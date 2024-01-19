Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9F8FC4725D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 09:20:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68F1387645;
	Fri, 19 Jan 2024 10:20:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.net header.i=wahrenst@gmx.net header.b="pkWU+bMF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4442487705; Fri, 19 Jan 2024 10:20:25 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 844B287561
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 10:20:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=wahrenst@gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=s31663417; t=1705656019; x=1706260819; i=wahrenst@gmx.net;
 bh=vkJvWgmSkvcECDRaYVeSw42Hw/nvvJrhojpJfun4PKE=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=pkWU+bMFrgY3u1HmToHtPqYnN0kn8MklwmB1V9fFdmmL2NNfz1e3z6oG7J5vcIty
 q3AuMq/uqOd+RORxV/KBfK/2KyKBO34BFgrWsU0wQ0w2XLG3C01oDgK4ItMvO8Rsf
 D1OFRj7HQFL8oam3ynx+2Kuc2AQb/nQ0HZA9utuIh88KVk+ii4xYXDGnQ9k4lYf/H
 Hrde+Rx5jrUBMT/VbhS9VUsAM3qKew2SN5HsVcXqkLUAPq8Rs25h79tBTezMnEva4
 otv6hRXDlX0hA5PiFGkB7CmQ6Gnr4cwuWn/8bVUTOt1DPXBglf9Bc7p3KH3pvNBUl
 KoA3cAZ15c7fkVSaoA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.167] ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MuUnA-1r8oQD32qw-00raZn; Fri, 19
 Jan 2024 10:20:19 +0100
Message-ID: <03bbe9ad-7cc6-491d-8bd9-631f1cf04f39@gmx.net>
Date: Fri, 19 Jan 2024 10:20:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/6] rpi5: initial support
To: Jens Maus <mail@jens-maus.de>, "Ivan T. Ivanov" <iivanov@suse.de>
Cc: u-boot@lists.denx.de
References: <BD4D4B77-9C54-4FD7-8EEF-A65E674E0747@jens-maus.de>
 <sfo77vzvmblyv5g5ek6uc6oxrf5n7dcp3vsw2g2lvfnnrlyaft@kc6s7vvspwvz>
 <4DCC64E0-F0E4-4AF6-8E81-62B156E81554@jens-maus.de>
 <2303FFA8-E2FA-4AA4-AE67-FF5E904D21DD@suse.de>
 <A796E025-0F6E-4FF7-BA4D-2F52CD763B4B@jens-maus.de>
 <9AFD4C3E-E1B7-4EA7-8589-7060A2747732@suse.de>
 <5C0A3CD4-2591-4266-B9CC-7EC38C6A88C3@jens-maus.de>
 <454FB8E4-52A8-482D-8671-5650F8C4773C@suse.de>
 <A26CEBAE-9950-4304-B3A2-1BAB4035437A@jens-maus.de>
 <zmxxqxlbhdhngu36ft4yrqxtjkmvalvhbgbl2uzsj2jgnq7zje@qtncpq2nss57>
 <DCAD0173-2377-4B89-92EB-F38ED1CA938B@jens-maus.de>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <DCAD0173-2377-4B89-92EB-F38ED1CA938B@jens-maus.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5KDXsXEKKRhHQAPsiPkKlzAcB7EeuvNndqT861kjChAeHrrzXSW
 Dzxsr0KKx0smzAr1Aa+trJX8KoQ0TCklpe2CUZQUB5fUaPWku5AaR9DDQW3HO4+rzlT/noD
 ih6xNj3JEsHviDiabsQRR/hwN3V7Ux/H9b8A/kqhTIuhQiI246GYNzZGP69FaXYxFXlbl/0
 haWWE/EzAA7vhoI4MuIzg==
UI-OutboundReport: notjunk:1;M01:P0:Rp0wjZ4c8u8=;qn0WP7Un3XKtxxce8Nuh/dwy2wN
 uDi5YRpJsJDxlpoGsrqDYS6awTufr/FVewyZDHCCpZqtmUPmAqQF6vRfrW9u2sFxT8r9mY85/
 2jOQBGAYLA1EC0DHucwZ1KoP6JAMnrgl29IXGqqZAVGyh/GJFY8kgkK/W2uVL6xMLbOprVio7
 sKFyPYQV4eYOb72SBC4qSB60xKP57AoMGvhqOddg99HSrLVlG7bsLReMOKuT4p2qneHLKQ4a7
 pKx+uuz0bbQRLXC9kcR4+XdLkOAyPbHMxbf0EFwlljLmQyCeis829Cq4DDFQrHIg4HW+qvpZt
 c7N7fQGUuG3G6HG8ZieeXOuPEJVPZn08NLXgrYfUtCLGIRPb5+uXz681g5QxSMG65PMElOAw4
 19Fo+uhwq0vjRE4eZRmwODzLpDvi4eeVjQM9/iurQzwUna6qmD5bTRm3LNgJ+XJVXrSDsWd38
 BB54B5LSw05qRPzZDGusglW0L3G5lYN57HV04+dfeHP+VlaRJwpq/HwipD9ae4f7sJ0r/lbgr
 sSFhEjLPPSb0mp5v/uk1m2EX3D1rNgauZoxZtsthAs7NicrscgdKWbdhTdHfI7gcTH2yFinw2
 Av9JMv1WyiAwNsmTkf83MBITA+DwE6OpYgFgIIWgzkfjT/k6m9awSqbmhH7gKBi3bHucl5mr8
 5JNWNhyByPq2nbq0CMV9KFxpR53P7V1dbs5VzBkZp9Vk1fIngrQxSlmOuFsiEHh9mFYeJGxHP
 O53tW3WPLeTb3AJ+oIzbBgCQkX3M78j1inPeVzaDzIrowTwh9JxDlN8tiV2ATaO11kcbZMG3I
 Gl5c4zWb612PBnXAzaAoW44UYXvXGHN/4A3cN68r6at+oqakuPZao8E9n93axuTe0t1KNrXVy
 Sji0EXnPhkYlRoEiPr35yRN1McVAIR6LaMUlFHrnpHKGEE/YvKU+FT8saDfWgJN0anliXXqO/
 yoqJkA==
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

Hi,

Am 19.01.24 um 08:21 schrieb Jens Maus:
> Hi,
>
>> Am 19.01.2024 um 06:29 schrieb Ivan T. Ivanov <iivanov@suse.de>:
>>
>> On 01-18 18:18, Jens Maus wrote:
>>>> I am afraid you will have to connect that UART debug cable and share
>>>> what is the memory map on your device :-)
>>> No problem.
>> Thanks, but could you apply attached patch and send me
>> the logs when there is HDMI monitor connected to the board
>> and one when cable is unplugged.
> I applied that patch, but unfortunately no U-Boot specific output on the=
 special debug UART of the rpi5 at all. As I have shown in my earlier emai=
l, the output ends with the =E2=80=9ENOTICE: BL31=E2=80=A6=E2=80=9C messag=
es and there is no single line coming from U-boot at all. Also tried to ad=
d =E2=80=9E#define DEBUG=E2=80=9C to the fdtdec.c file and added CONFIG_LO=
G=3Dy as well as raising the maximum debug level to 9 to the U-boot build.=
 This for some reason this does not end up in any additional U-boot debug =
line output on the RPi debug probe connected to the special UART of the rp=
i5. I even tried to connect the debug probe to the UART pins of the GPIO b=
ut also there no U-Boot debug output at all, I am afraid.
i don't know the reason for this issue, but here are some thoughts:

According to this issue [1] the 4 GB and the 8 GB variant uses
completely different RAM ICs. Not sure this is relevant here or a red
herring, because i would assume the VideoCore firmware would care about
this.

Another idea could be to dump the runtime DT of both variants via sysfs
(using official RPi OS) and compare them with each other. In the past
there was a lot DT firmware hackery for the Raspberry Pi 4.

Regards

[1] - https://github.com/raspberrypi/firmware/issues/1854
>
> So where should that U-Boot debug output actually appear with your u-boo=
t.bin patched version?
>
> Best Regards,
> jens

