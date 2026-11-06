Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15369606A326
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 21:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PdFe5bqT;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IE0psiuy
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E15B760D57;
	Fri,  6 Nov 2026 21:57:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0S3qxB8lIsvG; Fri,  6 Nov 2026 21:57:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2D52460AA2
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794002241;
	b=Wu8cQdwqozpAH9Jnt8+FGr3ir9Ep+1FiC12i5567I6C1WyZXkBxcVGaMf+05ZeKgV48y
	 yHuSH600pao4m7VaV6hVwh1YjbM1FEy6AxfdDFEYns+d65o2AUHt4V/ACmGzwtG9BBW1y
	 Jin+WgGOPXJalKWncdDCw+wm8hpUl0/CvlSR0NgdDxGniBZgK4ntEj86lNFTUvg0hdQcj
	 ZTuFMlmn5V5o40w8AEGME7hinwUtels7N7wmacis/v9tOm+c3aAFa5+ap4ddcTN/USVtq
	 cG273GA0UaBmsk27HzgkuRkPUNS0G7hASYU3MoAzDipHWa6O9AYecJJ9cG7XlTtFo8A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794002241;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=rmO3drZRlD7t+gIk4qJ3h4k+5SpDVXSGzXB+W8+ys6c=;
	b=KQ+qKJvACKxUEej1/Wgvq2C4y0Nnv6LBGvyXwgQR4s82KDkGQrZSOYzuOp88JR/agaTp
	 kCoue6FE5O/rtwkYMpMlWms/KZ6i3r13V9q2nFeAE/gSTHw98LmPTBpyLbKHEjmW855+/
	 y4j5N256QeQX736J1PpU6y39Cm/OkgG83amu9Fk1bkDeF2HFTp7EqXOpXt7k2sZhs80s3
	 L3iAg/xiDdXXvrYONgu5zXkXiY63Z2fj41jR8JktwnSmEdwK9naj7t3aDz+jnYayr6AJ/
	 9gZuj5oCQRP9BaA1GLl1N5WjtSmo1cS8fp2Lefhytt0U4pEF8+u6Uf3TqDg3R0wzfbw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794002241;
	bh=rmO3drZRlD7t+gIk4qJ3h4k+5SpDVXSGzXB+W8+ys6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PdFe5bqTqAEFjatMhNYfvho1dXng5wJxLN/JQLt7OqwBpxpbjvMBMLwDLIfjEHa3d
	 5QzEUz3XJoL8Wb5xsmYU5IfP6OtTlpNfbZIrfyMoFxls7U0nxcokHC4Kd3elJT1uum
	 ce5uXD+0ZTVyCn66g//B1dm/0VorEAOjMWISc1JIbzQA1mo17kIJMuMmcBytpGCMNA
	 hIMz26so2Witmz6Zu/vdpZymucD4jJplyDHkP6QvAdaemRFc8XrzF6zZW7TgvhSEq5
	 tc2B6SmwC5A9ag46PHb1lN8tQhHoXp2Sw2Moc53M0Xm0FotGogGP+5Ywae97f7bFPd
	 ZrwskxgiTTokQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2D52460AA2;
	Fri,  6 Nov 2026 21:57:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 136AF1C6
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:57:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id ED7C440401
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:57:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BRDpqB55ArS9 for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 21:57:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 19363403FE
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=IE0psiuy
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 19363403FE
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:57:18 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-4910b863b84so44305f8f.0
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 13:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794002237; x=1794607037;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=rmO3drZRlD7t+gIk4qJ3h4k+5SpDVXSGzXB+W8+ys6c=;
 b=IE0psiuyURmA1QrinMun49iU2VSRcKPyoRmvQpKJN7bw/Xqi2E6ChzCkpJyyOXKkC9
 YLti0/52MNh7HB0C7wWOcxvbSShXMH65Tlhubw5KcfoBqL1AQkrj8aQfWOq9aQqiyijv
 Uj74FYC1Ieq/Wbu0t7UFxjaYyAqtJEVvtM2QFMnUWVy4VrA6WZFncc0SPYa63tWp0yZM
 CC35ERLKWpULL3QpEWKwPY5lzz0d17BfvHKAGI29erjsnRidCxzSbtkB2z/WW/ExwqIg
 gvliVRLI8CguZTahRsaUsUSR3IU8Z+e72xe744S3xdbpzYhRFe/MGFN/DXaTGrGqfZDF
 IDRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794002237; x=1794607037;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rmO3drZRlD7t+gIk4qJ3h4k+5SpDVXSGzXB+W8+ys6c=;
 b=CKbo6TcB5RJiA9Vu7fOGxNbfz+JZN08RkgbjcZ4QvXBDc6po20Kwet3H737olkNexL
 AhDKtm0r+A8Bavu2Nw9ZdR4EZyskIUrNEI561eMQDaSwyN467j15EwOf4ecmvI/MJNOv
 xIoyF/iwiLPwhn2b2sSmMddrOaXlGjayR1dnETZJlfAGO0DbceMvBmXe6HwsHPkAcjwj
 MjvcAZZsMEzdLgFqD9NgKbJS4MzkIl17I86Kh8mM+rWbaUZX0xitojbMuANEEVh6MZBA
 a8WMtEGhhAZ25yP/N/xW6PkpPlsu2aDyJqkPEsCB9iZKJZyrR9rKSsVseSJD68u1YveD
 wvbw==
X-Gm-Message-State: APuU4Z8rF8mRXlGkc7ebN25wQ6XsEeBV63G1g8XCkhVRf4L0lzjJTgZJ
 1MzZym4kIm9e7nPY+m7Y0zRb4ArObXRG89Zq/stHcA+94YQwXSy9j/fWQaG1JLy/du4=
X-Gm-Gg: AYBFou07YxzTGRiL0PjKE7tLKBoFAWsPBJ1Sm7dxw/NvX3e9dxMmLyqQMtrQj9fML3e
 WvyHoq017N02NxjJGBj0gtX9ZokIp4/zBKFmScYLkpAZJH5XETeffie5pkY3oUWgEzyGUNZSf51
 slZeM1hkYaUceEmTuAffzBqNBW8YThJBQXGqM4QJ4Je51uyhoW9O8Mv/7CsX4tScYys1rWUi0mq
 gONFhaRrn21jjwi+oq810vGB6nE/pR1A2d5VdsLehXl6lEGZZHdFyOXZ/hwx+MEkHUGFgPOo19/
 fEpQZ47s2394TxrkkhH2B2pIlbJjczZzEjs1fz2fJd32qeHldb8SqLNJmK9j+EMnbzBMx5tJVrD
 Nzon66pmvx+Et/2IPKjt0WLmpy8J8yRPKCL9T7Gy4y+vw9BvoeaYJyEDPrKZ8sucZ51KTpndQMT
 XlimGhwCRKOozNqMSiIPyV+uOlpOXrEQJ8ULeUN+F6VoKEJPhu4CAViDfjvvZKLUBHi61SrvKmw
 TALNnKGoiK1HgOVrsGF1CLhA3Kqh1fCEM92ULZPy+XOT/MItxIQ+n2pjIwHO5EINYSMHbX5OYKC
 CifDLXkhl+pfDk51XRtJSU9O+I9KvJ1xy0xfp3MMh8VS7TQYRtv2
X-Received: by 2002:a05:6000:5c6:b0:490:5521:f24f with SMTP id
 ffacd0b85a97d-4941f667da5mr418249f8f.3.1794002236632; 
 Fri, 06 Nov 2026 13:57:16 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d7cc5e23sm6179984f8f.45.2026.11.06.13.57.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2026 13:57:16 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v3 09/11] efi_loader: do not start an image that cannot be
 measured
Date: Fri, 06 Nov 2026 21:57:14 +0000
Message-ID: <0f646128-9c33-45ae-a275-60dea1b58502@gmail.com>
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

With TCG2 measured boot, efi_load_pe() measures each image into PCR 4
or 2. When the measurement finds no TPM, the image is refused. Any other
error is ignored, so an image whose hash cannot be computed, because
efi_image_parse() rejects it, or whose PCR could not be extended is
loaded and can be started without being measured. With the range
checks added to efi_image_parse() earlier in this series, more
malformed images take this path. Such an image runs with boot services
and can start the expected boot loader itself, which is measured as
usual, so the PCRs end up as for a good boot.

Mark an image whose measurement failed as not authenticated, as
efi_load_pe() does for an image that fails Secure Boot authentication,
so that LoadImage() returns EFI_SECURITY_VIOLATION and StartImage()
refuses to start it. A full event log is no error, as in EDK2's
DxeTpm2MeasureBootLib: the PCR has been extended all the same.

Fixes: 163a0d7e2cbd ("efi_loader: add PE/COFF image measurement")
Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
Changes in v3:
- apply to main without Heinrich's "efi_loader: handling of missing
  TPM in efi_load_pe()": the new check comes before the one for a
  missing TPM, so that this patch applies with or without Heinrich's,
  and his applies on top of it (Ilias)

 lib/efi_loader/efi_image_loader.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_image_loader.c
index 67b83af0e8e..b14065fed6c 100644
--- a/lib/efi_loader/efi_image_loader.c
+++ b/lib/efi_loader/efi_image_loader.c
@@ -1151,6 +1151,16 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj *handle,
 #if IS_ENABLED(CONFIG_EFI_TCG2_PROTOCOL)
 	/* Measure an PE/COFF image */
 	ret = tcg2_measure_pe_image(efi, efi_size, handle, loaded_image_info);
+	if (ret != EFI_SUCCESS && ret != EFI_SECURITY_VIOLATION &&
+	    ret != EFI_VOLUME_FULL) {
+		/*
+		 * The image cannot be hashed or the PCR cannot be extended.
+		 * Do not start an image that has not been measured. A full
+		 * event log is no error: the PCR has been extended all the same.
+		 */
+		log_err("PE image measurement failed\n");
+		handle->auth_status = EFI_IMAGE_AUTH_FAILED;
+	}
 	if (ret == EFI_SECURITY_VIOLATION) {
 		/*
 		 * TCG2 Protocol is installed but no TPM device found,
