Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ECF7C282D1
	for <u-boot@archiver.kernel.org>; Sun,  9 Mar 2025 08:59:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1350980107;
	Sun,  9 Mar 2025 09:59:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ml71uNa6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49EF9801DE; Sun,  9 Mar 2025 09:59:48 +0100 (CET)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 161118003E
 for <u-boot@lists.denx.de>; Sun,  9 Mar 2025 09:59:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e53a91756e5so2494080276.1
 for <u-boot@lists.denx.de>; Sun, 09 Mar 2025 00:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741510785; x=1742115585; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nbPT0DeXdQKr6ZDtL8YF6sC8qVaQC03o5K+bE0iHtIY=;
 b=ml71uNa6tbgOBUr4tRb5sKQVb7PcOfsPzi80ngOA75nIv4eTl+V/3K0yOBDe/8uNXp
 eGgsDuq1cja110oDW/G8K0vQ5PVgDHsQWx7rxYLvmXWVa7JhoH5Zm3DBXHEQ2ZmEguuw
 8peddtPctFQ48J3etBFCT5ecdn3TkyEDypS4tC5QUDU1Ggn33UVd8G9wKfxApaUfB4FO
 K4hN+GIVHqqtRlRC+tviZs+ODL6T87k73qg4VhkmFvF2PM5X4BKdj0rIR9xyDkXxZ5qk
 hb8zQI7Ai8/m64mnA4O2v5U3HWP2az9LYEjJWRCDQcLZdEAG4fMeMPum2R2yWTBdwAhp
 ktGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741510785; x=1742115585;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nbPT0DeXdQKr6ZDtL8YF6sC8qVaQC03o5K+bE0iHtIY=;
 b=JUfP5+5PvvPCVFQ75VW3Gcc0jGEPN7GSuccTAALOcDhd216CJ8OeBoF1q2q/htWOA7
 hBpztDJrJBqgbmVWl18ElHKn4QDg17rHFGK2tdOHIzhitQ0M/MbUACSfCsbhSOKu/xB0
 6p4UzdMbzvfT8+fbuJE51IWT3ROHslZcuOTCP9fEYqyyc3gaVGRySj4pvmsNgrqhqKch
 eZwklQBGlu1C/G73dEkCixEN8O1QoGB0ytn4tBp+k3VOlwpV2AVdFvn7P7afg1daiKCw
 KpmK+vL0EMExiiMAqwpuB03Pa/+kGXQw6QwoGUKh09k2xYOdf6yWNPn/GOVcaiHrnd5d
 tFkA==
X-Gm-Message-State: AOJu0YzF8PrU4tT0GHaQ8chTckIk9pWXKxueXUF+Nyxedr9DP1cPCQPU
 pE4b1yg8smWvQ+WZQfScw1OyP6FLjhkpuDEgtd16LldRg+mybNws82aB6cg9+Ab+9qV1mujbTci
 CL6QDaahg3tlzBejW0aICjx9F9yww5A/B/nNxLw==
X-Gm-Gg: ASbGncu3qlnwSxFDedf1HeUnKsUV7wBOpg76Brfb2zhi17dhfwZnbADBxhfSuD4pH8A
 +m5ShT14uhFiCu04em9lL0MMhGRFfLZkqM0vDbT/ism/6P2TCJJsaxK3JmTdRwX43USJfqpW5rI
 SS9x/rSbrD3FiwYCJegBYfd2TweHC4n920oNCn/w==
X-Google-Smtp-Source: AGHT+IFQXWEL5JRGnF4K8MFqIoavf5beNQFYvQGAywGf2gnf4YWrXK5e8IiIkE8IvP7w4iOptXTI0RLY7XnXEYjg6sM=
X-Received: by 2002:a05:6902:468a:b0:e63:85cf:c82d with SMTP id
 3f1490d57ef6-e6386618c59mr5031560276.17.1741510768519; Sun, 09 Mar 2025
 00:59:28 -0800 (PST)
MIME-Version: 1.0
References: <20250228084529.127823-1-sughosh.ganu@linaro.org>
 <20250228084529.127823-7-sughosh.ganu@linaro.org>
In-Reply-To: <20250228084529.127823-7-sughosh.ganu@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sun, 9 Mar 2025 10:58:52 +0200
X-Gm-Features: AQ5f1Jrxbb-CUDv3YPysbtKuf_FRsxfE6ohSkBbmpy4EeCo2B-R2hf4DLF3UhIc
Message-ID: <CAC_iWjLGnYzY1XZX4HXKZg8YBqYq9LFJrC_ysm7WN_nFx_kJww@mail.gmail.com>
Subject: Re: [PATCH v6 6/6] blkmap: pass information on ISO image to the OS
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Anton Antonov <Anton.Antonov@arm.com>, 
 Tobias Waldekranz <tobias@waldekranz.com>, Bin Meng <bmeng@tinylab.org>
Content-Type: text/plain; charset="UTF-8"
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

HI Sughosh,

[.,.]

> +static int pmem_node_efi_memmap_setup(void *fdt, ulong addr, u32 size)
> +{
> +       int ret;
> +       efi_status_t status;
> +
> +       ret = fdt_fixup_pmem_region(fdt, addr, size);

As we discussed offline, this will never get called if bootefi has run
before the final OS image we want to load.
The reason is that U-Boot checks the installed config table and skips
the installation. Earlier versions where applying the fixup on the
config table for that reason.
Since Heinrich and you agreed that the DT can unconditionally be
re-installed, I think you should send a v7 including that patch.

Cheers
/Ilias
