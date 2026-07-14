Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8B16C44508
	for <u-boot@archiver.kernel.org>; Tue, 14 Jul 2026 17:20:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0443D84D54;
	Tue, 14 Jul 2026 19:20:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="A2FWITWa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D736484D55; Tue, 14 Jul 2026 19:20:41 +0200 (CEST)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CE0184D22
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 19:20:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1784049627; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=KpBGuuUhOoGA/dwfvFyOVtwPJDsQ8DyuEsPRXlPsDCfZqWR6hYM9Nno3k1cRRUYSAv3xqPjp05AsC32yuhVMk12Ozw/11FPULzndxJ70XcO0HEjQaeJilDtdQDVEyuEIgKtJkcQRHr4fY9SCJA6y8uv2kpNRueIbeW+u9mMloKc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1784049627;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Szr9Mliar2dRZ5VYXdRsL/7qC2klDhCQ9wzOAbgVVJI=; 
 b=HiLbZBmBQCVdwyD9dmFOgsBvGymDTWkNd9iCuD89ClCKblDRl5f48hIp26tF6c7vIerxPplqbk2dXGooNDFMSvY6fPMUaOwvsHdva5ei7awURYEDF//Xrdszvpw7++JFNfDJYpART2LZy8lRpumbRgqkd2LTBewu6YPUGx2f0uw=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784049627; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=Szr9Mliar2dRZ5VYXdRsL/7qC2klDhCQ9wzOAbgVVJI=;
 b=A2FWITWaAWkotIDQ3XDeKGVZmpaqx5l4ZfhW0/fo96Qh75CvDz9xhPnJI+CM7sy+
 WvZmHR1x3N4yr0Ky/0TdJnS9pYrPcu9G2sdosZUq1AZuxNgGF7Yq9pdDN5gwoSBKixT
 hY+DgOeScVZBPhOu+8imzHgHdM1QopOSwciD30fA=
Received: by mx.zohomail.com with SMTPS id 1784049623290352.1806624012322;
 Tue, 14 Jul 2026 10:20:23 -0700 (PDT)
Date: Tue, 14 Jul 2026 17:20:17 +0000
From: Yao Zi <me@ziyao.cc>
To: Simon Glass <sjg@chromium.org>, me@ziyao.cc
Cc: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 15/16] efi: LoongArch: Define LoongArch bits everywhere
Message-ID: <alZv0aZPHb-xed4F@pie>
References: <20260701111808.870705-1-me@ziyao.cc>
 <20260701111808.870705-16-me@ziyao.cc>
 <CAFLszTihFKatBwxu6YeQDJZvXcbp6_s07Xtgb5STPREGU8K8LA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTihFKatBwxu6YeQDJZvXcbp6_s07Xtgb5STPREGU8K8LA@mail.gmail.com>
X-ZohoMailClient: External
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

On Thu, Jul 02, 2026 at 11:27:36AM +0100, Simon Glass wrote:
> Hi Yao,
> 
> On 2026-07-01T11:17:53, Yao Zi <me@ziyao.cc> wrote:
> > efi: LoongArch: Define LoongArch bits everywhere
> >
> > They are all coming from UEFI specification, PE-COFF specification,
> > or IANA websites.
> >
> > Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > Signed-off-by: Yao Zi <me@ziyao.cc>
> >
> > include/asm-generic/pe.h                          | 2 ++
> >  include/config_distro_bootcmd.h                   | 5 +++++
> >  include/pe.h                                      | 1 +
> >  lib/efi_loader/efi_helper.c                       | 4 ++++
> >  lib/efi_loader/efi_image_loader.c                 | 7 +++++++
> >  lib/efi_loader/efi_runtime.c                      | 4 ++++
> >  lib/efi_selftest/efi_selftest_miniapp_exception.c | 3 +++
> >  7 files changed, 26 insertions(+)
> 
> > They are all coming from UEFI specification, PE-COFF specification,
> > or IANA websites.

...

> > diff --git a/lib/efi_selftest/efi_selftest_miniapp_exception.c b/lib/efi_selftest/efi_selftest_miniapp_exception.c
> > @@ -35,6 +35,9 @@ efi_status_t EFIAPI efi_main(efi_handle_t handle,
> > +#elif defined(CONFIG_LOONGARCH)
> > +     /* ud 31 */
> > +     asm volatile (".word 0x386007ff\n");
> 
> The rest of the series keys off CONFIG_ARCH_LA64. Please pick one
> and use it consistently - otherwise a future LA32 build will
> trigger this ud but be missing all the other bits. Given Tom's
> suggestion on patch 6 to move to CONFIG_LOONGARCH, that is probably
> the way to unify it.

It's intended to use CONFIG_LOONGARCH instead of CONFIG_ARCH_LA64 here,
since this UD works for both LA32 and LA64. Could you please explain
what's wrong with having only this UD defined for the future LA32 port?

> > diff --git a/include/pe.h b/include/pe.h
> > @@ -194,6 +194,7 @@ typedef struct _IMAGE_RELOCATION
> > +#define IMAGE_REL_BASED_LOONGARCH64_MARK_LA  8 /* yes, 8 too */
> 
> The PE-COFF spec also defines IMAGE_REL_BASED_LOONGARCH32_MARK_LA
> (=8). Since __loongarch_grlen == 32 is handled in efi_image_loader.c
> below, it would be tidier to add both here even if only the 64-bit
> one is wired up today.

Okay.

> Regards,
> Simon
