Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD4FBCD3427
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 13:59:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2685684948;
	Tue,  5 May 2026 15:59:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ecEV1mXK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A147E84949; Tue,  5 May 2026 15:58:58 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DEFE848FC
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 15:58:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-bc4edbedb4aso26593366b.1
 for <u-boot@lists.denx.de>; Tue, 05 May 2026 06:58:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777989536; cv=none;
 d=google.com; s=arc-20240605;
 b=Xa+xC1FZYUrOGikU0Lu9s/iDdVRQ2CvChTd+v0xwOUWvOZIKEeL/omfkRIvyS8S6Y9
 OjglJiRWOsWQaDl+dWvZ8nQTibkvFg7n0gtuaE5n3QYBEKrUFmihTAbLiq6J+BQoePaa
 J2k+NE6CpEhxFPyKfyCKC9uQUSJY/EUO2KWiqkJhH0I6Q2vk+xUxdzcmxoHFU8pCSHkj
 xz6uYi4/dSvIA5pmyh48zfVzC8ao2xja/ZIcP4cmapmD15tJ9KiO/NKda8k5LnkN2CqZ
 oveXVFgit3l3Mm2drm1cT8aYM8EMtZWKn4z7eGsZfT1BtHtPGQf1xo9n66sJBB5zYybH
 2N6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=RY71QjM3iOWtYfCkUKp5LSYXi8tdeq5bW4y5rrpCObU=;
 fh=6sX/JMBB1a9uFLN+GawcERyIrfwFtjkiJ6nSJPOXXGg=;
 b=CoP1khPTUTr0XF6eUKbwIrwV+jxONAppma/NeSsbKsPsKg+sXjUtRaqU0Z4D6FSo21
 4zQjDX4jfWxcEwt0GPY9ssThWRrQ1lFJUh04AQc9dQZq2JxQFTgqa6BiScMVcNAsNBWs
 o23iFD+tzrYVlux90DuafCs94qJlOXlI7y8ELpl5RFKgfjoOVxHDrUWRxjGZwT5QA6F9
 oZ+2ZtUAVN9G2XwvzIhxAf4Aj58tQpf38MbwoRxHzuv76i5e8pmWfDHoXa/DrvsFNsvD
 AwatMwdkJjJdbjEJTEfXoa0tQA1KQaXjfQwqwgeRGtneL/SHKE4Kib003+ZusPiwoqpe
 PmwA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777989536; x=1778594336; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RY71QjM3iOWtYfCkUKp5LSYXi8tdeq5bW4y5rrpCObU=;
 b=ecEV1mXKzDE3GVq55JaDXOBqAPndcBk6ArDQAy4MxS3YadrFLcX9JJVo7a/CtRwSnG
 BeOdhm9PFM4lZ4hZKYE/fVXC+Zg+bu72m9rw2SzuSMu6psUjPElYtp3uwC4yFnAlMx0v
 QAEigjqFwgBc3tEG22/XCmJiW4VX73loKMxIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777989536; x=1778594336;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RY71QjM3iOWtYfCkUKp5LSYXi8tdeq5bW4y5rrpCObU=;
 b=IEKYyESO4LvjXOLwDWuQVq4uoeaWVhsdLpaXPBMU0dwMpRPXE1dKzx6m4FAPtzgg2o
 uO9BFiWHh9BV3xA003ekKahfPRaykVe5uumCtJH/DvRV3v6OwNtXC88b+LzpZruYsKvb
 KdqiS0sTuQzhTQ3nVsb2wnyojQ8gBvG+whGhx13wWRZfLTTNwu6HTZW8k1Y7P/CUHvDq
 oJ3RuVvy2DSZxZZSaE/0Hcp89nRAVh7YO2aqLVHyTuMmuoUJlWWMpvLa1qK4dUD2Mh04
 zJH2atNVLneqXwyb6WvgYuGi0beCPQ0yuWD2ksIZ/ABY75pjyPBocvG25VVGODz+rag4
 VWig==
X-Gm-Message-State: AOJu0YzZtFL36vsu26P11y56tUk9ljZUhgBSxPZarwhHswhkwpgArs8N
 aeaFnS6Mmu6jp/4EnloT/d9QxbFGrfHnuBRU9W4tg5joHUzRb3KVMeeSJXdPGge8jLOC3C0lzLs
 vr/E9DtzMH1gPy0oUG2Q2Mf8t0WsqBUUmav3rdmVC
X-Gm-Gg: AeBDiev/6M7kpwhZa+9IzTKbIaMG53Wl6gMd2ARyN9jmzjTIWOidc6KPy+J/12WPo/k
 I2NIJjo/NfHyA0Vu97QgpRrUJ+hfuAwCQTgRBy9MogggT4COYkibDDWce3vLjkMSa1yWSCWPreC
 sV+XVbnFjM2x2Ir2KZpo3/te/X++6g90bkH/6zj5OisAfqOc0upmtIoeLwa6jI9WaChkgt3fYDd
 4UcHo0/mHXnC1975NVdWZ3R507C9hKSeMIR7XXywWef5BlIhVlP9Pe3m2YF+jJJ1MBv9jfQL0XJ
 wvgelKKwy5MKqND1
X-Received: by 2002:a17:906:fe03:b0:ba6:4e0f:e396 with SMTP id
 a640c23a62f3a-bbffad38563mr799157166b.12.1777989535770; Tue, 05 May 2026
 06:58:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260505-ufetch-net-v3-0-eee5eb9ca5ce@cherry.de>
 <20260505-ufetch-net-v3-2-eee5eb9ca5ce@cherry.de>
In-Reply-To: <20260505-ufetch-net-v3-2-eee5eb9ca5ce@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 5 May 2026 07:58:42 -0600
X-Gm-Features: AVHnY4JagoXdSz75zn0ROlxoHc-uPM9gY1ZnrO60L7KktpYQz0jo5l7SuZUz1Y4
Message-ID: <CAFLszTjYcqmyTZ2fWOcutqeL7AHaBrfVfqK64Daf=V_QHK5oBg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] cmd: ufetch: only show comma separator if there
 was a previous feature
To: foss+uboot@0leil.net
Cc: u-boot@lists.denx.de, Casey Connolly <casey.connolly@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>
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

On 2026-05-05T09:14:31, Quentin Schulz <foss+uboot@0leil.net> wrote:
> cmd: ufetch: only show comma separator if there was a previous feature
>
> Currently, if NET is disabled, the next feature to be printed will start
> with a comma and a space which is not pretty. Add the comma and
> whitespace only when a previous feature has already been shown.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>
> cmd/ufetch.c | 29 ++++++++++++++++++++---------
>  1 file changed, 20 insertions(+), 9 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
