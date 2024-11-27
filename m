Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED2CD6ACCA
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 13:08:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BA88897EB;
	Wed, 27 Nov 2024 14:08:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Z+Nfkamz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41A0B897D9; Wed, 27 Nov 2024 14:08:34 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 299A3897D5
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 14:08:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a9ec267b879so967438166b.2
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 05:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732712911; x=1733317711; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xrO518/R8Rw88lN95lpJxDx7SkDFpuxxm9fJFS6z7FE=;
 b=Z+NfkamzFUJExCyKIkQPiw2VzFfAgDvVWbyT04LfRJ7i6FPJt3GSIZWYt7jrLjINAz
 BuI//WMlZ6KvQSczhjz55P9NvZeelhdjvuQaqCgqYJUSIkrQ8wLLOQY6P46ku8YCUNU7
 Dcnai1sKuA3YVzNTBI5SiBzkkJAYAdihD6NlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732712911; x=1733317711;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xrO518/R8Rw88lN95lpJxDx7SkDFpuxxm9fJFS6z7FE=;
 b=JqK4mD12tHPlcb2shjfRVSD+1p4dGSFEY93jbv2jUHHRYzk1tBnmNBDPdHBGPcyvwF
 /ac8SgWy38Ej2v4OJ7NxZd1jZvxJkgXfVo0Lblf1ikvBH8OUGTQ0iXPTegSB8M5MvFjU
 bufiCVUE9UHegcXiEUiiY5SxiRW0w8R2EZBSoO7eELK/JhTfh1ZPN2DSdU+hOiowbYf+
 AICLXebTv5hqaaabllHwCyEf88JOWOh4A39s0cIrqdAs8ZNO+0cho5L380Q+7M6gWUPT
 Sk6aXKkMetwGFJZO/2y0OoHMIS5Z5CQ/Vb04KPfzu/Vax0P+UexNqd6ArrfPfEt2pXsx
 Ynzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIQP2A7DVncj6z/tfpXlEmKenXVddC34rIvqhwmn1MuxICFEjkYEdm2sYj6PpFKI9EIgi6qbY=@lists.denx.de
X-Gm-Message-State: AOJu0YzhS24/iW2Q3g9dvgIl7moMVoy1c1hLZe0u2u9SEwmneC/O0ew7
 0JrXwVjqhUF/jElOQZsWR7YDKvoSy8ATqEDBgLOJsE33K3L5WmUZGYoR8TUJM7HI/QX03UQhoV+
 BH3CoCcOvcMpKpOzwHEDls530dwM2ssFgWlu2
X-Gm-Gg: ASbGncti1nao3IjHBH1rTOsVAzmymhYIQUwiM5N+OUwTq1T/VjuQI48hhiiF6p6sC7V
 x7VudXmEJnrBOZ7ny6YxG/sLafjfw+30=
X-Google-Smtp-Source: AGHT+IEVuE18nGOlD6VWtZ7tjyqHt4rGQT4AF5cgCfdVZoUqmJiySIBDHpzHUFTQovc3/PFk94Oz6MbZfu+UvGNi9/U=
X-Received: by 2002:a17:907:2cf7:b0:aa4:e18e:1ca1 with SMTP id
 a640c23a62f3a-aa58109a35bmr178115166b.60.1732712911635; Wed, 27 Nov 2024
 05:08:31 -0800 (PST)
MIME-Version: 1.0
References: <20241123214554.305285-1-heinrich.schuchardt@canonical.com>
 <20241123214554.305285-5-heinrich.schuchardt@canonical.com>
 <CAFLszTgNguURurFAnX4W4mw8_Fokj2iCQOw15MCnFtT_zea6hw@mail.gmail.com>
 <f7706753-d4bc-484a-bf5d-f4b85205ac8e@canonical.com>
 <CAFLszTiCv3zdeg+1vNKY__iYmdZgVs4E=GXT6Y2DYCGQOi4RzA@mail.gmail.com>
 <5c80bb06-28fd-47c6-a249-55237a81d4a6@canonical.com>
In-Reply-To: <5c80bb06-28fd-47c6-a249-55237a81d4a6@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 27 Nov 2024 06:08:19 -0700
Message-ID: <CAFLszThH5i2cmf0WH_X2BYonMUHWbMHkUmCL-mgLO1SvbKjQEg@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] net: eth_bootdev_hunt() must not try to boot
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Daniel Golle <daniel@makrotopia.org>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Raymond Mao <raymond.mao@linaro.org>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, 
 T Karthik Reddy <t.karthik.reddy@xilinx.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
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

Hi Heinrich,

On Tue, 26 Nov 2024 at 09:16, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 26.11.24 16:38, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On Tue, 26 Nov 2024 at 00:42, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> On 11/26/24 01:32, Simon Glass wrote:
> >>> Hi Heinrich,
> >>>
> >>> On Sat, 23 Nov 2024 at 14:46, Heinrich Schuchardt
> >>> <heinrich.schuchardt@canonical.com> wrote:
> >>>>
> >>>> eth_bootdev_hunt() should not execute dhcp_run() as this itself would load
> >>>> a file and boot it if autostart=yes.
> >>>>
> >>>> Instead just check that there is a network device.
> >>>
> >>> If you look at dhcp_run() you will see an 'autoload' parameter. This
> >>> is 'false' in this code, so it never loads a file.
> >>
> >> This is not the complete truth.
> >>
> >> If $autostart=true and CONFIG_NET=y, dhcp_run(false) still tries to load
> >> a file.
> >
> > Here is the code:
> >
> > int dhcp_run(ulong addr, const char *fname, bool autoload)
> > {
> > char *dhcp_argv[] = {"dhcp", NULL, (char *)fname, NULL};
> > struct cmd_tbl cmdtp = {}; /* dummy */
> > char file_addr[17];
> > int old_autoload;
> > int ret, result;
> >
> > log_debug("addr=%lx, fname=%s, autoload=%d\n", addr, fname, autoload);
> > old_autoload = env_get_yesno("autoload");
> > ret = env_set("autoload", autoload ? "y" : "n");
> > if (ret)
> > return log_msg_ret("en1", -EINVAL);
> >
> > It respects the autoload parameter. If there is a bug in that, we
> > should fix it, but it seems to work OK to me. Please fix your commit
> > message.
>
> The cited code only sets "autoload". It does not adjust "autostart".
>
> As I have shown below this leads to trying to boot via DHCP.
>
> This is exactly what the commit message says: "load a file and boot it
> if autostart=yes".

Oh, I just thought they were the same and I didn't remember about autostart

>
> >
> >>
> >> In all cases dhcp_run() wastes boot time.
> >
> > Yes, it uses time. With bootstd the hunters are only called as needed.
> > In your case you are calling all of them at once.
> >
> > Is there a way to just call hunters which relate to block devices, perhaps?
>
> We need to probe network to provide the simple network protocol
> (lib/efi_loader/efi_net.c) but we don't need to execute DHCP.
>
> We also need the correct device-tree provided by the extension hunter.

It would be good to get some use of that, as it has no tests really.

As I ask on the other patch, why do you need to probe?

>
> Best regards
>
> Heinrich
>
> >
> >>
> >> CONFIG_NET=y
> >> => dhcp_run
> >> BOOTP broadcast 1
> >> BOOTP broadcast 2
> >> BOOTP broadcast 3
> >> DHCP client bound to address 10.0.2.15 (1004 ms)
> >>
> >> => setenv autostart true
> >> => dhcp run
> >> BOOTP broadcast 1
> >> BOOTP broadcast 2
> >> BOOTP broadcast 3
> >> DHCP client bound to address 10.0.2.15 (1002 ms)
> >> Using e1000#0 device
> >> TFTP from server 10.0.2.2; our IP address is 10.0.2.15
> >> Filename 'run'.
> >> Load address: 0x40200000
> >> Loading: *
> >> TFTP error: 'File not found' (1)
> >> Not retrying...
> >>
> >> CONFIG_NET_LWIP=y
> >> => dhcp_run
> >> DHCP client bound to address 10.0.2.15 (1007 ms)
> >>
> >> Where command dhcp_run is provided by:
> >>
> >> #include <command.h>
> >> #include <env.h>
> >> #include <net-common.h>
> >> #include <vsprintf.h>
> >>
> >> static int do_dhcp_run(struct cmd_tbl *cmdtp, int flag, int argc,
> >>                     char *const argv[])
> >> {
> >>           ulong addr = hextoul(env_get("loadaddr"), NULL);
> >>
> >>           dhcp_run(addr, NULL, false);
> >>
> >>           return 0;
> >> }
> >>
> >> U_BOOT_CMD(
> >>           dhcp_run,       CONFIG_SYS_MAXARGS,     1,      do_dhcp_run,
> >>           "dhcp_run",
> >>           NULL
> >> );
> >
> > See above
> >
> > [..]
> >
> > Regards,
> > Simon
>

Regards,
Simon
