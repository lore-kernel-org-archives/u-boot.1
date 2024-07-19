Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC9FEC3DA5D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 19:21:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6062788C0C;
	Fri, 19 Jul 2024 21:21:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1721416875;
	bh=1pRw42N5WNpGR7x+H+Zfpzbh67hZZtErlFYGcGgVW3g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yy2io8YkgoOvh+eUCN1NxCPhVTYBqweep16ECjPbfmLydvxxbR3on0M9hdw1bxBKL
	 CocXR3MvTPBnmtcLtns43yxvjeN/GqOQctf6qcIG5+REpsg49Dw9rEUb56CTsEPP00
	 WQVzCCZM/O0UnlyyY3QxGT7bwSZ2AlLyOKsSoYEALfKEJXHko531btLMZLTU5sfQt6
	 qSgb+ja9RDw6n8Z3Z8ii7ZMbin3/EwD4zFyQAAgXpEl6an+v2VcrBneB2bP6saEVlq
	 Ps3WilF+8Wbbp1CQo+F2xWZXqBqPKxlruM90d/ZG/z3gftI9QFXSF7EjJmrnzYyJvZ
	 +KvDj5nU5YJTQ==
Received: from crub (p508b6272.dip0.t-ipconnect.de [80.139.98.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: agust@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 0A29188BD6;
 Fri, 19 Jul 2024 21:21:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1721416873;
 bh=1pRw42N5WNpGR7x+H+Zfpzbh67hZZtErlFYGcGgVW3g=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=tJfMTT2NecOhqLK+mUROXW3RLqvIjXfTeIPhq970vT5GYjvvjWMu4bsL5DHm46rcz
 k1ZjdIPX8Bgjvz47ukkiqhFIFNDNxJ7JkjmUMqMBJTL4bNRtV5kuIX9GKdn60U1Nz/
 WSUtzxfCoHgQkW2ChkVT84eyb5bm8Xp1yIPUP67viRAnqHi0+fEyBy8znBCtq4x2kl
 bIOLemFj1ItGdo3kHsQBD3PzXEAveBsQWgM8eT5H1qf22LQwF8Mb2UpvX0wWAzVlZA
 LXhI9DR0EvwtGFd1bC3Cin+bNPs91ayGDT3onqfKS+BM4lusApAmwqcl+LEXPkw8aD
 d9l/AptGkccuQ==
Date: Fri, 19 Jul 2024 21:20:57 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>, Heiko Schocher <hs@denx.de>, Aleksandar Gerasimovski
 <aleksandar.gerasimovski@hitachienergy.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Angelo Dureghello
 <angelo@kernel-space.org>, Bin Meng <bmeng.cn@gmail.com>, Francis Laniel
 <francis.laniel@amarulasolutions.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Rainer Boschung <rainer.boschung@hitachienergy.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Subject: Re: [PATCH 01/20] arm: Remove pg_wcom boards
Message-ID: <20240719212057.7abb380c@crub>
In-Reply-To: <20240719104612.6ecd9891@crub>
References: <20240718173611.4014274-1-sjg@chromium.org>
 <20240718173611.4014274-2-sjg@chromium.org>
 <20240719104612.6ecd9891@crub>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

Hi Simon,

On Fri, 19 Jul 2024 10:50:16 +0200
Anatolij Gustschin agust@denx.de wrote:

> Hello Simon,
> 
> On Thu, 18 Jul 2024 18:35:52 +0100
> Simon Glass sjg@chromium.org wrote:
> 
> > These board has not been converted to CONFIG_DM_I2C by the deadline:
> > 
> >    pg_wcom_expu1
> >    pg_wcom_expu1_update
> >    pg_wcom_seli8
> >    pg_wcom_seli8_update
> > 
> > Remove them.  
> 
> Please keep these boards. I got the task to do DM_I2C conversion to
> prevent board removal from mainline. Thanks.

DM_I2C conversion patch is here:

  https://patchwork.ozlabs.org/project/uboot/patch/20240719191656.3323947-1-agust@denx.de/

--
Anatolij
