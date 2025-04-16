Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD41C369C2
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 14:12:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 926CF81E18;
	Wed, 16 Apr 2025 16:11:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="G7ZBfV6j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA6CD82F54; Wed, 16 Apr 2025 16:11:08 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1B4B81E18
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 16:11:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-2d4e91512b4so26079fac.1
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 07:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744812660; x=1745417460; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pKXtw8cQ7Rcn0GgNIl/IbB0Vrl9BGiOjlTDEuzjpRkg=;
 b=G7ZBfV6jAvLuPmtviOVVx9V0P11bo3jFrwW1hAficiKPYtsf1XXCV6WNHiXyIRVwtD
 +72Ww3Pl6CLspDhiNfbbB0bPxXb0KaJWljIsIpxi29uPO75QKtRU6vKo/I73bp3EgRZ9
 LLxMK+cdogX8SUaGv8OSTTXza34DwN1PERrrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744812660; x=1745417460;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pKXtw8cQ7Rcn0GgNIl/IbB0Vrl9BGiOjlTDEuzjpRkg=;
 b=BazCImsvqUf19DxYBkKx2B9ftIJB13IQjgOnZfGonbOzNBe1vphqpapoSo1NwLtsAG
 HAY/Hx238qa8qMnq89UapPQy++I0PyzaYnSVjnojFEdTculRn/dAetGX/NlnRPOMTE8y
 fnOnEbQZIZYNO6Bn9Ndhjmx/m7iP5ZSjjBjUMze26YvK/sVX3wthzo2Zb+Iti4j5CcB/
 ptml56tnCH+o46PKnhVNB75jRp7fQbeizqT+wuhxrNrOHAkX2+72/fxae6f9nw6lHDbd
 0Qo6WyXzu1MSu5MqRWI/Ecrk8CUntrzOdXlwmN9fN14bmQqcOu6FOElz71cxFTuhqVTx
 g5QQ==
X-Gm-Message-State: AOJu0YwcVX4THcE05jtmAgLGi6+/+QDc7aIZUesZQ1J4mloq+J2wOthW
 hfEPunljaDjTfHndCNqLia+cICVpnMH8NSxFe490QhTHPcl2TA1kTPPrqYXCLz4UOo5qgf00PBp
 f
X-Gm-Gg: ASbGncsEqcCRQqPpnp4WWowHW6axZIk1r4KOVBqvb+759mOO7lduKAA7Sm4uREBBDFJ
 r8mDMYWc7JCK+zxluU2jrGjxTCVlN26i2Kv2Vk9nhd3aJ+akJSniN1/2++DWDl05adp0gCYV0+E
 itOSpv7ND/nQQ5jfjNTPGTWxvn+pHV9MsKaqQsLO/r+6mMBOnOqC9x+gsn0Gyn6Agry48RCYYSZ
 R1u6UrojHi0fBdfnu4lvwCGxTFN2RCyb4BO9BrTEVc63qGPR06lrdIc5PAD9HO7zycyhd/HyQCT
 9bJJp3tRN+gkwv5Y0V97cNnFrudVrw/fMo35VAejRNTRdFSkc//4XeOkMNJDOM58e43y9YMO0F9
 O
X-Google-Smtp-Source: AGHT+IEXNHIZ4dnMIYVCB8DcUGYJEx4s9alz5VMsZs+C9UU9S/8s12TsZ+vMxHQZtj7NT+YSoaxQWg==
X-Received: by 2002:a05:6871:d80a:b0:2c2:5f8c:4630 with SMTP id
 586e51a60fabf-2d4d242fbb9mr1174142fac.0.1744812660276; 
 Wed, 16 Apr 2025 07:11:00 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2d09695a14csm3314722fac.15.2025.04.16.07.10.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Apr 2025 07:10:59 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Udit Kumar <u-kumar1@ti.com>
Cc: nm@ti.com, d-gole@ti.com, n-francis@ti.com, vigneshr@ti.com, 
 m-chawdhry@ti.com, mwalle@kernel.org, kamlesh@ti.com, j-choudhary@ti.com
In-Reply-To: <20250410132746.8168-1-u-kumar1@ti.com>
References: <20250410132746.8168-1-u-kumar1@ti.com>
Subject: Re: [PATCH] doc: board: ti: Add optee rng support
Message-Id: <174481265924.2150978.3856707242022245644.b4-ty@konsulko.com>
Date: Wed, 16 Apr 2025 08:10:59 -0600
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

On Thu, 10 Apr 2025 18:57:46 +0530, Udit Kumar wrote:

> J722S has hw rng, which can be used by OPTEE.
> So remove option to use SW TRNG by OPTEE.
> 
> 

Applied to u-boot/master, thanks!

[1/1] doc: board: ti: Add optee rng support
      commit: a8baac546fd9bfbf3f36af3d35b5a284a9664f4c
-- 
Tom


