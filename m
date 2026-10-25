Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6326C606A31B
	for <u-boot@archiver.kernel.org>; Sun, 25 Oct 2026 23:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Xf1FQQJF;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=GJknYKbs
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4DBA1405DC;
	Sun, 25 Oct 2026 23:18:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Vu0vqE7DNdOa; Sun, 25 Oct 2026 23:18:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EDDB940467
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792970311;
	b=hu+NZyS/lJg6fbSdTFzAMrWn4uB5b2Zl5HL+S8joc/ipBWUcnnxfCVs4TNoYhFAKClpj
	 ZXhxgdyNiXHLDw6v303Js1q188f0h6uO5Iqf74eCoa4cEcYddYx/wMyCZgAXPQ5Ci46g9
	 FcwFH4wjhohTF/XQzozUQUVIWWwP9WUCJJNLkT7DbL9IfrRmvMWpRdfHhFO6C7OR6VbCR
	 6ZAUS838QxlAA6iSZDv+t5xGRWKC9XEjPBpmxzAKmsjlYEkDcqbW64sXpvFqDok9BTvs+
	 NxO3+gNuB8ug197CaPElqNO6oABw8Kb9v4PVvHfXtRZxo448dhIoMDzLxub+WQwrfcw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792970311;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/k2zkReZq9+GyfhhcTyMAwNAvJNgO3rvJ+CKF8EcbrM=;
	b=DZP0A/8uS3DJOadA9Kk62wBqBXDAjCkW0kfNi+iw3mzljfzlx+fpyvs8esn5K2poLtYg
	 ttYYi2twMUqHBdb7QImOfbAsrBv7KVrjKg/ybpaEC30MSQ5b470dPGCbuep3s+ilcmca1
	 od2cK7q3d61XdqJmKWt4L0zGIHirTEN68j7XJWNf1KMFkTsP1S5zxxFRpqDA5jte3arwk
	 acW14tVh8oIB0mrPrtw12Z6F8+i6WLjw9QbtK7gnKwJV+96GgCSbtddO0LveCTwL9Ylah
	 xT0ISKff6+gt6hBjF+jmc/cS8mvA9Lc8WBWXwRm48WkQ/cfncCOqudegO+UYyarROkw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792970311;
	bh=/k2zkReZq9+GyfhhcTyMAwNAvJNgO3rvJ+CKF8EcbrM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Xf1FQQJF33fBlUFJvbXSx5Ok/ct1d0Dd2MddqVf4I0mbrsdrQp2whgYIi0Ka8CZca
	 gJ1KXJZEj+zWFoYWdW8jqM4L28YHWISR2KYmFHsDzTC/ZFWo/oN3+hRLo6y5QSWc0W
	 R8nNEGFNN8qIrJi0gEho8HOJfKnZY6BeWTExgH+jekcueF8X1pQb3Wh0k8a4ZDSvgx
	 bsWOBwAsejtli0HkSpbr5QwzMtCjFnpbEg1Gfv8e6E+vgIPe6t7wrMPqoN/5Hl4jw+
	 8R8t0nTJTs6n6ErhLj/+/7EOCFUJX6cTx8+p3riXw4YDhevzv4ym57DyBKSeyvtB2M
	 cdoLWFI4Q1uVg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EDDB940467;
	Sun, 25 Oct 2026 23:18:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id CF423B91
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 23:18:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B44E880C92
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 23:18:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h861Dx1FGKBu for <u-boot@lists.u-boot-project.org>;
 Sun, 25 Oct 2026 23:18:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2C65780897
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=80.241.56.171
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792970306;
 b=o80uIW0zbWxzy4yg4OnwpBAArlwWJib7FhrYncTjOcTvPAcxiN00ekDI3a5YN4GDp55r
 QOc9j8CIv1Ek65GbLcglrALZBlzPDtOoVDVLpvCgjp9lVFrvwpcI5cYNVLDPFTq5EHXBl
 WX+fr4xJpEkyRDZlZR7/2prbhkObJY/M8hvCc6u+ZCxnvaS8eZrzG25d3RBeTwvKEUMXk
 dQYabW0kW8CWwS6hAmkbRXElGSJ5Y0vchqagtf7qncVL+Sr3HapHyFpQipVU2wUD1aFx0
 Sl9iuszWhFkmWM8D4H9/v4gaEb4DElANpm1d2RFfo2qCe2Bwnhyjw3tSrE2v5sO/OUA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792970306;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-MBO-RS-ID:X-MBO-RS-META;
 bh=/k2zkReZq9+GyfhhcTyMAwNAvJNgO3rvJ+CKF8EcbrM=;
 b=By8mXF/qmesnskHn/0pTG1BRHM0ODkkaozybMoRcuDYSMag7mt1wfqxLk0VOAJ5QFSbR
 ToJLusjHChaskt6zilKjpYPS+Nh+30jwqfnKgw4+UcA1HoD03LHahoyGdc6WV2zhCsgei
 qXqHNszypaa41oZi+l8TRAN6qEO/tQl6dMZA0FHvp3QpLZWB70RUr7cikZup0u3QTbMIS
 zHQskQvS2/YKsSysfIwrwo1KLKApReQkcKy1jxluiQ1fqWSlVzcd7mTBbkODSQ0LLlcje
 bzTd15neFwHRu5IfPEccgECrDxCN/fCZsqv5N0yR5wKP+A4v2pCpAgvcRG3OtAYupvw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=GJknYKbs; 
 arc=none smtp.remote-ip=80.241.56.171
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.171;
 helo=mout-p-201.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=GJknYKbs
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2C65780897
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 23:18:24 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jCXk52clVzMlNn;
 Mon, 26 Oct 2026 00:18:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1792970301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=/k2zkReZq9+GyfhhcTyMAwNAvJNgO3rvJ+CKF8EcbrM=;
 b=GJknYKbs25FJIpkXSNs6YkNFso9OLmFL940U9oRZ5wOjpGg+o6B333ipqZn6Rt/Y6RJ+vk
 yCFXALRYZsb+XJ3YbaA9AqVrzhfiPs2lOavTQJa5thoDBDPQU5wNoNy62s7FeuvD8JCjvA
 alKGsJISuRGrdxbiY/xnCRvMggExmSuhD0z+vopxIF+1rOSJ27hmI4QMpdEX+1+FIRlxsr
 NHg0QYk4TEW/+Rd50Pkyi8xwT21WsYDs/QIS2M2agMNNmn6uslbQ89zHFWl6zbjv6nwnVg
 cBuT8Ff6m6o/0Wp5ZJmy4L7gsV2m/v/qvGpDlQMS7rshUc4iQoAiXdWK2m86gg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Aristo Chen <aristo.chen@canonical.com>,
 Daniel Golle <daniel@makrotopia.org>,
 James Hilliard <james.hilliard1@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] tools: mkimage: Simplify fit_pre_load_data() data types
Date: Mon, 26 Oct 2026 00:17:41 +0100
Message-ID: <20261025231817.1155249-1-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 587070842c280a92766
X-MBO-RS-META: b8t9g6m3kit6ccpdinw6aat9csmx7c1c
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

The fdt_getprop() already returns const char *, get rid of the
void types and multiple type casts. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Aristo Chen <aristo.chen@canonical.com>
Cc: Daniel Golle <daniel@makrotopia.org>
Cc: James Hilliard <james.hilliard1@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 tools/image-host.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/tools/image-host.c b/tools/image-host.c
index 03c4a07cf28..aaf5c1b98e2 100644
--- a/tools/image-host.c
+++ b/tools/image-host.c
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

