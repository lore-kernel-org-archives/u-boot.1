Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F2AACCD199
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 17:28:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDA6383835;
	Fri, 17 Oct 2025 19:28:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GeINuUIc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E90183837; Fri, 17 Oct 2025 19:28:21 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18A13807B1
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 19:28:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b64cdbb949cso232233666b.1
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 10:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760722098; x=1761326898; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/LnHWob9nzzNQY+Bzluas2ZobwZyvhYGtP6TS6rzlnQ=;
 b=GeINuUIcpmlCXo9t3Og8PBMt29o44bUShaFU0q1PRkb1nob9E1/sfaNzNX34iMbk0o
 QksCg1WznC4SbKELb2bIu1WRE10ofaCYTR+2i35xKnS+C/5wjkLeIvn1PPzsr8KCD5CK
 79OHGGxmYkPoC71CxY4+jjOdU13YLEIY10xTXu9jtNBIXzDpbqANFR5pp1SZd2bhRqB+
 69NRixUEitZq3LWeFrTiGkDZG37wWhUaoXIaD+bT/7o6nohMkdDBzzAmqNPaD3VBfM7l
 dyF7gumSan+d9gf6CgDjJJtjz/tHUXPpXB+pJd29vkLduL31Pl66MW6znXLXP7XRP2Zd
 v0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760722098; x=1761326898;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/LnHWob9nzzNQY+Bzluas2ZobwZyvhYGtP6TS6rzlnQ=;
 b=rjal0AqCdfCoOk5Af1FICuyHRescJAqBOh1sumkw9IIR5xjjE41ecdQuN2XOKUo/4K
 QDjtlfZlweDporU5GZsAPojSWRx5GW7g7lGBNbp5jwG2EGHR4IpPR0DSwBvx8/XCde1W
 G34FZzvjz7D6ls7cns4Y3vaCOaJm9YV0cduUtnAetFenQk+RBJFM1xhwnr7lwBSAW+KD
 gTlYSTmYai1j1mq7fD095vuCQnK43K6Edn1o2IMY0ZXEI0aRoWp+/03rD7me63E450MQ
 BlNmabjgtVQiS5v1Q9j3Xd4iQXjJcOjfnhIrAtHr3wC8dJgGBSsKTRwPjjwJd+fct89M
 mmPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUR6ITjvgNWScwY8Xpj15VIhZDVsRIkbdDJ2TKVkXm690sUNIG86XC2XqBiSlB4xOdjNIERioU=@lists.denx.de
X-Gm-Message-State: AOJu0YyQ/WAdHcggDgwR1u1WP7uirE88cW+2o+iO+pzNHUgJmtRKF/bb
 rRPkOJx5lUDfYLf6NuZ2iqaiYRkreyWD1KVoOtrSKMMd6op7Kn16kdd8lB4mNuVnJKXC3OuS+ZU
 7wFmBzi4apjrpQVLwIKea/hftJxhxOvs=
X-Gm-Gg: ASbGncuylxHQQLcl5m2mlRsZOiBHl38PZ0FGzTNWc2KAU7dB6SsFUd4ZY+PcFAj1RNI
 X1kfaak7GF/sfJrzuwef//CUHy5ly6Swkx+UNQ5CUgXRHFkP65S3RumLSxbND+7ngboKy5MeEAc
 PDnBlnK1BRsGhKi/NlybV8+qhpyEbY4mlzlJhTB5EdNiAH+Gtxnc94Rz8uRGyCnOBrqflBnMhDA
 omtTfsvzvI6fhQvkpNATaKhCYEwF4rF3dPHcKGu4FPJIJz5PIBxEHsRjak17p4Vjh/yF98yD96K
 v0AwY4BtO9pWbR1u89rW0jFCZykvm4+yF7/kkf0LlZ61wRzEAe3OCZxZm5gCuFNKYBSb
X-Google-Smtp-Source: AGHT+IE+TLPzx6z62F+WWxy/sGiGmbqGJ3pHUUxcxkWDZaKaLUyOW/0XetR2jvDXVl91JiRfNGPYxsPROPW04Rqeli8=
X-Received: by 2002:a17:907:7ea5:b0:b54:185f:359c with SMTP id
 a640c23a62f3a-b6473149643mr547455966b.16.1760722098272; Fri, 17 Oct 2025
 10:28:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250827075017.1583168-1-pbrobinson@gmail.com>
 <20250829153124.55f35ac6@minigeek.lan>
 <CALeDE9NQq+7yxEQ3v6KB=2OK58+MC-923nPr1tbxaw0vEcfMAA@mail.gmail.com>
 <20250924105627.27b32035@donnerap.manchester.arm.com>
In-Reply-To: <20250924105627.27b32035@donnerap.manchester.arm.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 17 Oct 2025 18:28:06 +0100
X-Gm-Features: AS18NWA3VdY1pjbnVX2k8kW8v1i68gZiJRP6DMTj5iyV8qwfaGT2v53Kdpttbis
Message-ID: <CALeDE9MF6KW=zs2kiuLf5XFEgB=8JUp3ufyiAmG2DvtNb2jj3A@mail.gmail.com>
Subject: Re: [PATCH] Allwinner: fix booting on a number of devices
To: Andre Przywara <andre.przywara@arm.com>
Cc: "linux-sunxi@lists.linux.dev" <linux-sunxi@lists.linux.dev>,
 Jagan Teki <jagan@amarulasolutions.com>, 
 Tom Rini <trini@konsulko.com>, Jernej Skrabec <jernej.skrabec@gmail.com>,
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

Hey Andre,

> > > > Revert "sunxi: enable MMU_PGPROT proper page table protection"
> > > >
> > > > This reverts commit 16cfccda4dbf0b53473b8212897f5c63bfbeb6e1.
> > > >
> > > > This causes the follow issue on the A64 boards I have including
> > > > Pine64+, Pine64-LTS and the Pinephone. Revert until the issue
> > > > can be properly investigated.
> > > >
> > > > CPU:   Allwinner A64 (SUN50I)
> > > > Model: Pine64+
> > > > DRAM:  2 GiB
> > > > Insufficient RAM for page table: 0x5000 > 0x4000. Please increase the size in get_page_table_size()
> > >
> > > Mmh, how did you get this? I just ran mainline on a Pine64-LTS, and
> > > didn't see any issues. Are you running on some specific setup? I am on
> > > GCC 11.2.0, TF-A is some v2.12.0-724-gf745e004a, and that's with
> > > pine64-lts_defconfig.
> >
> > Fedora 42/43, gcc 15.2, binutils 2.44, TF-A 2.13.
> >
> > I've seen it across Pine64+, Pine64-LTS and Pinephone.
> >
> > No special setup and I reproduced in on the vanilla upstream checkout
> > from a couple of days ago when I had the time to do the bisect.
>
> So I tried this with some gcc 15.2 from kernel.org, binutils is at 2.45
> there. That worked just fine for me. So can you send me the generated ELF
> files (u-boot and spl/u-boot-spl), from some upstream commit that breaks
> for you? And also the final u-boot-sunxi-with-spl.bin? Either for the
> Pine64+ or LTS. Could be privately, no need to spam the list. I would then
> try to build something as close as possible to that, and compare the ELF
> files to mine, to spot any differences.

Sorry for the delay on this.

Just tried this again against the v2025.10 tag with the latest Fedora
43 toolchain bits and still see the problem on the pine64+.

You should have all the bits here
https://pbrobinson.fedorapeople.org/pine64plus/

Let me know if there's anything else you need, or just ping me on chat.

Peter
