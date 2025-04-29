Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD119C369DC
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 20:58:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8BD18283E;
	Tue, 29 Apr 2025 22:58:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PTrV0x3J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66798829A1; Tue, 29 Apr 2025 22:58:07 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AAD38272A
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 22:58:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-72c14138668so1758000a34.2
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 13:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745960283; x=1746565083; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w+xKSYB0BTJAKniFVBU6l/O7D/oDuCqaL/aznH/rDqc=;
 b=PTrV0x3JThGV4Hzr2324UZdUer2bWlRrRCXutvfWXLazI83ArrAvFReXJJ/JwY8i3C
 JyJn8/KqGxZKZVk4FryThYQmS7iaXbgG/owEYgd2z6d0bj/uVLSBS2VhWgpqNTMElG1V
 XvtjsVKN5bovsb1LDE4Kj0ofe3BEl9isrH01o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745960283; x=1746565083;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w+xKSYB0BTJAKniFVBU6l/O7D/oDuCqaL/aznH/rDqc=;
 b=hxzy6tGMYcYwCizP+DXvxFyqSeOST6s/n8hgtsd3H6+d0vbZ2vy24eeopz2Lc4xsuL
 24hGetkUOIXXsOohLnKi8wgteDrEdzZZGQI/tBgMsIlBWGzWy8VH3ryRX0RRir93FTmF
 gXwuz1f/vwpakcegjNEtF57rOU0SjhqAoSYuDSQiIsWarpOl634e1y9SsPOVU9iNRCgW
 5k/lb0sWUUFpi6H6nnhsDa/XYTt8185gKpqIBy8H9n+1bufFIht1W8YlZn0585/SQPsc
 CIUyhFlufn1eqWG6xEz1OwxEOfoQlgorp/sFzbbXb3Qgs4qArP9vD39QE1QgAh9blhYv
 cxyQ==
X-Gm-Message-State: AOJu0YyzqGKGUA5pO2kgTFyOYpp3AsEZFFVeFdEJImBZjh1LpGoQIRPQ
 JBWinno4prFDYOR1+jXIdnvWsJrcXVUnnkx8rf5jnHrKprUMm4KoXftWZkhLMRE=
X-Gm-Gg: ASbGncvQVa24S/TXgXrrXXVcv/EZIOIf+OCBc6H2I43nBbzZtdcxB/wimBSUeywYwHc
 yydh6lHiGMlWZdRQY+6ao8HOISxKhXaiitH7ie//etHz11U1EBTB9Pf+Ab8rPtrxVFN4bIW6QC4
 zb2P4xdtcdJqzddLvGGAsEhp/SLYnTdiPAJSdUf3X43qWwW+qekfdMeXsDWM4Qp14o8/gA02zNw
 tKZbU3KGVeIlICl01XROfwbPuq6oTjqrbF1utbaI2Z8k4TBPVl1kWfMaBzhHVh/pew2U99idbVZ
 epIs+PNxgabkI2pEZuawEb5rkXMRKCuNBlsprQ+TsYpiqmwanVgSGM2DcPQwawxjBfRSKmDFXTu
 e
X-Google-Smtp-Source: AGHT+IHqwBqV2/efJUxbhzwCJMKazGs5Lj8cnZTXftgyDucTzMw37NwsgHvQfjM54/HObjYPNR9LQw==
X-Received: by 2002:a05:6870:71c6:b0:2d4:ef88:97c3 with SMTP id
 586e51a60fabf-2da6d18efbcmr74869fac.27.1745960283618; 
 Tue, 29 Apr 2025 13:58:03 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2da6e0f4983sm6016fac.16.2025.04.29.13.58.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 13:58:02 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Harrison Mutai <harrison.mutai@arm.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, nd <nd@arm.com>, 
 Manish Pandey <Manish.Pandey2@arm.com>
In-Reply-To: <20250422193657.512324-1-trini@konsulko.com>
References: <20250422193657.512324-1-trini@konsulko.com>
Subject: Re: [PATCH] Docker, CI: Add vexpress_fvp / vexpress_fvp_bloblist
 support
Message-Id: <174596028218.1655642.5577944890840942345.b4-ty@konsulko.com>
Date: Tue, 29 Apr 2025 14:58:02 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Tue, 22 Apr 2025 13:36:56 -0600, Tom Rini wrote:

> This adds the vexpress_fvp and vexpress_fvp_bloblist platforms to the
> list of platforms we test via emulator in CI. In order to do this we
> need to first have our container runtime have TF-A builds for the
> vexpress_fvp platform, both with and without transfer list support as
> well as installing "telnet" so that we can access console. In the CI
> files we check for the existence of /opt/tf-a/${TEST_PY_BD} and if
> found, copy bl1.bin and fip.bin to /tmp and set the variables so that we
> can later run FVP to run.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] Docker, CI: Add vexpress_fvp / vexpress_fvp_bloblist support
      commit: d75998b476de439a05b2f7ec95d426410bcaae18
-- 
Tom


