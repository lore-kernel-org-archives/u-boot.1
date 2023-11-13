Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DA99C4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 18:02:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 133E0871A0;
	Mon, 13 Nov 2023 19:02:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="frW14uV3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A73C387214; Mon, 13 Nov 2023 19:02:13 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AA178716D
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 19:02:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5a7b3d33663so55038527b3.3
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 10:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699898530; x=1700503330; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=F5k5uTUtllC5494IY6gWumSA+fWFedSi1zd2ndRtiIw=;
 b=frW14uV35z4MgE+D5xhqrQQGI3OWJCyAEMGnfxkEU70bznkCS8vwY7ZsaBku+UVdT4
 J4Mk+FiVx+BlNiiyQjlY1bhix2jokg7vm85jTvAf9hEt8dKkR6RrOPdZBSEl8g3/nAzU
 1epem4tjVL/EdVDF8HRYx7TGrniRksyqpQoBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699898530; x=1700503330;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F5k5uTUtllC5494IY6gWumSA+fWFedSi1zd2ndRtiIw=;
 b=boydk9xXS82EDb55DD2wAmUmazid7LQ7u6e51dZDfo/89ylGYCGjJ6mwkKLxGkS4tz
 zgYdOmZLy/Ol1j3DVJQhqY6WX1MIxrt8J3nREcXjCtqNzaxWux7QjC/Kg+ALzsi+drHI
 7QGtCEgSSrFEIGzHOKD2M++Y+SqcxLkhPUue7XBMWIrDSXaYK+1fLbXu7SpknCZ8WEMF
 PjdcgzeCGeg9hxvjgRrD4WkSr/BlNI/D3TfvJqrCg51/sx1erdPE0Av5BYMQBdcOs7TU
 Ua4AC6NZMdM/H13dIqE6Ep01gP5BIOMu/+miDorlRhO5R8OOiUiWQqrG4knYk/SSibGb
 oPJw==
X-Gm-Message-State: AOJu0YxrIYELV+nleGQwUc9M61IYwAU4RZKnY9mxzgyZQBAqIAv92EJP
 q4Ex2JjK341O6sF2TBT9s4Q1ix3mMZxAAcUCre773g==
X-Google-Smtp-Source: AGHT+IF9e/yjVAT5c9NGxXP1UO8dA3/Vstz91T0Xf0wE5o6myyjXU1fSxm6nqw88P7PeYeaOXuH8bs1+RZx3SvXE8do=
X-Received: by 2002:a0d:ca13:0:b0:5a7:d73d:42cd with SMTP id
 m19-20020a0dca13000000b005a7d73d42cdmr8291327ywd.20.1699898530050; Mon, 13
 Nov 2023 10:02:10 -0800 (PST)
MIME-Version: 1.0
References: <20231113145016.7673-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231113145016.7673-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Nov 2023 11:01:16 -0700
Message-ID: <CAPnjgZ1ifMZEqe+id5BwZzq3aVPmYXJZiwSY1vERre-9H_5eew@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: improve efi_var_from_file() description
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Weizhao Ouyang <o451686892@gmail.com>, u-boot@lists.denx.de
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

On Mon, 13 Nov 2023 at 07:50, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> It is unclear to developers why efi_var_from_file() returns EFI_SUCCESS if
> file ubootefi.var is missing or corrupted. Improve the description.
>
> Reported-by: Weizhao Ouyang <o451686892@gmail.com>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/efi_loader/efi_var_file.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/lib/efi_loader/efi_var_file.c b/lib/efi_loader/efi_var_file.c
> index 62e071bd83..dbf76f93de 100644
> --- a/lib/efi_loader/efi_var_file.c
> +++ b/lib/efi_loader/efi_var_file.c
> @@ -204,8 +204,11 @@ efi_status_t efi_var_restore(struct efi_var_file *buf, bool safe)
>   * File ubootefi.var is read from the EFI system partitions and the variables
>   * stored in the file are created.
>   *
> - * In case the file does not exist yet or a variable cannot be set EFI_SUCCESS
> - * is returned.
> + * On first boot the file ubootefi.var does not exist yet. This is if why we

s/if//

Reviewed-by: Simon Glass <sjg@chromium.org>

> + * must return EFI_SUCCESS in this case.
> + *
> + * If the variable file is corrupted, e.g. incorrect CRC32, we do not want to
> + * stop the boot process. We deliberately return EFI_SUCCESS in this case, too.

Does this mean that the file will be erased? Doesn't that mean that
all the settings are lost?

>   *
>   * Return:     status code
>   */
> --
> 2.40.1
>

Regards,
Simon
