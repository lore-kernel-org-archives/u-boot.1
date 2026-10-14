Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E78CC6B2D
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 21:28:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C265C407CA;
	Wed, 14 Oct 2026 21:28:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E1_LHX1_HNPz; Wed, 14 Oct 2026 21:28:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 083894077B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792013322;
	b=VZQLk5cLCicnqZ+Lbagx+0kXccBS0rsC/m3Fc4xWg5vK7WxmOO5OBYlkkufAnURWudsF
	 Vt7K2nN1bf+AIRj3kVxbFfdcQOgZ0pLyy+wslMZxUIGfnUyJurdmlMCUvcAaU4ZmQ30lK
	 vOm4MI3kvGRSb7g89et+cFGbhhF73XQu0PAWgoGVR/RhBrwHRPKrRMK5B7dKMfbsjxX1+
	 jOh5G4COmmcHu3c9PdbYDVUq1NMbaj/nj1CUYU+Rov+J6n6ptiE8cpTOCe6vrobsU6exF
	 DScGUxXl84ZzdhTW3KTy8M5xGRqdh2AjqAFXJbedVj+VCZjGAOJaW8t2jEbncehr99w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792013322;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=cCS1enX7eFfV77Gs0kIzXAmJhrAmty5Ii2VbyPmT6io=;
	b=UtUGZUWuBZJrZMRbo2XzVG760U2cebKjFmrgvUB4w8GNhD57wH85eeCizo08UL4e/EzC
	 fXbiW2qy1Nt/Vy9Nz1kHs+Ls4CIb7o64Bo2lqHIcrvDjT+8cHZUN5UVWzSn73GtW1Qem2
	 FmGRTMDbpMDvAgNA3ILupzohIsn7MsECP82aXUC5nsC+oxL2zVjZmdoR0bhgYUL7ejz+v
	 w2xVazIlENnMdiKTDj3/dU0VaFpYcbeJs8SumwgrnFW4I30juxQl7PwLQBALZEe7whqIT
	 /p7VHITdcAy+YOgHYlgUwCspN67JhwLsneQpVRJhCB+WcdF5PlsApoQYZnv5mXpK7sg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792013322;
	bh=cCS1enX7eFfV77Gs0kIzXAmJhrAmty5Ii2VbyPmT6io=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nCDlXUnG+iPIeQM251P3MIUDi8SIo1oIPg4tnXVziR033jZ8VeQl77y0hpK7J9QMI
	 1R7SsDmidWPuPABhhjC7xumHnIftQ9pF7JnFw3QqlT1DyIhm2A0rjydspdjWcQSYk1
	 b3tsMgDQNc4EBAp314XPali4BRtDm/UoaexnjuOg7J2OPHpenWmycGNlLGjAoCMc6z
	 xNLmPqT1qArWvVjPv8annFhG/CD4qN7mbkgLbkZCspqqLx+VRuVhqilThTnMsVOU4O
	 s0sf8uxK15/gzH9qHmnJQYcLmZ6chLGLvav5r+ni1WtmmPVWbZ4DjaRrMpmht3rCs2
	 GxxINrQ388MHQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 083894077B;
	Wed, 14 Oct 2026 21:28:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5462AA58
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 21:28:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3A4526077F
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 21:28:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3dytFjklo9Hr for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 21:28:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8C4E260681
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792013319;
 b=Qf0DvXI9ANt3S10ZSNK6YiC/d5FgcGMwlh5octoNIHuNrwHD7bvyf1wJZTGNQLWhgrU4
 skkLuhTXqlpyUgFAphbt6I8LcbMOeBzx/cS2BHMdf6j1hS5PhqS+XZnHYHSdPASugDXnX
 JuLbTIcO45Fs0BBpHbSi9TPiMNLi6M0tcIVb44C8oF5KnJc/3kjpljocQxoVd82y9c21u
 cx16vb44UKztcY9Rpg/hj3AVeKMjYNX8IqLqjQCwF/pxLx6bFl2rJjkMptbcCsH75cF4W
 nhYa3u+qhSHnV7ApIMQX8Iwve965yxVuqiPp1095OTxej1W++1qSFC5vQ0qCjwm5c9Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792013319;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=cCS1enX7eFfV77Gs0kIzXAmJhrAmty5Ii2VbyPmT6io=;
 b=Fkw8PWhoN8T8oDC8uGoJpnX9ChE7LyWjPnXqGhiYGPiAyTRPMRbBVkfCaak2Q64dRtox
 M4YlCadOaOhWB3SVDEU3pIsXdrUwxTGCjxvGIqG9hwC26P0hHAqZi6lA9mNeeyBnpesJh
 rrhvG0zlOffMfvN9TnXQvjFi2zLfUm+23VSLTiVwwh8UBf0pnqt+X1AWQK8+CYvvOGyV5
 KvPJ+ymMouwkZEJbqJW6zpb3XG95EYb6LsuWFYMrYIJJWbqm7eTv/FLw5eF5WsNaChk47
 hvghXba8Kjvil5fyAQPawrF0x7o29gES9PcJpG3xA+Sm0UAMlg3VR1YrhZnSmMg2Vhg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=nfc5ELSL; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=nfc5ELSL
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8C4E260681
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 21:28:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0200043F94;
 Wed, 14 Oct 2026 21:28:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 666BF1F000C4;
 Wed, 14 Oct 2026 21:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792013317;
 bh=cCS1enX7eFfV77Gs0kIzXAmJhrAmty5Ii2VbyPmT6io=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=nfc5ELSLAQO32xwJqVmengz2MP2JBH2RPyo6G2F17AQC/xC08xLzHckEqpjhAIzxv
 C5NfW1bzc2cF7L8B0+xi60IbK7k/3R52QC2TtNNpBupwxiBfD0bO3jSs1YCV4bmF5V
 1EAOe/F71FqEBLBxTRLX+naaFYTyyqHPFEzHmXIMtP2k44sKblM5jqNvOY7aU4aGNh
 eoIL8ZvaVLp+lCB8Jly/w7HTgf9DL6ZxyWrdNENxPqSHcfAqc1pZ74MKwaHhMe/4pT
 e57+lGOzYDeySlLiuc24lX6Uov0UeKfA7q9CWUQiYO8rTC1Ym3fLTDaBRXJji/Bdvn
 qGQ3U/yShvATA==
Date: Wed, 14 Oct 2026 21:28:35 +0000
From: Yixun Lan <dlan@kernel.org>
To: Dave Klotz <DaveWK225@protonmail.com>
Cc: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>,
 Zixian Zeng <sycamoremoon376@gmail.com>,
 Eric Chung <eric.chung@riscstar.com>, Peng Fan <peng.fan@nxp.com>,
 u-boot@lists.u-boot-project.org, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, u-boot-spacemit@groups.io,
 Anand Moon <linux.amoon@gmail.com>,
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>,
 Tanmay Kathpalia <tanmay.kathpalia@gmail.com>
Subject: Re: [PATCH v2 2/3] mmc: k1: let the SPL read SD cards more than one
 block at a time
Message-ID: <20261014212835-GKM26088@kernel.org>
References: <20261005T134748-0400.mmc-v2-cover.DaveWK225@protonmail.com>
 <20261005T135733-0400.mmc-v2-0002.DaveWK225@protonmail.com>
 <a57e47d3-fe8c-44dc-8afe-2c256ed49d71@gmail.com>
 <2ef42a4d-ee32-4650-819b-ea6d042bdad5@altera.com>
 <c02f3812-e549-4f4a-9fc8-77da7ed6b883@altera.com>
 <8a263ad7-5cf5-46f4-87a1-43e898a1d15a@gmail.com>
 <6f00fd89-d418-4d64-a066-c893dff89994@altera.com>
 <1f734cd0-cd75-4b0e-93ec-490ecfbb1ab0@gmail.com>
 <b34530c2-2a90-4cca-94ae-207e503188ee@altera.com>
 <20261014T154006-0400.uboot-k1-mmc-v2-handoff.DaveWK225@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261014T154006-0400.uboot-k1-mmc-v2-handoff.DaveWK225@protonmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Kathpalia, Dave,

On 19:59 Wed 14 Oct     , Dave Klotz wrote:
> On 12-10-2026 19:30, Kathpalia, Tanmay wrote:
> > Dave, I hope you are aligned with the changes discussed and tested.
> > Could you please post a new version incorporating them?
> 
> Hi Tanmay,
> 
> Sorry for the slow reply. I'm moving my K1 boards to a different boot
> chain, oreboot plus EDK2, so I won't be respinning this series. Thanks
> to you, Zixian, Yixun and Anand for the testing and the careful review.
> 
> Where things stand, for whoever picks it up:
> 
> - 1/3: Yixun suggested a sane default max-frequency when the DT has
I changed my mind of the idea to set a default in driver code level..

>   none, rather than trusting what an earlier stage left behind, and
Still don't like "what an earlier stage left", and expect to avoid

>   asked for a clearer explanation than "happens to return 0".
>   Hung-Chun's RFC, "[RFC PATCH 0/2] mmc: k1: do not require
>   max-frequency in the device tree", covers the same ground.
> 
Spent a few more time looking into this, and to understand the idea
of why setting max-frequency, turn out its goal is trying to set a
particular clock parent/frequency for the io clock.

I'd suggest we try to see if able to go with setting DT property,
 assigned-clock-parents or assigned-clock-rates
the advantage is it will also work on Linux kernel side

I've actually tested assigned-clock-rates on kernel, it worked well

If above idea is doable, then I'd suggest to drop patch 1/3 for now,
"mmc: k1: handle a missing max-frequency and clk_set_rate()'s return value"
leave the driver as current state which will keep using "max-frequency",
and I'm fine with new boards added still using "max-frequency" before
new solution landed, as it will take longer time..

BTW, the optimal emmc io clock for K1 is 375MHz(parent pll2_d8),
setting to 204.8MHz may work but runs in lower speed.
while for SD card, it's 204.8MHz(parent pll1_d6_409p6).

-- 
Yixun Lan (dlan)
