Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF499EA3F3C
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 10:50:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DC9D8341A;
	Tue, 10 Feb 2026 11:50:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="WgsPxlzC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FFF88341A; Tue, 10 Feb 2026 11:50:21 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8132B8063E
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 11:50:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 32B341FB26;
 Tue, 10 Feb 2026 11:50:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1770720616;
 bh=sIO0con3mPgo1ZFwEagQSw+UgbhgWBMsKwz02e2oSw0=; h=From:To:Subject;
 b=WgsPxlzCEYbQCrYJiKgpFzIsJS7jIkX1HPHVIqs3mRh/bptXCmWwp29gvOwFQILSe
 EabQY+bDjIp7NCgWse+CI5B6jeB9r1ay7RtxeGsFV90srySKsDP57/jIdS4SsDCjbA
 dRFMonqLF5wd4v/8isrreeM0NQAkwNOfwphmaXFxtmaNtWBiaZPAB8C+SWNDY07D+b
 4rUxIyFv3FV3/Dx/+vTwokdSUZA1W9X5YzJGO+RDjGZ7qOQ8tL+whTvFpCwbqm5SRq
 z0m/ScuGVceHW7L1KiH36jtDZPeQpx08goa5h2pLz5NYA5Co8RZLIP0v70a5P41kf9
 AFvZXDbp/g6Dw==
Date: Tue, 10 Feb 2026 11:50:14 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Bryan Brattlof <bb@ti.com>, Suhaas Joshi <s-joshi@ti.com>
Cc: Francesco Dolcini <francesco@dolcini.it>, Anshul Dalal <anshuld@ti.com>,
 u-boot@lists.denx.de, trini@konsulko.com, vigneshr@ti.com,
 n-francis@ti.com, s-tripathi1@ti.com, k-malarvizhi@ti.com,
 kamlesh@ti.com, vishalm@ti.com, d.schultz@phytec.de,
 w.egorov@phytec.de, ggiordano@phytec.com
Subject: Re: [REGRESSION] Verdin AM62/62P not booting with 42b3ee7fa524
Message-ID: <20260210105014.GB214446@francesco-nb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210092646.w5bugrscifmsh5px@ula0507357>
 <20260209202001.saeaf6l2kz57rufg@bryanbrattlof.com>
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

On Mon, Feb 09, 2026 at 02:20:01PM -0600, Bryan Brattlof wrote:
> Do you mind copying a boot log to a pastebin for me? I thought I had one 
> of these boards but I'm still digging around for it. 0x80000000 should 
> be where we load TFA now days unless some boards have opted out of 
> letting U-Boot move it to the bottom of DRAM

Here some more logs

https://gist.github.com/dolcini/aa4b669c6349cc6da1b9e7b19cf53fed

The files are named with the commit sha that is tested.

On Tue, Feb 10, 2026 at 02:56:46PM +0530, Suhaas Joshi wrote:
> Verdin boards are the only ones that are reporting this issue. Is it
> alright if we revert only the two Verdin-specific commits, and let the
> rest (TI and PhyCore ones) stay as they are? The patches are pretty
> un-connected to each other.

Verdin AM62 should not have anything special, the code is all there for
everyone to see, including the defconfig, the DT and so on, and the changes
we are talking about to me are self contained withing the SoC. Something
is wrong, and we are not understanding what yet.

I just retested once more 42b3ee7fa524 and it just hung, you never know
if I did something wrong. And for what matter this was spotted by our
CI.

> We are working on figuring out why Verdin is seeing these issues, in the
> meantime.

Anything I can do let me know.

If it matter the board that I am currently testing has 1GiB DDR RAM, and
the SoC is a AM6252ATCGHAALW. 

Francesco

