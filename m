Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34957C54E60
	for <u-boot@archiver.kernel.org>; Sun, 17 Mar 2024 15:52:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 470088753A;
	Sun, 17 Mar 2024 16:52:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A7EF87916; Sun, 17 Mar 2024 16:52:05 +0100 (CET)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8ABD1869F7
 for <u-boot@lists.denx.de>; Sun, 17 Mar 2024 16:52:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ngompa13@gmail.com
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-a3ddc13bbb3so852831566b.0
 for <u-boot@lists.denx.de>; Sun, 17 Mar 2024 08:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710690722; x=1711295522;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S+1daUl7RQJOxUjNePwtmnUxaWO4L5xItqbCG0F5brY=;
 b=C7fJWB11jK/nbO6h38IQdco1Ke38TOfypR9pt9lXNN3N+J8b1oIcty4YntpSKvsVyQ
 r58URfh8VbHLwV6jgFhPnlGlwG9X9e0T4w1u+C9/u6E2BiD6g0/WkWymahlj93c0gerN
 6eXsvGOSq679Zkd9zufYKXRMDohPxmUMLtEP9MtyOABMtrlSQluxafbf8n8p3P1fkBzE
 1yNMOE+HSeifs53fH8yy0WQh2I2wCDpDN8Us0xApmucWoyu4HxM9J43YBe8XT/tm7w8C
 Pnu1IDM5nJyJgIRQGHmkL3+Hz6wQXlotawmvWuEZx940+beYyoa5d3RhclihqUaXVEai
 Vkkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9dN8S9G/qpRCQrSThn/g3prfcauEC1ZH/s45tlhZUk2dNqVza8bsgMKLma3LLdgeWFluMJszwFHFLxuFBFfgW7MZFXg==
X-Gm-Message-State: AOJu0Yx4fQ9LyU4xN6TllUs/JYpwDrE5tDBNoo8A3SdU7Ds+glY7OiDC
 ynWF5kxVZUVzH/XHEqYu3Ni/+vxh0sKtNch/rJT5ICtQr1Nn9DaoCPpdB184sjE=
X-Google-Smtp-Source: AGHT+IGGszFZco2xJe0OjMpDdUxjZwc3xaa+84UGWEg5gw1G1q+OHT8viLbMlefGFiP0nRv+FVOiuw==
X-Received: by 2002:a17:906:a8b:b0:a46:8b1d:3d4f with SMTP id
 y11-20020a1709060a8b00b00a468b1d3d4fmr5776982ejf.28.1710690722347; 
 Sun, 17 Mar 2024 08:52:02 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com.
 [209.85.208.43]) by smtp.gmail.com with ESMTPSA id
 wr6-20020a170907700600b00a466c66804bsm3857392ejb.49.2024.03.17.08.52.02
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 Mar 2024 08:52:02 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-565c6cf4819so7951207a12.1
 for <u-boot@lists.denx.de>; Sun, 17 Mar 2024 08:52:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCXAFWR+OmFuSzZUl+5Q3JXEjH+9aS0WWfb03SEhsEMcNMj6PJRoC4Gg0rUVwWEJ1WGkYaB2YZfJAZOmxwqXnmeZ/9Cwmw==
X-Received: by 2002:a17:907:6d16:b0:a46:a8b8:f4cf with SMTP id
 sa22-20020a1709076d1600b00a46a8b8f4cfmr3390694ejc.35.1710690722073; Sun, 17
 Mar 2024 08:52:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240317-apple_config-v1-0-1b862bc140a9@jannau.net>
In-Reply-To: <20240317-apple_config-v1-0-1b862bc140a9@jannau.net>
From: Neal Gompa <neal@gompa.dev>
Date: Sun, 17 Mar 2024 08:51:25 -0700
X-Gmail-Original-Message-ID: <CAEg-Je-mnLRGhSnMgwffXek-P4vJj=S8Kbog6EgwEyrQOpMgmw@mail.gmail.com>
Message-ID: <CAEg-Je-mnLRGhSnMgwffXek-P4vJj=S8Kbog6EgwEyrQOpMgmw@mail.gmail.com>
Subject: Re: [PATCH 0/4] configs: apple: Switch to standard boot + small
 adjustments
To: j@jannau.net
Cc: Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, asahi@lists.linux.dev, 
 Hector Martin <marcan@marcan.st>
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

On Sun, Mar 17, 2024 at 7:54=E2=80=AFAM Janne Grunau via B4 Relay
<devnull+j.jannau.net@kernel.org> wrote:
>
> This series contains a few misc config changes for Apple silicon
> systems:
> - switch from the deprecated distro boot scripts to standard boot
> - allows EFI console resizing based on the video console size
> - enables 16x32 bitmap fonts as Apple devices come with high DPI
>   displays
> - enables 64-bit LBA addressing for USB storage devices larger than 2TB
>
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
> Hector Martin (1):
>       apple_m1_defconfig: Turn on CONFIG_SYS_64BIT_LBA
>
> Janne Grunau (3):
>       configs: apple: Use "vidconsole,serial" as stdout/stderr
>       configs: apple: Enable CMD_SELECT_FONT and FONT_16X32
>       arm: apple: Switch to standard boot
>
>  arch/arm/Kconfig           |  2 +-
>  configs/apple_m1_defconfig |  3 +++
>  include/configs/apple.h    | 24 ++++--------------------
>  3 files changed, 8 insertions(+), 21 deletions(-)
> ---
> base-commit: f3c979dd0053c082d2df170446923e7ce5edbc2d
> change-id: 20240317-apple_config-981fcd9028b9
>

LGTM.

Reviewed-by: Neal Gompa <neal@gompa.dev>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
