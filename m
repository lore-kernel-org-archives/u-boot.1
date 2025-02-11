Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A9D7C0219B
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 11:01:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2870800B3;
	Tue, 11 Feb 2025 12:01:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="XViAPp7w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97A8580104; Tue, 11 Feb 2025 12:01:11 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 773A780079
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 12:01:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 7ecb2b82-e867-11ef-bc52-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.6])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 7ecb2b82-e867-11ef-bc52-005056992ed3;
 Tue, 11 Feb 2025 12:01:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=MpRGeFf+Yd2bvktb0WIvaZk4aTWUBp/3JH7WcY1uCQ8=;
 b=XViAPp7wu3VvJSvuL2aDeEe9E99TrBz04d17lRmJYHJX6/o7nRCc3ScSXeGe78Yz80glL7H6yQfGf
 POai3mrOkYasVMPBO/pfFE+2vm8/YHo73s3+sOMErMdrXFFobjavOtHSq+AJM8l84kI3aXClz31nNt
 sMCbxFhE2RWlL4Y0EG2dE2ryu9BXMoijESj3vWsLfDPFslis1yfDjw8z4ayJJHfhB94XJpO2s1G77K
 PCi3NhdfvanviaWUy5WY05mi1Pl1h5PKZ0WAlWKMTVP31DhxwiuTr8Ej/nXaXgc3tzk8nR8AWGsmE0
 fTNJmUU7QzWx9aKsXvqNPQtB03uV0bg==
X-KPN-MID: 33|F+aYIpupDczImqwTpgPx4XbpGswJZrj+ikjknMN/AeMnzO60QriMWDxe1QGknlq
 eoB69XLtWCsJoisWloSuT9m3+2mRq2pYnWqWs/am+yd4=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|t9I9nGlxKMr68b/UkQLBv2XKKXQ/kZmNMW7xxnpiGHpc9rzRPnkQJMSKKDNv00l
 uUmr7WPdbKUW3psO5w9zghg==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 7f0fbacc-e867-11ef-88fb-00505699772e;
 Tue, 11 Feb 2025 12:01:08 +0100 (CET)
Date: Tue, 11 Feb 2025 12:01:08 +0100
Message-Id: <87seoksq2z.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: heinrich.schuchardt@canonical.com, xypron.glpk@gmx.de,
 trini@konsulko.com, u-boot@lists.denx.de
In-Reply-To: <CAC_iWjKK5qBz8-jZ6QOOYfoGJf1DM4P_1VqmWRD0k91UJx8JZQ@mail.gmail.com>
 (message from Ilias Apalodimas on Tue, 11 Feb 2025 10:50:01 +0000)
Subject: Re: [PATCH] efi_loader: remove comparisons to string literals from
 runtime
References: <20250211094942.36162-1-ilias.apalodimas@linaro.org>
 <87tt90ss3v.fsf@bloch.sibelius.xs4all.nl>
 <CAC_iWjKK5qBz8-jZ6QOOYfoGJf1DM4P_1VqmWRD0k91UJx8JZQ@mail.gmail.com>
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

> From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Date: Tue, 11 Feb 2025 10:50:01 +0000
> 
> Hi Mark,
> 
> On Tue, 11 Feb 2025 at 10:17, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
> >
> > > From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > >
> > > On EFI runtime services, we manage to preserve string literals
> > > by placing the .efi_runtime section just before .data and preserving
> > > it when fixing up the runtime memory by marking surrounding boottime
> > > code as runtime. This is ok for now but will break if we update any
> > > linker scripts and decouple .text and .runtime sections.
> > >
> > > So let's define the strings we used to compare in the stack for
> > > runtime services
> >
> > I don't see how this helps you.  Those string literals still need to
> > be copied into the stack variable from somewhere and I don't think
> > that with this changes where that source string literal lives...
> >
> > I think you need toput the string in a global variable with an
> > appropriate __attribute__ that puts it into .runtime.
> 
> The asm I am seeing is setting this up on the stack
> 
>   c29c0:       d2800ac1        mov     x1, #0x56                       // #86
> {
>    c29c4:       a9ba7bfd        stp     x29, x30, [sp, #-96]!
>         const u16 t[] = u"VarToFile";
>    c29c8:       f2a00c21        movk    x1, #0x61, lsl #16
>    c29cc:       f2c00e41        movk    x1, #0x72, lsl #32
> {
>    c29d0:       910003fd        mov     x29, sp
>         const u16 t[] = u"VarToFile";
>    c29d4:       f2e00a81        movk    x1, #0x54, lsl #48
>    c29d8:       f90027e1        str     x1, [sp, #72]
>    c29dc:       d2800de1        mov     x1, #0x6f                       // #111
> {
>    c29e0:       a90153f3        stp     x19, x20, [sp, #16]
>         const u16 t[] = u"VarToFile";
>    c29e4:       f2a008c1        movk    x1, #0x46, lsl #16
>    c29e8:       f2c00d21        movk    x1, #0x69, lsl #32
> {
>    c29ec:       a9025bf5        stp     x21, x22, [sp, #32]
>         const u16 t[] = u"VarToFile";
>    c29f0:       f2e00d81        movk    x1, #0x6c, lsl #48
> {
>    c29f4:       f9001bf7        str     x23, [sp, #48]
>         const u16 t[] = u"VarToFile";
>    c29f8:       f9002be1        str     x1, [sp, #80]
>    c29fc:       52800ca1        mov     w1, #0x65                       // #101
>    c2a00:       b9005be1        str     w1, [sp, #88]
>         if (!variable_name || !vendor || !data_size)
>

Oh clever!  It basically uses a bunch of mov instructions to create
the string on the stack.

> While the older code is doing
> 
>   if (!u16_strcmp(variable_name, u"VarToFile"))
>      a88:       90000001        adrp    x1, 0 <__image_copy_start>
> 
> 
> But I think that's very arm and compiler-specific, so I'll change it
> to what you and Heinrich suggested

Possibly even depends on the optimization options you use.  And it
would almost certainly not do this if the string was longer.  So yes,
Heinrich's suggestion is probably the way to go.

> 
> Thanks
> /Ilias
> >
> > > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > ---
> > >  lib/efi_loader/efi_var_mem.c      | 3 ++-
> > >  lib/efi_loader/efi_variable_tee.c | 3 ++-
> > >  2 files changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/lib/efi_loader/efi_var_mem.c b/lib/efi_loader/efi_var_mem.c
> > > index b265d95dd6ba..985e0baa128d 100644
> > > --- a/lib/efi_loader/efi_var_mem.c
> > > +++ b/lib/efi_loader/efi_var_mem.c
> > > @@ -310,6 +310,7 @@ efi_get_variable_mem(const u16 *variable_name, const efi_guid_t *vendor,
> > >  {
> > >       efi_uintn_t old_size;
> > >       struct efi_var_entry *var;
> > > +     u16 vtf[] = u"VarToFile";
> > >       u16 *pdata;
> > >
> > >       if (!variable_name || !vendor || !data_size)
> > > @@ -331,7 +332,7 @@ efi_get_variable_mem(const u16 *variable_name, const efi_guid_t *vendor,
> > >       if (timep)
> > >               *timep = var->time;
> > >
> > > -     if (!u16_strcmp(variable_name, u"VarToFile"))
> > > +     if (!u16_strcmp(variable_name, vtf))
> > >               return efi_var_collect_mem(data, data_size, EFI_VARIABLE_NON_VOLATILE);
> > >
> > >       old_size = *data_size;
> > > diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
> > > index 0d090d051dd4..8d173e58d2f7 100644
> > > --- a/lib/efi_loader/efi_variable_tee.c
> > > +++ b/lib/efi_loader/efi_variable_tee.c
> > > @@ -780,6 +780,7 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
> > >       efi_uintn_t payload_size;
> > >       efi_uintn_t name_size;
> > >       u8 *comm_buf = NULL;
> > > +     u16 pk[] = u"PK";
> > >       bool ro;
> > >
> > >       if (!variable_name || variable_name[0] == 0 || !vendor) {
> > > @@ -858,7 +859,7 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
> > >       if (alt_ret != EFI_SUCCESS)
> > >               goto out;
> > >
> > > -     if (!u16_strcmp(variable_name, u"PK"))
> > > +     if (!u16_strcmp(variable_name, pk))
> > >               alt_ret = efi_init_secure_state();
> > >  out:
> > >       free(comm_buf);
> > > --
> > > 2.43.0
> > >
> > >
> 
