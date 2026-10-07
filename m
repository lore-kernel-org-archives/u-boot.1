Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B12CA5FFF
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 19:31:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D4127407CF;
	Wed,  7 Oct 2026 19:31:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w15IG_TDHH14; Wed,  7 Oct 2026 19:31:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 24B3740787
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791401491;
	b=ZwRR10+1LcnRBHJGym1e+Mn1yqlo1W9RI1/9ubfElU2ipPbRoldjdPJgwHCgah50sxPZ
	 lITN1tz+SU1DOuH+Leo+ROOJlKx2h+BWBmxPBl5vPcuHLQwHxAnk3q2D8Ky9rc5E46OAe
	 i5pEziByHjV5apoVJgmFpFzWWkZihz8xaMDLwbLW7nzHQ7AqhccpqUpZovYvxK4StW1Uw
	 SdmDI94jaeRPm9u2y3M3N7XK/mTUvbtlmcfQVIytZVlq8XNbc5+8JRHJwY3uawbUpRaQw
	 qz8M0cALyE4cLXw0AXcOBnmAfLYBR+IOI1zkd0NeQmaNPE334YZgi2k7Qq87wFob20Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791401491;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=QDGPPFESvDcGby0h3wpUk8TFwBkmlsUK0rMKRB+BRG8=;
	b=oFCEIWj4F1RAeRur0omGHgPUVjOl+Dfqh97kxRxIJyshmGQsITkG7Ch7KwTW+QWHvQc7
	 Xpppoi5Bed7aruTlXOzYWJmgPsV10W+nkglPocsRSbhIt/jOSgNtNMEeO4xyTHr1B2eIn
	 ojavFd7v+y09VYIrtIkUGazh80ncUUDivJtiLpYbe1ODNkZDPPhmrsvl2zD1LZr4EQiXb
	 7RaXXQzvMorvCweEq4IEFQ9mN0SKWhdbxkjj5j4utDoooWjfikHsyiZwI/Qhy1+f7m7ft
	 4ixy+gSuGxTX3ZCBKBZZUGMQcjWZRqwiIr44dZV1/p5rEMzQ9aBWlNPuCR1JvUfM/3g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791401491;
	bh=QDGPPFESvDcGby0h3wpUk8TFwBkmlsUK0rMKRB+BRG8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kMZFEeetWmm3lke2a2fIMhBikCQelLT3C0BL/ETpUvRzlqL2jDwN9DuDSFNc/FaQR
	 jJ3TvidxFlLF+MMmRDHoqt7YWgyBwN0AeWZaEQOW4TykM2XGg517aCmQQmP0sLVSjs
	 PzBjEntIYD+Jqha74ftrEJslPbRaxp3EXb4OReKNdY3IOEO6GiyyJRlsMQs1Sfr/c/
	 avR1fEs6OBYrjYvpqOwSiSRO3fpSGVV6Ej7sa8qvEieogasnQdA2ilszTjizkucmEe
	 PTHC2quNHF3n8/Z66bVb7MzZiaOM7BW38UwNcCLX02VY3T7XovHXblX4gRgbFtDVPS
	 p4PsxBwyBEE8Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 24B3740787;
	Wed,  7 Oct 2026 19:31:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B7529317
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 18:50:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9D2BE60807
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 18:50:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g1d_pQc3K2jQ for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 18:50:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3682F605E9
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.120
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791399051;
 b=skHyIHrDVs5d0WcjTuAxvghmb19Mdn4LMlCXn1TRbDt9P99kE9dhG5t1d9uRdgquo0NN
 YhIjWqQO5ZPL2FMgtz0hbtLXGv9l+hllq57CVoj6Uzn51ukbyweyI3dp1GSr8NeqAyRkZ
 Ob/wxM0GxOI9r6mJ/ALU8jH60I+tDoIuwBgT90ApFEnHJA3aongm1nwwW7N3ffKbLhefA
 DJTBFJs0x0UesQHXqGd0u+M0FxK1tzrObr7C0a14NVKB9Yc167duAykYivF7AvTua6m0c
 rP2UGc4yts6cLKxztq2b/j6m30Cm8Uiw8+uCWhuRuyEaKYG9OSm3EzwG4dBmjHQRJMA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791399051;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=QDGPPFESvDcGby0h3wpUk8TFwBkmlsUK0rMKRB+BRG8=;
 b=SS6YunzGQMrVduXNQxjETNssrh5MmTMDqdsjkkk8JmdY+z7vyQmNJNnUSAIOGIShy+xV
 V+hpomxAc518IvC5Iljct0G0LLOk4zv4d4QiAAOzBwoDAQbLg3GGmRHiLHMaaaGCzzsJt
 DvlKuLyU01aj+QCkxS9JXmkW3OcCNo38oWbYc1ZUM4sqOc+HX/uOjb58/OzDMnKyev9gq
 zikcR9oFKwOov9FBqqFfZIf48Z/5tTtJ72lz888+j+xqfFpMh1S2jpPJXbdnjXzm01WNM
 U51sDZgv1uj4Dqu2vV1urjEqPqyhOpni4SbtrAT7tHQzaO6DmXtfpUZao0DvMYe7xdw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=canonical.com; 
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=bxFyUUos; 
 arc=none smtp.remote-ip=185.125.188.120
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.120;
 helo=smtp-relay-canonical-0.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=bxFyUUos
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3682F605E9
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 18:50:50 +0000 (UTC)
Received: from LT03.fritz.box (ip-084-119-040-110.um24.pools.vodafone-ip.de
 [84.119.40.110])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 6C4A43F18E; 
 Wed,  7 Oct 2026 18:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1791399048;
 bh=QDGPPFESvDcGby0h3wpUk8TFwBkmlsUK0rMKRB+BRG8=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=bxFyUUosfR+rdA6lerMaBPsH75JjkiGmVzD5BQ/p5fvky7A7TqxLm/u2OJfN8yy2u
 mbCGDe74xtivyoDHtZdkf5k5w+P6fGP4W4jtiJ8uajbPBg8Q1Rvkmh6dDQv+0Jqfrx
 68mP/LqMs2cK9yH6XttNtlZpl+TNEUDq7Mp9GMxHyQK+dXnn+k6q/RpBUBbPYCh1cA
 WwwpC75VB7+YCGU5aftTb/rQDhxyClfNJj0Wq++0k3lfRAO6W6ZXqa1qg3iHI9WxmL
 1tfvvYk0a3AuvOK8oy+2l80oArtO/6JAb+sue8KgqVWUgM7YOlU676+QMNt+lyHH+d
 BIpxlHEFfPjVUmYqfsYDfhJY1bGvT/kY6QYbqjwBrBIwlosaV7k7kKpYCg1Z3wUO7I
 26w4dCqSd+cYHREovhwU3jeNsx65N7onWuDHdzhubqj0lntXye3hkROFdeTkGRArcI
 Y3upiMDC5aCWwnAD9NLJ39sslhF0djBwpbgRmemJC7b753i+7mmW07ul5eYXynv6gY
 qmCBhjhSTSHVNSWyKQ8nBMxTN2zgCEPzGKp8VSyddANCXv5DvXmhZ9JK952swMnjEI
 o1ay803hpyrkrPQbMQUgrSQp1DeC96F0XbgZJKHelPc+uHof7X80ksZAjFJuPIas1o
 tPYKXfynSYVhLT1mczWqXdx4=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: AKASHI Takahiro <akashi.tkhro@gmail.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH] lib/rsa: require the modulus size to be multiple of 32
Date: Wed,  7 Oct 2026 20:50:42 +0200
Message-ID: <20261007185042.10718-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

In multiple places our RSA code assumes that the key size is a multiple
of 32 bit.

E.g in rsa_gen_key_prop() and rsa_mod_exp_sw() we allocate uint32_t[]
buffers for the modulus based on this assumption.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/rsa/rsa-keyprop.c | 11 +++++++++++
 lib/rsa/rsa-mod-exp.c | 10 ++++++++++
 2 files changed, 21 insertions(+)

diff --git a/lib/rsa/rsa-keyprop.c b/lib/rsa/rsa-keyprop.c
index 8a1ba847dc2..b01f8a6398e 100644
--- a/lib/rsa/rsa-keyprop.c
+++ b/lib/rsa/rsa-keyprop.c
@@ -679,6 +679,17 @@ int rsa_gen_key_prop(const void *key, uint32_t keylen, struct key_prop **prop)
 	/* removing leading 0's */
 	for (i = 0; i < rsa_key.n_sz && !rsa_key.n[i]; i++)
 		;
+	/*
+	 * Our code cannot handle key sizes that are not a multiple of 32.
+	 * NIST FIPS 186-5, appendix A 1.3 requires the topmost bit to be set.
+	 * Reject all other key sizes.
+	 */
+	if (i >= rsa_key.n_sz ||
+	    (rsa_key.n_sz - i) % sizeof(uint32_t) ||
+	    !(rsa_key.n[i] & 0x80)) {
+		ret = -EINVAL;
+		goto out;
+	}
 	(*prop)->num_bits = (rsa_key.n_sz - i) * 8;
 	(*prop)->modulus = malloc(rsa_key.n_sz - i);
 	if (!(*prop)->modulus) {
diff --git a/lib/rsa/rsa-mod-exp.c b/lib/rsa/rsa-mod-exp.c
index 5b3ea02f82f..454f2172d17 100644
--- a/lib/rsa/rsa-mod-exp.c
+++ b/lib/rsa/rsa-mod-exp.c
@@ -283,6 +283,16 @@ int rsa_mod_exp_sw(const uint8_t *sig, uint32_t sig_len,
 		      key.len, RSA_MIN_KEY_BITS, RSA_MAX_KEY_BITS);
 		return -EFAULT;
 	}
+	/*
+	 * Our code cannot handle key sizes that are not a multiple of 32.
+	 * NIST FIPS 186-5, appendix A 1.3 requires the topmost bit to be set.
+	 * Reject all other key sizes.
+	 */
+	if (key.len % (sizeof(uint32_t) * 8)) {
+		debug("RSA key bits %u is not a multiple of %zu\n", key.len,
+		      sizeof(uint32_t) * 8);
+		return -EFAULT;
+	}
 	key.len /= sizeof(uint32_t) * 8;
 	uint32_t key1[key.len], key2[key.len];
 
-- 
2.53.0

