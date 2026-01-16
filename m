Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97EFFC982F3
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 19:29:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B08BB836AC;
	Fri, 16 Jan 2026 20:29:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93BE083956; Fri, 16 Jan 2026 19:50:10 +0100 (CET)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com
 [209.85.210.41])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18D1983015
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 19:50:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ngompa13@gmail.com
Received: by mail-ot1-f41.google.com with SMTP id
 46e09a7af769-7cfd5d34817so1535441a34.1
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 10:50:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768589406; x=1769194206;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tdR/h3nDyWvP2R72hsHcMKi/rk0gO3WT3F+Gsv3V5+8=;
 b=MeHOb9xrQSGh0cUo7FvWISQZSZJ+pLCpl/TpJ1c7a+SF5w7hwOPTFazADVe0uIWib8
 dw6+t+ilLDzSRRVQ9UAOdls9eZKNWrqi9E8VUjDqIzCvmr981k/2FIskOwzTzLNP6pCU
 o23mAN7Jb+aBc8V67ut+kiRcb/XgTuTg1lX+lWf3L7yBKr0eMz94tGIBnB84FRcG4kuD
 2yj6h8R2M1XS8buCTm2/GY7/1dUlYP/AaMJ8FGuwFYKihey7kdDeXvoL2FO5EoSjMPb/
 ea5P4zRIo5QzeFShTDhSjwbUK+GdQUWd8Gq1YY3s2M2LefRRIoPd2HbHf/dykZWn+hat
 vdJg==
X-Gm-Message-State: AOJu0Yy5VwjozhG9JnHpKxeGVxB3yYN4bkZii5LYWcFZYLOck8yuMquY
 4VFoLkeGBF7lTlzXKGqvaIAY2I5m84AGxR2k8U5emLhn+8ePRUxgjNYM3qZxZg==
X-Gm-Gg: AY/fxX4vUM11SAW+rKdrM5uKsOIrfpa/SeUI+AfnExlNSTQBtZwf4i2SSv0YnFdVy0j
 nwuq/0ZWt6bADnKXbmh8qnLh4kf72GVGzsuD5kkmiJivmyEZxNy6/8GxH9e6vkSefRz+qjSaqQs
 +K704X5X/bdN1hwg1FbaVsTJuh3eAU9VsumPaY/yFp5wVK1aq3ol6RKfjwcoDE9o7Irl6TsUW8f
 HQJhSfWG7xAhbS8yc39R/NpLFZZJRrSLZt621hZ7DOvweBhgysuEHND62y5bNSJ/818gKPl1psi
 ub/nhs/Vcfhfu9dRI66RmIMAt3Gl6J5uL2RLbH3HLzKCkm949bMAeWTktrXV1JHSkvkSEmNgvsq
 j9gDohdyDoGItq4kzo7DrMBRiZNjc92Bbr2laXxUmZihTExdSDpe4Ti/U/M04m4aS3xH0RQ0OZ0
 p4zXyBX4Tz4+us8uRwiqMwYYUDfbRUWGnFWX8/hpZSmc2B2mDrlwK5EE9OgmztRjbdoKasAGwd
X-Received: by 2002:a05:6830:6612:b0:771:5ae2:fcde with SMTP id
 46e09a7af769-7cfdfe2272cmr1582034a34.2.1768589405893; 
 Fri, 16 Jan 2026 10:50:05 -0800 (PST)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com.
 [209.85.210.53]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cfdf28efbasm2179036a34.17.2026.01.16.10.50.05
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jan 2026 10:50:05 -0800 (PST)
Received: by mail-ot1-f53.google.com with SMTP id
 46e09a7af769-7cfcb5b1e2fso1524522a34.3
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 10:50:05 -0800 (PST)
X-Received: by 2002:a05:6830:6c11:b0:7c7:63b6:89d8 with SMTP id
 46e09a7af769-7cfdff80a6amr2215998a34.14.1768589405552; Fri, 16 Jan 2026
 10:50:05 -0800 (PST)
MIME-Version: 1.0
References: <20260116-apple-defconfig-smbios-v2-1-861d707b466a@jannau.net>
In-Reply-To: <20260116-apple-defconfig-smbios-v2-1-861d707b466a@jannau.net>
From: Neal Gompa <neal@gompa.dev>
Date: Fri, 16 Jan 2026 13:49:29 -0500
X-Gmail-Original-Message-ID: <CAEg-Je-UqeGMp+-vQLij=Zux0L9mKL4CZYMYHYbi=kvgjOuUYg@mail.gmail.com>
X-Gm-Features: AZwV_Qih0RhiiYZ5DHz0i73_uJf4prcJ1SgxgrjN6STH7fWjrWSzaqlj2u9btyg
Message-ID: <CAEg-Je-UqeGMp+-vQLij=Zux0L9mKL4CZYMYHYbi=kvgjOuUYg@mail.gmail.com>
Subject: Re: [PATCH v2] configs: apple: Enable SMBIOS / sysinfo
To: Janne Grunau <j@jannau.net>
Cc: u-boot@lists.denx.de, Mark Kettenis <kettenis@openbsd.org>, 
 Tom Rini <trini@konsulko.com>, asahi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 16 Jan 2026 20:29:22 +0100
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

On Fri, Jan 16, 2026 at 8:50=E2=80=AFAM Janne Grunau <j@jannau.net> wrote:
>
> Enable verbose SMBIOS table generation so that user space applications
> can use the SMBIOS table to provide details about the system. The
> desired information is chassis-type to determine whether the system is
> laptop.
> Adding the chassis-type property is proposed for the upstream device
> trees in the Linux kernel in [1].
> Enable CMD_SMBIOS as debugging aid as the platform can easily deal with
> large u-boot binaries.
>
> Link: https://lore.kernel.org/asahi/20260109-apple-dt-usb-c-atc-dwc3-v1-0=
-ce0e92c1a016@jannau.net/ [1]
> Reviewed-by: Tom Rini <trini@konsulko.com>
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
> Changes in v2:
> - Added CMD_SMBIOS as suggested by Mark
> - Added Tom's Reviewed-by: trailer
> - Link to v1: https://lore.kernel.org/r/20260109-apple-defconfig-smbios-v=
1-1-16477009c034@jannau.net
> ---
> I do not plan to update u-boot's in-tree device trees. The Linux device
> trees have almost reached feature parity. The main missing features are
> the USB Type-C ports (on track for next merge window) and the laptop
> keyboards. I think it makes more sense to close the feature gap and
> switch to upstream device trees instead of adding to the in-tree device
> trees.
> ---
>  configs/apple_m1_defconfig | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>

Reviewed-by: Neal Gompa <neal@gompa.dev>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
