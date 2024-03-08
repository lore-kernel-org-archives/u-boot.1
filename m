Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54FD4C54E41
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 20:23:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B93287D47;
	Fri,  8 Mar 2024 21:23:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Gza9Qmai";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86B4F87D48; Fri,  8 Mar 2024 21:23:09 +0100 (CET)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D591387D3D
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 21:23:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-58962bf3f89so661143a12.0
 for <u-boot@lists.denx.de>; Fri, 08 Mar 2024 12:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709929385; x=1710534185; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SmobVFb4dothDk+mUDKDkRtC8w/J1dl0n5HS9SNDY5s=;
 b=Gza9QmainmKZgG9cHnkSLsZpZdIdVL20gnBjDoT+EiMR6eAZZdl7QDymMXZv/vIoCJ
 jZ3E+CuEhCBZy4R8llhOIt4AAFCqjUsjNKDrHuiEPu4kBwSQ2TYQgiKtE8A20H5Ay1ew
 aN0/QFCI8ZxzvqINJKNk6jgYSsd/0opeCJlGLukTRMVufisiDX3wHAyDb/Mbrdid4wfm
 re/qCnmJy0Yocs2ZwVeFxOFJwu9U0XoWyYYFcWL0Rchd//uEAiMrOB8IfyVHBJn7Tqiu
 CHTZ4GkLOdl0UOkpU6ob1/hX4sdSMFJdBATGrHOEBzcWO8anRH1ecJqXLk8tqfD6zvwd
 y0Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709929385; x=1710534185;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SmobVFb4dothDk+mUDKDkRtC8w/J1dl0n5HS9SNDY5s=;
 b=IZ0jjKm00bBwfitwezT0jsQNn/fU9LwnkZWgskNMQJ9CGHNm8HTqglrqUZwT/byNKK
 j5+RcCyLAHfNLObqooQcCELfTpljqwqHgAykdTNxsfpMvKnRtSmNIynCQku5VKOuDIGd
 m9SFIV22YATk7wWL6HOfeiLs17c2bCrk1iEOXjhvSEl8Wys3mtSA8giVYKmA+z0f4Qhq
 IIsO2A4yl3+QUSt4PPHz31u0+xmzg2LiYUvzvCLQjFwhPdB1Vpx/yT3t2ncYrCjrd5M8
 iTvnAM4BecktanJBLq/NWgTe8A86fgxyiS0BypuAhbPq7sWdnL57suLiH92nv7NAnYzD
 m+Og==
X-Gm-Message-State: AOJu0YzZtMSuyinFNz02abL23c1obG8HbnaVUBmPOkZ/Fehf+Ry0RUR6
 d+hgJ6jy0wRs1yeHj9LUZsQUAMC4HhRANEwxRQul2VvO6Wsvfn5K6N2KStnj8q8O/jZDFh7zk1E
 ZYtecWfcBn83JzwruPe5XDhITtLw=
X-Google-Smtp-Source: AGHT+IGLV39OeyaGG+XR9Zk/V4NJN7PWbriJd9hJa/6FpR+ZZc1OXr4nvBE9Gsb6qdhHCtmBuyyFFngNbqe+d5T7lAw=
X-Received: by 2002:a05:6a21:318b:b0:1a1:7528:b45e with SMTP id
 za11-20020a056a21318b00b001a17528b45emr93454pzb.3.1709929384962; Fri, 08 Mar
 2024 12:23:04 -0800 (PST)
MIME-Version: 1.0
References: <20230214133814.4173549-1-paul.liu@linaro.org>
 <20230214133814.4173549-2-paul.liu@linaro.org>
In-Reply-To: <20230214133814.4173549-2-paul.liu@linaro.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 8 Mar 2024 17:22:53 -0300
Message-ID: <CAOMZO5B=EYPSNXkr=FM+iRvRYiv9fysB8DfhntuhQ_jhkKz38Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: Reduce add_map() complexity
To: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
Cc: u-boot@lists.denx.de, Marc Zyngier <maz@kernel.org>, 
 =?UTF-8?Q?Pierre=2DCl=C3=A9ment_Tosi?= <ptosi@google.com>, 
 Tom Rini <trini@konsulko.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
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

Hi Paul and Tom,

On Tue, Feb 14, 2023 at 10:38=E2=80=AFAM Ying-Chun Liu (PaulLiu)
<paul.liu@linaro.org> wrote:
>
> From: Marc Zyngier <maz@kernel.org>
>
> In the add_map() function, for each level it populates, it iterates from
> the root of the PT tree, making it ineficient if a mapping needs to occur
> past level 1.
>
> Instead, replace it with a recursive (and much simpler) algorithm
> that keeps the complexity as low as possible. With this, mapping
> 512GB at level 2 goes from several seconds down to not measurable
> on an A55 machine.
>
> We keep the block mappings at level 1 for now though.
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Pierre-Cl=C3=A9ment Tosi <ptosi@google.com>
> [ Paul: pick from the Android tree. Fixup Pierre's commit. Rebase to the
>   upstream ]
> Signed-off-by: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Link: https://android.googlesource.com/platform/external/u-boot/+/96ad729=
cf4cab53bdff8222bb3eb256f38b5c3a6
> Link: https://android.googlesource.com/platform/external/u-boot/+/6be9330=
601d81545c7c941e3609f35bf68a09059

I know this is an old thread, but this commit causes the following
boot regression on a colibri-imx8qxp board:

U-Boot 2024.04-rc3-00070-gecc9298a893b (Mar 08 2024 - 17:15:31 -0300)

CPU:   NXP i.MX8QXP RevC A35 at 1200 MHz at 51C

DRAM:  2 GiB
"Error" handler, esr 0xbf000000
elr: 0000000080020914 lr : 00000000800209c0 (reloc)
elr: 00000000ffec4914 lr : 00000000ffec49c0
x0 : 0060000070800401 x1 : 0000000070000000
x2 : 0000000010000000 x3 : 0000000000000002
x4 : 0000000040000000 x5 : 0060000000000401
x6 : 0000000000000c00 x7 : 00000000fff45140
x8 : 0060000000000000 x9 : 00000000fff45100
x10: 000000000a200023 x11: 0000000000000002
x12: 0000000000000002 x13: 00000000800a10e8
x14: 00000000ffffffff x15: 00000000ffec4cb8
x16: 0000000080056a88 x17: 0000000000000000
x18: 00000000fd6c1d70 x19: 000000000f600000
x20: 0000000000000000 x21: 0060000000000401
x22: 0000000070a00000 x23: 0000000000200000
x24: 0000000040000c28 x25: 00000000001fffff
x26: 0000000000000003 x27: 0000000070a00000
x28: 0000000000000002 x29: 00000000fd6bbfd0

Code: 1100047a a90573fb aa0103fb 2a0303fc (b5000113)
Resetting CPU ...

resetting ...

Reverting this commit on top of master fixes the boot regression.

Any ideas?

Thanks
