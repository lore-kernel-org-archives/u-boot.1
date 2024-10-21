Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE7ADD15DB8
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 16:32:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADC4488F47;
	Mon, 21 Oct 2024 18:32:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UvtwsQmU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D003588F28; Mon, 21 Oct 2024 18:32:30 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E909A88ED7
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 18:32:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5c9850ae22eso5912229a12.3
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 09:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729528348; x=1730133148; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HwpvIpqAp0rV3JyPztje/PLzxaWXxYn7zexG7+OM9O0=;
 b=UvtwsQmUGICr1okBvWq9Edv/QmvWxsK51XgQ5vOYqX13nFY762m7GOTS9yJ7dV1w0F
 DWZSGCC64Ebff8I3FEIThqzLdkfu8XDdYPd36sxfcjRILCcNiakH7a0PfIe7D9eomlsr
 eBJAzDan7AHnJnP7CzVhO7iXt+Ni1Wn4W7qdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729528348; x=1730133148;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HwpvIpqAp0rV3JyPztje/PLzxaWXxYn7zexG7+OM9O0=;
 b=MeSE5ewRZaM3v4/JGkgG27vqurfHg1DeoWcSQWoZzuKMV9Ex2wYV/RcPOOplNMTIM9
 LeIkuDcNsOYcZbix+m2Ujw1N2Apfu6eAbRkKpccEyGUuHL9tFL3iYnq8EQO9Cy0n7QH7
 YyeIVnemzHwtMylkGuVgamlpbQogIu+A0llJOtUMIygyTsd956+w3PJTYZRj2kbgwk2c
 g/mPuHMTAMk3UD+KhVMyVX/FyNqFm9oYELgg5KTZuHVVq6xeQcixHFbYyS1zzBXjHuw4
 aLQ8l4VgGKdQIx1oQ7ubhAcQ0to4KB48kYGYpOOy16NnaLQPqrWaZX28SNNtaukHjFZS
 2WVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcBf4F6TSeFPxA6fMTEUXrMNRZKGKrT5hOv3GjrsT7V9AP4fWjy8X6Ppjn/L9VrNkBA+E4Kag=@lists.denx.de
X-Gm-Message-State: AOJu0YwMYxq0kcqBHbUKwRbArGgNYZBdFxr90Me78QkMiQgSYJY6Rgzz
 W3LQpAMDrhJ75X3fvQGNDU4jmu5yBc9dx936iLta6+oVxQ4FCpv9QA8s0ZXpQ4UkQF3j9xowzT2
 bzuc0aTcvil2XBKYOAfOhvKcWGrx78jzLb2/j0tcMP5bBQ010sW1K
X-Google-Smtp-Source: AGHT+IEIJNIL8tXpZ11t9Df7n67bpBR5biLR2FnqjehoMVBkeUpSyPEMsWbHD3vUfFh6iokMCNhy6z668+Kc7Mm1Mac=
X-Received: by 2002:a17:907:3fa7:b0:a9a:9b1:f972 with SMTP id
 a640c23a62f3a-a9a69c8fcaamr1236594466b.40.1729528348405; Mon, 21 Oct 2024
 09:32:28 -0700 (PDT)
MIME-Version: 1.0
References: <20241021135633.2958463-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20241021135633.2958463-1-andriy.shevchenko@linux.intel.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 21 Oct 2024 18:32:13 +0200
Message-ID: <CAFLszTitzPHYq8CzbjfA9TMkSX1V8q4TT3x=roLkTtCS4isYoQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] cmd: nvedit: Mark a few functions static
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

On Mon, 21 Oct 2024 at 15:56, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Some functions are not used anywhere except the same file
> where they are defined. Mark them static. This helps avoiding
> the compiler warnings:
>
>   cmd/nvedit.c:201:5: warning: no previous prototype for =E2=80=98do_env_=
ask=E2=80=99 [-Wmissing-prototypes]
>   cmd/nvedit.c:315:5: warning: no previous prototype for =E2=80=98do_env_=
callback=E2=80=99 [-Wmissing-prototypes]
>   cmd/nvedit.c:384:5: warning: no previous prototype for =E2=80=98do_env_=
flags=E2=80=99 [-Wmissing-prototype ]
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  cmd/nvedit.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>


> diff --git a/cmd/nvedit.c b/cmd/nvedit.c
> index 98a687bcabbd..0bd4799dc5a2 100644
> --- a/cmd/nvedit.c
> +++ b/cmd/nvedit.c
> @@ -198,7 +198,7 @@ static int do_env_set(struct cmd_tbl *cmdtp, int flag=
, int argc,
>   * Prompt for environment variable
>   */
>  #if defined(CONFIG_CMD_ASKENV)
> -int do_env_ask(struct cmd_tbl *cmdtp, int flag, int argc, char *const ar=
gv[])
> +static int do_env_ask(struct cmd_tbl *cmdtp, int flag, int argc, char *c=
onst argv[])
>  {
>         char message[CONFIG_SYS_CBSIZE];
>         int i, len, pos, size;
> @@ -312,8 +312,8 @@ static int print_active_callback(struct env_entry *en=
try)
>  /*
>   * Print the callbacks available and what they are bound to
>   */
> -int do_env_callback(struct cmd_tbl *cmdtp, int flag, int argc,
> -                   char *const argv[])
> +static int do_env_callback(struct cmd_tbl *cmdtp, int flag, int argc,
> +                          char *const argv[])
>  {
>         struct env_clbk_tbl *clbkp;
>         int i;
> @@ -381,7 +381,7 @@ static int print_active_flags(struct env_entry *entry=
)
>  /*
>   * Print the flags available and what variables have flags
>   */
> -int do_env_flags(struct cmd_tbl *cmdtp, int flag, int argc, char *const =
argv[])
> +static int do_env_flags(struct cmd_tbl *cmdtp, int flag, int argc, char =
*const argv[])
>  {
>         /* Print the available variable types */
>         printf("Available variable type flags (position %d):\n",
> --
> 2.43.0.rc1.1336.g36b5255a03ac
>
