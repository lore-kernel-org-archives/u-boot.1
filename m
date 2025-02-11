Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E514C0219B
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 10:50:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 756E1800CF;
	Tue, 11 Feb 2025 11:50:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nh53llGV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49D2280104; Tue, 11 Feb 2025 11:50:41 +0100 (CET)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CD2380079
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 11:50:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e5b29779d74so4862061276.2
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 02:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739271037; x=1739875837; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GLrgJopQv4QNqC8WD2OumCYaG7B0OVigMOir0b9QajE=;
 b=nh53llGVjsmshTl65EZ5kes+t8N1Hb9Fmacv+e9TfwoirnZq70kLfvBgla5Absye1+
 EXQpFJ+UYTSZylSpi9M/dsua7RDVSWhRhzkY9cwC+/922prBbGedoZEfmcT7ZwZ9Bsgj
 mXHfNv145M9idjfKRx5FPztuC8KcZMzs98ic6bnqRhPPpAJGkej6szRqZPECZULiudQt
 HaUP1AMJvwt0gwnDun2sELUlMk9OpMjdDX07PDqwQU2cF78mYCtPDmYbg0cYpfMDY/0b
 EwTzWE+PAdNBY9RrpkoxNVecEwyef4u4feN0wMxICEmwimP8tE3WMBPPAmvWYaaqayE9
 TirA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739271037; x=1739875837;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GLrgJopQv4QNqC8WD2OumCYaG7B0OVigMOir0b9QajE=;
 b=n16cRu+5505e6bfg44SYZA3UgFTqcmHP1J1XvIH9ciGKbUOfPodQbeDU7YcEJNx3kp
 LorsSI9JQN0iNkRAcZtDvLq74MXjFpjrv8DCfeXNhzwUXr8lumuOYNXxN8S900C4kxm1
 X39nUBLg2N5pV+t2YiZN9Xe/xul20ThPoNX9HSrKEqb1+Khilze3wHItzgVAwdP4+yif
 Pu/ZOrbTHtq2cHGH5WvncUlyEJkKpDpnfXj4SRjFa11y8B9CJYBxx5YuWEbOk1UcGb8O
 Cjx+4EnhPa0Uo6dd2CBskPh7fEiepTbp5DkoEmdkI/8HvBTK6dF9C4iRydHIoxNkQa/o
 ypJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDnXb/UNhoQhVC7KhmmyMttvVuxwiBfe4Sa3Z7wDkH5Txk2CqQPG6kfHNINsrPhH9Kjj2mx9c=@lists.denx.de
X-Gm-Message-State: AOJu0YwSgqq7J7R/6EqF4eXgwEReLmgqTbac02M5azXp/63EPLntIHAo
 udOTzyApRJON6PeITiC7UgJzK2aFDVnZG8KbkTcC3L9kuUy6clzTAw4Pv0btmzS+8akx3Er4pll
 fX68TxnRpTw4azZOaclXmpRKXI9/FHtBzjEl01wU/vo2LWvMDlE7s3Mbc
X-Gm-Gg: ASbGncsVY9X6r7ZcNHkqB9Dolk/wDKeSydENOrcI2G2HqJYlULr6X1AaHgdFzn6DdMW
 1hy3ZJPCLPcFTLQpvfNFdaVFQuLAUmxzvIOmxmyF58TGXoqwMgoB1zvyIvSbiSJJIgkTIWGcqvV
 Q=
X-Google-Smtp-Source: AGHT+IH+CzhgV1c9BMTaPVrBIt1aVYjYwOeiEFu4P5qHO49Eo5IrcPy1VTO8x753ns/HOQYO6+4Nu1v0AEgihDnU/Xs=
X-Received: by 2002:a05:6902:154d:b0:e5b:171c:35ee with SMTP id
 3f1490d57ef6-e5b462a7ce1mr17471589276.48.1739271037218; Tue, 11 Feb 2025
 02:50:37 -0800 (PST)
MIME-Version: 1.0
References: <20250211094942.36162-1-ilias.apalodimas@linaro.org>
 <87tt90ss3v.fsf@bloch.sibelius.xs4all.nl>
In-Reply-To: <87tt90ss3v.fsf@bloch.sibelius.xs4all.nl>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 11 Feb 2025 10:50:01 +0000
X-Gm-Features: AWEUYZljN8c-uvW5FuwaSDhFOgynn8J988qwl0UaJ6g8q2FkV12WWeWi7iQlOuY
Message-ID: <CAC_iWjKK5qBz8-jZ6QOOYfoGJf1DM4P_1VqmWRD0k91UJx8JZQ@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: remove comparisons to string literals from
 runtime
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: heinrich.schuchardt@canonical.com, xypron.glpk@gmx.de, trini@konsulko.com, 
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Mark,

On Tue, 11 Feb 2025 at 10:17, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
>
> > From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >
> > On EFI runtime services, we manage to preserve string literals
> > by placing the .efi_runtime section just before .data and preserving
> > it when fixing up the runtime memory by marking surrounding boottime
> > code as runtime. This is ok for now but will break if we update any
> > linker scripts and decouple .text and .runtime sections.
> >
> > So let's define the strings we used to compare in the stack for
> > runtime services
>
> I don't see how this helps you.  Those string literals still need to
> be copied into the stack variable from somewhere and I don't think
> that with this changes where that source string literal lives...
>
> I think you need toput the string in a global variable with an
> appropriate __attribute__ that puts it into .runtime.

The asm I am seeing is setting this up on the stack

  c29c0:       d2800ac1        mov     x1, #0x56                       // #86
{
   c29c4:       a9ba7bfd        stp     x29, x30, [sp, #-96]!
        const u16 t[] = u"VarToFile";
   c29c8:       f2a00c21        movk    x1, #0x61, lsl #16
   c29cc:       f2c00e41        movk    x1, #0x72, lsl #32
{
   c29d0:       910003fd        mov     x29, sp
        const u16 t[] = u"VarToFile";
   c29d4:       f2e00a81        movk    x1, #0x54, lsl #48
   c29d8:       f90027e1        str     x1, [sp, #72]
   c29dc:       d2800de1        mov     x1, #0x6f                       // #111
{
   c29e0:       a90153f3        stp     x19, x20, [sp, #16]
        const u16 t[] = u"VarToFile";
   c29e4:       f2a008c1        movk    x1, #0x46, lsl #16
   c29e8:       f2c00d21        movk    x1, #0x69, lsl #32
{
   c29ec:       a9025bf5        stp     x21, x22, [sp, #32]
        const u16 t[] = u"VarToFile";
   c29f0:       f2e00d81        movk    x1, #0x6c, lsl #48
{
   c29f4:       f9001bf7        str     x23, [sp, #48]
        const u16 t[] = u"VarToFile";
   c29f8:       f9002be1        str     x1, [sp, #80]
   c29fc:       52800ca1        mov     w1, #0x65                       // #101
   c2a00:       b9005be1        str     w1, [sp, #88]
        if (!variable_name || !vendor || !data_size)


While the older code is doing

  if (!u16_strcmp(variable_name, u"VarToFile"))
     a88:       90000001        adrp    x1, 0 <__image_copy_start>


But I think that's very arm and compiler-specific, so I'll change it
to what you and Heinrich suggested

Thanks
/Ilias
>
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> >  lib/efi_loader/efi_var_mem.c      | 3 ++-
> >  lib/efi_loader/efi_variable_tee.c | 3 ++-
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/lib/efi_loader/efi_var_mem.c b/lib/efi_loader/efi_var_mem.c
> > index b265d95dd6ba..985e0baa128d 100644
> > --- a/lib/efi_loader/efi_var_mem.c
> > +++ b/lib/efi_loader/efi_var_mem.c
> > @@ -310,6 +310,7 @@ efi_get_variable_mem(const u16 *variable_name, const efi_guid_t *vendor,
> >  {
> >       efi_uintn_t old_size;
> >       struct efi_var_entry *var;
> > +     u16 vtf[] = u"VarToFile";
> >       u16 *pdata;
> >
> >       if (!variable_name || !vendor || !data_size)
> > @@ -331,7 +332,7 @@ efi_get_variable_mem(const u16 *variable_name, const efi_guid_t *vendor,
> >       if (timep)
> >               *timep = var->time;
> >
> > -     if (!u16_strcmp(variable_name, u"VarToFile"))
> > +     if (!u16_strcmp(variable_name, vtf))
> >               return efi_var_collect_mem(data, data_size, EFI_VARIABLE_NON_VOLATILE);
> >
> >       old_size = *data_size;
> > diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
> > index 0d090d051dd4..8d173e58d2f7 100644
> > --- a/lib/efi_loader/efi_variable_tee.c
> > +++ b/lib/efi_loader/efi_variable_tee.c
> > @@ -780,6 +780,7 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
> >       efi_uintn_t payload_size;
> >       efi_uintn_t name_size;
> >       u8 *comm_buf = NULL;
> > +     u16 pk[] = u"PK";
> >       bool ro;
> >
> >       if (!variable_name || variable_name[0] == 0 || !vendor) {
> > @@ -858,7 +859,7 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
> >       if (alt_ret != EFI_SUCCESS)
> >               goto out;
> >
> > -     if (!u16_strcmp(variable_name, u"PK"))
> > +     if (!u16_strcmp(variable_name, pk))
> >               alt_ret = efi_init_secure_state();
> >  out:
> >       free(comm_buf);
> > --
> > 2.43.0
> >
> >
