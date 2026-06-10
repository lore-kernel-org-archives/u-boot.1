Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8983FCD98C5
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 20:45:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B097984971;
	Wed, 10 Jun 2026 22:45:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ad+Q6g6x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF51F84935; Wed, 10 Jun 2026 22:45:16 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C60888495B
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 22:45:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-43d3031a750so3987963fac.2
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 13:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781124313; x=1781729113; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7Wh4BLiYud47r4mgTNDJ7JNRuRaUHB3WllICEWaaa9Y=;
 b=Ad+Q6g6x2EySZ3VtikeGoHt+T56H9ifAYm3bnDmdxoqMZfkAjEeQM9zvdseXA0q34w
 HS6OFL9FUH2P2UbiHv19OdkhRo1FOxq+Q3+GmQDojch/7K0QIa+LJnuiGk6fIAHuSumC
 OTr5pa6OoVS/YvnpK4CWC1+jDSoZ5pTpu3tH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781124313; x=1781729113;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7Wh4BLiYud47r4mgTNDJ7JNRuRaUHB3WllICEWaaa9Y=;
 b=B9lma1z2pdu+zsdEBoMn+AfRLVSCpaJAkJkXbWUQ4c7ZBJpAQ/LJoRl/t1qh556i9K
 jytqOvJqhmkMKMOwnVQkasqa+QhkzVqahGlTM4BGiHoikWpApfW2cl6pRJMp6D+oJx0d
 1e4hsgOAU/4zJ+Ly8tfJFAccn3+0HBH8emAymYiUmVPUTJWItwecshARiB5NY7YfA8oz
 vt2OhSWuoEXdIBka/LVZLKSBNixFAG7YPB7AoIqw+2qlZ2KfV6gmtaAxK3aAPFwX6yRu
 TNgUjV3fSK7aw0lGrf51ZFuHoc6hwgpctN0gDIO0NU9wP7YjiBls0hj8r/y90AO9O+0Y
 NsCg==
X-Gm-Message-State: AOJu0YwtoIMOl4fy15Jq+5qQLgaqGlrfdU/QHrU5TejFKfwB2zjyQgyp
 OIHL74MYALji0RAsM+93J3O8GVwS51s+tx19D1hG5E+OyHBScCFBhkiijzjsn5e+9UFFDY8kt9C
 7+MJKc4w=
X-Gm-Gg: Acq92OEh3JcWSlucc357kgcwcNTn9KO4xitOW7qxo6zsCqyxN0zeZ9U3pYVmSMXdD9r
 9wT4T+Xjb7fRhSvbFi7hFhtYpHkNpmu0VMwhGWN5az2eEtQaWn/HbDjmnn05QTB5EXLaigZozUX
 M7nQtedLHbHxYIslJCDcL3eXTe3lF9q8391z/7ooCR9vLVwZBZVIk2EEACiLvfLP5e2OxSj7p0R
 mkX8oguyC8+HWyX1KoG6xm3vwVVf9COuPlN8enkiPzMY1ntuzg6Li7Gla/74mrnVQlbhzuVCRQr
 ZEBCVH6aGVv60RHdrEIzjonY/Te62P54shxHxJ6SghKtqpHC/OXeWtP4qxBjkPlcBdNo6P1ApPX
 eC1oKHYY4KqDc+4RXnDVkH5/b3Av5AJlzpYm9kLUx3Sug07M8vEwfmnJ986gyf/Or9r7po+9N9v
 iQk1zWqThaWV6atZm95CLil17p9ELotSPCKYTgJkM7nbILVm/666NA8VemORlz2dkoFos77lcKd
 /XkxahG4MiMTJJngXG+GS1pQWxzX4D9eQHPXhmq7Mg4Fe08iss20XdWaw==
X-Received: by 2002:a05:6870:b50d:b0:43b:8eba:7d92 with SMTP id
 586e51a60fabf-4413d32eb92mr17129703fac.4.1781124313488; 
 Wed, 10 Jun 2026 13:45:13 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-245.totalplay.net.
 [189.203.97.245]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-440d8448e3csm21970194fac.13.2026.06.10.13.45.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 13:45:13 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20260610150556.20064-1-kever.yang@rock-chips.com>
References: <20260610150556.20064-1-kever.yang@rock-chips.com>
Subject: Re: Pull request: u-boot-rockchip-20260610
Message-Id: <178112431275.303511.16924748819017079706.b4-ty@konsulko.com>
Date: Wed, 10 Jun 2026 14:45:12 -0600
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

On Wed, 10 Jun 2026 23:05:56 +0800, Kever Yang wrote:

> Please pull the updates for rockchip platform:
> - New Board support: rk3588 FriendlyElec NanoPi R76S;
> - UFS boot from SPL for rk3576 (NanoPi M5, ROCK 4D);
> - Clock support for RK3576 GMAC 25MHz output and RK3528/RK3576 USB3 OTG;
> - Switch rk3128/rk3229 boards to upstream devicetree;
> - MAINTAINERS update for upstream devicetree references;
> - rk3588-rock-5b: Remove USB-C controller from u-boot.dtsi;
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


