Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A3FC83F11
	for <u-boot@archiver.kernel.org>; Sat, 26 Aug 2023 12:20:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 591E68556F;
	Sat, 26 Aug 2023 14:20:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=embetrix.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=embetrix.com header.i=@embetrix.com header.b="CfRA0clc";
	dkim=permerror (0-bit key) header.d=embetrix.com header.i=@embetrix.com header.b="U+lszQSz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF8CB86B19; Sat, 26 Aug 2023 13:53:35 +0200 (CEST)
Received: from mailrelay4-3.pub.mailoutpod2-cph3.one.com
 (mailrelay4-3.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:503::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EC87869CD
 for <u-boot@lists.denx.de>; Sat, 26 Aug 2023 13:53:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=embetrix.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=ayoub.zaki@embetrix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=embetrix.com; s=rsa2;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 from; bh=fOYmBDvDXKwoRgp8qHW1XqedBPVbNHoDNuuzcm0YHAM=;
 b=CfRA0clcXaEQyL9qcJzpsOwfZ5T10WZeqIrUFcRzrSME3FEXVLX6vrn8H4WaSs/eXunbhz07NaArP
 QZgQaBG5pJkVC967WdHqH6D0FQ9kaUFYwfgK2i90k+1BazUjjwJ9pzk57FL0b9tAkaM5OAvYvsaV33
 V+NRF23er9zb0cvnoNejytajlMvOhAP1q3hniWhaxBL+o7bnyEKEb0Le9hBUzY0be/VCZ5al2xrf+p
 CtJcQ/j9M8dqmN9ApR/TScp1bG58gKy5YSyMmMXEKnZo7+x3z8syeRqCBiSBmFfNp0J4MFR5ebU9uI
 futRjxBpX1C2hXOKjaXGZxtOIaFx5yQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=embetrix.com; s=ed2;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 from; bh=fOYmBDvDXKwoRgp8qHW1XqedBPVbNHoDNuuzcm0YHAM=;
 b=U+lszQSzQN2H8aNXK0GI7VoInUVUZtnJydl0gU4UMzuUThcwI0XrJC+8p6zLr5MZqWWOj6gc7jGWK
 Vc8uOkHDQ==
X-HalOne-ID: 2cecf377-4407-11ee-836d-592bb1efe9dc
Received: from xps13.fritz.box
 (dynamic-2a02-3102-8c10-00a0-e742-45ac-de8f-0cbb.310.pool.telefonica.de
 [2a02:3102:8c10:a0:e742:45ac:de8f:cbb])
 by mailrelay4 (Halon) with ESMTPSA
 id 2cecf377-4407-11ee-836d-592bb1efe9dc;
 Sat, 26 Aug 2023 11:53:31 +0000 (UTC)
From: Ayoub Zaki <ayoub.zaki@embetrix.com>
To: u-boot@lists.denx.de
Cc: Ayoub Zaki <ayoub.zaki@embetrix.com>
Subject: [PATCH] rsa: use pkcs11 uri as defined in rfc7512
Date: Sat, 26 Aug 2023 13:53:29 +0200
Message-Id: <20230826115329.12938-1-ayoub.zaki@embetrix.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 26 Aug 2023 14:20:38 +0200
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

pkcs11 : change engine uri to use full pk11-URI as defined in:

https://www.rfc-editor.org/rfc/rfc7512.html
Signed-off-by: Ayoub Zaki <ayoub.zaki@embetrix.com>
---
 doc/uImage.FIT/signature.txt |  2 +-
 lib/rsa/rsa-sign.c           | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/doc/uImage.FIT/signature.txt b/doc/uImage.FIT/signature.txt
index c71280b63b..2ff0db3f98 100644
--- a/doc/uImage.FIT/signature.txt
+++ b/doc/uImage.FIT/signature.txt
@@ -681,7 +681,7 @@ $ ./tools/mkimage -f fit-image.its fitImage
 Sign the fitImage with the hardware key:
 
 $ ./tools/mkimage -F -k \
-"model=PKCS%2315%20emulated;manufacturer=ZeitControl;serial=000xxxxxxxxx;token=OpenPGP%20card%20%28User%20PIN%20%28sig%29%29" \
+"pkcs11:model=PKCS%2315%20emulated;manufacturer=ZeitControl;serial=000xxxxxxxxx;token=OpenPGP%20card%20%28User%20PIN%20%28sig%29%29" \
 -K u-boot.dtb -N pkcs11 -r fitImage
 
 
diff --git a/lib/rsa/rsa-sign.c b/lib/rsa/rsa-sign.c
index d20bdb58a5..7ae163f264 100644
--- a/lib/rsa/rsa-sign.c
+++ b/lib/rsa/rsa-sign.c
@@ -116,15 +116,15 @@ static int rsa_engine_get_pub_key(const char *keydir, const char *name,
 		if (keydir)
 			if (strstr(keydir, "object="))
 				snprintf(key_id, sizeof(key_id),
-					 "pkcs11:%s;type=public",
+					 "%s;type=public",
 					 keydir);
 			else
 				snprintf(key_id, sizeof(key_id),
-					 "pkcs11:%s;object=%s;type=public",
+					 "%s;object=%s;type=public",
 					 keydir, name);
 		else
 			snprintf(key_id, sizeof(key_id),
-				 "pkcs11:object=%s;type=public",
+				 "object=%s;type=public",
 				 name);
 	} else if (engine_id) {
 		if (keydir)
@@ -238,15 +238,15 @@ static int rsa_engine_get_priv_key(const char *keydir, const char *name,
 		if (keydir)
 			if (strstr(keydir, "object="))
 				snprintf(key_id, sizeof(key_id),
-					 "pkcs11:%s;type=private",
+					 "%s;type=private",
 					 keydir);
 			else
 				snprintf(key_id, sizeof(key_id),
-					 "pkcs11:%s;object=%s;type=private",
+					 "%s;object=%s;type=private",
 					 keydir, name);
 		else
 			snprintf(key_id, sizeof(key_id),
-				 "pkcs11:object=%s;type=private",
+				 "object=%s;type=private",
 				 name);
 	} else if (engine_id) {
 		if (keydir && name)
-- 
2.34.1

