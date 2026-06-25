Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D9E9CDB47F
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 08:04:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12C9D8493F;
	Thu, 25 Jun 2026 10:04:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EHy5MrVB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B915847C8; Thu, 25 Jun 2026 10:04:18 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BFD68493F
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 10:04:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c0d6c75c58cso57250166b.1
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 01:04:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782374655; cv=none;
 d=google.com; s=arc-20260327;
 b=CVaXoapXaINlUwF1yL4JJ2LOM+wCMl5joga7Whfm1PjVjeBsQGezQsiMvlNV5Whe3I
 k1jx/j4pU98x1d8tQ7+gY6Ab8ftuuwJuqU9Xbic9g2gUBoDH7F3f8yUf1aXO8Qc6WjKa
 IedMTZir9tvWlfjLXDJ3uu44iRy/S+0prEv1/kHAYSYp7VjRbEu18qksIro38++/VtHT
 O/8wpLeOWED1U2yjdnhlDVC7gPx1Yx6EbmnzS6K+JoFdie+P4i8cpR4qgKavA2z+TStP
 0n4Ct1bnX15mRnW1ts3epfavoJIFx5mb16rcVtr/QocdUGtaoIUQ9Qw6zP732vCeYy6Z
 WMIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=lUu6r8xxadRaCdm/r5pUIrTA10IPOZkHGVbkql2TY04=;
 fh=oyiS1HjGAHh/b0PCGs8ZrowVSKDYk28OUZ+G4f/As28=;
 b=q1v+h9zImQIVCEOOhKshxdW6D7gKzjbRRRPPsqsDqCW7U752OMKkRacNgen29So0/u
 8tT7Edqw5qHkTTDYluErxTIsqeo9MPczcrb0x/ocWVU+pC8dS++as7/3HSXlecv9mH8I
 bjbObsGCXmHa0uZV1xqp8Zy27kmPFxwsP78OVE52xxXeuQxgiWDQ+0+WQXoT7DJPscpB
 HjtrFVH8kiuXBTlmE2hCp5wGRJy011U0/ZF1395Zqbg2onjhGDftLUM6XzjJhbxBEo1Z
 o1RqmVrmv1uM5fBBa3c5Atl5Xvlml/Kcef25SbcSA0jy+6oSdMX3N6AWX9nxf+0uo/or
 J2/A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782374655; x=1782979455; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lUu6r8xxadRaCdm/r5pUIrTA10IPOZkHGVbkql2TY04=;
 b=EHy5MrVBjStu5H0xJG1ZxTYSnlCpdNL3d9TneV/88R2y7A0W1wB6t7ykRKm2j9qdVM
 8/fMKd5uxLtkLVeQ6RWb1mIxhF+irZFP5tqRixtfXV9GV8J4oj1EU/N9uVfs3kyEzCP6
 KhNBnX/GpzSpaqrPGuuqflISRlejfqBD81ydw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782374655; x=1782979455;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lUu6r8xxadRaCdm/r5pUIrTA10IPOZkHGVbkql2TY04=;
 b=mmYFx3CjsxM/G3Xy96qk1mV7UQoLxLhanYv8HpBfreZduGb+zHG0Y8xSCNOW8fu4JJ
 0DjPcxeLPQroKs2YweAwSjJIFTY7hTDPMiXRrpeAHJayhqnCxyVAo2N8LNxR9pmTqNBd
 TTKY8geBtzIx7cDI03MEDWFpAvjB6GXRGpRG0Sehdr0AX1cmRlhobYD4swWoOZTEXjBv
 nERG9AxcpqraoiQYzfCbQpkuk3Uy2BB+vgTd2ft4vv2WdP1R9bTFV9ybRQ0dxsEg2pjW
 2VFijTKQiUXtvq9AiqL1b/bZ1T607hwlYboisUa4PiQxUHgsYZvfGeAuSw8eKm+xBkSW
 MsuQ==
X-Gm-Message-State: AOJu0YwNCABUHcguP51zR1iIFRML9LYuXxendbz1vc2PVUbRj68O75+u
 EAlcxkbnF0MY13pgZlsgWNBk6DgprOaVKJ1Z9uWTXOMKyLHq91QJljPVntrd6EC4LvbwJt2uFGZ
 z3wqwmRTwtnHBdmhQQhimmpL7xeDzdThhgimUlkXJ
X-Gm-Gg: AfdE7cm3ZUR/eICe2vUURYXJ9S03gteynsS9MCW7FUAbCt4Gou/wiYU34kPNX8oOYr8
 uYJxd9kQhyaYorJi+Jo2Kaond4nsxZfR2erUN94n4XY0WjCeyNgq9BTY/RzKQVLObavbXJWm5Hs
 +QWJj9MT7JQYkPdn1QWM6rZllZ5MkXKGJtR3gCHvwog0uX2/LbCN61ueQjApiTOXvCMewwu3Y4S
 7siBnS2gbJ3pnkzIEeqN9kqjJzMT0spNKPh0LSGbvbXoUU+DgD1AcXe3mua/ZvNcOiO7htsPA==
X-Received: by 2002:a17:907:d15:b0:bc6:14b3:e835 with SMTP id
 a640c23a62f3a-c1205ef2174mr85092266b.32.1782374655290; Thu, 25 Jun 2026
 01:04:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260618154750.180675-1-aristo.chen@canonical.com>
 <20260618154750.180675-2-aristo.chen@canonical.com>
In-Reply-To: <20260618154750.180675-2-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jun 2026 09:04:03 +0100
X-Gm-Features: AVVi8CccUN4KfDdJY4DzB0jCBKtNme8O9O-oi-rx2-0Wl_zcMMLzyWxu5G_9lMI
Message-ID: <CAFLszTg-SvwvkULgG3=VdxOY90Rv=EdXE+kYjp4dzCdEfXZ5Xw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] spl: fit: bound the external data size before
 reading it
To: aristo.chen@canonical.com
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Anshul Dalal <anshuld@ti.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Marek Vasut <marek.vasut@mailbox.org>, Michael Walle <mwalle@kernel.org>
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

On 2026-06-18T15:47:45, Aristo Chen <aristo.chen@canonical.com> wrote:
> spl: fit: bound the external data size before reading it
>
> load_simple_fit() loads an image stored as external data by reading it
> from the boot device with a transfer sized from the FIT data-size
> property. That property is listed in exc_prop[] in image-fit-sig.c, so
> it is excluded from the configuration signature and stays under the
> control of anyone able to modify the boot medium even when
> CONFIG_SPL_FIT_SIGNATURE is enabled. The read happens before
> fit_image_verify_with_data() checks the image hash, so an inflated
> data-size overruns the destination before the corruption can be
> detected. The device-tree overlay path is the sharpest case, because
> there the destination is a fixed CONFIG_SPL_LOAD_FIT_APPLY_OVERLAY_BUF_SZ
> heap buffer.
>
> Pass the size of the destination into load_simple_fit() and reject an
> image whose data does not fit before the read is issued. The data-size
> property is read into an int, so a value with bit 31 set arrives as a
> negative number, and comparing it as an unsigned quantity rejects that
> case as well. The block-aligned transfer length is checked too, because
> info->read() moves data-size rounded up to the device block length.
> [...]
>
> common/spl/spl_fit.c | 41 +++++++++++++++++++++++++++++++++++------
>  1 file changed, 35 insertions(+), 6 deletions(-)

> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> @@ -291,6 +294,18 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
> +             if ((ulong)len > max_size)
> +                     goto too_big;
> +

> @@ -302,6 +317,15 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
> +             /* The block-aligned read size must also fit the destination */
> +             if (size > max_size) {
> +too_big:
> +                     printf("%s: FIT image too large (max %lu)\n",
> +                            __func__, max_size);
> +                     return -EFBIG;
> +             }

Please can you avoid jumping into the body of an if-statement. A goto
landing inside a conditional block and falling through the printf and
return is hard to follow, and will likely trip up static analysers.
Put the shared label at the end of the function:

    if ((ulong)len > max_size)
        goto too_big;
    ...
    if (size > max_size)
        goto too_big;
    ...
    return 0;
    too_big:
        printf(...);
        return -EFBIG;

The cover letter quotes 57 bytes for the current shape; what does the
cleaner form cost on am335x_hs_evm? If it really does push past
CONFIG_SPL_MAX_SIZE then we'll have to use your code, but please say
so in the commit message.

> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> @@ -291,6 +294,18 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
> +             if ((ulong)len > max_size)
> +                     goto too_big;

Since size is the block-aligned length and size >= len, the second
check already covers everything this one catches, including the
negative-len case. The value of the early check is that it bails
before get_aligned_image_size() runs on a hostile value - please
mention that in the comment rather than the bit-31 reasoning, which
applies equally to the later check.

Also, the diagnostic only prints max_size. Including len (or size)
would make a real failure much easier to triage from a board log.

> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> @@ -427,7 +451,8 @@ static int spl_fit_append_fdt(struct spl_image_info *spl_image,
>       } else {
> -             ret = load_simple_fit(info, offset, ctx, node, &image_info);
> +             ret = load_simple_fit(info, offset, ctx, node, &image_info,
> +                                   CONFIG_SYS_BOOTM_LEN);

Just to check - the destination here is image_info.load_addr, set a
few lines up to ALIGN(spl_image->load_addr + spl_image->size, 8)  --
CONFIG_SYS_BOOTM_LEN is a sensible upper bound for the overall image,
but it isn't the space available at that address; the FDT is just
placed after the loaded image. Please note in the commit message that
for the non-overlay paths this is a conservative ceiling rather than
the true destination size, so it isn't mistaken for a tight bound
later. The overlay caller is the one actually sized to the buffer.

Regards,
Simon
