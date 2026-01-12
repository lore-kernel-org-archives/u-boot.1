Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05DECCF45CF
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 21:09:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19B10836D3;
	Mon, 12 Jan 2026 22:09:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BWxHRMql";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B44F83885; Mon, 12 Jan 2026 22:09:28 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21263836C8
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 22:09:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-4507605e19aso4612107b6e.2
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 13:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768252162; x=1768856962; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oVmluMvE/RMSGPYCp+kQWHb3ggFQ6Qsbj/A+YhYndi4=;
 b=BWxHRMqlszcepjAnKFBHGYK/X96L36JMpMC0rqt3v1y9gB4s1JwpcKweZm/7uu1e+2
 LSBmZFfFuMZi7rLoqOE6ex4iTpgcDHWN7QZ/EgD7DRBx1FnYtUEG32d2DAB0z53mH2x+
 aRL8ONgKkShgSrnTB/BU3Ce8/8FDUXpKMqsEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768252162; x=1768856962;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oVmluMvE/RMSGPYCp+kQWHb3ggFQ6Qsbj/A+YhYndi4=;
 b=ukghsq8eoi+L6LCr/V4B3JMS2sR8rZWALQYP5i6NScsccsVYnTvxK0mjGZfSAjpxY7
 +dy1fO3v3Vgrz2uOvt6ANP7EUhTfZ34zLiAB8ywTPzuVwNSji+1dSa67APYHBARcS9ZY
 5KnajjTePYSmKPBVVGccBXOdCWxmSO8WqHvA4XKmX81EPkPMBKYWVDm6euHcjE5NZmuB
 MhKUQ3TjWhNMRdOX9IyMUv9Q70FT0lFiJKncQxCzfhJflfzFgLoJLsoYvJoHGJrr/bN8
 6eY+lqKDuedM7bayojX0WhbkHD+A2lpqT19+pT7qc/WKlm+HS2RhP/UCT1oSswNnz3DZ
 Od5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVm3DPMuijQQzlAN+5n4+XxIVUb8dBJ2R1mT8IVdGl3QMXs54tcOrB/UmYAQ/hfH/K0lVFwUGU=@lists.denx.de
X-Gm-Message-State: AOJu0Yzn636Y97F+Rq/X8jBVV5L4lWanRhN92mSTnLQxcviC5KcEQ14e
 aKEwSJDauSIo6PrIoevOs2wTzZOkxYq7wcmZFZP3OSAGLtxHFo0stqPKCbhhVw1jN4UqAQi/e/P
 DOnBR7LY=
X-Gm-Gg: AY/fxX4PR57cUfUYNS4qJCXe4uh6NUKHkUCw94jEvMFAwNsvnVZ8SBsvlkgNiJkae99
 dGAsL+kqW7dusZ99F+1o3glTDzCQsr/r3qUzENswUL5hIpJCM7A6WZfoM0ezM9it23gsIjR+47l
 CxG+czgbOKp2sudnzMFr/kM3cqyvnhOkcuwUfuYGoq0uGLVYP28RtvEf9LNJFRudi3rm4iEMDXl
 4lMj1p4iDst+s2113PQCP9qCKZT/aqTLDktw9ZrneELstfKeEBOYyczPewTkNTG+AYrvfi5CvD+
 W+cvVCduqv6Nk600s2869pYVhiz7RRosw7uUPKov7fgAeUH5eXO5YWmEmZBg2S2EN2n1EAGdNj8
 Fmneq9996eZcUNdMBK0jNuYVGwVxxDPEVhFrHmSFHq7g3sEb7AAjaIEFm1BkJhg2cC9aCLU/QUZ
 NUdioTASh0GBSSn7qODY+FivJvbTD5gp9u6Lvd1y+y2B/EgsX9iBdX5VA3xu4aGXHYFdQMZuSfp
 AbiQbwb6tDKNZTU45iXurgzwskRMSURIVBQrw==
X-Google-Smtp-Source: AGHT+IHtnv49P7CFfWSv9jzHiD8b386o1SEXw9zgypIm8J582JFRH/RQBygG1NGx7l4FDkFHQxUzhA==
X-Received: by 2002:a05:6808:4fcd:b0:44d:be6b:33c1 with SMTP id
 5614622812f47-45a6beed273mr8813757b6e.65.1768252162276; 
 Mon, 12 Jan 2026 13:09:22 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45a5e17cd0esm8800789b6e.3.2026.01.12.13.09.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 13:09:21 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>
In-Reply-To: <20260106-pinctl-mtk-mt8365-v1-0-0ca3eb382468@baylibre.com>
References: <20260106-pinctl-mtk-mt8365-v1-0-0ca3eb382468@baylibre.com>
Subject: Re: [PATCH 0/3] pinctl: mediatek: add mt8365 support
Message-Id: <176825216130.1883046.17030676324013921496.b4-ty@konsulko.com>
Date: Mon, 12 Jan 2026 15:09:21 -0600
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

On Tue, 06 Jan 2026 16:05:18 -0600, David Lechner wrote:

> MT8365 has different pinctrl register layout compared to other SoCs in
> the family, so needs its own driver.
> 
> This is also the first SoC in this family supported in U-Boot using an
> upstream devicetree that has the mediatek,pctl-regmap property, so we
> need to add support for that to the common mediatek pinctrl code first.
> 
> [...]

Applied to u-boot/master, thanks!

[1/3] pinctrl: mediatek: support mediatek,pctl-regmap property
      commit: 424ceba18bfb4c9bc324618fc572066833e38d88
[2/3] pinctrl: mediatek: add pinctrl driver for MT8365 SoC
      commit: 5f836e52be0bd59e4634a26a8516d7cecd86ff1f
[3/3] configs: mt8365_evk: enable pinctrl
      commit: b58573e89433fdd3b383bd29af44a1f03a56b706
-- 
Tom


