Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D3E5C5472E
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 18:51:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A848688387;
	Mon, 26 Aug 2024 20:51:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="klRi4P2P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DD5288A7B; Mon, 26 Aug 2024 20:51:03 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 432D1880E6
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 20:51:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1724698232; x=1725303032; i=xypron.glpk@gmx.de;
 bh=H7FQSml9Ts+9TSE9GdHBuF6CIJEek1OozTCQyFBHeuI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=klRi4P2PeaZLFgKI0yO5hJaSNlNLHRico33bXIwa4XJ4R8IgNyNOjpTn1Cc0NHUN
 ai2rmKoG7S2eg0yYoJmJ9StHcd3xgqPW1nEhBZ4h6BFKlWYV50JkNteYtETl0Tp83
 XAfPZQlOhycMt0MCu0XRg5ycQebT28M6R+n8gvf/iwYAPYS0zvBmvXUbparqXeau6
 E9JXl1sRqnowf4ipDLqv48r/stl0gWH6ENoQHk4Tw24eEB1fqGoKfmtd+vmU/Zsec
 W+ieTdFY0hp4QxrZwzOG5O1fuFW2pZmW1WjqNaVL70pqKsnZhDQFae+DEKRBN9sDE
 TlgXur8SXWWRxgINcg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.229.134]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M1Hdw-1sgzpq1Dn0-005Amu; Mon, 26
 Aug 2024 20:50:32 +0200
Message-ID: <57af7831-850d-4e9d-8fcd-5ad03f8538dd@gmx.de>
Date: Mon, 26 Aug 2024 20:50:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] SMBIOS improvements
To: Tom Rini <trini@konsulko.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bin Meng
 <bmeng@tinylab.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Stefan Roese <sr@denx.de>, =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Wan Yee Lau <wan.yee.lau@intel.com>, Alexander Gendin <agendin@matrox.com>,
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sean Anderson <seanga2@gmail.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>
References: <20240816154658.1866186-1-raymond.mao@linaro.org>
 <CAFLszTjE+8BmdmtFXER94LmEYshNDEA4x_MDTqvyGhHYed2OCw@mail.gmail.com>
 <ffeb90f8-4f3b-4455-83db-d7b03b872c84@linaro.org>
 <CAFLszTg8gM53pcbHGj-LoA9GDSU-X294_q6ZRnP_QjYFppG0sw@mail.gmail.com>
 <20240826182345.GJ2479150@bill-the-cat>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240826182345.GJ2479150@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:X3nKlHY+ZczJlhGne0tmwlrZG+I7TvH6H8IHBiLKMzdnol0tAI6
 QFCTGwPxLeobnrsBimVG3qiFgVJDZnpppgjKsqHEXsQ52bNMMtt5SkNhs5XL5ox5xJ6VEPB
 H8wLaEh/0tvt6pJLTAkMKP41YmTosisGZrffM8MgNAsIx8hKeh47q98ICyJkEb9Irvz8vwe
 usqBC4/NMDNekjYbPaAqQ==
UI-OutboundReport: notjunk:1;M01:P0:YxmohzHArJk=;Y93MnY4LCGaiYdHU353u7IISnt7
 j5PjCoCdYqmdd49zEPgb+OgDuscKnEOcyAZQdaNsHFEI62S6VJ5wbqYQwDXMosmwLU6I/1jFN
 3igAOsO7+3gowCjEsR8CiNaWuugirC1RGdRdub4D8czxF3HvFS6yanZF4qqIhQ65voJuBPXzu
 rFyDOo+YOsyM2IGyWgAWSlhykPjeX1LcRHbaHQO46rmhEQKHlHrXA4Y7dmuhUJ1AjAw1r/luC
 x7Z3t0vMSTEd80COU6otvS/EJJonBehdDXDRi0WqknPyFw1NEcGpoHlExgSOWG0K8zyoAgsQz
 J1/apj36ZoHRUH31cRfmDmh4Cd2+UU8D7tE6Kynvyo8kSPLcQ4RqcYtZcsSdjZyCuH6ky/frS
 /bV1GcXwt1oCsyLwOzO+kVLPpQ7X9cu2Q5SJKOEAXv/CTD7+Q5WoX1oF2DjwrV3Bh/Z/mJGPn
 cXubTWXR2BEZnJfCxv3/wkXS10h7bhsG/FLiPl9Ib2TTouB9afbz7Muy9IvCOjr+YKTp/DJTd
 Gqr+Dl5njt6m9TJ1nEj9ZkyIcC4l8NEqQ62Y8JwVP7FnguRc/Wexo930w+RzJ9VyAkizYNBOg
 m5+FHBWH1sbBUPEYugquhXr30gfFphzBnZbSWXbU5kXZqqvHN6vSibHRU5aWEfxMo6tDeRW6j
 qR+VlvE55X+OkxNjd7Q9ZAS1f07zeH1ImKWj8uCmOiu/ig6ulmBhIX3dhvYM9qT7LXcIaVFXh
 kAF6W+8tM6DUU9L1Zun+C+WKr0ZLeTjAG9C0D3zrya626SEUq7pfj36T4fUestqCtMz1TIZFt
 uQQ1CnKINU4/2JzhemUtz42BLPIJ+g6gm2IVj74cgyPxU=
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

On 8/26/24 20:23, Tom Rini wrote:
> On Mon, Aug 26, 2024 at 11:58:54AM -0600, Simon Glass wrote:
>> Hi Caleb,
>>
>> On Mon, 19 Aug 2024 at 17:03, Caleb Connolly <caleb.connolly@linaro.org=
> wrote:
>>>
>>> Hi Simon,
>>>
>>>> As a general comment, this is adding a load of code which is used by =
a
>>>> lot of platforms. As more and more aarch64 platforms are created, thi=
s
>>>> data grows. Why not use the devicetree for this hardware information?
>>>> That is what it is for.
>>>
>>> This data does not belong in devicetree, the various system registers
>>> exist to describe this information... Putting it in DT would be
>>> duplicating it.
>>
>> I am not wanting to duplicate info which can be read from system regist=
ers.
>>
>>>
>>> Using DT for this would additionally require having bindings accepted
>>> upstream and for all SoCs to add them. To what end?
>>
>> To get the correct information in there. How are boards supposed to
>> add SMBIOS info? Do we end up creating a whole infra in U-Boot just
>> for the driver to read it out? It just doesn't make any sense to me...
>>
>> Let's put hardware info in the DT where it belongs.
>
> I'm a little confused here because of some older threads on this overall
> topic. Part of the issue here is that in user space, "everyone" has
> SMBIOS-based tooling today, and wants to have that work, rather than
> inventing new tooling or modify existing tooling. And you were concerned
> I thought that we had tied SMBIOS too much to EFI being present when
> indeed it should be possible to pass the location along to the OS
> without EFI, but at the time Linux at least only supported that notion
> on MIPS I think?
>

Looking at the Linux kernel code, only x86 can discover an SMBIOS table
without EFI. We should not ride that dead horse.

Best regards

Heinrich
