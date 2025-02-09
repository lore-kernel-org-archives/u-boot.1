Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4981BC0219D
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 02:06:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 791A380EAF;
	Sun,  9 Feb 2025 03:03:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="J6/Vkf1Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7812680836; Sun,  9 Feb 2025 03:02:52 +0100 (CET)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33B8580141
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 03:02:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-3ce886a2d5bso33004195ab.1
 for <u-boot@lists.denx.de>; Sat, 08 Feb 2025 18:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739066568; x=1739671368; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GB3ft6coeZM2/i5uYYcK7xK0Kh0y6U9sY/miet/OWag=;
 b=J6/Vkf1Ym0VrLSJyJe8T7GSON7E87X+o7e/7/CMyFiVG7STPfDkZwREV9fvyGnQ6CJ
 4gB0nhtGLy4rI0HNKZAHV324hzkP5hhMmwsYuQ5l1NQ7zlOi9mzKaWeDLOeoLeI6VGxj
 JskKnjhlYe/xCbc/a4CnjkE6LyewQek9gBFU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739066568; x=1739671368;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GB3ft6coeZM2/i5uYYcK7xK0Kh0y6U9sY/miet/OWag=;
 b=f1D9FkVMxkRHge34jcxzNb3rJR9uPJUEnwLHONYctcD988Bo6bfDoAgo+8JWJ7VOEZ
 tf4ReSXqT1yj6Bozd3JjvvWHwXtpsnkOLLYzMudhR6k05kNswDzzuhepFa97Rgp2dfL1
 b1Jq2Y67jJ6UknGodtiE6PSNZi4Wol/Ds8sQlV7851pGOQnbPrm+0RcrMxaBvevNAWzG
 sJeuEWcajgrSVasuDzlR1OghIp+/ImYIdpC2ZNrxNqxXpzOSymwexKZyZErpR3D4yeqO
 djQI5aY8Asz4rvZMJuG+xj/37n3cJ4UXwR+dD/6rurSf5rQmBgfBx0xN5XUw/VgNpT6i
 rYjw==
X-Gm-Message-State: AOJu0Yxcubcj7lbD0tlNFrMKK5CdCEZekQO3IK+MN7dG7QD1lO71FjN7
 T8xtsb6PsCUkEX0wNum5D1cvzW80dgk5Qp87R7H1EGVrLtt5VXNDR75E19qMojhTDmmmWL/s/GY
 =
X-Gm-Gg: ASbGncsUSj0EnYGzeobu/DDCjqiWQ0wstPCp0NZuC//+oRlcGOoFSBf2NsmNPuho7vR
 tHHsWWgiojm2DrOZig33Kwb6U8Egvc9RW2JpztgA6x0t/DSH8AWcummeEmEIbqcZc8tIeZCqEyB
 7xNWy2uCed7vf8e2JYVyep+TD/LS7KqQIsgosCSaHHKo3vlV1q0Q9fIFoPpEBsvHJLVEP+lidzi
 YMh2a5Nf3aOZAtXbyLNKXuG92rPC6u5XKCoPQFfjjA8tsgadIBYV8uQ6bDue1BGHZXfotw6soE6
 KwnIrwwz5j6HKsVkkChWCdXJje6wuNwb0rTldTn4U++VSu93b0b4
X-Google-Smtp-Source: AGHT+IGn+wdpD7bf1RNqYLKihJbx20UNPl7KiXFIcIzdedgBk8aFQhIfmECIjKErdno17haFGs5dkQ==
X-Received: by 2002:a05:6e02:1948:b0:3cf:cb93:de02 with SMTP id
 e9e14a558f8ab-3d13de78c94mr85645845ab.3.1739066568082; 
 Sat, 08 Feb 2025 18:02:48 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4eccfad03d4sm1506705173.75.2025.02.08.18.02.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 18:02:46 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Albert Aribaud <albert.u.boot@aribaud.net>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>
Subject: [PATCH v3 24/29] efi: arm: Provide startup and relocation code
Date: Sat,  8 Feb 2025 19:01:23 -0700
Message-ID: <20250209020136.4108987-25-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250209020136.4108987-1-sjg@chromium.org>
References: <20250209020136.4108987-1-sjg@chromium.org>
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

Build in the EFI-app startup code as well as the code to relocate U-Boot
to the loaded position, since this is under the control of the previous
firmware.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v1)

 arch/arm/lib/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index a41566c816d..a2b8ef96ff5 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -32,6 +32,8 @@ obj-y	+= relocate.o
 endif  # ARM64
 endif  # EFI_APP
 
+obj-$(CONFIG_EFI_APP) += $(EFI_CRT0) $(EFI_RELOC)
+
 obj-$(CONFIG_CPU_V7M) += cmd_boot.o
 obj-$(CONFIG_OF_LIBFDT) += bootm-fdt.o
 obj-$(CONFIG_CMD_BOOTI) += bootm.o image.o
-- 
2.43.0

