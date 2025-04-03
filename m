Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E669C36014
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 19:18:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBF6782139;
	Thu,  3 Apr 2025 21:18:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kohlschutter.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kohlschuetter-com.20230601.gappssmtp.com header.i=@kohlschuetter-com.20230601.gappssmtp.com header.b="L20lq5XR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64E0C82140; Thu,  3 Apr 2025 21:18:45 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECC6082006
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 21:18:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=kohlschutter.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christian@kohlschuetter.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5e677f59438so2016119a12.2
 for <u-boot@lists.denx.de>; Thu, 03 Apr 2025 12:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kohlschuetter-com.20230601.gappssmtp.com; s=20230601; t=1743707922;
 x=1744312722; darn=lists.denx.de; 
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6anDPCar9BOFCM9NMsaQl1j+l+LwxfZeK+q9Uilx3c8=;
 b=L20lq5XR605ERxC0MqkIVTko2KeW2a/VKEmAKlSat2JIgmK1dDZir/lZneLvm7XyHt
 4uBANbcaGr3XzdD8qlCKLgMrZDdHxE2Plu+IWhj7f6jqm9rnoyRieVxSDWadxnOjWGtV
 2VUKImOaoQ62HIUjBhUNwpET2BeIp3VY+UiYB/NMZfEKrM8lyI1ew4aVkgHqRGpY89mR
 gnoSA26mEWXHfGz/52RL/QqQfqrgoP9r7hchjTW6T4ecLiJwfK1M1Q+wAs+uIM6wNaM/
 xyHO2hRBReM4L0C3XHMS/qkoGYSuqQIVorYTiBwg2vn9XCARXPmc/mzRkezShRHlASfD
 ygOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743707922; x=1744312722;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6anDPCar9BOFCM9NMsaQl1j+l+LwxfZeK+q9Uilx3c8=;
 b=uPGL3hVGY932G2K6ySOFs6++nmTcJ2lOVlUdzsZiV75Zzvd2mibLBmUHGXy1EhFcJB
 o4PFtlAMOnwSQ7bMpUNpjZdFW8f+vwyZth+AApllg6+25ijJvEBjeurZcJGyVYLgw/kT
 dAk48xnMmbZdam55z85E3bn8PosItHXRKJOqYSarPqQIcG1mg3D9YbeCI4o7fpejgCWi
 WL7TtstifILltb77dcWwFY7H2RaCZN3u26J9TEhtvLbNhDKoulvNBAC+1SfWuFlUpSkc
 xvkXWWP0gwMofwuarBEDyD8ZURE0pHArveK/F01nsAYfu+EWBj3qqk8BEsJ7GeoJ5Ye/
 B7XA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXflPCkI+qwOtgu4JULrx1w3bX2tyydYdx+PTuvXQYqguRtAiZHyM6IJhbs9BXZEaTEr6q6HXM=@lists.denx.de
X-Gm-Message-State: AOJu0YzHIiSkag7tkJurM7W7Vw2pFvvwso3deWgABObFbfTBPDEwWnnJ
 2Gy3Zs9ZwQazqpluY6il0zmwHVN7H0f3Hs2hhrsDA+JIZLyDHXf4Rtt/toHG9DouCaKV2x6D9J+
 jCBk=
X-Gm-Gg: ASbGncvXFFIQRw2ELTdgddB0mDka+NMIxMZ2YKongyzqG++ruAh7xhxs+oPQMSiGJYa
 Ct5kNprMpiMGID/0CVGFWowZk+3VUqQAT5gKYPMJSbOilWo6jGsmrOvX+sNCkyI0V/lRWPMU9FV
 pPzdtFygakO9RvdjND4qLFyjkJrsfFieZxyibVAwBeTUDy+vvSfjfSkYT5kq06W33b9ZHSn8qpv
 nAK192grIfBZIePPVHfGlEFu+9xx1s89rBs1bXSkafWpjCgsM27Rz0wu63x1RUyu/TzpdFwzkej
 GQXIxmkh+KTXQsrQTMbhbf8m0cNcvKUNrbpdLqXt8c+7sXbmUxhA0K19y9aM7xYVsAoK
X-Google-Smtp-Source: AGHT+IEU8OKI+0VPnnx9WcicRMeL5/4Crwc096cmPnQQWryTDvJj2L67RbgVB68uHWJxvTPK1jNAxw==
X-Received: by 2002:a05:6402:2755:b0:5d0:8197:7ab3 with SMTP id
 4fb4d7f45d1cf-5f0b3b5a9a2mr313532a12.3.1743707922207; 
 Thu, 03 Apr 2025 12:18:42 -0700 (PDT)
Received: from smtpclient.apple ([91.64.76.218])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f088084e3dsm1272813a12.55.2025.04.03.12.18.41
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 03 Apr 2025 12:18:41 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: =?utf-8?Q?Re=3A_U-Boot_interferes_with_initrd_binary_=E2=80=94_Re?=
 =?utf-8?Q?vert_=22efi=3A_Correct_smbios-table_installation=22_=3F?=
From: =?utf-8?Q?Christian_Kohlsch=C3=BCtter?= <christian@kohlschutter.com>
In-Reply-To: <CAFLszTibROtKsE+LZ3cMXvj5MLBf=-6TP98UwxhPfh5eqQK+_g@mail.gmail.com>
Date: Thu, 3 Apr 2025 21:18:41 +0200
Cc: Michael Brown <mcb30@ipxe.org>,
 u-boot@lists.denx.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <68D651AB-8E9E-48B4-A062-9E688025F035@kohlschutter.com>
References: <C101B675-EEE6-44CB-8A44-83F72182FBD6@kohlschutter.com>
 <01020195ed33a587-cffad5a3-32c9-46b0-99ad-d2ba8f7813d1-000000@eu-west-1.amazonses.com>
 <F1B968E3-823A-4F6B-B39C-80AAE2961E9B@kohlschutter.com>
 <01020195f0df59d3-851c6ec3-9a49-4fab-b878-e11c6018b827-000000@eu-west-1.amazonses.com>
 <CAFLszTiRu3JtUw-z3LeHO9PKVZRuBW3L-WXm5vO0u6++-OdwAw@mail.gmail.com>
 <AED05ACC-AF9D-4A2E-90E3-7BDA597B2DB0@kohlschutter.com>
 <CAFLszTibROtKsE+LZ3cMXvj5MLBf=-6TP98UwxhPfh5eqQK+_g@mail.gmail.com>
To: Simon Glass <sjg@chromium.org>,
 trini@konsulko.com
X-Mailer: Apple Mail (2.3826.500.181.1.5)
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

+Tom Rini (actually adding Tom to the conversation)

> On 3. Apr 2025, at 19:54, Simon Glass <sjg@chromium.org> wrote:
>=20
> +Tom Rini in case this affects the release
>=20
> Hi Christian,
>=20
> On Fri, 4 Apr 2025 at 01:46, Christian Kohlsch=C3=BCtter
> <christian@kohlschutter.com> wrote:
>>=20
>> Hi Simon,
>>=20
>>> On 1. Apr 2025, at 17:51, Simon Glass <sjg@chromium.org> wrote:
>>>>=20
>>>> but I don't know precisely what these various functions are =
supposed to
>>>> do, and I can't find any path that leads from any of these to =
eth_halt().
>>>>=20
>>>> Is it possible that U-Boot is failing to call eth_halt() in =
response to
>>>> ExitBootServices(), and is therefore leaving the network device =
active
>>>> and performing DMA while the kernel starts up?
>>>=20
>>> The dm_remove_devices_active() is supposed to handle this, but it is
>>> possible that one of the drivers lacks a remove() method.
>>=20
>> for what it's worth, this is happening on both ODROID N2+ =
(meson8b-dwmac) as well as NanoPI R4S (rk_gmac-dwmac).
>>=20
>> I also don't understand why reverting =
06ef8089f876b6dabf56caba31a05c003f03c629 "fixes" this behavior. Does it =
mean that any memalign / malloc may cause this?
>> Also, how can this failure mode be detected and prevented in code?
>>=20
>> I really don't fancy the thought of remote code injection into Linux =
initrd by spoofing Ethernet packages, but it really looks like a =
possibility.
>=20
> Here's my idea of what might be going on based on Michael's =
observations:
>=20
> 1. designware_eth_start() starts the interface and
> designware_eth_stop() stops it
>=20
> 2. tx_descs_init() sets up the DMA and uses the device-private info
> (struct dw_eth_dev)
>=20
> 3. When the device is removed, the struct is freed, meaning that a
> future malloc() can use that same space.

Yes, that sounds plausible. How can such allocations be prevented?

I assume U-Boot's malloc does not know anything about iPXE's or Linux's =
allocation, and vice versa?

>=20
> 4. DMA traffic could then write over the malloc() region
>=20
> I'm not seeing where the Ethernet device's stop() is called. The
> dwmac_meson8b driver does not have a remove() method, so presumably
> DMA is still running after the device is removed. Probably the correct
> fix would be to add a remove() method to that driver.

Right. Of course this means that there's still a chance that some future =
driver would again fail to do this.
How can we prevent this? Can some removal hook be added automatically =
upon registration?

>=20
> Regards,
> Simon

Thanks for looking into this!
Christian

