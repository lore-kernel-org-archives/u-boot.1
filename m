Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E83B8CCD19A
	for <u-boot@archiver.kernel.org>; Sun, 16 Nov 2025 16:07:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E33983AB0;
	Sun, 16 Nov 2025 17:07:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IJ4Zl1T7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E822583AB0; Sun, 16 Nov 2025 17:07:33 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6EC7839D7
 for <u-boot@lists.denx.de>; Sun, 16 Nov 2025 17:07:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6408f9cb1dcso5197890a12.3
 for <u-boot@lists.denx.de>; Sun, 16 Nov 2025 08:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1763309251; x=1763914051; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hgrEzEI/5UpLz+Uapsw/SFitveho5C/myXic3Iw0/Yc=;
 b=IJ4Zl1T771YF1zN6PZg6ki0eUjKByTJcFUDoxmIuEof2SHEF5o4pUwkb5nh9L9bykz
 9USEnJi/5jadi/B9ek3tOS/J+XjHydF7YNUAP+WRNKSXc+JhqzeA8qSYMkuB9HejbsO4
 JjjJsrnEogttk0DWFz2bTkJ10mPjrYPPsOYXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763309251; x=1763914051;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hgrEzEI/5UpLz+Uapsw/SFitveho5C/myXic3Iw0/Yc=;
 b=edUNcF6oOb2vs2Se4G8Z450HWNRwFVX/WS+/x3qAiM+XlpU30gmKvUn1fLyhD+cGcI
 A/yrPhwfa/OLFsZrs6he8VtKt1ujpWCKyr6WFAJwUWGegwZsWQbr69R+ayWaJn2/XBCh
 2xjF5lEpp0NlDBV1tx0Fc/tBvo5c+qyY73EoFoO5bRy1Z5VQKpSZ1QVc/bXPKNPtpnQ1
 WQc7475dU4L4UCZtTms4lslWP4ThFlK/Wdty2lbe6wfqi6I8eMkTfP6wT0Abgg3+fkgu
 p1leLHivtZUD4LdF5xm292QHoSkeEGnbrD7aMMsXveCxSdzEBYMwJyVUjKb+5BfdreMu
 didw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnIyCMb9eTU4Y5QYjDa2D2JPbejBNakSf7LhVJe6bWgpPyYMT4GFpbdn9tV7e6KS3Sx5zNfg8=@lists.denx.de
X-Gm-Message-State: AOJu0Yy9r+VTi9EX1AbdGuoIgM48P9c8zOLr07epz3IlXm0bJvZutKeh
 JaG8bN2m3ny6SGkk6HJBkEhDQrZNICSU3OiVPL3aRlux41DV+ZXHMZbirg5ZUfbjpzUb+I3vRA8
 InwHCJmdxsyvCNx7Ek1jGimiX/wsl05pHaj+WfSFH
X-Gm-Gg: ASbGncscmJZRdWgOzUfceKrTxz4/KkvX3X+++XlbtMzBJg1iaHkr/1aQAdLeaHz2CTY
 uFCBBe1cj1AY9RTVS1Lh2OqWeCQz0cPyXl4NtntNnAleflzKlg8QSrZsMXu+wvo/xxR7TVF49td
 UI/4RK+ViiyKWU7nIYna2fT4ebBzLRr/8EqbGVKfafE8fb30IkJ0P+P6STINF6EtYMBy78OyuIq
 ExslQ5JffCOqM/T66pkLbvZ5/pKhrsiJdzknKy7iSAa7fBL4EavX1kUeX5+qdbpiiDxGREPSEbh
 Q14oAL4=
X-Google-Smtp-Source: AGHT+IFjGPUycPakNLQJ9wISKmE3/ghh30Ij8Xp4CynWPaeGZWDQcMmP2ZhvXyy7cMqMdZ0km2Rfg7oOZmEnb+mwL6A=
X-Received: by 2002:a17:907:7f0c:b0:b72:6de0:44a1 with SMTP id
 a640c23a62f3a-b73674cf6a6mr870910866b.0.1763309251300; Sun, 16 Nov 2025
 08:07:31 -0800 (PST)
MIME-Version: 1.0
References: <20251112011717.360045-1-marek.vasut+renesas@mailbox.org>
 <CAFLszTjofjQ_zmwJrGZ-sLejQ=x=-8tyqr4SBPYgt3683GVAbQ@mail.gmail.com>
 <20251113193816.GP6688@bill-the-cat>
 <CAFLszTjwpoCwCKKvJX5cZMLK480EK-=BWaFd5A6yLMrfsVWC6g@mail.gmail.com>
 <20251113200527.GQ6688@bill-the-cat>
 <CAFLszTjydNqmo=6qLv--m4fB07QzWd01XHGY3hxgTEbarJF-VA@mail.gmail.com>
 <20251113203654.GR6688@bill-the-cat>
 <385cdc16-cf73-443b-a0a1-440e233d4506@mailbox.org>
 <CAFLszThc4YC6mKp5sNsiuCFfaMNqMWJjVV27d4UkyLU4rPWY6A@mail.gmail.com>
 <bed4a846-6356-463f-a8a9-3d4bf05439a4@mailbox.org>
In-Reply-To: <bed4a846-6356-463f-a8a9-3d4bf05439a4@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 16 Nov 2025 09:07:19 -0700
X-Gm-Features: AWmQ_blz6MaEaYfYVReggEjsvUg0cFmWXnvduXkqPXsussKqJTjQh9fVgxkskJ0
Message-ID: <CAFLszTiLZaMkCUxk2_x=gwKBxJeg-02iO-w=JufXEtqhqHZyTA@mail.gmail.com>
Subject: Re: [PATCH 1/2] boot: android: Always use 8-byte aligned DT with
 libfdt
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Aaron Kling <webgeek1234@gmail.com>, Eddie Kovsky <ekovsky@redhat.com>, 
 George Chan <gchan9527@gmail.com>, Julien Masson <jmasson@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Nicolas Belin <nbelin@baylibre.com>, Sam Day <me@samcday.com>
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

Hi Marek,

On Sat, 15 Nov 2025 at 17:20, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 11/14/25 1:45 PM, Simon Glass wrote:
>
> Hello Simon,
>
> >>>>> Which is different from disagreeing with your specific feedback about
> >>>>> how we get there, to be clear.
> >>>
> >>> And again, since your feedback to this patch was "Don't?", I'm saying we
> >>> need to. But the rest of your feedback was structural on moving towards
> >>> resolving it and so I assume Marek will respond.
> >>
> >> The "blast radius" are these patches, that's all that tripped the tests:
> >>
> >>    - boot: android: Always use 8-byte aligned DT with libfdt
> >>    - test/py: android: Point fdt command to aligned addresses
> >>    - test/py: Use aligned address for overlays in 'extension' test
> >>    - sandbox: Fix DT compiler address warnings in sandbox DTs
> >>    - sandbox: Fix DT compiler pin warnings in sandbox DTs
> >>    - boot: Assure FDT is always at 8-byte aligned address
> >>    - arm: qemu: Eliminate fdt_high and initrd_high misuse
> >>    - efi_loader: Assure fitImage from capsule is used from 8-byte aligned
> >> address
> >>    - MIPS: Assure end of U-Boot is at 8-byte aligned offset
> >>
> >> Regarding last minute alignment, the problem with this android image
> >> seems to be in the android image itself, which packs in badly aligned
> >> FDT. We therefore have to copy it out and realign.
> >
> > My request is to implement these checks as part of the boot flow
> > (bootm, etc.) rather than adding memory allocations in leaf function.
> > We already support copying the FDT to a different address so we can
> > expand it and add things. Can we make use of that code?
> It seems the 'abootomg' command is extracting DTB from a container where
> the DTB can be at 4-byte aligned address. Thus far, the command
> internally used that possibly 4-byte aligned address, which is wrong. It
> also returned that address which was used by further U-Boot commands
> as-is, which is also wrong.
>
> This DTB usage here has nothing to do with any boot flow, this is
> incorrect DTB alignment during manipulation, which is not part of boot.
>
> What exactly do you propose should be changed with this patch ?

Actually this patch seems to adjust code which is just handling a
command. How about creating a common function which can put an FDT
into an abuf, either just using it in place, or allocating memory and
copying it? An abuf is ideal for this. E.g. something like (untested):

/**
 * fdt_ensure_aligned() - Obtain an abuf with a devicetree, aligning if needed
 *
 * @buf: Returns abuf containing FDT on success; caller must abuf_uninit(buf)
 * @addr: Address of FDT
 * Return: 0 on success, -EINVAL if not an FDT, -ENOMEM if out of memory
 */
int fdt_ensure_aligned(struct abuf *buf, void *fdt)
{
   struct fdt_header fdth __aligned(8);

   memcpy(&fdth, fdt, sizeof(struct fdt_header));
   if (fdt_check_header(&fdth) != 0)
      return -EINVAL;

   abuf_init_const(buf, fdt, fdt_totalsize(&fdth));

   /* The device tree must be at an 8-byte aligned address */
   if ((uintptr_t)fdt & 7) {
      void *fulldt;

      // a function like abuf_realloc_align(struct abuf *buf, int
align) would help
      fulldt = memalign(8, buf->size);
      if (!fulldt)
         return -ENOMEM;

      memcpy(fulldt, fdt, buf->size);
      buf->data = fulldt;
      buf->alloced = true;
   }

   return 0;
}

Then you can use this in various places as needed.

Regards,
Simon
