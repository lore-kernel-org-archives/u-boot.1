Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC152C02196
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 17:46:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8250807E2;
	Mon,  3 Feb 2025 18:44:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jOPaK27O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1A248039E; Mon,  3 Feb 2025 18:44:15 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89D74800B3
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 18:44:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3eb9ba53f90so1387191b6e.1
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 09:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738604652; x=1739209452; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZuUetpmbuzS6gMIAKBaYDVXHm5CVqgWXV3utuFzqna4=;
 b=jOPaK27O1cFTh7kvJd43bucL3c6zEJQJ8p2JFQnL5uTAY1GwDMTBT+7eyr/WsP4wkr
 ijj6pXVF+1ucTNGfb18zPvaY8L0BCglr5PT3sCAFnOHpb8b2uotca3eIvHfbWNpdTV52
 VLfPel3r6hoWluJ+/uTtqPe8XRhSTW8+CIlm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738604652; x=1739209452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZuUetpmbuzS6gMIAKBaYDVXHm5CVqgWXV3utuFzqna4=;
 b=i0BULfJD2qteY3jl77SnUKz5/PMzXy5C2BSQInT9QQvaC/yIr8e2K3bboTpUBUN72I
 JR64oRSf3Q/CuKcQobAe27sb6BCfeSsmg5//RN/jNe9uaPp/wPRUM/FBRe39+ViJ5c4w
 Osa7u0vS0lVPUIFM77xhGZ3Kk7q2NV4adaJCUMrxn8RuiSx/U5KFsazDUMQMksyCV73D
 0zXACTUfbsf30/TCgqSBn8hy00QBtElv2EUGLSRypkjcFFDrAsAOsLaUdqlmyBPJk8Jz
 PHI92xxvxNCXB24C3PFybUFzWPxPcdsON10gM7t1Fuf2/JjB8qjCWkbKu70w4wMjiVPH
 qF+A==
X-Gm-Message-State: AOJu0YyxI9zm8pMShCieiDF8tQyba3ZS1BqAY7/4WBTsAhKMUClya8hZ
 bFA+bn8/ZBhlA+AQgqjTMMchIFI3D4/W3rEiN69KSKJ7W+BRcK5NWshI9gPc21AKFKT2//H4I/M
 =
X-Gm-Gg: ASbGncvECOgx27hOb2ydaDnVpjjsdzaHTwDciZkmU1qNDP/fYpUk1U2vVjKYASe5Q+F
 HVKfjlwr5+HEe8x2t0iPBk/57tX7TwI1WB4AF+TL/fu6AHrc21rwa2JLxnrupEyS6CyXAAv/Ojk
 oEo00ujpbxHRVQmrAQVY+FIFhQwmQbIgJO92tTHVqSyk2usJE5TzbVknq6HgZ9vDb2G/yQAOf8k
 MnDgp+QV2zilJ5DJg5CL+Wua3wSb+XsvWH8luuGQ0pb6J5F72hAyRXEocXGPCxGTInaVxFnsNmq
 XoH2Pdd9/UfhuccozLKn4ObkYnAXegqL11llcrcSVbVqa30LRDbC
X-Google-Smtp-Source: AGHT+IG/jAjYmQbcxaHbEl5itCCWhX1MKuiEVoUmjcX4DqnmRsfM5y6ngV4Yg7iu4LqxYKOVGhAs9w==
X-Received: by 2002:a05:6808:2f07:b0:3ea:6149:d6fd with SMTP id
 5614622812f47-3f323a14825mr18132220b6e.2.1738604651679; 
 Mon, 03 Feb 2025 09:44:11 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f333558c89sm2564203b6e.24.2025.02.03.09.44.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 09:44:10 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 22/32] efi: arm: Allow use of the EFI table in the app
Date: Mon,  3 Feb 2025 10:42:15 -0700
Message-ID: <20250203174245.1331464-23-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250203174245.1331464-1-sjg@chromium.org>
References: <20250203174245.1331464-1-sjg@chromium.org>
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

It isn't worth the hassle of omitting this field for the app, since code
is shared between the payload and the app. Adjust the condition to avoid
a build error in the 'efi' command with the app on ARM.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/include/asm/global_data.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/global_data.h b/arch/arm/include/asm/global_data.h
index 8d51111f095..6a85fb2e152 100644
--- a/arch/arm/include/asm/global_data.h
+++ b/arch/arm/include/asm/global_data.h
@@ -108,7 +108,7 @@ struct arch_global_data {
 #ifdef CONFIG_SMBIOS
 	ulong smbios_start;		/* Start address of SMBIOS table */
 #endif
-#ifdef CONFIG_EFI_STUB
+#ifdef CONFIG_EFI
 	ulong table;
 #endif
 };
-- 
2.43.0

