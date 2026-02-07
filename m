Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02921EE6B76
	for <u-boot@archiver.kernel.org>; Sat,  7 Feb 2026 06:59:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C22183A64;
	Sat,  7 Feb 2026 07:59:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="d8oLpZwD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD11283AA7; Sat,  7 Feb 2026 07:59:12 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 900FD83693
 for <u-boot@lists.denx.de>; Sat,  7 Feb 2026 07:59:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-79088484065so26645817b3.1
 for <u-boot@lists.denx.de>; Fri, 06 Feb 2026 22:59:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770447547; cv=none;
 d=google.com; s=arc-20240605;
 b=L5flkwsKlfL3JbHh0cFzwlLy+F3cn+vAGTkXi5vZOdiKUT02BJiF1FBvBiizAAh4Jw
 0yKOlaCckcUb9uuAe4PYZWSL0FKDfUGxEEo/3uz9NnLZdOrURNLNopmbUtaxp5VoXQ2Y
 sBnziz3uds3hm9964rqcVsTa+ys1zZW7E80JCtlobZq6EwjQ0SWqYNSEdYrXLwhUCMVp
 xjolpquSHmbmaKpcLkb4RKUpoeACZMUTsD38O4E5WKGfDVfk9Gp9aiehm2LB6+iJVdxU
 mrY0rpIY8mUcDMQvQ/f2sSEMYXafZFOZJVYFabt0oAYcSFHIIrQonFxmZVLqMGXFUPkq
 74QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ulkTfc/7umdiY1DKbubXCAb7E3qdq6VgUCXWKRm+Ldo=;
 fh=oipBDXmSotTkcMeOoKry5uJ4L2vfLs8mlhqXSypuxQg=;
 b=lp+AQJBbreeRR3o/7OGLOtemkT6E6D2NjDhTG3uEQcSCGTF8SXj6TZvV5jaWyRaYfc
 MtQsqIIdCI3D+6cw3a2Az6Ae86kvOlKwIkaMfMrSQLi5+44DfjDPttG7lw7hHwM1Xd/B
 7TjpnE4nUlHl0u7PD0AuUqu7n6rIrx6+LFx9ZkoMl036jlYtw6Pa24vwIpvFjeVyDGw7
 iS2JUNIaHKX88sKmwBelgeaLay2EN8YXlnmid3m8FFAxeQlos4UwIPaUsaUqzVr/Nn8A
 Lhbd32Civ62lbWgWnltCDn2iy6R35iSRknvFb2AjA0tk+Og1bjdbzHrQIXsS/br2NCTG
 X3hQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770447547; x=1771052347; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ulkTfc/7umdiY1DKbubXCAb7E3qdq6VgUCXWKRm+Ldo=;
 b=d8oLpZwDJxuSnHcylna7giSTHGNc29jhphhrXqT1KNKxNyav0rPguxgF0yAxhteGFt
 vDlFp7Klxyr2744D2ya0ioi/ig+74Q10AYLbnpc8joRrGIXyXTfEeCSTHd20a9YOOEre
 E/LQ4Zm/V/6A3O5W/8xxiKxY5gtnXrvoiS70Q0sRAY3XX/VXBY4HIb+SgUROxUDWZSjI
 4f4mx1z5eepaqCThq0gcfCBY9oPXXZ2Er6e3DT+Dwql+XXK18UVBObqzNFRfCdQSxucS
 6UoPBB51897Im+cjiQB5v4Ojxa/HatZbLBjAmZLZGe3IlVk+L8xcadqjl4CR9orrpnRn
 QwUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770447547; x=1771052347;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ulkTfc/7umdiY1DKbubXCAb7E3qdq6VgUCXWKRm+Ldo=;
 b=BwCPYNFy0tMu9herCX0Jd86DdthPoVUt4PgAcLfk/Qu9YgitCoUW3QTlTzJ+z3xsC8
 Pw2mzml/jRM1EvFkg93eiw+jkvGsjyjYwLm2sWztqON+iVEFqYsb0H8zawPsU6uKT3ob
 gbAixjvsv3OPSM3LsNOPD26yJa4cB0dj+k0sD5kqqBUznElk1lAvdxGc49sTtfEq9toP
 7A4cfeQF1X9demTMuOUH9lF1+QS5kypnrd6Vw2lunV74NUxhkditse32+LTRwrcodl9L
 9G1zkrh6cL9OeacfxzPQQZ9b9mDHpzKfnMinZXTORRGBzMI6IMCHI0r+APGspgg9BMTC
 eH2g==
X-Gm-Message-State: AOJu0Yya1yd0Uw7bMtWYrsaJoa2gQ9WCIGsSCwoOLlNp0py8s1gdiRCj
 R3mHKvx2WG+8gtwn8V1BqdhYYSdc/1sCdObTMucThjxAq2m4b2EWR+Vslvbo0Mu7l7rZ4Th9X9c
 P7j/A6Jp/m+Rnec2BtAacDO8JJZP+0U/lqa1Kh/CtEQ==
X-Gm-Gg: AZuq6aI8FPDkFWCCTgLQWFLz6fSbFheO7LeA1CIbvkQgcMYN2Sn8MPKtoFWGlI7up37
 RSeBang/mfoRQy7Iek0oT8dCzFnwMP/SarOOuG459aSTY4NDAuVUWHJ35xRj5iYmbPe0jMo+iWQ
 hAHBLJjGA9zxEOmFsi1a70DxJK8H6GyA6T+3bU52DRzf6PKJdOkDeZdVGYtp99D95EIHJx1vRpq
 rCva+cXYzhQ+R9p/dAykEe+thxzs6Cn/+Jm7BfL/2FMsEebMGE8wZzbtldQT6gHwCDY2Bv9ZzlH
 Zo6y8Et5pbvtGEKLx3UMvnL/gyvNFg0gDJXXG69zcEEdit6FjpEeNFDxbuSEja4VtCgmDJ+gxHX
 +3FfI+AXFbIrFBvXn8lzvtoP14sDLGpTRkvFrPxrw30S2zLfqbPAj69YSZT0F2KLUtqYgGaYRlP
 OoLO5aUMiv4lefkJC7lNsugOQH3hiD+Cnxr3JBLC+jedSWHsJn8tUHTBnla8Gov39V2wLcw7lqx
 VTskdG7OdvTurNJ/8lwuETVv4JHl6Vj1rI2VU4i0r1oE8cGpfV5/F9Hq5UX9C2gCzHGDuqBugYy
 12Iw7VVW74Qju8/sFaIaLU7s954YZViL+Q==
X-Received: by 2002:a05:690c:498f:b0:796:3124:6565 with SMTP id
 00721157ae682-796312469e8mr15401907b3.1.1770447547240; Fri, 06 Feb 2026
 22:59:07 -0800 (PST)
MIME-Version: 1.0
References: <20260202113717.2696718-1-pranav.vinaytilak@amd.com>
In-Reply-To: <20260202113717.2696718-1-pranav.vinaytilak@amd.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sat, 7 Feb 2026 08:58:31 +0200
X-Gm-Features: AZwV_Qgzx0Cmg0Nax3z_cOxyBHxoCiZ6dq732jRkdpX2zBXc6X16SVCbYzKxcPU
Message-ID: <CAC_iWjKUht2V-mPwvvFRVewKYyyxt5noYpBA+icYATfRKFMF0Q@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: Improve EFI variable load message
To: Pranav Tilak <pranav.vinaytilak@amd.com>
Cc: u-boot@lists.denx.de, git@amd.com, michal.simek@amd.com, 
 Padmarao.Begari@amd.com
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

On Mon, 2 Feb 2026 at 13:37, Pranav Tilak <pranav.vinaytilak@amd.com> wrote:
>
> Change the EFI variable load message from log_err() to log_info() with
> neutral wording. The previous "Failed to load" message caused customer
> confusion as it appeared to indicate an error condition.
>
> The efi_var_from_file() function deliberately returns EFI_SUCCESS in
> this case to allow the boot process to continue normally. This is
> documented in the function's comment block but was not reflected in
> the log message level or content.
>
> The message now uses informational wording to reflect that this is
> normal behavior when the ubootefi.var file does not yet exist.
>
> Signed-off-by: Pranav Tilak <pranav.vinaytilak@amd.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  lib/efi_loader/efi_var_file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/efi_var_file.c b/lib/efi_loader/efi_var_file.c
> index ba0bf33ffbd..f23a964a418 100644
> --- a/lib/efi_loader/efi_var_file.c
> +++ b/lib/efi_loader/efi_var_file.c
> @@ -173,7 +173,7 @@ efi_status_t efi_var_from_file(void)
>         r = fs_read(EFI_VAR_FILE_NAME, map_to_sysmem(buf), 0, EFI_VAR_BUF_SIZE,
>                     &len);
>         if (r || len < sizeof(struct efi_var_file)) {
> -               log_err("Failed to load EFI variables\n");
> +               log_info("No EFI variables loaded\n");
>                 goto error;
>         }
>         if (buf->length != len || efi_var_restore(buf, false) != EFI_SUCCESS)
> --
> 2.34.1
>
