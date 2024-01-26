Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97692C47422
	for <u-boot@archiver.kernel.org>; Fri, 26 Jan 2024 08:09:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE62987BF4;
	Fri, 26 Jan 2024 09:09:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="s7B1bDLm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AAF587BF6; Fri, 26 Jan 2024 09:09:52 +0100 (CET)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF4EA87BAD
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 09:09:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-50eab4bf47aso129866e87.0
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 00:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706256589; x=1706861389; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RJ5jHfuy9tRQeIzRjqf7tjmJr/Bf0qeRUcAPz//+sm0=;
 b=s7B1bDLmY28+0P2prSLhWJ72iDAJSHCOAVi6WJ9WG1Cj9qY6SK4umYySH9wbAVnFB/
 tTX4ru9Q1C+bGYjFovJPRSuZuum1HaYbfuAe6aIPzOnJkSa3T22amtnJWaiLTImv/UEd
 fbpV0udoUz6d1Bs1Il5lR3Eh3GNcsZ1pPlF6peNL9vtl/MleMu6TaBkGDpnvr/4CzsDK
 XWDnbcpmRLxhLazwQFemnvrN2JAoGfomz/+UBnsjvSVlsplhjGzYMFLnFFlEK+CvS4wA
 ezuX5f3tvqDwfs6cTtL+iB7cnGAOU/EzR8aKSD106+EZPqKuj+u2ZiBj9W8uPg7SdzEF
 zavA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706256589; x=1706861389;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RJ5jHfuy9tRQeIzRjqf7tjmJr/Bf0qeRUcAPz//+sm0=;
 b=jBDWCSwGs5oXDDOUXGLAUznMLu/DqDIOQ4zWYxtANvydYULf+7KLvWr9HjApYWsrRO
 HznKY4eJR9QDkNbp8TM4DZy5Q6HXnnFvfwc0LL+VC/W6exuuKj0Vg2dF1Zo3z0TLULVN
 q2daii4tn/sXlIlE+qaQuApBaQIjN1QgkqevY2FfFnN/ny0wFMx2eC4PSRvoQJCYrK6R
 C10no6T107TZIWfsoVGyn9hXpbr0gKeG7rlBD6UNUCVoCGnaHi8/6HucEG3xH8CmxeLD
 NczpKgPeJVmGwJFYreQFc5RMdmtQEkOoEOOo7KiQXRhnnGrrf7vShsyoN2hMF+VzfH7E
 ekkQ==
X-Gm-Message-State: AOJu0YwG80cbprmN11wsAWiWd1RuLE/RkzVaJ6CNAGOmqJuDtDqqu/IE
 WH3dhUbpl4ld0osH+qYp5RAI/7BB5igpBUrcaHookqhqLwWKlsJCbl4ysFDztrw9wxUyxvqKAui
 J+wpgyPD67EbU/PdXKv9zRnyb6WJhKum+WNLUCQ==
X-Google-Smtp-Source: AGHT+IHN9NQbdFGsnZZMiaDaFy9W2AFqzDe2AGYwVW2eqdgKpw85XAdNPfqjeIOhltsMq0LQvwu5AvOnATLwNSMWK8E=
X-Received: by 2002:a05:6512:68:b0:50e:9eb8:3a23 with SMTP id
 i8-20020a056512006800b0050e9eb83a23mr312090lfo.19.1706256589186; Fri, 26 Jan
 2024 00:09:49 -0800 (PST)
MIME-Version: 1.0
References: <20240126075431.22876-1-heinrich.schuchardt@canonical.com>
 <20240126075431.22876-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240126075431.22876-3-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 26 Jan 2024 10:09:13 +0200
Message-ID: <CAC_iWjKhn7nyE4b82qVmbmDZeGOg3ZEERxAvDUqmx7b3YSsWNw@mail.gmail.com>
Subject: Re: [PATCH 2/2] cmd: in do_efi_capsule_esrt use
 efi_get_configuration_table
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Masahisa Kojima <masahisa.kojima@linaro.org>, 
 AKASHI Takahiro <takahiro.akashi@linaro.org>, u-boot@lists.denx.de
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

On Fri, 26 Jan 2024 at 09:54, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Use library function efi_get_configuration_table() to find the ESRT.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  cmd/efidebug.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/cmd/efidebug.c b/cmd/efidebug.c
> index a3a7556ea4a..a587860e2a5 100644
> --- a/cmd/efidebug.c
> +++ b/cmd/efidebug.c
> @@ -173,15 +173,12 @@ EFI_ESRT_UPDATE_STATUS_NUM  > (idx) ? efi_update_status_str[(idx)] : "error"\
>  static int do_efi_capsule_esrt(struct cmd_tbl *cmdtp, int flag,
>                                int argc, char * const argv[])
>  {
> -       struct efi_system_resource_table *esrt = NULL;
> +       struct efi_system_resource_table *esrt;
>
>         if (argc != 1)
>                 return CMD_RET_USAGE;
>
> -       for (int idx = 0; idx < systab.nr_tables; idx++)
> -               if (!guidcmp(&efi_esrt_guid, &systab.tables[idx].guid))
> -                       esrt = (struct efi_system_resource_table *)systab.tables[idx].table;
> -
> +       esrt = efi_get_configuration_table(&efi_esrt_guid);
>         if (!esrt) {
>                 log_info("ESRT: table not present\n");
>                 return CMD_RET_SUCCESS;
> --
> 2.43.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
