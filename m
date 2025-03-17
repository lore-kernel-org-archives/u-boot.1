Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79CD3C28B30
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 13:49:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB91B81C64;
	Mon, 17 Mar 2025 14:48:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FaytA263";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BB7A8081A; Mon, 17 Mar 2025 14:48:30 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0006A8168B
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 14:48:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43cf034d4abso23980615e9.3
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 06:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742219307; x=1742824107; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Oz1Y6X8JE5RfaKFMHgZ0FsTl0LqiXIGYVeXrZQwMgs=;
 b=FaytA263h8W5dWAh+Y9TJBMPyQWXVlc7ioIoRM+IiqqJjGWAfKaZ1p7CA7wEW9hVoS
 JPAwf4K1tBtfNG25tzgAVINCE/LHwkvuRMNB2lvzwWsog4DNwUhe6vD0va2gH8+IQHXK
 zIFpGpG9Kd5c5Ez4hmHX1ZVfAgEWy9Ozj+vd9Gie6gWrhYZVpqNN/TvCyCNVA/0+IwhO
 HiTo6jAFojC015rLxIJGx9LCIU87yNFuuZdLs4xuIs+aYT4WH7HHBbaqByS5p/TDexoL
 laUczb+OLCpu3B4XBOkeJr2pnVPGUADQcdom5O8r/AkbbKuthWgXQ0HCEi/NhD2+JrpO
 wjdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742219307; x=1742824107;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6Oz1Y6X8JE5RfaKFMHgZ0FsTl0LqiXIGYVeXrZQwMgs=;
 b=FV1mEwnwDOUFictnjssEoI2pUCKL7oydaYimePqeCWsvz03Fu19pGKcZGW64ufQEew
 roOrdJCiRgVME4q/S4ToWvYVNLwHQAv+OWdzDBqGhjhTcshq2GGT10SJ+9EmDHjwae7a
 Mck0JXBqX0YfSwNIdlEUp4PYV61seaRm2dCGVwaJW/LPLC4s8MOFH+j1YIMZoUgo1Xu/
 DTOvlbcQH3ppn2+05aqEplIITEMZqmF9FQd3D8+pbOs8rEo+fxsQu7iUihlsL68zNt6Y
 dznJW8JwLXBzn4DMxrmuf3+/+h7XaNG2+9FA49/1EcGusZmNIeBGmEPmVAxp0CL0tL+P
 sdew==
X-Forwarded-Encrypted: i=1;
 AJvYcCXG5+wTg2jY8Roy46t5CKoSKxfox/rHyoQ3gQ3rmX8bTcrNlBhTB0TUPdipia7fjrdIACSSkus=@lists.denx.de
X-Gm-Message-State: AOJu0YxksMhftSeHQDtXagfmTIx6Ovj4HfEeIinSZFjiauKsPX8GlMgM
 dgUzlJDwFEPJfNDtTCeVdDitSkOv4seJVddBON8OJnSYJywpJkk/ACdwuSCKmhehsg9aW02LYIw
 AsgI=
X-Gm-Gg: ASbGncuCYpypP/RzHwBqcSEWXFSvXdEz6ZcyPL4c+V8mkc6SNCoXSYQ6kczBOREldWP
 B5nU8eA+p9KXgxYkLCzwre2QbpSASlOZzxdKPGeszNlrhFOdnhDJ9G4sPpojM69w8RGp1nZ1b+H
 Oh7Q+Q+jBS9MtwLTUiJWsF+6mmvLicwklqMBrtk9PWkkWZrjyBdjzGoFkaftDfTRZWWogIYi6Qn
 FiXB91R26VyQMRQ2V38C0UwwZf28wEobGLjT3nbb0npBP5jR+wudjr0dBioXqkvycZn2j6+bP6a
 Lz0jTCZMYNKL2ttJsOoovxnBqXIROj9zIfhypxuaRdwLTiLG6WFY/TEP+ZPI0+sJEkXU/Bg=
X-Google-Smtp-Source: AGHT+IET7beWW++GbuglnCtTDYPHPsfOrwiVTDySLMlRU8Wv1sjfaaUTnHK+bYFObl5jUPQ6bq1ksw==
X-Received: by 2002:a05:600c:4f41:b0:43c:e7a7:aea0 with SMTP id
 5b1f17b1804b1-43d1ecd94b6mr118001595e9.26.1742219307463; 
 Mon, 17 Mar 2025 06:48:27 -0700 (PDT)
Received: from [192.168.1.116] ([2a0a:ef40:1d11:ab01:670b:cd84:4753:5ae9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d200fae4asm105655945e9.27.2025.03.17.06.48.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 06:48:26 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Sam Day <me@samcday.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
In-Reply-To: <20250127-qcom-handle-absent-psci-v1-1-e762f2db938c@samcday.com>
References: <20250127-qcom-handle-absent-psci-v1-1-e762f2db938c@samcday.com>
Subject: Re: [PATCH] mach-snapdragon: handle platforms without PSCI support
Message-Id: <174221930616.73541.3304986118588546443.b4-ty@linaro.org>
Date: Mon, 17 Mar 2025 13:48:26 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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


On Mon, 27 Jan 2025 14:48:55 +0000, Sam Day wrote:
> Most MSM8916 devices shipped without PSCI support. The history is quite
> nuanced (a good overview can be found in [1]), but the end result is
> that the upstream DTs for this SoC pretend that PSCI exists, and it's
> expected that the bootloader handles the case where it doesn't. This is
> codified by the de-facto bootloader for MSM8916 devices, lk2nd [2].
> 
> So we handle it here by deleting the /psci node if we detect the absence
> of PSCI. We need to do this early to ensure sysreset works correctly,
> since the PSCI firmware driver is PRE_RELOC and binds the PSCI sysreset
> driver.
> 
> [...]

Applied, thanks!

[1/1] mach-snapdragon: handle platforms without PSCI support
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/773a46b18b09

Best regards,
-- 
Caleb Connolly <caleb.connolly@linaro.org>

