Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A94F0C02193
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 08:50:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3AB28082A;
	Wed, 29 Jan 2025 09:50:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="Z0TSHxOD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50CA080834; Wed, 29 Jan 2025 09:50:08 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 100B580821
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 09:50:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 0883829b-de1e-11ef-9de5-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 0883829b-de1e-11ef-9de5-00505699b430;
 Wed, 29 Jan 2025 09:50:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=content-type:mime-version:subject:to:from:message-id:date;
 bh=g7STYjVl6uonFaEfDSmXiA1D5iurAXcXFecchZ5Wruw=;
 b=Z0TSHxODwLtmqamHQzy3olYQdR21Jum2kWUmyYr9j1EDj7ujLWHeNolJZ9Flzo4e8bhVdSQylsOW3
 nBrJrV7zLrjaJJq2cjQdrcsR23MpgwGGwoZjRNVIyNOxZK3HTLgWUClNc6M4Cl52W2NA0PvxWz3T+h
 YY3E6FNp1AbgWDq+jXLtBv2ItZkD49QV+UaASnZucgYtOrF8xfDLtxW/1KexcZLVzajf+TQWKoWH9g
 MbCk+/RAGsAyVhUtF91hnGHuOKZdw0//SiumuvtESXZSZtbikbsqYv8FrYlBqf761AFgeLmeDTQsT1
 kF5qPO3LD2TxwKDBuwCmbXGNN57o0pw==
X-KPN-MID: 33|qtoelbdiXF7Xv4WH2KzcVDq1wtxCyLCfq65Q51LKRyuLX8MGE5eQHy1zds6cH6A
 6DJjmB4V+5CtaGx0NJSwsGFbA4URbXL3qaMct0ven3jA=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|XKjlXn2PWWhjXT5w+LjE5zCjqbzR2VTYBtD5L1//lB8i2yugI3yf2aViywCMs74
 GH8EycAfeHL1LY84/7IyOBA==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 08c24fd9-de1e-11ef-9797-005056998788;
 Wed, 29 Jan 2025 09:50:05 +0100 (CET)
Date: Wed, 29 Jan 2025 09:50:04 +0100
Message-Id: <87h65ihumb.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Tom Rini <trini@konsulko.com>
Cc: msuchanek@suse.de, eugen.hristev@microchip.com,
 u-boot@lists.denx.de, sjg@chromium.org, xypron.glpk@gmx.de,
 michal.simek@amd.com, daniel.schwierzeck@gmail.com,
 marex@denx.de, alpernebiyasak@gmail.com
In-Reply-To: <20250128221559.GR1233568@bill-the-cat> (message from Tom Rini on
 Tue, 28 Jan 2025 16:15:59 -0600)
Subject: Re: [PATCH] lds: align u-boot-nodtb with 8 bytes boundary
References: <20221215115825.827111-1-eugen.hristev@microchip.com>
 <87edsx4qzy.fsf@bloch.sibelius.xs4all.nl>
 <20221221215637.GA3787616@bill-the-cat>
 <87len02xan.fsf@bloch.sibelius.xs4all.nl>
 <20221221230910.GC3787616@bill-the-cat>
 <87k02k2vku.fsf@bloch.sibelius.xs4all.nl>
 <20221221234412.GE3787616@bill-the-cat>
 <Z5kJyl354DO7uKCR@kitsune.suse.cz> <20250128221559.GR1233568@bill-the-cat>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
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

> Date: Tue, 28 Jan 2025 16:15:59 -0600
> From: Tom Rini <trini@konsulko.com>

Hi Tom,

> On Tue, Jan 28, 2025 at 05:46:02PM +0100, Michal Suchánek wrote:
> > Hello,
> > 
> > On Wed, Dec 21, 2022 at 06:44:12PM -0500, Tom Rini wrote:
> > > On Thu, Dec 22, 2022 at 12:20:01AM +0100, Mark Kettenis wrote:
> > > > > Date: Wed, 21 Dec 2022 18:09:10 -0500
> > > > > From: Tom Rini <trini@konsulko.com>
> > > > > 
> > > > > On Wed, Dec 21, 2022 at 11:42:56PM +0100, Mark Kettenis wrote:
> > > > > > > Date: Wed, 21 Dec 2022 16:56:37 -0500
> > > > > > > From: Tom Rini <trini@konsulko.com>
> > > > > > > 
> > > > > > > On Sat, Dec 17, 2022 at 11:14:41PM +0100, Mark Kettenis wrote:
> > > > > > > > > From: Eugen Hristev <eugen.hristev@microchip.com>
> > > > > > > > > Date: Thu, 15 Dec 2022 13:58:25 +0200
> > > > > > > > > 
> > > > > > > > > Newer DTC require that the DTB start address is aligned at 8 bytes.
> > > > > > > > > In the u-boot.bin case, the u-boot-nodtb.bin is concatenated with the
> > > > > > > > > DTB, but there is no alignment/padding to the next 8byte aligned address.
> > > > > > > > > This causes the board to fail booting, because the FDT will claim
> > > > > > > > > that the DTB inside u-boot.bin is not a valid DTB, it will fail with
> > > > > > > > > -FDT_ERR_ALIGNMENT.
> > > > > > > > > To solve this, have the u-boot binary `_end` aligned with 8 bytes.
> > > > > > > > > The objcopy in the Makefile will create the u-boot-nodtb.bin and it has to
> > > > > > > > > be truncated to 8 bytes to correspond to the u-boot.map file which will
> > > > > > > > > have the `_end` aligned to 8 bytes.
> > > > > > > > > The lds files which use devicetrees have been changed to align the `_end`
> > > > > > > > > tag with 8 bytes.
> > > > > > > > > 
> > > > > > > > > This patch is also a prerequisite to have the possibility to update the
> > > > > > > > > dtc inside u-boot to newer versions (1.6.1+)
> > > > > > > > > 
> > > > > > > > > Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> > > > > > > > > ---
> > > > > > > > > Hi,
> > > > > > > > > 
> > > > > > > > > I could not test all affected boards, it's an impossible task.
> > > > > > > > > I tried this on at91 boards which I have, and ran the CI on denx.
> > > > > > > > > I cannot guarantee that no other boards are affected, so this patch is a bit
> > > > > > > > > of an RFC.
> > > > > > > > > If the u-boot-nodtb.bin does not have the size equal with the corresponding
> > > > > > > > > one in u-boot.map, the binary_size_check will fail at build time with
> > > > > > > > > something like this:
> > > > > > > > > 
> > > > > > > > > u-boot.map shows a binary size of 502684
> > > > > > > > > but u-boot-nodtb.bin shows 502688
> > > > > > > > > 
> > > > > > > > > Thanks,
> > > > > > > > > Eugen
> > > > > > > > > 
> > > > > > > > >  Makefile                                    | 2 ++
> > > > > > > > >  arch/arm/cpu/armv8/u-boot.lds               | 4 ++--
> > > > > > > > >  arch/arm/cpu/u-boot-spl.lds                 | 1 +
> > > > > > > > >  arch/arm/cpu/u-boot.lds                     | 1 +
> > > > > > > > >  arch/arm/lib/elf_arm_efi.lds                | 5 +++++
> > > > > > > > >  arch/arm/mach-at91/arm926ejs/u-boot-spl.lds | 2 +-
> > > > > > > > >  arch/arm/mach-at91/armv7/u-boot-spl.lds     | 2 +-
> > > > > > > > >  arch/arm/mach-zynq/u-boot-spl.lds           | 2 +-
> > > > > > > > >  arch/mips/cpu/u-boot.lds                    | 2 +-
> > > > > > > > >  arch/sandbox/cpu/u-boot.lds                 | 6 ++++++
> > > > > > > > >  arch/sh/cpu/u-boot.lds                      | 2 ++
> > > > > > > > >  board/ti/am335x/u-boot.lds                  | 1 +
> > > > > > > > >  tools/binman/test/u_boot_binman_embed.lds   | 2 +-
> > > > > > > > >  13 files changed, 25 insertions(+), 7 deletions(-)
> > > > > > > > > 
> > > > > > > > > diff --git a/Makefile b/Makefile
> > > > > > > > > index 9d84f96481..b4d387bcce 100644
> > > > > > > > > --- a/Makefile
> > > > > > > > > +++ b/Makefile
> > > > > > > > > @@ -1317,6 +1317,8 @@ endif
> > > > > > > > >  
> > > > > > > > >  u-boot-nodtb.bin: u-boot FORCE
> > > > > > > > >  	$(call if_changed,objcopy_uboot)
> > > > > > > > > +# Make sure the size is 8 byte-aligned.
> > > > > > > > > +	@truncate -s %8 $@
> > > > > > > > 
> > > > > > > > $ truncate
> > > > > > > > ksh: truncate: not found
> > > > > > > > 
> > > > > > > > In other words: truncate(1) isn't a standard UNIX utility and not
> > > > > > > > present on OpenBSD for example.  It isn't part of POSIX and therefore
> > > > > > > > its usage is unportable.
> > > > > > > > 
> > > > > > > > Please find a different solution.
> > > > > > > 
> > > > > > > Ah yes. Can this perhaps be done with dd? A bit of looking around
> > > > > > > suggests that this might be a portable way to truncate a file to say 512
> > > > > > > bytes:
> > > > > > > dd if=/dev/urandom of=testfile bs=1 count=500
> > > > > > > dd if=/dev/null of=testfile bs=1 count=512
> > > > > > > 
> > > > > > > And then hexdump or whatever to see that the last 12 bytes are zero. Can
> > > > > > > you please test this on OpenBSD?  We'll need some shell work to get
> > > > > > > current byte size and make it 8-byte aligned, but that should be
> > > > > > > portable at least.  Thanks!
> > > > > > 
> > > > > > Hi Tom,
> > > > > > 
> > > > > > That results on a file with zero bytes on OpenBSD... but also on
> > > > > > Linux.  Did you intend to write something different?  I can't
> > > > > > immediately come up with a way to do this with dd(1).
> > > > > 
> > > > > Ah, I typod that, sorry!  I meant (and just re-checked):
> > > > > dd if=/dev/urandom of=testfile bs=1 count=500
> > > > > dd if=/dev/null of=testfile bs=1 seek=512
> > > > > 
> > > > > Which here does:
> > > > > $ dd if=/dev/urandom of=testfile bs=1 count=500
> > > > > 500+0 records in
> > > > > 500+0 records out
> > > > > 500 bytes copied, 0.00641125 s, 78.0 kB/s
> > > > > $ dd if=/dev/null of=testfile bs=1 seek=512
> > > > > 0+0 records in
> > > > > 0+0 records out
> > > > > 0 bytes copied, 0.000358246 s, 0.0 kB/s
> > > > > $ ls -l testfile
> > > > > -rw-rw-r-- 1 trini trini 512 Dec 21 18:07 testfile
> > > > > $ hexdump testfile | tail -n2
> > > > > 00001f0 8cdd 300e 0000 0000 0000 0000 0000 0000
> > > > > 0000200
> > > > 
> > > > That works here as well.
> > > 
> > > Great, thanks!
> > 
> > dd also has also has the conv=sync option, at least on Linux:
> > 
> > dd if=/dev/urandom bs=1 count=20 of=testfile
> > 
> > dd if=testfile bs=8 conv=sync of=testfile_pad
> 
> I spun up a test FreeBSD instance and this also worked as expected. Mark
> can you confirm OpenBSD also works as expected here? It would be good to
> fix this long running problem. Thanks!

yes, that seems to work

$ ls -l testfile testfile_pad
-rw-r--r--  1 kettenis  kettenis  20 Jan 29 09:45 testfile
-rw-r--r--  1 kettenis  kettenis  24 Jan 29 09:45 testfile_pad

and the file gets padded with zeroes (NUL characters).
