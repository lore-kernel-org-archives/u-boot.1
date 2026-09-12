Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA52C88E53
	for <u-boot@archiver.kernel.org>; Sat, 12 Sep 2026 13:26:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1067F80E1A;
	Sat, 12 Sep 2026 13:26:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QdSeB5sQ3I3R; Sat, 12 Sep 2026 13:26:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4AF8A80E5F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789219603;
	b=K8zjGI5+FRFEjXQFpBY6DhlFPg0+Ic211TLaj4UvwKkAMRliMQ3V40bU1XP4X9r1KhwE
	 jJEFR2IYRbpdZ5B7+Yv+OdWK0xPLUsrAhmZj2i0ByZWm+twYBo0WTsvllpGVljmZFpi2N
	 fbHNogtuUrD16+xJNSMYiynciJ/n5jbDYdGZCj3fU1DTT/1EQglSg7TDGwC4lPPnTFxqP
	 22BD6nIMAHXnh498sk2PAN44ZU6KzKUZfo1CibR0d2ZlSpDKcnkJLfejrdrwhU7vvwNcP
	 24xyVcS6NZ6bYywF4b/d6EixZFvsP6YwziefvRYvK949VwbGmB1tNAiRNFfs7NEBwWQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789219603;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=xHgp8urJ/r7tG1babstze6GLVTMmZgDqsVmjI2bSqJc=;
	b=HmfSanM6OnnWGroY9Z5g7VrHlrsAlKfizOW+SyjhIZW1/V/rcW5ohz62heLgNGuL/vRE
	 bCG+WvAcCOdAPnXBwh5axP+QTx0EBJ/QBVZg7bH456lnwH6ovuguJXTX/ATbNwfw80btI
	 Qv4Lpq4pkGqvL/L4mVV2JVvWG4O+sidwyu1249U2l996lFOCACPj4Vd9H0zI1UNQqYNX/
	 /EALvZBI8sz/Kcf25hz4k1mqEusAK8WHeOJKPwMBITg9aJr+X/KWHdSiRNP98SP4FtH8A
	 pERVdd1FvkgDN7qtESejv6IPDRQ4U59ssvmbASdJ4FUrynNjGr9Grj5KBL7sD15apBg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789219603;
	bh=xHgp8urJ/r7tG1babstze6GLVTMmZgDqsVmjI2bSqJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vIuk7vIPXMTavCnN2A24kPIjb+Vvo5QYeRr6UpsK8UkBywCrlaZPE/n6xdT6DBaR0
	 +y/NkQXmoPxxNRLxJLWpCstLKqoomjdKYW+9v/qE0lULdClf4BaHPNtJMuUfKluEbj
	 nukF/5JVyKUTt/HMg08B/9p1XtpXU35t0OV/TBJG4TzCcsLMwLOuPDSj2cunLH4Txg
	 n6Qnd9dNfkE61kQKuqnaAGkdFY2uZ9RtrrHzRhcAt4Dl43RLlpa/YKzOX150lIn6pz
	 hCMPBaHj+gENXWtmIdF+Y2r/42wcclahuGmv2kNI95FGtZ/Bnjmm+ruZrzsn2lSM1P
	 Rva/+eTSn5jRg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4AF8A80E5F;
	Sat, 12 Sep 2026 13:26:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 252112E3
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 12:45:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0B0544009E
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 12:45:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M05S4o_ISITV for <u-boot@lists.u-boot-project.org>;
 Sat, 12 Sep 2026 12:45:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 7BA8F40068
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789217115;
 b=PpXlJ9v8XKy6sOctlxII7BRAG8yVLYBLWzd4QFJY09/ZiZYruDrmEJvuAI9SlF8RMtH/
 bMLT85GYAZjngNVASZCM9mEHAzJ0GHl7/T4ZpdhMq/6UR21DrzRJo0HLK38d+boqEuYI9
 9t/e+1PTRJitJ+uL8bGpfaCTLam62BMUFB9SH/TrQPyxRZqpixPAQ0cZZ8QKGgCG9u0B5
 BQusBc/T7GixcW8qpTB/Vrr2qzRdbGlu8NU/6b6OvdGZlksxsvroQG4vN2JW+nstjlYVM
 U6hoWsXV8olgIX7hDgyEm0pP4tzKYF+g6Ry3WyW/qfk5pQ6ublHiSmtfMNWSgF+wK3A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789217115;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=xHgp8urJ/r7tG1babstze6GLVTMmZgDqsVmjI2bSqJc=;
 b=bpHxiy15eLv915yrrVFL6kd41I70tdG4Qp/IC5TjwPhs1jGe2PN6xazbuAAzgPYZcr0b
 T1P+CRUm4S92USVdkOMAixpSE6R2sJqufAYNCHKBuYwfgdRJJcZNsIFlPwJCVSGlmFf3u
 c6G79d1Zama77hHitr+g1M2ruSIemJMMXK0yVFxgFbKqhqd4R5swinkCqnOR0q0BFgabf
 vVwXyPkR6xHkxW9Zskd1ZMLUlkBdO79iFHfKxhAuxrCThhAOC20tHdCv/x9bfrskz+s6Y
 ofkjr+/6+ioN32QHBfJeeikFYgDg5AydKO44df6DOaKGgaofKaql2pJNHqNtatd3pkw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=canonical.com; 
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=NggT2CtH; 
 arc=none smtp.remote-ip=185.125.188.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=NggT2CtH
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7BA8F40068
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 12:45:12 +0000 (UTC)
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 849C64012E
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 12:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1789217110;
 bh=xHgp8urJ/r7tG1babstze6GLVTMmZgDqsVmjI2bSqJc=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=NggT2CtHHf8Xpk1DGnYXy8EB2AlDwtrDbR/P7k2ij+gt5739nhDAFZIbvSTJFd8+v
 MmON6dcBxeNXQQ32nVFf+MibvdfioMPaxmJhTIO3rlIGMzxD9v/HKFa+E71duEDSIW
 Snr32CM2M8l7YP7bi2NC/N16JPxREM9h0XXBrbvPr8pVjed2FP7bWOA5xJE2M7QQK9
 kIJM2sa7xpXCXNJ5dnTcieCH4dSfsItwKmxGf+573JVz1A8a2E7DDIsyfTUkFH2ZEh
 FzVBfAEtvuNxgt+MKTp12XLZuLDBiNVb82dM7IJ1SHemdT6qWfKeWOyn0WvTZPr5t7
 36IfFjOFUlctDzSorXb1x9BvfBkGZAXCMw2LgnG4fBYmFQj2teZDxljOBykumURbZq
 BCU2X5v49BR70chG8KgM6GH5bxCES7IbuoPjmGpy4ryy1wnHPE2OvcXNR5WcAndCUb
 B+jqoo/Iajr7SCqzQCtUotqav81B4Lk7Rm2E/x4eWcRd2/oy4rjX+57xiGoyDce17h
 CSt0326Qo6bMXNzZ0UvSj024iyOz0ONePloybyfCVx+ktvcMRCwKhlROghgzx4vJnf
 vUx2tpq7+9Z3PAnoYojJJ4+DpFhVPne8CBMVx7vt/ZRrDLhA6JdIOp4y5JXeC8dmS/
 aXv+YpJ0Kmx6TDysMl91cMzs=
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-86bb318386dso1008187b3a.1
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 05:45:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789217109; x=1789821909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xHgp8urJ/r7tG1babstze6GLVTMmZgDqsVmjI2bSqJc=;
 b=c55m7IVfjqfLeTKAOyTGv8xVgjQzvKoGDZ9N3EQ8TG2GsIkPFuNravQj0rWOo+exVi
 eaIdL4gaGFDcDVK6vDuPr6KTUUUdE3pAUhAZzDAFOkozlxxwv0xl/GpVY+SIueSJjVhe
 c/erNt0ejBwXSoK4mG0pv166Z6FLX46BK4eFfbWTOvhN8FI64rIWSKRlWkVRicw5dOCk
 Zmyvf/w1D9pevOlAyA1jIXghQmIXQJdsCmguh8JMTvlIC2c0NZ6QFEHYviWJHzug0S71
 Qplom5/tnRV8iGnTOZcw7WKI9DWOf64VD+2LJANdMfVhBuwtTZ1iRv8b+oycrM14rdaj
 e4XA==
X-Gm-Message-State: AFuF++kdui0G0GjZmT17YimaEgz+592myAVuVmokHhRXmFM4GbDiJZ6c
 YXUOz2AuuSVDLj04OJvJwcnfrLUFdgGQ28P6asHDxBj+ikU4p6ejCethT1ntZDPbcXlu0+CmgBd
 BdZgVo5lqq41m4uzF/6QtFVvVnTPQuQrhb0wwtAl3WSrzD1a9hSSjp2qwbDhXcsnXZbKDLr62yy
 zqWOmiOCl3ZZk/4FDAYQ==
X-Gm-Gg: AYBFou1UmgCSqvTpArITMWcmpkOfKmxuhKCyDGOgfMlEiwXNRb2+BEVW9b3EvsUCVBz
 QO72C9/f/Hz/2szkVeE876c/gH6VsejFfddlpGk2mqvgBTcVBTWwHUHOBjDq+FYS5/9f3danm1t
 sfcEojIucGVAiHL8pTUGG9NptJlm1/5UNait9G6ZgERykfLb0BcYESqbIZq05EJ6K0v82BIPpnI
 RUBQs/NkdA3xoTBDz+tOw3xQWIbYyGvLWb+7gyWPsRwnFwRq1RpmtfoOFFPJe8FZNAwJh/kEoD0
 lQfevhfM1SmeB2j50BVetS5FcmqXYDrLYCKu/x6qgglDBoZJgIMY+KYiXW6v3yNt4todBzNTGPa
 rMJ4Nx/KMP1QgzU8zX3wPmWt+vzbDICdUIO50KLJmDQ9Q/C0Xr5EVFHdHecijAtpeRQ==
X-Received: by 2002:a05:6a00:448c:b0:868:e6d3:fc18 with SMTP id
 d2e1a72fcca58-86b3180648dmr15875358b3a.15.1789217108878; 
 Sat, 12 Sep 2026 05:45:08 -0700 (PDT)
X-Received: by 2002:a05:6a00:448c:b0:868:e6d3:fc18 with SMTP id
 d2e1a72fcca58-86b3180648dmr15875323b3a.15.1789217108567; 
 Sat, 12 Sep 2026 05:45:08 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (211-75-139-218.hinet-ip.hinet.net. [211.75.139.218])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-86b291c5e8dsm2272101b3a.32.2026.09.12.05.45.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 05:45:08 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Daniel Golle <daniel@makrotopia.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v1 1/5] tools: mkimage: use an explicit iv from the cipher
 node when encrypting
Date: Sat, 12 Sep 2026 12:44:47 +0000
Message-ID: <20260912124454.13578-2-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260912124454.13578-1-aristo.chen@canonical.com>
References: <20260912124454.13578-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 12 Sep 2026 13:26:38 +0000
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

fit_image_setup_cipher() only consumes iv-name-hint: without the hint a
fresh random IV is generated for every image, and any iv property the
cipher node already carries is ignored and later overwritten. The FIT
specification defines iv as the raw initialisation vector carried in
the FIT and requires at least one of iv-name-hint or iv to be present,
so an .its author who supplies an explicit iv reasonably expects it to
be used.

Use the iv property when no iv-name-hint is given, after checking that
its length matches the cipher's IV length, and only fall back to a
random IV when the node provides neither. Besides matching the
specification this makes encryption reproducible, since the same
source, key and IV now produce the same ciphertext on every run. It
also allows images that share data through the image-data property,
added later in this series, to be encrypted consistently without
relying on an IV file in the key directory.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 tools/image-host.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/tools/image-host.c b/tools/image-host.c
index 46036673050..bb042b73446 100644
--- a/tools/image-host.c
+++ b/tools/image-host.c
@@ -421,7 +421,9 @@ static int fit_image_setup_cipher(struct image_cipher_info *info,
 				  const char *image_name, int image_noffset,
 				  int noffset)
 {
+	const void *iv;
 	char *algo_name;
+	int ivlen;
 	int ret = -1;
 
 	if (fit_image_cipher_get_algo(fit, noffset, &algo_name)) {
@@ -443,8 +445,9 @@ static int fit_image_setup_cipher(struct image_cipher_info *info,
 	/*
 	 * Read the IV name
 	 *
-	 * If this property is not provided then mkimage will generate
-	 * a random IV and store it in the FIT image
+	 * If this property is not provided then mkimage will use the iv
+	 * property of the cipher node, if present, or generate a random
+	 * IV and store it in the FIT image
 	 */
 	info->ivname = fdt_getprop(fit, noffset, "iv-name-hint", NULL);
 
@@ -479,6 +482,7 @@ static int fit_image_setup_cipher(struct image_cipher_info *info,
 		goto out;
 	}
 
+	iv = fdt_getprop(fit, noffset, "iv", &ivlen);
 	if (info->ivname) {
 		/* Read the IV in the file */
 		ret = fit_image_read_key_iv_data(info->keydir, info->ivname,
@@ -486,6 +490,16 @@ static int fit_image_setup_cipher(struct image_cipher_info *info,
 						 info->cipher->iv_len);
 		if (ret < 0)
 			goto out;
+	} else if (iv) {
+		/* Use the explicit IV from the cipher node */
+		if (ivlen != info->cipher->iv_len) {
+			fprintf(stderr,
+				"Wrong iv length for cipher in image '%s' (expected %d bytes, got %d)\n",
+				image_name, info->cipher->iv_len, ivlen);
+			ret = -1;
+			goto out;
+		}
+		memcpy((void *)info->iv, iv, ivlen);
 	} else {
 		/* Generate an ramdom IV */
 		ret = get_random_data((void *)info->iv, info->cipher->iv_len);
-- 
2.43.0

