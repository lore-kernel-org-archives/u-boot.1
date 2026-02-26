Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE891FD8FD3
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 16:11:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0ADC583D8A;
	Thu, 26 Feb 2026 17:11:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="dDRLVwtI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 177CB83E83; Thu, 26 Feb 2026 17:11:57 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2FB383AA9
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 17:11:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (xcpe-178-82-120-96.dyn.res.sunrise.net
 [178.82.120.96])
 by mail11.truemail.it (Postfix) with ESMTPA id 9D2E71FB45;
 Thu, 26 Feb 2026 17:11:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1772122314;
 bh=Q1cqXehaRM14LSi74n73rUZFC0315J0HZIlf/UnlVYE=; h=From:To:Subject;
 b=dDRLVwtIVar53rJPRvxY1uhWuKQS8LpqACEU62PskH/Xe/erknDLDwDz4F2A/nH65
 uzV1kmVVCqGjPEtupHs2nJSMT+StxjC8/ko2N4Ckw0gnY0EGoU7c+KX3SG4/sezkXK
 BmZMa/GySV/0Ba3EWxVcNZSo23+90zMn2P6Me+g+5oFJIgIfAEmh7tk3JFxgbo3LrW
 Wk92O0a+q4Gkb5t8mAAP9rhqkh8+soFk24IkCgQJEw2qtD+VZTzTrzTCv+6G9KsFuu
 JsM3I3WzDJCtjXaJAxkhncz2pzwT6cwY7sSeyvDw7XWZd1/K36DGxCRN/lLHZ7g8qj
 GyMU9oFWsuzQw==
Date: Thu, 26 Feb 2026 17:11:49 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Stefan Eichenberger <eichest@gmail.com>, Tom Rini <trini@konsulko.com>,
 Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
 stefan.eichenberger@toradex.com, s-k6@ti.com, w.egorov@phytec.de,
 n-francis@ti.com, emanuele.ghidoli@toradex.com,
 francesco.dolcini@toradex.com, u-boot@lists.denx.de
Subject: Re: [PATCH v1] common/memsize.c: Fix get_ram_size() original data
 restore
Message-ID: <20260226160901.GA29510@francesco-nb>
References: <20250314100734.23777-1-eichest@gmail.com>
 <20260226070502.GA6701@francesco-nb>
 <20260226142345.GB1593142@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226142345.GB1593142@bill-the-cat>
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

+Emanuele

Hello Tom,

On Thu, Feb 26, 2026 at 08:23:45AM -0600, Tom Rini wrote:
> On Thu, Feb 26, 2026 at 08:05:02AM +0100, Francesco Dolcini wrote:
> > Hello Tom,
> > 
> > On Fri, Mar 14, 2025 at 11:06:49AM +0100, Stefan Eichenberger wrote:
> > > From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > > 
> > > The get_ram_size() function fails to restore the original RAM data when
> > > the data cache is enabled. This issue was observed on an AM625 R5 SPL
> > > with 512MB of RAM and is a regression that became visible with
> > > commit bc07851897bd ("board: ti: Pull redundant DDR functions to a common
> > > location and Fixup DDR size when ECC is enabled").
> > > 
> > > Observed boot failure messages:
> > >   Warning: Did not detect image signing certificate. Skipping authentication to prevent boot failure. This will fail on Security Enforcing(HS-SE) devices
> > >   Authentication passed
> > >   Starting ATF on ARM64 core...
> > > 
> > > The system then hangs. This indicates that without a data cache flush,
> > > data in the cache is not coherent with RAM, preventing the system from
> > > booting. This was verified by printing the content of this address when
> > > the issue occurs.
> > > 
> > > Add a data cache flush after each restore operation to resolve this
> > > issue.
> > > 
> > > Fixes: bc07851897bd ("board: ti: Pull redundant DDR functions to a common location and Fixup DDR size when ECC is enabled")
> > > Fixes: 1c64b98c1ec4 ("common/memsize.c: Fix get_ram_size() when cache is enabled")
> > > Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > 
> > Tom, can we merge this?
> > This is the last bit to solve the regression reported here,
> > https://lore.kernel.org/all/20260224152405.GD340942@francesco-nb/
> 
> I wasn't happy with this at the time, and Stefan's last email in the
> thread left me with the impression more investigation was needed and
> likely something else was the root cause.

I believe that this patch is needed.

On AM62 what is happening is the following.

We have a cortex-R5 that is the first core booting (there is also a
cortex-m4, but it's not relevant for this discussion).

It runs from internal memory and it configures the DDR ram

We load to DDR memory various pieces of firmware (TFA, U-Boot for the
cortex A53, ...)

We do execute get_ram_size(), that read/write the memory, and it is
supposed to restore it back the original content

However when we have the cache enabled, we might miss to write back the
original memory content, where the other pieces of firmware are.

And after that we start the cortex A53, running in DDR, and there the
memory content might not be correct, because there is no cache coherency
between the cortex-A and the cortex-R. And because of that we have
crashes.

Stefan: any comment here? Can you help?

Francesco


