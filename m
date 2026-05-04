Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C12FF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 20:17:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECEA0846A1;
	Mon,  4 May 2026 22:17:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="ABf8Wffn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A49C846C3; Mon,  4 May 2026 22:17:02 +0200 (CEST)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18BA8846A0
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 22:16:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1777925814; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=hqxwv4Irn70GcfllCb3+H5HaDrq0Mla5OePHgdpYVL0SY+iNG3ii+VquySDkQF5VAQ3weDPaLm27Q1+cvb0aAouC4tzni/e5mx/WDFzWiJnf3IF1Ph2jzJ9PMw+NUsOxAPZZa8jtGE3Az2KvnyTZ9iPbSym5SPZvu0FJJeuWSDo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1777925814;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=hY9ac90sNL2KjdogaZPFtC3wFvzpMIt3C9omHT0eAeM=; 
 b=oFXwHHmYlMuFbn4LdA7Km3EFlw0WkoyJG3JpTj4OtHgLTYpGfX90eZOoHjLA+NiF7i+c7zgO1sSANb4s2+MqctEZDtngwW/nIfzoFoYabzAyAiBhe9Q22KZyzbDVfZyEEXduusPuntwCRpiyTnRDThDDrxJ082mozHXxKJjK0AU=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777925814; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=hY9ac90sNL2KjdogaZPFtC3wFvzpMIt3C9omHT0eAeM=;
 b=ABf8WffnbE+nKqKNhapVGDv+VVjuKbg1Sp4mPJM4vXnKA1ie9wMI9eeGru7ay5QC
 EZlYGMdU8VdInx0dj11MKbDZauRPkKgGo/ZlsvQkAmQOMSYn5wqFCWiy2tjeC0PquwD
 02xVJRQ9iQacnPZweapqJvF4MakMbf1P4Jm/lToA=
Received: by mx.zohomail.com with SMTPS id 1777925811896362.97701039650326;
 Mon, 4 May 2026 13:16:51 -0700 (PDT)
Date: Mon, 4 May 2026 20:16:40 +0000
From: Yao Zi <me@ziyao.cc>
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, git@amd.com
Cc: Leo <ycliang@andestech.com>, Rick Chen <rick@andestech.com>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] riscv: Skip riscv_cpu_setup() when CPU driver is disabled
Message-ID: <afj-qK8yzyGwn1bi@pie>
References: <0d875f98e9d81b68265ea26c379dae8ce5b1f5a9.1777550269.git.michal.simek@amd.com>
 <afRqUJZF81_y5K_O@pie>
 <45470f5f-f0f6-47f4-b87e-4c4c5d0cc9b8@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45470f5f-f0f6-47f4-b87e-4c4c5d0cc9b8@amd.com>
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

On Mon, May 04, 2026 at 11:00:17AM +0200, Michal Simek wrote:
> 
> 
> On 5/1/26 10:54, Yao Zi wrote:
> > On Thu, Apr 30, 2026 at 01:57:51PM +0200, Michal Simek wrote:
> > > Building on commit c64fc632a86a ("riscv: cpu: Use CONFIG_IS_ENABLED(CPU)
> > > instead of plain ifdef"), add an early return in riscv_cpu_setup() when
> > > CONFIG_CPU is not enabled. This allows platforms to save code space in
> > > SPL by disabling CONFIG_SPL_CPU.
> > > 
> > > The compiler's dead-code elimination combined with --gc-sections
> > > removes the unreachable code and all associated static data,
> > > achieving significant size reduction without preprocessor guards:
> > > 
> > >    spl/u-boot-spl:all -4332 spl/u-boot-spl:rodata -2872
> > >    spl/u-boot-spl:text -1460
> > > 
> > > Signed-off-by: Michal Simek <michal.simek@amd.com>
> > > ---
> > > 
> > >   arch/riscv/cpu/cpu.c | 3 +++
> > >   1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/arch/riscv/cpu/cpu.c b/arch/riscv/cpu/cpu.c
> > > index bbadd0c9a469..3bec7c7cb6d0 100644
> > > --- a/arch/riscv/cpu/cpu.c
> > > +++ b/arch/riscv/cpu/cpu.c
> > > @@ -638,6 +638,9 @@ int riscv_cpu_setup(void)
> > >   	const char *isa, **exts;
> > >   	struct udevice *dev;
> > > +	if (!CONFIG_IS_ENABLED(CPU))
> > > +		return 0;
> > 
> > Should we return zero here, or -ENOENT like the original behavior when
> > no UCLASS_CPU device is found?

My bad, the original return value when CONFIG_CPU is disabled should be
-ENODEV instead of -ENOENT. But in case that CONFIG_CPU is disabled,
-EOPNOTSUPP might be a better outcome. I don't have a strong opinion on
this.

> if you put there error value then when CONFIG_CPU is disable you get boot
> hang which is likely what you don't want to see right?
> 
> initcall_run_f(): initcall initf_dm() failed
> ### ERROR ### Please RESET the board ###

This should be the original behavior, i.e. U-Boot built with
CONFIG_CPU=n and CONFIG_EVENT=y is broken without this patch, too,
right?

int riscv_cpu_setup(void)
{
	int ret = -ENODEV, ext_count, i;
	const char *isa, **exts;
        struct udevice *dev;

	uclass_find_first_device(UCLASS_CPU, &dev);
	if (!dev) {
		debug("unable to find the RISC-V cpu device\n");
		return ret;
	}

...

}
EVENT_SPY_SIMPLE(EVT_DM_POST_INIT_F, riscv_cpu_setup);

When CONFIG_CPU is disabled, the call to uclass_find_first_device()
would always find no device, and riscv_cpu_setup() would return with
-ENODEV, causing the call to event_notify_null() in dm_init_and_scan()
to fail. We could fix this by guarding the instantiation of
EVENT_SPY_SIMPLE() within #if CONFIG_IS_ENABLED(CPU).

I consider returning with error a useful behavior, since there are raw
calls to this function (board/[starfive,thead]/*/spl.c), in which cases
a correct return value suggests something goes wrong, thus might help
debugging, for example, if someone turns off CONFIG_CPU but doesn't
expect the side effects.

Anyway, whether you agree on the return value or not, it should be
mentioned in the commit message that U-Boot built with CONFIG_CPU=n and
COFNIG_EVENT=y is broken without the patch.

> Thanks,
> Michal

Best regards,
Yao Zi
