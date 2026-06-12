Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA8BCCD98CC
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 01:59:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE71E848D8;
	Fri, 12 Jun 2026 03:59:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cAoiU//g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8396C838BB; Fri, 12 Jun 2026 03:59:19 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51DCD84717
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 03:59:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-4864abba33fso372630b6e.0
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 18:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781229556; x=1781834356; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+wPqTjXpzV9LSsHdxi2aK3vdxYcCCaufUl7l7l8+2Vk=;
 b=cAoiU//gxhG7ITauGbQviXK2vxeEV+vlwMIAfWXEkj8SH9kDnYBRRGm+bexJieknDi
 xqlv24pVHnyCOewXYNmoARQFtJEMtU0xtu37qV9SdRWIwfUofk9zw07VERNn58gnKydj
 c9haHCup/pSecPmGs3KjQdMSB16+wBJjkfN10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781229556; x=1781834356;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+wPqTjXpzV9LSsHdxi2aK3vdxYcCCaufUl7l7l8+2Vk=;
 b=UIuuhQB7YDpRz6bq76gZnstxiujpR1D/oyTLDNNNWB3bl4rU68zPJJHhbpQAuVoQsI
 YoQ6FHytxwYW67SfYD2aO47LssMA0j/H3z0E+uM9JaEZmCMViS4YprB/0p+qzstfVCo6
 n0wmZwsR3/UtVDu+9pPnzEfCzjANBsBX0RZdxNVy4sK6VYx/Ax0EB8qSqOWpviiFGgmQ
 yAxwovskdfLPnYI41MbqRoi0I2Qw9JUc62RBH+gpijEQM5Bx/FFAIsiy9s+xuErGlFat
 Ks16u6NFXZrHwR6rqbcotRG9omBpSyrcJdDxTzTtWl/1mCnAKINymXU+YB/X5dswB1oN
 9OkA==
X-Gm-Message-State: AOJu0YwmYl/0vCX7X04/f2E04eTIeWid4FxjgqvTLQUaCX5on2ThIjQt
 InNdTUTq1pLCFz501ssln2d8NBimJCb991YE/mJZBQc5FkXykkxqGqCNOs+2MYVlwdMyS0Hs7Mo
 HjDJOXTg=
X-Gm-Gg: Acq92OGgb52IzZKWaRHJBhpAJKRvzLjCEwve2suhyIemmoaiyWzSoP8wkPAdf3DgU+O
 nNToaS/0JbZXVv3MX5lx+7vdIs5hVWAZpbLGWfSj1hCMYBEe7Oy8Dz8NcKUkOK5Jw3fZy4QpUmh
 4i4bCRvJRaCFiULZlqdWkAXRdsV8Ed3toVLwajn5OFA43hZpyD7liacSFla+wz7r/2rMdYrw2Su
 c4UpRMB+BDmnlTIrjo+pkK4tYN6cR51kNXUoV1QTgV+SggSrfTZwb6vVJN1XF1az1r/10E0weKB
 zSOSTtXngX3PNSIrKFYUz94ufpMMT0kYN5SrAQbgf5sDU8SaOynEHE7qCIIncByuDHEEilEmDkh
 d0c9ZvArVXo5eikM/5OZEwltZIEzTvp4mDlcRXYb/vW6LTa60LLUXt7Cuh5IBzAZJs0CT4Anev6
 dL85NdcRjHYY3GLyw30RjXG7r2f0n+Kw9vL4eHrK4/HFQOWn48z6U5LKio6jNZo55vaEApMDbQB
 jS06razKjjF6SXjP1oFBIkEWaPKrchpU3cyG4H7NN9/UFA=
X-Received: by 2002:a05:6808:3025:b0:486:4b79:12b6 with SMTP id
 5614622812f47-4872dde9912mr738510b6e.9.1781229556070; 
 Thu, 11 Jun 2026 18:59:16 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-245.totalplay.net.
 [189.203.97.245]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4426abf184asm534734fac.5.2026.06.11.18.59.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 18:59:15 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Aristo Chen <aristo.chen@canonical.com>
In-Reply-To: <20260526020917.8438-1-aristo.chen@canonical.com>
References: <20260526020917.8438-1-aristo.chen@canonical.com>
Subject: Re: [PATCH v2 0/2] fdt_support: validate property lengths in
 chosen and dma-range fixups
Message-Id: <178122955531.605671.16534451440331531039.b4-ty@konsulko.com>
Date: Thu, 11 Jun 2026 19:59:15 -0600
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

On Tue, 26 May 2026 02:09:13 +0000, Aristo Chen wrote:

> boot/fdt_support.c contains a number of helpers that fix up the kernel
> devicetree handed to the OS during bootm/booti. Several of those
> helpers consume fdt_getprop() results without validating the returned
> length against the per-entry size implied by the surrounding cell-count
> arithmetic. When the OS devicetree is not signature-verified, for
> example an unsigned FIT, a DT loaded from $fdtaddr or $fdtcontroladdr,
> or a DT supplied over a network boot, the property is
> attacker-influenced and the missing checks turn into out-of-bounds
> reads or writes on the FDT blob and on stack buffers.
> 
> [...]

Applied to u-boot/next, thanks!

[1/2] fdt_support: bound serialN alias length before copying to stack
      commit: ca774b94d66332b6bd033369227ac487ad07d5e8
[2/2] fdt_support: validate dma-ranges length in fdt_get_dma_range
      commit: 84e250c0a85a615620a461e0710bb970801fb276
-- 
Tom


