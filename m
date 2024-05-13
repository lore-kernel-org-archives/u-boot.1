Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2713C25B78
	for <u-boot@archiver.kernel.org>; Mon, 13 May 2024 17:48:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A093882ED;
	Mon, 13 May 2024 19:48:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LkSZ5C6P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50D5B88312; Mon, 13 May 2024 19:48:23 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AF4A882D8
 for <u-boot@lists.denx.de>; Mon, 13 May 2024 19:48:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6a0d1032362so15751166d6.3
 for <u-boot@lists.denx.de>; Mon, 13 May 2024 10:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715622499; x=1716227299; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hyAu2CTzN3keWOb1d59N2E/RqTQyKcLO1Ff9DZrZpTM=;
 b=LkSZ5C6PNeL1HPeT0Rk0Lf+BWf5jM5MWFG2kDMfqvH3GG4iDXfAUMP+0mRi77MOJj6
 EaiFWlMb13fcTLhn80hmYTZIjtdmWX6zvt9v7LXj77QDYN14IeI0P4dswoZ4DKppov93
 ugvDxk1qSINxqokyGtIG6C+r6Zh18rJd7kVjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715622499; x=1716227299;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hyAu2CTzN3keWOb1d59N2E/RqTQyKcLO1Ff9DZrZpTM=;
 b=uP38USY8IwFwvzVlMEptsb8hSEAvHgboZ93mCMTewU+OFEjxExCfeIIfC91lT1R+2b
 WKlSzV617jMokN2vyHHskWKeclQiXQC8DcV2QHXHz2Z185sL9ids0ZOOBiZecCdF92hk
 Esu04f5MZU4XCcBJGlq6JsOZNsUn0ak8HrS8/W0Gm+NjKeoKFtENKlgzHoiFERGHGOOP
 v+P4pXF92jYeugLBmaS6+94OtzPvHX9FAhUmwOiHdf7A62MN7grUMaUvQAvMaY1kJ9Zx
 Jl/ZJwpC3iiqF71tQMuqpiueEzOlxf4eyeX9TATBwjFgmW3ArILx7SYNjzBLj3YCfzbU
 seJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDxryCyhguJ9E0gpyOwMLavqs80RMZD5U136ELfu/BYJgR/pmSQ6W4Bhd/lunoOIs/gqFL04CyovT8CTjn7bChcx1TUA==
X-Gm-Message-State: AOJu0Yxb2AqZHmIzUnxbWk6VNGjkoOuU2HyXlwJldL9uQHDkDUEyO8PX
 4QsLgikGDm+TbuYJ+AcIoki/rPdixFKrXU3d8eFCAw2IbPnSHUHz3G21sGH886s=
X-Google-Smtp-Source: AGHT+IGw7+KK9SvqvDI8is4gj2KZCfyB8KUr8554zl0J1c26a8SibNjOCg6IciRdn5rofV1LlzkQrQ==
X-Received: by 2002:a05:6214:5781:b0:6a0:d56e:4b30 with SMTP id
 6a1803df08f44-6a168388726mr151694216d6.53.1715622499112; 
 Mon, 13 May 2024 10:48:19 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.98.216]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a32e0fa401sm21966386d6.111.2024.05.13.10.48.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 10:48:18 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Nishanth Menon <nm@ti.com>, 
 Robert Nelson <robertcnelson@gmail.com>, Wadim Egorov <w.egorov@phytec.de>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Simon Glass <sjg@chromium.org>, Roger Quadros <rogerq@kernel.org>
Cc: srk@ti.com, s-vadapalli@ti.com, vigneshr@ti.com, r-gunasekaran@ti.com, 
 danishanwar@ti.com, u-boot@lists.denx.de
In-Reply-To: <20240513-for-2024-07-beagleplay-eth-v2-0-a9bf457c3bb8@kernel.org>
References: <20240513-for-2024-07-beagleplay-eth-v2-0-a9bf457c3bb8@kernel.org>
Subject: Re: [PATCH v2 0/3] arm: dts: am62-beagleplay: Fix Beagleplay Ethernet
Message-Id: <171562249709.3674659.2023833903024537480.b4-ty@konsulko.com>
Date: Mon, 13 May 2024 11:48:17 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Mon, 13 May 2024 15:13:53 +0300, Roger Quadros wrote:

> Sync AM62 device tree files with Linux v6.9 and
> add in the missing bits in -u-boot.dtsi to get CPSW
> Ethernet working.
> 
> CI testing
> https://github.com/u-boot/u-boot/pull/534
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


