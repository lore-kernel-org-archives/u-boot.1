Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F049E606A330
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 21:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rKqPq9UP;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y9DRbPLd
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8962C60D94;
	Fri,  6 Nov 2026 21:56:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E4uDS4eiPctm; Fri,  6 Nov 2026 21:56:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DDE6560D9F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794002218;
	b=k0tWgYhhb2PTSmx1RoC/VohBmwxuHty99AAfzz80SkRa7DbxtmjTgR3TClwTcN4qzg1V
	 /MqpjT0sYZCoYi8XLIMhyhqoYSvrCP/4j7+1p3ylV7QkLrfuZUOsLfGlA40WwhlEeZDq2
	 M3c3CUAN4+OXTrabH70kurQW8LHCev0gEqTXlJ6py8aSibbcXNkbOWOVDtZvDQPcG7M75
	 RnihYczogT0Ytf1H74JymcnsC8LHyvYj3gG2SOToCNQPeCJptvjtV52l7+7BRPNdZ21dY
	 eyITfkWGJA/T7lU9zNCCj2yrnk7ctKpPXT2C8MC1H2CDC9AjOs/RmvM9s3zmY/lwZ2w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794002218;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Ob7t9I2EUTklcUE4Hlmmpd+ANm22LRmKukaw1bdxe8g=;
	b=LWDhwOYpZzy6cs6pkZa6+zxgDToGCJ7enKztDUhGj8Ry2A9f6XMxWLTtzegv+DBU5pn/
	 mQ9vfPlsgIOXtPyJPBBGSzbbRGdYnSpm9nOUlUSjkplv0Acs2cVBZVTdpRQK+b09JOxKq
	 xHKGklvmwSfUGJOobS9Wqd4LpvmaX/33gEpX6wF/K6yAIeDZa6nMr1sI2yxzLIrtuAsE2
	 xDmtITL1NBeSBNwHimSzyOqjwRdG94cKTC4Vk6ZADRUFCHGh93cYscleBN6EgyOaavpmy
	 YpLp4eRaXaoTlfEzKR6ABOSwNLpXGXmKljuqIZ3oss7cG4m1mCCoKPZ3n3NWDUROZpA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794002218;
	bh=Ob7t9I2EUTklcUE4Hlmmpd+ANm22LRmKukaw1bdxe8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rKqPq9UPMRWeLHrnvS4djMjPlOG/t4nrzRbQqcjFt5XAOGwMOXSIeu7kA9wuxtUNH
	 TFlA7hPex2pgI0F3x5+Q47upZNKktvw1Db41M0uI3JIK5+k13z/oSA0KGHaODjEJaN
	 P+uYzQoPOVkM7JYm1API1TDSDs0/SFlZsU/ssKFWQRAPIGAFMaGVszybAukUsTiaM/
	 tXBDZAErNN+p7oFDTXjd0D/SO/x5+oSoFiX+x/rTCjMm8cpuGf0p3acVZW8858YBpX
	 xgqY9u7QygMkkFP7Cy2qgD1S6AcLZ1Y/AiODXohbEpQSF9oQYlVd2FbFByrh+EmMFq
	 qC9YGfW9PDRbg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DDE6560D9F;
	Fri,  6 Nov 2026 21:56:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 013D01C6
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:56:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E7021409B3
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:56:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pGLT5QYvfDOo for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 21:56:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F2C69409AB
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=Y9DRbPLd
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F2C69409AB
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:56:54 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a2d6d01ecbso7246185e9.0
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 13:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794002212; x=1794607012;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Ob7t9I2EUTklcUE4Hlmmpd+ANm22LRmKukaw1bdxe8g=;
 b=Y9DRbPLd0uR20QD4zpCs3gQwj4SMvZs5LdW5X1UjVJCQnv2priHv5GiEHrUWdCzx5+
 Gejr5P5oJMhVcP+Ucjzdrds9w63zCbxNhUGNqK5e68SotbgAljDNi5x9IZ0Pxh5NbVdC
 60WdKtjTTFREVNJv6e/rDgQaDjME6SehtPjbacMA8rDvEEejW1EgY55YoX/DqI4ScofT
 mBSkfZRw/XdiWi4egP/8T93W9o1zIvQDbkxJcbrpNHESx9wyhpOrMvxI7U4JOjPV50Mq
 m/VQtsGcY9suJD5USc4PvoNOSVmTu6JlNwoNzlxuTUV56KTkFCLH0niq7h6HuyUBAucD
 mgzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794002212; x=1794607012;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ob7t9I2EUTklcUE4Hlmmpd+ANm22LRmKukaw1bdxe8g=;
 b=XWRe2zGoxdOpou5NWznrIhr5gMmMGjVA+k880VTiFtjtibt088f7txpwb3onBjITIJ
 36Rg3oqwc3gzP5hM9lyWg840xsEVd1z/c/iZAXT0kPl0GRNIfBg96HeORv9dC+lNS+Xr
 W4upAe5ysS0iMHwTktEYbQOZzvmMXeXa0gYIs2DY/QLuOTTfj34W1RE0plkUNLAUza9r
 KWTJcYUT8luBWfOkjuAzcs2YjeatJ99FVL1Ih4h0rA1dKyJih2KCrvXmi9GwE9ihNyJ8
 gMkP2z7XMSsz/LDrjx0UJcr4B/qkJjE95IisS5JNFCRbIqOoo32ZW0SyHCp270YbmX2A
 YAtg==
X-Gm-Message-State: APuU4Z9V6zrSi9uvaWcgchs5whSUoix8sx9JuLa6cnVYNT6GOTXWsBrA
 nZKl5R7c4UxW4F+iGY42uaAMnawbTeCCbaile8x+CSFt5j+3eQ2f5RF2U6j02o/lyB8=
X-Gm-Gg: AYBFou3zzOI3ZYj2bZLiD8nW3IXhTCVtpgzwXsyX/RrlMP7bo/qG+QUPzQBCEKJabdy
 n4Cxyiz0z0U4Ff8W4M06sua8U7bG/1n7n0XxX0Dp4gNZSoEYuNnOOAwAOq1JUUNDqj32gVOyImM
 u9K+cVbSbIxGIx07rtDh2f8pY7VP/obRnYHGxPFdnrNorZ7nF7jgcSfCpwiQ0FQSE67GicgYM7c
 v1Tv8PFvqp+miaAx+hOFEeBCLjQpm11Q5LdyxzpsIT+NP+Y98JGgz5uBEShV/z/cdy8p3KGMYaE
 jE8+60cLP6drEqE76I7VtoUvvaqZir65eSvVLWGIY22AbPCswxtp6b+P/qoryO/dmjIU1Zjlu43
 ZU2SdqfS+3uXm4fcXIbTISIehzHVfMcrJcpq5fCYPeB8mB/laCfM1AIhKrVQ/A2+VfILLjLTmvv
 jAjBuaxd5CtvKMdbhOCtZpPb/Vlu2IX1hz33n/0YKpkS4ke6bLf9miSm1Uicg3TwZ4vwshOAVXd
 tS3A2MJNgjXqBDQU0aonSutS84FJV/+bKAdejFSqxzRyp5zM5IQFhV2QgnTfHKPh1mY9jX592P7
 2TKFhq95RUeU+Iliwyh7kJb+z//buGo=
X-Received: by 2002:a05:600c:19d3:b0:4a7:9006:b176 with SMTP id
 5b1f17b1804b1-4b6de788973mr66106455e9.7.1794002212486; 
 Fri, 06 Nov 2026 13:56:52 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b7d54d6f93sm20804815e9.0.2026.11.06.13.56.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2026 13:56:51 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v3 05/11] efi_loader: make room for the PE headers in the
 loaded image
Date: Fri, 06 Nov 2026 21:56:50 +0000
Message-ID: <f459c343-e217-4152-84b7-e7d907d03ae2@gmail.com>
In-Reply-To: <dacef858-56d7-4708-b784-16b0133bb6aa@gmail.com>
References: <dacef858-56d7-4708-b784-16b0133bb6aa@gmail.com>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
index c6e7d5fc599..a9e7fa0a74f 100644
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
@@ -1128,11 +1135,7 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj *handle,
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
