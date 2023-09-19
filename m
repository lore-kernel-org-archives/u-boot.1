Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A6B2CD3447
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 07:21:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFA2586A77;
	Tue, 19 Sep 2023 09:20:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ggXVvS0y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 762CC86A26; Tue, 19 Sep 2023 09:20:15 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39DB286AC6
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 09:20:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-502153ae36cso8590855e87.3
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 00:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695108011; x=1695712811; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A93VBx7rrugHJqgBKn5kfENPwNs1coGO6GImFL/lhJ0=;
 b=ggXVvS0yYMzB+eFrpqyWQFRtfePu/OerMBCAWs1yigouPiP5yCspRAnhXx2vsMQ9UD
 Mf1Fmp138zmryguIGNgDvBGqLpUMw+k6rDDSBsjLXm1ERtyh1/gvK/fD5Uq9ultje4Qe
 cPkfpaW8hYlT9jT3qc1hd7yfHs5sdCGA9DwXtt6fU5awfLrA+uN6XBDEPJ+Q4v8Ot53C
 zdOXJHLn0yKK8Q2qiUf/JrwAmp4YpS9mbB1mqG730dcfPZ9PV74qqcRVbZRxq783dJqY
 hYmUi4hQJdGRa+RlVv7zJUNdEgunwf3G4Z5w7dQ4Imj4k4qYd0paOHnL0FrUuRkM71/Z
 aBug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695108011; x=1695712811;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A93VBx7rrugHJqgBKn5kfENPwNs1coGO6GImFL/lhJ0=;
 b=ATzUUZUQ/aVZYUjYdq+iX4jJDiesBZbPiz36bp87WR+BJvcG6PiyQgZ0cYs9mbAW3I
 DQzl7aq7q/5MIcMMnPgHaIz8JDzJHIoawqXaViVacoqOPbjIp3k7rYzCdIvviPbOYTwn
 xzH6eKNb2hL+4ZxT0AFp/mhN5ALAs5wMKdt7aQ9NHuj7Vp7sQ6qftGshKO/w2RFRsq6k
 slXZQ2B7y2+Ryq4XnT9GZgd/U7x/BqveoeUlDz9sb2qf/davJ2W82Sw2MqCYD3FxJoUZ
 2YmQBtm1ywP67VLF38i68d/XLMfEUeDuEctsLCzXLbEUleLVvKC/EypLuKPVfTpzloUk
 UfTg==
X-Gm-Message-State: AOJu0YxYI7+bQkcbJyrKqdWF1dETtwxUHtRxyTBGvXXjkny0qp0nrIN6
 4J6+TttTfQSTaeNIegdwwPsG4sEGQ8k5Q6++gc8=
X-Google-Smtp-Source: AGHT+IEqN1vJ5cV4b/pUxOFTm9Bp8nQ1sLFg+PeeHNQvo+KnXngKpKk6Fbpq+WKI+WJyDQYW/VLGaqXzAC+756WwfQw=
X-Received: by 2002:ac2:58d7:0:b0:4ff:b830:4b6b with SMTP id
 u23-20020ac258d7000000b004ffb8304b6bmr7687984lfo.14.1695108011519; Tue, 19
 Sep 2023 00:20:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230823211059.1235147-1-sjg@chromium.org>
 <20230823211059.1235147-17-sjg@chromium.org>
In-Reply-To: <20230823211059.1235147-17-sjg@chromium.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 19 Sep 2023 15:19:56 +0800
Message-ID: <CAEUhbmWrq9DAKoeUA2AcvM3BpLGx3YZj20BjosdHRJmqRsE5UQ@mail.gmail.com>
Subject: Re: [PATCH v4 16/20] x86: coreboot: Record the position of the SMBIOS
 tables
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
> Make a note of where coreboot installed the SMBIOS tables so that we can
> pass this on to EFI.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v2)
>
> Changes in v2:
> - Add new patch
>
>  arch/x86/lib/coreboot/cb_sysinfo.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/x86/lib/coreboot/cb_sysinfo.c b/arch/x86/lib/coreboot/c=
b_sysinfo.c
> index dfbc80c430e..f7fd9ea5bcb 100644
> --- a/arch/x86/lib/coreboot/cb_sysinfo.c
> +++ b/arch/x86/lib/coreboot/cb_sysinfo.c
> @@ -471,6 +471,7 @@ int get_coreboot_info(struct sysinfo_t *info)
>                 return -ENOENT;
>         gd->arch.coreboot_table =3D addr;
>         gd_set_acpi_start(map_to_sysmem(info->rsdp));
> +       gd_set_smbios_start(info->smbios_start);

use map_to_sysmem() too?

>         gd->flags |=3D GD_FLG_SKIP_LL_INIT;
>
>         return 0;
> --

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>

Regards,
Bin
