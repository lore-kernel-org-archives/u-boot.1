Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9154606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 06:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ld6LGtp8;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h5p+5z7X
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A2F0960AA5;
	Fri, 30 Oct 2026 06:14:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bAa_g1MyfYHY; Fri, 30 Oct 2026 06:14:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D66DF605CC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793340855;
	b=PfgBUOgehU78CjidGYjiBufr7ULkzs/zsg95eoGXRtjvYXpGBGuMMg6xd6YO3aiTbUU+
	 yDVLH0fc9sfPKOnY8nsrBF/zVdbolVczp2whaZLWlUR/xJjpimYpc6ccOtOxmCBnbNJrm
	 /Nt0mhGffl7VSAFLdjPUsGsGHU0H6vpK+z8IANkiQqpKIIVxZOjN/Mw6VUFxR9btQgMQL
	 hcoXyOsfMa6NOAmqJToX12/ORRIw6N+lxvTsvY4OYCSHX7OuqdEb8H2PVEfyQdi/e/5V5
	 o+1+qGcu94ZDF2Kb8an/Emv4uaWed8UnV5gCtgd+oqp+yyuJOQbFJBEpwRiDv0vCnUw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793340855;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=82WZL9GMFMTeBsPG6vXQ2RWed8mC/le6kK338PoMjoI=;
	b=YDqrz36z7dZ1MzNpdsttMPnPB6+ffmPDfV+NgEss9+qE3IitEUHnq3nmBc+WI4do7Osp
	 7DHrKIOKJCExTniqLFaNmqRvYRckd7s/wTbpO22ov5TeiAQwxcxprpLwgwakNaR9oSztR
	 72bCdxY7/wOmjS7hFPU/bYtvACy0gInNh6gT8OQ/I9d8PfCMEoo3obz0SQI8mQIqfQYbz
	 vCzzs61vQn0hx8s6bgEZfshbJ3y0uIKZodL17b5KL25/37gx3vLBI1ZSs3z8+lgbYawKk
	 ktwi0yBDfHDR1t9J/2c3bJf67kfyFHimIlUNlBGlkyDTWWLXeffdS7lrmIsk7cyDYXA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793340855;
	bh=82WZL9GMFMTeBsPG6vXQ2RWed8mC/le6kK338PoMjoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ld6LGtp82zuW6gWEF/amt7fYuYemhYLihU4eBp5vw03lEK6GklUF3NM7ALXNC5xY5
	 XHyxHaC9hFMsN+5SZLoNMp09eYHPGbgpNA+n8uZSLC76HXNrmjV9h+4jSLx8d/zCsZ
	 T+1Cj8ynhDHeHmnozJHfPNN/VEcOa9SAgwEI6VG+pRy33rxomLel2o6r1taS6oq7lO
	 IdW1V7d/5imngmyB9S4CXuxwcm9iV4dP8fGQKNAQA1QKrPdcgBb7bnQm9sqhK/J0BN
	 nEvFE+brvfKpdI3ww9/iO2HZDzrG2ruQyNX9stgRN6hnbK6qjctuRP8NWkuJeCWn2S
	 JzmeX503V0ekw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D66DF605CC;
	Fri, 30 Oct 2026 06:14:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D74212C7
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 06:14:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C8BB7810D7
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 06:14:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oF3xTGVejhWW for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 06:14:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CD3BE810C2
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::333"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793340852;
 b=jbpRdehZEx5ay6OKTs6YlCMLKmLK5uUmRqTmbL1+z9orvHykyyT2uLoZQz2dMqe7tN82
 XZOJca3XUQKDsSUrOOBaX7DDTiTo/Nmj775j26UmmdUO9vErmHCwf7qanOa1B/eSDU1fu
 ZOXaWjoI5lLQfgRGBdisOXpZG28hG+5pECkx5RT8Kqfe9tlsxK71AakK0+I1T20lhRcDI
 cKoRMcLhjjRZKFOrOvPQaN95/fMK4Vj9ckq/Up4uoytOhJdGiBdK0C85muljTXydOhnDD
 LZmDSUMwAUvg8/OutfZxY3w8y9C8+ts/xfdIioXSGnfInncgLsv5IiKzRinenIUQzDg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793340852;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=82WZL9GMFMTeBsPG6vXQ2RWed8mC/le6kK338PoMjoI=;
 b=DdRGRFSDGsxk9CmBgo3CxikKPbE13cD0KYZOSkthdS/5kv4iJOp9PP9HVRN3gEgQIAys
 Rr91wMaIXjaR0QqvyuyVIrMVc7MVgC8RmYPVrHESiRLzfAqMdLr40ye5fpJb2DoszYzR2
 c+QiuqIsRLw2uuBHmc9axjFinvCYSLda4NETqpyeB+bxheW4ZdkNkfCGWNXefVGlADvmJ
 p25yulH68wbxbvNDqU12NuhGXEbJiQEcVT7S5Koyk+IcZbf6qOp3o5KGCzi5bsUflyz60
 bfv4mAm3DWq9wUA6WNxH1BPruj72mCdMRnadCkVWyGWcb/rRuRjnVsVk4IzCM/hCS6g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=h5p+5z7X; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=h5p+5z7X
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CD3BE810C2
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 06:14:10 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4a5720b0a57so7850225e9.0
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 23:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793340848; x=1793945648;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=82WZL9GMFMTeBsPG6vXQ2RWed8mC/le6kK338PoMjoI=;
 b=h5p+5z7XTX+Y8CDtygbJXmbe+56cWu/yTowfCRr0U79l0ozrWtEZD9woRnGgCkMCmd
 2GC376L5IG4qsj7ydXY3CgfcmEC49LMx2FON9C7zV2pr2HGSIxTku+lppm863MHsWZIC
 0/nP+oHhAN7qveuoJzbCzxe8pTbluxu5e6AXcicsD3e5PGkTeFPr85nXDZ/dq3hdwdL6
 B4bb03BLC8rBTfPdFglmg8dqCnCB3YCDK9Pjcppo6PUa+YkhomUJwI3o667m+ix3QQKr
 MkgJE3bVfKkoZFk3i5A37EJvDsZnS7M06Htd6L6lCvdjLpMxGB94Aic2wx7wXn2ggtX3
 8qUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793340848; x=1793945648;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=82WZL9GMFMTeBsPG6vXQ2RWed8mC/le6kK338PoMjoI=;
 b=1sYVG+BhWZEXg1wMwjboFtNSmbzqC9GgnEPWBiP5DJ0Tbd0FXK/Cu9H6aNS2Ub5jlb
 COmrHMo8YWaHMSHahZdHhuAW98s30fazdSWmiDszTwjwM11OgNiabRyuzp+icyq0GsmL
 AE8nukbiK0ecoFrgxl8bOnVaeFZE5ZANrzUnoJaZyPgcDc8jaYxkhUuW51MGgY5gtxS7
 Fb/wY28s2aynSL8hPXcsyVFSwcgvJS8avz8mPT1knMl+6sx7U9Lgqy+dWLIMm4zxcv7K
 Sd0zajnbY5WVvuD3rB71J3MA3uhvnWSheQ8yQ1def3++0Jg1NGSCIWRZF7K9qib87iiV
 PxeQ==
X-Gm-Message-State: AFq9FYIQvEqL0+Xm6gprh0Tl12bpNTM22lzU9K6zfjDC0N5ZQNELXWJT
 Q/ADR04Wcvox50lmkGV0W/4QGW/i/Ta10Dkd+F8tMk8kDthWGy7eyETo3ItvfmhSq/A=
X-Gm-Gg: AYBFou1wrpRQfLQZYfW7FIkYUQCPn/lb79dJDePMBcG2vIpktOMV3+ys3a57/YPUe/w
 0XEDW8ShKdF0UtB8LHtZwo0e3y7I13YkiCeQJCUEmLqeTU38lwg2BpsxNfWkNrLpZQhDcha7WIl
 60hYfZ5ajA59JkLajNDTgpOzbMtSLHD57P8yx5RHw5iYJdelauatNXAC6rcsB2DUu+CRnlhWdx0
 Cm16cROOvy8/qFZPZ990ICbBV91f4/ZtnipLYjLhB/nN02xE2WC0EzWoedM5P6IhruNJWpfBv1o
 yKcm6lLQQGOXhGSxkoQ7iRUzuxJUXSq+kQwb7hC07/VLo7nncT04URLcqtbuwN4d3gHz9Aeb4Il
 w+94JoeC8T0ghmmP4xC9KJBFLnzOQHLqgKKQKB5V2ShdH0ZsJ0qO2TfuIzh9pxJ0smZJLsECxaw
 ZE9EFKQhElQ7Xk3vyue28XrAt3AZtlEb0P9FL1/CkLxHgcl9r1pck42I6sEKgvP4KBJAJfVi3hI
 ejDfrYSDya1LvzrkROJ5PMAkPLkQ3fWYINCU+EyG/IS7SqXkDyyMdH1t5OJiFAetiOnlUGpNQHe
 3FftLxl19bm1g3fscMo+Gtk3HPcp7Bw=
X-Received: by 2002:a05:600c:19d3:b0:4a2:526b:d40f with SMTP id
 5b1f17b1804b1-4ac1209eafcmr25457045e9.0.1793340848135; 
 Thu, 29 Oct 2026 23:14:08 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf67aa704sm34908875e9.8.2026.10.29.23.14.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 23:14:07 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 05/10] efi_loader: check that the PE headers fit into the
 loaded image
Date: Fri, 30 Oct 2026 06:14:06 +0000
Message-ID: <07737350-49e9-420c-992d-6a290c2e0d76@gmail.com>
In-Reply-To: <633dddd6-ee22-4cd6-a8b6-cb7df0650fae@gmail.com>
References: <633dddd6-ee22-4cd6-a8b6-cb7df0650fae@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
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
checked to lie within the image, and reject an image whose headers do
not fit into its virtual size before allocating it.

This runs before the image is rejected when Secure Boot fails to verify
it.

Fixes: 8458bf648fd7 ("efi_loader: set image_base and image_size to correct values")
Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 lib/efi_loader/efi_image_loader.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_image_loader.c
index 7fd03ac6211..f9cd2cb274c 100644
--- a/lib/efi_loader/efi_image_loader.c
+++ b/lib/efi_loader/efi_image_loader.c
@@ -1010,7 +1010,6 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj *handle,
 			 struct efi_loaded_image *loaded_image_info)
 {
 	IMAGE_NT_HEADERS32 *nt;
-	IMAGE_DOS_HEADER *dos;
 	IMAGE_SECTION_HEADER *sections;
 	int num_sections;
 	void *efi_reloc;
@@ -1020,6 +1019,7 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj *handle,
 	int rel_idx = IMAGE_DIRECTORY_ENTRY_BASERELOC;
 	uint64_t image_base;
 	unsigned long virt_size = 0;
+	size_t hdr_size;
 	int supported = 0;
 	efi_status_t ret;
 
@@ -1085,6 +1085,16 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj *handle,
 		virt_size = max_t(unsigned long, virt_size, end);
 	}
 
+	/*
+	 * The PE headers, up to the end of the section table, are copied to
+	 * the start of the loaded image and must fit into it.
+	 */
+	hdr_size = (void *)(sections + num_sections) - efi;
+	if (hdr_size > virt_size) {
+		log_err("PE headers do not fit into the image\n");
+		return EFI_LOAD_ERROR;
+	}
+
 	/* Read 32/64bit specific header bits */
 	if (nt->OptionalHeader.Magic == IMAGE_NT_OPTIONAL_HDR64_MAGIC) {
 		IMAGE_NT_HEADERS64 *nt64 = (void *)nt;
@@ -1141,11 +1151,7 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj *handle,
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
