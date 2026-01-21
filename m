Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A3FC44506
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 20:49:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B51E483AB7;
	Wed, 21 Jan 2026 21:48:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="E+ZTbnAK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42CFC83B63; Wed, 21 Jan 2026 21:48:49 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18CBB83AB0
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 21:48:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7cfda2de4efso198267a34.3
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 12:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769028526; x=1769633326; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yEFUXMHaM8jozNCmqF0R3Xe0InK0l+Jd5PwtRm3i4Lw=;
 b=E+ZTbnAKgPoVv9DR04GqqF1at0uflqLvdSdZxVUZ3Jxn9157ZEziBzdkG94/FbA9Zx
 t6E6j6WwsPdjguxtNmMAa0K8sGRYH97mAE4byT767+lzGA/Na2cQpRctAVDVemGv1UR7
 sU+oma4qMSqdvpDT0Fvbhp+lRTHb41Xsqg/oU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769028526; x=1769633326;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yEFUXMHaM8jozNCmqF0R3Xe0InK0l+Jd5PwtRm3i4Lw=;
 b=UtphGnYpRHWW/LUeyJVxDOIxtQ8tfGEjXAp9dS5MVJ1xyzWB4GfSP9pDNW23bbRDIt
 N7cuQ/Hkoy/YGlk0adEAQvZILJFMu+miM8L1b6qORtdTLO/oeIOo5rexMOYSNuMHWoqo
 6oLMa9O9RMKBd6lqdxI9zOgg/PJl7jpu+3AxQKflygeQpE2ypTzy79H7iWfV2qSUeGPL
 dAZVLi/rsvN2hJcolG4u/QRnjahJrmilKBsiVtKNfx1yZY02sVkym7jWh5Jy3ugi9dQS
 XJW/o1Gk6OXvt9iexr4V5Fcz02LjtaQudzY9EVcYWg6xO/O6aif+4Cp1Lsrz0j1eY2ei
 x4eQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAn6EafZ9m3sNKJaLgOePQBF9rr9E2txCDmrHoxm/gWvnloLjkBqcNVW6pP/Mx1UsAXXFvRs4=@lists.denx.de
X-Gm-Message-State: AOJu0YyZa2MjjJlwlfoNQAqpSNYyeubMikIy6PVJv2oIH8jgN/CBPr1M
 tua5jDCexvZIQWnO+Yba5ef3cv7p2b2cRvm2FdbzC/SU7akR/lxWe+LfsayeZVyM6KO2STPs+LB
 cUropgSI=
X-Gm-Gg: AZuq6aIXtxAAh+JM0puZMvk/Ozj5aWjxRZarJG4ifIOCE8UrXKhpobuP3sgNNp39tRj
 Elz0jWXfKb9NayBSaz7qfw33llXbaIyGT9lmbj5LIukWRHmnqiSNPO7GBb+EeHCfM54OErAbaRU
 jH5GslbQrnA+qhROHphPs1LzX+sGwhnxcvbsq3GkZvFEK0Cp2/RuIcreJeAcC1mmF/QJlAaxk/q
 VjBPS8g/onXSiJSaxqcB8o7l9tCr+AFIk5fHe/StCQfqCTDlnAssOx7fN2vULcaG67WuxAASu42
 8xPgiZyCL8sI2Eo1+WQNkS+V4tOQpdjYj6QLyCMCL9YOuwp+xn953Kl7u5bamdcOEBXYUujUvW4
 01upxjfwcyTbWwVbCrjsdbvNmoaeHG9udASwj47/6nSLDfdi6VM44jUBrCZFjfckNX2PQ+MJeHZ
 3KBbt5cpMcM9EE7voBtdC3kezZvdw4PcoXnyRfzoEiKG98bB4Gr359j00X+aBKQA3uyDbE8F5fw
 Y0e0CI4y6P6hpzTm8xXUJ8DfjPs0MjdhGZM6g==
X-Received: by 2002:a05:6830:81f8:b0:7cf:da7d:5040 with SMTP id
 46e09a7af769-7cfded6f064mr12167559a34.14.1769028525842; 
 Wed, 21 Jan 2026 12:48:45 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cfdf0d8e05sm11134487a34.6.2026.01.21.12.48.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 12:48:45 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
In-Reply-To: <20260114-clk-mtk-fix-mux-set-parent-v1-1-bccd82b10027@baylibre.com>
References: <20260114-clk-mtk-fix-mux-set-parent-v1-1-bccd82b10027@baylibre.com>
Subject: Re: [PATCH] clk: mediatek: fix mux clocks with mapped parent IDs
Message-Id: <176902852471.661474.14377004900169705836.b4-ty@konsulko.com>
Date: Wed, 21 Jan 2026 14:48:44 -0600
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

On Wed, 14 Jan 2026 16:24:14 -0600, David Lechner wrote:

> Pass the unmapped parent ID when setting parent for mux clocks.
> 
> For technical reasons, some Mediatek clock driver have a mapping between
> the clock IDs used in the devicetree and ID used in the generic clock
> framework.
> 
> The mtk_clk_mux_set_parent() function is comparing the passed mapped
> parent ID against the unmapped IDs in the chip-specific data structures.
> Before this change, we were passing the mapped parent ID. When there is
> a mapping, this resulted in buggy behavior (usually just incorrectly
> failing to find a match and returning an error). We need to pass the
> unmapped ID of the parent clock instead for the matching to work
> correctly.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] clk: mediatek: fix mux clocks with mapped parent IDs
      commit: c196b0a6882929bf0b6504eae963f24289ee5d85
-- 
Tom


