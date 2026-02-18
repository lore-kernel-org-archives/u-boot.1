Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D839CE9A03B
	for <u-boot@archiver.kernel.org>; Wed, 18 Feb 2026 06:59:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2452083AA9;
	Wed, 18 Feb 2026 07:59:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="W97mCD4F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05E5E83AC5; Wed, 18 Feb 2026 07:59:24 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58C1B80050
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 07:59:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it
 [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 58FD71FAA3;
 Wed, 18 Feb 2026 07:59:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1771397960;
 bh=E78l5XwqWSl/4h9VqLo0q0gsGc6rqSqSAV2z5g/0ykk=;
 h=Received:From:To:Subject;
 b=W97mCD4FwM6YkTu+NL5ZS0rfYI86DeWJjHlGUUk7JQkg+u4yGlGWIifCXmxCOUaeM
 eheVutnxs1nWBFOrkc6UTc2NgVRhGR6GLY267OMS+mL6y4tJt1+A6IavUr+or3TpDb
 RXyyGCA+I062QRIBdqiVoknbyvR/sI8AHLslI8Suxl4TSPeuOzDc9NOm/jx0V0lKYO
 ebN+jmFdBnuhVUtGRo7CwKNWnyCdFNegUpj7XpTc4sFzSNaddiVSPkdMGEDhge1ws9
 zlz37cOjDKJ8VPuIhn26A4sJhoOyduw34et4W8YJJkc9pc/IaxGWBd2Op6r+W2jJGQ
 9A2DEB6f+gnWQ==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
 id 11E507F858; Wed, 18 Feb 2026 07:59:20 +0100 (CET)
Date: Wed, 18 Feb 2026 07:59:20 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Suhaas Joshi <s-joshi@ti.com>
Cc: Francesco Dolcini <francesco@dolcini.it>, Bryan Brattlof <bb@ti.com>,
 Anshul Dalal <anshuld@ti.com>, u-boot@lists.denx.de,
 trini@konsulko.com, vigneshr@ti.com, n-francis@ti.com,
 s-tripathi1@ti.com, k-malarvizhi@ti.com, kamlesh@ti.com,
 vishalm@ti.com, d.schultz@phytec.de, w.egorov@phytec.de,
 ggiordano@phytec.com
Subject: Re: [REGRESSION] Verdin AM62/62P not booting with 42b3ee7fa524
Message-ID: <aZVjSOzCH6ZP3CjW@gaggiata.pivistrello.it>
References: <20260210092646.w5bugrscifmsh5px@ula0507357>
 <20260209202001.saeaf6l2kz57rufg@bryanbrattlof.com>
 <20260210105014.GB214446@francesco-nb>
 <20260211101113.GA176369@francesco-nb>
 <20260211112109.56e27kyy4coqpcbb@ula0507357>
 <20260213102015.GA10715@francesco-nb>
 <20260217132150.of5l5qirxkeizsne@ula0507357>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217132150.of5l5qirxkeizsne@ula0507357>
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

On Tue, Feb 17, 2026 at 06:51:50PM +0530, Suhaas Joshi wrote:
> On 11:20-20260213, Francesco Dolcini wrote:
> > On Wed, Feb 11, 2026 at 04:51:09PM +0530, Suhaas Joshi wrote:
> > > On 11:11-20260211, Francesco Dolcini wrote:
> > > > On Tue, Feb 10, 2026 at 11:50:14AM +0100, Francesco Dolcini wrote:
> > > > > On Mon, Feb 09, 2026 at 02:20:01PM -0600, Bryan Brattlof wrote:
> > > > > > Do you mind copying a boot log to a pastebin for me? I thought I had one 
> > > > > > of these boards but I'm still digging around for it. 0x80000000 should 
> > > > > > be where we load TFA now days unless some boards have opted out of 
> > > > > > letting U-Boot move it to the bottom of DRAM
> > > > > 
> > > > > Here some more logs
> > > > > 
> > > > > https://gist.github.com/dolcini/aa4b669c6349cc6da1b9e7b19cf53fed
> > > > > 
> > > > > The files are named with the commit sha that is tested.
> > > > > 
> > > > > On Tue, Feb 10, 2026 at 02:56:46PM +0530, Suhaas Joshi wrote:
> > > > > > Verdin boards are the only ones that are reporting this issue. Is it
> > > > > > alright if we revert only the two Verdin-specific commits, and let the
> > > > > > rest (TI and PhyCore ones) stay as they are? The patches are pretty
> > > > > > un-connected to each other.
> > > > > 
> > > > > Verdin AM62 should not have anything special, the code is all there for
> > > > > everyone to see, including the defconfig, the DT and so on, and the changes
> > > > > we are talking about to me are self contained withing the SoC. Something
> > > > > is wrong, and we are not understanding what yet.
> > > > > 
> > > > > I just retested once more 42b3ee7fa524 and it just hung, you never know
> > > > > if I did something wrong. And for what matter this was spotted by our
> > > > > CI.
> > > > > 
> > > > > > We are working on figuring out why Verdin is seeing these issues, in the
> > > > > > meantime.
> > > > > 
> > > > > Anything I can do let me know.
> > > > > 
> > > > > If it matter the board that I am currently testing has 1GiB DDR RAM, and
> > > > > the SoC is a AM6252ATCGHAALW. 
> > > > 
> > > > I was able to trace the issue to the get_ram_size() in
> > > > verdin-am62.c:dram_init().
> > > > 
> > > > That function walks the addressable memory range to dynamically detect
> > > > how much memory is available.
> > > > 
> > > > Not sure on the proper way to fix it however, Bryan? Suhaas?
> > > 
> > > Yes, this does seem to be the issue, even in my digging. I have sent a
> > > patch to fix this. But since I don't have boards, I have not tested
> > > this. Could you please test this and let us know if it works, or if
> > > there are any other issues that pop up?
> > 
> > With commit f9ffeec4bdcf ("board: toradex: Make A53 get RAM size from DT
> > in K3 boards") merged we had our CI running on our whole board farm
> > last night.
> > 
> > Good news: the issue is confirmed to be fixed on Verdin AM62P and Verdin
> > AM62 [Quad|Dual] with [1|2]GB RAM.
> 
> That's great!
> > 
> > Bad news: we we do still have a boot failure regression on Verdin AM62
> > single core with 512MB RAM. I have no idea if this is the same issue or
> > a different one, but from the logs it look different (despite that I
> > decided to keep using this email thread and not start a new one).
> > 
> > The failing board from the logs uses a AM6231ASGGHAALW SoC, maximum
> > frequency 1GHz, we also have another device failing, single core again,
> > with maximum frequency 800MHz, the working one have 1.4GHz max
> > frequency.
> > 
> > Worth noticing the errors
> >   Failed to set clock rates
> > 
> > These are new compared to the previous U-Boot release, it affects also
> > other boards, and I have no idea if this is related to this issue or not.
> > 
> > Logs of the failing device (U-Boot is commit f9ffeec4bdcf1da655a0ffea482062adde78fee8)
> > 
> > U-Boot SPL 2026.04-rc2-0.0.0-devel+git.f9ffeec4bdcf (Feb 12 2026 - 14:12:09 +0000)
> > SYSFW ABI: 4.0 (firmware rev 0x000b '11.2.9--v11.02.09 (Fancy Rat)')
> > Failed to set clock rates for '/a53@0': -22
> > SPL initial stack usage: 13456 bytes
> > Trying to boot from MMC1
> > Authentication passed
> > Authentication passed
> > Authentication passed
> > Loading Environment from nowhere... OK
> > init_env from device 9 not supported!
> > Warning: Did not detect image signing certificate. Skipping authentication to prevent boot failure. This will fail on Security Enforcing(HS-SE) devices
> > 
> 
> I don't think this one is related to the firewall series. Not really
> sure what the issue is. Just to rule this series out -- could you drop
> my patch(es) and check if this specific device boots?
> 
> Was this device booting earlier? Could it be a build misconfig, since it
> says that it can't detect an image signing certificate?

This is a regression with 2026.04. 2026.04-rc never booted on this device, and
before commit f9ffeec4bdcf1da655a0ffea482062adde78fee8 none of the verdin
am62[p] variants were booting for multiple bugs that were present in the
release.

2026.01 is booting fine on this device, with plain vanilla U-Boot.

Francesco

