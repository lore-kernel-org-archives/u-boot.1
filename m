Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5046C982E4
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 18:04:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCA2983A79;
	Fri, 16 Jan 2026 19:03:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vQjEsCNY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A77E8397D; Fri, 16 Jan 2026 19:03:20 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FD6D839E2
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 19:03:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-64d1ef53cf3so3286470a12.0
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 10:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768586597; x=1769191397; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rvDEBAC9Ph+LuwmyH/4ogoteKVXq5mNhnK9I4LBFMq0=;
 b=vQjEsCNYNdxzmHTKKPVlRxPiDDSybOKp8FrZ681h05k30Bra/uxT2FYT9mvV64CG2V
 l5L2gKcmzwg/8oebrukqXiFgrIWGElyhM7jxeiVDLe2gVLrf6qNrCdhe38pWSA0hkw+I
 GnvtK/wJfNy7R7BVK4dOER62GI1+IsWXu08aporHUaXMX7WpHtJuDIUiAU82GKST6whu
 iTBK6OnVQ+Zq9nDH01fcj9TdTPhu6hiaWZPRWRmOTNbMK3wMV0VKaL221FvEZfBSWS29
 XKhcODdhwcmDNGwE4YjmfZ8TEpFA1mLx4AKPO3ySMtlsyuQZ5T40wMaVL7bIRxb0tglk
 eQEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768586597; x=1769191397;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rvDEBAC9Ph+LuwmyH/4ogoteKVXq5mNhnK9I4LBFMq0=;
 b=rx4A++Ra8uRnugCHHQF4VZ58bllj5D1kYI3Avp4TXEAwCD0b/h4vwC0PgVkI1PXk0Y
 zteIP7ppqX33uwrVHCJpKDMQz34/LgHtL/U7RIm3cJiWrEybU9S/+/z8IScJUabZJ8Ui
 G3+vtr7aO1f2cCA/gMnlRt9qk84+FBAc3bNiMt+bTQ6CRO17O4XaMd2NNjOtTEd7rmD4
 2ZBgHqi/4oxoUidzk/0voM6XY39ZzIsvNCCZbLaSAU/fykKU0Q4av+DLKtX+W1+NvRka
 d4iNQ4+UJTbKEBOGOw9G8zr2nEGpQm2UzzovIF9Et0+QwT7Cd/ovZxRJ2GPL0TZXHPP/
 VM+g==
X-Gm-Message-State: AOJu0YwdMUrkHGVa6lC9RW5MqrancrfzXzluoyjS3s31KzY/ftSTviZf
 f0HR0pNaI4wdd+iVbQzj4EZgxbi3A+Knl9f9sgU8ENhTYjWyNLUyMGNIpxgSh+CfseQ=
X-Gm-Gg: AY/fxX6TyElLR+zMd8lLx/9stPNpnoI4G6ypSFe1xZmETdf/IYTlS2M1gu0q6SWbgsX
 jlqiRfVQpARIH1ee/AWamgFJg0hTlFB86mLuMN1RBjWP3Xyrz/J2CrhEfsEBfmZPAGs3+xYPWaI
 3ecVs2y9ZrdL8YWv4479y8GeFDEx57tGOXPE38EjGKfWclcOgyHh/HMagkfKQ7tyiO+55MH9cx/
 Xqt4zrUJJvyLFTYR91UBsy09uklygSqOXWYJwxu9ePG3uBOZSH/8e39TEuWCAZY/NCIhCTXdovh
 aywQMewAjnwE5G+uNizyuIj5lymQ27YQBAP0U9FIfe9xSaCW7H1lAfzcG2vmPWn6MKOfQ33v/Me
 5P6cd2Lim4bAw4pctk1y0RufppUEuz1h7c8V8+msECKn0j9bDo8UkMPAiDzJ+/gk4Pa92uYd+v2
 /xgUpr0DL49lArKsJesKR2eSrVrViRSs9HPc2eExOSCuIC4aNLRocOIpioata+eHUO
X-Received: by 2002:a05:6402:278d:b0:64d:c54a:334e with SMTP id
 4fb4d7f45d1cf-65452ccace0mr2774279a12.29.1768586597523; 
 Fri, 16 Jan 2026 10:03:17 -0800 (PST)
Received: from lion.localdomain (p5b29e30b.dip0.t-ipconnect.de. [91.41.227.11])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-654533cc5e1sm2932712a12.19.2026.01.16.10.03.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 10:03:16 -0800 (PST)
From: Casey Connolly <casey.connolly@linaro.org>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
In-Reply-To: <20251119145523.843230-1-trini@konsulko.com>
References: <20251119145523.843230-1-trini@konsulko.com>
Subject: Re: [PATCH] dragonboard820c: Stop disabling device tree relocation
Message-Id: <176858659585.3399278.14778241299501533532.b4-ty@linaro.org>
Date: Fri, 16 Jan 2026 19:03:15 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773
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


On Wed, 19 Nov 2025 08:55:23 -0600, Tom Rini wrote:
> Remove setting of fdt_high to ~0, which disables device tree relocation,
> from the default environment. Doing so prevents U-Boot from correcting
> problems such as having an unaligned device tree and leads to various
> failure modes in the OS.
> 
> 

Applied, thanks!

[1/1] dragonboard820c: Stop disabling device tree relocation
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/57a5305948f3

Best regards,
-- 
// Casey (she/they)


