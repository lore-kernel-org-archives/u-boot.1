Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B165FE77188
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 20:19:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D556D80275;
	Wed,  8 Jan 2025 21:18:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jdl9lDBU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F1B28001F; Wed,  8 Jan 2025 21:18:58 +0100 (CET)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C2B78001F
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 21:18:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-7b9e2c1e3baso13966885a.3
 for <u-boot@lists.denx.de>; Wed, 08 Jan 2025 12:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736367535; x=1736972335; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tGnmslru3mP48FO5OjtaFtV+M6GQoKE1zlRkVey8/u8=;
 b=jdl9lDBUnPKCfb0P542uKqgEYZiHbRu9IvSbfeytW1IY4WZraL1Fo413tKuhsO1D7O
 yhdIopP39rFrB3L15ARsRhJQU6UvRFv5SLI1iaNpbdhV6qh3yE9Mef1nrZzOKy8w5NXS
 VyHqPK00wG7NEIieWtM1rBrp3RZswW7ortxMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736367535; x=1736972335;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tGnmslru3mP48FO5OjtaFtV+M6GQoKE1zlRkVey8/u8=;
 b=jGFRr07EsPVYeecL5mNllWf/takhPjoWnuuAimgmQ5Ky04OIJSZ7/ytZuWybGld33Z
 /RXPxseLE1Cxl+yojh7lGkNfMrS8FaSciHas8hF0T4J5C3F5uGmp1WAwn1JloiwPf0g+
 ekMS9Tj0P/shdqbvgcUYsEekm2UuiXWluKWAFRW+UuizyLl4ZEuAD5E3R2gO8tOEXrfn
 3yLtfEgHTKWVo4OZtbXPgwbU/kEbiFcZQM1uMss20jrdZdX71IxnuFIFgBmwC7dzf1nG
 V1/LaS7P27tNkSuoN/dmBN+iHwxl/EKc/t7VRlVt7kWavBNVD8rUWxO6nk008NzyULd8
 O6vQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxLR6PUSK13Dg36ZtjpuZEZKjYQJyApVj1t9X24BFwDkSaFBsVxZkjlQ/TZPR7cpfL6vdrZXQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyQJ1lu4aUuUAKJiPoYcfnpVKv7FTRHpCT69bzFRkmautt3jD/s
 QbsLpnNLSlWddwNTfRNfJNqQQlJ1yUVI+4CL8Eg9ukM+HM38FPj3nFGNhMuYZnk=
X-Gm-Gg: ASbGncsCArXqL512ovsa+dOYMXwMo2LUGTgLJjXL0Cz5NM3j5GnX7KSli7cp0LGImZj
 lDWvU2UnyfIZCCNeBCrfeTvEXmWglTrZdz2LUo+ghW+Tg6jzCcai0ajIZzcodJTi6hkGHKPWNWc
 8UmMat07NZxljIbgtd10cXk4XBiuz4/mMeCI0Gv6E2j/w22nmnFLL7duBpkAZYaTMH3mm1/HNxg
 2Iec1PJ+XnpyWdilMNoi32phcImJEl4kMC8EQvmwVobLPdmzfrGMA==
X-Google-Smtp-Source: AGHT+IEiCkxG/EMWbncRFXov40fCnXfwKvbqs02V8sOEofBB1d0tgj35d6V29eRZO1hNnfBCTPw7QA==
X-Received: by 2002:a05:620a:4456:b0:7b1:4f5c:6e86 with SMTP id
 af79cd13be357-7bcd973cff2mr621997085a.17.1736367535071; 
 Wed, 08 Jan 2025 12:18:55 -0800 (PST)
Received: from [127.0.1.1] ([187.144.0.100]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b9ac480ea7sm1706521785a.94.2025.01.08.12.18.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 12:18:54 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Judith Mendez <jm@ti.com>
Cc: Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 u-boot@lists.denx.de
In-Reply-To: <20241220203704.2076499-1-jm@ti.com>
References: <20241220203704.2076499-1-jm@ti.com>
Subject: Re: [PATCH RESEND 0/7] Enable MMC UHS modes
Message-Id: <173636753374.954784.11530773493349739733.b4-ty@konsulko.com>
Date: Wed, 08 Jan 2025 14:18:53 -0600
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

On Fri, 20 Dec 2024 14:36:57 -0600, Judith Mendez wrote:

> This patch series adds config options for Sitara K3 boards
> to support MMC UHS modes.
> 
> While testing with SD card boot and eMMC boot,
> found missing eMMC boot support for am62ax in am62a7_init,
> patch 1/7, and missing config option to support eMMC boot.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


