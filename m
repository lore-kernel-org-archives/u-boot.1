Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2262AC47258
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 22:37:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16ACD874CC;
	Thu, 25 Jan 2024 23:37:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TWc3jzXC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 605BC865F5; Thu, 25 Jan 2024 23:37:20 +0100 (CET)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 282A6874CC
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 23:37:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5d731b1a038so519551a12.2
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 14:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706222235; x=1706827035; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=97oYQzz+b2Ws96t04BlzUrAHH6TUGeYY0Q7PgBN0kXw=;
 b=TWc3jzXCvm5yeOWsiQDxi/GfZ+yLPNeZb0Yz15mSdk75K8rLLPdlvXhK+DNYebTE7S
 JpUe+7RY5EXseliFP/EW542QK5CSWgX1mdHRF72zNR+MeIRiXrBHKmhb92+voVFLdlTb
 JvUp799JsJc7sAOoYKiyVTs3lkWIsS2Ee11gXuAEGRtSu0xe1DDLdq9B7aRnKlmOtFYI
 +dZxIjxv4g9QOFoXvRM6pC3LPNeELUblI7KmdZoab92U9DCw6hkL7j+CWDJfF4bDvrSz
 OgDlGnZtCFCLmsRZE+VuaUoRTliKSeqWcsUbkkMfuCaSmopmu98ETvoORcio48vCe2IW
 qJsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706222235; x=1706827035;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=97oYQzz+b2Ws96t04BlzUrAHH6TUGeYY0Q7PgBN0kXw=;
 b=Q/yhOepcBX/2bpGz+cICpvDXZpDdaQsO4vD9DA67GuvxZWghE31mQfIo6Da5JUbYW5
 dF031WrWaeeF1CsL5Ot5h8zLUyuyxN6KzHy46dqpcrRsfAXVED4MKxefTKV6ETQybRNb
 Dt7Rxqc9OXvds/reo783vVDYfqaOAEMn2SKzjMdYj1AhZ0al+0ze0+J+79R+ej3GNvZ8
 vI0qrnJ7FdDtnvpQ5kZ7C3o7qN8jogEUK0G/9uWog6xQpF/0YLLEU6lMGFEQkCRNLNIY
 2n3UJHPVCdRP00qP6IF7aLcbI2d8GKwewpEBcmwtpYtS2PTRkqXWqijgqzAa5l5ZSnqR
 UGDg==
X-Gm-Message-State: AOJu0YyVOX4S8oD/DrzCq2FCUWRgaQzva0Gnk18QPP25FI6/jZdAmEgT
 BSuwLyh4aFHE0tFIDkb8KkNhtWx2FVTEsRsF7lw4Wzpy40DRFE8WeF4JQpsAX08T6C6bYDdsWCl
 72uVe/3lgkDet0MhSRGqRjc1c5+Y=
X-Google-Smtp-Source: AGHT+IH1Mv6eZkDgJBisBHHcY1pm2MgdfUJZ4gUHCNosbEy6EuxKDxNdA8TeT0hdfM+0FR1KEcZm8UaqJ1nCQ1ppvBE=
X-Received: by 2002:a05:6a20:7aa7:b0:19c:5c71:8221 with SMTP id
 u39-20020a056a207aa700b0019c5c718221mr322634pzh.76.1706222235203; Thu, 25 Jan
 2024 14:37:15 -0800 (PST)
MIME-Version: 1.0
References: <20240124021516.280026-1-Mr.Bossman075@gmail.com>
In-Reply-To: <20240124021516.280026-1-Mr.Bossman075@gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Thu, 25 Jan 2024 16:37:04 -0600
Message-ID: <CAHCN7xKcoQixHvZbXos7kiBrZnMD12-q1UfDze+1Y220g_Oq8w@mail.gmail.com>
Subject: Re: [PATCH v1] tools: mkimage: Add support for i.MXRT FlexSPI Header
To: Jesse Taube <mr.bossman075@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Giulio Benetti <giulio.benetti@benettiengineering.com>, 
 Mamta Shukla <mamta.shukla@leica-geosystems.com>, 
 Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com>,
 Fabio Estevam <festevam@denx.de>, 
 Simon Glass <sjg@chromium.org>, Jassi Brar <jaswinder.singh@linaro.org>, 
 Paul-Erwan Rio <paulerwan.rio@gmail.com>, Alexander Dahl <ada@thorsis.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>, 
 Mikhail Ilin <ilin.mikhail.ol@gmail.com>
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

On Tue, Jan 23, 2024 at 8:15=E2=80=AFPM Jesse Taube <mr.bossman075@gmail.co=
m> wrote:
>
> Modify imx8m Flex SPI Configuration Block to work with imxrt.
> Add more Flex SPI configuration options to Kconfig.
>
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>

I had to go back in time, because it appears the current version of
'master' doesn't fully boot the FSPI, but when I applied this patch
against a working version, it still worked when I was done.  I'll try
to git bisect the issue when I have time, but for now:

Tested-by:  Adam Ford <aford173@gmail.com> #imx8mn-beacon

adam
> ---
>  include/imximage.h | 42 +++++++++++++------------
>  tools/Kconfig      | 21 +++++++++++++
>  tools/imx8mimage.c | 41 ++++++++++++------------
>  tools/imximage.c   | 77 ++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 143 insertions(+), 38 deletions(-)
>
> diff --git a/include/imximage.h b/include/imximage.h
> index c1ecc0b7cb..a951699d0a 100644
> --- a/include/imximage.h
> +++ b/include/imximage.h
> @@ -210,33 +210,37 @@ typedef struct {
>         uint8_t datasetup;
>         uint8_t coladdrwidth;
>         uint8_t devcfgenable;
> -       uint8_t reserved_2[3];
> +       uint8_t deviceModeType;
> +       uint16_t waitTimeCfgCommands;
>         uint8_t devmodeseq[4];
> -       uint8_t devmodearg[4];
> +       uint32_t devmodearg;
>         uint8_t cmd_enable;
> -       uint8_t reserved_3[3];
> +       uint8_t configModeType[3];
>         uint8_t cmd_seq[16] ;
>         uint8_t cmd_arg[16];
> -       uint8_t controllermisc[4];
> +       uint32_t controllermisc;
>         uint8_t dev_type;
>         uint8_t sflash_pad;
>         uint8_t serial_clk;
> -       uint8_t lut_custom ;
> -       uint8_t reserved_4[8];
> -       uint8_t sflashA1[4];
> -       uint8_t sflashA2[4];
> -       uint8_t sflashB1[4];
> -       uint8_t sflashB2[4];
> -       uint8_t cspadover[4];
> -       uint8_t sclkpadover[4];
> -       uint8_t datapadover[4];
> -       uint8_t dqspadover[4];
> -       uint8_t timeout[4];
> -       uint8_t commandInt[4];
> -       uint8_t datavalid[4];
> -       uint8_t busyoffset[2];
> -       uint8_t busybitpolarity[2];
> +       uint8_t lut_custom;
> +       uint8_t reserved_2[8];
> +       uint32_t sflashA1;
> +       uint32_t sflashA2;
> +       uint32_t sflashB1;
> +       uint32_t sflashB2;
> +       uint32_t cspadover;
> +       uint32_t sclkpadover;
> +       uint32_t datapadover;
> +       uint32_t dqspadover;
> +       uint32_t timeout;
> +       uint32_t commandInt;
> +       uint16_t datavalid[2];
> +       uint16_t busyoffset;
> +       uint16_t busybitpolarity;
>         uint8_t lut[256];
> +       uint8_t lutCustomSeq[48];
> +       uint8_t reserved_3[16];
> +
>  } __attribute__((packed)) fspi_conf;
>
>  typedef void (*set_dcd_val_t)(struct imx_header *imxhdr,
> diff --git a/tools/Kconfig b/tools/Kconfig
> index f01ed783e6..667807b331 100644
> --- a/tools/Kconfig
> +++ b/tools/Kconfig
> @@ -148,6 +148,27 @@ config SERIAL_CLK_FREQUENCY
>           Chip specific frequency: other value 30MHz
>           1-30MHz  2-50MHz 3-60MHz 4-75MHz 5-80MHz 6-100MHz 7-133MHz 8-16=
6MHz
>
> +config FSPI_COL_ADDR_W
> +       hex "Column Address With"
> +       default 0x00
> +       depends on FSPI_CONF_HEADER
> +       help
> +         Default 0. For HyperBus protocol, it is fixed to 3
> +
> +config FSPI_CONTROLLER_MISC
> +       hex "FSPI miscellaneous control"
> +       default 0x00000000
> +       depends on FSPI_CONF_HEADER
> +       help
> +         Default 0. [0x40] Controller Misc Options
> +
> +config FSPI_FLASH_A1_SIZE
> +       hex "Size in bytes of Flash A1"
> +       default 0x10000000
> +       depends on FSPI_CONF_HEADER
> +       help
> +         Size of Flash connected to A1 in bytes
> +
>  config LUT_CUSTOM_SEQUENCE
>         hex "Enable Custom Look Up Table(LUT) Sequence"
>         default 0x00
> diff --git a/tools/imx8mimage.c b/tools/imx8mimage.c
> index 21075c2379..939f829a9f 100644
> --- a/tools/imx8mimage.c
> +++ b/tools/imx8mimage.c
> @@ -426,36 +426,39 @@ static int generate_fspi_header (int ifd)
>         .read_sample =3D CONFIG_READ_CLK_SOURCE,
>         .datahold =3D  0x03,
>         .datasetup =3D 0x03,
> -       .coladdrwidth =3D 0x00,
> +       .coladdrwidth =3D CONFIG_FSPI_COL_ADDR_W,
>         .devcfgenable =3D 0x00,
> -       .reserved_2 =3D {0x00, 0x00, 0x00},
> +       .deviceModeType =3D 0x00,
> +       .waitTimeCfgCommands =3D 0x0000,
>         .devmodeseq =3D  {0x00, 0x00, 0x00, 0x00},
> -       .devmodearg =3D  {0x00, 0x00, 0x00, 0x00},
> +       .devmodearg =3D  0x00000000,
>         .cmd_enable =3D  0x00,
> -       .reserved_3 =3D {0x00},
> +       .configModeType =3D {0x00},
>         .cmd_seq =3D {0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0=
0, 0x00,
>                                                         0x00, 0x00, 0x00,=
 0x00, 0x00, 0x00},
>         .cmd_arg =3D {0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0=
0, 0x00,
>                                                         0x00, 0x00, 0x00,=
 0x00, 0x00, 0x00},
> -       .controllermisc =3D {0x00, 0x00, 0x00, 0x00},
> +       .controllermisc =3D cpu_to_le32(CONFIG_FSPI_CONTROLLER_MISC),
>         .dev_type =3D CONFIG_DEVICE_TYPE,
>         .sflash_pad =3D CONFIG_FLASH_PAD_TYPE,
>         .serial_clk =3D CONFIG_SERIAL_CLK_FREQUENCY,
>         .lut_custom =3D CONFIG_LUT_CUSTOM_SEQUENCE,
> -       .reserved_4 =3D {0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00},
> -       .sflashA1  =3D  {0x00, 0x00, 0x00, 0x10},
> -       .sflashA2 =3D {0x00, 0x00, 0x00, 0x00},
> -       .sflashB1 =3D {0x00, 0x00, 0x00, 0x00},
> -       .sflashB2 =3D  {0x00, 0x00, 0x00, 0x00},
> -       .cspadover =3D {0x00, 0x00, 0x00, 0x00},
> -       .sclkpadover =3D {0x00, 0x00, 0x00, 0x00},
> -       .datapadover =3D {0x00, 0x00, 0x00, 0x00},
> -       .dqspadover =3D {0x00, 0x00, 0x00, 0x00},
> -       .timeout =3D  {0x00, 0x00, 0x00, 0x00},
> -       .commandInt =3D {0x00, 0x00, 0x00, 0x00},
> -       .datavalid  =3D {0x00, 0x00, 0x00, 0x00},
> -       .busyoffset =3D {0x00, 0x00},
> -       .busybitpolarity =3D {0x00, 0x00},
> +       .reserved_2 =3D {0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00},
> +       .sflashA1  =3D  cpu_to_le32(CONFIG_FSPI_FLASH_A1_SIZE),
> +       .sflashA2 =3D 0x00000000,
> +       .sflashB1 =3D 0x00000000,
> +       .sflashB2 =3D 0x00000000,
> +       .cspadover =3D 0x00000000,
> +       .sclkpadover =3D 0x00000000,
> +       .datapadover =3D 0x00000000,
> +       .dqspadover =3D 0x00000000,
> +       .timeout =3D  0x00000000,
> +       .commandInt =3D 0x00000000,
> +       .datavalid  =3D {0x0000, 0x0000},
> +       .busyoffset =3D 0x0000,
> +       .busybitpolarity =3D 0x0000,
> +       .lutCustomSeq =3D {0x00},
> +       .reserved_3 =3D {0x00}
>         };
>
>         for (val =3D strtok(lut_str, ","); val; val =3D strtok(NULL, ",")=
) {
> diff --git a/tools/imximage.c b/tools/imximage.c
> index b3da1f244c..2df4c7dd49 100644
> --- a/tools/imximage.c
> +++ b/tools/imximage.c
> @@ -908,6 +908,64 @@ int imximage_check_params(struct image_tool_params *=
params)
>                 (params->xflag) || !(strlen(params->imagename));
>  }
>
> +#ifdef CONFIG_FSPI_CONF_HEADER
> +static void generate_fspi_header(int ifd)
> +{
> +       int i =3D 0;
> +       char *val;
> +       char lut_str[] =3D CONFIG_LUT_SEQUENCE;
> +
> +       fspi_conf fspi_conf_data =3D {
> +       .tag =3D {0x46, 0x43, 0x46, 0x42},
> +       .version =3D {0x00, 0x00, 0x01, 0x56},
> +       .reserved_1 =3D {0x00, 0x00, 0x00, 0x00},
> +       .read_sample =3D CONFIG_READ_CLK_SOURCE,
> +       .datahold =3D  0x03,
> +       .datasetup =3D 0x03,
> +       .coladdrwidth =3D CONFIG_FSPI_COL_ADDR_W,
> +       .devcfgenable =3D 0x00,
> +       .deviceModeType =3D 0x00,
> +       .waitTimeCfgCommands =3D 0x0000,
> +       .devmodeseq =3D  {0x00, 0x00, 0x00, 0x00},
> +       .devmodearg =3D  0x00000000,
> +       .cmd_enable =3D  0x00,
> +       .configModeType =3D {0x00},
> +       .cmd_seq =3D {0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0=
0, 0x00,
> +                                                       0x00, 0x00, 0x00,=
 0x00, 0x00, 0x00},
> +       .cmd_arg =3D {0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0=
0, 0x00,
> +                                                       0x00, 0x00, 0x00,=
 0x00, 0x00, 0x00},
> +       .controllermisc =3D cpu_to_le32(CONFIG_FSPI_CONTROLLER_MISC),
> +       .dev_type =3D CONFIG_DEVICE_TYPE,
> +       .sflash_pad =3D CONFIG_FLASH_PAD_TYPE,
> +       .serial_clk =3D CONFIG_SERIAL_CLK_FREQUENCY,
> +       .lut_custom =3D CONFIG_LUT_CUSTOM_SEQUENCE,
> +       .reserved_2 =3D {0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00},
> +       .sflashA1  =3D  cpu_to_le32(CONFIG_FSPI_FLASH_A1_SIZE),
> +       .sflashA2 =3D 0x00000000,
> +       .sflashB1 =3D 0x00000000,
> +       .sflashB2 =3D 0x00000000,
> +       .cspadover =3D 0x00000000,
> +       .sclkpadover =3D 0x00000000,
> +       .datapadover =3D 0x00000000,
> +       .dqspadover =3D 0x00000000,
> +       .timeout =3D  0x00000000,
> +       .commandInt =3D 0x00000000,
> +       .datavalid  =3D {0x0000, 0x0000},
> +       .busyoffset =3D 0x0000,
> +       .busybitpolarity =3D 0x0000,
> +       .lutCustomSeq =3D {0x00},
> +       .reserved_3 =3D {0x00}
> +       };
> +
> +       for (val =3D strtok(lut_str, ","); val; val =3D strtok(NULL, ",")=
)
> +               fspi_conf_data.lut[i++] =3D strtoul(val, NULL, 16);
> +
> +       lseek(ifd, 0, SEEK_CUR);
> +       if (write(ifd, &fspi_conf_data, sizeof(fspi_conf_data)) =3D=3D -1=
)
> +               exit(EXIT_FAILURE);
> +}
> +#endif
> +
>  static int imximage_generate(struct image_tool_params *params,
>         struct image_type_params *tparams)
>  {
> @@ -917,6 +975,11 @@ static int imximage_generate(struct image_tool_param=
s *params,
>         char *datafile =3D params->datafile;
>         uint32_t pad_len, header_size;
>
> +#ifdef CONFIG_FSPI_CONF_HEADER
> +       int fspi_fd;
> +       char *fspi;
> +#endif
> +
>         memset(&imximage_header, 0, sizeof(imximage_header));
>
>         /*
> @@ -977,6 +1040,20 @@ static int imximage_generate(struct image_tool_para=
ms *params,
>
>         pad_len =3D ROUND(sbuf.st_size, 4096) - sbuf.st_size;
>
> +#ifdef CONFIG_FSPI_CONF_HEADER
> +       fspi =3D CONFIG_FSPI_CONF_FILE;
> +       fspi_fd =3D open(fspi, O_RDWR | O_CREAT, S_IRWXU);
> +       if (fspi_fd < 0) {
> +               fprintf(stderr, "Can't open %s: %s\n",
> +                       fspi, strerror(errno));
> +               exit(EXIT_FAILURE);
> +       }
> +
> +       generate_fspi_header(fspi_fd);
> +       close(fspi_fd);
> +
> +#endif
> +
>         return pad_len;
>  }
>
> --
> 2.43.0
>
