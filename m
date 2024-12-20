Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3DAFE7718B
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 22:27:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51DA2804F9;
	Fri, 20 Dec 2024 23:26:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fUZQ87Ud";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EA95803DF; Fri, 20 Dec 2024 23:26:28 +0100 (CET)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03889803A9
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 23:26:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7b6ed9ed5b9so297123085a.2
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 14:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734733585; x=1735338385; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l55Q/7S/02jQjh9plkA5j5No9vKAX3OJpHs8DyQi28U=;
 b=fUZQ87Udwvukv56wELD3roSD3mYfvpQwGMBUmrKh+fUfwUo3fod4iGU98DjkdHoC79
 /Fi71Ov6uGv/eLfeDkA30IIoZpME0cNYEnsNmvJyZN/bGJMp6ALFBs48qx8ksSletmLB
 FhI2qjB0QJeFVJkQwcARARd2xDkDVebNk9KCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734733585; x=1735338385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l55Q/7S/02jQjh9plkA5j5No9vKAX3OJpHs8DyQi28U=;
 b=b61C/VCF+6GSj5ZI6u5ZsRk/xlUl+k1VTqJDTuHNg1sgOgmRwMtDKkM27SBXWlzqOU
 LHYZeeYDSXWJBFHGhALmYFlQn8/2z9CreF87sX/sx81vfsOJIWk5EK8WZmbcvERYf1Bk
 0c5XtvmRCiKWW78grf8W5ISiRvLh5xEwV9nYpCH0/47BGHZpLaR15m14B+o1BhkGE0lc
 5w2pqaNLXaeTL0BZydffbgg9K2Sn9DbyNMBVTrG236+uxYn9CK9lQ3xfwXp1TO9c8Day
 iSy4s/4DXAdZCv20ez4qXd6eVzyMnEpVJACVUYWfntqi7fse0qp48yrVOpbpwOHbt3Jg
 FSLA==
X-Gm-Message-State: AOJu0YzUX4TN0AoEo0l8GuCoWOQ9KVfY6N5DCy0G9DQXhsEOAQdoa14w
 HIJVKdZX9YwmTVne4KaujdfB5tzz1dKirEYa/TKS0+RSKekv5LOvV74ydiMU98jUpt1QhjoLlKv
 msKI=
X-Gm-Gg: ASbGncsgGf093mudwdsCKIXxmtAikDBk5dnABFeHDKrMFF9nmJrMvqbL0o4QQrEXrzV
 FDr2JXMOI/lGROq5+HEGD1H2T/cDHDsrOBx+KbnsP8Xsx5jrK71T0Raxj2lrm6THOmnSW8FxliM
 mecrsdC/dKo1f4FekGmVQoHIZSOYqFec94ipTtYAqYXaiQu67R2k4a/pF0K4i7THJThWETvM5jC
 NV8rcgSnjj0sMGGb2DLGGty4B01zmoPVcGoQ4Ty3uhuCbjf/SyOAp8uHlpkmyZfUhctYx06qUEN
 Yr0=
X-Google-Smtp-Source: AGHT+IEs1VAZC/9qrOTKrNtEysVQwTQa8xOKEmp4xoDvtqkvRJF8ibsY4NzRKbA4lc57VjuwaRQ7xg==
X-Received: by 2002:a05:6214:c46:b0:6d4:25c4:e775 with SMTP id
 6a1803df08f44-6dd233373fcmr69354396d6.15.1734733585011; 
 Fri, 20 Dec 2024 14:26:25 -0800 (PST)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd181bb4desm21055606d6.87.2024.12.20.14.26.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2024 14:26:24 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heiko Schocher <hs@denx.de>, Kyungmin Park <kmpark@infradead.org>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH 5/6] mtd: Correct dependency of BLK
Date: Fri, 20 Dec 2024 16:22:21 -0600
Message-ID: <20241220222612.1757884-6-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220222612.1757884-1-trini@konsulko.com>
References: <20241220222612.1757884-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

In the case of MTD_BLOCK and UBI_BLOCK they should be select'ing BLK as
they provide block device functionality and not depending on some other
block device already being enabled too (as is the typical case).

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Heiko Schocher <hs@denx.de>
Cc: Kyungmin Park <kmpark@infradead.org>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
---
 drivers/mtd/Kconfig     | 2 +-
 drivers/mtd/ubi/Kconfig | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
index 678bbde89e68..df178665f9bc 100644
--- a/drivers/mtd/Kconfig
+++ b/drivers/mtd/Kconfig
@@ -34,7 +34,7 @@ config MTD_CONCAT
 
 config MTD_BLOCK
 	bool "Enable block device access to MTD devices"
-	depends on BLK
+	select BLK
 	help
 	  Enable support for block device access to MTD devices
 	  using blk_ops abstraction.
diff --git a/drivers/mtd/ubi/Kconfig b/drivers/mtd/ubi/Kconfig
index c027d898a640..ba77c0347365 100644
--- a/drivers/mtd/ubi/Kconfig
+++ b/drivers/mtd/ubi/Kconfig
@@ -116,7 +116,7 @@ config MTD_UBI_FM_DEBUG
 
 config UBI_BLOCK
 	bool "Enable UBI block device support"
-	depends on BLK
+	select BLK
 	help
 	  Enable UBI block device support using blk_ops abstraction.
 
-- 
2.43.0

