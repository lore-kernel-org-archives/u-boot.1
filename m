Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B14AAFC6185
	for <u-boot@archiver.kernel.org>; Sat,  3 Jan 2026 18:40:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F071483AB7;
	Sat,  3 Jan 2026 19:40:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=posteo.net header.i=@posteo.net header.b="B93rDuWw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C455083B07; Sat,  3 Jan 2026 19:40:50 +0100 (CET)
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 731F580077
 for <u-boot@lists.denx.de>; Sat,  3 Jan 2026 19:40:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j.ne@posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
 by mout01.posteo.de (Postfix) with ESMTPS id 20CCF240027
 for <u-boot@lists.denx.de>; Sat,  3 Jan 2026 19:40:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
 t=1767465648; bh=RvbuSiOdjpOXUYGcWo+gDCLkaR5z6wSoo9EKGuI4TBI=;
 h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
 Content-Disposition:Content-Transfer-Encoding:From;
 b=B93rDuWwLDe1r9EJWEBF9j1lKJsd0S0gs/yUg+wyCt5ymBjQKsxIpiCrWtKI3kqDs
 B6QebAPJvWrk8cYjny+uJOnjZh5weSXBmbFGDEZUj+EnQGGjR4EQ1jqsCCLop7tjDd
 2vUzmHXUnYEyZVBe9YFX7oy4wZllQnMz9+9Q8dhQeHMPYhvrkCBXYuiRE6MF6sJcj1
 dbR5WyS3gtQdUfa6XBzsatw9vnzNvvQ61WLso+wMUq6PV988I958CQmr0pTeYjxrks
 aAqzASjgAbzec7VnLN57mwcKQF2NpEgO5i5Of6tio2xFovWkENbsj5ZjLukqthzAeO
 lx0IqdCgCMi/w==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4dk8Wy70Fpz6twp;
 Sat,  3 Jan 2026 19:40:46 +0100 (CET)
Date: Sat, 03 Jan 2026 18:40:47 +0000
From: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: j.ne@posteo.net, u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Peter Geis <pgwipeout@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Junhui Liu <junhui.liu@pigmoral.tech>
Subject: Re: [PATCH next] board: amediatech: Add X96Q support
Message-ID: <aVlirgD9gWR9srwp@probook>
References: <20251231-x96q-v1-1-316d703b8f03@posteo.net>
 <aVlTJPeB5HmvmerJ@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aVlTJPeB5HmvmerJ@google.com>
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

On Sun, Jan 04, 2026 at 01:34:28AM +0800, Kuan-Wei Chiu wrote:
> Hi J.,
> 
> On Wed, Dec 31, 2025 at 08:45:03PM +0100, J. Neuschäfer via B4 Relay wrote:
> > From: "J. Neuschäfer" <j.ne@posteo.net>
> > 
> > The X96Q is a set-top box with an H313 SoC, AXP305 PMIC, 1 or 2 GiB RAM,
> > 8 or 16 GiB eMMC flash, 2x USB A, Micro-SD, HDMI, Ethernet, audio/video
> > output, and infrared input.
> > 
> >   https://x96mini.com/products/x96q-tv-box-android-10-set-top-box
> > 
> > This commit adds a defconfig and some documentation. The devicetree is
> > already in dts/upstream.
> > 
> > The CONFIG_DRAM_SUNXI_* settings are chosen such that the register
> > values in the DRAM PHY's MMIO space are as close as possible to those
> > observed when booting with the preinstalled vendor U-Boot.
> > 
> > ---
> 
> Please remove the --- separator above the Signed-off-by tag. git am
> treats everything after the first --- as comments, which will cause
> your sign-off to be stripped from the final commit message.

Yes - I forgot to add the S-o-b manually, and b4 added it under the line
automatically. I will stick to the proper format in v2.

Thanks
