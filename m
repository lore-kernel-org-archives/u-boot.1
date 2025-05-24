Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F7B8C54E71
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 04:24:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 136C583327;
	Sat, 24 May 2025 06:24:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Av+UHdLG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F7C583334; Sat, 24 May 2025 06:24:03 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FE9C83303
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 06:24:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-602346b1997so788510a12.3
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 21:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748060640; x=1748665440; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YnTz6WjS+UQrkh04dKvTAk5LRP8hkPhmoOzysJZw/PA=;
 b=Av+UHdLG47JspoAwQINOHuZUJqibRMZgLTHIGIfihVDr6IX2yNfPxgSG0MMZDV6ZXf
 qrJR7+hqZ99Dj7LZqIChdUSFzkU0Qg9OyYMRXOHN34A60/yls7RHH6d0ogIHgGQCLp/A
 qustHxYZ7AE/brypPHvXBYPYUfG5s32SvCI5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748060640; x=1748665440;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YnTz6WjS+UQrkh04dKvTAk5LRP8hkPhmoOzysJZw/PA=;
 b=ZUWRkKv4LBoagQTcqYY3xFBJqDIV1UZE9gl4/a8VySlFMqM5Q8l846Xo9X9dzHnntX
 1X+usSAzaPDmNtdJoTaRsHqxKWcX30sEbgAR/kdZ+/xMZ9ie9SfY2ARLCSMI6xpx1gJG
 vZ3GQdCjBYjzGETnT6tAXLufRzpvp6CjkllyDxNRAOOOcPUhD2hrVD1vkS4netnc0NMr
 Jcee9L4C7gukDhDsKdUquzC1WW9rOSPYfKoWMm01bRXZSHG5FUcVXeUIvvXi6jlyiou7
 x5hMVLLKt6gGoKCo2R9tM4LskEQUKcIaNLeStawZKvDmXK2nNiBDbsMThztWiu0inv05
 4rZw==
X-Gm-Message-State: AOJu0YxJtcf0VHrzZnQkFbQqdT8Kf+lfYL2UwVZngyVgKAVXWUpr+FZ/
 UDUeUWCLh+WSeTN+sKImh+AzeAKA06vUZMOlHxM9iwIb9XZkin/ytu2tLm9LqNr9kbEKok4Qx4l
 vog+R0mMOI+zLukWi4G3e3Xq6tRYF1axjuvfpQ4CmQLd5/3q9LEd/XiPmBYo=
X-Gm-Gg: ASbGncuqhroLTGKQRIet0xLP5hw9qKYD0uMRrlPlqFNgnXQEW6LbA9L61GnsFAGDG61
 HKRfGtXEzn8aqFQxxYbU1nkF7YyagsqpcvcYRlsUwt4DTXPbpOqKJw8pIN0fxK4Bklkm6VN3QuK
 468wl4GD9c3GTLbM7BPO6bfaMWS6d03sS/3C0AllHk0g==
X-Google-Smtp-Source: AGHT+IHo0jFdNBJO+B1rkrv7Zt8yarc7wEDmoKvuXHtfkoGnliQCZ9NLgElxcT+qf+j59zG+ZmMFdyi6Uaw/QV9wt7Q=
X-Received: by 2002:a17:907:c26:b0:ad2:1a64:79c5 with SMTP id
 a640c23a62f3a-ad85b13021dmr132300966b.7.1748060639895; Fri, 23 May 2025
 21:23:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250504132356.2317305-2-sjg@chromium.org>
 <20250504132356.2317305-1-sjg@chromium.org>
 <CAFLszTi6LwvSoNtThF5DzKjJNFzJxB5rk5DjYi9wzsfkiwwjcg@mail.gmail.com>
 <20250523140455.GP100073@bill-the-cat>
 <CAFLszTj1v7dhvdj9vM70OP=Bb8j3FArYHS3SGcpnJO31z3Ns1g@mail.gmail.com>
 <20250523164717.GU100073@bill-the-cat>
 <CAFLszTg0CO5PqagaAZNov-N4rv6D17iUV_qnAasJ336zW=eG9w@mail.gmail.com>
 <20250523212539.GX100073@bill-the-cat>
In-Reply-To: <20250523212539.GX100073@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 24 May 2025 05:23:48 +0100
X-Gm-Features: AX0GCFuZkgqpFUjQtKPqzRmIxdTlY9L58fiivAuK1Lhix5mqlZe7c_vEcvGJGcA
Message-ID: <CAFLszTioW78gyU2qK+-E5CcjyTAatvFuodWV3NKuwq5anBGdpg@mail.gmail.com>
Subject: Re: [PATCH v2 01/30] patman: Move all non-test logic into control
 module
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

On Fri, 23 May 2025 at 22:25, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, May 23, 2025 at 09:20:37PM +0100, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 23 May 2025 at 17:47, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, May 23, 2025 at 05:32:36PM +0100, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Fri, 23 May 2025 at 15:04, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Fri, May 23, 2025 at 08:19:30AM -0500, Simon Glass wrote:
> > > > > > It is easier for tests if the top-level control logic is all in one
> > > > > > module. Create a new do_patman() function to handle this. Move the
> > > > > > existing code into it.
> > > > > >
> > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > ---
> > > > > >
> > > > > > (no changes since v1)
> > > > > >
> > > > > >  tools/patman/__main__.py | 49 ++----------------------------------
> > > > > >  tools/patman/control.py  | 54 ++++++++++++++++++++++++++++++++++++++--
> > > > > >  2 files changed, 54 insertions(+), 49 deletions(-)
> > > > > >
> > > > > > Applied to sjg/master, thanks!
> > > > >
> > > > > Odd. I thought you had posted this against master or next, intending it
> > > > > for mainline, which is why I assigned it to you in patchwork. I see the
> > > > > cover letter is missing what commit it's against. And instead here you
> > > > > are once again spamming the list and with messages about your personal
> > > > > tree. Why?
> > > >
> > > > I'm applying it to my tree and intend to send you a PR at some point,
> > > > with collected tools/ patches. So I believe I need to send emails
> > > > about applying things and update it in patchwork. Let's discuss this
> > > > in a future call.
> > >
> > > I don't see what there is to discuss. Please follow the normal process
> > > for mainline and stop spamming the list with notices for your personal
> > > tree. You're also diverging your own tree further from mainline by doing
> > > this and making it less likely (multiple people have told you they don't
> > > want to review things not against mainline) any follow-up work will get
> > > comments other than that it's not applicable to mainline.
> >
> > For patman, I have another series [1] I'm planning to apply to my tree tomorrow
> >
> > Would you like me to send 'applied' emails for it to the mailing list?
> > Or perhaps just for the cover letter? Would you like me to send you a
> > pull request?
> >
> > Regards,
> > Simon
> >
> > [1] https://patchwork.ozlabs.org/project/uboot/list/?series=456256
>
> Yes, that's another series that while I disagree with the direction
> you're taking things, would rather apply to mainline than let it bitrot
> in mainline. So please send a PR against next. And that would also apply
> to the series this email is in reply to. As again, I had expected it for
> mainline and not your downstream tree even if I think we (and our users)
> would all benefit from managing the python portions differently.

OK, once I have applied the remaining two series I will send a PR.

You didn't express a preference for the 'applied' emails. It seems
better to send these emails so that there is a record of the patch
being applied.

Regards,
Simon
