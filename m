Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFDEFCD6E55
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 16:49:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C4FD84874;
	Wed,  3 Jun 2026 18:49:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="brCltZGq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A0F584879; Wed,  3 Jun 2026 18:49:45 +0200 (CEST)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B28688341A
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 18:49:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-36d98b68d68so2765559a91.2
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 09:49:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780505381; cv=none;
 d=google.com; s=arc-20240605;
 b=f58flFYzdVabu0LY7z8ndlWVz6OaGJI8ss/QETI0PhIGtNK2wRhVtAGPL9RO5DpPn5
 TIv9QaO/ho0gtpeQdQR7mmbFUe845ZJKM3RILhghZax4GpUAKGUgQwyT0nUD6r57QyZC
 xJYZKX/DlIBYtkwLM3zRjnNp9Xfgi//BbICKaZrn+BHWws8NUXvncoxMhGSLR1miP2gJ
 NrdpZzEFqNCSCsNMMMzLTMwUkyivwIxH5oW1q+6s7nzfv+NsdnwTSjVayqGWYpPKO/Y0
 xnjQxmgp19xeBV0Q7nCom2Bzxaah7ybgAexRU9NK+HUZksulIagiEvsOy6Xi06c4uXYh
 S8JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=umh3vJ/aramTS38/3P+sClno1SjIxEEPPf8XqAJPX0M=;
 fh=6w0gPzCwrwHFYHgKMMcY2pyn7gpS8Jn8cHNTnCVVozY=;
 b=IzbHoplpW2nRWPQcoJZo1pfTCt4EBQ0GlAZ+5mpK1zXmBO8rrF9qqfLE1wryBnJfA8
 3vAdSItm8E53OZIWo67VLbb/ZUjWjnH33KGJazSItv5oNiBjAvOP4EMCe3QhjeIYSjsH
 PnJZMQhxy+LYlWJ7yAZpQrtvHqpbvuDwFhRo6EOZ5xFsXH1IAVlkGqhcP03EwAkvBBRh
 ZIXESyMD247/EJjuVIGu2+8RKp+/rTchCgbPOBeGSTzfhBxMUuYq8IERzL0OUD0r1h4T
 66yqKUYbv8JvsV21aU/d3xF2d9AV7UVu9/veXE7tvVp5XntYPqgtz+KKO2j3xMf6CKL2
 TanA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780505381; x=1781110181; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=umh3vJ/aramTS38/3P+sClno1SjIxEEPPf8XqAJPX0M=;
 b=brCltZGqMb4PxwBcXgjwrwE3Sd4IvisfdOs8Xr7Km9rPAyJQhyJOagkiFgWJGRDEqj
 pIu2R4i0aLHNvC9EwaA+mP8BtJFeNUI0+PeaLLKRueeA3VSQfcSxgv67rklanZynahW1
 CenBFSO7+z9DVQAaTrW/SMe9/XtiEKajWmVf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780505381; x=1781110181;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=umh3vJ/aramTS38/3P+sClno1SjIxEEPPf8XqAJPX0M=;
 b=fsdYycLIaI8fj/6arWTeH0BPiR/eqqWD36O+VFD52uN5HNEv79vlyoPDg/2hUItWPF
 QlVKFfVFCVTwop2g19TIhHDKAxU/RR7/i6kSx1VV4qbS3F3/YbFPQl/oKj8F5RnlR0Sv
 rIBO1s4U5ad6wCG91/B/bcQYRzyeeei31Mihxy606r+1AyK6Qo0dVF2gghRiHl61ixeC
 e5jr7FIPNC4dgaI8VOBV1Mg4kWE5G3OAEp5eYcFKkAxokBM1Tk3XKlVBXR1dgVkFS6+N
 D6ZfaIDbC9Zz1sLuMEncCbSA1IVyWg6tYQAOVL5kULOQxPrDYcCU9Br/AMboHEiffxDK
 DQ3g==
X-Gm-Message-State: AOJu0YwZN7oGkDY6MGdrTGC7DUB/hr753MZjzQA6XB//kj/pwP+s9aS0
 RQ25Wds8ATL6z0Iu4qndI5PVkJyxXHI+W8PyIx1PgvTI7dxXRxXE/dh0Bs7oVw7pAwpL/lqhex+
 H0rrtdvwtDE3ZLPxBSVXc5SABs7yA6EwjOH/r7qBp
X-Gm-Gg: Acq92OFcxjgrpgUfxG8L0n/wEmEi177dXDK/uuHrjBF1o0/GGkxz6p4S/ElW5NOoOLS
 HVvnGMXfV90/LpUyDDJH5NAJ2Er7QmgWZha1qTEhGpMKkmXRqBSnjGJT0rwbbJjPWQw30KZvH8Y
 4MUgYdGmrVC1nz1y/paOlAPQk4Yt3+0rAFDU9rePUDTHeNEwrSW0bCBmeoVtiv5dllbYEcuTLuu
 pHFhmDW93HZg8zD1N1PU0fCCQx79MWD/HpFuuZ3dhmzoRY5nQDiMGhSO/tqHL6BmPkbA1FgSnZb
 P28TPoQIS2Gdhcux
X-Received: by 2002:a17:90a:c2c5:b0:36a:c4b:76cf with SMTP id
 98e67ed59e1d1-36e3310568dmr4445922a91.23.1780505381178; Wed, 03 Jun 2026
 09:49:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260520044554.15373-1-aristo.chen@canonical.com>
 <20260527150637.2850104-1-aristo.chen@canonical.com>
 <20260527150637.2850104-2-aristo.chen@canonical.com>
In-Reply-To: <20260527150637.2850104-2-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 3 Jun 2026 10:49:27 -0600
X-Gm-Features: AVHnY4KeP26brBbfi1lPnmhSLb-3_9S0Cj2Ib6PRet9KyNqSteJOXUEwpDEvTR8
Message-ID: <CAFLszTgTZsjQZhFqp7MDAeUxyWKOe7jwHjAGG2Zcr67yEmG_3w@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] bootm: fix overflow of the noload kernel
 decompression buffer
To: aristo.chen@canonical.com
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Benjamin ROBIN <dev@benjarobin.fr>, 
 Ludwig Nussel <ludwig.nussel@siemens.com>
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

Hi Aristo,

On 2026-05-27T15:04:32, Aristo Chen <aristo.chen@canonical.com> wrote:
> bootm: fix overflow of the noload kernel decompression buffer
>
> For a compressed kernel_noload image, bootm_load_os() allocates a
> decompression buffer sized to ALIGN(image_len * 4, SZ_1M), assuming the
> kernel compresses by no more than a factor of four. It then passes
> CONFIG_SYS_BOOTM_LEN, rather than the size of that buffer, to
> image_decomp() as the output limit. The decompressors honour the limit
> they are given, so a kernel that decompresses to more than four times
> its compressed size is written past the end of the allocated buffer and
> corrupts adjacent memory.
>
> Pass the allocation size to image_decomp() and handle_decomp_error() so
> decompression stops at the buffer boundary and fails cleanly when the
> image is too large, instead of overflowing. The regular non-noload
> paths are unchanged and continue to use CONFIG_SYS_BOOTM_LEN. When the
> failure is triggered by the smaller per-image buffer, print a note so
> that handle_decomp_error()'s generic advice to increase
> CONFIG_SYS_BOOTM_LEN does not mislead the reader.
>
> Fixes: 69544c4fd8b1 ("bootm: Support kernel_noload with compression")
> [...]
>
> boot/bootm.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)

> diff --git a/boot/bootm.c b/boot/bootm.c
> @@ -635,17 +636,20 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
>       err = image_decomp(os.comp, load, os.image_start, os.type,
>                          load_buf, image_buf, image_len,
> -                        CONFIG_SYS_BOOTM_LEN, &load_end);
> +                        decomp_len, &load_end);
>       if (err) {
>               err = handle_decomp_error(os.comp, load_end - load,
> -                                       CONFIG_SYS_BOOTM_LEN, err);
> +                                       decomp_len, err);
> +             if (decomp_len != CONFIG_SYS_BOOTM_LEN)
> +                     printf("Note: noload decompression buffer is %#lx bytes (not CONFIG_SYS_BOOTM_LEN)\n",
> +                            decomp_len);

Reviewed-by: Simon Glass <sjg@chromium.org>

The note is printed after handle_decomp_error() has already produced:

    Image too large: increase CONFIG_SYS_BOOTM_LEN
    Must RESET board to recover

So I think this is worth a follow-up, too...see also below:

Using decomp_len != CONFIG_SYS_BOOTM_LEN as the gate is
indirect - it relies on the alignment never coincidentally matching
the global limit. The condition you actually want is the one that
allocated the per-image buffer (IH_TYPE_KERNEL_NOLOAD and os.comp !=
IH_COMP_NONE), so testing that directly (or a bool set inside the
allocation block) reads more obviously and stays correct regardless
of how CONFIG_SYS_BOOTM_LEN is configured.

The cleaner fix is to teach handle_decomp_error() itself about
the noload buffer (e.g. an extra flag or a separate label for the
limit), so the 'Image too large: increase CONFIG_SYS_BOOTM_LEN' line
never gets printed when the noload buffer is the true bound. The
trailing 'Note:' is essentially patching over a message
handle_decomp_error() should not have emitted. What do you think?

Regards,
Simon
