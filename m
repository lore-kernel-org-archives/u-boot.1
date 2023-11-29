Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F595C4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 18:09:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9340B8779D;
	Wed, 29 Nov 2023 19:09:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AHxQO+2Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C12EB8779D; Wed, 29 Nov 2023 19:09:10 +0100 (CET)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D0ED86BA8
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 19:09:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-51f64817809so2915a12.1
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 10:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701281342; x=1701886142; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/WrgTYNgURL+j+aoP2hhMoiG3RxSlT19qhXSttyf0N4=;
 b=AHxQO+2ZAdr2g6r1Rhi0uEfScbSinHlpgvDDwzBANJ2Mn995cr8JeZ7KMqlfl0MrnB
 AkRiTW3woNI+vOYKNyXtTUjt+U/YdVnPZh+YxtHRyUlCXom2ZzKuVkydRaUPqZfcwuxo
 Fz9RtoVBTW/kzCavRvR4HOxpnmHiOIZxrH1TDayQ55jaTHJOO6/WkaqNlN09cqNwQIAz
 ZSo9JtfVFwkcwOq2A9WDjCJV7DsX1BL1IfTfuMI8+f9/Fx8yPKIRgjAZ0wYWuREzoy7T
 0sdHgdR7DZiyShutxVV+4n7ao0+3aDp7tvYah+az8mei/8q7HqDpY1T3GPZ3rTSrgUKx
 DeZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701281342; x=1701886142;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/WrgTYNgURL+j+aoP2hhMoiG3RxSlT19qhXSttyf0N4=;
 b=tWCrU3US3f8qjX7fA87WVTTrq7bfCqCUHyrreN/C/3X1pJG6Xg1SZyJ44F3hhXsicu
 IX2v5k5snezs0WLi3XXw0XFOmEpBvtAv6Y2aY989FKwGcSBv71VDeC48hQIQPl68+QBH
 Pgv2s6jNUSS7LD7Ld+e0IXL/mO44bic8mAMDGLQb6/Ri6HLf4YbBKnJb3PSg/RJ/olwT
 ZLCMnu64+/QBfq1+QXG+lfdsRz3OQqaN2qTV7RQhKvBkl/geUeQsS1KD0wXj+qLe6n6g
 NZCe9u4htRXgWc1bbkCPEaZzILLf9LwamLJuYKbFCFpStIVnKdD1mTXvRWo6+bvRgvVa
 ztmg==
X-Gm-Message-State: AOJu0Yyz7iirOfVLi3kbZnjiDnbJ7RDFzQxdD5UHHBL23U84EEkcw2bH
 v+HJ4Lal1XGCBBGZpH/r5tSOpUoNHopBDEGC7j0=
X-Google-Smtp-Source: AGHT+IGEgJTiBy/8zIxVvg2ebK8xek1bEBtLMGDKftDRsI4AjBxFPkMvLMkM65uHa0rNf6M+94Zaby33xikPuDbM9qE=
X-Received: by 2002:a05:6a20:4328:b0:18b:feaf:36da with SMTP id
 h40-20020a056a20432800b0018bfeaf36damr22212967pzk.2.1701281342473; Wed, 29
 Nov 2023 10:09:02 -0800 (PST)
MIME-Version: 1.0
References: <20231018183352.2168191-1-tharvey@gateworks.com>
In-Reply-To: <20231018183352.2168191-1-tharvey@gateworks.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 29 Nov 2023 15:08:52 -0300
Message-ID: <CAOMZO5B3-ua96CMAVzc5TYoe3Sq=DwVNjcq41VA96VJecNGrPA@mail.gmail.com>
Subject: Re: [PATCH] arm: dts: imx8mp-venice-gw73xx: add TPM device
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>, 
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Wed, Oct 18, 2023 at 3:33=E2=80=AFPM Tim Harvey <tharvey@gateworks.com> =
wrote:
>
> Add the TPM device found on the GW73xx revision F PCB.
>
> This hangs off of SPI2, uses gpio1_10 as a CS and gpio1_11 as RST#.
>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
