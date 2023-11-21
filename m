Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD9BC61D85
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 20:21:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1EBB87619;
	Tue, 21 Nov 2023 21:21:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nhPh2GK8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67BC987602; Tue, 21 Nov 2023 21:21:35 +0100 (CET)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70A0187253
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 21:21:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-507bd19eac8so7892952e87.0
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 12:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700598093; x=1701202893; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=n7JCrCkMvOyStFV8eEj0g7GTD8SIOkVvWQzu96EwQP0=;
 b=nhPh2GK8rRSqvfHGV+Tr1DYqvj3nELRftqRfnVwya7uOSFgNGFhA6omW90Mzg8XBee
 +kN7fUZ5iSwZmjc7TfD2jgd5RWzbm3D7qGUw+lf1cGK8+S6L4u3hn4NfGsAPxVPlOs+7
 3N7qBGuqqXBjKt3bp+ONszGDy0W7yJueKel0fMuO7hTwIMeelag0JGcpaJUhx+KOmdjF
 Gpd7s27QPeE4/RbfYDyp1ZGMw+fDPK7Lu8qjtEPPC3rWqd+ycE5xZL1xMmJyYjxfOB+v
 Ucx8LM0HK/irobHK4XOpiU8KgW+BgCq1EMQWxmCa7L0nYslBe5gperefmP+sJFYFOXOQ
 oDwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700598093; x=1701202893;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n7JCrCkMvOyStFV8eEj0g7GTD8SIOkVvWQzu96EwQP0=;
 b=ZdGp8E9CGYq6t1kxUX13WrF35lAkb6+jg2irZRDWkG0lfAS4/QMq//v9qajBvLl6CY
 IxN/MmLJyRDrZs/4ao1RNRCXVHEOwLsg+1Y5BoopxVHxp61rSGO+CxEPfbWggfDHuHZC
 lrcl+bITPeO8oN4SHydkGc3viU0bQnKbuDjwf9h09SciZz26evCwIUo4DDJnXfH8r4yC
 I5aAMCoDG6rX0kckcd7PXkSi4JwucZ425JU3yR4tOjxsi5tNyxqbF1Ooe+GyORwKMQ5z
 mL8SiUl91np32cWF0TTieTHbg9/r4bWji2cKaqdqlF493FrrXdvSJOstl7b5HJK34PL5
 EibQ==
X-Gm-Message-State: AOJu0Yx439tICogrDBXK2t8bmn15ae98dNzx6y6mQawBlm/uH0tJftrQ
 AtOYFNv6JC4LJZ77tmdYV4n8YWrEPU2fjC+6uHM/zRNSa85mRL8Q9Vs=
X-Google-Smtp-Source: AGHT+IGEggA2YVBEJ8N2VZFAPOyVg8ZTnI8FH+OBFU310/2APGR5YRIKb6W/v8FcLGCxRQa13nHnxA7jsoRm96UmH5Q=
X-Received: by 2002:a05:6512:3084:b0:50a:2710:d207 with SMTP id
 z4-20020a056512308400b0050a2710d207mr250451lfd.53.1700598092738; Tue, 21 Nov
 2023 12:21:32 -0800 (PST)
MIME-Version: 1.0
References: <20231121113557.800353-1-sjg@chromium.org>
 <20231121113557.800353-2-sjg@chromium.org>
In-Reply-To: <20231121113557.800353-2-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 21 Nov 2023 22:20:56 +0200
Message-ID: <CAC_iWjJwY6zM=Sz6r2WvEc3Bpsr1EK+4bbUKLSw34o=anHw=ag@mail.gmail.com>
Subject: Re: [PATCH 1/7] efi: Use puts() in cout so that console recording
 works
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Tue, 21 Nov 2023 at 13:36, Simon Glass <sjg@chromium.org> wrote:
>
> At present EFI output to the console use fputs() which bypasses the

nit, use ->uses

> console-recording feature. This makes it impossible for tests to check
> the output of an EFI app.
>
> There doesn't seem to be any need to do this bypass, so adjust it to
> simply use the puts() function.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>
>  lib/efi_loader/efi_console.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/efi_console.c b/lib/efi_loader/efi_console.c
> index a2d137d7a9e1..28087582e8d6 100644
> --- a/lib/efi_loader/efi_console.c
> +++ b/lib/efi_loader/efi_console.c
> @@ -182,7 +182,7 @@ static efi_status_t EFIAPI efi_cout_output_string(
>         }
>         pos = buf;
>         utf16_utf8_strcpy(&pos, string);
> -       fputs(stdout, buf);
> +       puts(buf);
>         free(buf);
>
>         /*
> --
> 2.43.0.rc1.413.gea7ed67945-goog
>
