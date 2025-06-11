Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC4A3C677C4
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 12:08:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 740CA82B63;
	Wed, 11 Jun 2025 14:08:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YoXnWTaG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E371782B70; Wed, 11 Jun 2025 14:08:13 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 321FE82B20
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 14:08:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 248B1A5172B;
 Wed, 11 Jun 2025 12:08:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4BA1C4CEF0;
 Wed, 11 Jun 2025 12:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1749643689;
 bh=GgZ038jX6HCDii19CnMVFG6NZhnTsihfjr5CScmFD+w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YoXnWTaGwyBIqnsbRKwXv8ZAiRHSByXMWlgsacn9s5m/4BP/z5ap7nzassoIxCdLx
 L40eeefm1bHSOybf8IYUkTMrKWGbVa9Dxj1B7J/8uJrIl+9olDewRcRHVhU7I6bb9+
 q10YXK3ETdlfAXFoqg99aqvP8nLxQLneUtFIlDS5mnT9nZMjLZtxP3iLhGZ5frayYO
 cda8Ae66QpdE1KiK/fKBjdoU7SozMXeH+G2muvpk8cbdqWklDbDJ+gpi6BHm6xuNT4
 HjX0NHMllVmWtPCbZur6PGqCh7EXlWWD5WcIzxxpXFK0LTuwPf9BYAbhZlU38lkX3b
 6r0j9xeVXSrxQ==
Date: Wed, 11 Jun 2025 17:38:01 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Tom Rini <trini@konsulko.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>, u-boot@lists.denx.de,
 linux-amarula@amarulasolutions.com,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Dillon Min <dillon.minfei@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Lukasz Majewski <lukma@denx.de>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <seanga2@gmail.com>,
 uboot-stm32@st-md-mailman.stormreply.com, quentin.schulz@cherry.de
Subject: Re: [PATCH 0/9] Support stm32h747-discovery board
Message-ID: <aElxoV5qvC-R0t3D@sumit-X1>
References: <20250607093730.2249536-1-dario.binacchi@amarulasolutions.com>
 <dc8bb4a3-c465-4ae0-a61d-bb2f74a42b64@foss.st.com>
 <aEbgxo0WUDPd-S8Z@sumit-X1>
 <CABGWkvox-1a1VSGjX8toQ=WsVTma0JcL8su=MGWaAwq4UZFkrQ@mail.gmail.com>
 <aEcAe80kh66cf0_c@sumit-X1> <20250609155019.GR1382132@bill-the-cat>
 <aEcGzCbZXajCthrh@sumit-X1> <20250609162239.GT1382132@bill-the-cat>
 <aEfyYd64P7txX7vS@sumit-X1> <20250610160454.GE1382132@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250610160454.GE1382132@bill-the-cat>
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

On Tue, Jun 10, 2025 at 10:04:54AM -0600, Tom Rini wrote:
> On Tue, Jun 10, 2025 at 02:22:49PM +0530, Sumit Garg wrote:
> > On Mon, Jun 09, 2025 at 10:22:39AM -0600, Tom Rini wrote:
> > > On Mon, Jun 09, 2025 at 05:07:40PM +0100, Sumit Garg wrote:
> > > > On Mon, Jun 09, 2025 at 09:50:19AM -0600, Tom Rini wrote:
> > > > > On Mon, Jun 09, 2025 at 04:40:43PM +0100, Sumit Garg wrote:
> > > > > > On Mon, Jun 09, 2025 at 03:46:27PM +0200, Dario Binacchi wrote:
> > > > > > > Hi Sumit,
> > > > > > > 
> > > > > > > On Mon, Jun 9, 2025 at 3:25 PM Sumit Garg <sumit.garg@kernel.org> wrote:
> > > > > > > >
> > > > > > > > Hi Patrice,
> > > > > > > >
> > > > > > > > On Mon, Jun 09, 2025 at 03:15:14PM +0200, Patrice CHOTARD wrote:
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > On 6/7/25 11:37, Dario Binacchi wrote:
> > > > > > > > > > The series adds support for stm32h747-discovery board.
> > > > > > > > > >
> > > > > > > > > > Detailed information can be found at:
> > > > > > > > > > https://www.st.com/en/evaluation-tools/stm32h747i-disco.html
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Dario Binacchi (9):
> > > > > > > > > >   ARM: dts: stm32h7-pinctrl: add _a suffix to u[s]art_pins phandles
> > > > > > > > > >   dt-bindings: arm: stm32: add compatible for stm32h747i-disco board
> > > > > > > > > >   dt-bindings: clock: stm32h7: rename USART{7,8}_CK to UART{7,8}_CK
> > > > > > > > > >   ARM: dts: stm32: add uart8 node for stm32h743 MCU
> > > > > > > > > >   ARM: dts: stm32: add pin map for UART8 controller on stm32h743
> > > > > > > > > >   ARM: dts: stm32: add an extra pin map for USART1 on stm32h743
> > > > > > > > > >   ARM: dts: stm32: support STM32h747i-disco board
> > > > > > > > > >   ARM: dts: stm32: add stm32h747i-disco-u-boot DTS file
> > > > > > > > > >   board: stm32: add stm32h747-discovery board support
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > Hi Dario
> > > > > > > > >
> > > > > > > > > For the whole series
> > > > > > > > > Applied to u-boot-stm32/next
> > > > > > > >
> > > > > > > > Please give some time for other maintainers to review this patch-set.
> > > > > > > > The dts/upstream patches in this series aren't clean cherry pick from
> > > > > > > > upstream.
> > > > > > > 
> > > > > > > All the commits are already in the mainline Linux kernel, specifically
> > > > > > > in v6.16-rc1.
> > > > > > > If you're referring to the fact that the patches can't be applied
> > > > > > > cleanly, I believe it's
> > > > > > > because the target path in the Linux kernel doesn't match the one in U-Boot.
> > > > > > > In fact, the DTS files are located in two different relative paths.
> > > > > > 
> > > > > > That's exactly why we have (refer here [1]):
> > > > > > 
> > > > > > ./tools/update-subtree.sh pick dts <commit-id-to-be-picked>
> > > > > > 
> > > > > > You should have waited v6.16-rc1 tag to be synced into
> > > > > > devicetree-rebasing [2] for the cherry-picks to work. This way of
> > > > > > manually patching dts/upstream is not allowed since it is going to break
> > > > > > DT syncs in one way or another.
> > > > > > 
> > > > > > So I would suggest you to wait for v6.16-rc1 to land in DT rebasing tree
> > > > > > and then send v2 with proper cherry picked patches.
> > > > > > 
> > > > > > [1] https://docs.u-boot.org/en/latest/develop/devicetree/control.html#resyncing-with-devicetree-rebasing
> > > > > > [2] https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git
> > > > > 
> > > > > To be honest, I don't think this is a big deal. Git will be merging
> > > > > based on content and not specific hashes. And in the case of conflicts I
> > > > > just copy the file from the tag to our tree.
> > > > 
> > > > The essential problem here to me is we are going to allow manual
> > > > patching of dts/upstream tree given this example? How do we keep track
> > > > if all that manual patching landed in Linux DT mainline? The cherry
> > > > picks ensured that we always keep in sync with mainline.
> > > > 
> > > > Lets take an example what if Git automatically resolved a merge conflict
> > > > for you with duplicated content or if manually patching a DTS file
> > > > diverged from upstream and get unnoticed during DT syncs?
> > > > 
> > > > IMHO, we should try to avoid manual patching of DT subtree otherwise it
> > > > is hard to set a policy as to what level of manual patching is allowed
> > > > or not.
> > > 
> > > Part of the problem here is that from the standpoint of applying posted
> > > patches there's no functional difference between what Dario did here and
> > > what could be done once v6.16-rc1-dts is tagged (if it's not already).
> > > It's essentially a "manual patch" either way.
> > 
> > Nope, there is a difference here. The cherry-pick from DT rebasing
> > allows the custodian to rather just cherry pick corresponding DT patches
> > rather than applying patches posted on mailing list. I usually do that
> > when reviewing dts/upstream patches if they can be cherry-picked cleanly
> > or not. So there won't be manual patching in that process.
> > 
> > ./tools/update-subtree.sh pick dts <commit-id-to-be-picked>
> 
> Alright. I hadn't foreseen anyone doing that rather than "b4 {am,shazam}
> msg-id" to grab the series.

Maybe we need to have some custodian specific docs listing best
practices.

> 
> > > We make it clear that
> > > dts/upstream/ *only* gets changes that are in Linus' tree. If someone
> > > tries to be sneaky and push something in that's not quite what's
> > > upstream, it will get stomped on later and there's not going to be any
> > > sympathy for the now broken platform.
> > 
> > For us the upstream sync path is via DT rebasing tree only. It usually
> > lags behind Linus' tree by maximum 1 week candence what I have noticed.
> > 
> > > 
> > > Yes, we document saying to use the cherry-pick script, and that's what
> > > people should do in general. But I don't think there's value in adding a
> > > further delay between "in Linus' tree" and "in devicetree-rebasing". In
> > > the linux kernel, there's thousands of people working on things and so
> > > strict rules can be understandable (someone will be running a bot to
> > > look for "(cherry pick from commit $hash)" and fail things where $hash
> > > doesn't exist, makes sense). Here if the ST custodians are happy just
> > > verifying the kernel commit, OK, that's fine. Or if they want to wait,
> > > that's fine too. We can be a little relaxed and let custodians do what
> > > they see as best.
> > 
> > The reason we adopted OF_UPSTREAM was just to get rid of the manual DT
> > patching and the syncs. So is it really that few days lag of DT rebasing
> > tree which is again pushing us towards manual DT patching? I am just
> > trying to understand the shortcomings that DT rebasing tree puts in
> > front of us.
> 
> It's mainly that I want to be flexible. So long as we don't violate the
> content rules (Linus' tree *only*) I don't want to hinder the people
> eager to now upstream U-Boot support for purely process reasons

This flexibility has a cost associated to it which I hopefully was able
to clarify above. But finally it's your decision which prevails.

BTW, DT rebasing has already got the v6.16-rc1 tag, so it was really
just 3 days gap. Quentin (CCed) has already done some proper cherry
picking from there [1].

[1] https://patchwork.ozlabs.org/project/uboot/list/?series=460450

> (which
> happens, E Shattow on IRC was asking how to at least locally point
> dts/upstream at something else, at least for local testing).
> 

I would love to hear problems from people if that's for downstream
development too.

-Sumit
