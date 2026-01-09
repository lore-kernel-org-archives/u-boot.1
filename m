Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF225D16810
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 11:34:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CE9284166;
	Fri,  9 Jan 2026 12:34:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="f88x08p/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 608A0842F2; Fri,  9 Jan 2026 12:34:33 +0100 (CET)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B1E183F56
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 12:34:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-bc2abdcfc6fso1680743a12.2
 for <u-boot@lists.denx.de>; Fri, 09 Jan 2026 03:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767958470; x=1768563270; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=F2cxIscv49UMS1kDPrnphSSj3Odv/ZoA7UlUQSB6xxQ=;
 b=f88x08p/Oxxn77oF8KOfCX0Mgn2VHXkzVqjRd5gwOQGyOz8VXV/7Vj7ZWiJcBR30GY
 PsFPbxf28r1uVgft9y6Zaupr9AuUCoCsJaF9R423WBrkXWPN3xd2TC/Ginwo5r125uWM
 G+WPvhZZB10NttUE350e9056X7tuMP9Iaxgss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767958470; x=1768563270;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F2cxIscv49UMS1kDPrnphSSj3Odv/ZoA7UlUQSB6xxQ=;
 b=JvuOMyDsysM3eIYhxYHG7tmJqVfOS/stCHqkgti8Xduw0Q/z5FvCA+X0tb0UP7q2Im
 i2IFx0sOW/8AtGekAYBtk7XSOjlKmp/ZRq5eCV4Z/RugLpziiobSczwbXnGYzCKi5LQe
 46uB8IivdNLJ2pkF6ARmaEfkw7ic6EoHGM0Pwp13YgTl1zrbRm45EWREJJ5Yh/WjhaDq
 7NuxqXs5lPb8t518DO/w8VMenEU/JQgJbsf2hc8PQ7ED19XCHbNYhEiXsX47MDItf+ah
 8QhUwoC8ZZBriB5ZquhKzLgSwQGjQ6TGVFar7nwtJpSpmyJ2eSFOqXAvvap4kj3zNXB9
 iKGA==
X-Gm-Message-State: AOJu0YybgjPew6Na8GJzNANQD7aKqcW7XyeAXvnJMG/AXwkiF5rS3fxK
 /gdBhwlSZhO3p6LLTuf9EIfNzmKWzA/Sa82EPKa8H1sC8PbF+NNnkYPZ3+prGAqCckRu+hMru8R
 dY/JGAwtl3y8Vq1u2h8KD2ChyfR02dUowss4+OwBI
X-Gm-Gg: AY/fxX5Pixm6OvKC8H9uwyOC1L1XctsTNRYgAGi8rp3rY/nXH25sTJkjtC0UKkHN6x3
 zgpmEtsfOQbBTa3oU6ilx5G2qawYz7h0ADnAXn1nHhaJaiL+rt9IF8mOgwq5xQ0aNoMVyEjvRSP
 RCfvSniUw1KDv9T/fkO8H9nJWVQpH3NXa8m4v3wJHNPsxvErefq8n5WmrxmJaLTy5najN/kvdqc
 UArzAglnXfgaIVp7HVVcY65FkMMD/QZ5uEbWlsPIHnWYyPNGTTSAyv69JULgnh/NS+kDA==
X-Google-Smtp-Source: AGHT+IHUOk+G/EMfqhHZsNcpfXNXtM+7wZ6NQBzfnvDLq8WlEwffRPvriilCveZNiocX1tGQZCIyV94hs3m8moDW8Ko=
X-Received: by 2002:a17:90b:1e0a:b0:34c:e5fc:faec with SMTP id
 98e67ed59e1d1-34f68c3367fmr8425012a91.2.1767958469636; Fri, 09 Jan 2026
 03:34:29 -0800 (PST)
MIME-Version: 1.0
References: <B157C9A8-9D26-4C06-B2F5-BABDFD7A8BFC@icloud.com>
In-Reply-To: <B157C9A8-9D26-4C06-B2F5-BABDFD7A8BFC@icloud.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 9 Jan 2026 04:34:06 -0700
X-Gm-Features: AQt7F2ovNGXXwDTwLCGcKAYGWZ3Ao8KvjjtVMXPYWUEYN8WhiQUa0gsezPc94Ig
Message-ID: <CAFLszTjwSCwS8Nu0Xzg=movSN3B26fifjA2+b23ORx14joM4vg@mail.gmail.com>
Subject: Re: Placement of FDT in memory
To: Yuri Honegger <yuri.honegger@icloud.com>
Cc: u-boot@lists.denx.de
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

Hi Yuri,

On Thu, 18 Dec 2025 at 16:30, Yuri Honegger <yuri.honegger@icloud.com> wrote:
>
> Hello,
> Recently I've been playing around with the imx23-olinuxino
> (mx23_olinuxino_defconfig) and booting NetBSD using u-boot. During that, I've
> noticed that NetBSD panics because u-boot places the device tree in the BSS
> section of NetBSD. NetBSD clears the BSS section and then complains
> that the device tree is corrupt.
>
> Reading the logs, it appears that FDT and kernel get loaded at non-overlapping
> ranges, but then u-boot relocates the device tree right after the kernel into
> the BSS section.
>
> ## Booting kernel from Legacy Image at 42000000 ...
> Image Name: NetBSD/earmv5 11.99.4
> Image Type: ARM Linux Kernel Image (no loading done) (uncompressed)
> Data Size: 11950164 Bytes = 11.4 MiB
> Load Address: 00000000
> Entry Point: 00000000
> Verifying Checksum ... OK
> ## Flattened Device Tree blob at 41000000
> Booting using the fdt blob at 0x41000000
> Working FDT set to 41000000
> XIP Kernel Image (no loading done) to 42000040
> Loading Device Tree to 42b93000, end 42b99a0a ... OK
> Working FDT set to 42b93000
> Starting kernel ...
>
> The bootm command seems to insist on having to relocate the device tree.
>
> Is this something the OS is expected to deal with?
>
> In the meantime, I've managed to work around this by running
> env set fdt_high 0x41000000;
> before bootm. Is there a better solution than this to force the placement
> of the device tree?

Do you have a value for fdt_high before you set it to that?

See boot_relocate_fdt() for the logic.

Regards,
Simon
