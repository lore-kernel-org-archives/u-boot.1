Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437AB606A320
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 10:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NO/GGGDu;
	dkim=pass (2048-bit key, unprotected) header.d=embetrix.com header.i=@embetrix.com header.a=rsa-sha256 header.s=rsa1 header.b=vPqkh0z5;
	dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=ed25519-sha256 header.s=ed1 header.b=/GPBLnPS
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A472780F74;
	Wed, 28 Oct 2026 10:31:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id usHtzyBHG9Ux; Wed, 28 Oct 2026 10:31:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CE29080F6C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793183501;
	b=UBmNY6h/XgCg0wPag66lgTklKXumhMsph3zvselz8UB/Bg0b/mHTO4cUt7DpOYMV9vb/
	 gP2fRuXaPyGixxiYu1XG3fYZw3P+KAN3FZbmajKLUlKKNW4Fc741E8VFtCZJhiwuOO4WP
	 6R4ZBw4U2yznmdqO8rFm4GA1/bul7QyWZAKEiHj7FPMrgdvkb/0ZaXOVuVusVBDiB88ZD
	 B1msp/JVhasB+ufw1DpH9a+FJWJhxq+JbpcUbawXoYuqLW6EvonDiItGnS5zoE6QNyXpC
	 tQTkCT+NUXUaYzSbjZKxBTxfrMyhjQoyFkX3oFkwiQebJZZDnjR+q8CLoA9bI3Raocg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793183501;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:X-HalOne-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=zEr1eXfzcmaEmiGNGMQ1ItkhDoI3doV8k7L+uG2Pl5I=;
	b=lbHvmJhNLexvHA4W76OsltDEKxv9vMmU1tPe/r0SOXdXquLiX4RuWUEmI6BW3nx3jcOL
	 e2qxOh8bdbl9LaHKaFSw39fv7685KQAYCsToKlNB8gF1/NGS83D4cNc2Xsv4fKEYDlDVl
	 NyLP1BVfoluX2xtRvkNTx4kjRC7wtbOeUex0r4LA6aTXBOXYoVqHsT2doH3JsheSdR6Oh
	 eznNDWheYUEItTv9WgEVr5SMsxtrdBR+xEBf3T9JnxKSXLzodZVUUEc2D6EUPRR8VgV0G
	 J59hXPBjoF0kPCzt7unkElj28Zjbo2ahhN1HPi28UZSuh5OfqytQO8Cga4CRSIE5X9Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793183501;
	bh=zEr1eXfzcmaEmiGNGMQ1ItkhDoI3doV8k7L+uG2Pl5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NO/GGGDuirBTC/OMb6MuZfcZckFOQkgDWsUkG1scCftuSV0B8UgbyuLLVCgm7JLLS
	 iUA+yo0CguBw7YAMFo40zTLRCb2xlN5xaDnAtdxUeeyuDmPMZiDrxrH/bXz44HnvVB
	 kPmXbwJ3M0tElFAuzl+h2wFTVauLDwu6zWikxvofQMcH0JVWL+SN43lTKfnLBpCULW
	 jSXQtP8bd8AaH9QRUfT5txNwC/M32UzS+VZ0GmwBpPCsCeMQolTWH5Y1/+fobWpkyh
	 hRh9U+xV5BWNsiuWDEspnwxSfnTZixNvNBiN9jMUD/Qp7SdJQ3RL+4gPsPaGtaMaHa
	 EO2KHV+9UxjBw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CE29080F6C;
	Wed, 28 Oct 2026 10:31:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DE6FF9C6
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 10:31:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C49FD40568
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 10:31:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OlpzpCbM8-EL for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 10:31:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0613A40565
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a02:2350:5:505::1"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793183492;
 b=eehZR6jQdsiWDeGwYuv4mHF6HBhtK9YNVrEjG3h7K5aQISq9kBmxbD0Ziz7p6gelcTpt
 EnZla8iTWnFjS8A5e9p7SKqXERrw5pRkCjflbIusOIy/UyfdWZqVe1QQ0y9seJ9gMW+zP
 7mMhk71z+PjBX7ola7t/zlECAKjwOA/sXfcrLkSWUVh3EGl3t/9ARmswRCEyFQffgaae1
 1VSoxrV6awe/lKLRdWR639K9lmOX4FXmtBR+eZOBMBViI+3QaJfF3DKJ8K8aYBt+QqLCa
 JIHCI86xRxJRWfH35lRQ9swdzX+3iNrvtuhHn9LLSbIJbdalsUeaK4qUnVMcOfGev8Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793183492;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:X-HalOne-ID:Received:From:
 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=zEr1eXfzcmaEmiGNGMQ1ItkhDoI3doV8k7L+uG2Pl5I=;
 b=NoiFqAe+DQkvlhmpyDONbY7jgwO/niEmw1spYTaWX4daR6DTHHGNRL33lU4ZHMTIu8kw
 XRtu06OW/c18OgTOFFEwbChz0AFh91zVE+vQEQxphQ8tmWSidog6SjgIVHOQbMbwlPUml
 ++6Ai/dk++blBQxMKnAsr9RjxPku4NQYD3kEdWOlcghwAoUT9/5e8npk0XQegbnoeb963
 Eh7hi+t9NyG3W4A5+6i+LYy0xXCSigwNum6LtnT6rNeZF6SDk154D8gbRxTIWI8HEq2yy
 rx9aUS70PgK+RlN3jdeutD0v8ih1Wxl2lQv3m4lKhor2Iv9Ocusu4M9KEJxiBAT1DEA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=embetrix.com;
 dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=rsa-sha256
 header.s=rsa1 header.b=vPqkh0z5; 
 dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=ed25519-sha256
 header.s=ed1 header.b="/GPBLnPS"; 
 arc=none smtp.remote-ip="2a02:2350:5:505::1"
Received-SPF: Pass (sender SPF authorized) identity=helo;
 client-ip=2a02:2350:5:505::1;
 helo=mailrelay-egress18.pub.mailoutpod2-cph3.one.com;
 envelope-from=ayoub.zaki@embetrix.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=embetrix.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=embetrix.com
 header.i=@embetrix.com header.a=rsa-sha256 header.s=rsa1 header.b=vPqkh0z5; 
 dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=ed25519-sha256
 header.s=ed1 header.b=/GPBLnPS
Received: from mailrelay-egress18.pub.mailoutpod2-cph3.one.com
 (mailrelay-egress18.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:505::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0613A40565
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 10:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1793183485;
 x=1793788285; d=embetrix.com; s=rsa1;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=zEr1eXfzcmaEmiGNGMQ1ItkhDoI3doV8k7L+uG2Pl5I=;
 b=vPqkh0z55H0adJgc3RS/ohqJg8Vy8Ql66OR/S0D/PsMnh3EAhnK+BwdW5JZF2aa0CL53c/mNcKujA
 b75uouDoP2MiGghBCH49TxSGC0C+d6Ydo77wnGVHOmPT7sLXYqIW7TKJ4ELmVwjNAfKcycvSmOlM4m
 5mTsyfeVKMxp0RtTQX/yhpywtXWwOsRFQZXZ3aBsaCdb3AJz8NKDQCRGUWzpvvUz8CUsbvvDH8WVDY
 hpxJ1P4fSFh2jtucvwqfLaNrnBmFU9ctHPpoGi5HvpjX9U9D0tFcQDFdBJJ4jOxiH8VZW7xSKOdJyh
 Ho0BzB2aMy9rdIcsLwmsGLu2U9mUuXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1793183485;
 x=1793788285; d=embetrix.com; s=ed1;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=zEr1eXfzcmaEmiGNGMQ1ItkhDoI3doV8k7L+uG2Pl5I=;
 b=/GPBLnPSpot13AuXMj8sh2DwaLu5HgmfKtE9xNTV68xwS686GyEAT7NVVQL2tfa2GzW0LvQpAM0lJ
 eXwYuhVCg==
X-HalOne-ID: b8d09014-d2ba-11f1-9e3f-5b5978544972
Received: from xps-13.fritz.box
 (dynamic-2a02-3102-8c10-1ae0-c98b-5300-3c35-71e4.310.pool.telefonica.de
 [2a02:3102:8c10:1ae0:c98b:5300:3c35:71e4])
 by mailrelay4.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
 id b8d09014-d2ba-11f1-9e3f-5b5978544972;
 Wed, 28 Oct 2026 10:31:24 +0000 (UTC)
From: Ayoub Zaki <ayoub.zaki@embetrix.com>
To: u-boot@lists.u-boot-project.org
Cc: sjg@chromium.org, Tom Rini <trini@konsulko.com>,
 Ayoub Zaki <ayoub.zaki@embetrix.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut@mailbox.org>
Subject: [PATCH v2 1/6] lib: rsa/ecdsa: Preserve FIT signing key file-open
 errors
Date: Wed, 28 Oct 2026 11:30:57 +0100
Message-ID: <20261028103102.414657-2-ayoub.zaki@embetrix.com>
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

RSA and ECDSA report every key file-open failure as -ENOENT.
fit_image_process_sig() and fit_config_process_sig() treat -ENOENT as
a missing key and return success. An unreadable key can therefore leave
an image unsigned even though mkimage succeeds.

Return the actual errno so file-open errors make mkimage fail.
Include the error description in the ECDSA diagnostic to match RSA.

Signed-off-by: Ayoub Zaki <ayoub.zaki@embetrix.com>
---
Changes in v2:
- Use a lib: prefix.
- Explain why -ENOENT permits unsigned success.
- Include strerror(-ret) in the ECDSA diagnostic.

 lib/ecdsa/ecdsa-libcrypto.c | 7 +++++--
 lib/rsa/rsa-sign.c          | 6 ++++--
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/lib/ecdsa/ecdsa-libcrypto.c b/lib/ecdsa/ecdsa-libcrypto.c
index c4bfb2cec61..a8e6b8f4c6f 100644
--- a/lib/ecdsa/ecdsa-libcrypto.c
+++ b/lib/ecdsa/ecdsa-libcrypto.c
@@ -228,10 +228,13 @@ static int read_key(struct signer *ctx, const char *key_name)
 {
 	FILE *f = fopen(key_name, "r");
 	const char *key_pass;
+	int ret;
 
 	if (!f) {
-		fprintf(stderr, "Can not get key file '%s'\n", key_name);
-		return -ENOENT;
+		ret = -errno;
+		fprintf(stderr, "Can not get key file '%s': %s\n",
+			key_name, strerror(-ret));
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

