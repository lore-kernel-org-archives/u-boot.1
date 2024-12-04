Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D12D4E7716E
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 15:13:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D4FD89718;
	Wed,  4 Dec 2024 16:13:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YeAZbLdI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CABBC89718; Wed,  4 Dec 2024 16:13:50 +0100 (CET)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DD96896EA
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 16:13:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2ee4f78493aso4279706a91.3
 for <u-boot@lists.denx.de>; Wed, 04 Dec 2024 07:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733325225; x=1733930025; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OwZlr+I/mUQp2P7zTnxAvDIav6QUUdYfTrHratme7mY=;
 b=YeAZbLdIP/PgvKBZpAngYi7BAhhpysBhGnwBI0I5D48CDsQ87DJmT14mtkfNx5aDQj
 2/WdasMhy4tUGwzirhHr+rtX7nqLXSyhWCtsJrYTRaBszByLEY6/dLFLxGkiPwKxbZtu
 UQpRo9X/QgH8GHAFczL9dyTnUaRBOKBHgcPSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733325225; x=1733930025;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OwZlr+I/mUQp2P7zTnxAvDIav6QUUdYfTrHratme7mY=;
 b=pwRPxpiIn5MOY3BoTmOO+P03oJgsQGI43HNOy9SMg1NvVGLzNiaok83vocSoVhMtZp
 iOi4uLUKchyU6tV0+dbeG+Iac5Sgz3UQGQ62+verLiY5JQyafTwaZLicVXnUQp9sZyH2
 HrD4NRzokWbUNk9+SDiKna7A7lSTyTRwHeb0xuNRspXfnCqc4VJGh7CpeP++cO1FsS35
 1Oqv47Gct7bRCrXsKxVFZDYFTLIc1HfTbMKd0ndEwf5WF47jSL1W+k4FhqgeSFzbnPEm
 PDR34sL5DzhOxAxVYZNKwXSPPO9lLdwJcrD3H340BZV44yNJhEnWWl0nFgmrjUpISr1w
 2caQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLGThiA76IKvIHmPXTQwW6vDHm1jCjxOyiSOgVDXJ4XRl4xOGfIxME0ArhnZ3vRGxGtio69B0=@lists.denx.de
X-Gm-Message-State: AOJu0Yzr/bMjXm0g2VhUmwuOLFjw9ZWPgdl0Ur0QoyEkUbBgyAD/zEet
 B8WWLJCi+OnJ23E0eB1PPBIl2TVBlws+SqU3DfFe0fNZUfUrYLkkEuUw5sA58oZTWCFSvGtt3Ex
 LNTBH3WqawLkvlQRrrOI1ngQ1Xl9L74fYC7wa
X-Gm-Gg: ASbGncv5aXFn9kU6F0obyVsVOe8mkvxDU0m9BidAlb7XtO5kBsLh0wQspM9tXCAJbGM
 KEO+nUTxoCusG4iNUPokukWU9i8ddMuwA
X-Google-Smtp-Source: AGHT+IFsJ5zra7bEfzz25PA9Unsr5mWp4+5Quj1QfGNtkbl8Lth2w66JTUz34mRmGqZSEVtN+yuzD762FY+4dnBTJZM=
X-Received: by 2002:a17:90b:3951:b0:2ee:f076:20f1 with SMTP id
 98e67ed59e1d1-2ef00f19544mr9520114a91.0.1733325224750; Wed, 04 Dec 2024
 07:13:44 -0800 (PST)
MIME-Version: 1.0
References: <20241127070631.16412-1-heinrich.schuchardt@canonical.com>
 <20241127070631.16412-5-heinrich.schuchardt@canonical.com>
 <CAFLszTjWzN0xmyCeMQEirNuhUQvAAjYUz+SaPTozy-+FFQJ_1w@mail.gmail.com>
 <df1e66dd-7b69-4d28-baef-8e992778d5c2@canonical.com>
 <CAFLszTiS-2MCZih4CzM-3YjgvX0MraxvY_thSDdHVy0_T_do3Q@mail.gmail.com>
 <02a3fcf7-bdc7-4d44-9d0e-1a05bd5216a8@canonical.com>
In-Reply-To: <02a3fcf7-bdc7-4d44-9d0e-1a05bd5216a8@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 4 Dec 2024 08:13:00 -0700
Message-ID: <CAFLszThMqzUKHHrWa34rihgwTdJBHnKPLT9wzYyNgOBg+72y1w@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] net: eth_bootdev_hunt() should not run DHCP
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, 
 Raymond Mao <raymond.mao@linaro.org>, Weijie Gao <weijie.gao@mediatek.com>, 
 Daniel Golle <daniel@makrotopia.org>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jonathan Humphreys <j-humphreys@ti.com>, 
 Dmitry Rokosov <ddrokosov@salutedevices.com>, u-boot@lists.denx.de
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

On Wed, 4 Dec 2024 at 02:10, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 27.11.24 15:14, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On Wed, 27 Nov 2024 at 07:00, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> On 27.11.24 14:07, Simon Glass wrote:
> >>> Hi Heinrich,
> >>>
> >>> On Wed, 27 Nov 2024 at 00:07, Heinrich Schuchardt
> >>> <heinrich.schuchardt@canonical.com> wrote:
> >>>>
> >>>> Currently when booting dhcp_run() may be executed multiple times:
> >>>> once in eth_bootdev_hunt() and once in the network booting bootmeth.
> >>>>
> >>>> We need to call eth_bootdev_hunt() when setting up the EFI sub-system to
> >>>> supply the simple network protocol. We don't need an IP address set up.
> >>>>
> >>>> We can reduce the bootime by not executing dhcp_run() in
> >>>> eth_bootdev_hunt().
> >>>>
> >>>> Furthermore eth_bootdev_hunt() with autostart=yes leads on the legacy
> >>>> network statck leads to downloading a file via TFTP and to booting the
> >>>
> >>> spelling
>
> I will handle that in my pull request.
>
> >>>
> >>>> downloaded file.
> >>>
> >>> I have now found the feature you're referring to - the calls to
> >>> env_get_autostart(). Perhaps we can remove this feature? It seems
> >>> pretty old and I don't see boards using it.
>
> Commands controlled by autostart include bootelf, dhcp, tftboot.
>
> For tftpboot autostart=no makes sense if you may want to download
> multiple files (kernel, initrd, dtb) before booting or the downloaded
> file is a firmware upgrade.
>
> But for PXE booting you will need autostart=yes. Many routers allow
> recovery via TFTP.
>
> For bootelf autostart=no leads to only checking the file in memory but
> not actually booting.
>
> I don't think that we can simply remove the setting looking at the
> diverse use cases.
>
> >>>
> >>> That feature stops bootstd working properly.
> >>>
> >>> But if we don't remove it, we need to disable autostart in dhcp_run(),
> >>> since in that case it does not behave correctly. I can do a patch for
> >>> that if needed.
>
> That change can be implemented separately from this patch series.
>
> >>>
> >>>>
> >>>> Instead of running dchp_run() just check that there is a network device
> >>>> in eth_bootdev_hunt().
> >>>>
> >>>> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >>>> ---
> >>>> v2:
> >>>>           reword the commit message
> >>>> ---
> >>>>    net/eth_bootdev.c | 30 ++++++++++++++++++------------
> >>>>    1 file changed, 18 insertions(+), 12 deletions(-)
> >>>>
> >>>> diff --git a/net/eth_bootdev.c b/net/eth_bootdev.c
> >>>> index 6ee54e3c790..b0fca6e8313 100644
> >>>> --- a/net/eth_bootdev.c
> >>>> +++ b/net/eth_bootdev.c
> >>>> @@ -64,9 +64,23 @@ static int eth_bootdev_bind(struct udevice *dev)
> >>>>           return 0;
> >>>>    }
> >>>>
> >>>> +/**
> >>>> + * eth_bootdev_hunt() - probe all network devices
> >>>> + *
> >>>> + * Network devices can also come from USB, but that is a higher
> >>>> + * priority (BOOTDEVP_5_SCAN_SLOW) than network, so it should have been
> >>>> + * enumerated already. If something like 'bootflow scan dhcp' is used,
> >>>> + * then the user will need to run 'usb start' first.
> >>>> + *
> >>>> + * @info:      info structure describing this hunter
> >>>> + * @show:      true to show information from the hunter
> >>>> + *
> >>>> + * Return:     0 if device found, -EINVAL otherwise
> >>>> + */
> >>>>    static int eth_bootdev_hunt(struct bootdev_hunter *info, bool show)
> >>>>    {
> >>>>           int ret;
> >>>> +       struct udevice *dev = NULL;
> >>>>
> >>>>           if (!test_eth_enabled())
> >>>>                   return 0;
> >>>> @@ -78,19 +92,11 @@ static int eth_bootdev_hunt(struct bootdev_hunter *info, bool show)
> >>>>                           log_warning("Failed to init PCI (%dE)\n", ret);
> >>>>           }
> >>>>
> >>>> -       /*
> >>>> -        * Ethernet devices can also come from USB, but that is a higher
> >>>> -        * priority (BOOTDEVP_5_SCAN_SLOW) than ethernet, so it should have been
> >>>> -        * enumerated already. If something like 'bootflow scan dhcp' is used
> >>>> -        * then the user will need to run 'usb start' first.
> >>>> -        */
> >>>
> >>> Please keep this comment
> >>
> >> I have moved the comment to the function description. See above. I think
> >> that is the adequate place.
> >>
> >>>
> >>>> -       if (IS_ENABLED(CONFIG_CMD_DHCP)) {
> >>>> -               ret = dhcp_run(0, NULL, false);
> >>>> -               if (ret)
> >>>> -                       return -EINVAL;
> >>>> -       }
> >>>> +       ret = -EINVAL;
> >>>> +       uclass_foreach_dev_probe(UCLASS_ETH, dev)
> >>>> +               ret = 0;
> >>>
> >>> There is a uclass_probe_all() function.
> >>>
> >>> My suggestion from the original series was to just do the dhcp once.
> >>>
> >>> How does probing the ethernet devices actually help EFI? It is not
> >>> needed for bootstd, since it probes any devices it uses.
> >>
> >> bootstd is not the only way to start an EFI application, you could use
> >> bootefi or bootm.
> >
> > That's fine, but I'm just trying to understand what probing does, in
> > this particular case. Doesn't EFI probe a device before it uses it? I
> > think I am just missing some context.
>
> EFI block devices will not even exist if not probed. See function
> efi_disk_probe().
>
> For network devices I would like to change the code in a similar fashion
> in future to make all network devices available in the EFI sub-system.

OK, thanks for the info. This patch seems OK since it fixes your problem,

Reviewed-by: Simon Glass <sjg@chromium.org>

Here's my understanding of what could be next:
- land my PXE series (which unfortunately needs another spin)
- update dhcp_run() so that it controls autostart, perhaps put
autostart in struct bootm_info?
- update bootstd so it only runs DHCP once on a device

Regards,
Simon
