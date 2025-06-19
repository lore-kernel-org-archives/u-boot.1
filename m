Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2478C7115B
	for <u-boot@archiver.kernel.org>; Thu, 19 Jun 2025 14:06:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7762882CBB;
	Thu, 19 Jun 2025 16:06:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gmMCh2ZL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F34C82CCE; Thu, 19 Jun 2025 16:06:05 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3471482CCE
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 16:06:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-606668f8d51so484892eaf.0
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 07:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750341962; x=1750946762; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=um4ZnGxczH3vkjmh6VDouSV6N331gJ++NxgGnWjexW8=;
 b=gmMCh2ZL9LOebghnxPEgsoRo8itlEw0pY+2ZnlKgz/+BIbImroUYhhLnM27qm3Qo1U
 3bRmvI0gSpxDvtkcp541mqkani/d19lDhRAYzvtyyjTrmFTjn61r5sGdcZd5AW3lDuBm
 0oqWPli2kchAzr2rSSG5ygStVlqdhWX5wZK1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750341962; x=1750946762;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=um4ZnGxczH3vkjmh6VDouSV6N331gJ++NxgGnWjexW8=;
 b=XoLuf2NOKF4vxRgme6I8tYpp5ut28UNmANHb4XNNIGo6tHDJpWHnrP8ZL0gytpLVDM
 YkUDFKYExU+1L2FF8GFAFaILYkWx02kI5ciS1vEHHOyg9MQBj+4qe05G9d6oZVsoLQcq
 GYLq0YN88JSuVA8SdkuAT308TYFQl7DAUWgYMhO4kzb6RRj28ic3mV2D4LfhydqxLcFe
 OiCezTtHb24k45GWTbfQtCGOgzI5B/qs8fJbMjUFLObVmHg4FQQ9g46Fan/thG1q4R+P
 w+kt3v5C83Mive2x103VW+WbZwE2MsVp04gSeyE1HlXbFP4Pcwd4jyXVbUQXnjuUUGnx
 KSXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDk2rtwWax6l7C4USp3OUT27WiAsejeivh7DhNuFpACk6d9F+ho2Cb+R7dQntYsMLlEv08jOM=@lists.denx.de
X-Gm-Message-State: AOJu0YzjYKNYj6KA1M6LwVy+JMYwJsSYf/lj+tb95Eqwx8xWEb/cWKK7
 ExNM5nDx4uRHmm2ArkOUEVT/HoFgTic6euePmHA6pzx6WmF3x/n5l0TZaI9elE4LL1M=
X-Gm-Gg: ASbGncvCRt8ZBIfxLZLtBBtDXhRE0JoMcV4NO+UVUKSxZFpauQ5C0KuhzcdzTPWCA3o
 roccYnQkJ+RhR7TI1Z5PgtfoHmeGgj1cu+xxsn/SKt4voIh3y3VyTb063uXiyxhiDFKq5FGaAM5
 veHGJUDj79H+aJ0OS4uybZ+w5cCsSQc6Ypf+wRT6BC+N/ova6q7aIi1kNg4Rsu36TqVwIDeOtk3
 sgLD236lFw9+XjUXGMy4K9b+myYJNpyi1LnbKPhGRMXdtbHOdJtj874jl2SXjeESKOCqcWd5Lze
 x9yQqr20KmLN8yxhFUWQLLGK5gZwqgv+0MBFz3x+WOdsgfnGXuV01sd4N8rvaS+zP9y2IveG2Hh
 YBFM6St7dKkK3jjS9oaXLy+Lh43n7Flj5
X-Google-Smtp-Source: AGHT+IHqy7DqTgJqSY4sX9Lwb1a4yO1vtyQ5kb4w2VUYMVkiMcigHXlN8eAwlKlbEVQ8tElaOhfyXw==
X-Received: by 2002:a05:6820:209:b0:610:f57c:64f9 with SMTP id
 006d021491bc7-6114e7ce59emr2528804eaf.0.1750341961795; 
 Thu, 19 Jun 2025 07:06:01 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61108d73d75sm1610633eaf.5.2025.06.19.07.06.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Jun 2025 07:06:01 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Beleswar Padhi <b-padhi@ti.com>
Cc: afd@ti.com, nm@ti.com, hnagalla@ti.com, n-francis@ti.com, jm@ti.com, 
 u-kumar1@ti.com, m-shah@ti.com, u-boot@lists.denx.de
In-Reply-To: <20250609081429.1724643-1-b-padhi@ti.com>
References: <20250609081429.1724643-1-b-padhi@ti.com>
Subject: Re: [PATCH v3 0/4] Add IPC support on MCU R5F cluster in Split
 Mode
Message-Id: <175034196023.205241.7017825926803664651.b4-ty@konsulko.com>
Date: Thu, 19 Jun 2025 08:06:00 -0600
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

On Mon, 09 Jun 2025 13:44:25 +0530, Beleswar Padhi wrote:

> This series adds remoteproc support on MCU R5F in Split mode.
> 
> During boot, ROM can bring up the boot R5F cores in either lockstep or
> split mode based on X509 certificate flags. If booted in lockstep mode,
> the MCU R5F cores will run first the R5 SPL, and then once A72 comes up,
> will run the Device Manager (DM) firmware. But if booted in split mode, core
> 0 will run DM firmware and second core sits in WFI. Shut it down so that
> other firmwares can later be loaded on them.
> 
> [...]

Applied to u-boot/next, thanks!

[1/4] arm: mach-k3: {am6/j7}*_hardware.h: Expose MCU R5 proc and device ids
      commit: 873e9dedd0ee5d732294b7923e06c58d0e84a6ed
[2/4] arch: mach-k3: common: Add support to shutdown MCU R5 Core 1
      commit: 87a9c1f5a05a2eff0f2146bf9199145a00049a0e
[3/4] remoteproc: k3-r5: Acquire processor control before reset ops
      commit: 92e77d3768ae968158a5b76e023b86cf6b7d72bd
[4/4] board: ti: j7*: Add firmware for MCU R5 core1
      commit: 574321414fa94f1f66e6ce34807a997ffb72ec55
-- 
Tom


