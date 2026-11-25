Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6CA606A31E
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 10:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XpV8EfmK;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=XUojVst7
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7EED360892;
	Wed, 25 Nov 2026 10:58:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ldO7MQ9OTdXQ; Wed, 25 Nov 2026 10:58:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3503D60884
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795604320;
	b=FcY7YIFmMo/1/WNipZSnPp7jN4HU2Ws1VhaIvvY4Jcmfc7TWDmFr8gmyXmx7F8sD7QaJ
	 PiSCyTSfO42KgfNE3xvDGGEX8Oz+M5Yg4Kt2RRx7wDoN9npIKzUFci/wiDNSx40jmUdv2
	 SuU38wru31YSsTn/M6Gkmu0oSs1srjaqhUGuasCzXH8Nk7l6Wl2Tnw842McduyYR2K01o
	 8pEs57nOfLHVCZZ57MA4gjP1opr4iXSAvaTmrE8Nm2qRJRERKs7f20OE491kQyzAY7zWi
	 PBEbqGprps2udlYojS05vyuvTufp+r4WpBXDx0DnNTJkZcyMufba3Wan4YRxxsnwzTw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795604320;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=uJXjeKUVgdVfosghpt8W3KbfVw5LtEfXWRiktO9wHos=;
	b=DwJiTGIfY4i0P+ujr1j4o36TiG1BgAc8Yg/FVcaMq4YFegTuHY7u6dcITdApytCNcFUQ
	 ooh846iNApJW8zY/3mw7MAzkSJI+Platc9asI1nyp03ZbydP2YkyIg8JV+BaYVSf2yJgJ
	 YeX6Tl0nM0RJNg4S9rd9KJIqaR2VieUleMLlpIFfl4Hoyuq0+OEqKyr8zn04+N9Lc/X7b
	 cFnWPfb8sFPGtPITkftl49H7qp9rCU2R5t4K2/1tz1aKFnozCACotnUtGMsNd0+9RHBWu
	 USroGKgN3ogm5zAcL3DvGN+wcMijN/Z6mRxc/A+Dot81rBTwI29iRdsqFV81PUsNp1Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795604320;
	bh=uJXjeKUVgdVfosghpt8W3KbfVw5LtEfXWRiktO9wHos=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XpV8EfmKsgg8KiLt2l0rlC33POYaWMcdZIIQS932dWx4Fx8am5qdAb8zG9LIcVwSM
	 7ucSwWAHxTXypIAyMIvBVSDM6yhIyHWhnIAcsErTKEmUWNDoUxKeoli65/PBTZoaJQ
	 SZ2tZUns67dvb37Ur8uPrqT13GlnAy7Ai10BKzdxTBcQ4dtRZNdmZudD/ZIi9D7+Ju
	 SOEDi4Bj0mvyXltQWuiVzLufoR9DPIUOrFLAFYUeYhB2iwemh3ofPmXy/p7lz0Mkfy
	 jn5cfb9RiuiGnA5rirMiCJjtBz7hKJfLRpu7J0p8mZlpXPwU5Kpyjp+EukjecUSW6M
	 yp67m5RYAydtw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3503D60884;
	Wed, 25 Nov 2026 10:58:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id CD286325
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 10:58:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BEDF580847
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 10:58:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9KvOzuI6zUut for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 10:58:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9630080835
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::433"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com;
 envelope-from=clegoffic@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=XUojVst7
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9630080835
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 10:58:34 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-4ac08f4a0b2so3957908f8f.3
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 02:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795604313; x=1796209113;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uJXjeKUVgdVfosghpt8W3KbfVw5LtEfXWRiktO9wHos=;
 b=XUojVst71spEIJc1cwxhqf/s/WY1OeYTM39EFDRgHU1uktyvasPWqleTs5vfGwWqSG
 cvmOLvtcsGPTw51AlfTeEvsbDo3wk2q0obY13/Y7Rzjpdu+imhSTrhX4Rc2TMOy267aC
 DGaLib1St1zm8Evcum6Ppm33jjeW3l4IvMVdLDPCIC1JKUUYV1e/y7ytS3gEK8pZcFpg
 QB7O1cp7YAav/b5bxpEUHDdQi4hdBgTTEa+FzR7yQeIQskTBJQY7hKdDQAX+HYX2IgrY
 WTOFJdWkM3SfYXy93b5nTtggTsZySs6l9S69RYSgdy56y8sV07AXCxWYfQbAkotIWG93
 LqoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795604313; x=1796209113;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uJXjeKUVgdVfosghpt8W3KbfVw5LtEfXWRiktO9wHos=;
 b=MeNYXmJjg2Ljhy8w7rF+ncva1DGtBo4Ni775X+0HknkIpvZUNEcsNPi946smSdrgUT
 NVHTVCWB2tN4FzevDHyZVGGghCrS0PHnEeZD5IOVWutCyMM7/dUanEJKeTW+Vfda2UzJ
 lLjrii+7GDITND/LkoMLZSNmBJGlI9nvLak9wa69aJGxc26bQKPz2weUU91Chl3HI9+i
 UM8RuAGCAo444Y2bWhNYVazqk+KUXYRJeAR4FbNLBpeQq5nZW1aMUkdJI37ATZI3Hiy9
 agG62Cokh31MIEsDJyVWQnvLHf7RYWCgUhXTfT0dl9JJo9K7Cdi+I4vfPGQ8wu1h29IJ
 O69A==
X-Gm-Message-State: APuU4Z8BoikIkMUF+mpMx4xuwBFkfFN6BPFdz50WmGTGBCG7R3kBmSDz
 PEoWC0Bjt8slW923PQgXbqPaErKV1XUlN3BZEbZg+nDnDEl8l4bOtILs1ca82igWyJ6Bm0bSdKS
 PpKrEomjexA==
X-Gm-Gg: AZFdTZcFMwKGtTUE7s1hoMnwOZSEi8R3oSAx6dGlG2y/6j7gt+nDfW972AMjlUiBbD/
 PkaieodeFvHF7tB9BwwscbRd1HETEeVifiYbazu2E1x9y4sOf449EisEWhLDPcY4/Fh1fXLIozZ
 eHGSTJlhcwOJDlcUt594lMR1esRYQOgk9/ZR9mgP7itpk9Bs4PwIijl6fx3tX65oKff6ifYo8Js
 TlcLx0cHEJFuHbUZbc4uM8nOiD987E5DvsQP3YGf7LUiH35qpYZO+5PXxOLqDztOfk8BpRGcs4B
 4k4O2crbJfP7TnToqFcdHbU3MZ6+Oai3paqT+RgA7WRCu6naPEVSi5IBsqNLEJ3HAjv3pr5tIDA
 W2Xo5UXGthGQArxVKWMzL0ipBjYZdGKZ39T+TfFgh+T8t4JbUsp3fv5r8BMRQdBaD+Mb/maIh6G
 5mxhjof97ZmVXKxUfqWaSemsI7cVdpxuo+XiYDK9uOlXUS5SPurl1HjSKYbtMBkSCo8aoQBXPRe
 p487pWSEpdP6zh4Au37OxfHdv6Vwb3aT1HzoPM7gl+f1FG94H25b0xBS1q/aRvkPnKPlh8vULSi
 ZvX65XWqy/wsY2QJ9ta3dm+zhYSJPuJliYB+LjD26m86TFBZq5hj5w08jM/iunoF+z0O0iIx
X-Received: by 2002:a05:6000:402c:b0:4a3:41e1:9d16 with SMTP id
 ffacd0b85a97d-4abb19c05d0mr34479313f8f.25.1795604312982; 
 Wed, 25 Nov 2026 02:58:32 -0800 (PST)
Received: from localhost (140.30.66.37.rev.sfr.net. [37.66.30.140])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6baa3882sm33129447f8f.49.2026.11.25.02.58.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 02:58:32 -0800 (PST)
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clegoffic@baylibre.com>
Date: Wed, 25 Nov 2026 11:58:10 +0100
Subject: [PATCH v2 01/11] env: Kconfig: Only offer CMD_ERASEENV with an env
 driver that can erase
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261125-clegoffic-env-flash-erase-v2-1-8d31a33a54d2@baylibre.com>
References: <20261125-clegoffic-env-flash-erase-v2-0-8d31a33a54d2@baylibre.com>
In-Reply-To: <20261125-clegoffic-env-flash-erase-v2-0-8d31a33a54d2@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clegoffic@baylibre.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Johan Jonker <jbx6244@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Weijie Gao <weijie.gao@mediatek.com>, Fiona Klute <fiona.klute@gmx.de>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
X-Mailer: b4 0.17-dev
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

CMD_ERASEENV can be enabled with any environment location, but only some
env drivers implement the erase operation. With a driver that does not,
such as the flash, NAND or FAT one, the command is built in and only
prints "not possible".

Add a hidden ENV_SUPPORTS_ERASE option that env drivers select to say
they support the "env erase" command. The drivers that implement erase
select it, and CMD_ERASEENV now depends on it, so at least one of the
enabled locations can erase.

Signed-off-by: Clément Le Goffic <clegoffic@baylibre.com>
---
 cmd/Kconfig |  1 +
 env/Kconfig | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index c64ca1807ef1..de2476107dcf 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -745,6 +745,7 @@ config CMD_SAVEENV
 config CMD_ERASEENV
 	bool "eraseenv"
 	depends on CMD_SAVEENV
+	depends on ENV_SUPPORTS_ERASE
 	help
 	  Erase environment variables from the compiled-in persistent
 	  storage.
diff --git a/env/Kconfig b/env/Kconfig
index 394e91833a33..f3b95fe64f57 100644
--- a/env/Kconfig
+++ b/env/Kconfig
@@ -100,6 +100,12 @@ config ENV_IS_DEFAULT
 		     !ENV_IS_IN_UBI && !ENV_IS_IN_MTD && !ENV_IS_IN_SCSI
 	select ENV_IS_NOWHERE
 
+config ENV_SUPPORTS_ERASE
+	bool
+	help
+	  Selected by the environment drivers that implement the erase
+	  operation used by the "env erase" command.
+
 config ENV_IS_NOWHERE
 	bool "Environment is not stored"
 	help
@@ -143,6 +149,7 @@ config ENV_IS_IN_FAT
 config ENV_IS_IN_EXT4
 	bool "Environment is in a EXT4 filesystem"
 	depends on !CHAIN_OF_TRUST
+	select ENV_SUPPORTS_ERASE
 	select FS_EXT4
 	select EXT4_WRITE
 	help
@@ -230,6 +237,7 @@ config ENV_IS_IN_MMC
 	bool "Environment in an MMC device"
 	depends on !CHAIN_OF_TRUST
 	depends on MMC
+	select ENV_SUPPORTS_ERASE
 	default y if ARCH_EXYNOS4
 	default y if MX6SX || MX7D
 	default y if TEGRA30 || TEGRA124
@@ -313,6 +321,7 @@ config ENV_IS_IN_NAND
 config ENV_IS_IN_SCSI
 	bool "Environment in an SCSI device"
 	depends on SCSI
+	select ENV_SUPPORTS_ERASE
 	help
 	  Define this if you have an SCSI device which you want to use for the
 	  environment.
@@ -393,6 +402,7 @@ config ENV_IS_IN_REMOTE
 config ENV_IS_IN_SPI_FLASH
 	bool "Environment is in SPI flash"
 	depends on !CHAIN_OF_TRUST && (SPI_FLASH || DM_SPI_FLASH)
+	select ENV_SUPPORTS_ERASE
 	default y if ARMADA_XP
 	default y if INTEL_BAYTRAIL
 	default y if INTEL_BRASWELL
@@ -427,6 +437,7 @@ config ENV_IS_IN_SPI_FLASH
 config ENV_IS_IN_MTD
 	bool "Environment is in MTD flash"
 	depends on !CHAIN_OF_TRUST && MTD
+	select ENV_SUPPORTS_ERASE
 	default y if ARCH_AIROHA
 	help
 	  Define this if you have a MTD Flash memory device which you
@@ -499,6 +510,7 @@ config ENV_IS_IN_UBI
 	depends on !CHAIN_OF_TRUST
 	depends on MTD_UBI
 	depends on CMD_UBI
+	select ENV_SUPPORTS_ERASE
 	help
 	  Define this if you have an UBI volume that you want to use for the
 	  environment.  This has the benefit of wear-leveling the environment

-- 
2.56.1

