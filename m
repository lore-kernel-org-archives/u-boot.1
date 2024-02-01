Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3335C4828D
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 14:33:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E9F18789B;
	Thu,  1 Feb 2024 15:33:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=foundries.io header.i=@foundries.io header.b="Y7oto/aM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FECC878EE; Thu,  1 Feb 2024 15:33:09 +0100 (CET)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F08187527
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 15:33:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@foundries.io
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2cf206e4d56so12841751fa.3
 for <u-boot@lists.denx.de>; Thu, 01 Feb 2024 06:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1706797987; x=1707402787; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MBQh+/5XQtSffU6fpRd5fzUm/wRjrw1elDLhxvNKQ5Y=;
 b=Y7oto/aMLBkwVrL3bHL5nJdhr/SLG64C5crRT20YlYOAIEu0bS8NZskwqZu0GyD5Dx
 b1w2buMv0ryT2I7EqOeOiCMIcUi8/iCbgU9C81jCWdTBs1xvhvr5fqupLWvHVq2UjT05
 KWiGzOynDpIFCbtP0WSYtqdrUwCnXop/JeXTBVohBvFvJsEHojujF0TBU3XhylCm0SjT
 CZK7IhgAt+5hxtWMYbk83cKHnPZRbLe4yy2EnM3v5M70AK6G2MjBliB49Xe/t3ZdajmY
 jhfBT9wj4udlAHvztSzHNVGbKp+LRkMKBDPD+ruqz43AFtEgE/cESMUefG9eT8tWxLU/
 IKVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706797987; x=1707402787;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MBQh+/5XQtSffU6fpRd5fzUm/wRjrw1elDLhxvNKQ5Y=;
 b=BTbPtMOXktdRoHzjckzWbiTnKtU/tfHvjnprSbaChv0xfLd56GoMzVw/3kiQ9ULcZf
 3IlzBwZmVhlFNevHzeYElL8oKMPKjAfczp2+MpWxwDfGIsd3etzZoBJQcswkJtA9as4c
 Ax9/po478eNVZjJbNxrtMkioyFCTWXsRuUh6SGHUUxqXHTG1OzXvD6B6abffGPB0KzlY
 ECXuky3LoQ8A6BATY03J7xxLxTN5BBQATNuppS35gkkqnYx8olCkFhf9FlaDPZE89qfN
 Oc4Zp2xCv6YV8IIpQwsE4xwo9Ybug7vVt0DNISO0Epfu52uOJETatf7Bcl3ZxiySauY6
 68jQ==
X-Gm-Message-State: AOJu0YwblJvZu9wkmde1mmrtMxVGDOohbMUrS2ndN5PAGY0YjaRYsiDB
 YdWB0hALnCP3njbhtY2a2lL2WrkuG++Prqx5w37Dn4iyb8zdZWeP5rNdiMHJoqY1/IvAowGXPlf
 6FhTCCyNyyyR3Vob/hHbwcDt2K7Z+NVmUom3mSA==
X-Google-Smtp-Source: AGHT+IHFS6cr3wyhdfzNa0d4zFn53CvnsF7j6YQreyn/jymBf702Sc2SC1tUBsAE56LoGYbY72dDTDxAh37WfKnenck=
X-Received: by 2002:a05:651c:c96:b0:2cc:830f:69f8 with SMTP id
 bz22-20020a05651c0c9600b002cc830f69f8mr2159350ljb.11.1706797986587; Thu, 01
 Feb 2024 06:33:06 -0800 (PST)
MIME-Version: 1.0
References: <20240131141426.34926-1-o451686892@gmail.com>
 <20240131141426.34926-4-o451686892@gmail.com>
In-Reply-To: <20240131141426.34926-4-o451686892@gmail.com>
From: Igor Opaniuk <igor.opaniuk@foundries.io>
Date: Thu, 1 Feb 2024 15:32:55 +0100
Message-ID: <CAL6CDMFtvYNjAssFCzWkrkpRw3u_C_ZvMUm8U4P89mhp_1OkNQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] cmd: rng: Add rng list command
To: Weizhao Ouyang <o451686892@gmail.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Tom Rini <trini@konsulko.com>, Etienne Carriere <etienne.carriere@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, u-boot@lists.denx.de
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

Reviewed-by: Igor Opaniuk <igor.opaniuk@foundries.io>

On Wed, Jan 31, 2024 at 3:15=E2=80=AFPM Weizhao Ouyang <o451686892@gmail.co=
m> wrote:
>
> The 'rng list' command probes all RNG devices and list those devices
> that are successfully probed. Also update the help info.
>
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
> ---
>  cmd/rng.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/cmd/rng.c b/cmd/rng.c
> index 52f722c7af..b073a6c849 100644
> --- a/cmd/rng.c
> +++ b/cmd/rng.c
> @@ -19,6 +19,22 @@ static int do_rng(struct cmd_tbl *cmdtp, int flag, int=
 argc, char *const argv[])
>         struct udevice *dev;
>         int ret =3D CMD_RET_SUCCESS;
>
> +       if (argc =3D=3D 2 && !strcmp(argv[1], "list")) {
> +               int idx =3D 0;
> +
> +               uclass_foreach_dev_probe(UCLASS_RNG, dev) {
> +                       idx++;
> +                       printf("RNG #%d - %s\n", dev->seq_, dev->name);
> +               }
> +
> +               if (!idx) {
> +                       log_err("No RNG device\n");
> +                       return CMD_RET_FAILURE;
> +               }
> +
> +               return CMD_RET_SUCCESS;
> +       }
> +
>         switch (argc) {
>         case 1:
>                 devnum =3D 0;
> @@ -56,12 +72,9 @@ static int do_rng(struct cmd_tbl *cmdtp, int flag, int=
 argc, char *const argv[])
>         return ret;
>  }
>
> -U_BOOT_LONGHELP(rng,
> -       "[dev [n]]\n"
> -       "  - print n random bytes(max 64) read from dev\n");
> -
>  U_BOOT_CMD(
>         rng, 3, 0, do_rng,
>         "print bytes from the hardware random number generator",
> -       rng_help_text
> +       "list         - list all the probed rng devices\n"
> +       "rng [dev] [n]    - print n random bytes(max 64) read from dev\n"
>  );
> --
> 2.39.2
>


--=20
Best regards - Freundliche Gr=C3=BCsse - Meilleures salutations

Igor Opaniuk
Senior Software Engineer, Embedded & Security
E: igor.opaniuk@foundries.io
W: www.foundries.io
