Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA3DCC83F1A
	for <u-boot@archiver.kernel.org>; Wed, 23 Jul 2025 10:34:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC6918344C;
	Wed, 23 Jul 2025 12:34:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rd5mzOHI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 664BC82E26; Wed, 23 Jul 2025 12:34:39 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DAB98313F
 for <u-boot@lists.denx.de>; Wed, 23 Jul 2025 12:34:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3a575a988f9so3907626f8f.0
 for <u-boot@lists.denx.de>; Wed, 23 Jul 2025 03:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753266877; x=1753871677; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=f5exGR1tOoXpifMkruDkO+usvP303rZQedHA08uoVlU=;
 b=rd5mzOHIPHKBOZzIsbQQZ3oMs+zwGiPP5tExDIxupkAKpkS7l5VQbWTXvdpY4wHs+j
 RsmCq3BXuoR/TPDIUYqwHnjkvKnvTpB+tnCciE5GQ6BDeUFkOT209ZTEcWH+vsOwNTyy
 Tb0Oz2iaFFdIzIaEF52CrY3HznHEwQzTu437SvDSC/uT8FuseOpalQi/+Q+3uhp01DyX
 1Bi4el6n6srLwX+de0Yo/W+x73JBovhvvcxpmLk7hVxnSfUTqOtaAvNCDaIN4YmChPSx
 5CGoNtzoZNt3wyplJwR5ydRPZCRBDvqpaXFnDRZiKcNKWOf72MmBbHKUIDevmNjQ1sJJ
 V+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753266877; x=1753871677;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f5exGR1tOoXpifMkruDkO+usvP303rZQedHA08uoVlU=;
 b=JzBkesSYbE1UelkDz/Wi8S6YmxdYKBVsXg0ZeqdR9eIZVCEN5TUMwuQCUEwkfRa1o7
 Ag9Racc8P9m2xgatlqPKBK4RHiqVpscXbQGIi40UN8SjC0FzBzHdltQ9jZ/ttu3Hkbk7
 ZNWHkhyFFc37slz5BhJilgUCVfjVHwtKK7tRic7mO6WkChDtc4RRCN9tzWXudN8HcNUn
 0RRtNmUl1tbaRaNpofOGzUFXselVghvnhzeupu/HIp59nVN39zv5UKgpfnxH9GrBIJgH
 /Oq5+/MPIL0mxo5k1MP6HLzdJOVf/7CaKvgvAtLaCDs0CIVyaiNue/CjdPbUK0WDD5WS
 xtBg==
X-Gm-Message-State: AOJu0YwGY4hdosvv4E0y/jzPeKsu3twPj7eTj/iH3SLtv0hwU78S3v4o
 Y5eieCnt1zCzt3EZb3/Vvih+YC+IAh/zeNGItUUMrq8EQcAnnEN0XLc0JUPdcjmHYDA=
X-Gm-Gg: ASbGncttLnEQXdjm0XIbEi4hq4zAHv6Nfkzq8yT9QBmHf7DmTn8ekw00PRkyoiqZ8TT
 PNep62EcfL1eBG3LjMTga++HyFIMgxPXD7k3bzoXA4s1l53KMZYDeNgeiitfpOw6JEYc/Rz1a4W
 VNG+BpG9Cyc7W6tqaEqp0mlKLGXk9V4E1lCj/wcCrFuwe6tU+f+1YXCOdjApr8+HoDqxn9+XHEm
 OCZhBgvil8xvsoNmgy6EN09pfU574CtUhVaCau0/Bv/O/kqaz6ml6sXoZBezk3E+XqPJqYOKKkB
 tmW7Ewkl01T8hzwPqbDksOsMxipEdy/tHkJW33LEFDDgQgizFzL9m6KCOu67hf7vQCYu3co3ujo
 OMFpBhosE7sv+1HoEFufWgzJHWqEUkNVX4HWbCc9gmxk52KBctIY=
X-Google-Smtp-Source: AGHT+IE8uUrzFFcTIZ0ivOzN6M7f5bgaQuNrzIWKi+vSiH7z9JhFbKVFjnsmXloOYD2S+EXaEe65hA==
X-Received: by 2002:a05:6000:4023:b0:3b3:e3f6:4a9b with SMTP id
 ffacd0b85a97d-3b768f2304amr2096066f8f.41.1753266876770; 
 Wed, 23 Jul 2025 03:34:36 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:eb9:1701:5143:c98d:3163:b66b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca2dfe0sm16015964f8f.36.2025.07.23.03.34.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 03:34:36 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 23 Jul 2025 11:34:35 +0100
Subject: [PATCH 1/2] bios_emulator: Fix buffer overflow
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-bios_emulator-v1-1-78b9ef7b9b4a@linaro.org>
References: <20250723-bios_emulator-v1-0-78b9ef7b9b4a@linaro.org>
In-Reply-To: <20250723-bios_emulator-v1-0-78b9ef7b9b4a@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

Using strcpy to copy a 4 character string into a 4 byte field in a
structure will overflow that field as it writes the terminating \0 into
the following field. Correct this by using memcpy instead.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/bios_emulator/atibios.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bios_emulator/atibios.c b/drivers/bios_emulator/atibios.c
index d544ffb5ffb..e992a1aa822 100644
--- a/drivers/bios_emulator/atibios.c
+++ b/drivers/bios_emulator/atibios.c
@@ -99,7 +99,7 @@ static int atibios_debug_mode(BE_VGAInfo *vga_info, RMREGS *regs,
 	regs->e.edi = buffer_adr;
 	info = buffer;
 	memset(info, '\0', sizeof(*info));
-	strcpy(info->signature, "VBE2");
+	memcpy(info->signature, "VBE2", 4);
 	BE_int86(0x10, regs, regs);
 	if (regs->e.eax != 0x4f) {
 		debug("VESA_GET_INFO: error %x\n", regs->e.eax);

-- 
2.39.5

