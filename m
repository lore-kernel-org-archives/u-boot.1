Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCA5BC47422
	for <u-boot@archiver.kernel.org>; Sun, 21 Jan 2024 22:08:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2CD6876F4;
	Sun, 21 Jan 2024 23:08:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="INTyiKjq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29764876E5; Sun, 21 Jan 2024 23:08:08 +0100 (CET)
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com
 [IPv6:2607:f8b0:4864:20::a2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFF0387897
 for <u-boot@lists.denx.de>; Sun, 21 Jan 2024 23:08:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-vk1-xa2b.google.com with SMTP id
 71dfb90a1353d-4b72e63821eso2105742e0c.1
 for <u-boot@lists.denx.de>; Sun, 21 Jan 2024 14:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1705874884; x=1706479684;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7Isi6Ek/FmMDNeaqeuDRFIGtM0qiAtCJK3NOONPDX78=;
 b=INTyiKjqcG7sbRtBd6DiYzNMRwcnKKPnn25H15opMUhfosfgp8VW4ra55klX4QwQrf
 vea6QvDY69a/2iCsTQDLmi2M3STMZk/DU9RI8PmzAfYUBA1KMXPDsuYObUFnyG7SFx88
 CLygpqzWOQnq/wDddZM0kPp0qoJi3gxdlcBt4uF7zqtdeAWse50IT5e0uWm9M5OwPPfQ
 tZOmUj/A36klX9f7yNrRxZuD/yNZ8NvSNAa2PSEEzMkmaJOvrzjMh76kZHfdtIui7vPv
 pHvm+8EXD91rkn7Efo+Bj/9qdHs3IU7xqG3E+Q3F55YSYKuhkaw8cG7DPpVcT7ynrjiG
 9tdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705874884; x=1706479684;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7Isi6Ek/FmMDNeaqeuDRFIGtM0qiAtCJK3NOONPDX78=;
 b=l2Llxv7ssApK/d3pSPyOUiBNjDfHcs/kSP3NFg1LtnCTzQWl/4LHjRfX+W/m6FNI58
 rHlKBYeOQ9dbfWthM1OgYT9zAaDRoNEd/SSt4/TmqMDqvqjMT80dbrfopU1/Nd0m6jYk
 g8j1EyuPx4PFc5py8yt1Nzoq4aH9eoMapCNIpl8NXjzbY86BF+hYjyObbb6SLptb5Fyz
 z0/PYNUM2gBC+RAfc0MWEbBszMaj217zTzsZdI94uPBo8ZOpP8bjrzcU4cd1M2gssUo8
 n9fanfXySxfjArtsaTYcmP3UKqbuYdyhmgoCaonly6bPilPm3GZSoJs2g2ENcWxk4IKU
 Lb7A==
X-Gm-Message-State: AOJu0Yy/DI7F7d03Lfhbb41TShVl8OW5EMp5q2Hk0AjGdvEING3nGLiD
 9WNqpWH9mA+pueNsprH9wbK3KRZ1dL+jdMh1fY67vMCfwoTwm/UsJdXU5GGxg4MXytXeY/V4bkV
 yu2u5jNvU7HvaFxt8hMIvGhLehRD83NrkUfBoRg==
X-Google-Smtp-Source: AGHT+IGeib4REoNY8Svsv7EQMtryOd5ssZEE2RhBTEfRkLcKGSW2QkNWdYG5AKIZLChadVncwvcoUVHhzvcHNJ9J1Jk=
X-Received: by 2002:a05:6122:d1a:b0:4b6:c9fa:d8e0 with SMTP id
 az26-20020a0561220d1a00b004b6c9fad8e0mr2042561vkb.15.1705874884426; Sun, 21
 Jan 2024 14:08:04 -0800 (PST)
MIME-Version: 1.0
References: <20231119172310.1307942-1-i@shantur.com>
 <CABEcMwW14BFrA1ZYWTh7iQTsnrXA7LdBPcREKf_QeO71op+Wdw@mail.gmail.com>
 <20231209191853.GA2513409@bill-the-cat>
 <CABEcMwU4C75Xsq9AYdugyPqjPYbrTf3C01gnE+sTM0WDyoMkQg@mail.gmail.com>
 <20231209204507.GH2513409@bill-the-cat>
 <5430e6c4-5d0d-4ddf-bc95-e3fbd2b046cd@rock-chips.com>
 <CABEcMwWfLJ_vHDBLNdFRe4U=+e2fWswF0FD0JAaDF49TtyDp1A@mail.gmail.com>
 <CABEcMwWt2yMXoRZG_s45G+AMDsuEVvNkdVo-8VA5pxN4wXWvCA@mail.gmail.com>
 <df499977-c373-4a95-abe7-3ec596d66050@rock-chips.com>
 <CABEcMwV3NWqjjdWP3aKj1iKSF7kn3FuDY=BAPr=UO-OEX6gcsA@mail.gmail.com>
 <f5332c95-c269-4ee4-85f0-c41476727be2@rock-chips.com>
In-Reply-To: <f5332c95-c269-4ee4-85f0-c41476727be2@rock-chips.com>
From: Shantur Rathore <i@shantur.com>
Date: Sun, 21 Jan 2024 22:07:53 +0000
Message-ID: <CABEcMwU2AOWseDTAtwcDT44XTQMynw29NZh4TzQa=Hb6xRtC7Q@mail.gmail.com>
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

On Thu, Jan 18, 2024 at 3:10=E2=80=AFAM Kever Yang <kever.yang@rock-chips.c=
om> wrote:
>
> Hi Shantur,
>
> On 2024/1/17 17:38, Shantur Rathore wrote:
> > Hi Kever,
> >
> > On Wed, Jan 17, 2024 at 9:18=E2=80=AFAM Kever Yang <kever.yang@rock-chi=
ps.com> wrote:
> >> Hi Shantur,
> >>
> >> On 2024/1/17 14:26, Shantur Rathore wrote:
> >>
> >> Hi Kever,
> >>
> >> On Wed, Jan 10, 2024 at 11:58=E2=80=AFAM Shantur Rathore <i@shantur.co=
m> wrote:
> >>
> >> Hi Kever,
> >>
> >> On Tue, Jan 9, 2024 at 10:55=E2=80=AFAM Kever Yang <kever.yang@rock-ch=
ips.com> wrote:
> >>
> >> Hi Shantur, Tom,
> >>
> >> On 2023/12/10 04:45, Tom Rini wrote:
> >>
> >> On Sat, Dec 09, 2023 at 07:49:04PM +0000, Shantur Rathore wrote:
> >>
> >> On Sat, Dec 9, 2023 at 7:18=E2=80=AFPM Tom Rini <trini@konsulko.com> w=
rote:
> >>
> >> On Fri, Dec 08, 2023 at 10:52:02AM +0000, Shantur Rathore wrote:
> >>
> >> Hi Tom / Kever
> >>
> >> On Sun, Nov 19, 2023 at 5:24=E2=80=AFPM Shantur Rathore <i@shantur.com=
> wrote:
> >>
> >> Rockchip SoCs can support wide range of bootflows.
> >> Without full bootflow commands, it can be difficult to
> >> figure out issues if any, hence enable by default.
> >>
> >> Reviewed-by: Simon Glass <sjg@chromium.org>
> >>
> >> Signed-off-by: Shantur Rathore <i@shantur.com>
> >> ---
> >>
> >> (no changes since v1)
> >>
> >>    arch/arm/Kconfig | 1 +
> >>    1 file changed, 1 insertion(+)
> >>
> >> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> >> index d812685c98..fca6ef6d7e 100644
> >> --- a/arch/arm/Kconfig
> >> +++ b/arch/arm/Kconfig
> >> @@ -1986,6 +1986,7 @@ config ARCH_ROCKCHIP
> >>           imply CMD_DM
> >>           imply DEBUG_UART_BOARD_INIT
> >>           imply BOOTSTD_DEFAULTS
> >> +       imply BOOTSTD_FULL if BOOTSTD_DEFAULTS
> >>           imply FAT_WRITE
> >>           imply SARADC_ROCKCHIP
> >>           imply SPL_SYSRESET
> >>
> >> Can this please be merged in ?
> >>
> >> I wonder if we shouldn't really globally default to BOOTSTD_FULL if
> >> BOOTSTD_DEFAULTS for everyone.
> >>
> >> Its matter of ~21KB in size, unless any platform is really to its
> >> limits it should be alright.
> >>
> >> Maybe I need to re-check things too, since I wonder how much of that
> >> growth is re-enabling things that were removed when dropping the DISTR=
O
> >> stuff, and so for platforms just migrating over now it would be smalle=
r
> >> in size if much.
> >>
> >> A board maintainer is free to enable this option, but I don't agree to
> >> enable this for everyone.
> >>
> >> Not like rk3399 and rk3588, some of other SoCs always want a clean and
> >> simple but usable U-Boot,
> >>
> >> eg. rk3036 and rk3308 are still in the list.
> >>
> >> The discussion is what we consider "usable U-Boot"
> >> By default bootstd doesn't have any options and not even to show what
> >> it's going to boot.
> >>
> >> Would it be acceptable if BOOTSTD_FULL is enabled for SoCs rather than=
 boards?
> >>
> >> Can you please suggest the way forward?
> >> Initially the patch was for RockPro64 and then after discussion it was
> >> suggested that as BOOTSTD_DEFAULT is very very limited
> >> we should enable BOOTSTD_FULL for SoCs that can support multiple boot =
modes.
> >>
> >> Let's enable it for RK3588 first and then maybe other SoCs which not c=
ode size sensitive.
> >>
> > My requirement is for RK3399, so I will enable BOOTSTD_FULL for it.
> > While at it do you want me to enable it for RK3588 as well ?
>
> You can add for RK3399 or both RK3399 and RK3588.
>

Patch v5 [0] has been submitted with RK3399 and RK3588

[0] - https://patchwork.ozlabs.org/project/uboot/patch/20240121220447.66340=
7-1-i@shantur.com/

Kind regards,
Shantur
