Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B575BCD8C9D
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 18:06:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E56688407D;
	Thu, 11 Jun 2026 20:06:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ms/iscf9";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="d/F4YgZ2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C6548466E; Thu, 11 Jun 2026 20:06:31 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DD32839A8
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 20:06:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gbrF061mwz9tgt;
 Thu, 11 Jun 2026 20:06:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781201188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=OMoRMVURHwCIP1yO2fzbC+Rz5ZYbpvw+kCWptPJ8hG0=;
 b=ms/iscf9lcf1eEQ/6/ODn7b+I4s4RjoFjVkHICaJ8+xz4/JV15csRdGjWgFi3bDmJp+t2b
 f/DjzuZhgkiMva6E0BGHHLOEVjsE13MH/wz+WhcyuQwVjE8ZmoW4MZTLqUVbhWgEE5ZJ77
 Zhug0zUxdDpD7c95kQP9iQDbErOhYQrOrGqYQyX9NJhCofE39N99yJCfF6jMn9LCj6FiZj
 26rqT3todL1IyKmWZHip5Kk6tz9KfVhQcG6j+yNGvRWO0yPe0JF252pcPf5L7jdWJHMZ6r
 l+rv45us4uC6nLV87EoSaENMDa0DVVoAHHTOMWj3mYoh7dIz6T1EiPBZm/G+0g==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781201187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=OMoRMVURHwCIP1yO2fzbC+Rz5ZYbpvw+kCWptPJ8hG0=;
 b=d/F4YgZ2EMiZx23fLt3AHIKr6548zkpVpQMbiPG07jdMbGCQY4p449GHoJj8x2v9Fii2ns
 MKPFIHYcZ31hjr5/DcYDidvmr2C0VUy6rw9ed0L2Lf9091g3iN8ZD+LvJVmEAzJsCGXFRS
 AZuHAwru/rhYNqDulXpEJrYW9FLRlsuywzJMpDDQM9QImroKhhqx9MKCyHOZFdfmRw7+76
 iw3OdLp5MFx9CzCeQpGAMYoxIeN37pMciTsjN2o7b8RBXO/J7V47t2EW82yYoAZB4aB2Eb
 wVQlwkFeZLgvkP/J6iQ0fu1UzIjOZKTcr/XrTCwFkJq8WX3Fvnie71eF/rDB/w==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hai Pham <hai.pham.ud@renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm: renesas: Make R-Car Gen5 u-boot-elf.shdr compatible with
 SDK flash_writer
Date: Thu, 11 Jun 2026 20:05:58 +0200
Message-ID: <20260611180622.145855-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: y8z6fxo63gwha1qksawt95ragnisof9q
X-MBO-RS-ID: 2f2bbe4700b9945aef7
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

The SDK 4.32 flash_writer tool, built from the SDK IPL source, requires
SREC S7 "Start address (termination)" record [1] at the end of the SREC
file that is sent to it during installation of content into storage,
otherwise the tool waits for the S7 record indefinitelly and the payload
does not get installed into storage.

Specifically, the tool considers SREC S3 and S7 records as mandatory,
S0, S5, S6 as ignored, and any other records as unsupported.

Configure srec_cat such that it explicitly generates the trailing S7
record, and also that it never generates the ignored S5 Count record.
This fixes installation of u-boot-elf.shdr using the flash_writer tool,
which can not finish successfully without the trailing S7 record.

[1] https://en.wikipedia.org/wiki/Motorola_S-record#Record_types

Fixes: 3b2ce3743c1a ("arm: renesas: Generate u-boot-elf.shdr for R-Car Gen5 RSIP")
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/mach-renesas/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-renesas/Makefile b/arch/arm/mach-renesas/Makefile
index 83c576d6007..4c8dbc465a6 100644
--- a/arch/arm/mach-renesas/Makefile
+++ b/arch/arm/mach-renesas/Makefile
@@ -50,6 +50,8 @@ quiet_cmd_srec_cat = SRECCAT $@
 quiet_cmd_srec_shdr_cat = SRECCAT $@
       cmd_srec_shdr_cat = srec_cat -output $@ -M 8 \
 			-Output_Block_Size 16 \
+			-DISable Data_Count \
+			-Execution_Start_Address 0x18400000 \
 			-generate 0x18400000 0x18400004 $(srec_cat_le_cmd) 0x00000003 4 \
 			-generate 0x18400004 0x18400008 $(srec_cat_le_cmd) 0x0 4 \
 			-generate 0x18402000 0x18402004 $(srec_cat_le_cmd) 0x6b657963 4 \
-- 
2.53.0

