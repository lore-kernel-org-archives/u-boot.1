Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E87EC8720
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 12:24:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C4EB869BF;
	Thu,  7 Sep 2023 14:23:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lJKnwIrr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FBBD86907; Thu,  7 Sep 2023 14:23:41 +0200 (CEST)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 561518685B
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 14:23:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-d74a012e613so1167904276.1
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 05:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694089417; x=1694694217; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=v7C1wPwW/TDUXmfPEWBelhG0dr00fp3RC1t8YWn7ANI=;
 b=lJKnwIrrCht0TlhFvp5/+0g1SxvAIbRfK7YiOPFvy+yqZMP5/tskXwFRih0G3Tyq5t
 Z3aknNXe2Q8iagkdO0EsETSYRU4daThsde/ubel4oQFG+LvZ1IDujqtU9ybrzD8mlqyI
 H3mJ+xIlfVexXT3qf8XYrBXu4a4RXJYwD8504=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694089417; x=1694694217;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v7C1wPwW/TDUXmfPEWBelhG0dr00fp3RC1t8YWn7ANI=;
 b=gZKkHGXBw+fCMoLhz7EvQBvQ4DJ12IcspLJ2Pay+UyeIGz2e+vuWmvf8Wa6FrH+zae
 qRMl0X36vE4T2EEnvY6Evo8iaNl54ft0mFqzE/Q8+ZONL+RKLR78YljyKjNNWHbLVd4n
 xItsURUIHJkuuGqP0HRcZz7jn1kzShkBsIUPv6dHn8pNUyeK8sdqHmPRUhgJHuxVaRf7
 UjMMiNOF0n3A3HoDQYIb5XtPKB5imT5hlQq+4WvTKPvw4OIdICCB+L2ScyN42CSNhkUw
 DtLmbE/qcv1TbQc3YItH8kWQke5zmY0U9qMBu5/zou8nFc02A8ENZeJ59VqmhpKBwKhv
 2fRg==
X-Gm-Message-State: AOJu0YzxnckOE2exwPP1yPEqVWfOgqVjUgIxraULZ04SKFPf1IxICxaz
 PXlaMnV1PWVXaFHOkp+sZz8A8yMb5LrNzpjrr3Z9Gg==
X-Google-Smtp-Source: AGHT+IEiUoEbxeyc49wRh49Qext8fQgr0sqqzFDqqvPIZdXCk8uz/csRfztYMUqLaE2oHtKPnSzjWNehErXL/xQhpUo=
X-Received: by 2002:a25:e0c7:0:b0:d7b:9b9b:2fc3 with SMTP id
 x190-20020a25e0c7000000b00d7b9b9b2fc3mr3099725ybg.3.1694089416801; Thu, 07
 Sep 2023 05:23:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230823134209.1450567-1-sjg@chromium.org>
 <20230823134209.1450567-8-sjg@chromium.org>
 <20230823151400.GK3953269@bill-the-cat>
 <CAPnjgZ1VBpE8S7G-eBfAeRNQ6PgNvONbGyLceDYL0JsoNnYMjQ@mail.gmail.com>
 <20230903164244.GY3101304@bill-the-cat>
 <CAPnjgZ3WbCoxx-GGcf-fXA9iU6pzyr7BJGZD5tRvG0+tZ6Frdg@mail.gmail.com>
 <20230903192522.GZ3101304@bill-the-cat>
 <CAPnjgZ3c45YBFoX+by0aybgHnzmEqzrFvv90oeW6cyiLdrwAkw@mail.gmail.com>
 <20230906175755.GI305624@bill-the-cat>
In-Reply-To: <20230906175755.GI305624@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 7 Sep 2023 06:23:06 -0600
Message-ID: <CAPnjgZ3LAtZ4V7hwwnBzHBu8=HBroQzTb1XuHV-7aBrkrxS6yg@mail.gmail.com>
Subject: Re: [PATCH 7/7] fs: Fix a confusing error about overlapping regions
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Michal Simek <michal.simek@amd.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Sjoerd Simons <sjoerd@collabora.com>
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

Hi Tom,

On Wed, 6 Sept 2023 at 11:58, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Sep 05, 2023 at 12:16:56PM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Sun, 3 Sept 2023 at 13:25, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sun, Sep 03, 2023 at 12:06:13PM -0600, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Sun, 3 Sept 2023 at 10:42, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Thu, Aug 31, 2023 at 06:15:19PM -0600, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Wed, 23 Aug 2023 at 09:14, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Wed, Aug 23, 2023 at 07:42:03AM -0600, Simon Glass wrote:
> > > > > > >
> > > > > > > > When lmb runs out of space in its internal tables, it gives
> > errors on
> > > > > > > > every fs load operation. This is horribly confusing, as the
> > poor user
> > > > > > > > tries different memory regions one at a time.
> > > > > > > >
> > > > > > > > Use the updated API to check the error code and print a helpful
> > message.
> > > > > > > > Also, allow the operation to proceed.
> > > > > > > >
> > > > > > > > Update the tests accordingly.
> > > > > > > >
> > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > [snip]
> > > > > > > > +     if (ret == -E2BIG) {
> > > > > > > > +             log_warning("Reservation tables exhausted: see
> > CONFIG_LMB_USE_MAX_REGIONS\n");
> > > > > > > > +             return 0;
> > > > > > > > +     }
> > > > > > >
> > > > > > > This isn't the right option.  Everyone has
> > CONFIG_LMB_USE_MAX_REGIONS
> > > > > > > set.  You would want to increase CONFIG_LMB_MAX_REGIONS.
> > > > > > >
> > > > > > > But it sounds like what you've found and fixed is an underlying
> > problem
> > > > > > > as to why 16 regions isn't enough in some common cases now?  So
> > we could
> > > > > >
> > > > > > I don't think I have fixed anything. But I'll send v2 and perhaps it
> > > > > > will be clearer what is going on here.
> > > > > >
> > > > > > > possibly avoid the string size growth here and have a comment
> > that also
> > > > > > > matches up with the help under LMB_MAX_REGIONS?
> > > > > >
> > > > > > I don't know, sorry. The size of struct(lmb) on 64-bit sandbox is
> > > > > > about 400 bytes. There seems to be a lot of code to save not much
> > > > > > memory.
> > > > >
> > > > > What do you mean here?  The alternative is not unlimited ranges but
> > > > > instead to define the limit of memory regions and limit of reserved
> > > > > ranges.
> > > >
> > > > A better alternative would be not to limit the number of regions, IMO,
> > > > i.e. have an array of regions that can grow as needed.
> > >
> > > That's not something that we have in the code today, however.
> >
> > No, I do have an arraylist thing that I plan to upstream, which could
> > handle that.
> >
> > But for this series, what do you think of the memregion idea? I am still
> > unsure of the saming we should use - see Heinrich's comments too.
>
> My biggest worry here is that we're papering over a real issue, and
> should either dig at that and see what's going on (should something be
> coalescing adjacent allocations? Were many platforms just right at the
> previous limit?) or just bump the default from 16 to "64 if EFI_LOADER"
> and then see if anything else really needs tweaking / cleaning up in the
> code itself.  I know Heinrich has previously said the LMB system could
> be better (or something to that effect, I'm going from memory, sorry if
> I'm mis-stating things) and I don't object to replacing what we have
> with something more robust/smarter/etc.

I am not sure...my series was designed to rename the code to reduce
confusion, and print a useful message when we run out of regions. It
does not paper over the problem, but actually makes it more visible.

Regards,
Simon
