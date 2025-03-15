Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A18DBC28B28
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 14:28:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE6158197F;
	Sat, 15 Mar 2025 15:27:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bze50ju2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1671A811B2; Sat, 15 Mar 2025 15:27:34 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B9948197D
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 15:27:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43cfba466b2so6897475e9.3
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 07:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742048851; x=1742653651; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ALveOlJ1YYPaatt9hXqXziYO3Z3wJwBWWAuV27HIJfw=;
 b=bze50ju2jSArvPSoLPMp3ZQvzqs2YNE2IYT5GI1VRXyAz+XFxnWqsAjqy1e0SlMjoz
 HG3KwJbXl8MVOaqyL13zLIstxiFgSEqdLQ+d5OPU/4Ox3n/l7FK00i1aBG7N+lkEWe/I
 IHInCRNjT+04FmS5KCYNmVMAvamq3vgPBKge4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742048851; x=1742653651;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ALveOlJ1YYPaatt9hXqXziYO3Z3wJwBWWAuV27HIJfw=;
 b=slRi1RpKdwRAlZQK5tuJ0olgzSflqRlFu2Rz7RPNfXSYqjb4Gkj3D9/F/nzzW1Gf5m
 6bNh/g/Hu4VQtKSEcS7Q+1xo85HVCCCgpqh9JW22z2KeLHJ2rj1bWjx+kKYEdqnc7ScQ
 rQLX3iL8PqX82gZaexnLRUFCz0e3AFebyDhF/KpCaM7n5NQVfOTnt+pEp4SzaFPMQlV4
 4ra9Bxevvss5iZMkPpa8lSzv1hGvUU26ajyOjMTm9tB58Ui1OW0ow3J6e8qmLa2o284v
 HJePpy2f6sVIrpAPww9h4gR8AW4XD1VDqPruuVZFU8W2QUIZ8m8Qw8A+bzauJffP29AX
 HWnw==
X-Gm-Message-State: AOJu0YxvCCVho6eE0AXDie2VvFeuw/yyTEFk+p0ELLyi0CO8cQ7gUJro
 Ipvai+GCfmsCavFgjXmj83g8YBotCd8KDT1JkZUnGovHLPEFQfbHAZSEzO6pjvbMgY9shvFGTYF
 NVQ==
X-Gm-Gg: ASbGncs7BgSYQ/bfOSOkgRd4BzXVemsuzN9eMoGoec28bWanu02ah9ysuxBUL6Qe2rf
 hWiq0gUElRqC51GUwDaccNh6IhTmpenjZ+RDeSVevtkjP2Gv3ZZH7gzgePUJdtnIwqIqux729ot
 CQiCYwEY3GodotP4J+Ca9LL1ifnoCi8GMrMGQLz+pQIO2J3nPVO1qE9nVRN395A9yvEnzxIxgra
 5asFFfxUuMU39f7Y8wvTQCn3RGDfgNmL+EVmlp4sQ7lG0qu2M5e0YRB/8mrBHCdbDmOytiDbA9y
 VIL6UugO7NOcDwm8P8prHfmEEUdGDPD6UXGhimJzdw==
X-Google-Smtp-Source: AGHT+IESQglFHl8QH5i5dSvmcR44lhFIMRbqTBz44j2Hxse4VtoM8S5egOk1GbMGW3CLtHO0UdK5qQ==
X-Received: by 2002:a05:600c:4fd4:b0:43c:f8fe:dd82 with SMTP id
 5b1f17b1804b1-43d1ec8e682mr75321075e9.18.1742048851081; 
 Sat, 15 Mar 2025 07:27:31 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe29386sm52105055e9.17.2025.03.15.07.27.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 07:27:30 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 10/46] x86: Avoid clearing the VESA display
Date: Sat, 15 Mar 2025 14:25:30 +0000
Message-ID: <20250315142643.2600605-11-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250315142643.2600605-1-sjg@chromium.org>
References: <20250315142643.2600605-1-sjg@chromium.org>
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

U-Boot clears the display when it starts up, so there is no need to ask
the VESA driver to do this. Fix this and add a comment explaining the
flags.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/lib/bios.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/lib/bios.c b/arch/x86/lib/bios.c
index 5dfe5a647eb..de4578666fb 100644
--- a/arch/x86/lib/bios.c
+++ b/arch/x86/lib/bios.c
@@ -231,7 +231,11 @@ static void vbe_set_graphics(int vesa_mode, struct vesa_state *mode_info)
 {
 	unsigned char *framebuffer;
 
-	mode_info->video_mode = (1 << 14) | vesa_mode;
+	/*
+	 * bit 14 is linear-framebuffer mode
+	 * bit 15 means don't clear the display
+	 */
+	mode_info->video_mode = (1 << 14) | (1 << 15) | vesa_mode;
 	vbe_get_mode_info(mode_info);
 
 	framebuffer = (unsigned char *)(ulong)mode_info->vesa.phys_base_ptr;
-- 
2.43.0

