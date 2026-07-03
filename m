Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B709DC43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 20:12:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6097849F0;
	Fri,  3 Jul 2026 22:12:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="P6y7HTmX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2ED0684A0A; Fri,  3 Jul 2026 22:12:42 +0200 (CEST)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5C73849E5
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 22:12:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1783109553; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ioP93BbJB2icJf6y85l32DNZSwCmuKNzOWwY1aF3/+S9Ueixe1essXELZrUFPPSiPzB7HxYdn7xD+xWVDfJKa7eKUtaK0UOF6t3GZTr2zLk6sCTa38RJvGrnfmsDFv9jfhDy1gMHfMjNRFD0NnG3SyIk9Guqz2/WQ+dn0Fgy66w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1783109553;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=oVNgCarCbScWcpJKolqogpRRzWN+IjS5QvOrFS0JLo4=; 
 b=kcL+4vtfZcreb+Uww0h39wV6R42rb5lUks+31LkCq/oLUCYREgsk57trWAC/i0HTSNnpOu3RpbKwuy1ReVFhG1BBl7NDlhvE1U3pTmNLHZDi8qmFO6MIasHWeYX0vZ5k4Bh5UgZHOkPz639NBfIUM0Kr6PZgqnFKXKND6AWrp4Q=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783109553; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=oVNgCarCbScWcpJKolqogpRRzWN+IjS5QvOrFS0JLo4=;
 b=P6y7HTmXi5as5SNRL6q/VPsBMUl+MBJBP61qk5UT71TbRFzSGIM0D5ikFcMszdkh
 hjycr7p9Msi88IRzurW8rV4EtQ1Cmc/7zgxvSTDgcwjeLPBArNa+E3XV1XHG4oR/zVA
 rXKm+4g8va3dVX7mFotrVD9GjUEkk9vgfv9x5G/Y=
Received: by mx.zohomail.com with SMTPS id 1783109550304852.3402184971152;
 Fri, 3 Jul 2026 13:12:30 -0700 (PDT)
Date: Fri, 3 Jul 2026 20:12:12 +0000
From: Yao Zi <me@ziyao.cc>
To: Simon Glass <sjg@chromium.org>, me@ziyao.cc
Cc: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 08/16] LoongArch: CPU assembly routines
Message-ID: <akgXnCSJC3splAlp@pie>
References: <20260701111808.870705-1-me@ziyao.cc>
 <20260701111808.870705-9-me@ziyao.cc>
 <CAFLszTh8G5hxAOUocaaXffKA=7PM5sp90M3+JBsieG908nFBBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTh8G5hxAOUocaaXffKA=7PM5sp90M3+JBsieG908nFBBw@mail.gmail.com>
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

On Thu, Jul 02, 2026 at 11:25:39AM +0100, Simon Glass wrote:
> Hi Yao,
> 
> On 2026-07-01T11:17:53, Yao Zi <me@ziyao.cc> wrote:
> > LoongArch: CPU assembly routines
> >
> > start.S for initialisation, smp_secondary routine for
> > a spin-table like interface for secondary cpus.
> >
> > Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > Signed-off-by: Yao Zi <me@ziyao.cc>
> >
> > arch/loongarch/cpu/Makefile        |   4 +
> >  arch/loongarch/cpu/cpu.c           |  27 ++++++
> >  arch/loongarch/cpu/smp_secondary.S |  55 ++++++++++++
> >  arch/loongarch/cpu/start.S         | 170 +++++++++++++++++++++++++++++++++++++
> >  4 files changed, 256 insertions(+)

...

> > diff --git a/arch/loongarch/cpu/smp_secondary.S b/arch/loongarch/cpu/smp_secondary.S
> > @@ -0,0 +1,55 @@
> > +1:
> > +     /* Query spin table */
> > +     idle 0
> > +     nop
> > +     iocsrrd.w       t0, t1
> > +     beqz            t0, 1b
> 
> Is the nop after idle 0 required by the ISA (to guarantee the
> wake-up completes before the load) or just padding? A
> one-line comment would help.

I don't think such requirements exist, and LoongArch instructions are
always 4-byte so there's nothing to pad, too. This is likely
unintentionally left when re-writing the assembly, and I'll remove it
in the next version.

> Regards,
> Simon

Best regards,
Yao Zi
