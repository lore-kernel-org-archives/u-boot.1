Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24933C0219E
	for <u-boot@archiver.kernel.org>; Sat,  8 Feb 2025 17:15:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D3AB808AF;
	Sat,  8 Feb 2025 18:13:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="V/tdoFN2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B48C280E94; Sat,  8 Feb 2025 18:13:13 +0100 (CET)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D42080EC1
 for <u-boot@lists.denx.de>; Sat,  8 Feb 2025 18:13:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-844e7bc6d84so96562839f.0
 for <u-boot@lists.denx.de>; Sat, 08 Feb 2025 09:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739034787; x=1739639587; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l1FiL+b+2bi6YDGKzQ5TE0O7W/UvOKkFXkHlQf3kCao=;
 b=V/tdoFN2du0RzNiddMTWW2BfuLvSml2x983y88pzjt/wrZdbJS7Io8ZQUi2QWYabGZ
 2z4w6wYl6jQy9KlN8oWMF3kvOUkX11xeorbdP4sAFtLzLgvxczGInew5B1UIJoB/Xr0c
 DtT23ZIAhmHkb3k4MgOS7bmC39+JZLnEjNIbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739034787; x=1739639587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l1FiL+b+2bi6YDGKzQ5TE0O7W/UvOKkFXkHlQf3kCao=;
 b=RRpldjJWAn5AZ+UvUE6oDh+VZy5Girc6H1JeAP7ygzDK9zevlS75C9S1CEL5b4w5LE
 VAQDz8WgvsEI0yKlbgyk6MVggZTe+xT8n7Lq6SvrLQlHL5+YSfMBnUFlVWI10xGHzAJA
 pi2pmdZdvzNSdY/WjC9n0wNOT2MjA4k0tPc6l7zLAdsNl8FQMlnRF0Lq+GbmxFLbwhHV
 hqNVq/He965vgjShgUTaCdRXz1K5dmIpODTyvZXenEiJQeTnrxOy1RAopSC0Wy4jmXqk
 K0kc/kloWYd5WCkKg+Ti0+6R6b0hqVZVfLQZItLWlNYkRW1dROhus20ZPh+a+CuQjqRV
 FpLA==
X-Gm-Message-State: AOJu0Yxxwo0jqWjeKzzLh6Aq/Xrna0UAtrH8r+brzEoneu3I1QnDljPf
 Vsriq1xhjj4z0N+uZ9wo6yPGq+qYudJn3MH4OomRCUrYjzg7NjLYLaFVLJDhwyqqhAMHPFBY8+U
 =
X-Gm-Gg: ASbGncsiJJwfWIrVqghdLvnheY8CFIHjntvaQYKn/E0GTGBr2TRnd9Ogq6sKSA83/4h
 BAnrPDdnek8C/VEbwBuSukVgwZ/nLIMOye0GbuBEVLhLCRLUAP9DmW0DxKSCMAlWrmGQM68L+iq
 MCEGZ2yXnMv/trp12f2/Eo8n3e9BsX5QMyjuFQVbYwzP3yfrQpU3DvP4TcG4UyJyoqgSV07a3RE
 4xZPMcHWSWFfKozL7g4qyusDyyNUDWydXSUKZrY1AWl370dDRYjpzWUh/WBWagFpUchb7M5om97
 uS/Jjr/GvYjWHz5+Olfkr+tYkkOX39hBGs2YbM6C7hRzOHjxvhtq
X-Google-Smtp-Source: AGHT+IHixQRgrWZbarGnuQ125bl0QbeUlIQoKokUau8geEHCXvnBVMUYDeC9Iu9OPCPB7KjaNgt+Ww==
X-Received: by 2002:a05:6602:ce:b0:835:39a8:e201 with SMTP id
 ca18e2360f4ac-854f386ec03mr836022539f.0.1739034787646; 
 Sat, 08 Feb 2025 09:13:07 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ece80badb5sm371754173.68.2025.02.08.09.13.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 09:13:06 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH v2 26/29] efi: arm: Disable STATIC_RELA for the EFI app
Date: Sat,  8 Feb 2025 10:11:46 -0700
Message-ID: <20250208171154.1305761-27-sjg@chromium.org>
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

This feature should not be used with the app, since we don't know where
U-Boot will be loaded. Disable it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a55ba6b7f09..fc8870c19be 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -142,7 +142,7 @@ config GICV3_SUPPORT_GIC600
 
 config STATIC_RELA
 	bool
-	default y if ARM64
+	default y if ARM64 && !EFI_APP
 
 config DMA_ADDR_T_64BIT
 	bool
-- 
2.43.0

