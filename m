Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 497B7E9271C
	for <u-boot@archiver.kernel.org>; Sun, 28 Dec 2025 01:16:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D1F18398C;
	Sun, 28 Dec 2025 02:16:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=0x0f.com header.i=@0x0f.com header.b="ew5Tjq+/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A2208398D; Sun, 28 Dec 2025 02:16:17 +0100 (CET)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4091F83981
 for <u-boot@lists.denx.de>; Sun, 28 Dec 2025 02:16:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-34c9edf63a7so8849233a91.1
 for <u-boot@lists.denx.de>; Sat, 27 Dec 2025 17:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0x0f.com; s=google; t=1766884572; x=1767489372; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vk577B9GAPTTeOr+xBVGmO8NS05a2L/XhFuN0Kf9E8Y=;
 b=ew5Tjq+/zw2Y8Mtgd97qwL9fRy+DD1Q0TRGO7Uff0F+bpJAXAWUDSIUy18rNjgw7cx
 ido6JLPTxf/gJ7UCdkpGRI6ULmjOV5WPH2YR7DVM45dPw1Dxi12BLmR6Ye/CXjdHPpV9
 /HGXN7ZWjwE4GbecLDxtIT3D6yQF7gfQSHJXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766884572; x=1767489372;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vk577B9GAPTTeOr+xBVGmO8NS05a2L/XhFuN0Kf9E8Y=;
 b=FS9GJWWHLrHCr7QEFo+LLKus/IZKkUZyc+7rJzM777J4RJkDazBO+D+ez0vKs/5bk1
 t0761+GYrTXOc6dIbDlzV3+jabZxwA8Ew3VVOerbyXFhG6f6Nv98arug42zH0wXYQvOJ
 rH1kP3gYGajsjurHIk0GMll61+1l28xW2qj+dXU8bGv1uI0gk6Rl9+F15CqRavrkQQYM
 yXbgO/ykD1mrBVMmjy3tiK/TR8ElnJd2uOzvv+Yt5uTV+VZqQjbXyp+Y/KxKQafn46FZ
 yXFugPbPmOvQ4GQAZj4oCimyypRFv1dWrQPWDbiJixNbpZG3W2k0yKt73h1njrTOAoZJ
 ivHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcat5fGaSGlyFtzqetdbSOZTx82VKU3ztumKFPsP4cDRX9qU5+lTQf/EQ+oqGZ4VX35GwB6R8=@lists.denx.de
X-Gm-Message-State: AOJu0Yx4fXBC1bhoFeNpagH//kBdwA9lTHRyd0RCTJMPGveIRggvnrvS
 coFheis2MUZVa6dbXMuAx+ryzQzrB9AgRMX+00luhzD2K/9Z0pruWAr4yXjk4qoocHVAJ7p1EHT
 cZP1/Yx4Nw3jftb6NNF2hDwxRnuCF7NbEqzDhrEiJcQ==
X-Gm-Gg: AY/fxX6j3NdyKb5BZsJO767WHbW7CcCGAcleUSC7duJie8/ynvwemuQmWrdon+rYTay
 y/WvklALUM5wkYq7ZD+TIoL7Czjz4+LmEOkhsfaP0QuExIF0vyb91SdEF7tbkjlqTpTxggPLAvV
 9uhkiz4M5lWb8zHGIRKItaU+INzKy2qg71PbNJmJnsyufOZXL64COnsb3oI8XirWJvPemGi/P9n
 BXuk9rOV7tLdfxVKsxF9wY6rfkwX3psbjz/1E03fLliOpMW/kBgP6PkKEbFpp3bwrKoTrcr
X-Google-Smtp-Source: AGHT+IE/edayrDMw9yvEhwxsRkqy+k0f8VmlCip6sAms3ZVYq6JoxVIv1zvq1RyaCLOq1qG7waFITBNQlExgsQ/aUTw=
X-Received: by 2002:a17:90b:4d06:b0:340:ec6f:5adb with SMTP id
 98e67ed59e1d1-34e9211e593mr22011647a91.3.1766884572477; Sat, 27 Dec 2025
 17:16:12 -0800 (PST)
MIME-Version: 1.0
References: <20251226175400.1154417-1-visitorckw@gmail.com>
 <20251226175400.1154417-4-visitorckw@gmail.com>
In-Reply-To: <20251226175400.1154417-4-visitorckw@gmail.com>
From: Daniel Palmer <daniel@0x0f.com>
Date: Sun, 28 Dec 2025 10:16:01 +0900
X-Gm-Features: AQt7F2rMqiEqXE0LSoaBjb7SpclVcRd6O9uYW3mdKNfbU7ONF0yYdZkSJUA3YDU
Message-ID: <CAFr9PXnZPOw3V9vwxtpvkVFfjOt10ZmfSjY6yMLcFnGW15bvZQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] board: Add QEMU m68k virt board support
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: alison.wang@nxp.com, angelo@kernel-space.org, trini@konsulko.com, 
 me@ziyao.cc, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, 
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

On Sat, 27 Dec 2025 at 02:54, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> diff --git a/board/emulation/qemu-m68k/qemu-m68k.c b/board/emulation/qemu-m68k/qemu-m68k.c

> +int dram_init(void)
> +{

> +       /* QEMU places bootinfo after _end, aligned to 2 bytes */
> +       addr = (ulong)&_end;
> +       if (addr & 1)
> +               addr++;

Maybe ALIGN() or round_up() could be used here instead of manually coding it?

> +       record = (struct bi_record *)addr;
> +
> +       if (record->tag != BI_MACHTYPE)
> +               return 0;
> +
> +       while (record->tag != BI_LAST) {
> +               if (record->tag == BI_MEMCHUNK) {
> +                       gd->ram_size = record->data[1];
> +                       break;
> +               }
> +               record = (struct bi_record *)((ulong)record + record->size);
> +       }

One thing I found when I did the bootinfo parsing in my version is if
I corrupted (during relocation etc) the bootinfo this type of loop
would often get stuck forever.
I'm not sure what the technical limit of the number of bootinfo
entries is but bounding this to something reasonable feels like a good
idea.

Cheers,

Daniel
