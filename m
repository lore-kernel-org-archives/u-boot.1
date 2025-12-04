Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44300D2A532
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 20:32:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9599E84197;
	Thu,  4 Dec 2025 21:31:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nJc4cSh9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B15348413A; Thu,  4 Dec 2025 21:02:29 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD3728412C
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 21:02:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b79b9113651so221672066b.3
 for <u-boot@lists.denx.de>; Thu, 04 Dec 2025 12:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764878537; x=1765483337;
 darn=lists.denx.de; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zUCTd51qd5hKszdI0KjZpjXdlT6BqRNJ1BIHw/1fmy4=;
 b=nJc4cSh9MFPLjnRiOP6/um6f1tyf1iu8GJVKdc8uNHD3h8VcY8lRaTWYjKhZhpF5Rx
 uZ6JrjkiGmH5gf2rwzqhe4lB+gzuZcZn9vcfRQZo/XpwYfI6D6T148v5h3CuKKmsVa8J
 VWUQ6hySbZQQWyTPvxjbRvLJruKjaUlxHD0WMIAgdWNqHhiO29a83lzysNyD2fpLanYe
 QX+4hjywPxgYh2tYR/Ak6yvX11bHNVYd2mSUJKdBO95baLCJKfaMORRoOiUHvT6aL+rC
 DPPT9wzl1WWzx3BLijV991TfThMGQWHuz+vXubFw82GRDZ4zXNKVyTkyc7U1osHukdFY
 nmxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764878537; x=1765483337;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zUCTd51qd5hKszdI0KjZpjXdlT6BqRNJ1BIHw/1fmy4=;
 b=JOg1e1nmTrcJqhlykYvtty5f7PP6bH+KyQvt80/7mVItop7t/ToKa4eGUWrMW0c/zH
 k7NMlWjWtuGJNwJWY9eba/03HlBo9srXl9Sdf3O2MF1j7sZZiV4FHUAOyRRmBZBk+APF
 1gW8kyisvjiXRa9P5Plr8YZJ7O9koGdspMeSb5CFQ6iLZAmmH57bTaX7XfBVjK9irVTW
 fxJgrVq91YQ4a5XBNC/UEsIEXwXQB7jYJU/4LK0WUCXtRko7Pb0RPy2I1GlvoGd1vlJ9
 mXB+W7aWXzp3FVLSvtODwO78VAk0XBq4yL1yKQM2FwdgScDUOI/qeJzb/qlzRoj7Ae6V
 J6XA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZGnbXBDYapah7syUuuhOR25rkfKoUnEgz/n+boav+HZbwKEZXZZ1A7ckKgOu4DcuuTFXGZMI=@lists.denx.de
X-Gm-Message-State: AOJu0YwqV2Ti1X7w52GL6+JoLSFD2N6w3oRAZvj6IuRMkwCbPYKYYwxo
 KA96zId7ifpUBtmiWvS1nSmlyhaEHGTSEauePC5fyot2tN7MLK5/ZNNAqlAkJZTbpJ0=
X-Gm-Gg: ASbGncttBDNfzhLZ8XzU8SKFjs+1MYLWvrYhjha0GPk8E5AkCrQEp9vkfCAu8Anfs/g
 UkbnflZeIn7kzBnCchMbGBye9KfwLzAlVDaIr1tgh7R/ViTppC8yTn+RpKfAn3bG54xMbJNjZNA
 gmTcTHBy5iyKb3LZrTrjAe5HKBNkOpVgRHhZWKDEF4OZ2MLyR4tq+UUzbsSSo/bxmdxW3OQWYQU
 mXNUNrkUAh8KxVMSYwV2ZRr7si3XH/d74eo8TWosgsZd4H1baepXLzwZ80PgB78OyKb37HZPByH
 t/UZwHms8fyM5fTKucDXL16TjNkNxXWrqfBovTmDHgnt/w4UZpr58HoGS7LRh/90wHIESCPhYff
 QkxB+bTL4vXXMNvEqZO5eVdqANxYh9pK95w7/hCO4HjgNSkm4FNNPttL+r6CURi+Ksbfg1u8MFs
 3VxO7i
X-Google-Smtp-Source: AGHT+IH4elUF9Al10ykM75B+lbxnV06JL4ksDatXAAwl5RJPCdgE7Ofw7nXHrokMU8/whjrbVrdXQQ==
X-Received: by 2002:a17:906:6a0b:b0:b72:598:2f32 with SMTP id
 a640c23a62f3a-b79ec6b9779mr453796066b.42.1764878536351; 
 Thu, 04 Dec 2025 12:02:16 -0800 (PST)
Received: from localhost ([62.246.248.122]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b79f49a897fsm203699366b.51.2025.12.04.12.02.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 12:02:15 -0800 (PST)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=48f16a4986ac7d214aa9b174a13bc4b0adffa9bf1bdf1782ba9f03a23b44;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Thu, 04 Dec 2025 21:02:09 +0100
Message-Id: <DEPP83IZ95UJ.3P51G8RXU01P7@baylibre.com>
Cc: "Vishal Mahaveer" <vishalm@ti.com>, "Kevin Hilman"
 <khilman@baylibre.com>, "Dhruva Gole" <d-gole@ti.com>, "Sebin Francis"
 <sebin.francis@ti.com>, "Kendall Willis" <k-willis@ti.com>, "Akashdeep
 Kaur" <a-kaur@ti.com>, <u-boot@lists.denx.de>, "Anshul Dalal"
 <anshuld@ti.com>, "Moteen Shah" <m-shah@ti.com>, "Santhosh Kumar K"
 <s-k6@ti.com>, "Nathan Morrisson" <nmorrisson@phytec.com>, "Garrett
 Giordano" <ggiordano@phytec.com>, "Judith Mendez" <jm@ti.com>, "Aparna
 Patra" <a-patra@ti.com>, "Jayesh Choudhary" <j-choudhary@ti.com>, "Chintan
 Vankar" <c-vankar@ti.com>, "Ilias Apalodimas"
 <ilias.apalodimas@linaro.org>, "Neha Malcom Francis" <n-francis@ti.com>,
 "Prasanth Babu Mantena" <p-mantena@ti.com>, "Sughosh Ganu"
 <sughosh.ganu@linaro.org>, "Beleswar Padhi" <b-padhi@ti.com>, "Andrew
 Davis" <afd@ti.com>, "Wadim Egorov" <w.egorov@phytec.de>, "Udit Kumar"
 <u-kumar1@ti.com>, "Andrew Goodbody" <andrew.goodbody@linaro.org>, "E
 Shattow" <e@freeshell.de>, "Devarsh Thakkar" <devarsht@ti.com>, "Peng Fan"
 <peng.fan@nxp.com>, "Jerome Forissier" <jerome.forissier@linaro.org>, "Sam
 Protsenko" <semen.protsenko@linaro.org>, "Marek Vasut"
 <marek.vasut+renesas@mailbox.org>, "Andre Przywara"
 <andre.przywara@arm.com>, =?utf-8?q?Th=C3=A9o_Lebrun?=
 <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v6 11/13] arm: dts: k3-am62p: Add r5 device nodes
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Chawdhry, Manorit" <m-chawdhry@ti.com>, "Markus Schneider-Pargmann
 (TI.com)" <msp@baylibre.com>, "Tom Rini" <trini@konsulko.com>, "Sumit Garg"
 <sumit.garg@kernel.org>, "Nishanth Menon" <nm@ti.com>, "Robert Nelson"
 <robertcnelson@gmail.com>, "Vignesh Raghavendra" <vigneshr@ti.com>, "Bryan
 Brattlof" <bb@ti.com>
X-Mailer: aerc 0.21.0
References: <20251120-topic-am62-ioddr-v2025-04-rc1-v6-0-6dd99a7271bb@baylibre.com>
 <20251120-topic-am62-ioddr-v2025-04-rc1-v6-11-6dd99a7271bb@baylibre.com>
 <b923eda3-46d9-4001-a976-82d7cb60d830@ti.com>
In-Reply-To: <b923eda3-46d9-4001-a976-82d7cb60d830@ti.com>
X-Mailman-Approved-At: Thu, 04 Dec 2025 21:31:27 +0100
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

--48f16a4986ac7d214aa9b174a13bc4b0adffa9bf1bdf1782ba9f03a23b44
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Mon Nov 24, 2025 at 7:18 AM CET, Manorit Chawdhry wrote:
> Hi Markus,
>
> On 11/20/2025 9:33 PM, Markus Schneider-Pargmann (TI.com) wrote:
>> These are needed in SPL to be able to resume from DDR immediately after
>> booting from IO+DDR.
>>=20
>> Tested-by: Anshul Dalal <anshuld@ti.com>
>> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
>> ---
>>   arch/arm/dts/k3-am62p5-sk-u-boot.dtsi | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>=20
>> diff --git a/arch/arm/dts/k3-am62p5-sk-u-boot.dtsi b/arch/arm/dts/k3-am6=
2p5-sk-u-boot.dtsi
>> index cf087c6e343a8af6f4bb2093bb6c3f28395a2686..8c2b198dede03fd77f16786f=
8743313a34902e46 100644
>> --- a/arch/arm/dts/k3-am62p5-sk-u-boot.dtsi
>> +++ b/arch/arm/dts/k3-am62p5-sk-u-boot.dtsi
>> @@ -11,8 +11,28 @@
>>   		stdout-path =3D "serial2:115200n8";
>>   		tick-timer =3D &main_timer0;
>>   	};
>> +
>> +	reserved-memory {
>> +		bootph-pre-ram;
>> +	};
>
> Keeping this property in parent nodes shouldn't be required with binman=
=20
> anymore [0]

Great, thank you! Will rework this.

Best
Markus

--48f16a4986ac7d214aa9b174a13bc4b0adffa9bf1bdf1782ba9f03a23b44
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaTHowRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlNo
/QD+LrL/0ljZzHv4eLMEHmtNiTO5mjcBxeXOCx0dwxSW8EUBAKB1306Hrxti7jHX
MQMz2nWohI8iv4u5KZhl1/5DHlYN
=x1R2
-----END PGP SIGNATURE-----

--48f16a4986ac7d214aa9b174a13bc4b0adffa9bf1bdf1782ba9f03a23b44--
