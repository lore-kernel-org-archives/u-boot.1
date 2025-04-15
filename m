Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A5B4C369AB
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 07:23:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7087881B4B;
	Tue, 15 Apr 2025 09:23:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JP0eUzF3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34E7E81CAF; Tue, 15 Apr 2025 09:23:30 +0200 (CEST)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93D35810E8
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 09:23:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e53a91756e5so4793490276.1
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 00:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744701806; x=1745306606; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/Fa27mnoByEw3Cr+ozPwwEwUl+oqgRl4AwE/V3ai9dY=;
 b=JP0eUzF3PnyI6ma+3WC5GOkXKqgiNtfe0QborNcCZK/ZmlbpCpKhzzJPwIjl1+mpny
 lPfdfhrNPtgYKxNVxGZgJFVy6oU0a5LIvhmrRy6o5qCQcOwxbUVC4+DwDPp35nZpvyYC
 5FacBsrQqDkYil8TxIAxoLC547TOE9SLV7EiGBBl5XuJ3H5jmy/H+23TLYT46Eti58cT
 aNkZO711m6kAqxRVTrZUFS4DENoYzgsWS1ljs6HviFXDczJWMLYLA06E7YQmBgF7bL4F
 LJ6r2OIc8JPjOhk19qCEOVESgeLdch9FUSFaz4iJoHweP0OSCZ9fsmlGbYZjYwgLss3L
 4d+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744701806; x=1745306606;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/Fa27mnoByEw3Cr+ozPwwEwUl+oqgRl4AwE/V3ai9dY=;
 b=MJjq2hVf/kBsGCqajFwgyxMyjUrXlmv2xyI/Io2zjwd3kG9OoCd/D6JvFuRyW27HHX
 x+HJTNlYWxXGZh6gd+FRt09HmXahZkvSuw0iNbhYSowMk8aVLH78lzyUTH9hHFsaQ53g
 DWo+vgnbW4eo1mZ5NMstGzxlFonSykxj+QrkZZ1DwR1/SFEZM4AoRUVf4sNoyU8c6Mdd
 g4FUJHif3vDA5/ZxCWawCuCYgl+huK0mx/Ug2AyrNYx1qBntJzH7jTLkuhYh2z/6RHns
 YcXaIQSBvyAtupdRIikM+ggoHJt2v1k1UkLdYUpBLVXSOmlzk20yjdrKES1lwz8MLJSq
 Op3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+GaijJfEhTAN3lA+8ceodcYGLWmq6CXgr0FHxhL8isefSvq8VwAGQSVkwXtGKzstvh3J98YQ=@lists.denx.de
X-Gm-Message-State: AOJu0Ywvl+uHurC9CCcsIOsKESsEWaJ3QYQzj1QGBxNLebT9APz2F9Zh
 gbbP7gb7rcxq10wbUXrAWk//R3SsWjQXV9b7fu+rdquB0J5IVKunAEk/TN1TVP/f4KWIxp6c2b+
 zBC+CmleV0kEoBY1UhrKLiv5lB3TlrzpBAdk7mA==
X-Gm-Gg: ASbGncv5FnVVIVkJ9YTPTBcq/a1TpnAxPvXW/eqH8WRYBVAjTAuL9s8Xdw5HE4DRpeO
 Kn5QjatJ9+KK3mFrzEkcWltTRuG75NvR3Oa4uGt01lcgikA65ZLWcSg4FwadMeHmCEZgwtefieY
 nUAGl6n8IzZKKcwFBpL1YXaz0=
X-Google-Smtp-Source: AGHT+IG0Prxg6V3RJ5dgWl9br3n0HkCuG7N6AqvQX6LvN4VSLvx02f9iX5Crbi5kM88HpsLtFhu2tkFLleVAhNTZ9Hc=
X-Received: by 2002:a25:9cc8:0:b0:e6d:efaf:3c26 with SMTP id
 3f1490d57ef6-e704de724d5mr18613388276.1.1744701806357; Tue, 15 Apr 2025
 00:23:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250405190711.365419-1-sjg@chromium.org>
 <20250414225307.GH5495@bill-the-cat>
In-Reply-To: <20250414225307.GH5495@bill-the-cat>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 15 Apr 2025 10:22:50 +0300
X-Gm-Features: ATxdqUGXIeu6O3AT8xPBmyhuNO1mhltiEh33h_o1yNH9t1S2IlZBcipDnLZavr8
Message-ID: <CAC_iWjKUBp1dUkGVts7aCcJEFNrE95Lu9ApmpPR5itCaWanJRQ@mail.gmail.com>
Subject: Re: [PATCH v2] emulation: fdt: Allow using U-Boot's device tree with
 QEMU
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Phelps <andrew.phelps@canonical.com>, 
 Alexander Graf <agraf@csgraf.de>, Bin Meng <bmeng.cn@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Jan Kiszka <jan.kiszka@siemens.com>,
 Jerry Van Baren <vanbaren@cideas.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Lukas Funke <lukas.funke@weidmueller.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Max Filippov <jcmvbkbc@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Robert Marko <robert.marko@sartura.hr>, 
 Sumit Garg <sumit.garg@linaro.org>, 
 This contributor prefers not to receive mails <noreply@example.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
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

Hi Tom

Thanks for roping me in.

On Tue, 15 Apr 2025 at 01:53, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Apr 06, 2025 at 07:07:04AM +1200, Simon Glass wrote:
>
> > At present it is impossible to change the qemu_arm64 defconfig to
> > obtain a devicetree from the U-Boot build.
> >
> > This is necessary for FIT validation, for example, where the signature
> > node must be compiled into U-Boot.

I'll repeat once more, that using the DT to store whatever random data
you invent makes little sense.
No one is obliged to follow internal U-Boot ABIs. Instead, it would
make much more sense to store the data in the U-Boot binary somewhere
and retrieve them. On top of that we now have proper memory
permissions at least for arm64 and you can place certificates in
.rodata.

> >
> > A proposed change to QEMU to allow device tree additions has been
> > blocked for several years.

It hasn't been blocked, it has been rejected.

> The only known workaround is to use QEMU's
> > dumpdtb option, merge in the signature node manually, disable
> > OF_HAS_PRIOR_STAGE and then start QEMU with special arguments. This is
> > complicated enough that it is documented in U-Boot[1].
>
> This paragraph and then
>
> [snip]
> > +       Note: this work-around is necessary since Linaro has blocked

Linaro hasn't blocked anything. The QEMU maintainers  NAK'ed the patch
multiple times for a very good reason.

FWIW apart from the commit message being misleading once again, the
overall architecture is just unnecessarily complicated.

Cheers
/Ilias

> > +       addition of a feature to support additions to the QEMU devicetree:
>
> This part of the help are overly antagonistic.
>
> [snip]
> > diff --git a/dts/Kconfig b/dts/Kconfig
> > index 2e88d210bb8..53f7e246a80 100644
> > --- a/dts/Kconfig
> > +++ b/dts/Kconfig
> > @@ -205,8 +205,13 @@ config OF_HAS_PRIOR_STAGE
> >         development purposes, but it is not recommended, and likely will not
> >         even work, for production systems.
> >
> > -       Note: This option must be set in Kconfig and cannot be enabled or
> > -       disabled in the board's defconfig file.
> > +       Note: This option can be disabled for QEMU usiing QEMU_MANUAL_DTB thus
> > +       allowing QEMU to support FIT validation, where the devicetree must
> > +       include a public key.
> > +
> > +       See also this for context:
> > +
> > +       https://patchwork.kernel.org/project/qemu-devel/patch/20210926183410.256484-1-sjg@chromium.org/#24481799
>
> And we don't need more wording here. The QEMU_MANUAL_DTB option itself
> is enough.
>
> --
> Tom
