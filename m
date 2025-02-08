Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61C9FC02198
	for <u-boot@archiver.kernel.org>; Sat,  8 Feb 2025 17:15:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9465080C8A;
	Sat,  8 Feb 2025 18:13:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CBhQ3uuN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12B3680D28; Sat,  8 Feb 2025 18:13:06 +0100 (CET)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB04C80C8A
 for <u-boot@lists.denx.de>; Sat,  8 Feb 2025 18:13:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-844e7bc6d84so96560539f.0
 for <u-boot@lists.denx.de>; Sat, 08 Feb 2025 09:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739034782; x=1739639582; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GB3ft6coeZM2/i5uYYcK7xK0Kh0y6U9sY/miet/OWag=;
 b=CBhQ3uuNy11rSzbPIpFNSrkia2dEgvzKnOZDMH72/uvEhNLaQRaI1H2VLYyYS1nMdI
 jjQGGQpGnkR1ggTIRJOttAJfLZOswSoRUeTlQW52hlrJuMtLGTQIwYC3zpJSeu5MlkL3
 3JanWNn8BjGE30xs7cVzCe76rzi3U0ozbVGuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739034782; x=1739639582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GB3ft6coeZM2/i5uYYcK7xK0Kh0y6U9sY/miet/OWag=;
 b=pbX/PJ37oU+nwFm7vvEhqcZ9Tl1DMdEzjpkYO7wQje4aVHqupebcarqg/OBoi212w5
 eHuwLirq8SQCVJW2VxrWOws+w5oAAPWyuHb8jLRkW6mf1/ezErHLRjZcXTfmV2JfiOjP
 968ZJRrQWkKE27CMWgr/61hQmtU3/ItROFvPP4GR9vKqIs2yk/K0SOQv1ikY9hFbyMAZ
 RFJMngO52ZPR/kbJXYEwj+PrchhDb+2rmjqeerE4yLVOCewk/Tt3tNmhqLx+/w7bf5nV
 nz8NGcaRTOkGInZnMj+qURvuUyh4Syo8o3H8E4VkJJfdE3guyt8SBD35AtJtwNq7NOEK
 04uQ==
X-Gm-Message-State: AOJu0YwZDl12xyt6n/PBwUUiF1etJARr8gOaTFGscWxRBKzJ2d0KFbf6
 4wLK0MdCA9Vvjc8PRSdVBKxv5+6YX1n33jGrSbSMDLcqkkcbcxEnj2d2RdXRK0Vz/QkIIs5z4Ss
 =
X-Gm-Gg: ASbGncvDbmvgv2zQCeonh7B44FFUQgCnaCQmZx8Ed28jAhjQ6h9XpwsJqykLcTxlgoT
 yufCiUPMAOQy6Wv0oEVizXD5G0g9VT8GShYrsNqx79G/n0psEcURInv91U4cJOc8NVMK2AcQVZJ
 FZxurJbBNjw1PfhViMI2wkq9ruPBdmdpBUeeIumkQ1JQm2bS1BEFwt+U7oZ0/Nd5KXhW1WQI9bL
 fK1pHqqvAxIDM2VSUal3iRCVXscpIYZFOi6NwmV8z3r4kFEurLKopgnw3/kZgu7fH+yJy2DPs1R
 8UJwJumGMzZHaJ6dK8RfbIKDtOhHowKBbxLmDPkW52bNCrfA+CpN
X-Google-Smtp-Source: AGHT+IFTVChX6qcdP3EIbwCmPtCZ4HDxacmSSEE0coZ00Ph0O4PP9UdKgAyP7duDeLVFtWvUwk0rug==
X-Received: by 2002:a6b:440d:0:b0:844:2ef3:a95a with SMTP id
 ca18e2360f4ac-854f3a6a163mr883538539f.7.1739034782087; 
 Sat, 08 Feb 2025 09:13:02 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ece80badb5sm371754173.68.2025.02.08.09.13.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 09:13:01 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Albert Aribaud <albert.u.boot@aribaud.net>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>
Subject: [PATCH v2 24/29] efi: arm: Provide startup and relocation code
Date: Sat,  8 Feb 2025 10:11:44 -0700
Message-ID: <20250208171154.1305761-25-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250208171154.1305761-1-sjg@chromium.org>
References: <20250208171154.1305761-1-sjg@chromium.org>
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

