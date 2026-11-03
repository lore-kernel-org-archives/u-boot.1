Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2996082BE6
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 16:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=H1IhEdbl;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zfuoyko7
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 752C84071F;
	Tue,  3 Nov 2026 16:13:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BV8wFR6YjiuN; Tue,  3 Nov 2026 16:13:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EBF0C4070E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793722380;
	b=RG9U4r7fpM6LYQLAIHVRM7rZiI7P5J2sEhKdjQIo70QvYGM8kwa5O1JvEL58R2md1HpQ
	 9l8YqoNf8Ss/gDz1JewamrmsheNWIUTdYqV2WkVDBq6cu3bTPnHkgzQiS0iO/HIyw91mR
	 BnlXuF0xuY3XXqwnAtLVfJRvWfoNFLqrPiB/Q2oAzICi7NX0FhicbfuefG9Q6hVKI4dx/
	 tnEVV4DUOXSCmvKHle/HkCRICi76xnFHHhE2WAuV2C+cBmJL0HnjHxKql5ach4At/BFhM
	 utSZDifo1DHXX6KlUhKyuCnZb6wSA+ozMT513cLbO0SwnZbG+3MlgTzF4g7reCpqE3A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793722380;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=IldhHQGc6D9WMoe3BgiuSVHAAHH121eoJdK+N1jHpFM=;
	b=SqzR98oy9N+rFoT3wLj5Fb/PhVugGK7v/bKvwrk5Q3FbnnHGud5YOPQpe+hAM2INPiSK
	 Mthw1Nf9+o66nlLG3f8QDyALFM+6ShmRS3a8usYqYEyZwL8xN8WfCkUly9xR4WevRnb5W
	 hXi8Y6ipyjw1MQLuNbiG67DuoJKQvWJifUpX7q2XIoPNLgiaKzgrxYryQb0zc8xf5IjRM
	 dOeemzlBSPv6H5t/Hwu5VZEw7CZakOaR2wBMmkfv64zUtvZKJOrxm/Gj34sE290V7CdF/
	 s8wUqdEVo1DQ2yescHuRDtxp/ozoooAzmoHqhVkDCZYcg32Ewp5l9v1f0gEAstx1pEQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793722380;
	bh=IldhHQGc6D9WMoe3BgiuSVHAAHH121eoJdK+N1jHpFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H1IhEdblMTTlpljmOLvijIYnAiRp7FWJNztejk389dN2o+KnHVLFQazBS4H37Xjva
	 +b6NwxCXQlzAIuuH4QU1we14ELypsSF5pE2HI/W9DS42PO1IvpzuYe2ccipuHh2sg4
	 fv+S97Bq2lz+FKICOF9t4WtrJ0iXsRLdeyNyvrowu8sisMz3h53ejTz3/1us+yKHyX
	 pOWapEXnuwuxASrypLdQg/a/+gc8n0a2L4QPjeEYEcAxzq6pg3NA74RVZ+62uldHYn
	 2XLExR4t84FYSCYuA1SoD1QoyK5AwRAJca7fzkkvjDWHGFgYH8dBThh4AZBNpJTtvv
	 CbiPuigX5VU6g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EBF0C4070E;
	Tue,  3 Nov 2026 16:12:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E804B2AC
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 16:12:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CAACF810D1
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 16:12:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xqtmj7BTh5iz for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 16:12:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4991480DC9
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793722377;
 b=LWw0i9ysM7XSbokoCjgJVqGtEfcYvg9V2KEIf6boqj3UDLOE1wjw8ujEti+stmtzszzr
 mIgqwPI4G/GOHGsa/nYGWa3aA+K1oYIxtFTOs70hLBr/aaH4C5x7z1OshonORxBEl3XN7
 Rf6XRqj1xT44qfI48pLgPZEVkRiAY3X3Z2oGduN5/L/3v+x39G/6dyPhHge63DRlG2B1c
 5/rRCYuRgnyELh5ova4VbBf1QuI/5h541v5mdhA8CDUWs+n+tAwmNV3eu3+fs78mzYWhs
 xozVSpeIMImlIYJ6VTtIxEom3DB/qy270E4XNzqWQH4IjTjoFxzzuU06VdV70cewHZw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793722377;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=IldhHQGc6D9WMoe3BgiuSVHAAHH121eoJdK+N1jHpFM=;
 b=qR1tnH66lKJn4xnbjjSc9PlGr+6YLEvLddjaCx2fJ5emGGrmDsj7ry4G5JhuSX7QPxG7
 otV7Rz02yRd0Oq3++NObwH4zRTVVDKWtT7w8SRZ9wi0kHtgaTVzei/0wc2FVIUaaeD6uY
 4qx6uqMeQ9uDOjmNHl4Nj28Y2XeTBXHbd3VBLqgELBbxhb4AaHFu7rT1I3ge8YTuQBKQZ
 +/daAnujkaY1vy1+qrIVqWz5OjefsCVxEbJwzKV5SFJ6dddxgtX8hoWOyJxJvgKXNJGQM
 qu7p1e0Fi83UD7DwJcyWcTKPCDbQiQrjBOdOvsLTouT6XkOAcT0Nu5QLZXxUpC99q3A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=zfuoyko7; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=zfuoyko7
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4991480DC9
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 16:12:56 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a2000d5fb1so30319085e9.1
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 08:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793722375; x=1794327175;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=IldhHQGc6D9WMoe3BgiuSVHAAHH121eoJdK+N1jHpFM=;
 b=zfuoyko7Au+Dfc6g4Ayv5qT0Mytti8xpIAAOsfdRnas29OuYwf3kFY0axVvpCnoUJg
 y91g1w49kxtQyPTpIy9XJC2wLt61dE+bkCVhkv4jVVW/XjPRo0yqzgjrRZoa/F9szpmc
 P7cUVI7yoxPjnhFNor496JKIJNpo/mJQmSvXHIHSIZGJLt+T+fel1aKNnSkAY/RCeaeF
 /mAeVsKPk2e3or+MPTc+Yw5JJogz/XiWplpEca6p6kBcM8LJ0abWK+81EH0iJjRY2WaL
 AV439gQknbcVCn0fLK76yxekC8ddcTC7D3QoW8wRqcVnY+rycFiGqWjRRyTCt6HlmcaD
 hfUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793722375; x=1794327175;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IldhHQGc6D9WMoe3BgiuSVHAAHH121eoJdK+N1jHpFM=;
 b=Zx87kp5MDnFCeTYbMkSl6ZLBS96HhI1JarV5R/CEKnfBbQ12bHFUtiWyGKrzqbkDiu
 etipvFBSO0NTvscEgVgOI0Orp1sGdyTpu630Xgyl5IYHU//MNec/FXpe8sgGtnkCVRZm
 6jsiJvKQtquI8bxsZ5STuc3w99MjSp8+6eQuedr7sLX9XvThtEtrJEVqVg5xHKQ0brdx
 IydmHaXZVYZk1IPjgPo6wHtWmkJIhH/Uvg5I8GW0yIUh9RHsId9P2xyzEsXVDCvjb2GX
 1GkijDbF/eIGxKtjCi0sByFkpgiCUbU3mlQuoQu1rUOEri/xTxwkZqllwCPWRL2JBVra
 ld7A==
X-Gm-Message-State: APuU4Z/vB24OFANSqUCbIZAsKunEx23QSVF2XU6itM7DXj9N8xtD0GGB
 gjUjhg8FOxelnDisshAezNceW1NBBJz5HVtBnS5v4miD3w6fcvA64LThTh3jNmd3CknJJ+r+
X-Gm-Gg: AYBFou3rTak7/7FWOz+/2/jo1rUXh+clPkguuuBGZZaTO/u9eeLCN48+94vKeRQGbdA
 7reI/xxXg+dKIY/IU4y+WEUgiTfbTqpvQP9Rnl7JZS2BjXDzEko7OaAItIt33FEKo2CWESr5h/Y
 hKgjmHgOxNo3HrJ8Pu9v7SN54GFk4ABZhELs+h6cz0ju8o84032uB83GXZXsspFKiP6pgDBIY6h
 UDKRxvTs3mDs3aDZdbFRnPGSyCTJmBR11xs+gFnGKUcZriwOJemOvfooOZcZuMhwyFkvqUQZoCC
 E78eK85A0repbQoxxG8BrpGLOg+R/AGghM45RiCNL2cy+LTs0VOLQtHwMhHEEmKYDXBRO4o7JMx
 TGNzCYQUoC3rtNfNj3/EatzstbI+f+NA+hfnUYPZ1SANaNv6a33HaGLbUnRvQ9dqTL6fpmkrZ10
 zxeD+w3xDemuGHoluIVfW3de80LndXNiUp4twTNwigg+tgeXz5rzqM/CjHf9/8eSIuU6yzp6mLu
 oiEaGtisffctkdRwkxdX9NafCVUFMeAF2JNFxsZdl8CY1R2zQcsz7ysGH2Gof3+KXCCISHtyePS
 4c/o44d7XGUjXvKZjs88xHUy1tFtdc8=
X-Received: by 2002:a05:600c:3554:b0:4a1:e7ce:107b with SMTP id
 5b1f17b1804b1-4ac150b20eamr329850995e9.2.1793722374663; 
 Tue, 03 Nov 2026 08:12:54 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2ab010a66sm96704655e9.13.2026.11.03.08.12.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2026 08:12:54 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v2 02/11] efi_loader: check the PE image ranges in
 efi_image_parse()
Date: Tue, 03 Nov 2026 16:12:53 +0000
Message-ID: <62eb1e61-614f-4ec9-8a53-e547623e8eb3@gmail.com>
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

efi_image_parse() collects the regions of an image to be hashed for
Secure Boot and for TCG2 measurements. It takes the header size, the
section table, each section's raw data and the certificate table from
the image without checking them against the image size:

- SizeOfHeaders and each section's PointerToRawData and SizeOfRawData
  are added as regions even when they run past the end of the image,
  which is then read out of bounds when the regions are hashed;
- the section table is read wherever SizeOfOptionalHeader and
  NumberOfSections put it;
- the end of the certificate table is computed in 32 bits, so a large
  offset wraps around and passes the check;
- errors of efi_image_region_add() are ignored.

All of this happens before the signature is verified.

Call efi_check_pe() first, check each offset and size against the image
size without wrapping, add regions only through a checked helper and fail
on its errors. Require the optional header to hold exactly the data
directories it declares, at most 16, as EDK2 and shim do. Take a file
alignment of 0 as the PECOFF default of 512 and require any other to be
a power of two. The padding of a section to the file alignment is hashed
only as far as the image goes, so an image whose last section is not
padded is still accepted. Check the certificate table against the size
of WIN_CERTIFICATE, not of a pointer to it. The sorted section table is
now freed on the error path too, which the new error exits from the
section loop need.

barebox, whose EFI loader is based on this file, added similar checks in
4ec1f7166778 ("efi: validate PE parser input ranges").

Fixes: 4540dabdcaca ("efi_loader: image_loader: support image authentication")
Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 lib/efi_loader/efi_image_loader.c | 254 +++++++++++++++++++++---------
 1 file changed, 176 insertions(+), 78 deletions(-)

diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_image_loader.c
index c2c3109ad1d..7be5b6f2a9b 100644
--- a/lib/efi_loader/efi_image_loader.c
+++ b/lib/efi_loader/efi_image_loader.c
@@ -393,6 +393,45 @@ void *efi_prepare_aligned_image(void *efi, u64 *efi_size)
 	}
 }
 
+/**
+ * pe_range_ok() - check that a range lies within the image
+ * @len:	size of the image
+ * @off:	offset of the range from the start of the image
+ * @size:	size of the range
+ *
+ * Return:	true if [@off, @off + @size) lies within [0, @len)
+ */
+static bool pe_range_ok(size_t len, size_t off, size_t size)
+{
+	return off <= len && size <= len - off;
+}
+
+/**
+ * efi_image_region_add_checked() - add a region of an image
+ * @regs:	pointer to array of regions
+ * @efi:	pointer to the image
+ * @len:	size of the image
+ * @start:	offset of the region in the image
+ * @size:	size of the region
+ * @nocheck:	flag against overlapped regions
+ *
+ * Add the region [@start, @start + @size[ of the image to @regs if it lies
+ * within the image.
+ *
+ * Return:	status code
+ */
+static efi_status_t efi_image_region_add_checked(struct efi_image_regions *regs,
+						 const void *efi, size_t len,
+						 size_t start, size_t size,
+						 int nocheck)
+{
+	if (!pe_range_ok(len, start, size))
+		return EFI_INVALID_PARAMETER;
+
+	return efi_image_region_add(regs, efi + start, efi + start + size,
+				    nocheck);
+}
+
 /**
  * efi_image_parse() - parse a PE image
  * @efi:	Pointer to image
@@ -401,8 +440,8 @@ void *efi_prepare_aligned_image(void *efi, u64 *efi_size)
  * @auth:	Pointer to a pointer to authentication data in PE
  * @auth_len:	Size of @auth
  *
- * Parse image binary in PE32(+) format, assuming that sanity of PE image
- * has been checked by a caller.
+ * Parse image binary in PE32(+) format. Each offset and size taken from the
+ * image is checked against @len before it is used.
  * On success, an address of authentication data in @efi and its size will
  * be returned in @auth and @auth_len, respectively.
  *
@@ -411,97 +450,142 @@ void *efi_prepare_aligned_image(void *efi, u64 *efi_size)
 bool efi_image_parse(void *efi, size_t len, struct efi_image_regions **regp,
 		     WIN_CERTIFICATE **auth, size_t *auth_len)
 {
-	struct efi_image_regions *regs;
-	IMAGE_DOS_HEADER *dos;
+	struct efi_image_regions *regs = NULL;
 	IMAGE_NT_HEADERS32 *nt;
-	IMAGE_SECTION_HEADER *sections, **sorted;
+	IMAGE_SECTION_HEADER *sections, **sorted = NULL;
 	int num_regions, num_sections, i;
 	int ctidx = IMAGE_DIRECTORY_ENTRY_SECURITY;
-	u32 align, size, authsz, authoff;
-	size_t bytes_hashed;
+	u32 align, authsz, authoff, header_size, num_dirs;
+	size_t bytes_hashed, opt_off, opt_size, dirs_start;
+	size_t csum_off, subsys_off, dir_off, dir_end;
+	size_t sections_off, sections_size;
 
-	dos = (void *)efi;
-	nt = (void *)(efi + dos->e_lfanew);
 	authoff = 0;
 	authsz = 0;
 
 	/*
-	 * Count maximum number of regions to be digested.
-	 * We don't have to have an exact number here.
-	 * See efi_image_region_add()'s in parsing below.
+	 * efi_check_pe() checks the DOS and PE signatures and that the image
+	 * is large enough to hold a 64bit NT header, which is longer than a
+	 * 32bit one. Every optional header field and data directory entry
+	 * read below therefore lies within the image.
 	 */
-	num_regions = 3; /* for header */
-	num_regions += nt->FileHeader.NumberOfSections;
-	num_regions++; /* for extra */
-
-	regs = calloc(sizeof(*regs) + sizeof(struct image_region) * num_regions,
-		      1);
-	if (!regs)
-		goto err;
-	regs->max = num_regions;
+	if (efi_check_pe(efi, len, (void **)&nt) != EFI_SUCCESS)
+		return false;
+	opt_off = (u8 *)&nt->OptionalHeader - (u8 *)efi;
+	opt_size = nt->FileHeader.SizeOfOptionalHeader;
 
-	/*
-	 * Collect data regions for hash calculation
-	 * 1. File headers
-	 */
 	if (nt->OptionalHeader.Magic == IMAGE_NT_OPTIONAL_HDR64_MAGIC) {
 		IMAGE_NT_HEADERS64 *nt64 = (void *)nt;
 		IMAGE_OPTIONAL_HEADER64 *opt = &nt64->OptionalHeader;
 
-		/* Skip CheckSum */
-		efi_image_region_add(regs, efi, &opt->CheckSum, 0);
-		if (nt64->OptionalHeader.NumberOfRvaAndSizes <= ctidx) {
-			efi_image_region_add(regs,
-					     &opt->Subsystem,
-					     efi + opt->SizeOfHeaders, 0);
-		} else {
-			/* Skip Certificates Table */
-			efi_image_region_add(regs,
-					     &opt->Subsystem,
-					     &opt->DataDirectory[ctidx], 0);
-			efi_image_region_add(regs,
-					     &opt->DataDirectory[ctidx] + 1,
-					     efi + opt->SizeOfHeaders, 0);
-
+		dirs_start = offsetof(IMAGE_OPTIONAL_HEADER64, DataDirectory);
+		csum_off = opt_off + offsetof(IMAGE_OPTIONAL_HEADER64,
+					      CheckSum);
+		subsys_off = opt_off + offsetof(IMAGE_OPTIONAL_HEADER64,
+						Subsystem);
+		dir_off = opt_off + offsetof(IMAGE_OPTIONAL_HEADER64,
+					     DataDirectory[ctidx]);
+		header_size = opt->SizeOfHeaders;
+		align = opt->FileAlignment;
+		num_dirs = opt->NumberOfRvaAndSizes;
+		if (num_dirs > ctidx) {
 			authoff = opt->DataDirectory[ctidx].VirtualAddress;
 			authsz = opt->DataDirectory[ctidx].Size;
 		}
-
-		bytes_hashed = opt->SizeOfHeaders;
-		align = opt->FileAlignment;
 	} else if (nt->OptionalHeader.Magic == IMAGE_NT_OPTIONAL_HDR32_MAGIC) {
 		IMAGE_OPTIONAL_HEADER32 *opt = &nt->OptionalHeader;
 
-		/* Skip CheckSum */
-		efi_image_region_add(regs, efi, &opt->CheckSum, 0);
-		if (nt->OptionalHeader.NumberOfRvaAndSizes <= ctidx) {
-			efi_image_region_add(regs,
-					     &opt->Subsystem,
-					     efi + opt->SizeOfHeaders, 0);
-		} else {
-			/* Skip Certificates Table */
-			efi_image_region_add(regs, &opt->Subsystem,
-					     &opt->DataDirectory[ctidx], 0);
-			efi_image_region_add(regs,
-					     &opt->DataDirectory[ctidx] + 1,
-					     efi + opt->SizeOfHeaders, 0);
-
+		dirs_start = offsetof(IMAGE_OPTIONAL_HEADER32, DataDirectory);
+		csum_off = opt_off + offsetof(IMAGE_OPTIONAL_HEADER32,
+					      CheckSum);
+		subsys_off = opt_off + offsetof(IMAGE_OPTIONAL_HEADER32,
+						Subsystem);
+		dir_off = opt_off + offsetof(IMAGE_OPTIONAL_HEADER32,
+					     DataDirectory[ctidx]);
+		header_size = opt->SizeOfHeaders;
+		align = opt->FileAlignment;
+		num_dirs = opt->NumberOfRvaAndSizes;
+		if (num_dirs > ctidx) {
 			authoff = opt->DataDirectory[ctidx].VirtualAddress;
 			authsz = opt->DataDirectory[ctidx].Size;
 		}
-
-		bytes_hashed = opt->SizeOfHeaders;
-		align = opt->FileAlignment;
 	} else {
 		log_err("%s: Invalid optional header magic %x\n", __func__,
 			nt->OptionalHeader.Magic);
+		return false;
+	}
+	dir_end = dir_off + sizeof(IMAGE_DATA_DIRECTORY);
+
+	/*
+	 * The optional header must hold exactly the data directories it
+	 * declares, at most 16, as EDK2 and shim require. The section table
+	 * follows the optional header; it and the whole header area
+	 * (SizeOfHeaders) must lie within the image, as must the certificate
+	 * table.
+	 */
+	num_sections = nt->FileHeader.NumberOfSections;
+	sections_off = opt_off + opt_size;
+	sections_size = (size_t)num_sections * sizeof(IMAGE_SECTION_HEADER);
+	if (num_dirs > IMAGE_NUMBEROF_DIRECTORY_ENTRIES ||
+	    opt_size != dirs_start + num_dirs * sizeof(IMAGE_DATA_DIRECTORY) ||
+	    !pe_range_ok(len, sections_off, sections_size) ||
+	    !pe_range_ok(len, 0, header_size) ||
+	    header_size < sections_off + sections_size) {
+		log_err("%s: Invalid PE headers\n", __func__);
+		return false;
+	}
+	if (authsz && !pe_range_ok(len, authoff, authsz)) {
+		log_err("%s: Size for auth too large: %u\n", __func__, authsz);
+		return false;
+	}
+
+	/* The file alignment is a power of two, by default 512 (PECOFF) */
+	if (!align)
+		align = 512;
+	if (align & (align - 1)) {
+		log_err("%s: Invalid file alignment %u\n", __func__, align);
+		return false;
+	}
+
+	/*
+	 * Count maximum number of regions to be digested: three for the
+	 * header, one for each section and one for extra data.
+	 * We don't have to have an exact number here.
+	 * See efi_image_region_add()'s in parsing below.
+	 */
+	num_regions = 4 + num_sections;
+
+	regs = calloc(sizeof(*regs) + sizeof(struct image_region) * num_regions,
+		      1);
+	if (!regs)
 		goto err;
+	regs->max = num_regions;
+
+	/*
+	 * Collect data regions for hash calculation
+	 * 1. File headers
+	 */
+	/* Skip CheckSum */
+	if (efi_image_region_add_checked(regs, efi, len, 0, csum_off, 0))
+		goto err;
+	if (num_dirs <= ctidx) {
+		if (efi_image_region_add_checked(regs, efi, len, subsys_off,
+						 header_size - subsys_off, 0))
+			goto err;
+	} else {
+		/* Skip Certificates Table */
+		if (efi_image_region_add_checked(regs, efi, len, subsys_off,
+						 dir_off - subsys_off, 0))
+			goto err;
+		if (efi_image_region_add_checked(regs, efi, len, dir_end,
+						 header_size - dir_end, 0))
+			goto err;
 	}
 
+	bytes_hashed = header_size;
+
 	/* 2. Sections */
-	num_sections = nt->FileHeader.NumberOfSections;
-	sections = (void *)((uint8_t *)&nt->OptionalHeader +
-			    nt->FileHeader.SizeOfOptionalHeader);
+	sections = (void *)((uint8_t *)efi + sections_off);
 	sorted = calloc(sizeof(IMAGE_SECTION_HEADER *), num_sections);
 	if (!sorted) {
 		log_err("%s: Out of memory\n", __func__);
@@ -516,14 +600,29 @@ bool efi_image_parse(void *efi, size_t len, struct efi_image_regions **regp,
 	qsort(sorted, num_sections, sizeof(sorted[0]), cmp_pe_section);
 
 	for (i = 0; i < num_sections; i++) {
+		size_t size;
+
 		if (!sorted[i]->SizeOfRawData)
 			continue;
 
-		size = (sorted[i]->SizeOfRawData + align - 1) & ~(align - 1);
-		efi_image_region_add(regs, efi + sorted[i]->PointerToRawData,
-				     efi + sorted[i]->PointerToRawData + size,
-				     0);
-		log_debug("section[%d](%s): raw: 0x%x-0x%x, virt: %x-%x\n",
+		if (!pe_range_ok(len, sorted[i]->PointerToRawData,
+				 sorted[i]->SizeOfRawData)) {
+			log_err("%s: Invalid section %d\n", __func__, i);
+			goto err;
+		}
+		/*
+		 * The padding to the file alignment ends with the image. Round
+		 * up in 64 bits, where the sum of two u32 cannot wrap around.
+		 */
+		size = min_t(u64, ALIGN((u64)sorted[i]->SizeOfRawData, align),
+			     len - sorted[i]->PointerToRawData);
+		if (efi_image_region_add_checked(regs, efi, len,
+						 sorted[i]->PointerToRawData,
+						 size, 0)) {
+			log_err("%s: Invalid section %d\n", __func__, i);
+			goto err;
+		}
+		log_debug("section[%d](%s): raw: 0x%x-0x%zx, virt: %x-%x\n",
 			  i, sorted[i]->Name,
 			  sorted[i]->PointerToRawData,
 			  sorted[i]->PointerToRawData + size,
@@ -534,25 +633,23 @@ bool efi_image_parse(void *efi, size_t len, struct efi_image_regions **regp,
 		bytes_hashed += size;
 	}
 	free(sorted);
+	sorted = NULL;
 
 	/* 3. Extra data excluding Certificates Table */
-	if (bytes_hashed + authsz < len) {
+	if (bytes_hashed < len && authsz < len - bytes_hashed) {
 		log_debug("extra data for hash: %zu\n",
 			  len - (bytes_hashed + authsz));
-		efi_image_region_add(regs, efi + bytes_hashed,
-				     efi + len - authsz, 0);
+		if (efi_image_region_add_checked(regs, efi, len, bytes_hashed,
+						 len - bytes_hashed - authsz,
+						 0))
+			goto err;
 	}
 
 	/* Return Certificates Table */
 	if (authsz) {
-		if (len < authoff + authsz) {
-			log_err("%s: Size for auth too large: %u >= %zu\n",
-				__func__, authsz, len - authoff);
-			goto err;
-		}
-		if (authsz < sizeof(*auth)) {
+		if (authsz < sizeof(**auth)) {
 			log_err("%s: Size for auth too small: %u < %zu\n",
-				__func__, authsz, sizeof(*auth));
+				__func__, authsz, sizeof(**auth));
 			goto err;
 		}
 		*auth = efi + authoff;
@@ -569,6 +666,7 @@ bool efi_image_parse(void *efi, size_t len, struct efi_image_regions **regp,
 	return true;
 
 err:
+	free(sorted);
 	free(regs);
 
 	return false;
