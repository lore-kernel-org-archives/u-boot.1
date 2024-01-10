Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E8DC4707B
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 11:58:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0124587811;
	Wed, 10 Jan 2024 12:58:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="wkrrDjUt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6081987957; Wed, 10 Jan 2024 12:58:44 +0100 (CET)
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com
 [IPv6:2607:f8b0:4864:20::a33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 010C4877C5
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 12:58:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-4b72f2bdbdaso1116409e0c.3
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 03:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1704887920; x=1705492720;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bHuCPR5HBimgtja5NqrXIMd/yhIlRoUIXW8blM/fZpY=;
 b=wkrrDjUtJCBR3YKm3Z5NG1hMLuxKQxIiSrvbiKKM9749RSd94pwrxZb5v9u+mCHbYP
 yGNscdWw+D6PAJnrZ/yLZLFv0mgc4LNoNj6Wd7WSRXfyRxs09wwo+Vk0hQ5t0f9zVR2Q
 OPp4U1udW4IlNBBEL09xJ6onYsg7+zyLLvIiQcxfCd4HLGRd4PtljYLldgc93mOxDOBi
 68qEybFr/DrmfdnnUTDyENg/k0tl0h+RNEvOUUovhzX02FeHm6/GHtZ8qMMf+iWJbx7X
 oCeEVqsq8CFGE+JxuGwaHaRgGQtrL/gwi81FCwjzBB4GhyVYVJ3SL5sk4qNrKgkun0K6
 75+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704887920; x=1705492720;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bHuCPR5HBimgtja5NqrXIMd/yhIlRoUIXW8blM/fZpY=;
 b=ZC/78fFaSN2W6rhV3ITf5zYmR0Zqm2FS08QpoCfXlp7N7k3nNDHfk1jCBRZnpp0yfk
 r3XdxCPiRq77UfO8lg2P2p1zvMpL1tZnIgcD/Lpg27YIpRfByYKM6f3VKc7F5tgH3DBI
 kP50w2tprd8vnEaGMKdr0AHgaMdUTgjm5YwBKUFoOp3GbiRAueurvi63d7y4iG+jc5mw
 TwsgBrtbeouf3x9IpW1rY9cJVOcUWMT7XrAhgwXOj72M/MbJFX3J1rWzmqaWKxyR9l5G
 fKNzXbJhDDHEDAPsLN11LCf7S5ZV25gDq6NayEP0pfJmXX9W1a4m4strWmOV2rdlsTH8
 mmww==
X-Gm-Message-State: AOJu0YzEGI2Muz2iaGKXYnhWfO6dDJvudi1w1mShoIiLe8R9Y99whvBW
 IdF8mJ9x3n+o4Jjs8AsOOK0kmo2x93mUHTBfSLrM07X+e7AMDA==
X-Google-Smtp-Source: AGHT+IFYl+caJxDtRc+306DXlhDdSK+sQJQrWLzzOxpY9R4wxlfuSMy+8S33etkpcdKpT9CU/LgUK1nhgLcJRnV8tb4=
X-Received: by 2002:a05:6122:4e8f:b0:4b6:c7e6:c669 with SMTP id
 gf15-20020a0561224e8f00b004b6c7e6c669mr383292vkb.17.1704887920683; Wed, 10
 Jan 2024 03:58:40 -0800 (PST)
MIME-Version: 1.0
References: <20231119172310.1307942-1-i@shantur.com>
 <CABEcMwW14BFrA1ZYWTh7iQTsnrXA7LdBPcREKf_QeO71op+Wdw@mail.gmail.com>
 <20231209191853.GA2513409@bill-the-cat>
 <CABEcMwU4C75Xsq9AYdugyPqjPYbrTf3C01gnE+sTM0WDyoMkQg@mail.gmail.com>
 <20231209204507.GH2513409@bill-the-cat>
 <5430e6c4-5d0d-4ddf-bc95-e3fbd2b046cd@rock-chips.com>
In-Reply-To: <5430e6c4-5d0d-4ddf-bc95-e3fbd2b046cd@rock-chips.com>
From: Shantur Rathore <i@shantur.com>
Date: Wed, 10 Jan 2024 11:58:29 +0000
Message-ID: <CABEcMwWfLJ_vHDBLNdFRe4U=+e2fWswF0FD0JAaDF49TtyDp1A@mail.gmail.com>
Subject: Re: [PATCH v3] arch: arm: Kconfig: Enable BOOTSTD_FULL for Rockchip
 SoCs
To: Kever Yang <kever.yang@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Kever,

On Tue, Jan 9, 2024 at 10:55=E2=80=AFAM Kever Yang <kever.yang@rock-chips.c=
om> wrote:
>
> Hi Shantur, Tom,
>
> On 2023/12/10 04:45, Tom Rini wrote:
> > On Sat, Dec 09, 2023 at 07:49:04PM +0000, Shantur Rathore wrote:
> >> On Sat, Dec 9, 2023 at 7:18=E2=80=AFPM Tom Rini <trini@konsulko.com> w=
rote:
> >>> On Fri, Dec 08, 2023 at 10:52:02AM +0000, Shantur Rathore wrote:
> >>>
> >>>> Hi Tom / Kever
> >>>>
> >>>> On Sun, Nov 19, 2023 at 5:24=E2=80=AFPM Shantur Rathore <i@shantur.c=
om> wrote:
> >>>>> Rockchip SoCs can support wide range of bootflows.
> >>>>> Without full bootflow commands, it can be difficult to
> >>>>> figure out issues if any, hence enable by default.
> >>>>>
> >>>>> Reviewed-by: Simon Glass <sjg@chromium.org>
> >>>>>
> >>>>> Signed-off-by: Shantur Rathore <i@shantur.com>
> >>>>> ---
> >>>>>
> >>>>> (no changes since v1)
> >>>>>
> >>>>>   arch/arm/Kconfig | 1 +
> >>>>>   1 file changed, 1 insertion(+)
> >>>>>
> >>>>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> >>>>> index d812685c98..fca6ef6d7e 100644
> >>>>> --- a/arch/arm/Kconfig
> >>>>> +++ b/arch/arm/Kconfig
> >>>>> @@ -1986,6 +1986,7 @@ config ARCH_ROCKCHIP
> >>>>>          imply CMD_DM
> >>>>>          imply DEBUG_UART_BOARD_INIT
> >>>>>          imply BOOTSTD_DEFAULTS
> >>>>> +       imply BOOTSTD_FULL if BOOTSTD_DEFAULTS
> >>>>>          imply FAT_WRITE
> >>>>>          imply SARADC_ROCKCHIP
> >>>>>          imply SPL_SYSRESET
> >>>> Can this please be merged in ?
> >>> I wonder if we shouldn't really globally default to BOOTSTD_FULL if
> >>> BOOTSTD_DEFAULTS for everyone.
> >>>
> >> Its matter of ~21KB in size, unless any platform is really to its
> >> limits it should be alright.
> > Maybe I need to re-check things too, since I wonder how much of that
> > growth is re-enabling things that were removed when dropping the DISTRO
> > stuff, and so for platforms just migrating over now it would be smaller
> > in size if much.
>
> A board maintainer is free to enable this option, but I don't agree to
> enable this for everyone.
>
> Not like rk3399 and rk3588, some of other SoCs always want a clean and
> simple but usable U-Boot,
>
> eg. rk3036 and rk3308 are still in the list.
>

The discussion is what we consider "usable U-Boot"
By default bootstd doesn't have any options and not even to show what
it's going to boot.

Would it be acceptable if BOOTSTD_FULL is enabled for SoCs rather than boar=
ds?

Kind regards,
Shantur
