Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B8BDC4167B
	for <u-boot@archiver.kernel.org>; Tue, 28 Nov 2023 07:09:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EEB887617;
	Tue, 28 Nov 2023 08:09:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fSng1sxJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C60FA87092; Tue, 28 Nov 2023 08:09:26 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E83287092
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 08:09:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-548ce39b101so6762373a12.2
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 23:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701155364; x=1701760164; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/++mEl69tADWMVUDtYHDi3adaMG1GsH9wClUPjfR9rQ=;
 b=fSng1sxJ/3c7jLYUCML+AgF0SPoxZFPlOyFJBFjKOB6ojEjKP5594GUUOto8+9jZgK
 EI3ZC0OaUS6MNq5ULYMiATmGRbrY6dFSCZl6F0l4zl+lHzytUx4kwcjduDl9lNWx1VAN
 1VQeWlUihMTOgqPQvQRzaN6/9RbP2aXBxzotaNNFqd1qwazkvg+LbxP7NXyv7pe3EnTB
 1BqzDhKb6RT2UYQOOFMFF1KafcpMSqbyqL9E8MPP+lXB7uNzqYS7/v7mCAkuVIDgKwxB
 n9TnGjM87NUQPgNUYBp6ho3uemjDlKiW9A6RhQ8j6rVcwVxNfx9OEW1DkOcAygqZwz36
 oIAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701155364; x=1701760164;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/++mEl69tADWMVUDtYHDi3adaMG1GsH9wClUPjfR9rQ=;
 b=d8H28ttd2oSRlIeF5MR9uLaUtrjFCNrZWByEUUPYkgnoR7Ucln9vx5rzBbY8RIXJCT
 aKa15KgKrj966OUpWKpqy4WuO3PF+gH3yihx0dFs59ukCqo5r6hqEGG3SttsCdlm6QXd
 iTPwFhgBgM2o2nTJ4suZq1LLNZ0ZapKLF3onPJYRoSAC+ia5rwAeNRvkr1nAK5b9rjPB
 T1LfWQ1JlzOjgA65Yf1zGQ3FG3azTq4PK8BU3m+OEgU6YCK5CO9dlJ3ShUb6kOtRK0MT
 yE5bDta1j3EAELOCy0kzmIRarOmZ3TxKFOrk6RoBO7t0slw/LF69MVXlSvXucsc9j276
 ZzBA==
X-Gm-Message-State: AOJu0YyxQSDNSJB+FQcDrxxLFGjXrqnr6EUK59EXtDC38pH/jeiAQmfq
 uYAHU7yrFnkv3yjWMtM0MgVqTzQjZ7h4F92s9Jd9SA==
X-Google-Smtp-Source: AGHT+IFx4rlNfLCsh/Eit77A0abbyJs+xkzrHtuKId+5+8O3zSG3sE2Xf6rHxsumlJGfHBIUQvjjf+ZLE2hFQd0ggWM=
X-Received: by 2002:a17:906:eb4b:b0:a0d:f0ce:2730 with SMTP id
 mc11-20020a170906eb4b00b00a0df0ce2730mr5300317ejb.11.1701155364021; Mon, 27
 Nov 2023 23:09:24 -0800 (PST)
MIME-Version: 1.0
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
 <20231127125726.3735-27-maxim.uvarov@linaro.org>
 <20231127131129.GD2513409@bill-the-cat>
 <c7022ef3-ad0c-4f89-ad47-a0f7df2a24c6@web.de>
In-Reply-To: <c7022ef3-ad0c-4f89-ad47-a0f7df2a24c6@web.de>
From: Maxim Uvarov <maxim.uvarov@linaro.org>
Date: Tue, 28 Nov 2023 13:09:11 +0600
Message-ID: <CAD8XO3aVLzpqV=MDVO2mJBP=sLzSieXhrV8GUPYPpu76mRKjeQ@mail.gmail.com>
Subject: Re: [PATHv11 26/43] configs/tbs2910_defconfig inc limit
To: Soeren Moch <smoch@web.de>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, pbrobinson@gmail.com, 
 ilias.apalodimas@linaro.org, goldsimon@gmx.de
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Tue, 28 Nov 2023 at 03:20, Soeren Moch <smoch@web.de> wrote:

> On 27.11.23 14:11, Tom Rini wrote:
> > On Mon, Nov 27, 2023 at 06:57:09PM +0600, Maxim Uvarov wrote:
> >
> >> Increase allowed binary size to fit lwip code.
> >>
> >> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> >> ---
> >>   configs/tbs2910_defconfig | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/configs/tbs2910_defconfig b/configs/tbs2910_defconfig
> >> index 8fbe84f1d2..ce40efa9ab 100644
> >> --- a/configs/tbs2910_defconfig
> >> +++ b/configs/tbs2910_defconfig
> >> @@ -17,7 +17,7 @@ CONFIG_SYS_MEMTEST_START=0x10000000
> >>   CONFIG_SYS_MEMTEST_END=0x2f400000
> >>   CONFIG_LTO=y
> >>   CONFIG_HAS_BOARD_SIZE_LIMIT=y
> >> -CONFIG_BOARD_SIZE_LIMIT=392192
> >> +CONFIG_BOARD_SIZE_LIMIT=417792
> >>   # CONFIG_BOOTSTD is not set
> >>   CONFIG_SUPPORT_RAW_INITRD=y
> >>   CONFIG_BOOTDELAY=3
> > This is another case where the binary size is a fairly hard limit. You
> > forgot to cc the board maintainer here (and I assume the rest of the
> > series too) for these config changes.
> ThanksTom for sending a notification to me.
>
> Yes, the CONFIG_BOARD_SIZE_LIMIT is a hard limit and this patch in its
> current form will break tbs2910 support and even brick the board for
> some configurations. So NAK for this patch.
> > I think on this platform it's not
> > impossible (like it is on am335x where I just replied) but really
> > difficult. I'll let Soeren comment on if switching the network stack to
> > lwip is the kind of feature enhancement that warrants the pain of
> > dealing with the size change here or not.
> Network boot is no important feature for this board and not used in
> the default boot configuration. But network support always was part
> of the config, may be used by some users, and is at least required
> to communicate the ethernet address to linux.
>
> So I'm not interested in a new network stack for this board, but
> also cannot disable network support completely. This seems to be a
> problem for this patch series, since networking support implies LWIP
> now.
>
>
Thanks Soeren for the explanation. Then yes, something more advanced is
needed
to be done here.



> The question for me is, why is the new network stack consuming so
> much space, with only a few enabled commands? Is the whole library
> linked in with some unused features (the cover letter mentions much
> more than what seems to be used in the converted commands). Or is
> the old network stack linked in in parallel to the new one? Can
> we save space here?
>

Yes, the old code is still there. I decided to not touch it for the first
integration (arp.o, bootp.o, ping.o and
mostly all from net/Makefile).  Those files also have reference code in
net/net.c. Not compiling
and not linking this code will save some space, but It's larger than the
current version.
Like for EVM SPL code with usb+net+ext4 and etc have very minimal space for
network stack.
I will take a look at this more closely...


>
> NFS support in the old networking code is quite big, enabled by default,
> and probably still there in parallel to this new lwip library. If there
> is really no other option to save space, and lwip in general is agreed
> to be the way forward for U-Boot, and only tbs2910 is blocking that,
> then from my point of view disabling NFS for tbs2910 could be a way
> to stay within the size limit.
>
> ok. I think that by default we need something very minimal (dhcp, tftp),
probably ping is even not needed.



> Regards,
> Soeren
>
>
