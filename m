Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96A47CAC5B0
	for <u-boot@archiver.kernel.org>; Thu,  2 Oct 2025 06:28:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6CB181D6A;
	Thu,  2 Oct 2025 08:28:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C712B828A2; Thu,  2 Oct 2025 08:28:24 +0200 (CEST)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CAEB80107
 for <u-boot@lists.denx.de>; Thu,  2 Oct 2025 08:28:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.54] (unknown [98.97.27.149])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 1AFC8B2202B3;
 Thu,  2 Oct 2025 08:28:20 +0200 (CEST)
Message-ID: <8fa4a057-2124-4620-9309-b8cc1817a749@freeshell.de>
Date: Wed, 1 Oct 2025 23:28:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 0/4] Add upstream boards Milk-V Mars CM and Mars CM Lite
To: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
References: <20250925053233.1874027-1-e@freeshell.de>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20250925053233.1874027-1-e@freeshell.de>
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



On 9/24/25 22:32, E Shattow wrote:
> Milk-V Mars CM and Mars CM Lite SoM's were formerly supported v2024.07 to
> v2025.01 and then absent since the OF_UPSTREAM transition of starfive
> visionfive2 multi-board support. Upstream patches are now queued up for the
> next merge window to Linux v6.18, so let's re-introduce support for these
> boards.
> 
> Sorting of OF_LIST is kept consistent with `LANG=C sort`, and callbacks in
> SPL for dts selection are ordered the same. Logic for setting fdtfile env
> variable corresponds with the sorting of OF_LIST and not the representative
> EEPROM value comparisons.
> 
> This series does violate some norms as it modifies the dts/upstream tree,
> and generally is introducing as upstream something which is not quite yet
> stable or release candidate in upstream devicetree-rebasing. RFC patches
> sent this way for review would benefit from not modifying dts/upstream
> tree at all but here it is done with empty files to pacify the build
> system. Actual dts content is simply copied to arch/$ARCH/dts as automatic
> inclusion dtsi. This pretends that if merged, then when upstream changes
> appear in devicetree-rebasing it would be only this updated content which
> can easily be reverted and empty placeholder files in dts/upstream be
> merged with less tedious conflict resolution.
> 
> For development with a local Linux source tree, the dtsi files for
> automatic inclusion may simply have a 1-liner include to the location of
> the corresponding dts file from that Linux source tree.
> 
> Open to comments about how best to encourage early review of series like
> this (notable is StarFive VisionFive2 Lite new product recently posted)
> when there is a hard dependency on both the OF_LIST of a multi-board
> target as starfive visionfive2 is and the dts which may not yet be
> available from dts/upstream devicetree-rebasing.
> 
> E Shattow (4):
>   riscv: dts: starfive: Add Milk-V Mars CM and Mars CM Lite from
>     upstream Linux for-next
>   board: starfive: visionfive2: Add Milk-V Mars CM and Mars CM Lite
>     selection by product_id
>   riscv: dts: Add placeholder files for pending upstream Milk-V Mars CM
>     and Mars CM Lite
>   configs: starfive: Add Milk-V Mars CM and Mars CM Lite to visionfive2
> 
>  .../dts/jh7110-milkv-marscm-emmc-u-boot.dtsi  |  12 ++
>  .../dts/jh7110-milkv-marscm-lite-u-boot.dtsi  |  25 +++
>  arch/riscv/dts/jh7110-milkv-marscm.dtsi       | 159 ++++++++++++++++++
>  board/starfive/visionfive2/spl.c              |   8 +
>  .../visionfive2/starfive_visionfive2.c        |   6 +
>  configs/starfive_visionfive2_defconfig        |   2 +-
>  .../starfive/jh7110-milkv-marscm-emmc.dts     |   0
>  .../starfive/jh7110-milkv-marscm-lite.dts     |   0
>  8 files changed, 211 insertions(+), 1 deletion(-)
>  create mode 100644 arch/riscv/dts/jh7110-milkv-marscm-emmc-u-boot.dtsi
>  create mode 100644 arch/riscv/dts/jh7110-milkv-marscm-lite-u-boot.dtsi
>  create mode 100644 arch/riscv/dts/jh7110-milkv-marscm.dtsi
>  create mode 100644 dts/upstream/src/riscv/starfive/jh7110-milkv-marscm-emmc.dts
>  create mode 100644 dts/upstream/src/riscv/starfive/jh7110-milkv-marscm-lite.dts
> 
> 
> base-commit: e482fdbbca935de32400054eb532de45b1cc01cb

The upstream dts series (Linux commit 8c0650e0cef28 "Merge tag
'riscv-dt-for-v6.18' of
https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux into
soc/dt") has been merged.

I will send an updated series when devicetree-rebasing 6.18-rc1 is
available to U-Boot.

Meanwhile I'm still wanting to know if there's a better way to fake-out
the U-Boot build system that avoids touching `dts/upstream/src` and have
it pretend that some missing dts (where specified in OF_LIST) is
equivalent to an empty dts file, so that the automatic inclusion
workflow can still amend that. This is for development and review
purposes during the duration when I'd like to submit _something_ for
review while waiting for upstream instead of, say "wait a month and try
again later".

From comments on IRC it was suggested to avoid OF_LIST and OF_UPSTREAM
then switch back to OF_UPSTREAM when devicetree-rebasing is available to
U-Boot with the needed data. Likewise the concept that "upstream" means
stable or release candidate only is reinforced and that what I'm asking
for is a bad idea. The counterpoint I have to that is it does not
actually test or give feedback to the build process which uses the
OF_UPSTREAM selection, so is invalid if what you're trying to do is get
a review on something that's surely going to be upstream by the time the
review feedback is collected and at which time the RFC is ready to move
forward as a patch (for final review).

I look at Hal's patch [1] sent one month ago and think well, this is
more difficult than it should be for a vendor to be "upstream first" to
get review feedback on an RFC, how can we make it better?

1:
https://lore.kernel.org/u-boot/ZQ2PR01MB13079882F31D06E973973C1AE6002@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn/

-E
