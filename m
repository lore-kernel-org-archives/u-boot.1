Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A40CFD2F6
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 15:57:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C64ED842A2;
	Thu, 27 Nov 2025 16:57:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Z2ICIbZW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3258F84419; Thu, 27 Nov 2025 16:57:41 +0100 (CET)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BBD383AEA
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 16:57:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=zajec5@gmail.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-59577c4c7c1so1970928e87.1
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 07:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764259058; x=1764863858; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QQbFKCSRl240FQv9G8UcC4b2z0mRXZgkd7m8+IdXyyw=;
 b=Z2ICIbZWo9Nj2DR1sbTLwLsjtEW7qjLv5vp5GpK2FXq6XCxFf5J0F5zATYymepP9+z
 KW84UfrXww5kxhsplcdHWxKDILbXPjkrJRDZ5bnaOuqXSFFimFEwnBjmrpF0JeaLqddj
 5DTnIN4R4/CT/WNUJTRLZmRoFVB1UtPPiQCeS873fBDhBB6+EFDfBPcGgu8WLHLbtsvQ
 cYoWzw6j2zDcSFV1MEcGfjzHCF79uHez7pI1AudNOScuA6iITlp/PdBwJkWrEdnxcRMo
 p5AyrLA8cCyLqmCtORZ7woPoKpkNm7F33l0JewZrmprvmnj9PRl7hBNcMemvEYxaJctu
 F3Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764259058; x=1764863858;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QQbFKCSRl240FQv9G8UcC4b2z0mRXZgkd7m8+IdXyyw=;
 b=psu+o5t6o+Yw58npmeNuSRau2v+mjkW33iaUYHQ5yDcPazKRLy9dd6n6T3oGXtAuU7
 0T6E+x+x7axwhvVxu024DsEulCuNf3/8wRfzN9oBaTSJz/m4z5znmdjxAXNtxnofonow
 lC+gU2oF3tV9Ps5ru5jL6XVBUpdBWb26ILXorIc0YujRRsnjJfFj/OacqFDlyjimpdRW
 p8anQw5m5lf46e7PEIclg8HM0Lp6dLukAIOD30wAuUjm12JFuX3aZGDsNjLdBjqrj2hE
 ndA3YaTIIVMTnvvrjYIvkIYjFa1Ob05x5kWhahnylGAzd58CnecAqIhydlUrH1QEbMXS
 VsSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZfjuVPBcimXpqHrbR2ncN10/Qm4c60pIGBk8hCgSQk4f0mijZxjAsix42KfnuNGQmgcqPMys=@lists.denx.de
X-Gm-Message-State: AOJu0YyAISj1WxLIX7yeacKvThIqKZsddxnewZpWycttBXAifG/0rQE5
 PRolOQdmq6KncAnzPr2cw/OI4EHLeCetFRNt01oOSCO9cWgEDgLr5M5CMTe22UWR6PKxuSy9OQw
 HWpiv4DHb8C9DHJzenzGH/Bs9AtMNjAQ=
X-Gm-Gg: ASbGncvlkFXzhdar940dwc9YglWjRff+OXVeg9YCegkvCFF5bAvZi495mV5x8nhMi9T
 R5oeEOOifTGW2T4qROzA1DcZlIjsK4H6LNuMEob6uhDJBPVTqpYrHpWmOy6/mj5VD7U3C7tAqVe
 R1J2JZqE+joKV0YYziB43uXm3nbj7bEFGkHVE89K9Jg2o5GqaCb+q3FVLiypnb7BcE3mdaUBWNW
 NIzZj/bZKhsmxEj2P2GZODCI30d8GrzNH8+68bRv2wflC0WTr56Z0eZBXZKIxXDHXQEJg==
X-Google-Smtp-Source: AGHT+IEnKdSUtnv8vufHiVwvqWs8x94vZFx/EEiPGsXNdRC0Kw2/7YN9splaj7pv4l+47cTeFhgVUH2J5eQud2F2hRU=
X-Received: by 2002:a05:6512:10c6:b0:594:524d:d966 with SMTP id
 2adb3069b0e04-596a3796430mr8736425e87.21.1764259058035; Thu, 27 Nov 2025
 07:57:38 -0800 (PST)
MIME-Version: 1.0
References: <20251127152646.3283967-1-mwalle@kernel.org>
In-Reply-To: <20251127152646.3283967-1-mwalle@kernel.org>
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Date: Thu, 27 Nov 2025 16:57:25 +0100
X-Gm-Features: AWmQ_bmxggar-Y1PxA64zAgYUPx8ERjGIXvuAHlQ5W-7l4RDQ45BWK6XBpEjwmw
Message-ID: <CACna6ryN7CB_7yRNY90Z3-wr_z6ouW564Las_dHs9RupgF-Cyw@mail.gmail.com>
Subject: Re: [PATCH] net: phy: broadcom: fix RGMII delays for BCM54210E
To: Michael Walle <mwalle@kernel.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, Tom Rini <trini@konsulko.com>, 
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
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

czw., 27 lis 2025 o 16:27 Michael Walle <mwalle@kernel.org> napisa=C5=82(a)=
:
> bcm54210e_config() configures the RGMII delays and then calls
> bcm5461_config(). But the latter will do a PHY soft reset and thus
> resets the delay settings again. Call bcm5461_config() first to fix it.
>
> Fixes: cba79a1b2e11 ("net: phy: broadcom: add support for BCM54210E")
> Signed-off-by: Michael Walle <mwalle@kernel.org>

Reviewed-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>

--=20
Rafa=C5=82
