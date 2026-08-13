Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78288C5CFDB
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 11:44:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D98104070A;
	Thu, 13 Aug 2026 11:44:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C2YflhsNE_Kw; Thu, 13 Aug 2026 11:44:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0421140992
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786621498;
	bh=q3BOOGUdZDRlEQLxfn0cq6infTzpw4tHGS4JncyNuaA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=y9xbz55xu/IlVd4pPLkUeJKD/u1Ly+/FuSQGH9g8VQCJA6pkZYjQOv55x10Z/ooSq
	 1VWRbaf+rgaptaKzkJ2L5Urbu12RYefAnZ6EzZy0B2E5DfSv/J9lFApTBYnDZO7B5F
	 +QoZtESMUx7/UlLOX2DH65LTDR43F0vKvDRDNxpWN9kII8Nfv/DGuyEfLlvy96vE4f
	 5Ar7GMAkVDCFvRf4MN8IwGZWv3UbvUaQdID0cRz1n2FZ1SjuMTIen8b1PmEHdDxUUe
	 PBHeGIBwRfyql3jPcuLSpfNCTB9J+Uiah/VPl0x6b28E3V5fVGYTqdQypwE4/SMgZv
	 Q5S3xf8MPwW7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0421140992;
	Thu, 13 Aug 2026 11:44:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 52E743A0
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 11:44:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4479F40992
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 11:44:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id st0ieyHfGWKE for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 11:44:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::52b; helo=mail-pg1-x52b.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org E1EE14070A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E1EE14070A
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E1EE14070A
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 11:44:54 +0000 (UTC)
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-cbb7926836eso479176a12.3
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 04:44:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786621494; x=1787226294;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=q3BOOGUdZDRlEQLxfn0cq6infTzpw4tHGS4JncyNuaA=;
 b=seah3pduSPWiy/9S3LtYCOTqQW+6yfXBl4EP74VANk2uIkB0fY7tL5K4SF4vKIv3R0
 i2MasNPixWBBavKGz3nWhJO8y3OCJl1i+jjV7D5cvVmZa7y0f3Z6tk+H1PKIffAGPvpX
 B4iZk0tcDJAMqu8N/NHWh1AydVC+0Si1TQCotoa286AR/WhNfwQZAG5u0bXXTR51eMji
 TADjpS/e5Uruz5r4aZ88cd8KYmBIkU1OOin+VANLwwcohFNQ9AfQur0LVAAAt/8uTdwF
 OwFxNalNk/L6wpBuMXLIWr1WaseNi4KFr2Xf/2jZZjZ5GOiEbD7O9hNaQpDzCPUHMT7u
 kDlg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpF9zA7aMsDoLyQFdyc7KJ/IcYxhG5TBK05DuE6G0fIaC7K3OCSSSJRjfwYdDao0CxJJsAVFxQ=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzXpMAWS/Dkp/qE8QmjinUsOXtJ4/YTMECxFwNMI/w5Id1Pi2f9
 uyKrQno0RwzGA67qGyQLrSMRxNnWjw/7AxcfigFbHcWuOpHBVYAfd9Gp
X-Gm-Gg: AR+sD119A7JxgLxQzwkeirW1+ghClhQ1MJhckL3yxEGxWs/XSsvAwZpZgBJGRGdhGyn
 M5rxHRtgQcLQ9YZDcJrz1R0oSzRrPTMojBFMMNAiwlOkp71jblV3wdZiNy6tV8MNhIUhkmTwVde
 KBlFPFl4ybSpzIsdpgugvybC+UEaxhxHiaYTM2FPTNBx21I+h/7oioHlbx9HyH+mVYypgDOhYUo
 FigidV3SwFtLR9RbY6mODlW+3vxFQ7C80M4w+gEl6Fxbezdw86hPtaYKiD/BaGYQ5XDLqC0DQUK
 qIJmTzYDvRDmyKgrz/2MilwvMcvrIjWJ9L+mlsEOUfmzD0MtMDWY5aa2MJCPsklgRuXmhQlvnwZ
 EvCONis5uTfLDTFYk/jANBQv7A1Z2NXmq/m/uFcl5gW2I8sMsdCrTSKOdeT/JZGuxEuc5kkKLVn
 4IlqR6RXFiOulvXhBDbNMKSbys+iLtvZ3NTcWFvjQTvGfjIhRq1MqhprGLdPS9UWmS0mFJJ2qYf
 XtfIF7bpqJzeoUTPt4zXmn8LjO+RccQQu4iMQ==
X-Received: by 2002:a05:6a00:410c:b0:847:8e98:9a4b with SMTP id
 d2e1a72fcca58-84fc74991ddmr5389552b3a.34.1786621494030; 
 Thu, 13 Aug 2026 04:44:54 -0700 (PDT)
Received: from fabio-X870-EAGLE-WIFI7..
 ([2804:1b3:a802:463c:b2f8:f8b2:9607:d599])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbef721aceasm918764a12.25.2026.08.13.04.44.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 04:44:53 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: u-boot@0leil.net
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org, Fabio Estevam <festevam@nabladev.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>
Subject: [PATCH v5 1/4] mtd: spi-nor-ids: Add XMC XM25QH128C
Date: Thu, 13 Aug 2026 08:44:42 -0300
Message-ID: <20260813114445.51640-1-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786621494; x=1787226294;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=q3BOOGUdZDRlEQLxfn0cq6infTzpw4tHGS4JncyNuaA=;
 b=XO2aIg0lSD2dlxnhJ3YCIXMFLwopnb3Rdk8hzraE0719tHa1U/zd/s0AHRn4v8weh9
 +SOCSFJSybMlZ+xuNYIAkzQRcIGDhvZistOJdpGzvKP9NpWQLm/TY9DqFvo/C8mvjthb
 6yIibwmiwKsZAY4f681OWfswQYPAsKhnn1OTtxd079JTkIKI6tF7+AxPhHR6nxzSFpH5
 6KR7yI0Rxu0G5j8h38P5Ge7EL5Z69NL52cpovkkWDzArITwfI1XaR8VgE1in2hdL5Cr5
 cOs3jLyZ337dbriSBBUkK4kTVrev1pfhogrZlZH5IU+P1JpwtBNCQSwlnU5leOGauLRr
 0TEA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=XO2aIg0l
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Fabio Estevam <festevam@nabladev.com>

Add the JEDEC ID for the XMC XM25QH128C SPI NOR flash.

This is a 128Mbit device using 64KiB sectors and supporting 4KiB
erase, dual read and quad read, matching the other XM25QH128 variants.

Link: https://www.xmcwh.com/uploads/435/XM25QH128C.pdf

Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Signed-off-by: Fabio Estevam <festevam@nabladev.com>
Reviewed-by: Takahiro Kuwano <takahiro.kuwano@infineon.com>
---
Changes since v4:
- Added Link and Takahiro's Reviewed-by tags.

 drivers/mtd/spi/spi-nor-ids.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 31a2ba49a87..90aa1025176 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -673,6 +673,7 @@ const struct flash_info spi_nor_ids[] = {
 	{ INFO("XM25QH64A", 0x207017, 0, 64 * 1024, 128, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ INFO("XM25QH64C", 0x204017, 0, 64 * 1024, 128, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ INFO("XM25QH128A", 0x207018, 0, 64 * 1024, 256, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+	{ INFO("XM25QH128C", 0x204018, 0, 64 * 1024, 256, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ INFO("XM25QU128C", 0x204118, 0, 64 * 1024, 256, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ INFO("XM25QH256C", 0x204019, 0, 64 * 1024, 512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 	{ INFO("XM25QU256C", 0x204119, 0, 64 * 1024, 512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
-- 
2.43.0

