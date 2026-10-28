Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B78606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 05:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Il488DR0;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=myGkizaL
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 26FE680CA9;
	Wed, 28 Oct 2026 05:50:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fM1X6LzcfzHc; Wed, 28 Oct 2026 05:50:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3DEA780C81
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793166608;
	b=WEIU7PnUoM9jq2Dx37HVbOpT4pK2FMsm/01LNcKSScZxTPYnm/N2WszUYmLEW+KFG2oR
	 tctc8Lqxd1/xtMoTJMo3IO/6vK7lItjtN9Tjr9G6MSJofIJmYkBR1+PGBIprcydEajfHt
	 b4/1fMrVRSR81EarVUO64757zYNtRaisXJTKnuP/WGHTKOG2rsCjc+cUzFS2FhFtsm3sQ
	 /tG7IR2QvQ+AaLegW9Bq2XFddvb9Liwook9cqFdZ2EOI2x+LummSbK6UW7sCVdjXKWye5
	 2xlkJibCYR5eFUeqz+iSvtVVTWgt2JA0Dt0mCk5K4d/q6meR09oZA2VPsDJMeatBaow==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793166608;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=92wUgZXjOciXtc8764ja3wNzh06jVIvNls13HkAa8ZY=;
	b=syOFaQ3HRuviZtvEvH8R9C8up1e/UxZ3y0qtyVS0gSzwYEhj9/46bUjkkl2Z73VEa1S1
	 d+t6uwiLq3ZcKA3gPTSX1euXQMNoUzb/JUZpBs2Uhg7IkmUB7ylc7e0GwH8DuX9SXWbE9
	 Sxn8oByofWoPWuZ1sibja7LpcSk/x/9F16rG3W4uQxhf9DbqZhEdh+BaFMaIXwrWyNEcz
	 IEYmu/jh0l8ef31AaSHieNPbvciB6u3Z7Uf3bPus7x2KzpCsIleJ0xfxJkAa+yCg4jiOd
	 noqmzwLdV0g/yoJfozkSo4Cw+ma4FtD1H5iOI7A8RGY4AdFokStAnNxpIpInBV7KkHQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793166608;
	bh=92wUgZXjOciXtc8764ja3wNzh06jVIvNls13HkAa8ZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Il488DR02JxBzLNsXKpW/pyyX2FVaSjtoKy6ZXjthNIzOlnZZ+ZZmGP7cR0cVQuBa
	 uis8aUfwnJVjhvTNPFpDFCFYKfGrwG8CoTqgZKu51IN7EcUgQokbZ8c7HFEzevOSAP
	 GUowpKHuQtvqnhnVpMYgVPuIvjCOV/l1K/X5orOM1kD2P+kbe55kwqmSzxzhdPVDcV
	 /ZwdFEBJHqGXgMIRKRe37S1uDgFvz/LZratkGMiOf/2Hdh6PkjojLC+tpiyZGTYM8c
	 pqYRc3svV0TG35GgROU0B3eCFL88YUHDbtZqi67urOxfbD1ZBy+Gb1wQh+WMKP8km5
	 ngBGrjXMTee6A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3DEA780C81;
	Wed, 28 Oct 2026 05:50:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D93BE2E5
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:50:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CB1334006F
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:50:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZAljTXfTIGM9 for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 05:50:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org CCA994016B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793166606;
 b=gtHde8TPEtPA5Iur5OIN2A4RkHBj1L/EuzA4d5NUgqbTUeBrnzpafXTlAPUIB/lR6YT9
 o3xE6Y/SrGT+oXFwoIssMpEC7td5vP2+t8oyFLiNY7ZmLETkMtKw1/4sMhNhZ9WwDAr+k
 E4njJ1IfUF7MhvK8wr0sgpTGfgxKj9xEYt2zMid/tpqOpvKOmhoI64EoCfmOqaMLVbfkt
 ey670jGFaxg1ET6bbzY10tlM7YFaI6dDB0vy74CzJdtjSC8sAmt+5ckBIpUcQ2jbWLi2W
 24wZn5nwgK51v4BRT+192vtVFfbKM73MRtzNv0UvMH+2aGOZbni9/XQryrM+0FQneIw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793166606;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=92wUgZXjOciXtc8764ja3wNzh06jVIvNls13HkAa8ZY=;
 b=nYW09WKqMx3f+S+rSt100soVii6NFIkkGon9cS22lmbUus5uuQapH9sUl/ii0HXdk72K
 XGgGQ/BzK66IVKWiF/bOunmhf1GqkIJ4Qcnsoq2Kb1OmAMq4nxibvSKwLzA8EwXcpGlJp
 ByddYqqL5cAKFk1YeTLDzz7phGMYkSEYEfg9I2GN2ihA6YJePeD3J0/yV3EZVp7zfjDcV
 qHaW7/sUJ7au6QhVjx6pgvfSNc819x2KGF4b9x1nYtnnGRpq4YsybAvKzJPLj2WFUI31C
 ndF9t76eHq25D0ie7KkPdfLg70CadG/LRO2JYUVEOyo1uYPPB45Vbo3n0Yw5ILBqnHQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=myGkizaL; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=myGkizaL
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CCA994016B
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:50:05 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a208d93758so5344175e9.3
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 22:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793166603; x=1793771403;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=92wUgZXjOciXtc8764ja3wNzh06jVIvNls13HkAa8ZY=;
 b=myGkizaLphahEW4wnU/+hu69HIQoyAHyeBBNbOgf98A017A4DgtcNljEIIpRkcuHqz
 z7FPTOmaQMrMb1Jy7Vq6t4qPBtLG+DFdH+xWhkj+ni4SXriyv7Sjc1j7pPwT+DnNRPr8
 7wuw4p+9jt5jdiwCW1Bkb21PXM2x8+VYXT+F5MsiWKn1oFyg5hzxB4AQw67e4AZr4lNP
 hgmCIttVhm2PYrj0y9XN7mkowjYZBjTn7EaBEP8Jx/tqBs7yVRySXj+I/vv8OXh2jeYg
 ge+uHqFGqf9BNC1HjfGpOCAO/SzY1E3tqdVWML1qOlQOialx5hmJ5P6HeeqKHLWeQ6S8
 ebjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793166603; x=1793771403;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=92wUgZXjOciXtc8764ja3wNzh06jVIvNls13HkAa8ZY=;
 b=A+0NeZn+N4nkG3rw2AzVE2GihKHxEGM+ToWaKbBsRhvJhSNa8q5jcnXbT8TImIiviC
 xQ7/ODsrhS57NoSdL8kie0SRscu4FQWwkFkkRIBMLDQCrytR7IBO+sDXn0gteYOAJ3ci
 fyVRDyz4YVFM2ppcJ5mmOXupBvHnI+S9htqw1HGrghrXRATGOV5YOHWszNMoenloy2O0
 nxaf7j3hhtTjElcB4K+L8N2QUtsFjwubzaXqTwrktZJD/5TDQ7IwRFMPMTw+1whvGlSS
 aTY71APhlMxCeOEHbrQrArm10NdVI6FPXO0By1y925ME9SQPXh/gamnpDcTOKBUu1brA
 rmkw==
X-Gm-Message-State: AFq9FYIQrKIvRnKluSwbZoipRYtA3rmT05xztsukU/Umva8u+90S0oep
 ENMfje9TgjGogI3gEsvl0RYp397dhySDC/3OhYFCxdOIjbYkcwUKSMq3eXUS0Id5CL4=
X-Gm-Gg: AYBFou2bYIKPcLHvECYnwBLEQKDi8F3PwaYIpqPjWfZrokvmmAB9n4j8s4Wx5DfOJy9
 cVcv+1vtfpOy6ewzY+LvKC7lFvU1DbPJ9O8GS3aNmTKAGhDaX8DvvA2sL1j6OJ/qvuxAnVL66hA
 +gZHc/VXOsplU2qWF6BBRHVSknLF6CKRaWJ5T2M/gktcI3TYDqcDOArAIYBoNKrgeJQI0BMbhd9
 ZxybhpRU4YcmaPXrEaBzuMjOnc+ENdZyyFuX6LVOS5mK3YBMDCN6nv5wPeed7kB9okSPig1b5Vl
 vEQes+gsMnnj6ijgCcvVcuh9HfI+knZ1HV8jgykYZsl5mzgtTSId7fwLdVRANY1fK2CtpfmC31B
 HT4aw5PJI3yj1bVnn7jwp3KmV+OG6P8/cg7NLviycAPTzJVptW7QzAN7LDfVUYQozFtSsrLqRFx
 OR6ma1hmG8qvNWrs3dVk8Ppe3AZKM7qDbLATPmaK7XLofb0Dn1LZBSPFGZy4Sz/zb7u8sU5Gz4g
 q2fAaM/PIJPHxSQpKIu0N6F8l6AT9ySIHDYEnlhxXqbqj/8Nn7yz/SN/9uvwDH0f1lU6CAYf2C3
 O629ruFPOO679M/OMFV3KWwG+YqIXtg=
X-Received: by 2002:a05:600c:1da8:b0:4a0:1c10:1372 with SMTP id
 5b1f17b1804b1-4a9677cb18bmr24703175e9.27.1793166603212; 
 Tue, 27 Oct 2026 22:50:03 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a93103e72dsm18066585e9.2.2026.10.27.22.50.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 22:50:02 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 3/7] efi_loader: capsule: check the FMP capsule against its
 size
Date: Wed, 28 Oct 2026 05:50:01 +0000
Message-ID: <5c1c9c69-a5cd-4ee9-a56c-7a68814fee69@gmail.com>
In-Reply-To: <ab256ba2-8572-4cda-b7da-45b2c0368beb@gmail.com>
References: <ab256ba2-8572-4cda-b7da-45b2c0368beb@gmail.com>
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

efi_capsule_update_firmware() reads the FMP capsule header, its item
offset list and each image header without checking them against the
size of the capsule:

- the capsule may end before the end of the FMP capsule header;
- the item offset list is indexed up to embedded_driver_count +
  payload_item_count - 1, which may run past the end of the capsule;
- the check of an item offset adds the image header size to a 64-bit
  offset and can wrap around, letting an offset close to U64_MAX
  through;
- update_image_size is passed on to the FMP driver without checking
  that the image fits in the capsule.

On the capsule on disk path all of this happens before the FMP driver
authenticates the image: a capsule file in \EFI\UpdateCapsule on the
ESP makes U-Boot read outside the capsule buffer the next time capsule
on disk runs.

Check each of them against the capsule size, and check that the vendor
code fits after the image too, along the lines of EDK2's
ValidateFmpCapsule().

Fixes: 8d99026f0697 ("efi_loader: capsule: support firmware update")
Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
Changes in v2:
- Use size_t for item and item_count (Heinrich)

 lib/efi_loader/efi_capsule.c | 46 ++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 13 deletions(-)

diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
index e8835315e86..f57a7e60a5d 100644
--- a/lib/efi_loader/efi_capsule.c
+++ b/lib/efi_loader/efi_capsule.c
@@ -538,11 +538,12 @@ static efi_status_t efi_capsule_update_firmware(
 {
 	struct efi_firmware_management_capsule_header *capsule;
 	struct efi_firmware_management_capsule_image_header *image;
-	size_t capsule_size, image_binary_size;
+	size_t capsule_size, image_binary_size, remaining;
 	void *image_binary, *vendor_code;
 	efi_handle_t *handles;
 	efi_uintn_t no_handles;
-	int item;
+	size_t item, item_count;
+	u64 item_offset;
 	struct efi_firmware_management_protocol *fmp;
 	u16 *abort_reason;
 	efi_guid_t *image_type_id;
@@ -588,18 +589,27 @@ static efi_status_t efi_capsule_update_firmware(
 		return EFI_UNSUPPORTED;
 	}
 
-	/* sanity check */
-	if (capsule_data->header_size < sizeof(*capsule) ||
-	    capsule_data->header_size >= capsule_data->capsule_image_size)
-		return EFI_INVALID_PARAMETER;
-
 	capsule = (void *)capsule_data + capsule_data->header_size;
 	capsule_size = capsule_data->capsule_image_size
 			- capsule_data->header_size;
 
+	/* sanity check */
+	if (capsule_size < sizeof(*capsule)) {
+		log_err("Capsule does not have enough data\n");
+		return EFI_INVALID_PARAMETER;
+	}
+
 	if (capsule->version != 0x00000001)
 		return EFI_UNSUPPORTED;
 
+	item_count = capsule->embedded_driver_count +
+		     capsule->payload_item_count;
+	if (item_count > (capsule_size - sizeof(*capsule)) /
+			 sizeof(*capsule->item_offset_list)) {
+		log_err("Capsule does not have enough data\n");
+		return EFI_INVALID_PARAMETER;
+	}
+
 	handles = NULL;
 	ret = EFI_CALL(efi_locate_handle_buffer(
 			BY_PROTOCOL,
@@ -609,24 +619,34 @@ static efi_status_t efi_capsule_update_firmware(
 		return EFI_UNSUPPORTED;
 
 	/* Payload */
-	for (item = capsule->embedded_driver_count;
-	     item < capsule->embedded_driver_count
-		    + capsule->payload_item_count; item++) {
+	for (item = capsule->embedded_driver_count; item < item_count;
+	     item++) {
 		/* sanity check */
-		if ((capsule->item_offset_list[item] + sizeof(*image)
-				 >= capsule_size)) {
+		item_offset = capsule->item_offset_list[item];
+		if (item_offset >= capsule_size ||
+		    capsule_size - item_offset <= sizeof(*image)) {
 			log_err("Capsule does not have enough data\n");
 			ret = EFI_INVALID_PARAMETER;
 			goto out;
 		}
 
-		image = (void *)capsule + capsule->item_offset_list[item];
+		image = (void *)capsule + item_offset;
 
 		if (image->version != 0x00000003) {
 			ret = EFI_UNSUPPORTED;
 			goto out;
 		}
 
+		/* the image and the vendor code must fit in the capsule */
+		remaining = capsule_size - item_offset - sizeof(*image);
+		if (image->update_image_size > remaining ||
+		    image->update_vendor_code_size >
+				remaining - image->update_image_size) {
+			log_err("Capsule does not have enough data\n");
+			ret = EFI_INVALID_PARAMETER;
+			goto out;
+		}
+
 		/* find a device for update firmware */
 		fmp = efi_fmp_find(&image->update_image_type_id,
 				   image->update_image_index,
