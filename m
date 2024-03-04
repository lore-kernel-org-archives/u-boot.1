Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 335B1C5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 15:44:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99B2F87FB9;
	Mon,  4 Mar 2024 16:44:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="VRhGeimz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC32287FBE; Mon,  4 Mar 2024 16:44:18 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6C8E875FA
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 16:44:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1709567052; x=1710171852; i=xypron.glpk@gmx.de;
 bh=i99GwJZ64gg0nFrFdHGjgvHNx0c090OInhTJtiqLJDQ=;
 h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:
 In-Reply-To;
 b=VRhGeimzAhcutJShcuiHBal0p9YYQBJ+qR1SJmIjcI/454b8lmErCmN851jbAg9B
 eG8NOfUnzgMkS4lz+3/g7nesJYIQznA0X35UJPAw+Qcd/v2eOnMCVVrGbbt8po9WP
 /f+Z9AoWslFSbklsvBbysi1O1v6URUL+5JjBpHg/5aK8IsT3R96JlUY/J4TrbG3wk
 rmVW2+kjYMLaEoAIVNFAhmof3qxS4H/mSQEjzomk3hS7B5i70yafwyFTUdS+lDyRx
 0NeQpvszDjNKJgpcPKLlNop5oH0dYgY8fNEWiNOSY2AJhM1EgvyCErC6rFSRKjWyK
 mEyE9yr+acBVDiSF+w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.101] ([109.42.176.242]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MkHMZ-1r0uv43abx-00kfnw; Mon, 04
 Mar 2024 16:44:11 +0100
Message-ID: <2e36991a-2a3c-46d8-bcbf-1c2c7a3d3a63@gmx.de>
Date: Mon, 4 Mar 2024 16:44:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: sf: Fix sf probe crash
Content-Language: en-US
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
References: <20240104114619.280513-1-o451686892@gmail.com>
 <CAHk0Hov+uwanmDK9wh9ke6c2JX7TRw9_qsF9Vq+Hrs6rqFqD6Q@mail.gmail.com>
Cc: Weizhao Ouyang <o451686892@gmail.com>, Michal Simek
 <michal.simek@amd.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAHk0Hov+uwanmDK9wh9ke6c2JX7TRw9_qsF9Vq+Hrs6rqFqD6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HcATq0IJD1Prl5cWlN5DpbbKQUYgLWM082w1kYhqlSBU6mv8ErR
 Od8YmOMsoQdfFzh7AwB4FEz50/NUwcLeJDzGxDxoR9RuuQBNTogIaiT4EEY5nwv14acFJgZ
 Bq9+IZCqjfV91Y+86DFqVAUBZNF3wDfy4yHimsAASSVOhoVQbJoYyRwRSxhkzUMURA7hXM/
 vikmQpLgmWGohU1tQzTvA==
UI-OutboundReport: notjunk:1;M01:P0:9JuNpxItve0=;SUDPk8yDvg5yKCtrH8CNsjo/7Un
 WpSg8Hh8wtL2Z98Yj/JahsF84f1LvFvGsOfzq3GxlNetyyxlUM1zJW880YAQr2MJvTRlavV/A
 03+JR7UfZWuEW3GQ9yBmEgKn/925QY3UJMwNvtImh/TcuUAv9OrU2mDLxCXJP2Ml6JQEEivmI
 VcRHrDw5XDulwR/9h4mLWZe/ePPN7N4sf4xc3wZq4jJCRyKE9piIFUQTZTRmMWtIse9moEn4u
 00JPwqoQMhh4vnt61dLFtilwFa4PXlh7FNO1vUg0SOQfFkKoNIuGylRffJE40xcFiU9sfmhhD
 ydAbq4OMH91LugQ9UB3SrcCkqeOBXlsTRfDedV+mbxppAit1FWKXvN/HLf2SjDyuElg6pDGgV
 u9rx9QEJ3eshGghjmxzc2x+y+b75RfkwnVrjehkSHXxq9eaEWqtC5elLHHqet+/QaK9LEi2Zn
 2QJLXYDqHIF3FLKGJ/hgaQ9tVJHOl5Z/GdNCWrUgWe6q8aNvRISS5ykx5PLV08J4XhxPk65bG
 83smb9tq5sK8KBdjBIalYftpdD1GHZzVooSDW3k2YVzGLn9wPkSDm+DycLUAUJukbvtBsE8dA
 c/WUT99T3hKGJy1L6MzE9wNcuYM2x4gABYP7D6dv/YkBoISlT10LmfMd4vPJPa7AfL0u/QfUS
 eC5OlPtmEQeC27hT0QskUWsGdRRQ2rpn3dmm9L7lS1lgY/V45wNu1Qcqxgzka9JdddJFI6dK/
 3F/CNY9Qa3aTnFKvV7q0FMbix7rIvAII6Gopc4rhW6L+mSYP4zxg/bNA0e9elsKwRUj+twz1E
 AltHWIL5Ds6b8vmnX6LQWEqCjb9oP+zNo8pt2fPGKxqQE=
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

On 04.03.24 15:47, Weizhao Ouyang wrote:
> Gentle ping. Not merged yet.
>
> BR,
> Weizhao

Hello Dario,

that patch is in your patchwork review queue. Could you, please, have a
look.

Best regards

Heinrich

>
> On Thu, Jan 4, 2024 at 7:46=E2=80=AFPM Weizhao Ouyang <o451686892@gmail.=
com> wrote:
>>
>> Handle the return value of spi_flash_probe_bus_cs() to avoid sf probe
>> crashes.
>>
>> Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
>> ---
>>   cmd/sf.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/cmd/sf.c b/cmd/sf.c
>> index 730996c02b..e3866899f6 100644
>> --- a/cmd/sf.c
>> +++ b/cmd/sf.c
>> @@ -135,8 +135,9 @@ static int do_spi_flash_probe(int argc, char *const=
 argv[])
>>          }
>>          flash =3D NULL;
>>          if (use_dt) {
>> -               spi_flash_probe_bus_cs(bus, cs, &new);
>> -               flash =3D dev_get_uclass_priv(new);
>> +               ret =3D spi_flash_probe_bus_cs(bus, cs, &new);
>> +               if (!ret)
>> +                       flash =3D dev_get_uclass_priv(new);
>>          } else {
>>                  flash =3D spi_flash_probe(bus, cs, speed, mode);
>>          }
>> --
>> 2.39.2
>>

