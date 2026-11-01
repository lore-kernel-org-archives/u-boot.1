Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B640E606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 17:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ny5NWIAg;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=LDzHZqOy
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 92F64405CF;
	Sun,  1 Nov 2026 17:16:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z1jS8VopRHjp; Sun,  1 Nov 2026 17:16:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CC895405D0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793553362;
	b=ORJhFpGDU7rJEfSqGa80PuyrZIkxUilmcGh6HXEC3HN9z6C9HyMpeLnW2Ec7BqQUyCtR
	 H3YhQ3967oGv7vj4xQX1SZPT6ZmZr8wK2eQ/BBdEhA/kJq/507QefrKqZFtpdPUaRC2B7
	 isCMKf5NPuZJxBCaanm/J1uKD0iNu2UrgmG87rSrdb+VIH/x6QvRBDh3w7HEjGgOrJaXg
	 w/nCpvPlOnGlJKkJYYt2bc7/GT8Ms9sPJ/0MDVa4JsfPO6AB7fbtRce2zm5/lU5PWBB62
	 EK+oFnyaAOWZzuqref2WniAdmiPKDayIG1VPTSnOEIBccYs2H0WPLws4ZQvSTyu05Vg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793553362;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=7pA5Ijn11rMZet17+AKXoOo3qka97i0ZXpMEhv/4O8E=;
	b=K7wOaWPV/Ys7YPt/vcTb0ZlPXH4gu058/NJ8AfLg73xnle/w4MTzNUQkwKnH41yL7LNZ
	 qS7b0asb6F+ei2NU2oi0moTf4fniII2O29l4cJKezjhgEhbTUFt2/vnecQWk44BQVYPBB
	 FAiKHemLGehAE72PAgL3Sy7VzsnAJ8n3hyhfAS9t2hleVU0xzSv0bj7QkNNQp0oHcwQKt
	 V44ClFELRpE7zP3pz6wbj0C4N/FS0FhSwLejv9fEiyWbm55gGQOjnbq8jSvf157Cxri35
	 bps5/+NzO0dulqNu5IyEhICRLVg5DxxVlJ923iB8zlPoAi3wHEjkWXXD+cEDaLOfD/Q==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793553361;
	bh=7pA5Ijn11rMZet17+AKXoOo3qka97i0ZXpMEhv/4O8E=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ny5NWIAgwCHb7+ianRONaurSP9dkXbH8JiD7xEiqee6+hXI+3HCaB3Goe/JzyBang
	 XiyML6upycbnKj59GzQ5wjBD/Z/eZHEErNt/rbNlaJSUqkDawUnrWi97A17R9q812F
	 +CWkVwnBurIZTlZfXOqpHdqj8fr0ZzNEucE0wbTr4fB3Jk/VnjtSG9Mook1a4cKp5s
	 oWgRGbYEUPpj0ZlC9pGQodRSBiTaHgeJJCVqDHlklxdEkvYeTn9LDeFinzAG6EXcxv
	 D3RHpNFcV+Xm4zfixgtY/sLLUvUVC2Yy5gAVnHK+/RSKI7sCcyZES9eKu9SlRN9lnB
	 jZ/1qJ8vSO/pw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CC895405D0;
	Sun,  1 Nov 2026 17:16:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id DB931EF4
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 17:15:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C2385606E5
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 17:15:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y6_29oq9ktrR for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 17:15:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A2480606CF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::634"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793553359;
 b=UEJ722mBB/koWZ8bXCCcaCNcSi6y5iBxLSqTjvk2OcZ7X/nhp8Dj0PIfzrp3fC9eNL2b
 UOZXEr12AAtL5rFUd6s7STdzdE7Y/WjpNPkkR08Kf8U7v5uR/yA+EXG1kwPAAAhIdxwYw
 +H59UsFL3/C2fTyJz54i7z2Z2vS4lbmYCVqyi7dUE8jk3IMdZ0OtndLKo0MgQhYof3/vT
 EW454nW6Rx1wqYl6kMvMWI3jYvZMyWpUiOKngChPSCwi/SdFpnxy3h3aaNhSQwvc1knUr
 oVMkGpg6tKIZUFrXRFHAX6Tm/GXEn7EsHxvn70UD2GlpaUdA8e7CJMuT+SecksFe6TA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793553359;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type:Content-Transfer-Encoding;
 bh=7pA5Ijn11rMZet17+AKXoOo3qka97i0ZXpMEhv/4O8E=;
 b=N52Qqm8P/yi67JgkadWSGbw8MjSua7BNgsAIvuvUrQbxI2A8rrm1mkPlnhMhvy/2rvJL
 YsZnmWoLtem53ixau+5w7jt/3bYo/BoYYyVvEfv/SUEibR1ch3Ds94SNtFNY8mVcMaxxr
 QbJ9gAQb1Up7qXZgo6JwJxIsP77KI3v+iSIA9QGG91F3V6HPB375pdzOW9l54xuJLmEM8
 qhd31NT/6KtgX3Gtc/bDifEO/1L94ughtx8xWaTAeA1dhuUOUQWiUV5EZT347FkgoUZpH
 34hlDyIW6Cxu8PAcXLYk1SQqxdtas5kog8+DNKgPWUkD1HvMa0cb2lKAug7ZC2/lSdQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=LDzHZqOy; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::634"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::634; helo=mail-ej1-x634.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=LDzHZqOy
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A2480606CF
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 17:15:57 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c46bd7a7345so465250766b.0
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 09:15:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793553355; cv=none;
 d=google.com; s=arc-20260327;
 b=LYPRCHTfh1qxo/zOm5vNchpkH8eIhIeXTLd2Emo7glcYbsIPpJqH7LGdnDw4jp+OlH
 Y9ecyTZUFAn9PssDf387ZexYOXjIHDN7on+6rGkWQj3ZFN/gK6lpdF1z9JzdNFAHYbV+
 KGyY05qfamYj5O3Cf6Fkj+5pEWFXC0MCUU8fDvmYTjOCAmDpPt/FqpsVVHdm93MtTN1i
 mtFBHkJ6A2NWMKhneNdAZ3UaQZUrbyLpfEaRepBztph+px0x1lte7FBv9/ULaOaP5o52
 hi/Sr67LVEshMsyzRMRf5/AhWFSmWLbK/qcfFNNXRzRQCPNrwBzwaw8hxjOVkcUhSKPP
 22dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :references:in-reply-to:mime-version:dkim-signature;
 bh=7pA5Ijn11rMZet17+AKXoOo3qka97i0ZXpMEhv/4O8E=;
 fh=nq0sldJ3Bdg8wyHZmEzVexphxoV+UYOIMFIzxAt9iZk=;
 b=nj//TC3trSS1n1Lb8BeFY6xTHvRa0b21hUShWh0HMwzbyGqQLrxMEpOabrXQkXK47y
 FBt1KQ4GBvSJPGTTyMAIBkE4CnhciCWKGW9iKTAaSdZTGdIL2CFqUJ4dq9vaGJ/SXhPp
 EnTKkBzODaTmLh55YJk6o3n1i2mYzjp4oKP2cjCB5J3i1SDZw4DX9e+PHSu84QAnfJwx
 o5ranaa5WmZYe/isgz2HZhEI25yK6gIP70OzZ1dTRcU7c8qyT2/9XtMdpmHdQ8oaScRY
 CsmaRcFZLSv+1qDPO8XFflrDUiyiAHv8dQ0KU1tkJv9hc8/3/bUFuIvn2iu9XYiGID8+
 /eeA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793553355; x=1794158155;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:references:in-reply-to:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7pA5Ijn11rMZet17+AKXoOo3qka97i0ZXpMEhv/4O8E=;
 b=LDzHZqOyYFggLI5RKem2//iBNW+uSa3LENzFmNIFRg2a1Fuu1IRAO9/twDhRF8s4tf
 R1gcBqik4zCUFgvN6GJJWofjiTcfBU11JnUR1yBPLVHjkpulUco17K03fqhoH5aG0vCw
 bJyEjrkdBle5pfyaepX+gDz0qvlP1vuW0+ybw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793553355; x=1794158155;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:references:in-reply-to:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7pA5Ijn11rMZet17+AKXoOo3qka97i0ZXpMEhv/4O8E=;
 b=qgQw1FS9Djw/ao6kL8CLlLEIFx+KV+oyLcfqtCcQjrxIzhV6lf9t65vHK8lqx3kJqA
 TmWwgmZpS0UmpqIz9KaOL3L/b53qiCdSfrpPRYzH6il6VMemjAVpZrwVFrUdszwguOxT
 rKxMdPPlMnu216vjeo8ub01x6JCTZl3KX9xefR73EAEpUGD01J8BPmI5+dJoshqKKxyc
 nKdG18BTCzTTwIs4129sPqtQ/619nlRa2jEM75RtaATPal9Z+jRa2yGSkiJZCiH6TRta
 noJvpA1a21s1x2dudRI61uoF25tyNpzUbWiwFJqu3qNw+0KX2v4QXfHwWZsYX2neuXfw
 +myQ==
X-Gm-Message-State: AFq9FYKremELnXMZxH+1TCw0YdADMBzfScSaENxT7tPnk4SfCvfuMb/Q
 Ne8p4a8JVcCg9uE/G/3FTAk32Od8FBu/X7dmjszx0PBg2hNGwBdaRu63HAslyrSmZx58MT/66TU
 7Q7djZeYJZk3czNditdk072MGb/SbE2LHbMeU0HNOt6xePqfuiK08Emhy
X-Gm-Gg: AYBFou1DTRq9z0TFJ8NvVoJkZAFKeiJy20LupLzFCnNmrhzxSDVEL9Ou3aKuwNVhGRw
 roJWjfE4tG0BPD+zrp6vm9m/SYH4REMoXpKWNlF8RDLVE42VYzyqYFELZXr/UQewjT8eVcA650E
 GPiOEgstyZ6IVcT7urYqRb9n0CPHsV4OZWtIboAGSRZufxgqNRayyOmNisTxe8xAiWQQY01fAmU
 dq12tnJNOqO+cbsrmvyZOXjMpet9mURWsNH9f1A9gSG2OZHDNqEV1ybgECHiD4xtQqCblwO19/t
 j43LjboBnhwsjGNZfcwnJ6GEjYUg7G0JY9bGuEkDYqqfjG6JtCUq9hQoFoTh4lzQ7IkrIZ7fRmJ
 cWrHa4+ZdBd7HKWsl9BJZ3Txk1EcpMul8GhT7wMkHRl99071zOe5a8TzWA4S1/PzpYawi9mw=
X-Received: by 2002:a17:907:6e87:b0:c36:777f:824c with SMTP id
 a640c23a62f3a-c49d10fcdc8mr960759666b.4.1793553355231; Sun, 01 Nov 2026
 09:15:55 -0800 (PST)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 1 Nov 2026 09:15:53 -0800
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 1 Nov 2026 06:56:45 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261030073655.164481-1-ylcncn@gmail.com>
References: <20261030073655.164481-1-ylcncn@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Nov 2026 09:15:53 -0800
X-Gm-Features: AclHuK_3s4ghWnV0tYnbw4k6zr2Z4O_gQh_Iy-MpnqykNFj8RUDPL4vuObx-mAE
Message-ID: <CAFLszTjd0n1LQ7wnJGTVgpHgirffJsz1U5FXuBhP5j783LFAZA@mail.gmail.com>
Subject: Re: [PATCH] console: allocate the device list when
 SYS_CONSOLE_IS_IN_ENV is off
To: ylcncn@gmail.com
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Yal=C3=A7=C4=B1n,

On 2026-10-30T07:36:55+11:00, Yal=C3=A7=C4=B1n Can <ylcncn@gmail.com> wrote=
:
> console: allocate the device list when SYS_CONSOLE_IS_IN_ENV is off
>
> With CONSOLE_MUX but without SYS_CONSOLE_IS_IN_ENV, console_init_r() call=
s
> console_devices_set() before anything has allocated console_devices[file]
> (only iomux_doenv() does). The stdout device pointer is then written to
> address 0 and read back from there by console_puts_select().
>
> That goes unnoticed while address 0 is RAM. On the RK3066 started from
> the boot ROM, address 0 is the ROM (GRF soc_remap =3D 0): the write is
> lost and the console calls ROM words as a stdio_dev, hanging in
> console_announce_r().
>
> Allocate the one-entry list when it is missing.
>
> Tested on an MK808B (RK3066) with U-Boot started from the NAND ID blocks:
> boots to autoboot with the USB ACM console; before, it hung at the banner=
.
>
> Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>
> Signed-off-by: Yal=C3=A7=C4=B1n Can <ylcncn@gmail.com>
>
>  common/console.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

> diff --git a/common/console.c b/common/console.c
> @@ -248,6 +248,19 @@ int cd_count[MAX_FILES];
> +	/*
> +	 * Only iomux_doenv() allocates the device list. Without SYS_CONSOLE_IS=
_IN_ENV,
> +	 * console_init_r() gets here first and the list is still NULL: the dev=
ice went to address 0
> +	 * and was read back from there. That only works while 0 is RAM (MK808B=
: after the vendor
> +	 * loader's soc_remap); from the boot ROM, 0 is the ROM and the console=
 calls garbage.
> +	 */

Please can you cut this down to a line or two, e.g. 'iomux_doenv() has
not allocated the list yet if SYS_CONSOLE_IS_IN_ENV is disabled'. The
MK808B and soc_remap details are in the commit message and will go out
of date here. The lines are also well over 80 columns.

> diff --git a/common/console.c b/common/console.c
> @@ -248,6 +248,19 @@ int cd_count[MAX_FILES];
> +	if (!console_devices[file]) {
> +		console_devices[file] =3D calloc(1, sizeof(struct stdio_dev *));

On Tom's question, I checked this. console_devices[] is a
zero-initialised global. In the !SYS_CONSOLE_IS_IN_ENV version of
console_init_r(), the env_set() calls run before GD_FLG_DEVINIT is
set, so on_console() returns early and iomux_doenv() never runs. So
console_devices_set() really does write through a NULL pointer. If
iomux_doenv() runs later (e.g. 'setenv stdout ...') it frees this list
as 'old_set', so a heap allocation is correct.

It would be worth putting this in the commit message, since it shows
the problem without relying on the RK3066 memory map. Also,
sizeof(*console_devices[file]) would be a little more robust than
spelling out the type.

A sandbox test with CONSOLE_MUX enabled and SYS_CONSOLE_IS_IN_ENV
disabled would be good, perhaps as a follow-up.

Regards,
Simon
