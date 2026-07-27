Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 054D3C531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 11:30:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3917480D7C;
	Mon, 27 Jul 2026 11:30:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J16XspmnM3EO; Mon, 27 Jul 2026 11:30:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 30F3D80D3E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785151807;
	bh=WiscUSxaRmhOSIUneZY+wKeXRw4fvW7LYKk7PTsQj8o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q62bHB/uyFRsm46D92g0i/8af6iufiVf3QFcqxH/ppp5B71jnb959CLjSCzEMNM9j
	 C02QqTspoPNZy6Hi4VUG/JBJi9n9Hhx0qir9TPikiznfBIgLQ3OiDCyCMbKqjbmLX1
	 InLr0fFAXkRW/yeh16JcRx8JcWG+dwF4WCMalbQ7f4+uH3Pxuh5iyq7MWWg2uBSBzC
	 qaseqruw2l7YNGzsDKYITwVn944pqVmXreyzv5sO9TsBy3Cmr6D7oQ9kS3gOZL+aEg
	 HlCw7hbalpfjFOieUd+Vn4pUMMcok62yViyPAa0NZWzmV4twb+wwEbnZ5nAxCK66wy
	 7royScU3VCxvA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 30F3D80D3E;
	Mon, 27 Jul 2026 11:30:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 54EE1357
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 11:30:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 52500406F6
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 11:30:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RrGBPZQiNy4S for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 11:30:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b12f; helo=mail-yx1-xb12f.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 5DE5C406ED
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5DE5C406ED
Received: from mail-yx1-xb12f.google.com (mail-yx1-xb12f.google.com
 [IPv6:2607:f8b0:4864:20::b12f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5DE5C406ED
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 11:30:05 +0000 (UTC)
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-66899c7b57bso2723338d50.1
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 04:30:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785151804; cv=none;
 d=google.com; s=arc-20260327;
 b=PvP5LUxeBbLQSztv4GuJ+1bdc0bS0JXY6nfi7iizC8oBxY0bUQjULfBjJvIt6g8dQt
 k7dloRYDHOriGqfdLhLfeQrU4FrcEKnyeq9u3ORFhOTd+tsglb0vjTXWPV/D3fpEo3PO
 WkYQi75f7rJI6PpRBsU0/kne7G8XY6HdbooURbbJKPU6UlWqaXCm9V00GpMjTxarPSSy
 F3n6IJuVucgR0nItnf63j6Ht5mb7O6Pb2oVh72gbrfHEegyrCttdXDYprLoHNAyrLB8U
 hdSHS8T2233EvR0Jxaku3lE4OsJmAMs1iaE30Y2TsLdfTHEDiOLX0vP58mjozflua+Hz
 q+aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=WiscUSxaRmhOSIUneZY+wKeXRw4fvW7LYKk7PTsQj8o=;
 fh=7vevgLnTBO4tKOPXf9f+BP46lhSNasABu94JehI9XS8=;
 b=GVBmZjn5t8uF98X/kiDryrYuJFKY9sBWZVWsWdOUQ1oVIbh6i7aEJb9S7hrCRLT02A
 SF6O8pT8vr55qrBTvZ/n78SWJd351BBbzMtfe2LIpGbcVn3LftTTiEoag+iZuPI57M8g
 tnDh2fQgIIsLEYnAQoaoOI8RyOeq1nL5Lh7ujQ+/khq1uM2U0etUZg9pzko22JkuaU9Y
 d92osRjmzynewPHA+SSU+YLzXPysJEVixlNSuHmw82Jo2I6zQDeu1E9avkXUTP3U9YsX
 aaYb6/wCLNclHhasWxNfrJAVId4UjD9NNri4vrFtdd2xtLxxmzQCD5TFfJweqySwSeZW
 g8JQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785151804; x=1785756604;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WiscUSxaRmhOSIUneZY+wKeXRw4fvW7LYKk7PTsQj8o=;
 b=p+G4326umOVmb2ZXBaw5W5Hz9t9ZaNUnnkYXnUgb+Ab7uruIBf+bbxUj45G7XbqVGW
 xUDAPoQsWV8WXd23F2tnuHauypaGO7XP+xim/NEjGocXc2bprFewwzHxIoLUpn3xB90v
 lgGhMB/SkAvCreJV4lkIrRj/y+M4KsI5/nRAwztcY9yh65YZv+1ryb+MwhdxlH/7jWjN
 v0qX66xubP9Ld11vlbGVyTI4OEgagPXBylEUlGls/0tWe2tpvqdxvQrKV1ESWyDERp+m
 3JC125znqvEIPSu5RM3bWTUgb+sJfoenm8dWQsNLCUOu99gFUr7uneOvr0ezuN7ir+l7
 VFBw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqTTixx08M697dGu/qly/cmMEGLiHAbh+++XPHajsTHj665i+O/twj4rQB1aexxArlyYwchB1E=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwpXtJZF/tWSZKqKEDj/cLiLaHW6HHXJi1ZadfIsLfWw/FMgq0p
 zRkcsQWtSmDn7Z/2tcjC9pofQUGOmb582T+3K6afaIrBMPgvixM4P4gRIHFKD7x9kgX8bYdkTNB
 TuFntgggpnVseIFd+2eBosdp5B3k0S6FhYza9iyJM0g==
X-Gm-Gg: AR+sD13pBL2UJgncxLYNOz3JvYM1WxwwLpgFjeH1ONhND72V1IPF8HZrSkbweY7zlii
 KFYKr5FiumjsOGsthq8hxXm7oOFNxYpiMySeJZxOA9shbQqxMStSxMziTVrQXCjJuwGiR0d8qGa
 jDrLvO2jNeuAkCAqfGgPfbCqflHDorixLPVsOx7JYkVPQ7W2COrvnhBXBkoeQbbxhQ/UZW0faQK
 DDq/YE6Xpo5TuM9bxo+JN8o32ZQJg56+v0CLBvhJCSkMhvmt1kz3hyNN4nU8aZVOK0BjoQt/H2t
 QxCexgNixaqU+eL0LTkBQbb2XYU/MCC0HgjafxwH4n3vT73EIX6Q1yWVQFzNL7PXknXHzcnGWKL
 h7zbjZ1PZZ5UheTTa/KIX2pi1GdUh4oG0tw4gpI2GYm/cRIclKUwRlNNvEC0t8ssqQrWee/F5a3
 4EqtDiE5NMafklGZJ6MnXUNVwgynVhx4IK0adgmghpjMk/t2MoIpH3oZL705IW5OovWzIzuJXb+
 Ut+docyjPSX21iZ/P0/Sabmjx9PTnJxwQBvq70dq7tCfNw2uDJSCgoUj2afOUbHiae3q9BP2nNQ
 zap+T+thpyNVqbyQRn6L+sdLKhKgLLWBu25aBOL0rPM82RRLEcNmwHoKsJmD
X-Received: by 2002:a05:690e:e8e:b0:664:c560:996f with SMTP id
 956f58d0204a3-668fae990b2mr89940d50.59.1785151803728; Mon, 27 Jul 2026
 04:30:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260727110336.71692-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260727110336.71692-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 27 Jul 2026 14:29:27 +0300
X-Gm-Features: AUfX_mx4TJditLm2ANMtiofCs-L5MTVnRXWndSNNu-oB9eIxG7DTMSHVlIhQmZY
Message-ID: <CAC_iWj+FgW-iqSLYH8vsdgeEis+Pc_EjKnnU3pMEdPbpgOjSbQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] efi_loader: check efi_deserialize_load_option() in
 get_dp_device()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Peng Fan <peng.fan@nxp.com>, Hem Parekh <hemparekh1596@gmail.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785151804; x=1785756604;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WiscUSxaRmhOSIUneZY+wKeXRw4fvW7LYKk7PTsQj8o=;
 b=wcDKezCbdhCkbxhmyJ3ZNcCa8I0e4tPrViLV9QYBzUu0N/2CSUorIfYldN/NfXcpsO
 2abp42JoFCyw8KZQ7jNGGH2srUihCwv2l89pY3h2zIycTMcuDxavWT0kWklInN2PhqAS
 3g3O1TEjyRm/jdnmdjGKH1EVMy9BtIVzZCBm1Vs0xsaGiiJxFOH90LsZw8dirgh/AdIq
 F2C2SpxJVyGHK0tk3vIqZqqpiNX/jTrgFq52cScR20qAz3sFVfy2iKmi9xbAbBXpI6Xp
 eRegjArMcZOl8IH1wEkCvROnZBosikuPti6jqTUcgHWEYJ7CZI6kDnHK0dmTP8Lj4F91
 r7yQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=wcDKezCb
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Heinrich

On Mon, 27 Jul 2026 at 14:03, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> From Hem Parekh <hemparekh1596@gmail.com>

This needs a :

>
> get_dp_device() reads a Boot#### variable and passes its contents to
> efi_deserialize_load_option() but ignores the return value. On failure
> efi_deserialize_load_option() may return without having initialised the
> caller's struct efi_load_option, and even on a malformed device path it
> sets lo.file_path before validating it with efi_dp_check_length().
>
> As a result get_dp_device() can proceed to walk lo.file_path with
> efi_dp_split_file_path() (via efi_dp_dup()/efi_dp_size()) on a device
> path that was never validated, or on an uninitialised pointer when the
> variable is too short to be parsed. A device-path node with a length of
> zero makes the walk loop forever, and a length below the 4-byte node
> header leads to an out-of-bounds read. The Boot#### variable is
> attacker-controlled in threat models where writing EFI variables does
> not imply the ability to execute firmware code, so this is reachable
> during capsule-on-disk processing at boot.
>
> Check the return value and bail out, as every other caller of
> efi_deserialize_load_option() already does.
>
> Suggested-by: Hem Parekh <hemparekh1596@gmail.com>

And you probably dont need this if you want to keep Hem as the author

> Cc: Hem Parekh <hemparekh1596@gmail.com>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         Use common exit out:
>         Remove invalid Signed-off-by: Hem Parekh <your.real@email.com>
>         Changed error message: remove word 'for'
> ---
>  lib/efi_loader/efi_capsule.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
> index 52887f7c274..a77810fa15c 100644
> --- a/lib/efi_loader/efi_capsule.c
> +++ b/lib/efi_loader/efi_capsule.c
> @@ -860,7 +860,11 @@ static efi_status_t get_dp_device(u16 *boot_var,
>         if (!buf)
>                 return EFI_NOT_FOUND;
>
> -       efi_deserialize_load_option(&lo, buf, &size);
> +       ret =3D efi_deserialize_load_option(&lo, buf, &size);
> +       if (ret !=3D EFI_SUCCESS) {
> +               log_err("Invalid load option %ls\n", boot_var);
> +               goto out;

efi_deserialize_load_option() will only return EFI_INVALID_PARAMETER.
For the capsule update on disk this seems correct as the EFI spec says
"Invalid capsule size, or an incompatible set of flags were set in the
capsule header. In the case of a capsule file, the file size was not
valid or an error was detected in the internal structure of the file."
We just have to make sure that we either explicitly set it or
efi_deserialize_load_option() doesn't return something invalid in the
future

In any case
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>


                                                                  =E2=94=82

> +       }
>
>         if (lo.attributes & LOAD_OPTION_ACTIVE) {
>                 efi_dp_split_file_path(lo.file_path, device_dp, &file_dp)=
;
> @@ -871,6 +875,7 @@ static efi_status_t get_dp_device(u16 *boot_var,
>                 ret =3D EFI_NOT_FOUND;
>         }
>
> +out:
>         free(buf);
>
>         return ret;
> --
> 2.53.0
>
