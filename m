Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE152C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 20:40:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 293DA848BF;
	Thu,  2 Jul 2026 22:40:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="idXm66D1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33DD984A5B; Thu,  2 Jul 2026 22:40:43 +0200 (CEST)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC153847C8
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 22:40:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1783024836; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=K+/aVCcCipvfBP0Gj5RREptYg6PVjwipCiC6orF/TI2QvigZ/iST6t2KaqOHLZlyeW/3JjQ/ucBvnMsviog0SRuUbP5y0KAunfBtqzg2abNmAshCwg8wOwEighA26JpNhYo3zINuPAXga+iC5ZVnLQpgZBljtzVdNOeMnuEuHX0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1783024836;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=dmECCeTe+U4Brckvd259RwKXDdoDeeHcPqtozcy5llQ=; 
 b=edMw4kkCwqFaSJzhNGfNewr88WvyauC4xTrj9k5rg2UF/lLo6Bf2JXdry5fAL+tasFpGzbu4WMZIEWGKJg8QSO/iSEauC0Si5u/buKRaUb12hEAq6/RTDpX5v33tL10RqLx4eNRxNpMh0Q36P5V5buT24AdElw/BA+sHw3uSeKc=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783024836; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=dmECCeTe+U4Brckvd259RwKXDdoDeeHcPqtozcy5llQ=;
 b=idXm66D1CBupkIQphwkczoor7FV27oqgTI0A/QFJ5QS5r7A6lGo2cgNbCZcHsXS8
 ElwFxsCNKVQRo8GG3bMN0VEeK+UrwbzX7yV4FaxKhFULykywzDLGN8EqvMJo+Fn2mFK
 GwDFUPMCJ65kQ7Rpskjp8bamVmdgeGYvuUBFMgO4=
Received: by mx.zohomail.com with SMTPS id 1783024833802335.4026535169007;
 Thu, 2 Jul 2026 13:40:33 -0700 (PDT)
Date: Thu, 2 Jul 2026 20:40:24 +0000
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Yao Zi <me@ziyao.cc>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 06/16] LoongArch: skeleton and headers
Message-ID: <akbMS_bAY2s0AL7l@pie>
References: <20260701111808.870705-1-me@ziyao.cc>
 <20260701111808.870705-7-me@ziyao.cc>
 <20260701174700.GO749385@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701174700.GO749385@bill-the-cat>
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

On Wed, Jul 01, 2026 at 11:47:00AM -0600, Tom Rini wrote:
> On Wed, Jul 01, 2026 at 11:17:58AM +0000, Yao Zi wrote:
> 
> > From: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > 
> > Commit for directories, Kconfig, Makefile and headers
> > 
> > Some of them are copied from linux, some of them are derived
> > from other architectures, the rest are wriiten on my own.
> > 
> > Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > Signed-off-by: Yao Zi <me@ziyao.cc>
> > ---
> > 
> > Hi Heinrich,
> > 
> > I kept the naming of CONFIG_ARCH_LA64 (instead of using the full name
> > ARCH_LOONGARCH64) since it's shorter, and we already have similar
> > CONFIG_ARCH_RV64I, and etc. in U-Boot. Is is okay for you?
> 
> We should use CONFIG_LOONGARCH here, to mirror the kernel I think. The
> CONFIG_ARCH_ namespace in U-Boot maps more to the usage of CONFIG_ARCH_
> in the kernel, for ARM (and ARM64) platforms rather than describing a
> CPU level architectural feature.

Oops, to make it clear, we do have a CONFIG_LOONGARCH symbol to
indicate LoongArch platforms, and CONFIG_ARCH_LA64 is for
distinguishing LA64 with LA32 and LA32R variants which would be
introduced in the future, just like the case of CONFIG_ARCH_RV32I and
CONFIG_ARCH_RV64I. Does this make sense for you?

> -- 
> Tom

Regards,
Yao Zi
