Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6C9EC3DA61
	for <u-boot@archiver.kernel.org>; Sun, 21 Jul 2024 15:26:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A68918800C;
	Sun, 21 Jul 2024 17:26:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="J1V6WOMC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CF7E87E64; Sun, 21 Jul 2024 17:26:41 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AD0587EB4
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 17:26:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-427b1d4da32so15874815e9.0
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 08:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721575598; x=1722180398; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jtzpk7+PfGpTBlxF3F2QiLS4+MvauOBt7bBzUn+TCK8=;
 b=J1V6WOMCJwVTFKMWnlmj2ZrK1jpvVlXgj0ljpBuNcIgHM8qUhmGEwwDjPzvPbYZK9n
 WxRQw9iUjjdj4Ij9hsC4flm1S76k2hAtZ3Jny8G5n/QWiAQqcjo/EgQTy2/8o8/TWv9j
 GTG3SelZIrByPR3L0nDW9bPFKhbRL+/fxFKS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721575598; x=1722180398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jtzpk7+PfGpTBlxF3F2QiLS4+MvauOBt7bBzUn+TCK8=;
 b=DYc0t45/CQll2IT+9o3P0/IooIUhvEoMvytw2t05qm5Xr023xAEfrq35S3qm5yUKA1
 XEwZ6zv9K3ewESfZznchKbvYp4bd2X/t+1RN9Y35/rOvzba3mWhjTODQqQTEnuJ9Gnxa
 NHnaMrJ4/1ASPl5kIxLzovX+xOBo3wsXlE5HDPPYCxDnwShEh5u5FNAqnrV2hmTbp+tC
 3aH01enCkYdMGFEld4ERCapSvteiXtZZiClLc8ig1vDoSF/1F3MLvfzexqlIs6uPk2XR
 P7mHANwouRZu5Z+ueguMoxfgtvBayuHmdrPZRmeyC94PjRiP/MoKBbv9fhziF7sLF+im
 DdrA==
X-Gm-Message-State: AOJu0YxuPb6TjZG7SVCDZQcB0cyg9mTHEgMNf01XOSxyI/dIYEnNAhiM
 SUDgKDe6F+eTIZbXtrL+kULuukRigVujlZ/RBOe4Ype22KkNoSefwZWXewFpzumRKzOPkcXzFhM
 =
X-Google-Smtp-Source: AGHT+IGi8eUgSHWZEx+4TAH0oFYhNvGLU4XD6wQtODxz2LubVOZ9XSb140GWHc3dqj80eExN/K+LWA==
X-Received: by 2002:a05:600c:1988:b0:426:6eb6:1374 with SMTP id
 5b1f17b1804b1-427d29b75efmr75742035e9.0.1721575598354; 
 Sun, 21 Jul 2024 08:26:38 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427e5803bb0sm8702255e9.45.2024.07.21.08.26.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 08:26:38 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Subject: [PATCH v2 02/14] spl: Correct use of CMD_BOOTI and CMD_BOOTZ
Date: Sun, 21 Jul 2024 16:25:47 +0100
Message-Id: <20240721152600.3212917-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240721152600.3212917-1-sjg@chromium.org>
References: <20240721152600.3212917-1-sjg@chromium.org>
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

These should have a CONFIG_ prefix. Add it.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: 7a0d88076b9 ("Add in the ability to load and boot an uncompr...")
Reviewed-by: Sean Anderson <seanga2@gmail.com>
---

(no changes since v1)

 common/spl/spl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 7794ddccade..6f4a8bfb3f4 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -322,7 +322,7 @@ int spl_parse_image_header(struct spl_image_info *spl_image,
 #endif
 
 #if CONFIG_IS_ENABLED(OS_BOOT)
-#if defined(CMD_BOOTI)
+#if defined(CONFIG_CMD_BOOTI)
 		ulong start, size;
 
 		if (!booti_setup((ulong)header, &start, &size, 0)) {
@@ -336,7 +336,7 @@ int spl_parse_image_header(struct spl_image_info *spl_image,
 			      spl_image->load_addr, spl_image->size);
 			return 0;
 		}
-#elif defined(CMD_BOOTZ)
+#elif defined(CONFIG_CMD_BOOTZ)
 		ulong start, end;
 
 		if (!bootz_setup((ulong)header, &start, &end)) {
-- 
2.34.1

