Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A532A606A33F
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 13:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=M2nL7XNh;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kaUU6HMv
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7F885406AB;
	Mon, 26 Oct 2026 13:19:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XoIIFryLM-XC; Mon, 26 Oct 2026 13:19:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B243F405AB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793020757;
	b=J0saH28wmZOr2JZcFHUR+8j2wPI4evI+rOh0T7it5QccFkpimhCpNy+9XS+W4ouSMu/c
	 98MxuEBP/IK+8vodfOWDWcyMcq35jlRS1o2d2fPKvKriZy/3fBpQ7/tRDMxIpoNWlKPHX
	 vhXHWOB6EltPIMAZhimkbhF8IkNLvHGSbiN/aESHJIUaecPW34SoluIOmDzTHLCQ0WC7r
	 z3HrtiFdXwCeNOJhqWzhn/29s9RNKnfiulOkLeyuruAh8oYbRiFtxP/90Ry7N7BZzJpJ7
	 +7wfrzhPfQ8QkZldTqgSJ1+BHzuhMHlQ6eCLSZHP9htohUVLvHRrI14Z+Dc1CNA9IMg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793020757;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Y8vYfBrTq40toBaQvDy/ssF1R26449Bl4PS9PvuZd4g=;
	b=gvQmmo4eTd2b2ckTbgSauQ6Wv9J/QqnvBTiklq/xlzVF31rmO1skYAZp1DH7y26Q/Xm+
	 AaEkuBy+1YHX8xXnQx7W1vZ89ij8UsqaDKwwMlWSorFKdOjBel+ly9o+7ofZOL17O7zZY
	 Nt0NbyEbUdH0QZAbvCl59G/BWIVz1GBZizfvAZko8Za5lZ6AcS1eLS1NLzJDv15lyFKFX
	 GjVtcD4iaVDnveLrEvmb1nLD8UGK92fsC7D/K9aYLNnWHPq+f6v3yIovc7mK36xLU4kZG
	 SbwlE59b0YWcv+Sz+SFR5zTwjkgZyUKPtO/5KMAWg35kA5ygYn8r/DbyKPHfIsEJRDw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kaUU6HMv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793020757;
	bh=Y8vYfBrTq40toBaQvDy/ssF1R26449Bl4PS9PvuZd4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M2nL7XNh5MPnFVKyt8IeoNMhkaO0LsX/jQfOT0g7iD9B99P2NFMTxzdoQMgieT+gV
	 oWJ0T9UcbZ2dQ/53kK1lF4vU7vNhuyTsTwkVQq7480JT8/zQpqa+xqdhrCu7k8YmQJ
	 SDv5Xv12T/CzBhqB19/tYElCKtdllCNbSir7zU+j9PnDWm4DwqswDa+p6Jm901vBF1
	 Tn6KKHAnZfB0ImybIm1UyKxD9kUO2rebK7mOvpN6E2ViQzXqeija/ilqdDZJ8eZe7o
	 u+3VyaDJ6ry/9Ue8jGa2LD6cBNI0eYciiQl61arvIbR2TpbEjK+sj3J1V1u42MgO47
	 KjQUmb8Iw/eLw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B243F405AB;
	Mon, 26 Oct 2026 13:19:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4224A4B8
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 13:19:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 33EFF40695
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 13:19:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1RsY7UFWhcHu for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 13:19:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2FDBD4043A
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793020755;
 b=O8ShTchJfFpA43qwgMKzHuPSrplbhcvnQRn1kqr24xKCZKDAkzelw5Rk1mkN029D4THA
 veIiTuZXnoc/4u38CYVGs8AJO9N7AEaRZJz2ceT7kI7jyImFkkuFT+T11PoX7gxVweF4k
 WYamCKgIZQcG9l15mcbwVn3tJ9LzP2msL7tBevi7QI9ARUqvXDhbLuSgv16cw2/iom6mt
 N2OGxYafViS/1IcWBQSrGvIbrW7oRhog7tRtJ6SoMjblW76Y8DT99G/8fYhXl6+Vnxlwu
 SQz4u55itQkPWfihoQSovK8iYtJDZKZzodyHMBFzH4QqwL/YLTh6uZIxF3RqIaPxPHg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793020755;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=Y8vYfBrTq40toBaQvDy/ssF1R26449Bl4PS9PvuZd4g=;
 b=fuAW82Tro075pyvv7TbOMUaflsQY/IbLf3/tFOakvbxFcw2NDgfWa1wVb30j5Mpn4EWo
 Js6lopPqOSd502wi+899ZjmQkAArnZ82Vmku6hSPmGF4tHlkKuVlKV3PP9rpyEIDpUJlF
 Z7i73n2gVWlX7EWOwwiHB2sRbQ4g91ML8+OOqgUxrvPDzX1zSL0F/fNfeBZkK3QQEvXI+
 FXUmoNsf+PoXCqkX53jMtlOGBl6pFrgdMLO/IfFtJnlMPbn7hiYq3FwCLcLFRkUuCHS01
 rnjOsRCPcRoQtz950uZYLQUvo88JFXl2LKauaD7ZnbzlCZFz4jWJ/lfws6/OKLa8vbg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=kaUU6HMv; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=kaUU6HMv
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2FDBD4043A
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 13:19:14 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a35d5d4a20so17797255e9.2
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 06:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793020753; x=1793625553;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Y8vYfBrTq40toBaQvDy/ssF1R26449Bl4PS9PvuZd4g=;
 b=kaUU6HMve31KQ7PuAM0T9i1Ulgs4QtsoHrmoiZfuqkxyYFVLfGAx4l/CGDhQ4UfUbZ
 xxGx7wpiBYPAEJAPructJKwHxAaqZa1mftd4/TErtqmzWM1h9nK6t6XAo/Kn9ffMUI9p
 ujgArwMUF7mGeXMwfFW6rBMPYR2LEWtwwu9g2DB1irH/Ie53XVeEJkbjgwBS2ymEZ5hi
 28c3risx26DSiraeQ8wgPrpPpOlxFsTzuTR2e5oWwP6IfdykhDz+0RtEQiyfXuMRdcSK
 k8aCyhZJp60QFbpuqRMWeuT7C7U3NSYB9eyxufDrMIHrG89D711cg1zwhCZ1DDWGQE5S
 ODtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793020753; x=1793625553;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Y8vYfBrTq40toBaQvDy/ssF1R26449Bl4PS9PvuZd4g=;
 b=cPe411lCsmN0iED92nqyMsKpBn46BDyp5Vee+mVImocKlPGFCSgyJEgQfJhsDsvSbp
 k6237LcnA0qHwAxmaI5R42hUxp9svw5A86EoqwmEu9k8ZXo8fHe67vDcaaCe2sZDwXKl
 YoKRFvwoj+oOf/kpoaFD6OXoU1RoOfFfor+6JxGTUtun8y0oMMHpeC5VLv+WJ1gVUCQa
 44/Q++mm21ICkPHEEF3pFB7ZTAjNGMZsiRPJzc513q5VbK6Zr0v4CtTyyr+YRk5zUACW
 FgqMQLwWG/eqc4nkLYL5P/5C83wAlgQW8UnS/IaBME1fxvy428EBGTSnk/oMxkKfjha7
 KqCA==
X-Gm-Message-State: AFq9FYIS4Hd5MtpmqY7sLM96zK2lfVHFFzzg9mC72BbWPzqtLmKcHmID
 stecKvNshVSa+nZktJF1NsIK9qy7J5lsszAsBKnwMrKq2bBTAxPNAOsCdg/t78qB
X-Gm-Gg: AYBFou2bFHroRu088mC7FQdoK4JWvhYzqto2UPIuzh5+vbBjVqAZHNQpZQXbyFJfts/
 aDSq9/dcSLVtE4N1AasOjKbJhNolUMG74rJBTDMEKt5ONKXifeFfPrbHNqb7mP91XCR8MAyum1K
 5vTfRr1sz/tWD5C4w5TkYiWOsy9rpNhXvvKH5q0nBlM/3nH388frL81nc0XcHUMH3yMNf/GL7AU
 9EtFWeU0yirXkK2V+mqjRHT+a92zXqO0Kq9mvYN4kgjq4g80JwCos+q/A1NWOySD2yd7rU7gC8t
 CPP212E3BfCONRKkwWesZ/zIC1X1bbHKca3Y74U/jPMXqZWL0BV98Z4Vlfr4Kf6B8crbnmHQtT9
 RtkAa1M9Uc/higuCFu53gqgstgdb3cGBV7pEQ/7U1jXwG/tzX9OMNp+QLIw6ji9RjIkNNumECCC
 nrox1VNM2rYrlUNgsilBiqJqFxCwUUROXirH3zpSsAGgEKOtsVflc2SZoRwKKYa7lSyOSYWf05Y
 LsZm1yLaNXdggdTJ/TgidluVYIaG+f4c0XQ5UXIsb65couXJFkuxP2LdA==
X-Received: by 2002:a05:600c:3c98:b0:4a7:9006:b176 with SMTP id
 5b1f17b1804b1-4a79006b1a9mr3777335e9.7.1793020752552; 
 Mon, 26 Oct 2026 06:19:12 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a2ed5a2sm206600525e9.15.2026.10.26.06.19.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 06:19:12 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH RESEND 3/6] efi_loader: capsule: check the FMP capsule against
 its size
Date: Mon, 26 Oct 2026 13:19:11 +0000
Message-ID: <475a43be-9eb7-416a-a501-77f39f9d94fc@gmail.com>
In-Reply-To: <f58ee8d2-b69f-48a5-99f5-a1bbcd3a920b@gmail.com>
References: <f58ee8d2-b69f-48a5-99f5-a1bbcd3a920b@gmail.com>
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
 lib/efi_loader/efi_capsule.c | 45 ++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 12 deletions(-)

diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
index e8835315e86..a8d57630a6f 100644
--- a/lib/efi_loader/efi_capsule.c
+++ b/lib/efi_loader/efi_capsule.c
@@ -538,11 +538,13 @@ static efi_status_t efi_capsule_update_firmware(
 {
 	struct efi_firmware_management_capsule_header *capsule;
 	struct efi_firmware_management_capsule_image_header *image;
-	size_t capsule_size, image_binary_size;
+	size_t capsule_size, image_binary_size, remaining;
 	void *image_binary, *vendor_code;
 	efi_handle_t *handles;
 	efi_uintn_t no_handles;
 	int item;
+	uint item_count;
+	u64 item_offset;
 	struct efi_firmware_management_protocol *fmp;
 	u16 *abort_reason;
 	efi_guid_t *image_type_id;
@@ -588,18 +590,27 @@ static efi_status_t efi_capsule_update_firmware(
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
@@ -609,24 +620,34 @@ static efi_status_t efi_capsule_update_firmware(
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
