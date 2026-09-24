Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28DF8C98317
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 12:36:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E93C381CEF;
	Thu, 24 Sep 2026 12:36:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WzdJDFK4aBmW; Thu, 24 Sep 2026 12:36:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org EFEFD81BF4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790253378;
	b=tCfTKr8r4BtfjnfjecCnw0vQr7QPnccff96QohvgqRZtHab64nr4h6axz8D6MaCnhfud
	 yx1ihhuADfYi4MVPZjORmlKfHCfGDis0ugqfO8au6KgxkUvf36MI3zYMJwj3V8VJ2XdFr
	 Nx0LV6UXPuPmwP74cm5VcTZiuzwvrHb/wswY5iwL8/gRZBcyhl2727hAngWBovDgbdvfg
	 MlbY90YfGjeNUASLkc6vpF7a7Nj3kPif39vrpAgNr/zpMWGA7Tu3monhhM0F5gp8rOfys
	 WbXMXynb6gYGSL0aXP6eiFrjDfQhPM5FozIre87TMtQxfMBu+mMYHUWur6iTxdBliBA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790253378;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=UI6aufYAloq76194QdAzmr7v4v7VBhdM2sF1xriJQ3I=;
	b=bUl0TIuT8SVa2aVjwQ0Qwach63NCCRxrA1etVOvDM70CdqWFVIUKQkkXyC5TQUCNO547
	 2l361iKehBgTBfUVyBOyeRDM7oHhHqDM6AJssxnulr8Et1ekh11sZ0wkJNZHgmVNxWGUx
	 qXFrsELX410I0GsrDxuOAPLf+uZV2OqSEydx3ntBxGq2wj4Jp0EI+hxxRrKSLgvly7vPC
	 u7PbhSKZXqHTqV8UH+bZeZ03JvVJvhJA6G7BqEfiyWKy3J0LxyV+GQCfViXpPZbm6luSY
	 Pj49+rKE5Sol9/VQN+s/ACtiG7sIXocCbocQh5ez2g8l4qi15MbeHP0PYB+ROfr1gSw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790253378;
	bh=UI6aufYAloq76194QdAzmr7v4v7VBhdM2sF1xriJQ3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dVu/NWaTTidMAUfDAdcJmizBun+hhauRDNT3BVdnVx7A42kIyuBuRiVh+Itd1ug89
	 s8BvbspgGmbdo3nAZq6oxeSEhXxf8iEL6JRuhsYmFsq9UyHBEoWIdtAUXvC4dvhE57
	 R/MrTHoxU/poy6YBbIA8ZBqiuMZrIwv+Hmcy1HSQuV0Ys+ERJvVxJUQAw6GFyTJjP3
	 vTrQuJtTr2zNr6oBV/mPvElLU9DzUByR73TusALl0swtrvH3KlgGwCpTDbOYoClc7y
	 nqm0YnQE9pNTnW87qLFg0rM4uAhwcK5u+JMKa1faUiakQyiGuJDSbhKZ32LTkp+3FT
	 RZ0ECRNT9Tt3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EFEFD81BF4;
	Thu, 24 Sep 2026 12:36:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4083E194
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:36:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2704440456
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:36:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hbYf9ZdKwgb5 for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 12:36:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 2A34A400FB
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790253375;
 b=NFtW1hGy3Es6wfwItUCYZxTU5mZGFUTrA+gJiDiNjBxIIL2c5vKLeBDsmEPlDhiMT0Fy
 qxIinw7l2qDu/xguPEQf2LeLBxL+bt/XFVCSsCdz0xD2p3HxV4gNXbrhHNo6BoEsnMKau
 zjEEwdQQL33SyP8bWh8CyjNRf16sXDLzCE4hNuw72YAiHejqtaJDnk+BYhAVRS+Pb7ytC
 g8FpLFgRI9p7EpgDOSi79IWIlLlJLX3CIzx0wha30HNgq7VJPZWTu8YBHZD5VPJY1Edqv
 0IWHiY+yeNUIeyvF1a8HUCZNg2kOqRBR0V6rFLj7Rl5tkcmyyZ3CdgdnGUrbiU0CGAQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790253375;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=UI6aufYAloq76194QdAzmr7v4v7VBhdM2sF1xriJQ3I=;
 b=CmD74Ak3cBtwdqbAcz/t/i5j0o4Hw7YZB/+BYb8sOAxG4tm4fJx8eZSg4hoilnDYAxy3
 rb/4ixEYydiYvvoxmN5+6zmw3+Hd9TbZ3SzjJYY6wfUdH7Sg9X2kEka9WWirkagRTTela
 zDuekiMNgwpS7nV+HTa/vpBksuAFDev5igCUgZxH81QuWbIIJFcP6UQmYWwWzoVRuozqm
 kbkzdlIslsyOPXVOnswIfKTBfMOuQIWT25zjR/T9x/txqJ8MnC4hh7MHQgJUVdKnxz7Ca
 pfHkL5AkYOfyrYdI759FUAXTa85lAglvxvmSW126J5xCnpLES7ELle5gYitEgpyI9cg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=bootlin.com; 
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=xGrT4MX5; 
 arc=none smtp.remote-ip=185.246.84.56
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.84.56;
 helo=smtpout-02.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=xGrT4MX5
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2A34A400FB
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:36:14 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id A0B151A1000;
 Thu, 24 Sep 2026 12:36:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 6805460341;
 Thu, 24 Sep 2026 12:36:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7D83F10329472; 
 Thu, 24 Sep 2026 14:36:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790253366; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=UI6aufYAloq76194QdAzmr7v4v7VBhdM2sF1xriJQ3I=;
 b=xGrT4MX5wnuS/EeQcyPBMF9m3qxaIJX/79QVsdNIRO+jbW+U0lQqjYOqv02VaqITLXng7t
 EXd9XA6MdBW8K+GJ7ZxxR8Nv0IzYw0hjBsmF/ltCRawRIn1c7B/1bbtZtUoj+6ejc49Eip
 hLXAzfT7aJZehWy1LNP11twCID4wIa3DDfs3Nid2WWXqQDLT1iJ/CQGrP9xCmIHXkQvGCR
 33DtESIw4if6HGC5qqVXIROrr93Tu5+inwj+fkwLlYPDh3vw8cdcZUSMU340P+tkfj0W6k
 AA8U8FdHRTmF24xMwZcM0Pn4TduJzRkgUUC6JyRn/zaqZdckkckLJg5r4P7LUw==
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
Subject: [PATCH v6 04/22] arm: mach-k3: security: introduce
 ti_secure_skip_cert()
Date: Thu, 24 Sep 2026 14:35:15 +0200
Message-ID: <20260924123533.2599438-5-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924123533.2599438-1-richard.genoud@bootlin.com>
References: <20260924123533.2599438-1-richard.genoud@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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
-- 
2.55.0

