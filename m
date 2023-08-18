Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C505C77B7F
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 17:02:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 746CF86E92;
	Fri, 18 Aug 2023 19:02:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j0B0DG9P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D8CA86EA4; Fri, 18 Aug 2023 19:02:36 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E1F086DC8
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 19:02:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-99bf3f59905so144738766b.3
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 10:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692378153; x=1692982953;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=54LS4gYWj7/yLEpSCWOnKDXTHCHCqIfTnJ6eLZX4p4U=;
 b=j0B0DG9PRjkMNO/2M7TAUeXzWdzWYa+dV0nu686FlxnQRlXN63HaaSM7gi6OlTHbki
 AuwDwhUtEaR1E8uMdD9JUY8Avu1XgMySJseNX9OanGYdEOhjuNlmX7Nc+1K7QMllMquO
 RedyFxWwy3SQwychdSl047z7QZYSnux9uWUnK3Kmtrc5aGxZS2cY0TPdfgX7b9wLLbo8
 Wj+ajjiGRjJzIOjXdyrecf/oIfdWkw0Ip4SwR/6vS0xv0Aic5RO0El3Bmkr6Fu2F/0dL
 xQC+4AGLB5z7TLljRMIvImOaYH0fm4cY48emNTdBOC/riIGtoOY38nJ+7Bg8jhWLY840
 INrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692378153; x=1692982953;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=54LS4gYWj7/yLEpSCWOnKDXTHCHCqIfTnJ6eLZX4p4U=;
 b=W9fvB+eWK1OGkjNbNKKRUyWqRLtkjPZ+ZUbY3vOfzcDtcuzpXruAZo3pRSMKxjaHvP
 UdT5/GNhE4DVmWjHVMOxifJ6/cUZ8sh8NHEplE9ELVFo89CeiGadz/CjW7cwAfsDyko9
 M+A+9sFz48IR6YHwGUWJfhnDWT1EWPFC1XlW4Vw5bzhG21hlqMIub1YrmeV/Y8qVlTC/
 6KNJNw75znDrOm2rQj/3zMQ/AkPxyD9YbhYatkZbSn63mcDzVP6g5XByQkLbzmFlfCy5
 a8X/148wA7QxC/29wDwzCzV2H6zaWoDOKTPUcBqA330DTS/5oOhUsac8pETbM89L56O9
 Vy3w==
X-Gm-Message-State: AOJu0Yy5z6zJixMzR10oTD43Lz/N4lgwzdr9h1gBBt08ECpay+dYiQNg
 cAGpJ8HZsXQgCBNBRjM7mrA=
X-Google-Smtp-Source: AGHT+IGEyZCnz9Da0MuiE4acrI8+etXQZ08pTTRPSw4cpjxFNdiu2RpzkZOrhU9VQ/31uLTBrFZy/w==
X-Received: by 2002:a17:907:2e0b:b0:99e:112e:7706 with SMTP id
 ig11-20020a1709072e0b00b0099e112e7706mr1962925ejc.77.1692378152539; 
 Fri, 18 Aug 2023 10:02:32 -0700 (PDT)
Received: from [127.0.0.1] ([46.211.164.36]) by smtp.gmail.com with ESMTPSA id
 j4-20020a170906254400b0099329b3ab67sm1408827ejb.71.2023.08.18.10.02.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Aug 2023 10:02:32 -0700 (PDT)
Date: Fri, 18 Aug 2023 20:02:30 +0300
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Thierry Reding <thierry.reding@gmail.com>
CC: u-boot@lists.denx.de
Subject: Re: [GIT PULL] ARM: tegra: Changes for v2023.10-rc1
User-Agent: K-9 Mail for Android
In-Reply-To: <20230818164943.GZ1515023@bill-the-cat>
References: <20230818133923.286332-1-thierry.reding@gmail.com>
 <20230818164943.GZ1515023@bill-the-cat>
Message-ID: <0C415156-B22C-4B86-94C6-1D03ED4287ED@gmail.com>
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



18 =D1=81=D0=B5=D1=80=D0=BF=D0=BD=D1=8F 2023 =D1=80=2E 19:49:43 GMT+03:00,=
 Tom Rini <trini@konsulko=2Ecom> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=B2=
(-=D0=BB=D0=B0):
>On Fri, Aug 18, 2023 at 03:39:22PM +0200, Thierry Reding wrote:
>
>> From: Thierry Reding <treding@nvidia=2Ecom>
>>=20
>> Hi Tom,
>>=20
>> The following changes since commit 68c07fc5fdf34f0926cf06fc0c4ebd6f2f3a=
fe19:
>>=20
>>   Merge https://source=2Edenx=2Ede/u-boot/custodians/u-boot-usb (2023-0=
6-21 14:42:50 -0400)
>>=20
>> are available in the Git repository at:
>>=20
>>   git@source=2Edenx=2Ede:u-boot/custodians/u-boot-tegra=2Egit tags/tegr=
a-for-2023=2E10-rc1
>
>FYI, in your =2Egit/config you can do:
>	url =3D https://source=2Edenx=2Ede/u-boot/custodians/u-boot-tegra=2Egit
>	pushurl =3D git@source=2Edenx=2Ede:u-boot/custodians/u-boot-tegra=2Egit
>
>And this part looks "nicer"=2E  Not a big deal, just an FYI=2E
>
>> for you to fetch changes up to bdf9dead86f06c7d6980c399a4a6339430b531ec=
:
>>=20
>>   board: htc: endeavoru: add One X support (2023-06-30 15:20:37 +0200)
>>=20
>> This passes CI successfully:
>>=20
>>   https://source=2Edenx=2Ede/u-boot/custodians/u-boot-tegra/-/pipelines=
/17411
>>=20
>> Thanks,
>> Thierry
>>=20
>> ----------------------------------------------------------------
>> ARM: tegra: Changes for v2023=2E10-rc1
>>=20
>> This adds support for various new Tegra30 boards (ASUS, LG and HTC) and
>> has some other minor enhancements, such as enabling the poweroff comman=
d
>> on several Tegra210 and Tegra186 boards=2E
>>=20
>> ----------------------------------------------------------------
>> Jonas Schw=C3=B6bel (1):
>>       configs: tegra-common-post: make PXE and DHCP boot targets option=
al
>>=20
>> Svyatoslav Ryhel (6):
>>       configs: tegra-common-post: add GPIO keyboard as STDIN device
>>       ARM: tegra: add SoC UID calculation function
>>       board: asus: transformer: add ASUS Transformer T30 family support
>>       board: asus: grouper: add Google Nexus 7 (2012) support
>>       board: lg: x3: add Optimus 4X HD and Optimus Vu support
>>       board: htc: endeavoru: add One X support
>>=20
>> Thierry Reding (2):
>>       ARM: tegra: Enable poweroff command on Jetson TX1 and Jetson Nano
>>       ARM: tegra: Enable poweroff command on Jetson TX2
>>=20
>> Tomasz Maciej Nowak (1):
>>       ARM: dts: trimslice: sync SPI node with Linux dts
>
>Since I'm not sure if this is v8 or v9, given when v9 was posted, I've
>applied this PR now, as I had said I wanted this in=2E  I do have two
>requests for you Svyatoslav, however=2E  First, if there's changes that
>are missing in master, please post those ASAP and we'll get them in, for
>v2023=2E10=2E=20

Patches Thierry applied are v8, while v9 has significant improvements=2E

Second, on Monday after I release -rc3 and merge that in to
>next, in the next branch we allow for (and encourage!) config fragments

I will apply fragments move in the next patchset for t20/t30 devices which=
 will be send once this pathes are applied=2E This is acceptable for you?

Best regards,
Svyatoslav R=2E

>to be in the board directory rather than top-level configs/ directory=2E
>Please make a patch on top of -next that moves the fragments and updates
>the MAINTAINERS entries=2E  Thanks all!
>
