Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 252B2C982E1
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 18:03:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 041F3839D7;
	Fri, 16 Jan 2026 19:03:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="utWV/XqZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7811882BF2; Fri, 16 Jan 2026 19:03:15 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 291AE838A5
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 19:03:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b872cf905d3so387238666b.2
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 10:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768586590; x=1769191390; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HLxnQDiHilYF61QzHfpgvZlND7JjNfqQ2ky8Hi79nsk=;
 b=utWV/XqZFtUJcMOB1+YJg+Xxf1vsPDKJscbHV0GygCmGEDM39zLWQub9U8fj0q1Nta
 +xjVQcVbOvZK+2RjQLlGuUI9/bOJvIz54jXi77b6wWtevjwAqLf90U9SPkRN+/ToK51T
 yn98DruBh/VAhxZQoD/NbMX5Rg+Q2AL6+IL69GXhhQGe8xMdflQm/68cKIon0+dVgUO4
 AMJaDPWEfiZuFKTfj02wo4uHfv90Oqm9+lgMMjKKIDtmRLRMGsmXYBKzMz7Wkn5fDmBJ
 Oh3DK9pO0DqdTkg/vKAb6VCV0/2ufoWOs8tKqYo7io4IBnPeD20Bm69FybqaF+AN08ne
 op+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768586590; x=1769191390;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HLxnQDiHilYF61QzHfpgvZlND7JjNfqQ2ky8Hi79nsk=;
 b=CsFZabNzOuW/EYXVu9HLRxjNAa26NBUmadsulopWdtI1Bal9icJZ/yohGkB41S6eKH
 Y+V6i9pkZauRdkshjkhzD9Sj7li9IS8BuCGz+Po0LMYoLIdNTzpoy/CR/2MwlO58QldW
 D2XIKuKoGt2+c6D3Se3DEpMCVzgO08kVqPu2PDZvqsdbDkAdDtPCPshC+jBucZMTnAOB
 JwBv7HXSMfENKIUXDmxexWQPKxy3uKxtyOuAUk8IFfHBtHQEFAwqKt0s/s6JSBNvef2O
 luGVqR+lS2XHU5+3Kdoj6J+b2MzcJVQxRSkBrqjfXyxy84K/6tpnLuBgDylqaTUYD/0V
 lE4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsDsxSbYFQGlP/ZfDEAoB9fNB7XWuhutVJChQriAhO5GQXjkBv39/L2WUu+yhQcXyq3ZNy7ME=@lists.denx.de
X-Gm-Message-State: AOJu0Yy3S6QZc+5qxYGkZxag7UXx1NAPHrTHkOMK31RsTGmqgHMkvwJ6
 kcpwS2FRZfAQKj9dvkwRUfGqEEIfe350ctNHhGh2uwsajSGjs9DYL0NNvz6Vtn/XvF0=
X-Gm-Gg: AY/fxX51sL2VMHHg+OCWOLmZQmxYDXcLjipwFp0lsvq1N5ANxEZ1/I7K/+4sYUeL80e
 oRuqWWNtSztTcWVn40Fa6Dn7j4vjz02lhYtkCDKmH7U9czNqqFKdkuYps5kTUX/fxB3rZr7EifW
 xhNI0nCMsFoEbaOjDHXhpgGFGs/ls3YZHOOQwEDEhHDIMxnb0AUixkqihhMcqWHl5QbYMXhaa81
 Ud+u92RXoO0cuAQpUxLYl+Cm71uwtWPUHVhmA1sj7W3dGh0UPuXn2AJ5VCK+CRgiNzVYMFga154
 0lGD4zc33SUGM898hCQfH2bg7Y62YYWwMvz8SF1F7EIaMDDt1qfko7qD6sg5u+RJ5O2GjZXjYRr
 4UbuiqhSsXfCEVDP9xswzoC4dCM+1D4dFSpxyBkkUd/inl4pIytfGW1ex0baCxf8k27g3zaY7h7
 iEtSA4Bq4hhDNFnQcKIE5UuVAjgNMjI5YN9JInIgXB3ZSp8NVk925APQ==
X-Received: by 2002:a17:907:7288:b0:b87:794f:254f with SMTP id
 a640c23a62f3a-b8796aee903mr322512666b.33.1768586590333; 
 Fri, 16 Jan 2026 10:03:10 -0800 (PST)
Received: from lion.localdomain (p5b29e30b.dip0.t-ipconnect.de. [91.41.227.11])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-654533cc5e1sm2932712a12.19.2026.01.16.10.03.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 10:03:09 -0800 (PST)
From: Casey Connolly <casey.connolly@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexey Minnekhanov <alexeymin@minlexx.ru>
Cc: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de, ~postmarketos/upstreaming@lists.sr.ht
In-Reply-To: <20251107232935.283843-1-alexeymin@minlexx.ru>
References: <20251107232935.283843-1-alexeymin@minlexx.ru>
Subject: Re: [PATCH] mach-snapdragon: capsule_update: Fix eMMC detection
 for non-UFS devices
Message-Id: <176858658879.3399278.6661440468873387550.b4-ty@linaro.org>
Date: Fri, 16 Jan 2026 19:03:08 +0100
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


On Sat, 08 Nov 2025 02:29:35 +0300, Alexey Minnekhanov wrote:
> Currently (since 2026.01-rc) on all SDM630/660 based devices this is
> printed, after observing long boot delay (several seconds) before
> executing preboot commands:
> 
>  QCOM-FMP: Failed to find boot partition
> 
> find_target_partition() function incorrectly assumes that eMMC is always
> at number 0. In general you can't rely on device numbering to determine if
> particular block device is eMMC or SD-card, because it depends on how
> aliases are defined in device tree "chosen" node. Some SoCs have MMC
> numbers starting at 1, not 0; so mmc1 is eMMC, mmc2 is SD-card.
> 
> [...]

Applied, thanks!

[1/1] mach-snapdragon: capsule_update: Fix eMMC detection for non-UFS devices
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/bf4045ede829

Best regards,
-- 
// Casey (she/they)


