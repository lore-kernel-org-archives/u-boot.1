Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C31CD3447
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 10:34:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 560B784BDC;
	Fri,  8 May 2026 12:34:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="lsRCs5GQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76A5B84C19; Fri,  8 May 2026 12:34:38 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 556A884B56
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 12:34:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=abdellatif.elkhlifi@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 326E61BCA;
 Fri,  8 May 2026 03:34:30 -0700 (PDT)
Received: from e130802.arm.com (e130802.arm.com [10.1.29.54])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B2D673F763;
 Fri,  8 May 2026 03:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1778236475; bh=m7u2doM0wmeImW+ZaUZNmJjXQGW4YlM0ymH0Ks7vjiE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lsRCs5GQ0Wi5K4OYmifKPIl1RcYZ2z9VE6Qaz2l1uvR3xN1ukNul6AqvgE/00kOmv
 +1oP0Kf4q6rrGD176/uETHgTIctoQqC6NLhImt5BmJla1kJBW+OH0KzPWzw6tPERQ7
 n13TFuB3tyumSjAW7wX7btMEu7Gv3RdGerQ+vNUQ=
Date: Fri, 8 May 2026 11:34:25 +0100
From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
To: Simon Glass <sjg@chromium.org>, harsimransingh.tungal@arm.com
Cc: hugues.kambampiana@arm.com, ilias.apalodimas@linaro.org,
 trini@konsulko.com, u-boot@lists.denx.de, xypron.glpk@gmx.de
Subject: Re: [PATCH 12/12] efi_loader: align FF-A cache maintenance with
 runtime path
Message-ID: <af28MYL97NMcvsFz@e130802.arm.com>
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
 <20260424173151.371134-13-harsimransingh.tungal@arm.com>
 <CAFLszTjVEhDxLN0btbo=Uczr7QMQpJF-T_7Sp78vvft-FYTPZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTjVEhDxLN0btbo=Uczr7QMQpJF-T_7Sp78vvft-FYTPZQ@mail.gmail.com>
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

Hi Harsimran,

> On 2026-04-24T17:31:50, Harsimran Singh Tungal
> <harsimransingh.tungal@arm.com> wrote:
> > efi_loader: align FF-A cache maintenance with runtime path
> >
> > Match boot-time FF-A cache handling to runtime behavior
> >
> > The boot-time FF-A MM communication path used invalidate_dcache_all()
> > after copying the message into the shared buffer. This differs from the
> > runtime path, which performs range-based maintenance to avoid global cache
> > operations.
> >
> > Update ffa_mm_communicate() to use the same pattern as the runtime helper:
> > clean the shared buffer range before the SMC and invalidate the same range
> > after the response. This keeps boot-time and runtime behavior consistent
> > and avoids whole-cache invalidation.
> >
> > Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> > Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
> >
> > lib/efi_loader/efi_variable_tee.c | 33 ++++++++++++++++++++++++++-------
> >  1 file changed, 26 insertions(+), 7 deletions(-)
> 
> > diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
> > @@ -389,19 +389,38 @@ static efi_status_t ffa_mm_communicate(void *comm_buf, ulong comm_buf_size)
> >       memcpy(virt_shared_buf, comm_buf, tx_data_size);
> >
> >       /*
> > -      * The secure world might have cache disabled for
> > -      * the device region used for shared buffer (which is the case for Optee).
> > -      * In this case, the secure world reads the data from DRAM.
> > -      * Let's flush the cache so the DRAM is updated with the latest data.
> > +      * Shared buffer cache maintenance for FF-A / OP-TEE communication:
> > +      *
> > +      * NS -> S (request path):
> > +      *
> > +      * The non-secure side populates the shared buffer. If the buffer is cached
> > +      * in NS, the updated bytes may reside in dirty D-cache lines and not yet be
> > +      * visible in DDR. Since the secure world typically reads the shared buffer
> > +      * directly from DDR (e.g. with caches disabled / non-coherent mapping), we
> > +      * must clean the corresponding cache lines to the Point of Coherency (PoC)
> > +      * before entering secure world.
> > +      *
> > +      * S -> NS (response path):
> > +      *
> > +      * The secure world may update the same shared buffer in DDR. After returning
> > +      * to non-secure, any cached copies of that region in NS may be stale. We
> > +      * therefore invalidate the shared buffer range after the FF-A call to drop
> > +      * those lines and force subsequent reads to fetch the latest data from DDR.
> >        */
> 
> This 20-line comment is now duplicated verbatim with the one in
> ffa_mm_communicate_runtime() introduced earlier in the series. Please
> factor the clean-before / invalidate-after sequence into a small
> helper (e.g. ffa_mm_buf_pre_call() / ffa_mm_buf_post_call()) so the
> commentary lives in one place and the two paths cannot drift. The
> runtime helper would add the extra 'no whole-cache invalidation after
> ExitBootServices()' note at the call site.
> 
> > diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
> > @@ -389,19 +389,38 @@ static efi_status_t ffa_mm_communicate(void *comm_buf, ulong comm_buf_size)
> > -#ifdef CONFIG_ARM64
> > -     invalidate_dcache_all();
> > -#endif
> > +     if (IS_ENABLED(CONFIG_ARM64))
> > +             flush_dcache_range((unsigned long)virt_shared_buf,
> > +                                (unsigned long)virt_shared_buf +
> > +                                CONFIG_FFA_SHARED_MM_BUF_SIZE);
> 
> Just to check - flush_dcache_range() and invalidate_dcache_range() on
> arm64 require start and end to be cache-line aligned, otherwise the
> arch code warns and falls back to clean+invalidate of the partial
> lines. CONFIG_FFA_SHARED_MM_BUF_ADDR and _SIZE need to be at least
> CONFIG_SYS_CACHELINE_SIZE aligned - is that documented or enforced
> anywhere? You could use BUILD_BUG_ON() near the call, perhaps?

Let's make sure the CONFIG_FFA_SHARED_MM_BUF_ADDR and _SIZE
are CONFIG_SYS_CACHELINE_SIZE aligned and document that in the Kconfig file.
It is also a good idea to add the BUILD_BUG_ON() check.

Regards,
Abdellatif
