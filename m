Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D66F1D0D167
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 19:02:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B74884082;
	Wed,  7 Jan 2026 20:02:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RJiUcY/8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F7C783A26; Wed,  7 Jan 2026 20:02:51 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5870484082
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 20:02:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-64dfb22c7e4so2012039a12.1
 for <u-boot@lists.denx.de>; Wed, 07 Jan 2026 11:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767812564; x=1768417364; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hnC3lYIl0djgEWlfa1G7Tm0Gu9SoVM5QVPn7fw2XiJk=;
 b=RJiUcY/8+GECeY0MLsQGDr8046VjrKAtkYq3SOKivh0cjl3gauizNcp39pOr4BHDJh
 HJzjvTOyQNvlr0An88NP8xunDEEymFsxKKyrmlhT618wjRdEW+68DTKocgx0uB3h7pQN
 CCeRh4yHfY2FAjQXtJlFWuf0uX8W4s1JGuWHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767812564; x=1768417364;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hnC3lYIl0djgEWlfa1G7Tm0Gu9SoVM5QVPn7fw2XiJk=;
 b=aKfu/wCIP4xBdCxXPxo0fWh4lfdhFrLbuXOzqaiel4voP8AzE6ic+hmySxNk8A3Loz
 EmH/CWXLJFfpalyXD53G6uHgbuMkGwAYTbmouoO9zwdnlwOm2l1bDw+Vmz7X1Q6xKxRP
 tvdVFsJ5Qepz8AVXuft75pN+2QSz5QV20lzzlbrITpy4iDXSNliKWc4J4lBQBK/0Yvzz
 bEX5K7XFJ/hh2DLlE3INHkbaoNyNYInUBHB0ifzVW3Ge86fq09I2lyfj8VxyBpJaECZe
 UNV3n4HTtgxfC/zjLWBD60HDBTRXK1etePVZkPRByVYFvPzyytnSnCXn+mKwUBPt4ZYF
 cfhw==
X-Gm-Message-State: AOJu0Yz7tA6DAQnOX/xr0HDLxi9Gz4fR7RZUEejMbD0/kKKVdKHVoi7n
 kqx1j0M7SAZ2q1fAz3on+3jzk0yYZYUaYterU/neMRR2gopa56Cs2A7fdHuz9X909yaWVub9kct
 Tp7Gr2EXNLPPVlsxBKNI8acACSclSoeLF+VceBdtE
X-Gm-Gg: AY/fxX7cJXaRxpxI6gQSXjBH+p2k8jAUJshMtHFCQrGtyI09xFaI66n5ihRBRhhwlYL
 E8qQj9R8vBJMxMvnjQ2uT645UIE2Fr/Tz/hUe+nZ/RweAndEMgMiw8LXBSYTO6VLPq/3hcmnsWf
 dAaq5bXiKChCi0Rf2pIzAGp8+aAkIORVhHIYDlQJRwgM4ngdJQug5GQ60CFfX38rtlXmBe5E53r
 eYHJxxQrBxXqjA7N57R4t8AgEyWrOUCWz1amTyj0GhU2TGdVO6L0j/y9rhzuMd4r0r1Ig==
X-Google-Smtp-Source: AGHT+IHwuRJ39/y1SuGFZSWzKx4Wdpd7/20nbLchb6ZV+ZlEzT1NEa9fRfN80noG61hbTjfHYAJzc5ZZM3c7ua9uq7w=
X-Received: by 2002:a17:906:ef0c:b0:b71:ea7c:e501 with SMTP id
 a640c23a62f3a-b8444c593c2mr431817766b.4.1767812563612; Wed, 07 Jan 2026
 11:02:43 -0800 (PST)
MIME-Version: 1.0
References: <20260107003131.3064800-1-simon.glass@canonical.com>
 <20260107003131.3064800-10-simon.glass@canonical.com>
 <57EAA792-D01D-4D72-BA46-259C8E0A7D32@gmx.de>
In-Reply-To: <57EAA792-D01D-4D72-BA46-259C8E0A7D32@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 7 Jan 2026 12:02:31 -0700
X-Gm-Features: AQt7F2rIzERir1dVJ_JksL4MZyR1KdBNSNfkdWvK-iSJyH8KPVtpxcFKTTCOXok
Message-ID: <CAFLszTjw848wUp3wMnewneS6Mss2dDr2xKcB2192FBhpT5GLtQ@mail.gmail.com>
Subject: Re: [PATCH 09/10] efi: Drop EFI_GRUB_ARM32_WORKAROUND
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <simon.glass@canonical.com>, Adriano Cordova <adrianox@gmail.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Raymond Mao <raymondmaoca@gmail.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Yao Zi <me@ziyao.cc>, "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
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

On Tue, 6 Jan 2026 at 20:46, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> Am 7. Januar 2026 01:31:26 MEZ schrieb Simon Glass <sjg@chromium.org>:
> >From: Simon Glass <sjg@chromium.org>
> >
> >This work-around dates from 2019 and grub 2.04 which is quite old. New
> >builds of grub don't have the problem and old boards presumably use an
> >older U-Boot, so don't need this.
>
> Where do you disable caches that are not managed by CP15?

I suppose it would be SoC-specific. See for example the code in this
arch/arm/mach-tegra/cache.c - I'm not sure if this is using a standard
ARM thing but I suspect it is tegra-specific:

/*
* Systems with an architectural L2 cache must not use the PL310.
* Config L2CTLR here for a data RAM latency of 3 cycles.
*/
asm("mrc p15, 1, %0, c9, c0, 2" : : "r" (reg));
reg &= ~7;
reg |= 2;
asm("mcr p15, 1, %0, c9, c0, 2" : : "r" (reg));
}

I also found this Nuvoton code that might qualify,

void set_pl310_ctrl(u32 enable)
{
struct pl310_regs *const pl310 = (struct pl310_regs *)CFG_SYS_PL310_BASE;

writel(enable, &pl310->pl310_ctrl);
}


>
> Best regards
>
> Heinrich

Regards,
Simon
[..]
