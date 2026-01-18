Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEBD2C98315
	for <u-boot@archiver.kernel.org>; Sun, 18 Jan 2026 19:51:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED9018307F;
	Sun, 18 Jan 2026 20:51:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=freeshell.de header.i=@freeshell.de header.b="lmTqKjYy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4B028313B; Sun, 18 Jan 2026 20:51:33 +0100 (CET)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5436082BF2
 for <u-boot@lists.denx.de>; Sun, 18 Jan 2026 20:51:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1768765887;
 bh=tpoj9WQKz3J8G2n5uEkMdoL2JuNqd8nuZVzCpY+UvZk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=lmTqKjYysBJN6rRE6/c+JA4kfrtopmtsH32lzJTpdSbcvsWCrnxvzCVHVFWBOzp84
 mAthfq5259fL7UCkE2HDL4th2wN8p1KBzPjJzAFiarxGeJ2dutWvh5QXGA/wMq1gEq
 7+iivrFpvu/IwR1ePrj0z9102EZW1wWWgUNV/BGNverfvy14NA6TTilXm0weswUgUC
 3+Y2KuKrdH9RO1QYpaFQgd3cRF8ut/n1/rUMV3O8DZcsvk26k8uCYWILbeSdOdlm3m
 vXIGmT1eaFpvWkepDeDaNLEn+yH2vknZQOF6Yhz1mWt7h83/957hmJay2bil5gVFM6
 Xr3qJz3o6Q4lw==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id AF894B220405;
 Sun, 18 Jan 2026 20:51:26 +0100 (CET)
Message-ID: <13cf5056-12ca-434d-87b4-d9e950cb6f2a@freeshell.de>
Date: Sun, 18 Jan 2026 11:51:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] doc: expand on JH7110 boot select switches
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>
Cc: u-boot@lists.denx.de
References: <20260118120523.13724-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20260118120523.13724-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8
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


On 1/18/26 04:05, Heinrich Schuchardt wrote:
> While some boards have separate switch RGPIO0, RGPIO1 others only
> have a common switch.
> 
> Describe the restriction.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  doc/board/starfive/jh7110_common.rst | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/doc/board/starfive/jh7110_common.rst b/doc/board/starfive/jh7110_common.rst
> index 77102fcc189..14ec556ab13 100644
> --- a/doc/board/starfive/jh7110_common.rst
> +++ b/doc/board/starfive/jh7110_common.rst
> @@ -237,6 +237,11 @@ RGPIO1 RGPIO0 StarFive loader function @ 0x2A00_0000
>  1      1      UART Serial XMODEM loader
>  ====== ====== ======================================
>  
> +While some boards have separate switches for RGPIO0 and RGPI01 (Milk-V Mars,
> +StarFive VisionFive 2, Pine64 Star64) other boards only offer a common
> +switch (Orange Pi RV, StarFive VisionFive 2 Lite) or control line
> +(Milk-V Mars CM). Here booting from SD-card or eMMC is not possible.
> +
>  According to `JH-7110 Boot User Guide BootROM`_ the StarFive loader code reads
>  content to SRAM @ 0x0800_0000 from different media selected by [RGPIO1,RGPIO0].
>  

Repeating the names of specific boards to describe this concept
unambiguously is clearly good reason why this statement does not belong
in the common document.

Statements in the common snippet should describe the SoC, the logic of
BootROM (which we don't yet know 100%), and for want that we don't have
a U-Boot specific snippet then also any U-Boot common functionality.

Maybe the "Boot button" would be considered a common peripheral however
(for want of upstreaming) the Pine64 PineTab-V does not have consistency
with other boards in this regard, and Milk-V Mars CM is a
system-on-module so that's also going to be absent of a boot button, and
some boards never featured a boot button; it's just not common.

Aside, I'm about 70%+ through classifying a reverse engineering effort
of the BootROM, and it's full of StarFive's JH7100 GPL2.0+ code derived
from U-Boot code (circa v2015.10 or so). This is evidently in disregard
for the license requirements to publish or made available the
modifications. However there is a lesser chunk of code which is probably
original to StarFive, is that considered proprietary? I'm not clear on
what is permissible to post to the mailing list in this situation.

I'm sharing Ghidra project archives of the effort off-list for anyone
that wants to get involved, there's ~20 stdlib-like and cryptography
("secure boot" ? perhaps) function calls that remain to be identified.
It's on-topic for JH-7110 boot select signals but probably way off topic
for U-Boot mailing list to dive into reverse engineering discussion.

Anyways if I might direct this constructively into a suggestion for
improving per-board documents, for our reference, here are some draft
notes I have collected about Milk-V Mars, Milk-V Mars CM (and CM Lite),
and Pine64 Star64:

""
Milk-V Mars
===========

Revision V1.1
No schematic published

Revision V1.11
* MOSFET input
  * BOOT_EN test point
  * pull-down momentary switch SW2 (remove R320 to disconnect)
  * pull-down bias R321 (n/c) || pull-up bias R322
* RGPIO0 pull-up bias input MOSFET inverted output
* RGPIO1 pull-up bias input MOSFET inverted output

Revision V1.2
No schematic published

Revision V1.21
* MOSFET input
  * BOOT_EN test point
  * pull-down momentary switch SW2 (remove R320 to disconnect)
  * pull-down bias R321 (n/c) || pull-up bias R322
* RGPIO0 pull-up bias input S1 pins 1,3 to MOSFET inverted output
* RGPIO1 pull-up bias input S1 pins 2,4 to MOSFET inverted output

Photos of rev V1.1 and of rev V1.11 have boot button and there is not
any multi-selection DIP switch.
Photos of rev V1.2 and of rev V1.21 both have boot button and
multi-selection DIP switch.


Milk-V Mars CM (-Lite)
======================

Revision X1.0
https://pica.zhimg.com/v2-c573f43a562d3e375c6e5bfc448e2fd8_1440w.jpg front
https://pica.zhimg.com/v2-bb53dd24e15502b60b73ecd21a04f444_1440w.jpg back

https://www.techspot.com/images2/news/bigimage/2023/09/2023-09-06-image-7-j_1100.webp
front

Revision V1.0
https://milkv.io/components/buy-marscm-view.webp

Revision V1.01
schematic available

Revision V1.21
schematic available


Pine64 Star64
=============

Boot selection MSEL DIP switch is active-low.

V1.0 pull-up MSEL
V1.1 pull-up ?

""


Given a per-board logical switch "on" may be inverted by logic to the
high or low state on the RGPIO lines of JH-7110, then each per-board
document should contain a simple table of [RGPIO3:RGPIO0] values
referenced in jh7110_common.rst with the schematic and usage information.

Suggested for example of structure:


""
Hold boot button pressed on Mars during power-on and during U-Boot SPL
to ensure StarFive loader UART function and U-Boot SPL YMODEM loader
function. Mars rev V1.2 and V1.21 have an additional multi-selection DIP
switch not populated on rev V1.1 and V1.11, with some overlapping
functionality as the boot button.

rev V1.1, V1.11:
Button  "GPIO1" "GPIO0" [RGPIO3:RGPIO0]
Release L       L       [0000]=0
Press   H       H       [0011]=3

rev V1.2, V1.21:
Button  "GPIO1" "GPIO0" [RGPIO3:RGPIO0]
Release L       L       [0000]=0
Release L       H       [0001]=1
Release H       L       [0010]=2
Release H       H       [0011]=3
Press   L       L       [0011]=3
Press   L       H       [0011]=3
Press   H       L       [0011]=3
Press   H       H       [0011]=3

Refer to vendor documentation for photos and usage with vendor board
support package:
https://milkv.io/docs/mars/getting-started/setup
""

I have not verified the accuracy of the above example idea for expanding
on Mars per-board document, it is suggested here for structure.

RGPIO2 is common between boards that we know of and likely does not
apply to users of upstream U-Boot so it can be assumed zero value for
the purpose of per-board documentation.

StarFive VisionFive 2 Lite vendor U-Boot has RGPIO3 (a user LED) as the
selection mechanism for fastboot feature; and perhaps upstream we might
do the same if it does not break other boards to do so. It may be useful
then to describe RGPIO2 and RGPIO3 connections (if any) per-board.
Changes to overall RGPIO3 behavior would belong in jh7110_common.rst
U-Boot description if it applies to all boards, and then per-board
describes any user-settable pin jumper configuration.

I have located and classified the mask ROM code in JH-7110 BootROM that
compares RGPIO state... and so there's a possibility of describing
secure boot closely related to OTP and RGPIO state. That would be
applicable to all boards and so is an example of what belongs in the
common snippet. While I'm not sure about the appropriateness of posting
reverse-engineered BootROM code to the mailing list inline here,
however, I can say that the mask 0xf is applied to retrieve from
register at 0x1702002c so that would be [RGPIO3:0] and then the return
value is masked off to 0x3 [RGPIO1:0] for comparison. There's also an
OTP register being compared... but I have not found yet what (or if)
there's RGPIO2 state effecting the boot vector selection. It's not clear
to me if the BootROM is involved in selection of the boot vector, or if
that is earlier so eventually when it is known this could be said or
ruled out about the BootROM and probably never will apply to U-Boot
users for boot vectors different than 2a000000.

Perhaps the common document would then get some U-Boot specific or
summary section with sixteen table rows numbered 0 through 15 for
[RGPIO3:RGPIO0] state, this seems unnecessary though it is only four
individual RGPIO tables that would need to be looked up by the user.
Having a short description of what a user needs to do "Hold boot
button..." ought to be sufficient, and more detail is there if a user
wants to look for it. Instead that might make sense to have as a
per-board summary.

What's the plan for reapplying the patch this depends on?

-E
