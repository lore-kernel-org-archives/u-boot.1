Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88BFDC88E6E
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 08:31:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CB4C980CA6;
	Mon, 14 Sep 2026 08:31:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W--Mjx2rLjok; Mon, 14 Sep 2026 08:31:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 016C680CC3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789374711;
	b=qlOHp6WyMRdQFrehOGGJH+on+YXl4K1VxMrR8ElhyYGDBBlXXHZKXm0YspkOFgd1Q5fq
	 B0UmWPWyt1aIksr/OKBx+nhJtcfQssV3VvPkmi8Frd3ycDACEoPf+WrVmzeb4nmYtSO1C
	 HamcabAw2KlY7lvx8LGHkAUwWYheTpMoEv0ImCJlBBfNRdnerbmsm2dIWBfsOzfY0/yeZ
	 xhF7q2Qdas0pHpIPfIGr0PUjXLxW5XvklGDTCiLCtaA43dpeYH6GmkIr8dSyOrZKmxMHA
	 4Ut/+QTQpzGQcmn/wEoPHY62l9lkE6bsuFa9yGfdrKH0nhjpq6izXtWOjiITZRLU1ag==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789374711;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=d5eaHkYIX3NVCsDR8ydkaQHJuSCv0DbjiyseA+kNAGw=;
	b=SNSxisI/JbCDAAZ8ihtd+JRKS1N/sEittktcLNhv+j6YkLzoRPRbHpF6t8kZTcf7OHs3
	 Untr9BtxyZ5I2nPPZ/Jz2SNHef50BzRnvdcEShPkGQjGosfZ7oJ8WUSOf8DfG/2RdyuHl
	 BRwPWq4L7CEXw0lWpD+x83YfW7Nw/FA1egE/IWh9lKYqGazlBbb8zVsVdJ7CWFClXggf2
	 Xfbh2tCXaMIw/+mlCpGz9BiD8f7d2+0FIJKzb5YfepmuYuzamTl9XWvSK45oKVIMac1c/
	 3tLBcprpFV7Cdf0OEZSnuj7omCIDemzmDGItkhEapGt/tRSispoRYuQjIFUGOw9HKrg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=pRhp7ne7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789374711;
	bh=d5eaHkYIX3NVCsDR8ydkaQHJuSCv0DbjiyseA+kNAGw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=F9AzAIjE754ApH9TSrUi2CaAZexhuXSvWJA5Es9s+Nl/sXmTCA+PnvLmvwLfPhwXQ
	 5X3ovbaq3UWhUw8yhheiOwN/k7xd5WAes1HEej1qQJtykSs3ti57yUj+Eot967hXDn
	 R1mBSJf1vk9w+vvfeQNo/jSeL66jTlMB6Fjwea+aXQbqiqonPG6qblulQm9Zqpv6kF
	 jfHEYYUlBktlwfZ2rI7SuEcf6x094/h6djfKh5i2MOb5OYh0XXb0YKB/gWdj6k8ABP
	 KU9OzddqNwZh5Ulo4716n+R7C/m2yETN4KZU9CWsI4y+EUZPAdJyMh2o6oZSwgg5TN
	 9tcSGRzt6YN0w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 016C680CC3;
	Mon, 14 Sep 2026 08:31:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0DE6A2D0
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 08:31:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E70B280CA6
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 08:31:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P_rO2DUxxb_9 for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 08:31:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A4C4B80CA2
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789374707;
 b=qZzNnk9PrqFdZHR7Or0Ux4UjAMo+fUNZTPg0EbytbMRE4MP8Spy05Qy7NIJVUQm0r2C3
 pnSW2/5JfyTaH8B4thQm2M9Hd+Ts24ASQFRM0Snu8kv5yms0RGUwlrPfqrAE6cSoA87xi
 bdU45BaWFvtWr9cfAS2zuiFSYimN4ZKgrXLkKDGB9CfeGcs9C6s/SiQ1ifP7L/hRljIxa
 grvh49+2ZLDJAwKjT3K2Av7lexD6yl86Ntq4C/YAxihAOKeIHEUQfI3AVQtqod/0JlHCA
 mpfZXNr/BBMIFYWl0KRb2HzPP6ha3A1Eew6zT41ifuAaz+OG6qTyvpcjwafz9EJzD1Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789374707;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=d5eaHkYIX3NVCsDR8ydkaQHJuSCv0DbjiyseA+kNAGw=;
 b=RabdXO9iz+vmFi+BhsU4mzDEEX7jbjPuPXcM+mKtcPIO6E4pcCbM2uK9hHz15WEpwI2A
 3Xx+d4n40pCw6U5CsExYlXt+cM+NcKRVIFcv+mY37W7yVEq9szsjFaL9Ouyn8iihlxuVy
 FXnJ0IbdJJHpHSu/s0GX14E62jRTR7/l9UWsU/bfAgKcSam1JJL73lZgwYMMNTsgxgsnO
 7abPurTW/vvzZ6UXjhLQGQGhRYdpPT046Gmgo5Goa7ZiDCRNNgVbfeXpR5gAQKIjYt1JE
 epZU/sN6tTdoSVn3JyN1JEiO9fTCywNtrqIkFBcfJDSYXW+HZhMqkmanwNWlFztK0NQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=pRhp7ne7; 
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:34::10; helo=mail-ej2-x10.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=pRhp7ne7
Received: from mail-ej2-x10.google.com (mail-ej2-x10.google.com
 [IPv6:2a00:1450:4864:34::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A4C4B80CA2
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 08:31:44 +0000 (UTC)
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c254f9f0b1fso292055466b.2
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 01:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1789374702; x=1789979502;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=d5eaHkYIX3NVCsDR8ydkaQHJuSCv0DbjiyseA+kNAGw=;
 b=pRhp7ne7AmitVOtHMjuf4DpxNobsRWM2XfYuMrZpb3o8i/+q3r1ZK+QLlcww07xfp8
 Wmmxg7M/dVjQNunmn+AF/v9ANkOrPns40ZyUygWuNVgbOGrxHrp+CFel1KwY2Tz/qjgT
 5MUn2y4Jm5uBsb1hpnII8JX70chgqsnxNsZkPNNy/SUTnWJ9qN7BFv4GNwBwPbRSsShB
 mWPADoq49tI7zqzjllfKxCFuye6+iHQhrZ49/IazL5+OQJTV5P0UiOXuzTjIVCsOkQvK
 PbbD9e02u/iZ0GZ8xTNsjsSnx0zIcTdPB5WIOtrvRYxA2NMard5W0fpJ/pEP3gO67ziz
 uRUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789374702; x=1789979502;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=d5eaHkYIX3NVCsDR8ydkaQHJuSCv0DbjiyseA+kNAGw=;
 b=phsuFsoWweqzf9Mzg91aDaf2HrYhD/hjZWyMZrmp8laxc3As5Thz7nQwpkzRA6T8na
 W2uhlCxmF/BHfY5cGaJ2sHI27/k4+3IqVLeOlVOw6WaBNSJL5uczD34iSGImobTJjASN
 Rmq7tpyEhN0pTBcqo/c8SKutEXTwMqUPAHCUfF0DEW5EnJ2IlynMFP/TqdZLdfOBtavL
 cX/r7Jq8/RSHN3R60dfh4frBocUFZ9jj6+lykvoqlsTWjf/10+fnE/RP3wfXVn0XzTOR
 AjxebZNXWIPa2uiQVh3gQcaZf3Wch4AlAbWUM+opfnd46Ws1VKLF2hn2K6cbQx9/FTZq
 E//g==
X-Gm-Message-State: AFuF++nGIcoV+HKYRRXRtkQBHTWmK1vdM9fOTcnub+fGzZjacNq66dxF
 ZysKQ68uYvbODwOdgs/4N5hFsq1gFgsISYm6ke6PL1M8bBF1iuIG+CCBxHJLygzVk+E=
X-Gm-Gg: AYBFou1QbH0GOC1Nx0GICtmaaiN6LnFWn7v4KZk0+tG8n/KdsKmFQjWEACJR1OPGnwm
 UDNGVaI1fp/X2cg/Nu8NFKymxcfKwDUpmo/1lhgEbgnoD7Wn/gcCP9VmK34WB1G7lWWBstfVOto
 MDD90d4Jnu6zroS3jeVbos5JCxcFt8Vm0+Xuy3B8fK0GRSLHoHa5wClUBiiaT/FQqFaoXc0XsS1
 r9XKr09EbUEczH4KljarvZDDKrd8ymo+WnpHhKhBTkTHKX8C1/JRbAWzCJRRIc7yIz3msA5g6wm
 vP/ut8nJIVXKbN9dDZqkdyj05MsiNesRCx7TYfzzUDimxue/JdnoSe0WpRV+VUCqVhke3sOzDIw
 paLFo5at9UK8KUJREQUh2Z95VHoNw0WCrVeibbHsehQGdYNatOPXSubrprK5diGYImrjnD/VvdZ
 CFC1ZBkofMVKTYZA5SO1in7hDsz3bvKp07+Puipb3ZUxQ3yD+0XFmcF26TUoqi7Fc92p734nZrq
 4WQxLDDP1ZN2U29UyOc3GgfOIizjwidNgDotc77DUJC90Hk0ekO+xclhZl0cerEiyXTYY3SjAlE
 rPQr/UAAYeSnlHU=
X-Received: by 2002:a17:907:97cd:b0:c29:462b:f917 with SMTP id
 a640c23a62f3a-c29b86f3b5emr180140666b.14.1789374702014; 
 Mon, 14 Sep 2026 01:31:42 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-95-232-147-181.retail.telecomitalia.it. [95.232.147.181])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c296598e8b0sm383944166b.0.2026.09.14.01.31.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 01:31:41 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Mon, 14 Sep 2026 10:31:37 +0200
Subject: [PATCH v3 1/2] spl: mmc: select the boot partition after device
 initialization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-ccaione-upstream-part-dynamic-v3-1-a38c19e74563@baylibre.com>
References: <20260914-ccaione-upstream-part-dynamic-v3-0-a38c19e74563@baylibre.com>
In-Reply-To: <20260914-ccaione-upstream-part-dynamic-v3-0-a38c19e74563@baylibre.com>
To: u-boot@lists.u-boot-project.org, uboot-stm32@st-md-mailman.stormreply.com
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Alexey Charkov <alchark@gmail.com>, Johan Jonker <jbx6244@gmail.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 =?utf-8?q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Carlo Caione <ccaione@baylibre.com>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Boards may need to read boot metadata before choosing the partition
containing U-Boot. The partition hook currently runs before the MMC
device is initialized, so it cannot do this reliably.

Defer selection until the raw partition load and provide the initialized
device to the existing hook. Explicit partition loads keep their supplied
coordinates, and a successful Falcon boot needs no U-Boot selection.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 arch/arm/mach-stm32mp/stm32mp1/spl.c |  2 +-
 common/spl/spl_mmc.c                 |  7 +++++--
 include/spl.h                        | 15 +++++++++------
 3 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-stm32mp/stm32mp1/spl.c b/arch/arm/mach-stm32mp/stm32mp1/spl.c
index d2e41b8e65f..2229ebf5eeb 100644
--- a/arch/arm/mach-stm32mp/stm32mp1/spl.c
+++ b/arch/arm/mach-stm32mp/stm32mp1/spl.c
@@ -62,7 +62,7 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
 }
 
 #ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
-int spl_mmc_boot_partition(const u32 boot_device)
+int spl_mmc_boot_partition(struct mmc *mmc, const u32 boot_device)
 {
 	switch (boot_device) {
 	case BOOT_DEVICE_MMC1:
diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
index cc16709dc9b..3e637f5adbd 100644
--- a/common/spl/spl_mmc.c
+++ b/common/spl/spl_mmc.c
@@ -301,7 +301,7 @@ u32 __weak spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
 }
 
 #ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
-int __weak spl_mmc_boot_partition(const u32 boot_device)
+int __weak spl_mmc_boot_partition(struct mmc *mmc, const u32 boot_device)
 {
 	return CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION;
 }
@@ -431,6 +431,9 @@ int spl_mmc_load(struct spl_image_info *spl_image,
 			return 0;
 #elif defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION) || \
       defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE)
+		if (IS_ENABLED(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION) &&
+		    raw_part == -1)
+			raw_part = spl_mmc_boot_partition(mmc, bootdev->boot_device);
 		ret = mmc_load_image_raw_partition(spl_image, bootdev,
 						   mmc, raw_part,
 						   raw_sect);
@@ -466,7 +469,7 @@ int spl_mmc_load_image(struct spl_image_info *spl_image,
 			    NULL,
 #endif
 #ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION
-			    spl_mmc_boot_partition(bootdev->boot_device),
+			    -1,
 #else
 			    0,
 #endif
diff --git a/include/spl.h b/include/spl.h
index 5078d7525ab..08a84536f51 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -595,18 +595,20 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device);
 
 /**
  * spl_mmc_boot_partition() - MMC partition to load U-Boot from.
+ * @mmc:		Initialized MMC device
  * @boot_device:	ID of the device which the MMC driver wants to load
  *			U-Boot from.
  *
- * This function should return the partition number which the SPL
- * should load U-Boot from (on the given boot_device) when
- * CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION is set.
+ * Called before loading U-Boot in raw partition mode, after any Falcon
+ * attempt. The hook may select the hardware area containing the image;
+ * it must leave that area selected. It may run for each MMC load attempt.
  *
  * If not overridden, it is weakly defined in common/spl/spl_mmc.c.
+ *
+ * Return: Partition number to load U-Boot from.
  */
-int spl_mmc_boot_partition(const u32 boot_device);
+int spl_mmc_boot_partition(struct mmc *mmc, const u32 boot_device);
 
-struct mmc;
 /**
  * default_spl_mmc_emmc_boot_partition() - eMMC boot partition to load U-Boot from.
  * mmc:			Pointer for the mmc device structure
@@ -972,7 +974,8 @@ int spl_mmc_load_image(struct spl_image_info *spl_image,
  * @param spl_image	Image data filled in by loading process
  * @param bootdev	Describes which device to load from
  * @param filename	Name of file to load (in FS mode)
- * @param raw_part	Partition to load from (in RAW mode)
+ * @param raw_part	Partition to load from (in RAW mode), or -1 to call
+ *			spl_mmc_boot_partition() in partition-number mode
  * @param raw_sect	Sector to load from (in RAW mode)
  *
  * Return: 0 on success, otherwise error code

-- 
2.55.0

