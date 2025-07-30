Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A2AEC87FCB
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 17:19:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 263E182D32;
	Wed, 30 Jul 2025 19:18:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QM/WJBNZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 800B3830B4; Wed, 30 Jul 2025 19:18:47 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9988A803CC
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 19:18:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-2ff8d43619cso92621fac.1
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 10:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753895923; x=1754500723; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jkRxmq9evVuytgH0e5j5EMnLkLmNNT5/lSLMcT57PG0=;
 b=QM/WJBNZLqRrEeu/uXCJDoJ05y6Erz9AB/B6Ouk678NINJ0+42F74Gd1S0YnCkN0GW
 yD7S+/WrqrG94b1UALSLNPT5oO6O6/kiDO3K8Fsau6iloJqOH5PZHasSwOdDrZ3vdzTT
 ujpabAzoy+f3sevPDBUiB10hXPODnz1tAk9DE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753895923; x=1754500723;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jkRxmq9evVuytgH0e5j5EMnLkLmNNT5/lSLMcT57PG0=;
 b=pqFP7JAGyv6kdBci3yBMe0nTwwy8EtGIurkC8ASD7NVJe/dh3fEDU8qONy9jCCSPSu
 f+Cb+dwR7CEHpOQBcJorE4h7BOrgEZNOOllHtwKNF0XuI4ZldiHCO+oKjz98i2NYoUM7
 XxxjyNwO9OGtCFcFKjvMGC5C76K0S4yG751qKnIVSBmUg5Z0LIaF0yz3RUA02YDk4S3Q
 DzrKk9YyRtLl9xiBlVQarL2IyYvkJ6QPA2eFWZP9LDX1/pWUJ6ZElTXbLO4rHU9ImBYW
 vCD0V++sSJoxRRpQP73FbNcyfksvf8TGtuQZMpavwIlVQE/mwaNbqe5MkfGlqr1Vy3mr
 17og==
X-Gm-Message-State: AOJu0YwGsOq8jq1gbXEXKvwCJWxm9CwVyAgqkdjMZrnVGGUf2XyHNyJQ
 XJ15zr6EhGD2BVWpAPpTDHLH06nMBOtJrbsyC8lBnekrWkxy85Lo2v2vg555rbKo1V5LKWAELlb
 jD0TYsDs=
X-Gm-Gg: ASbGncvFxWo7ash22gCvq+XRt1wKfC1FZ86GxYxwas7D7mhkPxeLwTUcgoQjPYRyETu
 wtAhFO1CUizySzqL/SXg8POh1XKsxwAsxhgSGKdZayuY6VAxUbTPp4Frig8o5ES+5uULgghmcoJ
 06F8C4MpZ2QXLlunR56+0RigIsGfUwtjKyC6DfhTEyexe3KzKjAM6KWvU+kFH7pl9eK1Qi8pB96
 Drh8AD+t1O2QuSkeC9SC39NhVKqr51VFd6Ju4YXwAZIZJ0syUilZH3Dminb/dxhWtiToWt0UW4M
 KTivrvIjefupHQBG9mV/yPRN4N0AWHkG5JxyfT+/teGHtSXZJtX2wHFGNu4vwpG5kJ2agg+8fUN
 PCdxQ5qDThjbk2PLpQNsTgPHywWniSyhYw3y/u5fDr6Hol7pM+Iof2co=
X-Google-Smtp-Source: AGHT+IGtSsbBYDBXv4WnXWh8k/IYSRRV5MG72M+HaKDa3ARYsj9YHxxL4OaraTISvHXVtqlK2qIIKw==
X-Received: by 2002:a05:6870:591:b0:2ff:8f57:9168 with SMTP id
 586e51a60fabf-30785cb08a9mr2549835fac.28.1753895923220; 
 Wed, 30 Jul 2025 10:18:43 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3071323a99csm3016751fac.12.2025.07.30.10.18.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Jul 2025 10:18:42 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250722-usb_onboard_hub_cypress_hx3-v4-0-91c3ee958c0e@thaumatec.com>
References: <20250722-usb_onboard_hub_cypress_hx3-v4-0-91c3ee958c0e@thaumatec.com>
Subject: Re: [PATCH v4 0/5] Extend usb_onboard_hub driver to support
 Cypress HX3 hub family
Message-Id: <175389592193.3621398.11597831090132856728.b4-ty@konsulko.com>
Date: Wed, 30 Jul 2025 11:18:41 -0600
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

On Tue, 22 Jul 2025 11:55:32 +0200, Lukasz Czechowski wrote:

> This patch series extends the usb_onboard_hub driver to allow for
> support of more types of onboard hub devices, and adds the Cypress
> HX3 hub family.
> 
> First patch in the series updates the bind function, so that it no
> longer uses hardcoded compatible strings.
> Next patch simplifies the code, by removing unnecessary dm_gpio
> function call.
> Third patch updates the remove function, which allows the prevent
> issues with usb devices reenumeration, in case of calling
> "usb reset". Although the issue could still occur in case of invalid
> initial state of reset gpio, it is minimized with no impact on main
> usb_hub driver.
> Fourth patch extends the driver with support for multiple power
> supplies, the same way it is done in kernel driver.
> Finally, last patch provides hub data and of_match table entries
> for Cypress HX3
> 
> [...]

Applied to u-boot/master, thanks!

[1/5] usb: onboard-hub: Use the ofnode to check if the peer-hub was probed
      commit: a4446e13dba65f2e56e0d7a97875f76e5199015c
[2/5] usb: onboard-hub: Use devm API do automatically free the reset GPIO
      commit: 480753ca92352e69a08455ad487089388fac9d88
[3/5] usb: onboard-hub: Set the reset gpio pin before freeing
      commit: 42a025412d737cd57874b81de8c8f49fea538c8b
[4/5] usb: onboard-hub: Add support for multiple power supplies
      commit: 3eb6b0f504f7b6ed3d7786c48fc15fa4d8708d7c
[5/5] usb: onboard-hub: Add support for Cypress HX3 family
      commit: a1f8103bbeedfcb2f4521eabc9f1aa580d81ec00
-- 
Tom


