Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A72AAFD7F91
	for <u-boot@archiver.kernel.org>; Fri, 27 Feb 2026 10:40:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CA0E83AA9;
	Fri, 27 Feb 2026 11:40:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="FoL8QgBD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4632B83BB1; Fri, 27 Feb 2026 11:40:47 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B22E783642
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 11:40:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it
 [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id BBAB122B15;
 Fri, 27 Feb 2026 11:40:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1772188843;
 bh=ZRxjvZt4Br2eXlLpdw4LBQzPXaftgap0sfgEEbKSSK0=;
 h=Received:From:To:Subject;
 b=FoL8QgBD2ymm0o+tRUUzngbkhsQL0ZR2/QyqzdzUsL1JMlKZ3b+yo7PrU7zCd5f1s
 nv/j7KReEHfeHXuem5SXtCPzviDbVqMnjKrTVp91IQBvvdm2e4zetLsAVsaVj6iUC8
 QHYTUNsbTwP1ioSczy60C+TyBqesKcQpSyVU/IbwVCIpbCe1c+pKyMBoI7/EMccPXZ
 e8AcSPDCL5IFtthJAaPUkrjFbWPWaMSlhxWNpqiHZAkVRncFTOnk2srD6c/Zzor4b5
 m4ZzqDz3QJy9YLBqPwLm6+RBb7ey3qtChtKz+NPS2nw6AlnFrRIwDiPne06xcQ4q4g
 6/IEDUVF9ZLKg==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
 id 760077FA9E; Fri, 27 Feb 2026 11:40:43 +0100 (CET)
Date: Fri, 27 Feb 2026 11:40:43 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Tom Rini <trini@konsulko.com>, "Francis, Neha" <n-francis@ti.com>
Cc: Stefan Eichenberger <eichest@gmail.com>,
 Francesco Dolcini <francesco@dolcini.it>,
 Emanuele Ghidoli <ghidoliemanuele@gmail.com>,
 stefan.eichenberger@toradex.com, s-k6@ti.com, w.egorov@phytec.de,
 emanuele.ghidoli@toradex.com, francesco.dolcini@toradex.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH v1] common/memsize.c: Fix get_ram_size() original data
 restore
Message-ID: <aaF0q0QZvAdmN_m5@gaggiata.pivistrello.it>
References: <20250314100734.23777-1-eichest@gmail.com>
 <20260226070502.GA6701@francesco-nb>
 <20260226142345.GB1593142@bill-the-cat>
 <20260226160901.GA29510@francesco-nb>
 <aaB1DifzODCVv4SU@eichest-laptop>
 <20260226163117.GJ1593142@bill-the-cat>
 <c8e7db77-5c9f-490c-a5e5-30607fde09aa@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8e7db77-5c9f-490c-a5e5-30607fde09aa@ti.com>
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

On Fri, Feb 27, 2026 at 03:43:07PM +0530, Francis, Neha wrote:
> On 2/26/2026 10:01 PM, Tom Rini wrote:
> > On Thu, Feb 26, 2026 at 05:30:06PM +0100, Stefan Eichenberger wrote:
> >> On Thu, Feb 26, 2026 at 05:11:49PM +0100, Francesco Dolcini wrote:
> >>> On Thu, Feb 26, 2026 at 08:23:45AM -0600, Tom Rini wrote:
> >>>> On Thu, Feb 26, 2026 at 08:05:02AM +0100, Francesco Dolcini wrote:
> >>>>> On Fri, Mar 14, 2025 at 11:06:49AM +0100, Stefan Eichenberger wrote:
> >>>>>> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> >>>>>>
> >>>>>> The get_ram_size() function fails to restore the original RAM data when
> >>>>>> the data cache is enabled. This issue was observed on an AM625 R5 SPL
> >>>>>> with 512MB of RAM and is a regression that became visible with
> >>>>>> commit bc07851897bd ("board: ti: Pull redundant DDR functions to a common
> >>>>>> location and Fixup DDR size when ECC is enabled").
> >>>>>>
> >>>>>> Observed boot failure messages:
> >>>>>>   Warning: Did not detect image signing certificate. Skipping authentication to prevent boot failure. This will fail on Security Enforcing(HS-SE) devices
> >>>>>>   Authentication passed
> >>>>>>   Starting ATF on ARM64 core...
> >>>>>>
> >>>>>> The system then hangs. This indicates that without a data cache flush,
> >>>>>> data in the cache is not coherent with RAM, preventing the system from
> >>>>>> booting. This was verified by printing the content of this address when
> >>>>>> the issue occurs.
> >>>>>>
> >>>>>> Add a data cache flush after each restore operation to resolve this
> >>>>>> issue.
> >>>>>>
> >>>>>> Fixes: bc07851897bd ("board: ti: Pull redundant DDR functions to a common location and Fixup DDR size when ECC is enabled")
> >>>>>> Fixes: 1c64b98c1ec4 ("common/memsize.c: Fix get_ram_size() when cache is enabled")
> >>>>>> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> >>>>>
> >>>>> Tom, can we merge this?
> >>>>> This is the last bit to solve the regression reported here,
> >>>>> https://lore.kernel.org/all/20260224152405.GD340942@francesco-nb/
> >>>>
> >>>> I wasn't happy with this at the time, and Stefan's last email in the
> >>>> thread left me with the impression more investigation was needed and
> >>>> likely something else was the root cause.
> >>>
> >>> I believe that this patch is needed.
> >>>
> >>> On AM62 what is happening is the following.
> >>>
> >>> We have a cortex-R5 that is the first core booting (there is also a
> >>> cortex-m4, but it's not relevant for this discussion).
> >>>
> >>> It runs from internal memory and it configures the DDR ram
> >>>
> >>> We load to DDR memory various pieces of firmware (TFA, U-Boot for the
> >>> cortex A53, ...)
> >>>
> >>> We do execute get_ram_size(), that read/write the memory, and it is
> >>> supposed to restore it back the original content
> >>>
> >>> However when we have the cache enabled, we might miss to write back the
> >>> original memory content, where the other pieces of firmware are.
> >>>
> >>> And after that we start the cortex A53, running in DDR, and there the
> >>> memory content might not be correct, because there is no cache coherency
> >>> between the cortex-A and the cortex-R. And because of that we have
> >>> crashes.
> >>>
> >>> Stefan: any comment here? Can you help?
> >>
> >> I think what you wrote summarises the issue well. If I recall correctly,
> >> I "fixed" the issue last time by simply calling get_ram_size() once
> >> before enabling the cache. This was in commit 4164289db882e. The SPL
> >> then informs U-Boot of the memory size via fdt fixup. However, something
> >> has probably changed now (possibly in the R5 SPL), meaning the cache is
> >> enabled earlier, so the cache is enabled again when get_ram_size() is
> >> called.
> >>
> >> For the AMP use case, either "get_ram_size" should not be called once
> >> the cache is enabled, or a similar patch to the one I proposed is
> >> required.
> > 
> > I would lean towards the former if at all possible.
> > 
> Just trying to understand, what is the reasoning behind ensuring get_ram_size is
> not called if cache is not enabled? Wasn't get_ram_size written with the
> possibility of cache being enabled (existence of dcache_en logic); then this
> patch is a valid fix right?

Yes, I am also confused about this.

Right now get_ram_size works well if cache is enabled ... apart this issue
in which the memory state is correct only from the CPU core that called the
function (or that we have some kind of HW cache coherency in place, but this is
not the case for AM62 A53/R5 cores).

If I have to solve the issue outside of get_ram_size(), I can either disable
the cache before calling it, or flush the whole cache to the DDR just afterward.

IOW, to me the patch is conceptually correct and I would apply it.

Francesco


