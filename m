Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58885C02183
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 01:29:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5840280758;
	Thu, 16 Jan 2025 02:28:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XbRKDldz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA2B4807AE; Thu, 16 Jan 2025 02:28:10 +0100 (CET)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94AB980214
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 02:28:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3a9628d20f0so2719225ab.2
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 17:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736990886; x=1737595686; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Aga82xic4I/913gUeQ4aMQPGg90hYvhxSNU/YvQJr2w=;
 b=XbRKDldzZcVajzAsFje2IU7JW8CDs5/cKGIzYH5XRwBQgbGWrXNE2qgcy8pi9yhcJa
 sqDcXnE9LYBGyG+6sMrdKB4f/YmR/2NJrVOs/L+XEwi55EZIG2c1qg7rluYi1p26T2QV
 9dfHLCSrRAv2DmEa+OA6i1527cM8iN/+w3KDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736990886; x=1737595686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Aga82xic4I/913gUeQ4aMQPGg90hYvhxSNU/YvQJr2w=;
 b=NK0nFWGvOS/p7hms1Gj7jUSwwvp3weQBRINeq1rWqKTe3uiVsNa3fYrDTeAnlne4KL
 tc3M8xP1yWL/fW9rFnScMeIcCBKfp+q1yZdxnYOKq2lIjT89rVLdfjVvz8mMdbQXt8oA
 0dRHYgPbbj7NE4qBHVAsMglFhwtxu2mjsCZ+oVF2UvQkM/rmZDhGNJYSvg1daCGfUHaP
 RbDAzo7jZrguEPyF1g1lANFddLcqWQpgAApFtw0vHydt6v1ZwI2sHP7s3Ao5tcKif7M1
 r1fDItPfai+77QUM70hY2+XAhEtsBK2cIrojjzDquAntJ7UWtTdwvTzdz9ArOiOFI8y8
 IgZg==
X-Gm-Message-State: AOJu0YwMSD/3nb4k5NYljYEu0g060gQ/2LSM6y7LFGZvn67HW6+Y604O
 CnhjgLDID3cCvEBTx3+1AwRkuu7mPlqXUUjJGckLtkIgNANVdS9UrWjObXE4wWTLMkx/tI58DGU
 =
X-Gm-Gg: ASbGncsViADd194yJ3UYsRvnjhzPErAuNOj9FI/ZJeiGKQauyR6pKfikiSSMvPUinHV
 6vCX0q/8+zI09Pe1R7Mv5WwOsLvcCKqpCVpwzlEhXN7ja8JCxy2P4Cl5knKJMSck9AXrj7Cev7t
 1HbbmqdZDoZ8srKj6htJmsUkepnQqZxHNtvsvfmKONYGqc4l4SmPB7GRGRq/a22vTlMcAzoVgYl
 Qm5kN6K/wySJReS5H6NyUqUXPHsAFANF0V1cnwCw3/2c+Jb0cAivCVAsVEr++3uol08TcRrTJgP
 roUdWn0zi0K6h1i3JQ==
X-Google-Smtp-Source: AGHT+IHfDysYaMu00WS/+diE2z+2a4v7bKyMJaUUYAs1QnrC/iNK6rnqCe3KX5zM61XL01gSvzWUrA==
X-Received: by 2002:a05:6e02:2411:b0:3cd:da4e:2a8b with SMTP id
 e9e14a558f8ab-3ce3a9c6b0cmr240617895ab.11.1736990886641; 
 Wed, 15 Jan 2025 17:28:06 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3ce4add8570sm42587725ab.32.2025.01.15.17.28.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 17:28:03 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 11/22] vbe: Allow VBE to load FITs on any architecture
Date: Wed, 15 Jan 2025 18:27:12 -0700
Message-Id: <20250116012723.2820301-12-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250116012723.2820301-1-sjg@chromium.org>
References: <20250116012723.2820301-1-sjg@chromium.org>
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

At present the VBE implementation is limited to sandbox only. Adjust the
call to fit_image_load() to remove this limitation.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/vbe_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/vbe_common.c b/boot/vbe_common.c
index 5f45724f74b..ecf4ad916e0 100644
--- a/boot/vbe_common.c
+++ b/boot/vbe_common.c
@@ -178,7 +178,7 @@ int vbe_read_fit(struct udevice *blk, ulong area_offset, ulong area_size,
 	fit_uname_config = NULL;
 	log_debug("loading FIT\n");
 	ret = fit_image_load(&images, addr, &fit_uname, &fit_uname_config,
-			     IH_ARCH_SANDBOX, image_ph(phase, IH_TYPE_FIRMWARE),
+			     IH_ARCH_DEFAULT, image_ph(phase, IH_TYPE_FIRMWARE),
 			     BOOTSTAGE_ID_FIT_SPL_START, FIT_LOAD_IGNORED,
 			     &load_addr, &len);
 	if (ret < 0)
-- 
2.34.1

