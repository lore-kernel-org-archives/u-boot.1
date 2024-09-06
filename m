Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE576CE7AA3
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 12:29:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E53AB88908;
	Fri,  6 Sep 2024 14:29:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fhVVDKwZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DA3488B58; Fri,  6 Sep 2024 14:09:33 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2294188908
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 14:09:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42bb72a5e0bso15822745e9.1
 for <u-boot@lists.denx.de>; Fri, 06 Sep 2024 05:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725624570; x=1726229370; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7DmR4REQSH1B0QWbejGNVbMMd6fqrm3h98m1H7+ztj4=;
 b=fhVVDKwZ3MEaQ32QWRCDcdQrt8qdeC3jjtUfKVRVJKSpAmhfU2Vxt2nPB74+BVJsp3
 7+7MpJX7PXCKZ+mAPQ1C2hW2UXN6s/DgKX/zvcazyX6GKubBIylChK8W8A5zNAJpL5JP
 7OH4Uk5Jf5H2wgpP2l2umjpqbJhHXHNv1xZ32KyiqNCq9uOrkkdTotXQTg5ES22SZlWw
 QJaCkV9AysUVjrMwMvX1GY7n4q7o0xer5Wt3KkZB7hrpO45Wzph+cU2bTP802YuHsXP7
 uGeqmNclP1xUNJm4Wju35oCV6dR+r9HweiSmU6RlsWlpke7L1vv+eSJE+3oKSpqWTSUW
 N4nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725624570; x=1726229370;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7DmR4REQSH1B0QWbejGNVbMMd6fqrm3h98m1H7+ztj4=;
 b=MC0aQn64DJZ3Cyr8Sd07AfjpWb+Gxxjm/3ltRYMu7X2Fh7lZQ6Kegr+nHppSgColDs
 iyq53YRqjkhIJEYiiJZfGTYc9i+SnB9OOdH8QaB0je6GkEwHUUbYX2wgKqJWPaEYQx68
 +jxaT8b+0cW0xgiCugQa7Zjn646wLUi101LgJc0T04CubLSy9xpxK+57nm1K5Cgl3PoJ
 YF947oBXePlktgXmkQ1Vl6XfM1JuXCHPDLwJ5ovxG+cOp5Ii01uDDW2d1QmIeEtTP1a8
 pBAYKga852scCK/P9jhpBpNveWU5DZs6khgKBJ6vPcCnQMS3oYVPyS2+s8lz6JYcZb/C
 TpjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUanhSfMqAL4GoQ32Mdhrv3a9GNONZhO1kxe3Kn60cnhyHWQYAiX2LtuDhWK7Pvy4x4tIzGGvI=@lists.denx.de
X-Gm-Message-State: AOJu0YwFjOUeKu0hHERndq23sc9EEwTQum1ZgWnp231tsGIS66Jgyzc7
 R4N1q0zrsIuQV9kUgK3xcJ3u2zieXbOeCp6R8yBDc6LHIag5HMr9jaMz/3pJX9k=
X-Google-Smtp-Source: AGHT+IF+6sshTCMdFZA7kKeLcvpyjlAz/I4F5hSdbRFp9xy6Eb326mEsGozMRfAIW9LYgpFaH3MJ9g==
X-Received: by 2002:a5d:5d86:0:b0:374:af04:d6a3 with SMTP id
 ffacd0b85a97d-374af04d7aamr12678057f8f.57.1725624570353; 
 Fri, 06 Sep 2024 05:09:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:1679:7ccd:c07d:7c6?
 ([2a01:e0a:3cb:7bb0:1679:7ccd:c07d:7c6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374b9859486sm18435387f8f.111.2024.09.06.05.09.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Sep 2024 05:09:29 -0700 (PDT)
Message-ID: <5d0aa1f3-f8ce-46d5-8984-654a2786d5a5@linaro.org>
Date: Fri, 6 Sep 2024 14:09:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 20/37] net-lwip: add DHCP support and dhcp commmand
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Matteo Lisi <matteo.lisi@engicam.com>, Gilles Talis
 <gilles.talis@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Marek Vasut <marex@denx.de>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Nishanth Menon <nm@ti.com>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Petr Zejdl <petr.zejdl@cern.ch>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Eddie James <eajames@linux.ibm.com>, AKASHI Takahiro
 <akashi.tkhro@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Johan Jonker <jbx6244@gmail.com>, Maxim Moskalets <maximmosk4@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <sean.anderson@seco.com>, Artur Rojek <artur@conclusive.pl>,
 Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>,
 Yang Xiwen <forbidden405@outlook.com>, Gabor Juhos <j4g8y7@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Jonas Karlman <jonas@kwiboo.se>,
 Boon Khai Ng <boon.khai.ng@intel.com>, Robert Marko <robert.marko@sartura.hr>
References: <cover.1724419624.git.jerome.forissier@linaro.org>
 <36a13357261f734187444b48b74dec2540e73b86.1724419624.git.jerome.forissier@linaro.org>
 <CAFLszTi3YRpf4krkAYE1u7Sex0=Dn_YscSKxE8mQEh9Mxcgjow@mail.gmail.com>
 <a946cdb4-648c-46a7-83c5-302ab0d666d3@linaro.org>
 <20240904152011.GP2479150@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20240904152011.GP2479150@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 06 Sep 2024 14:29:53 +0200
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



On 9/4/24 18:09, Tom Rini wrote:
> On Wed, Sep 04, 2024 at 09:54:15AM +0200, Jerome Forissier wrote:
>> Hi Simon,
>>
>> On 8/29/24 16:05, Simon Glass wrote:
>>> Hi Jerome,
>>>
>>> On Fri, 23 Aug 2024 at 07:49, Jerome Forissier
>>> <jerome.forissier@linaro.org> wrote:
>>>>
>>>> Add what it takes to enable NETDEVICES with NET_LWIP and enable DHCP as
>>>> well as the dhcp command. CMD_TFTPBOOT is selected by BOOTMETH_EFI due
>>>> to this code having an implicit dependency on do_tftpb().
>>>>
>>>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>>>> ---
>>>>  board/engicam/imx8mp/icore_mx8mp.c            |   2 +-
>>>>  .../imx8mp_debix_model_a.c                    |   2 +-
>>>>  board/ti/am335x/board.c                       |   3 +-
>>>>  board/xilinx/common/board.c                   |   3 +-
>>>>  boot/Kconfig                                  |   3 +-
>>>>  cmd/Kconfig                                   |  91 +++---
>>>>  cmd/Makefile                                  |   6 +-
>>>>  cmd/elf.c                                     |   2 +-
>>>>  cmd/net-lwip.c                                |  13 +
>>>>  common/board_r.c                              |   4 +-
>>>>  common/usb_kbd.c                              |   2 +-
>>>>  drivers/net/Kconfig                           |   2 +-
>>>>  include/net-lwip.h                            |   3 +
>>>>  lib/tiny-printf.c                             |   3 +-
>>>>  net/Makefile                                  |  14 +-
>>>>  net/lwip/Makefile                             |   5 +
>>>>  net/lwip/dhcp.c                               | 125 ++++++++
>>>>  net/lwip/eth_internal.h                       |  35 +++
>>>>  net/lwip/net-lwip.c                           | 286 ++++++++++++++++++
>>>>  net/lwip/tftp.c                               |  11 +
>>>>  20 files changed, 560 insertions(+), 55 deletions(-)
>>>>  create mode 100644 cmd/net-lwip.c
>>>>  create mode 100644 net/lwip/Makefile
>>>>  create mode 100644 net/lwip/dhcp.c
>>>>  create mode 100644 net/lwip/eth_internal.h
>>>>  create mode 100644 net/lwip/net-lwip.c
>>>>  create mode 100644 net/lwip/tftp.c
>>>>
>>>> diff --git a/board/engicam/imx8mp/icore_mx8mp.c b/board/engicam/imx8mp/icore_mx8mp.c
>>>> index e2ed70caa43..bfdc447c478 100644
>>>> --- a/board/engicam/imx8mp/icore_mx8mp.c
>>>> +++ b/board/engicam/imx8mp/icore_mx8mp.c
>>>> @@ -33,7 +33,7 @@ static void setup_fec(void)
>>>>         setbits_le32(&gpr->gpr[1], BIT(22));
>>>>  }
>>>>
>>>> -#if CONFIG_IS_ENABLED(NET)
>>>> +#if CONFIG_IS_ENABLED(NET) || CONFIG_IS_ENABLED(NET_LWIP)
>>>
>>> How about making NET mean 'net', rather than having two options?
>>>
>>> Perhaps the existing NET needs to be renamed to NET_INTERNAL or
>>> something like that?
>>
>> The problem with that is it will make it a bit harder to remove
>> the legacy NET implementation, because every occurrence of
>> "if NET" would need to be questioned if it is applicable to
>> NET_INTERNAL only or to NET_LWIP too. IOW, some of the thinking
>> already done here would need to be done again.
> 
> Would a new symbol instead help? Make both NET and NEW_LWIP select
> HAS_NETWORKING or something along those lines.

Well in principle this HAS_NETWORKING would be !NO_NET, wouldn't it?

-- 
Jerome
