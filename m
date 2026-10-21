Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F15A606A329
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 10:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=MuarvdgU;
	dkim=pass (2048-bit key, unprotected) header.d=embetrix.com header.i=@embetrix.com header.a=rsa-sha256 header.s=rsa1 header.b=vLqkjstJ;
	dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=ed25519-sha256 header.s=ed1 header.b=Q/WHOW6/
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E8C96406F9;
	Wed, 21 Oct 2026 10:26:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q2sEkpxWTy32; Wed, 21 Oct 2026 10:26:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 338FE406E6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792578400;
	b=UZXraNNmqV4f0h/k5Jeof2ALcC9OS47AvovBaqkL3v2CKGA+Fl+Lknb4Ukne4lhF89g/
	 yqDszPbloObgwRr5wPZ2DHyg/tDofTwPyS55vNr1XLKACWzv/K5/XfaoNfJFUJseQifdh
	 EMaedF4055I/JAc/x6siSvWwx1V0pUxUCSnWLNpaji79gfClV0goPM7YM6bYj3LdkMH9O
	 jIetfWv9Zl//txLwnKF726kOJGrEAIj0ErjpfRajjuB+FKGBqS5e1/lR2jt8HYVEpklQa
	 HlacStbAKafwwNPPtsnmV0Y1kr+AFT1Tg3Tg/m+wMLEDksxRJw1BIpix+tkAZwBHwoA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792578400;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:X-HalOne-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=gSNoFZEGU04zNYFD7Q7qQKTmh0ieNT06+wdvG+Vi0m8=;
	b=A9PxjvI6Hgw+dTPC2T/iunM35MV0ZB6B5DCkm0reGXP0BJtoF0B7il/X65z6oQczzrOX
	 PdAfK5ZLCHLdvl4tdBS3gXB+gTgCVz3Al2kxECdoDJA3Yu87iswsw+c0XMCi/XmmEpBBA
	 Ozd3s96J3RB3JcGvQuiWxVG8ug8ioUdQnTyYgvgntZ1MHRvrIRfbGX3mZktN3Cm1aKIj9
	 LuOztsGZYaLryDbyI3ekHDuDgLnbH+r4F7ZVfVXNW/rpWMEE2NGtSHhivt2uAW0DtSErx
	 1fPYD2P8SHp7gzrwYJtEf4+3ZwAwZkwL80Ay6Vo+IKgYA2PquW5S0KV51Lw9VuFxODA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792578400;
	bh=gSNoFZEGU04zNYFD7Q7qQKTmh0ieNT06+wdvG+Vi0m8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MuarvdgU1qSVXvVbqlhx28rBaKKmkOGax7GQ2+qktSRsDGMKfAaX7f40iXOMiZla/
	 e0Onb1W9vHjQGXGTbQp3q+O9h0NfR3qRv46f/P8Qp0OzrSsLeNHoJfDIDOlk7PUw1m
	 57faXK5mZfSl1pCn3r6qa1ewhdypJ4qYvH+AiQoT6nTrKe3hZTlqQHlpSqq2dOsDEt
	 CP4Vj3G5b38UoylqCFwbZPMVvPnGm785vu/IiIQUlThYA1XJK1ssyMxRI/BgEoKOgU
	 Kgifd9XPcHzLGCrSaAy45ppJ3otO8H+7mZwWviphZKhPgLWN1Dj4GTB8Wno0H8Wbnd
	 MwFu2uUhd0n7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 338FE406E6;
	Wed, 21 Oct 2026 10:26:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id AEC781E9
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 10:26:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9487C606B6
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 10:26:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rN0SSabsQfi9 for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 10:26:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 97437605F5
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a02:2350:5:505::1"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792578397;
 b=UE5FIfaZdQEC/sO7miyovJT5MRvnq5LauNB3HD15k/OxLv2dIICMppOZr2Fc1jCQRvDT
 GVKp9Dcd+NLoTfqv1/zabm6muqz1YjAPBPVuoXKVPdfP8Z4bG2ihcKgoIH9tBm8/9q3H5
 c1JW37udTaDRG0OpF3PurL4sbiPwiS5W/pFbqXN8Qo6BWe3Q3PUYsCooo157Y3e7UvhaA
 YTDx27hlhy083FxyDMHNrCrornNuC076zToVz7iNqeuAy1u9mn00mQ3bJ2wZgzTJLHLkq
 JIb7XFOUSyYgEIvDbcr5pWi7OY4zn9npTjDdywH4R1XizZA1sIMOrq9UZTdL0y6hw0A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792578397;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:X-HalOne-ID:Received:From:
 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=gSNoFZEGU04zNYFD7Q7qQKTmh0ieNT06+wdvG+Vi0m8=;
 b=Jyc+ZVp2judbsMcGvVKEvNyA3k4j3mJDUqbLNF+hisecHVOuO6+93wulM+QIAd5onQXL
 VLrK7WpGMNdUqfJvHXBHqUaaUFkacACgIWbxI4WJkQqYBwl8Bi7c9H7d/+lPrsNBRHvcU
 tuRVh7fbw3Grz5/d0XKrjBo3MNt5TZDKDjG6uXiMlFdrm8t776ZDjBFQJr4Gw+Q3OWuo+
 N6i/VN188Sbzw72ITfxZgioQ652dJTWSW0NxoZw0Uw4NClYrpBbXzZQOctzzHnT0Mk6jX
 iPneArqftMjgAYFCjP/oc8+7v3hljuaSz1zgv8zRgJ8Dr6il2oZtmPUmkLvEAzMgpCA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=embetrix.com;
 dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=rsa-sha256
 header.s=rsa1 header.b=vLqkjstJ; 
 dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=ed25519-sha256
 header.s=ed1 header.b="Q/WHOW6/"; 
 arc=none smtp.remote-ip="2a02:2350:5:505::1"
Received-SPF: Pass (sender SPF authorized) identity=helo;
 client-ip=2a02:2350:5:505::1;
 helo=mailrelay-egress18.pub.mailoutpod2-cph3.one.com;
 envelope-from=ayoub.zaki@embetrix.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=embetrix.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=embetrix.com
 header.i=@embetrix.com header.a=rsa-sha256 header.s=rsa1 header.b=vLqkjstJ; 
 dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=ed25519-sha256
 header.s=ed1 header.b=Q/WHOW6/
Received: from mailrelay-egress18.pub.mailoutpod2-cph3.one.com
 (mailrelay-egress18.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:505::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 97437605F5
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 10:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792578391;
 x=1793183191; d=embetrix.com; s=rsa1;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=gSNoFZEGU04zNYFD7Q7qQKTmh0ieNT06+wdvG+Vi0m8=;
 b=vLqkjstJsE66ktLR/bdX1eKiGQRwyTQXQOzOjqj6rVUlRLLlOuMCSAGrZRkF8pqDRY8/mfbNz26n7
 ICddktID4a5S4WbDNJ0U6zFEAupDfKKZij3tHTP+4an6PqkttyQOW/oah4NTKKdIjjUIzXknpyNV7I
 JyCdIFtqRy6+kID4LnuJy0N0mzKl/D364+mqDPyAa5GsmdJvWcsGvbfYoHMmotiQbJFQXfUmZta7OF
 C6oN2jaXL8ILddrxP/HUmP41L+tRTc0noUpsZ4LbWvVRXye1MMJHme4X0SR16FwehQPYL70BoSoRXc
 2sqXTqmSH2vyD+d27AdwAG8bEeD4MSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792578391;
 x=1793183191; d=embetrix.com; s=ed1;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=gSNoFZEGU04zNYFD7Q7qQKTmh0ieNT06+wdvG+Vi0m8=;
 b=Q/WHOW6/q6fpUxkH30MIt72P/Hm49XuQrxmjCl0JA+WA52pwrMXWUxC98K7c/Letk0f4AZlrCh6od
 5nJ1PZwBA==
X-HalOne-ID: e0e80f5c-cd39-11f1-8910-33fc7c51c1c8
Received: from xps-13.fritz.box
 (dynamic-2a02-3102-8c10-1ae0-7f8e-6877-ce5b-5167.310.pool.telefonica.de
 [2a02:3102:8c10:1ae0:7f8e:6877:ce5b:5167])
 by mailrelay3.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
 id e0e80f5c-cd39-11f1-8910-33fc7c51c1c8;
 Wed, 21 Oct 2026 10:26:30 +0000 (UTC)
From: Ayoub Zaki <ayoub.zaki@embetrix.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Ayoub Zaki <ayoub.zaki@embetrix.com>, E Shattow <e@freeshell.de>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 3/5] lib: ecdsa: Accept .key private key files as a fallback
Date: Wed, 21 Oct 2026 12:26:24 +0200
Message-ID: <20261021102626.264091-4-ayoub.zaki@embetrix.com>
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

Allow mkimage -k to use a .key file when the ECDSA .pem file is absent.
Keep .pem precedence so existing key selection is preserved.

Signed-off-by: Ayoub Zaki <ayoub.zaki@embetrix.com>
---
 lib/ecdsa/ecdsa-libcrypto.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/lib/ecdsa/ecdsa-libcrypto.c b/lib/ecdsa/ecdsa-libcrypto.c
index 6a020b84d6b..a1f76ba60e1 100644
--- a/lib/ecdsa/ecdsa-libcrypto.c
+++ b/lib/ecdsa/ecdsa-libcrypto.c
@@ -218,12 +218,18 @@ static int default_password(char *buf, int size, int rwflag, void *u)
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
+		key_name = fallback;
+		f = fopen(key_name, "r");
+	}
+
 	if (!f) {
 		ret = -errno;
 		fprintf(stderr, "Can not get key file '%s'\n", key_name);
@@ -325,7 +331,8 @@ check_key_len:
 static int prepare_ctx(struct signer *ctx, const struct image_sign_info *info)
 {
 	int key_len_bytes, ret;
-	char kname[1024];
+	char kname[1024], pname[1024];
+	const char *fallback = NULL;
 
 	memset(ctx, 0, sizeof(*ctx));
 
@@ -336,6 +343,9 @@ static int prepare_ctx(struct signer *ctx, const struct image_sign_info *info)
 	} else if (info->keydir && info->keyname) {
 		snprintf(kname, sizeof(kname), "%s/%s.pem", info->keydir,
 			 info->keyname);
+		snprintf(pname, sizeof(pname), "%s/%s.key", info->keydir,
+			 info->keyname);
+		fallback = pname;
 	} else {
 		fprintf(stderr, "keyfile, keyname, or key-name-hint missing\n");
 		return -EINVAL;
@@ -345,7 +355,7 @@ static int prepare_ctx(struct signer *ctx, const struct image_sign_info *info)
 	if (ret)
 		return ret;
 
-	ret = read_key(ctx, kname);
+	ret = read_key(ctx, kname, fallback);
 	if (ret)
 		return ret;
 
-- 
2.53.0

