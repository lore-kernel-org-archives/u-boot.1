Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57ED8D6ACE4
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 14:55:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB61B895E2;
	Wed, 27 Nov 2024 15:55:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="d9FhVAt6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C33F8961A; Wed, 27 Nov 2024 15:55:49 +0100 (CET)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A07A895D2
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 15:55:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-53ddb99e9dcso4530005e87.3
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 06:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732719346; x=1733324146; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3500fk57A9dRklCFSJnym0IlvEQ6NZHWUiWAwirVj9g=;
 b=d9FhVAt6lEqAHGct0kLWkqeLhkajWJ0ga3jlwQ1PquG/BJO3eDW0enme6SvqrP1JQL
 yOobLbZdsdt2Xofhq0MmPXP2E3R6+qDYjP17ktHOV/e7MIWXhfGiGouoD2mMbDMgzG2x
 2ciTLJ79a+cMF3KHhCxmgU4WH/vebV4E6dfEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732719346; x=1733324146;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3500fk57A9dRklCFSJnym0IlvEQ6NZHWUiWAwirVj9g=;
 b=F/irS7YI+tV6eO2Y+IA5h59x9bYdmRkpuT9Hlrg+MITunHgjoKu4iRsh181VKqqv3p
 4aQ83LMpmP5DlQ7DRQk3u99a+S5BsLftvVKfOzWKP19R640PYVfoDwWHus2L+GyX66+0
 X8TiAnckjaWebY+Vh6XDGgmy2YTpBvDjB3NlYapAr1goGUczJA6MEhgmadetE44Yrjaa
 qhfNXf05BUptNSbRw71N6RpwD6VJKGSWApsthmAAQMrGs8s3sX357U+VZWluK5lXaoYs
 MCWbqEybmlNWUmPwOTsR/LcmDLQb60ZX9NYZS1OjDlgM+ArpsXkVNBpO1ZzV6UgivxJj
 MicQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDTWWegtQVbO+GqIQPNLFESZw+9c9x4a+oR/iAkKHmGWYI+5LrlNwWRps4ZfI8sR2WxiqbKyQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxyuSrAfQSy5/tCGKTvrxOic5DR1ObiSsxWknXJjZz0QKj0OQX6
 SY6mqTmWDWCobmZWteRZ9BKz0knmJc3IpCVtbdvl8OE4WRooX+TMvghV9PYOf5lti5dRHO2JBiJ
 BBmkdpTjhyXIcXg6ZIm+XyZXvBxWEKgLXOLUo
X-Gm-Gg: ASbGnctgP7hEVPocX/4L5bb5rH83JBPXcBx76zkD2gycBE6Pi/dN8tFtPFTC4KhO9yE
 EtWtTyRhPAPm+LrLRtpahHHN9Vtf2k5s=
X-Google-Smtp-Source: AGHT+IHAFjQY/qSEiujHiHxDiR3bg2Cu6tqtQe2JppZCPMDmq5Nyo5vrRq8WretCk26ql8Mo9NgAWUquf50C0w5XdmI=
X-Received: by 2002:a05:6512:3c99:b0:53d:ed8d:9a14 with SMTP id
 2adb3069b0e04-53df00c7448mr1983322e87.2.1732719344850; Wed, 27 Nov 2024
 06:55:44 -0800 (PST)
MIME-Version: 1.0
References: <20241123214554.305285-1-heinrich.schuchardt@canonical.com>
 <20241123214554.305285-5-heinrich.schuchardt@canonical.com>
 <CAFLszTgNguURurFAnX4W4mw8_Fokj2iCQOw15MCnFtT_zea6hw@mail.gmail.com>
 <f7706753-d4bc-484a-bf5d-f4b85205ac8e@canonical.com>
 <CAFLszTiCv3zdeg+1vNKY__iYmdZgVs4E=GXT6Y2DYCGQOi4RzA@mail.gmail.com>
 <5c80bb06-28fd-47c6-a249-55237a81d4a6@canonical.com>
 <CAFLszThH5i2cmf0WH_X2BYonMUHWbMHkUmCL-mgLO1SvbKjQEg@mail.gmail.com>
 <9e572f07-9cd4-472e-a6f0-acf4c38ec982@canonical.com>
In-Reply-To: <9e572f07-9cd4-472e-a6f0-acf4c38ec982@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 27 Nov 2024 07:55:33 -0700
Message-ID: <CAFLszTgnuURujjipbL51Z=94D3TW-bGmyxoj2NJFh9r9ZcQBjw@mail.gmail.com>
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

On Wed, 27 Nov 2024 at 06:43, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 27.11.24 14:08, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On Tue, 26 Nov 2024 at 09:16, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> On 26.11.24 16:38, Simon Glass wrote:
> >>> Hi Heinrich,
> >>>
> >>> On Tue, 26 Nov 2024 at 00:42, Heinrich Schuchardt
> >>> <heinrich.schuchardt@canonical.com> wrote:
> >>>>
> >>>> On 11/26/24 01:32, Simon Glass wrote:
> >>>>> Hi Heinrich,
> >>>>>
> >>>>> On Sat, 23 Nov 2024 at 14:46, Heinrich Schuchardt
> >>>>> <heinrich.schuchardt@canonical.com> wrote:
> >>>>>>
> >>>>>> eth_bootdev_hunt() should not execute dhcp_run() as this itself would load
> >>>>>> a file and boot it if autostart=yes.
> >>>>>>
> >>>>>> Instead just check that there is a network device.
> >>>>>
> >>>>> If you look at dhcp_run() you will see an 'autoload' parameter. This
> >>>>> is 'false' in this code, so it never loads a file.
> >>>>
> >>>> This is not the complete truth.
> >>>>
> >>>> If $autostart=true and CONFIG_NET=y, dhcp_run(false) still tries to load
> >>>> a file.
> >>>
> >>> Here is the code:
> >>>
> >>> int dhcp_run(ulong addr, const char *fname, bool autoload)
> >>> {
> >>> char *dhcp_argv[] = {"dhcp", NULL, (char *)fname, NULL};
> >>> struct cmd_tbl cmdtp = {}; /* dummy */
> >>> char file_addr[17];
> >>> int old_autoload;
> >>> int ret, result;
> >>>
> >>> log_debug("addr=%lx, fname=%s, autoload=%d\n", addr, fname, autoload);
> >>> old_autoload = env_get_yesno("autoload");
> >>> ret = env_set("autoload", autoload ? "y" : "n");
> >>> if (ret)
> >>> return log_msg_ret("en1", -EINVAL);
> >>>
> >>> It respects the autoload parameter. If there is a bug in that, we
> >>> should fix it, but it seems to work OK to me. Please fix your commit
> >>> message.
> >>
> >> The cited code only sets "autoload". It does not adjust "autostart".
> >>
> >> As I have shown below this leads to trying to boot via DHCP.
> >>
> >> This is exactly what the commit message says: "load a file and boot it
> >> if autostart=yes".
> >
> > Oh, I just thought they were the same and I didn't remember about autostart
> >
> >>
> >>>
> >>>>
> >>>> In all cases dhcp_run() wastes boot time.
> >>>
> >>> Yes, it uses time. With bootstd the hunters are only called as needed.
> >>> In your case you are calling all of them at once.
> >>>
> >>> Is there a way to just call hunters which relate to block devices, perhaps?
> >>
> >> We need to probe network to provide the simple network protocol
> >> (lib/efi_loader/efi_net.c) but we don't need to execute DHCP.
> >>
> >> We also need the correct device-tree provided by the extension hunter.
> >
> > It would be good to get some use of that, as it has no tests really.
> >
> > As I ask on the other patch, why do you need to probe?
>
> You asked on the Network protocol.
>
> If your idea is that the concept of extensions is not yet deployed, is
> there a good way to exclude BOOTDEV_HUNTER(extension_bootdev_hunter)?

Well, my approach with bootstd was to try to reverse-engineer what
distro_boot did and extensions was one of those things.

I am not suggesting excluding it, merely that I am pleased that it is
being used!

[..]

Regards,
Simon
