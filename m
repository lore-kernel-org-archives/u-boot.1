Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E332E64A8F
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 13:28:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9D6889198;
	Tue,  3 Dec 2024 14:28:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="stLiM+oQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D178888F2E; Tue,  3 Dec 2024 14:28:23 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C41518939E
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 14:28:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1733232495; x=1733837295; i=xypron.glpk@gmx.de;
 bh=wYYynlgkmg440lK8rusT5hfwBUf60VtMjy8C7GiVrF8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=stLiM+oQXo8SJPFsWASSGut+s/UFJG1Gv2+i72ZEU+OYEvPLINNsAJSux57wclg7
 QOYRZJ6ITgdTIWMlhH0YqJiDVhYL0q2zkQzxkMUHhabk3hd71E74ALZc4S0Zp7vLp
 Qm2BzMcnkdA3YAZZBneiVK9Vsq9g9fYZqG7f5mY+96C7WOqFUsDPiNyLXBkFdzKGy
 UBUddeOy12+8WNDRQF8SyNpKWhDoN/kEQzifq7h8uHie03exBuGqJqciNokvLPVX5
 y1YLccAneBcaCEvbU3pEgc2bbn55SLA6yDldBAV4IfPZSmI0Ird1kT+7hj5fCgG8y
 0mgvcD5i52NvaHI0uQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MA7GM-1tOYXl2CCY-001bhY; Tue, 03
 Dec 2024 14:28:15 +0100
Message-ID: <e9b219d1-0e94-4596-9fca-f34cd174edd8@gmx.de>
Date: Tue, 3 Dec 2024 14:28:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] smbios: address build warning
To: Peng Fan <peng.fan@nxp.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 Peter Robinson <pbrobinson@gmail.com>, Michal Simek <michal.simek@amd.com>,
 "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
References: <20241203134257.5067-1-peng.fan@oss.nxp.com>
 <9211f24f-d406-4d57-820f-f5814fcd061b@gmx.de>
 <PAXPR04MB8459658B4CAE851F480965DD88362@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <PAXPR04MB8459658B4CAE851F480965DD88362@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vKuXqrAGyGUhmm5OIlWsOzQ/AcM8uqvLYZ0dlqhtOAM3Qa+r9t/
 g5GDS85Mc0oxHOQdmxAR5lQBSdspxK8UY5pMpIbyAUwuCI5h0GJ7pP42klWqxpwCTq8Riq8
 0CpT8xuxwVuago75gPSiBm2/GXBsUOrm6D2vkxCHvgKbRorlkywmE2rKsM3zWYDiK1Oq1T9
 alMpMOhCc4LKOwswfTSGw==
UI-OutboundReport: notjunk:1;M01:P0:YkKXRqynDrU=;oKlpTABjxBdm3Avfn525p1hGR+L
 PVNLbiFfOG6xLKwiGe3MXyByd6UxQTfrfhByxMxXWHNi3F+OhFwz0TcfAM1c4aJFJTKf0gTlm
 oY/TM7+vNFRsmrKNtK2qE4GVPRrlrs2x7Jc6h94tS8yqIVqScaL96PEHQrsxHVN2oNaY7sGGU
 OJ7wZ7+RHWY4QL8B+ppdNdubhJfSo2oHHtdGeP5M7VAY5zhdL267B2M80Iv9/mPk+G5Bj43db
 yaB7ri+WvJT09ttQrcPIA4DiZIoIZtsTQZAMqNnVhCcfPpJHTWo1RlyrqGUCGaPJl5H+XAHwZ
 QT1qu8lO4O6yfmuQT1EYQvoZT9fC3wWRFiN33xB2zixhPs9v5RKCPr5Ni2k/wuRCT5r/kx3fF
 rHHFouuMTYUjDLifIl2gz1ZMttRUbjh9BbUo1MXR29eSL6xGvawPpCzmgkYeTckofxPHFPhL7
 ejflUNRhf3HC6naw6uf52ZzVnzr8oV/d/5lk4sYuVKt3Hay0tswU+u4Y2JC7I5vkr+XMgvbaP
 xAHn6FsOJr7kX/2u8HQkMFx+bozptarfE/uhvMVR20kXOBliGo6RN6/r89QjvZxIqV4DS2Rx5
 PraUy1hpOZU+46uKiwjWVIQicp4m+uTW/YXTWWIGN9Ab4b7VrayYKDXxPmOk4uVJ23nrY1xvw
 sMOXGvgIlx983u8nZggnfnRkhzqzlQ5OU86OXowPZei4xT2y207EfoF+38PRtLS265ckGmJVL
 MfVzMMeTuXnNPpQgNWl6XxLiiGqLIKmTE7u0yATAb//YaCd+QIuT++MZIe3bpGuZFAtmQ75Ky
 44JjXdWoP83p9VJZXPFz0xCNID389XVb/bzFiW8Ibug6r3rTe6kPeWg2H2TqwtDGb0P1euCXe
 aiLq8i5ueeTgQOfa5b7NLS3abShNbT1PgTLqY8P27xfG+q2wVznAP9aXA/RGtPGPTSQWlSLwf
 KuAqCZPGzZOB8cH2hKLhiYJQh3dJ8x+9IxNV8dWuySrNCi+Pddsp+rYsLizilelsQ8Um9nKVD
 jd6xkFqA6UNk3SJFMzFYnfuHGns0LzXnkObhSQH10S0iAK553zeTYiwm75Mg88nBJ4yKD39Ja
 ZA0Uwalp6gv+yNlO4ahw308/FRBV8Z
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

On 03.12.24 14:16, Peng Fan wrote:
>> Subject: Re: [PATCH] smbios: address build warning
>>
>> On 03.12.24 14:42, Peng Fan (OSS) wrote:
>>> From: Peng Fan <peng.fan@nxp.com>
>>>
>>> include display_options.h to address build warning:
>>
>> build warning occurring with CONFIG_LOG=3Dy
>>
>>> lib/smbios.c: In function =E2=80=98smbios_update_version=E2=80=99:
>>> lib/smbios.c:305:9: warning: implicit declaration of function
>> =E2=80=98print_buffer=E2=80=99
>>> [-Wimplicit-function-declaration]
>>>            print_buffer((ulong)ptr, ptr, 1, old_len + 1, 0);
>>>            ^~~~~~~~~~~~
>>>
>>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>>
>> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>>
>
> Thanks, please let me know whether I need to post V2
> to update commit log to include
> "build warning occurring with CONFIG_LOG=3Dy", or
> Maintainers could help update when apply the patch.
>
> Thanks,
> Peng.

To me the patch is ok as is.
I was just wondering, why we did not see the issue in CI.

Best regards

Heinrich

>
>>> ---
>>>    lib/smbios.c | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/lib/smbios.c b/lib/smbios.c index
>>> a36d4b4e54a..defb6b42f45 100644
>>> --- a/lib/smbios.c
>>> +++ b/lib/smbios.c
>>> @@ -7,6 +7,7 @@
>>>
>>>    #define LOG_CATEGORY	LOGC_BOARD
>>>
>>> +#include <display_options.h>
>>>    #include <dm.h>
>>>    #include <env.h>
>>>    #include <linux/stringify.h>
>

