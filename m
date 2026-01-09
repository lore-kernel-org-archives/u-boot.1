Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B69C8D232E4
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 05:59:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3206B84158;
	Fri,  9 Jan 2026 06:59:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="TOnU9fhM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A35CB8415D; Fri,  9 Jan 2026 06:59:33 +0100 (CET)
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com
 [136.143.188.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 986ED84150
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 06:59:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1767938363; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Zir6ae4raJWhiSJg0Yvk47EZNQPspHks7nE+HylXhlJYr+XdpDJKVEj8hKLBCx7UYto8nKyyPl3P/3Dd3rRRxFjYzuR+gXu/XUkTDEzpLB3acW8BdshsYMBgos/sxUwNatYP7R0Fb0HLmv+iE+GP5XM3dK13k4NnvDpvyrBfISw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1767938363;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=2YYmRTFMRVjLGRJ+CsSrpPariConGm9vw6YwKrOiCZk=; 
 b=P8WxoYI8bFzMd4tHtTCVUEVKmpJZitT758LoTXbW5nWcLCHZiXlZ6pA1J0J34eJn8UvP5n7sl5rsKz2QJIvb17N21lKK8dxXKlFtFhXuNC8XeEQ1RiwG13Unj8KFyKgENiw1JFA2iyWwYaVHNJhuBGg11twK+xjxMG5KVZIezh8=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1767938363; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=2YYmRTFMRVjLGRJ+CsSrpPariConGm9vw6YwKrOiCZk=;
 b=TOnU9fhMNb8jGoosgsm57+N/TPhFSDIa7O6ruwPjlX77KF26sUJkRZDEUJvQJGin
 5yF995FJDDKl9y+uJQLFIrydv41UP2QTBIFBbp2KVP0+psMRgqBNykzJ49UlWB+2tFu
 jr88c3QvdYPd57CUMFCfYbHawHZvmxp4Tpzb5NAk=
Received: by mx.zohomail.com with SMTPS id 1767938361412251.47554907439996;
 Thu, 8 Jan 2026 21:59:21 -0800 (PST)
Date: Fri, 9 Jan 2026 05:59:11 +0000
From: Yao Zi <me@ziyao.cc>
To: Jonas Karlman <jonas@kwiboo.se>, Yao Zi <ziyao@disroot.org>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH 2/2] board: rockchip: Add FriendlyElec NanoPi Zero2
Message-ID: <aWCZLw6ROLDRX6M0@pie>
References: <20251019052607.61702-1-ziyao@disroot.org>
 <20251019052607.61702-3-ziyao@disroot.org>
 <55af1d20-4dd0-4b77-8cab-035921c405a0@kwiboo.se>
 <aPWeJiP1gnrR0Px2@pie>
 <f8b616ca-7930-4125-bbd8-6e3b96403651@kwiboo.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8b616ca-7930-4125-bbd8-6e3b96403651@kwiboo.se>
X-ZohoMailClient: External
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

On Fri, Jan 09, 2026 at 02:26:25AM +0100, Jonas Karlman wrote:
> Hi Yao Zi,
> 
> On 10/20/2025 4:27 AM, Yao Zi wrote:
> > On Sun, Oct 19, 2025 at 12:52:17PM +0200, Jonas Karlman wrote:
> >> Hi Yao Zi,
> >>
> >> On 10/19/2025 7:26 AM, Yao Zi wrote:
> >>> FriendlElec NanoPi Zero2 is a super-tiny development board based on
> >>> RK3528A SoC. Add board-level configuration and U-Boot-specific
> >>> devicetree piece for it.
> >>>
> >>> Signed-off-by: Yao Zi <ziyao@disroot.org>
> >>> ---
> >>>  arch/arm/dts/rk3528-nanopi-zero2-u-boot.dtsi | 11 +++++
> >>>  arch/arm/mach-rockchip/rk3528/MAINTAINERS    |  6 +++
> >>>  configs/nanopi-zero2_defconfig               | 46 ++++++++++++++++++++
> >>>  doc/board/rockchip/rockchip.rst              |  1 +
> >>>  4 files changed, 64 insertions(+)
> >>>  create mode 100644 arch/arm/dts/rk3528-nanopi-zero2-u-boot.dtsi
> >>>  create mode 100644 configs/nanopi-zero2_defconfig

...

> >> With above adjustments this closely matches the defconfig I have been
> >> carrying in my rk3528 branch at [1] a few months.
> >>
> >> So with above fixed this is:
> >>
> >> Reviewed-by: Jonas Karlman <jonas@kwiboo.se>
> > 
> > Thanks, these changes are all reasonable and I'll adapt them in v2.
> > Seems I did something wrong when doing savedefconfig and lost some
> > defconfig changes...
> 
> Are you planing on sending out a v2 of this?
> 
> I still carry my old version of this in my rk3528 branch, see [2], I
> can send that commit out if you do not have time to send a v2?

Sure, please go ahead and send yours instead, thanks. Sorry for the huge
delay.

> Btw, I should be able to send out a new revision of the Linux RK3528 USB
> series any day now, once I have completed re-testing.
> 
> [2] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commit/e3f251b7828ddc09f0bc1c2240687c5ad22a40df
> 
> Regards,
> Jonas

Regards,
Yao Zi

> > 
> >> [1] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commits/rk3528
> >>
> >> I plan to send out a series with the ROCK-2 and Sige1 board additions shortly.
> >>
> >> Regards,
> >> Jonas
> > 
> > Best regards,
> > Yao Zi
> 
