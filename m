Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B15CCCA6004
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 10:51:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2594D40861;
	Sat, 10 Oct 2026 10:51:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JKOKyy9Cc4s8; Sat, 10 Oct 2026 10:51:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 86D0A40821
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791629475;
	b=nGXOPl8NhaEvrpDlxg4W4QikrJ5KbjjeqQ6Zno1x83uKuoU1TRJ0TwV9TYYIqZMc2EOF
	 eFdXNEVEn9wCp8Cf+dCW2RhVM+0hiay/Mg9FplIjCUGz27X1cRfQLqmVtJ49hNo7eMPjU
	 HyZ5UluXYAiy1OS2iVS4xIVREexU+f/TZccEkGCvR6qBj3E5w5D/IJRv3azIFwEkJyMci
	 nv9xtvijk3FgYLyqIKOyQ1jJ9gBPND1biN7NoCwnzo1V8YirzmUXVEInMqbrijxywxRaQ
	 RdKUVY7rM9ChOzRrAnxhd6GTxnvQbD/zoIVufJmSCbaKHwY1dEDv+jOO5FyjuMLawMQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791629475;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:Content-Type:Mime-Version:Subject:From:
	 In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-ID:References:
	 To:X-Mailer:Feedback-ID:X-SES-Outgoing:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=SdBaOsVx4aU3xN4MeH04GKwi9H0A+3FsKN5S3zHUAFQ=;
	b=EoLGd30GZd3nmUaVFH7MJ7W6aG7eMK9ojgPQEGBGLISce8Kln7+5F4yYILIwgbmladTB
	 S7Ux+o4kFWbZ5ArlBqxRboCHgYqZXuIBxkxIMQsciPrXnLPpWmizGIqe1bgj2YXeoOaKi
	 TyKwrGRmUjrB2x+VwiI1ueThTf2d4vhibiLHl/Qq8cWdsVdOM834/z6flGTtGUPhJ4b+5
	 Z7lV5oF95E2X6MwyQnJLF3eBqxI0kS8IOrCHw3tVJfReeoRjHSEHxoUj+TLbJn/dN3ttG
	 8KudqT+n/6IxW0bE62xftrcLPyY5dhTn3AUR3WpPAptXagTC+B/MhpfGUo+u7tQLyvA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=freemyipod.org;
	dkim=pass header.d=freemyipod.org header.i=@freemyipod.org header.a=rsa-sha256 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=Cfr6v0fd;
	dkim=pass header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh header.b=WP2grDvc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791629475;
	bh=SdBaOsVx4aU3xN4MeH04GKwi9H0A+3FsKN5S3zHUAFQ=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WWBKmKdv8MGK7GpcbjUfyYupQV0Jg9bf6r7JQJZfVs+RjW6sLhilvY9aiuvtB2qjW
	 wwJuP6Th/cX2IF0Ey0d+fElJzDZktPWfzvBe0VTtbvJ/w2SNNFsxoeqtJLjWiv+UPt
	 juBHdV/01FssTzLbnHNI/RJwrnoQNgz/sgbsQIJYoOiKlW25YD/+GqER30JCCEjj5o
	 pwGPfGDTGQNRZzhyIdmgXLYV7w8OH3ZYxMYQPVISwX8Gb3d04aN6JDLUjVtwP6bgPs
	 RHDCNNKGBlOqY2n2bpb77gJp82/czT1RwPa9NdATorEw24qFZP+I2hd3MnwibRxzhO
	 us4Wbv8KbKmdw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 86D0A40821;
	Sat, 10 Oct 2026 10:51:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 27C0375
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 10:51:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 065CF40821
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 10:51:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tLHd9Kh__mXi for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 10:51:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E4D614081B
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=69.169.224.10
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791629472;
 b=rdoquLYeBYc3CdeUnWjTBbY4mQrXOF/f+ShHU0wl2s0/hzucKDRcJb2b85t2bXjpVQDJ
 P9p/+aV51Unk76mV5isgZvZwPj8wrrAj/DD4SNvDo6dqqbEOTgo0nl8NHVtpYHQIJVFcD
 LJvVOAh34E7txdDYwGp/MIUx4xeWHGD1ek28mvXF80c4JHA8h747dTsHLQaFJkVNSapR6
 TCIZ4vHxVOt62AC7qOC+HkacHwsNvyEFuYgZw46PnMQUHLXk2P5YOjp3WjYB3UbkbOfM/
 kMU+rcA4B78t2L+KeqlpHzrYYjmY5fpOcBry76aU4iYQI92PqokgQs3Zi8H9eS6k6NQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791629472;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:Content-Type:Mime-Version:
 Subject:From:In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-ID:
 References:To:X-Mailer:Feedback-ID:X-SES-Outgoing;
 bh=SdBaOsVx4aU3xN4MeH04GKwi9H0A+3FsKN5S3zHUAFQ=;
 b=Y8+NKs14mTukPNQdg2EKGjagCO9GqCVhRnIR46nbZErC7AMpeNfTt4zTbvu0OqcomTWq
 eTnfpc/w33r3UouYKNI8ZH4N4YsvG7cCtvV9VE3YpRs6wVUID2q4pwzBr+s4WCztqZ8m3
 CPQx7egMb+gcqWt/JM8Z5FO4kOx13sM/m6551JlzP/ToM9SPdGPy9XRUrLNAky5sW1/hy
 6tXnDGtP2MVQyy3rChpy3iRGMJ06RV0Umm9UYHKeRQfl5AWIm7HfvPQmEWmnY6Zuham+5
 yP/eGNMeYC+6BoDdcVilMpn7rbpi38fYvd025Tk/0KCYdXxlo26HNJgoA0+rvPgj+vw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=freemyipod.org;
 dkim=pass header.d=freemyipod.org header.i=@freemyipod.org header.a=rsa-sha256
 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=Cfr6v0fd; 
 dkim=pass header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256
 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh header.b=WP2grDvc; 
 arc=none smtp.remote-ip=69.169.224.10
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=69.169.224.10;
 helo=b224-10.smtp-out.eu-central-1.amazonses.com;
 envelope-from=010701a125702538-042eab3f-9dd5-4f9a-b8cd-8d60474a8910-000000@ses.freemyipod.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=freemyipod.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=freemyipod.org
 header.i=@freemyipod.org header.a=rsa-sha256
 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=Cfr6v0fd; 
 dkim=pass (1024-bit key,
 unprotected) header.d=amazonses.com header.i=@amazonses.com
 header.a=rsa-sha256 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh
 header.b=WP2grDvc
Received: from b224-10.smtp-out.eu-central-1.amazonses.com
 (b224-10.smtp-out.eu-central-1.amazonses.com [69.169.224.10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E4D614081B
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 10:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz; d=freemyipod.org; t=1791629469;
 h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:References:To;
 bh=mhd24lwSPmhj4+tDHS1DyAPh1ETa58tiJP3yD0tuQA8=;
 b=Cfr6v0fdg63Gnl+OJoy0aHCUCNtfeU2HAtrsY6hkENgQQWx7JJEFFE3WRookSnPd
 F9Jg8levH4GkzT+qHOVZEo6+jqdZSjHw/ZO8Z4aRAZWVGHiocVbwEmyGNRkQpnQOgFT
 sXc9/gDxbir/ILvYMC7fB+BsTvXF6/NiLf4bh62LcFSIkbwAx6hcFoA7Jua7Zs0I3KK
 gIKRCUyWFYcevMwLWlTywe2zAxx7XOo8R0sEK69xTz5/B52/akfTLDzkWeMhNcsywB9
 oxH4dPdc0Pe51rh44P3LkmhD5xHHjzZJB7i3fKHeDZ4tYH8NKa2X5l/5PKk2amzQh1V
 M/Tajrui5w==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh; d=amazonses.com; t=1791629469;
 h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:References:To:Feedback-ID;
 bh=mhd24lwSPmhj4+tDHS1DyAPh1ETa58tiJP3yD0tuQA8=;
 b=WP2grDvcc3Hru1VvW3Mx+po6BRpz7+Nv/5xhYpWJ+qN2S+wPNQwSGBQiwkbZ7DmA
 1edaauENPXLQIbiMNok/Q1AOmCuSPJdVGnIaZD9Rc+Mgftof5uXbN1KFdUjD9HE3cHL
 qrXBJClUcB96y5pCyxT7Pq+z0zLMK+DyK3sQJiMI=
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.12\))
Subject: Re: [PATCH] New platform: Samsung S5L87xx
From: Vencislav Atanasov <user890104@freemyipod.org>
In-Reply-To: <20261007191312.GD3079290@bill-the-cat>
Date: Sat, 10 Oct 2026 10:51:08 +0000
Cc: u-boot@lists.u-boot-project.org, Janne Grunau <j@jannau.net>, 
 Mark Kettenis <kettenis@openbsd.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>
Content-Transfer-Encoding: quoted-printable
Message-ID: <010701a125702538-042eab3f-9dd5-4f9a-b8cd-8d60474a8910-000000@eu-central-1.amazonses.com>
References: <010701a10b3e4582-979b6c8d-12c9-4819-ad7f-7ce925de5824-000000@eu-central-1.amazonses.com>
 <20261007191312.GD3079290@bill-the-cat>
To: Tom Rini <trini@konsulko.com>
X-Mailer: Apple Mail (2.3901.100.1.1.12)
Feedback-ID: ::1.eu-central-1.GZFSN+SpSZlcZgoCjFtpLsnhzRcxifcxl4uaxXIRIUo=:AmazonSES
X-SES-Outgoing: 2026.10.10-69.169.224.10
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Tom!

Thanks for the review! Please find my answers below.

> On 7 Oct 2026, at 22:13, Tom Rini <trini@konsulko.com> wrote:
>=20
> On Mon, Oct 05, 2026 at 08:46:32AM +0000, Vencislav Atanasov wrote:
>=20
>> Port U-Boot to the Samsung S5L87xx SoC family, which is used by the
>> Apple iPod nano (2nd to 7th generation), iPod classic (6th =
generation)
>> and iPod touch (2nd generation) digital audio players.
>=20
> It's very nice to see this. For the next iteration, please reword this
> so there's more information, and also the attributions, above the =
first
> "---" so git doesn't omit it.
Sorry, this is my first patch using the kernel/u-boot workflow, I was =
not
really sure which part to include in the commit and which part in the
description text.

>=20
> [snip]
>=20
> Globally, there are spacing issues where the changes don't match the
> rest of the file, please fix those. Similarly, please run =
checkpatch.pl
> and make sure there's not other fixes like that to do as well.
I've ran checkpatch.pl (using b4 prep --check) before submitting and the
output is:

$ b4 prep --check
Checking patches using:
  /Users/venci/Git/u-boot/scripts/checkpatch.pl -q --terse --no-summary
--mailback --showfile
---
=E2=97=8F 93571ce45b81: New platform: Samsung S5L87xx
  =E2=97=8F checkpatch.pl: =
arch/arm/include/asm/arch-s5l87xx/s5l87xx.h:47: CHECK: Macro
 argument reuse 'i' - possible side-effects?
  =E2=97=8F checkpatch.pl: =
arch/arm/include/asm/arch-s5l87xx/s5l87xx.h:67: CHECK: Macro
 argument reuse 'rx_pin' - possible side-effects?
  =E2=97=8F checkpatch.pl: =
arch/arm/include/asm/arch-s5l87xx/s5l87xx.h:67: CHECK: Macro
 argument reuse 'tx_pin' - possible side-effects?
  =E2=97=8F checkpatch.pl: =
arch/arm/include/asm/arch-s5l87xx/s5l87xx.h:69: CHECK: Macro
 argument reuse 'fn' - possible side-effects?
  =E2=97=8F checkpatch.pl: board/apple/nxx-common/nxx.c:15: WARNING: Use =
the livetree
 API (dev_read_...)
  =E2=97=8F checkpatch.pl: board/apple/nxx-common/nxx.c:20: WARNING: Use =
the livetree
 API (dev_read_...)
  =E2=97=8F checkpatch.pl: drivers/serial/serial_s5p.c:16: WARNING: Use
 'if (IS_ENABLED(CONFIG...))' instead of '#if or #ifdef' where possible
  =E2=97=8F checkpatch.pl: drivers/serial/serial_s5p.c:65: WARNING: Use
 'if (IS_ENABLED(CONFIG...))' instead of '#if or #ifdef' where possible
  =E2=97=8F checkpatch.pl: drivers/serial/serial_s5p.c:123: WARNING: Use
 'if (IS_ENABLED(CONFIG...))' instead of '#if or #ifdef' where possible
  =E2=97=8F checkpatch.pl: drivers/serial/serial_s5p.c:140: WARNING: Use
 'if (IS_ENABLED(CONFIG...))' instead of '#if or #ifdef' where possible
---
Success: 0, Warning: 10, Error: 0

The first CHECK uses a u8 so no side effects, the next CHECKS use a =
compile
time constant. About the livetree API, it looks like a false positive to =
me, as
these fdtdec_* functions look like the standard way to init DRAM and its =
size.
And the serial_s5p code essentially needs to not get compiled at all for =
this
specific platform, so it uses #if IS_ENABLED(x) rathen than if =
(IS_ENABLED(x)).

So there were no spacing issues according to checkpatch.pl.
FWIW, the PIE changes in arm920t/start.S and arm1176/start.S
were directly copy/pasted from armv7/start.S and they are needed because =
the
previous stage bootloader cannot be configured to load u-boot from a =
specific
address. I'll fix the spaces without relying on checkpatch.pl to point =
it out
for me.

>=20
> [snip]
>=20
> For all of these dts files, have you submitted them upstream?
No, as there isn't a working Linux port for all devices. There is a =
kernel
booting on 2nd, 5th, 6th and 7th gen iPod nanos, but from different =
branches
because individual developers worked on each of the ports. But since =
getting
u-boot to run is the easier part, and a pre-requisite for Linux, I =
decided to
wrap up and submit the u-boot port for review first.

>=20
> [snip]
>=20
> Can we figure out a way to share includes? It seems like this one for
> example is cp'd a few times. Maybe arch-s5l8xxx ?
I was relying on the arch/arm/include/asm/arch symlink that points to =
the
corresponding arch-* folder at compile time. But since the files for all =
s5l87xx
devices are essentially the same, I can modify the driver to just =
include a
common on in case of IS_ENABLED(CONFIG_ARCH_S5L87XX).

>=20
> [snip]
>=20
> We should probably handle this as a "choice" statement
I'll fix this.

Does this also apply to arch/arm/mach-s5l87xx/s5l8702/Kconfig and
eventually arch/arm/mach-s5l87xx/s5l8720/Kconfig, when it gets a second =
entry
i.e. iPod touch (2nd generation)?

>=20
> [snip]
>> +#obj-$(CONFIG_S5L8730) +=3D s5l87xx-buscon.o
>=20
> Commented out lines should be removed unless there's a very good =
reason
> to keep them (and in code, it should probably become some debug
> statement that'll be optimized out normally).
This code was an attempt to port arch/arm/mach-s5l87xx/relocate.S (Remap =
SRAM
vectors) from ASM to C, but the vector copying needs to be done =
immediately
after the remapping so I was not sure how to do it. I can leave just the =
ASM
code for now and delete the C code.

>=20
> [snip]
>=20
> Empty functions like this should mean we just need to turn off a =
Kconfig
> symbol instead.
I've done it for the other CPU core types, but for ARM1176 there wasn't =
already
a Kconfig symbol, and I saw that other platforms already do something =
similar
e.g.:

arch/arm/mach-mvebu/cpu.c:47:
void lowlevel_init(void)
{
/*
* Dummy implementation, we only need LOWLEVEL_INIT
* on Armada to configure CP15 in start.S / cpu_init_cp15()
*/
}

arch/arm/mach-hpe/gxp/reset.c:15:
/* empty to satisfy current lowlevel_init, can be removed any time */
void lowlevel_init(void)
{
}

If the goal is to clean up this pattern, I can modify
arch/arm/cpu/arm1176/start.S to include
#if !CONFIG_IS_ENABLED(SKIP_LOWLEVEL_INIT_ONLY), similar to the other =
ARM
platforms.

>=20
> [snip]
>=20
> I can see this (and presumably the rest) weren't done via "make
> savedefconfig", so please do that for v2.
They weren't as I didn't know this is the way to generate a defconfig. I =
will
redo them using savedefconfig in the next patch.

>=20
> --=20
> Tom

Thanks again for taking your time to review the patch. Should I submit =
the
corrections as a new patch which applies on top of this one, or as a
second version of this patch? Also I saw you have a GitLab instance, are =
MRs
accepted there, or the email flow is the most recommended one? I'm more =
used
to web-based MR and review, but I've already set up my email and git/b4
tooling, so I can continue submitting the patches via email.

Another thing to note is that I'm working on macOS so all building and =
testing
is done on a Mac. I also have a couple of Linux machines, is it a =
requirement
to test if the patches build on Linux before submitting? I'm using
arm-none-eabi-gcc version 16.2.0 from Homebrew for the target and Apple =
clang
version 21.0.0 (clang-2100.3.34.2) with target arm64-apple-darwin27.0.0 =
for the
host tools. It seems to work well so far.

Regards,
Vencislav

