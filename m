Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E1CC4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 20:40:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A63E687871;
	Wed, 13 Dec 2023 21:39:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="N6Mc2kVW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1397587863; Wed, 13 Dec 2023 21:39:17 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1377287869
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 21:39:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-54c64316a22so9341181a12.0
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 12:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702499952; x=1703104752; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RcD9K0023HiknR/hfJRtAUaTjYZBnNG3/NSwBJb+9nc=;
 b=N6Mc2kVWTnzn3ezcYRDTZJdNMso1MWlTUkBbBG+Wf8rcabcQahZ77DS9hSPrSj2Wi7
 zZEGIWlrkp8rL+p2bGD1ZWFgHJFg4CZSiBEWS9ZcsMRh4tRWsaurlx2DXbAFbdVIamcy
 z8vG2uNU3gXKgf+RP08/avDPJ4t1x+j5hgnnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702499952; x=1703104752;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RcD9K0023HiknR/hfJRtAUaTjYZBnNG3/NSwBJb+9nc=;
 b=YhkWi8hVWcEewKHPM2hJ5GH/rzr41+1eSDPUjwZmjFc3covjS7U1BUwHpLshPsizI0
 RmpPUVlQoMglE+tcgNq8gsdYLkXHx/lJ4/7lVLM6LWZ7sciKoddNtdzUcb/EoSQ3fGlx
 vk9bx+RcYLSGQEM3hlBpZHtngma2x95BUi5CeexSPOopIcIosNLkVKlKP++7F6wuX5f/
 m4igAqGu2RChx2dbeF7hK40BPFvu+hfLoJXqzfB9jA2Tpa+BmwsewwQxlW0+jiCsD2FQ
 RCl4GneXAn59LqqzZFUpkRHJN5TPjK75IVMTYklbEfo7ny3GBx5a6FrccJ4fbuPHd1Dc
 HEdA==
X-Gm-Message-State: AOJu0YxJq2WeiEXd1IqWBzhBo67gqt0thL0/J18jLar8zPmuASvoEPBy
 6Ei55Tby+LHT6/IFVcox9o7uy+Si6s1QQCCFlgNyI8xryKYMdsNhVbA=
X-Google-Smtp-Source: AGHT+IE1QDSV53Kj+CEESvb1XZ0D8n7+Q5fgO5Cb86fveVWU3yLj7HUEJcMSRPX/gnnsMLstP6jZkTF/eUbARRikz5g=
X-Received: by 2002:a17:906:7386:b0:a14:b151:72e6 with SMTP id
 f6-20020a170906738600b00a14b15172e6mr4291908ejl.21.1702499952340; Wed, 13 Dec
 2023 12:39:12 -0800 (PST)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 13 Dec 2023 12:39:06 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231121144128.20256-2-heinrich.schuchardt@canonical.com>
References: <20231121144128.20256-2-heinrich.schuchardt@canonical.com>
 <20231121144128.20256-1-heinrich.schuchardt@canonical.com>
Date: Wed, 13 Dec 2023 12:39:06 -0800
X-Google-Sender-Auth: YesHPcOB42pL6vbdSB12lQwwr_A
Message-ID: <CAPnjgZ3PwMy89B0-DGMz1MfWizqa2C2W9R=g3ob6X_UUY8wXLg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] acpi: fix struct acpi_xsdt
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
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

The size of the ACPI table header is not a multiple of 8. We have to mark
struct acpi_xsdt as packed to correctly access field Entry.

Add a unit test for the offsets of field Entry in the RSDT and XSDT tables.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
v4:
	no change
v3:
	no change
v2:
	add unit test for offset of field Entry in RSDT, XSDT
---
 include/acpi/acpi_table.h |  2 +-
 test/dm/acpi.c            | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

Applied to u-boot-dm/next, thanks!
