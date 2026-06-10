Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F16CECD98C7
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 20:45:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7120484957;
	Wed, 10 Jun 2026 22:45:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DxXIjzzp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C1B984970; Wed, 10 Jun 2026 22:45:16 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 036F484935
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 22:45:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-4863cd278d7so4541358b6e.1
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 13:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781124313; x=1781729113; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ecZxa0Xi/EFrLmq9ciL1rjK+G6D1sQvbCOeQOqxEIpE=;
 b=DxXIjzzpHGwXfJTTq/w2lre87cRgBTHC9Y3xftLwuu148J4LgDxqiTy4Rn4K0byubn
 pnwD7cFmHDZWXsQpTSYJT/aZpqC6QuvUgnPtBADfMWJwtLAALEaPd2830cAloCDb9OZr
 L2caRVFJWBvlrrw4LrhXAtdrQRWAHu3PFQiN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781124313; x=1781729113;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ecZxa0Xi/EFrLmq9ciL1rjK+G6D1sQvbCOeQOqxEIpE=;
 b=AKd9PS/Zl6kOKCy4GFp8cFeH1y1HSPnzOcgYFFA+ykXkNBFUrwSi3JhGlH7ykpi61d
 DfPNssOACxPjDU8XSgUOTZckIPdMh10qVMqw2a4FyAe3oJZVe4GpLpxTlor6CsU/dD52
 RJcz8lQpdGEMzWw8DAZMsbf0Qno5xrye/3/3jSWgLxqCD78fc0SZPWHHv6fV10ly6a93
 wfK75ra4C4HtW9hRTCg1b5u62FIr0Cmop2tVCTHZ32/pLrrV5PxJXT7/43fAG6YNEY28
 0NiRm4D6giXpfJNxI8X6BT3EVOdpfhGK7THxyAYpT/0nA5kry5DfJM7BigU0yF14Dr/G
 24Fg==
X-Gm-Message-State: AOJu0Yy68/s26J8RPBE/ZekPfdj0+krCD3Xf5BFDzSAKMurPoHTcny2j
 a55q5J0O9dmkLDfJX29oa2xoe5sQtTyOkh3R0aL10X/DaGvchFWzIiEupC+vnKoec98=
X-Gm-Gg: Acq92OHk/So2e3dhTBr68hbIXz2lNTwRCtKvz5EY4q664hS7H9v1VI5t0UPgHXZ08yR
 F22CEyVEvhRHPTRbzKMvNPVTvYZARtlPs8O54VVBuWlz3lEz4uGK+voPMCicsywjMicjLK3Q84O
 mpaHdf8LQgoN2q6cjvSixdBgfzPSlROMaLuK/cdsqY466FbuA6iCZ5u0BWjWPVp7lONk8w3FG1D
 MGH/elbCRfLZXWLs5J0jGCUPyHHZiZIdSj/pYj+upIT+Ea+c1R/mYREig2oyhEZSONR5sthjZV5
 WmWUzJnfrfr+NcvdzayhyPX3fmuj4L3UtyLylzdE80OYU/8C23kBtXfDwUNwdrHeD+1N4+w611E
 A7f+FBMoIneMTER+J6N3+il60QIiOMG5gkWqyuvT0E2HqO+iXINxFR6Ym7k6Ec2YEJDiswmfRfv
 2VikMV5KdUNznX3jFVeM6511upvB2YelxBgVrrPjuIRBbKvWzsd26Ctb9dG11PTdR2HapbMGbOh
 WdnrJa3epN0zHB7v025QMtb6Gf/epF99f1iXx27Wyg/qBXwTFam3le7Aw==
X-Received: by 2002:a05:6808:1a19:b0:486:4bd0:9a18 with SMTP id
 5614622812f47-4868dfb0c20mr16075709b6e.40.1781124312638; 
 Wed, 10 Jun 2026 13:45:12 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-245.totalplay.net.
 [189.203.97.245]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-440d8448e3csm21970194fac.13.2026.06.10.13.45.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 13:45:12 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: Sumit Garg <sumit.garg@kernel.org>, neil.armstrong@linaro.org, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Federico Amedeo Izzo <federico@izzo.pro>, 
 Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>, 
 Petr Hodina <petr.hodina@protonmail.com>, Sam Day <me@samcday.com>
In-Reply-To: <20260610113844.3715979-1-casey.connolly@linaro.org>
References: <20260610113844.3715979-1-casey.connolly@linaro.org>
Subject: Re: [PULL] Please pull qcom-main
Message-Id: <178112431129.303511.6623975794347435350.b4-ty@konsulko.com>
Date: Wed, 10 Jun 2026 14:45:11 -0600
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

On Wed, 10 Jun 2026 13:36:28 +0200, Casey Connolly wrote:

> A few Qualcomm fixes for 2026.07
> 
> * Define memory map for lemans-evk (pending SMEM)
> * Fix CONFIG_SYS_INIT_SP_BSS_OFFSET in db410c chainloaded fragment
> * Fix the "dump bootargs" command in the qcom-phone boot menu
> * Fix a bug in the rpmh-regulator driver where the regulator mode may
>   not be set during enable.
> * Enable watchdog autostart for Dragonwing boards
> * Fix serial console init on ipq5424-rdp466
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


