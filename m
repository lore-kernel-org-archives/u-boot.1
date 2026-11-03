Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B0D606D807
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 16:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=W3F4ZAXD;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iLo181RO
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ADCF240726;
	Tue,  3 Nov 2026 16:13:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SKhvx32V4tmC; Tue,  3 Nov 2026 16:13:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DAC8440768
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793722386;
	b=S/VPnvledb7KYTHjKGiJjTdY25Vs5KuqBW2mP/Uz2rVBvCIpSJu4vjEHw3rhTUvpz+XC
	 m7/7WLh++u9Vmkyy2+2Rr9UO5F2PHlq3KR5OGrsg+Y5kuR4GGMkwKgOrVcfkso8JB0K71
	 P9VfYQdE3DX2zEPpSmNEeJ0WReeLstMci15SiovYSHbPiBkMWIRmeg6TKztdV1VVKo9Gk
	 eDjM++04d0W2yWDFPReYSTUepIY4cYv0YMOLV3EqyZgJnGEDmXlp7NZhzVdrBvrh2SEIU
	 3dkEtGhS7yztxCROKo5VqF8ETAHO7aRAlqyI01FGXBCl2oQd6JngMkwmKj44CjnRy4g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793722386;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=swYF1DAvIOqIqgYjpo7Z5T/JYYy8WidmLlDfbWV2O4U=;
	b=PKFaSvp0WorKpWHKY5PO0m/Dc9WveUWeNEbUhW3bzBIcC63j3eHXOgsFQpx5gUUlVeDB
	 CEfZWbGllyNhs/7w6fjGy7HMsuojXShOVFPcXrhuZ4TQS/2NchV9yyUrNW3voNQBqMGaM
	 2RZjMR1Q4gZpqR8I2FYt9Lcbs4owg6w38DJiDi7RDUppAP+0e/tvVIFt8IsXHtC45UQ5P
	 jRV2ev9+YVMuChp2T9PmVdxDWDDAH2RQWtQtlY8XSbN9zaS8QrSNr7GrRhQWnJNSNqBuP
	 oP/24r3LIn8IORcDdxxwvUAgimWNdszz2XGrF3FUXtf0tqYwGgSkv0uyP3bBODWzUBg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793722386;
	bh=swYF1DAvIOqIqgYjpo7Z5T/JYYy8WidmLlDfbWV2O4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W3F4ZAXD6nFaQF0/O8iiEm15T79WspGGdobRdyJAnYBr19QM14LHOEF6v0+Oa9cYW
	 wpeh4c3XoemjpgM+v7rwd40/XEqdJEy1icyjMcvGHBz7PLgrdIYO2IfFVdcGzNVjdj
	 HNNh770KSwXVxggi3YLspogv8Kth3ZwUvxhFR2DLbGBef5adp1UJPtGKM5DdJPo1JX
	 1XQLm3XhEz0pZPjUjRN61jC7JrE6dv6eIMY7e2ClRpmjk6bR7MpCcCQ8wsclDE4/Fw
	 7eiUUu8N0OmtAQMte7PdOyJRsFYnmxB0eKhKIRsZFlTyPpFPZFZIYQuq/twLZXi6DH
	 ZJn+mdmaBiF+A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DAC8440768;
	Tue,  3 Nov 2026 16:13:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id DFD61A5E
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 16:13:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BAE7F60880
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 16:13:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mlA_sEi9cks3 for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 16:13:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 22CE76083A
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793722383;
 b=e+lqf5VtVjO9+oZqFAH5Bru6qdZNRXISvbdzlWJyJg0A50yuK90fb7WkLwqp6yslts9P
 4EgpWsNGcDO7s/zck7HJYKiaj6PBQXgrncL/Qy4kJd97g0CtgoO7ECE1eANR+O9Tyeyuo
 TjJ9Uc2WPoW9YcniI8OsnDbqsUqZO69NYaCQU8xMO2khoE950vPhZI3HgIgxOlUu3Y9i5
 56XTkgguehEQi68InLwsIQCepCqzYiUFI5tXVjJ5FBmA4k58COC3+lEm/SKh4AOFUMd+a
 l20gDpSlnrZ9y+xMzyoJP9w1nGDw2M7rjnvW2OysMfYbgJcNXJfFVeqmRJafvkhUQUw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793722383;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=swYF1DAvIOqIqgYjpo7Z5T/JYYy8WidmLlDfbWV2O4U=;
 b=iD5Ch3ecQygRR88AKrQ1RjEQhrNeB4U0Ayi/JOWxXnj4iuGNsfAJZpv44X9ikFCbwuV5
 lnjOh51I04f3NQI5pb/D8n7qfgmG/kiV6TvFj1ze+IPTDSAB8I6XSDu3lPMKAO4JHNx5Q
 l23td0oW7W7hiJW3cbgSIbL2tq1jl9ApITwt3bkwutpnMcYKDvuVIbnEJSbXvaYUowqu/
 NQG75rWr92O6HkPWIF6/BNuuyIQt+OjUe8OlaPwZWjXnmxXm9wBm5MlQj0Islwe/LTDVq
 +OpBzjAtaj4pRK0pd1QiinVncalRcKfR0C2z0bWuIQc4YcpHpjSl8m+5VHL9HBRyZoQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=iLo181RO; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=iLo181RO
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 22CE76083A
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 16:13:02 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-48c5358fc28so3603607f8f.0
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 08:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793722381; x=1794327181;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=swYF1DAvIOqIqgYjpo7Z5T/JYYy8WidmLlDfbWV2O4U=;
 b=iLo181RO1nuld2tuzOo+UhEl8dOP//rX2Tk9w7qTiC54NfpJCRFxjV0MafJficFCxO
 7rm2sLhrRPK4Uh4IhJK/3g3ORl1ySE24+M4cnvkq3mQXobazHTqkJJ/3GlNE8ftYloOb
 qbZvkxzMhCyVH/kd60fE7PnBFztHCkL9RPMWLfKJAri+dKPYw4z2F3UFSJjMYeV12cB5
 5Aa08w8rQ4m+72CTW5crbG1+1735Ep9L8BGPfi+TVAALrUgXLuhKTuphRNiNTllKNT9H
 lHoplaA+QnWgO1OGIEFNH6TBWLvLufwOANowuo6K9pxa1dVKvU8XcG52FU2yXwQA+sQ5
 Xmzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793722381; x=1794327181;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=swYF1DAvIOqIqgYjpo7Z5T/JYYy8WidmLlDfbWV2O4U=;
 b=sgON1WGxOmw2a0S0+/mP0RqYbZA3ZGehEMArj7T2Mio01w9lfrLTqgFgheXPUNIaaP
 MrYwVJUNLgpAqhaJFk6DJeVs1/5EQEs4XPOnEdH0zULHicEEEoER7OTd/pnMi8neJMp2
 jLj3jXtd1t9i+R2vxzKO62dBqrygFckxccSD6t99TwExff4yfps/owdr9E/Pvov7HWNW
 68GzacYKTJRA0x7PUw84PeZwlyNrWCoOVJUVcGMVfouR1dubk1RxSwwRw0keF6z/Ouyi
 ibNSxcAixsfV1xZS8SYakT8MBPavDObcP49ifFlAU0nRAg28AhN/XBRNIk4RAgIIXESL
 jkzQ==
X-Gm-Message-State: APuU4Z/o6evWc7dULOJ9zNz/NN1SqyayuWYmtQ7CFIbEvpVB9CuI2RKu
 Ta8KaCuc9kalmJDNrtc8FTKAkyWuBtfMNhNIHxEUPXEfQLt2P0Hv8sfNHOeTEWHRTIINflTb
X-Gm-Gg: AYBFou3BYZ6NxDpY02rjj6cXQAloENPg1QpkKjDtj28KMhHsqZoyCTgA/xfpMZjv5VK
 w9gA58w/rrob2gxUMGTOtjLO7jgF6ZgyA4ZAfOoEwr42l1lmJVTmhhk1n9l9vAUrjVPVo+CyqxW
 ta9XfsXbrrXK4JM/s+nLZmTvs+7klAFlwnwz6HQj39DYmSx9lf1vyaLEuiv4kCz987fpEkYA8Tl
 cCKR2Xgdm9ww5nnEespwf+e+Gsxggc7UEvUlk3On1aQQDTXCDDxRm62ik0WlG+0y2NXO58AE1TP
 0u8J1gNr9XAMNb8UjjCBR9MTe1xdQ4Y9WwJpj0vCQi1idb3Jj9IoRNmZRmgtYWy47AzaauWa9DY
 aMltyTNsPMD3osm0R3bROidWiTGVQYe858b9lUmebLjXAyLCeMc5dyZUXw3XBkbAPQ7vwhdsUk8
 xRQtIwZeHF0qbDTnwao6097qyE0eQnZXhXk9ZdfV6BHmhDqXiYIAALDv/Mjk2nqaC3CX2Yhygg0
 dpGpclp3rNLMUxL/FZjbjv5OrsyDc4C2F6Xhbn4wFYPEqrvzds4bf5llkI8UEiIVQshKWtBdKv8
 Yh1q6InW9RY/joMW5g43SaKBgGsvCqg=
X-Received: by 2002:a05:6000:2213:b0:48c:7f18:c85e with SMTP id
 ffacd0b85a97d-48e6e3042d5mr30399587f8f.45.1793722380674; 
 Tue, 03 Nov 2026 08:13:00 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71ba7168sm27716342f8f.55.2026.11.03.08.12.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2026 08:13:00 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v2 05/11] efi_loader: make room for the PE headers in the
 loaded image
Date: Tue, 03 Nov 2026 16:12:59 +0000
Message-ID: <40233c90-345e-4fd3-9233-a51d22bc49e5@gmail.com>
In-Reply-To: <ad3fd084-d61c-44e2-980f-c978ca1e1dbf@gmail.com>
References: <ad3fd084-d61c-44e2-980f-c978ca1e1dbf@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

efi_load_pe() copies the PE headers to the start of the allocated image.
The size it copies is not the size of the headers: it adds the size of a
whole 32bit NT header, which already holds an optional header, to
SizeOfOptionalHeader, and assumes that the NT header follows the DOS
header directly. Nor is it checked against the size of the allocation,
which only covers the sections. An image with many empty section
headers but little section data makes the copy write past the
allocation, and the copy reads past the end of a small image.

Copy the headers up to the end of the section table, which is already
checked to lie within the image, and allocate at least that much.

This runs before the image is rejected when Secure Boot fails to verify
it.

Fixes: 8458bf648fd7 ("efi_loader: set image_base and image_size to correct values")
Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 lib/efi_loader/efi_image_loader.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_image_loader.c
index f9594189bef..1877c164944 100644
--- a/lib/efi_loader/efi_image_loader.c
+++ b/lib/efi_loader/efi_image_loader.c
@@ -996,7 +996,6 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj *handle,
 			 struct efi_loaded_image *loaded_image_info)
 {
 	IMAGE_NT_HEADERS32 *nt;
-	IMAGE_DOS_HEADER *dos;
 	IMAGE_SECTION_HEADER *sections;
 	int num_sections;
 	void *efi_reloc;
@@ -1006,6 +1005,7 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj *handle,
 	int rel_idx = IMAGE_DIRECTORY_ENTRY_BASERELOC;
 	uint64_t image_base;
 	unsigned long virt_size = 0;
+	size_t hdr_size;
 	int supported = 0;
 	efi_status_t ret;
 
@@ -1072,6 +1072,13 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj *handle,
 		virt_size = max_t(unsigned long, virt_size, end);
 	}
 
+	/*
+	 * The PE headers, up to the end of the section table, are copied to
+	 * the start of the loaded image: make room for them.
+	 */
+	hdr_size = (void *)(sections + num_sections) - efi;
+	virt_size = max_t(unsigned long, virt_size, hdr_size);
+
 	/* Read 32/64bit specific header bits */
 	if (nt->OptionalHeader.Magic == IMAGE_NT_OPTIONAL_HDR64_MAGIC) {
 		IMAGE_NT_HEADERS64 *nt64 = (void *)nt;
@@ -1127,11 +1134,7 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj *handle,
 #endif
 
 	/* Copy PE headers */
-	memcpy(efi_reloc, efi,
-	       sizeof(*dos)
-		 + sizeof(*nt)
-		 + nt->FileHeader.SizeOfOptionalHeader
-		 + num_sections * sizeof(IMAGE_SECTION_HEADER));
+	memcpy(efi_reloc, efi, hdr_size);
 
 	/* Load sections into RAM */
 	for (i = num_sections - 1; i >= 0; i--) {
