Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430C5606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 15:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=odVW/vvd;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ISaZNvHf
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B4B5260603;
	Mon, 26 Oct 2026 15:32:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UYxT_a6a4DFE; Mon, 26 Oct 2026 15:32:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F176360635
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793028759;
	b=Cleh0X6TqHt77cBM3R1n4NhzQI8SD7unrnhfCPqY5LePO4BpniY3dpofOXCiQlVUfiNg
	 R405kUDaaNj+4l4ef2WwfZrNcWQLoikz/TVIgTQr37PI71FYjThd11YhcHSX7wim7rjSr
	 l6MS6P8kvX36+Rutkwz2gBzHGm1WSKsYu4whIW+3CPxqWRT8mHGeZux13mqTfBoPYhgzJ
	 qULuWZInJYhJvtNiN5vKWEaW5BGAC6r3mHx/wo9RMz0RocHoVETfcvn990VthoP+jczvT
	 wA8OfN7RKk33lSMVSFkRFS8L2M16Tl5fCFnt4r6oODXhd9vbPQoREgpZFtzJbmuj5vw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793028759;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=AXKY4E31p6DynU7jgwTJ+MAFi9p4O1BKf5MsW390DX0=;
	b=HoRNs9+5ArFFLMEutH42txDCasPlviYUaWGeepjYVSnMkF7Y/s2IOW8htAEOLRKiw1mk
	 52lHO6aTStQfDkWSc3oTVsUISJTnYxiWd5XfDibXYgx2fRMHKXkjzpk0QWc2jVEo5oajx
	 0RP3vvFpRtatq7ndIOeg51bLZ/isD2mgvxH3CGHLPGhLDdW0CP/edIYYQ35afGLi8HZmq
	 IoOJxS+oLd4ecmdVRGFQuVPTR6naW8Sh+T+2YR8t3V7vThARV7D0AG/ByuyHJWl29z3oR
	 4FpBSSdub3ERBT+dDir9MVvwPMyzvRegEeUCppCPgHw38Gr28knrW2jD2ocZCAI6pmg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793028759;
	bh=AXKY4E31p6DynU7jgwTJ+MAFi9p4O1BKf5MsW390DX0=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=odVW/vvd7j2+pA97n/B/x1+OHiFV/BKOOAeIN78jE1lmgi2/Jd9b2cD9Nfg8AT7PG
	 TkZcR/WMaKCZCNBUr7S1gR7ETQadwPplxAwt1fQKeG6pUcy+rShcAgGUt2PPIrfuLI
	 KqBAlb64CAgqzBNiyOfv02jANoqLqvfHeO1oiC0sDokoyO/WtclilvSdsLFd3xQIIs
	 +OS+a6n2AMp9sLr00tGYDLOLvxPQImnoZKCz50kStyjOaqInMpaxUT2B0lR7OFzdjB
	 TSKXQj85gA3Ph76alndC1KenuRLbNi2p6gUgx22yT75KL0omre8772aF+ZnYczcs5T
	 Xwim0T276MjVg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F176360635;
	Mon, 26 Oct 2026 15:32:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5ABD94BC
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 15:32:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5831B40663
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 15:32:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4EtUdf2IsxY3 for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 15:32:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5897340664
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793028756;
 b=lbYToCUAhBvjh4DJlbqDfxEA0BDhHwOqDqIBntmuZgEoDLLDEIBU+Y8OG6FdMOWVqDOS
 ZJzzx1siu3clYSqUaFOoB3dM2CGmCcpgopKuizLEfvzAf3B6b57xmLA6968uivi+QwvQb
 VE2Hj79EUuEsq5bL1kt9HUgAbHVXp2gBqzbs69aT4V1KfqnOVuBZEmXK6vaUAlcV807rc
 IgsYF2sq7XkTVSNhknY5IKL1I4WBagmjN/fWn6ytj9p8pZ2Eu85qdou3pebXK2qgrHOLu
 POKfYvNAT3Ptwpr80uhUZl+0cg+BaN6S6paA6Mtw+Pp4PqL7DTv1Pz75hE0I3victZw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793028756;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=AXKY4E31p6DynU7jgwTJ+MAFi9p4O1BKf5MsW390DX0=;
 b=iPxIb3QN82ZOdEvBGwgCAG35N4cYtS8HqXUaP1VF/TKJe3DiXT01Dokz+x3gVUpdJp5s
 SCIbiDxVrlwTsS9xvOtqHR1HMIVu4XRQgEpLVXiGlbfS4DQDlb6n4Ikbvtle+TrygI2QR
 h13Fm7VhbtuNWftqMHWQB/zHUKd+/r02iyDA3lTI42OOIVaLFiP4gD9vXyJkAkc2xMW78
 zmZjB/GyPKtI7bF5/aQMirQd4sIY6V85ZYlDvBw43RTsXchUQcmkPnXSD3SD/yG9M8IaS
 0ZyeyUaMIYlfXHG7Zw//mCEn/zbUIFZTSwJFR7FDyVJ0n2UylVU109n3Ai+sV/v9isw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=ISaZNvHf; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=ISaZNvHf
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5897340664
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 15:32:35 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6b1aa27963eso1961a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 08:32:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793028754; cv=none;
 d=google.com; s=arc-20260327;
 b=PznPTuxs3uvsEW+hbdnVt1Inthcd7J+ibXkXAfTNF6gbTWmsc8sZCmJHqnqExvDdSh
 a2IGO+3jnC/8zkcctjuszhvUonFt2FLSyVUVfPdOqPyDNZzuoWmXA2mviAGoM3BCs8mU
 VpwHu/qYyJt7hcuwLwrMuhTxoWEiIDHWeX3BqmJ+Cn9N4JHPX6PsdFHnJp+W9UDXXc6e
 dQuFTQC2H+VMKMw2cpXO0jyIWx+gi4erIMaXmkcgt3jFYAtjchrhMkns4RZfi8E40V16
 9uduLWnJoKALG+Zjya4wJfpnprl3HBVP+VjM2VvAlUbbVqDbQwFryCRnYnpvZWbgly94
 m/wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=AXKY4E31p6DynU7jgwTJ+MAFi9p4O1BKf5MsW390DX0=;
 fh=VINjqkK6uyBtXwZULJ3aSFhLCJnDVVBjealkVjTmI5s=;
 b=o3A7oqQCz2nly4TJz0GBX7X7PMsWnEdjBKBOoVW/01UqGUPb97toYKGPpGJuK8bVJ4
 tLS/ddB4tm4PO535c+PdE+jSBJVJ7/7uVmkP5yUJihCCs9zSFKjp5zJnt0Cqu9FXMlgs
 vB92N8yDfdWATUO1k2+pTxGor2WTT2tw88u52+EmduiQcST0eNJ0FyWVG6hBGT5gyVHb
 qKe6NPMCSGWwaBzSVvu28eTAM4pCt/1A60YzmeZosNYYafC4OIn7dKRXjWHuYOgX1qUk
 /tK+/IUpNobcC6HQ2cGxYBruVnDPZRo/6CE9Rwvh4TRxa/CvGqTZ80FJCoL4ELEJaqnE
 hIGA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793028754; x=1793633554;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=AXKY4E31p6DynU7jgwTJ+MAFi9p4O1BKf5MsW390DX0=;
 b=ISaZNvHfIWlHjqpq2OqrT04Ofw/OUq50S1X3FbFTQGU7+CaToO95+JPT//TND8bNkP
 mw37N1pn7XW5E7UmzNTL4JO2KgCeos4XJllORVi+iykR5w9AoMqxhC6hux7vnh0JUsQu
 H5EfoZEQv2wrjMRCa6hpQOaaCRVgH+5MGoaj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793028754; x=1793633554;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=AXKY4E31p6DynU7jgwTJ+MAFi9p4O1BKf5MsW390DX0=;
 b=zDLpFlfaZMpJpfmqkCA/PRqc45wNrm+25RA8KgA33/ny5k+VwgxETDf45RnAH+Vqdn
 G/td38PfuDxPn4uVxc+QcXfwBim7PqJseSy1hmXEb5kRiPYiMA51cc7la8I2BYnnITsi
 T7Uby7CAXvfOKOjwSDhy5TixIucf/n8GiDIdkUiZWF5kguALlvyicWERqq/b8nvfgC70
 WG4EUbOkjuBK6pDq5cLZdHHaBznzGZB5t/0Ew5zhn7c6WD+0o0TmcjS6JLQR6j1FnWHb
 cP0xc5U5qa4SCpd7dUI1CBtF6K/AiUZ23cSV6NL0lpY1tPDXbHxbvzOi8k4v8DcLKYlY
 CQKg==
X-Gm-Message-State: AFq9FYLkR8Q8vGM01IIQZkXdzl+ERAH7M9fQcQc1hvfHoj5ux+iAen9i
 3HAXKm8Jm7qZMOJkAW//WwYTMt5I4aWkVW/c5L/8dQQSuBmWVilU5WWkgK7I/qku7abJZXfSGUN
 uifZIZ/O8+MKl6yUIwNaXGDVd+TV5uY5NDsAa6rllrhjqNKTXtC7IQA==
X-Gm-Gg: AYBFou2qnKG8Fjep7YXR/PUIAC4V5sDta9qwF/7kep1CyWvPVAftskVxjt+YeYqFurf
 9KPiPfJRH9HJlI/0GEZNK176DbiLVXc4O7XQa6FUgFwFnxRKoXYIUaJERMSq73wCYMClrZDzjNs
 kx7Y87or0OmmscHTudtEAPmcbSlCVX5awJ4I4m3a3lYv29zb4TGyQwfCY5+q/0++XJx/HNeWyW6
 BOqRY1jgqe8yRdiD1lbvDgqY1saCug0gPPwN4ysME4W9ojFBHjUZJhFUGNoVkswPpL7GQIld1je
 S5t4qnsT5zMQ/7eSuKZkKeE435ouktupp/cT/jewJXC/FJQV6t/f2vn2qqj3198MXgkyXQZejZ1
 dMZvRCobZgNs+NYvXrgCPHAyhPGve6rtgzeA=
X-Received: by 2002:a05:6402:b2a:b0:6b3:e4e8:74ba with SMTP id
 4fb4d7f45d1cf-6b442fd858emr6050999a12.13.1793028753572; Mon, 26 Oct 2026
 08:32:33 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 08:32:31 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 02:05:25 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <05b8bc65fe5c2cdc8b93400570b9f77f2684e571.1792504199.git.michal.simek@amd.com>
References: <05b8bc65fe5c2cdc8b93400570b9f77f2684e571.1792504199.git.michal.simek@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 26 Oct 2026 08:32:31 -0700
X-Gm-Features: AclHuK-9Ey_EShVDliRW7wovbAzl_4mA_BTr0iNE_J1TeQgfM3QwzuLzp2p7Wj0
Message-ID: <CAFLszThCjQHHH4FsESfcdo99BxX0g1aMOipMkcR7ASm=Nsp07A@mail.gmail.com>
Subject: Re: [PATCH] gpio: delay: configure wrapped GPIO as output on first use
To: michal.simek@amd.com
Cc: u-boot@lists.u-boot-project.org, git@amd.com
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Pranav,

On 2026-10-20T13:50:01, Michal Simek <michal.simek@amd.com> wrote:
> gpio: delay: configure wrapped GPIO as output on first use
>
> gpio_delay_probe() requested each wrapped real GPIO with flags 0, so
> direction was never configured. On native SoC GPIO controllers the pin
> stays at its default input/tri-stated direction, so gpio-delay's
> set_value() never actually toggles the pad.
>
> Rather than establishing direction at request time, defer it to
> gpio_delay_set_value(): use dm_gpio_clrset_flags() to set GPIOD_IS_OUT
> together with the requested GPIOD_IS_OUT_ACTIVE state. This way the
> wrapped GPIO only becomes an output the first time a value is actually
> requested, and that transition still goes through gpio-delay's own
> ramp delay instead of being driven silently at probe.

This doesn't quite match the code. dm_gpio_clrset_flags() runs on
every call, so the direction is set each time, not only on first use.
Please can you either reword this (and the subject) or make the code
do what it says?

> diff --git a/drivers/gpio/gpio-delay.c b/drivers/gpio/gpio-delay.c
> @@ -41,7 +41,9 @@ static int gpio_delay_set_value(struct udevice *dev, unsigned int offset,
> -	ret = dm_gpio_set_value(&desc->real_gpio, value);
> +	ret = dm_gpio_clrset_flags(&desc->real_gpio, GPIOD_IS_OUT_ACTIVE,
> +				   GPIOD_IS_OUT |
> +				   (value ? GPIOD_IS_OUT_ACTIVE : 0));

One thing I'd like to check is a real controller with no set_flags()
op. There, _dm_gpio_set_flags() calls direction_output() on every
write in place of set_value(), so dm_gpio_set_value() is never used
and its open-drain/open-source emulation is skipped. Also, if the
'gpios' property has a pull flag, the call now fails with -EINVAL,
where before it worked.

It would be worth changing the direction only once, then going back to
dm_gpio_set_value() for later writes, e.g.:

    if (!(desc->real_gpio.flags & GPIOD_IS_OUT))
        ret = dm_gpio_clrset_flags(&desc->real_gpio, GPIOD_IS_OUT_ACTIVE,
                                   GPIOD_IS_OUT |
                                   (value ? GPIOD_IS_OUT_ACTIVE : 0));
    else
        ret = dm_gpio_set_value(&desc->real_gpio, value);

That matches the commit message and keeps the existing behaviour after
the first write. What do you think?

BTW, to cover this fix, dm_test_gpio_delay() could check that
GPIOD_IS_OUT is set on gpio_a 9 and 18 after the first write, perhaps
as a follow-up.

>
> Fixes: c866f2f197e2 ("gpio: Add GPIO delay driver")
> Signed-off-by: Pranav Sanwal <pranav.sanwal@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
>
>  drivers/gpio/gpio-delay.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Regards,
Simon
