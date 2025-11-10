Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55ABCCCF9E3
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 13:11:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCA7983956;
	Mon, 10 Nov 2025 14:11:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="i2vI5c43";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66672839DE; Mon, 10 Nov 2025 11:32:18 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54630839AD
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 11:32:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b72e43405e2so257208066b.0
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 02:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762770736; x=1763375536;
 darn=lists.denx.de; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zAs+XHWqtnYBGVPxOBejHRJ0uM4cfc5YKe4k8FTNONo=;
 b=i2vI5c43M1aA1WpfvU+EpgCAu6drQmvhSskB2VCIrek3dYTScWAxN7MHoUqzimSF2k
 ne5nMoSwmw3RqUYTAXZRiVb8IJziLcpCRVKuJrFyh+5pwj14MeANOXryIFXVmDIfwbaD
 dD2/nCYKHUpNw7ZgoYcV5Bwr4suvX13BoMeCfNn8URJ77N8Dh/hdyYriBLiDCSyHrbOw
 +E5623OKzTqTA5oWV7AeVH2KBFyE0OG7oUOQtilDDEDusxJ4zdiWhAdcpVMKlSfQyccO
 auShnc3daKEMDAWICfpSW602/PjKDozRxIcpKt92EFFfFFTjewdZGKYdVDXzbd+iTlpG
 tmpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762770736; x=1763375536;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zAs+XHWqtnYBGVPxOBejHRJ0uM4cfc5YKe4k8FTNONo=;
 b=oEthxpQ56dXcnGyeVdE45B0Sl3/z4XQBPIFlp3cI5mnKWiTfRMLSAEvke7wApbki8/
 l3+cEziVmx3gZ+Fty1fdkbiumBbNKeCTBcWzoU3Zs6NFtdTIu2FtOg9bTkzopONm43Ua
 DJkHzgQrB0XjrCqiF2o8QJds/7LNz114ReDq58Wt1B5AFIZGAyzvI53YME3C4eRS/ZTn
 C81+qzKthfyC9DuqZN/3mdpK3LNR5O4XWaC9MEyFVicnjZCa2Xgx48I9Ei2V8XL2hXIP
 5a/iBhTejRIe6ci5/yGi1mRWaXujAJZOLq0BS+SZy3negLCHONf9sO/qJrclQu6QaMUB
 MXTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZRMbjB0ANGFfm9cTtbC/BuNfZvXR/Y1mXge/3N6oWk9ry/0bato0p0jygfpvzS57av51Ik/U=@lists.denx.de
X-Gm-Message-State: AOJu0YxquUcqtDc9k8jMtoe7qWxT7fqUo1nSkM3SzsVrxnQdWtEcDyXn
 Njd+SyLnGKqWZMYiDYVZvEXm56wtoTmGkGx/v9QAGQOpl5pIOFxL48Pq1zdftvivKso=
X-Gm-Gg: ASbGncvRhB//7XYSTMB1ZlU+Uj+L8XNlyyYB3kZeMKxpJ4D45yw2swUZNgm6bb0cdOS
 FO9K1QWQ4W9mZltnZYHKWVLCP0M6ztgrj1pOLMhmyygQZA4eiMbTxwTt2ojvxNFMv0twDlokxNN
 odoqYX6e8Iy9xFEzKct0myINDx+jhuJ2IcJBkuVEEKeWtwiNymLdadIc7WNpGE+E/vfUCDAUmWk
 mmvoFf+xiSLjX7qNT8LIm8lK7us69k2/vT/qJauNHZXr2wRt6/gZnggqefessCuXKmiOWAOlT/Y
 BN0JNZS6hRmQa5NTqRzvqLEcHyXUlrb3NXel7rbVg7zT3EMp6VAMC0FTV7aEvfl3q47I3UfkUlq
 PTS2kol70pYaZYGvKSd+zOAicOSjfOXWmYrvlw6RihlBpNmq8MW+C9TC8JhMPMV7d8Jvw
X-Google-Smtp-Source: AGHT+IHdH7Ij6yPhnSIqSjb1DjnZGUWnU8HN63qsLT57WtF51eTxtE05ou3sHtAL1WW++3poC5fucQ==
X-Received: by 2002:a17:907:96a6:b0:b71:d742:5148 with SMTP id
 a640c23a62f3a-b72dff5fe26mr759994166b.31.1762770735750; 
 Mon, 10 Nov 2025 02:32:15 -0800 (PST)
Received: from localhost ([62.246.251.40]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b72bf4fbd8csm1066920166b.24.2025.11.10.02.32.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 02:32:14 -0800 (PST)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=cb1fd18759f8644ce4199243c4e7aa6dc50b650241f05cfee59a863bdb4e;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Mon, 10 Nov 2025 11:32:06 +0100
Message-Id: <DE4Y2K2WN1L3.339SXVYRJJ5D6@baylibre.com>
Cc: "Sumit Garg" <sumit.garg@kernel.org>, "Nishanth Menon" <nm@ti.com>,
 "Robert Nelson" <robertcnelson@gmail.com>, "Vignesh Raghavendra"
 <vigneshr@ti.com>, "Bryan Brattlof" <bb@ti.com>, "Vishal Mahaveer"
 <vishalm@ti.com>, "Kevin Hilman" <khilman@baylibre.com>, "Dhruva Gole"
 <d-gole@ti.com>, "Sebin Francis" <sebin.francis@ti.com>, "Kendall Willis"
 <k-willis@ti.com>, "Akashdeep Kaur" <a-kaur@ti.com>,
 <u-boot@lists.denx.de>, "Anshul Dalal" <anshuld@ti.com>, "Moteen Shah"
 <m-shah@ti.com>, "Santhosh Kumar K" <s-k6@ti.com>, "Nathan Morrisson"
 <nmorrisson@phytec.com>, "Garrett Giordano" <ggiordano@phytec.com>, "Judith
 Mendez" <jm@ti.com>, "Aparna Patra" <a-patra@ti.com>, "Jayesh Choudhary"
 <j-choudhary@ti.com>, "Chintan Vankar" <c-vankar@ti.com>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, "Neha Malcom Francis"
 <n-francis@ti.com>, "Prasanth Babu Mantena" <p-mantena@ti.com>, "Sughosh
 Ganu" <sughosh.ganu@linaro.org>, "Beleswar Padhi" <b-padhi@ti.com>,
 "Manorit Chawdhry" <m-chawdhry@ti.com>, "Andrew Davis" <afd@ti.com>, "Wadim
 Egorov" <w.egorov@phytec.de>, "Udit Kumar" <u-kumar1@ti.com>, "Andrew
 Goodbody" <andrew.goodbody@linaro.org>, "E Shattow" <e@freeshell.de>,
 "Devarsh Thakkar" <devarsht@ti.com>, "Peng Fan" <peng.fan@nxp.com>, "Jerome
 Forissier" <jerome.forissier@linaro.org>, "Sam Protsenko"
 <semen.protsenko@linaro.org>, "Marek Vasut"
 <marek.vasut+renesas@mailbox.org>, "Andre Przywara"
 <andre.przywara@arm.com>, =?utf-8?q?Th=C3=A9o_Lebrun?=
 <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v4 00/13] am62: IO+DDR resume support
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Tom Rini" <trini@konsulko.com>, "Markus Schneider-Pargmann (TI.com)"
 <msp@baylibre.com>
X-Mailer: aerc 0.21.0
References: <20251030-topic-am62-ioddr-v2025-04-rc1-v4-0-4cef18af0226@baylibre.com>
 <20251107220021.GA3498997@bill-the-cat>
In-Reply-To: <20251107220021.GA3498997@bill-the-cat>
X-Mailman-Approved-At: Mon, 10 Nov 2025 14:11:49 +0100
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

--cb1fd18759f8644ce4199243c4e7aa6dc50b650241f05cfee59a863bdb4e
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Tom,

On Fri Nov 7, 2025 at 11:00 PM CET, Tom Rini wrote:
> On Thu, Oct 30, 2025 at 10:59:18AM +0100, Markus Schneider-Pargmann (TI.c=
om) wrote:
>
>> Hi,
>>=20
>> this series introduces support to resume from IO+DDR. IO+DDR is a low
>> power mode of am62a and am62p in which nearly everything is powered off
>> except DDR which is in self-refresh and a few pins which detect
>> activity and can wakeup the system again.
>>=20
>> On resume uboot SPL is loaded and checks if this is a IO+DDR resume. If
>> it is, the DDR initialization sequence in k3-ddrss differs slightly as
>> it has to get the DDR out of the self-refresh.
>>=20
>> Afterward a specific address determined from DT is used to get the
>> metadata that stores relevant context addresses. The context is restored
>> using the tisci message TI_SCI_MSG_MIN_CONTEXT_RESTORE. At the end all
>> further initializations are skipped and uboot SPL directly jumps into
>> the DM resume address which takes care of the rest.
>>=20
>> k3-ddrss is using absolute register accesses at the moment. I am trying
>> to submit syscon DT patches upstream to access these through syscon,
>> unfortunately there is ongoing discussion regarding syscon.
>>=20
>> I tested this on am62a.
>
> Please make sure this builds without warnings (enable CONFIG_WERROR):
> +(am62px_evm_r5) arch/arm/mach-k3/common.c: In function 'lpm_resume_from_=
ddr':
> +(am62px_evm_r5) arch/arm/mach-k3/common.c:252:42: error: cast to pointer=
 from integer of different size [-Werror=3Dint-to-pointer-cast]
> +(am62px_evm_r5)   252 |         struct lpm_meta_data lpm_data =3D *(stru=
ct lpm_meta_data *)meta_data_addr;
> +(am62px_evm_r5)       |                                          ^
> +(am62px_evm_r5) arch/arm/mach-k3/common.c:263:45: error: cast to pointer=
 from integer of different size [-Werror=3Dint-to-pointer-cast]
> +(am62px_evm_r5)   263 |         image_entry =3D (image_entry_noargs_t)(u=
64 *)lpm_data.dm_jump_address;
> +(am62px_evm_r5)       |                                             ^
> +(am62px_evm_r5) cc1: all warnings being treated as errors

Sorry, I missed these warnings in my checks. (defconfig didn't enable
the code in this patch so my tools didn't pick up this warning). Fixed
the warnings and my tool.

Thank you!

Best
Markus

--cb1fd18759f8644ce4199243c4e7aa6dc50b650241f05cfee59a863bdb4e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaRG/JhsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlNE
fgEAr2niAWTDWdQBXUL/lHrvd3+ZzS4vbNibEeUVI9t35jsA/312xWanixVrXRMq
ECqaTpgh/orlljavMLTAGT9k9KcO
=M9I2
-----END PGP SIGNATURE-----

--cb1fd18759f8644ce4199243c4e7aa6dc50b650241f05cfee59a863bdb4e--
