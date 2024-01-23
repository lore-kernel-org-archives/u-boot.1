Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FDB4C47258
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 12:09:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DDB0879A8;
	Tue, 23 Jan 2024 13:09:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.net header.i=wahrenst@gmx.net header.b="tlDJpbjN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF2D5879F0; Tue, 23 Jan 2024 13:09:54 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15D03876EF
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 13:09:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=wahrenst@gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=s31663417; t=1706011791; x=1706616591; i=wahrenst@gmx.net;
 bh=LEbuZ/g9vZ3F0LHNR6CGz2M3yO+bMCjpKHF9OhZoCIo=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=tlDJpbjNQqkkp1O/qFRAW8/bHvvKp7YSGcEvieJ++e2zm0jvg0horWnp6k9zOiQ4
 g6YVDAWMiVmgErSeC1mAIr7nL8EnQrvN2OyHl09E7ZKk9Q8m80HOy1JNb+65EiGGw
 2llkLArd5bVN1RSfhYCU7rE3CrgYW7/x7XST7MZKgs2q3WMzuYcTnkQBoxCDMWMvL
 u7tBIKaEbvyDbLuSB3SqsOIFlf3yEm/PHhlrhqH/J2qu8B1TfCTqKk11ZBl1Y7p/h
 KbeWhFWEzDlO3hI2WTfMTfDbW1SWQJdwv6pvQIezwYM/t7aTxshs11aIKZsSQ+BM5
 PHFcl9kb2yZdsd0efQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.167] ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mj8mV-1qvxBi2lvR-00f7Oq; Tue, 23
 Jan 2024 13:09:51 +0100
Message-ID: <5ba843cd-eae7-46a2-88a5-d704556bf91b@gmx.net>
Date: Tue, 23 Jan 2024 13:09:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/6] rpi5: initial support
Content-Language: en-US
To: Jens Maus <mail@jens-maus.de>, "Ivan T. Ivanov" <iivanov@suse.de>
Cc: u-boot@lists.denx.de
References: <25AB43C7-829F-4F62-AC8E-3284B22ACB03@jens-maus.de>
 <E7BFDAEE-00A9-463A-AF73-75101AFF2BC6@suse.de>
 <FB66DFF3-03B0-4DA5-8916-AB80CA6C6EB5@jens-maus.de>
 <dvpwizpui6a52dfmy57ghv4zmplvgqvow6oec7x5opwzh63zzl@jehyglofr6yh>
 <489FBAE5-501A-49F6-894D-58BE5C5429CC@jens-maus.de>
 <A0746263-646C-40C6-A2A6-659C39385E8B@jens-maus.de>
 <246035ba-0090-4cc3-982e-1de837ec7340@gmx.net>
 <6E2D7E91-E869-48C6-8CE8-0B410A2B67B9@jens-maus.de>
 <ebffa598-6945-4a03-abe4-fe519df5fbfd@gmx.net>
 <223DA3F8-B17B-44CF-B247-12DEBD100A75@suse.de>
 <uwh4skanpw4c42t5iefqiawfns2wglxl4rizmaexeaetyvahf3@yibnd3owvcn2>
 <36C77701-6838-4ACC-B6B0-62286CD0F7D1@jens-maus.de>
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <36C77701-6838-4ACC-B6B0-62286CD0F7D1@jens-maus.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eigoHYqNLtH8NUavKXUHMxxOUqKmhKhaf/I6O3rreTiH4Ial8HR
 R+gvpy2ozws01KtQ+bHjuj5DeW5U9agYiFxztd/0MghvxZ+jHL/Y98jZQFgOifhM1ffywtA
 IBfBqHvNuK5Oy3sulnz9Ibp7CIvldJ0Vp5RZ3qnGi9Hnb1KgE9EVqH6MPvZG47bJvb67nyW
 Ls1dIxKzpRA65FiS5QDPQ==
UI-OutboundReport: notjunk:1;M01:P0:dSBjhe+P5b4=;ddKenCRwXf4wTI90DN2jEVadrgn
 fdKtroSV4pebVEXM0ouOgVUfSewdcYiOSkaoFw+vVDZvBbuNw+rwTV+4Ng/5OJ5/yC25EnKaG
 fZzX3p3Lj7VMR8yK/XnMxtTcl8WJyoHeiFIu5e9amD4cqLoFTKkdVmGHplrUaGJ1cZopEZqkf
 qtHqI6xUGfr0A8EJ5DgEl1o9NuE1gaFlRdtFow34aGky7HcAdUYOp1R7DQ0JLqT6kzPPyn+43
 3YqvjRt713bSnKersob/llobEVoeh0goW0IRzTg/V3vYA5Scdj82ZiIVBRaQDxKDzpyEUUhKy
 UQhvpxUuFma2DI4c8wiI6/zKNRk8ZKSlHSQEQGdAnIiEBEAlcXj6mMYk8zPxnT0SaJwvfUKqO
 LZocFSNMFmIt8Zgx9yTQ/Kvu/StjmVHyKwjQXoj5i97HDSn0WnmY+nDBmC0q4VysWtdkCVXp9
 s8/VUkp2UBD4t+DXmTV12j2SFrUq/QqIkG4Ri8IrDAHvCDCULWDhFud0k246vkWWquvL0Cw1k
 Ln3YTraNSUlN5L2y4yPsA+T8ENNAQ6BwxaxThDaBrqiG9NuK4QbkQH8LXtX9NftbH3ZcJCgk7
 427JuOx4reoaWN3W6CW/i8omvly8ZBqA7t6Fs4ulK1rwAjv8oIkfmbpNtBenVeToQ+50wcaAA
 YMiiST+chUQ3xRG4VKU/8AdShma+AlUnjblKzOCo0c8yEosEt8RLxPgQ6JwsXcjkIlrKGYWMJ
 1ZvaubVReqagg//QHK+2fa4ZBOkGn/2fTgtvG/azjdBQhwmwPf0Cywr7d6s4DKaSLo96PQ+ZD
 PIpvjjMoe4HSqvmQYB3QNLfBuvr4eybWmuj5ot0M7rhPmmFvIZnPq9SzJhQJa4uvv+thQcVMC
 SP0p4JH7xhGhIskBoV9erV7EDOXdGxcbeCvaD+fPb9/snPfD/yPHGEogPE3cl9HMAh8fTDDNP
 cWDjsQ==
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

Hi Jens,

Am 23.01.24 um 12:11 schrieb Jens Maus:
> Hi,
>
>> Am 22.01.2024 um 15:16 schrieb Ivan T. Ivanov <iivanov@suse.de>:
>>
>> On 01-22 13:57, Ivan T. Ivanov wrote:
>>> I was able to enable early debug UART in U-Boot and I will try to
>>> find what is happening, once I get some free cycles.
>> Ok, this was relatively easy to find :-)
>>
>> New versions of EEPROM firmware change =E2=80=9Ckernel=E2=80=9D/U-Boot =
load address
>> from 0x80000 to 0x200000. And because on RPi=E2=80=99s CONFIG_TEXT_BASE=
 is
>> hardcoded to 0x80000 code run through the fields.
>>
>> Hopefully simple patch like bellow make it work fine in older and
>> newer EEPROM firmware versions.
> Thanks for this tiny but important fix on your patchset. In fact, I was =
able to verify that now with your latest v5 patchset for the initial rpi5 =
support even newer/latest rpi-eeprom versions work as expected and u-boot =
is chain loaded by the rpi boot loader.
thank you for testing. Could you please give your Tested-by to v5 or at
least parts of them?
>
> So thanks again for that fix and I am looking forward to seeing your pat=
chset integrated and hopefully also maintained in future so that USB boot =
and GPIO support will be added in the near future.
>
> regards,
> jens

