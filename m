Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4364EECD6D3
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 18:26:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4990D83E3A;
	Wed, 11 Feb 2026 19:26:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lFJhCWLS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9B6F83A47; Wed, 11 Feb 2026 19:26:45 +0100 (CET)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 927E283DCB
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 19:26:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-6630d0685abso1279890eaf.0
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 10:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770834402; x=1771439202; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sZiEnBIsqo4EcibQrvfcljeZH8byQQgESZ1mLIbcr38=;
 b=lFJhCWLSWQUSuyYKo9bAcizrHb+8rWLLVakcfQKX4EpakEAPcgiQw6XK+VijY9MfuM
 N+4BfRsVz/Sd4vwZO9sbu1Gk5Yy1Zyzvf18MyNHGQmw7rfrwtzxK1dGQRtIHLXkMR75D
 JHDCqQjtJB8kAF7X0O5IvkznHvNwBgPpW9MvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770834402; x=1771439202;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sZiEnBIsqo4EcibQrvfcljeZH8byQQgESZ1mLIbcr38=;
 b=hkwTWRLfsRYifRMrMqiRpfr4ltWpLPEWYQ9NIDFh/xEupjLCthwechBxU4F3D55V4q
 Gp0suRC4tmuf1baYTTSC1XpvRhvU6ecEhBoohkqQ5xCxE9z66c3LhimIFxXW6JFaEeCa
 spUcLREyPIBr+7gBil9XTXU3qg2KT1rJXqZ2UPHXdeZBK7D0YFpXkRgkcH25nr0DWFI5
 O3Tlubrg0ZYA2AvAu7gbLAm3clxX1rG5/HqnCEV0wVlvxZHyeKdnAWKRf4xHXmuTrsFZ
 mZtVmVxI0lquxd/RMNMqtJt8Kvj6q7wsLf8mzVzEJ5O0x7pSnjBDoTPYpFcMSuL9RRHz
 RZFw==
X-Gm-Message-State: AOJu0Yx5RI27QNS2vARpKY5vwx/KtwnU8gopQYPFIiHLbadbbm7rWjPP
 YA8SnBr9z8L0rzlBP1iCPlu6MxgWFl/VLXhINZWrWM3olxLgCClRka3Re3ObFHF3fcw=
X-Gm-Gg: AZuq6aJtYmzXOYjyHu7rZkgfuq4q1vRpVhR9HMW6AJFg1whfhD5Z5dlkXTh2SC9VuCm
 SN5ibNy/XKZ31MotfiNV0jz0mFqLImHlsf/zq7JGZqUkNS+V0M+P5KD++HWt9GnB8nIKOWpritG
 XTdsRxNPNmovpkj6cymWwZOAm8yQIbhHn0R6VeSiluov8C364/mCEWatuxUXOWDbkL/RGXbAkZz
 USC6jTs47esrupnp7hNIU78f/WzHQyFSCiUEONnYO7mtJWtHqrhazegSiymAzr+6uPYQOesJzPb
 dFpHyCqLijIeWJCDCNS/8rPP7CNRDFir++LhRXiHE3SVDR7qI2OHIsoopz86Oa6g9lW/xydYRH0
 zCiLURUdI/1A5Kvvt5ty/Gvc3vZlY27BF61Rii3/4xZIpEp9ItWBIq/xonZpM7FtPKut2QS5whM
 OYBDcwZec8UU3lBHsr+z+Zpu6MofD/hXjNzowBVAxIUXInxt9FiHCj78wjTj3el/6s0+FORCK6U
 Tru8I7LJ+Jv+c+AvQ2M0GhTBbBTA4pYNe+HrX+wWMQLi06ppQ==
X-Received: by 2002:a4a:ee83:0:b0:662:c3fe:e61a with SMTP id
 006d021491bc7-6759af09ab4mr53997eaf.49.1770834402280; 
 Wed, 11 Feb 2026 10:26:42 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40eaf16c383sm1814426fac.14.2026.02.11.10.26.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 10:26:41 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, vagrant@debian.org
Cc: Green Wan <green.wan@sifive.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, Peng Fan <peng.fan@nxp.com>, 
 Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260130040424.472735-1-vagrant@debian.org>
References: <20260130040424.472735-1-vagrant@debian.org>
Subject: Re: [PATCH 1/2] env: Provide another work-around for unquoting fdtfile
Message-Id: <177083440086.1681814.4970334495428293102.b4-ty@konsulko.com>
Date: Wed, 11 Feb 2026 12:26:40 -0600
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

On Thu, 29 Jan 2026 20:04:23 -0800, vagrant@debian.org wrote:

> Some boards use CONFIG_DEFAULT_FDT_FILE to specify the value of
> fdtfile, althugh the quotes get embedded in the value.
> 
> Provide DEFAULT_FDT_FILE with the quotes stripped.
> 
> This is a similar work-around to the one provided in commit
> d085e692c98d0d7b57cc577ed9befda159cd4a40 for
> CONFIG_DEFAULT_DEVICE_TREE.
> 
> [...]

Applied to u-boot/next, thanks!

[1/2] env: Provide another work-around for unquoting fdtfile
      commit: b3087d21f022e29678e396b425e4a78ff7cf0912
[2/2] board: sifive: unmatched: set fdtfile with unquoted variable.
      commit: 03d2d5fc003f355515e202c14aee8cc543b730e4
-- 
Tom


