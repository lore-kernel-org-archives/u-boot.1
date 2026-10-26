Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2A4606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 13:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DNfW0I1s;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=m6fpdecp
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AD5676067F;
	Mon, 26 Oct 2026 13:19:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9nus44_krzuE; Mon, 26 Oct 2026 13:19:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EC27B60612
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793020769;
	b=USnhkx24VLUEyw9pZ0FeEYRT8tLbs2BqQjcFO+anEkJDZoSMairpgcil9M10UcgqPL5f
	 qDZvR2ywTLAxhfhsSRwC0rtbMjbD3D3G7aTiEBFpYqRAmUkJgwj5g4NLwD0RDscaHWZpe
	 D9i2sMijJa8GT9QTZBDmDYF0N+lcoPd0iIgi7ZwG/dEeT9wMFdK+aQw5B59B/FQDn0QMk
	 l5sFkk82Ot5TbJICkRCefKSvHIeGnPuMpfInYGLrPv93/nPTVV+AP3Y1WMJEBlAVbngXN
	 qATTQAJ0yA3E0iYf7NuL0NrZAF88tk4Q4TIo90SMcvGbP/345z/tkYSj9OiWe6DoCKg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793020769;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=FmZNAOvii68txnuIyVvjtInO4pygO8caxjk2Bu9y0No=;
	b=puFFMkUzh3GORVjidosRx5SiVUTNABTa2DiqRYjRFKE37PhFadAa2J4b4SVmtfOJl+ZX
	 tP+G4AbONjx+WuTemDgSvnusr0b2O12Y6GNG7SUIfEXi4Mb+ODpJUSpiXBP4aPzK2QURj
	 OCJO+Titrq/HjaBs9FN5hJKP5c8YjaLo5IAFMOH8kWM2E74+HYBGPPOWWwpHwb6nQpq97
	 rZlmV8raP33mKXxmmcWdRZevDhsGWMHAmOFTGgXe86eRc9XPPKkrs/0hzzWNlxODuagb4
	 KuXEkVIuy0uRptDkozXwa5mskdEWwsD63MFHaVD0M1Z4Y5OJ99E3NWqpWPIITGmx1ug==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793020769;
	bh=FmZNAOvii68txnuIyVvjtInO4pygO8caxjk2Bu9y0No=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DNfW0I1sc9Z91Dx2ULHLVpaJdqR/RZ+hVdxMoskcJuh+8q0D6eaWaHk6ccSfo1RGI
	 Kyl31QXj9MMFluRq8VfkoYBaoHI+Sqn1RdTGPlkE6q4VKylLNRQ4VRWEpIjhDJHw1T
	 bBb8MU8ml9z+SLngFaSAxk30yBxAtbQojRzilgyerk2YPEQSR/cXd0fUggMkZBguAf
	 B9XHMQVn8UlaQYznc4kVCR2oXoIKmqsXlGlIXmSUL0xqJxtdDWKqy9ZNll3+f4nGRH
	 CYcs+z/sjhpr0c9jE8yry4fwn3q0ZsYU52Hoq+5ZvtM5wxrGBAn50rouD4kgetuize
	 6/fqiv8tbveJg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EC27B60612;
	Mon, 26 Oct 2026 13:19:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 84E8D4B8
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 13:19:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7664E80D34
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 13:19:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0WG0lgQV7JQ6 for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 13:19:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 80FE080D85
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793020766;
 b=LiTsR09NrrfdF5VT1N6EDA8aTvqhbFd4YKj836TWlFHVz8kL0XQI2XKiru17B+SiRbme
 nlW0tImVj/ERhT1Jm9kOjlzhlsfjFiSMD+ZPx886Ip0UUGHiLJ8NuCtniruwP+Rp4bfKM
 xazhv+SSvDGIMF0uRDA1qh7Ccbf3IfW8Z0pxsdwYFyu1Exiqs7A4QGKSIiNC6Yf2LLzmV
 PORn0vs9FM73OKyYSVPZ50l0tjnQlQU5MB1i/mpYN3LNEWFcBG9WMN6mMD8OsbbOw4iof
 zPGDZ5Ltz14PNr9Jra1t8/DpSuxOUdtL90A5+l/QOEWXDeGLi6aBZV+fr1z/3ngIbTw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793020766;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=FmZNAOvii68txnuIyVvjtInO4pygO8caxjk2Bu9y0No=;
 b=QXHsGQXU7nF5OIr11i3NFSUbG2we3c6TYVjVxrQUL+Yft4UKGIe5+I0q0McKvvX3ZZIi
 TzSArY5FkTKS7/uA7L0QJi+DGOjrj1Ck6wZpJH1b6PR1onPRmDG/Fse1Le9Kl81qxzVej
 NYb8zrw/JU0Bb42hNrnp1sikP3iWArTJOsziumEvo+KSsFyisas2Aqc3rHWPoaqnDHMco
 mVJbScedIlQjJtmgGHdfsoMsdrzYLtlomVUSWlpAkhW6lX463vcYWJwuakP0ZyvXX0jOS
 5I4Z5GIYUUSJ2J6WTnNrucPdQJkb+7Z7ePUe9+FX1iBX+ePUh6Ql1Pb4lPd2icxG8Kw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=m6fpdecp; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=m6fpdecp
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 80FE080D85
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 13:19:26 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-48e4831c028so1424114f8f.0
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 06:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793020764; x=1793625564;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=FmZNAOvii68txnuIyVvjtInO4pygO8caxjk2Bu9y0No=;
 b=m6fpdecpaJW9QOiUs/aRTuyCQ8zppWe0Li6FDfNkgFadA41AJsAxtbuO8iM1inQK88
 Eox/ejVW5H6lyRdqjEsVOKTNVCJkzi5w38qf03yLjl38lxpLKRtOasRGXPVeFxQ1lSHU
 7F9+5l8Izktz9wU7vig/oDvFrSwbZjXRp2e0Z/HfYCdPFSTYrQYDmzSs9IiCsxOPdDO0
 igiANPz/B5IiWJTI1DxriW1Vtxh6S1NV/H2ccpVFliNhYOvtwbtgFIgXykA8Rax17CsN
 K7RYHq9dGrh+62wOpKnhCEYI5uzTZkoUEvmwfwuJtqOUI7lAxyWM0Tpy8rqvBsYqzAi6
 cu9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793020764; x=1793625564;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FmZNAOvii68txnuIyVvjtInO4pygO8caxjk2Bu9y0No=;
 b=ZyfJ1/n9I4fA2jH/3X4j0qv8Sv9VAbM6LwPegYV2kMj4PXSYsaWz0bsNmuJDUrUf/Y
 xPsN7r6D6LNpj8sburt8aCuKAGijxz75GZeq65GJhenTWHtD4Wt0WByfzrkYvVFFSk5r
 nY75r7F4Uh3drl3cSPbGXzhTeADFYqdURuzd9gWqIs9X7gLqzKHz+XK2Gi4rimTJe6VP
 wSocr7wBcCHko/qLWFq5/9xKCznEVIy8Euxuxf8Q125xgniKSyVEd9v/PZRG2QFcMc2T
 qhHPREgRiCCL8XDKKgps2VM2QHbNiTDOb7lth66CpxVmbtjsw8NMzWjuFCLrkQjgO2pM
 WRpQ==
X-Gm-Message-State: AFq9FYJrAi5ZZy2xk4mlCslxpQOjmy+Z5uq/PjNG3xk5G+KDNqc/DgqV
 jlLMmdoDqAXIAdb6/dzZPTYZ3kFBM/Ex1gRCrntYX5DAqfcLTTRbzS9BBr8/pxHl
X-Gm-Gg: AYBFou0oBRhQPXYyDH7kinOyzSx17yaHhIaue5m89CvqfTDx+7uJznUSqEQK+gdAxJz
 WajKl3hw3ZB0zv+6/xSpfJQI1qyc6aWPeP1n6V0AZLGsDWteiXxEodkBoj1sG6afyHYSWmtqkhk
 BpnAQw/dMy7KdPMOZ1R/vnSHtr1EUv4+LTRTXGRctm6Rz6EbiCc7Eki7kAOzSyErlpTU+rCYsjK
 Jcq9bVH2TIRRYI2LiOz5eLHsS1eb2uYAZYQySiUzBomFcBZ2k2XXv5aVuwygqsxrRjTfZPr8eKy
 G5xiygcaimCn5N8601AtVwEyyBfSOGrbKb2NikuiotOwn/JQ3TNlqvIs1U9PcNK6TqEJWUZSvz9
 9x5Z9t/DU+5s5gL+iydXmhbGC504fBDMsHdSbJDUPcVJv8dF8qSJIPvV0gWS0tkHH/vAccfshSk
 I3EU7+m91qhmc5I3u52Bxr1jKlHL8sg2GMEowdJuiPFjfyjvi1qSBF4LwhHeg0sRQU6S4wnrErE
 PCp41Tai6H1JyKb+sZjA+E1qgOyyoUQGMBL7k6jIgMlZKmrKeC4BYSa34GhTwyAlloJXjxcQGAw
 UcM=
X-Received: by 2002:adf:ea0c:0:b0:48b:59f:db9c with SMTP id
 ffacd0b85a97d-48e3eb8bfa7mr8456252f8f.53.1793020764175; 
 Mon, 26 Oct 2026 06:19:24 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecdf9bdsm15904384f8f.55.2026.10.26.06.19.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 06:19:23 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH RESEND 5/6] efi_loader: firmware: check the FMP payload header
 size
Date: Mon, 26 Oct 2026 13:19:22 +0000
Message-ID: <97f06833-cb2c-4aaa-aae7-5b19d8a105dc@gmail.com>
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
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

efi_firmware_get_fw_version() reads an FMP payload header at the start
of an image without checking that the image holds one, and skips it by
its header_size without checking that against the image size. A
header_size larger than the image makes the image size wrap around
before the image is written.

Only look for the header in an image large enough to hold it, and
reject a header_size smaller than the header or larger than the image.

With CONFIG_EFI_CAPSULE_AUTHENTICATE the header is part of the signed
image, so there this is hardening.

Fixes: 675b62e12f9d ("efi_loader: Add logic to parse EDKII specific fmp payload header")
Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 lib/efi_loader/efi_firmware.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
index 84de95f5c23..4a5249e5d4a 100644
--- a/lib/efi_loader/efi_firmware.c
+++ b/lib/efi_loader/efi_firmware.c
@@ -499,22 +499,32 @@ efi_status_t efi_firmware_set_fmp_state_var(struct fmp_state *state, u8 image_in
  * Parse the FMP payload header and fill the fmp_state structure.
  * If no FMP payload header is found, fmp_state structure is not updated.
  *
+ * Return:		EFI_SUCCESS, or EFI_INVALID_PARAMETER for a bad header_size
  */
-static void efi_firmware_get_fw_version(const void **p_image,
-					efi_uintn_t *p_image_size,
-					struct fmp_state *state)
+static efi_status_t efi_firmware_get_fw_version(const void **p_image,
+						efi_uintn_t *p_image_size,
+						struct fmp_state *state)
 {
 	const struct fmp_payload_header *header;
 	u32 fmp_hdr_signature = FMP_PAYLOAD_HDR_SIGNATURE;
 
+	if (*p_image_size < sizeof(*header))
+		return EFI_SUCCESS;
+
 	header = *p_image;
 	if (header->signature == fmp_hdr_signature) {
+		if (header->header_size < sizeof(*header) ||
+		    header->header_size > *p_image_size)
+			return EFI_INVALID_PARAMETER;
+
 		/* FMP header is inserted above the capsule payload */
 		state->fw_version = header->fw_version;
 
 		*p_image += header->header_size;
 		*p_image_size -= header->header_size;
 	}
+
+	return EFI_SUCCESS;
 }
 
 /**
@@ -543,7 +553,9 @@ efi_status_t efi_firmware_verify_image(const void **p_image,
 	if (ret != EFI_SUCCESS)
 		return ret;
 
-	efi_firmware_get_fw_version(p_image, p_image_size, state);
+	ret = efi_firmware_get_fw_version(p_image, p_image_size, state);
+	if (ret != EFI_SUCCESS)
+		return ret;
 
 	image_type_id = efi_firmware_get_image_type_id(image_index);
 	if (!image_type_id)
