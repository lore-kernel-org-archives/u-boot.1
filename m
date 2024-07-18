Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AF27C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 08:02:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 806018818B;
	Thu, 18 Jul 2024 10:02:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XQRXCb3s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96CA78818B; Thu, 18 Jul 2024 10:02:14 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E4A887B1A
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 10:02:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-42679f33fefso144235e9.2
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 01:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721289732; x=1721894532;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=J9ySQSoLDZt74f2ROktTPdcizEayBtt86njQBDyv7VI=;
 b=XQRXCb3sL2GKIV0VDRt/Cx77ZMevlei7PmPYpOj49aPAK3FMY6JuJWBMe4UpyGGaUW
 LhPlboFQFioTXDxxFB6fMTJDsbzwzrz5zgg/8crOCV0XWHJnXFPnwns3D4rH2viLj6or
 9WxMbI5ppCsXrEFWGW2RLgrFz+ezXyVZGHYDpsdQJm8FJqbpOfH+xHCo9MYESCgDEPpK
 HNMfx534Rd0bct3jcJUQt3lfzQcJmO9XBoZtvvAvMeT9/mnZeixIFJhriWJPHm62a6K9
 /5ZArnr/Elc/NPl0oTGUZcKzvyfw7Mk9gT3/Jl60pY03RPHHiYPq68pltJQWUGnYxKda
 rynA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721289732; x=1721894532;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J9ySQSoLDZt74f2ROktTPdcizEayBtt86njQBDyv7VI=;
 b=bZzdc2TOxhARWeF+yy9cI/XnSwb/77BZyDK5ZF7qo+H4AYfVvfRY4I28OPPbHKMQ3O
 +QFLYBE2s92aUP4CWkSoXwWDFD+FsabVYNDBf1+KxLwwEnymf2aSOOnLibLSZXbOGRAs
 prTTb2wN3KCR3ixg9FUrGjX8noYg+IoOLtCztkUctB94263V8+lyYE5ohkGjaIgSiMCE
 I6GkDUlb+FMLJpcrx3S92opzgJq23+FF6OFURBBF3bXekPR8IIRt8kKuEJ9EkrMo6TJ7
 qHVUw0OcwZZyHcRCo0/8/SQZn4zQ2r/JtIRD+t4T1REqwmkEyH057bBmI31UvHa7F2Mx
 VUNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwbV33092ysfu6y/8puPC0JiwdTCu90nFAtd5ZpKEdr1xrKnuP7WJepcSJgQ17+KxrlQdy7LbhcZtCVqZ/rM6jc4LgzA==
X-Gm-Message-State: AOJu0YzRb6UqtJjXzTKU82CJWLYHuSOgkLj/xBh6b4F27TXJ/x2xbi0N
 bq9l4zyNjE6xQZhGQcabNQzz76/K/EHORSviQTpBP+9ajScWBhHzvyzcYa0qbdg=
X-Google-Smtp-Source: AGHT+IHUlTNLROEWW5t67JS5kt9pTko2taA8zXKYWE52eHr3m241SgJSASFDmxjk8Fw5I4btknjMMw==
X-Received: by 2002:a05:600c:3555:b0:426:6eb9:db07 with SMTP id
 5b1f17b1804b1-427c2cc36famr30004035e9.13.1721289731637; 
 Thu, 18 Jul 2024 01:02:11 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a6e91fsm1098055e9.23.2024.07.18.01.02.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 01:02:11 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Michal Simek <michal.simek@amd.com>, Sean Anderson <seanga2@gmail.com>,
 Lean Sheng Tan <sheng.tan@9elements.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 01/21] sandbox: Use const in os_jump_to_file()
In-Reply-To: <20240713070055.2172883-2-sjg@chromium.org>
References: <20240713070055.2172883-1-sjg@chromium.org>
 <20240713070055.2172883-2-sjg@chromium.org>
Date: Thu, 18 Jul 2024 10:02:07 +0200
Message-ID: <871q3rm8lc.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Simon,

Thank you for the patch.

On sam., juil. 13, 2024 at 08:00, Simon Glass <sjg@chromium.org> wrote:

> The argument array is not changed by the callee, so mark it const.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>
> (no changes since v1)
>
>  arch/sandbox/cpu/os.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/sandbox/cpu/os.c b/arch/sandbox/cpu/os.c
> index d7869b2e368..6a8a5e7b89b 100644
> --- a/arch/sandbox/cpu/os.c
> +++ b/arch/sandbox/cpu/os.c
> @@ -808,7 +808,7 @@ static int make_exec(char *fname, const void *data, int size)
>   * @count: Number of arguments in @add_args
>   * Return: 0 if OK, -ENOMEM if out of memory
>   */
> -static int add_args(char ***argvp, char *add_args[], int count)
> +static int add_args(char ***argvp, const char *add_args[], int count)
>  {
>  	char **argv, **ap;
>  	int argc;
> @@ -859,7 +859,7 @@ static int os_jump_to_file(const char *fname, bool delete_it)
>  	struct sandbox_state *state = state_get_current();
>  	char mem_fname[30];
>  	int fd, err;
> -	char *extra_args[5];
> +	const char *extra_args[5];
>  	char **argv = state->argv;
>  	int argc;
>  #ifdef DEBUG
> -- 
> 2.34.1
