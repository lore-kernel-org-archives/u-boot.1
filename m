Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD8F606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 13:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=VeyDh1Cl;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=X4x4RvSz
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5BF8881208;
	Wed, 18 Nov 2026 13:19:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SpZzULIfaPlq; Wed, 18 Nov 2026 13:19:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8DF0281163
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795007954;
	b=J29oQNADoAQ5qN4P+9HKJDzBNkWw+emikCj8ao+uhPi4ptq2YOhAw8xSFboaxRJut1LQ
	 QJoAWQDlYDFC9tlW5FEtik85xCY0NhB8qMp96JD7pgNGX4T+O2SMJiDNfqFdB9/I9HJi7
	 ebafflCOFLEMZeRDQOUv+4EkGailBtan9vyZYNoFcVQJfPW70g+Jcl1sBB5NE7aCQYuZO
	 PnvHl5asb0VhuG82VQImFcuVkl7AMnSxprvWaLXN8z7CS4KNaYERGf7pYr9ArlNW2F63r
	 LU8US0MzWbuBnGfa26Fl+8yJV4cOvTHBKQlWSKcpWU0Efj0pie9tVIPPYyAR9rpCeTQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795007954;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=sH3W9c0hZy1J3igL/gUPHb55DL4d/oubqgWtZCLpS/8=;
	b=i4IEZ4gAuYnfB90F9b2R6l78lGxEAY+PYIs89lC68Pv9jN6xO1vGHXM7ASQcM9twtnYG
	 UVAdzfkNHu8favEyIMG3Q9hS4JhphzhyHVI9lFCLjd736C9H4qnjRbpSThSK5UCftcVr+
	 8vtoFvZiUEBA4hi6Vz99nhIsYvoHCnMY9k3zJw4iM7l3IfHA243fMDjA24wKuaylhVUGw
	 p0rZcy5stoeP4xpE/NhTyM9ktQeB2vDdWBAoUqRHAHpFc0OUJQw7rpHsuL3RYmqKPF0QA
	 XHCRY1dJJmOT0oQb7OHXHTmhEXlAAsi649atvXA22VoNVa/ZX90i5EVEKDKVflaMnDQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=X4x4RvSz;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795007954;
	bh=sH3W9c0hZy1J3igL/gUPHb55DL4d/oubqgWtZCLpS/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VeyDh1ClUp36nLifvwLzOHRX2+fk3eFxndY7fX/w4gquZAIepEtcU9fibQAb8eZyO
	 XW7Zj4c88c5Eg4xqqYpaPH8BuGZs7ezWitD2VLUW+vCzoIGa5A8pS5THa4LfTemY51
	 fP9j2ZIcBnvNrDGqyjdyba5zuzwbZCVq5l+25xIso9kuyQABRsbLDBmNtIAE7P/b4v
	 EgZ2dsDBBQyaaq7gWM+jpDaCoRaaix2hNQlp8paJgOSJEwWj7BXdWoqQqkbBIrakTZ
	 7VLXe/wBZqHYGdV1X7XJszm91a6EQxuYCpiXbnioLJ2nnA7ZX/KEaPOxoaH1BZN2Pm
	 00fRAb00a3Fyg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8DF0281163;
	Wed, 18 Nov 2026 13:19:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6DC95977
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:19:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5F5C181235
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:19:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UVlktAKYdOAi for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 13:19:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6BAFD81275
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=185.246.84.56
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.84.56;
 helo=smtpout-02.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=X4x4RvSz
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6BAFD81275
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:19:08 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 6B8E81A16D0;
 Wed, 18 Nov 2026 13:19:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 32BBD5FE9B;
 Wed, 18 Nov 2026 13:19:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4DB0F11BC1FBE; Wed, 18 Nov 2026 14:19:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795007946; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=sH3W9c0hZy1J3igL/gUPHb55DL4d/oubqgWtZCLpS/8=;
 b=X4x4RvSzAfkKDPjtzf7TA1QawbHGcTotboSuP5JvjOPA8wfggSVeWhAEHEqa3z+zdUgGWN
 yV5GaAxbHZc4fz1D0h9ww9IZwhdajrkFYepLYkxYD1K6g4Qm6wcNGpxLAkwZdtcEoLoMTL
 ikYn4Pt5por6HnuLPJg1JLkYJlKOJ+4ZYHmG+ACIJXfDfzibvqX5LA4c5CvaLYoXndEool
 7rYdQTKzIi/GrbenX3eaaVPDNxlIDEndQ7gXgXzlk+t9nq8utwbo3V2JEHYJ9GJ9Nx5D9k
 X9gNzViFE+IJ6imYuNlVjQVFB4YSBMCxJAVciDa2YC7R8/b/plWYIT5XZk1OmA==
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
Subject: [PATCH v7 15/20] arm: mach-k3: j722s: Enable LPM resume flow
Date: Wed, 18 Nov 2026 14:18:02 +0100
Message-ID: <20261118131807.135859-16-richard.genoud@bootlin.com>
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add support for resuming from suspend in board_init_f for J722S.
The resume state of the SOC is identified and lpm resume
sequence is followed accordingly:

First, set LPM core bus path and compatible needed by extract_lpm_region
to find lpm-metadata memory region (at boot and at resume time)

Then:
   - Extract context address from devicetree
   - Power on the rproc cluster power domain.
   - Ask TIFS to authenticate the certificates attached to saved images
     of ATF, OPTEE and DM and apply the firewalls in it.
   - Send the context address to TIFS.
   - Ask TIFS to firewall the context address area.
   - Ask TIFS to decrypt and restore TFA.
   - Ask TIFS to resume TFA.
   - Power on the rproc power domain.
   - Jump to DM firmware.
(All those steps are done in do_resume())

Moreover, ctrl_mmr_unlock() needs to be called again after the TIFS
version message, otherwise the pmic calls in j7xx_board_is_resuming()
are failling.
Just moving ctrl_mmr_unlock() is not enough, since in this case, TFA
fails to start on J722S HS-FS device.

Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
---
 arch/arm/mach-k3/j722s/j722s_init.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/mach-k3/j722s/j722s_init.c b/arch/arm/mach-k3/j722s/j722s_init.c
index 1180c75f551d..99517fe0a29c 100644
--- a/arch/arm/mach-k3/j722s/j722s_init.c
+++ b/arch/arm/mach-k3/j722s/j722s_init.c
@@ -14,6 +14,7 @@
 
 #include "../sysfw-loader.h"
 #include "../common.h"
+#include "../lpm-common.h"
 
 struct fwl_data cbass_main_fwls[] = {
 	{ "FSS_DAT_REG3", 7, 8 },
@@ -151,6 +152,8 @@ static void k3_spl_init(void)
 	/* Output System Firmware version info */
 	k3_sysfw_print_ver();
 
+	ctrl_mmr_unlock();
+
 	/* Output DM Firmware version info */
 	if (IS_ENABLED(CONFIG_ARM64))
 		k3_dm_print_ver();
@@ -165,6 +168,8 @@ static void k3_mem_init(void)
 		ret = uclass_get_device(UCLASS_RAM, 0, &dev);
 		if (ret)
 			panic("DRAM init failed: %d\n", ret);
+		k3_set_lpm_core_bus_node_path("/bus@f0000/bus@b00000");
+		k3_set_lpm_core_compatible("ti,am62-r5f");
 	}
 
 	spl_enable_cache();
@@ -186,6 +191,9 @@ void board_init_f(ulong dummy)
 
 	k3_spl_init();
 	k3_mem_init();
+	if (j7xx_board_is_resuming())
+		do_resume(); /* no return */
+
 	setup_qos();
 
 	if (IS_ENABLED(CONFIG_ESM_K3)) {
