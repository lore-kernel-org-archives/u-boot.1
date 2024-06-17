Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB33C27C6E
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 09:24:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E880287E52;
	Mon, 17 Jun 2024 11:24:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="qlTPfT7X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68B4987E52; Mon, 17 Jun 2024 11:24:41 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B19C88263
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 11:24:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1718616275; x=1719221075; i=xypron.glpk@gmx.de;
 bh=EaGz3/9L5auT4L03CZr8w8Inphc28PQb7BmUGWGaKOw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=qlTPfT7X7gYqExfZCftdOm1srkQI5NXB5vYS4vycxzSPjEB9ynUtq7KeEh07bpE1
 oTWgyT9OHaiDqxBVbfQtTUSbUqtFVWXKy9oGE7LK6s7DtJrAiOpJ9Juf3hsjytjOH
 Pyd/51yEQeDXnRjmzR4C/gFqGvKh+SQrUOcuc7mJqaHlQx0PtqVVbIsLwnPhHn51F
 6Vz+U+Vp6RbNdq+xND93vwNdI5LynYYPJEjRn07R3DRxJOAjaITY5T9G/8v4sutNL
 jk4q996lv6b2DLqTNO5HtiO1zs0rtbLBYMD7X3Y0xvKnly+y2exHnjNw/JTJypQ2x
 dW0qwbPyI8UUOi/nAw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([178.202.41.25]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N33ET-1sVlXy2EiT-00w9a7; Mon, 17
 Jun 2024 11:24:35 +0200
Message-ID: <f7ef89cb-7753-4cc3-a287-aab1ee097e60@gmx.de>
Date: Mon, 17 Jun 2024 11:24:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] bootstd: Replace bootmethod(s) -> bootmeth(s)
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Mario Six <mario.six@gdsys.cc>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
References: <20240604-bootmeth-typos-v2-0-821683a95aaf@baylibre.com>
 <20240604-bootmeth-typos-v2-2-821683a95aaf@baylibre.com>
 <a7410171-c413-4815-8187-606d32b0c5b3@gmx.de> <87r0cwaxn2.fsf@baylibre.com>
 <cee89831-9ece-4dd7-b021-538c6fcacfae@cherry.de>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <cee89831-9ece-4dd7-b021-538c6fcacfae@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8OAuIzEW1MyEjR+tYTdJ98mQWCxgkfw+mC5Ar0wFMR04yBw5NSe
 21ZDcMI7msvy3vBFyUo2/mrbJbSUEvjaLWX9bc5MmKfgwRDO0MHAx5n1UZt+bO+5qIfaQUF
 nvs1QpGK+4n5l4Gd3mWAAhSEBaSfYygNEk+ZrYcDAZbTiI1xbDPS/mz3TT5B7rWpY2XRsTb
 Y0RGeBKVE7Fxo0hqn9mgg==
UI-OutboundReport: notjunk:1;M01:P0:C3V+yw48WNI=;sA8/kaotLo+hQHtcYrJWjwXo2Hw
 M1RprApGZdm3mG7jKTl6VB6g4F2u/wo8C7tfzNGhtnTvp0jxC5Eo8Hxn9NTc07OSNE7lB18oI
 AoSbY9GIokem93Lv8Q3fpshjkYY2lCs/jvfRp86UhENbj8jS6wdPNi+ezzUc0/Av2ikZ6N/Hh
 6vqYiv52/Fs68nskM9w+0GoF5KcDftzF8RXNYoBSzbeM05N346fcitHtEh4Noi3Hq6AUULxsW
 FxUHWvCJpJ7npkikEB+RWmGZvB/pYStofAOqOj9LYWtmJEdP/Zw1mA1M2nfDHZnB5hDGkz77D
 TXSt8t17ql4eVbXxIYBBApF47nWBw+1I4AoaOfFJWfKIKsuHHqkQVGpMUKvO41cDt3mZaSkgT
 WZratQtiE1f8AbzfqpEsm8am2AeGslypSB+bOQbWEX2WaAhxxSVb3RjyEchix10iMqDQiu9ec
 fTEhLBMd/BNPBgp2O82JPwcU41ncEGr4nfZfsukS7Dg4+5YPzJx00OfHFxPsn/7scOlUO/HTL
 2Zt7DSMJSfyiJ7if1UoGf/Qy8gl2OVnBoo2XJEpOCoM8pIuhNNwZy+HURQgTPcLGb65Qi3rwR
 H9pgf+LGFxXIGUSNVY+3DLqAkFte5O+6Y8IQeEQgj30yyiFTMSz2YLRmDHDdmflhJQ9rDnHqj
 9Z3D/d7PgzxEkoeECquUMgpNbc+paumHNKK+yGwZ8c8L4XIVsLsWOYnIAPiFhCtxXwUAq2qRL
 Nx3ESJkLwPvHNCKpXmwMvskkFcPP+zGQ2ddC8Yeh1zvp3jk3SD2o0PpAUhop39li1ILLfFAfl
 W91kTOOln2O7Kke2Qms0PJWBPMpHO+lqO8eW967k/p4G8=
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

On 17.06.24 11:00, Quentin Schulz wrote:
> Hi all,
>
> On 6/17/24 8:31 AM, Mattijs Korpershoek wrote:
>> Hi Heinrich,
>>
>> Thank you for your review.
>>
>> On dim., juin 16, 2024 at 09:38, Heinrich Schuchardt
>> <xypron.glpk@gmx.de> wrote:
>>
>>> On 6/4/24 17:15, Mattijs Korpershoek wrote:
>>>> According to [1], we should use bootmeth when describing the
>>>> struct bootmeth:
>>>>
>>>> """
>>>> For version 2, a new naming scheme is used as above:
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - bootdev is used instead of bootdevic=
e, because 'device' is
>>>> overused,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 is everywhere =
in U-Boot, can be confused with udevice
>>>
>>> Boot devices are udevices though they don't relate to hardware but to =
an
>>> abstract concept.
>>>
>>> bootdev is just an abbreviation. This does not make the meaning any
>>> clearer.
>>
>> Per my understanding, the name for this concept is "bootdev", not
>> "boot device", see:
>>
>> https://docs.u-boot.org/en/latest/develop/bootstd.html#introduction
>>
>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - bootmeth - because 'method' is too v=
anilla, appears 1300
>>>> times in
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 U-Boot
>>>> """
>>>
>>> Avoiding abbreviations like bootdev and bootmeth improved readability.
>>
>> The above paragraph is quoted from email [1].
>> In this email, Simon made the choice to use bootmeth and bootdev
>> when pushing the initial implementation.
>>
>> This patch just corrects the places where the older terminology
>> (bootmethod, bootdevice) was still used.
>>
>
> The current wording is just incorrect, so it needs to be fixed. We have
> two choices: use the struct/abbreviated name (bootdevice -> bootdev;
> bootmethod -> bootmeth) or the full name (bootdevice -> boot device;
> bootmethod -> boot method).

The English languages has three types of compound words: solid,
hyphenated, open. bootmethod, boot-method, boot method all mean the same.

According to https://www.merriam-webster.com/help/faq-compound-words:
"Compound nouns are usually written as one word."

See also "U.S. Government Publishing Office Style Manual", chapter 6,
"COMPOUNDING RULES",
https://www.govinfo.gov/content/pkg/GPO-STYLEMANUAL-2000/pdf/GPO-STYLEMANU=
AL-2000.pdf

We should avoid unnecessary abbreviations.

Best regards

Heinrich

>
> Heinrich are you suggesting we go for full name instead?
>
> board/sandbox/sandbox.env should be using bootmeth instead as that's the
> name of the feature?
>
> Cheers,
> Quentin

