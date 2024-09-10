Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAFC3ECE564
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 06:38:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A92188BDA;
	Tue, 10 Sep 2024 08:38:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Tlri1PZ8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C65E88BE4; Tue, 10 Sep 2024 08:38:56 +0200 (CEST)
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com
 [IPv6:2607:f8b0:4864:20::e2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 718BE88960
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 08:38:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe2b.google.com with SMTP id
 ada2fe7eead31-49bc13c3a47so2352151137.3
 for <u-boot@lists.denx.de>; Mon, 09 Sep 2024 23:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725950332; x=1726555132; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MsnDjRpmFA+HPeo106kOO5aT81BhWx6gKkd8OM7WSyI=;
 b=Tlri1PZ8UaNmxZEY0T0JlHMklL5ox6nL1Wn0QUyqIRxUU8/mgPmKZImkWXe1aEx3AQ
 A0w49Rl/PVt2aprlpHTla0qkik8YPbU9jhDe0uMSZlBA2BTbcu7uG7v4SQ2yfKScmHGQ
 TvswHg+DDz1z5e9IpgScWFDuYEVLQAI/AftbDpJsshpmoe/cgP3mCN6fc+5isQcsOmHs
 +JcCV59jVin5gqn6glzw+sR9Zur7NszhwIxhVyJk9nw3qleWibWSlZWyGxzGMVFYJ3r5
 kfknl+7cqRIrNbI37V1DlzQ5ngSUhHijGBXzN7ItTPJz9/bPye0hCyrT1I/759vtboKa
 0v/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725950332; x=1726555132;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MsnDjRpmFA+HPeo106kOO5aT81BhWx6gKkd8OM7WSyI=;
 b=Dc2imrD+YjAVDF3OlS/xexRKm+Vi7cMJ1oakHlq9kow4Z9z618ROoRQfrF0L8XkMUr
 AmIpafZOjuup1VC6t23utq/IPbZ0hPlF/buxMp3qvxwRMy6NGk0+HYnCnNkJJYqj2k8T
 Po430wL/CxrMZBGF7hWozLINvcpIzPgXBTxYlFDYWiJNZzQN4K/AXbsVQrDE90kKB8FM
 tXL39wIQrhmJvNfS1if+27i4gwGaz1IQn2Gs8RU3mAFOt/TxZy1tVk9ef6Ug5QMondtw
 uEfAdyhEOHbiWXzGo4P3sis+qGVTMvzTW51PHxBjZORfru+UDaR5xvhJfUmYqZCIvJnf
 PPVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV608edMMv5eyX9KkMDP57rDSi2bWmBLMaBdeLYo4Pf3Adhrbc/fltUILv91fkm2KPOzsC8gxc=@lists.denx.de
X-Gm-Message-State: AOJu0YxwhYFQDiO7dv3Xo/3lc+D7PX54gpH5MyVrTC/BiW9d+nRNPplN
 Jq5/GnrN5Is0o0EJTTl2sj9NJFCCUsLr98DOVe8Av9PxEhSOORKyN5BCiX9M9cqoMhb1Bh/t+1U
 anDqpKgocPymwx2FkE+prMffQmirYSL1laXLeKA==
X-Google-Smtp-Source: AGHT+IFaUIRJM0yD2w2p1tJMOx/yPs3k7r3EsbHHCCXPFtVII42+lmAfDb3kXiGcFw4jDEcAX0ZceIXatkvRISftPxo=
X-Received: by 2002:a05:6102:52d:b0:49b:e245:2e5d with SMTP id
 ada2fe7eead31-49be24530c8mr11308136137.11.1725950332148; Mon, 09 Sep 2024
 23:38:52 -0700 (PDT)
MIME-Version: 1.0
References: <7765273f-7f36-41e4-a604-1901e4fbec62@siemens.com>
 <20240813125245.ezlu6me3ljwx6dkj@margarine>
 <89f8e976-e831-4035-8cd0-ab6284846d0a@siemens.com>
 <4ec5108f-b7a4-47db-baa4-edee532c58af@siemens.com>
 <CAFA6WYMQustcwo4Es7iJQj5Lva6UiYJ-j7WgSzMjOvEHemeDcQ@mail.gmail.com>
 <4576b818-9732-45ff-a4ab-b98fc0ecf4c9@siemens.com>
 <CAFA6WYNXgJkCX9-aoL5FGchAHGdV+ikTt4+pTJP-jZ_UJG8E6Q@mail.gmail.com>
 <87a9fe3e-5d9a-41e8-a8b2-4368cb727a65@siemens.com>
 <CAFA6WYMGyMAB=m-hkxs87PyHszcbQUk6+0_G0n+0-Yk8NeRXQQ@mail.gmail.com>
 <f61a8c74-9838-481e-aa1e-09fcc07f044e@siemens.com>
 <CAFA6WYNdS0jZ1iESfCErX92SOL2fJSRNNLZ1a_7jHoSfOUrdgw@mail.gmail.com>
 <0ff5653f-60e2-49ee-b68b-d86801aa1d66@siemens.com>
 <trinity-13f6d284-1ea6-4a53-ad60-847791f0c127-1725470974423@3c-app-gmx-bs17>
 <331b4f3f-6b4a-470b-897d-03ac09fd9c0d@siemens.com>
In-Reply-To: <331b4f3f-6b4a-470b-897d-03ac09fd9c0d@siemens.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 10 Sep 2024 12:08:41 +0530
Message-ID: <CAFA6WYM7n+cbFFrN8nH67pYCGo9ENn5Avv-2QOMA4U_ws+9ogw@mail.gmail.com>
Subject: Re: OF_UPSTREAM vs. additional dtbs
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Frank Wunderlich <frank-w@public-files.de>, Nishanth Menon <nm@ti.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Jan,

On Thu, 5 Sept 2024 at 12:08, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 04.09.24 19:29, Frank Wunderlich wrote:
> >
> >
> >> Gesendet: Mittwoch, 04. September 2024 um 19:16 Uhr
> >> Von: "Jan Kiszka" <jan.kiszka@siemens.com>
> >> OK, our overlay sources are on their way into mainline, will only take
> >> until 6.12-rc1 to get them here.

Glad to hear that.

> >> To accelerate the preparation, I ported
> >> that change to a local branch - just to find out that OF_UPSTREAM has no
> >> clue about DT overlays so far. And it is not just that there are no
> >> build rules for them (that was quickly fixed). It's also that there is
> >> no way to trigger their build for your u-boot proper.
> >>
> >> Are there plans for addressing this? I'm inclined to revive my patch
> >> that allows to augment dtb-y from the board's config.mk. Better suggestions?
> >
> > Hi
> >
> > i hang also on this part, in my case i build the dtbos for the vendor and try to use fdtoverlay to merge base-dt with the defined overlays.
> >
> > see commits till July 11th
> >
> > https://github.com/frank-w/u-boot/commits/2024-07-bpi-ofupstream-all/
> >
> > this fails because the target for fdtoverlays needs targets for the dtbos (have used the fdtoverlay target from linux)...
> > but i build then without dedicated target (while building the basedt).
> >
> > maybe you can help solving the "small" problem in makefile.
> >
>
> This is close but not quite the same scenario because I only need "our"
> dtbos, and there is no need to create dtbs with them applied (they will
> be used during dt fixup in our case).
>
> What I've now done is this:
>
> diff --git a/dts/Kconfig b/dts/Kconfig
> index 569d4be338e..7ea4fd5a79b 100644
> --- a/dts/Kconfig
> +++ b/dts/Kconfig
> @@ -226,11 +226,11 @@ config OF_LIST
>
>  config OF_OVERLAY_LIST
>         string "List of device tree overlays to include for DT control"
> -       depends on SPL_LOAD_FIT_APPLY_OVERLAY
>         help
>           This option specifies a list of device tree overlays to use for DT
>           control. This option can then be used by a FIT generator to include
> -         the overlays in the FIT image.
> +         the overlays in the FIT image or by binman when assembling an image
> +         that uses overlays during DT fixup.
>
>  choice
>         prompt "OF LIST compression"
> diff --git a/scripts/Makefile.dts b/scripts/Makefile.dts
> index 790f3c508f1..dc181240a21 100644
> --- a/scripts/Makefile.dts
> +++ b/scripts/Makefile.dts
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0+
>
>  dtb-y += $(patsubst %,%.dtb,$(subst ",,$(CONFIG_DEFAULT_DEVICE_TREE) $(CONFIG_OF_LIST) $(CONFIG_SPL_OF_LIST)))
> +dtb-y += $(patsubst %,%.dtbo,$(subst ",,$(CONFIG_OF_OVERLAY_LIST)))
>
>  ifeq ($(CONFIG_OF_UPSTREAM_BUILD_VENDOR),y)
>  ifeq ($(CONFIG_ARM64),y)
>

Yeah that's all you need to build DT overlays from dts/upstream
subtree. Care to send a proper patch for this?

>
> I will also provide a patch to enhance the machinery in dts/upstream
> /Makefile. This apparently plays no role when building U-Boot, but it
> would still be useful for validation purposes to have overlay support
> there.

As you mentioned we don't use Makefile for U-Boot builds. So it's
better to directly send that patch for inclusion in the DT rebasing
tree.

-Sumit

>
> Jan
>
> --
> Siemens AG, Technology
> Linux Expert Center
>
