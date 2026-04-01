Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C2B510FCAC9
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 19:21:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91CCA83CE3;
	Wed,  1 Apr 2026 21:21:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EcdGxr08";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA4B183F7D; Wed,  1 Apr 2026 21:21:54 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8D2D80517
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 21:21:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b9bfcbaa81eso14546666b.1
 for <u-boot@lists.denx.de>; Wed, 01 Apr 2026 12:21:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775071312; cv=none;
 d=google.com; s=arc-20240605;
 b=ZYkEb1QKmxfPNwjm4OR3oXGp0GgonzUK/6TJXUlRBPAsHhO7SA0fH9ueXvPRUKlzv+
 kj77K1H1a+bh+Mb668c2KHKiOrtgEMghnvcPcjKn+TIOHlWWdvUxSW3zPkTduAg/S/Id
 QnjVfQQE2eXF6bXhgnbKDkvr+fXbQuFhRp0odmjg/BAL2ckEOpo2NvsQBeV24HPz51k/
 7X7ZRurr2jCQw++xOLtSEol0bZjVJBj9H6/GKqA7SnHzujXhRNZ/6v+vm9cU5mcevq/u
 wDHnrlxr+Fmcokr+KrFFKqq+TEgTxM1159uTduvs74fR/uIHj0DMm7Iz54R3zVphOoXp
 c5TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=maGjk4q3qtgGG+6sXe/bIyGdL3HWWaSd4pa/gVVWnIs=;
 fh=Ep4XymEjZXAMeTcHv6IfUoi3WcXbGoIeg30b8xoqmMI=;
 b=GVqDSeT7oxWLKGltmC1VvTnZb4akhIUw9yGcGUTRkPZjm8w+c/eewIuWOMCQV0Fn+0
 rbiw3ykstKDllV6olHcVtGryRH+cCByjJUC4sia8sbVyb2FBE702ts3XJf468JdgqzX+
 //7MEMUMJceIjagW0XYBCg5jOPmgHZ5jWRlNXdeea8IdG+S/0Pcr1xyhS6IPWa2iUiQV
 Spy7u8rHH0kWps5UVU1fQuVyozCb+Q2cjlvBCqwecj0BZe2KRjvn26VgvUjGAPPLSk7+
 H/M4PVuId3e24zeSCcfWqFQcdreVlMazCRrfJkYr6wQJoZexlDzS9L7HyijesuLO2Dok
 dsKA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775071312; x=1775676112; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=maGjk4q3qtgGG+6sXe/bIyGdL3HWWaSd4pa/gVVWnIs=;
 b=EcdGxr08fUmKUNzvMjtB1BIuS24MC8uEYP35PZLsmxZb0AYcUw0Uv0qL/3qO3Wx7SW
 BHKYyT1g4UqWtnxXtbu0OJZoL5esQIECarqnFBZRq22lxOLhAt+sdPd3aV2B9bYhmSld
 KplyZrWFsrnaTnvEdLnbDSF3Ay+YWFjVv3L5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775071312; x=1775676112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=maGjk4q3qtgGG+6sXe/bIyGdL3HWWaSd4pa/gVVWnIs=;
 b=OvS4fcR2GQzGEqGmQvvod3/B06DYtE8xclyboFsOkiAqFe4RANpvLjnF5d8teXy4dD
 OJ4VK/sD77w5GvpE98ixEc8CZ+EyFptmOWhp8qcdhV86TpiRlaDEl5shl2WPYuTH1skG
 cV9Itx2rk/kwKQ4xSZ4QBkoeihCWoxu80/cavXh4+BRrkj7pfZL59AdeMKSeiIUff5z9
 1IKINRfZeoM4pRuLUOAsiWE9RxkcdmoXP+FUtKWUWkaSuFVllbIh9whuPgvj/2VwgS2K
 oJYE7CvhL8tYeV1jmpGx5J13Jpesh1b5T0EK+6RnGWb7Hpr77+Evoo083rjUzQPhcPzp
 2ldQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzUlF7sGtch0Ym2qfxVnROd1lLGmepi6a3SuXbIQKwkTku0AwnKDXOewhg0HmVLMJw2JkzPRA=@lists.denx.de
X-Gm-Message-State: AOJu0YzcojHUS748+PuzdKuRX3h0N7xB5YNldNxk9YeDkv6s4nCL8NSM
 hCbM9KlzyB1j85Bf7k+oHTkZ3fQg4fA5EYkOmiQfh4rHHKFLIeAwcFYjLQjJxSxhnkTsPmEMGni
 sSWLLucBZP+S1PrlHTzm6n6GT0kMOaRQ2meJxRVz8
X-Gm-Gg: ATEYQzwupQMAxlYJAX85wbQ7s7O58QkwU1qW19hCvABeLx0Tft+zKRgRtabCy2UxxpG
 BYGJ0aJgWUG3vVTLP0KIHtMIMO3X7gGH/Z4eMqX6UOwa7ocf4DMSQS8OItl6wjOdbFeD/X08Fh4
 Eg/N59DrpJo9PolK+agUaqRbhHw61gNqit7qYPoJXDM4TYmgs8zTMjV6kegmWfnT9J+Eh6gQ3ox
 iMwEtDynmD4Fw8wp9eoZwqxmpW78mCCQ2RXyMF9gezISFMs1Jkl6caIIyxLEmuX31NNA5dBZPnl
 VDQHRhWN1OVC46Dt1ZJHBrq7m2IAMzIjy4vlpF3uL3Nj1Ht/6Qo=
X-Received: by 2002:a17:906:f185:b0:b97:4e42:23ef with SMTP id
 a640c23a62f3a-b9c138f8b82mr197111866b.16.1775071312036; Wed, 01 Apr 2026
 12:21:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260331080117.2370092-1-ilias.apalodimas@linaro.org>
 <20260331080117.2370092-4-ilias.apalodimas@linaro.org>
In-Reply-To: <20260331080117.2370092-4-ilias.apalodimas@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 1 Apr 2026 15:21:36 -0400
X-Gm-Features: AQROBzAmxXwi58pHMEgZneHpxpc-b4euuENaauOGzLtHeOKEKdtgl7HiHjyxiRE
Message-ID: <CAFLszTjBntjNr8dC1c5D7nBnCbHRQdznymEFV9VJNo46js-U=g@mail.gmail.com>
Subject: Re: [v2,3/4] fdtdec: Introduce fdtdec_setup_ram_size() to determine
 the memory size
To: ilias.apalodimas@linaro.org
Cc: marek.vasut+renesas@mailbox.org, trini@konsulko.com, u-boot@lists.denx.de
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

Hi Ilias,

On 2026-03-31T08:01:10, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
> diff --git a/include/fdtdec.h b/include/fdtdec.h
> @@ -965,6 +965,21 @@ int fdtdec_setup_mem_ram_top(void);
> int fdtdec_setup_memory_banksize(void);
> +/**
> + * fdtdec_setup_ram_size() - decode and setup setup gd->ram_size to the sum of

There's a missing blank line between fdtdec_setup_memory_banksize()
and the new kerneldoc comment.

Also, 'setup setup' is duplicated.

> diff --git a/include/fdtdec.h b/include/fdtdec.h
> @@ -965,6 +965,21 @@ int fdtdec_setup_mem_ram_top(void);
> + * This function should be called from a boards board_get_usable_ram_top().
> + * This helper function allows for boards to query the device tree for the
> + * overall memory described in as the sum of all memory banks.

'described in as' should be 'described as'

'a boards' -> 'a board's'

> diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> @@ -1142,6 +1142,24 @@ int fdtdec_setup_memory_banksize(void)
> +int fdtdec_setup_ram_size(void)
> +{
> +     int ret;
> +     phys_addr_t old_size = gd->ram_size;

'old_size' should be 'phys_size_t' rather than 'phys_addr_t' since
'gd->ram_size' is a size, not an address

Regards,
Simon
