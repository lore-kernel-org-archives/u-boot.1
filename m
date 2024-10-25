Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97B31D10399
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 15:28:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33AB688FC8;
	Fri, 25 Oct 2024 17:27:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15B6388FAC; Fri, 25 Oct 2024 16:43:21 +0200 (CEST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com
 [209.85.208.171])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EFE787F7D
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 16:43:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=wens213@gmail.com
Received: by mail-lj1-f171.google.com with SMTP id
 38308e7fff4ca-2fb4fa17044so23384121fa.3
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 07:43:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729867394; x=1730472194;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AU/PzZlykHHoujrVc3gxuX+4ixyqcg60/hgRaGyT47w=;
 b=FAz+zgkcapFRD5AH9i5bMetJzD+kUIulRb88ypmcTb+FFy1sm+D99VmOyr0Uf+AicP
 vUHINWI/Vo5Ezxt1GhhkfAtSw/6NK0j1fiEuCGVcz8RQo18g00lRaHvi7uKSPpk9CQFa
 nuHzdcT4/aBVI7SJFcro5nPCcrtMk/ulgWncLwxQx4swntILDpx4Kr8u80wLk4bc+uJe
 qU5H7Pgo2qZ7mAK2PLVUX95ni2Jjf/rfQkopO9aa3ISQ7nVQCOj9fxEnAONPtyg0xeyS
 RJXif92tPxH0px8bW3NFwK0ZeJSs/dNqX6xlQAT/3dBbc5S7SZCnORc4nFeQ9bfp9vlM
 qtwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOYlyoX7oqwfyLNM2OClllANCkcOHsLSmmmawXhQuxCIWC3QzMPV5QSex8N0QHke2qz8vvb4A=@lists.denx.de
X-Gm-Message-State: AOJu0YwoYDcTQ5cLMptIKOCIgBxrs476z3ovrIGzgQRfcdkPngNTCRxq
 cqDJUHGenLGHA0O96SRrajmTfmnskasuX2yR0WmRzMx16HXIi0GNckw5FMrh
X-Google-Smtp-Source: AGHT+IE+H9ptq5tDiIrgOCwl39k1C0rlkgA7hsCYnrPsqfKbm7rk6lJZGlA+nRkiWUeItUoV9gv9PQ==
X-Received: by 2002:a2e:4601:0:b0:2fa:d4ef:f222 with SMTP id
 38308e7fff4ca-2fc9d3840admr43437961fa.38.1729867393722; 
 Fri, 25 Oct 2024 07:43:13 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com.
 [209.85.208.182]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2fcb4519b26sm2071291fa.50.2024.10.25.07.43.13
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Oct 2024 07:43:13 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id
 38308e7fff4ca-2fb5014e2daso22290701fa.0
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 07:43:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCWaDAdcKsRkUzL4DTnjolEGqfWno7xkPF2NvS8ve9aiLWMCAb1YrC3a7/WvZ6TQ3SV8sf5stuE=@lists.denx.de
X-Received: by 2002:a2e:a991:0:b0:2fb:6057:e67e with SMTP id
 38308e7fff4ca-2fc9d375a1amr60051471fa.32.1729867393241; Fri, 25 Oct 2024
 07:43:13 -0700 (PDT)
MIME-Version: 1.0
References: <20241007222625.18883-1-andre.przywara@arm.com>
In-Reply-To: <20241007222625.18883-1-andre.przywara@arm.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Fri, 25 Oct 2024 22:42:58 +0800
X-Gmail-Original-Message-ID: <CAGb2v671y0EkMKmYJKqPp0ek3_-kv26adUjG=g5-tdPe+5f3Hw@mail.gmail.com>
Message-ID: <CAGb2v671y0EkMKmYJKqPp0ek3_-kv26adUjG=g5-tdPe+5f3Hw@mail.gmail.com>
Subject: Re: [PATCH] sunxi: power: axp809: Fix DCDC4 programming
To: Andre Przywara <andre.przywara@arm.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>,
 Jagan Teki <jagan@amarulasolutions.com>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 25 Oct 2024 17:27:53 +0200
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
Reply-To: wens@csie.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Tue, Oct 8, 2024 at 6:27=E2=80=AFAM Andre Przywara <andre.przywara@arm.c=
om> wrote:
>
> When trying to set the DCDC4 regulator, the code was accidentally
> setting the voltage register for DCDC5 (VCC-DRAM). The higher voltage
> doesn't harm the DRAM chips, but upsets the Linux regulator driver: when
> it tried to correct that, it tripped over a separate DT bug.
> The DCDC5 DT limits are 1.425 and 1.575V, which cannot bet set with the
> rail's resolution of 50mV. The kernel driver gave up, and made in turn
> the system hang, as the PMIC powers essential devices.
>
> Fix the copy&paste bug by using the correct PMIC voltage register.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

> ---
>  drivers/power/axp809.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/power/axp809.c b/drivers/power/axp809.c
> index 9e38e1a7450..ec3eca1ac4b 100644
> --- a/drivers/power/axp809.c
> +++ b/drivers/power/axp809.c
> @@ -93,7 +93,7 @@ int axp_set_dcdc4(unsigned int mvolt)
>                 return pmic_bus_clrbits(AXP809_OUTPUT_CTRL1,
>                                         AXP809_OUTPUT_CTRL1_DCDC4_EN);
>
> -       ret =3D pmic_bus_write(AXP809_DCDC5_CTRL, cfg);
> +       ret =3D pmic_bus_write(AXP809_DCDC4_CTRL, cfg);
>         if (ret)
>                 return ret;
>
> --
> 2.46.2
>
