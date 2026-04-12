Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70787F3ED7B
	for <u-boot@archiver.kernel.org>; Sun, 12 Apr 2026 06:42:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7924839D5;
	Sun, 12 Apr 2026 08:42:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="e+og8whB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55F6B839D5; Sun, 12 Apr 2026 08:42:45 +0200 (CEST)
Received: from mail-dy1-x132b.google.com (mail-dy1-x132b.google.com
 [IPv6:2607:f8b0:4864:20::132b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CF1A8341A
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 08:42:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-dy1-x132b.google.com with SMTP id
 5a478bee46e88-2d832f2f44cso386476eec.0
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 23:42:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775976160; cv=none;
 d=google.com; s=arc-20240605;
 b=gbit/IZMS4rkQuS0T+YSFlay8ht8LhZYjqF7j36c/aTc4M54x98fXcY/hDNoe6xj0S
 TrSJZETAx7J27ZB7p+ROyKS342wy4GUlaYT+gH7CpU3aYVzHeomzSz45hsrqiHcR/MMc
 pvQVJ0TCUooj9SMm1FbuPYLmxFmi32fPjNg7piQmutptls+rUdAmyMZf6TKyMZ3GOzV0
 TzvHo/U06EZO9NM5kFekLA/poP/Pz4LEbmLYdHGq40ihT6gLfgqRXA/SdgZQQHSSmlGn
 FSu91n8bPnJYlUuk07p0biWHEZh+Gidvgni1FuhnR6bXFqBKJM4Z7eBhuAkWqsjWNKL2
 JcYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=inpa90MuOGjyOTviur5osIWaeWS5ypycmjqkDb633iI=;
 fh=NkE7yuAmtwqzxskB4KxGqErm1Ug5krxk3F4BiKXYxAY=;
 b=DDi+8GQKazkQ7YCLmGnfLdCdQWrUJ1+xWu/q6K4707eIzo4LDfDwsos41YJtTV8NPb
 FdMmIqJaUeqhT6jBG+ZmMkjvlFJRwnMrbwxqWAi2+w/YOudj0B17eNOE3jkp9p7BydIo
 Zfq8UTW0gryeZTHE7SmLEtgMqe1xACrLGxkqAKUxxHIZxx1Pw55XW8vshIbUClhA0PN9
 +K5mzfKieQ/v1R+gzNaAmsmp/OYp9SGL+diqjlVZXl+Ijs5TfTCZKqpexElTin4H7HwS
 swz82RuWbn7xqkyLfaVidiPSs/cM3E8SymyqKmfUPMK99oG8HgY4OT///Zp0i+5S447q
 tfGQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1775976160; x=1776580960; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=inpa90MuOGjyOTviur5osIWaeWS5ypycmjqkDb633iI=;
 b=e+og8whB/cI+tjWH2XP8APIPpmL6bI+A6QITCsveSS4nlbBE00HGQq7aWbYtKvYf0Z
 vRtkkljezib1yiPG8VE44IqFfkvmHr9lKdQwI8CoVAMoWFRWCE9NNgB9i3/PO3ihSB72
 A6S4g+uSFiu6HfoK4axwdVWYSVY+69uUoZ9ZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775976160; x=1776580960;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=inpa90MuOGjyOTviur5osIWaeWS5ypycmjqkDb633iI=;
 b=b4J0K0U8BlaGpzC8q+rXOwSZliPhji75hmCxyOHaaoOq4TtBuvK/4gTNPJbbOs2rE3
 2irKaXGDelaH0RSQ0hIlYWSvS4+VG1kFIJVB4xdc3Xj2te5aG6G1aj+DY5x4dEiKn+Ey
 oojVgNC5O0Ake6Wh2ochNzMUH0SmOeAt5e68yxZZ87noQlL1Rs3/n5FzOMJU0p7bYFYo
 RCVm9eCxUis1kgDZLPZgPbRXq6aWR8NszpKwnbqgMBPHiKDU9EFslzs/xYZAQT+9acQK
 udQIX2msMYWmKX+wQJkmUCeMYuiFM7/k76iWAeG0SzJNSDUL/Y2+R2S34oZdilr4IeDY
 wMCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXB7EaBUY9HSQxxSm5hR45Z7Z79nMc1EzWX/pwIZQ+4ZBv1RnC2lbR5n4srcw5gXIJpl4oPMIE=@lists.denx.de
X-Gm-Message-State: AOJu0YwVb9zQd8u2jOsVU9cmcpIBpAgCqMRlRKtD5h1UwiPrftwH4SVc
 DCQNBMvrkOYjLvJ4Okb2PAvy7kq3iCJXpTP268QBdQxh7/cLBeWcbob7ypnA9AvhVTPhUQRB2Sl
 S33YlfQJW6Bq3lfLndIADf2O4IneB28pM808xhnKmxw==
X-Gm-Gg: AeBDieuGws/1EJ8fWP3Ge+7TqetQ54oKkoIJe8YbPdKq5kb9NWM0rw3d4mmpbTb+xAT
 mmoHUWxcS/MNkhvrV2gxBG1glnz+6lNEC1KbGSaDUMq4YyhV17ZCZ9kzlL7Z7hZ6S/eJkx/S1eG
 hsrGcyYHdk1fBq4o6t5QTU9uoRRo7fd6gee1iz+b4d1aBbRkrMxdsZa8QIPjb3+3NDLxtYxJXTN
 iUVpxQyhPRjztfxTBhgy2p7XeoWwLz+T6J8Kootu6gWaDNo/t0XhpFO+34boN4gshWI6vZRb5GQ
 AKo2VPgbR4uin3E=
X-Received: by 2002:a05:7022:ec07:b0:128:d3de:c9e4 with SMTP id
 a92af1059eb24-12c34ef7f15mr5109554c88.30.1775976159957; Sat, 11 Apr 2026
 23:42:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260408220928.3328551-1-daniel@thingy.jp>
 <20260408220928.3328551-6-daniel@thingy.jp>
 <358e3185-1a42-4786-9c37-fe7ac41054e6@kernel-space.org>
In-Reply-To: <358e3185-1a42-4786-9c37-fe7ac41054e6@kernel-space.org>
From: Daniel Palmer <daniel@thingy.jp>
Date: Sun, 12 Apr 2026 15:42:28 +0900
X-Gm-Features: AQROBzBruwH-Wndq8AXvZQr74HcaraNYTO-ew8p-MXYGNyZYxcpJLrMaBHUs40g
Message-ID: <CAFr9PXn46L9sMwevPTExEgkfAc-hADTiX6DnzOVGyVXL1TCGQA@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] board: qemu: m68k: Create virtio mmio instances
To: Angelo Dureghello <angelo@kernel-space.org>
Cc: visitorckw@gmail.com, bmeng.cn@gmail.com, u-boot@lists.denx.de
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

Hi Angelo

On Sun, 12 Apr 2026 at 05:28, Angelo Dureghello <angelo@kernel-space.org> wrote:
>       m68k:  +   qemu-m68k
> +  422 |                 sep = memchr(fixup_str, ':', fixup_len);
> +      |                     ^
> +  432 |                 sep = memchr(name, ':', fixup_len);
> +m68k-linux-ld: cmd/virtio.o: in function `do_virtio':
> +cmd/virtio.c:42:(.text.do_virtio+0xa6): undefined reference to `blk_common_cmd'
> +m68k-linux-ld: final link failed: bad value
> +make[1]: *** [Makefile:2105: u-boot] Error 1
> +make: *** [Makefile:189: __sub-make] Error 2
>
> Looks like a "select BLK" is missing.

Yeah, I guess whatever config causes the virtio command to be enabled
should depend on or select it.
I'll take a look and add a fix for v4.
