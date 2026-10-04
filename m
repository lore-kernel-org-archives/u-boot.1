Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C03D2CA5FDD
	for <u-boot@archiver.kernel.org>; Sun,  4 Oct 2026 01:39:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E9C0F60638;
	Sun,  4 Oct 2026 01:39:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YgoGvUGeetWL; Sun,  4 Oct 2026 01:39:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org AE70960624
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791077991;
	b=pTLtGXYpgqi4cTRvdwAzqFwYMUbd4u02mwaPBT+jqH77J+mb16WR/MGQCB7RXkHPEVgP
	 8QA6irMbey7+Qi4gxA8ZXDvBmhSPPGGKOQtO5HUeW6SCw4OODsKgPGgsmCDLi//XxLUKx
	 BOuC+N7o1jAwYqXns62dCXpb1HAWN5HGXf1lTGsGDTFmqHubgk52FLxq0NfFRJ1+x1e3s
	 nkLd7NfwB4Am4aAM8AFMWygHcOD/lTxYqn1zi7xrz47w/jqYNOumTpWGGagwEc0wSVSON
	 7FPltip23Z6/WmMOZxArpSqvVhagS3eqeXfW2JGMRGVJs0cH1zi8bOd92EvmYl/1Q+Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791077991;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=lHb9CRuskECP8KclWLWHrldvsk5EHjIcHWF2Vi5dl2E=;
	b=XhOAo+LuDvQ+5CgnN/NCLXUtsN4Q6C8mkIv/olf6lLtCru+/5zBJhK4vEaHe260Z3gwm
	 mc0s77Ck0HGx/kp3Q59bP+p3LMpM1TAOovLwCxnNmZ7Q0PI0865P1vnVqVIVZplz4SHwO
	 JVF1o317ozhV6SE6oQFtdjgCXtXL/dbV8TB0UctomI6wcYGF+RSF33up0Coom5DQM73by
	 Z8vdUxSeRMzRwy0m1Pwnl+2Snqkpn1u7juk7Rz170SGfEFlD2qQeYbOvlhEnOq2zUdAz+
	 TZNyxqdtsLhNkPGFz17GIlbfmOkGNly/Ksx0UjUSl9hyMkf+0qe5VTcdRMSK/b4J1zA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791077991;
	bh=lHb9CRuskECP8KclWLWHrldvsk5EHjIcHWF2Vi5dl2E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ngpCzycDv6I343UjWi8W2QK2aJiyy/APsSUhIDXU/j+hkPmqX2Xkur5MIXKEOLVKx
	 WhV/aoMP2lnm8GadQVu90sBglWbetB3eTvzCpYyFUPdwgsZ9E2d27KZ8n8Ebiai0tA
	 dZkgJbSR6GoqNtO6x14dTd5KheH4JoFonZJDcRxjejGEsv8hm6pJYJXUn/9cQo2LIE
	 F3fFBViIA8LtTW/INUZC3NQl/lrrD7KnB05dyykccxnjU5L55OfMMuKDgzuELW3ZoG
	 ZPAFZkB2pogPsHgwzvGQK65vPiXyBaZ+rJWc9C0DOcMvOeJROGgVO071IBOChut+oG
	 NivIMu9IraBUw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AE70960624;
	Sun,  4 Oct 2026 01:39:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id ECD30435
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 01:39:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DEA2540075
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 01:39:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UZPyuQ0_kU20 for <u-boot@lists.u-boot-project.org>;
 Sun,  4 Oct 2026 01:39:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 89DDC4002B
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791077989;
 b=IM19mSL6GuG/AfUtuio9oRgySL9BQyrzpmMnSiCivRiULvKbvOeMyxcSYh4ue8SwbQbC
 6/l+FLIquRdkNI0je5GZHwNOdRswrVnbtfduK8uJgNpxFlP3aFI3OasoJbTUbgIRtTV25
 AhVlfmQ5l2M09jBTDlxFD50fN0ITXR0QoVe4WdCrkDHVnK7qQbqVPlRfHsV6nn23eFnDe
 fAht1AKwAzU6oboY6XBniX4Zd2Sudl2QzDjowPzx3g5lCwfitV6DBEG887OGRFKFY3dPw
 wz7aaGKEBwkT9Sc8atwLdkGr6od3pyZrvH9cuKiCo/0QerL+8EvGn/BCy3TqtxyaEvQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791077989;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=lHb9CRuskECP8KclWLWHrldvsk5EHjIcHWF2Vi5dl2E=;
 b=Ao5+OjOy7B5bTxQgStI611jTyXtsZt917/6tUeByWcC1Cs4Arw0HqtZoyrPqsBij2hgE
 h+U7zx4kzA47qEPh1OnMWOGXxr3pAUHuN0k3Sv4YjFzy+AbEQ2pzEPa/k7ko1UyiRAmaQ
 FfORgaiW4tbloqH9RW9vJH1R0AqIuycRt07BKjpkmsnG34Sh8iAXEUgkq6rg9FBuMshSI
 aOpArtNRpVacD2hjM0+kd6U6EPKY1DHXM+UefCfdetCchbXwMUE6403dvQ2y+oh0KuJ54
 jjK076Wtyky9Drcv7npCkkRVb3wkfkDE6jO0sh1GCp16TKXoH+C4TyWaQ9MxXYVP7zA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=S+fcgZqw; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=S+fcgZqw
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 89DDC4002B
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 01:39:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2F56A4070F;
 Sun,  4 Oct 2026 01:39:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 880E51F0089B;
 Sun,  4 Oct 2026 01:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791077988;
 bh=lHb9CRuskECP8KclWLWHrldvsk5EHjIcHWF2Vi5dl2E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=S+fcgZqwjrFwTL4ey66KvnGFyTjb67jLL+6rLHyEyotlkFbldBwog3Ybbv1mEYapb
 pnzO7DcpB2iRhIhm+g9fc+Ck7TvLt41jAVfuCe/GTscCb6crn+bFELyFVNsa3LO9hC
 G4efhaxWgrroXiLAP5amY8uVePFqBZK4cS5/0Sql3nwwXF+cl8G+9YHGGaa2jq6HQP
 EaybvnHvkd8A/XRg9fe5enLGBa+x3SKrYJ/QtsTqtBIM7f/Ni2FY4wC3ElPHltFy0L
 mRz4+UUX7PiSxjkZRttBnRCqSf3couQyXc4f8Kut1P20NuZnd+EaGOjctyZO36MBR0
 HfZ0F0PXOkBQA==
Date: Sun, 4 Oct 2026 01:39:45 +0000
From: Yixun Lan <dlan@kernel.org>
To: E Shattow <e@freeshell.de>
Cc: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>,
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Hiago De Franco <hfranco@baylibre.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>
Subject: Re: [PATCH v3 4/4] doc: spacemit: k3: Add Pico-ITX board
Message-ID: <20261004013945-GKC68132@kernel.org>
References: <20261003-00-basic-spacemit-k3-v3-0-dea68cd1bd7d@kernel.org>
 <20261003-00-basic-spacemit-k3-v3-4-dea68cd1bd7d@kernel.org>
 <b506708c-5ee2-492b-a77c-4bdc9a904b9e@freeshell.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b506708c-5ee2-492b-a77c-4bdc9a904b9e@freeshell.de>
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

Hi E Shattow, 

On 05:43 Sat 03 Oct     , E Shattow wrote:
> Hi Yixun,
> 
> On 10/2/26 17:34, Yixun Lan wrote:
> > Add documentation for how to test the mainline U-Boot on SpacemiT
> > K3 Pico-ITX board, currently it still rely on using vendor FSBL.bin
> > file to initialize DDR and boot U-Boot proper, and the opensbi
> > firmware is built from an on-going mainline branch.
> > 
> > Signed-off-by: Yixun Lan <dlan@kernel.org>
> > ---
> >  doc/board/spacemit/index.rst             |   1 +
> >  doc/board/spacemit/spacemit-pico-itx.rst | 204 +++++++++++++++++++++++++++++++
> >  2 files changed, 205 insertions(+)
> > 
> > diff --git a/doc/board/spacemit/index.rst b/doc/board/spacemit/index.rst
> > index 71854e5735b..51918f0acc7 100644
> > --- a/doc/board/spacemit/index.rst
> > +++ b/doc/board/spacemit/index.rst
> > @@ -8,4 +8,5 @@ SpacemiT
> >     bananapi-f3
> >     k1-mmc
> >     k1-spl
> > +   spacemit-pico-itx
> >  
> > diff --git a/doc/board/spacemit/spacemit-pico-itx.rst b/doc/board/spacemit/spacemit-pico-itx.rst
> > new file mode 100644
> > index 00000000000..dd29e3c31c8
> > --- /dev/null
> > +++ b/doc/board/spacemit/spacemit-pico-itx.rst
> > @@ -0,0 +1,204 @@
> > +.. SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +SpacemiT K3 Pico-ITX
> > +====================
> > +
> > +Building
> > +~~~~~~~~
> > +1. Install the SpacemiT riscv cross compile toolchain_, or skip it if riscv toolchain is installed.
> > +
> > +.. _toolchain: https://archive.spacemit.com/toolchain/
> > +
> 
> Avoid the advertisement for any unnecessary vendor-specific information.
> 
Ok
> The packaged toolchain from any generic Linux distro is fine enough to
> build with as "1. Add a RISC-V toolchain to your PATH." and no other
> explanation is required.
> 
> I have tested with Debian forky/testing for example, it is fine. Code
> size differences between output of GCC major versions may be detailed in
> a future update if it becomes important.
> 
Ok, I generally agree, any riscv toolchain should works fine here,
no specific requirement, this is just a copy-and-poaste from K1 doc,
and should consider as one of many ways to setup compiling toolchain

> > +2. Setup cross compilation environment variable:
> > +
> > +.. code-block:: console
> > +
> > +   export CROSS_COMPILE=<riscv64 toolchain prefix, e.g /opt/spacemit/bin/riscv64-unknown-linux-gnu->
> > +
> 
> Likewise, it is enough to have "2. Set a cross-compilation environment
> variable if needed: export CROSS_COMPILE=<riscv64 toolchain prefix>"
> 
> There is much documentation about compiling U-Boot at
> doc/build/index.rst and so do not name a specific vendor toolchain path
> name here.
> 
Ok
> > +3. Before building U-Boot, OpenSBI should be built first. OpenSBI can be
> > +built for SpacemiT K1 SoC as below:
> 
> built for SpacemiT K3 SoC ?
> 
> However it is clearer to re-phrase that as a statement of requirements.
> "3. U-Boot for SpacemiT K3 SoC requires OpenSBI in-development generic
> platform object fw_dynamic.bin to be included in the Flattened Image
> Tree blob. OpenSBI may be first built as below: ..."
> 
> Please if it will help you then do copy any build examples adapted from
> my own writing in doc/board/starfive/jh7110_common.rst which contains a
> small error in build command details corrected at
> https://lore.kernel.org/u-boot/20260924063843.8934-1-e@freeshell.de/
> 
I will try to do some ajdustment to make it more generic..

> Additional phrasing may be as "Review the OpenSBI developer mailing list
> archives for patches to apply in support of SpacemiT K3 Pico-ITX". Let
> this be generic enough that we are not dead-linking to something 10
> years later when a user is viewing this old document from the future.
> 
But, well, either way isn't perfect, I didn't expect this is an unchanged
doc which will last 10years long, instead it should be kept improved.

> > +
> > +.. code-block:: console
> > +
> > +   git clone https://github.com/spacemit-com/opensbi-upstream opensbi
> > +   cd opensbi
> > +   make PLATFORM=generic
> 
> Please refer to upstream directly. I appreciate to make it convenient
> with patches curated on a fork repository but this is not durable for
> documentation purpose, is this going to exist in 2 years? 10 years? 20
Shouldn't be problem for 2years, while not sure for more than 10years,
but I don't think this is really a problem, see below

> years?. Mailing list archives are durable and if we depend on OpenSBI
> then I expect at least upstream OpenSBI git repository to be durable, too.
> 
I'd hope patches for opensbi will be finally accepted into mainline, then
update the doc here accordingly, providing a fork repo is just a conveniet
way for people to download, I could adjust to use mainline opensbi repo +
applying extra patches, but to be honest, I don't see that's much
different.. so, I'd rather not change it now, or let's say, do update the
doc when above fork repo is really broken/or opensbi patches accepted.

> > +
> > +4. Then build U-Boot as following:
> > +
> > +.. code-block:: console
> > +
> > +   cd <U-Boot-dir>
> > +   make spacemit_k3_defconfig
> > +   make OPENSBI=<OpenSBI-dir>/build/platform/generic/firmware/fw_dynamic.bin
> > +
> > +This will generate u-boot.itb
> > +
> > +Testing
> > +~~~~~~~
> > +Currently, in this stage, the U-Boot SPL isn't ready, and has no ddr initialization code
> 
> Instead, as "Currently there is no U-Boot SPL build target. It is
> required to use 'FSBL.bin' vendor board support package SPL for DDR
> initialization and testing u-boot.itb"
> 
Ok

> May SPI NOR be erased empty? what exactly must be present in SPI NOR for
> successful testing?
> 
Doesn't matter if there is fw present in SPI NOR, for my testing, my
board do has SPI nor firmware exist

> > +Thus please test with fasboot command via USB download.
> 
> fastboot
> 
thanks

> > +
> > +First, retrieve Bianbu Linux image from archive_ and extract the FSBL.bin firmware.
> 
> We should build any out-of-tree dependencies (FSBL.bin) from from source
> if it is possible. This is a cheap operation to 'git remote add -f
> spacemit-com https://...spacemit-com/uboot-2022.10' on an existing
> u-boot git repo.
> 
> Assume SPI NOR content is erased. Is there something vendor-specific you
> need that is not available by compiling spacemit-com k3-br-v1.0.y branch?
> 
I don't want to put too much effort to document about building vendor-specific
firmware.. currently, providing one way to test is enough, since there is a
work-on-porgress project, and we target having a mainline SPL support in
tree finally

-- 
Yixun Lan (dlan)
