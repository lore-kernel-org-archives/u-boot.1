Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD0BAC25B75
	for <u-boot@archiver.kernel.org>; Sat, 18 May 2024 15:03:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4033788685;
	Sat, 18 May 2024 17:03:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="JibL7S/2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5097F882AF; Sat, 18 May 2024 13:00:29 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B9E780245
 for <u-boot@lists.denx.de>; Sat, 18 May 2024 13:00:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fiona.klute@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1716030026; x=1716634826; i=fiona.klute@gmx.de;
 bh=EAvStJNRXGPRWqdmrVJ7XImesf1dVEx8WaWdF0LHVww=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=JibL7S/2actjzhtkDcjgCQZ/5fvx4uo7XrE0CB2fL9W8dGPiJtjn+XeYYeI15IeU
 xlSBhAhjiI4Hyoenhhwopb9xC8QmNVpCFgCW75+msx7Xd9BAvz3RkCc7aibYcoJFh
 p8ErPSQFTDtvMSLqHTdwG4yDVarDiwGsSGsrZGtnOe7TjQxWJgVuH2au0eQcB/4GU
 RFfcAAnP3WX7TZlUbjzmP9KF4DqMjDoLUkjVzHfIlItOjd2JdNqizqGjVHcC/W0vY
 KslWjXvRaUzekBAI3EUYMM5XiOlpRaYnNa+gFF+nODAX3NYhv1Wwo3VIIP68tVLlm
 IEFavq1tOtCY1wfwDg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.7.2] ([85.22.125.1]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MV63g-1s1F3142dC-00TCxj; Sat, 18
 May 2024 13:00:26 +0200
Message-ID: <efb7d71d-3f90-493f-9bb6-a0e6031133bc@gmx.de>
Date: Sat, 18 May 2024 13:00:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] doc: Detailed example for netconsole setup
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de
References: <20240514202041.386027-1-fiona.klute@gmx.de>
 <ca354685-cdc4-42b9-ad84-f3d8ed05154d@gmx.de>
Content-Language: en-US, de-DE-1901, de-DE
From: Fiona Klute <fiona.klute@gmx.de>
Autocrypt: addr=fiona.klute@gmx.de; keydata=
 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
In-Reply-To: <ca354685-cdc4-42b9-ad84-f3d8ed05154d@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fBtashU1wUXhS6fM41XE/UO8O5zob4m22A4XwioUjHUidP7ufMX
 B5rnN99fGawtO9ZGjFIc5kkM3ULD9Yu25QARmzz/3JGvJP8mqMa1LBqTVDAxYtikHwXbBfl
 kjIiPlGhzZYqvFGgIp680lUV38/uQN43pIa6rFBAX0eff3KX3SyZahm3mnqQED9O9lv4Crs
 tXgHPOx3zmmLiQLAX96DA==
UI-OutboundReport: notjunk:1;M01:P0:LI7w6E/Bpc4=;nDv9//1iCY1ZfgxchsPchOK40u4
 /yqGebdNJiBhyPWFA3Of+EMoIrA9T5nU5gm2CejWr7rK1+t8pikSwvQ1GGO/l4vcmErJ3Wbh1
 goC0nAntAukNgXHiWzLjz5Hif5/5t26xxcNw4A1A9HUBPs0zkHmoishtZ+3FRHzKusJ/DSErr
 XprNwAwOdQqZdsogEzBW0sXD5skQKpF+xABeTASQVp5REgQSmYwGcMXkZDUpqA/sRQJTN2OS3
 xxOQHij/webGN8S9UHel93+/P0CiJ1zojjweE3tnF/D/Bp6HGGcAEPW9MTXylnQRrPInLxTBx
 IqnftsStNY3GVeEzhFbrRx+7GK5mr23qxHe/bZLdsRMnEaifRWQ2LdS4qbV501/hbx7H1FlHY
 /zbrcQpTwaE0fywljDxR5GWoLQl5HZWt3U55SBS6bRttGGqWa+7+yhiCmQucpU01XhRHteh9j
 8vtDo+pE0kFBsKLh1Jwd2OOpgUVdQ+Fj9kDJKREPzPFTZv7PjPBICOjKswaA6Ui1KIXaPNq0A
 aw+ZVQpOT5fPcT1WJOB5fOfZzTqw0dQrHAyF9o/qhx6am6Mvx0Y3Gvw296YXMFmMG0zSFuYX3
 TbTI6KJUOYH58ZYIiTm5zzldsbviWRHwGYP0cp5sfz54Ag3N1zpNg55biBwK1TncVttcvWzoS
 B9M+udWDV4VWw5qgr1Lm/+QMyiGk5TCCzue0XXdNqzG3xV5kmLc2BcB/V5UUFd6Q3rVizqI/9
 L0krseEipIbbx0G6RwYxBoa1YAxz/4uj6xYoZffpmSxHfPjMymBK4bagypOvKGpYu748nUMLx
 w/H7TDLZMPj6ApA0P428xrG60D5nilhX2Ct1MKcnu2YdI=
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

Am 17.05.24 um 09:32 schrieb Heinrich Schuchardt:
> On 5/14/24 22:20, Fiona Klute wrote:
>> This adds details that I would have liked to have readily available,
>> in particular how to activate the network interface before enabling
>> netconsole, and how to integrate netconsole so you can use the U-Boot
>> prompt.
>>
>> Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
>> ---
>> =C2=A0 doc/usage/netconsole.rst | 33 ++++++++++++++++++++++++++++++++-
>> =C2=A0 1 file changed, 32 insertions(+), 1 deletion(-)
>>
>> diff --git a/doc/usage/netconsole.rst b/doc/usage/netconsole.rst
>> index 2aa3b9ccc5..0c983e6970 100644
>> --- a/doc/usage/netconsole.rst
>> +++ b/doc/usage/netconsole.rst
>> @@ -18,7 +18,9 @@ broadcast address and port 6666 are used. If it is
>> set to an IP
>> =C2=A0 address of 0 (or 0.0.0.0) then no messages are sent to the netwo=
rk.
>> =C2=A0 The source / listening port can be configured separately by sett=
ing
>> =C2=A0 the 'ncinport' environment variable and the destination port can=
 be
>> -configured by setting the 'ncoutport' environment variable.
>> +configured by setting the 'ncoutport' environment variable. Note that
>> +you need to set up the network interface (e.g. using DHCP) before it
>> +can be used for network console.
>>
>> =C2=A0 For example, if your server IP is 192.168.1.1, you could use::
>>
>> @@ -107,3 +109,32 @@ as follows:
>>
>> =C2=A0 Note that unlike the U-Boot implementation the Linux netconsole =
is
>> =C2=A0 unidirectional, i. e. you have console output only in Linux.
>> +
>> +Setup via environment
>> +---------------------
>> +
>> +If persistent environment is enabled in your U-Boot configuration, you
>> +can configure the network console using the environment. For example::
>
> Thanks for adding this information.
>
> Prefixing lines with =3D> makes copying harder.
> If you see value in showing the prompt, please, use
>
> .. prompt:: bash =3D>

Good point, I've sent a v3 series to address this.

Best regards,
Fiona

>> +
>> +=C2=A0=C2=A0=C2=A0 =3D> env set autoload no
>> +=C2=A0=C2=A0=C2=A0 =3D> env set hostname "u-boot"
>> +=C2=A0=C2=A0=C2=A0 =3D> env set bootdelay 5
>> +=C2=A0=C2=A0=C2=A0 =3D> env set nc 'dhcp; env set stdout nc; env set s=
tdin nc'
>> +=C2=A0=C2=A0=C2=A0 =3D> env set ncip 192.168.1.1
>> +=C2=A0=C2=A0=C2=A0 =3D> env set preboot "${preboot}; run nc;"
>> +=C2=A0=C2=A0=C2=A0 =3D> env save
>> +=C2=A0=C2=A0=C2=A0 =3D> reset
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

