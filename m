Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98D36CD3445
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 07:19:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58F5B86A3F;
	Tue, 19 Sep 2023 09:19:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YGShc9Vl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BE7986416; Tue, 19 Sep 2023 09:19:38 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAD0386A3C
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 09:19:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-530ea522f5eso2595282a12.3
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 00:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695107976; x=1695712776; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g7/JEZyGc5fZPDOyKlhQAH8UPvVmSttGInfS49bnzzY=;
 b=YGShc9Vl02f0Wp4ZoYiSE8pxx0vgbwIUGwbaik5/AgbFtS/QFlG4JwtVV/+1+uiSoU
 IgCya1T5uKMUU5tOD0yAt5RgKLyBgFVr2WphwYZwVQwmz7hoGwQDInysMtV3a8mTztm9
 Rd8xvcA+ix7NlzxnT47k4e0VnKRoKl21ziYPEPBej/Ofkq4b12fVfpjBC7Cv2lZKkt1D
 MMapNx4O0qO6WpGj5c/RJsoHuk/lkrbSTdBdZf9ESLUr59FEawSKylDQOINlMJd5b26d
 ZkO38DTMgaZxiuwsGtgwFUiwJsFdLtThekINV9Q3qEmZ5eLlMFBSLo/e/3HwjP6KUslo
 Z8iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695107976; x=1695712776;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g7/JEZyGc5fZPDOyKlhQAH8UPvVmSttGInfS49bnzzY=;
 b=lX+9CAt2LJKRcvY8WtypaQsDhlQ8mAk5+XwHHvnLG2jFYW9WgVNNo+WyUfO2bKG8AK
 lXrfY24zjAk5DeYQl2To2QpfBGk6Gocj5CL7wumgl/NT27Ic0yYstamklN7H2AeZ3Vgb
 wqLFFoJMcdu+8HZIfC4XjxBgRAGm9xCR+Dh4vQt3BXSCPBeHn/f8DskfZezirPgvGPz/
 emOFoAWEQR2M7uFlk/po06yx7KSrnFo8spRduiNhvStoD3wuVPL57K8izMz+pE/LUlDT
 O+lWiXbWU3RVHy7mKogGnSc+UsJZBIwABDsTHejwD5MaKGOjfcLv3qq3uufF/O67oQv5
 T1Zw==
X-Gm-Message-State: AOJu0YxUedPcrKShi8vAWOFt9Up6iaif2wpQ18eRQ1wVy5O7zyaI9yC8
 /s3uNeckKqE05SDc/zF13NcZzjBhCrm3e8oI0NU=
X-Google-Smtp-Source: AGHT+IEkTDcQcRlUbnRSHhaPDRghJH7mVIAzXRAdjSfFw/fqK2ZwM7IaXjwmVK7e3nF5RGW40LY3K/3kxXfUD3oYxWw=
X-Received: by 2002:a05:6402:f1b:b0:530:ccf7:37af with SMTP id
 i27-20020a0564020f1b00b00530ccf737afmr7496231eda.12.1695107975946; Tue, 19
 Sep 2023 00:19:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230823211059.1235147-1-sjg@chromium.org>
 <20230823211059.1235147-4-sjg@chromium.org>
In-Reply-To: <20230823211059.1235147-4-sjg@chromium.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 19 Sep 2023 15:19:24 +0800
Message-ID: <CAEUhbmUPEkFNSgu=QXb2Q26m=m-7TtbvTLL2=hp02D=RDu05Rg@mail.gmail.com>
Subject: Re: [PATCH v4 03/20] x86: coreboot: Rearrange arch_cpu_init()
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Thu, Aug 24, 2023 at 5:11=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Init errors in SPL are currently ignored by this function.
>
> Change the code to init the CPU, reporting an error if something is wrong=
.
> After that, look for the coreboot table.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>  arch/x86/cpu/coreboot/coreboot.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/cpu/coreboot/coreboot.c b/arch/x86/cpu/coreboot/cor=
eboot.c
> index 835b2c77746..c2ceaa9a56c 100644
> --- a/arch/x86/cpu/coreboot/coreboot.c
> +++ b/arch/x86/cpu/coreboot/coreboot.c
> @@ -21,7 +21,14 @@
>
>  int arch_cpu_init(void)
>  {
> -       int ret =3D get_coreboot_info(&lib_sysinfo);
> +       int ret;
> +
> +       ret =3D IS_ENABLED(CONFIG_X86_RUN_64BIT) ? x86_cpu_reinit_f() :
> +                x86_cpu_init_f();

nits: not aligned

> +       if (ret)
> +               return ret;
> +
> +       ret =3D get_coreboot_info(&lib_sysinfo);
>         if (ret !=3D 0) {
>                 printf("Failed to parse coreboot tables.\n");
>                 return ret;
> @@ -29,8 +36,7 @@ int arch_cpu_init(void)
>
>         timestamp_init();
>
> -       return IS_ENABLED(CONFIG_X86_RUN_64BIT) ? x86_cpu_reinit_f() :
> -                x86_cpu_init_f();
> +       return 0;
>  }
>
>  int checkcpu(void)
> --

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>

Regards,
Bin
