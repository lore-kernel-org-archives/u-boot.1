Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E155AC71136
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 14:19:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58F4E82C67;
	Thu, 12 Jun 2025 16:19:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="fayFNUQ/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 258BD82C7F; Thu, 12 Jun 2025 16:18:59 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61CB382BD9
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 16:18:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eballetb@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749737935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OW5fz8ZimFQEpdPxqSwWoyc8d7KaG+fyp05VQ1TUbbw=;
 b=fayFNUQ/GAmfh1aRj/B6LOWs7pezx0Pe8SANiOHplqt1IckyBils52QS+wfWbdF4Yxp5XK
 JZEMW5l8DTi0jE4m2DpN3ph7C4ah68oZfTWfY7LUg7TG1FBbG6pujzByGBDNVoYtBp83ze
 sHv5SfeezihE4MRhq0/e5DQuslsvPVk=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-siXXF9SjNDeNJ3MdDAf9Tw-1; Thu, 12 Jun 2025 10:18:53 -0400
X-MC-Unique: siXXF9SjNDeNJ3MdDAf9Tw-1
X-Mimecast-MFC-AGG-ID: siXXF9SjNDeNJ3MdDAf9Tw_1749737933
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-735b420575eso281146a34.2
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 07:18:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749737933; x=1750342733;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OW5fz8ZimFQEpdPxqSwWoyc8d7KaG+fyp05VQ1TUbbw=;
 b=Acy4A8oKtFY4igSIydiDKeoZ8OS35hwQU5/X/hfqwFAlsPeV0Ab5MMXr9z3xKq38Zb
 luhhnmB+n5hMobqXEQjnaQxhnFK+iH8vHYKtu300h5Fao8+kZyhkn3rhqRjdo70RBa5E
 OyH24SJeVa5yZUAq2omLNHdcj3a2zXSayqfuxhnrV/n1wIvEkihV5QwKsXTxS3bXQJOl
 Dp8Tq8bbfXXsaK474HD3DSBdOb7H0etD/w2KsYuRPPQFPDbQHMoAQehQUstAzvukQacP
 +F2DASUdCQGiVuyF1YxfWDT8XHbg3Pwql+cE85c6LSSnuuiJNo/0QbYY2pOOFAMvVAB+
 wU8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTihASwNzXEe3GCneTrr5DNnFcD0/QMDExntq74qiRnBlnjJtYxuZzZdKVLGcZf/ZJID7si9o=@lists.denx.de
X-Gm-Message-State: AOJu0YzdChWz8w36lG0JgcAcIOJD6q6wjh1XTCsgHZub976zWL8h9Kjr
 BI42jaUX3zErDb43oGJJ2YYEOZom4/J2J8ANXC7hsWiD22n7zjhAjLOngDawZGxdIse0dO9vUJa
 Io80r0Z85xc7vlyvdywrupGcRSi2Sb85L4eTn+a0CYC039Dpl3nUAbQ8xjkXg/kHX0N7B9Mo7yU
 UMYMvRib3pcMYj8NxqYoYFQvKf4p6CNA==
X-Gm-Gg: ASbGncv54fhaLmibn1bGAfdWdyqrxh1rSCa6MVCxUgwpT8i1AcvC2Ke88zAmQ+Zamz3
 UdQF5COeD/q32yMVM+8D0zwUlqOwuJ3GhxnMayACgEZJ6/MiQDrlNnwpMFY6Ir2QFrB/rDEWIoq
 9v17k=
X-Received: by 2002:a05:6871:b183:b0:2ea:9826:dab5 with SMTP id
 586e51a60fabf-2ea9826de42mr1114933fac.2.1749737932537; 
 Thu, 12 Jun 2025 07:18:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHETLWXUExnoQp0oe6WmmftdqbDY3y0LI9krwWfQs6xLr4YHQTyW7t7dunBTVCGdOO0jjFinmN7kUQ9Vh+PvfA=
X-Received: by 2002:a05:6871:b183:b0:2ea:9826:dab5 with SMTP id
 586e51a60fabf-2ea9826de42mr1114923fac.2.1749737931926; Thu, 12 Jun 2025
 07:18:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250428-imx95-v1-0-a3df9c340ace@oss.nxp.com>
 <20250428-imx95-v1-17-a3df9c340ace@oss.nxp.com>
In-Reply-To: <20250428-imx95-v1-17-a3df9c340ace@oss.nxp.com>
From: Enric Balletbo i Serra <eballetb@redhat.com>
Date: Thu, 12 Jun 2025 16:17:55 +0200
X-Gm-Features: AX0GCFtuUm5x_2yjQFD-_KS4D98s5occhNKBKhfmYmzApvne1TAGM6Iy-tq-ICI
Message-ID: <CALE0LRtOTErhJ=ixnN_pSp2YROGyW9CtMXQ3GXF46mH6bkdfjQ@mail.gmail.com>
Subject: Re: [PATCH v11 17/21] tools: imx8image: add i.MX95 support
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>,
 u-boot@lists.denx.de, 
 =?UTF-8?Q?Lothar_Wa=C3=9Fmann?= <LW@karo-electronics.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IwUe2o5UUU368O-lOUclQHYGsk8u-k7D3WQTovAZzQo_1749737933
X-Mimecast-Originator: redhat.com
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

Hi all,

On Mon, Apr 28, 2025 at 12:41=E2=80=AFPM Alice Guo (OSS) <alice.guo@oss.nxp=
.com> wrote:
>
> From: Alice Guo <alice.guo@nxp.com>
>
> i.MX95 uses binman to invoke mkimage to create image container. 2 image
> containers are needed currently. The first one is composed of
> ahab-container.img, LPDDR firmware images, OEI images, System Manager
> image and u-boot-spl.bin. The second one is consisted of ARM Trusted
> firmware and u-boot.bin.
>
> Because DDR OEI image and LPDDR firmware images have to be packaged
> together and named as m33-oei-ddrfw.bin by binman, so imx9_image.sh does
> not check if m33-oei-ddrfw.bin exists.
>
> When using "make imx95_19x19_evk_defconfig; make", imx9_image.sh will
> delete the line for u-boot.bin in container.cfg. In fact, binman is
> always called after the u-boot.bin is built, so imx9_image.sh does not
> check if u-boot.bin exists.
>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>

I bisected a problem with the current mainline with the imx8qxp_mek
board and seems to point to that patch. After this patch, I'm getting
the following errors when u-boot creates the  flash.bin binary.

   error writing image hdr 400
   MKIMAGE flash.bin

The resulting binary seems to not work. Reverting that patch helps to
make bootable the board again.

The u-boot log is:
....
  MKIMAGE u-boot.cnt
1+0 records in
1+0 records out
33792 bytes (34 kB, 33 KiB) copied, 6.5088e-05 s, 519 MB/s
64+1 records in
64+1 records out
32909 bytes (33 kB, 32 KiB) copied, 0.000142272 s, 231 MB/s
1+0 records in
1+0 records out
676864 bytes (677 kB, 661 KiB) copied, 0.000610144 s, 1.1 GB/s
1320+1 records in
1320+1 records out
676272 bytes (676 kB, 660 KiB) copied, 0.00326546 s, 207 MB/s
build_container: 0 0
error writing image hdr 400
  MKIMAGE flash.bin
1+0 records in
1+0 records out
164864 bytes (165 kB, 161 KiB) copied, 0.00016016 s, 1.0 GB/s
321+1 records in
321+1 records out
164608 bytes (165 kB, 161 KiB) copied, 0.000612231 s, 269 MB/s
1+0 records in
1+0 records out
79872 bytes (80 kB, 78 KiB) copied, 7.304e-05 s, 1.1 GB/s
155+1 records in
155+1 records out
79799 bytes (80 kB, 78 KiB) copied, 0.000962302 s, 82.9 MB/s
build_container: 400 0
error writing image hdr 400
append u-boot.cnt at 316 KB
702+0 records in
702+0 records out
718848 bytes (719 kB, 702 KiB) copied, 0.00186017 s, 386 MB/s

Best regards,
  Enric

> ---
>  include/imx8image.h |  19 +++++--
>  tools/imx8image.c   | 147 ++++++++++++++++++++++++++++++++++++++++++++++=
------
>  tools/imx9_image.sh |   8 +++
>  3 files changed, 155 insertions(+), 19 deletions(-)
>
> diff --git a/include/imx8image.h b/include/imx8image.h
> index 6b95e93fb50..e0d25c5b6c9 100644
> --- a/include/imx8image.h
> +++ b/include/imx8image.h
> @@ -157,7 +157,9 @@ enum imx8image_cmd {
>         CMD_SOC_TYPE,
>         CMD_CONTAINER,
>         CMD_IMAGE,
> -       CMD_DATA
> +       CMD_DATA,
> +       CMD_DUMMY_V2X,
> +       CMD_HOLD,
>  };
>
>  enum imx8image_core_type {
> @@ -169,7 +171,9 @@ enum imx8image_core_type {
>         CFG_A35,
>         CFG_A55,
>         CFG_A53,
> -       CFG_A72
> +       CFG_A72,
> +       CFG_M33,
> +       CFG_OEI,
>  };
>
>  enum imx8image_fld_types {
> @@ -208,7 +212,10 @@ typedef enum option_type {
>         FILEOFF,
>         MSG_BLOCK,
>         SENTINEL,
> -       UPOWER
> +       UPOWER,
> +       OEI,
> +       DUMMY_V2X,
> +       HOLD,
>  } option_type_t;
>
>  typedef struct {
> @@ -227,12 +234,16 @@ typedef struct {
>  #define CORE_CA35       4
>  #define CORE_CA72       5
>  #define CORE_SECO       6
> +#define CORE_M33        7
>
>  #define CORE_ULP_CM33          0x1
>  #define CORE_ULP_CA35          0x2
>  #define CORE_ULP_UPOWER        0x4
>  #define CORE_ULP_SENTINEL      0x6
>
> +#define CORE_IMX95_M33P                0
> +#define CORE_IMX95_A55C0       2
> +
>  #define SC_R_OTP       357U
>  #define SC_R_DEBUG     354U
>  #define SC_R_ROM_0     236U
> @@ -246,10 +257,12 @@ typedef struct {
>  #define IMG_TYPE_EXEC    0x03   /* Executable image type */
>  #define IMG_TYPE_DATA    0x04   /* Data image type */
>  #define IMG_TYPE_DCD_DDR 0x05   /* DCD/DDR image type */
> +#define IMG_TYPE_OEI     0x05   /* Optional Executable image type */
>  #define IMG_TYPE_SECO    0x06   /* SECO image type */
>  #define IMG_TYPE_SENTINEL 0x06 /* SENTINEL image type */
>  #define IMG_TYPE_PROV    0x07   /* Provisioning image type */
>  #define IMG_TYPE_DEK     0x08   /* DEK validation type */
> +#define IMG_TYPE_V2X_DUMMY 0x0E /* V2X Dummy image */
>
>  #define IMG_TYPE_SHIFT   0
>  #define IMG_TYPE_MASK    0x1f
> diff --git a/tools/imx8image.c b/tools/imx8image.c
> index 0135b190951..a333ded46e2 100644
> --- a/tools/imx8image.c
> +++ b/tools/imx8image.c
> @@ -7,6 +7,7 @@
>
>  #include "imx8image.h"
>  #include <image.h>
> +#include <linux/sizes.h>
>
>  static int p_idx;
>  static int sector_size;
> @@ -54,7 +55,9 @@ static table_entry_t imx8image_cmds[] =3D {
>         {CMD_CONTAINER,         "CONTAINER",            "new container", =
     },
>         {CMD_IMAGE,             "IMAGE",                "new image",     =
     },
>         {CMD_DATA,              "DATA",                 "new data",      =
     },
> -       {-1,                    "",                     "",              =
     },
> +       {CMD_DUMMY_V2X,         "DUMMY_V2X",            "v2x",           =
     },
> +       {CMD_HOLD,              "HOLD",                 "hold",          =
     },
> +       {-1,                    "",                     "",              =
     }
>  };
>
>  static table_entry_t imx8image_core_entries[] =3D {
> @@ -66,7 +69,9 @@ static table_entry_t imx8image_core_entries[] =3D {
>         {CFG_A55,       "A55",                  "A55 core",     },
>         {CFG_A53,       "A53",                  "A53 core",     },
>         {CFG_A72,       "A72",                  "A72 core",     },
> -       {-1,            "",                     "",             },
> +       {CFG_OEI,       "OEI",                  "OEI", },
> +       {CFG_M33,       "M33",                  "M33 core", },
> +       {-1,            "",                     "",             }
>  };
>
>  static table_entry_t imx8image_sector_size[] =3D {
> @@ -144,6 +149,14 @@ static void parse_cfg_cmd(image_t *param_stack, int3=
2_t cmd, char *token,
>                         exit(EXIT_FAILURE);
>                 }
>                 break;
> +       case CMD_DUMMY_V2X:
> +               param_stack[p_idx].option =3D DUMMY_V2X;
> +               param_stack[p_idx++].entry =3D (uint32_t)strtoll(token, N=
ULL, 0);
> +               break;
> +       case CMD_HOLD:
> +               param_stack[p_idx].option =3D HOLD;
> +               param_stack[p_idx].entry =3D (uint32_t)strtoll(token, NUL=
L, 0);
> +               param_stack[p_idx++].filename =3D NULL;
>         default:
>                 break;
>         }
> @@ -221,6 +234,16 @@ static void parse_cfg_fld(image_t *param_stack, int3=
2_t *cmd, char *token,
>                                 (*cmd =3D=3D CMD_DATA) ? DATA : AP;
>                         param_stack[p_idx].filename =3D token;
>                         break;
> +               case CFG_OEI:
> +                       param_stack[p_idx].option =3D OEI;
> +                       param_stack[p_idx].filename =3D token;
> +                       param_stack[p_idx].ext =3D CORE_CM4_0;
> +                       break;
> +               case CFG_M33:
> +                       param_stack[p_idx].option =3D M40;
> +                       param_stack[p_idx].ext =3D 0;
> +                       param_stack[p_idx].filename =3D token;
> +                       break;
>                 }
>                 break;
>         case CFG_LOAD_ADDR:
> @@ -238,9 +261,15 @@ static void parse_cfg_fld(image_t *param_stack, int3=
2_t *cmd, char *token,
>                 case CFG_A53:
>                 case CFG_A55:
>                 case CFG_A72:
> +               case CFG_M33:
>                         param_stack[p_idx++].entry =3D
>                                 (uint32_t)strtoll(token, NULL, 0);
>                         break;
> +               case CFG_OEI:
> +                       param_stack[p_idx].dst =3D (uint32_t)strtoll(toke=
n, NULL, 0);
> +                       param_stack[p_idx].entry =3D param_stack[p_idx].d=
st + 1;
> +                       p_idx++;
> +                       break;
>                 }
>         default:
>                 break;
> @@ -549,6 +578,7 @@ static void set_image_array_entry(flash_header_v3_t *=
container,
>                                   char *tmp_filename, bool dcd_skip)
>  {
>         uint64_t entry =3D image_stack->entry;
> +       uint64_t dst =3D image_stack->dst;
>         uint64_t core =3D image_stack->ext;
>         uint32_t meta;
>         char *tmp_name =3D "";
> @@ -558,7 +588,9 @@ static void set_image_array_entry(flash_header_v3_t *=
container,
>         img->offset =3D offset;  /* Is re-adjusted later */
>         img->size =3D size;
>
> -       set_image_hash(img, tmp_filename, IMAGE_HASH_ALGO_DEFAULT);
> +       if (type !=3D DUMMY_V2X) {
> +               set_image_hash(img, tmp_filename, IMAGE_HASH_ALGO_DEFAULT=
);
> +       }
>
>         switch (type) {
>         case SECO:
> @@ -580,6 +612,27 @@ static void set_image_array_entry(flash_header_v3_t =
*container,
>                 img->dst =3D 0xe4000000; /* S400 IRAM base */
>                 img->entry =3D 0xe4000000;
>                 break;
> +       case OEI:
> +               if (soc !=3D IMX9) {
> +                       fprintf(stderr, "Error: invalid core id: %" PRIi6=
4 "\n", core);
> +                       exit(EXIT_FAILURE);
> +               }
> +
> +               img->hab_flags |=3D IMG_TYPE_OEI;
> +               if (core =3D=3D CORE_CM4_0) {
> +                       img->hab_flags |=3D CORE_ULP_CM33 << BOOT_IMG_FLA=
GS_CORE_SHIFT;
> +                       meta =3D CORE_IMX95_M33P;
> +
> +               } else {
> +                       img->hab_flags |=3D CORE_ULP_CA35 << BOOT_IMG_FLA=
GS_CORE_SHIFT;
> +                       meta =3D CORE_IMX95_A55C0;
> +               }
> +               tmp_name =3D "OEI";
> +               img->dst =3D (dst ? dst : entry);
> +               img->entry =3D entry;
> +               img->meta =3D meta;
> +               custom_partition =3D 0;
> +               break;
>         case AP:
>                 if (soc =3D=3D QX && core =3D=3D CORE_CA35) {
>                         meta =3D IMAGE_A35_DEFAULT_META(custom_partition)=
;
> @@ -587,8 +640,10 @@ static void set_image_array_entry(flash_header_v3_t =
*container,
>                         meta =3D IMAGE_A53_DEFAULT_META(custom_partition)=
;
>                 } else if (soc =3D=3D QM && core =3D=3D CORE_CA72) {
>                         meta =3D IMAGE_A72_DEFAULT_META(custom_partition)=
;
> -               } else if (((soc =3D=3D ULP) || (soc =3D=3D IMX9)) && cor=
e =3D=3D CORE_CA35) {
> +               } else if ((soc =3D=3D ULP) && core =3D=3D CORE_CA35) {
>                         meta =3D 0;
> +               } else if ((soc =3D=3D IMX9) && core =3D=3D CORE_CA35) {
> +                       meta =3D CORE_IMX95_A55C0;
>                 } else {
>                         fprintf(stderr,
>                                 "Error: invalid AP core id: %" PRIu64 "\n=
",
> @@ -687,6 +742,15 @@ static void set_image_array_entry(flash_header_v3_t =
*container,
>                         img->entry =3D 0x28300200;
>                 }
>                 break;
> +       case DUMMY_V2X:
> +               img->hab_flags |=3D IMG_TYPE_V2X_DUMMY;
> +               img->hab_flags |=3D CORE_SC << BOOT_IMG_FLAGS_CORE_SHIFT;
> +               tmp_name =3D "V2X Dummy";
> +               set_image_hash(img, "/dev/null", IMAGE_HASH_ALGO_DEFAULT)=
;
> +               img->dst =3D entry;
> +               img->entry =3D entry;
> +               img->size =3D 0; /* dummy image has no size */
> +               break;
>         default:
>                 fprintf(stderr, "unrecognized image type (%d)\n", type);
>                 exit(EXIT_FAILURE);
> @@ -709,15 +773,26 @@ void set_container(flash_header_v3_t *container,  u=
int16_t sw_version,
>         fprintf(stdout, "container flags: 0x%x\n", container->flags);
>  }
>
> -static int get_container_image_start_pos(image_t *image_stack, uint32_t =
align)
> +static int get_container_image_start_pos(image_t *image_stack, uint32_t =
align, uint32_t *v2x)
>  {
>         image_t *img_sp =3D image_stack;
>         /*8K total container header*/
>         int file_off =3D CONTAINER_IMAGE_ARRAY_START_OFFSET;
>         FILE *fd =3D NULL;
> -       flash_header_v3_t header;
> +       flash_header_v3_t *header;
> +       flash_header_v3_t *header2;
> +       void *p;
>         int ret;
>
> +       p =3D calloc(1, SZ_4K);
> +       if (!p) {
> +               fprintf(stderr, "Fail to alloc 4K memory\n");
> +               exit(EXIT_FAILURE);
> +       }
> +
> +       header =3D p;
> +       header2 =3D p + FIRST_CONTAINER_HEADER_LENGTH;
> +
>         while (img_sp->option !=3D NO_IMG) {
>                 if (img_sp->option =3D=3D APPEND) {
>                         fd =3D fopen(img_sp->filename, "r");
> @@ -726,7 +801,7 @@ static int get_container_image_start_pos(image_t *ima=
ge_stack, uint32_t align)
>                                 exit(EXIT_FAILURE);
>                         }
>
> -                       ret =3D fread(&header, sizeof(header), 1, fd);
> +                       ret =3D fread(header, SZ_4K, 1, fd);
>                         if (ret !=3D 1) {
>                                 printf("Failure Read header %d\n", ret);
>                                 exit(EXIT_FAILURE);
> @@ -734,19 +809,27 @@ static int get_container_image_start_pos(image_t *i=
mage_stack, uint32_t align)
>
>                         fclose(fd);
>
> -                       if (header.tag !=3D IVT_HEADER_TAG_B0) {
> -                               fprintf(stderr, "header tag mismatched fi=
le %s\n", img_sp->filename);
> +                       if (header->tag !=3D IVT_HEADER_TAG_B0) {
> +                               fprintf(stderr, "header tag mismatched \n=
");
>                                 exit(EXIT_FAILURE);
>                         } else {
> -                               file_off +=3D
> -                                       header.img[header.num_images - 1]=
.size;
> -                               file_off =3D ALIGN(file_off, align);
> +                               if (header2->tag !=3D IVT_HEADER_TAG_B0) =
{
> +                                       file_off +=3D header->img[header-=
>num_images - 1].size;
> +                                       file_off =3D ALIGN(file_off, alig=
n);
> +                               } else {
> +                                       file_off =3D header2->img[header2=
->num_images - 1].offset + FIRST_CONTAINER_HEADER_LENGTH;
> +                                       file_off +=3D header2->img[header=
2->num_images - 1].size;
> +                                       file_off =3D ALIGN(file_off, alig=
n);
> +                                       fprintf(stderr, "Has 2nd containe=
r %x\n", file_off);
> +                                       *v2x =3D true;
> +                               }
>                         }
>                 }
>
>                 img_sp++;
>         }
>
> +       free(p);
>         return file_off;
>  }
>
> @@ -838,6 +921,7 @@ static int build_container(soc_type_t soc, uint32_t s=
ector_size,
>         char *tmp_filename =3D NULL;
>         uint32_t size =3D 0;
>         uint32_t file_padding =3D 0;
> +       uint32_t v2x =3D false;
>         int ret;
>
>         int container =3D -1;
> @@ -861,7 +945,7 @@ static int build_container(soc_type_t soc, uint32_t s=
ector_size,
>         set_imx_hdr_v3(&imx_header, 0);
>         set_imx_hdr_v3(&imx_header, 1);
>
> -       file_off =3D get_container_image_start_pos(image_stack, sector_si=
ze);
> +       file_off =3D get_container_image_start_pos(image_stack, sector_si=
ze, &v2x);
>         fprintf(stdout, "container image offset (aligned):%x\n", file_off=
);
>
>         /* step through image stack and generate the header */
> @@ -870,6 +954,7 @@ static int build_container(soc_type_t soc, uint32_t s=
ector_size,
>         /* stop once we reach null terminator */
>         while (img_sp->option !=3D NO_IMG) {
>                 switch (img_sp->option) {
> +               case OEI:
>                 case AP:
>                 case M40:
>                 case M41:
> @@ -892,6 +977,30 @@ static int build_container(soc_type_t soc, uint32_t =
sector_size,
>                         file_off +=3D ALIGN(sbuf.st_size, sector_size);
>                         break;
>
> +               case DUMMY_V2X:
> +                       if (container < 0) {
> +                               fprintf(stderr, "No container found\n");
> +                               exit(EXIT_FAILURE);
> +                       }
> +                       tmp_filename =3D "dummy";
> +                       set_image_array_entry(&imx_header.fhdr[container]=
,
> +                                               soc,
> +                                               img_sp,
> +                                               file_off,
> +                                               0,
> +                                               tmp_filename,
> +                                               dcd_skip);
> +                       img_sp->src =3D file_off;
> +                       break;
> +
> +               case HOLD:
> +                       if (container < 0) {
> +                               fprintf(stderr, "No container found\n");
> +                               exit(EXIT_FAILURE);
> +                       }
> +                       file_off +=3D ALIGN(img_sp->entry, sector_size);
> +                       break;
> +
>                 case SECO:
>                 case SENTINEL:
>                         if (container < 0) {
> @@ -963,11 +1072,15 @@ static int build_container(soc_type_t soc, uint32_=
t sector_size,
>         do {
>                 if (img_sp->option =3D=3D APPEND) {
>                         copy_file(ofd, img_sp->filename, 0, 0);
> -                       file_padding +=3D FIRST_CONTAINER_HEADER_LENGTH;
> +                       if (v2x)
> +                               file_padding +=3D FIRST_CONTAINER_HEADER_=
LENGTH * 2;
> +                       else
> +                               file_padding +=3D FIRST_CONTAINER_HEADER_=
LENGTH;
>                 }
>                 img_sp++;
>         } while (img_sp->option !=3D NO_IMG);
>
> +       fprintf(stderr, "%s: %x %d\n", __func__, file_padding, v2x);
>         /* Add padding or skip appended container */
>         ret =3D lseek(ofd, file_padding, SEEK_SET);
>         if (ret < 0) {
> @@ -980,6 +1093,7 @@ static int build_container(soc_type_t soc, uint32_t =
sector_size,
>                 /* Note: Image offset are not contained in the image */
>                 tmp =3D flatten_container_header(&imx_header, container +=
 1,
>                                                &size, file_padding);
> +               fprintf(stderr, "error writing image hdr %x\n", size);
>                 /* Write image header */
>                 if (write(ofd, tmp, size) !=3D size) {
>                         fprintf(stderr, "error writing image hdr\n");
> @@ -1000,7 +1114,8 @@ static int build_container(soc_type_t soc, uint32_t=
 sector_size,
>                     img_sp->option =3D=3D AP || img_sp->option =3D=3D DAT=
A ||
>                     img_sp->option =3D=3D SCD || img_sp->option =3D=3D SC=
FW ||
>                     img_sp->option =3D=3D SECO || img_sp->option =3D=3D M=
SG_BLOCK ||
> -                   img_sp->option =3D=3D UPOWER || img_sp->option =3D=3D=
 SENTINEL) {
> +                   img_sp->option =3D=3D UPOWER || img_sp->option =3D=3D=
 SENTINEL ||
> +                   img_sp->option =3D=3D OEI) {
>                         copy_file_aligned(ofd, img_sp->filename, img_sp->=
src,
>                                           sector_size);
>                 }
> @@ -1031,7 +1146,7 @@ int imx8image_copy_image(int outfd, struct image_to=
ol_params *mparams)
>         fprintf(stdout, "CONTAINER SW VERSION:\t0x%04x\n", sw_version);
>
>         build_container(soc, sector_size, emmc_fastboot,
> -                       img_sp, dcd_skip, fuse_version, sw_version, outfd=
);
> +                       img_sp, false, fuse_version, sw_version, outfd);
>
>         return 0;
>  }
> diff --git a/tools/imx9_image.sh b/tools/imx9_image.sh
> index ca78a57a19a..6523d1a0ad1 100755
> --- a/tools/imx9_image.sh
> +++ b/tools/imx9_image.sh
> @@ -18,6 +18,14 @@ for f in $blobs; do
>                 continue
>         fi
>
> +       if [ $f =3D "m33-oei-ddrfw.bin" ]; then
> +               continue
> +       fi
> +
> +       if [ $f =3D "u-boot.bin" ]; then
> +               continue
> +       fi
> +
>         if [ ! -f $tmp ]; then
>                 echo "WARNING '$tmp' not found, resulting binary may be n=
ot-functional" >&2
>
>
> --
> 2.43.0
>

