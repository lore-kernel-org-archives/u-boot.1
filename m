Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 623EAE88D6E
	for <u-boot@archiver.kernel.org>; Sat,  4 Apr 2026 01:49:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77DCE839D5;
	Sat,  4 Apr 2026 03:49:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=0x0f.com header.i=@0x0f.com header.b="qC3vELNR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C37983642; Sat,  4 Apr 2026 03:49:20 +0200 (CEST)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4890E83642
 for <u-boot@lists.denx.de>; Sat,  4 Apr 2026 03:49:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-c70c112cb61so1312648a12.0
 for <u-boot@lists.denx.de>; Fri, 03 Apr 2026 18:49:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775267354; cv=none;
 d=google.com; s=arc-20240605;
 b=TYQFnHA7ekmRNE0u2Z5/P5SXjNZgiNxpKG6t27iDYpvR/Y41UfGXHh7jW+xxagr+eF
 6Esvf8/ZtsYtkLwDlM5iREBo/N025yTxdos/h3j7F8vWMJG2mmS40SMVlze9mEU8Z1jk
 VGULhmT92WGf4kx+TAsbdX51Zxus+qPo6GfJ8SAZqEPY4uKTeWmBRyptYFcuFx1Zb4C1
 QZ8OzazAPr2f8p1ibD6b4l+cDW/m20B68D6P3x5ghQdaO0IV2wf5+xhG5c6TVio/otaR
 +lsie6LC/Izbx7X7IvZuHR1QgF/Sj0q2EpsUR4EP9umGrwcynwR/mrxb6F5DYm6jQGHl
 2fAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=D+P4tiE4DWcxv7dGzcj6pC1xHzEspJzUlpt8l65BfsI=;
 fh=SzBzyNi005PpH/XaxKiLZXzYaFVsaS2YRuavy5x6t1Y=;
 b=CC1VC6nrBuhr/En8Yi4xfAacyIHgoGageJcWkwTbZjqpJCdUatX9JngiZ1qJYtVbCK
 GLukR51+/pBx4KMY2XsCVayP5O1N2D1108OSJHQzdKlytjc2wL3HN9RX/Fsknii/ZFOm
 2tvHHHnEhKS7rhiJmle0EaQkBTNH6ghoakcr0GnMvvEXK0yGSy9ApAUw5J6bOfJ+eCrV
 ubO/H3npDeGuXgYqZjOFG48nRD8bKy9vnM/OjvIZGgQLzB0qxeA5W9ZlNpnpfoZlGlKK
 mRrMRWkWlJYGPxtii4ygua61Zbn8kFGoSfpluM/joxyY35ok4KPXKut7VLYyABvTrRom
 aiPw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0x0f.com; s=google; t=1775267354; x=1775872154; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=D+P4tiE4DWcxv7dGzcj6pC1xHzEspJzUlpt8l65BfsI=;
 b=qC3vELNRl5c4XgDbIPxdnihuPTcz5DKSG7Hb0zyuBp95FKoEudob+LyViGCoh9FGjW
 ZN415BOAgd5pDAg3BVih00xophXO8BP2gg/G8MUUB4VLVA1blir9MN/bdL2r0ua5NtOO
 RqzmI0g8HOt319XL/rFbmsEjo86Gr8mFNxL3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775267354; x=1775872154;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D+P4tiE4DWcxv7dGzcj6pC1xHzEspJzUlpt8l65BfsI=;
 b=hekMYqkWWEqo2BjQSotHNEjHhmDhZ6LDn2rcuPi+qSn+NmONV/oouZQ937jkiJXgpc
 wjb0LX+xlo5OkpFsiNC+4n0Y275SnVdNBJvmAT+txwaXnk6BE5BEYCn++Twt7JtcsjSc
 2aoB2Fk8EwznEaDcXzzwecavQGN2qSAAStC7Qa72pg7i6A9/wURbRgsPRaVvmCwIWaSe
 B1e7K4fmqwsZxPSj/6NBaFtxIACMIvrD90pD188L5vQcE6ShF6W43u2+V5nSIkHpkxil
 YYofRxSx0qS19wyuXmLx6A1cvssckj3tHHQi211rslhtmqX/g7hFx04PpgPQC03Uw+8A
 fRDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMP/1jsWh6nEkl9MOoTB+En9lzYtxBjNFFWPfvBm0w6G8OtlWYKjrqEtUdBcS4vyDLiLwBrX0=@lists.denx.de
X-Gm-Message-State: AOJu0YyPxbkjGoQGvK+yVP6rsDA2+xBZmjp3Qoe6u6eb5twYM5kJRrB+
 7RDfXt4YO5H+BeDOxlaO6CYtYSCZ6vF6EUEGXavB1PahUCxDghKt1NKIB+ac/0zpwJR8Eq+mcjc
 I5dVYYVLjOjL7yBmmnjmXc+A7fQHK9Pbkj51/swtg9A==
X-Gm-Gg: AeBDiesn8Rtxz7rQVEtDkewGhxJRn06emz9wC7P8wL+N/Hr4WiKo1MJ63UDXsMoJ/xu
 DAqpMDzJD/MjJ+S91WK3s3PuWjPkdPBsnAHK26SqtFMeBZN0jCZa2pbSKt6PRUzqyjbKi1YR6pT
 cCRFSgX0Mfo0RQR3kJpT2jgSCyKI8BLQpgJSCwHK7Jdvhr5mpHUQiSR7zmpIrsLxphiPPJLdAfv
 sDdefoIp6nmGl+4oSEantTl+p9U8L+SCi6kxym56T3K1dMxZoNKkzr/vDyJeuTj0X2G7V/uuV/5
 WY2D
X-Received: by 2002:a05:6a20:6a28:b0:398:8db5:4131 with SMTP id
 adf61e73a8af0-39f2ed95189mr4661613637.9.1775267354346; Fri, 03 Apr 2026
 18:49:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260310135940.1756141-1-daniel@thingy.jp>
 <20260310135940.1756141-3-daniel@thingy.jp>
 <CAFr9PXn3abM6DcbfJBBbokBtQ02XrfK66jVtjCGo8+_V-mtkzw@mail.gmail.com>
 <ac7G35VDs5TV4GCP@google.com>
In-Reply-To: <ac7G35VDs5TV4GCP@google.com>
From: Daniel Palmer <daniel@0x0f.com>
Date: Sat, 4 Apr 2026 10:49:03 +0900
X-Gm-Features: AQROBzCdtAh93lsJYk3koiGpTTCbbY4IzpMc4CN5I-nR68JcFwKkunz5NK14ffU
Message-ID: <CAFr9PX=FgjwkTPN5wwquxKW7y8XZGp2BKCw5i1c4YKP3-3eNpQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] virtio: mmio: endian *fixes* *HACK*
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: angelo@kernel-space.org, bmeng.cn@gmail.com, laurent@vivier.eu, 
 u-boot@lists.denx.de
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

Hi Kuan-Wei,

On Fri, 3 Apr 2026 at 04:43, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> >
> > I have a patch for this in my Linux tree too so I sent that:
> > https://lore.kernel.org/lkml/20260314030612.1949420-1-daniel@thingy.jp/T/#mab66837bb90c30916fd0fc066245bdeb9918e96c
> > It would seem our versions of readl(), writel() etc are broken. For
> > Linux the nommu versions are broken, for u-boot it seems they are all
> > broken. By broken I mean they should be expecting a little endian
> > value from the access and then converting to the CPU endian. (I think)
> >
>
> Sorry for the late reply.
>
> So it sounds like we have to fix all the broken readl/writel() in both
> Linux and U-Boot first.
>
> For U-Boot, I think we need the following fix? (totally untested yet)
>
> diff --git a/arch/m68k/include/asm/io.h b/arch/m68k/include/asm/io.h
> index 35ad4a1c044..0106a57a03e 100644
> --- a/arch/m68k/include/asm/io.h
> +++ b/arch/m68k/include/asm/io.h
> @@ -31,10 +31,10 @@
>  #define writew(b,addr)         ((*(volatile u16 *) (addr)) = (b))
>  #define writel(b,addr)         ((*(volatile u32 *) (addr)) = (b))
>  #else
> -#define readw(addr)            in_be16((volatile u16 *)(addr))
> -#define readl(addr)            in_be32((volatile u32 *)(addr))
> -#define writew(b,addr)         out_be16((volatile u16 *)(addr),(b))
> -#define writel(b,addr)         out_be32((volatile u32 *)(addr),(b))
> +#define readw(addr)            in_le16((volatile u16 *)(addr))
> +#define readl(addr)            in_le32((volatile u32 *)(addr))
> +#define writew(b,addr)         out_le16((volatile u16 *)(addr),(b))
> +#define writel(b,addr)         out_le32((volatile u32 *)(addr),(b))
>  #endif
>
>  /*

Doing this might fix virtio but break anything that relies on the
current behaviour. At least in Linux Coldfire has hacks in its io
macros to retain the broken behaviour for certain places but have the
correct behaviour for others (PCI I guess).
Since MMU-abled classic m68k seems to have the correct behaviour in
Linux I think we should split the u-boot io macros into Coldfire and
classic m68k and make classic m68k match Linux. That will avoid
breaking anything in coldfire that uses the io macros and depends on
the current behavior. But I guess we might need to revisit the pieces
you added for the virt machine to make sure they still work.

nommu classic m68k is broken in Linux but I intend to send a patch to
make it match MMU classic m68k.

Cheers,

Daniel
