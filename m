Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B6FC982FA
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 12:47:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 249D46074F;
	Tue, 22 Sep 2026 12:47:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oYCXLMJeQr80; Tue, 22 Sep 2026 12:47:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 54396605A9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790081258;
	b=Q6PR49pdtsMJEj97012rn+K54XcQi/B1oDqHgFJTidlGGgdQFsDO11pRrnngZitL9+D1
	 oCq4d7zvQU7y0z7IGfjrW9r+8qR8ntC2CG3SbAPk5QzWhV8TVedNY5iO/V3G6L7D+H2ME
	 gm+1zX3zkqRbZpx77WWsOuObqSi8oeNclhMxL71IqgXbu2HmPWVKEKDanOpoXSE/Btqw6
	 UdqnSi8vJRPTuquyR4rCtuWjtam6jWvl33pcom9SIrTJb6PiXRadjiX7XRyB7fvLfcqxW
	 4vaNG2LhJ7qENUzzNOlcYewDWHzfK+GmyEwi/qc3hWbNyq/b5t3bK6ac/LX3nrtnZcg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790081258;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Rcyc9MvE6K9z+t9KPJwGX5Mwf1e78pl7SY5/yMpBozM=;
	b=EV1htskRB0ZXgTbD7b6oxDAI4zRVVB7UYMv3bJFj+sHZBEL8kQAnTH96b46DNC4qwfvQ
	 P2S+MGaut2ZPETKPqi2OjmbNYLq/f1v1CmfGkHiBaGTH/9BtU3E7soz7qQT8TmrnH+3GE
	 dHxgSH/077acU4Fi1o/ibAhojq1IOoUqLqdJRzBDjpnX4QHXs0qHb7fK+E3MOsi0O4x+v
	 nAHnCuw9y5itPe1hixb6LTkqr5Jt5/0eBJ4CacWsLZjQXTWbCnvyaq+eoI9iQjRmi+eGh
	 DRgCPQqWKKedALoGBPKV5pcXaDvNPJLmlHP6aYVoM5B/ZVoCLOgISL4W4NYcUs7MFNw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b="cMKI/S9j";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790081258;
	bh=Rcyc9MvE6K9z+t9KPJwGX5Mwf1e78pl7SY5/yMpBozM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=u5Q3gnbNoyO1Tqa1m4Qo9AXikqB+jOSLurkjiE4b/UxNksrHYP/31e+R1pSUrQw8n
	 y1NvgZm3akFdTK4B+HUfBrSznd2qEzEXI2ea24bETBmNCJuDFVjoVKf8INsetMU4H7
	 PNvZyEWIdAZmEUVnaHUuIUs88u5a1SE0zt6T/xXkpZVmV73413Kg2BARtD1u6rNvV4
	 FrsdWyhWWkVwHlK7A1JizwGKR7G+6EA5mjL7valcLRyhZpxvqwYFLf8X6SfiZmpQOj
	 vIXT7K2P/4tUvU2hPRu1mWpfjBWK/yLxvrVfZEWJ+ebpfebb5+LsA50igmQSSUuRcj
	 9FXYNpzHnvbdQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 54396605A9;
	Tue, 22 Sep 2026 12:47:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B42699CD
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 12:37:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9A6536072B
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 12:37:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i4P-kqV3yZpI for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 12:37:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 251086061D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790080623;
 b=nwyQ4y93vQIrqvu6mh47lNH1RWgNgI32rXz4gkqwBDvVTbykd/ocQM75tV0z7vyd+MHo
 07AdpdYkFcsSKxVKYbIGBIsDCbB3tqcNZZgZB+3o/YCxGCkZuQoYeqVOUfbrCN/yFsvAO
 /Dr6HbQqRmJMfxAcPhcSMSR31G6Nf3fHHqkO/24w2UmKahY+nJCVrbOzeG6rB6q0npj0N
 5I41509sCzxrFdmWjXSNsES3VoAnqBkRzuWKGRKjt6UX4ccuQmilGJubSD1YKR7QdR1Xm
 QEQsuMM7rH8n9+lm4zDBMsv/Ppc9vZBnOBFdziwxRlEz8JCArH1oavxo//u3KVfEtlQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790080623;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=Rcyc9MvE6K9z+t9KPJwGX5Mwf1e78pl7SY5/yMpBozM=;
 b=f3wOUC/wi3keFvJYPjDZMFGXjlJaZrKMq9sE2bbt+h9RjjvzSijE6ifWYBHRhNRQj6W5
 EuZby2fGRSjsKZSIXGDhW1BGB2bT4j3+0/kDFtYrbC6YjveRPEAiQMZph5VlQv3d+hZpq
 +I9ybh2dXbwZfN/6l8tKRjyx/LgduUXwKe71O7wSebbragu4gu79wgmwyteTA26jQejGU
 rigNsr3hSZyMoXs4Kp76ujSmxasyJEXBxWa6zUBQolQbajo1CLNJbI5/QvtKQP+URwD6U
 ogjYkuSJR70Wner3crabWwvTaYb+ir/ZLLYiqNa6NtYLL7xL5qujSTNwcPzR73mSjrg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=canonical.com; 
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b="cMKI/S9j"; 
 arc=none smtp.remote-ip=185.125.188.122
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=cMKI/S9j
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 251086061D
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 12:37:02 +0000 (UTC)
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CFAAF3F780
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 12:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1790080620;
 bh=Rcyc9MvE6K9z+t9KPJwGX5Mwf1e78pl7SY5/yMpBozM=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=cMKI/S9jXOiBAzLMmqAdj5vpHpjXdF1kSByI9TxG9T7MrNRU/fW0eGNM4A+y5iMAE
 Vq+2h7zNvAmhVsxYWmiME+J5pO09WZKKEeEb4pF+HvNCvjirQsqI/yWm32I9NYdRjl
 wtEHdjQ5VvktdxQGm5GHLiXlzNX0jfV/5DENoc/IcGLPf6uspBGC62BqXkyF1C2CeV
 sNVqnfYPIz5ACn+CNK+KEsjJN5SM0ksyEXIDit+x+KrDmgjVSN+p3cjNLfZY6cxGqh
 rwWl3F1PGZy8PgbjuwWwip9PBvik0Yz90owMtCGrlrGQDLofvw79xXWEeUc9DDm8QI
 OnK9HvfpQf0X7UwUc//ND2rjcdnXwwDY90WwlfPEqiY9CLGOkajQZViY7F2GvnPxFi
 F3CSDamHHzXifqlK+03h4aIaLLUm0PXfQDLuriCUCwjy9bjau4v72b4BR6o66mZW25
 +OA5yS+czlEPCiLfgJhF9f3jcadLz2LgsvjeETefBuE4Kf0Dugs7kFL4lPG+WNQfno
 c7g66wXRLgZv4TKsKIQ0I2dacZFGNDUcUL6MH7Dc6UEfHKt34nyDuwwIvqKB6dcobq
 Xo2wWyUeGrLJo+mzNwveYzRHMs2xqV+PR49yuq16AcZmOw6X0esvZcsg2nV4m7wthR
 +/RMTi1mp2ZxzKMpG+NPfHDE=
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2d94a158dc8so71589455ad.2
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 05:37:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790080619; x=1790685419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Rcyc9MvE6K9z+t9KPJwGX5Mwf1e78pl7SY5/yMpBozM=;
 b=pVVDyN+cZoI/BXnLSYvRsKwG7sOVZRVKIv50w5bhcndE5JFPvkxVJ2PZWLuENoknJz
 bKhGh0WP5Uvf1C86bzxL0h2r4O7WwYREdIAwt6xchDWYti+L6UI5hP/4XhE2kqAba8wt
 huGSTaajx1kncz2Z73KFAcqQVryVQcMMqGfrzEPYDk3CCRkO+nMauXlYMaLEH2BjbCUl
 URB1jpL/rV5dmPoRxkZclqq6xk/VwlTZ9R3ErLwHsTWLFO4XEjKNj250zcihLItHEuSZ
 eLO3FPa91Nesabwq2KUA/va+xQPb7tGnqyNfhzUWRBceFQinHpGV/sT4rBAQh0t1cRiu
 HcKg==
X-Gm-Message-State: AFuF++kxTsoFo2X2Sc47wWD/DZXHnw4kl0wfiafxRLc3NxS5hdUvD60S
 exBrV78fpeiY4pKWH8q7drPDrvKCPljxHy4+ZyLpI3SPKaVaSkI+uV1kpDGfOoLLh9qXk+EJatj
 WdWpk4JjKpoEiKiSUnGgdvxTCLFYWH/1fp38mJ3I1TOy9pc4cFcqi5S/dmclaOtMr6DcNx40BbW
 ZeXDm9GGlNr7lDq3hvdA==
X-Gm-Gg: AYBFou1HZR11t7+CtB7JQ54NrosvfbY/YRDgxHzK2E0WVUtfunYfTCEeQLm5LelW9vr
 /j5Wu9Ray/hUEy9EimonhSr9hyGLRC8YqBNtlzlvlQeT0U+ULGyGfSMJtneDE6Tuwbav9hkKZFt
 P6YGTLysDIxo5k+cQtHnJ+UZ5c2otjoC/rxbTArL76xj8lS12FMZ4M7+taaw+DwH0cFR8j/jqMG
 9kKcoV7y+Ij8b1DhleIqsdib8MWeKCZYYsh6sN6Txm/aEe0E010l43ogJk87ssRc23ZKClaCA31
 mu/ioM2k/+sXm7ORy/3Gf2Kdl9S2RRFiPdQaZk+0SfFl21khJrYztDL3R2HX7Cyytr5cw66/VQj
 9IA71+E24Bp3hohwuE6KkCWtmKISxFj8aXmE7YXrktcWHOl6Udq4=
X-Received: by 2002:a17:902:f60c:b0:2df:3461:5162 with SMTP id
 d9443c01a7336-2df60b2edbamr15159755ad.37.1790080619138; 
 Tue, 22 Sep 2026 05:36:59 -0700 (PDT)
X-Received: by 2002:a17:902:f60c:b0:2df:3461:5162 with SMTP id
 d9443c01a7336-2df60b2edbamr15159235ad.37.1790080618612; 
 Tue, 22 Sep 2026 05:36:58 -0700 (PDT)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2df5d058116sm9054105ad.77.2026.09.22.05.36.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 05:36:58 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Daniel Golle <daniel@makrotopia.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Anton Ivanov <anton@binarly.io>, Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v2 2/7] tools: mkimage: use an explicit iv from the cipher
 node when encrypting
Date: Tue, 22 Sep 2026 12:36:22 +0000
Message-ID: <20260922123630.608961-3-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922123630.608961-1-aristo.chen@canonical.com>
References: <20260912124454.13578-1-aristo.chen@canonical.com>
 <20260922123630.608961-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 22 Sep 2026 12:47:32 +0000
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
Reviewed-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
    v2: use the new FIT_IV_HINT and FIT_IV_PROP defines in
    fit_image_setup_cipher(); non-functional cleanup requested in review,
    Reviewed-by kept

 include/image.h    |  2 ++
 tools/image-host.c | 20 +++++++++++++++++---
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/include/image.h b/include/image.h
index d80834049e5..4130cea0199 100644
--- a/include/image.h
+++ b/include/image.h
@@ -1158,6 +1158,8 @@ int booti_setup(ulong image, ulong *relocated_addr, ulong *size,
 
 /* cipher node */
 #define FIT_CIPHER_NODENAME	"cipher"
+#define FIT_IV_HINT		"iv-name-hint"
+#define FIT_IV_PROP		"iv"
 
 /* dm-verity node */
 #define FIT_VERITY_NODENAME	"dm-verity"
diff --git a/tools/image-host.c b/tools/image-host.c
index 46036673050..b9df05d4ca8 100644
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
@@ -443,10 +445,11 @@ static int fit_image_setup_cipher(struct image_cipher_info *info,
 	/*
 	 * Read the IV name
 	 *
-	 * If this property is not provided then mkimage will generate
-	 * a random IV and store it in the FIT image
+	 * If this property is not provided then mkimage will use the iv
+	 * property of the cipher node, if present, or generate a random
+	 * IV and store it in the FIT image
 	 */
-	info->ivname = fdt_getprop(fit, noffset, "iv-name-hint", NULL);
+	info->ivname = fdt_getprop(fit, noffset, FIT_IV_HINT, NULL);
 
 	info->fit = fit;
 	info->node_noffset = noffset;
@@ -479,6 +482,7 @@ static int fit_image_setup_cipher(struct image_cipher_info *info,
 		goto out;
 	}
 
+	iv = fdt_getprop(fit, noffset, FIT_IV_PROP, &ivlen);
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

