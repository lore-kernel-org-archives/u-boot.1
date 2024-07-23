Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD079C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 06:44:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFB0F88354;
	Tue, 23 Jul 2024 08:44:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="j8Q4eoUn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A39987E0D; Tue, 23 Jul 2024 08:44:12 +0200 (CEST)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B659D886FC
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 08:44:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-70d357040dbso834589b3a.1
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 23:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721717043; x=1722321843; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=y8LUFl+oZWE/on10F87UWv9avHKYbxEAq9NKZQcJFfs=;
 b=j8Q4eoUnG6waUpRy7Hbb2CDN9CBaE9phgQWjx/JcoEW48eLI6unmYngMHr5KuJ3kWe
 tY9IDn9J+rnPVbB9NNzBh9l3bY8U6p6IkyFOBMsGtg6QcAtdPgM5HkAL+JqITtp7HOJT
 m1ZzuXC/46uzhwg7mhZgWm2uNj9HxQxXF1F4IR1N4IiAsGErpQ84S+HE/XQLoi982Rjm
 KgYvRcx9ORQEpKGqjEKtKrJ2YSoroxpinqdrQu8zHXKu0swgsXBnMWWSqQO2TV/2AVEG
 SrWqYQwLVpZGGBDDK2Q/pQ29t+EWxU2IlulnbAD3DsK6RqoaulD8sM+empiDJZwJq+0q
 b/vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721717043; x=1722321843;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y8LUFl+oZWE/on10F87UWv9avHKYbxEAq9NKZQcJFfs=;
 b=pDubx5nGCllMiaK93BzyW4gL5yocPBAZnpQQVuw9yfhdzw6joW4/IxVxg7VQY/61YC
 KIadX1obiku6YhUI7ZIpstv2QLMoAdgpf7GwcTpy3E5qvat7SiltZ9VfqdbwZ86l+Dtb
 5GxaNUjsszk8HJKriWUAbOPnQBk0zu7jBKlj5HvSdet0U5GDprGLlTlfb598ZVNNcREL
 Sttj07iVubs0h/PCJaUpPw7FLY8YPMRAxFGDymvGgQkT3fXvz8D+WoDzefOYlMih/Jjj
 FaRfpW3+V/0HOVyJrRF3+8gxQAG6K2HQiIP1zmy2UQNRMaO83iRHHjHkRfR0IVBoNFF/
 fkwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSgOra3WXxcM0bu9FoWZLdWhYeGrBA6D/68AmWyWUkjXOhTuZd1bppHNNnwH2OPV7ptlje3O59iqRLeWLYeNZs4ytT0g==
X-Gm-Message-State: AOJu0Yy6ZMG9Y93vBDFOaTLp45QF6+RAKo/9ElkyZF9WKWTkvJOK8sWq
 /HOYUDHId5c296NB1XFdt9EBLzCJom9KMHloA2u0cVCb9V53XqhVK8dJiqB9pBFlhitCqRp+OUQ
 jOvYYG9VRjLbWbOXFzVLXWY8nGst35c3OXW9tHQ==
X-Google-Smtp-Source: AGHT+IE9KKDJzZpFwyr8dvVghKoVmxeWAmG6IOM24v7Kwti59dmxkXkMuEYvp01Kzl/u1IcZgwdGpK7sM1u5K4i3R4Q=
X-Received: by 2002:a05:6a21:999e:b0:1b4:2f6:62b3 with SMTP id
 adf61e73a8af0-1c42857a5c4mr7730958637.26.1721717042975; Mon, 22 Jul 2024
 23:44:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240722175532.184842-1-caleb.connolly@linaro.org>
In-Reply-To: <20240722175532.184842-1-caleb.connolly@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 23 Jul 2024 09:43:26 +0300
Message-ID: <CAC_iWj+CoOvKXmHbrBkFt88mPOO2MPybM8j=4pxG9kke5u3t9g@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: add /dtbs search path
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
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

On Mon, 22 Jul 2024 at 20:55, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Add an additional search path /dtbs, this is where dtbs are installed on
> postmarketOS and potentially other distros.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  lib/efi_loader/efi_fdt.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/lib/efi_loader/efi_fdt.c b/lib/efi_loader/efi_fdt.c
> index 86ba00c2bdd9..4777943b80df 100644
> --- a/lib/efi_loader/efi_fdt.c
> +++ b/lib/efi_loader/efi_fdt.c
> @@ -42,8 +42,11 @@ int efi_get_distro_fdt_name(char *fname, int size, int seq)
>                 break;
>         case 2:
>                 prefix = "/dtb/current";
>                 break;
> +       case 3:
> +               prefix = "/dtbs";
> +               break;
>         default:
>                 return log_msg_ret("pref", -EINVAL);
>         }
>
> --
> 2.45.2
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
