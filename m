Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B5CC3ABBC
	for <u-boot@archiver.kernel.org>; Mon, 12 May 2025 09:22:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8352F8091A;
	Mon, 12 May 2025 11:22:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D10D828BC; Mon, 12 May 2025 11:22:00 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22F8980050
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 11:21:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 54C9LdiS078171
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Mon, 12 May 2025 17:21:39 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 May
 2025 17:21:39 +0800
Date: Mon, 12 May 2025 17:21:36 +0800
From: Leo Liang <ycliang@andestech.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
CC: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt
 <heinrich.schuchardt@canonical.com>,
 Rick Chen <rick@andestech.com>, Bin Meng <bmeng.cn@gmail.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] riscv: set the width of the physical address/size data
 type based on arch
Message-ID: <aCG9oFl1V5r4oNGX@swlinux02>
References: <20250506092401.646595-1-sughosh.ganu@linaro.org>
 <7c05f66b-1047-400a-816f-db0de0951def@canonical.com>
 <CADg8p94crfzYzhR+jFFFRR=Xp6wY3cADXSQmKxXvVgvn9GHBkA@mail.gmail.com>
 <CAM=mAO=8gP3J9Kt5ox-Gpd43s8ozZ+t42O4dBNnYV32hMS_pMg@mail.gmail.com>
 <CADg8p9547kkDg=N990eGqfOF+4e+vG1MRda-faKw7bXOn-2g+w@mail.gmail.com>
 <CADg8p94OcjLZxAyxuvAHCim2zAhdYEkp5cpegeN0oZ5dm9=hzw@mail.gmail.com>
 <20250507154839.GL5430@bill-the-cat>
 <CADg8p97Puqi5my9SXCjGFmJan3hC5xPFWa45+072hcPkwyR-WQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CADg8p97Puqi5my9SXCjGFmJan3hC5xPFWa45+072hcPkwyR-WQ@mail.gmail.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 54C9LdiS078171
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

On Thu, May 08, 2025 at 12:07:37AM +0530, Sughosh Ganu wrote:
> [EXTERNAL MAIL]
> 
> On Wed, 7 May 2025 at 21:18, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, May 07, 2025 at 03:11:38PM +0530, Sughosh Ganu wrote:
> > > On Wed, 7 May 2025 at 13:19, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > >
> > > > On Tue, 6 May 2025 at 16:35, Heinrich Schuchardt
> > > > <heinrich.schuchardt@canonical.com> wrote:
> > > > >
> > > > >
> > > > >
> > > > > Sughosh Ganu <sughosh.ganu@linaro.org> schrieb am Di., 6. Mai 2025, 12:50:
> > > > >>
> > > > >> On Tue, 6 May 2025 at 15:19, Heinrich Schuchardt
> > > > >> <heinrich.schuchardt@canonical.com> wrote:
> > > > >> >
> > > > >> > On 5/6/25 11:24, Sughosh Ganu wrote:
> > > > >> > > U-Boot has support for both the 32-bit and 64-bit RiscV platforms. Set
> > > > >> > > the width of the phys_{addr,size}_t data types based on the register
> > > > >> > > size of the architecture.
> > > > >> > >
> > > > >> > > Currently, even the 32-bit RiscV platforms have a 64-bit
> > > > >> > > phys_{addr,size}_t data types. This causes issues on the 32-bit
> > > > >> > > platforms, where the upper 32-bits of the variables of these types
> > > > >> > > can have junk data, and that can cause all kinds of side-effects.
> > > > >> >
> > > > >> > How could it be that the upper 32-bit have junk data?
> > > > >> >
> > > > >> > When we convert from a shorter variable the compiler should fill the
> > > > >> > upper bits with zero.
> > > > >>
> > > > >> That does not seem to be happening. The efi_fit test fails on the
> > > > >> qemu-riscv32 platform, when attempting to boot the OS from the FIT
> > > > >> image.
> > > > >>
> > > > >> These are the values of the base address that I see in the
> > > > >> _lmb_alloc_addr() function.
> > > > >>
> > > > >> _lmb_alloc_addr: 755, rgn => -1, base => 0x1a1c0e00802000bc, size => 0x50b1
> > > > >
> > > > >
> > > > > As you are running on QEMU you should be able to track down where the value is actually assigned with gdb. This could for instance be a buffer overrun.
> > > >
> > > > I was able to hook up gdb and re-create the issue. What I observe is
> > > > that when the lmb_allocate_mem() function is called, the base address
> > > > parameter, which is 64-bits, shows a value with the upper 32-bits not
> > > > zeroed out. So, this looks like a compiler issue, where the upper
> > > > 32-bits are not being zeroed out. Fwiw, this shows up with the
> > > > compiler being used in the CI environment, as well as the one that I
> > > > am using.
> > >
> > > Thinking a bit on this, I don't think this is a compiler issue. The
> > > problem is that we are using the ulong type in some places(especially
> > > in the boot* commands) for storing the address values, while we use
> > > phys_addr_t in other places. And because this is a pointer being
> > > passed across functions, when the data-type that the pointer is
> > > pointing to changes from a 32-bit to 64-bit value, the upper 32-bits
> > > get considered. So the issue is that we use ulong in some places, and
> > > phys_addr_t in others for storing the addresses.
> > >
> > > But I think that the solution for this(at least for now) is to set
> > > phys_addr_t based on the underlying architecture. In the long run,
> > > there needs to be an audit of the usage of ulong for storing
> > > addresses, and that needs to be changed to phys_addr_t.
> >
> > Thanks for digging in to this more. I agree with what you're saying here
> > for both the short and long term.
> 
> Heinrich and I had a discussion on IRC on this, and for the short
> term, it was decided to instead have the ulong values copied into a
> local variable of type phys_addr_t before calling the lmb API. This
> approach too will work for now. Heinrich is of the opinion that it
> would be better not to make the change to the riscv32 file as the
> maintainers think it appropriate to use u64 for phys_addr_t. I will be
> making this change as part of my upcoming version of the lmb API
> series. I will be on leave for the next week, and will send the v2
> once back. Thanks.
> 
> -sughosh

Hi Sughosh,

Thanks for fixing this! I will review the v2 patch as soon as posted.

Best regards,
Leo

> 
> >
> > --
> > Tom
