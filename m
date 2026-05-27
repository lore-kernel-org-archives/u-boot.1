Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FF76CD5BD2
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 01:08:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43946846A5;
	Wed, 27 May 2026 03:08:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jtJKGdhz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7322C84855; Wed, 27 May 2026 03:08:43 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73A9784659
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 03:08:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-bd11a3729e8so1725355466b.0
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 18:08:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779844121; cv=none;
 d=google.com; s=arc-20240605;
 b=UZ6jEY8+4k61oqRspiDXa4Tpx5hAD9Ve+L+EnuLGhmuw6auBpbppvQYDmFafeaefM5
 j8ztFiKB+lgWaGmMyfRe5GqlEsaXQfiNVU66m4oEc5TsRcpX5gqinPynDLiusst/TJiC
 80o4+BZia2KnYeylQD7CoB9DBNpidzvq7YHicGDLK7hHHsVZctzSz24EcPEjxzgcDmAI
 J1DmLumuGEUT+/eB/8dRgxSAA5uZDnesTGgTTEIz7bUEsCXig7hdE+P2lok/VXi5HDnG
 P2ZIhTwX9aTeLR448eQ4Bnjk/zzWCPgkpeFw/J3SP7AxMW7Wihl5XPdTqacGSBAMkJsy
 Jd6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=p2lk/7JV7F0DhX445LGpIaHqNmoNEljtbIOihc7BiMk=;
 fh=awCdf5QgHX1JZpfY5SxxRPYY/WvjLzkL76v7yMMdVS0=;
 b=cPablchDDxHDQmEpTTbEW+obYXAAunKPXzlEQOXpt0bV/tUcsKCLfURincPIc9s4ld
 AQNR7+O9Ob7pX571Mxch0byD0QSLG2E6CsP3eWe6KFy/zTcyIjeYKFcIynq+ZB1yje5T
 mWTKJoxWJoeNtg/4mLoj//qiv6Js/tIEUdIvf2SDievmBStWJOatOJV8Mx1021ZTt76V
 iMORPqjsfAJLb1SZNy0ymNAt+jjRiMUvnbVhVoSYeBj3+f3tbSZ7xTlTI2W8JcXC1+R+
 2I193gm1gjvzn7TI4GCccnbHmVAcHYTIF5p4v/2bMr8e1AsuytnSgGaKZ0aoQAKRTAcS
 2kVQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779844121; x=1780448921; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=p2lk/7JV7F0DhX445LGpIaHqNmoNEljtbIOihc7BiMk=;
 b=jtJKGdhzq2ABXqlnyhG5OzEOU5T3vJwtrqLgjCvUyISq/DkufY8CZMkwSTWuoZ+6Eh
 21HY1qxEQEXDfudbM8x2SNc2MbmxtflAZt8P+IGZB1Pg5ZvRA5+OzDC4YO7IRUu/GBa7
 4vNMcp2BSGH5oBX4O51fg3oSZ/38QVvofH7Yg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779844121; x=1780448921;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p2lk/7JV7F0DhX445LGpIaHqNmoNEljtbIOihc7BiMk=;
 b=HF8gGseLLWjd696ReuUer7gsyRjVNDELyQnr66OLPEcfDnitPPoXcsAW2SNv0HV4bV
 V1vfGmk5lAWzXQCjr5u/GWvVSDzbih6DTuyVHSmQlrtae6ebOef4GBcsYJhcegtBVyhH
 uUDPqwHZcWRclVfbGcje+22WYPuB3+yHEQqq+tF8GRDlEIiJzwEuGXX3ToAD2+hWpwGo
 UaaVqvOOfMh7ekVu223pdOfmjDrO6gA3Lm/w6JCq65e5ylfvmGeWCMPwKMTkYaBl7nJR
 qYBTZePl4oS7JlvFpxhv/iz3vC/PAlA4AqZkz6KELE1L26KUkejorI6045mQHrTD6lz6
 ST8Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9zM9cweSLPKW50vL1XVSI+6+CD7Ir/9yWLqh6Ii4y+feUD/m0pAJ4NzomrMBArmpH2J301jAE=@lists.denx.de
X-Gm-Message-State: AOJu0YyYt6GH8Xt2/3+/DrtozsRwX9YLCJdHM4SuPl98NPYIsoC9Mu3E
 UaBT5dUe1sSpUMKxo5UOIx2tHT+M6Vc6asGrxJYSAKa16KlUNM/as1RPbCDUBSzFcNrBKLh92vq
 xgZSredmpomg8BlkLIGJ4vjrVSlzJuwjSz3Iy7EXyLXAGALPrb2SebBXByiUqXg==
X-Gm-Gg: Acq92OEhPbOm5T7YUImcemKC43gGsx6TwMEh+CPiyba+4+LVkFVIlHIDSyqBE8+2Fi6
 m+RO2umO3ipUpLmoO8krsYIWSOEig8+6i+gNQzgA4WOqt0SOebjv5WZasnnFw7z9lWw6sUAkalj
 nM2wiB0Czr7ZNBXfhiWIBsa6t9nMYzoFPMEGzh0m8lBT4QV92oY2H6Q+1yHmangr0pM8MVGXMot
 3Sf7jVgTIrCMmWiPPVS7wM/dyihUtnWpal44qyvUBkMvu5AykY8J8yZV0sl3A+QuCKCRCLeN0XU
 rAucCm8S9oWRNOhclTh2M4E3M2M=
X-Received: by 2002:a17:907:3ea2:b0:bdb:b76c:4dd0 with SMTP id
 a640c23a62f3a-bdd263c954cmr1234601966b.40.1779844120909; Tue, 26 May 2026
 18:08:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260526124044.354578-1-Alexander.Feilke@ew.tq-group.com>
 <20260526124044.354578-2-Alexander.Feilke@ew.tq-group.com>
In-Reply-To: <20260526124044.354578-2-Alexander.Feilke@ew.tq-group.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 May 2026 20:08:28 -0500
X-Gm-Features: AVHnY4IorhB_u-RWOAz9P0uqpBpYP1wXlQsxR4Plhw6pINT3l6buwlIzkrRjIUo
Message-ID: <CAFLszTiyPbM9e7X4unRLghpVQEwCQ-bmKZmYQJGvt2KU+wuupA@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] sysinfo: uclass: use sysinfo_priv size for
 per_device_auto
To: Alexander.Feilke@ew.tq-group.com
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com, 
 Nora Schiffer <nora.schiffer@ew.tq-group.com>, Tom Rini <trini@konsulko.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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

On 2026-05-26T12:40:39, Feilke, Alexander
<Alexander.Feilke@ew.tq-group.com> wrote:
> sysinfo: uclass: use sysinfo_priv size for per_device_auto
>
> Reference the struct itself for the size as it is more robust,
> even if it contains just a bool at the moment.
>
> Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
> Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
>
> drivers/sysinfo/sysinfo-uclass.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
