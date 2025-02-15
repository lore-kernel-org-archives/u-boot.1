Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C7CCC02198
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 03:26:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E03880EE5;
	Sat, 15 Feb 2025 04:24:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UHDXZtrq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D955480EE5; Sat, 15 Feb 2025 04:24:07 +0100 (CET)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA31880ECC
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 04:24:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3d14f752bcaso17474135ab.3
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 19:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739589843; x=1740194643; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VzbAbn6jezAfM2vkzs+3zRWqKNCeNhI3O86hiTSibVA=;
 b=UHDXZtrqtYk2BrRnLb5YdK6ctr6iBgKBdiuV0AOLufTOLNCBGVGoci8Zjm12CRS6WA
 zJseSmJt4KXoPolvvM72Svn06GJWpiGKQu4LmKSnjTCulxdRp8D8BTkJKIZN67fM/jwR
 eTuJFyKtsmlAWPFeqvGxRnf9uS8oO9uLH8ZBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739589843; x=1740194643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VzbAbn6jezAfM2vkzs+3zRWqKNCeNhI3O86hiTSibVA=;
 b=mSgxyRHBr3ONtR0e6E5sPb9FGdS9/laWLHQt8A50A2rakkfzisX+6VaF53KZ6CmpdB
 0ZlJz7RK/e5txZkvbKcOpStQWUsprIZyMMM+6ok5utqHcq+kftR4itStwH+Hsc6vzk+e
 NBmzCTLo3GMrDoamsd44YbG+0ysOuYorO+2MyI3w+eHwDLdxCYWjklhtcwEbTUpyeeqc
 1hheqyk5mEavEneVeQ6ljucW90JOQv1DqaPzDpYL2x5tcKQ4I83KpHaEr2b1wOVBd4ui
 bZwUQdPkur4GAir/e3afz/6lCp/UccLTQIaRVmjiEJXf+NHJw1pyslZab5gsevFnId6h
 N2/A==
X-Gm-Message-State: AOJu0YyU4ScwwRk5rjV8RRYilDjSQNjNVO26ZQuE+6DpBelndzIdTIqD
 t4bAM73IjpGczkm2Dpy4unqpC+pkFiBbPi6oNrNcHy+lTRTrC2Q4D3FIG6L0/Lbz7jbK/6utvNU
 =
X-Gm-Gg: ASbGnctiq9cD6tjAK2vDLgRjYTwWjj3M2NFY7Do52wf3vBOBUsbfWHJY5A8X0gnjzRd
 INVkDwPE7tC5RnKwRtcb9MYtxkRxHfo/QDESg/pMyxEg3iTnbeheJty4Odte5FFCxnA6O7sDvhP
 VkukKqqH4gv/KnTm8iiGxclzM6iJYjep/mhnhdSW7KPoZGrLSGdAZU2Dqs97cshyQgXB6jzOi+/
 4t7yGFsBnPh36PorCg66j6NBdNX3NJZRycJ64w1OzPFAQO4hRPKdIWrVClelmIO+Njpq6QkZiP7
 3xlzzwYKPf9PBd9i48UGWKNmyu3D5NhczmRFlFe0qU8sJdZMPlJN
X-Google-Smtp-Source: AGHT+IEb+1EFxn0cF4DHky7BCWkadYyOQrDYaHYemVE/gOlbaIVVd0ADJ/0EnbBGRIodu9Z6+c6OOA==
X-Received: by 2002:a05:6e02:32c8:b0:3d1:963b:9f06 with SMTP id
 e9e14a558f8ab-3d28078d2a9mr17335245ab.3.1739589843436; 
 Fri, 14 Feb 2025 19:24:03 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ed2819d0f5sm1087697173.67.2025.02.14.19.24.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 19:24:02 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 20/29] efi: arm: x86: Allow use of the EFI table in the app
Date: Fri, 14 Feb 2025 20:22:41 -0700
Message-ID: <20250215032254.4121030-21-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250215032254.4121030-1-sjg@chromium.org>
References: <20250215032254.4121030-1-sjg@chromium.org>
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
a build error in the 'efi' command with the app on 64-bit ARM.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Document the x86 field better and add a comment for ARM too
- Mention '64-bit ARM' here, rather than just 'ARM'

 arch/arm/include/asm/global_data.h | 4 ++--
 arch/x86/include/asm/global_data.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/global_data.h b/arch/arm/include/asm/global_data.h
index 8d51111f095..ba12da6204e 100644
--- a/arch/arm/include/asm/global_data.h
+++ b/arch/arm/include/asm/global_data.h
@@ -108,8 +108,8 @@ struct arch_global_data {
 #ifdef CONFIG_SMBIOS
 	ulong smbios_start;		/* Start address of SMBIOS table */
 #endif
-#ifdef CONFIG_EFI_STUB
-	ulong table;
+#ifdef CONFIG_EFI
+	ulong table;	/* holds the table address from previous EFI firmware */
 #endif
 };
 
diff --git a/arch/x86/include/asm/global_data.h b/arch/x86/include/asm/global_data.h
index 1bd1fa92078..0d9fa823121 100644
--- a/arch/x86/include/asm/global_data.h
+++ b/arch/x86/include/asm/global_data.h
@@ -110,7 +110,7 @@ struct arch_global_data {
 	int has_mtrr;
 	/* MRC training data */
 	struct mrc_output mrc[MRC_TYPE_COUNT];
-	ulong table;			/* Table pointer from previous loader */
+	ulong table;	/* coreboot/EFI table address from previous loader */
 	int turbo_state;		/* Current turbo state */
 	struct irq_routing_table *pirq_routing_table;
 	int dw_i2c_num_cards;		/* Used by designware i2c driver */
-- 
2.43.0

