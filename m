Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29FD8C44508
	for <u-boot@archiver.kernel.org>; Tue, 14 Jul 2026 17:33:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55E2484D56;
	Tue, 14 Jul 2026 19:33:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="lLGUMT52";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0678784D57; Tue, 14 Jul 2026 19:33:24 +0200 (CEST)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29CDB84D52
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 19:33:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1784050396; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=iXOgPE0Jj2fMfUalacojDdRxRnXayGLQddec073lGjg7TjODo+Uu2pfHeFWQ7zNaWCcLyBXXI7VVIf8IUHtBitRXqmBXcWW2xhGPYPEDszTs0V9TQrTiuzyR3rKYFpyTl0Tu5kMPY8oYefBV7NTzPkB4dXf/hmD/dg/8HEPU5PY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1784050396;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=bV7Mn8XhCIkhGDSB4N+9PN/QYqKUxeRMpe17FLpfsJM=; 
 b=i0Emf7wK+0BZMyu7p/egagHWoyZf1ajcvXEiC4fMgSsStnl1mDdbBzTmuGoyPll/ySj9QqYTue5APTDpUDmTxtwhdISODFFm2MEDhItLSPOaoy/w40IAuHWuDrbsZ4Gr1g7UTkMKQGrSwzKOZGtj2ZaAXDBJwTtnU/dq7duJtPY=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784050396; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=bV7Mn8XhCIkhGDSB4N+9PN/QYqKUxeRMpe17FLpfsJM=;
 b=lLGUMT52AQ641rQAqJnN6Nb3DAjvSINuiPZ3qOFd0PqU01BRSjawQ6bQsaFnmwMF
 ZQnkVIQHoycRTU4pJ8v4HM5ref+NZI6Y3kY6kE7YwQsscKDVNN/NSwVJImh8uUGio2d
 WSci0VbhVNbG3S7FyGysHWwC1DpksCHNwcJtd1xY=
Received: by mx.zohomail.com with SMTPS id 17840503936621001.8849956683497;
 Tue, 14 Jul 2026 10:33:13 -0700 (PDT)
Date: Tue, 14 Jul 2026 17:33:09 +0000
From: Yao Zi <me@ziyao.cc>
To: Simon Glass <sjg@chromium.org>, me@ziyao.cc
Cc: u-boot@lists.denx.de
Subject: Re: [v2,00/16] LoongArch initial support
Message-ID: <alZy1VJfNjkoUNEU@pie>
References: <20260701111808.870705-1-me@ziyao.cc>
 <CAFLszThCoSOqG=7j3A8jDfVkzKj=m3GBG_NnKBbZHQ0-uq_WFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszThCoSOqG=7j3A8jDfVkzKj=m3GBG_NnKBbZHQ0-uq_WFg@mail.gmail.com>
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

On Thu, Jul 02, 2026 at 11:31:07AM +0100, Simon Glass wrote:
> Hi Yao,
> 
> On 2026-07-01T11:17:53, Yao Zi <me@ziyao.cc> wrote:
> 
> > So far this series has implemented general support for initializing CPU,
> > exceptions, kernel booting, CPU and timer drivers, QEMU LoongArch virt
> > machine support and UEFI standard compliant EFI booting support.
> 
> Thanks for picking this up. The split between generic and arch-specific
> changes makes review much easier.
> 
> I think Tom mentions this but please add doc/arch/loongarch.rst and
> doc/board/emulation/qemu-loongarch.rst

Okay, I'll add documentation in the next version.

> > board/emulation/qemu-loongarch/MAINTAINERS
> 
> The board has its own MAINTAINERS stanza but there is no top-level
> entry for arch/loongarch/. Please add one covering arch/loongarch/,
> drivers/cpu/loongarch_cpu.c and drivers/timer/loongarch_timer.c

I intentionally omit MAINTAINERS patch for architecture changes, since
we don't have a custodian tree and thus I'm not sure what I should fill
for the T: field, or just leave it alone. I've raised this question in
my previous reply to Tom's e-mail[1].

Thanks again for the detailed review.

> Regards,
> Simon

Regards,
Yao Zi

[1]: https://lore.kernel.org/u-boot/alZxPrNmjeVSsTUv@pie/
