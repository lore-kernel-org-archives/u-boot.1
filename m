Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8A74E7E0BC
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 18:07:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A50883C5E;
	Mon,  9 Feb 2026 19:07:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="MnuOAM5x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05B038397D; Mon,  9 Feb 2026 19:07:31 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB9B1805D7
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 19:07:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 6EA011FE29;
 Mon,  9 Feb 2026 19:07:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1770660447;
 bh=Kudp5ar6xso0pKxr7kYUyrXFfkP9fWAjOYWnfHKzqfU=; h=From:To:Subject;
 b=MnuOAM5x8RMemsSqwxLRyeCFM/XmOAkRHXnRFu63QWrkGWyCUav3Xn39OI29s6vbc
 kgdvjd4q/dRWhLA471+TEC9Y26ufyrUmuPcwOxi+RQbQVcFLiaNXr8O6jPSc+DiMb+
 CPFFvc4Og7o200Wx+nG83ZtaVtckHeOphnzUQJ4H2zfY20HU4aC9NhXlTBBoNvm4mO
 Hhfpp8lewiVl4Wxtf7AlbLBm4WpMUyxawk58M23FAjRigQqcNR5u5WkLMe9eM1m8E5
 h+2UzQhfjm9DY3dm10SQ5iaNvSxMDeiweqos6LXev4MZ1MDWQ1Md/hiybULWVKiDtG
 x1VXPXpO39ZHw==
Date: Mon, 9 Feb 2026 19:07:26 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Tom Rini <trini@konsulko.com>, Suhaas Joshi <s-joshi@ti.com>
Cc: Francesco Dolcini <francesco@dolcini.it>, Anshul Dalal <anshuld@ti.com>,
 Bryan Brattlof <bb@ti.com>, u-boot@lists.denx.de, vigneshr@ti.com,
 n-francis@ti.com, s-tripathi1@ti.com, k-malarvizhi@ti.com,
 kamlesh@ti.com, vishalm@ti.com, d.schultz@phytec.de,
 w.egorov@phytec.de, ggiordano@phytec.com
Subject: Re: [REGRESSION] Verdin AM62/62P not booting with 42b3ee7fa524
Message-ID: <20260209180726.GB281089@francesco-nb>
References: <20260209083855.GA9367@francesco-nb>
 <20260209084529.GA12200@francesco-nb>
 <20260209100851.abaf46pr77uq46zi@ula0507357>
 <20260209101635.GA28492@francesco-nb>
 <20260209172546.GA281089@francesco-nb>
 <20260209174308.GG2603314@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209174308.GG2603314@bill-the-cat>
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

On Mon, Feb 09, 2026 at 11:43:08AM -0600, Tom Rini wrote:
> On Mon, Feb 09, 2026 at 06:25:46PM +0100, Francesco Dolcini wrote:
> > On Mon, Feb 09, 2026 at 11:16:35AM +0100, Francesco Dolcini wrote:
> > > On Mon, Feb 09, 2026 at 03:38:51PM +0530, Suhaas Joshi wrote:
> > > > On 09:45-20260209, Francesco Dolcini wrote:
> > > > > + Bryan, Anshul
> > > > > 
> > > > > On Mon, Feb 09, 2026 at 09:38:55AM +0100, Francesco Dolcini wrote:
> > > > > > Verdin AM62 and AM62P are not booting anymore with U-Boot 42b3ee7fa524,
> > > > > > everything was fine with b5213bbfdcb1.
> > > > > > 
> > > > > > Looking at the commits between the two revision, I would say that the
> > > > > > issue is with this series https://lore.kernel.org/all/20260127081652.506357-1-s-joshi@ti.com/
> > > > > 
> > > > > We have also commit 3382d75f7a6c ("arch: arm: dts: k3: refactor common
> > > > > nodes to k3-*-r5.dtsi") that might be the root cause for this issue.
> > > > > 
> > > > 
> > > > Hi Francesco. Unfortunately, I don't have Verdin line of boards with me,
> > > > so I cannot reproduce this issue. This is also why I wasn't able to test
> > > > my series on my end and had requested board-specific maintainers do the
> > > > same.
> > > > 
> > > > Since I don't have the boards, could you run the following test to help
> > > > us ascertain which of the 2 suspected commits actually broke the boot?
> > > > 
> > > > * First drop my AM625 Verdin patch, and compile and copy the binaries,
> > > >   and boot.
> > > > * Then let my patch remain in the tree, and remove Anshul's refactor
> > > >   patch, and try the same thing again.
> > > > 
> > > > This could help us ascertain which commit broke boot, and we can try
> > > > fixing from that commit.
> > > 
> > > Sure, I can bisect it. 
> > > 
> > > Do this difference in the logs
> > > 
> > > Failed to set clock rates for '/a53@0': -22
> > > 
> > >   vs
> > > 
> > > Failed to set clock rates for '/a53@0': -61
> > > 
> > > ring any bell?
> > 
> > The boot failure start with commit 2ffab9da9142 ("Merge patch series
> > "Firewall ATF and OP-TEE memory regions in Sitara"").
> > 
> > With commit 24338c81ec2f ("arm: dts: k3-binman: Use configs for
> > ATF/OPTEE addresses") the board still boots fine.
> > I have some concern that this commit is changing something, however
> > CONFIG_K3_ATF_LOAD_ADDR is 0x80000000, while before in the dtsi file it
> > was 0x70000000. I tried changing it back without any positive result,
> > I just got an EL3 exception.
> > 
> > Any more test I should do?
> 
> Should I revert that firewall series, at this point?

I did one more test.

It seems that the issue is some interaction between the firewall series
and commit 24338c81ec2f ("arm: dts: k3-binman: Use configs for ATF/OPTEE
addresses").

If I keep the firewall series in, and revert 24338c81ec2f, it boots.

IMO, unless we understand what is going on exactly, we should revert
both.

Suhaas: is current master working for you on the am62 SK or beagle play?

Francesco

