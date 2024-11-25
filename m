Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90F8DD59D6A
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 20:45:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AAAE89A73;
	Mon, 25 Nov 2024 21:45:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YUMdJPP3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3734989301; Mon, 25 Nov 2024 21:45:22 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0828389A6C
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 21:45:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-841a9366b08so28169839f.1
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 12:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732567518; x=1733172318; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DQXkC3H8zqIuYJBRVPxfuIGoIvAddWEkQzPRMLzP6qk=;
 b=YUMdJPP3qQo7lPtZ3PPQx5AjZ9TotzUhzjl/itrtpNDqpRiqv8qCVZQg4OedehrwF2
 rZ8eLduEoaTtvPQBKCTvsINtZCybm87YpLk9Rt9IbQ8BTZiITnkFNRywhxKx4ncTQQtf
 RSdSzgywX9QRPwCdAGlPcyFGMtCxstTFJjR6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732567518; x=1733172318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DQXkC3H8zqIuYJBRVPxfuIGoIvAddWEkQzPRMLzP6qk=;
 b=a5y8+JOYuwu3sx5mC2qeoy1xiOkXWO41MgyX7QLiQQMXfLtKWixhRit6KFQ97KFzxv
 YgkObntMTr/KH8IvcOW+kunFtBJ2g2c1xdfXRm3K0eY28ek4ddf3D4Wj9V2Oh39EU95r
 49Z2ATXImm5aBPt9+R1aCfwOvhkWCcpnhK637cAv/3wKW2PsqxMKMxwo1e23caJwsi8y
 byTu4NxtEWEtrFqb026bQ9thUMOZUuXNi10rv8117Eu3QjIrlAdkLVqE4WBIyveEKIfl
 jBQCrykbRJ7vFQAVOwW+L1RfxLZy//ifBnSwDSWY9o4Xi5YO4FCl+lfN1iXfOj0i58Rx
 oSAA==
X-Gm-Message-State: AOJu0Yzx09acMgJwWdBWaGQC/www0Qv9vZBzOJJpWA1b+f0OwTzL6JSZ
 B07rWOo2GR4QtXFmywXfqfac5d64E/Ljvwhb27aEGxn4WKMdziNTE7KebXlzKVhGyu05kqy6OXU
 =
X-Gm-Gg: ASbGncu2YARoELkCsDttZTB92v6DWen0VhWoSRjaw+U3HDWgbRLx7OJ8Qh0gmu+0iuK
 2PwjZ/2zYmvrIPWJtgXJcZ0aGXwAIDJuZexVoH964bpaHaS3djoax2kCS0U+eUW2tOYu3G2Ix2H
 cNUphSoP8I+lkDESndiMEBbwZl5MIkrftppJ6OF6kD+dcArT89RFyIHnBpzasRymLzeXJsQzI7u
 d4DhrFGOm59iIJ8h6xo8erpgAW3PyBTHBRky/DPqNjIlsA=
X-Google-Smtp-Source: AGHT+IHAgt20XHKDWMvEZiV+iIMScPYQKCZUeerRGhMibseEovNFr0XIDmOb9q399BhYjQWwfE/5cw==
X-Received: by 2002:a05:6602:6b82:b0:82c:f30d:fc72 with SMTP id
 ca18e2360f4ac-83ecdc53c49mr1675868039f.2.1732567518241; 
 Mon, 25 Nov 2024 12:45:18 -0800 (PST)
Received: from chromium.org ([50.235.115.130])
 by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-841ac8403a2sm26134639f.9.2024.11.25.12.45.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 12:45:16 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Janne Grunau <j@jannau.net>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 03/13] efi_loader: Show the resulting memory address from an
 alloc
Date: Mon, 25 Nov 2024 13:44:42 -0700
Message-ID: <20241125204456.1525752-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241125204456.1525752-1-sjg@chromium.org>
References: <20241125204456.1525752-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Update efi_allocate_pool_ext() to log the pointer returned from this
call, which can be helpful when debugging.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/efi_loader/efi_boottime.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
index 080e7f78ae3..90437e3e401 100644
--- a/lib/efi_loader/efi_boottime.c
+++ b/lib/efi_loader/efi_boottime.c
@@ -511,6 +511,9 @@ static efi_status_t EFIAPI efi_allocate_pool_ext(int pool_type,
 
 	EFI_ENTRY("%d, %zu, %p", pool_type, size, buffer);
 	r = efi_allocate_pool(pool_type, size, buffer);
+	if (r == EFI_SUCCESS)
+		log_debug("*buffer = %p\n", *buffer);
+
 	return EFI_EXIT(r);
 }
 
-- 
2.43.0

