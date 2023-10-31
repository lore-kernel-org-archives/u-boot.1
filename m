Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4616C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 05:09:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 404BD87AC7;
	Tue, 31 Oct 2023 06:09:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N4h6cVlD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5919E87557; Tue, 31 Oct 2023 06:09:40 +0100 (CET)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 338C987ACF
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 06:09:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2c523ac38fbso77339621fa.0
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 22:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698728977; x=1699333777; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=MnsPtX3DP9JK3VCdiioF2UfDlaneKwV0VVEccAge5LI=;
 b=N4h6cVlDKj5JvkJe9ZgwQSYPJrx6RYDVhZPZ0832/k55wjpGAPEuLcH0dBBfeINKrS
 S6rOl/2FZsJtosnuiMbX7WeSaLGBP5Eb74tq1w1idCvNcGNMmG7IiPfFL274rPCIEQlY
 +YDKqfU0tUvQmZbomF6P0hakGGqrfE9X/RGrFd6EqiDrc93VOwP/T7BaDY9+8/RaZIT2
 gK421u1NErTKRw/04ntlKJQ64+DlOR0vu7fFZEcPadcUNT6zYvOMKkTSsy1FBdwmXFFh
 cfzmo6JHhPOSa02ps7IKSBurpkspCPg5befwHswEIqBTj109uH4CvUui7TF0mxc1QTx2
 24wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698728977; x=1699333777;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MnsPtX3DP9JK3VCdiioF2UfDlaneKwV0VVEccAge5LI=;
 b=j9Zktc0tWPdQARrarXjpitWRMvHseKcWFAc5FrqTRilgVvjbc6HGQaly1JdEhQaT95
 S03bAxsh50UHboFja5R82ziSNz3hiStzfWmkOYafR6UZEhtXXleL1ReIGUYG2+z/fT7h
 FnQ+PFtVF30kfL92MSyZjrY/W2e7wncxIc+81eTyBOadhDuRtAAzGI+NqyA9mZLCsrUd
 oSEGpubFVDR6I4VvM7lfPg4vXRrj6OhhGAo/I0INuMjKlooklaZqwUTntzKV+VQN8aK+
 zJiQ3BO3AHduYSVoGErm6vBimO29EB2eaVUgB2BCtTeXlpiIOAqtnykdmB2DgIPn81yL
 E8UA==
X-Gm-Message-State: AOJu0Yxvxc5TiYtxrRdgtqyeXKRUesfkUgqsSyOpLiJNV4IMki7BGpk8
 t8/eRfTOAjf2fxWhERY5jt67gJ5Nro8=
X-Google-Smtp-Source: AGHT+IG3pw8kbv4Vh/uqm7MFiT05RIL71Bo12r14LKV/r0yoPpOC4OC0nZ/MjGsH0QwuHmDFOjS+GA==
X-Received: by 2002:a2e:a48d:0:b0:2c5:6cb:2e52 with SMTP id
 h13-20020a2ea48d000000b002c506cb2e52mr8114431lji.42.1698728977166; 
 Mon, 30 Oct 2023 22:09:37 -0700 (PDT)
Received: from [127.0.0.1] ([46.211.28.155]) by smtp.gmail.com with ESMTPSA id
 d4-20020a2e96c4000000b002c503c2dc97sm76656ljj.64.2023.10.30.22.09.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Oct 2023 22:09:36 -0700 (PDT)
Date: Tue, 31 Oct 2023 07:09:35 +0200
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
CC: u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/2] power: pmic: support TI TPS65913 PMIC
User-Agent: K-9 Mail for Android
In-Reply-To: <9940bfe9-dbbc-4f35-bc5d-425f68adc5f5@samsung.com>
References: <20230715183431.5318-1-clamor95@gmail.com>
 <20230715183431.5318-2-clamor95@gmail.com>
 <CGME20231031050254epcas1p4ed27bc59086fa0854df068deb7d13101@epcas1p4.samsung.com>
 <9940bfe9-dbbc-4f35-bc5d-425f68adc5f5@samsung.com>
Message-ID: <818D9DD5-CB38-469F-A28A-676847D39AA7@gmail.com>
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



31 =D0=B6=D0=BE=D0=B2=D1=82=D0=BD=D1=8F 2023 =D1=80=2E 07:02:54 GMT+02:00,=
 Jaehoon Chung <jh80=2Echung@samsung=2Ecom> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=
=D0=B0=D0=B2(-=D0=BB=D0=B0):
>On 7/16/23 03:34, Svyatoslav Ryhel wrote:
>> Existing PALMAS PMIC driver is fully compatible with TI TPS65913
>> PMIC found in many Tegra 4 devices, like Tegra Note 7 and ASUS
>> TF701T=2E TPS65913 shares same structure of regulators like TPS659038
>> so data can be reused=2E
>>=20
>> Tested-by: Svyatoslav Ryhel <clamor95@gmail=2Ecom> # NVIDIA Tegratab
>> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail=2Ecom>
>
>Reviewed-by: Jaehoon Chung <jh80=2Echung@samsung=2Ecom>
>
>Best Regards,
>Jaehoon Chung

power: pmic: add TPS65913 support patchset is outdated already and should =
not be applied!

>> ---
>>  drivers/power/pmic/palmas=2Ec | 1 +
>>  1 file changed, 1 insertion(+)
>>=20
>> diff --git a/drivers/power/pmic/palmas=2Ec b/drivers/power/pmic/palmas=
=2Ec
>> index 6080cbff0b=2E=2Ed6eb9cb433 100644
>> --- a/drivers/power/pmic/palmas=2Ec
>> +++ b/drivers/power/pmic/palmas=2Ec
>> @@ -87,6 +87,7 @@ static struct dm_pmic_ops palmas_ops =3D {
>> =20
>>  static const struct udevice_id palmas_ids[] =3D {
>>  	{ =2Ecompatible =3D "ti,tps659038", =2Edata =3D TPS659038 },
>> +	{ =2Ecompatible =3D "ti,tps65913" , =2Edata =3D TPS659038 },
>>  	{ =2Ecompatible =3D "ti,tps65917" , =2Edata =3D TPS65917 },
>>  	{ }
>>  };
>
