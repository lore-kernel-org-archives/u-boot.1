Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F71CC4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 17:25:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73B8287030;
	Mon,  6 Nov 2023 18:25:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="It9DqNVw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48E9A86FFA; Mon,  6 Nov 2023 18:25:32 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7218F87091
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 18:25:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-53e70b0a218so8121120a12.2
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 09:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699291520; x=1699896320; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dPqphffhmeb7CaekgVIE+KcfmM8MQmJkj5cvjjgTj+Q=;
 b=It9DqNVwWjk1Ux57dNBd3Jc6APpzbl3R6115JskNS40a93/vFAhp20VjXrIwBCYWLh
 eBV5rlVva8VTBFmdFNe6k9hnvCr4iSrGxay+usBRhe0vztdXh1UonYRbvzCaOmqN5i+F
 BUGuBx+t9mnSIBBx0ER6cZc/B/HAjtZaGdcwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699291520; x=1699896320;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dPqphffhmeb7CaekgVIE+KcfmM8MQmJkj5cvjjgTj+Q=;
 b=QkAtfD+RFOAPvwhjm2AlAqgrHxRYf2s7zdx52w1rYhkDTlaTbqtw9S0iADV6ngVCgw
 DCeuhMLjcF6zHYx7FfVffkzaz8QoEwWo0Jsi/AQSXAy5qw7UubafJ1dGpAD7oZ9WhAml
 3+1uoNUGraGdmhR0u0GcqDQPZTDbQ+XMt+s6LDnuFKtDN3GJQO85C4C271tD0eDq0TWK
 vjlsjPJ7NsQz0kOvLc8xucLR9vGiYTlaJ0p4M8BDAB+jxDVBJJBUrqa/ppyQ9twi/E0p
 9ii79d9CthNMgNG1U/XggMwIP9V0ENYo2xUe7xP0CYL/3vywS50Vwv/1HjlcA1zBuCQ5
 qd3A==
X-Gm-Message-State: AOJu0Yx0mVKGhaRKn0Rli1u3jyvbIBhyILD5NfeyQnycFszxVYCjoCR1
 ohbcwoABhzDhVFsTJ4afvylBdKOY4BKvWtWZiycJbA==
X-Google-Smtp-Source: AGHT+IHaTCxwtvFowbS1QDOCTtcIArIfe3leOJS9XZOTSzYf0fyBFJrKTairFvbdhOQKpY8FSA2Ppzk4qKfqafUdMHA=
X-Received: by 2002:a50:a45b:0:b0:543:5fc0:de22 with SMTP id
 v27-20020a50a45b000000b005435fc0de22mr17616852edb.24.1699291520106; Mon, 06
 Nov 2023 09:25:20 -0800 (PST)
MIME-Version: 1.0
References: <20231104065107.23623-1-heinrich.schuchardt@canonical.com>
 <CAPnjgZ36uRkVGKicr_hD-=0HO+i9giQ7vRxo0uKD+BGQnLWdWw@mail.gmail.com>
 <874c3e34-56db-4f3a-acad-099d16735333@canonical.com>
 <CAPnjgZ3LHxNtf1RGRJzwT-9vF_03JdN_3SRF3o9QYNzshpp1cQ@mail.gmail.com>
 <e0d4ec60-96fe-44c0-ac18-69b69bc14283@canonical.com>
In-Reply-To: <e0d4ec60-96fe-44c0-ac18-69b69bc14283@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 6 Nov 2023 10:24:57 -0700
Message-ID: <CAPnjgZ0tMbFn66JiKQWDxXgCZKYToN1Po+8img3NEudtsTfd8w@mail.gmail.com>
Subject: Re: [PATCH 1/1] rng: detect RISC-V Zkr RNG device in bind method
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Rick Chen <rick@andestech.com>, Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de, 
 Xiang W <merlew4n6@gmail.com>, Andre Przywara <andre.przywara@arm.com>
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

On Sun, 5 Nov 2023 at 14:54, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 11/5/23 18:25, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On Sun, 5 Nov 2023 at 03:47, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> On 11/4/23 21:42, Simon Glass wrote:
> >>> Hi Heinrich,
> >>>
> >>> On Sat, 4 Nov 2023 at 06:51, Heinrich Schuchardt
> >>> <heinrich.schuchardt@canonical.com> wrote:
> >>>>
> >>>> The existence of devices should be checked in the bind method and not in
> >>>> the probe method. Adjust the RISC-V Zkr RNG driver accordingly.
> >>>>
> >>>> Use ENOENT (and not ENODEV) to signal that the device is not available.
> >>>>
> >>>> Fixes: ceec977ba1a9 ("rng: Provide a RNG based on the RISC-V Zkr ISA extension")
> >>>> Reported-by: Andre Przywara <andre.przywara@arm.com>
> >>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >>>> ---
> >>>>    drivers/rng/riscv_zkr_rng.c | 34 ++++++++++++++++++++++++++--------
> >>>>    1 file changed, 26 insertions(+), 8 deletions(-)
> >>>
> >>> This device should be in the DT, so you have some control over which
> >>> RNG is used.
> >>
> >> The device-tree provided by QEMU does not contain such a device as Zkr
> >> is an ISA extension and not a device. This device-tree is not under the
> >> control of the U-Boot project.
> >
> > Why do you bring up QEMU? I would expect that it follows the norma dt
> > bindings, so it should not be any different from real hardware?
>
> Yes Simon, QEMU follows the normal bindings. If you want to change
> these, please, contribute to the RISC-V working groups or to the Linux
> kernel project.

Rick, can you help with this? I am thinking of something like this as
a top-level node:

rng {
    compatible = "riscv,zkr";
};

>
> >
> > Anyway, you could add it. It is just a binding. I believe RISC-V has
> > all sorts of isa options which result in different machine features.
> >
> > What are you going to do when you want to choose between the ISA RNG
> > and a TPM one?
>
> First of all there are different configurations switches for both
> drivers. But of course you can enable both. They will be different
> U-Boot devices. The rng command has a parameter to choose a RNG device
> by device number. This is not different to having two USB drives.

Did you see the other discussion about this? Without a propert driver,
there is no way to choose which RNG device is used.

Also the comment is very clear:

/**
 * struct driver_info - Information required to instantiate a device
 *
 * NOTE: Avoid using this except in extreme circumstances, where device tree
 * is not feasible (e.g. serial driver in SPL where <8KB of SRAM is
 * available). U-Boot's driver model uses device tree for configuration.

Do we need a build-time warning so people don't forget this?

Regards,
Simon
