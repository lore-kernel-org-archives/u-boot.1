Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA684C61CE8
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 16:07:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D61482998;
	Mon,  9 Jun 2025 18:07:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="adBcC2rY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 163B482AA7; Mon,  9 Jun 2025 18:07:53 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85246826AA
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 18:07:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 66B9E5C49BF;
 Mon,  9 Jun 2025 16:05:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA8DC4CEEB;
 Mon,  9 Jun 2025 16:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1749485268;
 bh=VE4KYsfrrUSqUuDGGN5S6RtpApe/nEvN7R2vqN/eZ8U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=adBcC2rYf331GDWr0c2Oe0QTkVYBjK5p1uM3PyJIC1wyLBS8QBV391X195fO0lXxV
 Ohp5MgZTqxe5oFIZXReI5wbWuUQf78SoQwn+JkpSKRuoZIDWPalHpveFuOuSHRWOsk
 ZJLpp0MOw+pfemT3J/nRmofUqp2zx20DGwzAS1qMkTFwwYbe/U41of7bFlXcFRLrDu
 AVooXTrSKhuaJlktHMU9u3byzemkqzg4dU5XrVVqiL6nQGV/FRNm+mc5k7jSH9wU50
 xtjArsl9ltOZwykVHdtfOJLvOgyMPmJVTU/gY8evUsM+MdQWPG1D+6WIdrE2Vnxs1W
 znnEYhlFJDT9A==
Date: Mon, 9 Jun 2025 17:07:40 +0100
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
Message-ID: <aEcGzCbZXajCthrh@sumit-X1>
References: <20250607093730.2249536-1-dario.binacchi@amarulasolutions.com>
 <dc8bb4a3-c465-4ae0-a61d-bb2f74a42b64@foss.st.com>
 <aEbgxo0WUDPd-S8Z@sumit-X1>
 <CABGWkvox-1a1VSGjX8toQ=WsVTma0JcL8su=MGWaAwq4UZFkrQ@mail.gmail.com>
 <aEcAe80kh66cf0_c@sumit-X1> <20250609155019.GR1382132@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250609155019.GR1382132@bill-the-cat>
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

On Mon, Jun 09, 2025 at 09:50:19AM -0600, Tom Rini wrote:
> On Mon, Jun 09, 2025 at 04:40:43PM +0100, Sumit Garg wrote:
> > On Mon, Jun 09, 2025 at 03:46:27PM +0200, Dario Binacchi wrote:
> > > Hi Sumit,
> > > 
> > > On Mon, Jun 9, 2025 at 3:25 PM Sumit Garg <sumit.garg@kernel.org> wrote:
> > > >
> > > > Hi Patrice,
> > > >
> > > > On Mon, Jun 09, 2025 at 03:15:14PM +0200, Patrice CHOTARD wrote:
> > > > >
> > > > >
> > > > > On 6/7/25 11:37, Dario Binacchi wrote:
> > > > > > The series adds support for stm32h747-discovery board.
> > > > > >
> > > > > > Detailed information can be found at:
> > > > > > https://www.st.com/en/evaluation-tools/stm32h747i-disco.html
> > > > > >
> > > > > >
> > > > > > Dario Binacchi (9):
> > > > > >   ARM: dts: stm32h7-pinctrl: add _a suffix to u[s]art_pins phandles
> > > > > >   dt-bindings: arm: stm32: add compatible for stm32h747i-disco board
> > > > > >   dt-bindings: clock: stm32h7: rename USART{7,8}_CK to UART{7,8}_CK
> > > > > >   ARM: dts: stm32: add uart8 node for stm32h743 MCU
> > > > > >   ARM: dts: stm32: add pin map for UART8 controller on stm32h743
> > > > > >   ARM: dts: stm32: add an extra pin map for USART1 on stm32h743
> > > > > >   ARM: dts: stm32: support STM32h747i-disco board
> > > > > >   ARM: dts: stm32: add stm32h747i-disco-u-boot DTS file
> > > > > >   board: stm32: add stm32h747-discovery board support
> > > > >
> > > > >
> > > > > Hi Dario
> > > > >
> > > > > For the whole series
> > > > > Applied to u-boot-stm32/next
> > > >
> > > > Please give some time for other maintainers to review this patch-set.
> > > > The dts/upstream patches in this series aren't clean cherry pick from
> > > > upstream.
> > > 
> > > All the commits are already in the mainline Linux kernel, specifically
> > > in v6.16-rc1.
> > > If you're referring to the fact that the patches can't be applied
> > > cleanly, I believe it's
> > > because the target path in the Linux kernel doesn't match the one in U-Boot.
> > > In fact, the DTS files are located in two different relative paths.
> > 
> > That's exactly why we have (refer here [1]):
> > 
> > ./tools/update-subtree.sh pick dts <commit-id-to-be-picked>
> > 
> > You should have waited v6.16-rc1 tag to be synced into
> > devicetree-rebasing [2] for the cherry-picks to work. This way of
> > manually patching dts/upstream is not allowed since it is going to break
> > DT syncs in one way or another.
> > 
> > So I would suggest you to wait for v6.16-rc1 to land in DT rebasing tree
> > and then send v2 with proper cherry picked patches.
> > 
> > [1] https://docs.u-boot.org/en/latest/develop/devicetree/control.html#resyncing-with-devicetree-rebasing
> > [2] https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git
> 
> To be honest, I don't think this is a big deal. Git will be merging
> based on content and not specific hashes. And in the case of conflicts I
> just copy the file from the tag to our tree.

The essential problem here to me is we are going to allow manual
patching of dts/upstream tree given this example? How do we keep track
if all that manual patching landed in Linux DT mainline? The cherry
picks ensured that we always keep in sync with mainline.

Lets take an example what if Git automatically resolved a merge conflict
for you with duplicated content or if manually patching a DTS file
diverged from upstream and get unnoticed during DT syncs?

IMHO, we should try to avoid manual patching of DT subtree otherwise it
is hard to set a policy as to what level of manual patching is allowed
or not.

-Sumit
