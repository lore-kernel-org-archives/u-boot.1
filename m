Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4788E606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 05:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=CqRYPahF;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SZm72Aor
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 22B0E605E0;
	Wed, 28 Oct 2026 05:50:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xQYx0jcSN8AI; Wed, 28 Oct 2026 05:50:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 670B66065C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793166618;
	b=RZ4fY4nDfXmVrkqdOo8KrMaL/Jkwce847o+RdASMm2CaHRvRweb5RML9SUkoGkKmaolK
	 Ba+HVi65P+sZ39me0Lj7XZwAP+RWrapd6OCGj4SD9ONRHtuP0GZaDoKZKYjsHtyvJzPKA
	 6TfyHdusc0N5v73/mJu5quVvi1plIxPZuJlCyPt/ohlj/bA+yeqUuI4AhDbg4gGsG7ctI
	 mIJTJutkeZm/9VTar8Ewg8u5SdaVSdQ8b0UPN0cspB0FgN45fPc09VmFUTGpEYxxILiMV
	 NbMCQiLuMhS2DH66HaHN1LJjEB0Q0A33aPN49y/E1jLtXscCy+g5An7X1ll3amchR6Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793166618;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=FmZNAOvii68txnuIyVvjtInO4pygO8caxjk2Bu9y0No=;
	b=Bs5r+2QPHxsy5g26GXPZfA5RbARC8GJJxxqLRk5V8KFhDR4OIC5CQT61FiMKlNWo/j+/
	 YNKT2pWk3/jHak2kBn9fSYhL+2rL376BuGJMwo0gdkGhr0YeVBhvDSf9A1MjPNPhHAEh2
	 FplLeeM+Gc5UZj4+O4zn1zuns0eQzDTWzCh/sSAIbuMxMEPaGkgX5MAkbwimBnUy6v3VZ
	 R2PB6+LvagRngNiJaeTIIdzULLSK8HYITena7snR9U5EuARhG/NJLDX6snOeoHSnjI7dp
	 1NoFpb04kOXCjje92K7en+ZGK8ry9JPS+uM0WQ+kirdPrDH2oCejtYQY5YCyMVrPhSQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793166618;
	bh=FmZNAOvii68txnuIyVvjtInO4pygO8caxjk2Bu9y0No=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CqRYPahFZMFKjXq2cUx+Qi8saizlLvoSVVmEV0xa292dbUtrzMorGdmKRstww3Q/7
	 3ZGJX4b9KrOXDB9o0AiGXJnCG2TUeVB1hfhr9FTp+g3P4V/9Ig35ngvFSgdgJYkLn8
	 07YHaxr3p8tLzyI079Mm8vmhGxu8qyBPHsmQQ2dpOMWaQGgCYJmDCgY1Q8g+p4RnDO
	 LETYWqqVPWcx7jfIHsAnsopYwfiPclcivgDrpVMsznoN0bs4UOFUGTxGz1/QyGzXW1
	 3Y1jmcG8CqzkmznDxps0e97ARbH/334I//gyxFPMZG6S2eaqCIRIsGkfLzMitoWt34
	 PMqt1sL9q1XXA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 670B66065C;
	Wed, 28 Oct 2026 05:50:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4E25A4D1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:50:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3470040576
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:50:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4RgUv5aV1-56 for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 05:50:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 512D940574
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793166616;
 b=GZ/imOVoCRo3Yj2PpxVrciC/HglVEUq3UVMObU1EPy+O3ZBF7TxJG2f84cSFkuMiHs5t
 leU4r/J0aCC6+qHLzA/rz3CzpjmyngxmmXjDOaAgW759zuepeSaHke/biOZPanGluOA+Y
 nmag2fKl/0giCdxQ+NEWmR/bi44XcNu4vIDZnGas6PdD6IaXOQnnjWoaSlC/ak5EyyjWG
 MiJHG5xyobwnpmd2KncArYSjx9whcCDaFZJBkrtN3ffpQfLqtv0MbqKRrZdlx6Y6qSTfQ
 cH4yLqb5H4ovMp8r5/1koJ9jb8blHG1NAuWF/6EoF9k9CCs8Yt+XONMPJ/+XRAPNeGg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793166616;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=FmZNAOvii68txnuIyVvjtInO4pygO8caxjk2Bu9y0No=;
 b=Te878sXTJVrOVDkpxvPUHEfR/rQaCwR6TjyDLwamdcxYMbLBVGTwa5dVYMVx+2GRbZGs
 /wN0WY4u0H4vGN4Bbxg/fFueuMlTbldJMSaxHcw7seC1HQdUWOtz4VOqYqPqk6BEhGKUB
 0Kc0DGgJCGWrdElL8WKhn7iekCV+VD2T3ghIncqogQSVc7BeUJQUqWTkTByp/fcvxcGEs
 f2fDf8PkBeeVOAzhhi+dgvBbl8QOg+nCU2c5AkwycPTpc5JScgf/1KfGxbGzY7mew3bdo
 S/I7oJPtHRzpUclTxpXv5dFRA1Xng+ULAQYME7ubRlNDTNBStIBv4PZnD0GRn5Kip6g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=SZm72Aor; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=SZm72Aor
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 512D940574
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:50:15 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a5720b0a57so9475545e9.0
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 22:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793166614; x=1793771414;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=FmZNAOvii68txnuIyVvjtInO4pygO8caxjk2Bu9y0No=;
 b=SZm72AorN+JaGqZ99dvfWroHLNSwoFCM+1MJKIGge0YQ0iQyW7o/puT5OjcPpuVix0
 tIYqraOngs1VXKBeDgydmZ39LJFWGtY0XlCTplJ41E6qxmcqV/Sl8HKwFu19OnL517Uw
 xF/SB4B+Dai0NUXFFSDD6RiHbgr+suqIEWJjgd8+FL758zlVxrybZ+fZ1ua5UDiPE6UC
 3H6SqlDNe2zB1AfxmYzCYPrTOgFTZH9UtTd9X+/uny4GtVw/wg/J4oJ7vKvcVYBiaZEm
 IArlHcrRssH2xxFPhyUHUVraxvkXI4I54jED5UgicjIhWaYX048JYc+svXIt+Dg9aWWc
 z2+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793166614; x=1793771414;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FmZNAOvii68txnuIyVvjtInO4pygO8caxjk2Bu9y0No=;
 b=J1UCpPg7f+XFT3WipWMfC9yJga4SvSBHm0AHF1bVxoV/cDAo1IWVZ2LEdh0qBzf5+j
 SJPQeq39fC2XBz4SnuDirG+AOYkdXvv267XbG3Wju9sR0yWWXZGndgMG76QCHl5+fEZe
 csv8XiZTppf9aMa4UuNJFTHw+0tQ2FfRjdBjsTkymIeMfqoLW4oY/Sco6IM44/hiXF6Z
 85A2MYPW7/mcEYiUy3KKtoOiTDwjhxnGuBki58RwMGqqHuHDTuD5ykh9nYOa0OLXZDF1
 06Y4V14l0kyG2I96uGzp0keyxUQN3VqS0xAk4vdKG8t6Mh1p3lhwGPngVZLsROnZ/IcX
 iXLw==
X-Gm-Message-State: AFq9FYJCdWFhCLbFGqasj85+hpcD08njCWdBpfhX6ounmCiI7/QsxViq
 iOQCCKzJg67s+v0tTk0O5+1cysxEUIb89HlU24jv/OzVifDN2+1CfS4Kv5PyubVEnm8=
X-Gm-Gg: AYBFou0zsgPuMra5w760Eb9uH4hK3WFpqR1DfLEMxzmTrnipMYPuzaiiHR8yzNwLaSe
 n4qPiBmXbMxpCz7fHcjGKmyQCVKaXvzuDAuk5OxAbdFt8jchldMVwbDsL80jWDa+2dPNwic5EvL
 hEphq0nsVFR4cofWIdtT4Cmd33Pob6Vrt6u+aHrAYREnYygeqY8mD1qGEh2dZCYGUeE12cFnDFM
 MffuytqGAMyNkpgH9hQGznBlIEYKZH2vUaRFGgPXQm2YpCZXaoKHa189JWvv1fn3m2XAk5Hoou6
 XKwpJ5Fo5rNzEH+VDlWjwHWJsFKwh7vi4FdpJgcoCXE+q86pFMXPJeb28P7Ced+piBtz+JuFEGa
 /Pd4WXQ+EsI7NXMJalHPAr3srVlh8/f0qFwWY8Iq73ZKQ3pvfRsTTbn3cs3CZ9y0XnPfUgrm6lD
 C1I3LXLNwUMNNR/wM5tFMP0Xnn8gGEpoEZhQZirz7/nZlhiRoUSagbxhbrbC8J25377KVnPm11a
 8qEaRKrfymEG+Xd9GcgMJ0C2RKHU8bd+kBNFDd11bRtgc0c6qPYmJlZBgJ/QcFZO82KPc/AMVPJ
 tFIk2j9+FyIBHAmQhL7c97e8ggkAQF6Wmy5Wql4ucgzwQK6/KdFQ
X-Received: by 2002:a05:600c:3d05:b0:4a2:1104:7ca7 with SMTP id
 5b1f17b1804b1-4a7c523da32mr117848975e9.11.1793166613992; 
 Tue, 27 Oct 2026 22:50:13 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebcb902sm27643079f8f.24.2026.10.27.22.50.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 22:50:13 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 5/7] efi_loader: firmware: check the FMP payload header size
Date: Wed, 28 Oct 2026 05:50:12 +0000
Message-ID: <7d28c891-2928-4a30-b2ea-a0aa9d1093d7@gmail.com>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
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
