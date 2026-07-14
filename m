Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46527C44508
	for <u-boot@archiver.kernel.org>; Tue, 14 Jul 2026 17:16:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FC0184D3B;
	Tue, 14 Jul 2026 19:16:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="WARJR7T/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29B8884D3C; Tue, 14 Jul 2026 19:16:09 +0200 (CEST)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DD3C84D22
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 19:16:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1784049361; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=USqQ+DNtpiiur33fbzyW/u30UL4gEc5IwQZn28ElNzf8VtkeKrxEY017QxbBhdPVrguV2bAhBOIyJ+tuHH1bDH40DvrbhGVq3DXWjLPv79jIa+46U8CqaFM5lEmwrf9s5mmUSGm5kvlpxEjTzMLW1iI/UXyzuZHDEjjrHAYmcVI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1784049361;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=LBH4dfQiyH+xf+3wQUaBgSDyLT8DeVU1PFqKTbWbtxg=; 
 b=Q06cXLghaxtfqyHy1V/GtZyooimmuuBi92xyyuxjhN6gh2GcnWjUbmDptC8JG7zkSoJNpgPmZMylwZ3+r3QVzBItPU8q0Rb0lxfwpGwHOZxipk7FrQyaJV959E/4boz2H3v4bN+k5QJlIJ58vWVxDIlDeX7CjciJ7iFSh1SwTwk=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784049361; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=LBH4dfQiyH+xf+3wQUaBgSDyLT8DeVU1PFqKTbWbtxg=;
 b=WARJR7T/0rW5c2WHqVw/BYrgNYI0gpzNyDM9dObESFpF8CkUuVnUNVj0FaibKOHw
 /85QxjzW0MtxoVnepyTxJw22dRB43papKDGntIuRLtFJCdrw+bJlQ7WHc9Fovomzqyn
 CAJC2Zd/Adf/vweLEZbvFK6XLcADk3xpD7g1GDM0=
Received: by mx.zohomail.com with SMTPS id 1784049358117595.4586746767283;
 Tue, 14 Jul 2026 10:15:58 -0700 (PDT)
Date: Tue, 14 Jul 2026 17:15:53 +0000
From: Yao Zi <me@ziyao.cc>
To: Simon Glass <sjg@chromium.org>, me@ziyao.cc
Cc: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 13/16] timer: Add loongarch_timer driver
Message-ID: <alZuyTNY-oWH-YsL@pie>
References: <20260701111808.870705-1-me@ziyao.cc>
 <20260701111808.870705-14-me@ziyao.cc>
 <CAFLszTjRDnny3uqxHHbcg_h4pgF80c6_cy-8N_itADwNfEHLcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTjRDnny3uqxHHbcg_h4pgF80c6_cy-8N_itADwNfEHLcQ@mail.gmail.com>
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

On Thu, Jul 02, 2026 at 11:27:04AM +0100, Simon Glass wrote:
> Hi Yao,
> 
> On 2026-07-01T11:17:53, Yao Zi <me@ziyao.cc> wrote:
> > timer: Add loongarch_timer driver
> >
> > Implement a timer driver for LoongArch architecture driver.
> >
> > It's synced in hardware for every core in a system, and frequency
> > information can be gathered from CPUCFG instruction.
> >
> > It is not described in fdt, thus I have to declare a DRVINFO
> > for it.
> >
> > Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > Signed-off-by: Yao Zi <me@ziyao.cc>
> >
> > drivers/timer/Kconfig           |   8 +++
> >  drivers/timer/Makefile          |   1 +
> >  drivers/timer/loongarch_timer.c | 112 ++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 121 insertions(+)
> 
> > diff --git a/drivers/timer/loongarch_timer.c b/drivers/timer/loongarch_timer.c
> > @@ -0,0 +1,112 @@
> > +#include <dm.h>
> > +#include <errno.h>
> > +#include <timer.h>
> > +#include <asm/loongarch.h>
> 
> lldiv() is used below but div64.h is not included. Please add it
> (see riscv_timer.c).
> 
> > diff --git a/drivers/timer/loongarch_timer.c b/drivers/timer/loongarch_timer.c
> > @@ -0,0 +1,112 @@
> > +static int loongarch_timer_bind(struct udevice *dev)
> > +{
> > +     struct timer_dev_priv *uc_priv = dev_get_uclass_priv(dev);
> > +     u32 rate;
> > +
> > +     rate = loongarch_timer_get_freq_cpucfg();
> > +     uc_priv->clock_rate = rate;
> > +
> > +     return 0;
> > +}
> 
> This is wired up as .probe below, so please rename to
> loongarch_timer_probe(). Also, if loongarch_timer_get_freq_cpucfg()
> returns 0 (LLFTP not present, or CPUCFG5 reads back zero) the driver
> still probes with clock_rate=0, which then trips a divide-by-zero
> in timer_get_boot_us(). Perhaps return -EINVAL in that case?

In case of missing LLFTP, I think bailing out would be correct. I'd
prefer to return -ENODEV since LLFTP represents support for constant
frequency counter and timer, when it's missing we don't even have a
stable timer to poke at all.

And CPUCFG5 represents "the corresponding multiplication factor of the
clock used by the timer", thus I don't think CPUCFG5 = 0 is a reasonable
hardware implementation, and prefer to ignore this case.

...

> Regards,
> Simon

Regards,
Yao Zi
