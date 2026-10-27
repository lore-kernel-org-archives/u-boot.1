Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4152760A383B
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 23:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=X3fypVfA;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=EMh4a8vn
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 244D7405A1;
	Tue, 27 Oct 2026 23:16:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hCUSdFAnKtI9; Tue, 27 Oct 2026 23:16:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 99E6840596
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793142962;
	b=NPht2pppM3by6lvqRppEJuNJaHBKbcKqXXv39OH+ACHUbpTiEZm+Lqg9v0KIkiMDkvM/
	 FoJGxRSLKvPgAxs2FKkd2ijn7rjZKr4QfAdMPkE6Xy9YpnaHBVDahjsbIM/1t0qdDw1og
	 pzsY4ZRuS+yA9KEMt+Ee6VZM80begmRLJicEJ9n/djyw472HnWE0l4HsQ/jvOPlE2zraj
	 NSajokDSL7mP1VBwjrEjEZbVELSgjybu6oMvTkm1WQDkfeSGMdDC6V88lEBCAZzyrF2e4
	 o7MQWGBjJJJjzqUUU+pCPezJGT2Oclwvu5iRpJy6nlV87yJhIpBEkhmlI3Z8l9pkc8w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793142962;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=mehCsCtqIXWJjKjBmK8rHER39lnen1dFL6N3vYP9pt4=;
	b=pXzbSeBK9O0obD3s5s77Z7WerpdpvVZkruxPhnxBrX+G1pO16kyAuqsPQCD17n5AXNni
	 dwLCuGrkhDjyZxQyv1xqLTw58xPlCoR2l7Fc7POOWV1f32rjToAunzsKOp2+ruUw+8SbU
	 ZtHE5P+sbxdq/H5HWqKOENK25dlqen/nBV3usebEkxSnbQlW4Ywtr2Mo9EOgk/aZMIwT/
	 pI5UtujeGcopXGQGnDOdT+ZRqJCpd68uQ6nHBglwgm413L/wAk7nRG/f3YK38MroB8CHA
	 Cy0KpzYg8ikXH3Zngwhow0NlaKq/ZQ0wRSvwuvC3qVvZrFnId9hfKEakttKlYBxebuA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793142962;
	bh=mehCsCtqIXWJjKjBmK8rHER39lnen1dFL6N3vYP9pt4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=X3fypVfAyNir+f+agqxX/NL0kCU/QG2RnZ9OvYQB5r3yfE3i+cfQw3jE0C3HYpbhI
	 jfGBpeOKYFz+0BktRAy/+46nbVkBJcV0b/LaA8suFAVkAvAgAINgCx+oawghhNCszG
	 S0E35mYnnzMMBw2/kn0xmavjFZhtSG9JsdY6wtZxiLkoLDRFYa20i//eXsR+DteW5j
	 M+/wYOOFbK/YtOCwWIANW7AnrL3wFcNCuJN2BYiG/x4c8z2tWfs26OMfgpPMBzyMVd
	 r2uR+e+2WlLCVm9tIDQz5FwsnBGNrNtwOqOfOOI1t8Kg6NLEASX9bZ52NSvamuJPlp
	 5mZlMbnaV7Rqg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 99E6840596;
	Tue, 27 Oct 2026 23:16:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C60C92E5
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 23:16:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AC3E560653
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 23:16:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ocU-Iwfhu0FJ for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 23:16:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4FFEA6060B
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=80.241.56.152
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793142960;
 b=NVYRKubONi3QiFfizTRrLGDWo1mwjKNN0mB0pF/UTtu8WQJM7yCvREWVsh0ZOK9/28r2
 JKKIqKWAUEeB27VGqQfFFFNIxgm09k60GRna1P2Oa9rdQx0E7uX6M9Mx5H7SU5f9sXxA1
 569PTmkXC7rOTBAHtpV0e4oP55z87jIy2v2FbhX3jvyrbQ3IFJmORXSk0nNI9VRwb3JIs
 bV5DOeRs3baBpO5JeJ5o0WtA3FgTOA0spZS6PPFjqX/VW4hkbqdAlR9lAPOFOXp/zCAzp
 +qqZSB0upyBlqBO5bMLfpRV1MoUQyLvQ3wy7ZKlitsZKePLB1DdATEvcpsfjgfvvkKQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793142960;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-MBO-RS-ID:X-MBO-RS-META;
 bh=mehCsCtqIXWJjKjBmK8rHER39lnen1dFL6N3vYP9pt4=;
 b=RhMoz30B6Q29WBFhwA49AmPcs8Wfx7mIAOGQAL4eYnPITGgl93KqpSaUpBgkbm66Kg3T
 65HaKU1vCeIoqutS54FpQb5sraw134+jyGOKQDEAk+ExrhGg6iazCVNXac5/QG4XuVFNu
 hvBukIyuNWxnj/ANzHLULzDI2KXHrjvPAcUqnrW/RFieMuN1lYgcT7hNWwVHCAo7+pP0S
 Fv77I88rWsxy8SWw+NQ0u5HIFDt3LzvXfoEUyk1tou6vPTW625awRRiSE65FVk87sn82T
 IfDj4vGOAmzvrmpDFcOnYaG1WA/cc0Pu3/OYeOq2++BJszCRk8dU06nWp8//yXKldrw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=EMh4a8vn; 
 arc=none smtp.remote-ip=80.241.56.152
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.152;
 helo=mout-p-102.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=EMh4a8vn
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4FFEA6060B
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 23:15:59 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jDmZN3jnMzKnBM;
 Wed, 28 Oct 2026 00:15:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1793142956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=mehCsCtqIXWJjKjBmK8rHER39lnen1dFL6N3vYP9pt4=;
 b=EMh4a8vnUa4Bn5aAMcOpkPU5odk7+KoebFQtK0xvQ9KybqHKrWGCD+I9xzwvFK+s9h+DeU
 MRyA67Or1NIGO+HxarRCqGvOUWgOGnTheBap3PtxxwMOEGrVb5+hmxvMa08xcw5gWdwFej
 P/Bzntfya476aZQmLn8uUKY8XnncsecG2DDxQt+7lSzQjo0xZcVZT6qfhkpnwc2PhJvT8R
 ivLoSYegzUK5AV5UAmWkG95YW1nHFTZ6ATbX/YC2kWXR7atjqAoh032QQg5C7kUF2VQPgd
 tbjPinv2Q/xlZ9iOmHAnRTw+fDsSohh0gFhTVHSiaCNbiT+QgAsTtrdnS8sCKg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Aristo Chen <aristo.chen@canonical.com>,
 Daniel Golle <daniel@makrotopia.org>,
 James Hilliard <james.hilliard1@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 1/2] tools: mkimage: Simplify fit_pre_load_data() data types
Date: Wed, 28 Oct 2026 00:15:27 +0100
Message-ID: <20261027231552.60390-1-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: ddf0fadf57a74e4ac99
X-MBO-RS-META: n5wnnsaxurzquam3aib8h5iz819gqa9p
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

The fdt_getprop() already returns strings, use const char *
and get rid of the void types and multiple type casts. No
functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Aristo Chen <aristo.chen@canonical.com>
Cc: Daniel Golle <daniel@makrotopia.org>
Cc: James Hilliard <james.hilliard1@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
V2: - Propagate const char *key_name further into fit_pre_load_data_key_rsa()
      and fit_pre_load_data_key_ecdsa()
    - Update commit message
---
 tools/image-host.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/tools/image-host.c b/tools/image-host.c
index 03c4a07cf28..4b6c16ed403 100644
--- a/tools/image-host.c
+++ b/tools/image-host.c
@@ -1645,7 +1645,7 @@ static int fit_config_add_verification_data(const char *keydir,
  * 2) get public key (X509_get_pubkey)
  * 3) provide der format (d2i_RSAPublicKey)
  */
-static int read_pub_key(const char *keydir, const void *name,
+static int read_pub_key(const char *keydir, const char *name,
 			unsigned char **pubkey, int *pubkey_len)
 {
 	char path[1024];
@@ -1655,7 +1655,7 @@ static int read_pub_key(const char *keydir, const void *name,
 	int ret;
 
 	memset(path, 0, 1024);
-	snprintf(path, sizeof(path), "%s/%s.crt", keydir, (char *)name);
+	snprintf(path, sizeof(path), "%s/%s.crt", keydir, name);
 
 	/* Open certificate file */
 	f = fopen(path, "r");
@@ -1700,7 +1700,7 @@ err_cert:
 }
 
 static int fit_pre_load_data_key_rsa(const char *keydir, void *keydest,
-				     int pre_load_noffset, const void *key_name)
+				     int pre_load_noffset, const char *key_name)
 {
 	unsigned char *pubkey = NULL;
 	int ret, pubkey_len;
@@ -1721,7 +1721,7 @@ static int fit_pre_load_data_key_rsa(const char *keydir, void *keydest,
 }
 
 static int fit_pre_load_data_key_ecdsa(const char *keydir, void *keydest,
-				       int pre_load_noffset, const void *key_name,
+				       int pre_load_noffset, const char *key_name,
 				       const void *algo_name)
 {
 	struct image_sign_info info;
@@ -1763,8 +1763,8 @@ static int fit_pre_load_data_key_ecdsa(const char *keydir, void *keydest,
 int fit_pre_load_data(const char *keydir, void *keydest, void *fit)
 {
 	int pre_load_noffset;
-	const void *algo_name;
-	const void *key_name;
+	const char *algo_name;
+	const char *key_name;
 	char *name;
 	int ret;
 
@@ -1794,10 +1794,9 @@ int fit_pre_load_data(const char *keydir, void *keydest, void *fit)
 	}
 
 	/* Is it a RSA or an ECDSA key */
-	name = strchr((const char *)algo_name, ',');
+	name = strchr(algo_name, ',');
 	if (!name) {
-		fprintf(stderr, "The name of the algo is invalid: %s\n",
-			(char *)algo_name);
+		fprintf(stderr, "The name of the algo is invalid: %s\n", algo_name);
 		ret = -EINVAL;
 		goto out;
 	}
@@ -1809,7 +1808,7 @@ int fit_pre_load_data(const char *keydir, void *keydest, void *fit)
 		ret = fit_pre_load_data_key_ecdsa(keydir, keydest, pre_load_noffset,
 						  key_name, algo_name);
 	} else {
-		fprintf(stderr, "The algo %s is not supported\n", (char *)algo_name);
+		fprintf(stderr, "The algo %s is not supported\n", algo_name);
 		ret = -EINVAL;
 	}
 
-- 
2.53.0

