Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9AC3C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 05:10:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45B6D87AD8;
	Tue, 31 Oct 2023 06:09:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FApypx93";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0AC587557; Tue, 31 Oct 2023 06:09:56 +0100 (CET)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A61E87ADB
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 06:09:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-507b96095abso7559881e87.3
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 22:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698728994; x=1699333794; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=vH1zTW53GiRITnqHNe8IF/mY7MgfNrEai+91D3zgZ6E=;
 b=FApypx9334qrAyYOzdoyELNawdx6WllyjZLPaBnxRMSioUmf+Jso4fBZcy9WMBSCm9
 oE4sDZ3mgtCBgNOFapBJIToHmAE0KJologmPFqjZubsHiDabXburWu0SV2iAJatELIBm
 YEm5YWhhvVIu18xhaLEzqpvrmt3RkLibdKaSdJCCd2e89rv3Y4XnscUBq0ly4oM71oLe
 xDkOSKq2QTUICRif2MZLe1pdUT6fK7D1KbX9w1fqQKAeZWgmsxiPmHFkP3GN5CiCoLhM
 inv2QXM+gYDsgwoGOhsQUe2Iw0GNah5Cynj1+YsXoKEmTcAfqLEQwxRrjiyN3IQNqye+
 U2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698728994; x=1699333794;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vH1zTW53GiRITnqHNe8IF/mY7MgfNrEai+91D3zgZ6E=;
 b=fEm8/Jr/UwUzKA2Qaeo2xRa8wrcoqrjFA67X4riEQv1zAYtyPvYBKFnMmE58wM3T03
 /Q3Wqxas0tx17LPUVF881jau1Lda97Il8EJTsBhRnJx5FQSNrqCuuvOWWoP04PezmDdY
 AYw59D9ayUTnJuMkZnyitlB7FSFeYSBlX5qEI/wuy3nJdEWLEMcVvyhLsSgPf2/VHHUc
 T2Ik9DpYNbjX/ggk8I3eLjWpcZmKgNo6uDPLbikcyeVeksYBQRzKgw/oNK2fa/z06vGc
 niIXGTtNvels8k7U11vKxL1P2CcpoJDujyCLuAt4n5nb1KbgxQCytTAOtQxghma7ZGPm
 i1xg==
X-Gm-Message-State: AOJu0Yw6ybr08aQm2mPZv/x8WwR8e6dVGgmQ1WvCGy2Dgk77/CtMERG4
 EQU6KobHliMH5HvU8XnjXQo=
X-Google-Smtp-Source: AGHT+IH1UURFH33uWEvlK4FfpV4mLqr5tu+9yNxUrQAZf4xFWmmI5t3lWq33NXR7B1A1sKsA8q55bA==
X-Received: by 2002:a05:6512:10cd:b0:507:9e56:5b1c with SMTP id
 k13-20020a05651210cd00b005079e565b1cmr11129800lfg.13.1698728993977; 
 Mon, 30 Oct 2023 22:09:53 -0700 (PDT)
Received: from [127.0.0.1] ([46.211.28.155]) by smtp.gmail.com with ESMTPSA id
 m8-20020ac24288000000b00507a1b05d2bsm81167lfh.308.2023.10.30.22.09.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Oct 2023 22:09:53 -0700 (PDT)
Date: Tue, 31 Oct 2023 07:09:52 +0200
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
CC: u-boot@lists.denx.de
Subject: Re: [PATCH v2 2/2] power: pmic: fix regulators behaviour
User-Agent: K-9 Mail for Android
In-Reply-To: <71985400-586d-4504-9091-10ee1fd55cfd@samsung.com>
References: <20230715183431.5318-1-clamor95@gmail.com>
 <20230715183431.5318-3-clamor95@gmail.com>
 <CGME20231031050317epcas1p3355c1c22bb69bd9c6679ff393711a326@epcas1p3.samsung.com>
 <71985400-586d-4504-9091-10ee1fd55cfd@samsung.com>
Message-ID: <E98981CD-7138-4C2C-B8EC-5CB05C3BEE98@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
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



31 =D0=B6=D0=BE=D0=B2=D1=82=D0=BD=D1=8F 2023 =D1=80=2E 07:03:17 GMT+02:00,=
 Jaehoon Chung <jh80=2Echung@samsung=2Ecom> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=
=D0=B0=D0=B2(-=D0=BB=D0=B0):
>On 7/16/23 03:34, Svyatoslav Ryhel wrote:
>> Currently device tree entries of regulators are completely
>> ignored and regulators are probed only if they are called
>> by the device which uses it=2E This results into two issues:
>> regulators which must run under boot-on or always-on mode
>> are ignored and not enabled; dts props like voltage are
>> not applied to the regulator so the regulator may be enabled
>> with random actual voltage, which may have unexpected
>> consequences=2E
>>=20
>> This patch changes this behavior=2E Post-probe function is
>> introduced which performs probing of each pmics child and if
>> it is a regulator, regulator_autoset function is called, which
>> handles always-on and boot-on regulators, but if none of those
>> props are set, the regulator is disabled=2E
>>=20
>> Later disabled regulators can be re-enabled by devices which
>> use them without issues=2E
>>=20
>> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail=2Ecom>
>
>Reviewed-by: Jaehoon Chung <jh80=2Echung@samsung=2Ecom>
>
>Best Regards,
>Jaehoon Chung

power: pmic: add TPS65913 support patchset is outdated already and should =
not be applied!

>> ---
>>  drivers/power/pmic/pmic-uclass=2Ec | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>>=20
>> diff --git a/drivers/power/pmic/pmic-uclass=2Ec b/drivers/power/pmic/pm=
ic-uclass=2Ec
>> index 0e2f5e1f41=2E=2E8a26b519c9 100644
>> --- a/drivers/power/pmic/pmic-uclass=2Ec
>> +++ b/drivers/power/pmic/pmic-uclass=2Ec
>> @@ -16,6 +16,7 @@
>>  #include <dm/device-internal=2Eh>
>>  #include <dm/uclass-internal=2Eh>
>>  #include <power/pmic=2Eh>
>> +#include <power/regulator=2Eh>
>>  #include <linux/ctype=2Eh>
>> =20
>>  #if CONFIG_IS_ENABLED(PMIC_CHILDREN)
>> @@ -198,9 +199,26 @@ static int pmic_pre_probe(struct udevice *dev)
>>  	return 0;
>>  }
>> =20
>> +static int pmic_post_probe(struct udevice *dev)
>> +{
>> +	struct udevice *child;
>> +	int ret;
>> +
>> +	device_foreach_child_probe(child, dev) {
>> +		if (device_get_uclass_id(child) =3D=3D UCLASS_REGULATOR) {
>> +			ret =3D regulator_autoset(child);
>> +			if (ret =3D=3D -EMEDIUMTYPE)
>> +				regulator_set_enable(child, false);
>> +		};
>> +	};
>> +
>> +	return 0;
>> +}
>> +
>>  UCLASS_DRIVER(pmic) =3D {
>>  	=2Eid		=3D UCLASS_PMIC,
>>  	=2Ename		=3D "pmic",
>>  	=2Epre_probe	=3D pmic_pre_probe,
>> +	=2Epost_probe	=3D pmic_post_probe,
>>  	=2Eper_device_auto	=3D sizeof(struct uc_pmic_priv),
>>  };
>
