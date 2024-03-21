Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C003C54E58
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 09:17:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F80387D08;
	Thu, 21 Mar 2024 10:17:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="mC8THJYI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D03187C7F; Thu, 21 Mar 2024 10:17:06 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC4EA87BAF
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 10:16:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5684db9147dso692329a12.2
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 02:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1711012618; x=1711617418;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JdYMWj1J+B5ervTDzI4sGamn8PGSp9ouS1kj4QW4Xm8=;
 b=mC8THJYIgKKALtklpyoGBtk8CSTG7MO39n8plKkCDHWDOFADV5bYUftyPjIZArEXOY
 Z14imVdIbd4Bgw7Zedu90ATeDFxeh8JBFWAV7iJKlyFjW2SlT35vEoZwmkSONARH7rz5
 ecy5YFVjFEN8po3qy6EKbF5QLTnhEoh48e6uY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711012618; x=1711617418;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JdYMWj1J+B5ervTDzI4sGamn8PGSp9ouS1kj4QW4Xm8=;
 b=MIjxNk4AY1DlmfBJtrSVKKz6N+RblAvvoKTSEWifSlzzYV8emmwSuhAg7Obaf38AdF
 YD6QT2VnFX2sp5ujL/uqlHlFZ0mQRGFWa1aj/MtBfMWyQKkw7grlt2qKoLjCw0fzWyR3
 QSA7OeEAvo9b8DEQPAyrkJCaK/MP4ym9Hy96vMQzumDyhupDqHfGvt1rI2tBlklWP33L
 3rKZ9uRXiB6Q7d0N8mhBYF2nk6B7pTeKZIuZgXfJvLzp+7smix/OkjUvaFz/J3Wz8GEt
 vbr8BKEDRi2HpXabovWZo4B6I1iYA/FrVBekmQoL4ZeegtWVTTf/B45dJjsf+RFTN592
 54jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlGVvtSSulyGM/V8Uk3fpxpdxi9/ETiHi9lmZY5oCyzWXZQ4PnGmLVaQYF7JIK220Tu9ao6kv7Z8XqeRbPzCgmLYTh+A==
X-Gm-Message-State: AOJu0YzEqeTfh30FQS6eGNCQxNPuvHMWr+/h1RYAAmNfSyBo9hDtkjPU
 67p4WhvKD1hzURytcURY/p4aHAvYKhhDhSZ9HWKHwKmMXoHdwPPeDr7oGsJNa4BW31g8jrwGVHR
 1YoZ7fu/iB7zKSlVIS5iQ+NQ+Ci601TV8urAjmw==
X-Google-Smtp-Source: AGHT+IHfg7ePhkHSKN3U9FUmJOzhMua84dVmrz/5L9HS97UdlfqaLOpyyQawp+loyIKnV4+PVfLhA7oLCSEUevjHUXc=
X-Received: by 2002:a17:907:7e94:b0:a46:ad7c:ccc7 with SMTP id
 qb20-20020a1709077e9400b00a46ad7cccc7mr10850591ejc.59.1711012618221; Thu, 21
 Mar 2024 02:16:58 -0700 (PDT)
MIME-Version: 1.0
References: <20240320090214.40465-1-ada@thorsis.com>
 <20240320090214.40465-7-ada@thorsis.com>
 <PH8PR11MB680479987099973E85D6CC6C82332@PH8PR11MB6804.namprd11.prod.outlook.com>
In-Reply-To: <PH8PR11MB680479987099973E85D6CC6C82332@PH8PR11MB6804.namprd11.prod.outlook.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Thu, 21 Mar 2024 10:16:46 +0100
Message-ID: <CAOf5uwmeW0_0rjXgoPBHK2XPYJk=D9Cdw4Qc7rQ_TPuOanCHwQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] cmd: nand: Add new optional sub-command 'onfi'
To: Mihai.Sain@microchip.com
Cc: ada@thorsis.com, dario.binacchi@amarulasolutions.com, 
 Balamanikandan.Gunasundar@microchip.com, eugen.hristev@collabora.com, 
 Bin.Li@microchip.com, u-boot@lists.denx.de
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

Hi

I think this command can be really useful.

On Wed, Mar 20, 2024 at 3:09=E2=80=AFPM <Mihai.Sain@microchip.com> wrote:
>
> Hi Alex,
>
> --------------------------------------------------------
>
> Override the ONFI timing mode at runtime.
>
> Signed-off-by: Alexander Dahl <ada@thorsis.com>
> ---
>
> I used the same board sam9x75-curiosity to test mode 5 =F0=9F=98=8A
>
> I forced in nfc driver the mode 5:
> +       if (conf->timings.sdr.tRC_min < 20000)
>
> And I ran the nand torture on 16 MiB:
>
> =3D> nand onfi 0
> =3D> hsmc decode
>
> MCK rate: 270 MHz
>
> SMC_SETUP2:     0x00000007
> SMC_PULSE2:     0x22112211
> SMC_CYCLE2:     0x00220022
> SMC_MODE2:      0x001f0003
> NCS_RD: setup: 0 (0 ns), pulse: 34 (102 ns), hold: 0 (0 ns), cycle: 34 (1=
02 ns)
>    NRD: setup: 0 (0 ns), pulse: 17 (51 ns), hold: 17 (51 ns), cycle: 34 (=
102 ns)
> NCS_WR: setup: 0 (0 ns), pulse: 34 (102 ns), hold: 0 (0 ns), cycle: 34 (1=
02 ns)
>    NWE: setup: 7 (21 ns), pulse: 17 (51 ns), hold: 10 (30 ns), cycle: 34 =
(102 ns)
> Standard read applied
> TDF optimization enabled
> TDF cycles: 15 (45 ns)
> Data Bus Width: 8-bit bus
> NWAIT Mode: 0
> Write operation controlled by NWE signal
> Read operation controlled by NRD signal
>
> =3D> time nand torture 0x800000 0x1000000
>
> NAND torture: device 0 offset 0x800000 size 0x1000000 (block size 0x40000=
)
>  Passed: 64, failed: 0
>
> time: 30.152 seconds
>
> =3D> nand onfi 5
> =3D> hsmc decode
>
> MCK rate: 270 MHz
>
> SMC_SETUP2:     0x00000001
> SMC_PULSE2:     0x0b060804
> SMC_CYCLE2:     0x000b0008
> SMC_MODE2:      0x001f0003
> NCS_RD: setup: 0 (0 ns), pulse: 11 (33 ns), hold: 0 (0 ns), cycle: 11 (33=
 ns)
>    NRD: setup: 0 (0 ns), pulse: 6 (18 ns), hold: 5 (15 ns), cycle: 11 (33=
 ns)
> NCS_WR: setup: 0 (0 ns), pulse: 8 (24 ns), hold: 0 (0 ns), cycle: 8 (24 n=
s)
>    NWE: setup: 1 (3 ns), pulse: 4 (12 ns), hold: 3 (9 ns), cycle: 8 (24 n=
s)
> Standard read applied
> TDF optimization enabled
> TDF cycles: 15 (45 ns)
> Data Bus Width: 8-bit bus
> NWAIT Mode: 0
> Write operation controlled by NWE signal
> Read operation controlled by NRD signal
>
> =3D> time nand torture 0x800000 0x1000000
>
> NAND torture: device 0 offset 0x800000 size 0x1000000 (block size 0x40000=
)
>  Passed: 64, failed: 0
>
> time: 15.891 seconds
>

Let try to have more testing on more boards

Michael

> Best regards,
> Mihai Sain



--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
