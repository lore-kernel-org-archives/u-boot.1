Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F7B8C5321E
	for <u-boot@archiver.kernel.org>; Sun, 25 Aug 2024 18:36:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBDAB880E6;
	Sun, 25 Aug 2024 20:36:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T4myBlpp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58ECA881A1; Sun, 25 Aug 2024 20:36:22 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F5AE87E9D
 for <u-boot@lists.denx.de>; Sun, 25 Aug 2024 20:36:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-533461323cdso4056823e87.2
 for <u-boot@lists.denx.de>; Sun, 25 Aug 2024 11:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724610980; x=1725215780; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w0Ftc+qH7rF/9aJdlvRWR7wjXNUpT8qWpf2hZ1IwZzU=;
 b=T4myBlppB9C+xk+qta0ne5dfmAOwNbWWFLFXCnqKv4D3WSra2U7PbZGZrtxbMTygIZ
 n3rad4/igB706enrjwNOZfAutnFARaXQn3Tp1AGL2i/NtVXkDgBbhGo/ORJHERmBWoF2
 3On8huIugjv2fRUIZHmmFf7gv9dZ/fb6ac0py7vyAVXypi+NyRzhbVgZvgedgGmAgg3z
 W7leoQYYr1xg/QOBjz2RI8bBysbJF4upDd6HIKGRt2YxOce/GbAiHA2VMAa7lP97dlHi
 +vCaHy60V1IWJZWlKQo1KXbkHrReXKH7cTs4sUZaqVnK/0FiKyOiwu7ek0aDJIeI4oQy
 Rfaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724610980; x=1725215780;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w0Ftc+qH7rF/9aJdlvRWR7wjXNUpT8qWpf2hZ1IwZzU=;
 b=MmkpXQlw42hTOAccuS7D66AR/89PjcIfo2s3wpNzK+PNPF7Sg7EDC1BKCs9xKJtUoj
 /12+eJ63jervoY7HMVsnmUZJOF+88xwZDVfIUHKwjja0CFBB5C0wp6w/MoE5csioHM98
 M6XPdfSt6D391plkqoP0vvWwkLGIocjBlFzhsYYiduZpYXdlJTB3a2M4tFSjQhjUuQ/1
 mXLxHnvKBvAUP/I5N+SEaLQ5CCUx1n26IJgOKmwSip6N6RxLQCQU1AHfiZZdI5i8wR7b
 lZlSzDOViFJT5qkH0BQbsimmrCx0fwsIyYLO7n4K2C7TTfHorDAlgMabkeSDaHYETIS/
 dTxg==
X-Gm-Message-State: AOJu0YxRGCVO6PM/di4VhEZ/p/ZWw0p1VEJlbBRpkl2hsn2zI9cPAEMs
 Qj4+xOtxx9OTbwwYlRdFccYQOCL9w5uBsE4XOO1vCVS/LeMJP42cOOc6aa9XPyPtb2QldidVs0N
 Vu7LS8GaxImc8r2/DxTdx20I5DUU=
X-Google-Smtp-Source: AGHT+IG4weghK1jmwMDcFr6iyRrSwbtAMjQWXQWCeCeM6m+QB/1uNe1eJOsy7sAZupQJKJ8ypS2chRNbHktQO02ahQ8=
X-Received: by 2002:a05:6512:3d92:b0:533:aa6:767b with SMTP id
 2adb3069b0e04-5343882db8dmr4951263e87.10.1724610979316; Sun, 25 Aug 2024
 11:36:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240825122617.3708982-1-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20240825122617.3708982-1-dario.binacchi@amarulasolutions.com>
From: E Shattow <lucent@gmail.com>
Date: Sun, 25 Aug 2024 11:36:08 -0700
Message-ID: <CANV2PTN_+9rZu0=XrNE+AUO3YRPCUjSHZy-Oe8WcXb_M-MiVTw@mail.gmail.com>
Subject: Re: [PATCH 1/2] bootm: adjust the print format
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: u-boot@lists.denx.de, linux-amarula@amarulasolutions.com, 
 Eddie James <eajames@linux.ibm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
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

On Sun, Aug 25, 2024 at 5:26=E2=80=AFAM Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:
>
> All three addresses printed are in hexadecimal format, but only the
> first two have the "0x" prefix. The patch aligns the format of the
> "end" address with the other two by adding the "0x" prefix.
>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
>
>  boot/bootm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/boot/bootm.c b/boot/bootm.c
> index 480f8e6a0e6e..951e549f19ff 100644
> --- a/boot/bootm.c
> +++ b/boot/bootm.c
> @@ -703,7 +703,7 @@ static int bootm_load_os(struct bootm_headers *images=
, int boot_progress)
>
>                 /* Handle BOOTM_STATE_LOADOS */
>                 if (relocated_addr !=3D load) {
> -                       printf("Moving Image from 0x%lx to 0x%lx, end=3D%=
lx\n",
> +                       printf("Moving Image from 0x%lx to 0x%lx, end=3D0=
x%lx\n",
>                                load, relocated_addr,
>                                relocated_addr + image_size);
>                         memmove((void *)relocated_addr, load_buf, image_s=
ize);
> --
> 2.43.0
>

From U-Boot documentation, alpha-numeric input is assumed to be
hexadecimal except when it is not, and generally does not accept "0x"
prefix on input. So the correct action would be to make this
consistent over the whole U-Boot code base, or remove the "0x"
prefixes (not add more of them) ?

-E
