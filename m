Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D692CD37B7
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 08:51:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71EA784715;
	Mon, 11 May 2026 10:51:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="FC/tuS+c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E09D684715; Mon, 11 May 2026 10:51:00 +0200 (CEST)
Received: from mail-dl1-x1236.google.com (mail-dl1-x1236.google.com
 [IPv6:2607:f8b0:4864:20::1236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C04E784706
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 10:50:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-dl1-x1236.google.com with SMTP id
 a92af1059eb24-13317450f83so907498c88.0
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 01:50:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778489455; cv=none;
 d=google.com; s=arc-20240605;
 b=RKyo5JGlJbUM7Ir0l7MscAAsL0E2SkUf74wJRmFo0aBOyDi7x0zJFwbJtJcLK8G8sG
 Hhd6wVb8PxnMx/a8c1u1LnD5MfEfrkZKxX1B4Ej5izxUMg+FBAcH1kR/GUHtPkNlirpY
 IdLe7kSi39vhhRRHuqHLDDM6R1f5ew1+OtLhg4LUV2cjFmZFKoOEhT/e5P2g8KtTADn4
 VP6OYBXHMBOiFlbdrMthWMIR5xRIyUzWC+pba4COcO4O/MJeLvgG+qRd64AROHuTA9z9
 aBY7neU1QXZJ+gfR3LwFu/GSAAPT8tp2InPfldHqzLHZq46JdCXPECq5Kq6L4iN7xDTR
 vDIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=MU5Lm+Sg9dj9sovsSPkBJ9SNopCXuLFlRxlOfGObcqw=;
 fh=qBHlv/iScIMoMO6tf0yygDojNiqY5sXEZKEQ4AcpFIM=;
 b=Rhw+iKqEyH3NGeWKlTAYoFQl0uw9xFHCHvaaPPP8U60sKu++PLNEXPvZDgcJ8YdHnW
 HzVBsw8U5Rq5eD69oc+QSZPmY3S/cMBnVxNhTzk26KAdMcmI8l5V+CGvQzt2bh/Gpsq7
 FSPv948CJYAmRK8lGvK97SksvfbJjwCcQ1ydQ4v+cD6yem5MvgRgSQnx82tuRiOh9efT
 xuCaolHn+GJm2vv7c4EvzxmnBNL4WdHalXEkjgRk/6FNKQit7uS29NN2jdWJXezvfL9W
 NyTc09mLztaGTuV8BXRebYpxMJxasbKovIMayeb7xudQQ6zvfylD5hkM0NiQDU8cYuiX
 Bifg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1778489455; x=1779094255; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MU5Lm+Sg9dj9sovsSPkBJ9SNopCXuLFlRxlOfGObcqw=;
 b=FC/tuS+cxkmAiIATfynYGGdIplFUPIbyBEdje1z6Tqk331lVltwQOTLJSknkAd2JJf
 Wh8oOIA8rVhR3+dMM1F9Nea+vt+blNYj7MwWAvdSW2apjBOdBt9NPABfnn2TEPlPdheN
 PmDJ3N5/uSippsTvyg2XuthKo8cvQrh20tTiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778489455; x=1779094255;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MU5Lm+Sg9dj9sovsSPkBJ9SNopCXuLFlRxlOfGObcqw=;
 b=jAJkWmXz/zguMzWHPzT4qfvUvj02IbtlvCZKtIbzu5CUTDqvNaPDgmp3FZWJYrCpY9
 jR/gLsQtuwWdgrBdK/bK93iXjTd9JMuP5vHULVgiiszmSFrCwYhc4ZcAjXO1KOFNDwVu
 mBIqtMJ8tFwFk0deJoQyYxZzQvRFqkqcTMmeU3qPlWND95dOH6BQc+Hp+x/ZVgNGKKa9
 Iwu+57d7WhNdSZmUtgpvyj3w28lDqPVzwc7Hf+opGOn6PDBQlsnRWhRmJGnm6xe+mhK3
 8RHFkiWNH2VVVj8aHU3JgCzX6CoK5yIfO+nQfoaF8S0LAhYec5oZJ3LRmDIds0xatJjT
 yQUw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8gN/8NQmbXkMNt9DoRDbYob79evFD1ZFKSb7zzCs1disX2WZS6b5WgmF9qaEQw0JaWhc4tWVc=@lists.denx.de
X-Gm-Message-State: AOJu0YzImhSXAzfWJrF9lZwgVD+mbVylBVMXZS80zSgq4LKbyA5nLqOJ
 dT4+nypiI7N/Ei9znQHgJWIjtWBeNI/wrsbfE/u9Y0r/0W898CP/NqtRrAY+CWYd++ekSpD8cqO
 PEqUENcYfQVf9aXuBYgsdzVmzhDdAoCfd0QNSbxZ2+CsyoSKK2vli3E4=
X-Gm-Gg: Acq92OH2QAUHM2u0u0TEgW4W28FoimkjuHG2+ydHbuz6QXJnojI0BUqtiMWkjoR1h7T
 tVfRBvRQCj4WyFR0T5HTY8tQNpABGCVonKYB+AA9LuDCD08+vtTgZIQGwG2JybQmGhfQaudEvk1
 5CRcabejTXcZATGDIpTyo6+oDfuERde+wRaX9QinEbe1V98vBhWkUCLy1QKldD3fcYStuOtX0ln
 KHIXlUnLqODraYywgkdLPMRwZqQPSHsksOUKZlDud5f33bxuHWw6uTYxfrix5OLfYhi4T9cUrjx
 SaQXkvR8tbI4HyZpcPqYcpETMa7+dziI4SyLe7Fa
X-Received: by 2002:a05:7022:ea29:b0:12d:de3e:86a8 with SMTP id
 a92af1059eb24-13271eb11e6mr6849179c88.38.1778489454997; Mon, 11 May 2026
 01:50:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260505074948.2603870-1-daniel@thingy.jp>
 <20260508192952.GA1948090@bill-the-cat>
In-Reply-To: <20260508192952.GA1948090@bill-the-cat>
From: Daniel Palmer <daniel@thingy.jp>
Date: Mon, 11 May 2026 17:50:40 +0900
X-Gm-Features: AVHnY4IgmNv6m8JSwqVhmWW9JnJuQ5-HCNDsYpY3dvWU2zcmIaSs0-ua7GCwaO8
Message-ID: <CAFr9PXnAt2y9-yRqmTdUmn9CHQHZ3HjJ=MWeW6Mi4MxHRx9ivw@mail.gmail.com>
Subject: Re: [PATCH v6 0/8] Add virtio-mmio support to m68k virt machine
To: Tom Rini <trini@konsulko.com>
Cc: visitorckw@gmail.com, angelo@kernel-space.org, bmeng.cn@gmail.com, 
 sjg@chromium.org, u-boot@lists.denx.de
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

Hi Tom,

On Sat, 9 May 2026 at 04:29, Tom Rini <trini@konsulko.com> wrote:

> We hit another error in CI now, with "allyesconfig":
> drivers/sysreset/sysreset_qemu_virt_ctrl.c: In function 'qemu_virt_ctrl_request':
> drivers/sysreset/sysreset_qemu_virt_ctrl.c:41:37: error: passing argument 2 of '__raw_writel' makes pointer from integer without a cast [-Werror=int-conversion]
>    41 |         __raw_writel(val, plat->reg + VIRT_CTRL_REG_CMD);
>       |                                     ^
>       |                                     |
>       |                                     phys_addr_t {aka long long unsigned int}
> In file included from ./arch/sandbox/include/asm/io.h:257,
>                  from drivers/sysreset/sysreset_qemu_virt_ctrl.c:11:
> include/asm-generic/io.h:168:67: note: expected 'volatile void *' but argument is of type 'phys_addr_t' {aka 'long long unsigned int'}
>   168 | static inline void __raw_writel(u32 value, volatile void __iomem *addr)
>       |

mmm that one is interesting. It seems like it's triggering because
sandbox doesn't define __raw_writel() so the generic version is being
used and that is a static inline function so it doesn't cast the
address to a pointer like most places do. But for riscv writel() is
already a static inline function so it should have broke the build for
riscv before the change?

Anyhow, I added a patch that I think solves it for v7.

> Please see https://docs.u-boot.org/en/latest/develop/ci_testing.html for
> v7, thanks.

I didn't realise I could trigger a pipeline run so thanks for the
information. Anyhow, I triggered a run for v6 and it completed and I
couldn't actually find where the error in the result. I triggered it
again for the v7 and it passed too. Is there something I should check
before I send it again? The run is here:
https://github.com/u-boot/u-boot/pull/964/checks

Thanks,

Daniel
