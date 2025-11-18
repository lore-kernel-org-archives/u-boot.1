Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88BC1CEDDB0
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 15:24:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C32783DBD;
	Tue, 18 Nov 2025 16:24:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DSZ1Gl6l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2DCB83D07; Tue, 18 Nov 2025 16:10:32 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C67283BD2
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 16:10:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b73669bdcd2so759354266b.2
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 07:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763478630; x=1764083430;
 darn=lists.denx.de; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jQt2k/Hcb4zuPrFwWhKQVUma/RoWLU+BIlRGgQ9ru8A=;
 b=DSZ1Gl6l/q5xwxyu3I2zXC9SKp7LAqvInWbMjmH6Ouj9wepFSU0OobpJRzFlW2cinr
 itS2OpGI3g4yY9hPzVfHR99lFCv9SLf0+qnVHFSgajrlM+viOxFHLNypQI/rQeFFto0R
 hxuFVTb9IiYnz8C/8ZooRPJC9QRijbRKYIFy0ApxDm0FFyr+arsZeKdmOuMPIayLg88y
 FpBbjSU4dqouFJV1U7dty56meqXJxcDq8RHc1ZzVYYmhcS0/9qCqM/wEBQE6dC2yki6z
 U3FdWTXXLlPPzYRpFzmcJq5P1wZJe22r1eqG+bWDqjCYedFjshRa2ovB7Y9fcki5aaRf
 C/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763478630; x=1764083430;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jQt2k/Hcb4zuPrFwWhKQVUma/RoWLU+BIlRGgQ9ru8A=;
 b=Px6KuBuJL91vApA8KDTcYPXO5sNrrEIA74U7zp18sgVK0sbA80YaWGrGimS6zI3kNm
 orZBP3679Ymf/bfXfVtng9Ra/506ubemDCc2HRoBGFjjL3LUfgypgDr1l5pcsTxTT2l3
 zTtHMbzfajT0SOhd0Q2XEBrJnZEmNWZUQiKe1svsbVZYOPXgJO9x4vTZ+mxZvccas+Xo
 VqWnUzsBDCEUxgxsgH6QP09A0eRX7UIbtvasc08EG9yC6qP+6Aw1/PpEXBPLIwY2EgZ2
 PwkFfMZ/c4/aLUkDqPATw9n4n9XDqitk16ASXv39t++QHnqf+r+E+5U5to7fJLL9XE2o
 gqfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgWK1qwXmZgukqJWMpGs3rNO8qUw/393VIPvsoybrCnXQDokTcFaqWqRvxOBsDJs78aO7MhGc=@lists.denx.de
X-Gm-Message-State: AOJu0YyBOZLk5Gk6C1hhlqN4AEJB5U1k1FvEJmKGeu+3fMPQAjv106Ke
 jgWg/EVrI40vrYw80NtZqCJJ40n9f86igSYKLxX7c3njPrefMB9hS6M8lHfT2QI1iIs=
X-Gm-Gg: ASbGncskOCxIEfKjoW7QtZEcgONbGPC9E9WVaKs/uJDnvf4h1PTRMxWss9rW7YxWJju
 qyX6EOE8xdNL/R2qopR7d0rpZIbiwJHeKP2shXCRWCAzjU2sCqfrdPsxaESXUGegTLJsmD4j+p7
 qTLF/JExOZyHplQCGuvJ0kHWJQ9cMiix4EDfPxPa7rTRz3UbB5Wjo6ahrJRtm/9YOqPE+7TSU63
 +dyIUyYipEbLlsnxyBUsUL4J/XuS9XpCLe+zyYdBfz6UhajsTgjpWnxmAy2Nz7cuju9UxgBXi1B
 8wVp9klLxkj5Y34Gs9P4hr4gIo4qa8uQX/cappgqMz4tS0yDyTTH1iPTEuPDkNYrPnPcQsDdvhv
 rAA2tKmbLXJsjXqryEA5/zTmion4N2PlUFQyVYKcLq1ITPJ5eGifDYQRpGd0ZW7DeuqXtNA==
X-Google-Smtp-Source: AGHT+IFPAdhuCpl+uhfqiO+odj5kY56TGtD+b612JG/FpypD4EPnmfjq6/LXvJv+EOv35c9SO0/Mtg==
X-Received: by 2002:a17:906:9f8f:b0:b73:7fc8:a9c9 with SMTP id
 a640c23a62f3a-b737fc8c1d0mr1228530166b.29.1763478630355; 
 Tue, 18 Nov 2025 07:10:30 -0800 (PST)
Received: from localhost ([62.246.248.122]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b734fad4635sm1373301066b.26.2025.11.18.07.10.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 07:10:29 -0800 (PST)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=69b3e66a43c364a8cf7b0db638113c450d681eed1b740c2edaa83e19827e;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Tue, 18 Nov 2025 16:10:24 +0100
Message-Id: <DEBX005BON2S.1310DKOYIIK9V@baylibre.com>
Cc: "Maarten Brock" <Maarten.Brock@sttls.nl>, <u-boot@lists.denx.de>, "Kory
 Maincent" <kory.maincent@bootlin.com>, "Rasmus Villemoes" <ravi@prevas.dk>,
 "Rayagonda Kokatanur" <rayagonda.kokatanur@broadcom.com>, "Tien Fong Chee"
 <tien.fong.chee@altera.com>, "Alif Zakuan Yuslaimi"
 <alif.zakuan.yuslaimi@altera.com>, "Casey Connolly"
 <casey.connolly@linaro.org>, "Tingting Meng" <tingting.meng@altera.com>,
 "Peng Fan" <peng.fan@nxp.com>, "Quentin Schulz" <quentin.schulz@cherry.de>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, "Liya Huang"
 <1425075683@qq.com>, "Marek Vasut" <marek.vasut+renesas@mailbox.org>,
 "Romain Gantois" <romain.gantois@bootlin.com>, "Simon Glass"
 <sjg@chromium.org>, "Jaehoon Chung" <jh80.chung@samsung.com>, "Miquel
 Raynal" <miquel.raynal@bootlin.com>, "Marek Vasut" <marex@denx.de>,
 "Mattijs Korpershoek" <mkorpershoek@kernel.org>, "Andrew Goodbody"
 <andrew.goodbody@linaro.org>, "Anatolij Gustschin"
 <ag.dev.uboot@gmail.com>, "Sukrut Bellary" <sbellary@baylibre.com>, "Yegor
 Yefremov" <yegorslists@googlemail.com>
Subject: Re: [PATCH 03/15] arm: omap2plus: Select REGMAP
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Tom Rini" <trini@konsulko.com>, "Markus Schneider-Pargmann (TI.com)"
 <msp@baylibre.com>
X-Mailer: aerc 0.21.0
References: <20251118-topic-am33-evm-oftree-v2026-01-v1-0-91ce13c661e2@baylibre.com>
 <20251118-topic-am33-evm-oftree-v2026-01-v1-3-91ce13c661e2@baylibre.com>
 <20251118140258.GP2125796@bill-the-cat>
In-Reply-To: <20251118140258.GP2125796@bill-the-cat>
X-Mailman-Approved-At: Tue, 18 Nov 2025 16:24:05 +0100
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

--69b3e66a43c364a8cf7b0db638113c450d681eed1b740c2edaa83e19827e
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Tom,

On Tue Nov 18, 2025 at 3:02 PM CET, Tom Rini wrote:
> On Tue, Nov 18, 2025 at 11:40:23AM +0100, Markus Schneider-Pargmann (TI.c=
om) wrote:
>
>> clk/ti/clk.c is compiled when ARCH_OMAP2PLUS is set and uses regmap
>> functions. Add REGMAP dependency to prevent linking errors when CLK_TI_*
>> options are enabled.
>>=20
>> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
>> ---
>>  arch/arm/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>=20
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index 3db5474a05b8c08e111e8c8b98c3a6fe68de15f2..c72821ce2131e9d9deebef4f=
ce3757fc68bd9f3f 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -844,6 +844,7 @@ config ARCH_OMAP2PLUS
>>  	bool "TI OMAP2+"
>>  	select CPU_V7A
>>  	select GPIO_EXTRA_HEADER
>> +	select REGMAP
>>  	select SPL_SOC_INIT if SPL
>>  	select SPL_STACK_R if SPL
>>  	select SUPPORT_SPL
>
> This belongs with the appropriate CLK entry, and Yegor Yefremov has been
> fixing some issues along these lines recently as well.

Yes, that's what I wanted to do, but the functions that use regmap are
compiled if ARCH_OMAP2PLUS is selected. From drivers/clk/ti/Makefile:

  obj-$(CONFIG_ARCH_OMAP2PLUS) +=3D clk.o omap4-cm.o

clk.c is where the required functions are implemented.

Best
Markus

--69b3e66a43c364a8cf7b0db638113c450d681eed1b740c2edaa83e19827e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaRyMYBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlOp
IQD8DfCpRuN1+auc049AKOxzatQHcgvqtRvm4v/My2rRSdUA/iT2o0TvTV7S1FoY
NskZZKye/f7vUxYg3oMRMckUQ4oK
=kHVh
-----END PGP SIGNATURE-----

--69b3e66a43c364a8cf7b0db638113c450d681eed1b740c2edaa83e19827e--
