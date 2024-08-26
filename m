Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C51C5321E
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 13:38:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39730884C3;
	Mon, 26 Aug 2024 15:38:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="v69Rbet9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F2F488966; Mon, 26 Aug 2024 15:38:31 +0200 (CEST)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B20208806A
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 15:38:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-201e52ca0caso29631705ad.3
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 06:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724679507; x=1725284307; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YaPBvKeBftTXdxp+OouV8UzajRq59AXsNfehNldp5QI=;
 b=v69Rbet9oXng55wwGzr8mptD/jH2MNxk+cvNK/8ONC5JhE49MHnCf4MVpbXg+lvCne
 PRga3cOu2WipLFUE77/11Y72JlqwiVVmszuPk/1w+zX6auCAK64DW2OJU/x0mEtuLDWG
 lS9E85tAf/lJrIkBFHwnC3v+WVGGF+YgYj2v1Mw0la8zwnLxlmdUwIYdGNyB2qcKuHxl
 FjP824KdUEoXzHSrZLQZjX2pEwR1dF9yXloAQ8M5IUVGcE7Yr4FKO/kuAFhe1i+mQvsQ
 U8LLx3B1VXdKOH1unocHv5FcQARJHs0Zgse4kb/WbwJXE2HG5Y80c+UTgq5KEbbuRfD2
 D6ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724679507; x=1725284307;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YaPBvKeBftTXdxp+OouV8UzajRq59AXsNfehNldp5QI=;
 b=PC7IFVPOQhXTdaL6yE7Ja29UwCzgP13VqX/FBdJevX0xcvZE5yfAOEw5j0BUv4Zj3I
 SIT7jyAubpa4FpgUmsOXUSOHvvCWiI77TqPZ7H6VhLj8TFnPGTQB5GXUpoH0nXubixZ+
 09IlBu6paLCMBXf5vTSCG9EAfz4Ocp5MSzelR/oVoofubH/P30s/MD289AJ4iK9tPpSm
 w1WCkTET7EAv+cDc6n+uQGSaBMITXl8InmQ77I/k11vammjnTO9cUwUuIqX69vhOfois
 X5WnQBMu7lBOgctNg5FhiVzMCMyzI1uw65WZhmiw2K06IzjMChW/N5zi2HFZHJNUHpz5
 eQGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQostjdk6cN0lWGiLWFBaSW890kHzlx+zfiCKErM9DfzjjJNw1AYDtHwjM23XKCBWpHOxM8Vc=@lists.denx.de
X-Gm-Message-State: AOJu0YxP+LIRq8MFGql0w+evUGFAzvabztdyRbrqoF0Zy6HZ36lpGVF+
 PweMbpW8DYBGl5R1zA0/HrZaDGFHJ//bBU3lIx2vy7HS9Y7RzYRs3uTrCwO9o74F/SgpTjQa0LE
 CPBwd0FCiksnCNLQ0qSb3Xva3hys9Nq35YTdJ+Q==
X-Google-Smtp-Source: AGHT+IEIOrgYmtD0l0Jtwmt+zj/XKIVFqDJtXqG5K2IKyLjQE55DH8Oq3LQLoAIvo6dHP2R86ilE8U0s3sLprpVSqiQ=
X-Received: by 2002:a17:902:ec91:b0:202:2ed:b3a3 with SMTP id
 d9443c01a7336-2039e4c4cbcmr85650295ad.32.1724679506768; Mon, 26 Aug 2024
 06:38:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240809-b4-dynamic-uuid-v7-0-8c44ab1f06a5@linaro.org>
 <20240809-b4-dynamic-uuid-v7-9-8c44ab1f06a5@linaro.org>
In-Reply-To: <20240809-b4-dynamic-uuid-v7-9-8c44ab1f06a5@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 26 Aug 2024 16:37:50 +0300
Message-ID: <CAC_iWj+gjTWu2+h8w8ipeVB2xKxWS6wAEx0QNJiRWtgQSB+Z4w@mail.gmail.com>
Subject: Re: [PATCH v7 09/11] tools: mkeficapsule: support generating dynamic
 GUIDs
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de
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

On Fri, 9 Aug 2024 at 03:56, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Add support for generating GUIDs that match those generated internally
> by U-Boot for capsule update fw_images when using dynamic UUIDs.
>
> Dynamic UUIDs in U-Boot work by taking a namespace UUID and hashing it
> with the board compatible and fw_image name. This feature just provides
> a way to determine the UUIDs for a particular board without having to
> actually boot U-Boot on it.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  doc/mkeficapsule.1   |  23 ++++++++
>  tools/mkeficapsule.c | 156 +++++++++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 174 insertions(+), 5 deletions(-)
>
> diff --git a/doc/mkeficapsule.1 b/doc/mkeficapsule.1
> index c4c2057d5c7a..bf735295effa 100644
> --- a/doc/mkeficapsule.1
> +++ b/doc/mkeficapsule.1
> @@ -9,8 +9,11 @@ mkeficapsule \- Generate EFI capsule file for U-Boot
>  .SH SYNOPSIS
>  .B mkeficapsule
>  .RI [ options ] " " [ image-blob ] " " capsule-file
>
> +.B mkeficapsule
> +.RI guidgen " " [ GUID ] " " DTB " " IMAGE_NAME...
> +
>  .SH "DESCRIPTION"
>  The
>  .B mkeficapsule
>  command is used to create an EFI capsule file to be used by U-Boot for firmware
> @@ -41,8 +44,12 @@ format is the same as used in the new uImage format and allows for
>  multiple binary blobs in a single capsule file.
>  This type of image file can be generated by
>  .BR mkimage .
>
> +mkeficapsule can also be used to simulate the dynamic GUID generation used to
> +identify firmware images in capsule updates by providing the namespace guid, dtb
> +for the board, and a list of firmware images.
> +
>  .SH "OPTIONS"
>
>  .TP
>  .BI "-g\fR,\fB --guid " guid-string
> @@ -112,8 +119,24 @@ at every firmware update.
>  .TP
>  .B "-d\fR,\fB --dump_sig"
>  Dump signature data into *.p7 file
>
> +.SH "GUIDGEN OPTIONS"
> +
> +.TP
> +.B "[GUID]"
> +The namespace/salt GUID, by default this is EFI_CAPSULE_NAMESPACE_GUID.
> +The format is:
> +    xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
> +
> +.TP
> +.B DTB
> +The device tree blob file for the board.
> +
> +.TP
> +.B IMAGE_NAME...
> +The names of the firmware images to generate GUIDs for.
> +
>  .PP
>  .SH FILES
>  .TP
>  .I /EFI/UpdateCapsule
> diff --git a/tools/mkeficapsule.c b/tools/mkeficapsule.c
> index 54fb4dee3ee5..8dfc09ffaf4f 100644
> --- a/tools/mkeficapsule.c
> +++ b/tools/mkeficapsule.c
> @@ -19,12 +19,16 @@
>  #include <gnutls/gnutls.h>
>  #include <gnutls/pkcs7.h>
>  #include <gnutls/abstract.h>
>
> +#include <libfdt.h>
>  #include <u-boot/uuid.h>
>
>  #include "eficapsule.h"
>
> +// Matches CONFIG_EFI_CAPSULE_NAMESPACE_GUID
> +#define DEFAULT_NAMESPACE_GUID "8c9f137e-91dc-427b-b2d6-b420faebaf2a"
> +
>  static const char *tool_name = "mkeficapsule";
>
>  efi_guid_t efi_guid_fm_capsule = EFI_FIRMWARE_MANAGEMENT_CAPSULE_ID_GUID;
>  efi_guid_t efi_guid_cert_type_pkcs7 = EFI_CERT_TYPE_PKCS7_GUID;
> @@ -53,11 +57,23 @@ static struct option options[] = {
>         {"help", no_argument, NULL, 'h'},
>         {NULL, 0, NULL, 0},
>  };
>
> -static void print_usage(void)
> +
> +static void print_usage_guidgen(void)
>  {
> -       fprintf(stderr, "Usage: %s [options] <image blob> <output file>\n"
> +       fprintf(stderr, "%s guidgen [GUID] DTB IMAGE_NAME...\n"
> +               "Options:\n"
> +
> +               "\tGUID                        Namespace GUID (default: %s)\n"
> +               "\tDTB                         Device Tree Blob\n"
> +               "\tIMAGE_NAME...               One or more names of fw_images to generate GUIDs for\n",
> +               tool_name, DEFAULT_NAMESPACE_GUID);
> +}
> +
> +static void print_usage_mkeficapsule(void)
> +{
> +       fprintf(stderr, "Usage: \n\n%s [options] <image blob> <output file>\n"
>                 "Options:\n"
>
>                 "\t-g, --guid <guid string>    guid for image blob type\n"
>                 "\t-i, --index <index>         update image index\n"
> @@ -70,10 +86,11 @@ static void print_usage(void)
>                 "\t-A, --fw-accept  firmware accept capsule, requires GUID, no image blob\n"
>                 "\t-R, --fw-revert  firmware revert capsule, takes no GUID, no image blob\n"
>                 "\t-o, --capoemflag Capsule OEM Flag, an integer between 0x0000 and 0xffff\n"
>                 "\t-D, --dump-capsule          dump the contents of the capsule headers\n"
> -               "\t-h, --help                  print a help message\n",
> +               "\t-h, --help                  print a help message\n\n",
>                 tool_name);
> +       print_usage_guidgen();
>  }
>
>  /**
>   * auth_context - authentication context
> @@ -816,8 +833,130 @@ static void dump_capsule_contents(char *capsule_file)
>                 exit(EXIT_FAILURE);
>         }
>  }
>
> +static struct fdt_header *load_dtb(const char *path)
> +{
> +       struct fdt_header *dtb;
> +       ssize_t dtb_size;
> +       FILE *f;
> +
> +       /* Open and parse DTB */
> +       f = fopen(path, "r");
> +       if (!f) {
> +               fprintf(stderr, "Cannot open %s\n", path);
> +               return NULL;
> +       }
> +
> +       if (fseek(f, 0, SEEK_END)) {
> +               fprintf(stderr, "Cannot seek to the end of %s: %s\n",
> +                       path, strerror(errno));
> +               return NULL;
> +       }
> +
> +       dtb_size = ftell(f);
> +       if (dtb_size < 0) {
> +               fprintf(stderr, "Cannot ftell %s: %s\n",
> +                       path, strerror(errno));
> +               return NULL;
> +       }
> +
> +       fseek(f, 0, SEEK_SET);
> +
> +       dtb = malloc(dtb_size);
> +       if (!dtb) {
> +               fprintf(stderr, "Can't allocated %ld\n", dtb_size);
> +               return NULL;
> +       }
> +
> +       if (fread(dtb, dtb_size, 1, f) != 1) {
> +               fprintf(stderr, "Can't read %ld bytes from %s\n",
> +                       dtb_size, path);
> +               free(dtb);
> +               return NULL;
> +       }
> +
> +       fclose(f);
> +
> +       return dtb;
> +}
> +
> +#define MAX_IMAGE_NAME_LEN 128
> +static int genguid(int argc, char **argv)
> +{
> +       int idx = 2, ret;
> +       unsigned char namespace[16];
> +       struct efi_guid image_type_id;
> +       const char *dtb_path;
> +       struct fdt_header *dtb;
> +       const char *compatible;
> +       int compatlen, namelen;
> +       uint16_t fw_image[MAX_IMAGE_NAME_LEN];
> +
> +       if (argc < 2) {
> +               fprintf(stderr, "Usage: ");
> +               print_usage_guidgen();
> +               return -1;
> +       }
> +
> +       if (uuid_str_to_bin(argv[1], namespace, UUID_STR_FORMAT_GUID)) {
> +               uuid_str_to_bin(DEFAULT_NAMESPACE_GUID, namespace, UUID_STR_FORMAT_GUID);
> +               dtb_path = argv[1];
> +       } else {
> +               dtb_path = argv[2];
> +               idx = 3;
> +       }
> +
> +       if (idx == argc) {
> +               fprintf(stderr, "Usage: ");
> +               print_usage_guidgen();
> +               return -1;
> +       }
> +
> +       dtb = load_dtb(dtb_path);
> +       if (!dtb)
> +               return -1;
> +
> +       if ((ret = fdt_check_header(dtb))) {
> +               fprintf(stderr, "Invalid DTB header: %d\n", ret);
> +               return -1;
> +       }
> +
> +       compatible = fdt_getprop(dtb, 0, "compatible", &compatlen);
> +       if (!compatible) {
> +               fprintf(stderr, "No compatible string found in DTB\n");
> +               return -1;
> +       }
> +       if (strnlen(compatible, compatlen) >= compatlen) {
> +               fprintf(stderr, "Compatible string not null-terminated\n");
> +               return -1;
> +       }
> +
> +       printf("Generating GUIDs for %s with namespace %s:\n",
> +              compatible, DEFAULT_NAMESPACE_GUID);
> +       for (; idx < argc; idx++) {
> +               memset(fw_image, 0, sizeof(fw_image));
> +               namelen = strlen(argv[idx]);
> +               if (namelen > MAX_IMAGE_NAME_LEN) {
> +                       fprintf(stderr, "Image name too long: %s\n", argv[idx]);
> +                       return -1;
> +               }
> +
> +               for (int i = 0; i < namelen; i++)
> +                       fw_image[i] = (uint16_t)argv[idx][i];
> +
> +               gen_v5_guid((struct uuid *)&namespace, &image_type_id,
> +                           compatible, strlen(compatible),
> +                           fw_image, namelen * sizeof(uint16_t),
> +                           NULL);
> +
> +               printf("%s: ", argv[idx]);
> +               print_guid(&image_type_id);
> +       }
> +
> +       return 0;
> +}
> +
>  /**
>   * main - main entry function of mkeficapsule
>   * @argc:      Number of arguments
>   * @argv:      Array of pointers to arguments
> @@ -840,8 +979,15 @@ int main(int argc, char **argv)
>         char *privkey_file, *cert_file;
>         int c, idx;
>         struct fmp_payload_header_params fmp_ph_params = { 0 };
>
> +       /* Generate dynamic GUIDs */
> +       if (argc > 1 && !strcmp(argv[1], "guidgen")) {
> +               if (genguid(argc - 1, argv + 1))
> +                       exit(EXIT_FAILURE);
> +               exit(EXIT_SUCCESS);
> +       }
> +
>         guid = NULL;
>         index = 0;
>         instance = 0;
>         mcount = 0;
> @@ -928,9 +1074,9 @@ int main(int argc, char **argv)
>                 case 'D':
>                         capsule_dump = true;
>                         break;
>                 default:
> -                       print_usage();
> +                       print_usage_mkeficapsule();
>                         exit(EXIT_SUCCESS);
>                 }
>         }
>
> @@ -951,9 +1097,9 @@ int main(int argc, char **argv)
>             (capsule_type != CAPSULE_NORMAL_BLOB &&
>             ((argc != optind + 1) ||
>              ((capsule_type == CAPSULE_ACCEPT) && !guid) ||
>              ((capsule_type == CAPSULE_REVERT) && guid)))) {
> -               print_usage();
> +               print_usage_mkeficapsule();
>                 exit(EXIT_FAILURE);
>         }
>
>         if (capsule_type != CAPSULE_NORMAL_BLOB) {
>
> --
> 2.46.0
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
