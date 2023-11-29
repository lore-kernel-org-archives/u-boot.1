Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A258C4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 18:08:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78A9587773;
	Wed, 29 Nov 2023 19:08:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HLqNz/x6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FD8086BA8; Wed, 29 Nov 2023 19:08:26 +0100 (CET)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 813C787773
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 19:08:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-280b06206f7so10508a91.1
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 10:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701281302; x=1701886102; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/WrgTYNgURL+j+aoP2hhMoiG3RxSlT19qhXSttyf0N4=;
 b=HLqNz/x6nbpqf4jRaDpSBG6riwhuzB+YUlDA3XhEOy6mD6ImsKZMuF79KueYNKQqvB
 7nc1MixJYCuRpAHYnYzpu1KgodNkus1xH456WegbQ8AQcy1LPmm18ggcUmZKI2b1d9a1
 fBTJo2o14KhOH/5iVJ3y7Yb9/O5nZTBIxGxk/QqR1+deNe8aQ8TYF5fiyQgIMxKCbtUj
 sidAvxPy00ZRc5HVkbAc2KNQxb39VA5owNOILUWNMfylzuAjcQDmRX0mG9EIPJEQrQmZ
 +6Ga/GVqzjtcoTGXguF0RzL3Hm2QvlqK4zGwoxf+g38rlS/GyfpHTLXQKoQ5fTXqt1dj
 uFEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701281302; x=1701886102;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/WrgTYNgURL+j+aoP2hhMoiG3RxSlT19qhXSttyf0N4=;
 b=njTUQ7jBFyTy4G1XuEFz768saoCOaPqGf0ZfOzpHOloEWSBpYy+PWjC5oTSZrdcCOl
 rUPn2xXGfw9tXZ6b9BB64qsqFcDESQX6TCv+4r8yc2LdQoaWOhdOAZMSsbvOsKmyYFmq
 lGv6MuxfbSUwJZTm3BCfywXjlWX6oooEUyasCN+lEQ3Go02IVQrQSjGxl57QriOX1/mp
 p03qTTPwyNsoSVV6phaMN3XfuTQz+hiqAWArlLEzcAYZD6ZtA22Fu41i+lB62ULX04FU
 O6MwLmiXFtQNbWjMGElJUu3Erw/Yd3Kmpn64rs28eMTLjmEUKmNvEszg5Q55Q6wiolSe
 0mRw==
X-Gm-Message-State: AOJu0YwrzuQ1NyBb0V8jCfcLMz6gTPVtfTueScNjOhsnhEWrEm+vRZXm
 wYSPhcUIlaAyytodaBqvlyG+XYBj/fOBK5K4i7ykCUtOPjs=
X-Google-Smtp-Source: AGHT+IFRu1j5Ygi9C8nXUfsALOf82lQGqnoX8V8FJKFzKUHrKF1WxPySexSOroEQwdFwS0wf2/gCOUjmUVIMmbCTfvk=
X-Received: by 2002:a17:90a:f695:b0:27d:2762:2728 with SMTP id
 cl21-20020a17090af69500b0027d27622728mr19314609pjb.0.1701281301794; Wed, 29
 Nov 2023 10:08:21 -0800 (PST)
MIME-Version: 1.0
References: <20231018183338.2168118-1-tharvey@gateworks.com>
In-Reply-To: <20231018183338.2168118-1-tharvey@gateworks.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 29 Nov 2023 15:08:11 -0300
Message-ID: <CAOMZO5CH_kddcH8=9abcBQN6s5__GadOEv0WxB-s006BABXuow@mail.gmail.com>
Subject: Re: [PATCH] arm: dts: imx8mm-venice-gw73xx: add TPM device
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
