Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D19C5B543
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 08:53:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29B508070C;
	Tue, 10 Jun 2025 10:53:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LmIxSqAT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F063280C83; Tue, 10 Jun 2025 10:53:00 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D8F2805D7
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 10:52:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 61D68A51025;
 Tue, 10 Jun 2025 08:52:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CFD5C4CEED;
 Tue, 10 Jun 2025 08:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1749545577;
 bh=64/CmAwtPW2K5sKN9T769Y+pvBxM/anS0ZkRgxKu1ak=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LmIxSqATVf6CX40PelM8PDmYrBJgKGCJ4W8lcr2uYj/togh9B6jiT1kvFHIJ+0oOV
 /UbM8shkVWrVpJGt/kSQ4yVHCEE6DSa3KUjCb4FniW2/l0D59GPLLtOMM6OOEl5ijb
 YILr+bCk4a6pwQzmoR6RgjxW42fYTVC/mwZxeJMqSKVUfQjG5wD53lzbYfk6lhE7lF
 7BUHcUffQOvyvREGRH6J+5kBQza9V7jfaGSPi83wJR6rhGgEtBPDJ0lP69X/nrQps8
 finERQdo1VqEW8nvycibi+UgLQ07AgOEV67R4jI6PlrCmjNMPc6AGXLX4w1u51JYdI
 KiniPSP2CCc9w==
Date: Tue, 10 Jun 2025 14:22:49 +0530
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
 Sean Anderson <seanga2@gmail.com>, uboot-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 0/9] Support stm32h747-discovery board
Message-ID: <aEfyYd64P7txX7vS@sumit-X1>
References: <20250607093730.2249536-1-dario.binacchi@amarulasolutions.com>
 <dc8bb4a3-c465-4ae0-a61d-bb2f74a42b64@foss.st.com>
 <aEbgxo0WUDPd-S8Z@sumit-X1>
 <CABGWkvox-1a1VSGjX8toQ=WsVTma0JcL8su=MGWaAwq4UZFkrQ@mail.gmail.com>
 <aEcAe80kh66cf0_c@sumit-X1> <20250609155019.GR1382132@bill-the-cat>
 <aEcGzCbZXajCthrh@sumit-X1> <20250609162239.GT1382132@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250609162239.GT1382132@bill-the-cat>
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

On Mon, Jun 09, 2025 at 10:22:39AM -0600, Tom Rini wrote:
> On Mon, Jun 09, 2025 at 05:07:40PM +0100, Sumit Garg wrote:
> > On Mon, Jun 09, 2025 at 09:50:19AM -0600, Tom Rini wrote:
> > > On Mon, Jun 09, 2025 at 04:40:43PM +0100, Sumit Garg wrote:
> > > > On Mon, Jun 09, 2025 at 03:46:27PM +0200, Dario Binacchi wrote:
> > > > > Hi Sumit,
> > > > > 
> > > > > On Mon, Jun 9, 2025 at 3:25 PM Sumit Garg <sumit.garg@kernel.org> wrote:
> > > > > >
> > > > > > Hi Patrice,
> > > > > >
> > > > > > On Mon, Jun 09, 2025 at 03:15:14PM +0200, Patrice CHOTARD wrote:
> > > > > > >
> > > > > > >
> > > > > > > On 6/7/25 11:37, Dario Binacchi wrote:
> > > > > > > > The series adds support for stm32h747-discovery board.
> > > > > > > >
> > > > > > > > Detailed information can be found at:
> > > > > > > > https://www.st.com/en/evaluation-tools/stm32h747i-disco.html
> > > > > > > >
> > > > > > > >
> > > > > > > > Dario Binacchi (9):
> > > > > > > >   ARM: dts: stm32h7-pinctrl: add _a suffix to u[s]art_pins phandles
> > > > > > > >   dt-bindings: arm: stm32: add compatible for stm32h747i-disco board
> > > > > > > >   dt-bindings: clock: stm32h7: rename USART{7,8}_CK to UART{7,8}_CK
> > > > > > > >   ARM: dts: stm32: add uart8 node for stm32h743 MCU
> > > > > > > >   ARM: dts: stm32: add pin map for UART8 controller on stm32h743
> > > > > > > >   ARM: dts: stm32: add an extra pin map for USART1 on stm32h743
> > > > > > > >   ARM: dts: stm32: support STM32h747i-disco board
> > > > > > > >   ARM: dts: stm32: add stm32h747i-disco-u-boot DTS file
> > > > > > > >   board: stm32: add stm32h747-discovery board support
> > > > > > >
> > > > > > >
> > > > > > > Hi Dario
> > > > > > >
> > > > > > > For the whole series
> > > > > > > Applied to u-boot-stm32/next
> > > > > >
> > > > > > Please give some time for other maintainers to review this patch-set.
> > > > > > The dts/upstream patches in this series aren't clean cherry pick from
> > > > > > upstream.
> > > > > 
> > > > > All the commits are already in the mainline Linux kernel, specifically
> > > > > in v6.16-rc1.
> > > > > If you're referring to the fact that the patches can't be applied
> > > > > cleanly, I believe it's
> > > > > because the target path in the Linux kernel doesn't match the one in U-Boot.
> > > > > In fact, the DTS files are located in two different relative paths.
> > > > 
> > > > That's exactly why we have (refer here [1]):
> > > > 
> > > > ./tools/update-subtree.sh pick dts <commit-id-to-be-picked>
> > > > 
> > > > You should have waited v6.16-rc1 tag to be synced into
> > > > devicetree-rebasing [2] for the cherry-picks to work. This way of
> > > > manually patching dts/upstream is not allowed since it is going to break
> > > > DT syncs in one way or another.
> > > > 
> > > > So I would suggest you to wait for v6.16-rc1 to land in DT rebasing tree
> > > > and then send v2 with proper cherry picked patches.
> > > > 
> > > > [1] https://docs.u-boot.org/en/latest/develop/devicetree/control.html#resyncing-with-devicetree-rebasing
> > > > [2] https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git
> > > 
> > > To be honest, I don't think this is a big deal. Git will be merging
> > > based on content and not specific hashes. And in the case of conflicts I
> > > just copy the file from the tag to our tree.
> > 
> > The essential problem here to me is we are going to allow manual
> > patching of dts/upstream tree given this example? How do we keep track
> > if all that manual patching landed in Linux DT mainline? The cherry
> > picks ensured that we always keep in sync with mainline.
> > 
> > Lets take an example what if Git automatically resolved a merge conflict
> > for you with duplicated content or if manually patching a DTS file
> > diverged from upstream and get unnoticed during DT syncs?
> > 
> > IMHO, we should try to avoid manual patching of DT subtree otherwise it
> > is hard to set a policy as to what level of manual patching is allowed
> > or not.
> 
> Part of the problem here is that from the standpoint of applying posted
> patches there's no functional difference between what Dario did here and
> what could be done once v6.16-rc1-dts is tagged (if it's not already).
> It's essentially a "manual patch" either way.

Nope, there is a difference here. The cherry-pick from DT rebasing
allows the custodian to rather just cherry pick corresponding DT patches
rather than applying patches posted on mailing list. I usually do that
when reviewing dts/upstream patches if they can be cherry-picked cleanly
or not. So there won't be manual patching in that process.

./tools/update-subtree.sh pick dts <commit-id-to-be-picked>

> We make it clear that
> dts/upstream/ *only* gets changes that are in Linus' tree. If someone
> tries to be sneaky and push something in that's not quite what's
> upstream, it will get stomped on later and there's not going to be any
> sympathy for the now broken platform.

For us the upstream sync path is via DT rebasing tree only. It usually
lags behind Linus' tree by maximum 1 week candence what I have noticed.

> 
> Yes, we document saying to use the cherry-pick script, and that's what
> people should do in general. But I don't think there's value in adding a
> further delay between "in Linus' tree" and "in devicetree-rebasing". In
> the linux kernel, there's thousands of people working on things and so
> strict rules can be understandable (someone will be running a bot to
> look for "(cherry pick from commit $hash)" and fail things where $hash
> doesn't exist, makes sense). Here if the ST custodians are happy just
> verifying the kernel commit, OK, that's fine. Or if they want to wait,
> that's fine too. We can be a little relaxed and let custodians do what
> they see as best.

The reason we adopted OF_UPSTREAM was just to get rid of the manual DT
patching and the syncs. So is it really that few days lag of DT rebasing
tree which is again pushing us towards manual DT patching? I am just
trying to understand the shortcomings that DT rebasing tree puts in
front of us.

-Sumit
