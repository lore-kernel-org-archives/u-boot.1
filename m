Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D4EC0218A
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 16:46:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C992981DFA;
	Tue, 28 Jan 2025 17:46:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="wCyuvBuI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HhjaADhv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wCyuvBuI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HhjaADhv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4D0E81E51; Tue, 28 Jan 2025 17:46:06 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3A5181B4B
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 17:46:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=msuchanek@suse.de
Received: from kitsune.suse.cz (unknown [10.100.12.127])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0349F1F381;
 Tue, 28 Jan 2025 16:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738082764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Tvy06RU25wR7a6r00vs8BzgPUkhOG4R68gJd2jh1TQ8=;
 b=wCyuvBuIWEv61RrNAarB3I9GdubWN8HVmtaCL7bONkG1xUajbsoMcBPZqBI4ELkIbMzu/O
 /43JUTRz30tzL7AjDg+VQNoxvxuEv/6/2Sx9Atp5Cmk8y9XxXZ0Gs9izn6Q6qXShJuQMzy
 zUmxi3pbyVDV06qFj5zBpEqK2Gnbybg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738082764;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Tvy06RU25wR7a6r00vs8BzgPUkhOG4R68gJd2jh1TQ8=;
 b=HhjaADhvxogsdsr6W9qSFBCqVh98MEE0YBI2xypRZTuqzh5/NHPGCo+HyfWhtf7ERNY6OU
 cuMCxIqmNippk5DQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738082764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Tvy06RU25wR7a6r00vs8BzgPUkhOG4R68gJd2jh1TQ8=;
 b=wCyuvBuIWEv61RrNAarB3I9GdubWN8HVmtaCL7bONkG1xUajbsoMcBPZqBI4ELkIbMzu/O
 /43JUTRz30tzL7AjDg+VQNoxvxuEv/6/2Sx9Atp5Cmk8y9XxXZ0Gs9izn6Q6qXShJuQMzy
 zUmxi3pbyVDV06qFj5zBpEqK2Gnbybg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738082764;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Tvy06RU25wR7a6r00vs8BzgPUkhOG4R68gJd2jh1TQ8=;
 b=HhjaADhvxogsdsr6W9qSFBCqVh98MEE0YBI2xypRZTuqzh5/NHPGCo+HyfWhtf7ERNY6OU
 cuMCxIqmNippk5DQ==
Date: Tue, 28 Jan 2025 17:46:02 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Tom Rini <trini@konsulko.com>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, eugen.hristev@microchip.com,
 u-boot@lists.denx.de, sjg@chromium.org, xypron.glpk@gmx.de,
 michal.simek@amd.com, daniel.schwierzeck@gmail.com, marex@denx.de,
 alpernebiyasak@gmail.com
Subject: Re: [PATCH] lds: align u-boot-nodtb with 8 bytes boundary
Message-ID: <Z5kJyl354DO7uKCR@kitsune.suse.cz>
References: <20221215115825.827111-1-eugen.hristev@microchip.com>
 <87edsx4qzy.fsf@bloch.sibelius.xs4all.nl>
 <20221221215637.GA3787616@bill-the-cat>
 <87len02xan.fsf@bloch.sibelius.xs4all.nl>
 <20221221230910.GC3787616@bill-the-cat>
 <87k02k2vku.fsf@bloch.sibelius.xs4all.nl>
 <20221221234412.GE3787616@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221221234412.GE3787616@bill-the-cat>
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_ZERO(0.00)[0]; MISSING_XM_UA(0.00)[];
 TAGGED_RCPT(0.00)[]; RCPT_COUNT_SEVEN(0.00)[10];
 ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[xs4all.nl,gmx.de,gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[xs4all.nl,microchip.com,lists.denx.de,chromium.org,gmx.de,amd.com,gmail.com,denx.de];
 MIME_TRACE(0.00)[0:+]; FROM_EQ_ENVFROM(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_SOME(0.00)[]
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

Hello,

On Wed, Dec 21, 2022 at 06:44:12PM -0500, Tom Rini wrote:
> On Thu, Dec 22, 2022 at 12:20:01AM +0100, Mark Kettenis wrote:
> > > Date: Wed, 21 Dec 2022 18:09:10 -0500
> > > From: Tom Rini <trini@konsulko.com>
> > > 
> > > On Wed, Dec 21, 2022 at 11:42:56PM +0100, Mark Kettenis wrote:
> > > > > Date: Wed, 21 Dec 2022 16:56:37 -0500
> > > > > From: Tom Rini <trini@konsulko.com>
> > > > > 
> > > > > On Sat, Dec 17, 2022 at 11:14:41PM +0100, Mark Kettenis wrote:
> > > > > > > From: Eugen Hristev <eugen.hristev@microchip.com>
> > > > > > > Date: Thu, 15 Dec 2022 13:58:25 +0200
> > > > > > > 
> > > > > > > Newer DTC require that the DTB start address is aligned at 8 bytes.
> > > > > > > In the u-boot.bin case, the u-boot-nodtb.bin is concatenated with the
> > > > > > > DTB, but there is no alignment/padding to the next 8byte aligned address.
> > > > > > > This causes the board to fail booting, because the FDT will claim
> > > > > > > that the DTB inside u-boot.bin is not a valid DTB, it will fail with
> > > > > > > -FDT_ERR_ALIGNMENT.
> > > > > > > To solve this, have the u-boot binary `_end` aligned with 8 bytes.
> > > > > > > The objcopy in the Makefile will create the u-boot-nodtb.bin and it has to
> > > > > > > be truncated to 8 bytes to correspond to the u-boot.map file which will
> > > > > > > have the `_end` aligned to 8 bytes.
> > > > > > > The lds files which use devicetrees have been changed to align the `_end`
> > > > > > > tag with 8 bytes.
> > > > > > > 
> > > > > > > This patch is also a prerequisite to have the possibility to update the
> > > > > > > dtc inside u-boot to newer versions (1.6.1+)
> > > > > > > 
> > > > > > > Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> > > > > > > ---
> > > > > > > Hi,
> > > > > > > 
> > > > > > > I could not test all affected boards, it's an impossible task.
> > > > > > > I tried this on at91 boards which I have, and ran the CI on denx.
> > > > > > > I cannot guarantee that no other boards are affected, so this patch is a bit
> > > > > > > of an RFC.
> > > > > > > If the u-boot-nodtb.bin does not have the size equal with the corresponding
> > > > > > > one in u-boot.map, the binary_size_check will fail at build time with
> > > > > > > something like this:
> > > > > > > 
> > > > > > > u-boot.map shows a binary size of 502684
> > > > > > > but u-boot-nodtb.bin shows 502688
> > > > > > > 
> > > > > > > Thanks,
> > > > > > > Eugen
> > > > > > > 
> > > > > > >  Makefile                                    | 2 ++
> > > > > > >  arch/arm/cpu/armv8/u-boot.lds               | 4 ++--
> > > > > > >  arch/arm/cpu/u-boot-spl.lds                 | 1 +
> > > > > > >  arch/arm/cpu/u-boot.lds                     | 1 +
> > > > > > >  arch/arm/lib/elf_arm_efi.lds                | 5 +++++
> > > > > > >  arch/arm/mach-at91/arm926ejs/u-boot-spl.lds | 2 +-
> > > > > > >  arch/arm/mach-at91/armv7/u-boot-spl.lds     | 2 +-
> > > > > > >  arch/arm/mach-zynq/u-boot-spl.lds           | 2 +-
> > > > > > >  arch/mips/cpu/u-boot.lds                    | 2 +-
> > > > > > >  arch/sandbox/cpu/u-boot.lds                 | 6 ++++++
> > > > > > >  arch/sh/cpu/u-boot.lds                      | 2 ++
> > > > > > >  board/ti/am335x/u-boot.lds                  | 1 +
> > > > > > >  tools/binman/test/u_boot_binman_embed.lds   | 2 +-
> > > > > > >  13 files changed, 25 insertions(+), 7 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/Makefile b/Makefile
> > > > > > > index 9d84f96481..b4d387bcce 100644
> > > > > > > --- a/Makefile
> > > > > > > +++ b/Makefile
> > > > > > > @@ -1317,6 +1317,8 @@ endif
> > > > > > >  
> > > > > > >  u-boot-nodtb.bin: u-boot FORCE
> > > > > > >  	$(call if_changed,objcopy_uboot)
> > > > > > > +# Make sure the size is 8 byte-aligned.
> > > > > > > +	@truncate -s %8 $@
> > > > > > 
> > > > > > $ truncate
> > > > > > ksh: truncate: not found
> > > > > > 
> > > > > > In other words: truncate(1) isn't a standard UNIX utility and not
> > > > > > present on OpenBSD for example.  It isn't part of POSIX and therefore
> > > > > > its usage is unportable.
> > > > > > 
> > > > > > Please find a different solution.
> > > > > 
> > > > > Ah yes. Can this perhaps be done with dd? A bit of looking around
> > > > > suggests that this might be a portable way to truncate a file to say 512
> > > > > bytes:
> > > > > dd if=/dev/urandom of=testfile bs=1 count=500
> > > > > dd if=/dev/null of=testfile bs=1 count=512
> > > > > 
> > > > > And then hexdump or whatever to see that the last 12 bytes are zero. Can
> > > > > you please test this on OpenBSD?  We'll need some shell work to get
> > > > > current byte size and make it 8-byte aligned, but that should be
> > > > > portable at least.  Thanks!
> > > > 
> > > > Hi Tom,
> > > > 
> > > > That results on a file with zero bytes on OpenBSD... but also on
> > > > Linux.  Did you intend to write something different?  I can't
> > > > immediately come up with a way to do this with dd(1).
> > > 
> > > Ah, I typod that, sorry!  I meant (and just re-checked):
> > > dd if=/dev/urandom of=testfile bs=1 count=500
> > > dd if=/dev/null of=testfile bs=1 seek=512
> > > 
> > > Which here does:
> > > $ dd if=/dev/urandom of=testfile bs=1 count=500
> > > 500+0 records in
> > > 500+0 records out
> > > 500 bytes copied, 0.00641125 s, 78.0 kB/s
> > > $ dd if=/dev/null of=testfile bs=1 seek=512
> > > 0+0 records in
> > > 0+0 records out
> > > 0 bytes copied, 0.000358246 s, 0.0 kB/s
> > > $ ls -l testfile
> > > -rw-rw-r-- 1 trini trini 512 Dec 21 18:07 testfile
> > > $ hexdump testfile | tail -n2
> > > 00001f0 8cdd 300e 0000 0000 0000 0000 0000 0000
> > > 0000200
> > 
> > That works here as well.
> 
> Great, thanks!

dd also has also has the conv=sync option, at least on Linux:

dd if=/dev/urandom bs=1 count=20 of=testfile

dd if=testfile bs=8 conv=sync of=testfile_pad

Thanks

Michal
