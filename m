Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42C7ACD4F25
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 15:20:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C32B846AC;
	Thu, 14 May 2026 17:20:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="VoxzyPLc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 463AC84694; Thu, 14 May 2026 17:05:20 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id CC15A846B1
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 17:05:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=harsimransingh.tungal@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D435B1C00;
 Thu, 14 May 2026 08:05:10 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.69.131])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D23A3F836;
 Thu, 14 May 2026 08:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1778771116; bh=ydukl6uYMZXgGT7/IDKzc8SW2+j+rhEeNqb1O3IuZvw=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
 b=VoxzyPLcxaB4ftBc4BdtYpBi0BIuXD1snicdtNE2Rf1BSII9CmN9+WsiyE4R8VQBo
 DVZcTZUar1Ol8rfkw7rraolqJ1JgtDv/Ir4QDurA5aZdNHoGvf/x6lKs3gTdJV8TnF
 JsYCTH7eimrLaiw192Bhh4D+nKoAJQsImueHoDZ8=
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 10/12] doc: arm64: document FF-A runtime path for EFI
 variables
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: Simon Glass <sjg@chromium.org>
Cc: harsimransingh.tungal@arm.com, u-boot@lists.denx.de, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>
In-Reply-To: <CAFLszTjvRPPY4Cb3X7CmKDwZNke6=mZGnFJ-H0+j1Ex5pXVCyw@mail.gmail.com>
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
 <20260424173151.371134-11-harsimransingh.tungal@arm.com>
 <CAFLszTjvRPPY4Cb3X7CmKDwZNke6=mZGnFJ-H0+j1Ex5pXVCyw@mail.gmail.com>
Date: Thu, 14 May 2026 16:05:08 +0100
Message-Id: <177877110822.2318147.14252019789985635442.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Thu, 14 May 2026 17:20:09 +0200
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

On 2026-04-28 12:08 -0600, Simon Glass wrote:
> Hi Harsimran,
> 
> On 2026-04-24T17:31:50, Harsimran Singh Tungal
> <harsimransingh.tungal@arm.com> wrote:
> > doc: arm64: document FF-A runtime path for EFI variables
> >
> > Document how EFI runtime variables use FF-A MM communication
> >
> > Describe the FF-A runtime layer on arm64 and how EFI variable
> > runtime services use the FF-A transport and shared MM buffer.
> > Also clarify armffa command scope and link to the FF-A doc.
> >
> > Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
> >
> > doc/arch/arm64.ffa.rst   | 92 ++++++++++++++++++++++++++++++++++++++++++++----
> >  doc/usage/cmd/armffa.rst | 11 ++++++
> >  2 files changed, 96 insertions(+), 7 deletions(-)
> 
> > diff --git a/doc/arch/arm64.ffa.rst b/doc/arch/arm64.ffa.rst
> > @@ -15,10 +15,10 @@ application in S-EL0, or a Trusted OS in S-EL1.
> > +U-Boot's FF-A bus support exposes an optional transport that EFI runtime
> > +services can use to communicate with Secure Partitions. Through this
> > +interface, EFI services (such as variable access) can request or exchange
> > +data with the Secure World using FF-A.
> 
> The rest of this file uses lower-case 'Secure world' (see lines 12 and
> 16). Please keep the capitalisation consistent throughout the new
> prose — also at the 'Secure World' in the runtime section below.
>

Thanks, I fixed the capitalization in v2.
Link to v2: https://lore.kernel.org/u-boot/20260514124924.1804332-1-harsimransingh.tungal@arm.com/

> > diff --git a/doc/arch/arm64.ffa.rst b/doc/arch/arm64.ffa.rst
> > @@ -158,6 +164,77 @@ they want to use (32-bit vs 64-bit). Selecting the protocol means using
> > +- The communication buffer is located at CONFIG_FFA_SHARED_MM_BUF_ADDR and
> > +  sized by CONFIG_FFA_SHARED_MM_BUF_SIZE.
> > +- CONFIG_FFA_SHARED_MM_BUF_OFFSET is sent in the FF-A direct message payload
> > +  to indicate where the data begins.
> > +- The buffer is filled by memcpy(), the cache is flushed before notifying the
> > +  MM SP, and later the buffer is reused directly with only the shared-buffer
> > +  range invalidated (invalidate_dcache_range()) to avoid whole-cache
> > +  invalidation.
> 
> This level of cache-maintenance detail is an implementation note and
> will go stale the moment the code is touched (and patch 12 is already
> touching it in this very series). I'd drop the third bullet and let
> the source comments have that, or move it under a clearly marked
> 'Implementation notes' sub-heading so readers know it is informative
> rather than contractual.
>

Thanks, agreed.

In v2, I dropped that cache-maintenance bullet and kept the section focused on the FF-A
runtime/MM buffer interface rather than implementation detail.

> > diff --git a/doc/arch/arm64.ffa.rst b/doc/arch/arm64.ffa.rst
> > @@ -158,6 +164,77 @@ they want to use (32-bit vs 64-bit). Selecting the protocol means using
> > +- get_comm_buf() switches to the static shared buffer
> > +- mm_communicate_runtime() selects FF-A transport when the runtime context
> > +  is enabled
> > +- ffa_mm_communicate_runtime() issues FFA_MSG_SEND_DIRECT_{REQ,RESP} through
> > +  ffa_sync_send_receive_runtime()
> 
> Naming specific static helpers in a public document ties the doc to
> current internal names. If one is renamed or refactored later, the doc
> silently lies. Please describe the flow at one level higher (e.g. 'the
> runtime path uses a static shared buffer and dispatches direct FF-A
> messages') and leave the function names to the source.
> 

Thanks, this makes sense to me.
In v2, I removed the internal helper names from that section and rewrote it at a higher level
in terms of the FF-A runtime transport, the shared MM buffer, and direct FF-A messaging
after ExitBootServices().

> >
> >     doc: arm64: document FF-A runtime path for EFI variables
> >
> >     Document how EFI runtime variables use FF-A MM communication
> >
> >     Describe the FF-A runtime layer on arm64 and how EFI variable
> >     runtime services use the FF-A transport and shared MM buffer.
> >     Also clarify armffa command scope and link to the FF-A doc.
> 
> The single-line paragraph just restates the subject and the next
> paragraph. U-Boot convention is to open with the motivation/problem -
> please replace this with a sentence explaining why the doc was
> previously incomplete (the previous text said runtime support was a
> future development) and what readers gain from the new sections.
> 
> Regards,
> Simon
> 

This has been updated in v2.
Thanks

Regards
Harsimran Singh Tungal

