Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04726606A31C
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 10:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ymJHXY7M;
	dkim=pass (2048-bit key, unprotected) header.d=embetrix.com header.i=@embetrix.com header.a=rsa-sha256 header.s=rsa1 header.b=EJgtavVj;
	dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=ed25519-sha256 header.s=ed1 header.b=Dh/isNtz
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7A51C6061D;
	Wed, 28 Oct 2026 10:31:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LudoI6BrdOoK; Wed, 28 Oct 2026 10:31:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 66EC4605EC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793183499;
	b=Qg4Ee26Krq5KyRiASSRHTCTukRMFeYHzpvZJoH5hUfOarJ9b/X7vMslVZL3zik8O9qbs
	 X2LWuq9Z9xEmzy0vzbBgIrbDZ+d2aCicjwh8y9uCw1DI7827CMLpH3oY7aeIRhaiqBDy6
	 JF3S4AX2PzS+JcLLH+tMtH6J/lGsAUThC0P1WoitkqWo6b/9232mXXsVX4VmYWy8G2Rlo
	 FpWc5d2Z388SPeGKkrkqV/P6PRakzsSKX6E4LdD+oB66ThTfdtu5vT+so5Dta4C4Y4mX2
	 ZQzhAryyi8iyqE4+bxwGVfMQ96tI8YxKhsf5yKrvoA57HMDY+wvsUx9oBmZ9gWc0ngA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793183499;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:X-HalOne-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=brF1xZaL2N6DS2uhGHQBm+kqve/u6ObHHQH/jHeDj4s=;
	b=OLSpMO2/O3dgDOWGN/G5D1KNO33lDykRaLcceqtBK00/tpse1PzDpeW9e+gItPhVXx2Y
	 VXSTygklJOIFENorxo4cUmsQExfkOzbOw9gAtl8Fx6WnN4MtxZtpQDJsrRu7n8S4KAkKA
	 viS7h/LP+nPQq674N2strjo5vw6Zutoi7xkSg58avGq69TbgIDqsr+h6XUkpphVBIu/k9
	 7wZYOSnUWPVzc/dFD/rIlmvH3TzcxQqzzgd62m7Eh6E/CnqP9Bist+h7ll2xc8+yhoGoI
	 UXFBOyT9QT1jSnQj1NZRheFr8qeSOyGwt2zFyDJZlSVqwanw5UQdCr/k9pBTsOqrwUA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793183499;
	bh=brF1xZaL2N6DS2uhGHQBm+kqve/u6ObHHQH/jHeDj4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ymJHXY7MEB6QdRygrO6+rZd6KjUnz02FucOx9yxJ1NL/+vCu7IjtKbkes3RmZwCO2
	 uqC9jnJrSbPUyS4NYb9Ry/ZL0MCZl3D0C1VdTiZVWXBTXgUxz+fzryggWXJo1RSCSf
	 GUq5HLEnkIGV9Rvw2ksOAzOuqdCBnQtx9XYRMhsecJP9F7jKGLvr7sfsluMN5fqEOG
	 26ft7tzbojI6GVLZYUUZ+B9PhWT0qo194tQGnjwr5SkbPPecfjhG5GBoSKFoVzUX6e
	 jP8RBek+vuctWDajpVY9/s78l6HG3Djw2Wi61IW0NQoPVCiROkl9AGE1VevBvBUp2w
	 g3YBnBXdPspUQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 66EC4605EC;
	Wed, 28 Oct 2026 10:31:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id CAEACD1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 10:31:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C8E6940565
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 10:31:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N6c-44M9NvE2 for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 10:31:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AF33940567
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a02:2350:5:505::1"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793183493;
 b=cFdUCiCrWFfQbJebvwZHkY5cIqruDX1C2uOG5YRHZKvViEyjVanRxFMG66gPoPNvKE5e
 yvE8M3pXd7TN4dvN32vAuYSrgwUXKcnIMjpCskSJalM3NC4Yxds362P4kBjm/okVoCiqh
 CI9tFDJvH39ThvaGd1UmiadZ3uZQk95iYvRKICHklWJc9EV5KxDdz5DjIzBQ7sMh/H7vJ
 w4915Fi2lZKbSSX40tx2oarcsfOP4dD5bRC60brtfv0GgkSt8uwVRJRyp4LqBucFslzqf
 q0ggTepmRBqNSK+Y+wRX6DvRFoEjH/AFW4AUq5CWrjbw6R2+rjfbiJPSzVFsxCmuelA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793183493;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:X-HalOne-ID:Received:From:
 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=brF1xZaL2N6DS2uhGHQBm+kqve/u6ObHHQH/jHeDj4s=;
 b=OWvW9fh10Bd/2JExggXbDoUk+agC3sEeBfOmJMB1BnFxtbioe+b/wt2n3FHSEw3dl8mw
 VQLfEOXI+wFId451DgDUQwU5566SsgYqipo9b7WcEKwS3uYbgK/kPIY6aBW6BNjpMeZ0g
 0DMgp/XjJR+hP9cxXrjkNBXVyg2hH3ABLCTV5ywNwoIok4LKDHZXASfJREmj1mmngTBzR
 4MtnIFQe3gXqCHYLKPos/g4F1MZ/MNXGsp/Ez5fuhdCdh+k8ntpwFkDp1JCp4J3GoErAW
 oZeZV+cxe3sqTcYpjhqSVdJarGKtMzzzVO1/q1BrSgHxZxHoNW4pDIl9dZnH7Huc3Gw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=embetrix.com;
 dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=rsa-sha256
 header.s=rsa1 header.b=EJgtavVj; 
 dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=ed25519-sha256
 header.s=ed1 header.b="Dh/isNtz"; 
 arc=none smtp.remote-ip="2a02:2350:5:505::1"
Received-SPF: Pass (sender SPF authorized) identity=helo;
 client-ip=2a02:2350:5:505::1;
 helo=mailrelay-egress18.pub.mailoutpod2-cph3.one.com;
 envelope-from=ayoub.zaki@embetrix.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=embetrix.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=embetrix.com
 header.i=@embetrix.com header.a=rsa-sha256 header.s=rsa1 header.b=EJgtavVj; 
 dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=ed25519-sha256
 header.s=ed1 header.b=Dh/isNtz
Received: from mailrelay-egress18.pub.mailoutpod2-cph3.one.com
 (mailrelay-egress18.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:505::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AF33940567
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 10:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1793183486;
 x=1793788286; d=embetrix.com; s=rsa1;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=brF1xZaL2N6DS2uhGHQBm+kqve/u6ObHHQH/jHeDj4s=;
 b=EJgtavVjpUgaB0B6dxHT21A1HFqphjUt77HqH4WyAUopyJscl/G+C6IHunt63NNbsjRqcH+ue0kyn
 KA+iZTvSlR7J7UT3WnbA6K3J0gJZ/XQmioWifE2VKSEXliHQYdooj58hKsdzuqJIRqr61QwIJoDynp
 QJ38yp4RWA8dpv+S/jT9Q0aVOnDRy1nGXFWB2ZasZHdruewypQe0jJ67WS0BKfxL0idcet+xXzoqg/
 bp/jGiexmFlme2TMtYlKdhs9lrHsSe9AupSqtX+gMNfiWwsTzdBH/ysr4MScYGQNq2zk71Rse22tKl
 SFyD7nDrUnrvjHOsM4ORUqPdDtpCasQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1793183486;
 x=1793788286; d=embetrix.com; s=ed1;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=brF1xZaL2N6DS2uhGHQBm+kqve/u6ObHHQH/jHeDj4s=;
 b=Dh/isNtzPlDtoi2kpBP0lN/k5RDpU1MASynH7iwavt2jf24pSpPnLgKZflxvY/rMGva0rZxWyWDTR
 PHXDLBHDg==
X-HalOne-ID: ba0ae1af-d2ba-11f1-9e44-5b5978544972
Received: from xps-13.fritz.box
 (dynamic-2a02-3102-8c10-1ae0-c98b-5300-3c35-71e4.310.pool.telefonica.de
 [2a02:3102:8c10:1ae0:c98b:5300:3c35:71e4])
 by mailrelay4.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
 id ba0ae1af-d2ba-11f1-9e44-5b5978544972;
 Wed, 28 Oct 2026 10:31:26 +0000 (UTC)
From: Ayoub Zaki <ayoub.zaki@embetrix.com>
To: u-boot@lists.u-boot-project.org
Cc: sjg@chromium.org, Tom Rini <trini@konsulko.com>,
 Ayoub Zaki <ayoub.zaki@embetrix.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut@mailbox.org>
Subject: [PATCH v2 3/6] lib: ecdsa: Accept .key private key files as a fallback
Date: Wed, 28 Oct 2026 11:30:59 +0100
Message-ID: <20261028103102.414657-4-ayoub.zaki@embetrix.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028103102.414657-1-ayoub.zaki@embetrix.com>
References: <20261028103102.414657-1-ayoub.zaki@embetrix.com>
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

Allow mkimage -k to use a .key file when the ECDSA .pem file is absent.
Keep .pem precedence so existing key selection is preserved.

Signed-off-by: Ayoub Zaki <ayoub.zaki@embetrix.com>
---
Changes in v2:
- Report both attempted filenames when fallback fails.
- Rename pname to fallback_name.

 lib/ecdsa/ecdsa-libcrypto.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/lib/ecdsa/ecdsa-libcrypto.c b/lib/ecdsa/ecdsa-libcrypto.c
index 402c49cf61c..6ffd970a47c 100644
--- a/lib/ecdsa/ecdsa-libcrypto.c
+++ b/lib/ecdsa/ecdsa-libcrypto.c
@@ -218,12 +218,24 @@ static int default_password(char *buf, int size, int rwflag, void *u)
 	return strlen(buf);
 }
 
-static int read_key(struct signer *ctx, const char *key_name)
+static int read_key(struct signer *ctx, const char *key_name,
+		    const char *fallback)
 {
 	FILE *f = fopen(key_name, "r");
 	const char *key_pass;
 	int ret;
 
+	if (!f && errno == ENOENT && fallback) {
+		f = fopen(fallback, "r");
+		if (!f) {
+			ret = -errno;
+			fprintf(stderr, "Can not get key file '%s' or '%s': %s\n",
+				key_name, fallback, strerror(-ret));
+			return ret;
+		}
+		key_name = fallback;
+	}
+
 	if (!f) {
 		ret = -errno;
 		fprintf(stderr, "Can not get key file '%s': %s\n",
@@ -326,7 +338,8 @@ check_key_len:
 static int prepare_ctx(struct signer *ctx, const struct image_sign_info *info)
 {
 	int key_len_bytes, ret;
-	char kname[1024];
+	char kname[1024], fallback_name[1024];
+	const char *fallback = NULL;
 
 	memset(ctx, 0, sizeof(*ctx));
 
@@ -337,6 +350,9 @@ static int prepare_ctx(struct signer *ctx, const struct image_sign_info *info)
 	} else if (info->keydir && info->keyname) {
 		snprintf(kname, sizeof(kname), "%s/%s.pem", info->keydir,
 			 info->keyname);
+		snprintf(fallback_name, sizeof(fallback_name), "%s/%s.key", info->keydir,
+			 info->keyname);
+		fallback = fallback_name;
 	} else {
 		fprintf(stderr, "keyfile, keyname, or key-name-hint missing\n");
 		return -EINVAL;
@@ -346,7 +362,7 @@ static int prepare_ctx(struct signer *ctx, const struct image_sign_info *info)
 	if (ret)
 		return ret;
 
-	ret = read_key(ctx, kname);
+	ret = read_key(ctx, kname, fallback);
 	if (ret)
 		return ret;
 
-- 
2.53.0

