Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43EEEC4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 15:18:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DE1186D1D;
	Mon, 13 Nov 2023 16:18:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mqyPrkee";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4D86870EB; Mon, 13 Nov 2023 16:18:52 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E04986D1D
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 16:18:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=o451686892@gmail.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5440f25dcc7so6991729a12.0
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 07:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699888730; x=1700493530; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ng6parsoTqc5wXM/ItQfaqRwlT5lWkniJnUup+yHCes=;
 b=mqyPrkeercP1qcI5UmWxcv4blr99dkEKtgYPWuHO1S2gMxD1SHAFK6ZU8PjMLtwURB
 HDL2v7BpYVVlj50LYMQwG5r9HzaNxlXdTD3KT/rVuSOkK6SmoG0apeElF1wHnc+cL/JB
 qlhsa12FPhUBkx1CNDwt3XAcKYeDGIEyEB05sZqJmeG3PQzxL4lp6y8xxA2j1yk6vYhh
 hdRICvm/UXzCXZV5uTwle6CH7upuKco5YFspDamL79t4wGfp0KsyX4y5oC/k62O1LmeU
 4IkN7qiWAGzgpdplhO5lLV5vTsxgAX9ikYMqj9m9kw2o4hh9MokmUQXJjQLAK2kwa/vh
 Kb6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699888730; x=1700493530;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ng6parsoTqc5wXM/ItQfaqRwlT5lWkniJnUup+yHCes=;
 b=pha2cYrgMS0BFN1atB0kIlG5pPBYhU9h/8FK7KfaIGe683Wfcc/+ekT7DnMD+Wf1Pd
 BJnU5coJgcdyuMHTvtvJzSyxX33RYY3p4q0dPzzfetBprgsn7Iyl4ZY6wfssJ21ixSFf
 4Nr8QT1sAVWE7aPAGwrKV7v7eIM5bybbRZ2plIpX3nWBEICEmE7nkF7ZfxXeNDxBwKGh
 UFIyjrxUBB3Ko59t+rjmPnyPRJ4WoHLATTDHA28edFNgdczxT8+pDv4nn8kwPwkfoQz9
 CG949gOWnnGSOKtzNBKLaeTudJk3lIYgoSqHa8aPU8d77oISlT474bEQ4BUtjspSEDoe
 zUsw==
X-Gm-Message-State: AOJu0Yzsf7w4I+enLwFSmdGPnUobjE2Cw3/qun36dsYx+TJ1g16LJrKH
 nhz8zcsxD0HZIgLcqjpFqdfXc/tA70RAjTGddVE=
X-Google-Smtp-Source: AGHT+IHOSgVYvFVZWTwAp4o9bWyzi+kO6502g+YvZSn5I0CcgzALwZQ60JcMTZK1dvlufIM/AlLZOnCseoZHwn7FldA=
X-Received: by 2002:a05:6402:1042:b0:540:c989:fcdd with SMTP id
 e2-20020a056402104200b00540c989fcddmr5208559edu.11.1699888730136; Mon, 13 Nov
 2023 07:18:50 -0800 (PST)
MIME-Version: 1.0
References: <20231113145016.7673-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231113145016.7673-1-heinrich.schuchardt@canonical.com>
From: Weizhao Ouyang <o451686892@gmail.com>
Date: Mon, 13 Nov 2023 23:18:38 +0800
Message-ID: <CAHk0HouMgvMS5t+TM_zxOxhEMqM94aHxu6yWKOuZdPanPY8qEw@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: improve efi_var_from_file() description
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
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

On Mon, Nov 13, 2023 at 10:50=E2=80=AFPM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> It is unclear to developers why efi_var_from_file() returns EFI_SUCCESS i=
f
> file ubootefi.var is missing or corrupted. Improve the description.
>
> Reported-by: Weizhao Ouyang <o451686892@gmail.com>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/efi_loader/efi_var_file.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/lib/efi_loader/efi_var_file.c b/lib/efi_loader/efi_var_file.=
c
> index 62e071bd83..dbf76f93de 100644
> --- a/lib/efi_loader/efi_var_file.c
> +++ b/lib/efi_loader/efi_var_file.c
> @@ -204,8 +204,11 @@ efi_status_t efi_var_restore(struct efi_var_file *bu=
f, bool safe)
>   * File ubootefi.var is read from the EFI system partitions and the vari=
ables
>   * stored in the file are created.
>   *
> - * In case the file does not exist yet or a variable cannot be set EFI_S=
UCCESS
> - * is returned.
> + * On first boot the file ubootefi.var does not exist yet. This is if wh=
y we
> + * must return EFI_SUCCESS in this case.
> + *
> + * If the variable file is corrupted, e.g. incorrect CRC32, we do not wa=
nt to
> + * stop the boot process. We deliberately return EFI_SUCCESS in this cas=
e, too.

Reviewed-by: Weizhao Ouyang <o451686892@gmail.com>

>   *
>   * Return:     status code
>   */
> --
> 2.40.1
>
