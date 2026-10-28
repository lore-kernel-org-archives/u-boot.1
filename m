Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2C4606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 10:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wPL4eefO;
	dkim=pass (2048-bit key, unprotected) header.d=embetrix.com header.i=@embetrix.com header.a=rsa-sha256 header.s=rsa1 header.b=H909QBJV;
	dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=ed25519-sha256 header.s=ed1 header.b=+rTJg3h6
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C56C680E12;
	Wed, 28 Oct 2026 10:31:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5R7q-QXlnu1S; Wed, 28 Oct 2026 10:31:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F290980DAB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793183495;
	b=O32iR7PgeTzyqMiIVKW9mybdQahIk7gVw9WyTl3NBktI65sn1ukqN9TgjazYLYyf5cJ1
	 9E2qeKiE7fUtoe8NWt2eVwlmFq4gFNVV20KlLJ2dNqagbCen4MTy6t3/P5UajHkpdCxZB
	 awd7S4ZG21w3zaWdQYa1G22Kr6L/qOXdmDGzOYhEwIqt/wBHRns7ksJX1uFLbunefufqi
	 Y8vXsAtVQNimrtb4hqnotGTMWfyg8CSS7rKclgv7Sep+OUN2NETmQGtadz1mhe3q/0p4q
	 B2D0frVE+SalC70mdvqBnv6uXPXA0TkEMAjrf9H5o/R48N/i9K2RKZtbqkJtA3XIv4g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793183495;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:X-HalOne-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=599ZWRJTahPXh+HCPGW0J3UZbg3kWO9GhNntOuHEqR8=;
	b=LmJ5joxC21xzCT1dyXYhvLQTbf6208vKfSSNM92n0VT1pQAQFc0svv3Hs0SoY0rVQzFM
	 /IJ704XLOhKxAGFTDQFSt2/zvS102uf2JWKXU4EOlpgGX+fwSIbh/rj9Y3TCP/Xbnq7wt
	 Bs/rDmVu1w5ColsjTZMX6JZV0ZHVnLaIU2MtBXp8uTQdBReruFKfb1DcRtzc/A4pm+1Bk
	 XZAvwTSnAcgDSw3ATQi9zLLvdxJH5FUSCv9LhDb6xsGX+kLPeO49g6wqwy2i4hlzwGaF/
	 EYdZXuLZ4nM9NJCrEBKC0M219v/xaqWCfR7N3tSlUpmeTGuFWz1WlQ3XS4WA2fDbgAw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=none header.from=embetrix.com;
	dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=rsa-sha256 header.s=rsa1 header.b=H909QBJV;
	dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=ed25519-sha256 header.s=ed1 header.b=+rTJg3h6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793183495;
	bh=599ZWRJTahPXh+HCPGW0J3UZbg3kWO9GhNntOuHEqR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wPL4eefOZZ6CbhP++LBwirDcAQ3AtU5/LmFlD1hgafNMiKQXwzM1EQoRsCq08jH4p
	 htyax6B1gYtFD2iAMy6LxC1kVled2YBbEDcQU7dnJbC8J7VGqZ80sxwW/9q0gkcrjc
	 6lmBeE28JY2EEAjOEhB7bsSG9PXRKaCjlJU9J6oAIgLyrIL8/2hm9fURYoj56TAzZ4
	 1t9SkVfJ44r3QUY6S0CdgWhjghBBu3W9q/AhHC6u3zmk462QRLDv2lWrJ25tYZr+Hf
	 iaFdIPZRWhC33tTiKXTzhr8abZ1B7GS2rH5jetwSdXvmwPO0JSeK2vKxX98takj1mo
	 fw6fP+zfUz0Pw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F290980DAB;
	Wed, 28 Oct 2026 10:31:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 69771972
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 10:31:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4F46D80DEC
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 10:31:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bFem3BFiimFj for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 10:31:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6DEBA80DAB
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a02:2350:5:505::1"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793183492;
 b=Z1tGmb30Zo5VZn/aPtrmeLwdW4ZhVFr0Sr9OSkxOEMpS2s6jSjJFwxDKt6ptCabRf1Ck
 0rBnjll+RX8/8PJ+XqtK1fAAvqi+IUpH+azVB6puiH81CLXSPcUhBXCRA4Z0c5+vS8eHI
 fcFNICUaoZFbqdZXne8UyOPUI2gvmiUBlwe5FpULoqOLidvLIDS5gTkyQmDe5KTd7Ifm1
 xF4lYwubyxIKsXwkQmHrpd4UrvVo25/zRwWGM/bUpYTCg8z1ybk4xgy7e4cpLcWFkRwtv
 QHdNqg6f+PxbLo1SCt85tLSvgyZPITD7zu8aP6UueG2XiVIqubXAPdZqjtUs8wZHmGQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793183492;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:X-HalOne-ID:Received:From:
 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=599ZWRJTahPXh+HCPGW0J3UZbg3kWO9GhNntOuHEqR8=;
 b=rs2RVnw/PTF447MpBwym2t8zKqmnIvq/4dS6c/nzc8Gvnm2fAqm8aEKsoy5gd1KHnpyD
 XjJyIgdjzfSZ+oyD1MlZjzGevNW6nQEmmLbJbmSyBYX2Rj6pORsKi3+JIXOV9Y2TiE5+B
 +cNGdVDHRz5qFcntzupfrM6XaOydELnEytmm44W+d4T/9DlFm7SzZM7KgLifHTTtGxaw+
 S7JcmCfh4JRuq41ZQsTU03gSOfTC/iNRVZbCdxia9Xb8Ry1H+pG4jf1WMNON1PuqhdgDy
 MYgalAN5FFfkdLh91VF6yG2qiOfAxUbT6gOpXD9kHalMhTYDX8HXKoj1amYgWYlEBEg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=embetrix.com;
 dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=rsa-sha256
 header.s=rsa1 header.b=H909QBJV; 
 dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=ed25519-sha256
 header.s=ed1 header.b=+rTJg3h6; 
 arc=none smtp.remote-ip="2a02:2350:5:505::1"
Received-SPF: Pass (sender SPF authorized) identity=helo;
 client-ip=2a02:2350:5:505::1;
 helo=mailrelay-egress18.pub.mailoutpod2-cph3.one.com;
 envelope-from=ayoub.zaki@embetrix.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=embetrix.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=embetrix.com
 header.i=@embetrix.com header.a=rsa-sha256 header.s=rsa1 header.b=H909QBJV; 
 dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=ed25519-sha256
 header.s=ed1 header.b=+rTJg3h6
Received: from mailrelay-egress18.pub.mailoutpod2-cph3.one.com
 (mailrelay-egress18.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:505::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6DEBA80DAB
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 10:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1793183488;
 x=1793788288; d=embetrix.com; s=rsa1;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=599ZWRJTahPXh+HCPGW0J3UZbg3kWO9GhNntOuHEqR8=;
 b=H909QBJVaPiYyTPxwr+jfRozxeUxIkGxVk4zYyoCdmdgn8FBW23Kw2aYhakdHwy87NrtCrrOoTQrk
 YPvu6gRMTBLxmUabffe4CFXP/Xm5m0uHwRRSObT3YwO/yfoJCRGgtmFW19CrhnSKM3u+6waHmCy8w8
 mlT+jsv8+mw+eGK7qVCYeYmQJ7uqUq2sPM3SQExWt+GeYxiBuppDB1AjRYKvYDs/jTfz1cBk3a06sF
 E/KPjuNQP8uUVHSMSDTTX2IA+p9cbczrO8ybBjAC8MUh+lvG6RUa3I296fynhTIqh8+8XDi8DUDJFv
 Om0V7b89NPm0vWRDCvqZx1Z+CPgdGxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1793183488;
 x=1793788288; d=embetrix.com; s=ed1;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=599ZWRJTahPXh+HCPGW0J3UZbg3kWO9GhNntOuHEqR8=;
 b=+rTJg3h6iU6Bf4zJmB14sMp1ZcJLW50bY3MqHa6drNGufyt3k0thN6URwBL2JnffZsVKy0hpfqKTr
 SGH+Q90Dw==
X-HalOne-ID: bb23e4a3-d2ba-11f1-9e47-5b5978544972
Received: from xps-13.fritz.box
 (dynamic-2a02-3102-8c10-1ae0-c98b-5300-3c35-71e4.310.pool.telefonica.de
 [2a02:3102:8c10:1ae0:c98b:5300:3c35:71e4])
 by mailrelay4.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
 id bb23e4a3-d2ba-11f1-9e47-5b5978544972;
 Wed, 28 Oct 2026 10:31:27 +0000 (UTC)
From: Ayoub Zaki <ayoub.zaki@embetrix.com>
To: u-boot@lists.u-boot-project.org
Cc: sjg@chromium.org, Tom Rini <trini@konsulko.com>,
 Ayoub Zaki <ayoub.zaki@embetrix.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut@mailbox.org>
Subject: [PATCH v2 5/6] doc: fit: Document private key filename fallbacks
Date: Wed, 28 Oct 2026 11:31:01 +0100
Message-ID: <20261028103102.414657-6-ayoub.zaki@embetrix.com>
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

Document RSA and ECDSA private key filename preferences and fallback
behavior in the FIT guide and mkimage manual.

Signed-off-by: Ayoub Zaki <ayoub.zaki@embetrix.com>
---
Changes in v2:
- Allow name.pem in the existing mkimage manual requirement.
- Clarify that either file must contain a PEM-encoded private key.

 doc/mkimage.1               | 5 +++++
 doc/usage/fit/signature.rst | 7 ++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/doc/mkimage.1 b/doc/mkimage.1
index 9a2d07cee75..84b2338a7bd 100644
--- a/doc/mkimage.1
+++ b/doc/mkimage.1
@@ -385,6 +385,8 @@ Append a ramdisk or initramfs file to the image.
 Specifies the directory containing keys to use for signing. This directory
 should contain a private key file
 .IR name .key
+or
+.IR name .pem
 for use with signing, and a certificate
 .IR name .crt
 (containing the public key) for use with verification. The public key is only
@@ -392,6 +394,9 @@ necessary when embedding it into another device tree using
 .BR \-K .
 .I name
 is the value of the signature node's \(oqkey-name-hint\(cq property.
+RSA prefers the .key extension and ECDSA prefers .pem. If the preferred
+private key file does not exist, mkimage tries the other extension.
+Either file must contain a PEM-encoded private key.
 .
 .TP
 .BI \-G " key-file"
diff --git a/doc/usage/fit/signature.rst b/doc/usage/fit/signature.rst
index da08cc75c3a..8cd84322ebe 100644
--- a/doc/usage/fit/signature.rst
+++ b/doc/usage/fit/signature.rst
@@ -497,9 +497,10 @@ the path to a file containing the signing key.
 
 The alternative is to pass the 'keydir' argument. In this case the filename of
 the key is derived from the 'keydir' and the "key-name-hint" property in the
-FIT. In this case the "key-name-hint" property is mandatory, and the key must
-exist in "<keydir>/<key-name-hint>.<ext>" Here the extension "ext" is
-specific to the signing algorithm.
+FIT. The "key-name-hint" property is mandatory. mkimage first tries
+``<keydir>/<key-name-hint>.key`` for RSA or
+``<keydir>/<key-name-hint>.pem`` for ECDSA. If that file does not exist,
+it tries the other extension. Either file must contain a PEM-encoded private key.
 
 
 Hardware Signing with PKCS#11 or with HSM
-- 
2.53.0

