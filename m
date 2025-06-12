Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB9E7C71136
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 00:29:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E689B828A2;
	Thu, 12 Jun 2025 02:29:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AXbtyCZ6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D09182977; Thu, 12 Jun 2025 02:29:37 +0200 (CEST)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 777B581FEE
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 02:29:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-6065251725bso290586eaf.1
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 17:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749688174; x=1750292974; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DFcHXI7ec04ZS3RjrkaORI3RAL6bvnuVGyfhDHX6ZKA=;
 b=AXbtyCZ6N4EPPP+neYU++/KgII9aUVP3x45DCGPkhRvZ0JPIXeUHhxLq0g6AFZ6e38
 jnJSuSF/ambAJwQrWt1e58DmQc3MsTdVAS4S08RtH3WPReH7KEITgt8fM2WhHwcTQQs6
 L7KkJHt+6wHWJHC/tYWmuPmd7mKCc/z3+y2r4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749688174; x=1750292974;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DFcHXI7ec04ZS3RjrkaORI3RAL6bvnuVGyfhDHX6ZKA=;
 b=VU04NWRdPi8S5BkWCWZYO0UOHfgPNA8sJv/Uwv8/vYh1iYxHhz/Kw9X/M9rkBd8VPJ
 jZRroX0eNN8wxPvVR6RefO2Edf0TZt1CtQ606AgeFNjM3ghZijJCbgGkj8ieyrjoSloR
 CfcSOgpOpp5M9d76SEU409X0uglo8vWdj4eTiSI5rYCyndUXkhdjF803+CO4zy5vrEoG
 cYXtuC/hTdZc7WSKdIC+VSufvPro+xqYhLs/9NJe68hgZpVt6h7PkhCa3FziHaHtuQo5
 od2xYl9WpJa1heep/Vz7cb8CA2ORDEAVVJcO5TDLEaB3Qpva/KPO3L01ZM4WzGd7ztsb
 Mo+g==
X-Gm-Message-State: AOJu0YysPb8EU/RRC7nJ01m0O5cc2ZtFYbreLXhpk24WoRmThrJwCYjy
 8wsaaZRDCMbJeEW+aYFxRq9yhVsqTPFQv2R/3lsJj3m6mhpAUhkTLdZh8EnMnTEzp08=
X-Gm-Gg: ASbGnctKwNjqLSOOaRFYzIM3qD/uo5xG/W+PmdvmQABeNq5567kxpPOPbf/PcongMJ4
 1OuVceGJHRqx4gX/vPBXgEmGyrKTOz+67kYxmfJymdApqkSlRPkgcvhmK0A5sZwZRygypVvJxO1
 7ZoLNOEi2k+bZW4HDQVqN6iLRVj9dAvNWJEDoI4bo1qN7wNkt0EsGAR0Cm3MXzfEZGk144VCkUE
 97ht67Rwj6hOmiQ3PARC5RQwknciC8HE5dMdGJaWq164l1DCoUHOIUenK9q7J8yRNKIoG+SFvui
 2QnfC0KVXWfWdicInXlCmCsXo7u/ME5YoHHg5KZvHiz4VHuCLOiOagh9ZvPbj7n0Nbzlm8F23pd
 KuZEEDchaQUUOPvmbLyMWrQ==
X-Google-Smtp-Source: AGHT+IFhHKK3+wY0yY/T/CfiudlU0yEr4lD+GEqKxlOEO1lw61E1dvIk4vnU0NRm6yUEIyR30Y8M1g==
X-Received: by 2002:a05:6820:1347:b0:60b:d676:b666 with SMTP id
 006d021491bc7-610fd4b8932mr480550eaf.5.1749688174279; 
 Wed, 11 Jun 2025 17:29:34 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-610fd523fe9sm66629eaf.40.2025.06.11.17.29.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Jun 2025 17:29:33 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Heiko Thiery <heiko.thiery@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>
In-Reply-To: <20250611142352.3990076-1-trini@konsulko.com>
References: <20250611142352.3990076-1-trini@konsulko.com>
Subject: Re: [PATCH] mmc: Kconfig: Really correct dependencies SDHCI ADMA
 options
Message-Id: <174968817336.20873.2253388108943248289.b4-ty@konsulko.com>
Date: Wed, 11 Jun 2025 18:29:33 -0600
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

On Wed, 11 Jun 2025 08:23:52 -0600, Tom Rini wrote:

> When doing the investigation for commit 53bb8fdea12a ("mmc: Kconfig:
> Correct dependencies SDHCI ADMA options") I missed the implications of
> MMC_SDHCI_ADMA_HELPERS. The problem is that FSL_ESDHC via the
> FSL_ESDHC_SUPPORT_ADMA2 option will also enable these helper functions.
> This in turn means the correct dependency here is
> MMC_SDHCI_ADMA_HELPERS and not *MMC_SDHCI_ADMA.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] mmc: Kconfig: Really correct dependencies SDHCI ADMA options
      commit: b62e422d6e6878e9bca1d20fe372ffdd7db294fa
-- 
Tom


