Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7BB6CD3420
	for <u-boot@archiver.kernel.org>; Sun,  1 Sep 2024 20:12:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF03C88C1C;
	Sun,  1 Sep 2024 22:10:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Kfr91gYK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4438388BCF; Sun,  1 Sep 2024 22:10:10 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4CB488B2D
 for <u-boot@lists.denx.de>; Sun,  1 Sep 2024 22:10:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6c359c1a2fdso6739966d6.2
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 13:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725221407; x=1725826207; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+khhxaey6krbSrki5P069HyNIymIdrYzrxmNXMtTBis=;
 b=Kfr91gYKvjCpUN3II21kCRGHV6bvWebFgNEAUbMf3m8ECOibPmwVSZR7AuJYDG7nrn
 cU95E8xzfAh2JN48yRKK7BZbDrAlaoGUqUEM0AnSo7ZTblXqgHQ/19CzXeoKpbrva94J
 YJM09Dm7kjo/y5CFuZnfFCP7WS0thTJGUqvDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725221407; x=1725826207;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+khhxaey6krbSrki5P069HyNIymIdrYzrxmNXMtTBis=;
 b=mA5XksslczmZxSDgkoFD6RMxR4KOEJaO0BskrZ2WDKmpYD9Q6aQxCURFx92Zzq49v5
 xtrqbj5JsoWtqCfcMIwNAsrUGMGYfHqjpf5cNI4k8nJynLMj6SZUxZyrviI4vCrOSfwj
 quMb5eoesudW5GcqvArpRSzDvrhcYUuNjFTK1wGyifobzsSsfsc6lzw4wIunoUtpXCIB
 0L9gKCPpuIxNm/QowNpNJgu0/QAo6cNdvmozYQLh+4XevB5jZXHUfbvHBG7rNS7Ju/l7
 8fEcmAJ7mv6m+Dq1MQeKieeQnzT+CWJGwZ67TLt+ynDZjE71wzBZIWx48LpjtvoIhu63
 y+kg==
X-Gm-Message-State: AOJu0YwUnHACRMb0Vr6VExCQQepnohoBT62/WDP9cRWgl1Brr3pdRuLn
 P3YA8O9HP9JoJQxhLWShDYG23U1T7FjW8rP22SvbJQrHljcQmLkW2WXkBGVxeafqIyh8gKZOk/z
 xon5QDGIAv5/038+ciMETr56A16ikB6V6IylQOXLd2k+ekpY=
X-Google-Smtp-Source: AGHT+IGuKFJJz7gvCf8n/4ZZ3buyopaHsCmYyOw9hGuWw39ShW7G1ykNi0XV19N1kR+9lANwQx0zcBpibsUfjTPVPd0=
X-Received: by 2002:a05:6214:5548:b0:6c3:68b0:a5ce with SMTP id
 6a1803df08f44-6c368b0a897mr6815756d6.27.1725221406756; Sun, 01 Sep 2024
 13:10:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240829192958.GO2479150@bill-the-cat>
 <CAFLszTh3hgG3dpYSK_w=DZTJcm59Ct-xQRZPy-00Mh7iGwwaYw@mail.gmail.com>
 <20240830143002.GT2479150@bill-the-cat>
In-Reply-To: <20240830143002.GT2479150@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Sep 2024 14:09:56 -0600
Message-ID: <CAFLszTjcE-0sBdy6TnbTuXCUo7ZyvL6mzGfBVrAyYr-XDM6p9g@mail.gmail.com>
Subject: Re: My labgrid setup
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

On Fri, 30 Aug 2024 at 08:30, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Aug 29, 2024 at 07:06:53PM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Thu, 29 Aug 2024 at 13:30, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > Hey all,
> > >
> > > So now that I've posted my u-boot-test-hooks for labgrid:
> > > https://patchwork.ozlabs.org/project/uboot/patch/20240829185620.3179866-1-trini@konsulko.com/
> > > the next relevant parts would be how I use that. There's three scripts,
> > > first of which is "uboot-hw-testcycle.sh" :
> > > ------------------------ >8 ------------------------
[..]
> > > ------------------------ >8 ------------------------
> > >
> > > I will say, if there's one thing I don't quite like with how my
> > > integrations with labgrid work right now it's that acquire/release is
> > > done the way it is. This is where I think Simon's adding another hook is
> > > the right direction, if there's not some other hook that can be used and
> > > I'm just missing.
> >
> > Thanks for posting this. I know you had described it but this makes a
> > lot of things clearer.
> >
> > So basically you have set up builds for the different boards and use
> > the hook scripts to write them and do the actual power/reset/console
> > munging.
>
> Yes.
>
> > How do you handle interactive build/run, e.g. to run U-Boot on a
> > particular board quickly?
>
> Well, this is the CI lab, so that's not the primary point. But control-O
> in a shell? Some platforms I have a wrapper for, some I don't.

OK. In my case I often want to try things out on particular boards, or
at least that is what I have found. Perhaps I will do that less once
gitlab is running. Anyway, my point is they use the same mechanism.

>
> > Also how would gitlab work?
>
> Similar to how it works in your series, but with more "make the
> container build/include firmware blobs for use", most likely.

Yes, it should be similar.

>
> > Re acquire/release, I added a -a option to auto-acquire the place and
> > release it afterwards. But if the console dies then so does Labgrid so
> > it doesn't release reliably...something to worry about when more
> > progress is made.
>
> Well, that's what pre/post steps are for, IMHO.

Yes that's why I added it. I think it is best to keep that, at least
until we find it never goes wrong.

Regards,
Simon
