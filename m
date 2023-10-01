Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B56AE748EE
	for <u-boot@archiver.kernel.org>; Sun,  1 Oct 2023 16:17:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC77A86DCA;
	Sun,  1 Oct 2023 18:17:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Mf/Y+EPJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CE4386308; Sun,  1 Oct 2023 18:14:04 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0950985DEA
 for <u-boot@lists.denx.de>; Sun,  1 Oct 2023 18:14:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=viraniac@gmail.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-1dc863efb61so8379757fac.0
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 09:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696176840; x=1696781640; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AhldAxHSOfjqbOtlJRmbEL39mNXossd1654escVH8F0=;
 b=Mf/Y+EPJbFO6gVHXITZJrYAAoln2oTICXCozEZHf3SSVlEMa+nUcv2DZNAWE6LNH15
 1pFVCJ2ONSSsI9t3aRYPPUt8juzPVwYLQQGop/fIYloQZuU3tYrls5vinJD4pPTVKoaI
 Y+qKQumwYtJMqFUIvGJZU53zcEWwc/O4wzszcdFZaNa1TZSRiz/KnbcYqGe9zLta4SSb
 EesGipKk52VRaVKcreblrpyjSHJ08Sp5VR6xsGQaCWwRfzzKMGH81VjNetZ+f323E6s3
 6TiZAHbNBV4c6foVqr24Q0pxKpY4Crb4mogctLVwm4j4lFl3XMOYEyOmsGBHp5892NM6
 imkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696176840; x=1696781640;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AhldAxHSOfjqbOtlJRmbEL39mNXossd1654escVH8F0=;
 b=m0Aq34gXDU2mWwJkzcsvCe+71T0SSIzowd2QwqRH55QrklnwDljpcfVc3cRRVAITaR
 tK8NplO9+LPSodMfsaYRpRZPSBsf0z4PIWbt2oGxXUHMKOVef6sJGeyjgMNfw6KVTIpL
 1VqrlVU/b6nh6lPPAqaXoYgSV2BPRl0te7zdihscpgS6WRr/sFRFHPJp3T/G3VU6aF01
 Ce4rkbZnAqMUjo9cjjje4ySadYYnbtYBp0+7QL2gVkZ4i6+zqY3xBWw2PL3SnFOCqxHg
 gVgzOm+8h9v+WsBuGDwGY4nWt7mKB09a9EnGLThxtB82/YBcSdjjF6zI6fd5gS7eUM7a
 x4Ug==
X-Gm-Message-State: AOJu0YycotfxZjY0vkzAxU1slz/n9XjnEqM6dSwSjoUtoePxYBwyktG8
 ZTOGx2uXwbap0lAvBI7xsK9uaL2ukS4bIg==
X-Google-Smtp-Source: AGHT+IHFKPDmyBNHW6Ht01aRqum7yboKmqcCgHbSc01nc5/oIm5/K9IIPeYQs9plI9NOOb0E3eebsg==
X-Received: by 2002:a05:6871:70f:b0:1d6:8b7f:ce89 with SMTP id
 f15-20020a056871070f00b001d68b7fce89mr11237666oap.51.1696176839744; 
 Sun, 01 Oct 2023 09:13:59 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:1005:b0fb:a4e0:d431:5949:1fcf])
 by smtp.gmail.com with ESMTPSA id
 w22-20020a63af16000000b00583f73b7bcbsm10905058pge.58.2023.10.01.09.13.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 09:13:59 -0700 (PDT)
From: Gunjan Gupta <viraniac@gmail.com>
To: u-boot@lists.denx.de
Cc: Jernej Skrabec <jernej.skrabec@siol.net>, Ondrej Jirman <megi@xff.cz>,
 Gunjan Gupta <viraniac@gmail.com>, Andre Przywara <andre.przywara@arm.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 0/1] Fix for U-Boot SPL hang on sunxi H6 due to incorrect ram
 size detection
Date: Sun,  1 Oct 2023 21:43:31 +0530
Message-ID: <20231001161336.31140-1-viraniac@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 01 Oct 2023 18:17:08 +0200
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


On Orange Pi 3 LTS, sometimes on reboot, SPL detects ram as 4 GB instead
of 2 GB. This leads to a hang later and board fails to boot. Fix is
tested by leaving the device in a reboot loop overnight where device
successfully rebooted 1350+ times by the time I stopped rebooting it.


Gunjan Gupta (1):
  sunxi: dram: Fix incorrect ram size detection for some H6 boards

 arch/arm/mach-sunxi/dram_helpers.c   | 1 +
 arch/arm/mach-sunxi/dram_sun50i_h6.c | 2 ++
 2 files changed, 3 insertions(+)

-- 
2.42.0

