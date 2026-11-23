Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E398A606A31A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 08:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mLMhA03Y;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=giGyHrHu
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 40E6640660;
	Mon, 23 Nov 2026 08:22:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rBhT9yCkQi6E; Mon, 23 Nov 2026 08:22:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6FCC840654
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795422134;
	b=EpsmQHGpkFbLCrkdVKB1vkF7pWb7e3RzKee29f59hPu+hmhJEcLIrGBfxxZy44Ihv98d
	 lLkrrr1nB/jp+uYmgZsgW+42M9E575DgIC/Y+76kymhAq51MvnYqZnbjtlPIlMlUt7OQz
	 dKK9SHlx95HCPNtYdSWAaxuZ9I/80d5AkQtrwbZdmLO9BoGQ81BHfLJuqW3gtwCxMFH3R
	 wQnu2/THy/8IAf4slT8wq0CDerf+o++Cqw+tXtl2ptawHKGL3HdK6GxOTVPCCGCjLCEY9
	 3bgkcBeR5c8cqeD7QKFFDhMMpTBkq06S6pQ1CUsjO6RdNXg/8M4BwzOdW2wISgX/2YQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795422134;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=YjAFRJpaKRfR+JLbpXw7XfDziKOIzGwcRawCzZjHhFw=;
	b=El66uS+fr1Ovo04oczomW3KZcaprVvu+McMO4+6jJe23omU94Cm8wJKrw2CwjbjZmWQK
	 SdQhBAbV5Yge4H04IByUY1FlGE6EFE1gIIAUUVadKoNu9WbwIdsjgsyvm4eOP4b3MO8uT
	 aDQsIFzh9uB6D7Ei0v9qmXeQrYt4ebjpfHyq3IbOrk3nWC3KBh0r3YiOJNos3Z/PViM6I
	 H3egNwi81lqGq8HRSkRpPZBT9czPNz9yzFgOFTPBEVKF2rHLl2d5yXGiga1/CBuie5mNu
	 Q5OOAiMF4bU3dn+qSQeiFhywTwtYMD8JFKhvM5HUwrqVPnxXE2gWq5Yuvmzw0H+ZupA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795422134;
	bh=YjAFRJpaKRfR+JLbpXw7XfDziKOIzGwcRawCzZjHhFw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mLMhA03Y0aTIqvcKQrVpeDdHJYB/SJawZque0kqFKZTZjEMrqGcspsSO4Vb+dhlM/
	 1YyklKeNtXf3ULq1PCrXlVdJpSlyOOZszItVgFkoY6LqfauFfzV/enWSO1HoBVVx+R
	 1QglgJATrBGXT7As1lo18eZ27tB9FjIJsKBjw5kP1E/SWTBIzt1Nory6Ny7tynmAIn
	 dZOVD+Vcyem5iAdr+Lt34p3x4eohv0nShnij2EvoXdRG8hHgVcQH4934M1uk9heJG7
	 YEP2hOwmIzKyo+Lcn9stDXQTnRaY23cnDjbjRVqPo6iBYjhPM69dO/mI7if5DVn0nV
	 1+EwBWd+HMe8w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6FCC840654;
	Mon, 23 Nov 2026 08:22:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 52CC522B
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 08:22:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 451BF40063
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 08:22:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yWskN1WnANbE for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 08:22:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5714B4005D
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1133"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1133; helo=mail-yw1-x1133.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=giGyHrHu
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5714B4005D
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 08:22:11 +0000 (UTC)
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-8b4c685c751so24722437b3.1
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 00:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795422130; x=1796026930;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=YjAFRJpaKRfR+JLbpXw7XfDziKOIzGwcRawCzZjHhFw=;
 b=giGyHrHu1K2mYLSwHPA5ckGmDxtSXhM5KcfHFFhwkIAPHkwR5HlR35d7TE6sSD5a1p
 9lRkOoSrFmGhPcDrHX1YgFnmAARjFvBAYeZnY/W+fE4ru+Ffk8ZXpL24/pQGV4wxl0q6
 9FMXw+xpguGG6BzsyWiFc3IuDR19TznQ/3l9idfLI3YDAhmgkfFgehzuEsFWmzYKyhgn
 JKGNtVLRf4uO3p7D2rSrsedh1qivGxrOGCd0fNBXkq6+brRifShbnzCMIZxRL9JNU7f6
 SQMqmKy4dygQzhmATcwCvFu6yclhnJ55Srq25vOpTgF4KVCU3I2qZd4onI57I/1Hix7I
 Xw6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795422130; x=1796026930;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=YjAFRJpaKRfR+JLbpXw7XfDziKOIzGwcRawCzZjHhFw=;
 b=KM9J8TfddX0eyMo4kz+j3o4Dz4Mvl6eahjZY3pITPZ8R5tCQyWxkLITRvhL+xeFaTR
 On5H7CN5zLM6dx3+QKy7hSHZPFcLVkzLCDOUOTAE+0OmjJkjiBe42b4KO7qvIxxVMbVF
 68KspzyvFcwMYSmMffytdNBeHo1X8gM39WZvbBkbPAWM2D33wYEEC60BqCqIN/XuyIsn
 Qs90VZFvcUABYYykUYgIzKV5Olvc48HDfuw8gTOAlcyFH0lFXNSkuJOsiR8jJ+RB/+Pk
 6g8ra9ea05KaL3s4E344YklGBFE1EdTtJsSoP2a+71jZV3+qYcaOdb8nq1XGN31VGdjv
 hJvg==
X-Forwarded-Encrypted: i=1;
 AL+hErHDutXfl/t+hY6e7gjEQe+ObXTjvUKMcT0odCH5T59Y8RFFVksRTb2PyueO/M9VYRBfShJOxKA=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9f85NDiJWTWH5knJ0POC+3qKZCxwLBRT1NmjtYxaM2GcFG6huK
 JEeIfR4jFUaAoZlRRxAEPeR9TAPVy1HQjrTf3Pbb8d3u7M25rCDtXNgNXYvKghy77OCiDQWZE3E
 pwK0X6xAhLaIOSn4lV6WEY7pSoM+hRqUIS8JXu+caIQ==
X-Gm-Gg: AZFdTZdd/IqfCKjqXmP1ZviHxv0kXzwP3zcJIkg+xqEX7jWCHHDnHoAd5oE0qkEX9Jw
 Hl8wf0LLMZrcPuCPRbVRbfftp6Lo9PmYy6k5N6MbTVzxVM/WBz+VzD54ZruQou+vHq57fg4d3S7
 Yf32frApLBecjX4VMCtSI9ZyEesCtxIEZUtEQ7nwa2lCB5haUnrFjPdL802TEroY2mz0Znsfczf
 TgWbMJ8x1r0KVsHjofg/75yioyJQkhN8ubFq53UCPMenGJuUnDKQp6ILJ/plAKPTou0x/7GsSgm
 5hZkESHba5DMrnGN6hhX/TZlTO/awthGD79B/ZIh2cqsjMQJcTFEmaL7f7uZq60KYoUCqd59lO6
 fgtIOqsTrXNynPMZ01vHUKe2HK7yyMs0zZXEqau6OQSpLDhB1WH8YPnn89/R0aUmW5r42jFdlZY
 S7u9yb7m4lsa1pc/HR9qEEEKeRRx8+9xEkaVmBDp3Sy/8MzwZJ+JRr48dZ2U0NShb9fVAoxbPxy
 WK56sCwu9TcY1WvHqDTsSvEiVgU0x8ieAkxa/8Vw5WGR15mhmjiLEWQ2yjMeSwcJA7hkJYIJdPl
 nEMUl2BIk3022zTAr5sc7JN1vpqwLWged8Zq01zpfSeAeP+TYq67strHzPgIjDmvriW+Ra2EdUt
 1EF9kWoB5uPapOF0B0qKZG7TXY9NBgw721mLFlDjM3t0AHGq9k1sy6KJ6gdjST/h09A86ayHd7T
 si0JPzVjuPY2XVBwLw9D0wN5tjZsKjNflON7sUho/CUbgVyJ9xlwkzq91UIN6tBM2Wmpy/5Ak=
X-Received: by 2002:a05:690c:e18:b0:8b4:f333:d5d2 with SMTP id
 00721157ae682-8b5204d7da7mr33091127b3.74.1795422129934; Mon, 23 Nov 2026
 00:22:09 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261106051357.265179-1-oss.patchbox@gmail.com>
In-Reply-To: <20261106051357.265179-1-oss.patchbox@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 23 Nov 2026 10:21:32 +0200
X-Gm-Features: Aa3M54qBqxMZiSxEfz-R7JNvrp4dLoQ8351O_V304DIaGZvQr7AOn-9CI_8inqg
Message-ID: <CAC_iWjJBNXo55krjo0bmpYCUShfksyPswBBsGsEvD1g3OK4Ghw@mail.gmail.com>
Subject: Re: [PATCH v2] efi_loader: unload image if efi_run_image() fails
 before starting it
To: Yuho Choi <oss.patchbox@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.u-boot-project.org
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 6 Nov 2026 at 07:14, Yuho Choi <oss.patchbox@gmail.com> wrote:
>
> efi_run_image() returns without unloading the image in two cases where
> the image has been loaded:
>
> - efi_load_image() returns EFI_SECURITY_VIOLATION when an image fails
>   Secure Boot authentication. The image has still been loaded and a
>   valid image handle is returned, and it is up to the caller to unload
>   it.
> - efi_env_set_load_options() fails after the image has been loaded.
>
> Each such attempt to run an image through 'bootefi', 'bootm' or an EFI
> bootflow leaves the relocated image pages, the image handle and its
> loaded image protocol behind.
>
> Unload the image on any error before do_bootefi_exec() is called. For
> its other errors efi_load_image() either sets the handle to NULL or
> fails before it creates one, so initialize the handle to NULL and only
> unload when it is set.
>
> Fixes: 6b95b38c41a6 ("efi_loader: rework bootmgr/bootefi using load_image API")
> Fixes: 4540dabdcaca ("efi_loader: image_loader: support image authentication")
> Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Changes in v2:
> - Unload the image on any error before it is started, not only on
>   EFI_SECURITY_VIOLATION (Heinrich)
> - Add a Fixes tag for the efi_env_set_load_options() path
> - Reword the subject and the commit message accordingly
>
> Tested on sandbox only (LTO disabled, gdb). Forcing either a Secure
> Boot authentication failure (efi_secure_boot set to true in
> efi_load_image()) or an efi_set_load_options() failure for three
> 'bootefi hello' runs left 8 handles in 'efidebug dh' without this
> patch, 3 of them with a Loaded Image protocol; with it the count stays
> at 5. A normal 'bootefi hello' still runs and gets its load options.
> Not tested with enrolled keys or on hardware.
>
> do_bootefi_exec() also leaves the image loaded when efi_set_watchdog()
> fails before efi_start_image(). That affects all of its callers, so I
> will look at it separately.
>
>  lib/efi_loader/efi_bootbin.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
> index 12db8f517c7..5bcb8c2540f 100644
> --- a/lib/efi_loader/efi_bootbin.c
> +++ b/lib/efi_loader/efi_bootbin.c
> @@ -170,7 +170,7 @@ static efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size,
>                                   struct efi_device_path *dp_dev,
>                                   struct efi_device_path *dp_img)
>  {
> -       efi_handle_t handle;
> +       efi_handle_t handle = NULL;
>         struct efi_device_path *msg_path, *file_path;
>         efi_status_t ret;
>         u16 *load_options;
> @@ -192,9 +192,15 @@ static efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size,
>         if (ret != EFI_SUCCESS)
>                 goto out;
>
> -       ret = do_bootefi_exec(handle, load_options);
> +       return do_bootefi_exec(handle, load_options);
>
>  out:
> +       /*
> +        * The image has not been started. efi_load_image() also returns a
> +        * handle for an image that fails authentication.
> +        */
> +       if (handle && EFI_CALL(efi_unload_image(handle)) != EFI_SUCCESS)
> +               log_err("Unloading image failed\n");
>
>         return ret;
>  }
> --
> 2.43.0
>
