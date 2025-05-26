Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB805C54FB3
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 08:36:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F43C82D09;
	Mon, 26 May 2025 10:36:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OjWjCI5Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A5D482B2F; Mon, 26 May 2025 10:36:18 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12B0982D09
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 10:36:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-602c3f113bbso3664329a12.0
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 01:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748248575; x=1748853375; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NmJ/cOKciJubxjZ3EO3fEoqhjai0bLfXon5za2nJAUM=;
 b=OjWjCI5Q8vjPb4eRFBjJGfnUY4A0kfyh6kKohhiaxdwlKf12kCB349P/FfHaaWlq3u
 G9MlyGmbYOjlHNvZd8IelO6qiMSwFU4NhXJneezHWwZi+LgMh80XB0CGFeDEJj3a5poZ
 ssMGcycZ63bOdrTNHNVgqmESTDjYAsLITafb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748248575; x=1748853375;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NmJ/cOKciJubxjZ3EO3fEoqhjai0bLfXon5za2nJAUM=;
 b=pCJ9Nhg79/S01OiG9TUKBb9zBha98UYFN42C95aITYLHWTveL2QJHbJDGy3SgAU+Es
 Yh9cxW/PCMr+PUnbbIko49Q4qGxyfSq6OMbaaTsenuBADW7QZDWxdYGLoT6dQzGaO9r9
 MG07VHydZyVF3Ut1QNdsJDbEszEFYmy3rSHBrNdR/W8Wd6HBPVWpzOLReZVrwO3sS8os
 b2ll7+tU9XqNQwFqfrJH65suwB8VtsdE7WOZgTGiYdp2hfcqsKcvwEmXPNMZ2RsJTDA5
 Z630Z4TvesRItqg/ThDGE6MAQbHK0ELUYRWJTRc/qnOaew1agU9I42w+ljTjXPm8uKWV
 Uupg==
X-Gm-Message-State: AOJu0YzkDI3MRnqnGMTnnDWy+U3mLhB/tN1Zy1qXX1KQDMDhLw6CauM6
 F11ZblCj8GqPWt84pPfo44/odUSpues4dS3pSd+DVsem12zQ4NaIIuJ5+tQhH7FnvodMzKgwlVh
 QHC770JN1MGmbCWLFVh+BKE6nr3wZN7mwL99/1lx/
X-Gm-Gg: ASbGncvq9fZVqMIF6FyOT+f++mg9dVZlqPejF8Q7mKrtye2ek96Vpq3ZenaradAKhcL
 se3P4A1DFpn9zbPeB9WosTcKbXZczLedyq4yrrWX/uISXlXXIqCOV8QgPK48uOFZitX1tX9KFSw
 qoqDIoyEXmcSfysARMdYSdUlq7Z55QZr4=
X-Google-Smtp-Source: AGHT+IFGEr5HLCH1L0EfLBRuY4QTR1MxnqjaLvU9U/Gv4PcMrBzTL4dLdXMMrFSO0MDi3ItlDWuVg0lV1SYURIf4Kt0=
X-Received: by 2002:a17:907:3faa:b0:ad4:f5ee:3c0 with SMTP id
 a640c23a62f3a-ad85b16dab8mr765833266b.16.1748248575408; Mon, 26 May 2025
 01:36:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250523130651.1329593-1-sjg@chromium.org>
 <3b23fc9d-345f-4945-b89d-153a18f5828d@gmx.de>
 <CAFLszTjofbRtjXxfR6MmnHP0hYcpg+pgLKLYDXN2KxLZ2rNPHQ@mail.gmail.com>
 <20250523164909.GV100073@bill-the-cat>
In-Reply-To: <20250523164909.GV100073@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 26 May 2025 09:36:03 +0100
X-Gm-Features: AX0GCFuYB8mARp8PODLUF0t_RmVs7HeJsYQeHSPKv6qRh-CpIW7BAUrMmMU_ImY
Message-ID: <CAFLszTiVv9Qe5y2Mt7LFZ0i=3G=4u+0ZAVjs3hc6G219BCzBsg@mail.gmail.com>
Subject: Re: [PATCH 00/10] efi: Move some efi-loader code into a new shared dir
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

-trimming cc

Hi Tom,

On Fri, 23 May 2025 at 17:49, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, May 23, 2025 at 05:36:52PM +0100, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On Fri, May 23, 2025, 15:19 Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > >
> > > On 23.05.25 15:06, Simon Glass wrote:
> > > > Some functions provided in lib/efi_loader are actually useful for the
> > > > app as well. This series refactors the Kconfig and directories a little
> > > > so that code is easier to share.
> > > >
> > > > As a starting point, it moves some filename and device-path functions to
> > > > the new directory.
> > > >
> > > > The next step would be to move device-path code over, but this will need
> > > > some discussion.
> > >
> > > Hello Simon,
> > >
> > > Overall the ideas in this series look fine to me. But this series does
> > > not apply to origin/next.
> > >
> > > Applying: efi_loader: Separate device path into its own header
> > > Patch failed at 0001 efi_loader: Separate device path into its own header
> > > error: patch failed: cmd/efidebug.c:8
> > > error: cmd/efidebug.c: patch does not apply
> > > error: patch failed: include/efi_loader.h:967
> > > error: include/efi_loader.h: patch does not apply
> > > error: patch failed: lib/efi_loader/efi_bootmgr.c:12
> > > error: lib/efi_loader/efi_bootmgr.c: patch does not apply
> > > error: patch failed: lib/efi_loader/efi_device_path.c:10
> > > error: lib/efi_loader/efi_device_path.c: patch does not apply
> > > error: patch failed: lib/efi_loader/efi_helper.c:6
> > > error: lib/efi_loader/efi_helper.c: patch does not apply
> > >
> > > Please, resend the series based on origin/next.
> > >
> > > Patches that are not based on upstream U-Boot cannot be reviewed via
> > > this mailing list.
> >
> > The app is quite behind in Tom's tree due to rejected series.
>
> It was not "Rejected", it was "Changes Requested", please stop
> mis-representing things.

That seems like a distinction without a difference. For example, [1]
is marked as 'changes requested' but the abuf comment on patch 1 looks
like a rejection to me.

>
> > In fact
> > the app is pretty limited on x86 and there is no Arm app at all.
> >
> > My current plan is to move forward and eventually Tom might take it
> > via a pull request.
> >
> > Do you have any other ideas?
> >
> > Perhaps this is something we could put on the agenda for a future call.
>
> There's nothing to discuss in a future call as step one is "post patches
> against mainline".

Well, you keep bringing it up, so it seems that you are unhappy with
it. An alternative to talking about it, if you prefer, is to accept
the status quo. But either way, it doesn't seem helpful to mention the
same issue on so many threads.

Regards,
Simon

>
> --
> Tom

[1] https://patchwork.ozlabs.org/project/uboot/list/?series=454989
