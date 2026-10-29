Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6A3606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 06:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fD/aDU1M;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=Ja3/NxzT
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1D3364076A;
	Thu, 29 Oct 2026 06:27:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DCuJk99sUTRm; Thu, 29 Oct 2026 06:27:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 414DC4075D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793255265;
	b=Tkn1Ql3Bd/l+GQGNsxIuIXfZFF4Z58ROc3HJFXGQ4H+w0OS9x9KfCxl2oUIT3xKmxMNd
	 FIHZJkOf3wATTgrEV/kc6utL0NSaKru88gV36mjrHypoz8OQBhlCce2b2JDF1GmguudY+
	 z0Gd0APsz8V27/QK54jd/aNreXkJslKNvBZgL+H1FomtLCLTWC6BaEjcoX4vmuaBNFjCK
	 xcitcROcgK8nAP71o3ezWreyNxQOxvaEdjyz0ACGAdFhWsNn+tAu74sUddDLEDHPjXyCS
	 frGBMnQjxcjc8ElRlkvc/7Wghk8B5cREGMInRrhEFLic/9Cx3jHoHPdDfJbKejwU4Sg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793255265;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=IeQyM+qcY5jDGhzJU7195Ri1lL0t1l2dVinQn7qTwQE=;
	b=KpxMonbVl+Ud8WHY0tgUr/Nrcgkeiz7kwN81yGvk4rX0FV8JqUXWBH51eioFmRTfT67W
	 8MPm5fwXFFsUZWXoVL17gm43hwwtYuRefqUmRZEBBkSoLU0OM5vJ8GQUYrSFbo5C9QpbW
	 AT/wT7CDa6yChe4cHwVGti4ylV49zrXTut+yWAvAL8kLgK1SFHQ+3n/3VXn6LptRi7Wkl
	 ipOvuQjtpMJvMAMLBH+rxRY8qCzKpN7LQHaa2KwRgB5gmV3L8nJrlG/9Gy23gtVl3rb+X
	 k8bJRBH2ipbKDCMmOqbHc6/qRlSLDzBy/wpH3nMgj/eRBbprfNhZoaxtTe6YkACScoQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793255265;
	bh=IeQyM+qcY5jDGhzJU7195Ri1lL0t1l2dVinQn7qTwQE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=fD/aDU1M4yLlxVNaR8AVFR+6X6QQwavOceGJyF7HU+8SQE6VWg0LjnLIfSpuDyoIg
	 YoKbWwwcmcKiQEzoDZmw+bDNFrBIkHDdhw3zmKwkPGPClTwjtJ8O+ci/BYhlPGdM9K
	 HMVCp2elqRRe37KKlkjr6pg+jy0U+WB7uXmOS3qfYDBzxoGHbm/VOIUT5sthVdjkj1
	 YDYRZPGxcViIYBJ1cFfVP+pq4KjM7Uq5a+a6ipA1q1ReStw16r+h0jK0hbt4MXgjTC
	 iTT7ktnGJQ/vRPkEXZB09INAJCkt1JUDRSAoOSsCqiGSlq+5dTAwvk19ckX9EcOI8P
	 S7RL3PSQxreaw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 414DC4075D;
	Thu, 29 Oct 2026 06:27:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E3011120
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 06:27:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D538D40176
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 06:27:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 70mG79DLo2Kj for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 06:27:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A671340080
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::102"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793255263;
 b=VeuQ0NfEEvGTXC9UP+V6w3A5uOIoK1ZOvHO9vPA6SnEkCkU9Qw1X6npnBHFEiXGEFO7M
 P1Z/bn37L5Ma4wZPh42GXqSo3Qlb1y8iCj799PZFv9tLioHUH6iBwBm+Bm/QCoKxeNbHS
 XNqfizVdb0fVG5DB4ge8X5xpEiggm/tlojt9CBWk4pr4QhqT+UXdttmbzvJSv6iyrxGEM
 gMoWMisocEW2eQkMoDV4BhIg/njv4mXuqfW1wdUpwdH6k7mOG7k/sRosQT331/Sqkihso
 WVIUsx11lAcbw2YMzjhGRWlHZqsTn9GARYjCGM8OAWymgRcaJXaaRcULOkHAw48UBqw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793255263;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-MBO-RS-ID:X-MBO-RS-META;
 bh=IeQyM+qcY5jDGhzJU7195Ri1lL0t1l2dVinQn7qTwQE=;
 b=ZQh4lZAC7r5naj9ZDUE49+Xflt3KLgYZsiSIQtv8WJu6wC3pHXH262hPivZGUcYWuimU
 oYU1VJq8FQVkGG7NWPCGQWeYoPLNNyiB5gpx9EYt+5WdxlS1NLYlPu6esPoVNwq35h+6e
 IOlhIHaonGZjx88J7OQSmShYZQjUu9ssbpgQaFNXBT5RdaiOZMYUAccrXqk1UMnIOjGH5
 Af+8jXbS/0d1RHZEjxIeuxkRdqiTxfxp+6LDMSHlZ6FdoqHTsU36h4DFKCmPY++/Zf5MQ
 u9oe61y+HolSnfjLXjaD8LfEHoQf6k5yrjjPDV8LlGFT5AyafSkQ587VVxEkR8jO2Zg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b="Ja3/NxzT"; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::102"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::102; helo=mout-p-102.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=Ja3/NxzT
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A671340080
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 06:27:42 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jFZ631tv4zKp1t;
 Thu, 29 Oct 2026 07:27:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1793255259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=IeQyM+qcY5jDGhzJU7195Ri1lL0t1l2dVinQn7qTwQE=;
 b=Ja3/NxzToQI8ddiESeO0rWF60m8tquUQS6ddrkM/l6im5TXcUrkRXi8m1lW5Ab9a1i1UlR
 4ESYX0HrjdXiXoS7QHdeEIjR7Ys6b09IEcAK1NXXQAuyH1DU8SNLXkqXx2mSvz5Tc/4xqU
 i0KQIo5ZPRHJDpm0xIhdjw9BkDN1f86/92EfAPoe6qqm+7r1AsaZhYD6AELAFoEyqVDt1D
 9f2l8hVtp6f3JAXkEWvLjCAwj63Wvg14stXX3JRsLXwGMP+9tXTFg+IW+kzk7wffJiwg85
 FRQ9vgL7RSqtloTTSvqOkZUsyeTncxR0urYEesmWeec+rBPvrRnwETLYC7ROKQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Aristo Chen <aristo.chen@canonical.com>,
 Daniel Golle <daniel@makrotopia.org>,
 James Hilliard <james.hilliard1@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 1/2] tools: mkimage: Simplify fit_pre_load_data() data types
Date: Thu, 29 Oct 2026 07:27:27 +0100
Message-ID: <20261029062735.898715-1-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 4674af87f5df4009902
X-MBO-RS-META: 47deitcw8nds3kwnaeygk94xwiwxdm3b
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
V3: - Fix one more instance of const char *algo_name and drop two type casts
---
 tools/image-host.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/tools/image-host.c b/tools/image-host.c
index 03c4a07cf28..4874c33a01c 100644
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
@@ -1721,8 +1721,8 @@ static int fit_pre_load_data_key_rsa(const char *keydir, void *keydest,
 }
 
 static int fit_pre_load_data_key_ecdsa(const char *keydir, void *keydest,
-				       int pre_load_noffset, const void *key_name,
-				       const void *algo_name)
+				       int pre_load_noffset, const char *key_name,
+				       const char *algo_name)
 {
 	struct image_sign_info info;
 	int node, ret = 0;
@@ -1733,15 +1733,13 @@ static int fit_pre_load_data_key_ecdsa(const char *keydir, void *keydest,
 	info.name = strdup(algo_name);
 	info.checksum = image_get_checksum_algo(algo_name);
 	if (!info.checksum) {
-		fprintf(stderr, "Can't find valid checksum from %s\n",
-			(char *)algo_name);
+		fprintf(stderr, "Can't find valid checksum from %s\n", algo_name);
 		ret = -EINVAL;
 		goto out;
 	}
 	info.crypto = image_get_crypto_algo(algo_name);
 	if (!info.crypto) {
-		fprintf(stderr, "Can't find valid crypto from %s\n",
-			(char *)algo_name);
+		fprintf(stderr, "Can't find valid crypto from %s\n", algo_name);
 		ret = -EINVAL;
 		goto out;
 	}
@@ -1763,8 +1761,8 @@ static int fit_pre_load_data_key_ecdsa(const char *keydir, void *keydest,
 int fit_pre_load_data(const char *keydir, void *keydest, void *fit)
 {
 	int pre_load_noffset;
-	const void *algo_name;
-	const void *key_name;
+	const char *algo_name;
+	const char *key_name;
 	char *name;
 	int ret;
 
@@ -1794,10 +1792,9 @@ int fit_pre_load_data(const char *keydir, void *keydest, void *fit)
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
@@ -1809,7 +1806,7 @@ int fit_pre_load_data(const char *keydir, void *keydest, void *fit)
 		ret = fit_pre_load_data_key_ecdsa(keydir, keydest, pre_load_noffset,
 						  key_name, algo_name);
 	} else {
-		fprintf(stderr, "The algo %s is not supported\n", (char *)algo_name);
+		fprintf(stderr, "The algo %s is not supported\n", algo_name);
 		ret = -EINVAL;
 	}
 
-- 
2.53.0

