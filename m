Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F4EAC47DDB
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 00:59:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE4E887895;
	Tue, 23 Jan 2024 01:59:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A91B87B41; Tue, 23 Jan 2024 01:59:30 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 522D887895;
 Tue, 23 Jan 2024 01:59:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 119101FB;
 Mon, 22 Jan 2024 17:00:13 -0800 (PST)
Received: from minigeek.lan (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE2983F762;
 Mon, 22 Jan 2024 16:59:23 -0800 (PST)
Date: Tue, 23 Jan 2024 00:58:34 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Tom Rini <trini@konsulko.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io, u-boot-custodians@lists.denx.de,
 sjg@chromium.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor@kernel.org, neil.armstrong@linaro.org, caleb.connolly@linaro.org,
 ff@shokubai.tech, daniel.thompson@linaro.org, dgilmore@fedoraproject.org,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org,
 b.galvani@gmail.com, xypron.glpk@gmx.de, michal.simek@amd.com,
 seanga2@gmail.com, rasmus.villemoes@prevas.dk, peng.fan@nxp.com,
 jh80.chung@samsung.com, rfried.dev@gmail.com, marex@denx.de,
 mibodhi@gmail.com, bb@ti.com, mark.kettenis@xs4all.nl
Subject: Re: [PATCH v4 00/11] An effort to bring DT bindings compliance
 within U-Boot
Message-ID: <20240123005834.4ab47bf5@minigeek.lan>
In-Reply-To: <20240122164959.GN3652023@bill-the-cat>
References: <20240110103547.719757-1-sumit.garg@linaro.org>
 <20240122114515.760e9cd3@donnerap.manchester.arm.com>
 <20240122164959.GN3652023@bill-the-cat>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
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

On Mon, 22 Jan 2024 11:49:59 -0500
Tom Rini <trini@konsulko.com> wrote:

Hi Tom,

> On Mon, Jan 22, 2024 at 11:45:15AM +0000, Andre Przywara wrote:
> > On Wed, 10 Jan 2024 16:05:36 +0530
> > Sumit Garg <sumit.garg@linaro.org> wrote:
> > 
> > Hi,
> > 
> > I certainly welcome this more automatic synchronisation of the DTs,
> > however have one comment about the upcoming sync process:
> >   
> > > ...
> > > However, Linux kernel DT maintainers proposed [2] for U-Boot to rather
> > > use devicetree-rebasing repo [3] which is a forked copy from Linux
> > > kernel for DT source files as well as bindings. It is tagged at every
> > > Linux kernel major release or intermideate release candidates. So here I
> > > have tried to reuse that to bring DT bingings compliance as well as a
> > > standard way to maintain a regular sync of DT source files with Linux
> > > kernel.
> > > 
> > > In order to maintain devicetree files sync, U-Boot will maintains a Git
> > > subtree for devicetee-rebasing repo as `dts/upstream` sub-directory.
> > > U-Boot will regularly sync `dts/upstream/` subtree whenever the next window
> > > opens with the next available kernel major release.  
> > 
> > I hope this doesn't need to stay that restricted? Can we either sync more
> > often, or at least on the kernel's -rc1, and not only on a "full" release?
> > 
> > The reason I ask is that we have a chicken-egg problem here: without a DT
> > merged into the kernel tree, no U-Boot board support can be merged. And
> > without U-Boot support, we cannot boot a kernel, at least not in the
> > canonical way.
> > 
> > Since the U-Boot and kernel merge windows are not in phase, for sunxi I try
> > to sync the kernel DTs either as early as possible (-rc1, sometimes even
> > before, when the maintainers have merged them into their tree), or
> > sometimes "out of season", if a board defconfig patch is coming up.
> > 
> > Otherwise new board support, which typically has a very low regression risk
> > for the rest of the code base, would need to be delayed until the next
> > release. In the worst case the U-Boot merge windows opens one week before
> > a kernel release, then new boards need to wait three months?  
> 
> Would it be to bad to bring in board X with OF_UPSTREAM=n for one U-Boot
> release, and then with the next one switch to OF_UPSTREAM=y (and delete
> the dts from arch/) for the next release, when we would have gotten back
> in sync?

Ah, I didn't look into the actual patches, but if this provision is
there, that sounds surely acceptable. It might still be good to sync
earlier than the .0 kernel release: if it appears in Linus' tree, it
had already seen a good share of review and testing. And with the
U-Boot releases being always further away than the next kernel release,
we could pull fixes still in time. So we could pick the latest -rc (or
.0 release, whichever is more recent) when the U-Boot merge window
opens?

Cheers,
Andre
