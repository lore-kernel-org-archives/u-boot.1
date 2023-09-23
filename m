Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 121BDCE7A89
	for <u-boot@archiver.kernel.org>; Sat, 23 Sep 2023 19:50:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07CCC86C28;
	Sat, 23 Sep 2023 21:47:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SL6u6/PT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CABD086BD6; Sat, 23 Sep 2023 21:47:47 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE78186BE1
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 21:47:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-533d6a8d6b6so889251a12.2
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 12:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695498465; x=1696103265; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8Tjld7HL+k71zR4upxGaDbc9nppsAIyytz8o2gdoj2o=;
 b=SL6u6/PTmGu5x+sMSBQwhJGECpgOyUx0JElCIRSHzv/+mLadiMRtzfVfIakylUmzXM
 EuobI1mRjhC8sSJ4/2FRmc91gjZztVPLpwCf4Wc3KLflh4AeO8tZsN0PU0HxZll+advf
 hPQB/AqrpIHfczisVGVtMO3Kcj6BT7+Y73LpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695498465; x=1696103265;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8Tjld7HL+k71zR4upxGaDbc9nppsAIyytz8o2gdoj2o=;
 b=ZmVuln97NbfYAFSzS7iUuu0StadrTQeSOEd1gNLFvvt/srZgvLQ1e8w4dMtIDnR13M
 qwZPWCuWpRpd8xl8TA8ejKqgwInBIVzZBm25fc7UU9aF+gIGe3B/ABz2OloDTU9HuAHW
 OQmgk5Syb0ML9Ru2dStxyKhJmxI2AXtXNOXBvIfWqXiotLPbSLMJKnZhQBwH4jx0KS38
 UVkWyx3WMftPEujp7FFO85utqTAAe2biS7eh+1efjvR53shezl2Zuh+QrHnCCl8Ntrso
 In4OyS5S5afjUlWNKllzctJlfBHW+MDuV1tmDElJU1A1N6BU1wQBtogHWVl1EIgTDod6
 vDEg==
X-Gm-Message-State: AOJu0YxOhYgP2cIT11oLXMIOfs4q40xIYFGlR+WuP9WlDjE3vVDZr9TL
 orhsU2IknBZ+yjanv9vitkEhKdwU2npBxEoLeDWYjg==
X-Google-Smtp-Source: AGHT+IFizqGw0LmB/5gfzoHUbOQRM7y5GOnAPdVRZTjYuiY8boEPpfXWVyVfRt6A0n+jPYtP5dLxE/VsfXoNYXnvwYw=
X-Received: by 2002:aa7:d78f:0:b0:530:74ed:fc8a with SMTP id
 s15-20020aa7d78f000000b0053074edfc8amr2164735edq.41.1695498465419; Sat, 23
 Sep 2023 12:47:45 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 23 Sep 2023 12:47:44 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20230820220316.3517102-1-jonas@kwiboo.se>
References: <20230820220316.3517102-1-jonas@kwiboo.se>
Date: Sat, 23 Sep 2023 12:47:44 -0700
X-Google-Sender-Auth: a3asWGAtezDSfqXmMravo1aq0hg
Message-ID: <CAPnjgZ1fx4MXKGRNPwT1V0JaeBOO3YKcV12gRD9nTdq3ZgrhAw@mail.gmail.com>
Subject: Re: [PATCH v2] dm: core: Report bootph-pre-ram/sram node as pre-reloc
 after relocation
To: Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
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

Nodes with bootph-pre-sram/ram props are bound in multiple phases:
1. At TPL (bootph-pre-sram) or SPL (bootph-pre-ram) phase
2. At U-Boot proper pre-relocation phase
3. At U-Boot proper normal phase

However the binding and U-Boot Driver Model documentation indicate that
only nodes marked with bootph-all or bootph-some-ram should be bound in
the U-Boot proper pre-relocation phase.

Change ofnode_pre_reloc to report a node with bootph-pre-ram/sram prop
with a pre-reloc status only after U-Boot proper pre-relocation phase.
Also update the ofnode_pre_reloc documentation to closer reflect the
binding and driver model documentation.

This changes behavior of what nodes are bound in the U-Boot proper
pre-relocation phase. Change to bootph-all or add bootph-some-ram prop
to restore prior behavior.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Changes in v2:
- Drop use of !! to convert into bool
- Update documentation for ofnode_pre_reloc
- Rewrite commit message
- Collect r-b tag

 drivers/core/ofnode.c | 2 +-
 include/dm/ofnode.h   | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

Applied to u-boot-dm/next, thanks!
