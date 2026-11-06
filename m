Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692EE606A32C
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 21:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mxLO1JR5;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XnvfB9Sd
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 48C4A60A8D;
	Fri,  6 Nov 2026 21:57:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id evg6M7R0xHAI; Fri,  6 Nov 2026 21:57:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 85A3160AA2
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794002235;
	b=QlPIznWM8VV1/cF7AuupJEGK7N18/ZJvom0UeucnCiJ52ycKATCP1ZAukjNGkqY5vgzq
	 tP4yAeYAbZlkrFcdYaEEMPpZQU1q2dm9pUvUFSzGiAggKwqmRy4cB1gHSVyN2zJY/pxi0
	 tGAXoZcGBKMMeV2lC/JQOVGKrLsTov2svI0wDEztYSf3/hO28bS7Dl282hS631Zt/10wR
	 ihoDo5BWsLeEiBG60cuuBHui+jqR6a1TiwwGsJi9yzQhO9vWCWGkHzYWT9VUXf+OCIu06
	 tsz4aw6UJPxEsULuXYVoU72IyP8GyIG4m/f9kVTovn41EB5HeLbfgfj+9JW4AtQCTJA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794002235;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=xsiCpsWQyCNuW++xjMcNtRWltjCutSP/s0CQZEMGo0E=;
	b=JM16UVwUM4UanWXGKZGIDGvgclFY+qutFQRujDvIwLn7mkxj0ffGgHJZgGPf//9XuKRa
	 Cgs08eGrfZRUeC8QNYDtdTuB2a8RXxpMYA3l8Kmsyk2YPVimWykCR8y/rJ+Myk6bgSvvP
	 rNNc+wD8EroPSSbcrI/wA+mRl446tcU5NhRDwOw7esqnjsAVT8+QaBmAr/EZB/6giModC
	 0fUSevPPA8Ytu7pUBpxH+1OX16RvR7XulKhmyOenm5uV+DAbbAmoGBLGqLOQNcE+6tP3I
	 EvfcLQWKIzGgki8nVy00bfar53D2WyouUv1wfrLNY98OlwkUPnixmzxKIDqtx3qnTVg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794002235;
	bh=xsiCpsWQyCNuW++xjMcNtRWltjCutSP/s0CQZEMGo0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mxLO1JR5aJcJskC4H/qf41/Zr7i0s1E+XA3wsXLkV1Wb6gFlQ80DUftd/MCADsnAs
	 thBB6OsfTS3Ppr/c/SoS+RhveZOLf2KlJCirSxYD9WOk/FDrii2U3mT1SR2dwq6y3F
	 tmmznjOxm7r8lWK6Xkg526wFPevbSvP4l3EXF9tFUM86MzpgeEeB2JsvbW/xsjWAqR
	 7jkvTZo7WwrkcB+hotxgt9BffDT8CGZiuPmy1c+V4zgQVKZeI6w4Hu7n0zsG73Cojd
	 80ekaSBet7vLRtnnWztlWiwnuVHjm8mjheFHGcCylRfJmU8lLsccGzpo+ua9xggDB/
	 0Ue3M68JQ0t+w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 85A3160AA2;
	Fri,  6 Nov 2026 21:57:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id DB5EE34D
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:57:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C155140401
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:57:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1KF17nGcreUn for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 21:57:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D87B2403FE
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::432"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=XnvfB9Sd
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D87B2403FE
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:57:12 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-492fcbfaa88so650299f8f.3
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 13:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794002230; x=1794607030;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=xsiCpsWQyCNuW++xjMcNtRWltjCutSP/s0CQZEMGo0E=;
 b=XnvfB9SdfqQ8JNnxVOYSnPMAAEmzRreCd50yIK2yv2ADkVCRFuFvRG6gv2//m1KeAw
 txitQFUSgaPH7jlL0I1cVgNn6F7pIPvVzw9y9E2q8c1j7TFb3+KnW5qI4eLP0BuqO+nS
 vPmhRZIcr1KujjmH+SKM8bEfCGA3w1tEHJNecNW3r/KPzjz5FnpVRiK66l0ZcjBm+eKP
 fN6hjhWoneUvj1TDRKPJc62gvQU5iQRe/4/3uKiSWEW/4PLhXWhnjCNNFHz6Aya9yGlQ
 PbwvQsdLlgVL3ogA828S62JDCt7FhHB+k66X3c2KPkNl/guDANKQAOsaruKPdajjYenw
 6Omg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794002230; x=1794607030;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xsiCpsWQyCNuW++xjMcNtRWltjCutSP/s0CQZEMGo0E=;
 b=dcTEUhZwPjdhgkpjttm+OS7Is4sO13sSizAq4m4P+SUm/TkpTEnky56CEy6YfLgEcB
 CAEg/wsepvLhvnJtJNDoVf2jmV93unpILeSRUX3LiDZC6ix9Ti/T6/cMRnhbPnjMPZBc
 ej2lHBYBKEWIhswsmrbJcxyx8SBAer3tvHo4O1NcF7ADeqyQ9hKneRt+g7K7Ge7KtJi1
 J9cO/OTsFhdYFSwsMmgNBDUBR6F61CGf23knfSiCDSmxMYUd0NZ7uhGfc4MwPGlHh2sq
 kW/dQILC5fuC+w06wz8QoCsPhgovkATbArBtE8+zy+usX1Z5nby5z+2sMuES+xoD2+/f
 nZwQ==
X-Gm-Message-State: APuU4Z/mQvhbvz17lJwnr63fmpi7cJUtCy1vP5ZZtICem6CeNM6SV8aG
 hGJjVUJupLqF580OVH9lytXIODnLaeJP/Y5/DrLCmeKNxuVymvYSe8BSe12ijFbUMR8=
X-Gm-Gg: AYBFou1BAtk9/Rg34Z5lzmEYsCeEm98tYfJqETATU3BMlavFfApECDspt0VLNv+t0PF
 VTizu9nzcBKmSE0tRMZek7AVnHSz/PApl8u/bfqydYi5oTfs+3SfZtPBkoIfayBJZcIkHjDGj/f
 CJ8963MeClqI4ju5Ei9T1xujpKBvyyZBRz5g57ChFC6F03IuEntU0RwNmhlr75NeIXMkBCBL75+
 puuAr/dg0gc4gFdiWgzKFrxD/0UuCkdYs3YLeTgRMd6UrtdCZh0TnnK82hcuv5Zd7E3RcGLi+c3
 JwpCXj9SnwnI5sKYDg5jXUJRA7zTcQkJFD8ZI5OQ/Yhq50rlA0pvafD2BevMukaHvej9RPlKjE5
 0+PhrAEWL+/1rFctlHXBkvbVvzCs9HarZs94qnAiXxJ9L3M002ZXxsMXkyqOAN0hwj7E9M5fcYj
 QkFjExHnTBCSyGwjncn+08ZNISXbJ0Xj0fDKVskiZmbwf4LgNesYGkuHiatElj0dd6DuOEgOPmq
 T2f+2c1y7V/Pwzf9mo9iX+HuSTyi6I4QBxZwznQ89RtlF9bfOAXCdm6cjaNxb2CmZxBF00gMgZ6
 LG4v7aUUOGpL577avPPfIWsUcndt1bk=
X-Received: by 2002:a05:6000:4a06:b0:48d:f034:7fcd with SMTP id
 ffacd0b85a97d-49278a136fbmr7434152f8f.51.1794002230441; 
 Fri, 06 Nov 2026 13:57:10 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d7cc5e23sm6179579f8f.45.2026.11.06.13.57.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2026 13:57:10 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v3 08/11] efi_loader: refuse a PE image of an unknown subsystem
Date: Fri, 06 Nov 2026 21:57:08 +0000
Message-ID: <dd3c51cb-a55c-4e3e-9408-7899706de312@gmail.com>
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

efi_load_pe() loads an image whose Subsystem field is none of the UEFI
image types as an application: efi_set_code_and_data_type() only logs
"invalid image type". Such an image is then not measured by
tcg2_measure_pe_image(), and efi_start_image() does not measure its
invocation either, so with measured boot it runs without a trace in
PCR 4.

The UEFI specification defines subsystems 10, 11 and 12 for UEFI images,
and LoadImage() returns EFI_UNSUPPORTED for an image type that is not
supported. EDK2 does so in CoreLoadPeImage(). Do the same here, also
for IMAGE_SUBSYSTEM_EFI_ROM, which was given a runtime driver's memory
types but could not be measured either.

Fixes: 36b41a3cedd6 ("efi_loader: allocate correct memory type for EFI image")
Suggested-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/efi_loader/efi_image_loader.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_image_loader.c
index 8f48d8fb5a5..67b83af0e8e 100644
--- a/lib/efi_loader/efi_image_loader.c
+++ b/lib/efi_loader/efi_image_loader.c
@@ -252,8 +252,10 @@ static efi_status_t efi_loader_relocate(const IMAGE_BASE_RELOCATION *rel,
  * @loaded_image_info:	image descriptor
  * @image_type:		field Subsystem of the optional header for
  *			Windows specific field
+ * Return:		status code, EFI_UNSUPPORTED if @image_type is not
+ *			one of the UEFI image types
  */
-static void efi_set_code_and_data_type(
+static efi_status_t efi_set_code_and_data_type(
 			struct efi_loaded_image *loaded_image_info,
 			uint16_t image_type)
 {
@@ -267,17 +269,15 @@ static void efi_set_code_and_data_type(
 		loaded_image_info->image_data_type = EFI_BOOT_SERVICES_DATA;
 		break;
 	case IMAGE_SUBSYSTEM_EFI_RUNTIME_DRIVER:
-	case IMAGE_SUBSYSTEM_EFI_ROM:
 		loaded_image_info->image_code_type = EFI_RUNTIME_SERVICES_CODE;
 		loaded_image_info->image_data_type = EFI_RUNTIME_SERVICES_DATA;
 		break;
 	default:
 		log_err("invalid image type: %u\n", image_type);
-		/* Let's assume it is an application */
-		loaded_image_info->image_code_type = EFI_LOADER_CODE;
-		loaded_image_info->image_data_type = EFI_LOADER_DATA;
-		break;
+		return EFI_UNSUPPORTED;
 	}
+
+	return EFI_SUCCESS;
 }
 
 /**
@@ -1104,7 +1104,10 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj *handle,
 		IMAGE_NT_HEADERS64 *nt64 = (void *)nt;
 		IMAGE_OPTIONAL_HEADER64 *opt = &nt64->OptionalHeader;
 		image_base = opt->ImageBase;
-		efi_set_code_and_data_type(loaded_image_info, opt->Subsystem);
+		ret = efi_set_code_and_data_type(loaded_image_info,
+						 opt->Subsystem);
+		if (ret != EFI_SUCCESS)
+			goto err;
 		handle->image_type = opt->Subsystem;
 		efi_reloc = efi_alloc_aligned_pages(virt_size,
 						    loaded_image_info->image_code_type,
@@ -1121,7 +1124,10 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj *handle,
 	} else if (nt->OptionalHeader.Magic == IMAGE_NT_OPTIONAL_HDR32_MAGIC) {
 		IMAGE_OPTIONAL_HEADER32 *opt = &nt->OptionalHeader;
 		image_base = opt->ImageBase;
-		efi_set_code_and_data_type(loaded_image_info, opt->Subsystem);
+		ret = efi_set_code_and_data_type(loaded_image_info,
+						 opt->Subsystem);
+		if (ret != EFI_SUCCESS)
+			goto err;
 		handle->image_type = opt->Subsystem;
 		efi_reloc = efi_alloc_aligned_pages(virt_size,
 						    loaded_image_info->image_code_type,
