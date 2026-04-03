Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 106CAE8536B
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 13:22:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEC1D83642;
	Fri,  3 Apr 2026 15:22:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mPMnejwH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45B8D84129; Fri,  3 Apr 2026 15:22:30 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B71483642
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 15:22:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b9825ba7f9dso493626566b.0
 for <u-boot@lists.denx.de>; Fri, 03 Apr 2026 06:22:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775222548; cv=none;
 d=google.com; s=arc-20240605;
 b=RzhwMsLyoXQdoB8HMLKOYQ8qwwCp30PD+PTs+Ne99DAux1dXifpU7l6l8YHBs7wd/w
 YLmFkib5blcqycRaS/csfGzJWXLZ6Ou/zqXtNZL0dm83SlQqbu5u/1BNXCeht4jp/Yl5
 7sq42JOBXNYb5PCpvJYQb9t4GBVH61qGqebX5Ku6Kg8qbW2a6MBNy8uZTpJknrBi/3+R
 EWO22pJffbpp7lcsSh1rWAus/xqdw59NDUJ/U2LbNUwQafsD/EQjvKM/hBHSicmuAfcH
 5Ndb8mr7dsKBlycL9hCqAiv7BTdseP8hGCAKJDH7HZ3ZSZlmEMPhIJfQSu/8Q8r1JgP0
 oKKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Bj3+4IHR1q3FC+n8K6gaf2t6LMbUHl9svL9aJcD19co=;
 fh=HLdiPJs/mnHt8wVvA8Vc6jRlr8leddhtYdJsb0ra954=;
 b=GAJB/bRkL0p2gkXwS/3o2nwUtV3inNfPyhVBTnCM7KlZ3wmF9oVL72fSZwwpzLB4nU
 wLKWus4OMdKgIErSCSrgIh1nd2v8DrQ5Yqj9UDLIGG/o405+grURoMaqHuvJhBsyX+/0
 vbD7AAxuj2ohuNYH9FR1qjho9hKm59jzVS0bDZSVA6SsPdM8eh5BK+No+5Ys5BDV/Ktp
 F9vzq+bFq1eZg8WMPnrx8swVoOyibqdjPmmN/5pwDX7vNvQpOEYfpqh2ruS0qHJhl2Eh
 C1OhkWr8pfXG1YjYLC7bQaPdlKCH5oGJUP4jMlJyyY+IOiMkXWQnom7MCzMdV9f/iHTG
 b5Pg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775222548; x=1775827348; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Bj3+4IHR1q3FC+n8K6gaf2t6LMbUHl9svL9aJcD19co=;
 b=mPMnejwHdXNUuV3pfZxkqBFbD0+1d2wKUIPF4KlOWGxwcHJFIGr5M1aBFBhDsiesXp
 J7kdkRCQNnXxRpaEIf/Yn6gGLo6SzScvDkIO9sHih2JiHOCmpZrbrp1+JxqQthziEhoN
 UflzebX2yXZrs5Ak0BDYT7KTOSoqZc3HYNwC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775222548; x=1775827348;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bj3+4IHR1q3FC+n8K6gaf2t6LMbUHl9svL9aJcD19co=;
 b=aoyHvA7XlnzgMqOVJkJw8jAh9a8q/A1SGokHKG0Cx+RXjYJoL73pAAp7Uxu1rG7dHp
 X9BylNs+rhI0xheAcnIDLe2NrufI5AnWtzuLTqVyw/RwLN7pHXb3bUmsalTEuOR6gpFI
 LuLhgAMNym7u0Swpu1DINfZoeR372jlnNZvtq0ADhYs9meZlSqZZAQdfmvfAY/OkSroe
 Mbj7wlN2wNSIqGtn+Vc/2qsM5TucF2H/LM6ohEZwFYuouVsNhNbdDD8RcGKEXfXNRgow
 ZpRsWl5+44IkiLyERtsQxT7gCzqCRGBwVtkmtigSdyPpE//vq+enTuHLQQNSgunN8aFV
 SPdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4ZHRuO8avmpmekavR2/TZPDFVjCFkmXsxgYV5PPXW5C0em++phWztgNAvTDij3r4JnS4o43g=@lists.denx.de
X-Gm-Message-State: AOJu0YxK6yT1PirrYhwD8YmL9T0mnfIq4rihAI8s/aWDZqn9Tzqppr2S
 VzVBN3Z4ALYGyMYX5lbNi1DFhkNpbwEtjXzgU9mGX8KLwHEqoBrGtG1pJorwhJV4ZEvLpczHnau
 ZH6uP0Jd0JIBxMH394HcjeZsBz9AbD1qphoTfuDx3
X-Gm-Gg: AeBDietaSEzn+oR/NWtm51BGMzvHmmvJLw4psluLmRlWoa7Wiw+OxumHVZ0FIrXEpqn
 oirhjuFJRSxhMOqhJ0llHqnv6ZERWAY5h2taN3E2wl4I81tc4Yb/DUsJfFxu9TL8o68EOGf+4GS
 1udp4G36FfayBy9N5FXKn/xdb70sEJUsmLCNx6TvjXkgV5CWvUZ2fId82V4nA9/b6WEAKtzf4DB
 SqnXkfucesu+bIjf6pVg94hjXlLl+DuCdGh+FiXUF8EcGDghOvITWjKYG40fVInf89Vhs837YxY
 q1iGXJltC0Xi92PF
X-Received: by 2002:a17:907:c22:b0:b98:f1d:6a63 with SMTP id
 a640c23a62f3a-b9c46e25d10mr322813466b.9.1775222547704; Fri, 03 Apr 2026
 06:22:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260331191853.44549-1-gary@garyguo.net>
In-Reply-To: <20260331191853.44549-1-gary@garyguo.net>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 3 Apr 2026 07:22:08 -0600
X-Gm-Features: AQROBzDcQRfhmX4KObEwgGG0MAPIc1m8wdfCm51yQ9UIfk9gG4ahOgIANvpE9tc
Message-ID: <CAFLszTj-QRQBCZHNCyM6YR7n5M4+myr8ztDo6Xn9CfDb6=ppSA@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: support EFI_OS_INDICATIONS_BOOT_TO_FW_UI
To: gary@garyguo.net
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 David Zang <davidzangcs@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Javier Tia <javier.tia@linaro.org>, Martyn Welch <martyn.welch@collabora.com>,
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

Hi Gary,

On 2026-03-31T19:18:51, Gary Guo <gary@garyguo.net> wrote:
> efi_loader: support EFI_OS_INDICATIONS_BOOT_TO_FW_UI
>
> EFI variable OsIndications have a bit EFI_OS_INDICATIONS_BOOT_TO_FW_UI
> indicating that the OS (or next stage bootloader) requests booting into
> firmware UI instead of continuing autoboot process.
>
> Support it by having autoboot.c asking EFI bootmgr if boot should continue,
> which checks and clear the bit (so the next boot continue as normal).
>
> With this change, systemd-boot will show a "Reboot Into Firmware Interface"
> option which will be able to drop back to u-boot. This can be useful if
> bootdelay is configured to be -2.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> @@ -1290,6 +1290,51 @@ out:
> +bool efi_should_abort_autoboot(void)
> +{
> +     efi_status_t ret;
> +     u64 os_indications = 0x0;
> +     efi_uintn_t size;
> +     efi_status_t r;

(I'm leaving the proper review to Ilias & Heinrich, this is just a few
nits and a though)

Please can you use a single variable name for both efi_status_t variables.

> +     ret = efi_init_obj_list();
> +     if (ret != EFI_SUCCESS) {
> +             log_err("Error: Cannot initialize UEFI sub-system, r = %lu\n",
> +                     ret & ~EFI_ERROR_MASK);

The log message says "r = " but prints ret. The similar message in
efi_bootmgr_run() just prints the value without a prefix.

I would also like to see the code which adjusts the variable placed in
a function.

Regards,
Simon
