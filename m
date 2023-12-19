Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F3AC41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 10:35:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BFFD86D82;
	Tue, 19 Dec 2023 11:35:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.net header.i=wahrenst@gmx.net header.b="LbjX5m5T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 449A0871B1; Tue, 19 Dec 2023 11:35:55 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB86086C68
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 11:35:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=wahrenst@gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=s31663417; t=1702982140; x=1703586940; i=wahrenst@gmx.net;
 bh=vfUcFzjbGfoM9wYXfpMVDTwZ6utL3qMaYZB2Nx35/iM=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=LbjX5m5ThIj48b+Kw89YbZ86TNpKNMA9/OBvY9QyhHhjOZ5fZeBnxEpoTOjDw2Sw
 6MyshVgn4s13WlvLqYfOyTRv4M+ZofTEHVLu2sy5zT2rky8GOqaojfYF2s/8KfAVf
 e+LRQIZd+CqaTa0zeyDnYj620wJHbeAlsPZ9X/PPPls1njRp0P8O63zn5zJ3jPHix
 q9zVITEAqClSkihvIQMecKRyybqSZtla9fmnlX3ogtsCC1gIGQygBELY9SG2PRooP
 QtfBVgcIm3EH2a8jPQ9tQ9dK6a6PlfLbIxkwdd3ANo8CGWIl9y66fdk+jwzajZpBw
 Vcvnd9XXL3i1il890A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.130] ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MysRk-1r2wTW33OE-00vt0J; Tue, 19
 Dec 2023 11:35:40 +0100
Message-ID: <6e90aa34-b6a0-4d96-82f3-01d7c95b946e@gmx.net>
Date: Tue, 19 Dec 2023 11:35:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] bcm2835: brcm,bcm2708-fb device is using r5g6b5
 format
Content-Language: en-US
To: "Ivan T. Ivanov" <iivanov@suse.de>
Cc: Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Dmitry Malkin <dmitry@bedrocksystems.com>,
 Thomas Fitzsimmons <fitzsim@fitzsim.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>,
 florian.fainelli@broadcom.com, u-boot@lists.denx.de
References: <20231218210341.30073-1-iivanov@suse.de>
 <20231218210341.30073-5-iivanov@suse.de>
 <7764be07-c3cc-47e0-a284-4ba9420a843f@gmx.net>
 <tosej62qjugymvxevjaqq6kqkkjlo3qpkbzaw4xx4ot6fk3j54@evih5bgvfdtf>
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <tosej62qjugymvxevjaqq6kqkkjlo3qpkbzaw4xx4ot6fk3j54@evih5bgvfdtf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cr0O1yoHWWmDNmn6c9Lz0CgXInGy8+Y6jebPZvlcqzHR7UlCFmU
 cg0stsJiAJ7/Gwexodf3oksuUSFw7KkeyQsfSAPFbNNadlApny5+HhUYIn3HMu7eQpKMIrp
 XJqvD3uDpjMwz72Gr+p8ystb83ntn4bm97twf1YVFcZKexPLTiIcq3i6STYtW8R2akfH6pR
 sVqA0hdSEeBD0mtsrbjyw==
UI-OutboundReport: notjunk:1;M01:P0:DCuy6vHCV4I=;zDSCKELhyo3hFo6Z3TDwWwt7eTL
 WXC3TLGrVrZrNhNMTcb2qSKmI3iDqi9A/tQSgrIOY532uQqPK7LAUg1Qm9a+eosCGEc7QpXuX
 7ojyitdlREjU63mzE0qIdpUT3RjwQjR3OGBglVZKfGPFqtNDP8+Dvj5xTVzv+P8jAyMO3sGOy
 /KOf9hAd4k86+mv6Zluvs296jWkasH54O8b/OAAbArraX8jZV5esQY37TqrNeQ5EycwKr33D8
 MyJoERw1zApWYrtNcw78ozNperwUx/B8/JTIrQbR8mervi384vt5CZ7orPAgLKmDDcogMMWQV
 BK4F8liDb3Yw+r3W3+fMw1G1AzLLoZP5p8OvmexAyNPhPVPyrW/iO2ZrKu6EPvONeHXU+ZHnE
 5XuJ/zGxgx3n9e9mRSHgY+WbbtsHUUamwzDHKzAvfVGmlZCMsZ+k8oDPqzs64LIhp4t03MhcB
 cyrBysaQ2Y0Y0jX/JcfTkNENvM37185sR5KtJQyZhZ8ykqvYeSipqTQ38g1WERvBnQj3UyO3F
 twh9Nhae9V2eSHdI797HBvTdlG+mhHxv+5k740aNkZps3tKvXCSeKEcUz2MOPy2B6w6Da6C3J
 UMUcwSO4BhWzRXf5G9IGSGYbS8M1HbQf/zVCWPslZe3MR32PSGXBXrW5hsdEEDgUjf0K52Una
 EsXc/CgFnD37c+aV8z/ZqLFKuWRHEwl2knza4vvfizRkpwT4NRMxE2C1hD22Ho3jCY0iTEZoh
 zgX542HkpYdvdgNfVd3AmzobyzbSZ/cEUJ/b0cy+/yrCf7Dbqs0Vl5ZXNtjZWo5WBwkSGk6Co
 bVcCmUx5Fw/lfFLz4uHMXpv5fuLmLpME40UP3PIzSpmDdQ7DHdsyKIYqjLTKtEB1zaBOIxi5q
 oDarYAa+DeBCx22DYb7CVjS3Z5lTtc3T3nZutPQ7ZFXLs/KDTggJo6vytHwW0NGUjEm9hfOga
 nF/OC4Ngep6c5ZFe/tfSSG/cbUc=
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

Hi Ivan,

Am 19.12.23 um 09:51 schrieb Ivan T. Ivanov:
> On 12-18 23:32, Stefan Wahren wrote:
>>>    static const struct udevice_id bcm2835_video_ids[] =3D {
>>> -	{ .compatible =3D "brcm,bcm2835-hdmi" },
>>> -	{ .compatible =3D "brcm,bcm2711-hdmi0" },
>>> -	{ .compatible =3D "brcm,bcm2708-fb" },
>>> +	{ .compatible =3D "brcm,bcm2835-hdmi",  .data =3D VIDEO_BPP32},
>>> +	{ .compatible =3D "brcm,bcm2711-hdmi0", .data =3D VIDEO_BPP32},
>>> +	{ .compatible =3D "brcm,bcm2708-fb",    .data =3D VIDEO_BPP16 },
>> this change looks wrong to me. Before we used VIDEO_BPP32 for
>> brcm,bcm2708-fb. I think it's hard to explain why we should downgrade
>> the other boards. I would expect some brcm,bcm2712 compatible at least
>> this needs an explanation in the commit message.
>>
> If you are confident that this semi device was working before with
> BPP32 I will try to find better way to handle this. Do you remember
> which RPi version was this?
as said before i'm don't have much experience with U-Boot, so i'm not
confident. But downgrading the bpp value for an existing setting only to
make RPi 5 work, isn't a good approach. It's a hack.

A quick search for the compatible revealed this [1], so it looks like a
fallback which applies to all Raspberry Pi boards with a firmware
provided DTB.

In case all of them uses 16 bit, i'm fine with this change but then the
commit log should mention this. I think these are points which needs to
be discussed with the Raspberry Pi guys.

Best regards

[1] - https://lists.denx.de/pipermail/u-boot/2018-July/333476.html
>
> Thanks,
> Ivan
>

