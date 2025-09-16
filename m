Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60471CAC598
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 22:07:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A18283323;
	Wed, 17 Sep 2025 00:06:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZzIAm1CZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E70C4832F0; Wed, 17 Sep 2025 00:06:42 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 609CA83323
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 00:06:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7459d088020so2833016a34.3
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 15:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758060399; x=1758665199; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LDNMI/fL6WhLdjKW7tsDlz/vot/T5xIMHPrCfp9ZUIc=;
 b=ZzIAm1CZ6rN7y/wAOaRNYsBX+UFRh+2+anmZkbjhEfU/TTkIhxcVocL5tP1Eb67uzI
 bB/5DXkKnvZkHgDrDb1YsOULK/kOP4XozDjZfPNxCeskf+jdnwA6+7fnywr9pV+K48jx
 DC7pOVBLWS21PIxMLtQx84oldAlOOyaB7k7JI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758060399; x=1758665199;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LDNMI/fL6WhLdjKW7tsDlz/vot/T5xIMHPrCfp9ZUIc=;
 b=DnFysFKzRu3Azk5Prb3cfM9w4hhNWZPo+7N/ydnK4KjnJ8a4f9VOhRlcGDPZLUI0X6
 VpmHDFfHx7zV2tCw8JtmNK2+s2eVnK5Y73JKndN2Hzq7ADt58i4Gk1eF2rGs9UkiQA31
 IwNLFwusTyE+IJutJUtabzYxmaDmg4biLWqcuH4YiHPuOnMo4wJxT1Uv0sZRf1uz1mEI
 x5isATz+YEmAC+EpXN/HHlaSRzbJHRsizVeiV62Tx9z7ikHJqWaWRJHWK8TdctDaIyHy
 RS5AoCMGCTNSdPJtHLkgb1aiRs8rBgSQIAcu5oEfTINx115hXPDG5U6jjW1SNNWa9jZU
 qvBw==
X-Gm-Message-State: AOJu0YztiyKouRoXDIDZbJtVmDZL8nAB7s1m8xzmmpaV72uaF/bpAWgT
 T8vqa+9yxtIAlqXo3Q4lyYSg6OygoR1STGdfXKIj5zQqn/zx3VMiUqKCKwXkOfVdCUlxjL+Njyk
 2ed6svCg=
X-Gm-Gg: ASbGncto07Rc6aLCvol9lSfUnE7Tca/3rvm4FJIe5rGS6+IIoePJbywVAV25560Gfao
 SzEdA8B485xE/ecxDwc4HkRp4uNUKXSvxpPEBhV8yo8Iu8fOFVl3ztdxuZmrBYlo4XMrwbPcJy3
 VgDUEqSmb068bjgsLA8+gD53Klyb01bHS37+cnMzROu7HQ+9LejQwugIbO8seg1kqLMvdvbHiPp
 La31F1og59ZG00y5fqRe/B8h6gh6DEdrjXyceo+TRrXC6FZGOLAoeuHMHPrZmwvpQG3GIQJ1yq/
 KjJ5wcD37kdgiTEkh81aGH0kPo97UHFyxGB7vyv+33DGEfOH5X2a6zYC135im0dvwWqdTiH945O
 PNMUETCWwE29k56s6BmoUD7myh793SJbo86EvYMuITMFGJlGqdS7A3vzQYF70QkIpBw==
X-Google-Smtp-Source: AGHT+IHhyShofmDfk9952PcMHju5dqaWEYmaZ8x0cacCtGNyipmvP7V5IsQ0tzcd6PYCobIvwRurGA==
X-Received: by 2002:a05:6808:2203:b0:439:ba45:96cd with SMTP id
 5614622812f47-43b8d9d6854mr8147253b6e.31.1758060398830; 
 Tue, 16 Sep 2025 15:06:38 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-43b82a72a48sm3500050b6e.20.2025.09.16.15.06.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 15:06:38 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Javier Tia <javier.tia@linaro.org>
In-Reply-To: <20250905205349.127333-1-javier.tia@linaro.org>
References: <20250905205349.127333-1-javier.tia@linaro.org>
Subject: Re: [PATCH v3 0/4] Modernize U-Boot code formatting with clang-format
Message-Id: <175806039811.649628.4300351470915606526.b4-ty@konsulko.com>
Date: Tue, 16 Sep 2025 16:06:38 -0600
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

On Fri, 05 Sep 2025 14:53:43 -0600, Javier Tia wrote:

> This patch series modernizes U-Boot's code formatting infrastructure by
> with current Linux kernel practices and providing a more robust and
> comprehensive formatting solution.
> 
> Changes in v3:
> 
> - Extend clang-format documentation with additional information. How to disable
>   formatting. Explain controversial aspects of introducing a new coding style.
>   Clarify the origin of the '.clang-format'. Add code formatting best
>   practices.
> 
> [...]

Applied to u-boot/next, thanks!

[1/4] clang-format: Add configuration file
      commit: 29f6db89add2a5484ac478ba93d4574bb65ee158
[2/4] tools: zynqmp_psu_init_minimize.sh: Switch to clang-format
      commit: aa711ac815618bdc2c992c4b3869f6ef27b80202
[3/4] Lindent: Remove wrapper around indent tool
      commit: 1b5a8ff3fdf607656097761174abe4b7473b89db
[4/4] doc: Update U-Boot coding style guide with clang-format usage
      commit: a9d997685a400e1a08d60056177aefcd159bc2af
-- 
Tom


