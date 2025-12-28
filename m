Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C37E92722
	for <u-boot@archiver.kernel.org>; Sun, 28 Dec 2025 01:53:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8158F83990;
	Sun, 28 Dec 2025 02:53:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ksN1+eI4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED7FF8399B; Sun, 28 Dec 2025 02:53:46 +0100 (CET)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4756183981
 for <u-boot@lists.denx.de>; Sun, 28 Dec 2025 02:53:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-598f81d090cso8815797e87.2
 for <u-boot@lists.denx.de>; Sat, 27 Dec 2025 17:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766886823; x=1767491623; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aP8kZ1XDSI/16gWIUbXb4AO3pGJ8qgCC4VK8V8lYSiU=;
 b=ksN1+eI4MHD1UhBl2rS7Bm9d7EGjEaXo1AhOT5BtMXRKVT5HA0OvqSLh88CURDlzwN
 vzpWeBgWUab0+PZNDsYyI0BD/AsanPLqA4Da0ll3cfSg9UEOG5punpQ5UikR+ALUFuBK
 beW1DILDGBXxtrhWKinZzUoBN0RTZAcoE30+LnqXNs5Fh43DstrwsAGhHKwgZhyoa0oS
 gcTAr/WzZlT31EboOXIN316loEcPwFR0jdF37zAKiYhBIS7LDB47CuZu8lnpSFMotyTX
 qAyhzw+TWeX2laEFyjMi3lgqJ5nRYnJLcXQM7bNOomnZh40oNNmwY9rn7nfuXm/KnGxC
 cRJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766886823; x=1767491623;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aP8kZ1XDSI/16gWIUbXb4AO3pGJ8qgCC4VK8V8lYSiU=;
 b=ivLb57KrnDpo38KcRjgKVUSwVz/DkkA/4TqeQOZR5Q16hhZqNArexzYpW1Kq/KWtiF
 UiZVidYLFZFylNk+Domk56HKAsmEpclRyJI/0oVmDDiHDPuCWRZtJY5/bhSHmkq8Cpo0
 mcCUS7FpoMOjjH5Yqbc9bi6/2n2JWC5xO2gl4HgzjKbvDKm53ktQoG3L259nGrCJT0Di
 xymSl2JfSi6CvTwKeXEGwMIwgSBjgHVrYosKKDKR0M3f/jGODkC8N65gKusJ95m9fir4
 EH/vag4ChJxaBMdg2F+3cBxAalCCR1wijBYqTbtEvezNkjLcNlUfaGeV+sFJ98n1PpIp
 dpqQ==
X-Gm-Message-State: AOJu0YyyURE9dElCKRzuh8lEILMl7f7mY9r448n50qSHpXddPXCq5acE
 /RRmRYc4wLdgs6lA6l9LCpBgKnRUm4xwcZMsvCLwRSjfSDPF3fuZNTSKAdJ6FakOFTgotIZnEBc
 +RA7GvUflqLAFV5fQxlpoK0/cTpQ1rvg=
X-Gm-Gg: AY/fxX7I23xzHRtpzNOFkhNbqlignS3InU3X4NysbEbFZK/dhFVC1/sFT2fHY01yAeA
 7Ofdjbov5xapqcvuNSyGoeJg2FGqey1bzOsIG8fJeLzU+h+58KpOnhi6Irb5/pu5yH3EOTS1+IO
 OepTtomUqMTjtRIIZFDpNR1sCEgxCAEA+ftTAPBDAuQIdH2s376Pa/Rb1sXlZCJcgDg6U48t20l
 UYIEt8hZu9JesV9iqOJ77tt0S24XjuuFbsXWkoCF3d6sWefqDomvusVcTy5gXxSuti2lDTtQB2j
 77dKxSvJ
X-Google-Smtp-Source: AGHT+IFPc3VCL54BvcL6QY6wACZ6S79yDMMc0fTEi1YlQ6MX56mHidA+nwpDZZSOQXJSQxk03oByhWbBg7QhWAa/kjk=
X-Received: by 2002:a05:6512:3f26:b0:594:4b55:d2dc with SMTP id
 2adb3069b0e04-59a17d64f00mr8542396e87.47.1766886823135; Sat, 27 Dec 2025
 17:53:43 -0800 (PST)
MIME-Version: 1.0
References: <20251218083326.644326-1-brian.ruley@gehealthcare.com>
 <20251218083326.644326-8-brian.ruley@gehealthcare.com>
In-Reply-To: <20251218083326.644326-8-brian.ruley@gehealthcare.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 27 Dec 2025 22:53:31 -0300
X-Gm-Features: AQt7F2roihmtmglaT2U9yHvPGJfFhjAbpf_kvYS7fvJqLdbEasPAmSgzrDU6j38
Message-ID: <CAOMZO5DOUE2PexcBcVcg3vYTo5eV=LT3=S9cSBosLCyir8Kw5g@mail.gmail.com>
Subject: Re: [PATCH v1 7/7] video: imx: ipuv3: refactor to use dm-managed state
To: Brian Ruley <brian.ruley@gehealthcare.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@nabladev.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, David Zang <davidzangcs@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
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

On Thu, Dec 18, 2025 at 5:33=E2=80=AFAM Brian Ruley
<brian.ruley@gehealthcare.com> wrote:

> diff --git a/arch/arm/mach-imx/cpu.c b/arch/arm/mach-imx/cpu.c
> index cc215b771ef..2aa9d9c9666 100644
> --- a/arch/arm/mach-imx/cpu.c
> +++ b/arch/arm/mach-imx/cpu.c
> @@ -285,10 +285,10 @@ u32 get_ahb_clk(void)
>
>  void arch_preboot_os(void)
>  {
> -#if defined(CONFIG_IMX_AHCI)
>         struct udevice *dev;
>         int rc;

This causes failure in CI:

https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/1340742

Please fix and resend.
