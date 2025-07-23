Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D422BC83F17
	for <u-boot@archiver.kernel.org>; Wed, 23 Jul 2025 23:09:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A1BD835AA;
	Thu, 24 Jul 2025 01:09:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="V94gGweS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2141835B0; Thu, 24 Jul 2025 01:09:26 +0200 (CEST)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE3D58353A
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 01:09:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-60bd30dd387so260234eaf.3
 for <u-boot@lists.denx.de>; Wed, 23 Jul 2025 16:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753312163; x=1753916963; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0glqTxZyRuxX0xWlud71DQkPcTTz8WCjOQ0mK9GTt4Y=;
 b=V94gGweSdl8ft8d5ARhrOZZedUulvCU1XMcus8R9gJyPG1MWaTfKAXg0KfxMEISoAw
 rstAo7PhuUKO7qqZrIGI3KO/3BIhJ8pyY+stQSTzDbMgmSg52MJg2kEVNJfX9Oxg0guG
 VIeRCX9rJEtgPWYh3qatJ9fag5I61qzB3131s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753312163; x=1753916963;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0glqTxZyRuxX0xWlud71DQkPcTTz8WCjOQ0mK9GTt4Y=;
 b=M3lHtblU+UDKDc1RWGaLFZsnxBdOqBSoC3UtYBMDnjWHAFF5o3I+8CnDbzUzMTQEJS
 Q4+LhgWZoT+XE3erCjrr7WGzDwNuc9Gk5VQQIlkdvKgQttsAR3ZP96iACiwc16LCokCx
 c3bbgenpCLIPMHjdcruWJYbYHnT8sSjP7JSPgOY4tsc04KGtMKJfpNW99c12IlQnWE/6
 J0QOo27Y7YH2cGeb+gjVaheDXwBgJ9mRYdcYIlkNMus+JLutKxNSslY5eb1co2sqA+9a
 5avg1s1gdpwurzwIt5/x+4d1ZYLc0TqM10+SexQJaQR1zoxhwMjM/bwvxCGlY8xMnuAM
 bJOg==
X-Gm-Message-State: AOJu0YxKpAczyn6lfPKLG9WhyyFrVFQ6E/1P61SMbomVkicb3Ga9ivJS
 5PLG0/MMpcN5FiWaoDw45EYNsmBKfRCN4h7ewwWbpFROfv8VBYrRM5ZBWP0Gk3SmdZU=
X-Gm-Gg: ASbGnctjMHlCD4VgKM4IaUCnbQjQ10YiuVxvKtoyJ/UbzLyeZTXAmWCcJUUBFDaZgYX
 o8ttH54YgK5ptHB76CJs/OuDWE+NVjy0Kzavi1P6+0sZWKomRFqpBNOH1/eG/sUUBEVZVAzuYkb
 eURxhY0i5gwYhA62N79CF5HCYsDBCbdyTp58+1Vlliah1zgI8zb+9sDSGKUS4j8T/QywpSzOyUN
 HktvN/Wp64IPrFvTuFetHltcNL0FvK7N5iqoT6wjDi9oJbNDAY22plNqxNyzpQWfHvhrOFPXgGJ
 tHt77eq1gymw1RnT5I3k1re5K0RmOYFcFKxvqHmDIkevibjS2eU2/5d4M0vo9UuaT2hRM87Espa
 lt84iQcVkYb4yin1k6du/lKaQKi8sEot83v5qZfT34wVNu8l/EEJp0vg=
X-Google-Smtp-Source: AGHT+IHxZk3OvXXSA+WhfvubKNWvkEJz1eX/fopz53ILtpxicEjQKvO9aH6fSlg9I20MGWg3D2xSyw==
X-Received: by 2002:a05:6871:e003:b0:2d6:2a40:fb9d with SMTP id
 586e51a60fabf-306c72f6a87mr3738272fac.28.1753312163432; 
 Wed, 23 Jul 2025 16:09:23 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7412d0fa63csm52693a34.10.2025.07.23.16.09.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 16:09:22 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Aristo Chen <jj251510319013@gmail.com>
Cc: jan.kiszka@siemens.com, baocheng.su@siemens.com, sjg@chromium.org, 
 ravi@prevas.dk, quentin.schulz@cherry.de, 
 Aristo Chen <aristo.chen@canonical.com>
In-Reply-To: <20250715130317.3886-1-aristo.chen@canonical.com>
References: <20250715130317.3886-1-aristo.chen@canonical.com>
Subject: Re: [PATCH v2 0/3] mkimage: validate default configuration reference
Message-Id: <175331216223.248145.17380522700660175789.b4-ty@konsulko.com>
Date: Wed, 23 Jul 2025 17:09:22 -0600
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

On Tue, 15 Jul 2025 13:03:04 +0000, Aristo Chen wrote:

> This patch series introduces a validation step in `mkimage` to ensure that
> the `default` property under the `/configurations` node in a FIT image
> references a valid subnode. If the referenced node does not exist, mkimage
> now prints an error and fails early. This helps prevent runtime failures
> when U-Boot attempts to boot using an undefined configuration.
> 
> The first patch implements the validation logic in `fit_image.c`. The second
> patch fixes an invalid default configuration reference exposed by this new
> check in the `k3-am65-iot2050-boot-image.dtsi`. The final patch adds a test
> case to verify that mkimage correctly fails when an invalid default
> configuration is present in the ITS file.
> 
> [...]

Applied to u-boot/master, thanks!

[1/3] arm: k3-am65-iot2050: Fix invalid default configuration reference
      commit: f7b03695d46d7301fe78eed0fe8f8df9c08c33a4
[2/3] tools: fit_image: validate existence of default configuration node
      commit: edb4bf38688bb232ba0739585693aa94be5246f5
[3/3] test: fit: add test case for invalid default configuration reference
      commit: 93d09d3bd8ea941eff860443db2d8628cdbfe7e8
-- 
Tom


