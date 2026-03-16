Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF9BFF30298
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 02:44:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AFDA840AE;
	Mon, 16 Mar 2026 03:44:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZY/nr4Ra";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 737D38410C; Mon, 16 Mar 2026 03:44:24 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B58C840A6
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 03:44:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b8d7f22d405so506493366b.0
 for <u-boot@lists.denx.de>; Sun, 15 Mar 2026 19:44:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773629062; cv=none;
 d=google.com; s=arc-20240605;
 b=ky7DrQe+K3fWcYJizDV9bxzOk8VFPgYSf4kkHhokAdpOIaCAFsTDZaeLm+8JAHCWo/
 vKTNpk25RL2SH9p7hjOdzMH1X/zPxXEuA1FJrbIshCbk0j5tlU3BIGFSgf8yLbJv/mSR
 sr7kwOm5Pl12tOo5VxDoP5sOoqvTlldVJsjDS6AS5n8Gek3vnIidp0HYbkKmlNgMfUyf
 PIE17X+sI332rllUVAVbXHa200ku4S3592F/eMnZdR9ZrE0XV9G8voP5TLSPZTQw0jLP
 RVuckmL6UfzlDJM/746aM/cNStsePXRWImJd4AJjNxYaBv45xnnq9dODZ6CcbolMm4J3
 JFwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4Z1P8cnNRJoEEtXp7Pxu1VvOO0DQEpBu2WZAWzRF2Ss=;
 fh=zGyDxAB0bCS1uClR71JKAdydwMJVnVqCuINIX7CBvkM=;
 b=H1fEgIxBlxoaUg35dGCpX6ouvAKqkvUiH75TzldNapURDmOSwzCIuGSvWHkp+hJNN+
 b8kmB2isXHHbBY9h50xS28/QyGcbgif5sBBhXrntX2ix2GT39dnm5uXPYyl8J1A8Ganj
 VEVPCxxeK4apkpJKvVq6jSTce8/qZs59MqwuEh8eQ7FcRucsItxLZpXvd/QGqn/tUJ91
 mOuuaaTUKsjRWHWZgW81cQ87lz53/rx91VkF+5Pvg6WJdCo3KnP6phVpDiqkCgE4IaFt
 GSmhzhHv/ET68HVvPfvJKq3OJgNFa39f8kYClHATuRqrnAcMdNrgnRHqH6vNa64+ouBp
 KnwQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1773629062; x=1774233862; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4Z1P8cnNRJoEEtXp7Pxu1VvOO0DQEpBu2WZAWzRF2Ss=;
 b=ZY/nr4Ra+2sx3cjbJ9hIhUVgdDJJxzVXBJ4ZG2kmi1qCQU0bO4x0umMOt1UG9JTZCL
 Tp5hTqRGuG1hqF7yhA4dWTuaIqi+45RJhip/TByOz7Ohwonwm9IGqHaFBm8+NZ74nhI4
 PHcoT8gVrctqnIMiRcdS9wqDRTM38YwPJxjrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773629062; x=1774233862;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Z1P8cnNRJoEEtXp7Pxu1VvOO0DQEpBu2WZAWzRF2Ss=;
 b=dYOEX79GaM5sKLrpl3yYdeAEMWcStc2JdA3uC8fTcR2XVksnTje/2dpd2ULHjyTsgy
 75bAjI5EYhjWyL404UWGbAwFHUc+rWnog5wQDTM7fbFHTq1FTJFWgeE8Z3v6YX6wiN3E
 gUW/sQ2hQVNFctF9wcZ9dbHI4ynHxD1mYljWyFXpYXY6PbV/RUfXiG51L/52SKJC1Pyc
 ZmfYQP5uBI2/aN1x8L8aUHqmzjzQuuDFccdP1BZsA0+ZGIX56UHaTvN/oCBt87LbXk/P
 pDLKv4rFVAI2HlHsKhIRoqDu5jZGhSO8HF9Oh83zkPerlTSVd+v9oPbuGsD+PvhuPJgy
 /R4g==
X-Gm-Message-State: AOJu0Yw5zWFlNGa97V67QHS3/puLKe5IVzUltwY8/C99wf1jTOqsyrJN
 DU/AULEtHfCogsalQx/xERrg8BI/D0m41RUNcu9qbYYl3jiztM7nM/zwtf+c0zYR6z7AY7XaaHG
 bO2PIJfUmsfWiNUeDUfRGgsn99jkNBBnfREuHTTES
X-Gm-Gg: ATEYQzw6Rst7tkPt6v/YOFC3JsRO6ulIgkAGdLTZIzHglSXDZF7Eikz/UBfBRQcmw/y
 Y8H8hJ6KtVtrSehQjFH6PMEtCgKV5d/jcvMswKDZhiVuKzKG2jvDLQ9IeBnojpeK43adBD7YpYh
 GBEFcCO52IAhht0XHoP/3SzGivPNs8VqoSbjFj2rDbWeQjFAliBwn2eaK2Y8uTNqZO+mmxwlKum
 D5PEHkz3P7zuXSh3b8ncl1x0VaMavPBh8i91tIHhchldF9HXf6dfSh//owR9nMde9iwfLhKDLkO
 TGxPDw==
X-Received: by 2002:a17:907:2d8a:b0:b87:7485:b4a8 with SMTP id
 a640c23a62f3a-b9764b6b0f8mr656881566b.0.1773629061955; Sun, 15 Mar 2026
 19:44:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260315235353.304637-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260315235353.304637-1-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 15 Mar 2026 20:44:03 -0600
X-Gm-Features: AaiRm53Awv4vP05lsPPW7t8uOPtv_ENzl1FuYNMxuytZILXNNpZ1y8WMaBOuQYY
Message-ID: <CAFLszTgRms-_m+Ws9JN+KU3UpjF2A+R3zvr_O5SWybMS+Hi+aw@mail.gmail.com>
Subject: Re: [PATCH] console: Prefer currently selected serial console as
 stdio device
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Alexander Sverdlin <alexander.sverdlin@siemens.com>, 
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>
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

Hi Marek,

On Sun, 15 Mar 2026 at 17:53, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> Adjust the scan for default console stdio device to prefer the
> currently selected serial device. This is useful in combination
> with CONFIG_SERIAL_PROBE_ALL=y, in which case the system would
> instantiate all serial devices as stdio devices in the order in
> which they are listed in control DT. The currently selected serial
> device may not be the first device listed in DT, in which case the
> current console_init_r() implementation unexpectedly switches to
> another serial console after listing stderr using "Err:" line, and
> just before showing U-Boot shell, which is not the desired behavior.
>
> The scan runs twice. The first round looks up the current serial
> console device and tests whether it is suitable as a console. If
> yes, then the scanning ends, otherwise the second round starts.
> The second round of scanning simply picks up the first suitable
> console device.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> Cc: Andre Przywara <andre.przywara@arm.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>  common/console.c | 38 ++++++++++++++++++++++++++++----------
>  1 file changed, 28 insertions(+), 10 deletions(-)
>
> diff --git a/common/console.c b/common/console.c
> index 48586fd2166..3de53c66094 100644
> --- a/common/console.c
> +++ b/common/console.c
> @@ -1208,17 +1208,35 @@ int console_init_r(void)
>                         outputdev = console_search_dev (DEV_FLAGS_OUTPUT, "serial");
>         }
>
> -       /* Scan devices looking for input and output devices */
> -       list_for_each(pos, list) {
> -               dev = list_entry(pos, struct stdio_dev, list);
> -
> -               if ((dev->flags & DEV_FLAGS_INPUT) && (inputdev == NULL)) {
> -                       inputdev = dev;
> -               }
> -               if ((dev->flags & DEV_FLAGS_OUTPUT) && (outputdev == NULL)) {
> -                       outputdev = dev;
> +       /*
> +        * Scan devices looking for input and output devices.
> +        * The scan runs twice. The first round looks up the current
> +        * serial console device and tests whether it is suitable as
> +        * a console. If yes, then the scanning ends, otherwise the
> +        * second round starts. The second round of scanning simply
> +        * picks up the first suitable console device. This scanning
> +        * method allows retaining the currently selected serial
> +        * console, especially in case DM contains multiple suitable
> +        * serial consoles and the currently selected one is not the
> +        * first stdio device in the list.
> +        */
> +       for (i = 0; i < 1; i++) {

It looks like it only runs once? Is this the loop you are referring to?

> +               list_for_each(pos, list) {
> +                       dev = list_entry(pos, struct stdio_dev, list);
> +                       if (!i && dev->priv != gd->cur_serial_dev)
> +                               continue;
> +
> +                       if ((dev->flags & DEV_FLAGS_INPUT) && (inputdev == NULL)) {

!inputdev

> +                               inputdev = dev;
> +                       }
> +                       if ((dev->flags & DEV_FLAGS_OUTPUT) && (outputdev == NULL)) {
> +                               outputdev = dev;
> +                       }
> +                       if (inputdev && outputdev)
> +                               break;
>                 }
> -               if(inputdev && outputdev)
> +
> +               if (inputdev && outputdev)
>                         break;
>         }

I think you could have a function like is_suitable(), call it on
gd->cur_serial_dev and then go into the loop failing that. It might
give smaller code and avoid the extra loop.

>
> --
> 2.51.0
>

Regards,
Simon
