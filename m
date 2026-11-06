Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CEA606A326
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 21:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zzrYStcL;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vxuLL/5v
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9EBF160D8F;
	Fri,  6 Nov 2026 21:57:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O2cM86mfjVl6; Fri,  6 Nov 2026 21:57:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C5CD260D9F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794002223;
	b=bCS2zUd6HwwwP6jVbfISvUo7IXbVRgpzTKjSNgD9NLX6gM4O59r2FkiZ1qbKnaOph9Ph
	 ROpUsrWaJu8FOKsLxG8KLvJhdrXBlNPmOtLJOX5yiI2p2HLPolgIsHVzyZm4jJAov1Fck
	 /FBmTXTWE+2XUQfBw1Vf1/1ZDLPhVcJNIeDJm2UMVZEbDrrjIyGqOYcmi0t/c68Q7CWJM
	 5alSWbYge12IQqs/aeViBErYCgFmgZKZa1kd900rMPTA8A9AlcMstSP+RHeiI+frcfo3V
	 Y6UZ95o4YhPwgczZYAGuHiA3T8Ucob0YEc3LKoaVCTvWt8Eb18zQPEASl2tiQIoHQJA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794002223;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=HMilOeAXPnqi+7xw7Z4rmKRN6wyiLvg3BhNHWYAiZes=;
	b=QBQWJ15kkRspOo7JI39v/L8UkCDYuIHOXza55DayyYgIdfOoEP0Nh9yy1n0ogxfoCX0k
	 d/IN3ysV3JnZsDRfsG69ZaeBUdt7DUlQ+G5fS8U2DCOYS1vU4h1vdMj6eiwtApVxoei1t
	 nnwUdCaHS71kts3vg4IjIGoFmm52Cd0lzS23zgS+tg0TkNFEgZWlDH0KnjOdUTw987fYc
	 JnJ8OeOnOmOB27DrweXHi02al1z8uI9qWvKDun8M2RAqdjhAHEzcf/D2700hDIY2jqPVm
	 ManevjCHHbwqtESOYPh+Tf5cmngOUvzvmDsv/tbvTlrazKxPIsosjdwIHxzynsPEzng==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794002223;
	bh=HMilOeAXPnqi+7xw7Z4rmKRN6wyiLvg3BhNHWYAiZes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zzrYStcLvH33xjhbzuwdH+aBey5U8M6I8vBVhS2N1UIYaIR4QUdMi5VltLqlwQoPy
	 /2FWhK8iRQhlvjIQ+7WyKdysD7F7X/XndZFc29BaTIfGUU99KqMvBuD2EKRQJJdifN
	 sf4toR52PzUA0scI1b7JRE6GCHnMUfEjTrqotGhSy0CKeytGyW3FRS45LJNqROPe6E
	 hTEhAc63mCuB/gV2ez6NWqoVCemNwKbDcQHlFupvro34oYlmdyZHX+Ewree2fjlIcY
	 O1Bs4ndFHqbUl7iU5cc0GjxxCRJz72Mmn+6Nvuzt8p3lPSnpB7HKBLn+p5NyqSu5la
	 KbkNcr73BQaLw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C5CD260D9F;
	Fri,  6 Nov 2026 21:57:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 46C621C6
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:57:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 43C7E80F55
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:57:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T9PfVZrhUHy8 for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 21:57:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 61A3680F50
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=vxuLL/5v
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 61A3680F50
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:56:59 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a35a60499eso9690035e9.0
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 13:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794002218; x=1794607018;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=HMilOeAXPnqi+7xw7Z4rmKRN6wyiLvg3BhNHWYAiZes=;
 b=vxuLL/5vUYsaCZanRN7cJYmwpJesdV8p/P8U3D01MIlh97cGpSJriHYuX9R6VR93tU
 dHFCDdGmQJqwQIncq4JIKlKhGMNYDx3OZ96Jau3Fcv9PXALr3xFO0XsG+e8zwnMoRpUv
 04Rzxhmx/Rc28fhmRZVAY3JTf2euynysFlfOFyuLwpncN0Fx3PzCF+nm7CFemben0bxN
 G8+ta4IDWQNO89fyIA/xrFc7QdSTY4gl9EtEx0USNoHzwzJArFjqH+6mJoc1JM+dTzIl
 SWLp2SJhwmtmoTTU4u1+dAg3EWcG5nF+5fLOnoSpEFEQgr3CZ5toWuCK66afMzOx3yxD
 5XMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794002218; x=1794607018;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HMilOeAXPnqi+7xw7Z4rmKRN6wyiLvg3BhNHWYAiZes=;
 b=o9x/UuR+mQ/CbwsiHblqxqHHh7xhjEY3fX0u5MJB4YAy+lyTFa24VP4Z9dFlqZhHo1
 456qvrEqL4jC3OR8s1TvxO/Ct9MI4iNE0ACEwsmgrolyQgygtS1viLcQsIWdKsNNN2o2
 Lx56GjlglMrtxYBdHkOboQuSPxQLZnPOigccnelAh9siJyvKK+kCloR4uJQ52j00+hxq
 JNQDp+DtztFmVPKTH7mgUFsF//txqkz1pQbjO35xLtKCeX0FQf7bYAEI0IqxdswiDEW7
 XG5/nn78i7HszFAw7HVp0ftNvqMuS7bZC4t7dZ8KkmM8iSqMaPYDwbhY9L3t6x5QJX0s
 euAA==
X-Gm-Message-State: APuU4Z8Blbi8KbG6JE61vcBcsSnipQhLpn8VwLtaXKuC+ENnPIL7eZlR
 u4N4tiAMSWdn+YridoRNdVV7mT0AzIcbC9T73k20grN86ayrYDSexV1Y7FMXDaiVV3s=
X-Gm-Gg: AYBFou31nJ7hRqg8A3JvPgQWocnhtbwtRmAiAVrpCN5O6DW5WJ11QHXNtONL01gQTp6
 WavXoYBNYETRZPp4AMFMfD7XfZF7FcQLKku4zsFS1HpINEF9eSjmayAqlFYw2ZQvN9v8M7+6+aE
 qqa073wOUChyHv/HNV2Yh2x8squphDs6kq1ds3Tqcamfcsd+mWP9UqvQsVrfURRAB0acOO9935a
 SrWweXQwYi+Q8SsTDPdsSSCnvKBbSfBSifAOn27EAEHsIwK0VavhC9pMF4mEWm/8Pr6GRvsgD3W
 ERgelO3rDRle/ef57ephVuWoIW7uGoXGvJ48i1mtxPnbLqI+TdHdmap7ebODE30HCLTzv7Vg1zT
 Jvcow3zCZAAbZu5GXgRCC+jag5n49Tqea3VeUH1KCEWWekkPCsMOgj7HxZAopMCO/tWF0VMXzzC
 wWtlcx+uhdqJyy+ekdofJWmaWw2r7i0VFT0CUct1nMR9H7AWvnCp4m3L0hTWbFrAW7kki09yES7
 gI+BBtMp55GfQmKa3AlI8FZ0R4+nalm9g5gpfsteIO6EFemKiThVJBSCQkP8XojVTr9Gf3COuTB
 jimvMy1uPN1DeCEfy96aKTAP4RZUKEc=
X-Received: by 2002:a05:600c:3148:b0:4aa:1527:659 with SMTP id
 5b1f17b1804b1-4b6df6df7a5mr66903865e9.17.1794002217988; 
 Fri, 06 Nov 2026 13:56:57 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b7e327a6d8sm11872515e9.9.2026.11.06.13.56.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2026 13:56:57 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v3 06/11] efi_loader: check the relocation table against the
 image size
Date: Fri, 06 Nov 2026 21:56:56 +0000
Message-ID: <60828963-763a-44f7-8379-43c9cd7255d0@gmail.com>
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
index a9e7fa0a74f..417282698fa 100644
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
