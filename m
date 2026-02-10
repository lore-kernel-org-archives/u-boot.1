Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D83B8EA3F36
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 10:35:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1295D8388D;
	Tue, 10 Feb 2026 11:35:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="u/CTnL2+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A4D383CB5; Tue, 10 Feb 2026 11:35:08 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB5268341A
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 11:35:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id B22911F822;
 Tue, 10 Feb 2026 11:35:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1770719703;
 bh=KvxnKYi8i8GhIV2IRRBW4lq3et0/Hp605H0Cm7D5Qeo=; h=From:To:Subject;
 b=u/CTnL2+msQtrS/os/+Hwvp0YKmxz5QOGQzicWNb03TGiiTK2ds2ibEcLV4OIow/c
 xCYr+1moQrQtP8J9GXrRtETbIVG+DDFfszm4Ifw4D3cxc2VtfhaBCK1qcGbx7ed0Z2
 XJtW1h2ZvN0807JlWSyxrg1D6yIV0J4pW/CiBwGgAT34lLRx+dRvgL0iea7isCF7js
 Ank22o3ykPPHuQPOdQyT6Pa1Oa5PhuJ+hkJirFEF7/pzrl4WSC+kfYidP3+Y3GlTCH
 1tf76YnJjTxoESkA8D3iN41BlVoeo0IgqYbdEbVhiQPGpjKfP+a0pQssgeuxyGz5KN
 Yss7G1i06GeHw==
Date: Tue, 10 Feb 2026 11:34:59 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Wadim Egorov <w.egorov@phytec.de>
Cc: Suhaas Joshi <s-joshi@ti.com>, Tom Rini <trini@konsulko.com>,
 Francesco Dolcini <francesco@dolcini.it>,
 Anshul Dalal <anshuld@ti.com>, Bryan Brattlof <bb@ti.com>,
 u-boot@lists.denx.de, vigneshr@ti.com, n-francis@ti.com,
 s-tripathi1@ti.com, k-malarvizhi@ti.com, kamlesh@ti.com,
 vishalm@ti.com, d.schultz@phytec.de, ggiordano@phytec.com
Subject: Re: [REGRESSION] Verdin AM62/62P not booting with 42b3ee7fa524
Message-ID: <20260210103459.GA214446@francesco-nb>
References: <20260209084529.GA12200@francesco-nb>
 <20260209100851.abaf46pr77uq46zi@ula0507357>
 <20260209101635.GA28492@francesco-nb>
 <20260209172546.GA281089@francesco-nb>
 <20260209174308.GG2603314@bill-the-cat>
 <20260209180726.GB281089@francesco-nb>
 <20260209181307.GH2603314@bill-the-cat>
 <20260210092646.w5bugrscifmsh5px@ula0507357>
 <4803a086-700b-462f-ae36-2fd55e9dcac2@phytec.de>
 <4338d5e8-ea88-4f9c-9edf-65b07b725324@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4338d5e8-ea88-4f9c-9edf-65b07b725324@phytec.de>
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

On Tue, Feb 10, 2026 at 05:22:13PM +0700, Wadim Egorov wrote:
> 
> 
> On 2/10/26 5:02 PM, Wadim Egorov wrote:
> > 
> > 
> > On 2/10/26 4:26 PM, Suhaas Joshi wrote:
> > > On 12:13-20260209, Tom Rini wrote:
> > > > On Mon, Feb 09, 2026 at 07:07:26PM +0100, Francesco Dolcini wrote:
> > > > > On Mon, Feb 09, 2026 at 11:43:08AM -0600, Tom Rini wrote:
> > > > > > On Mon, Feb 09, 2026 at 06:25:46PM +0100, Francesco Dolcini wrote:
> > > > > > > On Mon, Feb 09, 2026 at 11:16:35AM +0100, Francesco Dolcini wrote:
> > > > > > > > On Mon, Feb 09, 2026 at 03:38:51PM +0530, Suhaas Joshi wrote:
> > > > > > > > > On 09:45-20260209, Francesco Dolcini wrote:
> > > > > > > > > > + Bryan, Anshul
> > > > > > > > > > 
> > > > > > > > > > On Mon, Feb 09, 2026 at 09:38:55AM +0100, Francesco Dolcini wrote:
> > > > > > > > > > > Verdin AM62 and AM62P are not
> > > > > > > > > > > booting anymore with U-Boot
> > > > > > > > > > > 42b3ee7fa524,
> > > > > > > > > > > everything was fine with b5213bbfdcb1.
> > > > > > > > > > > 
> > > > > > > > > > > Looking at the commits between the
> > > > > > > > > > > two revision, I would say that the
> > > > > > > > > > > issue is with this series
> > > > > > > > > > > https://lore.kernel.org/
> > > > > > > > > > > all/20260127081652.506357-1-s-joshi@ti.com/
> > > > > > > > > > 
> > > > > > > > > > We have also commit 3382d75f7a6c ("arch:
> > > > > > > > > > arm: dts: k3: refactor common
> > > > > > > > > > nodes to k3-*-r5.dtsi") that might be
> > > > > > > > > > the root cause for this issue.
...

> > > This series is confirmed to be working on TI boards. I just tested it
> > > (again) on AM62 SK. See [0] for logs.
> > > Verdin boards are the only ones that are reporting this issue. Is it
> > > alright if we revert only the two Verdin-specific commits, and let the
> > > rest (TI and PhyCore ones) stay as they are? The patches are pretty
> > > un-connected to each other.
> > 
> > I have not tested the patches on the phycore-soms yet.
> 
> The phycore-am62x boots, see the logs
> 
> https://pastebin.ubuntu.com/p/P3GHhZw8xc/plain/
> 
> But I can also see this new error
> 
>   Failed to set clock rates for '/a53@0': -61

Yes, this is also new on verdin am62. It seems unrelated, and it should
be also be fixed / investigated.

Francesco

