Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2B0FCF9C58
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 15:59:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8259888B12;
	Fri, 20 Sep 2024 17:59:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OCYyFnFz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C333988883; Fri, 20 Sep 2024 17:59:35 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90C8488883
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 17:59:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3e03c736466so1296542b6e.1
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 08:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726847972; x=1727452772; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uuaSVEJls0v7kQRKz89d+MqoHE2ihyPkQ0LZqPl24ko=;
 b=OCYyFnFzlYmP+1gFubk68hqfjswCJfQBb+VA3db8m12gccyPEewyoOuGCbkhxzG4Bd
 deqlaMVfLMLHrIx5KRaBqBvUqQuVPSit++6G0ipTONGIs/mH6vU3HuXDyn+3r/mdEFCJ
 GLzySCOZfetOmSj1rnNZYriFt7JWl7IRXwzWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726847972; x=1727452772;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uuaSVEJls0v7kQRKz89d+MqoHE2ihyPkQ0LZqPl24ko=;
 b=cCejZSCAZqZiS6RjzM2+TtAMZVoNej5qeAolJWMEECFSMlqJJbj7/FtcNUcFNuk+nJ
 4MZglNlNK2C1eg3B6d+VYEHant9RIabbo5z4U/pspKV591e2lBSKSOlgfE5bTUwckfGo
 DjDHJTVW05Y15EiR+ji8Qz6lV6atjvyZH5gaxn1I3LECoGwMXvmLNlTGeA9QDtfqtIte
 8iBBarfoBp4ARL2KCDcskiJ4oRj72/qwdogyCszey1ABEhIZx61fvC7O/7jWj2yD0Bqs
 IqvTnkZNHCY8B1bfKCQQuuVTO+2Z1vuBw5J7xBEkuD63G3080Sfy5TXmSWtS1P4al3Kk
 4uBg==
X-Gm-Message-State: AOJu0YzRU+GygGZkCHplAERG2oloe96m79b+zzvaHO3NtyN9oKelPHQd
 xT4orpp63yit0nMNcOg7nwS8G38qfaE0LY4fAh2BBIj1OJa87toxl5RWzZ+HuXgT63bGAcJoKNF
 mRoOfvsuexkjzpp1EBcUhyuo/FrM9z2vK1dtQ
X-Google-Smtp-Source: AGHT+IHZbk6o2VgygABr6npIKHntNG3t+4hVUpaE9oGUPawv5FmX3JQJydF1sHvY/MFby143m/ufknB773ORfIwQt/g=
X-Received: by 2002:a05:6808:4498:b0:3e0:3e64:bf01 with SMTP id
 5614622812f47-3e2728f799fmr2072237b6e.5.1726847972390; Fri, 20 Sep 2024
 08:59:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240901222634.460873-1-sjg@chromium.org>
 <20240901222634.460873-20-sjg@chromium.org>
 <8ff14ff9-eadb-4d75-a7f4-49a548110899@cherry.de>
In-Reply-To: <8ff14ff9-eadb-4d75-a7f4-49a548110899@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 20 Sep 2024 17:59:22 +0200
Message-ID: <CAFLszTg_=_AwFbJPQp-pc8Zsm0g-cnO-63+LqoPMidpUnrMUZQ@mail.gmail.com>
Subject: Re: [PATCH v4 19/23] cmd: Fix memory-mapping in cmp command
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
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

Hi Quentin,

On Tue, 3 Sept 2024 at 11:42, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Simon,
>
> On 9/2/24 12:26 AM, Simon Glass wrote:
> > This unmaps a different address from what was mapped. Fix it.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >   cmd/mem.c | 26 +++++++++++++-------------
> >   1 file changed, 13 insertions(+), 13 deletions(-)
> >
> > diff --git a/cmd/mem.c b/cmd/mem.c
> > index 274348068c2..4d6fde28531 100644
> > --- a/cmd/mem.c
> > +++ b/cmd/mem.c
> > @@ -245,7 +245,7 @@ static int do_mem_cmp(struct cmd_tbl *cmdtp, int flag, int argc,
> >       int     size;
> >       int     rcode = 0;
> >       const char *type;
> > -     const void *buf1, *buf2, *base;
> > +     const void *buf1, *buf2, *base, *ptr1, *ptr2;
> >       ulong word1, word2;  /* 64-bit if MEM_SUPPORT_64BIT_DATA */
> >
> >       if (argc != 4)
> > @@ -270,22 +270,22 @@ static int do_mem_cmp(struct cmd_tbl *cmdtp, int flag, int argc,
> >       bytes = size * count;
> >       base = buf1 = map_sysmem(addr1, bytes);
>
> "base" isn't changed in the rest of the code, so we could just reuse it
> instead of declaring yet another variable.
>
> >       buf2 = map_sysmem(addr2, bytes);
>
> We could also set ptr2 here... Allowing to avoid the diff from here to....
>
> > -     for (ngood = 0; ngood < count; ++ngood) {
> > +     for (ngood = 0, ptr1 = buf1, ptr2 = buf2; ngood < count; ++ngood) { >                   if (size == 4) {
> > -                     word1 = *(u32 *)buf1;
> > -                     word2 = *(u32 *)buf2;
> > +                     word1 = *(u32 *)ptr1;
> > +                     word2 = *(u32 *)ptr2;
> >               } else if (MEM_SUPPORT_64BIT_DATA && size == 8) {
> > -                     word1 = *(ulong *)buf1;
> > -                     word2 = *(ulong *)buf2;
> > +                     word1 = *(ulong *)ptr1;
> > +                     word2 = *(ulong *)ptr2;
> >               } else if (size == 2) {
> > -                     word1 = *(u16 *)buf1;
> > -                     word2 = *(u16 *)buf2;
> > +                     word1 = *(u16 *)ptr1;
> > +                     word2 = *(u16 *)ptr2;
> >               } else {
> > -                     word1 = *(u8 *)buf1;
> > -                     word2 = *(u8 *)buf2;
> > +                     word1 = *(u8 *)ptr1;
> > +                     word2 = *(u8 *)ptr2;
> >               }
> >               if (word1 != word2) {
> > -                     ulong offset = buf1 - base;
> > +                     ulong offset = ptr1 - base;
> >                       printf("%s at 0x%08lx (%#0*lx) != %s at 0x%08lx (%#0*lx)\n",
> >                               type, (ulong)(addr1 + offset), size, word1,
> >                               type, (ulong)(addr2 + offset), size, word2);
> > @@ -293,8 +293,8 @@ static int do_mem_cmp(struct cmd_tbl *cmdtp, int flag, int argc,
> >                       break;
> >               }
> >
> > -             buf1 += size;
> > -             buf2 += size;
> > +             ptr1 += size;
> > +             ptr2 += size;
> >
>
> here - making the commit all the more explicit (for me this commit is
> basically only renaming a variable, since unmap_system doesn't appear in
> the git context) - by only changing:
>
> unmap_system(buf1);
> unmap_system(buf2);
>
> to
>
> unmap_system(base);
> unmap_system(ptr2);
>
> I believe?
>
> Additionally, my linter tells me that:
>
> buf1 += size;
> buf2 += size;
>
> is undefined behavior:
>
> arithOperationsOnVoidPointer: 'buf1' is of type 'const void *'. When
> using void pointers in calculations, the behaviour is undefined.

Hmmm I thought that got changed...or at least I rely on void * being
taken as char * when diffing pointers.

>
> I suggest the following:
>
> buf1 = ((u8 *)buf1) + size;
> buf2 = ((u8 *)buf2) + size;
>
> since size seems to be size in bytes?
>
> What do you think?

Well I think you should send a patch! It seems reasonable to me.

>
> We already have test/cmd/mem.c is this something we can augment to test
> the unmapping is proper too?

Yes, it would be possible to check the list of mapped pointers in
sandbox, to make sure it has gone back to its original state (i.e. any
new mappings in the test were deleted before the test ended).

Regards,
Simon
