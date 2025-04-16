Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED54C369B1
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 04:38:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AF6781E14;
	Wed, 16 Apr 2025 06:38:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j6ebwoKW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2BF881E72; Wed, 16 Apr 2025 06:38:30 +0200 (CEST)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82D2E81DE3
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 06:38:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-af55b7d56a1so4807650a12.2
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 21:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744778307; x=1745383107; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5fPxvXgQbo90nohQ4+HR2bSKfsk5ii0mh8Cv5vQ1Zuk=;
 b=j6ebwoKWzbf2zAZUQgnXPBqt/XnAnxju2IyuHsaiRo2XfPRmummuN+HxcA5Wcjms/a
 ixWHEkDJIUCrVUAtC+ZpfaecXctXpsYkj131nHEMBOxCYMwMlm4qDaVrJm/cjPdIHgzP
 +hqoYEbOVCQun0Y+JaA3HkQwNPOsj6r+Lwx7fw1pLvmxi/kVteL6l9GvLYzIJVPd4ziG
 9fZ9rfX7Sqi+8GA8Y5o0p2gqwgvh3PBLFrVKbJI33p3LAYdDREDkssIb+xZ0QXJFYFB0
 UzA5yomn2zpZuLFnh6W3ckSmhI2gNbVZjaSUI26W8XpBUvkCBPpD8Eh4cycuaWgHT13m
 Kzyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744778307; x=1745383107;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5fPxvXgQbo90nohQ4+HR2bSKfsk5ii0mh8Cv5vQ1Zuk=;
 b=HVdlh8vDdeYW6pYmWTiYbZWU7Ezp9ooRTdoTkVHf9ZaVxdIyAy3LkJVYBi12n7v65A
 RjjLYRDx4Ry9swCvHp9apRHPPKvoxE2sTwfGOXZPqwjw0NiEXH9Epkyo4kzPVkV8M641
 5NNTBqb5kvifWBESNz3iSv8IPz3vEA1ev0syCvWPqktNsH5hG7/Vs3aFwQvqHUJz6ITy
 3NNHFr+egfIgH6722iueyVqdZl51VgQ5seQuLzNW7LtLVG4zZ7WL2EJnP7YM8vDylWsd
 6u6QHO1JjBQDfZbO0U1t/KxhlYpAV/xvIwYzPbdfFz+NQXFvGlRHK4T/9ZCuzpD67fWC
 u+VQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHCw7F4q4nhKx3sosCvRPu9FNDgdLNByxWzWY9xidCFsph5sIdxeD2oTuOX4ZKbtIX2dSWRYM=@lists.denx.de
X-Gm-Message-State: AOJu0YwC+U5ZvMxH+p24GEijkiHErSg24Lp2wBeKIclZa+piHK6sPrtQ
 oIqKtUIMr+c2FCmYwRQiGE10195k5kkNPx7ZKBcDSLpa2Ajz3joXxV/LvFqk5cNUhXt0FbIAgTS
 ACylyy4GbVFqI/PIERR8LTCMucxg=
X-Gm-Gg: ASbGncvJzZ9ILrhik8q5fhFoX6f5Z5tyP/k0iKUnrSwo9Lzp12/E3krr9Ea79fq0Bpe
 pubkEcG7wf6NIOGldF+Z5MptC7qLPX4hL/Vq7F5Q0A28WrAnzDHo3eijtXC+EUYgE/7dNM0k9f8
 MB7MVfl1axgvQ5/E9Bu75OYA==
X-Google-Smtp-Source: AGHT+IFF2XMak2r4TjD+xu93Ds60lXLJM2urGD3hBqGglKFo0qlipndAIRMKPatpui/FFKwpp5lTY3JyLvhqD8Iwp/o=
X-Received: by 2002:a17:90b:2f0b:b0:2f9:c139:b61f with SMTP id
 98e67ed59e1d1-30863f19dffmr581237a91.14.1744778306791; Tue, 15 Apr 2025
 21:38:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250323160107.145749-1-marex@denx.de>
 <20250323160107.145749-17-marex@denx.de>
 <20250415142846.GA244333@francesco-nb>
 <CAHCN7xLa5W-AtRso6RUZwZG_sfDm9CHierfzt_WfOqFjSGJZoA@mail.gmail.com>
 <20250415150344.GA246483@francesco-nb>
 <b396cb96-ff95-4822-ad24-ddff2e3b6545@denx.de>
 <CAOMZO5B=j=k8U6to2TDzohS11j4hPWQOho9bdrYCPe0WXtrQjw@mail.gmail.com>
In-Reply-To: <CAOMZO5B=j=k8U6to2TDzohS11j4hPWQOho9bdrYCPe0WXtrQjw@mail.gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Tue, 15 Apr 2025 23:38:15 -0500
X-Gm-Features: ATxdqUE_B5MmzgNL22rPZ8rwW3F0NSmsUULNb-byXE1Uaz_cRW9f2Ocp1uLnPo8
Message-ID: <CAHCN7x+1YrF_-R4aqRy5OioGWpLKmhacZjhT6=EGEK97i3WO9g@mail.gmail.com>
Subject: Re: [REGRESSION] Re: [PATCH v2 16/24] clk: imx: Convert clock-osc-*
 back to osc_*
To: Fabio Estevam <festevam@gmail.com>
Cc: Marek Vasut <marex@denx.de>, Francesco Dolcini <francesco@dolcini.it>, 
 Fabio Estevam <festevam@denx.de>, u-boot@lists.denx.de, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Peng Fan <peng.fan@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, uboot-imx@nxp.com
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

On Tue, Apr 15, 2025 at 12:13=E2=80=AFPM Fabio Estevam <festevam@gmail.com>=
 wrote:
>
> On Tue, Apr 15, 2025 at 1:55=E2=80=AFPM Marek Vasut <marex@denx.de> wrote=
:
>
> > Do you have af9cdd1ccd2d ("Revert "arm64: dts: imx8mn: Include 32kHz
> > oscillator clock in SPL DTs"") in place ? If so, try and revert it, doe=
s
> > it help ?
>
> It seems I have not pushed the "Revert "arm64: dts: imx8mn: Include 32kHz
> oscillator clock in SPL DTs" fix. Sorry about that.

On my Nano, if I revert arm64: dts: imx8mn: Include 32kHz oscillator
clock in SPL DTs" it does not boot any more.

I haven't tried on my Mini and Plus yet, but if you want, I can.

adam
>
> As Francesco is using imx8mp, then I guess we also need to do the same
> for imx8mp:
>
> diff --git a/arch/arm/dts/imx8mn-u-boot.dtsi b/arch/arm/dts/imx8mn-u-boot=
.dtsi
> index 96a6df94c6cf..6cc910ee9835 100644
> --- a/arch/arm/dts/imx8mn-u-boot.dtsi
> +++ b/arch/arm/dts/imx8mn-u-boot.dtsi
> @@ -68,11 +68,6 @@
>         bootph-all;
>  };
>
> -&osc_32k {
> -       bootph-pre-ram;
> -       bootph-all;
> -};
> -
>  #ifdef CONFIG_FSL_CAAM
>  &sec_jr0 {
>         bootph-pre-ram;
> diff --git a/arch/arm/dts/imx8mp-u-boot.dtsi b/arch/arm/dts/imx8mp-u-boot=
.dtsi
> index 6de9ab5d37cf..35af412f01b0 100644
> --- a/arch/arm/dts/imx8mp-u-boot.dtsi
> +++ b/arch/arm/dts/imx8mp-u-boot.dtsi
> @@ -37,11 +37,6 @@
>         /delete-property/ assigned-clock-rates;
>  };
>
> -&osc_32k {
> -       bootph-pre-ram;
> -       bootph-all;
> -};
> -
>  &osc_24m {
>         bootph-pre-ram;
>         bootph-all;
>
> Does this fix the boot problem?
