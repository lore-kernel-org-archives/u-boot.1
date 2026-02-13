Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE17FEF99D3
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 20:20:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1913A83CF2;
	Fri, 13 Feb 2026 21:20:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SwnNzhBz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CB7B83CF2; Fri, 13 Feb 2026 21:20:49 +0100 (CET)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8912083015
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 21:20:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-c2a9a9b43b1so888305a12.2
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 12:20:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771014044; cv=none;
 d=google.com; s=arc-20240605;
 b=JXoYdQAFq01LYTkYfsiopJojphNDSPmkxiaBMdVOvEJgM1T8jHG9w32XZaMRo3hIYs
 ZwX3X4eFDjB7hBwyvwctYRtodBfNy8yyUPYWRdXVKyI/fD5GprQceFjP5XeVBa5//Yfk
 b4nZzFA9T6li9auS8/LHffNQr5dJqR7nqlsI6SDcFC0k6QDyL099sL7O7S9CUItGfsCF
 h4fjVeGE5clh4ZAZt6u+LSNFequlAfaPmc/K3ckRCkykmjFSdp6Kw62hQqW1ma/cZsIs
 n/cvj6hUtVKzWlZDrr9TPPhWRsRVlLZCb+rgI8uBhJGcdJSO75MZJvU3U56tS7PA64br
 OlOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7y+1mshWv2DIvvYrWrjUzwdfiPSR85EXBWQsCUVT9M8=;
 fh=4LtZ/CwKDHgVbXOMHlNLsvz29Pn69x+uUFNhmsEpgAk=;
 b=iJ0rCtK7fYGsEC/2zPrw9cLuxP9l9lKn4y7qNFbpTqdr9GRyBawly46IDpnLJlcA+t
 4MHvgQmWVioXIROWVFCyrwiZINX11qe8fKg6vlE4yqawPUwsSBDAKrxKdJ7S6SQx1rG2
 aj5RGQcSMpGGlRC+zvqp3Ix8q7CN20+roSPt9wqLrEwz2mvyj5hSIjwx//LPRH1pFEDF
 +/rWHXizAdQN2EyGjr/T4m3MKwXubHhmeIfON0oUhc+m57Tb7Th++5TcWfD8MF285YdZ
 LYMuyh6BNz0Nkeqa+Vrlty47AEaMUph1PD31eviof0ZUB4FGcXBYDGRR0FBQXL7gfrV1
 aaaw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771014044; x=1771618844; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7y+1mshWv2DIvvYrWrjUzwdfiPSR85EXBWQsCUVT9M8=;
 b=SwnNzhBz8fP3ahTw/ar4H2ELpcj9duxeLT6JgnqN9uAXNcWN6UmKSzv+I0MkfYAf+C
 Q874pPdCh1z/Lo4+pzYRdITxWgIPpPkUQDE6bgZLkAbSBgiH/9MI+n7ZQ5kIqOsrcg3u
 DgHbBf0BR9ZIMUKYJ6jrN5q/gx7zXPppQ98Mg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771014044; x=1771618844;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7y+1mshWv2DIvvYrWrjUzwdfiPSR85EXBWQsCUVT9M8=;
 b=J3ltonki8Oj4TJO/i0q0iL+67nA6WMv4/6jQ7ILgup9cV/Yc2t5YZaNldHunb7AXMc
 VrweE990uAmQ4BrRHkJsdTu5jyLcXpoPfv+Dsxpl6n/e6iTvNx0HGNc+sEsr5fMCxOoo
 NLea/bR99weunpc4iHHKRCKeTz3Z+3WRK75lUkOD5eukr/kch23OHL+j2vhpvypZaJ3b
 9KbYNnPyNJlHE2WiNd/WehF63z8hdKwYLa83mQ+zWz1oxyKTm5tKAWBen89QAu3GtYsK
 ybzKSriMgwh+vsXPZtOdALo7D361v7O8UpJ4tFD14U2pMb27AomPd0q2LZSuC5K7Blk7
 5foA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaDwuQ1y5l00F8HJhQFPFVfPu+jKBNu9nB9o9eTI0buOYplEHq3KBU+l3i5NJWiZ059bidflA=@lists.denx.de
X-Gm-Message-State: AOJu0YyQn637CukgotechK2z1yegb+VVITAAPuNdfHof2HMt+rOtjhZj
 KO8+Bbx7y3Oj2uWU8qaLw7VcMDJe9DcQDIxrtSa34pyk1mL1z/5XhvKnkJuJ+mzUbIEmvTxqBIr
 IGG841GhEy9cfh9EVxGVy8A4qoiTLCg567KgFin95
X-Gm-Gg: AZuq6aJ3XKMCnxecRt/zHfndr036ylqbD4x8iSjCmEM/GazL9gtE3ZQ/Wtu7tQS9ppg
 ZvbZNxtmaRteWzUyqpc6zTo3P0AIUY0mF506vrR5WiAMowNmMD93Bn5ZPOPgVkJPdSEhXuKhqa1
 hmjqyqtqEJ8ug8GAsObLALkxkQhNdASvcjpjeUltK8GAxlQwOsWOVmE+Goi1f2RHY5xes/ZFgvY
 ZIyqCbjzhrZw0iYb64jw8arFUPYOuqjvwSkuL81wXCs1n3dAdUdPR5+wOKLbD72s5abxjDhxKuZ
 8M4s
X-Received: by 2002:a17:90b:53c3:b0:32e:7bbc:bf13 with SMTP id
 98e67ed59e1d1-358450eca4emr577928a91.34.1771014044067; Fri, 13 Feb 2026
 12:20:44 -0800 (PST)
MIME-Version: 1.0
References: <20260121063920.1500293-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260121063920.1500293-3-varadarajan.narayanan@oss.qualcomm.com>
 <CAFLszThUMWgySrb4H2F5PE6XVsRK0Cc+PZ37f_3xZ12HEhM=3g@mail.gmail.com>
 <aXg8ge6z7EMWliSd@hu-varada-blr.qualcomm.com>
 <CAFLszTh-B=zQyBjwJ_OuVxAbpTpUaKB1e9zB8Nm6+wuJCK5OcQ@mail.gmail.com>
 <aY7x9EAueKZ9Xxmt@hu-varada-blr.qualcomm.com>
In-Reply-To: <aY7x9EAueKZ9Xxmt@hu-varada-blr.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 13 Feb 2026 13:20:10 -0700
X-Gm-Features: AZwV_QhCt1kcZ4T10jTu4D-4YB4ynFUDOeztp345Za7WNr3imK5w72uqZNZ2HZ0
Message-ID: <CAFLszTgWW0-3hXkUWVmiDgfT1yMZMkjX8zDsT8Qf846ZgaA2Xg@mail.gmail.com>
Subject: Re: [PATCH v6 2/5] drivers: sysreset: Add sysreset op that can take
 arguments
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, jerome@forissier.org,
 marek.vasut+renesas@mailbox.org, 
 ilias.apalodimas@linaro.org, me@samcday.com, aswin.murugan@oss.qualcomm.com, 
 clamor95@gmail.com, michal.simek@amd.com, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io, Sumit Garg <sumit.garg@oss.qualcomm.com>
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

Hi Varadarajan,

On Fri, 13 Feb 2026 at 02:42, Varadarajan Narayanan
<varadarajan.narayanan@oss.qualcomm.com> wrote:
>
> On Wed, Feb 04, 2026 at 01:23:05PM +1300, Simon Glass wrote:
> > Hi Varadarajan,
> >
> > On Tue, 27 Jan 2026 at 17:18, Varadarajan Narayanan
> > <varadarajan.narayanan@oss.qualcomm.com> wrote:
> > >
> > > On Mon, Jan 26, 2026 at 06:15:34PM +1300, Simon Glass wrote:
> > > > Hi,
> > > >
> > > > On Wed, 21 Jan 2026 at 19:39, Varadarajan Narayanan
> > > > <varadarajan.narayanan@oss.qualcomm.com> wrote:
> > > > >
> > > > > Add a 'request_arg' op to struct sysreset_ops to enable sysreset drivers
> > > > > to receive arguments given to the 'reset' command. Process the
> > > > > request_arg() op before the usual request() op.
> > > > >
> > > > > Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
> > > > > Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > > > > Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> > > > > ---
> > > > > v6: Wrap this functionality inside CONFIG_SYSRESET_CMD_RESET_ARGS
> > > > > ---
> > > > >  drivers/sysreset/Kconfig           |  8 +++++++
> > > > >  drivers/sysreset/sysreset-uclass.c | 37 ++++++++++++++++++++++++++++++
> > > > >  include/sysreset.h                 | 18 +++++++++++++++
> > > > >  3 files changed, 63 insertions(+)
> > > > >
> > > > > diff --git a/drivers/sysreset/Kconfig b/drivers/sysreset/Kconfig
> > > > > index 0181f6cd581..6fb0ca81dc6 100644
> > > > > --- a/drivers/sysreset/Kconfig
> > > > > +++ b/drivers/sysreset/Kconfig
> > > > > @@ -49,6 +49,14 @@ config SYSRESET_CMD_RESET
> > > > >         help
> > > > >           Enable sysreset implementation of the reset command.
> > > > >
> > > > > +config SYSRESET_CMD_RESET_ARGS
> > > > > +       bool "Enable reset command to take arguments"
> > > > > +       help
> > > > > +         Pass on the arguments received by the 'reset' command to the
> > > > > +         sysreset driver(s). The sysreset driver(s) may make use of the
> > > > > +         additional arguments for implementing arch/board specific
> > > > > +         functionality.
> > > > > +
> > > >
> > > > I haven't been following this, but what sort of args are you planning to pass?
> > >
> > > As of now, an argument to indicate reboot to emergency download mode.
> >
> > So how about adding a struct in sysreset.h where you can include a
> > flag word and create a single flag for your case? We should be able to
> > handle reset without the cmdline being enabled.
> >
> > There are other cases where this would be useful, e.g. an EFI app
> > rebooting into setup boot.
>
> Previously, i.e. v5 [1] didn't have SYSRESET_CMD_RESET_ARGS config
> option. This was added to avoid bloat code size for platforms that will
> not need this. Please see [2]

Sure, but you are adding a new method, so you could make it take a new
struct instead of the string list, still behind your Kconfig option.

Regards,
Simon


>
> Thanks
> Varada
>
> 1 - https://lore.kernel.org/u-boot/20260113103840.1948029-3-varadarajan.narayanan@oss.qualcomm.com/
> 2 - https://lore.kernel.org/u-boot/20260119170701.GD3416603@bill-the-cat/
