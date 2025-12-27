Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2EB3E8FDD8
	for <u-boot@archiver.kernel.org>; Sat, 27 Dec 2025 13:45:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7574183B7E;
	Sat, 27 Dec 2025 14:45:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="clnpWbaP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BC4F83B7F; Sat, 27 Dec 2025 14:45:25 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F78483B72
 for <u-boot@lists.denx.de>; Sat, 27 Dec 2025 14:45:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-64d30dc4ed7so9078208a12.0
 for <u-boot@lists.denx.de>; Sat, 27 Dec 2025 05:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1766843123; x=1767447923; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uMSzFBWysZOgUE7tMlIqYrN789qLxOQD78vvDGmBna8=;
 b=clnpWbaPADmUx6MB1CIlyoMEbBaOfqhIY7StL3qe7+LVZQaBBULyMfjHc5nbgmBBdt
 HvnCX/2HFZql7Qdlo7BITdnsaY+Tec2GTN8g1u0Tra5SnX5nUGzzU4hJN/tUJJLkoU2e
 q24jEE2RFlrAjvkpKfWtpGyji9Yz9+yhBbLfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766843123; x=1767447923;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uMSzFBWysZOgUE7tMlIqYrN789qLxOQD78vvDGmBna8=;
 b=fxyDtnoleINab9O8oIxMsKYD0H008mYL4uTxy1L+FJiGQza1cfA52QpcHj98gHZthy
 9X3aBTo/+YlExewzVN0hEXCuAmG5x1jd7L1Lr9mmwjxYVIfTQZexansXb/FcrQsakEjC
 8884Q2/jBR70FrRSi/gOvaLIsyTWnt/Q1ru4HPY+1yXWCDfRE8g00SXvAd3u6sEvdhoc
 UFQlviuGSAiSi7pUBWBk+m3zBAeN5Xvdp7TFuPsxT7qU05EpNr0H/gfdCtLcINPzO0Y0
 HrPGUoFVHLhmjlo0x3mW04avleAx433rhb5GNRWO9ffH1Y1GzXfb7mVjpCcEYWO3gOxH
 RLig==
X-Forwarded-Encrypted: i=1;
 AJvYcCUf5quwqRIQFCC+sYIxHpOZEjK7DUon1uF1XfauU7DAUpUilD0oZvqEWG9bZ4lEk/Rk9OC9a2Q=@lists.denx.de
X-Gm-Message-State: AOJu0Yw3oQ8X+5/C5AjZjnbntb8+pqyiWE6QOwCfrmy6pb4BHXt6ogr7
 HXuIK1Y12wpR+ffY9szYnfqKi0TfuDW0Qubr3oaaXVpIUkUuhTs8QebPG4PKvY1STtR0s/4NROx
 9UoOVKHAC1BJYRZZ3kIRYfHHNBMza9jj1uFOf5ftO
X-Gm-Gg: AY/fxX4+A8UAYi3XZLYlcB54PBWRp9l9JAeNmX80pe6A8S5cwQx0WhGppxo6pRKLydu
 1+0YJDXRSvlQ9VQIfqvSZjcaAyGszmtbryuS2zuAj7W8bKd4sYu+KQ4xKLu5MoAYx1HTac3h39k
 xpBCkkMQaTthAFyzFDSMiMhdw9doZ20wZaML+iMp88hnf3NyPtZDE4aXrhsNZz8gerzojisrirp
 HbYsHONk9Hbqnq3wMUUyzbNpK0s+LykafNBvsCdPsZB7PuVHdCLRwcQkhgUMsRSizejnvfoskuG
 c9X+
X-Google-Smtp-Source: AGHT+IEbFEm0Y2HLABL0SDWFZXvnTjq4TlMXUW11mGFQgINJBQjBkpKwAGaTpX01zufY82wjnIrA4eg/q+hMjlpPfgM=
X-Received: by 2002:a17:907:3f23:b0:b74:9862:3e36 with SMTP id
 a640c23a62f3a-b8037198d15mr2888178466b.51.1766843122702; Sat, 27 Dec 2025
 05:45:22 -0800 (PST)
MIME-Version: 1.0
References: <20251221015859.738112-1-heinrich.schuchardt@canonical.com>
 <20251221015859.738112-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251221015859.738112-3-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 27 Dec 2025 06:45:06 -0700
X-Gm-Features: AQt7F2rY2uwDVoT0JB11IfGRsMGgk516A8TghkuRegXuRvCfd5F10uLI-1K84Zk
Message-ID: <CAFLszTg8f+gRehmoBVL4fvSdQo-ABkKZHoKnnh1M0RAHN4bZ+Q@mail.gmail.com>
Subject: Re: [RFC 2/8] trace: initr_trace must succeed initr_dm
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Shiji Yang <yangshiji66@outlook.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Yao Zi <me@ziyao.cc>, 
 Raymond Mao <raymondmaoca@gmail.com>, Sean Edmond <seanedmond@microsoft.com>, 
 Heiko Schocher <hs@nabladev.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>, 
 Rasmus Villemoes <ravi@prevas.dk>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de
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

Hi Heinrich,

On Sat, 20 Dec 2025 at 18:59, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> qemu-riscv64_smode_defconfig with function tracing enables ends in an
> endless loop in notify_dynamic. When iterating over state->spy_head,
> list_for_each_entry_safe() does not discover the end of the list.
>
> The reason is that the address of state->spy_head has been relocated but
> state->spy_head.next and state>spy_head.prev still point to the unrelocated
> address. Therefore list_for_entry_safe() does not discover the end of the
> list.
>
> We cannot start tracing before initr_reloc().

There is a step missing here...why is initr_reloc() sending an event?
Also it isn't clear what this has to do with tracing.

>
> When placing INITCALL(initr_trace) directly after INITCALL(initr_reloc) the
> timer driver panics with
>
>     Could not initialize timer (err -11).
>
> Tracing uses the timer driver to add timestamps. The driver model needs
> to be initialized to use the timer driver.
>
> INITCALL(initr_trace) needs to be placed after INITCALL(initr_dm) in
> initcall_run_r() to let the timer driver work properly.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  common/board_r.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/common/board_r.c b/common/board_r.c
> index 76f9fc090fb..2b8f5a423a6 100644
> --- a/common/board_r.c
> +++ b/common/board_r.c
> @@ -604,7 +604,6 @@ static void initcall_run_r(void)
>          * Please do not add logic to this function (variables, if (), etc.).
>          * For simplicity it should remain an ordered list of function calls.
>          */
> -       INITCALL(initr_trace);
>         INITCALL(initr_reloc);
>         INITCALL(event_init);
>         /* TODO: could x86/PPC have this also perhaps? */
> @@ -635,6 +634,7 @@ static void initcall_run_r(void)
>  #if CONFIG_IS_ENABLED(DM)
>         INITCALL(initr_dm);
>  #endif
> +       INITCALL(initr_trace);

No, this is far too late.

>  #if CONFIG_IS_ENABLED(ADDR_MAP)
>         INITCALL(init_addr_map);
>  #endif
> --
> 2.51.0
>

Regards,
Simon
