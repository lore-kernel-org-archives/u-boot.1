Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8747C606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 13:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=EbU/QcOH;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=pZIMzAp4
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 609BD812CF;
	Wed, 18 Nov 2026 13:19:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1B7OPzgOtWir; Wed, 18 Nov 2026 13:19:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 501D9812C6
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795007962;
	b=sxMpYHVLx0FzxRbOJjXvGFjI1E51n4d7VK/gfxjb6OaIgSRcLWhpRTcwhfqqk0Ij9y32
	 LYG/n2aoS5TDFckrSYDdUwH/eKE5hzREYEPvsDHvcWYbdn6GzYvxNAwUjRV0ziurrpOp3
	 BaL4ZxfyWgpvMycnL33MK5AU13udyl0hs9o9qA4VLqw050XyP9cUxWH5Ipkop3Iokfb5O
	 qTbZUxY+M9MGBVRwRDtLTDQxy7yBM5eA7avRJGZChFYeVzMrNJ+KjRxkgpideAZA7X+Ju
	 aLFeuTEHDo2rp50V4Ke3t4tz754QbX84fwzWzdUud1PydFvMzPYnOPvtoyBYwdypBiw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795007962;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ZM4ifLM9cmyt+w8kV7B4/8psw21D1lHoefNW9QT0e38=;
	b=r2cW7ElFtP4w8F0DeECVq2sxy3sg2qwzDzx3aCNmKJ6GIJCxqYd2OspBxX328ZY3sim/
	 1R5LGJ38RSVovzUHOWGjc0N3USxlLQj6le1GSmdWmExJdLu268q1jSwpIbl6EIaYBJzab
	 rpvnbMwsCoouX3zeyjLqGXxC+32NTN5zpIsE1JHX1I9ZeSfJYYrtbpNcLS/hz+vfdZmIZ
	 TLpLSPSc8IiOetkCCC2yBXgHm3s7yfmx8Osr7ppH4ELEGcdL9tjtPsYJu+5GYTcfPHZRb
	 T0okig+NsZfX66qL5gdVDou3x+H25Flsv4CdDe2rRe5cimXdCQQhnD8wyOkT/8nCLAQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795007962;
	bh=ZM4ifLM9cmyt+w8kV7B4/8psw21D1lHoefNW9QT0e38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EbU/QcOHxLiCwUPwtbuhjOFuYhyXtRI0JrtgzUA0u2bWGyGgKDZHhblfSAniqm4Kr
	 HtwzqNFnuH1eiqK+i8fv4kB9Dd+bBAII8fsAFIertl8txPsaLKcNDHTyf4aUW31UsI
	 Jdti7w7iEm6/WxgG7Z7Bf6UWEzG2mQPfmE8eXeRrWJhvnp15GRXKxHPj9j1+JXlgJJ
	 Ztutgt2mzYz/FhCm6ZwBB9/xbT0lkQXnz5VyLYuig71xl9bles7MrYD+USZ3gkdYaY
	 6+cPNK7ogJzI9c7wfDZpFsEp9w3VHcBDyrf30O1Ze9pit3zFYd4fAeaWOhOAuAkiNl
	 /T3ZP2tvG5hkA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 501D9812C6;
	Wed, 18 Nov 2026 13:19:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 83A12977
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:19:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6A6114047C
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:19:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c869DUNvP0Hw for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 13:19:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A473840060
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=185.171.202.116
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.171.202.116;
 helo=smtpout-04.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=pZIMzAp4
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A473840060
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:19:18 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id D0B24C4CBD9;
 Wed, 18 Nov 2026 13:19:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 082235FE9B;
 Wed, 18 Nov 2026 13:19:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0385F11BC1FCD; Wed, 18 Nov 2026 14:19:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795007955; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=ZM4ifLM9cmyt+w8kV7B4/8psw21D1lHoefNW9QT0e38=;
 b=pZIMzAp46/s3dbOHAb9MXHG20aA0MxbqVUkJT8LB4c+tR8A41wz3cR9Eqn7zrUMEox26xB
 afZBHrjeVeiLCt3/CdEvsUI1XuPt3eT6CJmeeLUDsfzm76IiMNwLieTXdIF2onYJ+UlKX5
 WOA/BvNP9IRE7M43Md99eI3/PMTUMdKfbzpFiXJH2CCfFIr+5bncRB5RB7LiYAiftYg2PH
 Pgz5cBprOHdR1gI2AWuc4HpjaNYeZmY6WE98fKEN/3rOwV7ZTWsVdMdxlkLbJR2fXe1/SW
 nikIE0JpKZ0R6atb8w+0hUDMnwvAssXrGdSKNUyApg2W8jylfBrti6rAQYc1Bg==
From: "Richard Genoud (TI)" <richard.genoud@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 "Andrew F . Davis" <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Bryan Brattlof <bb@ti.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
 Kendall Willis <k-willis@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Abhash Kumar <a-kumar2@ti.com>,
 Thomas Richard <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v7 19/20] arm: dts: k3-j7200: Extend firewall for ATF region
 to TIFS
Date: Wed, 18 Nov 2026 14:18:06 +0100
Message-ID: <20261118131807.135859-20-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261118131807.135859-1-richard.genoud@bootlin.com>
References: <20261118131807.135859-1-richard.genoud@bootlin.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

From: Prasanth Babu Mantena <p-mantena@ti.com>

Extend the access to SRAM region of ATF to TIFS as well. This is
needed for TIFS for encryption and decryption of ATF as a part of
low power mode sequence. TIFS encrypts the ATF while entering into
low power mode and decrypts it back while resuming back.
So, giving permissions for TIFS to access this region.

Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
Co-developed-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
---
 arch/arm/dts/k3-binman.dtsi | 7 ++++++-
 arch/arm/dts/k3-security.h  | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
index af752619255f..368c53783360 100644
--- a/arch/arm/dts/k3-binman.dtsi
+++ b/arch/arm/dts/k3-binman.dtsi
@@ -501,7 +501,12 @@
 					FWCTRL_CACHE)>;
 		permissions = <((FWPRIVID_ARMV8 << FWPRIVID_SHIFT) |
 						FWPERM_SECURE_PRIV_RWCD |
-						FWPERM_SECURE_USER_RWCD)>;
+						FWPERM_SECURE_USER_RWCD)>,
+					<((FWPRIVID_TIFS << FWPRIVID_SHIFT) |
+						FWPERM_SECURE_PRIV_RWCD |
+						FWPERM_SECURE_USER_RWCD |
+						FWPERM_NON_SECURE_PRIV_RWCD |
+						FWPERM_NON_SECURE_USER_RWCD)>;
 		start_address = <0x0 CONFIG_K3_ATF_LOAD_ADDR>;
 		end_address = <0x0 (CONFIG_K3_ATF_LOAD_ADDR + CONFIG_K3_ATF_RESERVED_SIZE - 1)>;
 	};
diff --git a/arch/arm/dts/k3-security.h b/arch/arm/dts/k3-security.h
index 33609caa8fb5..3e066bca6ad7 100644
--- a/arch/arm/dts/k3-security.h
+++ b/arch/arm/dts/k3-security.h
@@ -7,6 +7,7 @@
 #define DTS_ARM64_TI_K3_FIREWALL_H
 
 #define FWPRIVID_ALL    0xc3
+#define FWPRIVID_TIFS   0xca
 #define FWPRIVID_ARMV8  1
 #define FWPRIVID_SHIFT  16
 
