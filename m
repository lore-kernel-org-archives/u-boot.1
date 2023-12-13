Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9C20C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 16:28:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 375BD86A81;
	Wed, 13 Dec 2023 17:28:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GIGOrnyo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0333787807; Wed, 13 Dec 2023 17:28:07 +0100 (CET)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8F6986A81
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 17:28:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-28ab6f0944bso387283a91.1
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 08:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702484883; x=1703089683; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I7dgK0y1GAYY63yIrlT4OeFwEj2zMrzvLduICGFJu/0=;
 b=GIGOrnyoVy+z2kNLTnnRn4rCXMHHlauDS+2844RYCFL5BU2gMBHp5EEF+KHWskCbNQ
 n3lCzDs6TId4ifqr+3CGHtp9WTDGtuuhYREMsyXIEjgIGSmH0VLLmbOucwonoEGyZfC5
 c4XaJ3fgja7bckMqxs0IRJMRNgMmNbP/FyQOWayiLV6f3YaXibFCfGcB1xncZkyDre61
 HU2wohOZY8Ebvg93oHh7gbCuM1IbWYkTeLGpWO7rMlu3gP5zUDaVJeQAEwgpwt27l5js
 XxnTBy4/ajuAn0pZ8uP2WSlkrDuKy+k0Oy12u0a3h4zNyqvNft9CfXMOMNLA+8Ujwj1x
 wtnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702484883; x=1703089683;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I7dgK0y1GAYY63yIrlT4OeFwEj2zMrzvLduICGFJu/0=;
 b=xBXP0YcezQiR2UAJhf9mPF01YMrz4I4yoQ6/9Lf7e3DWJaWCFNFV3ELvTj98qTQF+l
 4PFkcNW6a+qza+skpA1RyjtLu6j1YG/RdFJUZm13LxI6R5Bbksn2nC5J+nLNtTYCGHTe
 r1zsQVsRbm1yMjyL1jeaMmzgQiWuCHp4haKuaQY1FGGh9e1Dw6RvIvkQx6YOJPsJ4a12
 RSR+45QTuTUt3ZAad42A/uDko4RxmF0ws0xtZJ3F/2CN3MgwYY6AY8GxV0cA+TKbNr1e
 yO3+EbO/+F+I8hO/fSFXvT9HxZ+tguqwD69tPrBbGgGM3MEAngaTZh1Gf/ich95PG/mb
 s/6Q==
X-Gm-Message-State: AOJu0YxnDmYTGcAFzr+qZM1ENibJW2twSP0VaXWxcizO6Q6kHJ0lhZUn
 DN++4owSC0p/ka/vCq2jqFL3K3NASRWv7oUlP9EFdvIOd4g=
X-Google-Smtp-Source: AGHT+IGmw2/PNXZi+l4MPamF5CYTDdljkMvEXTL1MfjUaUOwey1mNey/Szy4T/B4OGET+dKUzj5V/Uk04+ih6fuvm98=
X-Received: by 2002:a17:90a:88f:b0:28a:e25d:a9da with SMTP id
 v15-20020a17090a088f00b0028ae25da9damr2213461pjc.3.1702484883076; Wed, 13 Dec
 2023 08:28:03 -0800 (PST)
MIME-Version: 1.0
References: <20231019120623.1476421-1-festevam@gmail.com>
In-Reply-To: <20231019120623.1476421-1-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 13 Dec 2023 13:27:50 -0300
Message-ID: <CAOMZO5BKHoP9Zn-+ziFqhC-NLEt5TTPb2nq+qibd7eHQ8nVTqQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] arm: dts: imx8mm: Sync with linux-next 20231019
To: sbabic@denx.de
Cc: u-boot@lists.denx.de, aford173@gmail.com, tharvey@gateworks.com, 
 Fabio Estevam <festevam@denx.de>
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

On Thu, Oct 19, 2023 at 9:06=E2=80=AFAM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> From: Fabio Estevam <festevam@denx.de>
>
> Sync imx8mm.dtsi with linux-next 20231019.
>
> The motivation for doing this sync was a bug when doing "ums 0 mmc 1"
> on imx8mm-evk. It worked well for the first time, but after doing
> a CTRL+C and launching the ums again, the command did not work.
>
> Adam Ford suggested to sync imx8mm.dtsi with the Linux dts, as there was
> a recent USB power domain reorganization there.
>
> After syncing the imx8mm.dtsi with Linux, the ums command works without
> problem after a CTRL+C.
>
> Suggested-by: Adam Ford <aford173@gmail.com>
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Applied all to u-boot-imx next, thanks.
