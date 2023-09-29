Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B811FE743D5
	for <u-boot@archiver.kernel.org>; Fri, 29 Sep 2023 02:20:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E36886E85;
	Fri, 29 Sep 2023 04:20:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TqhLTSJC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8183786E86; Fri, 29 Sep 2023 04:20:45 +0200 (CEST)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32BAE80EF7
 for <u-boot@lists.denx.de>; Fri, 29 Sep 2023 04:20:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-578d0d94986so9900316a12.2
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 19:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695954041; x=1696558841; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LOf5V4xUEHArGuyO534ITtfW2q6uVAo9Va7kO3OY3tc=;
 b=TqhLTSJCMx8FSta+Ulmt6lZP/4aP2NTUILZlPTsDooKYKPJI5Xw+emqqCHW8KmNlWV
 2JZNDIGgxEV4sxOMjF8Mej7zHIVTHhz37aCRQekhJpLhkhcozBnqKW9pJ3Ue6OBW5tcN
 Vb9Avt2WNZ1H/GaRmPnOYXnav9SPmYyuOnI36ME0hAKOMyks0Ll2QK077CvgxnhzvEE2
 JjCIOo+t+ltesdNiL0WcOuc6HnNm4HVGY+v9dAFZHigGDvMQA2As7g6RkSHRQAZHiQC+
 n39P1BkvRmnQxvF6kKHrP4bu1vYIXv/8yPSjNUQYYFlqu9ucVfduEicuFnUb+S/E4+PO
 rLSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695954041; x=1696558841;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LOf5V4xUEHArGuyO534ITtfW2q6uVAo9Va7kO3OY3tc=;
 b=pSvPCGBy0KWyNT79kh5MuM0+8cR6bxccp5QARaZg9jGFkprX7hYHEIJAKiTcyzvemh
 j9kP64XH/G6ooUXXhnKqZLdWIJSyekvYPLcIK/gTzU4eyv08A3G2aLVg53XZdEubcXfI
 +9CZGhMkthTX2qrbrMtJxxLNddt8e6B/MDbEx/dtUG1/bUQQei2dhMGnYc1SdRNDTsIB
 uWEtoJxHUwTsnBOtHlNUqRtJvA5o8qBuV1z/g1RKCm98b40aqg2gldQJJ/G+DMep9LAa
 +8DqcoDHhtpzQVL9KgarNf5CzdM24p2LX0JB7Nvl14U7dPgY4T8xBKBuTNGYt/J8KSbm
 qIzA==
X-Gm-Message-State: AOJu0YznYiK4bfe0JGj4leiIjPxNitTICV2JS5vV73koTDbGBUppSeNg
 D9i9K76LDzifVLG8rgx+7Fb1v4ePOWh5rf+wybl26A==
X-Google-Smtp-Source: AGHT+IEfB8vkDTbrJ7l0My/Iye8Smln4K5AifZVogUSQdDecxB4ZTmy5/2P1b2ryHIbJO4lEc3zkn664BqLCda3KEyQ=
X-Received: by 2002:a17:90b:33cf:b0:274:bf7a:60cd with SMTP id
 lk15-20020a17090b33cf00b00274bf7a60cdmr2885944pjb.34.1695954041424; Thu, 28
 Sep 2023 19:20:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230927093631.1595494-1-masahisa.kojima@linaro.org>
 <20230927093631.1595494-6-masahisa.kojima@linaro.org>
 <CAD8XO3brLfDuxSQ=gzC9FOAoBF3Xtf_8x95EbPNz52bVeUQLQQ@mail.gmail.com>
In-Reply-To: <CAD8XO3brLfDuxSQ=gzC9FOAoBF3Xtf_8x95EbPNz52bVeUQLQQ@mail.gmail.com>
From: Masahisa Kojima <masahisa.kojima@linaro.org>
Date: Fri, 29 Sep 2023 11:20:30 +0900
Message-ID: <CADQ0-X-NOM-T7sX0KZx0ZcsESuf3bj_JdUvSCkovC7ZFiiU7JQ@mail.gmail.com>
Subject: Re: [PATCH v5 5/7] cmd: efidebug: add uri device path
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>
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

On Thu, 28 Sept 2023 at 23:32, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:
>
>
>
> On Wed, 27 Sept 2023 at 15:38, Masahisa Kojima <masahisa.kojima@linaro.org> wrote:
>>
>> This adds the URI device path option for 'boot add' subcommand.
>> User can add the URI load option for downloading ISO image file
>> or EFI application through network. Currently HTTP is only supported.
>>
>> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
>> ---
>>  cmd/efidebug.c | 50 +++++++++++++++++++++++++++++++++++
>>  include/net.h  |  8 ++++++
>>  net/wget.c     | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 130 insertions(+)
>>
>> diff --git a/cmd/efidebug.c b/cmd/efidebug.c
>> index 0be3af3e76..f2fd6ba71d 100644
>> --- a/cmd/efidebug.c
>> +++ b/cmd/efidebug.c
>> @@ -19,6 +19,7 @@
>>  #include <log.h>
>>  #include <malloc.h>
>>  #include <mapmem.h>
>> +#include <net.h>
>>  #include <part.h>
>>  #include <search.h>
>>  #include <linux/ctype.h>
>> @@ -829,6 +830,52 @@ static int do_efi_boot_add(struct cmd_tbl *cmdtp, int flag,
>>                         argc -= 1;
>>                         argv += 1;
>>                         break;
>> +#if (IS_ENABLED(CONFIG_BLKMAP) && IS_ENABLED(CONFIG_CMD_WGET) && IS_ENABLED(CONFIG_CMD_DNS))
>> +               case 'u':
>> +               {
>> +                       char *pos;
>> +                       int uridp_len;
>> +                       struct efi_device_path_uri *uridp;
>> +
>> +                       if (argc <  3 || lo.label) {
>> +                               r = CMD_RET_USAGE;
>> +                               goto out;
>> +                       }
>> +                       id = (int)hextoul(argv[1], &endp);
>> +                       if (*endp != '\0' || id > 0xffff)
>> +                               return CMD_RET_USAGE;
>> +
>> +                       efi_create_indexed_name(var_name16, sizeof(var_name16),
>> +                                               "Boot", id);
>> +
>> +                       label = efi_convert_string(argv[2]);
>> +                       if (!label)
>> +                               return CMD_RET_FAILURE;
>> +                       lo.label = label;
>> +
>> +                       uridp_len = sizeof(struct efi_device_path) + strlen(argv[3]) + 1;
>> +                       fp_free = efi_alloc(uridp_len + sizeof(END));
>> +                       uridp = (struct efi_device_path_uri *)fp_free;
>> +                       uridp->dp.type = DEVICE_PATH_TYPE_MESSAGING_DEVICE;
>> +                       uridp->dp.sub_type = DEVICE_PATH_SUB_TYPE_MSG_URI;
>> +                       uridp->dp.length = uridp_len;
>> +                       if (!wget_validate_uri(argv[3])) {
>> +                               printf("ERROR: invalid URI\n");
>> +                               r = CMD_RET_FAILURE;
>> +                               goto out;
>> +                       }
>> +
>> +                       strcpy(uridp->uri, argv[3]);
>> +                       pos = (char *)uridp + uridp_len;
>> +                       memcpy(pos, &END, sizeof(END));
>> +                       fp_size += uridp_len + sizeof(END);
>> +                       file_path = (struct efi_device_path *)uridp;
>> +                       argc -= 3;
>> +                       argv += 3;
>> +                       break;
>> +               }
>> +#endif
>> +
>>                 default:
>>                         r = CMD_RET_USAGE;
>>                         goto out;
>> @@ -1492,6 +1539,9 @@ static char efidebug_help_text[] =
>>         "  -b|-B <bootid> <label> <interface> <devnum>[:<part>] <file path>\n"
>>         "  -i|-I <interface> <devnum>[:<part>] <initrd file path>\n"
>>         "  (-b, -i for short form device path)\n"
>> +#if (IS_ENABLED(CONFIG_BLKMAP) && IS_ENABLED(CONFIG_CMD_WGET) && IS_ENABLED(CONFIG_CMD_DNS))
>> +       "  -u <bootid> <label> <uri>\n"
>> +#endif
>>         "  -s '<optional data>'\n"
>>         "efidebug boot rm <bootid#1> [<bootid#2> [<bootid#3> [...]]]\n"
>>         "  - delete UEFI BootXXXX variables\n"
>> diff --git a/include/net.h b/include/net.h
>> index 57889d8b7a..c748974573 100644
>> --- a/include/net.h
>> +++ b/include/net.h
>> @@ -935,4 +935,12 @@ static inline void eth_set_enable_bootdevs(bool enable) {}
>>   */
>>  int wget_with_dns(ulong dst_addr, char *uri);
>>
>> +/**
>> + * wget_validate_uri() - varidate the uri
>> + *
>> + * @uri:       uri string of target file of wget
>> + * Return:     true if uri is valid, false if uri is invalid
>> + */
>> +bool wget_validate_uri(char *uri);
>> +
>>  #endif /* __NET_H__ */
>> diff --git a/net/wget.c b/net/wget.c
>> index 4801e28eb9..6a4d22be32 100644
>> --- a/net/wget.c
>> +++ b/net/wget.c
>> @@ -558,3 +558,75 @@ out:
>>         return ret;
>>  }
>>  #endif
>> +
>> +/**
>> + * wget_validate_uri() - validate the uri for wget
>> + *
>> + * @uri:       uri string
>> + * Return:     true on success, false on failure
>> + */
>
>
> It's better to have a comment description in one place. You already have
> it in the header file.  And even here the text is a little bit differ.

OK, I will add a comment in the function header.

>
>>
>> +bool wget_validate_uri(char *uri)
>> +{
>> +       char c;
>> +       bool ret = true;
>> +       char *str_copy, *s, *authority;
>> +
>> +       /* TODO: strict uri conformance check */
>> +
>> +       /*
>> +        * Uri is expected to be correctly percent encoded.
>> +        * This is the minimum check, control codes(0x1-0x19, 0x7F, except '\0')
>> +        * and space character(0x20) are not allowed.
>> +        */
>> +       for (c = 0x1; c < 0x21; c++) {
>> +               if (strchr(uri, c)) {
>> +                       printf("invalid character is used\n");
>> +                       return false;
>> +               }
>> +       }
>> +       if (strchr(uri, 0x7f)) {
>> +               printf("invalid character is used\n");
>> +               return false;
>> +       }
>
>
> So you validate that only English characters exist in the url. There are urls with non English characters.
I only excluded the control codes and space(0x20), so non-English characters
and UTF-8 encoded URIs can be available.

>
>
>>
>> +
>> +       /*
>> +        * This follows the current U-Boot wget implementation.
>> +        * scheme: only "http:" is supported
>> +        * authority:
>> +        *   - user information: not supported
>> +        *   - host: supported
>> +        *   - port: not supported(always use the default port)
>> +        */
>> +       if (strncmp(uri, "http://", 7)) {
>> +               printf("only http:// is supported\n");
>
>
> log_err()
OK, I will replace other printf() calls.

Thanks,
Masahisa Kojima

>
>>
>> +               return false;
>> +       }
>> +       str_copy = strdup(uri);
>> +       if (!str_copy)
>> +               return false;
>> +
>> +       s = str_copy + strlen("http://");
>> +       authority = strsep(&s, "/");
>> +       if (!s) {
>> +               printf("invalid uri, no file path\n");
>> +               ret = false;
>> +               goto out;
>> +       }
>> +       s = strchr(authority, '@');
>> +       if (s) {
>> +               printf("user information is not supported\n");
>> +               ret = false;
>> +               goto out;
>> +       }
>> +       s = strchr(authority, ':');
>> +       if (s) {
>> +               printf("user defined port is not supported\n");
>> +               ret = false;
>> +               goto out;
>> +       }
>> +
>> +out:
>> +       free(str_copy);
>> +
>> +       return ret;
>> +}
>> --
>> 2.34.1
>>
