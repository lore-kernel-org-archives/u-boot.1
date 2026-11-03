Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9A6606D820
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 16:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GkmL0zPW;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z+za01fb
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9096C40799;
	Tue,  3 Nov 2026 16:13:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HV27hoSHCAfp; Tue,  3 Nov 2026 16:13:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A63BF407A1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793722392;
	b=aR64i4AAJz3xlDj4usjrRfCNIO5du13mw5F5lhzcVHTpruEmz4QqDGnElsAKFRkl4/6A
	 LD38OzE5tqPJUKfpwQvvGYnwavwZjgWFMG4Lo7fUvryVE9xaEEufGMvHDsgyoF7JTsBOl
	 D8l3ZfLx1oGzK/xd68xVkeU9BLKBbkMM6npdeLntCnd1AfrRpKJ/SqBNxxgHQ9CAL73FT
	 yZMwAOryj8vI+ff19Kboi89tYl9eMjS3Nn20FSLDgjbBhgFTd2W+DhFTVEifxO47GAvi0
	 GhZ1xxJ38JUqtCvBleeYBL0stgQJQRDEgKadzwnUTh1UJRbJa89XvMNHQzX27mhrd9Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793722392;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=6nNiNMxyAzl/my9lDFIE37j1c0zJ0Zr+rdOAak10agk=;
	b=DU/Gwsl+gkKE0EgslFmxwvUIcvzhu7WSrV840G3pyEpR3DZCtWV9AmBrgiuD7L39g5ZG
	 7PY5yoUq4Xd9NJQiJlFvQIX/WxLRTWsFXtFUJQpfLJsB2jSo796k+kWlpqMr4yI6JmpBT
	 isI7TPxtanONFTAy+EvHYLlbRJGZclSJsulrxRdA9VnQhm7NIM3lFCBNpo59U2zCDgmh1
	 SREPhUh236wKgs7JPQIrloNZEI5KFAcfkm8DF1A43IPO/6aWpQfEaWyNGDDWnoQ1cG7cR
	 oMl0xFeZmvNLXvDp8YSVClQD62JKN0fzyjDzdCx2aXbVZ5yRNe4ZBcQaLkyHli47fkQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793722392;
	bh=6nNiNMxyAzl/my9lDFIE37j1c0zJ0Zr+rdOAak10agk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GkmL0zPWsAU2HT6LjmK/gkM0Q4nR7KX0pVJLKroevngncqM5Jth/08qm7jQTZ/N7Q
	 +RzArXD/4Jo0ZW7UKwf20axP3B68DouyySCSAgM5lCxHm06GxKh1QpqbbFRczbqWqi
	 +qM4a6+PqMXPVAYkGOaoHR1n0gG06JkRTMNu9By2zFOMUJzq1G3b7N/yViGHGvnBrM
	 69HmnFMXNnpFrzglwqSAmCRYm69fg1cXbj9TDnNDb9v/c+80kEBGUy5txuGXix/Yq+
	 FIECClTUarosZtNtRf1yzHiAO8HWhEaP2wTkQNqW3q+GYVrAf8vut0KGXJdk97WcUU
	 4u0M215OlYpjg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A63BF407A1;
	Tue,  3 Nov 2026 16:13:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 74DFAA5E
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 16:13:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 665C460893
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 16:13:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BcnEO5WNw6US for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 16:13:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E2DD360867
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793722389;
 b=Ch1NYjbWK3vtdOjEsE/7ZDUULmCJ1ARHuOEC5o1WNWuE5tyLAvXkQSSdpopWcOo1qLpH
 3imzrA3Cp8sBS1UVyoZ5iei872HWzghYzZivGhtb5mENVsE0VGO6l88ZQzuROA1X7a9Ot
 CFacGf7pTiTKeIh+Nz+qEoS+y9ppI2hEacOOX9gcEqGeD5DMLmqt6L/Ss0k2MtxmT+1A2
 GMjl667nlh4o5P1ujJLJXT5VBbfk3zN09MS+FJXTs04FdGrJrYb4w+r3hqKfAp50jCxTc
 AfSkBRUXicEb2kgmmc7blNX/3Ne9UHn8qt0su5bUHVkqKs8j458prpbiFrC3R+GaWvw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793722389;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=6nNiNMxyAzl/my9lDFIE37j1c0zJ0Zr+rdOAak10agk=;
 b=YjO3CCE9kc1tzURUBB174mR/mMliH1m0BxKH2//eQ4U4ukixxtIigG/8IEMQn/m9Orqh
 MAO/FEwYdl7LZ0ejFzrxaCr0Fy81XEV+Y6nei8Bns9XGR9jpUbaS/lTpdvC0gHJI6Pbcz
 7A9Zj2nKDsCgNA44u6oxAgy3DnG4I+uTcrWXv+b/QVSnV31S8E5Dg20VPOlUxP1L56Vmo
 lNN4Qpo7O+kA8YjChAHIXR2srNI+Z8YjF/9DFriLwtDPeVSy+qH35hKdLgCITrfd8R6BX
 p1zfEnB6NoZax98L4kxyWeZKWGpHT9DDlXD3Q2/EJpg5w/5/Glkmf/wENannbfLafpQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=z+za01fb; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=z+za01fb
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E2DD360867
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 16:13:08 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a2072b9832so5576105e9.1
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 08:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793722387; x=1794327187;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=6nNiNMxyAzl/my9lDFIE37j1c0zJ0Zr+rdOAak10agk=;
 b=z+za01fbNt3zYJk6zR/HPREXZJJ/OIUo/lcGHx/BwnEn116fV0W014oXBf7/BFlQMJ
 NgIzUS1SPKrKBO/QgQkrcAcIAGYqCdSGDLLyLalSPYoNUYioJJb1cAYl+SN7FaYS6f3m
 z7oaXxZXVYEJhb3aaodDbPsObLoYqZJifGjsOjWp9aNXigBf6f/yin+UtbBoTyBE1HRS
 hi5pg6NUgcfdNPT+L22dmcP60xi/WdtSiJameQVQSJTDryp9f0T9z2z5q+WwqNf9CclW
 ldbWdQ7/RJSBBB0j7IY3NtuKozPMVUS4VknwWzuzu2bfKpsSfAX8pxbqYQqqeJP6L/7X
 L1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793722387; x=1794327187;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6nNiNMxyAzl/my9lDFIE37j1c0zJ0Zr+rdOAak10agk=;
 b=LMpaW9j6gTFlbBhZbdos9IoXRRCX/cP9SX55D0sOZzf1qt0++ygCh6/q6h6rqGWKJM
 WiG6cgusdFhmniitPrKECnovsWQKkU7AgwPmDfqX5ptXiURPWEIRtuOhDgBdJxa9D6RL
 OyXxumTAWK+I1znfmOEnqOaxmr7g0V5LSnw3Z+BSVMtn+LPor6DBz0NPInEI+Rjttfcn
 oZtSgrZ/MW176YdtfUx6F3zTnX/Kf/tO6J6iiJvV/AtqWn6ObDzharV37fYysPKxsFjX
 gfczrfE767CY3+Eqs8nyjGYKM9lvB34QyKw9jHp/ZETEAPu4WcN7Yvma/ssNLvsLOsBe
 lE2Q==
X-Gm-Message-State: APuU4Z/9WLOvNMoR0Hy3OQ5eSmhNgieLP0ts5Ieciimablb8iwPVfM1k
 gDuPOLSSL1+X0oI1j522CPtCjhbg7SDIP3J4u4Xgmj0gwQ83W7Jcn71ORGDh2bqHMNq/NFr1
X-Gm-Gg: AYBFou00Uex34A2IQ3pPJLgQYWOr+raIpn3ShdtyLZlUCs3HWInsAMrs9JrjtPAIqKv
 kg57li5fmogFZcnMJZSENIfYDXVMUzo29uymrp/Yq6DPqsNJwmjX7scxGZ7tp8ZUZrtt3E+82SE
 TUyxbZT4s//tYMu23bXaYnFFcjk7u08w3SzEra+28tcxWu/l0Sh608uqL/mA09cV9rA/qnn4tm4
 VtXGUetNrJlzcUfXAvciNpCtxbilDW3zkLqNVKNSC9WAkPo1cK/LxLNjXsrzczwDF5FbzxhGgSA
 rWaP1YAsKixtUGR0B7aC44MNkkcrWSHppPULIbDS2tS488Q0SYa/6FOKfA8VXfzLqnTKcMWmVI6
 RIDpzskINKg57V93drb3AFFW5Ya27f9olGGLk2XyHce0AhU5szF4W/B6rQz6pCJ5egAE6bUKEWh
 UL65aeyEOh2q8akbHQmmnMg1oIw7EQQEn11+n1hRCDuPRw3mN9Kchuxg3lP+LzMjhmUY/03+lRT
 mHFi3UgaVuBYUG++Le6qzgnp9iWnyyieMx71hIix8yP24XKAvhWcqa/ufzUD2EhkpKBbz9Nqf+r
 uENaB56+xggEyCKrNmgsTWQjIo89WPY8
X-Received: by 2002:a05:600c:c87:b0:4a1:efbe:529c with SMTP id
 5b1f17b1804b1-4ac17567fe1mr320923155e9.12.1793722386509; 
 Tue, 03 Nov 2026 08:13:06 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a879f401sm64894515e9.5.2026.11.03.08.13.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2026 08:13:06 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v2 08/11] efi_loader: refuse a PE image of an unknown subsystem
Date: Tue, 03 Nov 2026 16:13:05 +0000
Message-ID: <73227aa2-9e4d-422e-8999-b873945828c9@gmail.com>
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
---
 lib/efi_loader/efi_image_loader.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_image_loader.c
index 5a784bfb43a..a0879f18621 100644
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
@@ -1109,7 +1109,10 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj *handle,
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
@@ -1126,7 +1129,10 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj *handle,
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
