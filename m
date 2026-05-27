Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9986CD4F54
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 04:41:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AB6F846CA;
	Wed, 27 May 2026 06:41:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DNJ17iFU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAA77846CA; Wed, 27 May 2026 06:41:40 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A84F80433
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 06:41:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-bd6460b0d11so1973609666b.1
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 21:41:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779856898; cv=none;
 d=google.com; s=arc-20240605;
 b=Jp/I959BbopXUtbYV9cIPeoYbZtnQu6chmqBgpkM1QdllQzwTKaFK9K4wzUHVmFqMz
 1NJlN5YTj6prW64Vsyg9DTxlLkvy9qH14CYF6jTeaiibtjVG660I2CaWOt2L2L+qcK1X
 FHVu3oEGoXjd6bSolJE0+lW3OwNoaJbr7z21l480CMGtSexmq2iwCnOaMB2GPuw4kh53
 hNt6Q0euN3t7ugg3XCyDZ+T5/K2yMowmJj8pCfUzpdZ+kl7buiE6s8Yamgj/j95n89aS
 3z40jaWNZ9gmUGBfCC+jbik+GjCbZAV/wUONpljR+CcemWrHGIVwf3buXoqbpszwmZ0R
 h1mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=FURvVhsQwQ7f4/O9qRJRHTWeCyLBqiGWNiNUeOCT4Zc=;
 fh=dF1r8TcFC8WpmU6ie9flbb4nUWAT8O17IykatCYVKAw=;
 b=KOUNfLg5Q3vJFjDOthpc5eysJ907QB7GAJiuwTgfbbqC2Y4jdFk2mv9DloBdBxg2F3
 HSKqMbkA7oyxGtNTfaE2pCP97ojA/qT/G9fMk1AW8ckb8bo+aHncWfFctxPqz8WPCXdo
 ANpZkv/BXnSWkJc0ARETXwhInAyDpyTPKk9wt5V1U1UTgryOsGVHcRZ2RhvC930MjoX1
 G0sJVCKov9fWwL+fpZYLbS1U9BBscv5Ax134EOqed3G1pFxu7XcKIKB0R4UofjyP9uid
 vtsPssjZHNUxrRD+fftoQkp5WfCKxBUPdrjRsEljHaNM2Dcd+jtc1C18CW7OwaNknnLZ
 TTZw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779856898; x=1780461698; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FURvVhsQwQ7f4/O9qRJRHTWeCyLBqiGWNiNUeOCT4Zc=;
 b=DNJ17iFU5DuGLcd3VgeiWDqROoLuQS1yFsmM5na4jppLHwgotgRAoosPdOXkC6DVx0
 sgDzvRih0mJnDDNL/CQg2FXako/XXxv+Go+qwPJj/iCjZ2kcdBjTrCAUmIAb4tSd3dam
 4MONN59k43Inu7Cind0FssbDq0/CcCdPObknU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779856898; x=1780461698;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FURvVhsQwQ7f4/O9qRJRHTWeCyLBqiGWNiNUeOCT4Zc=;
 b=UIxeSjzUP++5nsiUuizvpLXUHs3c/0tj80ztRLpOMhP2Ht23HGex6gb1PMiHa/sjbG
 nc8MnxxLp3PoVKJZx4tiGBsGAVawMG5Ny4kCkt6v8Ahaq2RNz3sBTMG5AIf9UwdKPwfR
 6fu76ZeMQassQ+QfGqKaXjJUTrAvXg6Vhs7IsZo/G0DMRMcwEqVqczTFQiolyGEC6jqN
 ygQZ41lYammiHqx2aGPG4AA7VWgyo8309sVwD1pUqufzE9XdnOaekwu2KKRFHLO1DCHg
 SrJmLsWk2EyCzaSF+/R+JXLX+B8NYmE1+MoAHpJcl/J2sLSfRTrW67p0Q+Q2fXHI71ju
 D8gQ==
X-Gm-Message-State: AOJu0YymHl4fP1issL+q7scoO7icmEv2++tkHPia0Ne18u6suSk/3UKW
 DN28kdO9Sv4r/J1ZlOll9zYTn6Yo/Osprc2QPJ64Zfi7N5rQHYUza42zz5Xu+62tj1XC8N49Ltp
 3oHGsOxG/ldzGgUJTtH/x3Ze6APcBlAp19FOCPsfN
X-Gm-Gg: Acq92OHhOZY97ytkRE++hB7aMBbIjzDS8uOtrR3p4UZ8kikshTXkNbDA7/fuYcqvzEJ
 WVg0tcs9Z0f8oqo/eBsMGhE8yM+4PrBW+ofKYn4yrAmlxWVFQd8reBz8Rd+UxJ6r7wjo20U6cGz
 6wbHMsQr2Ex2WY1l1TV0EiG+rzKTHLVL+BpKc/hFdsMGjZYkp3re3u094k7bEDa8WX9O0FGn6gR
 AxFYwpWyCndKul0zModegrd3XdzV6yVQEHadzDhnKvqiYbtmUiUbtwKguDt4A3DN+pAN3bSJV5s
 2nEBVsxEOFuO9xfG
X-Received: by 2002:a17:907:1df0:b0:bd5:156d:835a with SMTP id
 a640c23a62f3a-bdd260d4e2emr968777166b.41.1779856898525; Tue, 26 May 2026
 21:41:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260526202218.4004070-1-trini@konsulko.com>
 <20260526202218.4004070-3-trini@konsulko.com>
In-Reply-To: <20260526202218.4004070-3-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 May 2026 23:41:26 -0500
X-Gm-Features: AVHnY4Js_DZm8jV2immd96yKnnVoggXUdITPhH0pFqQv-RmfrDLMzFpySj43vB0
Message-ID: <CAFLszTgeaOPAkcLR3eKm_s+feXMoHzs15ZY9KEnmM2wSrTNC+w@mail.gmail.com>
Subject: Re: [PATCH 2/2] dtc: libfdt: Introduce a can_assume check in
 fdt_check_full
To: trini@konsulko.com
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Anton Ivanov <anton@binarly.io>
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

On 2026-05-26T20:19:26, Tom Rini <trini@konsulko.com> wrote:
> dtc: libfdt: Introduce a can_assume check in fdt_check_full
>
> The current upstream method of having a function omit various tests is
> to use the can_assume macro. Take the logic we had previously been using
> and instead make it a can_assume(PERFECT) check within fdt_check_full
> itself.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
>
> scripts/dtc/libfdt/fdt_check.c | 2 ++
>  1 file changed, 2 insertions(+)

> diff --git a/scripts/dtc/libfdt/fdt_check.c b/scripts/dtc/libfdt/fdt_check.c
> @@ -21,6 +21,8 @@ int fdt_check_full(const void *fdt, size_t bufsize)
>       const char *propname;
>       bool expect_end = false;
>
> +     if (can_assume(PERFECT))
> +             return 0;

Just to note that this of course affects image-fit.c too, so FITs are
no-longer validated if used in SPL. People can change the mask though.

I suggest stronger wording in the commit message since  'Take the
logic we had previously been using' reads as a no-op refactor to me.
I'm assuming that the motivation here is code size so you could
mention too.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
