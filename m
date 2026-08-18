Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AB64C5DF7E
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 14:21:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BF106608D4;
	Tue, 18 Aug 2026 14:21:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e7Iv9aqK9hlR; Tue, 18 Aug 2026 14:21:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 24310608AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787062886;
	bh=gvOnlk/YoTsw5ojkG7HTNyeznJHEuQI8WjzDUf+xies=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=FZ1L2l0wDQf9wZ1guTkoGDSWH8ecg9+AKDo8vyIOIFSYM0gegNNcK22nZ/Uouhvd9
	 K4Jo0ivNstj+ttJ33IG1tTwxaciFHdgoRWh0kG0GSZWA/pl38QpV3o8kCMB+zpKPWT
	 ufWo4M02D1dQMqAnZTgpYR7MAQLJfazIM+NxiSWp0yZvYR+L8/vtBAzunYrtaqpuzP
	 nZLk+sITcEMDISfoKg0F3x3hWLUdsdpYd7pTmTAMOcanpSWZ+3qAB69RSGgIcE3q4F
	 BCuWsKQCbv+y/DebhKQdv5fBO5pXykkxrhncx3BNJz6g/4LJdzWhiG2CySyGBKT6qE
	 IeP6HfnHbKhYQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 24310608AC;
	Tue, 18 Aug 2026 14:21:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E5F52322
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 14:21:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D79F880CF2
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 14:21:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p919yNB-ywyr for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 14:21:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 2CA6380E71
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2CA6380E71
Authentication-Results: smtp1.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=FySJmqgP
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2CA6380E71
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 14:21:22 +0000 (UTC)
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id F400A3F62F
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 14:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1787062880;
 bh=gvOnlk/YoTsw5ojkG7HTNyeznJHEuQI8WjzDUf+xies=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=FySJmqgPqs8NVQJjWEZjKuIEI+BMcvdg1PqTUUONTB5Ih6DbM2gW9A98IrEkLaRpO
 RP09VIFT5y0YTQtXukHWn+qKHNbOgfBXhzyjA6T6UTOQJuN2TbYJGW4lMzohQvw8iA
 biKCgXXjgeehemHialGhYXEkPvNuS3bTGywvkomfNkgp2DLeD8Y2k1Bn81KC7MJ4Af
 ChUztAXxYoAtR6ySxbf65MRRGIblC8XHxJIs4TpLYP0qteBMU4ZflbXzWdO5aPODOe
 jOEQHH7oXrJ6NprUgwfZYR5gh9I4G/zZ9dCiSAcfz81ZrEuEDkHL+8nSWqO0PU8VLE
 e+rHLKSMaVC+rnmpG+cX1FVeXpWuOjqxTUAw3HDz08hkv4DPGZaz+KC7czcQbFnSi8
 6TB4gzGZsvgItt1+KgWtoVt285F7J0De3UuLyLECpuLwuOB1UbZBFigzqvLFZNaLgK
 gFPZM//XTDOtPdLkV8RmFSBNMtQsv67tz49JezS50Tc2H6fzt8exdG/u2DjO2WXq52
 2GX3khv17Ix+dDoRIN1tiXx8OqZX9xki5dIWKiMFa30vF+a3lxjxNQ8jQ9EtJmMHst
 G02GEJ6TE6hgQbSsFbBrm5ri+Q5g5IWQF2pAhW+os18lP4LeCG6ioKfpv0NI7PpFzz
 rxU+pvuZFIArAeYnVDGeSyX8=
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-47f84ac1990so2776017f8f.2
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 07:21:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787062879; x=1787667679;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gvOnlk/YoTsw5ojkG7HTNyeznJHEuQI8WjzDUf+xies=;
 b=s7vvQ9Ynt1NrWWFYO1rVbZX7KhuQX8pO6St4K6uvzSjhfhlh7SabQbTHaTGecJQuOz
 inhZ9tf1pbjZNmxY1LLXQA4/LDKayvb1aGbK+LydSW8+7LzGIgmR6meXHOO2qzRbQnJO
 uMttB2lpysYAe/uTpBx4dZd58ijtu5QjYXGcbuVIy3MRQ+sUMbA/NsIUrFoWR7zyO2HD
 sz16NPBVa/Y6hld64Oi928+Fq5Xmvfv3qyg3ajUDABDougQwdRw/CU34MpPSWVJUOVIi
 5qvTx7dW7aY7vXqkYIsYubNGyBTmUz1gw7I/+TfUa4L4EpIq0r+e9kkZ4J/iYisNnvd5
 uWTw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqVHPfxELDFTcbWsqq1CXtNE3pzbtyYdSky5+T+/mpdYwEJF7jWeNaLTkP5l3yJq0Tg/DNaBYY=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yy9g1JqjtjbnP5eaydIt8bIjolvxDfKwjDo3U/nixBsKQda3/ip
 WYneXwYThJ2nq8nkvRws7VdGpx1hT1eusPtwV+gzCTHRz0h1wWx6AX+UsXwXHV7WTStwqffX0sT
 /LC5Xxo14MFiNOqTomRGYCpq/BdHriyb2XHJhi7c/3qmNIDCEIFYXSjUIiJ3pCYHTVQqwsz89ys
 73Xp5I6eO0eA==
X-Gm-Gg: AR+sD13Bpbm1W6B/1WQ4P0kW6akhWMBuXLMiC1BCrwjac9JZrPl/9LfHi4Mk3QmWjpa
 g1sCmTvBE+ScMa0VZwzAAmG4rE3+cN5XagOaIxvHYGRBK5E/QWjWWB1yDFehgvi2bA0x9i6rW7d
 rOS/OtiOF6rlpIXep7iLyWLwp//XSdzqu14RLAeciT/WPwPE22Qs8B3f7x2UFiRSsKonkDuM+GA
 izt208BkyF0mjO0g194FuSAiZTIYsaJbOpWBIRV9QEoGyPfL4W5ZUthpyYPYDaWnuRE8j4/Sy8H
 kYCp0rV6YyrxWCCjhDuAFwEjDQwvkwp5jvFt2FbVYMUsjvTI57O05D5yzSgUAvdra+8qZAkjLG9
 H5HGtk75CqSXdxjvTqHT+gLBCFGswBJN2VL1L5tbUgFBWbEvFQEarlPSJ
X-Received: by 2002:a05:600c:4fcb:b0:499:5a50:b022 with SMTP id
 5b1f17b1804b1-49987928d0cmr573411275e9.3.1787062879313; 
 Tue, 18 Aug 2026 07:21:19 -0700 (PDT)
X-Received: by 2002:a05:600c:4fcb:b0:499:5a50:b022 with SMTP id
 5b1f17b1804b1-49987928d0cmr573409905e9.3.1787062878830; 
 Tue, 18 Aug 2026 07:21:18 -0700 (PDT)
Received: from workstation5 ([2a02:908:1242:30e0:bcda:7742:51e7:90c3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499961098cdsm284906825e9.6.2026.08.18.07.21.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 07:21:18 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Johan Jonker <jbx6244@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.u-boot-project.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] mtd: QEMU uses 32-bit port width for ARM and RISC-V
Date: Tue, 18 Aug 2026 16:21:13 +0200
Message-ID: <20260818142113.205897-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

On qemu-riscv64_smode_defconfig the flash size was incorrectly reported.

The QEMU code has:

    hw/arm/virt.c:1792:    qdev_prop_set_uint8(dev, "width", 4);
    hw/riscv/virt.c:134:   qdev_prop_set_uint8(dev, "width", 4);

As U-Boot lacks autodetection of the port width, we need to set
CONFIG_SYS_FLASH_CFI_WIDTH_32BIT=y.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 drivers/mtd/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
index f6bd9f6f2e9..b370b2b6726 100644
--- a/drivers/mtd/Kconfig
+++ b/drivers/mtd/Kconfig
@@ -60,6 +60,9 @@ config FLASH_CFI_DRIVER
 choice
 	prompt "Data-width of the flash device"
 	depends on FLASH_CFI_DRIVER
+	default SYS_FLASH_CFI_WIDTH_32BIT if \
+		TARGET_QEMU_ARM_32BIT || TARGET_QEMU_ARM_64BIT || \
+		TARGET_QEMU_VIRT
 	default SYS_FLASH_CFI_WIDTH_8BIT
 
 config SYS_FLASH_CFI_WIDTH_8BIT
-- 
2.53.0

