Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BCF1C25B74
	for <u-boot@archiver.kernel.org>; Sat, 18 May 2024 15:03:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8B8F88697;
	Sat, 18 May 2024 17:03:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="cpNOZxxr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B812C88635; Sat, 18 May 2024 13:05:08 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF7DD883BD
 for <u-boot@lists.denx.de>; Sat, 18 May 2024 13:05:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fiona.klute@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1716030305; x=1716635105; i=fiona.klute@gmx.de;
 bh=J4v+BbPN2miC+mP2rKv9uvwrmUkdfRqGi+fo1aisehc=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=cpNOZxxr+nHCJPvp+H2Nr77h6U/EP+jiFfUOdX3gh/hUIypeRMTmYSl+rJ6UBQd2
 e4a2lfq1NRmfbiNt5nz2AOPR04fc+CEVWQ0i2ygjYaA0wB/gL4vicz9TiIu8qIN/X
 zZnJZ2PWiePMEWm9wAFCC3JsilkbnXbOuw1bzbhRqzjThyv6XOkQI80/baEW+IKUt
 o6cTVtEo0M9kpA7rAN8O6hEmbbpKjJDlqOX7h7rMFQ7NCkMKMMDmlt3Feo+IKUwJE
 ywQsDWCDuzduy4MHAypbTnBnBMjfztjUoU2t35o1YpZ3mgBY4WRUYKHqgXBMSJdjh
 Fg9GL6KJw0VWNDJmBQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.7.2] ([85.22.125.1]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLi8g-1rqkzI3baC-00Kvg4; Sat, 18
 May 2024 13:05:04 +0200
Message-ID: <f1f07df1-758c-4329-8449-a187cb378c1d@gmx.de>
Date: Sat, 18 May 2024 13:05:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] doc: Detailed example for netconsole setup
To: Tony Dinh <mibodhi@gmail.com>
Cc: u-boot@lists.denx.de
References: <20240516104245.2075748-1-fiona.klute@gmx.de>
 <CAJaLiFw1BD6rtMd8E3eejM62YY9W+YA9fmP9FGkiN1KE0fwgZw@mail.gmail.com>
Content-Language: en-US, de-DE-1901, de-DE
From: Fiona Klute <fiona.klute@gmx.de>
Autocrypt: addr=fiona.klute@gmx.de; keydata=
 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
In-Reply-To: <CAJaLiFw1BD6rtMd8E3eejM62YY9W+YA9fmP9FGkiN1KE0fwgZw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Fc+fS7cP7T/LlBlqRiXOveZ1FCZwEvvIKQpSBAFRzDkmcaboOVM
 O1rJxpT9M6YQN7VydAgfDqBaKVn9FN4ldMqRUWDTSqxJAeaYougX4mGoUGB1DjKo+uTxzTY
 RmEECUzToiYrVRIuqq9mXOqWSXdMxTt/UFhQVdZ/rHTNyw2wv3yuuK4TR+syKT1Cci2VaQI
 P71VjodwB/FZirNXL2bDQ==
UI-OutboundReport: notjunk:1;M01:P0:xP5kk6M65fI=;A6xrJsTgulD3rkAXwFRTiPzMrAM
 buD5/+LdrQ3MFcthjZo8et7xnohicZ/zw/fidvQ5PjvS9WFxXItx1xY2xQTH4QZZSRtTivgf9
 rHlT+qhhai+mTRsXZU9S2Zgiffw77i0Xl6FEqH5S5BOecfRb8PV+7pC5/p8uC9QHSByo7qvDw
 C+su0uva6FvDj3XLN07494Jt4rFRJhHyX5aGqkmM2QK74OmLuWysADr1f19srxfb/Lx4z23Pq
 Y9Dc0/u5yIbQCfpQ3Z11B9KS8+bzcjan5n6QoccmA6GHfSF9g5O+/mha3SFbh5mlWFngl6uFK
 vBaRQdJmZn7sw1A+aZr/ktcjjPc8DEh1zztEVtr/Tr+toOCb40IHZfcgLF+iIzsHscpQtP1ji
 nzgb3W3XKO0KirCSlxpDIkUuVU0fYjN4kIZ9ocCqaNpCbqOniVc6dtOpiprgC0aSst97smnp7
 roZgARU8cDS8Ab/Gd4epoLTyirQfQtZRovVkHDwEL7i6Nxxe55s1bjB1WmgNf99lIxkGWLaHu
 0x9glrSat5YtS6Ds4b4vQw8VLtKcmvsGKXtW/TWi/FH+vvK/QiGQLeTjmbA4nmAgNjwJyv+c7
 H42WsptJELE+pdc/eeYvoa/D5wbYvTYgszFMU5uYJGGsb0cM9DEGP6WsfsuwLevQj/GmgqHZc
 FW2hHQJeXJQytN++KFjmx0SIA0Y7erkGGcd30Bf+Cjrae3OroLNSOGaeJu3q95E1P5Z+WfKhY
 WulSszc9a9b/HLXKtOYj5ijIFf2Z+LrMqJApHrjtcl1a4ABKoxk+ut9JKDrBzESPzLzX/+/2T
 3U4eraQYD/PRHmJjcbbn3H36pE24/Lf94fVJFUfqfGltA=
X-Mailman-Approved-At: Sat, 18 May 2024 17:03:12 +0200
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

Hi Tony!

Am 16.05.24 um 21:28 schrieb Tony Dinh:
> On Thu, May 16, 2024 at 3:43=E2=80=AFAM Fiona Klute <fiona.klute@gmx.de>=
 wrote:
>>
>> This adds details that I would have liked to have readily available,
>> in particular how to activate the network interface before enabling
>> netconsole, and how to integrate netconsole so you can use the U-Boot
>> prompt.
>>
>> Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
>> ---
>> Changes in v2:
>> * Include stderr redirection
>> * Use 4 spaces instead of tabs for code block to avoid overflowing
>>    lines
>>
>>   doc/usage/netconsole.rst | 33 ++++++++++++++++++++++++++++++++-
>>   1 file changed, 32 insertions(+), 1 deletion(-)
>>
>> diff --git a/doc/usage/netconsole.rst b/doc/usage/netconsole.rst
>> index 2aa3b9ccc5..647f0c220b 100644
>> --- a/doc/usage/netconsole.rst
>> +++ b/doc/usage/netconsole.rst
>> @@ -18,7 +18,9 @@ broadcast address and port 6666 are used. If it is se=
t to an IP
>>   address of 0 (or 0.0.0.0) then no messages are sent to the network.
>>   The source / listening port can be configured separately by setting
>>   the 'ncinport' environment variable and the destination port can be
>> -configured by setting the 'ncoutport' environment variable.
>> +configured by setting the 'ncoutport' environment variable. Note that
>> +you need to set up the network interface (e.g. using DHCP) before it
>> +can be used for network console.
>>
>>   For example, if your server IP is 192.168.1.1, you could use::
>>
>> @@ -107,3 +109,32 @@ as follows:
>>
>>   Note that unlike the U-Boot implementation the Linux netconsole is
>>   unidirectional, i. e. you have console output only in Linux.
>> +
>> +Setup via environment
>> +---------------------
>> +
>> +If persistent environment is enabled in your U-Boot configuration, you
>> +can configure the network console using the environment. For example::
>> +
>> +    =3D> env set autoload no
>> +    =3D> env set hostname "u-boot"
>> +    =3D> env set bootdelay 5
>> +    =3D> env set nc 'dhcp; env set stdout nc; env set stderr nc; env s=
et stdin nc'
>> +    =3D> env set ncip 192.168.1.1
>> +    =3D> env set preboot "${preboot}; run nc;"
>> +    =3D> env save
>> +    =3D> reset
>> +
>> +``autoload no`` tells the ``dhcp`` command to configure the network
>> +interface without trying to load an image. ``hostname "u-boot"`` sets
>> +the hostname to be sent in DHCP requests, so they are easy to
>> +recognize in the DHCP server log. The command in ``nc`` calls ``dhcp``
>> +to make sure the network interface is set up before enabling
>> +netconsole.
>> +
>> +Adding ``nc`` to ``preboot`` tells U-Boot to activate netconsole
>> +before trying to find any boot options, so you can interact with it if
>> +desired.
>> +
>> +``env save`` stores the settings persistently, and ``reset`` then
>> +triggers a fresh start that will use the changed settings.
>> --
>> 2.43.0
>>
>
> Just for information, if the board uses static IP then the example
> would be slightly different. I usually use static IP and ping the
> netconsole server to make sure it is up. However, I think this DHCP
> example is good enough to show how to prepare and activate netconsole.

Maybe it'd make sense to link to a general network setup section for
alternatives? The problem is I can't find any in the existing docs, the
closest I see is the "Automatically updated variables" list:
https://docs.u-boot.org/en/latest/usage/environment.html#automatically-upd=
ated-variables

As far as I understand you can also set the environment variables
mentioned there manually to configure networking, but I'm not sure if
that applies to all of them.

Is my understanding correct? If yes, I could send a separate patch to
add that information, and maybe rename the section to "Network
configuration variables".

Best regards,
Fiona

> Reviewed-by: Tony Dinh <mibodhi@gmail.com>
>
> All the best,
> Tony

