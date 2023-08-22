Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE31FEE49A3
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 05:16:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03C5A862B6;
	Tue, 22 Aug 2023 07:16:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gSlJi07F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0530D871BC; Tue, 22 Aug 2023 07:16:35 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEED08522C
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 07:16:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-4ff09632194so5659437e87.2
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 22:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692681391; x=1693286191;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=mA+2o0zhzpMSYYxBNU+WJuvV5oW5AmhLkmE+F8g8v0k=;
 b=gSlJi07Fyw9+n76LNWbxzkw1YTIt+HLLplvi98BcseR2HFBO4EvnvUBDhk8NjjfTC4
 YdBo1t/kMpt6ZW2oDXQ5P8yw28yQZYtke+DEtYADmPbVj3A67o4b0GsLz4d92IqgoPkJ
 2GX/IBSxsBAT1ku2GBtPG2h4V7a0VgSqQmQJfi6rQLji3shwlwNJNC2RHCEKZxUCIeJz
 zvI60vL5im6hgruHneX7I+b1fp3qs6GjoM8zLTZC8QCj+UU3m9qxQLuGVXxqI8jMjKNm
 4Mvqoi4aZvv5iMfqc6yZiG8ZSosQt0yvnPXjS3qziyN9I1auBjrM2IupWNKPSQLXvKFv
 YqyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692681391; x=1693286191;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mA+2o0zhzpMSYYxBNU+WJuvV5oW5AmhLkmE+F8g8v0k=;
 b=BmWq1+nPuzotXpRFNp2AmaR0V69+IP+St5jTVh7ja9oJaXZfVYYLMODDrEKb5pfbyl
 ve2OX5W6GTMCuxnibwzTO8UwjwRSqXR9Zb9TMrZCaBcuvyPXsGVul5LXYc34YJCXGd75
 DSSfIAjunNeSK8/e8/vOnBJWV7T6jwIctS4y7Wzp/4HjuSWOriApePZq614Z2DSt8s/z
 W49pMzbzJ/yQUAJ3DcBAqi3s/AMWtPl6DFWoQGn4o2jWcC8wMyNvuxz4l1XO9p+qM72+
 tGAneOXnc3TaMuVO7NzzJMxm+9fl/nul4JLl72w46n1yKbfk3cHwwCNENEVaN4xF0y8a
 8Liw==
X-Gm-Message-State: AOJu0YxcrwMICT326qDuitg97nGGTP7/jPVXY7/YE3XDLE3s3gOM+0eW
 ydWZpKLA36Prm4dAhp8D7G8=
X-Google-Smtp-Source: AGHT+IGheF7QdR4aDRAIcJsUP4T0hijSWxgkAJ7WK1dw7KzV9PSEdUqOSHZ8jZg02lzptBbYqRMZKA==
X-Received: by 2002:a19:4f0d:0:b0:500:7c2a:30da with SMTP id
 d13-20020a194f0d000000b005007c2a30damr3303388lfb.60.1692681390794; 
 Mon, 21 Aug 2023 22:16:30 -0700 (PDT)
Received: from [127.0.0.1] ([46.211.153.74]) by smtp.gmail.com with ESMTPSA id
 p6-20020aa7d306000000b0052574ef0da1sm6917548edq.28.2023.08.21.22.16.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Aug 2023 22:16:30 -0700 (PDT)
Date: Tue, 22 Aug 2023 08:16:29 +0300
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>
CC: Thierry Reding <thierry.reding@gmail.com>, u-boot@lists.denx.de
Subject: Re: [GIT PULL] ARM: tegra: Changes for v2023.10-rc1
User-Agent: K-9 Mail for Android
In-Reply-To: <20230818170447.GA1515023@bill-the-cat>
References: <20230818133923.286332-1-thierry.reding@gmail.com>
 <20230818164943.GZ1515023@bill-the-cat>
 <0C415156-B22C-4B86-94C6-1D03ED4287ED@gmail.com>
 <20230818170447.GA1515023@bill-the-cat>
Message-ID: <5DFCCFFB-D137-4530-8AF9-C72071842A60@gmail.com>
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



18 =D1=81=D0=B5=D1=80=D0=BF=D0=BD=D1=8F 2023 =D1=80=2E 20:04:47 GMT+03:00,=
 Tom Rini <trini@konsulko=2Ecom> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=B2=
(-=D0=BB=D0=B0):
>On Fri, Aug 18, 2023 at 08:02:30PM +0300, Svyatoslav Ryhel wrote:
>>=20
>>=20
>> 18 =D1=81=D0=B5=D1=80=D0=BF=D0=BD=D1=8F 2023 =D1=80=2E 19:49:43 GMT+03:=
00, Tom Rini <trini@konsulko=2Ecom> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=
=B2(-=D0=BB=D0=B0):
>> >On Fri, Aug 18, 2023 at 03:39:22PM +0200, Thierry Reding wrote:
>> >
>> >> From: Thierry Reding <treding@nvidia=2Ecom>
>> >>=20
>> >> Hi Tom,
>> >>=20
>> >> The following changes since commit 68c07fc5fdf34f0926cf06fc0c4ebd6f2=
f3afe19:
>> >>=20
>> >>   Merge https://source=2Edenx=2Ede/u-boot/custodians/u-boot-usb (202=
3-06-21 14:42:50 -0400)
>> >>=20
>> >> are available in the Git repository at:
>> >>=20
>> >>   git@source=2Edenx=2Ede:u-boot/custodians/u-boot-tegra=2Egit tags/t=
egra-for-2023=2E10-rc1
>> >
>> >FYI, in your =2Egit/config you can do:
>> >	url =3D https://source=2Edenx=2Ede/u-boot/custodians/u-boot-tegra=2Eg=
it
>> >	pushurl =3D git@source=2Edenx=2Ede:u-boot/custodians/u-boot-tegra=2Eg=
it
>> >
>> >And this part looks "nicer"=2E  Not a big deal, just an FYI=2E
>> >
>> >> for you to fetch changes up to bdf9dead86f06c7d6980c399a4a6339430b53=
1ec:
>> >>=20
>> >>   board: htc: endeavoru: add One X support (2023-06-30 15:20:37 +020=
0)
>> >>=20
>> >> This passes CI successfully:
>> >>=20
>> >>   https://source=2Edenx=2Ede/u-boot/custodians/u-boot-tegra/-/pipeli=
nes/17411
>> >>=20
>> >> Thanks,
>> >> Thierry
>> >>=20
>> >> ----------------------------------------------------------------
>> >> ARM: tegra: Changes for v2023=2E10-rc1
>> >>=20
>> >> This adds support for various new Tegra30 boards (ASUS, LG and HTC) =
and
>> >> has some other minor enhancements, such as enabling the poweroff com=
mand
>> >> on several Tegra210 and Tegra186 boards=2E
>> >>=20
>> >> ----------------------------------------------------------------
>> >> Jonas Schw=C3=B6bel (1):
>> >>       configs: tegra-common-post: make PXE and DHCP boot targets opt=
ional
>> >>=20
>> >> Svyatoslav Ryhel (6):
>> >>       configs: tegra-common-post: add GPIO keyboard as STDIN device
>> >>       ARM: tegra: add SoC UID calculation function
>> >>       board: asus: transformer: add ASUS Transformer T30 family supp=
ort
>> >>       board: asus: grouper: add Google Nexus 7 (2012) support
>> >>       board: lg: x3: add Optimus 4X HD and Optimus Vu support
>> >>       board: htc: endeavoru: add One X support
>> >>=20
>> >> Thierry Reding (2):
>> >>       ARM: tegra: Enable poweroff command on Jetson TX1 and Jetson N=
ano
>> >>       ARM: tegra: Enable poweroff command on Jetson TX2
>> >>=20
>> >> Tomasz Maciej Nowak (1):
>> >>       ARM: dts: trimslice: sync SPI node with Linux dts
>> >
>> >Since I'm not sure if this is v8 or v9, given when v9 was posted, I've
>> >applied this PR now, as I had said I wanted this in=2E  I do have two
>> >requests for you Svyatoslav, however=2E  First, if there's changes tha=
t
>> >are missing in master, please post those ASAP and we'll get them in, f=
or
>> >v2023=2E10=2E=20
>>=20
>> Patches Thierry applied are v8, while v9 has significant improvements=
=2E
>
>OK, I've updated patchwork to try and reflect this too=2E
>

Merged patches are not the most recent I have sent=2E How to fix this?

>> Second, on Monday after I release -rc3 and merge that in to
>> >next, in the next branch we allow for (and encourage!) config fragment=
s
>>=20
>> I will apply fragments move in the next patchset for t20/t30 devices
>> which will be send once this pathes are applied=2E This is acceptable
>> for you?
>
>Yes, I think this will be fine, thanks!
>
