Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD862606A31A
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 10:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oVYhJpzp;
	dkim=pass (2048-bit key, unprotected) header.d=embetrix.com header.i=@embetrix.com header.a=rsa-sha256 header.s=rsa1 header.b=V9Hd6eTE;
	dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=ed25519-sha256 header.s=ed1 header.b=4BNzSUB5
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9489C607A8;
	Wed, 21 Oct 2026 10:26:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HJfExzQdbtPB; Wed, 21 Oct 2026 10:26:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CAE70606B6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792578402;
	b=QA/bjFTiqguVl7EanUXWlS0gHJrsbT9jd9b0tIzWbviYVdk1YUrTAz+bB7UEeXVWVnmc
	 upRxnI/0rR5BvVQ5EhJxBSoFiSlhmrA9N3jUI0wTKzCtwqOwrE6tXghCyI8i1kdFotZII
	 KyPS4T1nl7lE7xleHSkRaJgmndUkBgh1E2Bi99qszAyS974Nfq+3BzXcdgFazidAyC9fd
	 0wtN+ljncX4sJvgD7AGC+jN6eh57SHefqAvAychmoOTp+TzEmLAAPNp+kHuoYBuwZJXDT
	 iMWrnwPwRzL2PxqbJEB7LfKlEIqk4kF4pMBKjNL7030KoqIvBSrDDQMJmG87wOt50yA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792578402;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:X-HalOne-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=YdhZwFzj/eyEdmR5qJwq2VfHgdf/VsMCYoWW7MZw7dI=;
	b=KqnwN3C6xFutl/cz72DXdijtgkLtnyz/b+GJJ15KhFO6h9rmD5of4tTQne5WPEYMxhMD
	 ngCzZnI3Pr0adYAfd1NlOfOFJJ8BzqW94Ya6DA93nKVBXGpVUY0Z1Cev4/V+iODc1eUZh
	 FE9WXi/2FSs0BD4dET5IpTM3jTM4i2VkjgTXmgx6T9jxYdQ4eHLIyPfzsohhDms9eK1n0
	 Yg6OsAoeLKhpaE5ko6y3VBMjNfvmJd2JOgez6+e9JSMb03gxo9AVNi6LPNws24Xy2wOo+
	 mYT2adqLqLonjxfCRcY6au1rwvrV9+xKXwbgKdqb0wTiSQ4hEV3hbuxUlD3V623lZgA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792578401;
	bh=YdhZwFzj/eyEdmR5qJwq2VfHgdf/VsMCYoWW7MZw7dI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oVYhJpzpJJWiOr8pqKVmg6isVuh/XYE4sqLJoKjhxhl7zawd8yLbC1NSrbRvyaNEQ
	 QFrAL4XhB8W4fo1R+9XpUQTkNkQ6/6KW+9oOyeju61btop5iWaDRxxCnmiCjp/yf9X
	 FwcCzhFhEtX2W39IVdh8J4WAEUYblbVDLw8At7Tj8J8lNeFoRYUBKpfQIvjDJSCPrS
	 FmE7UIZ3d8E77G99dy1dYmguNYEnLsVepVg/ovOLdM7uNjQ441T8jF+Hku/twd4WDk
	 oGK+ohe1NOGfeEGyugJ9GXHz5LjQ5gCwAkVMRRVTA9fgZOzcF6WAPu+hWd+joPp2ji
	 U9hNihIUpSX0Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CAE70606B6;
	Wed, 21 Oct 2026 10:26:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D32971E9
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 10:26:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C43D581029
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 10:26:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4hbP5oXiHogv for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 10:26:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 975E080D9C
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a02:2350:5:505::1"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792578397;
 b=l/T0a0TTaIOuWgaCg6ulP6i+mg2oCoY6is2n6/WCzGnvyiD4b5saMZ14I3/AjtFNMljT
 FJiyKcIkM4Q7IVPE+/gtLw3BJ69ZNIM0kdvKiHZs1lnnNDqTPnJSQgvQey5ciF/IWBpd1
 6ny9htB8EfnZ+IdKwSbilh/DTF9t/9L1tbONEilM5u23IpKdb2uloQoP7VqvsBDA4SE2r
 rd+tCMEHrzBrKYlPGzNtSKVH12wxPGkd5MoDMCqXBxaVw3E+/DWM8eGkG8GflhJWf/GeM
 TvgxnGg7y5H3It0LjrwA4R4BGG1FN9QIDWweGUPO7y2o0l5OF5G1oq9vVA6+BGUAi2g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792578397;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:X-HalOne-ID:Received:From:
 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=YdhZwFzj/eyEdmR5qJwq2VfHgdf/VsMCYoWW7MZw7dI=;
 b=AM5eOjWwkzq2lWZilZRkboZA8Mz4o7FaZTzm5L16GN1L5F5CEP5UGsliepOE5YRib018
 ygHG87XIaMh0h49mh9lmOqGy0kft7tcVM7N526i0b8BaAC+/LN/7y7o/eT9OZeYTIZ+Fw
 DNOTzAupVa3rI184j49Qs/zUZO+wTc+FJB93kmCeahnCinsSOVuUT1eHKW4Acg70fQAxb
 xmo0KAjvjuXs3ZkVolBWuL0aTgN0JCp+l+M3PNYtDDKZNCTQTfT3a0J6mbX/0dd/qc3ph
 bpiRaplv+SiCR2JZ6cpmRvzHx/9KW6xk+/uCBpFl1VP1OEkmBEaeHc4CI3eEFO6sWvA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=embetrix.com;
 dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=rsa-sha256
 header.s=rsa1 header.b=V9Hd6eTE; 
 dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=ed25519-sha256
 header.s=ed1 header.b=4BNzSUB5; 
 arc=none smtp.remote-ip="2a02:2350:5:505::1"
Received-SPF: Pass (sender SPF authorized) identity=helo;
 client-ip=2a02:2350:5:505::1;
 helo=mailrelay-egress18.pub.mailoutpod2-cph3.one.com;
 envelope-from=ayoub.zaki@embetrix.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=embetrix.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=embetrix.com
 header.i=@embetrix.com header.a=rsa-sha256 header.s=rsa1 header.b=V9Hd6eTE; 
 dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=ed25519-sha256
 header.s=ed1 header.b=4BNzSUB5
Received: from mailrelay-egress18.pub.mailoutpod2-cph3.one.com
 (mailrelay-egress18.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:505::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 975E080D9C
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 10:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792578389;
 x=1793183189; d=embetrix.com; s=rsa1;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=YdhZwFzj/eyEdmR5qJwq2VfHgdf/VsMCYoWW7MZw7dI=;
 b=V9Hd6eTEI1tYLzMkDUurAJdaK4bIbWJFHHP//9peXAu1JHVImMFOPKzHO+124+0X5Enzqs6t3ByET
 Xh3W2671SSkco6nUPqMeNpWzKHl4yyF6+L13nPry8Z1bKmdmgn4FmvBy2AjE8/fFgYuSc7zflUo0OL
 fDa/JgHl+lXCXGFL6qQtpRNmdtWFBuQZmvWejnv01oP9Xy0kukWp/E2I/qwWn2abXkF8MTkn+gheS2
 i27z5U0qb3wIBREI3bCXdGVbyMktP04k8kyFaoN6QlpcUvn8nHfp3Q3ynHKTYzyUxRvzBFGKeEeW5a
 uhc18aTAXiMsghCTMj1YozD/tH4cTUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792578389;
 x=1793183189; d=embetrix.com; s=ed1;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=YdhZwFzj/eyEdmR5qJwq2VfHgdf/VsMCYoWW7MZw7dI=;
 b=4BNzSUB596DWpGi4c4xw+UzIlMrLFkbZuvzd9KJyvWjTwmCesP2IxWNOwQ9R9FsFpbXL2pjArE/uk
 /WAEw3mCQ==
X-HalOne-ID: df989a6b-cd39-11f1-8909-33fc7c51c1c8
Received: from xps-13.fritz.box
 (dynamic-2a02-3102-8c10-1ae0-7f8e-6877-ce5b-5167.310.pool.telefonica.de
 [2a02:3102:8c10:1ae0:7f8e:6877:ce5b:5167])
 by mailrelay3.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
 id df989a6b-cd39-11f1-8909-33fc7c51c1c8;
 Wed, 21 Oct 2026 10:26:29 +0000 (UTC)
From: Ayoub Zaki <ayoub.zaki@embetrix.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Ayoub Zaki <ayoub.zaki@embetrix.com>, E Shattow <e@freeshell.de>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 1/5] tools: Preserve FIT signing key file-open errors
Date: Wed, 21 Oct 2026 12:26:22 +0200
Message-ID: <20261021102626.264091-2-ayoub.zaki@embetrix.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021102626.264091-1-ayoub.zaki@embetrix.com>
References: <20261021102626.264091-1-ayoub.zaki@embetrix.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

RSA and ECDSA report every key file-open failure as -ENOENT. Return the
actual errno so mkimage fails on permission errors instead of treating
the key as missing.

Signed-off-by: Ayoub Zaki <ayoub.zaki@embetrix.com>
---
 lib/ecdsa/ecdsa-libcrypto.c | 4 +++-
 lib/rsa/rsa-sign.c          | 6 ++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/lib/ecdsa/ecdsa-libcrypto.c b/lib/ecdsa/ecdsa-libcrypto.c
index c4bfb2cec61..14027d27c0c 100644
--- a/lib/ecdsa/ecdsa-libcrypto.c
+++ b/lib/ecdsa/ecdsa-libcrypto.c
@@ -228,10 +228,12 @@ static int read_key(struct signer *ctx, const char *key_name)
 {
 	FILE *f = fopen(key_name, "r");
 	const char *key_pass;
+	int ret;
 
 	if (!f) {
+		ret = -errno;
 		fprintf(stderr, "Can not get key file '%s'\n", key_name);
-		return -ENOENT;
+		return ret;
 	}
 
 	key_pass = getenv("MKIMAGE_SIGN_PASSWORD");
diff --git a/lib/rsa/rsa-sign.c b/lib/rsa/rsa-sign.c
index 0e38c9e802f..3040b345fdd 100644
--- a/lib/rsa/rsa-sign.c
+++ b/lib/rsa/rsa-sign.c
@@ -188,6 +188,7 @@ static int rsa_pem_get_priv_key(const char *keydir, const char *name,
 {
 	char path[1024] = {0};
 	FILE *f = NULL;
+	int ret;
 
 	if (!evpp)
 		return -EINVAL;
@@ -202,9 +203,10 @@ static int rsa_pem_get_priv_key(const char *keydir, const char *name,
 
 	f = fopen(path, "r");
 	if (!f) {
+		ret = -errno;
 		fprintf(stderr, "Couldn't open RSA private key: '%s': %s\n",
-			path, strerror(errno));
-		return -ENOENT;
+			path, strerror(-ret));
+		return ret;
 	}
 
 	if (!PEM_read_PrivateKey(f, evpp, NULL, path)) {
-- 
2.53.0

