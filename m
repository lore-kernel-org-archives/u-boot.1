Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C083C25B74
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 12:51:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CECF882D9;
	Thu, 16 May 2024 14:50:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="XZeRUP2/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8339B88263; Thu, 16 May 2024 12:07:06 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD0EC88193
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 12:07:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fiona.klute@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1715854023; x=1716458823; i=fiona.klute@gmx.de;
 bh=QtlTUSeNdQa7t8Rru/yTFSk9OHE0LCZkF16UW9QlTxA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=XZeRUP2/BvP/lLnsPbKwmhWyEakHEqHTZOfqqTBBPznnkiP7Qh/J8pN7lKJFSTb/
 3VOrzvfB2/7pbn1P0Eoqjl0Jtu39pR0Mwul5SUWoST17W1f8C+/k8S1zGmG0+dNT6
 Lbb+6CLs3zkOvQv/Rs8RdbesZR3AVUZEV5MlgaQ8RqURPCxCRUZnHkLL8vp9gvekJ
 hH4Wp2E+vqhkK4Z+HUxfOG7sPrhv3rOJZI3N6d7T09dwO4nOMBJqPdqiskXzi2oZV
 GPV4ZMpdbXIWXMSJWhMimLXipJn9F2+WgA7Pm2Tq21mkpBxwu6vM4sBXnNJkxRxrz
 hFko1u0GNldqB7/vvw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.7.2] ([85.22.121.157]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWRRT-1s5Ys93fnH-00XvGu; Thu, 16
 May 2024 12:07:02 +0200
Message-ID: <42513d32-0159-400e-8b83-8404b48ff5ac@gmx.de>
Date: Thu, 16 May 2024 12:07:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] doc: Detailed example for netconsole setup
To: Tony Dinh <mibodhi@gmail.com>
Cc: u-boot@lists.denx.de
References: <20240514202041.386027-1-fiona.klute@gmx.de>
 <CAJaLiFxwTCCiXjrRP4eHZ+Enjw+X5H-Yzd6wFJemQnLR6Ws0Rw@mail.gmail.com>
Content-Language: en-US, de-DE-1901, de-DE
From: Fiona Klute <fiona.klute@gmx.de>
Autocrypt: addr=fiona.klute@gmx.de; keydata=
 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
In-Reply-To: <CAJaLiFxwTCCiXjrRP4eHZ+Enjw+X5H-Yzd6wFJemQnLR6Ws0Rw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ooixb8wPLXnA/jytKvWMqpCNV7co6DIy0aLkKUpWsv0ZId7/6mT
 iHGex7qfzxYZd69vxE82otwWWL9zawTSEX9ihhp6CES9k2OhZ4P81VOeEUXAYfBqJyRfzrD
 d0nOM+o5oQ/tbgblzfh7c0BG/KFlK8MI9SgB65nSpw0RlTOWHFptsdDUaUXJAyPOnDDUB6z
 P17g3Z+6ZpW5Wg9wLoB7g==
UI-OutboundReport: notjunk:1;M01:P0:dKAYCoNru4Q=;CW+DFV5bdu1DEGz02nRbXFmFS7E
 TJu6ZF5wNxPWDTa/dMCb6bBnRT1huorpTzOUVEfiGSMseOnTAnVjpCm3i5MTZfUlbN/0OgqQx
 s4Kucy6Zca0H4MONZgZ/G3HurAEJEaT4n0lq2+dt/UeXAOaBBBlIdGu+JkgoH5YxQAjGJFxYz
 FkatvGJgJkPmD+Ec7jxS6JW/Z5vq+MZ3Sy0GVT7KJV8wNYhB2ETXP8aHEfjqF6qByM0kH1dN0
 2gFjWfu+fjkOy66Zm/Pqqf2qD/xLkbqRNdHNXIohomWqHqzkhGhZ7DExT5t7NYo50xahFlzwJ
 g2J+v7XRviInkysonOtRd3rF+USDFQsruhJ8P0gyt0oSTj4SQWR2Hbx9cqQqZJTWnbES8ivUN
 L5pko0USkntAvmcStK1Shh1yRe3C3dLxDmUMC07MwzxLiza+MuFjduUmyikkjqiumrljLBLeL
 z0sisevmoBEpQw7xQkvK6hN0KRazuF0rIZVxPTUMgzRSR3IU9el4D8mfwRg5CrwvUxLlQ4Qfu
 ej/VyTu8LJcZYh09G5JAMDn3OpGKe+ulI7RCdCAxV/byfiyleJLey9DlNIngB7izNDPZoFKBP
 nHkmwaWJBHTsRWdK+6lVbws0YSD9ombe9MiMvmVjhHu9YZyBlWGECbSiEI2mdBjWptR/WXXhd
 l4PoaBsu+GHcqwST6oRimWpdIyxghco7wUjmS8eWskcOcYKs9E3h0bRJlqtrdLuQsbws6ckvv
 mmLtCUGkMbBTDlIuDMWGCSDWAHOu9VeLBaQCKGDFqJ/LGhnK0afTT0uXy4hmYN32qHaezSlL8
 VGOSiByWIAC9r+JkkEzfJlfVNNlpbLGcjl9aIylB3vzQY=
X-Mailman-Approved-At: Thu, 16 May 2024 14:50:16 +0200
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

Am 15.05.24 um 21:05 schrieb Tony Dinh:
> Hi Fiona,
>
> On Tue, May 14, 2024 at 5:28=E2=80=AFPM Fiona Klute <fiona.klute@gmx.de>=
 wrote:
>>
>> This adds details that I would have liked to have readily available,
>> in particular how to activate the network interface before enabling
>> netconsole, and how to integrate netconsole so you can use the U-Boot
>> prompt.
>>
>> Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
>> ---
>>   doc/usage/netconsole.rst | 33 ++++++++++++++++++++++++++++++++-
>>   1 file changed, 32 insertions(+), 1 deletion(-)
>>
>> diff --git a/doc/usage/netconsole.rst b/doc/usage/netconsole.rst
>> index 2aa3b9ccc5..0c983e6970 100644
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
>> +       =3D> env set autoload no
>> +       =3D> env set hostname "u-boot"
>> +       =3D> env set bootdelay 5
>> +       =3D> env set nc 'dhcp; env set stdout nc; env set stdin nc'
>
> We would need "env set stderr nc" here, too.

Thanks, I guess I should add that to the existing description and
example as well then. I'll test it and then send an update.

Best regards,
Fiona

