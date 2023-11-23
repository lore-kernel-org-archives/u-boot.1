Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07021C61DF7
	for <u-boot@archiver.kernel.org>; Thu, 23 Nov 2023 15:17:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6275687640;
	Thu, 23 Nov 2023 16:17:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC0A187687; Thu, 23 Nov 2023 16:17:15 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 1533387467
 for <u-boot@lists.denx.de>; Thu, 23 Nov 2023 16:17:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9CAC12FC;
 Thu, 23 Nov 2023 07:17:58 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE19A3F6C4;
 Thu, 23 Nov 2023 07:17:11 -0800 (PST)
Date: Thu, 23 Nov 2023 15:17:09 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: electricworry <worryelectric@gmail.com>
Cc: u-boot@lists.denx.de, "linux-sunxi@lists.linux.dev"
 <linux-sunxi@lists.linux.dev>, Mikhail Kalashnikov <iuncuim@gmail.com>
Subject: Re: Adding support for Orange Pi Zero 3
Message-ID: <20231123151709.64002286@donnerap.manchester.arm.com>
In-Reply-To: <CABZPTZSQHhcVuqLmg6nEiKBfF4p+R+y5sDCGaa19qztSEs54BA@mail.gmail.com>
References: <CABZPTZSQHhcVuqLmg6nEiKBfF4p+R+y5sDCGaa19qztSEs54BA@mail.gmail.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
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

On Sat, 4 Nov 2023 19:17:44 +0000
electricworry <worryelectric@gmail.com> wrote:

Hi,

> I would like to contribute improvements u-boot to enable support for
> the Orange Pi Zero 3 board. I have already gained a good understanding
> of the project and the standards for changes, and so I have made
> modifications and tested them on my board.

thanks for your interest and for reaching out!

I will answer your questions below, but for this particular topic there
are already support patches on the list (sorry for the disappointment!):
https://lore.kernel.org/u-boot/20231114013106.31336-1-andre.przywara@arm.com/

Can you please apply those patches on top of mainline U-Boot and test
them? Then reply to patch 3/3 above with a Tested-by: line, stating your
name and email address?
Having independent reports of that working would make me more confident in
merging the series.

As a general advice: try to reach out early, to avoid working in parallel
on something, and also to avoid working in the wrong direction.
There is the #linux-sunxi IRC channel on the OFTC IRC network[1] (you can
join via any browser), also there is a mailing list for Allwinner related
upstream work: linux-sunxi@lists.linux.dev [2]
Another resource is our wiki: https://linux-sunxi.org

[1] https://www.oftc.net/WebChat/
    https://oftc.irclog.whitequark.org/linux-sunxi
[2] https://subspace.kernel.org/lists.linux.dev.html

> Before submitting patches for review I've got a few questions I'd like
> to discuss.
> 
> The board is an Allwinner H618. From what I can gather this is just an
> H616 with minor changes. The changes are so minor that I've been able
> to implement the support as changes to the existing files for H616.

Just curious, what changes did you find in particular? So far we know
about the increased L2 cache, which is irrelevant from a software support
perspective, and the change of base address and layout of the CPUX_CFG
block, which is already covered by:
https://source.denx.de/u-boot/u-boot/-/commit/0a137ac5015933bf38ea2700abe70602ef63bbdd
Did you find anything else?

> For example, to add LPDDR4 support I have been able to make changes to
> arch/arm/mach-sunxi/dram_sun50i_h616.c and done so in a well

Out of interest, how did you do this? Disassembled the vendor boot0?
Dumping DRAM registers? We discussed and tested the LPDDR4 support already
a while ago, and support for that was merged recently:
https://source.denx.de/u-boot/u-boot/-/commit/4b02f0120a4bb2a5d7081aef8cef6a4ca57e9db2

> configured way that won't impact anything else. Is doing it in this
> way acceptable or would the preference be to have a separate file

In general we try to keep the code as much together as possible,
especially when there is a high overlap, like in this case.
So yeah, one file to drive all variants of DRAM for this SoC.

> (e.g. dram_sun50i_h618.c) to keep H616 and H618 separate? The way I've

Please note that the DRAM controller in both chips is the same, it's just
that the OrangePi boards using the H618 are the first easily available to
use LPDDR4. Mikhail was in fact developing his patch on a custom board
with LPDDR4 DRAM, using the Allwinner T507 (a repackaged H616).

> done it feels right because it really is just a minor upgrade, but
> there might be other opinions I should hear first.
> 
> Further, with regards to attribution, all of my changes are based on
> code in https://github.com/orangepi-xunlong/u-boot-orangepi. I've not
> been able to cherry-pick changes because that codebase has departed
> severely from the u-boot master branch and it's not as elegantly
> maintained, so I've had to surgically move just the changes required

I see you figured ;-)

> to get my board working. Their repo is correctly marked as GPL-2.0 so
> compatible with merging, but the exact author of every line of code
> will be difficult to attribute. Is it sufficient for me to cite that
> downstream repo as the source of the patches?

Yes, if you (need to) make significant changes, it's common practice to
make those your patches, and just mention the original work. At the end
the original author apparently couldn't be bothered to upstream this.
If possible, it's nice to try to reach the author, and ask for their
intention on this: often they don't really care (anymore), so are happy if
you do the upstreaming work.

Another way would be to take an original patch, adjust/rebase it, and
send it on behalf of the original author, keeping their authorship
(From:). This requires a Signed-off-by: line from the author, and *your*
Signed-off-by: line added, to confirm that you obtained those patches
legally and in compliance with the license.

Commonly this generates a series with a mixture of original patches,
rewritten patches (you as the author), and slightly adjusted patches (them
as the author).

Hope that helps!

Cheers,
Andre

> Thanks in advance. I've not submitted a patch here before so I could
> benefit from some hand-holding to not create problems for people, but
> I'm pretty confident that the changes I've made comply with the
> standards of the project and that there won't be much of an issue
> having them accepted.

