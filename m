Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF59EC87FCA
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 10:04:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB0B4844D3;
	Thu,  7 Aug 2025 12:04:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ciKZDQzS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D55EB83C39; Thu,  7 Aug 2025 12:04:20 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A6D783C53
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 12:04:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-459ebb6bbdfso5518415e9.0
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 03:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754561048; x=1755165848; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MH3TF5/YN4Hlu7k7zMMLjhGJygDR5pgvQMYQq30nvJI=;
 b=ciKZDQzS/HNsZMhZqNWppxuYePnZfmMTxFZbbCJjDYngbgjWVSjtrGPHchztzkUZ51
 +TWuoO0eeiZtVvzlPzyBUAwM8SH/mEoPGoo9/WS82wTlUmzpj6IdtgCws8pdnMJaOGOR
 +BAsV0jKicGdudvvovcNhvdQaJ7DM6pEmHOJStuUm0sY+espkocByRCgvYsUCgESVMWz
 cGIPzcIvfPKC6y8KZdGE1bIgIQT1jb1/om/wkuIAGUQYAi4WayNzT7BSHq/fIAINJHJM
 yU3zuPlNUOr4LVrMPRNWD14m4/GY1JjAtcF+uRrPi7Ok6wz09tE+nb/OAlRRgLoUOv/X
 MSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754561048; x=1755165848;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MH3TF5/YN4Hlu7k7zMMLjhGJygDR5pgvQMYQq30nvJI=;
 b=AP7zmGqTshp+1qyYRXGugqwD4ES8algwQui9nTIB8F4olqkRtZJ0Ot9LcElJnSI48g
 vz4c4zGGAFmwr/v+1SV9Yjeo6kF6XBoPNHk1IET4gdnkKnwKjPOnVidcax82mMvRa+/E
 PzvVk+AgA+dh+sxpt/WxNRubm4eD75ayKfoJ5qnbxV7Y2CuvJN6v0gxkEWqY+ExKuE4r
 9pm837iKKOgSicLCqo/qQHxDPWP5lYCfH8Ov1o4c9nJli6zOpZFfjrZOWdBWttX+gxvZ
 P3Z4OZXxCrFgK1CI0OsriwpIaQ0s4IvgYgAgzHO/UNFChKqKACdzVDELmNlYHxcfRhk6
 JbFg==
X-Gm-Message-State: AOJu0YwkW9+oNcTufAJiS3cvjGga70q972E6yaOnrXXsg2OCqBJbn5rg
 CUCGRkYdZn22f8Jt2kC9g7ANavihYdumjdQBrogaUYaJwUzjrKHLFxC3LqQXb33fwkIdF34mUBV
 c54Zi6xI=
X-Gm-Gg: ASbGncsrCtvecU8c9IrsT2NltGFLlY+f7NooDWWLVxIaV6W/fY7hAuybuaN+wq1hpnZ
 pKpcQM1L0Hb4o58Uz5Ix4zeEOv2Eqsi9MhCjdKuXuVMHFtMXI8GZcK60PP2pEY+HkW/79iwSo/s
 WDPm436Hay2Xr0BLN5E9lTrAimkcQa0SzInAmS2/NH7WP4ODFckSwLXc2jHF3Lu8nNrT2j2eeIT
 izMlqChJ5uRdDHW1bHAOxiDZyjkZaauUFNgW8mV9Xwoh8gP0u47W4A/gow1dwP3cYANKU3oZgO+
 LF14NwWBud1UOpQ/Wk5Ms1f4HY9hOVKwsvh0u/kpkiOH+In9p3Mk3yE3HQRSGzAhiiz37WZpbe9
 EaeDAx9LE8XNubFyz8kQc/fwxeUElfcLVYk1e5L0vR4bvRWO7FOik3SxLFdR+Nw==
X-Google-Smtp-Source: AGHT+IExm+su1cnyCFtPZpieI0b+diInV7z0DG6JrkXUwhKyIIwdmRm3Rbp5AzaM60RP8X4UGU5Owg==
X-Received: by 2002:a05:600c:1d25:b0:456:1904:27f3 with SMTP id
 5b1f17b1804b1-459ee85db8bmr22084485e9.18.1754561047925; 
 Thu, 07 Aug 2025 03:04:07 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:377e:cf4f:d0ff:80bf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458953eaeeesm358481575e9.25.2025.08.07.03.04.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 03:04:07 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Thu, 07 Aug 2025 11:04:03 +0100
Subject: [PATCH 2/4] pinctrl: stmfx: Remove duplicated code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250807-pinctrl_misc-v1-2-eeb564a1b032@linaro.org>
References: <20250807-pinctrl_misc-v1-0-eeb564a1b032@linaro.org>
In-Reply-To: <20250807-pinctrl_misc-v1-0-eeb564a1b032@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, uboot-stm32@st-md-mailman.stormreply.com, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
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

In stmfx_read_reg there is duplicated code to detect ret < 0 and return
ret if so. Remove one version of it.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/pinctrl/pinctrl-stmfx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-stmfx.c b/drivers/pinctrl/pinctrl-stmfx.c
index 61f335c4eb1..0d5778faef9 100644
--- a/drivers/pinctrl/pinctrl-stmfx.c
+++ b/drivers/pinctrl/pinctrl-stmfx.c
@@ -87,7 +87,7 @@ static int stmfx_read_reg(struct udevice *dev, u8 reg_base, uint offset)
 	if (ret < 0)
 		return ret;
 
-	return ret < 0 ? ret : !!(ret & mask);
+	return !!(ret & mask);
 }
 
 static int stmfx_write_reg(struct udevice *dev, u8 reg_base, uint offset,

-- 
2.39.5

