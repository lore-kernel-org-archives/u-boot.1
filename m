Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DDBB105F79E
	for <u-boot@archiver.kernel.org>; Sat, 14 Mar 2026 08:53:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A069C842DF;
	Sat, 14 Mar 2026 09:53:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=0x0f.com header.i=@0x0f.com header.b="sifdxKyn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2792F84332; Sat, 14 Mar 2026 09:53:35 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90BF5842CD
 for <u-boot@lists.denx.de>; Sat, 14 Mar 2026 09:53:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b7cf4a975d2so393863966b.2
 for <u-boot@lists.denx.de>; Sat, 14 Mar 2026 01:53:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773478411; cv=none;
 d=google.com; s=arc-20240605;
 b=WON1RL6zLc/0nYXzBXNuEawCvNJNkApYoyRTsMpAB1YenDp91daEjHzCOnWoJwc/VC
 tu9W1dEmSWp4SID1IUjwJxNYmS9OL8+FYmrMV8gQNxritgvpJWTzt1sgp5KEyQEpcjxf
 zgyBXVkdMGHtsFqEYdJ5Gw2P/Ubexg7oHxU7dQan0hwVF8aQAUgiqjNGb7/ECpLyvNM1
 2+LjDGy3/83LilPfvbYG1Cx/rQupzuQU62N0d2gPnVqikVc8rjF4OmMy4LgCmrkyz56U
 6pyCQ5rH55xBD6lfb4SWUxOecRkNNY7+F9kP0hFIt6/wtpU7No8Oz9ai/oRCXs7l5sxU
 Ydlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZIJGBPxosk9MV2XupCYrMf5eHVHyTKMJ6b0pz0YEQLo=;
 fh=d7nB15xmv3RtjfCQKvXnxrDwyfDlDjY2Ww2jadh0cg0=;
 b=aeos7MfHDGhhjoE71v30RUyZiV70DtMkhpJrRoFYO+BXjBrHIuPXIs7Gk+45URGTEn
 ijIIN/8XijDNMtIizcB/iJpVOS9r7+ZIIWvrkq6DQAcRZCn8xa20Ev/lAxSXF5uVt+i8
 13WfhCQDb+CCFOIx4mx8diygzBaFHM0QBFJEK/B3coaG04YpXlAndJRz+K8wx3iOPVON
 UbciQKGKZIdpBqoS0rAcULUW0cdWiWIVv6mIdJyT5nR5PpdiVXLmXvKnoRlxIrWw6rXh
 +IrNW5Sok6bRJcjSAyOP19HatfNB3cNDTWyWGmHi4GhP8uVe6gdGpXkiUec+Tc5Tm2jM
 6UMQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0x0f.com; s=google; t=1773478411; x=1774083211; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZIJGBPxosk9MV2XupCYrMf5eHVHyTKMJ6b0pz0YEQLo=;
 b=sifdxKynrvDjeAxyUv8ZuS39yz8nqbBw1uHj7Kq+Sj5M6tnyQwLsMOuYrLVZggVRbC
 +Dm7NlTKl50DJ0aNjLbgkBhIN99bGluYRz7xZarn5jmxgnald2tnkG4GwKXKpRzCmeAS
 m47QlOLY7HDYSgaKXj6xWR5qzn6R1nNZaXM3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773478411; x=1774083211;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZIJGBPxosk9MV2XupCYrMf5eHVHyTKMJ6b0pz0YEQLo=;
 b=QEgaTBDB5y6Qa4VjtzQf5PWE9ZXFwDfglRoiY26JWxgAYs+wcvX8PLCO+gX3BfTb7T
 aa4qrSNjzm68gsxfxOY5Z7vzlPkuqj5e2fu3JWuUtz6qMIHKGJ49zc74c5Fc5RMDJjN5
 2D05Je9yUzDdGRuyAUP6BfSPKOcyazjsTt3uZZ08AEz5dnx36prFs1ggbx1Rkd+JLnQE
 vYq4DLDlBJNp7f2ovU6LW87bnxwhjOMuLc1Psw8p0qLuO1SSF6qpCOzkaoSdeZkXzm2N
 3/HI2LoUhLBI9JdCH75bpG3eMKjFHwm4Cljpgn+ot07ptgjUk2dUJThnG4uXxeh4uOS9
 NiiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWngv/+6qG8A+Hvwn8QHDwFLFvVMrG/sH1mBzqC4Kly41ok0Vq8YS9jQldJj5eiUyveKIpxpHw=@lists.denx.de
X-Gm-Message-State: AOJu0Yx8aElGDDd0ISvqnIT41pb+IIuCORfu/PKjSlnhAvZ1t8i6u04x
 o2BYMu/IogzjNtwUdGTw8iCs+c4SMNPD2qU5T1K1VeXCafE62c67TKN4hawPDLlQcyksKEGs9pJ
 VGYtTuClZq4aNCmln5LY2bdusO7CLqPFRt4rifW69BQ==
X-Gm-Gg: ATEYQzzjbGHcWG6e8WRQPunej9creDLFADNOtJoG/hzIklHnnE4q6NOHlpeYjMx3AS/
 utBHnYwFpzy+6G/2h28frwqP4Y+ScS4j9gumfkSIW5KZoJs8qS7uBwchBRDC9g3oqS6dtzNwY0e
 gwDgtDb4TkjaVfc0X7j2qut1DCd5pvgHtXdVqm6OPJqoNqko8mBNmuD9qzfw41bW+wibb8EvWUF
 9xBgP2fB8s3tz5ZUmkvGv7HWVP99HY+ShIoUVIJ3HhJutaTdmtD4EUB8mHZ3trEhSyevAfaCETV
 P4YKdy1JdNRZKiGfqXmD
X-Received: by 2002:a17:907:94d3:b0:b96:edcd:cd04 with SMTP id
 a640c23a62f3a-b976530e917mr337322366b.49.1773478410174; Sat, 14 Mar 2026
 01:53:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260310135940.1756141-1-daniel@thingy.jp>
 <20260310135940.1756141-3-daniel@thingy.jp>
In-Reply-To: <20260310135940.1756141-3-daniel@thingy.jp>
From: Daniel Palmer <daniel@0x0f.com>
Date: Sat, 14 Mar 2026 17:53:17 +0900
X-Gm-Features: AaiRm52x3CuP84qnJ0SA_SludrGy9NE6bvNu9Hl6uZUNpNZx30sQz1ncHbhJoKQ
Message-ID: <CAFr9PXn3abM6DcbfJBBbokBtQ02XrfK66jVtjCGo8+_V-mtkzw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] virtio: mmio: endian *fixes* *HACK*
To: visitorckw@gmail.com, angelo@kernel-space.org, bmeng.cn@gmail.com
Cc: laurent@vivier.eu, u-boot@lists.denx.de
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

Hi all,

On Tue, 10 Mar 2026 at 23:01, Daniel Palmer <daniel@thingy.jp> wrote:
>
> From: Daniel Palmer <daniel@0x0f.com>
>
> This is an attempt to *fix* virtio mmio on the QEMU m68k virt machine.
> As far as I can tell all of the registers in the virtio mmio regions
> should be little endian so after reading them they need to be converted
> to big endian for the code to work on them? other parts of the code
> are also doing endian conversion so I'm not sure.
>
> Or QEMU is incorrectly giving big endian register values?
> ---

I have a patch for this in my Linux tree too so I sent that:
https://lore.kernel.org/lkml/20260314030612.1949420-1-daniel@thingy.jp/T/#mab66837bb90c30916fd0fc066245bdeb9918e96c
It would seem our versions of readl(), writel() etc are broken. For
Linux the nommu versions are broken, for u-boot it seems they are all
broken. By broken I mean they should be expecting a little endian
value from the access and then converting to the CPU endian. (I think)

Cheers,

Daniel
