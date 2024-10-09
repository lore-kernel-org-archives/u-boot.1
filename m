Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F017CED635
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 09:15:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0076989191;
	Wed,  9 Oct 2024 11:15:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="B71N2axp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2697E8916A; Wed,  9 Oct 2024 11:15:26 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37BCC8916C
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 11:15:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-37cdac05af9so6066512f8f.0
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 02:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728465324; x=1729070124; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eDwNUDP4H+tYsTjvteRwPnLJvmXBQqk9NeBIefz3auQ=;
 b=B71N2axpSYrADVBB0aIi557mPp1mEOhZ23bsrtLMEdiTvLHzsjSitV/g5gcxJwvzB5
 ir82cpKUJqCuHpEk/SjhvzBbAUhTq8woKLUFPHPnF/Vu27McRMvtdL8G8HwX3RAf5CQ/
 X1a2o08+MKrlyU1AqoPqZHvjRQSHLxwic+FHBTYDELQMsUbzTuOV4sivcjWVj4fanPZ2
 WAIHn3c9Rmu+VYlGDHI8oTFBjep1Hw32xyMtFaoOaW6x9WlEoIz39FjnLvWjFc1mUr41
 uPtub92obCj1AZ3bPQRAKi1IE1vVMrTPwmCowLO+FjqujjLX2D7r+zz39zUJEmN43rUr
 AZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728465324; x=1729070124;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eDwNUDP4H+tYsTjvteRwPnLJvmXBQqk9NeBIefz3auQ=;
 b=dnTtdQUbE+wiWqif1jzARfSa2W780qboBED3bqBu3sdyni8hIaYcGdgDumCNQ5dIZt
 NSNAefg4A2fJeeMKXxxsedeflvEjMcvPmR5hibk5+3eZzRMxejJO3MzaXyNH8vdGKMpJ
 yVjvH204B4ccskEDrYRcd8oKSkklv34QZDn+nT3i1+1qYwhT2C4NM3ym6gZ+6G4vj8lm
 sk6yMGTzeWPX9j0NRMx1w3H5zrBocyO+Q/HbKWDgtBdwR4e2u2TNgCy1qn96Y8tU/CGA
 uqEqz59nB1gOJBvj2nAY2ZX+UkPrhU1jJpWVfYKKx+nHu0AwwyM4HxKMCvi8D1uY2hAF
 /Ttw==
X-Forwarded-Encrypted: i=1;
 AJvYcCULA4ESGn/fAT332Axr3XIHLKtOConZoRrfnRl4zR+hwPEwDb4z4sulVK+dxr0Mr97R8c5BpC8=@lists.denx.de
X-Gm-Message-State: AOJu0YyRh1IIh/U21CU0gHG1SVpROokFBfUrFZgPXek8dd4YtMcdsTE6
 /j6oYD2MNAqFhXpnYvUyP1JtEpqtusiGPnyD9mFcTeThLlpSVg8h7FltL2e5Iic=
X-Google-Smtp-Source: AGHT+IHgItw8ojQNW3ruLMKSzWiZREHmW+1sMJlnqWGZcEEA29GJ8gv5u9yDl7G4Xg+BPe9bylAJ1w==
X-Received: by 2002:adf:f850:0:b0:37c:c51b:8d9c with SMTP id
 ffacd0b85a97d-37d3aae2866mr1459753f8f.38.1728465323570; 
 Wed, 09 Oct 2024 02:15:23 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d1690f270sm9865471f8f.21.2024.10.09.02.15.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 02:15:22 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/2] ARM: mach-meson: fix HDMI since DT update to v6.11
Date: Wed, 09 Oct 2024 11:15:19 +0200
Message-Id: <20241009-u-boot-topic-fix-hdmi-v1-0-2479cd90c4ea@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKdJBmcC/x2MywqAIBAAfyX23IKV2ONXokPqlnsoQy2C6N+Tj
 sMw80CkwBRhKB4IdHFkv2eoygKMm/eVkG1mqEUtKyF6PFF7nzD5gw0ufKOzG6PWTW9s1yopFeT
 2CJTd/x2n9/0AAjvBE2cAAAA=
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=757;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=l8XmijvTwm7w6IFh5f/hbeLXZrLruekZ0b7APjEkvUg=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnBkmpxUSEdZRLhfrlK5id0Wc/9lEeuVe/qDpfHzV9
 t2sd2/6JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZwZJqQAKCRB33NvayMhJ0aRHD/
 9ipDxV9NvPhyRjezNZejvaKQgqEyEZkIJB31pCb8rcB3RX6Kv+9gydMrnCSJesauzizUn1roGQXdy5
 6FycVlQ5NCe2NWO6SCyhSmLiR0dGwl4M5+YXdNKU6xDpw9QSeJoDoiD+nlHdzomGePGkoMkJJKV+UE
 9PRYQLjAETycrDy/nUJa7PEWAE+JsCL+XSspZ0hrkxOgSe3LuorNRglZpVKFtSTRDhlBObYuP6qpTv
 QXb3hoOG99o1tuIfvKE6vIq92Y0oC07n+kGNs72kcA3cBhvOrWC6ldENVGRFn3yn5piUmVu30glrrc
 VFoR6fqKudeoFeI5onY9fY5aILXZTauIo2Dvz+Vq6rkaMl7IrFLoDRuvUMKAXntxV0rickbdlAC9sJ
 evz8sKxDZbzd6AiEPfSOyYUemDb3u0b9phfBAAy8TG6MyByY+y79JWwlukTCOO4b5Ltx9xOObaeGhp
 dJ4QFGHxDpoaZ3F28L1k6BZ2UwObb2/NrOdNS0DYwnze5MGZ3Kn8l4NG/h1bTJbbaTONTYQrT/+vYx
 AFNJac80Xw90nMLg4Mwz54DhyzpvBBSUaWaWXW4dN2KUMdHDsledjIDrhDxpdFUZ2vt7ddL5OcbuJc
 hJNbdJV7CLq32/lvn2/SsHvI+hWC8yLN3lsejQ3GmKfQJEiy+STDGBI+bQIQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

The DT was updated with unhandled clocks and a shared
power domain, causing a probe failure and a green output.

Add the missing clocks and avoid enabling a power domain twice.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (2):
      clk: meson: gxbb: add HDMI clocks
      power/domain: meson-ee-pwrc: make sure to not enable a domain twice

 drivers/clk/meson/gxbb.c             | 50 +++++++++++++++++++++++++++++++++++-
 drivers/power/domain/meson-ee-pwrc.c | 15 +++++++++--
 2 files changed, 62 insertions(+), 3 deletions(-)
---
base-commit: 28dc47038edc4e93f32d75a357131bcf01a18d85
change-id: 20241009-u-boot-topic-fix-hdmi-bb39cd876446

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

