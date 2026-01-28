Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE85ED46BE5
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 17:48:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3872C83CAA;
	Wed, 28 Jan 2026 18:48:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lwQahms8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BBDC83DC9; Wed, 28 Jan 2026 18:48:34 +0100 (CET)
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC3C383C39
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 18:48:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x341.google.com with SMTP id
 46e09a7af769-7d195166b2cso20698a34.3
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 09:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769622511; x=1770227311; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KpEooqyETsoMEBWaMdTx955e4AtvliV/NWHwI3As6ok=;
 b=lwQahms8a+qNBFswTSxpGfFaRxl81FCl1ejgzWY38y0XQdtJH/Ej6nR5gv6DH6UfXE
 azcuje1Y2748x7bJdwRogBS8+/XYnMZkE4v2+QiUF40OzNBwjkmRzXoW5vF9bo+AlKDq
 QPyHprQao9FJWGdUVj3I+EaQypX3aBWzDOSJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769622511; x=1770227311;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KpEooqyETsoMEBWaMdTx955e4AtvliV/NWHwI3As6ok=;
 b=JykQdSEo0DUB+WJC0cdKemCpfOnhoBP7qGHCqHLVlJTHBZsH6UiRKgWYokM6WlRvPS
 8OzRWnCU2gLChPK23Q24Qc4qHmvgVar3/Z+od/GdMuxTXp0yUOjtM8AApipVlIZIqu/D
 UjAznIl5kvka5V4J5CQKtiujodlz+OpnH2TDXYfqFMmZpW535Xp2PSxbMbVjnJVeXqQL
 imY3UxnzDLxLvKIbh1urS7OjaHR2eKMgHGk1PjVXWrm/uKbVoz/WHrdjE4qjU0iH+faf
 MwxktUu83ekRegHCwrDDI8H0exAJ6J6+Ij68ZSTS7TvcVJOMvtd+qF177vJYuwRTvdiF
 xeIQ==
X-Gm-Message-State: AOJu0YzFkxdilQw5FFBHWdaXH5KGyVfFWlKCJvc48XtRnO/XqX6tDm1G
 yLgzc4QQ9YigPJjeaLMk0kWhUNweZ+AJ89/NFmndvuoBqDEXALOfOMvDOBz3NanIqjws4Ii1cNW
 pUFjzei4=
X-Gm-Gg: AZuq6aJ8sVJMPxTn4KuuB0ERAr8yaCp8JfCBvfEcrtzyQSrg8JACFyMhzkimv69kF1l
 yY+lys9CvLeyglCHZjmBz2ty8L1pC/VpUg3LWMbE1jSasnAicInmY/7HZ/KvYtuoPib40tus4MA
 Zx7lSHyKoa4COeGZCgK5ps5iVyd2LcpcloNvNTwAsxVSXEST+VNMmVEfAJPZpPOUQvmJaU1NREM
 oMmvMdIeM4nWY3gqnWevWQwl7UYiJiwExcjc2GUc8H9WN41btgx82J5orzHZF08E5H+SnJqO/ZL
 NzVxuz7HLzkak3xReGmw8bkQn+UWbudKycIbMRYvNp2/KD0s/G9UjSAFNIC5EvbT1jjmVe8XyQo
 bQR+lAw0B2ah15MKuCyT8HpJ/ZXgTxcXBVWl0bZ/PFfkrSE+GF24am1HGK9CtHiC8DSN0Ecc/O3
 KOTZvtWC3A/phQdR7AvF4O1AvYxR6TSVFWQrT0Q6pmTabADst0lrPqKg5jYKrKy/kYacImk2pmR
 HIgqf6Pdx5ItI7HDr7r7o4NBSliT6M4BGfSdwZGB54/g2au
X-Received: by 2002:a05:6830:608a:b0:7d1:474a:1910 with SMTP id
 46e09a7af769-7d1850f3b51mr3386334a34.28.1769622510662; 
 Wed, 28 Jan 2026 09:48:30 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d18c7cf526sm2156982a34.17.2026.01.28.09.48.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 09:48:30 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Cc: Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Simon Glass <simon.glass@canonical.com>
In-Reply-To: <20260127-topic-musb-probing-v2026-01-v4-0-ea3201e0f809@baylibre.com>
References: <20260127-topic-musb-probing-v2026-01-v4-0-ea3201e0f809@baylibre.com>
Subject: Re: (subset) [PATCH v4 0/7] dm: core: Support same compatible in
 host/gadget musb drivers
Message-Id: <176962250947.1701001.12363653047797853440.b4-ty@konsulko.com>
Date: Wed, 28 Jan 2026 11:48:29 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Tue, 27 Jan 2026 12:03:34 +0100, Markus Schneider-Pargmann (TI.com) wrote:

> musb currently uses a wrapper driver that binds on the parent device of
> the actual musb devices to manage the differentiation between gadget and
> host modes. However in the upstream devicetree this parent devicetree
> node can not be used to match the wrapper driver.
> 
> To be able to probe the musb devices in host/gadget mode directly, this
> series introduces support for returning -ENODEV in bind functions
> resulting in iterating the remaining drivers potentially binding to
> other drivers that match the compatible.
> 
> [...]

Applied to u-boot/master, thanks!

[1/7] dm: core: lists_bind_fdt: Remove unused variable
      commit: 6f3e63b4de851357d81f74211f14fd3b577cae6c
[2/7] dm: core: lists_bind_fdt: Replace found variable
      commit: 41cf66011fc80bd122c3ebbeda4218547c48c297
[3/7] dm: core: Support multiple drivers with same compatibles
      commit: 6668b8e7cc68ee287ef87e18aadc97bf88cea4db
[4/7] dm: core: lists_bind_fdt: Indent continuation debug log message
      commit: 87d7d8190f5cc17abc104f924e0f499fda2fd02e
[5/7] test: dm: Add compatible multimatch test
      commit: c7e0e3fd33ca9809605a6de0a58809daf1224bff
-- 
Tom


