Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E75EC02196
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 17:47:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6ABBC80A09;
	Mon,  3 Feb 2025 18:44:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IGhaj4/Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA8AE80A09; Mon,  3 Feb 2025 18:44:40 +0100 (CET)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A35068070F
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 18:44:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3eba347aa6fso2963840b6e.3
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 09:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738604677; x=1739209477; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=an3AXcDMhwsYq0B4Bkggrfvq8YfaXGLjuO3LQ2gS7HI=;
 b=IGhaj4/QvH9OxAEBkdeMQme/AdUD7t/MOZmwHJA3k2doJIdjv6ZGh5WMdrdtmEgVzt
 9g+8bSTd8DEdThpTSK7CnilOsg5TjvzOp7EIR2ZuNxSLQr0BVJ4S8Xhko7vc8Gw66YkF
 /tpeBe6HusdlolJz6nusLyoteRcHL7Q5urXyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738604677; x=1739209477;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=an3AXcDMhwsYq0B4Bkggrfvq8YfaXGLjuO3LQ2gS7HI=;
 b=VVznjYNS5+UUfvqop2xP1zI5Ntr7ZjYV1rtkTydcnmMeI996COUDm7y2vhTCRCcfAF
 rxVnJ+wrW3WTjfP4hQ+5VxNPPtvvMTMkrKatcingHFhFXtlgh0zprLMdCdbzDGFJKZiP
 mcoYU0+9mXSm0JnSqLAqqzgKxuIgeBNdhNT+6AJmT7lb8BYYOz1/Ztfk6RHYY6Q0wBG/
 H5+whTWPsgg8TOQHjV/S0Pk02owzwduspuCJ/JsBZ4gpEPY23FTP02SaEPkjO0Qf77l0
 sQoLIIxI8ni/mXocOiNhRGs53l8TirMw2EyXWaX5z36Zx5LTa31OGOUF5XXCvtpl0P5q
 MDTQ==
X-Gm-Message-State: AOJu0YxDiQQasUTX2QuAtRovIPAUCGsG8Ed2EdNsVXMghX6+sgAbGiq7
 lJA881yN+DXIzHkCBHzBoEg17gGb2H09rTk8AWyNtQXF+rB1pYIa9tuSjjuI/YNBFY2d2ZFV22M
 =
X-Gm-Gg: ASbGncs+T0mnzyYnh3yAUD7iQs/uaNYjHKyz00LJm2u5i/qGtOr3ksxIe3NQKghAUyt
 79hVT7/atQBr/Hf8QC7g01JBOatk7SFNO0uEYtwBLJ/W60LXsif8OIiv9ZqaU/2688ccHA8aKAT
 i4uX+zIvA+9XVJJClenbfkCaLes4ppefGw78gxut1NeJXcAGxpoR8aWNfmPrb2PzHrVAGHiH7cB
 54xqwPxFFX/FpmubrKFJGxFPTvL6wVmPgwUtHfaxUVNsqtuSYP7FAadvO0/R9CYG82WmonSGZwP
 SWBvd9oRp/7NdqkMZYUk+GlHrUpEo0NzmFzkHtOa/sG5mp2Hj4XK
X-Google-Smtp-Source: AGHT+IHD+57NYtfNmFi7Yb6oTgIhQ5XduUY+3jmT0Q6UXgOPlsvoLsDYbczbiDoIw3VHrH8wMeowwg==
X-Received: by 2002:a05:6808:1485:b0:3ea:443e:d1cd with SMTP id
 5614622812f47-3f323b6f27cmr15113606b6e.34.1738604676866; 
 Mon, 03 Feb 2025 09:44:36 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f333558c89sm2564203b6e.24.2025.02.03.09.44.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 09:44:35 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 30/32] efi: arm: Use EFI flags for all compilation with the app
Date: Mon,  3 Feb 2025 10:42:23 -0700
Message-ID: <20250203174245.1331464-31-sjg@chromium.org>
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

As opposed to the payload, which is built normally with just an EFI
stub, the app is build homogenously using EFI flags. Update
PLATFORM_CPPFLAGS to enable this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/cpu/armv8/config.mk | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/cpu/armv8/config.mk b/arch/arm/cpu/armv8/config.mk
index d2d1a8d2bc2..cf0b89819d5 100644
--- a/arch/arm/cpu/armv8/config.mk
+++ b/arch/arm/cpu/armv8/config.mk
@@ -23,5 +23,6 @@ CPPFLAGS_REMOVE_crt0-efi-aarch64.o += $(CFLAGS_NON_EFI)
 CPPFLAGS_crt0-efi-aarch64.o += $(CFLAGS_EFI)
 
 ifeq ($(CONFIG_EFI_APP),y)
+PLATFORM_CPPFLAGS += $(CFLAGS_EFI)
 LDSCRIPT := $(LDSCRIPT_EFI)
 endif
-- 
2.43.0

