Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB40B606D816
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 16:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=C8t051qk;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pJanRN64
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 848B9607C4;
	Tue,  3 Nov 2026 16:13:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gBtVWgyHkmhk; Tue,  3 Nov 2026 16:13:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B963E6084A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793722387;
	b=P7ieSzRngTcPcFJ15IxoYUoI3hUU3n7cIty1q15oOTnsmSaTjPfENlf/uOhtDUlzskW9
	 5jYzQa27Gc08Nw22J4C1NmKkuQ/YoNkspmZW9WABc+kIhR8KAcPzj/GzsgIBmBamBOaOg
	 8UFWxcoO3KjL6mF4rdyCWPDWmL1oUnpRmFGvqzAXoEbeZfs1q6oFO9eItfwCCxtTODqMJ
	 bWKA/62M/CM9wDzoq+ZzME9CrnB6JMxg9bccNb+WbM9hbJjTVevcGPEfdGaYioA1kd79d
	 FZBZG3Jk0OgjYgj9mGgAccdgwJjji81hMrAzngJsi8ol408rqN9iond2lHLBMKn0OwA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793722387;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=uRhl4P4SyUuH3C+I9MR07uDydvGJabu4U6KKiIqsPjI=;
	b=OnMRFacA3dy6R0OAwuNkP/VrAdc1lE1U0lDwsN2Qgr8FZpsSe9Ic/X7QorO+Bm81qThK
	 coABzgl2OsBAn7XhI/Lg+txLjxIgTePsxDI38/5XvXrGbKG6L8GKivf3x3N/Gf4bAC5dJ
	 Qn/UPQbjpSIr5fpRVMlds5YTvEkuXnsQZckP0APLCMXYC150VNxcuYR71Oi5H9Gn4Kbfa
	 K5xMo4Xl+nqwbhv77dFW6iW9Sg5F+eNfIHdAXqR+m0nWhqvA0gyckrpk316P6Dh4tAYUR
	 nZbSlObgcsjzI17S8KdN/vzCTKxUF6x+wI0brf9lfKlSNGjpEZcXxtWbqwTlBSV72SA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793722387;
	bh=uRhl4P4SyUuH3C+I9MR07uDydvGJabu4U6KKiIqsPjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C8t051qkauz9QI/0tPVpn6l6XMb8eUab0l1EvqqZgJ0cR5nW0kN4gNpyh8SqMR246
	 Uia31KDezA5Hhor4Vc/MNwvN8S778VyZxsUZMAnfAW84isqBuei10cFB3U0GWJJ4E5
	 5tafy2Q9VmBMD7np+LT8+agrTwmDANRaVfDsHGoXT0MKCisELBw5IUPG2PTf5y+EI7
	 dLV6stPDvNP8Nqb6RXN8uQvAyI7gYNWO0g8lJ6qSidJhP8qIuAGjDl5PlCoAwa5Wwb
	 r0N7Se8hm/z1whm2rntC3DrFOLPCkHjqlwu4g2o4xozjvEyd5TugoUr6boRczSZG50
	 AtKfISK31i2QQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B963E6084A;
	Tue,  3 Nov 2026 16:13:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2BDF7D3A
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 16:13:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2795540762
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 16:13:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G9X_2vlZA5sx for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 16:13:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3E7A940760
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793722385;
 b=lKy9+i2+YgdhWYQs7TDwRcumwQbrXMdo6FTJ5xCjg2cImhDyA5pDi/NBQsL5L5sYRpW2
 ZrnrRD+1jYnTKCq2AZO8ggrYSUnQSYsgRFoDfTO+a8V9si9+JvAKze6vArBaad+yPl27R
 f+Hn8wf/srt11+xj4Ao2qvkzCTdR2WQVdvqVYLBGQelhfQdBQMA/LMYPhUhLAXRqmJclU
 XRMgvn5n8bg6hcz+oq7zgaL5Ci1+R3grio6+Ff408oZJcz2fZu+jyo8MdIZkgh56wPpM/
 5+lgEITcJrWH7Rzf5qibvYNOCR8omf6WAs3dCTY0SA0QoVd2rOxJ4cIhYzHRewbWjUA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793722385;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=uRhl4P4SyUuH3C+I9MR07uDydvGJabu4U6KKiIqsPjI=;
 b=efcldi6z1VzropKIdAOSK3xOEXE3MfHT7HNrwFNQihlHhH+UeLvUSEyoEnNWzntqrut7
 QwShyVNbNbYNCE0gX5dSK0FDcVGqT2AMwsGhU8jDJ3XPPO3G1tfM1cXUsPGdSWZYuLpg+
 +mFbsBDNxtFmzB+ZgSo3niuaZzZou/O4/Eirre3I75l7/h2FaAqotny2neFEA0lgfTDRO
 xvekwwAUpu/RHbN7aDxEL7dIelWjgGXF06/UcNOmS1HUYg4qbrwDjtvk0/MFR4AqPoAmD
 RXgAruxeoOVQTuKWJQjkmSS044pDVnbcj5fjMuoW4/IruhIY3nIExqUQmS6D+rVhG9w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=pJanRN64; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=pJanRN64
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3E7A940760
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 16:13:04 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a35db1f202so45713715e9.3
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 08:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793722383; x=1794327183;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=uRhl4P4SyUuH3C+I9MR07uDydvGJabu4U6KKiIqsPjI=;
 b=pJanRN64hGVaZaiPHFg8iXdII6SCj1RpVnGgve8C5LDF95XqdFc0yZxc/Pc06IxHsh
 2TWoPkS/FP1NhsPaO0ziuDLz5OLlCq9cjLiAHls+029kWUzSzyIXcXGrhE4eoqU0NaPl
 YOYqvTFOs2whFL8+XYxv+5Jmf6Hm04k75Yl5T3tyQ2DSPn/kmYBwMv758Ndj4dJKYIzf
 MWK1+lpJ0vrhB3r9DeTf3XGUO9IyJvH4RVNSLAAu/cBZMqid1Hi6VHmHnSNvbSiyxV5L
 WGblZ7RwcppP182oKjRwLLO8BmEpzqOBoIUTqxtwwNm5+MfEFtG5hhHXsX/uNEhNwSJW
 XcZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793722383; x=1794327183;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uRhl4P4SyUuH3C+I9MR07uDydvGJabu4U6KKiIqsPjI=;
 b=NLfc90n7+3sErpln19x9M71DMKqkQXDULJ5BhqIuxkIaDPyrj3Pb4wD4g+TZI1B/d/
 puSJPlsuZVQAs6vtSorB3wxliEAeO3tOkNT+isozDVETlYy6jzd2KBo7sIt23dkV5Be9
 o6ZyjPPE6CXlzguHjjDGldxWhho6xcf/R7X1IBvaSVtDNZURKyy3zwsU8g++WCvMKBGw
 uVmCWVvzywXVaj37B+4ddcEBtjTAGf+UJXoBWeoI21yCJZwEcE5Zk0XudynrZ3Cq25OJ
 /MhFPelhVnyoNmVvl9JYT/dqflw47SR5mVxiX/WriczsqeN1lDLSPdFSYBUz54uaxiMT
 /9ew==
X-Gm-Message-State: APuU4Z9NR49A7wlyGgNjQp0Ho6tZJSmY3WVlIF+4Pr6GgzFwO2t03F0T
 X0j5u4RGWM5Vvr6IuQ0LYkj6VJqhKvuHAvkMmMzTbYT8xEYgqfWTxUhdtQHZyT6sBdDEqAqJ
X-Gm-Gg: AYBFou2sJBUrMnY+euhD70KynpEYtxPe8v9xSNj/YOz/LYYfE4q58bM5K8gYjC7coKd
 +euyq14ZmHE/0pKvQNKKDzXpTS0ln52suqOTEGBRmlSQrQVfrFlEjt+G4MIo5Rg0fEaVEzd7iWX
 3HcJQpXljOmfMpVL2IaNznWeBo/yGlk5DOWIPPiYoebeR/uXz+x80HVezjj8cD+Wg3lgfMhJehf
 8bnRUf9tvcKiZmnE+9IDzxhQUZkdgbrfu1mmY2Rrq4Iq4WjDTMwGvHapP7UK1H3M21//XIEKmD/
 TZuB7w6V1pWPMjwz4pjZXJhDAD+FmQLqdQlMtkof83kxRITcyWIMxs/JG9x+RddCV4ArQg0H+rf
 vMpTCvIueTB4Kp3EjhQ6uEuHx5LkBZGVOeV4tt6ffvco3rv1lFv2AcLShaGqaVjjZq7rBeSi1oJ
 00NZQa+ZCuYenNBOEflC3/ES2+1pjm+iK48t3cQybsK4pBTZXl1J/PG9Ayf6J1lat95JFnv3/SD
 XtILJXPDEz1twYJEMvW6/KaFmnk0NzgPsjsn1ti0iqqpHAinElinKMrvduQUF0s3XuFu3JVh4lY
 WscEWvPOM251UsVwhsm9g939UWb6871QYGJXylmGEg65KKQVq0AG
X-Received: by 2002:a05:600c:6099:b0:4a1:992f:d0e7 with SMTP id
 5b1f17b1804b1-4ac180f2ac5mr287362105e9.16.1793722382552; 
 Tue, 03 Nov 2026 08:13:02 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b393fd1748sm23380075e9.7.2026.11.03.08.13.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2026 08:13:02 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v2 06/11] efi_loader: check the relocation table against the
 image size
Date: Tue, 03 Nov 2026 16:13:01 +0000
Message-ID: <a1cbff34-0f08-4279-ab17-08ede1f0a1a0@gmail.com>
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

efi_loader_relocate() checks each relocation block and entry against the
end of the relocation table and each target against the image size, but
the table itself is taken from the base relocation data directory as it
is: its address and size are not checked against the image, so the
blocks are read from wherever they point, up to 4 GiB past the image.
The directory is also read when NumberOfRvaAndSizes says the image has
none, in which case its bytes belong to the section table.

Use the base relocation directory only if the image has one, and reject
a relocation table that does not lie within the image, as EDK2's
PeCoffLoaderRelocateImage() does.

This runs before the image is rejected when Secure Boot fails to verify
it.

Fixes: cb149c66342c ("efi_loader: Add PE image loader")
Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 lib/efi_loader/efi_image_loader.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_image_loader.c
index 1877c164944..73e96b63671 100644
--- a/lib/efi_loader/efi_image_loader.c
+++ b/lib/efi_loader/efi_image_loader.c
@@ -117,9 +117,17 @@ static efi_status_t efi_loader_relocate(const IMAGE_BASE_RELOCATION *rel,
 					unsigned long virt_size)
 {
 	unsigned long delta = (unsigned long)efi_reloc - pref_address;
+	unsigned long rel_off = (const char *)rel - (const char *)efi_reloc;
 	const IMAGE_BASE_RELOCATION *end;
 	int i;
 
+	/* The relocation table must lie within the image */
+	if (rel_size &&
+	    (rel_off > virt_size || rel_size > virt_size - rel_off)) {
+		log_debug("Relocation table exceeds image size\n");
+		return EFI_LOAD_ERROR;
+	}
+
 	if (delta == 0)
 		return EFI_SUCCESS;
 
@@ -1095,7 +1103,8 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj *handle,
 			goto err;
 		}
 		handle->entry = efi_reloc + opt->AddressOfEntryPoint;
-		rel_size = opt->DataDirectory[rel_idx].Size;
+		rel_size = opt->NumberOfRvaAndSizes > rel_idx ?
+			   opt->DataDirectory[rel_idx].Size : 0;
 		rel = efi_reloc + opt->DataDirectory[rel_idx].VirtualAddress;
 	} else if (nt->OptionalHeader.Magic == IMAGE_NT_OPTIONAL_HDR32_MAGIC) {
 		IMAGE_OPTIONAL_HEADER32 *opt = &nt->OptionalHeader;
@@ -1111,7 +1120,8 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj *handle,
 			goto err;
 		}
 		handle->entry = efi_reloc + opt->AddressOfEntryPoint;
-		rel_size = opt->DataDirectory[rel_idx].Size;
+		rel_size = opt->NumberOfRvaAndSizes > rel_idx ?
+			   opt->DataDirectory[rel_idx].Size : 0;
 		rel = efi_reloc + opt->DataDirectory[rel_idx].VirtualAddress;
 	} else {
 		log_err("Invalid optional header magic %x\n",
