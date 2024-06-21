Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47A00C27C4F
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 05:51:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAB1687FF7;
	Fri, 21 Jun 2024 07:51:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nhCzrNDS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBB1688093; Fri, 21 Jun 2024 07:51:20 +0200 (CEST)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75B0E87FBC
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 07:51:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2c7da220252so1374905a91.1
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 22:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718949077; x=1719553877; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=C46k3CvHvnciE+CXQXC7azc+6l/2m9A+ACn+crFmDvM=;
 b=nhCzrNDSBdV7XPoP7oAgpRbYSKSBW83Q54XhpOIldWmiFNNvRGDELb2XFsAUxrRK4P
 26T1sewBcxuYQNqDTD7eH+5xkbj2fL3HhvqDxGGc+xXDlBcEi6a5t7ojQFEz980CF0+q
 fdaiM2UFlkP5n4Jl5S7SDLWnQQ3aE1paUpIAX+897w8y3xJpM2GORF+u2DvVmuwtEI7T
 9PxwpB2TqZSjIr5wrOPVtxRt077Y9DtOH/HFvi7D+Mtb/NDXEg0EsGRi5A2KRhyEptjp
 6jzIiz1In70VI0xEYibZFWhdUKTXMNPG8oTJAKgiUEZ8HziGCdUBpzVPhPoe5xWah9j0
 7suA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718949077; x=1719553877;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C46k3CvHvnciE+CXQXC7azc+6l/2m9A+ACn+crFmDvM=;
 b=Qvvciz4rLe2eVJQtG2iw5ThHHR4L4H0DHXP4Qee/L2xEIdsNr+RN/V151lUbKvfr8E
 hEiIZLZcCY7rk4t2qChnkfuO5NkSWaG/B3+0b0Y0YngzQua0wtwcEhHRgAyUeQrnNqUr
 3I8eJ5MRewiaXSL/u14ZKYJfDu5Ow2QWuzIUGEqpYh8fr42xkIDqD9Cq6NTs57WZTHlX
 FyH0Jw2Mbc+1d9Exnbe7ho3gRycUWHDnQERGLdU6UdovFQpTLTIXfU/6XCEkQg5zMSTo
 OEflTmV9g3LdTMuJ/pq5+amyZDNEKSy56T3apZGHKVe8VEPwTp5a8gD6RzerxNxH5Rn8
 2Lug==
X-Gm-Message-State: AOJu0YyeZeIzJx8w87DKFi7b/fETHQw8vzne1ZE+K9Sd9mnrSz0hZvm1
 KMXNj7xIMw14aBdkj5hScMrmT+BwnvUgml6CUTSmkfvEZHkDU1MOXBgA5yestjkzZVhNHx+DxKW
 e6AmLjW8AMgwV2GSGmtb6qHbBrCFtioHfF362cw==
X-Google-Smtp-Source: AGHT+IE469CQPHV42AOxdmNs/usTlO7pqya4fJDyJBTvK2E6GthMOYhK/hKh9OpBiSCryjjaxm3mg6S5o4hPLigdSdY=
X-Received: by 2002:a17:90a:e643:b0:2c7:b194:6881 with SMTP id
 98e67ed59e1d1-2c7b5d56bc9mr8082462a91.31.1718949076778; Thu, 20 Jun 2024
 22:51:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240620230625.1797397-1-sjg@chromium.org>
 <20240620230625.1797397-4-sjg@chromium.org>
In-Reply-To: <20240620230625.1797397-4-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 21 Jun 2024 08:50:40 +0300
Message-ID: <CAC_iWjKxfLSHdyWMbZ6sYB52=TPXB79=qSJMbhAdS=mPdwCVmw@mail.gmail.com>
Subject: Re: [PATCH v3 03/18] mkeficapsule: Add a --version argument
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
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

On Fri, 21 Jun 2024 at 02:06, Simon Glass <sjg@chromium.org> wrote:
>
> Tools should have an option to obtain the version, so add this to the
> mkeficapsule tool.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>  doc/mkeficapsule.1   | 4 ++++
>  tools/mkeficapsule.c | 8 +++++++-
>  2 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/doc/mkeficapsule.1 b/doc/mkeficapsule.1
> index c4c2057d5c7..c3d0f21488a 100644
> --- a/doc/mkeficapsule.1
> +++ b/doc/mkeficapsule.1
> @@ -87,6 +87,10 @@ Generate a firmware revert empty capsule
>  .BI "-o\fR,\fB --capoemflag "
>  Capsule OEM flag, value between 0x0000 to 0xffff
>
> +.TP
> +.BR -V ", " --version
> +Print version information and exit.
> +
>  .TP
>  .BR -h ", " --help
>  Print a help message
> diff --git a/tools/mkeficapsule.c b/tools/mkeficapsule.c
> index 6a261ff549d..c112ae2de8d 100644
> --- a/tools/mkeficapsule.c
> +++ b/tools/mkeficapsule.c
> @@ -21,6 +21,8 @@
>  #include <gnutls/pkcs7.h>
>  #include <gnutls/abstract.h>
>
> +#include <version.h>
> +
>  #include "eficapsule.h"
>
>  static const char *tool_name = "mkeficapsule";
> @@ -28,7 +30,7 @@ static const char *tool_name = "mkeficapsule";
>  efi_guid_t efi_guid_fm_capsule = EFI_FIRMWARE_MANAGEMENT_CAPSULE_ID_GUID;
>  efi_guid_t efi_guid_cert_type_pkcs7 = EFI_CERT_TYPE_PKCS7_GUID;
>
> -static const char *opts_short = "g:i:I:v:p:c:m:o:dhARD";
> +static const char *opts_short = "g:i:I:v:p:c:m:o:dhARDV";
>
>  enum {
>         CAPSULE_NORMAL_BLOB = 0,
> @@ -70,6 +72,7 @@ static void print_usage(void)
>                 "\t-R, --fw-revert  firmware revert capsule, takes no GUID, no image blob\n"
>                 "\t-o, --capoemflag Capsule OEM Flag, an integer between 0x0000 and 0xffff\n"
>                 "\t-D, --dump-capsule          dump the contents of the capsule headers\n"
> +               "\t-V, --version               show version number\n"
>                 "\t-h, --help                  print a help message\n",
>                 tool_name);
>  }
> @@ -969,6 +972,9 @@ int main(int argc, char **argv)
>                 case 'D':
>                         capsule_dump = true;
>                         break;
> +               case 'V':
> +                       printf("mkeficapsule version %s\n", PLAIN_VERSION);
> +                       exit(EXIT_SUCCESS);
>                 default:
>                         print_usage();
>                         exit(EXIT_SUCCESS);
> --
> 2.34.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
