Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98360E77199
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 17:18:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E7BB800DF;
	Wed,  8 Jan 2025 18:18:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ykSKkEC8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD220805E2; Wed,  8 Jan 2025 18:18:14 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35BD48006D
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 18:18:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4361f65ca01so764915e9.1
 for <u-boot@lists.denx.de>; Wed, 08 Jan 2025 09:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736356692; x=1736961492; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GyhYSS3hpzy7MkcvyKHosjkXhJ3LSlBrEclyeIo6epI=;
 b=ykSKkEC8dq8qzw6MBRm8aSxY+exyInr9CgQ38+u1fb2YdP4gGhuI1tHHqnZu0jVbne
 Tw1ZFw5iXqva5DBe0jaPDa0626RJjjU2HNxx9qvcg9CUvXyNFqTwpPfcjbRgeTBOc6Wx
 0aqP4rW0n/E9Gfgp/9SzNZYC+2+kHWB35qGLPu2BfmWjnIR5NSQt+QDuXGAJhS+dQOQQ
 D1IxAvvlNi0DFRPzH/QNXTFsnizdpFLsgKXrAnmJ7xr4FomT3zA3Ngt7bMGK7DSpphRt
 QXsa5RaeE0bd2gjnx/Nw8N82xEWDIfocnTBBEwK3Ov8vcztw3+l2+UJJS3NFGkOuKXek
 tCjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736356692; x=1736961492;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GyhYSS3hpzy7MkcvyKHosjkXhJ3LSlBrEclyeIo6epI=;
 b=BtqGV8/DkTTI350wwUQ9d0FyrKbmD6puM9C0jOSbYJegw475epGSPjdnFtuWTKQIFK
 aSzSDuIePSK6Iwsy7DapyHKF/A8otnF1B8unOlOBOs1QQ53ULS4UxV+bVI12FN304FP0
 71HiT2ZcdcjIlarJI8kohKbDAc4DA6eLirrBQiDLjkuvxebRkvEGBQ4e2QECUxce9kEV
 oOJsJrwT5wOnBZWbJT/L9myhUzy1osHHXsLjaY4UQoNuNerhJRIQPb/yMeIdSTD6bDkr
 BJzICoYRCzA3uOZRftFg0pMGPZG1loz5mVfg25H8TUCKSokL6NH56DT63uVvnD3viZlh
 sIjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyCPsgdOhVzG+cDMVEPZ+M/9zYGDoffS+s7jptUFP4ob4NvOi4+VSdlmtLj+CuW5Op5AMKMn0=@lists.denx.de
X-Gm-Message-State: AOJu0YzvmEjW+wRfl8GlZCK40iVBKlGm5ZhmNOCEgzIn3L6xsTJXoKBQ
 i8nhwakqjTptX8qfj2vMd7AGgv4iIv69pIUNmbwpfw2dsUSkC9eqfEd3OYTia0M=
X-Gm-Gg: ASbGncvowx/ZgAdGxf/9XzT9P9YzNH4ML7CngYE8HcpGwxAmrZRa6M2ymHQ8O5hs9Lp
 oFSoT8yTTdJedj4aWs51I3mKOEi0IbV24brWkGLoGgBfb2BGaOtsbi9VMZzTzGpRGEkGss/3j+e
 8DnTNIhMZwvRqeNIAOpGywj6kPfGODGsu6/euZXBjW741LxpOvhPiF5unTEAko5bdjEE8cAdW49
 ljyEdRpCURwV3nL4s+cxnC/CPKzKLUF1wrSUzDhUsTXpuz1UHKO8RzGlkgS5g==
X-Google-Smtp-Source: AGHT+IFUjg7hd2BmI+hmN0jD4vEcU+Pjm/2Q2YgTiCjbc8HBTVmiS6/cpQuSZEoU7Uz1WnwBRkEn2g==
X-Received: by 2002:a05:6000:470b:b0:386:37f5:99e7 with SMTP id
 ffacd0b85a97d-38a872f51a3mr3008220f8f.33.1736356691337; 
 Wed, 08 Jan 2025 09:18:11 -0800 (PST)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a88d0d608sm1518058f8f.36.2025.01.08.09.18.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 09:18:11 -0800 (PST)
Date: Wed, 8 Jan 2025 20:18:07 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Yixun Lan <dlan@gentoo.org>,
 Huan Zhou <me@per1cycle.org>, u-boot@lists.denx.de,
 Ben Dooks <ben.dooks@codethink.co.uk>,
 Marcel Ziswiler <marcel@ziswiler.com>, Bin Meng <bmeng@tinylab.org>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jonas =?iso-8859-1?Q?Schw=F6bel?= <jonasschwoebel@yahoo.de>,
 Kever Yang <kever.yang@rock-chips.com>, Leo <ycliang@andestech.com>,
 Michal Simek <michal.simek@amd.com>, Nishanth Menon <nm@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Randolph <randolph@andestech.com>, Rick Chen <rick@andestech.com>,
 Samuel Holland <samuel@sholland.org>, Sumit Garg <sumit.garg@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>,
 Huan Zhou <pericycle.cc@gmail.com>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Padmarao Begari <padmarao.begari@amd.com>
Subject: Re: [PATCH] riscv: spacemit: k1: probe dram size during boot phase.
Message-ID: <a6c23382-4406-4306-b544-4117f631a32e@stanley.mountain>
References: <20250108-get-dram-size-v1-1-4bae32ecf756@per1cycle.org>
 <20250108111105-GYA3276837@gentoo>
 <34F2FA88-E868-45C0-B73B-98BADEF49263@gmx.de>
 <2f6d95b7-da47-4a6c-a566-b73db825410b@stanley.mountain>
 <CAFLszTg4e8M01fScjjzhKvbG7AzgbTiZ3RgnzTvZN4-WZafPLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTg4e8M01fScjjzhKvbG7AzgbTiZ3RgnzTvZN4-WZafPLA@mail.gmail.com>
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

On Wed, Jan 08, 2025 at 10:03:08AM -0700, Simon Glass wrote:
> Hi Dan,
> 
> On Wed, 8 Jan 2025 at 05:37, Dan Carpenter <dan.carpenter@linaro.org> wrote:
> >
> > On Wed, Jan 08, 2025 at 12:21:18PM +0100, Heinrich Schuchardt wrote:
> > > Am 8. Januar 2025 12:11:05 MEZ schrieb Yixun Lan <dlan@gentoo.org>:
> > > >Hi Huan:
> > > >
> > > >On 16:49 Wed 08 Jan     , Huan Zhou wrote:
> > > >>
> > > >>
> > > >..
> > > >> ---
> > > >remove above "---"? otherwise following commit message will be
> > > >dropped during patch application..
> > > >
> > > >> This patch introduce improvement for get dram size on bananapi BPI-F3,
> > > >> retrieving the dram size dynamically.
> > > >> Have tested on bananapi BPIF3 4G and jupiter 8G.
> > > >>
> > > >> Signed-off-by: Huan Zhou <me@per1cycle.org>
> > > >> ---
> > > >>  arch/riscv/cpu/k1/dram.c | 40 ++++++++++++++++++++++++++++++++++++++--
> > > >>  1 file changed, 38 insertions(+), 2 deletions(-)
> > > >>
> > > >> diff --git a/arch/riscv/cpu/k1/dram.c b/arch/riscv/cpu/k1/dram.c
> > > >> index c477c15cbfb19f0e3a0ee72985b602f5bda352d7..095217f2a4c053f7477d62c0776bcb51e623db47 100644
> > > >> --- a/arch/riscv/cpu/k1/dram.c
> > > >> +++ b/arch/riscv/cpu/k1/dram.c
> > > >> @@ -4,17 +4,53 @@
> > > >>   */
> > > >>
> > > >>  #include <asm/global_data.h>
> > > >> +#include <asm/io.h>
> > > >>  #include <config.h>
> > > >> +#include <bitfield.h>
> > > >>  #include <fdt_support.h>
> > > >>  #include <linux/sizes.h>
> > > >>
> > > >> +#define DDR_BASE 0xC0000000
> > > >>  DECLARE_GLOBAL_DATA_PTR;
> > > >>
> > > >> +static inline u32 map_format_size(u32 val)
> > > >> +{
> > > >> +  u32 tmp;
> > > >> +
> > > >> +  if (val & 0x1 == 0)
> > > >please add brackets explicitly, something like
> > > >     if ((val & 0x1) == 0)
> > >
> > > We tend to avoid == 0 in U-Boot
> > >
> > > if (val & BIT(0))
> > >
> >
> > That's reversed.
> >
> >         if (!(val & BIT(0)) {
> >
> > I have really complicated rules about when to use ! vs == 0.
> > https://staticthinking.wordpress.com/2024/02/20/when-to-use-0/
> 
> I  mostly agree with that and it provides some motivation for the
> conventions which have built up over the years in Linux/U-Boot/etc.
> 
> If you want to send a patch:
> 
> $ git grep 'if (ret != EFI_SUCCESS)' |wc
>     864    4841   51380
> 
> I think the only place I would differ is with strcmp(), where I've got
> used to 0 meaning success, like in much other code.
> 

Huh...  I've never thought about it as a success/fail thing.

I feel like I've seens quite a few reversed strcmp() functions but it's
hard to catch these sorts of bugs with static analysis because it
totally depends on the context if you want the strings to be equal or
not equal.  I can't imagine what a static checker rule would look like.

regards,
dan carpenter
