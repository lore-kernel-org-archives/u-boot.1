Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D502EE57DF
	for <u-boot@archiver.kernel.org>; Mon, 11 Sep 2023 20:25:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E0B086CED;
	Mon, 11 Sep 2023 22:25:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="f88fzQON";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68FBD86E25; Mon, 11 Sep 2023 22:25:21 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD47086284
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 22:25:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 4d0e9d1b-50e1-11ee-b85c-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 4d0e9d1b-50e1-11ee-b85c-005056992ed3;
 Mon, 11 Sep 2023 22:25:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=WOsbYcz8Y3W5UxyKdPNcPxXtlvtlyz0Bk25Lc0lLlj0=;
 b=f88fzQON3RQAilUyQUf/wCC1+oBpEfqDqycsOW4IInl55qgDSZ3zATmU1cBNJttr84k2tVviPD7Qu
 3cpxjZ5/LyFZT/OdTRdX1Plc/TsFXhGJlSMzDQNrwCU9laYSf/CyIUX6tNfcytM86ebIp3yJlHhlvC
 fSqgPE8ga2RnvErTZQ9LVaxJ6fOxt5/hjiif+QIVAJBgyox3OTehE/5Pgi/Sp0GOmgfB4WAsCAvHJk
 F+Cv7UQkPmgNDU+lae1RTv/vWRjTnnB7AO02RnpEUVd3VcVHzkTSwkWpanVzJTRN+PnU3+d2924DIM
 6/sh8n5KlSXzWVvJYP9SnbKgjjVJqIw==
X-KPN-MID: 33|6bdKw/JTQP08RMVTMR3FSBUpd9Vjum9b4deQuknkBNwHfs1xyqsrzVi46e9GRUq
 U0Kqkhk1ijowOAoAz6NdZS1jACzyrZrrcCDRj4tjtYso=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|NMRy+zebjg7Fz8e0Akg8joiapOJHodWg73xk7X1zgyR4aMjJBIKy4Xxh9tib8nG
 NoaH4E4VfmEVT+iHi/K/teA==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 52312b81-50e1-11ee-ac77-00505699b758;
 Mon, 11 Sep 2023 22:25:17 +0200 (CEST)
Date: Mon, 11 Sep 2023 22:25:17 +0200
Message-Id: <87r0n4foeq.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Simon Glass <sjg@google.com>
Cc: j@jannau.net, kettenis@openbsd.org, trini@konsulko.com,
 u-boot@lists.denx.de
In-Reply-To: <CAPnjgZ0aDxNsqKzWcTDOq++4vC4j_VRQNqC0=LiL3As0d0H7Bg@mail.gmail.com>
 (message from Simon Glass on Sun, 10 Sep 2023 16:36:48 -0600)
Subject: Re: [PATCH] arm: apple: Add initial Apple M2 Ultra support
References: <20230906-apple_t6022_m2_ultra-v1-1-7d28623285bc@jannau.net>
 <CAPnjgZ0aDxNsqKzWcTDOq++4vC4j_VRQNqC0=LiL3As0d0H7Bg@mail.gmail.com>
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

> From: Simon Glass <sjg@google.com>
> Date: Sun, 10 Sep 2023 16:36:48 -0600
> 
> Hi,
> 
> On Wed, 6 Sept 2023 at 15:50, Janne Grunau <j@jannau.net> wrote:
> >
> > Apple's M2 Ultra SoC are somewhat similar to the M1 Ultra but needs
> > a tweaked memory map as the M2 Pro/Max SoCs.  USB, NVMe, UART, WDT
> > and PCIe are working with the existing drivers.
> >
> > Signed-off-by: Janne Grunau <j@jannau.net>
> > ---
> >  arch/arm/mach-apple/board.c | 183 ++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 183 insertions(+)
> >
> > diff --git a/arch/arm/mach-apple/board.c b/arch/arm/mach-apple/board.c
> > index d50194811843..47393babbc62 100644
> > --- a/arch/arm/mach-apple/board.c
> > +++ b/arch/arm/mach-apple/board.c
> > @@ -444,6 +444,187 @@ static struct mm_region t6020_mem_map[] = {
> >         }
> >  };
> >
> > +/* Apple M2 Ultra */
> > +
> > +static struct mm_region t6022_mem_map[] = {
> > +       {
> > +               /* I/O */
> > +               .virt = 0x280000000,
> > +               .phys = 0x280000000,
> > +               .size = SZ_1G,
> > +               .attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> > +                        PTE_BLOCK_NON_SHARE |
> > +                        PTE_BLOCK_PXN | PTE_BLOCK_UXN
> > +       }, {
> 
> Is there no devicetree binding for this information?

Not directly.  The device tree does contain the addresses of the
devices of course.  But what we want here is a memory map that uses a
few big ranges that cover all the devices in the device tree rather
than lots of small ranges that cover the individual devices.

But yes, it sucks that every time Apple produces a new SoC we need to
add another memory map.
