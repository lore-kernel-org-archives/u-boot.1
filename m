Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C3CCF34AB
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 13:17:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43DF483F66;
	Wed, 19 Nov 2025 14:17:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="B8KEUVG6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D300783F6C; Wed, 19 Nov 2025 14:17:42 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE19983956
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 14:17:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b736cd741c1so842479166b.0
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 05:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1763558260; x=1764163060; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=N7YaklTWbIzMYEMZBgJGipmRaAup0xlDt8CRazw5r2Q=;
 b=B8KEUVG6ZxS7GXvLt6xwUoE1r+Vo5pPxw9ZvpmwmNQpHQSRt6eV5ruOgY/3laOKWP/
 li1hV5YMpZNM9Qw2PWjMrvd8k/7q2bOYt99KIeKcRqBu1s1l7hTE41AppcuhneOW9Z+j
 IQMdpIduMFt/j5eRrUXZzS0EiTM4k8ORJBb9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763558260; x=1764163060;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N7YaklTWbIzMYEMZBgJGipmRaAup0xlDt8CRazw5r2Q=;
 b=CYUexJZKgKH3ANfLUm6x3JIMzCDb2NmBONaJS+2ANDX/f6av66GyWjPdnJRIeCyo9F
 s5ow5+86wAW6v93do1wGr2eDUpmArYKYJI0igysEbGivSE9iTwwRibOQSSUnigQpFv43
 Qma1lVMN5Uhr8RYPcwnFC2dO5r/AbQbCr4Qr04oX5d/AIvcXZMrBzMC0tAVaRuJFGptd
 1qnclWXiBD85PAKTkmZulR1At6Ea+9Fji4ZX9Ph5wa3wjglf6QT2+87MTLBWE08ib9M9
 ON81Vb+RHX/JreO/ntwMckdNZsSCxKAtGT49e/bF2Z7JCvYSJCAN2ixNtryYYMga3hOc
 jBEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXr3O2rKtTQp+tmZsjiF4guq002+MSdKJcSrT5sj0ckk/l0znUX3Zrm+O4ERXo9jFbRQjmzycY=@lists.denx.de
X-Gm-Message-State: AOJu0Yy3TeTYYn6ygGXCyQKyBNPl22RM7go2tB0jNAHuZ4pB6+Lvt0C1
 8Z3PRdgG3CImDSfb6a8PWo3TGjCE99WF9OyDEmJMavmDmpuEuMbtb0F6Uwt0j+IedLiCVJKmWLG
 JxHXRY4/99BIiF4c1/G2d2RwVoek+Ankt9Jmw8s+Y
X-Gm-Gg: ASbGncvxVw8qEo4+ba8m0U+LDCw7nviya1ULU+jfqhF2oSSCqhT36fMW1G/TFDv05O8
 Zr8U7WmUMOHmCRKkqqWDGUaUM0rV4ZKnPp1WplAPG7VJtji6TNyMN/MSLU2GfDTXshPTFAKTw48
 o+2qR2k7L/+Au7DuQCw6MmzEM+7f7E8N3Tltcbns5lV0iJrpgue9SgtVgH17513II5h/gDCwerx
 Jcarj4T+V51AQFcgc4LAdvI8xnU6MKLvhFODXgcxaFnR0qfIjJ8rApnLrOHxI6CNKMTX0U0s7zL
 inw8Fn0MgNsD3UQ=
X-Google-Smtp-Source: AGHT+IEXlr6CUiSOpXD/tG1Rdf7sPXloTcnIj7jjy2Eli542ZicJcEUpKloioygwDACqf1GLnGQF3mzZaLKGbxc3TlA=
X-Received: by 2002:a17:906:6a18:b0:b76:339d:63ed with SMTP id
 a640c23a62f3a-b7637a05cedmr264119466b.52.1763558260026; Wed, 19 Nov 2025
 05:17:40 -0800 (PST)
MIME-Version: 1.0
References: <20251114-bootconfig-v3-0-a28b813dba90@baylibre.com>
 <20251114-bootconfig-v3-4-a28b813dba90@baylibre.com>
In-Reply-To: <20251114-bootconfig-v3-4-a28b813dba90@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 19 Nov 2025 06:17:28 -0700
X-Gm-Features: AWmQ_bm2uhS7YyPZ6W3fJu4qXTA_d5j5_7fDH_IZE4J0yQ79LybbJtV8b1v4nN0
Message-ID: <CAFLszTh9OMr9mskSXZ=kN5HFz8KHa+eGxqHwRwzdOS8EkFUFsg@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] cmd: abootimg: Add 'get ramdisk' command
To: "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de, 
 Nicolas Belin <nbelin@baylibre.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Aaron Kling <webgeek1234@gmail.com>, 
 George Chan <gchan9527@gmail.com>, Sam Day <me@samcday.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Maxime Fournier <mfournier@baylibre.com>, 
 Eddie Kovsky <ekovsky@redhat.com>
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

Hi Guillaume,

On Fri, 14 Nov 2025 at 08:28, Guillaume La Roque (TI.com)
<glaroque@baylibre.com> wrote:
>
> Add support for retrieving ramdisk address and size from Android boot
> images. This command allows users to extract the ramdisk information
> for boot image v3+ which combines vendor ramdisk, boot ramdisk and
> bootconfig sections.
>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Signed-off-by: Guillaume La Roque (TI.com) <glaroque@baylibre.com>
> ---
>  cmd/abootimg.c | 35 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

> diff --git a/cmd/abootimg.c b/cmd/abootimg.c
> index 6fb52153786..2a8e2c20941 100644
> --- a/cmd/abootimg.c
> +++ b/cmd/abootimg.c
> @@ -230,6 +230,33 @@ static int do_abootimg_addr(struct cmd_tbl *cmdtp, int flag, int argc,
>         return CMD_RET_SUCCESS;
>  }
>
> +static int abootimg_get_ramdisk(int argc, char *const argv[])
> +{
> +       ulong rd_data, rd_len;
> +
> +       if (argc > 2)
> +               return CMD_RET_USAGE;
> +
> +       /*
> +        * Call android_image_get_ramdisk with UNMAPPED addresses
> +        * The function will do its own mapping internally as needed
> +        */
> +       if (android_image_get_ramdisk((void *)abootimg_addr(),
> +                                     (void *)get_avendor_bootimg_addr(),

Casting an address to a pointer seems strange. Probably at some point
the API should be updated to have an address.

You can use nomap_sysmem() but that is more for things like ACPI
tables which embed addresses, so in this case I think an address would
be better.

> +                                     &rd_data, &rd_len))
> +               return CMD_RET_FAILURE;
> +
> +       if (argc == 0) {
> +               printf("%lx\n", rd_data);
> +       } else {
> +               env_set_hex(argv[0], rd_data);
> +               if (argc == 2)
> +                       env_set_hex(argv[1], rd_len);
> +       }
> +
> +       return CMD_RET_SUCCESS;
> +}
> +
>  static int do_abootimg_get(struct cmd_tbl *cmdtp, int flag, int argc,
>                            char *const argv[])
>  {
> @@ -249,6 +276,8 @@ static int do_abootimg_get(struct cmd_tbl *cmdtp, int flag, int argc,
>                 return abootimg_get_dtb_load_addr(argc, argv);
>         else if (!strcmp(param, "dtb"))
>                 return abootimg_get_dtb(argc, argv);
> +       else if (!strcmp(param, "ramdisk"))
> +               return abootimg_get_ramdisk(argc, argv);
>
>         return CMD_RET_USAGE;
>  }
> @@ -315,5 +344,9 @@ U_BOOT_CMD(
>         "    - get address and size (hex) of DT blob in the image by index\n"
>         "      <num>: index number of desired DT blob in DTB area\n"
>         "      [addr_var]: variable name to contain DT blob address\n"
> -       "      [size_var]: variable name to contain DT blob size"
> +       "      [size_var]: variable name to contain DT blob size\n"
> +       "abootimg get ramdisk [addr_var [size_var]]\n"
> +       "    - get address and size (hex) of ramdisk in the image\n"
> +       "      [addr_var]: variable name to contain ramdisk address\n"
> +       "      [size_var]: variable name to contain ramdisk size"
>  );
>
> --
> 2.34.1
>

Regards,
Simon
