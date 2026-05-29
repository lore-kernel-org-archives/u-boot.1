Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFB55CD5BD2
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 08:45:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 209AB84671;
	Fri, 29 May 2026 10:45:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kkiDOWO9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDB20846A5; Fri, 29 May 2026 10:45:30 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEA15844CF
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 10:45:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-bd01481e592so1962783566b.2
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 01:45:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780044328; cv=none;
 d=google.com; s=arc-20240605;
 b=W1tMjjmes8OeStByC1iA7f8Bl9TSlNaqiXahj23c9NDruawKnKAKsuqNpLKUKA1QNf
 j2g14552iYRHx8/acKDvTTnATep5Cmu33qli/1VKmr/vcg3yors8b9EZv4Y+5XnPYjZq
 1zl6JVjS3/xTmZ+gQYcMds0iEfHJ5haC+88pTlmgd1Mr3l/XPseih0JrsPhhdUSwlMO+
 k9GObgiuj2LzGgW7rrLlhBmTvl/HR/+SxiJcU49ufTv9srmLygLTMjJ3JG1vCHXvoEuJ
 WuiGaisAjWvsaZMZQB9qK7OQvvDPFTxNDqHsz7G/1plmvLIP7HAuDZK2kZWVv48laY64
 M/xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xw9T0n3rVZvD65g4NOSl8NhQ3ozrwyEv+xY1Lm2gLQI=;
 fh=Hlhgev5xB0xlM2njeo0mv1AJniEuivCiBjj7I4NN/4E=;
 b=EGpBbTuf2CHXlEZl3Y+oVfEF1cBdr2145cT+tNOxG8vOQeHCLUCpmLuRPxg9kZ/eMt
 ERzKWUCSsziQR/BkXka+prFdZthtHE02JYy+av8QYSMSDykjzuFFQakNkbGbG9NexWsR
 AMyMpnlZPkePxcZBc0+cpnsW2dvE0/lg1A8v1Hkk+ktNyZQx3+Ylru3ezFEtvW5r2zw+
 gQr7+TLvFOtF2UKh33nuO65Jo4SPpd46PgcEwUPJkkQpC01UTOH3KViAwJCjp8PSkICp
 Pytaih3lyXc2WffIczG1TUhpBgVX1llJzygD4AxI9hnTxyfFlWxb8dPHMLxDytD3vG63
 hpuQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780044328; x=1780649128; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xw9T0n3rVZvD65g4NOSl8NhQ3ozrwyEv+xY1Lm2gLQI=;
 b=kkiDOWO9bZ6vBkweA3n51Sn2PKbLoJS0XN559r7WvwsUgrJVIPZWjd7RuQw5nZVudb
 FvXGJVNN8Ngy37Np0ULd8glJlt0z2H0BkY5rKH8IRRQonlk5hk8rrVGMn/WG0AyM8Kcl
 QgKwQyhCqJQqmloGCgQgJdX7oHs2PMmv0lEf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780044328; x=1780649128;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xw9T0n3rVZvD65g4NOSl8NhQ3ozrwyEv+xY1Lm2gLQI=;
 b=f3W9Kr4DYDMfaDRFX6pTtpnOdM/E3++bYf+w5e+Z28CoR9Ruhux1HqvOiDFzYwAXPj
 5D4be2sbyCl6kvD4C9EIuftZF5z35ylDw/UwUyFBC2ljUOT1ReBJHL/WuCx9I3gQ0SGV
 C/RMf7h/+bDzKvhYQYXGey9DABPLJsJijcZYHbr71zqz7IFRx39zHzp9UFPL+JGNgeew
 D1VEsxBRGvYnkFaLq879JEGR8bUF35HtvFdHxiT43+Hj+gH498lYOL6gcgCQ3mgwoNnH
 2leG8MlKKIc60oZPMCHi+P6cL9krgcU8cvphC7rghS8kXQLIZnzBTT6sxdjVZD+tEcDK
 oxwg==
X-Gm-Message-State: AOJu0YxwQTh48WpizoIeyH9OHcmoPoFMNE9Eabxi2/u4Iv48bEf6qXL7
 fEPCQIr5Esced/Hepwra4s0rZkf4zmHhr9B0qthWoGNF7ro8u3F7PrZHfINrJHHO80O277n+7ZD
 OUQu+8Zu6C5OzjWNqfngnXUgH4pNCF0vGoVQ2V7aC
X-Gm-Gg: Acq92OF18EUr/FG2UWGpiM0JhBrP8lENJTemhgh7CzuaLb75WdiM0W6Ur4wNn0hkCdC
 a1GdqvSpvxDyxsJO+O/mfPtbhsbnzRa+OBKqN/S95VGAogYRSYLbnsQszx+vYbHz9oD/lFoZCvJ
 RzwSwLv6FeNR55keTgHfYp1f0K94EPB6nFUXJWJUlU0YsH2RgfUXxb0bRMVmMbOudCTZwcBDUQI
 SjVw8WhB+vtvC+a4onBl7MhggLBLjhfI4MAgt4wzIWLMNjMlBmTVsNqcAF09DjWPxIDk9b1CRPU
 136IAnumo1kInzFqkxU=
X-Received: by 2002:a17:906:8455:b0:bd8:d0e4:dabe with SMTP id
 a640c23a62f3a-be9cb6e0387mr73526766b.39.1780044328252; Fri, 29 May 2026
 01:45:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260526105300.44523-1-anton@binarly.io>
 <20260527112338.9811-1-anton@binarly.io>
In-Reply-To: <20260527112338.9811-1-anton@binarly.io>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 29 May 2026 03:45:13 -0500
X-Gm-Features: AVHnY4KUivNVPjoTsN_iSQAINblIRoWrBksvKCIUe6_BQJCvHAtqGSc2ySOlCfQ
Message-ID: <CAFLszThthARfp8Srhg0w9qfw6D0=nzLrPf=0-oDWsezQpODqsQ@mail.gmail.com>
Subject: Re: [PATCH v3] image-fit-sig: Validate hashed-strings region size
To: anton@binarly.io
Cc: u-boot@lists.denx.de, sjg@chromium.org, trini@konsulko.com, vr@binarly.io
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

Hi Anton,

On 2026-05-27T11:23:38, Anton Ivanov <anton@binarly.io> wrote:
> image-fit-sig: Validate hashed-strings region size
>
> fit_config_check_sig() reads the hashed-strings property and uses
> its size value without validation when building the region list for
> signature verification. A crafted FIT image can specify an arbitrary
> size, causing the hash calculation to read beyond the end of the FIT
> image.
>
> Validate that the declared strings region fits within the FIT
> before adding it to the region list.
>
> Signed-off-by: Anton Ivanov <anton@binarly.io>
>
> boot/image-fit-sig.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)

> diff --git a/boot/image-fit-sig.c b/boot/image-fit-sig.c
> @@ -512,8 +512,18 @@ static int fit_config_check_sig(const void *fit, int noffset, int conf_noffset,
>                * The strings region offset must be a static 0x0.
>                * This is set in tool/image-host.c
>                */
> -             fdt_regions[count].offset = fdt_off_dt_strings(fit);
> -             fdt_regions[count].size = fdt32_to_cpu(strings[1]);
> +             int offset = fdt_off_dt_strings(fit);
> +             int size = fdt32_to_cpu(strings[1]);
> +             /*
> +              * The offset should be already validated by fdt_check_header();
> +              * validate the size here.
> +              */
> +             if (size < 0 || size > fdt_totalsize(fit) - offset) {
> +                     *err_msgp = "Strings region is out of bounds";
> +                     return -1;
> +             }

Thanks for fixing this.

tools/image-host.c writes string_size = fdt_size_dt_strings(fit), so
the tighter bound here is fdt_size_dt_strings(fit) rather than
fdt_totalsize(fit) - offset. The latter still permits a crafted size
that overlaps the structs block while staying within the FIT.

Also, fdt_getprop() is called with a NULL lenp on line 509, so
strings[1] is read without first checking that the property is at
least 2 * sizeof(fdt32_t) bytes long. A crafted FIT could shorten
hashed-strings to make that read go past the property - please can you
validate the property length too while you are here.

fdt_off_dt_strings() and fdt32_to_cpu() both return uint32_t, so the
locals would be better as uint32_t (and the size < 0 check then goes
away). Please move them up with the other locals rather than declaring
them mid-block.

Since this is a security fix, please mention in the commit message
that the OOB read is reachable during signature verification of an
untrusted FIT, and add a test in test/boot/ (or extend an existing
one) that feeds a FIT with an oversized hashed-strings size and checks
that verification fails cleanly.

Regards,
Simon
