Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CB87CD13DF
	for <u-boot@archiver.kernel.org>; Sat, 31 Aug 2024 22:23:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F3898855C;
	Sun,  1 Sep 2024 00:23:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="civ3e3l9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CF868861D; Sun,  1 Sep 2024 00:22:59 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2617C884DB
 for <u-boot@lists.denx.de>; Sun,  1 Sep 2024 00:22:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-534366c1aa2so3121135e87.1
 for <u-boot@lists.denx.de>; Sat, 31 Aug 2024 15:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725142976; x=1725747776; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V/RWF7ikXbs96YBOkw8Gcj69RLTzWSJ5IZdIlYojOv4=;
 b=civ3e3l9+FMUSMTR+xvJlOFkkbxvmkJvIfSKNvROcEBGXPU0MXS0EEC+ovyUujTCJ1
 61zW80BvrzBBVmChVtjCK/EwzQxF8vAXLnq1+cr75p1aP/vkNk1nDE67vwiFaS+JnraZ
 fFStosgJz9FeqvG6bAK5+e7R2NOXFPLlBN3WNNBbkFt/g14yJ/rYgOcEm3XQIeeLCiCA
 AUR72Wqmck1mdYHvipTuU8QESabv/s1E1GxFq1UNefEPTy54y1UOtn7FIktniFtZNk+F
 /xj++AFiIcGB42yGaEiPyJOsAUE5WEHV09YN3PO0SLu7YfdJqTteYyo0lOyModfA6JkS
 Nn1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725142976; x=1725747776;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V/RWF7ikXbs96YBOkw8Gcj69RLTzWSJ5IZdIlYojOv4=;
 b=Wx2rndZKANS46sYKXYKVMty6OJKIG0Vc+GQM8VYCI+RC+IGAxMkLlQSzBl8zM3AO1c
 N8kw+5U6X17qtrQ4QMGh7dSYfjXWvwhyo1u7sF+HxVR8/e64h4gaE3WYo6VC09WiPz1u
 SH3oiKpHY3cfs+HhvVJL3jnIk0pfcBEm8iafkjeCxq5xiPKZHXlsMe4B+jhfyMjV5AxX
 CmB8IAvfxrU+ZTBp6bq3C7sIHEaCcC9GiwNSmTTqDe6xY6Lhg/AD/uY+J4nBUkkMnINN
 Ew8LJKWd7o5tURHtApOJv6qq6iGEiWDjgXAm2rQtob9AS7zKY2wnO1AUeJdZpXnDSWTO
 mZlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSrskKfRzyIQFaYm+p6A60BaUOAWbIKau0K+6/rA+jVry/jumnR+kYcoVI6QnGa6Kt5dwMYB8=@lists.denx.de
X-Gm-Message-State: AOJu0YzsTXWbmDNjMzOviYM0EPcKsTzkUtWI4eVMhXwgQaEHDkLrveFQ
 Ra8XVNOiqtXdZLjj11hvOf4TjShX5cvtfdUHM1jnLlnSjGsSGqZnYHVasc2BtmV8NjoLWNDaGqo
 LlknSy0IMZfsiB7f9KEFWEJSk1s4=
X-Google-Smtp-Source: AGHT+IHY6A/pTOiLG7ACd8tRF1nsw5p4Fu/U0EnH/KTzsrEpRmA1SCSEPdx6TvUVpXCYgqlYTKbaAcLks2zwJQ7pyZA=
X-Received: by 2002:a05:6512:1151:b0:52e:f77b:bb58 with SMTP id
 2adb3069b0e04-53546b418a9mr3349782e87.36.1725142975988; Sat, 31 Aug 2024
 15:22:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240831164639.2298097-1-caleb.connolly@linaro.org>
In-Reply-To: <20240831164639.2298097-1-caleb.connolly@linaro.org>
From: E Shattow <lucent@gmail.com>
Date: Sat, 31 Aug 2024 15:22:44 -0700
Message-ID: <CANV2PTM+wevfK7w15j-=a2oakPMMXpTdr7ntzBfkc3jbbv+veg@mail.gmail.com>
Subject: Re: [PATCH] cmd: fdt: use U-Boot's FDT by default
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Caleb, the problem here is hidden conditional behavior.

On Sat, Aug 31, 2024 at 9:56=E2=80=AFAM Caleb Connolly
<caleb.connolly@linaro.org> wrote:
>
> When using the FDT command to inspect an arbitrary FDT in memory, it
> will always be necessary to explicitly set the FDT address. However it
> is also quite likely that the command is being used to inspect U-Boot's
> own FDT. Simplify that common workflow of running "fdt addr -c" to get
> the control address and set it by just making $fdtcontroladdr the
> default FDT if there isn't one.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  cmd/fdt.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/cmd/fdt.c b/cmd/fdt.c
> index d16b141ce32d..8909706e2483 100644
> --- a/cmd/fdt.c
> +++ b/cmd/fdt.c
> @@ -276,8 +276,17 @@ static int do_fdt(struct cmd_tbl *cmdtp, int flag, i=
nt argc, char *const argv[])
>
>                 return CMD_RET_SUCCESS;
>         }
>
> +       /* Try using U-Boot's FDT by default */
> +       if (!working_fdt) {
> +               struct fdt_header *addr;
> +
> +               addr =3D (void *)env_get_hex("fdtcontroladdr", 0);
> +               if (addr && fdt_check_header(&addr))
> +                       set_working_fdt_addr((phys_addr_t)addr);
> +       }
> +
>         if (!working_fdt) {
>                 puts("No FDT memory address configured. Please configure\=
n"
>                      "the FDT address via \"fdt addr <address>\" command.=
\n"
>                      "Aborting!\n");
> --
> 2.46.0
>

The use of `fdt` command in the default action might be depended on by
some userspace script as a success/fail result. I don't imagine what
that might possibly be, just that the logic of scripts in u-boot
depend on that pattern of use.

Secondly there would need to be a warning to the user that some hidden
conditional action is being applied? i.e. "No valid FDT address is
configured to $fdt_addr_r or $fdt_addr so now configuring to use
$fdtcontroladdr instead." or however you would phrase that.

Otherwise I agree improvement to the fdt is welcome and my memory of
first using this command is that it has not-sensible defaults but I
then assumed it was designed this way because of possible use in
U-Boot scripts.

-E
