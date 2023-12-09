Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9415EC4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 17:05:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1C8E8758F;
	Sat,  9 Dec 2023 18:05:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="BqQneH0+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5084875A4; Sat,  9 Dec 2023 18:05:46 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95C528709C
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 18:05:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 3FB1E3F27E; 
 Sat,  9 Dec 2023 17:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1702141543;
 bh=6L/8hmFLdAL/8jSk3T/yrsHz1ddbiXVVMUnVCjNOvXU=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=BqQneH0+JEHsTxw3/5x2UcPeZXsyeKabqlZfuT/+dl6J4TBU+/aBpNpcs57LVxLWQ
 n8FEBPuY4bKfFdN62oRnFgrXCfkdYtkQlplievAzyCkm277EiqNmsxgRjLQ8yqCXRE
 K0257T2Wdr1IjcgiY5qN/anEQ+PxLKAxKt6rW8l7DqmKkvcaCD8MAHd7QYoUT/xnrV
 Kz3DKiA3HImM7UZRySV5h48xxxKBE2ePw4dYSLVAxWFiNLPga6U3Ph8ktuCH2vp5/W
 WIcjIH4yd0jOdbT3bQDU/RUmCUi08Cb9gjzQTyd1F1Y1QhMS0n+GRb6XP2bDYsnjx0
 X6xPi6FouFCVQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] cmd: check argc for acpi dump
Date: Sat,  9 Dec 2023 18:05:36 +0100
Message-Id: <20231209170536.104700-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
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

'acpi dump' without parameter results in a NULL dereference. Check the
number of arguments.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/acpi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/cmd/acpi.c b/cmd/acpi.c
index 89970417a0..0c14409242 100644
--- a/cmd/acpi.c
+++ b/cmd/acpi.c
@@ -160,6 +160,9 @@ static int do_acpi_dump(struct cmd_tbl *cmdtp, int flag, int argc,
 	char sig[ACPI_NAME_LEN];
 	int ret;
 
+	if (argc < 2)
+		return CMD_RET_USAGE;
+
 	name = argv[1];
 	if (strlen(name) != ACPI_NAME_LEN) {
 		printf("Table name '%s' must be four characters\n", name);
-- 
2.40.1

