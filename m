Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 401E0C3DA7E
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 13:42:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB1048874C;
	Thu, 18 Jul 2024 15:41:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KV1g0gLQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF23788A7F; Thu, 18 Jul 2024 15:41:39 +0200 (CEST)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C605C88709
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 15:41:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-5ca9835db95so401642eaf.3
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 06:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721310096; x=1721914896; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RTIliegtaH8b61qNDCktrGfpNtvKcC7soqAvxBKo/f0=;
 b=KV1g0gLQKbjfvSOR7H3YtNnFubnjGtSAhLiVp4Als1qNLc7L4F4wBou4A9S5CKlWjY
 WJriZh91QGHtIoxwodiQuZZIqAmfREuIfr2NMYlfFXzsw8U/m5/TXoLoNhzjPMA6WsMG
 qsfqphNj6GGb6N6XZAjZImiz7KsuJ6AEBMor8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721310096; x=1721914896;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RTIliegtaH8b61qNDCktrGfpNtvKcC7soqAvxBKo/f0=;
 b=WhSAiNl0aK4Fjn/hIMM5PCXn87Z2r3YdoE8dGuZ7i87Klob0t0JhzanhWdwPMPaGlw
 nH2FSETAqOCGqrsfP/nOZ1RTnTls9VF/V72gVV9LxyKUvLDTCQM4Y+HX8tLjz/jlaipr
 /kdHLluPrctrfoNLI4hrMy27UFAst/njWghaBEnC2qeVn4INELX6haZ6TdJSRBx58Rbr
 lK514RkVoIN+8xf2tstIXOSGT+kWhq+f/C21K1eSsGVSZEThhR7NqyUaBM25W06hirjb
 8+QvnlqgLXS7EW0Ice+ZhuY0Vog2V1f0Whj/pmMeIGw+YPZ0U8/JZKnEr16fYPBjYJUU
 IKyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWVK3leJu7JGgvi19NfDg5hBOEWhP1aszQEIyu8eujBcOAHSWnoH5yAthdsT3uY+GAAZshYWSM7bPgB33UMzA+rQuznw==
X-Gm-Message-State: AOJu0YzOP4Y8yhEeJhe8TUdP/efhSa5NihEUeMl06CR4RenKv1d5MHKl
 HPRa2uj8TluiYKasAOOde/FsGnif6+cXYz3+M2XhQXZTEPOojaxMVcyIgO6C6dU=
X-Google-Smtp-Source: AGHT+IH9rZuOajHSX/Z6w5pdc/4vAOVaXCh1hyShnx8yYaefb7L3NqPX80FNUxjXShr2qFfMCNHvpA==
X-Received: by 2002:a05:6871:89e:b0:260:eb3a:1b2 with SMTP id
 586e51a60fabf-260eb3a278cmr2719290fac.7.1721310096596; 
 Thu, 18 Jul 2024 06:41:36 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-260ee947f82sm355303fac.50.2024.07.18.06.41.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 06:41:36 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Etienne Carriere <etienne.carriere@linaro.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Weizhao Ouyang <o451686892@gmail.com>, u-boot@lists.denx.de, 
 Leo Yan <leo.yan@arm.com>
In-Reply-To: <20240709162309.1531981-1-leo.yan@arm.com>
References: <20240709162309.1531981-1-leo.yan@arm.com>
Subject: Re: [PATCH] driver: rng: Do not check ARM_SMCCC_TRNG_VERSION
Message-Id: <172131009566.1834634.11880136553369334629.b4-ty@konsulko.com>
Date: Thu, 18 Jul 2024 07:41:35 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Tue, 09 Jul 2024 17:23:09 +0100, Leo Yan wrote:

> As described in the document SMC Calling Convention (ARM DEN 0028 1.5 F),
> section 7 "Arm Architecture Calls", the SMC call SMCCC_ARCH_FEATURES is
> not expected to support the function ID ARM_SMCCC_TRNG_VERSION. Trusted
> Firmware-A follows up the specification in its implementation.
> 
> This commit removes the invocation to avoid the failure - which is a
> wrong calling in U-boot. The later code invokes ARM_SMCCC_TRNG_VERSION
> for retrieving the TRNG version, except it can read back the version
> number, it also can be used to detect whether the TRNG is supported or
> not.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


