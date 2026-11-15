Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C728F606A32C
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 19:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zyLiibl6;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GPFGSxgb
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A039240639;
	Sun, 15 Nov 2026 19:00:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cRzMEjdWdd9M; Sun, 15 Nov 2026 19:00:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EE6B540641
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794769239;
	b=DDlARSlwNW5owrgB7k7uRFwjtj8Mw9QSX2f8xVslWZAkpqqkxc/ScDab+xisqkptki+Q
	 sNnfMmkPblxkyQxESaeiDwGMaGysWFuODJZQtvhyYHqswIVURg0nhVXONLRCBSDVSO58K
	 F/jZH9rPsyD6o1488g8FfzaFKOQYPqCL/ZjVS6EERCFj5a89JcicUDhurQ8ZthqC7w3NQ
	 brcR8oLNvb9CVdl/lNH1CXCUI6OAyoZuIBzaAkjAHl+yTDX4lf2jK7MBNYnOgqz0WSnXX
	 50KtiWRVlKcNWcGoX5xADI+GwvFll/XAQwxIlBEJU5RkYUsjVc/C0CBLD4Hyz8nBFOw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794769239;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=V8dSAxE8YHbrYQVCREIZgvbnbLGjS53TnRPBXACxb5c=;
	b=Z6a9pcoWzolICbXJnHNqsLFfbHadcTnBW3rwX++L3U/NDtGgZfqjUwNID47mf6ahKFzB
	 2q2bCOgiHAjeMrGcrigBciQJyjLTNnKJWfTS7IgdpHXH/tkFut5VNbGn1N1ze4AEyNQZP
	 r0huHaRu/krJdWCmEIyCvBr5Ghww4qUTSZbqG5sEw4FC7Ejy1ir5i46OlRSnZDqmJ/XL1
	 QcAF1hAxlcHOSm3KBHFuR36vsGj4Bc/lqPhGAnNj4TmdBr+UwxSAt16zaABIrmB1ojfzX
	 NMahlqt0r/IGT+qRKwWyjaE3pPenVIcPGLwItq2N5NgghECbr8C7xufybPKrBHF35yg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GPFGSxgb;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794769239;
	bh=V8dSAxE8YHbrYQVCREIZgvbnbLGjS53TnRPBXACxb5c=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=zyLiibl6abF7r5FOXgtIS6EzxS/V9yqg7SPvSa7AuZyaV+jqG2nrcyMz1Y4x3Rrxh
	 b17xwXaB00qLoZIffO2SGt6QSw3WQW/BNnO8w8KYEPUoNaAoxDUawK/l4qCuqyxSBw
	 dtRM2nXvIx7UD7rXSeXyNbkmtA/rGA6PClr9OE6L5I91eIsa6XPrDeXDMYPIc4H1jn
	 o3NVANdtiOZlN5N5TW3Y8o6jgkO6Yn0UnjiPrdCa3rlpqhW0X4HNgjC9MB2UGz/0bp
	 LWu9EvdSUhoZ8Pj558jVv8b2wsKDmxynHZKWwGCEDOLob55ywp+rDhWQvwYg/Wk/No
	 L18mL72yIyygw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EE6B540641;
	Sun, 15 Nov 2026 19:00:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D45DC109
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 17:12:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C63E0406D5
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 17:12:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aUJJ4XzlOax4 for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 17:12:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0241A40637
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::e36"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::e36; helo=mail-vs1-xe36.google.com;
 envelope-from=georgekola@google.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20260707 header.b=GPFGSxgb
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com
 [IPv6:2607:f8b0:4864:20::e36])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0241A40637
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 17:12:15 +0000 (UTC)
Received: by mail-vs1-xe36.google.com with SMTP id
 ada2fe7eead31-7d2da166818so2373077137.0
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 09:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794762734; x=1795367534;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=V8dSAxE8YHbrYQVCREIZgvbnbLGjS53TnRPBXACxb5c=;
 b=GPFGSxgbwheWSDrlCWrqP0Ey90LFiRKMkx74088iDz5do5+ksmsYO6OFmYeJUfWCE+
 tUFaxutY+lxBdJqKNn79mabwrH4np24XaemWXHt0edg1V/09VGEVjde1wV8yTVWSKuV0
 laVPvGbvBftxxdHYCg9Bgw1rhDytJNbmjMMOqFyMrN7gIWv2qWn79qvPJSkGd1J6OORz
 Z9m62qyhEYPSRCCgsFDErRk6tTHOEsAkogPalcnDohD63gSgm5+eg9GT9K8ZjrLAbgWr
 Uw85lnZG0TGL4zO6cWFqL0ZTMXWa/4di0wEKJZ3PAPuQpOJS6XG3NdvlIPqGFfiiLl63
 2ZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794762734; x=1795367534;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=V8dSAxE8YHbrYQVCREIZgvbnbLGjS53TnRPBXACxb5c=;
 b=ZpSIq/NXT4o6r8Z6TgCtuIDN5D7s7Thogr86R9zpqTu+2Im+unIuDjR7zRRvvUsLhO
 yYUxyIsMOosiz8Mna87YIkrBzAcR3ZkSIr3ZI3YyPBPOxI44rPL7R/6QTw4boNAYFJB2
 yXy1lWRomGRFFbUKOOl4/iX9YyLylKRNE7Mu6PIokY0ME2VsvF+faD+VJ77VWH/uUZlZ
 tJ5PGYIA4j/QvWjRyiLtKeVrjBmLj5MOKAZKR7gQtq5jCZdANAp2C15jFhw+oxYWhYO5
 zSVwMz9jJ2TFarg7o3YXA+GN7glP4uqWyN+Kvw/yBPBv2eSZeFcgFy4u0uJndyIPVyGK
 nf4Q==
X-Forwarded-Encrypted: i=1;
 AL+hErExbnYHCzRLdCLi4lehLoWFaR8hNBtZ1ulUuEAuJVwcaA2Ua3atRiVOS3CjDXJANC7QH+/6biM=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9egcsc9F6BS0wiiqbSQB5d72phvSN8N7AfX98co9ypJP3WKkME
 YrVmG5WvKdqu5QRq19spsQaF2xHkl41mPNy7qpidQHk1bVxDASRSDo/1JXVq4YvLHGliSBgWO8G
 aahK9U/Qq1JiOzmOv9YYAzZXkjsdYxSLm5IA3jNHk
X-Gm-Gg: AYBFou13BULPQgq/81xICVCLqKQtxpTCPZl7B78yK31whNxmG5aLd1Jfz9AGap1WgtJ
 L2ouVmc6sHkmhAwZt87sM/sauQlKqfZxDOQirNA5fYEFoGqLKkZywHqHVIpQSLfkhGr8wE5vDNV
 mG4YN5Km1rYrymUWfJ/Tb2urp2FSSCp97VlLMYB6X3zH4jGDkHYWOfOGwQvKFJTz0bqY0sVloqm
 oOy9sLDNol1m8d4omgOHBY+CqJVJ6LdEsDvmNXSowEje8e+ga3t3SVM/IGfH7k8Q65WBFgcA+RZ
 cp/KythSOe4UOiLuY7amJ1+i+QPa3g7OScD7oXx4t183129+Q7Huti/cyyNc5NgyvWpZ4sPVrBk
 xptbMTutocFyJKum9IB+V+x11YfPVIQ21uTjLzbwH7GRWLpGlRhgMIbjDFsc7wGfX4sPHd4QkQw
 CNuel+Y9SXIk0=
X-Received: by 2002:a05:6102:510f:b0:7cc:3246:3095 with SMTP id
 ada2fe7eead31-7d64d8b73cbmr3199510137.34.1794762733545; Sun, 15 Nov 2026
 09:12:13 -0800 (PST)
Received: from 913411032810 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 15 Nov 2026 09:12:13 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: George Kola <georgekola@google.com>
Date: Sun, 15 Nov 2026 09:12:13 -0800
X-Gm-Features: AclHuK8j0EqRegNMJLd8_6xt4vfUu0tTMioQsdlcFSjWN3yiDqcDY2C2JRJViak
Message-ID: <CAOTQ16L9__jZh-oVkY0xa_tUvh_x8xQE1tsHdHOAQRYv-XXO+Q@mail.gmail.com>
Subject: [PATCH] efi_loader: http: prevent stack overflow in URL conversion
To: Adriano Cordova <adrianox@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sun, 15 Nov 2026 19:00:33 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

efi_http_request() converts the caller-supplied UTF-16 URL into a
1024-byte stack buffer url_8 using utf16_utf8_strncpy(..., 1024). The
count argument bounds Unicode code points rather than output UTF-8
bytes, allowing multi-byte code points to write past url_8 on the
stack.

Validate that url_16 is non-NULL and that utf16_utf8_strnlen() fits
within sizeof(url_8) including the trailing NUL byte before copying.

Fixes: 238e0269d82f ("efi_loader: efi_net: add EFI_HTTP_PROTOCOL")
Signed-off-by: George Kola <georgekola@google.com>
---
 lib/efi_loader/efi_http.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_http.c b/lib/efi_loader/efi_http.c
index 5c6367a9e5..f61b99685f 100644
--- a/lib/efi_loader/efi_http.c
+++ b/lib/efi_loader/efi_http.c
@@ -237,10 +237,15 @@ static efi_status_t EFIAPI
efi_http_request(struct efi_http_protocol *this,

 	current_method = token->message->data.request->method;
 	url_16 = token->message->data.request->url;
+	if (!url_16 ||
+	    utf16_utf8_strnlen(url_16, sizeof(url_8)) >= sizeof(url_8)) {
+		ret = EFI_INVALID_PARAMETER;
+		goto out;
+	}

 	/* Parse URL. It comes in UCS-2 encoding and follows RFC3986 */
 	tmp = url_8;
-	utf16_utf8_strncpy((char **)&tmp, url_16, 1024);
+	utf16_utf8_strncpy((char **)&tmp, url_16, sizeof(url_8) - 1);

 	ret = efi_net_do_request(url_8, current_method,
&http_instance->http_load_addr,
 				 &http_instance->status_code, &http_instance->file_size,
-- 
2.56.0.611.g1030f0b940-goog
