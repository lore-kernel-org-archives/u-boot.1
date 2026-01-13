Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A071D30CC1
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 20:26:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9980980077;
	Tue, 13 Jan 2026 21:26:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=public-files.de header.i=frank-w@public-files.de header.b="deiylC/e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9953980081; Tue, 13 Jan 2026 21:26:30 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DD268004F
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 21:26:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=public-files.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frank-w@public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
 s=s31663417; t=1768335988; x=1768940788; i=frank-w@public-files.de;
 bh=p36Twz86Nv6Qc8gfX+u2cGPbnBn4/o+vzf50yjKizFE=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Reply-To:Subject:
 To:References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=deiylC/eJPofYG+3OsCqJFVxXCyeGrnBalODTYlYr57tf8Jn6VpyVemUJ216hbMN
 QN5SOm4PxTlNUJZPUK6DmJtZWYtweSaG/x7ZmyPmMFEWTkkLOJ8LhaTJZ5VS0mxsz
 2Pra7JfJ9oEQcw72jQDhSxCu++tz78+7AqlzLMlW9urifz4+Re5tJjzlJ1AxdlUxu
 PkUXtdIK8JGg05drNRUsFLykmhdcMnbQPrVUfMidBceEfoTF7rfc72WMN8do+zSop
 /dbQrwVW4WxZm17tf76LWZsCQSSJW02pU+z0SLBp5oi2dMQQdwXHBDqfahSBRmZdc
 EFv0LGoZAdoz68hpoA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.21] ([194.15.84.12]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MK3Rs-1vOlmn3bJu-00NOTT; Tue, 13
 Jan 2026 21:26:27 +0100
Message-ID: <ac14ca5b-093e-4a67-b2cb-eeba3b1f8ddd@public-files.de>
Date: Tue, 13 Jan 2026 21:26:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: u-boot.dtsi also possible for dtso?
To: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
References: <trinity-3f748198-84ca-4da1-a48d-3f6e1c1818af-1767437709081@trinity-msg-rest-gmx-gmx-live-5bb597646f-r2jdb>
 <9095dbbf-b039-4fe5-8157-736e46ac0f04@cherry.de>
Content-Language: en-US
From: Frank Wunderlich <frank-w@public-files.de>
In-Reply-To: <9095dbbf-b039-4fe5-8157-736e46ac0f04@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3y04lQ+2SgZLot0A/5lk7irY+f2TQjUTkSPVUgatEzVPi608VMz
 Jsnc7glW8Z/aAnwNWLAtAUZ+zb1ZLKbPh0/7FXn7Z9J8wFJjjgRKFgVhtx8oVNgsLENuj3P
 Iu8voB5eaWF118JFKtS76fA4B4lsXWrLDVvcQe7otByGqWIVrxUSgp1bOnRooLygrYAntaQ
 TEYRuZLPdx9HFTVHX8Ywg==
UI-OutboundReport: notjunk:1;M01:P0:HVjmqWg3yIw=;l4eFQl/cfKY2kjWOPynJ99f5+B2
 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
 c7ouToGC9D/+CJ0V8VrQtl/sFXWo3ilrKJNNvB
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
Reply-To: frank-w@public-files.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi

Am 13.01.26 um 17:41 schrieb Quentin Schulz:
> Hi Frank,
>
> On 1/3/26 11:55 AM, Frank Wunderlich wrote:
>> Hi,
>>
>> i make new attempt to change mediatek boards to OF_UPSTREAM because i=
=20
>> found out, that dtbo merging is now possible.
>>
>> but i faced a problem:
>>
>> e.g. BPI-R3 has 2 SPI-devices (nand,nor) on same spi switchable via=20
>> hw. i need both in dts to probe the right
>> device for linux and to allow install from sdmmc to both of these=20
>> devices based on hw switch.
>>
>> currently in uboot the nor is device 0 (unit-address and reg) and=20
>> nand is 1. this does not work in linux, so i need a
>> way to overwrite the dtso from linux with the new values in uboot.
>>
>> for dts there is a way using -u-boot.dtsi files...do they also work=20
>> for dtso? where do they need to be placed?
>>
>
> I don't understand the issue. Is there code we can look at?=20
the issue is that in linux there is only one device at address 0 (1 does=
=20
not work).
in uboot i can and have to add both devices with different=20
unit-address/reg property to check which one is available.

this is the current used file:
https://github.com/frank-w/u-boot/blob/2026-01-bpi-ofupstream/arch/arm/dts=
/mt7986a-bpi-r3-sd.dts#L196

and i want to move to OF_UPSTREAM to use linux dts synced in uboot.

https://github.com/frank-w/u-boot/commits/2026-01-bpi-ofupstream/

currently i put both nodes manually in the board u-boot.dtsi

https://github.com/frank-w/u-boot/blob/2026-01-bpi-ofupstream/arch/arm/dts=
/mt7986a-bananapi-bpi-r3-u-boot.dtsi#L67

but it would be better to merge the linux oberlays

https://github.com/frank-w/u-boot/blob/2026-01-bpi-ofupstream/dts/upstream=
/src/arm64/mediatek/mt7986a-bananapi-bpi-r3-nand.dtso
and
https://github.com/frank-w/u-boot/blob/2026-01-bpi-ofupstream/dts/upstream=
/src/arm64/mediatek/mt7986a-bananapi-bpi-r3-nor.dtso

but they cannot have both reg=3D0 in uboot...then no device will be=20
detected. that's why i want to change one to reg=3D1 (and unit-address to=
=20
1). to have same result as i did in the override file.

regards Frank
> Are you planning on using the exact same DT binary in U-Boot and Linux=
=20
> kernel? Why does it matter to Linux that the NOR in U-Boot is device 0?=
=20
not the binary, but source dts to have devicetrees defined only once. It=
=20
was mentioned a requirement for adding new nodes in uboot.

in linux only one overlay will be applied and both need to be 0 as=20
defined in linux. but in uboot i need both nodes and they must not be=20
same reg/unit-address.
> Cheers,
> Quentin

