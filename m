Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5099C4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 09:09:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C46888527;
	Tue, 23 Apr 2024 11:09:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="B/YzX60p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48006881F3; Tue, 23 Apr 2024 11:09:34 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B5B2881F3
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 11:09:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-56e47843cc7so4825521a12.0
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 02:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713863371; x=1714468171; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OeznMQgODpYk6WsukislHKjxMCgRq9SZMFg5lICcZa0=;
 b=B/YzX60pKAR8+/El8jollqF37FSvV3aFzXql4/V62/mm9j7oRaEE2O36xG4d9ybLzD
 dKrD/TcI6AtSDX4qToeULSO8Fryn/3eyfa8OcRkiM/cDwGo2iSVjAmAaZUFYS5oIMJQ2
 LxEuDUPmDN2CGU0Mzh/3itm2ZW6z32kVRNQh5rdSPpv13X3N4yz8JzWMZW0SL9QuG0uz
 Skt94M3pMljqO302H2zHR8LHDhvX91rELA/E8SUZuB9z+ghx+1c13cb4s1Zdk0mSJVoe
 FpMuX7lP0sg+BOW081Yk7XNguFmN5jZ7UPZ05oGi6EhKNt7snZpHZSoHsmYx2zBrjD3K
 tLBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713863371; x=1714468171;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OeznMQgODpYk6WsukislHKjxMCgRq9SZMFg5lICcZa0=;
 b=tAIVSVZmGpShLgX1TukZ8Wa0zn/C0mZ4Pab84nLgkwt+z3k9o4gyTM+c26ei5ChuhM
 3ZSHeGZ0a1oGKmk+/g1eBRPdy/6YHEU1amDtt23XlNPVrj1B47zYLOOYMLHAk/AU4tvK
 OevjHwu2W312kq/j7F3FdQnNc4Xhhp4EtpQzmLiKrIQuHoJTXHYc12xtmcRprcNOjbzP
 uhHORy9S6REkn3c5d+wizf83ERgM9V5dyyhW1+jU6L97+K69rpKjEtCHSGyFlKPh+UGk
 3mjZguHrk1VY1vlHcVqM+lVTdfpboELW3PM+cGPlssUfbKlZY/Gl+x6HY52hGpHh/ru6
 rBew==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7VeXPbrKFk0AWQlq7SoKbxJXZFa1nq6D1p6ZiqKmHdxpeqQcaUK7u9oDa79I1cUuvITXisiFtq2JvD+e7GkrbE9RG6A==
X-Gm-Message-State: AOJu0YyEqyY4B4IQYG3DPKHS+9PaWY4aEg/PdyswZKHnQfq/g2ERR0qR
 6EgohtqDsOoQcXxRqUVFvlJgxANZIYnQBM8+1RQV2A+VfSLvoQS09RthP0jE8bK4fTtfDkBR87Y
 iv1Qmnwlmg4IZpwgnxvAbWBLpcHQNbngaYBpg2g==
X-Google-Smtp-Source: AGHT+IHxyYEQga/kFUqClFp6hJu1DDusBecvzuy7uGY3kl5ozUI3DSoCoIb+tyMUXLgRihnuqmoQaohLCNX8FvSDJPg=
X-Received: by 2002:a50:d5ce:0:b0:568:bfcd:e895 with SMTP id
 g14-20020a50d5ce000000b00568bfcde895mr6846501edj.41.1713863370662; Tue, 23
 Apr 2024 02:09:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240419065542.1160527-1-sughosh.ganu@linaro.org>
 <20240419065542.1160527-2-sughosh.ganu@linaro.org>
 <d50d88c9-445e-45cb-936b-0c1fac2cf8ad@gmx.de>
In-Reply-To: <d50d88c9-445e-45cb-936b-0c1fac2cf8ad@gmx.de>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 23 Apr 2024 14:39:18 +0530
Message-ID: <CADg8p96ZZrMFvFvaLYaHytCH=dMTAt67yvRF7+68axyxcwv1-Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] tools: mkeficapsule: Add support for parsing
 capsule params from config file
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

hi Heinrich,

On Fri, 19 Apr 2024 at 12:44, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 19.04.24 08:55, Sughosh Ganu wrote:
> > Add support for specifying the parameters needed for capsule
> > generation through a config file, instead of passing them through
> > command-line. Parameters for more than a single capsule file can be
> > specified, resulting in generation of multiple capsules through a
> > single invocation of the command.
> >
> > The config file can be passed to the mkeficapsule tool in such manner
> >
> >   $ ./tools/mkeficapsule -f <path/to/the/config/file>
>
> Please, mention the long option.

Okay

>
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> >   tools/Kconfig              |  15 ++
> >   tools/Makefile             |   1 +
> >   tools/eficapsule.h         | 114 ++++++++++++
> >   tools/mkeficapsule.c       |  87 +++++----
> >   tools/mkeficapsule_parse.c | 352 +++++++++++++++++++++++++++++++++++++
> >   5 files changed, 538 insertions(+), 31 deletions(-)
> >   create mode 100644 tools/mkeficapsule_parse.c
> >
> > diff --git a/tools/Kconfig b/tools/Kconfig
> > index 667807b331..0362ca8e45 100644
> > --- a/tools/Kconfig
> > +++ b/tools/Kconfig
> > @@ -104,6 +104,21 @@ config TOOLS_MKEFICAPSULE
> >         optionally sign that file. If you want to enable UEFI capsule
> >         update feature on your target, you certainly need this.
> >
> > +config EFI_CAPSULE_CFG_FILE
> > +     string "Path to the EFI Capsule Config File"
> > +     help
> > +       Path to the EFI capsule config file which provides the
> > +       parameters needed to build capsule(s). Parameters can be
> > +       provided for multiple payloads resulting in corresponding
> > +       capsule images being generated.
>
> This help test does not explain if this is a parameter for binman or
> something built into mkeficapsule.
>
> We should not hard code any path inside mkeficapsule.
>
> I can't see the new CONFIG parameters used within the code changes of
> this patch. Please, add them into the patches where they are needed.

As discussed over IRC, I need these config options only for the CI
testing. I will replace these with hard-coded paths for the tests.

>
> > +
> > +config EFI_USE_CAPSULE_CFG_FILE
> > +     bool "Use the config file for generating capsules"
> > +     help
> > +       Boolean option used to specify if the EFI capsules are to
> > +       be generated through parameters specified via the config
> > +       file or through command line.
>
> Given this help text I would not know if this option changes how
> mkeficapsule is built or how binman invokes it.
>
> I would expect that mkeficapsule is always built in a way that a
> configuration file can be passed.
>
> Furthermore I would expect binman to invoke mkeficapsule with the
> appropriate command line parameters if you have enabled building capsules.
>
> Why do we need this configuration parameter? Just always build
> mkeficapsule with support for the -f parameter.

Will remove these config flags.

-sughosh

>
> Best regards
>
> Heinrich
>
> > +
> >   menuconfig FSPI_CONF_HEADER
> >       bool "FlexSPI Header Configuration"
> >       help
> > diff --git a/tools/Makefile b/tools/Makefile
> > index 6a4280e366..4311f5914f 100644
> > --- a/tools/Makefile
> > +++ b/tools/Makefile
> > @@ -253,6 +253,7 @@ HOSTLDLIBS_mkeficapsule += \
> >   HOSTLDLIBS_mkeficapsule += \
> >       $(shell pkg-config --libs uuid 2> /dev/null || echo "-luuid")
> >   hostprogs-$(CONFIG_TOOLS_MKEFICAPSULE) += mkeficapsule
> > +mkeficapsule-objs := mkeficapsule.o mkeficapsule_parse.o
> >
> >   mkfwumdata-objs := mkfwumdata.o generated/lib/crc32.o
> >   HOSTLDLIBS_mkfwumdata += -luuid
> > diff --git a/tools/eficapsule.h b/tools/eficapsule.h
> > index 6efd07d2eb..71a08b62e6 100644
> > --- a/tools/eficapsule.h
> > +++ b/tools/eficapsule.h
> > @@ -54,6 +54,12 @@ typedef struct {
> >   /* flags */
> >   #define CAPSULE_FLAGS_PERSIST_ACROSS_RESET      0x00010000
> >
> > +enum capsule_type {
> > +     CAPSULE_NORMAL_BLOB = 0,
> > +     CAPSULE_ACCEPT,
> > +     CAPSULE_REVERT,
> > +};
> > +
> >   struct efi_capsule_header {
> >       efi_guid_t capsule_guid;
> >       uint32_t header_size;
> > @@ -145,4 +151,112 @@ struct fmp_payload_header_params {
> >       uint32_t fw_version;
> >   };
> >
> > +/**
> > + * struct efi_capsule_params - Capsule parameters
> > + * @image_guid: Guid value of the payload input image
> > + * @image_index: Image index value
> > + * @hardware_instance: Hardware instance to be used for the image
> > + * @fmp: FMP payload header used for storing firmware version
> > + * @monotonic_count: Monotonic count value to be used for signed capsule
> > + * @privkey_file: Path to private key used in capsule signing
> > + * @cert_file: Path to public key certificate used in capsule signing
> > + * @input_file: Path to payload input image
> > + * @capsule_file: Path to the output capsule file
> > + * @oemflags: Oemflags to be populated in the capsule header
> > + * @capsule: Capsule Type, normal or accept or revert
> > + */
> > +struct efi_capsule_params {
> > +     efi_guid_t *image_guid;
> > +     unsigned long image_index;
> > +     unsigned long hardware_instance;
> > +     struct fmp_payload_header_params fmp;
> > +     uint64_t monotonic_count;
> > +     char *privkey_file;
> > +     char *cert_file;
> > +     char *input_file;
> > +     char *capsule_file;
> > +     unsigned long oemflags;
> > +     enum capsule_type capsule;
> > +};
> > +
> > +/**
> > + * capsule_with_cfg_file() - Generate capsule from config file
> > + * @cfg_file: Path to the config file
> > + *
> > + * Parse the capsule parameters from the config file and use the
> > + * parameters for generating one or more capsules.
> > + *
> > + * Return: None
> > + *
> > + */
> > +void capsule_with_cfg_file(const char *cfg_file);
> > +
> > +/**
> > + * convert_uuid_to_guid() - convert UUID to GUID
> > + * @buf:     UUID binary
> > + *
> > + * UUID and GUID have the same data structure, but their binary
> > + * formats are different due to the endianness. See lib/uuid.c.
> > + * Since uuid_parse() can handle only UUID, this function must
> > + * be called to get correct data for GUID when parsing a string.
> > + *
> > + * The correct data will be returned in @buf.
> > + */
> > +void convert_uuid_to_guid(unsigned char *buf);
> > +
> > +/**
> > + * create_empty_capsule() - Generate an empty capsule
> > + * @path: Path to the empty capsule file to be generated
> > + * @guid: Guid value of the image for which empty capsule is generated
> > + * @fw_accept: Flag to specify whether to generate accept or revert capsule
> > + *
> > + * Generate an empty capsule, either an accept or a revert capsule to be
> > + * used to flag acceptance or rejection of an earlier executed firmware
> > + * update operation. Being used in the FWU Multi Bank firmware update
> > + * feature.
> > + *
> > + * Return: 0 if OK, -ve on error
> > + *
> > + */
> > +int create_empty_capsule(char *path, efi_guid_t *guid, bool fw_accept);
> > +
> > +/**
> > + * create_fwbin - create an uefi capsule file
> > + * @path:    Path to a created capsule file
> > + * @bin:     Path to a firmware binary to encapsulate
> > + * @guid:    GUID of related FMP driver
> > + * @index:   Index number in capsule
> > + * @instance:        Instance number in capsule
> > + * @fmp:     FMP header params
> > + * @mcount:  Monotonic count in authentication information
> > + * @private_file:    Path to a private key file
> > + * @cert_file:       Path to a certificate file
> > + * @oemflags:  Capsule OEM Flags, bits 0-15
> > + *
> > + * This function actually does the job of creating an uefi capsule file.
> > + * All the arguments must be supplied.
> > + * If either @private_file ror @cert_file is NULL, the capsule file
> > + * won't be signed.
> > + *
> > + * Return:
> > + * * 0  - on success
> > + * * -1 - on failure
> > + */
> > +int create_fwbin(char *path, char *bin, efi_guid_t *guid,
> > +              unsigned long index, unsigned long instance,
> > +              struct fmp_payload_header_params *fmp_ph_params,
> > +              uint64_t mcount, char *privkey_file, char *cert_file,
> > +              uint16_t oemflags);
> > +
> > +/**
> > + * print_usage() - Print the command usage string
> > + *
> > + * Prints the standard command usage string. Called in the case
> > + * of incorrect parameters being passed to the tool.
> > + *
> > + * Return: None
> > + *
> > + */
> > +void print_usage(void);
> > +
> >   #endif /* _EFI_CAPSULE_H */
> > diff --git a/tools/mkeficapsule.c b/tools/mkeficapsule.c
> > index 6a261ff549..480cedfa5e 100644
> > --- a/tools/mkeficapsule.c
> > +++ b/tools/mkeficapsule.c
> > @@ -28,13 +28,7 @@ static const char *tool_name = "mkeficapsule";
> >   efi_guid_t efi_guid_fm_capsule = EFI_FIRMWARE_MANAGEMENT_CAPSULE_ID_GUID;
> >   efi_guid_t efi_guid_cert_type_pkcs7 = EFI_CERT_TYPE_PKCS7_GUID;
> >
> > -static const char *opts_short = "g:i:I:v:p:c:m:o:dhARD";
> > -
> > -enum {
> > -     CAPSULE_NORMAL_BLOB = 0,
> > -     CAPSULE_ACCEPT,
> > -     CAPSULE_REVERT,
> > -} capsule_type;
> > +static const char *opts_short = "g:i:I:v:p:c:m:o:f:dhARD";
> >
> >   static struct option options[] = {
> >       {"guid", required_argument, NULL, 'g'},
> > @@ -49,11 +43,21 @@ static struct option options[] = {
> >       {"fw-revert", no_argument, NULL, 'R'},
> >       {"capoemflag", required_argument, NULL, 'o'},
> >       {"dump-capsule", no_argument, NULL, 'D'},
> > +     {"cfg-file", required_argument, NULL, 'f'},
> >       {"help", no_argument, NULL, 'h'},
> >       {NULL, 0, NULL, 0},
> >   };
> >
> > -static void print_usage(void)
> > +/**
> > + * print_usage() - Print the command usage string
> > + *
> > + * Prints the standard command usage string. Called in the case
> > + * of incorrect parameters being passed to the tool.
> > + *
> > + * Return: None
> > + *
> > + */
> > +void print_usage(void)
> >   {
> >       fprintf(stderr, "Usage: %s [options] <image blob> <output file>\n"
> >               "Options:\n"
> > @@ -70,6 +74,7 @@ static void print_usage(void)
> >               "\t-R, --fw-revert  firmware revert capsule, takes no GUID, no image blob\n"
> >               "\t-o, --capoemflag Capsule OEM Flag, an integer between 0x0000 and 0xffff\n"
> >               "\t-D, --dump-capsule          dump the contents of the capsule headers\n"
> > +             "\t-f, --cfg-file <config file> config file with capsule parameters\n"
> >               "\t-h, --help                  print a help message\n",
> >               tool_name);
> >   }
> > @@ -389,6 +394,7 @@ static void free_sig_data(struct auth_context *ctx)
> >    * @guid:   GUID of related FMP driver
> >    * @index:  Index number in capsule
> >    * @instance:       Instance number in capsule
> > + * @fmp:     FMP header params
> >    * @mcount: Monotonic count in authentication information
> >    * @private_file:   Path to a private key file
> >    * @cert_file:      Path to a certificate file
> > @@ -403,11 +409,11 @@ static void free_sig_data(struct auth_context *ctx)
> >    * * 0  - on success
> >    * * -1 - on failure
> >    */
> > -static int create_fwbin(char *path, char *bin, efi_guid_t *guid,
> > -                     unsigned long index, unsigned long instance,
> > -                     struct fmp_payload_header_params *fmp_ph_params,
> > -                     uint64_t mcount, char *privkey_file, char *cert_file,
> > -                     uint16_t oemflags)
> > +int create_fwbin(char *path, char *bin, efi_guid_t *guid,
> > +              unsigned long index, unsigned long instance,
> > +              struct fmp_payload_header_params *fmp_ph_params,
> > +              uint64_t mcount, char *privkey_file, char *cert_file,
> > +              uint16_t oemflags)
> >   {
> >       struct efi_capsule_header header;
> >       struct efi_firmware_management_capsule_header capsule;
> > @@ -605,7 +611,21 @@ void convert_uuid_to_guid(unsigned char *buf)
> >       buf[7] = c;
> >   }
> >
> > -static int create_empty_capsule(char *path, efi_guid_t *guid, bool fw_accept)
> > +/**
> > + * create_empty_capsule() - Generate an empty capsule
> > + * @path: Path to the empty capsule file to be generated
> > + * @guid: Guid value of the image for which empty capsule is generated
> > + * @fw_accept: Flag to specify whether to generate accept or revert capsule
> > + *
> > + * Generate an empty capsule, either an accept or a revert capsule to be
> > + * used to flag acceptance or rejection of an earlier executed firmware
> > + * update operation. Being used in the FWU Multi Bank firmware update
> > + * feature.
> > + *
> > + * Return: 0 if OK, -ve on error
> > + *
> > + */
> > +int create_empty_capsule(char *path, efi_guid_t *guid, bool fw_accept)
> >   {
> >       struct efi_capsule_header header = { 0 };
> >       FILE *f = NULL;
> > @@ -878,6 +898,8 @@ int main(int argc, char **argv)
> >       unsigned long oemflags;
> >       bool capsule_dump;
> >       char *privkey_file, *cert_file;
> > +     char *cfg_file;
> > +     enum capsule_type capsule;
> >       int c, idx;
> >       struct fmp_payload_header_params fmp_ph_params = { 0 };
> >
> > @@ -888,8 +910,9 @@ int main(int argc, char **argv)
> >       privkey_file = NULL;
> >       cert_file = NULL;
> >       capsule_dump = false;
> > +     cfg_file = NULL;
> >       dump_sig = 0;
> > -     capsule_type = CAPSULE_NORMAL_BLOB;
> > +     capsule = CAPSULE_NORMAL_BLOB;
> >       oemflags = 0;
> >       for (;;) {
> >               c = getopt_long(argc, argv, opts_short, options, &idx);
> > @@ -943,20 +966,20 @@ int main(int argc, char **argv)
> >                       dump_sig = 1;
> >                       break;
> >               case 'A':
> > -                     if (capsule_type) {
> > +                     if (capsule) {
> >                               fprintf(stderr,
> >                                       "Select either of Accept or Revert capsule generation\n");
> >                               exit(1);
> >                       }
> > -                     capsule_type = CAPSULE_ACCEPT;
> > +                     capsule = CAPSULE_ACCEPT;
> >                       break;
> >               case 'R':
> > -                     if (capsule_type) {
> > +                     if (capsule) {
> >                               fprintf(stderr,
> >                                       "Select either of Accept or Revert capsule generation\n");
> >                               exit(1);
> >                       }
> > -                     capsule_type = CAPSULE_REVERT;
> > +                     capsule = CAPSULE_REVERT;
> >                       break;
> >               case 'o':
> >                       oemflags = strtoul(optarg, NULL, 0);
> > @@ -969,6 +992,10 @@ int main(int argc, char **argv)
> >               case 'D':
> >                       capsule_dump = true;
> >                       break;
> > +             case 'f':
> > +                     cfg_file = optarg;
> > +                     capsule_with_cfg_file(cfg_file);
> > +                     exit(EXIT_SUCCESS);
> >               default:
> >                       print_usage();
> >                       exit(EXIT_SUCCESS);
> > @@ -985,21 +1012,21 @@ int main(int argc, char **argv)
> >       }
> >
> >       /* check necessary parameters */
> > -     if ((capsule_type == CAPSULE_NORMAL_BLOB &&
> > -         ((argc != optind + 2) || !guid ||
> > -          ((privkey_file && !cert_file) ||
> > -           (!privkey_file && cert_file)))) ||
> > -         (capsule_type != CAPSULE_NORMAL_BLOB &&
> > -         ((argc != optind + 1) ||
> > -          ((capsule_type == CAPSULE_ACCEPT) && !guid) ||
> > -          ((capsule_type == CAPSULE_REVERT) && guid)))) {
> > +     if ((capsule == CAPSULE_NORMAL_BLOB &&
> > +          ((argc != optind + 2) || !guid ||
> > +           ((privkey_file && !cert_file) ||
> > +            (!privkey_file && cert_file)))) ||
> > +         (capsule != CAPSULE_NORMAL_BLOB &&
> > +          ((argc != optind + 1) ||
> > +           (capsule == CAPSULE_ACCEPT && !guid) ||
> > +           (capsule == CAPSULE_REVERT && guid)))) {
> >               print_usage();
> >               exit(EXIT_FAILURE);
> >       }
> >
> > -     if (capsule_type != CAPSULE_NORMAL_BLOB) {
> > +     if (capsule != CAPSULE_NORMAL_BLOB) {
> >               if (create_empty_capsule(argv[argc - 1], guid,
> > -                                      capsule_type == CAPSULE_ACCEPT) < 0) {
> > +                                      capsule == CAPSULE_ACCEPT) < 0) {
> >                       fprintf(stderr, "Creating empty capsule failed\n");
> >                       exit(EXIT_FAILURE);
> >               }
> > @@ -1009,6 +1036,4 @@ int main(int argc, char **argv)
> >               fprintf(stderr, "Creating firmware capsule failed\n");
> >               exit(EXIT_FAILURE);
> >       }
> > -
> > -     exit(EXIT_SUCCESS);
> >   }
> > diff --git a/tools/mkeficapsule_parse.c b/tools/mkeficapsule_parse.c
> > new file mode 100644
> > index 0000000000..0b010706d5
> > --- /dev/null
> > +++ b/tools/mkeficapsule_parse.c
> > @@ -0,0 +1,352 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright 2023 Linaro Limited
> > + */
> > +
> > +/*
> > + * The code in this file adds parsing ability to the mkeficapsule
> > + * tool. This allows specifying parameters needed to build the capsule
> > + * through the config file instead of specifying them on the command-line.
> > + * Parameters can be specified for more than one payload, generating the
> > + * corresponding capsule files.
> > + *
> > + * The parameters are specified in a "key:value" pair. All the parameters
> > + * that are currently supported by the mkeficapsule tool can be specified
> > + * in the config file.
> > + *
> > + * The example below shows four payloads. The first payload is an example
> > + * of generating a signed capsule. The second payload is an example of
> > + * generating an unsigned capsule. The third payload is an accept empty
> > + * capsule, while the fourth payload is the revert empty capsule, used
> > + * for the multi-bank firmware update feature.
> > + *
> > + * This functionality can be easily extended to generate a single capsule
> > + * comprising multiple payloads.
> > +
> > +     {
> > +         image-guid: 02f4d760-cfd5-43bd-8e2d-a42acb33c660
> > +         hardware-instance: 0
> > +         monotonic-count: 1
> > +         payload: u-boot.bin
> > +         fw-version: 2
> > +         image-index: 1
> > +         private-key: /path/to/priv/key
> > +         pub-key-cert: /path/to/pub/key
> > +         capsule: u-boot.capsule
> > +     }
> > +     {
> > +         image-guid: 4ce292da-1dd8-428d-a1c2-77743ef8b96e
> > +         hardware-instance: 0
> > +         payload: u-boot.itb
> > +         image-index: 2
> > +         fw-version: 10
> > +         oemflags: 0x8000
> > +         capsule: fit.capsule
> > +     }
> > +     {
> > +         capsule-type: accept
> > +         image-guid: 4ce292da-1dd8-428d-a1c2-77743ef8b96e
> > +         capsule: accept.capsule
> > +     }
> > +     {
> > +         capsule-type: revert
> > +         capsule: revert.capsule
> > +     }
> > +*/
> > +
> > +#include <ctype.h>
> > +#include <limits.h>
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +
> > +#include <uuid/uuid.h>
> > +
> > +#include "eficapsule.h"
> > +
> > +#define PARAMS_START "{"
> > +#define PARAMS_END   "}"
> > +
> > +#define PSTART               2
> > +#define PEND         3
> > +
> > +#define MALLOC_FAIL_STR              "Unable to allocate memory\n"
> > +
> > +#define ARRAY_SIZE(x)                (sizeof(x) / sizeof((x)[0]))
> > +
> > +const char *capsule_params[] = {
> > +     "image-guid", "image-index", "private-key",
> > +     "pub-key-cert", "payload", "capsule",
> > +     "hardware-instance", "monotonic-count",
> > +     "capsule-type", "oemflags", "fw-version" };
> > +
> > +static unsigned char params_start;
> > +static unsigned char params_end;
> > +
> > +static void print_and_exit(const char *str)
> > +{
> > +     fprintf(stderr, "%s", str);
> > +     exit(EXIT_FAILURE);
> > +}
> > +
> > +static int param_delim_checks(char *line, unsigned char *token)
> > +{
> > +     if (!strcmp(line, PARAMS_START)) {
> > +             if (params_start || !params_end) {
> > +                     fprintf(stderr, "Earlier params processing still in progress. ");
> > +                     fprintf(stderr, "Can't start processing a new params.\n");
> > +                     exit(EXIT_FAILURE);
> > +             } else {
> > +                     params_start = 1;
> > +                     params_end = 0;
> > +                     *token = PSTART;
> > +                     return 1;
> > +             }
> > +     } else if (!strcmp(line, PARAMS_END)) {
> > +             if (!params_start) {
> > +                     fprintf(stderr, "Cannot put end braces without start braces. ");
> > +                     fprintf(stderr, "Please check the documentation for reference config file syntax\n");
> > +                     exit(EXIT_FAILURE);
> > +             } else {
> > +                     params_start = 0;
> > +                     params_end = 1;
> > +                     *token = PEND;
> > +                     return 1;
> > +             }
> > +     } else if (!params_start) {
> > +             fprintf(stderr, "Params should be passed within braces. ");
> > +             fprintf(stderr, "Please check the documentation for reference config file syntax\n");
> > +             exit(EXIT_FAILURE);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static void add_guid(efi_guid_t **guid_param, char *guid)
> > +{
> > +     unsigned char uuid_buf[16];
> > +
> > +     *guid_param = malloc(sizeof(efi_guid_t));
> > +     if (!*guid_param)
> > +             print_and_exit(MALLOC_FAIL_STR);
> > +
> > +     if (uuid_parse(guid, uuid_buf))
> > +             print_and_exit("Wrong guid format\n");
> > +
> > +     convert_uuid_to_guid(uuid_buf);
> > +     memcpy(*guid_param, uuid_buf, sizeof(efi_guid_t));
> > +}
> > +
> > +static void add_string(char **dst, char *val)
> > +{
> > +     *dst = strdup(val);
> > +     if (!*dst)
> > +             print_and_exit(MALLOC_FAIL_STR);
> > +}
> > +
> > +static void match_and_populate_param(char *key, char *val,
> > +                                  struct efi_capsule_params *param)
> > +{
> > +     int i;
> > +
> > +     for (i = 0; i < ARRAY_SIZE(capsule_params); i++) {
> > +             if (!strcmp(key, capsule_params[i])) {
> > +                     switch (i) {
> > +                     case 0:
> > +                             add_guid(&param->image_guid, val);
> > +                             return;
> > +                     case 1:
> > +                             param->image_index = strtoul(val, NULL, 0);
> > +                             if (param->image_index == ULONG_MAX)
> > +                                     print_and_exit("Enter a valid value of index bewtween 1-255");
> > +                             return;
> > +                     case 2:
> > +                             add_string(&param->privkey_file, val);
> > +                             return;
> > +                     case 3:
> > +                             add_string(&param->cert_file, val);
> > +                             return;
> > +                     case 4:
> > +                             add_string(&param->input_file, val);
> > +                             return;
> > +                     case 5:
> > +                             add_string(&param->capsule_file, val);
> > +                             return;
> > +                     case 6:
> > +                             param->hardware_instance = strtoul(val, NULL, 0);
> > +                             if (param->hardware_instance == ULONG_MAX)
> > +                                     print_and_exit("Enter a valid hardware instance value");
> > +                             return;
> > +                     case 7:
> > +                             param->monotonic_count = strtoull(val, NULL, 0);
> > +                             if (param->monotonic_count == ULLONG_MAX)
> > +                                     print_and_exit("Enter a valid monotonic count value");
> > +                             return;
> > +                     case 8:
> > +                             if (!strcmp(val, "normal"))
> > +                                     param->capsule = CAPSULE_NORMAL_BLOB;
> > +                             else if (!strcmp(val, "accept"))
> > +                                     param->capsule = CAPSULE_ACCEPT;
> > +                             else if (!strcmp(val, "revert"))
> > +                                     param->capsule = CAPSULE_REVERT;
> > +                             else
> > +                                     print_and_exit("Invalid type of capsule");
> > +
> > +                             return;
> > +                     case 9:
> > +                             param->oemflags = strtoul(val, NULL, 0);
> > +                             if (param->oemflags > 0xffff)
> > +                                     print_and_exit("OemFlags must be between 0x0 and 0xffff\n");
> > +                             return;
> > +                     case 10:
> > +                             param->fmp.fw_version = strtoul(val, NULL, 0);
> > +                             param->fmp.have_header = true;
> > +                             return;
> > +                     }
> > +             }
> > +     }
> > +
> > +     fprintf(stderr, "Undefined param %s specified. ", key);
> > +     fprintf(stderr, "Please check the documentation for reference config file syntax\n");
> > +     exit(EXIT_FAILURE);
> > +}
> > +
> > +static int get_capsule_params(char *line, struct efi_capsule_params *params)
> > +{
> > +     char *key = NULL;
> > +     char *val = NULL;
> > +     unsigned char token;
> > +
> > +     if (param_delim_checks(line, &token))
> > +             return token;
> > +
> > +     key = strtok(line, ":");
> > +     if (key)
> > +             val = strtok(NULL, "\0");
> > +     else
> > +             print_and_exit("Expect the params in a key:value pair\n");
> > +
> > +     match_and_populate_param(key, val, params);
> > +
> > +     return 0;
> > +}
> > +
> > +static char *skip_whitespace(char *line)
> > +{
> > +     char *ptr, *newline;
> > +
> > +     ptr = malloc(strlen(line) + 1);
> > +     if (!ptr)
> > +             print_and_exit(MALLOC_FAIL_STR);
> > +
> > +     for (newline = ptr; *line; line++)
> > +             if (!isblank(*line))
> > +                     *ptr++ = *line;
> > +     *ptr = '\0';
> > +     return newline;
> > +}
> > +
> > +static int parse_capsule_payload_params(FILE *fp, struct efi_capsule_params *params)
> > +{
> > +     char *line = NULL;
> > +     char *newline;
> > +     size_t n = 0;
> > +     ssize_t len;
> > +
> > +     while ((len = getline(&line, &n, fp)) != -1) {
> > +             if (len == 1 && line[len - 1] == '\n')
> > +                     continue;
> > +
> > +             line[len - 1] = '\0';
> > +
> > +             newline = skip_whitespace(line);
> > +
> > +             if (newline[0] == '#')
> > +                     continue;
> > +
> > +             if (get_capsule_params(newline, params) == PEND)
> > +                     return 0;
> > +     }
> > +
> > +     if (errno == EINVAL || errno == ENOMEM) {
> > +             fprintf(stderr, "getline() returned an error %s reading the line\n",
> > +                     strerror(errno));
> > +             exit(EXIT_FAILURE);
> > +     } else if (params_start == 1 || params_end == 0) {
> > +             fprintf(stderr, "Params should be passed within braces. ");
> > +             fprintf(stderr, "Please check the documentation for reference config file syntax\n");
> > +             exit(EXIT_FAILURE);
> > +     } else {
> > +             return -1;
> > +     }
> > +}
> > +
> > +static void params_dependency_check(struct efi_capsule_params *params)
> > +{
> > +     /* check necessary parameters */
> > +     if ((params->capsule == CAPSULE_NORMAL_BLOB &&
> > +          ((!params->input_file || !params->capsule_file ||
> > +            !params->image_guid) ||
> > +           ((params->privkey_file && !params->cert_file) ||
> > +            (!params->privkey_file && params->cert_file)))) ||
> > +         (params->capsule != CAPSULE_NORMAL_BLOB &&
> > +          (!params->capsule_file ||
> > +           (params->capsule == CAPSULE_ACCEPT && !params->image_guid) ||
> > +           (params->capsule == CAPSULE_REVERT && params->image_guid)))) {
> > +             print_usage();
> > +             exit(EXIT_FAILURE);
> > +     }
> > +}
> > +
> > +static void generate_capsule(struct efi_capsule_params *params)
> > +{
> > +     if (params->capsule != CAPSULE_NORMAL_BLOB) {
> > +             if (create_empty_capsule(params->capsule_file,
> > +                                      params->image_guid,
> > +                                      params->capsule ==
> > +                                      CAPSULE_ACCEPT) < 0)
> > +                     print_and_exit("Creating empty capsule failed\n");
> > +     } else if (create_fwbin(params->capsule_file, params->input_file,
> > +                             params->image_guid, params->image_index,
> > +                             params->hardware_instance,
> > +                             &params->fmp,
> > +                             params->monotonic_count,
> > +                             params->privkey_file,
> > +                             params->cert_file,
> > +                             (uint16_t)params->oemflags) < 0) {
> > +             print_and_exit("Creating firmware capsule failed\n");
> > +     }
> > +}
> > +
> > +/**
> > + * capsule_with_cfg_file() - Generate capsule from config file
> > + * @cfg_file: Path to the config file
> > + *
> > + * Parse the capsule parameters from the config file and use the
> > + * parameters for generating one or more capsules.
> > + *
> > + * Return: None
> > + *
> > + */
> > +void capsule_with_cfg_file(const char *cfg_file)
> > +{
> > +     FILE *fp;
> > +     struct efi_capsule_params params = { 0 };
> > +
> > +     fp = fopen(cfg_file, "r");
> > +     if (!fp) {
> > +             fprintf(stderr, "Unable to open the capsule config file %s\n",
> > +                     cfg_file);
> > +             exit(EXIT_FAILURE);
> > +     }
> > +
> > +     params_start = 0;
> > +     params_end = 1;
> > +
> > +     while (parse_capsule_payload_params(fp, &params) != -1) {
> > +             params_dependency_check(&params);
> > +             generate_capsule(&params);
> > +
> > +             memset(&params, 0, sizeof(struct efi_capsule_params));
> > +     }
> > +}
>
