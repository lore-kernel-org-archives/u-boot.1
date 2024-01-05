Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83212C3DA6E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jan 2024 14:09:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C76F4879A3;
	Fri,  5 Jan 2024 15:09:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=prolan.hu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=prolan.hu header.i=@prolan.hu header.b="VyvFo703";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B40A876A4; Fri,  5 Jan 2024 15:08:20 +0100 (CET)
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F82F8798C
 for <u-boot@lists.denx.de>; Fri,  5 Jan 2024 15:08:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=prolan.hu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Csokas.Bence@prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain
 [127.0.0.1])
 by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id E2621A140D;
 Fri,  5 Jan 2024 15:08:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :from:from:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=mail; bh=dXrSakn14+Fvy9DnjUOS
 tVo1Uh3+m/ce2pvpcs1/t6A=; b=VyvFo7030e6g0FsLE2D/nlyTVd+ToFJ5Avka
 cQGK+qy0iJWZ6fdfOgY0zoT6lkeV6eTMw0tHIu0GEZborDAl40EHmufkKv3c7zB0
 Qi+zPik6e8POj+JauEV3/3ITTf0EVP/7/Apxp/hX1Zx8RsguaCua0e1IBbd8n2QL
 akNtgpYvxDJVRvmTDv5O96aQBbXuQQvUKvxyxLHdOMuJ/bnrItSjpQW6xR84VV0c
 UemoaIwLegTvFMkHXuzPKC7V1GCAZdB3njOq+qNdw1jMzfEc8Fzg7Ybg4HspLIlM
 Sc0TKUor4a3A6JGrFVdljRTNH+pMT8OVuCSsN9A1EJG8ZD+Mfm/hHIFWEGn4jqJO
 O+OKEIT1qZM/wFNzKWDrWSk/OmeWsXIxY1EC/KUB+aQpj6m06yhB9GT9JNLs07mu
 SQ82iFFSXmPyIk0Mo4sbvJI3TEjb3UGt9SKleabZ9g7+TNu2xhM703o2uy4rAZka
 gNNNUvBM5ZcvGuBfbqY95fLfsVLdaotbQE7xXphPx/a/yQpZODRJtPd891JR2x7O
 ZtjV2fZe1ArDWiHHKKq3KoEAD5VvSp4GAv6MjkfSn6obS58kCZwG5wDCA+MyxFe1
 zmpMn5kymNbQSJz8i616Zrt0OX+BzewLL1aAl++HySNXWdKAcWU9KzfkVaSJA5EB
 2E4zWXg=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?= <csokas.bence@prolan.hu>
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Ayoub Zaki <ayoub.zaki@embetrix.com>,
 =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?= <csokas.bence@prolan.hu>
Subject: [PATCH 2/2] lib: rsa: Allow legacy URI specification without "pkcs11:"
Date: Fri, 5 Jan 2024 15:08:04 +0100
Message-ID: <20240105140804.14383-2-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240105140804.14383-1-csokas.bence@prolan.hu>
References: <20240105140804.14383-1-csokas.bence@prolan.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK; S=0; OP=CALC; TIME=1704463697; VERSION=7966; MC=496457010;
 ID=385190; TRN=0; CRV=0; IPC=; SP=0; SIPS=0; PI=3; F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29CE703B55657D66
X-Mailman-Approved-At: Fri, 05 Jan 2024 15:09:19 +0100
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

But emit a warning for it. Then we can remove support when
everyone had time to update their scripts, docs, CI etc.

Fixes: ece85cc020 rsa: use pkcs11 uri as defined in rfc7512

Signed-off-by: Csókás Bence <csokas.bence@prolan.hu>
---
 lib/rsa/rsa-sign.c | 42 ++++++++++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/lib/rsa/rsa-sign.c b/lib/rsa/rsa-sign.c
index fd587d8deb..2304030e32 100644
--- a/lib/rsa/rsa-sign.c
+++ b/lib/rsa/rsa-sign.c
@@ -104,6 +104,8 @@ static int rsa_engine_get_pub_key(const char *keydir, const char *name,
 	const char *engine_id;
 	char key_id[1024];
 	EVP_PKEY *key = NULL;
+	const char *const pkcs11_schema = "pkcs11:";
+	const char *pkcs11_uri_prepend = "";
 
 	if (!evpp)
 		return -EINVAL;
@@ -113,19 +115,26 @@ static int rsa_engine_get_pub_key(const char *keydir, const char *name,
 	engine_id = ENGINE_get_id(engine);
 
 	if (engine_id && !strcmp(engine_id, "pkcs11")) {
-		if (keydir)
+		if (keydir) {
+			// Check for legacy keydir spec and prepend
+			if (strncmp(pkcs11_schema, keydir, strlen(pkcs11_schema))) {
+				pkcs11_uri_prepend = pkcs11_schema;
+				fprintf(stderr, "WARNING: Legacy URI specified. Please add '%s'.\n", pkcs11_schema);
+			}
+
 			if (strstr(keydir, "object="))
 				snprintf(key_id, sizeof(key_id),
-					 "%s;type=public",
-					 keydir);
+					 "%s%s;type=public",
+					 pkcs11_uri_prepend, keydir);
 			else
 				snprintf(key_id, sizeof(key_id),
-					 "%s;object=%s;type=public",
-					 keydir, name);
-		else
+					 "%s%s;object=%s;type=public",
+					 pkcs11_uri_prepend, keydir, name);
+		} else {
 			snprintf(key_id, sizeof(key_id),
 				 "pkcs11:object=%s;type=public",
 				 name);
+		}
 	} else if (engine_id) {
 		if (keydir)
 			snprintf(key_id, sizeof(key_id),
@@ -224,6 +233,8 @@ static int rsa_engine_get_priv_key(const char *keydir, const char *name,
 	const char *engine_id;
 	char key_id[1024];
 	EVP_PKEY *key = NULL;
+	const char *const pkcs11_schema = "pkcs11:";
+	const char *pkcs11_uri_prepend = "";
 
 	if (!evpp)
 		return -EINVAL;
@@ -235,19 +246,26 @@ static int rsa_engine_get_priv_key(const char *keydir, const char *name,
 			fprintf(stderr, "Please use 'keydir' with PKCS11\n");
 			return -EINVAL;
 		}
-		if (keydir)
+		if (keydir) {
+			// Check for legacy keydir spec and prepend
+			if (strncmp(pkcs11_schema, keydir, strlen(pkcs11_schema))) {
+				pkcs11_uri_prepend = pkcs11_schema;
+				fprintf(stderr, "WARNING: Legacy URI specified. Please add '%s'.\n", pkcs11_schema);
+			}
+
 			if (strstr(keydir, "object="))
 				snprintf(key_id, sizeof(key_id),
-					 "%s;type=private",
-					 keydir);
+					 "%s%s;type=private",
+					 pkcs11_uri_prepend, keydir);
 			else
 				snprintf(key_id, sizeof(key_id),
-					 "%s;object=%s;type=private",
-					 keydir, name);
-		else
+					 "%s%s;object=%s;type=private",
+					 pkcs11_uri_prepend, keydir, name);
+		} else {
 			snprintf(key_id, sizeof(key_id),
 				 "pkcs11:object=%s;type=private",
 				 name);
+		}
 	} else if (engine_id) {
 		if (keydir && name)
 			snprintf(key_id, sizeof(key_id),
-- 
2.25.1


