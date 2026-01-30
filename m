Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A124AD49C6A
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 07:43:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15B8F84206;
	Fri, 30 Jan 2026 08:43:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iIJowiBb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E991D84214; Fri, 30 Jan 2026 08:43:49 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D40684131
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 08:43:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-79495b1aaa7so13647447b3.1
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 23:43:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769759021; cv=none;
 d=google.com; s=arc-20240605;
 b=JtKg7Vkdgp0LCXjJ0LhHK7B79HDnQnAz9pIldChg3lQ4UmRQZiW7IFocLZSIoXUZeH
 s9Qa4c/w/wsc6Ru/cRZ8lOGwnBM/ZpjFPZUdZeUd3kEZ63iIcxcqn4dYLloz0Y/T5uQi
 POsnTNC08xfO6IZbPT5/7yXRDzymWfVNWhqevfs6HcWY1LBcfJM1rZITnG41raztojE3
 LEwrPTPUJxxuVqkqC6p8w/BeAcYJ98zn6Gl5PKxMzhqqdr/bOYmtjaSG/8to1sgB6Onj
 PCy6YTWkIKphmZFd7fDxdeHPBNVomzeoWdo01o3nlDzOe/xC3Xzdl+Jk7aSLm7QbqZK7
 qC0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Ec3z0kGabhzwhhopaepihT4nejNX8JdmeG/z8ARCN1M=;
 fh=wrhZen22MtbkREBrqvGymwuHbf+JYQB1yPUxtoA5vm8=;
 b=eyjSseWKKbrpSzkHg2Fm4KDB/PjlmQGRcEO0jqpqZgfDQ5c93BCoMJnBBT2i9Q8lKZ
 mP5V4W8zIlcrpVrQzcT7lnuw+UWJz7PsHT8P8L5mSOFUSVXtJSqS9weU7JtEoGp3TUtE
 e/3udfARUmMs4q105Ur2Lwgwd8LmvWCQFJ3rOWzH+QpA0Zc7S+gdzvaN0fwIMdFQEsa7
 NOxn42DYE5O6f6oaq/E8p7iEnJkSh4naxHZJdhxTl1Hm6SrCxDrphnGTQdK+vH8xoERH
 lwCNbDKHvLTI4tDJ2WkDUYkuwJ6U8D6o0Frvl6sJITz3YaZkS7vU1n8BtyilnjNPA57s
 oCBA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769759021; x=1770363821; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ec3z0kGabhzwhhopaepihT4nejNX8JdmeG/z8ARCN1M=;
 b=iIJowiBb6PvzEE8eMoPN835expyBpd/YgtYBZWHfTUEQx+VKhTOBnVaCO1ZxiGqDzt
 oiZqLm01ZtqFp9/Aa/oLBCmyBIx57nWukXOzrwFRZpkh6W9P3CJTrqa3ZhewN5ylraTB
 5f28soFQfp4BHUAlKlL1YqlroagCwpiN2XCBmDcL8Szoek8t8Pz0mhXO7YjE8dWTli3+
 AzWS6tuly3tRWGr2Xa4K6FJHjWgjnorCSUhZD2EP97+e8f6TF8sl1swL2b7jxccYUhlK
 P0T7VnVeOQpsUn5wOkj9KyOhGULP5dlqXxlHiBjJtYzX/jXDr6DCpU/oVQcF2kfbiVgg
 anbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769759021; x=1770363821;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ec3z0kGabhzwhhopaepihT4nejNX8JdmeG/z8ARCN1M=;
 b=BY49PaZF5+xolci83s9532JF5HcQtykAsRyI80/behnKCGaxT2hgVJhh+EBWyzFOge
 1Zej7F3z4u4I6wCu4Z8oFbXGz+PhYAckCQY//DDWaYC71pNY7OGJnfMkCTWMrkgJNvsK
 1oRcA4fZk9NBV8Pzm3Ywux1Q/y7E91T1OfxRhEuAmBn/uYzFRpCIB8m2I/fWxiOB5zxb
 i2K5tWZARIaUfDI8AJd791L/qrIQz1fWAb+dD9KfoZWAEVPxP3agHJsBjlToFSygqKIc
 LdVioCxwH9qtNpVMNjLCZ/KfLcaw3/taLRKfbVi+SIhLOnW2FQN6UQtCRrw8Mu+bvYSt
 puig==
X-Gm-Message-State: AOJu0Yx74EZoiVA+jTH6N7NYd9KT1/wKT/mbfzMi+iSfZQ3Ud+edyE7t
 2J89yUhVIFeE69lXV4PHfHmTwPyTxx+PR/i6OZRmQ3VtV4RFGqghqVWWAy7SM7x/237YOo7xz4m
 palgLVmvCFB6F2KEJVxnUIoQLpdTpHP4YHTfmY5DXig==
X-Gm-Gg: AZuq6aK3nXZlcJ5HeYCBqwkSH2FKySc6vBCCesiBUg1jiBagguuhjGRWiNmlq5NgnLs
 3s0oJ1FdRLQYjwuafgL2Ks4kb3XXaxW8TsFhryxcxy71glepN2zz7brWCAWPYh8SPVyQ5NgBPyQ
 IWO4+opDQQEgg9PrCgQIV7FzdoKlixGKH93jTkcSkMDGRaZaHJ60/9qWKTTDgTKf9t70Z2wJE43
 5d12j5Cwfog1lo/PLwvIGvW4S4friHDWSmhX/3z4cT8QRYfeLQ8XaUiU7khPOyq1EQV5gChnhjN
 A9mFXv/3ec/Hpb2ZajMw094oAxMJyCsnrXR8hBNAb94Tyu4FikdlOXc8zEIE/TfsgaFF5Np/mkG
 xbMbR3PDqjHVvppSGg3m9TRELTrcAaI31DwalOw9eB4bbmNMloiOx0QImXWzPl7SwqqWcO9vTii
 icR0FdGywaHf+i2tSDERW3qMPpp75pOQlNPO9w8r+3PzDJlvWGKezos345eQ1NAdpFzhFPeRIlz
 QnBi2/OzIC0IEtB813PaSstrBOTyYl1aX7pf00JXw3hAK+bmCwrlByQm3iI635RJc64LI9mledd
 FeLwJE3qm229Mpq2I7q9J8BQhmyv/ncilFWJ4Hxb6r4=
X-Received: by 2002:a05:690c:a92:b0:794:1ec3:3100 with SMTP id
 00721157ae682-7949de8478bmr17893827b3.8.1769759021147; Thu, 29 Jan 2026
 23:43:41 -0800 (PST)
MIME-Version: 1.0
References: <cover.1769177838.git.michal.simek@amd.com>
 <bec63fe7ad5201c1baf268a6c275d87f42713a9e.1769177838.git.michal.simek@amd.com>
In-Reply-To: <bec63fe7ad5201c1baf268a6c275d87f42713a9e.1769177838.git.michal.simek@amd.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 30 Jan 2026 09:43:05 +0200
X-Gm-Features: AZwV_QghNj4cnY72-MqJTgIcxsSzJSkl9x8IahqNJ48yj_6cyiZzvcjvJ8tekxQ
Message-ID: <CAC_iWjKXzvFbPQ71dmoTyoJCEMC8NnTKcjgtS2_B=n7Jd8fmzg@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] efi_var: Unify read/write access helper function
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@amd.com, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Shantur Rathore <i@shantur.com>,
 Tom Rini <trini@konsulko.com>
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

I am ok with this with a small nit.
Can we rename efi_var_read/write to efi_var_from/to_storage? I want to
make it clealer what these functions are used for

With the changes above
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

On Fri, 23 Jan 2026 at 16:17, Michal Simek <michal.simek@amd.com> wrote:
>
> efi_var_to/from_file() suggest method where variables are placed. But there
> is no reason for it and generic name can be used to wire also different
> locations for variables.
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>
> (no changes since v4)
>
> Changes in v4:
> - New patch based on review comments from v3
>
>  include/efi_variable.h        | 13 ++++---------
>  lib/efi_loader/efi_var_file.c |  8 ++++----
>  lib/efi_loader/efi_variable.c |  4 ++--
>  3 files changed, 10 insertions(+), 15 deletions(-)
>
> diff --git a/include/efi_variable.h b/include/efi_variable.h
> index ee68fa4a885f..ae542c597129 100644
> --- a/include/efi_variable.h
> +++ b/include/efi_variable.h
> @@ -137,13 +137,11 @@ struct efi_var_file {
>  };
>
>  /**
> - * efi_var_to_file() - save non-volatile variables as file
> - *
> - * File ubootefi.var is created on the EFI system partion.
> + * efi_var_write() - save non-volatile variables
>   *
>   * Return:     status code
>   */
> -efi_status_t efi_var_to_file(void);
> +efi_status_t efi_var_write(void);
>
>  /**
>   * efi_var_collect() - collect variables in buffer
> @@ -178,17 +176,14 @@ efi_status_t __maybe_unused efi_var_collect(struct efi_var_file **bufp, loff_t *
>  efi_status_t efi_var_restore(struct efi_var_file *buf, bool safe);
>
>  /**
> - * efi_var_from_file() - read variables from file
> - *
> - * File ubootefi.var is read from the EFI system partitions and the variables
> - * stored in the file are created.
> + * efi_var_read() - read variables
>   *
>   * In case the file does not exist yet or a variable cannot be set EFI_SUCCESS
>   * is returned.
>   *
>   * Return:     status code
>   */
> -efi_status_t efi_var_from_file(void);
> +efi_status_t efi_var_read(void);
>
>  /**
>   * efi_var_mem_init() - set-up variable list
> diff --git a/lib/efi_loader/efi_var_file.c b/lib/efi_loader/efi_var_file.c
> index d32edaac277d..01ac7cc20e1f 100644
> --- a/lib/efi_loader/efi_var_file.c
> +++ b/lib/efi_loader/efi_var_file.c
> @@ -43,13 +43,13 @@ static efi_status_t __maybe_unused efi_set_blk_dev_to_system_partition(void)
>  }
>
>  /**
> - * efi_var_to_file() - save non-volatile variables as file
> + * efi_var_write() - save non-volatile variables as file
>   *
>   * File ubootefi.var is created on the EFI system partion.
>   *
>   * Return:     status code
>   */
> -efi_status_t efi_var_to_file(void)
> +efi_status_t efi_var_write(void)
>  {
>         efi_status_t ret;
>         struct efi_var_file *buf;
> @@ -85,7 +85,7 @@ out:
>  }
>
>  /**
> - * efi_var_from_file() - read variables from file
> + * efi_var_read() - read variables from file
>   *
>   * File ubootefi.var is read from the EFI system partitions and the variables
>   * stored in the file are created.
> @@ -98,7 +98,7 @@ out:
>   *
>   * Return:     status code
>   */
> -efi_status_t efi_var_from_file(void)
> +efi_status_t efi_var_read(void)
>  {
>         struct efi_var_file *buf;
>         loff_t len;
> diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
> index 13db6eae882a..124281c29c7d 100644
> --- a/lib/efi_loader/efi_variable.c
> +++ b/lib/efi_loader/efi_variable.c
> @@ -404,7 +404,7 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
>                 if (IS_ENABLED(CONFIG_EFI_VARIABLE_NO_STORE))
>                         return EFI_NOT_READY;
>
> -               efi_var_to_file();
> +               efi_var_write();
>         }
>
>         return EFI_SUCCESS;
> @@ -599,7 +599,7 @@ efi_status_t efi_init_variables(void)
>                 return ret;
>
>         if (!IS_ENABLED(CONFIG_EFI_VARIABLE_NO_STORE)) {
> -               ret = efi_var_from_file();
> +               ret = efi_var_read();
>                 if (ret != EFI_SUCCESS)
>                         return ret;
>         }
> --
> 2.43.0
>
