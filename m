Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D88A606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 06:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=M6hBMZ5S;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XGdHY5Ax
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 07E5A60AA6;
	Fri, 30 Oct 2026 06:14:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hq67nKHi24aC; Fri, 30 Oct 2026 06:14:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4079660A9D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793340870;
	b=eKMI+BJlsFhG7HrN6qqHXI/CxZvJ9EqLaxqbc76uDNfcVd5xR65vPdxkwwQFWcsisP/V
	 McxcgLd8oow0baJ8M5gw1ItaIgN4Ezi1aKUqaaT6LydoVvnDY2fyjClp/VeLThloKJ3gK
	 n8JDHypznB9TFtyj+d1B6N7pr3FcuWZ21ycjsScKsYcLoMqpmWvuYnRC4Rz6jTicJhE00
	 zb6yvNlJVQvsApEaW4R54jej7hnperEashR8bOiKpFL/p3e/dS64Mh5889wL9fbXxQxDS
	 L/QhP9aZLGBNfN1kyY4PA14AyH2WcJAyjUPBi//+3iv8JlpesUsjPuYWBpZ8E6fKa2A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793340870;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=6Dij2Qj3qrckXW8RSgwCQSA7PSliKrbVj2yQNIehmv0=;
	b=NxIXxs11toSmwpifm1o7/skNIuNRleRBPFVdrr7nJmHyQTdoD1dn7HZjdlvndiwjV6xS
	 WZZi5knNMufA59HEf7HYIyQODakH6ScGtD+7+mo+HNwLr1R2HbWFcXqq4Sg7eBnLtUJFQ
	 gVs3VYAMI4Z/3VNwjGc+wSe7Qdmh/k1tecVAU6dtSAgfSld3neE8DBaG8JR6RH9FPYOwR
	 3XT7/kXE/mM6zGIntFj1SJt2pMtoWA3OMm7gDNeTqm/HNquyMPZeFvLhFpWBuvE5P5uvi
	 c6WzgKU7qER1Ts2Rq5dsJVGUfYSWGJO9fZG2Bc/tPtx6fdJYpwF1uKp8x992iY0ibMQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793340870;
	bh=6Dij2Qj3qrckXW8RSgwCQSA7PSliKrbVj2yQNIehmv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M6hBMZ5SRSv6u5HoSmUIElVR4djydPj8f8WxKWe2CSkLlZ2OdAh58gYWnTxI6JSP9
	 jVOm9ATpCkFUueEOIbmQR6IiwtaisHsAr0fGEhBEfv5cQ9wHeVFkeEikWnp3dINP3N
	 XqNjzGL+hoRYRWNFfq8ZXn1nLV7+g/+wLHE+QdrK9XzdMdxXiuR93oC5pKFoe9i1PO
	 LOkacZ/cQeXBRqKb0VenmbgicNAD/K55WeKm8HvuakwDtmsyPk9jE1CuC4VcSHGViO
	 IiXpBjptD+ezMX79lvYk7yZ926uyibRRnK9vXppVfPkVrVUFimXVGsj+LTV1VuMGir
	 SL71LxaTbVeRw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4079660A9D;
	Fri, 30 Oct 2026 06:14:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 30FE12C7
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 06:14:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 16E9A4051A
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 06:14:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XwHqp4MSEg6H for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 06:14:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 28EB8402F6
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793340867;
 b=nCNSgdwiIA2AKRR/RtlIohPWsLZ3aMjDSzD9iqa6j9wJ6XlZV4NR1ih98TM/kV2cZjyJ
 lepULz5xpuuSrPtpaWm585ZKaBpkIZrOsmf2lsvv2h6WZhL8x55t6Z5BRuGr/xmh+e+Ep
 SRpLa1Q32AXFBCThI9b7ueQaRdjfKm8erujUS5HN+pw25Bmgrn2hcSgpuy8rLpY4+/vIt
 p/8MOXnm4ncqZ/bMW7C7EhBLTe1nGw/68IvFjJG7aPHeJIfIe0uzxC7SK49D+vBmqVBdG
 p415v/64JDRiMpJnxAyMGbVCG2B3qhvwbeU/JRX/lvra3BY5I7PEZOvc5bXibGhie8A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793340867;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=6Dij2Qj3qrckXW8RSgwCQSA7PSliKrbVj2yQNIehmv0=;
 b=Kb3n0y5Yg1YuvoasQR8TukPkGvt455OwLKputwL2Y0Rd/vZ2lTSg84Hnif0eP21JF3nh
 y6aIU7JJClvTAYjweLu9hVUeoANUD0dyHdyi0OjS6vRY1YAdA1+StVbAuy+wKPHdQwlIJ
 jjOw6hoENfN7+4iIwXUXc46jEvXJ+a3MrwPR93os3C8Z2rnmyO8sOYtmk5a5leREV4rC3
 1VgfejtaQaEqHnQ3E3rN1orFHqpzOaNVYavUuluho8wL7TGBsGrIat599fD0KWOjv87b2
 e62T6LOhmvbC75oEyetYAoRvlS6qN+YCu73qB5Nwj7fprO/pWyH+kopE7ZRY5mm1/Sw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=XGdHY5Ax; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=XGdHY5Ax
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 28EB8402F6
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 06:14:26 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-48e00eee27dso134767f8f.0
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 23:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793340865; x=1793945665;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=6Dij2Qj3qrckXW8RSgwCQSA7PSliKrbVj2yQNIehmv0=;
 b=XGdHY5AxSyiCYei0BmgafZfQvD8y9WlcMT+z5daRqDRi+FgR2thzT3tKStaHCfC7RI
 Tv6HUwXczgbceBek5qWk0YKdOL65/vr7anVUZx7cObFH6VbeMIRbDShm/04suc8ymrpS
 i61eoEtk1OzakYY5Tpb5d7mFmR07C+Dff8CNEcHYlK+ntoHLZqLtZR/77Wb6iPzV3hlk
 lFRsbar20djAalvcnP9xnNV6Pzd+RrwLpq27YZ8l5LM6t/e/l0L9dGT1LOW3UIL6aTy0
 yOnZJn2g10IjJ0v13io1eYSn54JybBL5fEQrpqWADoZk+gufU8fSBQnpZfxGCkg6pKV4
 HfRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793340865; x=1793945665;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6Dij2Qj3qrckXW8RSgwCQSA7PSliKrbVj2yQNIehmv0=;
 b=s88Vqhf2QTG9NiooCyvyiZR0QxilmzIVuuCH4evM+mPmCo2uljbkm69gZfuLojiZrN
 nPyGFYhD9vcb5eKVddA1+B0Va6RdPz3NdRXgXk5aVMJMMxNvMy+AQCcf3zMvk4M8Nix3
 ODsfjhDzTUQporyINWUlMqmHBKbS10KBawPUfYoTz4dN12Jp/meZUdkChu0KiI/LcbHO
 8O6XgFRlr6EU5NyvmfeIo3XMF2xY1WWN0ZwnFhXBc5+fCfCIgoQxXR0lodWl1dX35DLW
 monuXs9mN1PtI3NGJ36pUs7sXPxMtiktWx38/tvPmDjFdIVqpAER4LEZsRlnyr2scB9e
 tPFw==
X-Gm-Message-State: AFq9FYLACXe846r3aVhjjjvGInLaGtGUxkxdN77h7dQyLu8dzN5E6Iys
 4oDzxigWY1tdx0qBquMySbi5KzuxwZI918F99zQYoqV38iokMnpc92JjkO1jv85YTTc=
X-Gm-Gg: AYBFou318hiw4KU9z/ogKwTNFGgrC0VDu+hLDIlbjK/IJZqQpVOdPlkvHu/ysu5Tscq
 KyJJgoX/tZ/O26Hvuwt18TpQmUUkgq88s6Z/FDUbxDEDuW3EqUjavuCE+lwNeYhfnjrN7YE+Qs7
 Fx8mXM5oRIIccHrw23Ye6GJcp4mGS2H1EaIBb4IWn+fQ/AgPmafHDIVFM+9KVc8/3K0WJIR7Pk8
 Q8XwfCu8+8QV9ofka7RUDi1bTLYPtBzXjAo1KgWP1d4lB5hV64cqXUEMVpbA0U2f845sW+ZxHhQ
 JgWT6VdhPzHMPTqR0IipTEEJSYq51H90wnI6mKSMSS81+piX2TkxiNlUyd2KuCifqmXsGihkQIt
 qWxmtVWlsoaJYoAivDo3m4SLbEnTUtIz4zp/rEcpD5FWkELwjqgZF99YLgNNZbVylkUSSliPPmw
 bR9lRwjM5FHdQ80DAa6JJe5A0VZjy48N0kOrzVHa3b5XsKxnEE/A6+dovoMZyho1pZ4959Fhq81
 MLYLx9JAtlBv929ojAXpc6OL/ylE/8WtyOCUA6MaVtaxlwRjXo2fVx5O/48Dp/o8picXFTx1ynb
 Q4ahjxjiUXVj7ya3Q6920g6fbcZ6OpZk9aOntULzeRk0ZF7N0Z3H
X-Received: by 2002:a05:6000:40dc:b0:48d:e61d:68da with SMTP id
 ffacd0b85a97d-48e6e2fa50dmr3104948f8f.20.1793340864517; 
 Thu, 29 Oct 2026 23:14:24 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d3e9sm1455381f8f.6.2026.10.29.23.14.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 23:14:24 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 08/10] efi_loader: do not load an image that cannot be measured
Date: Fri, 30 Oct 2026 06:14:22 +0000
Message-ID: <be672b54-42c4-48fa-a7ad-994a7ab47ea7@gmail.com>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

With TCG2 measured boot, efi_load_pe() measures each image into PCR 4
or 2, but it gives up only when the measurement reports that no TPM was
found. Any other error is ignored, so an image whose hash cannot be
computed, because efi_image_parse() rejects it, or whose PCR could not
be extended is loaded and can be started without being measured. With
the range checks added to efi_image_parse() earlier in this series,
more malformed images take this path.

As EDK2's DxeTpm2MeasureBootLib does, refuse to load an image whose
measurement failed: free the memory allocated for it, which the error
path leaked so far, and return EFI_ACCESS_DENIED, so that LoadImage()
returns no image handle. A full event log is no error, as there: the
PCR is extended all the same.

Fixes: 163a0d7e2cbd ("efi_loader: add PE/COFF image measurement")
Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 lib/efi_loader/efi_image_loader.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_image_loader.c
index c4f64f102e8..c33b693c4ff 100644
--- a/lib/efi_loader/efi_image_loader.c
+++ b/lib/efi_loader/efi_image_loader.c
@@ -1166,12 +1166,22 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj *handle,
 #if IS_ENABLED(CONFIG_EFI_TCG2_PROTOCOL)
 	/* Measure an PE/COFF image */
 	ret = tcg2_measure_pe_image(efi, efi_size, handle, loaded_image_info);
-	if (ret == EFI_SECURITY_VIOLATION) {
-		/*
-		 * TCG2 Protocol is installed but no TPM device found,
-		 * this is not expected.
-		 */
-		log_err("PE image measurement failed, no tpm device found\n");
+	/*
+	 * Do not load an image that could not be measured. A full event log
+	 * is no error: the PCR has been extended all the same.
+	 */
+	if (ret != EFI_SUCCESS && ret != EFI_VOLUME_FULL) {
+		if (ret == EFI_SECURITY_VIOLATION)
+			/*
+			 * TCG2 Protocol is installed but no TPM device found,
+			 * this is not expected.
+			 */
+			log_err("PE image measurement failed, no tpm device found\n");
+		else
+			log_err("PE image measurement failed\n");
+		efi_free_pages((uintptr_t)efi_reloc,
+			       (virt_size + EFI_PAGE_MASK) >> EFI_PAGE_SHIFT);
+		ret = EFI_ACCESS_DENIED;
 		goto err;
 	}
 
