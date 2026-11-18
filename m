Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AAB606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 13:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=r8DaTFOF;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=R9NGVd/L
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D377840A00;
	Wed, 18 Nov 2026 13:18:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PNliAAg6sNr0; Wed, 18 Nov 2026 13:18:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 14553409ED
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795007912;
	b=sitOG/ZZwrpHJG5kV/t3k+MFt3cBByDK+tVWHD8pRUkSGDQf7eONB9GxIZxn7jicQLTk
	 tPJOtb76cUptGSP/RCXh6xJA0a4Jt1beJ/IPg1iX3nmFcjAITxpubP3lH45lRWJX3Jovo
	 xMnie1MCXohhe3bONnn9wXGKy50bszpAANV6nohpbsmQbnXGWH+C2tZNUfPbwAAc9oAG0
	 jFPnb74HTFEwqbwA1wgFWGqPIjzC5U7PaaaDa0+wNNaaYRDGkocX4WmzzlpwYumicQd2L
	 3y3oo6tBRI3MBrwN9Mm5Hy/FYnSm9uT1f1iwwwVTzt+X9ow80duSK54xVZK7bcI9rGw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795007912;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Od7ymGlHGUpV5elM49ANTGlHRHfWDnFMUNoq+JFSx40=;
	b=mSM+fSguprnGue8LJrmhhMWmz+bPupMfyP8/sHad+4Cb7dq4oDwoqyzzU3KQ/0FkL+pn
	 dTZacuriCac5pxsuTxPi0hH4MbHyQQ1RgmdCJ8FrDE1QU9gU2cPF9AA5S9sZB1f4YzcVE
	 d6RFaCfhBgzvzZaKnxDuUY4Iq7GvS15ksF2Yl/h2T0zRbAqUdWcsiNYp8X3KxmNql8UUU
	 +UaY1C4cUQJTb5HJLTk3LOJ9qzs1MCRsQazzF+jqcVUjN9gAG9IV8oJ2kiyeoZcjSU7L0
	 HCJb+4K2SbGp6eqgV9+1CTbUoP52LIjaFSPe1lbXvX3izTW9e0L3aR9u38kdChPPRqw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="R9NGVd/L";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795007912;
	bh=Od7ymGlHGUpV5elM49ANTGlHRHfWDnFMUNoq+JFSx40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r8DaTFOFD6FODRnAeWlN+s7sCATkmAXfkGLfLrSgP7ItB6/JG219+hfus+hhSzzpx
	 D47FifQmjxkPXQqMa2KsTW0oFvORz6irMx+qSTzwUj2iTFeDeeNLuy5G0gkuxnpANM
	 VB7nr8Rc6mBUSsSBSxXv5ZpeyGtprn2rNetgRObwANJWK+NcYkxbQm6GA9GEFUUTJG
	 +q2cpx3S4ICD9kYt4cSTXhz0ZTIZmAzMkwBWvEDyXvezoOx7J/SXc6nLnmTiOtw+45
	 +/XH2qZuW0PFdgCQSkZy+gnwFoJjICAENuoupHzatC5yqp/7M8LzUAlvRgbN+k/k8/
	 HTpKEwXxf3UnA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 14553409ED;
	Wed, 18 Nov 2026 13:18:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 22C8770B
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:18:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 20662409E3
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:18:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WqvbdAgV1xYx for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 13:18:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A0B99409B2
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=185.246.85.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=R9NGVd/L
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A0B99409B2
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:18:27 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 297554E4162A;
 Wed, 18 Nov 2026 13:18:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id E5DF95FE9B;
 Wed, 18 Nov 2026 13:18:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1C83B11BC1443; Wed, 18 Nov 2026 14:18:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795007904; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=Od7ymGlHGUpV5elM49ANTGlHRHfWDnFMUNoq+JFSx40=;
 b=R9NGVd/LWp5uyFQgIZuVAfrGM1+MVCctqRmjS5Cn/AI8bhNoXEYZUJ2gRDnuUac+VVy1ay
 /ZvGehnjhDgO/SmS+Ze9Hve4GiDyIN+GDxW5ABoArZEHjTi2UmXMqc/QKpUftwiRXONRRk
 MfgZqsz0DpUbPGC+us7XxMvHoEqNksjOi439j1FxT7i0QNvEVZ97/vgy6R/SLxRNrTsnpz
 t5KkyRDUHcqn/mV4xx0l4QZdUKBZw1N1THzXJHBKCq0RoegyoFHQrd44ZsmaUoPJY+0j+n
 Ah0b+R8TxKsDtboZ+GjLClKVX88nP7xPcS0F2flobCdGSkRxhVOV4LBz1rgbKg==
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
Subject: [PATCH v7 02/20] arm: mach-k3: security: introduce
 ti_secure_skip_cert()
Date: Wed, 18 Nov 2026 14:17:49 +0100
Message-ID: <20261118131807.135859-3-richard.genoud@bootlin.com>
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

ti_secure_image_check_binary() skips the signing certificate prepended
to an image when it is loaded on a GP device, so that the actual
payload can be processed.

This functionality will also be used in resume_to_dm_f() to skip the
certificate once it has been authenticated.

So, factorize that in ti_secure_skip_cert().

No functional change intended.

Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
---
 arch/arm/mach-k3/include/mach/security.h |  1 +
 arch/arm/mach-k3/security.c              | 46 +++++++++++++-----------
 2 files changed, 27 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-k3/include/mach/security.h b/arch/arm/mach-k3/include/mach/security.h
index fa90fed7c427..3750265a845f 100644
--- a/arch/arm/mach-k3/include/mach/security.h
+++ b/arch/arm/mach-k3/include/mach/security.h
@@ -10,3 +10,4 @@
 
 void ti_secure_image_post_process(void **p_image, size_t *p_size);
 void ti_secure_image_auth_apply_fwls(void **p_image, size_t image_size);
+void ti_secure_skip_cert(void **p_image, size_t *p_size);
diff --git a/arch/arm/mach-k3/security.c b/arch/arm/mach-k3/security.c
index 2df922a2fa27..f87fe6ec44e2 100644
--- a/arch/arm/mach-k3/security.c
+++ b/arch/arm/mach-k3/security.c
@@ -37,10 +37,33 @@ static size_t ti_secure_cert_length(void *p_image)
 	return seq_length + 4;
 }
 
+void ti_secure_skip_cert(void **p_image, size_t *p_size)
+{
+	size_t cert_length;
+	u32 device_type = get_device_type();
+
+	if (ti_secure_cert_detected(*p_image)) {
+		if (device_type == K3_DEVICE_TYPE_GP)
+			debug("Warning: Detected image signing certificate on GP device. "
+			      "Skipping certificate to prevent boot failure. "
+			      "This will fail if the image was also encrypted\n");
+
+		cert_length = ti_secure_cert_length(*p_image);
+		if (cert_length > *p_size) {
+			printf("Invalid signing certificate size\n");
+			return;
+		}
+
+		if (device_type == K3_DEVICE_TYPE_GP)
+			printf("Skipping authentication on GP device\n");
+		*p_image += cert_length;
+		*p_size -= cert_length;
+	}
+}
+
 void ti_secure_image_check_binary(void **p_image, size_t *p_size)
 {
 	u32 image_size;
-	size_t cert_length;
 	image_size = *p_size;
 
 	if (!image_size) {
@@ -48,25 +71,8 @@ void ti_secure_image_check_binary(void **p_image, size_t *p_size)
 		return;
 	}
 
-	if (get_device_type() == K3_DEVICE_TYPE_GP) {
-		if (ti_secure_cert_detected(*p_image)) {
-			debug("Warning: Detected image signing certificate on GP device. "
-			       "Skipping certificate to prevent boot failure. "
-			       "This will fail if the image was also encrypted\n");
-
-			cert_length = ti_secure_cert_length(*p_image);
-			if (cert_length > *p_size) {
-				printf("Invalid signing certificate size\n");
-				return;
-			}
-
-			printf("Skipping authentication on GP device\n");
-			*p_image += cert_length;
-			*p_size -= cert_length;
-		}
-
-		return;
-	}
+	if (get_device_type() == K3_DEVICE_TYPE_GP)
+		ti_secure_skip_cert(p_image, p_size);
 }
 
 void ti_secure_image_post_process(void **p_image, size_t *p_size)
