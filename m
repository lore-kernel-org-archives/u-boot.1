Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B48606A329
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 10:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NcKf+ro3;
	dkim=pass (2048-bit key) header.d=e-labworks-com.20260707.gappssmtp.com header.i=@e-labworks-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=X0Mgjakc
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 98FEC81061;
	Tue, 17 Nov 2026 10:15:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6fETzSVZj55G; Tue, 17 Nov 2026 10:15:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CD1ED80D83
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794910541;
	b=opgh3z0TAK+oumTQkl7MqSI/r8ilQTZi+HVN1JQY2NPD1062jrBScmA5CKhPe7dtZDN8
	 nTOZvzdr0uT8u9VGjAKxNTnQPMhINhW5NSny/0YE8x5Cqv0Id0Fb/M2zTDBye3HkKDA/x
	 RI6OOfz6acz+69oz817MwhTcdgBXG4DRJxPbWnTI9F6kMMBVFpH4moOAQ9R8V9F4LEkec
	 VcxGsMOiPi91rqTzCvKwWAoNs95ezLY6BtPGD56qibO0msC/9/VFOKE4Ou14Q8go427H4
	 RRVERMC2HDj46K9sTmumb95qt16qi4QgYNd1oFIIxPqvwafj/R3hbG2ztrzrTH2S4qA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794910541;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=fzEbL1nZKec3MFKqdIhExkf6SeO96t6Xe4IHjK6PCSY=;
	b=dRkj5K9ahE/a9fnekozr1qhPdRf74WjCoIZCiUz75vBWkL6sxelDrDjW+p+ZBWxwK0sZ
	 /1W8ZKGOBS03RDirLAANA/22dljY9qO1kaEcg5D69fVwNb2KBETtxMdUxgFWXo5Y12daO
	 3htfFCqzL7mwc06FFyFnpu7tBAn52wxUEUwq6Zd9nMMFnXN9jjf0KbmdxXBbzywCoMnTw
	 kHcG1XxgM9qd3q07si7ObVq1ZDrzJqBccC3J9U8MBLvj1x8Dkyjgyd9Mssd/2AlXsy6Dx
	 rM0MOvY6jrEXR+l0/UlNUGSDc/4YAyi7/Ev9O/QSlFW1JRL2BgxtYVz58EwstxfU3Cw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=fail header.from=e-labworks.com;
	dkim=pass header.d=e-labworks-com.20260707.gappssmtp.com header.i=@e-labworks-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=X0Mgjakc;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794910541;
	bh=fzEbL1nZKec3MFKqdIhExkf6SeO96t6Xe4IHjK6PCSY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=NcKf+ro3TMzs4F02LXCNoVrFo5LPoaPLnzd2ya+4ap9SSwXM88u25QuwlmTfb4FSw
	 s0YKd0L+tDjIj6SH6T0Gp3mXX5dV2yzOCHE4eZEAWvCGaL08jpIbrq6/Sa8vvDdo36
	 4vC+G0Ve5zwPcPzErFl2vj/9DyA92dV66FMafTYkct7v5ScT+45mNL7FvYuaQKvO2+
	 0bItq4U7DPCnANNlTPqEL4TDqp2ffbQewVBA20ceyJ2eonHSseJf6kfyDb+EummNd7
	 n6f43kLiVLMGTNtERnCep1Hji3EEFriVgWXEpNlrshGL/gM0SS/+KNy19JFfPxHj+X
	 WccDb5GTdnB3A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CD1ED80D83;
	Tue, 17 Nov 2026 10:15:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A8D5E1A6
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 10:15:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 94C4380D83
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 10:15:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dyYc48MfrgSf for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 10:15:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C31E780D10
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::112a"
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112a; helo=mail-yw1-x112a.google.com;
 envelope-from=sergio.prado@e-labworks.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=fail (p=none dis=none)
 header.from=e-labworks.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=e-labworks-com.20260707.gappssmtp.com
 header.i=@e-labworks-com.20260707.gappssmtp.com header.a=rsa-sha256
 header.s=20260707 header.b=X0Mgjakc
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C31E780D10
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 10:15:37 +0000 (UTC)
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-8b4f21cc259so3310127b3.1
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 02:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=e-labworks-com.20260707.gappssmtp.com; s=20260707; t=1794910536; x=1795515336;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fzEbL1nZKec3MFKqdIhExkf6SeO96t6Xe4IHjK6PCSY=;
 b=X0MgjakcnKkK81bSNRzrbtQvwGqrl46xDpB/NnIF6RCLB8O9QMie9r01B6lcqH8t5J
 5KD6Lj5ctCKH2ZPGj49RxeP1Cxgr6qS1FBJ6yx7DmVnQ9BDC1wKKSoKFRkoj5x7ND732
 EbMqI6HAvWrQcTZHRKNTYlgp4SMe8ypuoJsJ6l4UoQiunqv+cfDoKdNklHYxj4TFgR7R
 3O3YLCIVaFIm7lQYvfF81GRokCheSvGuWCycx5EtWlpNnc4RtGn096Eq+DVOB4rB7nni
 UwyCuwIaqjOxiFcmy+/pc67LKN4X9t9/LW20O+RYlq5ofdaHQ2qi6OlWpfYxRng8mfY6
 RTUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794910536; x=1795515336;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fzEbL1nZKec3MFKqdIhExkf6SeO96t6Xe4IHjK6PCSY=;
 b=PQsTElB6TXZ5oMtpUMvVr9l4OhCwrYwb0bKkAbNRAHkJSvGMStXO1tYiOJoIV74jIL
 +uKCx4bja8FV84Ri0DogqEn/HISXWSDGzBqDWC+Tyn4EutbgDm1bPV0sz097FrfP04AG
 M3jsK4U/0ySbMa0Xoj13uribTRkRiCvmXoptwvfFJbS6u/OC6LWk9eDHuk7mC0e3LAxo
 oJK/Y4b5g3fhUrMTTiu9G03WcK1SsJ7i6DbbjJncvdEEX9K5RjFl+VsWEdiwRC+OctQa
 n7yqSWFmMsQQgLzrkRGwQK6vOn1RmkHiuFcnVZdIJN1de5iaLocNdFsYNDJ3Jgy6nYai
 wGZg==
X-Gm-Message-State: APuU4Z+TXMRGI3N3xdb3Tj8Lhta3y9lplDkSLag/SI/ZHxfhCaG9FPxu
 yDUhYTJrpvIo0I7uSlbUnX7/T7LsiCP9Ksfl7dzDj0PEDgGbvkJwXH6ZGT9z0/TtInFWD+hlxhd
 c6XV2
X-Gm-Gg: AZFdTZdJ5ymvz26yVLXwXwF5M0GMP2cjsrWe2mrm9Ttd0smRWXE0yUFvLEqkaTNYDWg
 lOd9GIMSa1hPRbd2bbmU5pGEbNVotHRU0fXfOvXMRi4gfzGlHjgFonh91A+LYFK/TJ2JRblJjp2
 i75GLzfvcW//5MNxvjhRFuulqO9kesBTm4H68UYA4AeR0UnNd1hJ+aTitj8plfKpjmmdGvtMnNJ
 CkJ3IhgaiDMGplNRDNzRrEnrH09bDG4YZCuWeQ+5lQAp2f693ZzGOhWzoAwOCnH3QFW0K+l0GmX
 7QzNTDQ77UNavIrvIUU+rh9srmj5Dblf4oD8/LN5v2ltsLW2Pqg7UVZDKfghv6MwvM1rlgeo5q2
 tS5NdZUVlfWAwJI4UKyCj5LQyaWtxXhj3HAnGF/ppjlI44opGt7y/lwuDl4qigKurF52sUeZE9d
 iHKAFVcLr8TrkEa16LixG0Sb3Lpx7zGp0jcXdAD5//vxZ0ToZv+XLKNBvrqqXPSkntWsjorL8YN
 50h7qhy/MHVKTD1ZwRJJEUGrXNbbxL6qHwLRvBAbiEh+uj2J4P4lfqMuUmSVudQlHM/7rcUhwIm
 QwoC/adZ1RPpP4NI4x9OMZxEFtXjzrn61i95
X-Received: by 2002:a05:690c:f16:b0:8b4:c71b:e4f9 with SMTP id
 00721157ae682-8b4ee18f50fmr13400577b3.8.1794910536157; 
 Tue, 17 Nov 2026 02:15:36 -0800 (PST)
Received: from desktop.. ([2804:7f0:6400:b6f:6eee:9e47:df40:7cb1])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b4ec065d13sm19934727b3.25.2026.11.17.02.15.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 02:15:35 -0800 (PST)
From: Sergio Prado <sergio.prado@e-labworks.com>
To: u-boot@lists.u-boot-project.org
Cc: francesco.dolcini@toradex.com, festevam@gmail.com, sbabic@nabladev.com,
 uboot-imx@nxp.com, trini@konsulko.com, marex@nabladev.com,
 o.mandel@menlosystems.com, Sergio Prado <sergio.prado@e-labworks.com>
Subject: [PATCH] board: toradex: verdin-imx8mm: adjust U-Boot proper offset
 for eMMC fastboot
Date: Tue, 17 Nov 2026 07:15:19 -0300
Message-Id: <20261117101519.3952636-1-sergio.prado@e-labworks.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The Verdin iMX8MM boots from the eMMC boot partitions with the eMMC
fast boot fuse enabled, so the boot ROM loads flash.bin from offset
1 KiB instead of the usual 33 KiB. The SPL loads U-Boot proper from the
fixed sector CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR, so the board
device tree moved the FIT in flash.bin to 0x5fc00 to compensate.

That override only works while the fit node is placed directly in the
binman section. With CONFIG_IMX_HAB, imx8mm-u-boot.dtsi wraps the FIT
in an nxp-imx8mcst node with its own offset of 0x57c00, which takes
precedence, so a signed flash.bin has the FIT at 0x57c00. When booting
from eMMC, the SPL does not find the FIT at the expected sector, treats
the data there as a raw U-Boot image and fails to authenticate it:

  Authenticate image from DDR location 0x40200000...
  bad magic magic=0x75 length=0x206d version=0x63
  bad length magic=0x75 length=0x206d version=0x63
  bad version magic=0x75 length=0x206d version=0x63
  Error: Invalid IVT structure

Adjust the sector in the SPL instead, as the Kontron SL i.MX8MM does,
by checking the fast boot fuse and the boot partition, and drop the
FIT offset override. The FIT is then at the default 0x57c00 for every
boot medium, with or without HAB. This also applies to the MX8Menlo,
which reuses the Verdin SPL code and U-Boot device tree.

Signed-off-by: Sergio Prado <sergio.prado@e-labworks.com>
---
Tested on a Verdin iMX8MM with the eMMC fast boot fuse set, booting from
eMMC boot0:
- without CONFIG_IMX_HAB, on this tree;
- with CONFIG_IMX_HAB and a signed flash.bin, on v2026.07 with this patch
  applied, on an open device with no HAB events.

 .../dts/imx8mm-verdin-wifi-dev-u-boot.dtsi    |  4 ----
 board/toradex/verdin-imx8mm/spl.c             | 20 +++++++++++++++++++
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/arch/arm/dts/imx8mm-verdin-wifi-dev-u-boot.dtsi b/arch/arm/dts/imx8mm-verdin-wifi-dev-u-boot.dtsi
index 183de46f66a8..2dd80338c0c0 100644
--- a/arch/arm/dts/imx8mm-verdin-wifi-dev-u-boot.dtsi
+++ b/arch/arm/dts/imx8mm-verdin-wifi-dev-u-boot.dtsi
@@ -35,10 +35,6 @@
 	bootph-pre-ram;
 };
 
-&binman_imx_fit {
-	offset = <0x5fc00>;
-};
-
 &gpio1 {
 	bootph-pre-ram;
 };
diff --git a/board/toradex/verdin-imx8mm/spl.c b/board/toradex/verdin-imx8mm/spl.c
index 10b9991e3bf9..d340286e4bbc 100644
--- a/board/toradex/verdin-imx8mm/spl.c
+++ b/board/toradex/verdin-imx8mm/spl.c
@@ -43,6 +43,26 @@ int spl_board_boot_device(enum boot_device boot_dev_spl)
 	}
 }
 
+unsigned long board_spl_mmc_get_uboot_raw_sector(struct mmc *mmc, unsigned long raw_sect)
+{
+	/*
+	 * The image offset on SD/MMC devices is 33 KiB, except for eMMC boot if
+	 * fastboot is enabled. In this case it is 1 KiB. In order to make the
+	 * bootloader universal, check the fastboot OTP boot fuse and adjust
+	 * the offset.
+	 */
+	if (!IS_SD(mmc) && (readl(OCOTP_BASE_ADDR + 0x470) & 0x80)) {
+		switch (EXT_CSD_EXTRACT_BOOT_PART(mmc->part_config)) {
+		case EMMC_BOOT_PART_BOOT1:
+		case EMMC_BOOT_PART_BOOT2:
+			raw_sect -= 32 * 2;
+			break;
+		}
+	}
+
+	return raw_sect;
+}
+
 void spl_dram_init(void)
 {
 	ddr_init(&dram_timing);
-- 
2.34.1

