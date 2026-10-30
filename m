Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA038606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 06:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tNvWaX78;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nB5ffVnP
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8253560AA0;
	Fri, 30 Oct 2026 06:14:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t7w_L4R24zpa; Fri, 30 Oct 2026 06:14:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AAEC560AB2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793340858;
	b=Ppi+amBMEwCG8x7p4y4Roq+YPmSVxUYYiVSRtqpuvENSYvhgE3OjWrDku1EZdAbcC5ko
	 PM2+s55sU8g4p0voMYwcLOLK/rxzBEXBwuB+jW41l0/4bPZnWDDJIKDklpAaUTIHZJb3P
	 q6DW7ZeBLzGyv/nb6jmZOYBRq+t3kJUqromcbi9G7bSgqqOvgKvpgWtnjMwv0t0taPwJR
	 bHWCUCDqGE6j3k9uetddkO8GqMe5x8Gu+CwCFcQ4dbZB1rb9LxrJHGIALK9XU+c6+Pc5t
	 6cj/4QgAZjOVvAqdRbL37RLD6881V0TgtxVZdWILiGCbOvH2qL/Rb3hz1eSKonrfAqg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793340858;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=x2OlhI8F5Sobp91tZ1j+Tv+oVNx+NWMvmZ+iI56gXnc=;
	b=MVT3C3GvwjlDcmSztQMrRWdaYGMssokdLo454kA6z/8jlKKyLyFN8MemnNaQHQYa5+9S
	 lv3Y2NGo0s11HFLJBNI9MvNWTLIstDE2mcpWTSFbVZa1pza35TxfWSt83/K6tOyrMUplu
	 G+VzYA2h2VdKsXLjtUUCKPqsQPn7QxiWi3quzVeJD6lKG0eVrxKOFpJ7faGT2A57sX8jy
	 Zubkk8w5sAjpkwEuKpI/RS6wVMikQSjHR2wMdj8H917T2EwzreE6LN4O5L/oS5u1PM2kK
	 Ba9RVobYnPrjBdz70QSZ1WVlp+jr3Yv8tnGhHAiSlAnYjFAC0GHNBDVuLF5dXJHqJ4g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nB5ffVnP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793340858;
	bh=x2OlhI8F5Sobp91tZ1j+Tv+oVNx+NWMvmZ+iI56gXnc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tNvWaX78nXSC6Yhd3kKC6cTonBRGTv0RpQoEUqWGXpVyCeRvs5YdeZl5ZKjRXfg8s
	 AKDCMQTgfdOp7Mu4DLbQyPYhdcZq8Zw0vOVQrzrGsJyh+JuLidn1mPa+zCERsy6dwx
	 B9BHfQ6Zg7t5kZvymkW23+YsJgIqnOlZvfHxMqnYz/bMmnh6Hk+3mTvbi8DRDM0fd4
	 dagm5LRSx+7PqK+LvTi6m7cC0e8T6DsPz8PKbhUmuu+Q578lxiqDRG2Lj48Km6p0zh
	 SAjjQ6N+1TgfRDF6Mx0s2H9O9dyWoDLMOelPIW3KL9OpHJYW6ulGIXLhT9fXao/SOL
	 RNflyU3WY01Bg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AAEC560AB2;
	Fri, 30 Oct 2026 06:14:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C5392712
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 06:14:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B1A0160AA8
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 06:14:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 60WUA6l8PhWx for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 06:14:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3E09060AB2
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793340856;
 b=FvSG72JP2IKS9mq4ZU7fXF91koOI94HtFymvKpmN9eMCBqaxCh2o8qat4UJWBbzBufrX
 9eBOvxlFlFK/5ohYkQGWjjTg4tUd5VpPIk3kJRF0x9zxTpmlHnYgKeKWmpMGzZwm/Bo0R
 K59SjD5N9BJiIKlxgnzOT0lcwPHO12Og2fPMLK7Hl7vnEE6qNOC5SXCoArp1UhhauwTbK
 uaoGRSgRbLm0q4oixSwZceeKKUXEwEy60EdkrMEE3V8gyyA9T0FGpu5bMiFNyb1l5F/tl
 QSO3bPVWKvOWChkZAIRaiFYIf8Gk2hT0hYgoEnZsLAn+H5OvxocxbKaYC9yA4vUy/wQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793340856;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=x2OlhI8F5Sobp91tZ1j+Tv+oVNx+NWMvmZ+iI56gXnc=;
 b=VdYfGWuRlYZr+MdtNe9aXnAHGLpp36w0E4hu36nRV6Hy+YhEZL3VP9tO9f2voghhGf1U
 pXMl2jS6hLxFOOz0dHB4EUQRFQde2rBcZgYvKmnN+YirbRkggYzaSOY/1ZUQqLI/KNuUo
 WtkXYTXBdIMrI+Zqi+Q0DIkm3wdaB0pdJgojIF0l2iO6rce17YlLGns6Yyt9VdaXhiyho
 R43K+LQ9yi59PG4+3qrmqB52nVvLdNYoCnGPNDYSyXBT6VsOnOvl6ucXTIGr2qM9dHxIb
 mSaDlnaNydyBiY9LaH6ebxHnKBtK3yz3x1tdFnG/5CgmXBImwnvy8visjp7pCOOmagg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=nB5ffVnP; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=nB5ffVnP
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3E09060AB2
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 06:14:15 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4a2167bd087so2052635e9.3
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 23:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793340854; x=1793945654;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=x2OlhI8F5Sobp91tZ1j+Tv+oVNx+NWMvmZ+iI56gXnc=;
 b=nB5ffVnP2ZPzLS9QkJlRf/t+yvztIMt/CavYgV08qJuHmSqFd6Vy1t+FRTgWzBEs0z
 rL192wL+I0snL7cXWTQLEYMTHzNA9x3lfLeVvS5PhI2+czjxBCD3nPizXAvJrVFgMYs/
 oCh3D7xqDAPNu8xPWWP06LtPAm/RcObB9jYF79j5sr9cq8mwqcT3ljcO4EvIRzjS13cD
 ptjL7kxdGkymsVl5PiMPvcqhoXy8S2/IAGvJTuQfkXKKAHVOdxTCZA3gjLLb/MgjdYbj
 9ZybEGWVh3rwjqp9rgotRLyWFIYmRgwLZLW8kqASOwzjMtDBGTpQ1ZGbEKghi1VzAyvK
 6GYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793340854; x=1793945654;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=x2OlhI8F5Sobp91tZ1j+Tv+oVNx+NWMvmZ+iI56gXnc=;
 b=JMRVMAbS7JTVJq+8wgaDm+JQOXp/kikbbt4HADKVPyzKStKhxE0NZ/6FanfzU9znMe
 GJ42K90RM85RPDXOw+n2Xkwc75YIXG5Eg+VgU6GGRpfIAsCgqR+4b46o2tgajFWujGsH
 b9XRPh/cy5vlGoYOWwXiLfKRrrduqyThmKwwGq60ZeMbreXgAP7CNRm/LcXbdHsC0Asa
 LtXrCpWUPzgCcJxqlACQ4tZP667odcprW4WOVZA4A0FNVpHpzvhbTx7WuokbwISSYDnn
 olx/BXWoiUhOThiL0XqUr1WlUt0q1AIELcTO9Y/37J7nlOJ/dFRONf5KU1W8HC/+5CnA
 HTiw==
X-Gm-Message-State: AFq9FYIyOcCbugEki9bAKCp/+KbF3OEuGorIIckF8g0erw004vLD0nET
 DzItDPf9vj2HjWgoH5Y30PBLgHN6svru/UpZUnvv1MNYWo93C0zsS/pYU+j9SifYhL4=
X-Gm-Gg: AYBFou1PoJzMeJpbGSZvSFeNfLbM9TWxwIq4KJzDlC5Ct76Une6h9WQ/gIXBi+//BSd
 4brADdqcHHfXet5REte4D1goAYg74gdHgcKav6U7rXpuoROuG29b9mIRjP9YiNXKeJ9dlb6qOxB
 tKG1ySZSqfZkyc1LWO5v3KRF/kNXxGlcbQ0TEm+47i+nXwU+h7G2C4yY52yLwoumJs7zndUvFsp
 d9NbqN2lArniptBVbJgpeWKQR5wCN0K7P2rbYfZTTpUbXQU9NNQ42ZU6q2Nai/6hShFhyenaEyP
 lJCXJ84ZqcLm6syK4M1kkOUg3g5Dy0bOrQTqvIeNG14KHt/EAl0co+Jr43/bqyEmb70nCXpAYQc
 mLvDCQieO+eBvXOOsLEmkXLHFh3I/JvmNo1NELs1qvhmpdgVv8Q7tfQNIAozsiw9xMMn0EXVWgV
 wloLjyBEuhdtxwCn/zK7rpuzlnLylLXd1E+fP8icwL2Fts09gAJAAun36SgRgbaYXUB7iqVAnVu
 wicdIDGEBNuF925vJWMT0WeoAGcUv9fJ2P9UVZad+SMNswdrhyQl4JysiARNc/utFI9ahchmtBo
 3Lcz2YCcjS7zkyEvOSJ6T/ULx3/5THwm9yxWLCaFSVq49J/iV1Rd
X-Received: by 2002:a05:600c:6099:b0:4a1:811c:8078 with SMTP id
 5b1f17b1804b1-4ac185bc1d2mr21837625e9.26.1793340853669; 
 Thu, 29 Oct 2026 23:14:13 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b9b54dsm1368724f8f.47.2026.10.29.23.14.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 23:14:12 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 06/10] efi_loader: check the relocation table against the
 image size
Date: Fri, 30 Oct 2026 06:14:11 +0000
Message-ID: <22a9b067-d08c-4fb2-a4de-46dfc6226ada@gmail.com>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
index f9cd2cb274c..c0677b440e8 100644
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
 
@@ -1111,7 +1119,8 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj *handle,
 			goto err;
 		}
 		handle->entry = efi_reloc + opt->AddressOfEntryPoint;
-		rel_size = opt->DataDirectory[rel_idx].Size;
+		rel_size = opt->NumberOfRvaAndSizes > rel_idx ?
+			   opt->DataDirectory[rel_idx].Size : 0;
 		rel = efi_reloc + opt->DataDirectory[rel_idx].VirtualAddress;
 	} else if (nt->OptionalHeader.Magic == IMAGE_NT_OPTIONAL_HDR32_MAGIC) {
 		IMAGE_OPTIONAL_HEADER32 *opt = &nt->OptionalHeader;
@@ -1127,7 +1136,8 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj *handle,
 			goto err;
 		}
 		handle->entry = efi_reloc + opt->AddressOfEntryPoint;
-		rel_size = opt->DataDirectory[rel_idx].Size;
+		rel_size = opt->NumberOfRvaAndSizes > rel_idx ?
+			   opt->DataDirectory[rel_idx].Size : 0;
 		rel = efi_reloc + opt->DataDirectory[rel_idx].VirtualAddress;
 	} else {
 		log_err("Invalid optional header magic %x\n",
