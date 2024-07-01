Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC537C2BD09
	for <u-boot@archiver.kernel.org>; Mon,  1 Jul 2024 09:58:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F00188297;
	Mon,  1 Jul 2024 11:58:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="h/vaXElq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DF15883AC; Mon,  1 Jul 2024 11:58:27 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 289F38824C
 for <u-boot@lists.denx.de>; Mon,  1 Jul 2024 11:58:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-57d06101d76so16197a12.3
 for <u-boot@lists.denx.de>; Mon, 01 Jul 2024 02:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719827904; x=1720432704; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eUMFLpE+8qddekIzBDHDKPuAEIg5nMHnE0IyxnXh3lQ=;
 b=h/vaXElq3XjS+uUlZACm1vod3NieOouNF5qD7RcQsN8cNNYPTFy88Ek/6hTiGyY8oc
 3cQE3dCawHzNF5AzfvEbbJqOGSdpOo/OoLed7OLKlF/joQGdzDW3x2SXDd6m0TMuZMQV
 LDHT0sJVHEce5KDOD5Anx98d+zXHHCuygl09LvsFXCIy+OIjoK7Mj+hAEmga9luVCZ30
 Fd2cB4X4HjmdEoHAyrL11mCLq1uvkdk1cwAGL1EY1GjaNZuRCXdyb8BxmOrJW0+WbAzM
 IoYQtsnvik2ZpBimEaHblwuuyZQsV/vU/cLOTTKuTDlm2zQmqR0sM+SN3j9JtcAYdDnb
 /h7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719827904; x=1720432704;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eUMFLpE+8qddekIzBDHDKPuAEIg5nMHnE0IyxnXh3lQ=;
 b=E6MhiK1CjGMPBaffd9RpkYQsiSK1r6X4YMzk+Yun7UYT4OGK362rZqv7hXZt3QB5Nj
 RsTWDGphr8jzf4sq4Lb09O1Pfvjtqq5vdH+0xPMlTOHKpfhBK/gqZkDPd7zLmmmCiRXJ
 Zo248qi0Kydk0sCpuGBcZ25A/pkptrJCAmZGuK9WfmXbCmALKoZm7wDQnA9mLGbEq7D0
 W6Z715nTHOuCoeM5I3XFxG9xIh2wPHIhN8aJ4alYFw2is+ibzrIN6aHW4PAzfrlNglFQ
 1FHN1d3Nj5npOjKECXrVO4kZwa7LKIrmj8vfq/I4b7CRGUn5jbekuBCWdJm/kP+vTBzT
 7eAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVA1eVcMpdrOZLT4noiTcoI69Tf1HWAUnusIOPi5ezEaBoGF1TJRQmiuT3nNkTH0fwcS5S0boF7FiVk8DS5E5/tjQ97LQ==
X-Gm-Message-State: AOJu0Yxs4izNb1cLzQlqaq/K28FOzVbHpMEOSmqJpZYApRj0VyjRPuIp
 HTgWs8iCIa9rzl1TnYa/J2pHQ41bxYR4n+nJqRAYkpUhTJPbPk1SoFbMQO40Gik=
X-Google-Smtp-Source: AGHT+IGXzOfqSCWb7f7MLyeCNc77wCeHuiUv0sUaINkKmwjTsD5hnNkgA56Nmkch6ACV1u/+dIXogw==
X-Received: by 2002:a17:906:c9d4:b0:a6c:7181:4ffe with SMTP id
 a640c23a62f3a-a7514498a9cmr334354066b.66.1719827904434; 
 Mon, 01 Jul 2024 02:58:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:6677:431e:31d2:9da9?
 ([2a01:e0a:3cb:7bb0:6677:431e:31d2:9da9])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72ab0657a6sm317488266b.129.2024.07.01.02.58.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jul 2024 02:58:24 -0700 (PDT)
Message-ID: <bad2d9b7-1fb2-4602-b699-036f32e60a20@linaro.org>
Date: Mon, 1 Jul 2024 11:58:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/14] Introduce the lwIP network stack
To: Tim Harvey <tharvey@gateworks.com>
Cc: Maxim Uvarov <muvarov@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Joe Hershberger
 <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>
References: <cover.1718638104.git.jerome.forissier@linaro.org>
 <CAJ+vNU0yGH6FKZsx+UZXvnQnsT13U9iKUb68=Fqc_z7J0XL14w@mail.gmail.com>
 <0db93742-f8d3-45b6-9d1e-e4f687c2d81a@linaro.org>
 <CAJ+vNU3ECDoquHLyA3ULac0HkUGbzggG-bDQ8v0F2vStyr47gQ@mail.gmail.com>
 <CAOMZO5A4MS9eZe24WBSu4omfhjmwtjM72ftdQBwDWGd1wFiLmw@mail.gmail.com>
 <CAJGZr0LCGaKN_G54HMOmQx8y7cuER_OLGP6Axf2ksUQLhoSF8Q@mail.gmail.com>
 <CAJ+vNU2X7n0VQjP0EZ7NpyVM-fKiqWQ7xL=MKGa3xQa+d4YXrA@mail.gmail.com>
 <126507ff-2309-4147-bea6-1c4398baeeb8@linaro.org>
 <CAJ+vNU0A2XUXgqc6-2RF2iV347P9G+gPGjVQBTpwV-67LxY2hg@mail.gmail.com>
 <01fc0b03-68aa-40d1-90b7-fc95fd80ffc9@linaro.org>
 <CAJ+vNU23e3jEcTBhZvK63gvzN7eFmaxa8NcB+5j00BGnP2iK7w@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAJ+vNU23e3jEcTBhZvK63gvzN7eFmaxa8NcB+5j00BGnP2iK7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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



On 6/28/24 17:48, Tim Harvey wrote:
> On Fri, Jun 28, 2024 at 2:50 AM Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
>>
>> Hi Tim,
>>
>> On 6/26/24 18:00, Tim Harvey wrote:
>>> On Tue, Jun 25, 2024 at 1:02 AM Jerome Forissier
>>> <jerome.forissier@linaro.org> wrote:
>>>>
>>>> On 6/25/24 00:28, Tim Harvey wrote:
>>>>> On Sat, Jun 22, 2024 at 1:09 AM Maxim Uvarov <muvarov@gmail.com> wrote:
>>>>>>
>>>>>> пт, 21 июн. 2024 г. в 21:42, Fabio Estevam <festevam@gmail.com>:
>>>>>>>
>>>>>>> Hi Tim and Jerome,
>>>>>>>
>>>>>>> On Fri, Jun 21, 2024 at 1:08 PM Tim Harvey <tharvey@gateworks.com> wrote:
>>>>>>>
>>>>>>>> I tried your to-upstream/v5-wip branch
>>>>>>>> (042bea36eb9731079a3d7afffe3774d79e06ac5d) and it behaves the same. Do
>>>>>>>> you have something else to try/test?
>>>>>>>
>>>>>>> Yes, when I tested older versions from Maxim I could never get lwIP to
>>>>>>> work with i.MX.
>>>>>>>
>>>>>>> Jerome,
>>>>>>>
>>>>>>> Please try to run the lwIP series on any i.MX board, if possible.
>>>>>>>
>>>>>>> Thanks
>>>>>>
>>>>>> Packet not for us means that incoming packet DST MAC does not match to
>>>>>> the MAC address inside lwip. I.e. to MAC address set into lwip when
>>>>>> lwip_init was done. Original U-Boot network stack does not compare
>>>>>> MACs but lwip does. There is something specific on this board, in
>>>>>> general lwip with debug should print out
>>>>>> MAC used during initialization. This MAC should match to the MAC from
>>>>>> the incoming packet.
>>>>>>
>>>>>
>>>>> It seems 'packet not for us' can mean a lot of things.
>>>>
>>>> Yeah :-/ in this case I believe the traces are caused by unrelated traffic
>>>> (UDP port 138 is used by NetBIOS).
>>>>
>>>>
>>>>> I added a bit of debugging around 'DHCP packet accepted' and found I'm
>>>>> not receiving any packets from my DHCP server. So I connected directly
>>>>> to another board (isolated network) where I ran my own server and
>>>>> tcpdump and I don't see packets coming from lwip:
>>>>
>>>> Ha! That's interesting.
>>>>
>>>>> without lwip my server shows:
>>>>> # tcpdump -i eth1
>>>>> tcpdump: listening on eth1, link-type EN10MB (Ethernet), snapshot
>>>>> length 262144 bytes
>>>>> tcpdump: listening on eth1, link-type EN10MB (Ethernet), snapshot
>>>>> length 262144 bytes
>>>>> 22:18:01.043992 IP (tos 0x0, ttl 255, id 23, offset 0, flags [DF],
>>>>> proto UDP (17), length 328)
>>>>> 22:18:01.044391 IP (tos 0x10, ttl 128, id 0, offset 0, flags [none],
>>>>> proto UDP (17), length 328)
>>>>> 22:18:01.044454 IP (tos 0x0, ttl 255, id 24, offset 0, flags [DF],
>>>>> proto UDP (17), length 328)
>>>>> 22:18:01.044752 IP (tos 0x10, ttl 128, id 0, offset 0, flags [none],
>>>>> proto UDP (17), length 328)
>>>>>
>>>>> # tcpdump -i eth1
>>>>> tcpdump: listening on eth1, link-type EN10MB (Ethernet), snapshot
>>>>> length 262144 bytes
>>>>> 22:22:41.602178  [|llc]
>>>>> 22:22:41.709978  [|llc]
>>>>> 22:22:41.867947  [|llc]
>>>>> 22:22:42.105202  [|llc]
>>>>> 22:22:42.502091  [|llc]
>>>>> 22:22:43.219079  [|llc]
>>>>> 22:22:44.497979  [|llc]
>>>>> 22:22:45.776884  [|llc]
>>>>> 22:22:47.054773  [|llc]
>>>>> 22:22:48.333667  [|llc]
>>>>> 22:22:49.611559  [|llc]
>>>>> 22:22:50.890469  [|llc]
>>>>>
>>>>> What actual hardware has this been tested with? I think Tom mentioned
>>>>> he tested with an rpi of some sort.
>>>>
>>>> Yes, I believe he tested on RPi 3B  and me too. Ilias has tested on NVIDIA
>>>> Jetson Nano.
>>>>
>>>>> I don't know what the meaning of the llc msg is above but you can see
>>>>> there is no DHCP request.
>>>>
>>>> Some more tracing is needed. Can you try enabling all traces in
>>>> lib/lwip/u-boot/lwipopts.h? i.e., replace all LWIP_DBG_OFF with
>>>> LWIP_DBG_ON in the #if defined(CONFIG_LWIP_DEBUG) section. And of course
>>>> enabled CONFIG_LWIP_DEBUG.
>>>
>>> Here's what I see with all those enabled on an imx8mm-venice-gw73xx-0x:
>>> Net:   eth0: ethernet@30be0000 [PRIME]
>>> GSC     : boot watchdog disabled
>>> Thermal protection:enabled at 96C
>>> Hit any key to stop autoboot:  0
>>> u-boot=> dhcp || echo fail
>>> netif: added interface et IP addr 0.0.0.0 netmask 0.0.0.0 gw 0.0.0.0
>>> netif: setting default interface et
>>> dhcp_start(netif=00000000fdf23bb0) et0
>>> dhcp_start(): mallocing new DHCP client
>>> dhcp_start(): allocated dhcp
>>> dhcp_start(): starting DHCP configuration
>>> udp_bind(ipaddr = 0.0.0.0, port = 68)
>>> udp_bind: bound to 0.0.0.0, port 68)
>>> udp_connect: connected to 0.0.0.0, port 67)
>>> dhcp_discover()
>>> pbuf_alloc(length=308)
>>> pbuf_alloc(length=308) == 00000000fdf23d10
>>> transaction id xid(42021)
>>> dhcp_discover: making request
>>> dhcp_discover: sendto(DISCOVER, IP_ADDR_BROADCAST, LWIP_IANA_PORT_DHCP_SERVER)
>>> pbuf_add_header: old 00000000fdf23d5e new 00000000fdf23d56 (8)
>>> udp_send: added header in given pbuf 00000000fdf23d10
>>> udp_send: sending datagram of length 316
>>> udp_send: UDP packet length 316
>>> inet_chksum_pseudo(): checksumming pbuf 00000000fdf23d10 (has next
>>> 0000000000000000)
>>> inet_chksum_pseudo(): pbuf chain lwip_chksum()=807
>>> udp_send: UDP checksum 0xf7f8
>>> udp_send: ip_output_if (,,,,0x11,)
>>> pbuf_add_header: old 00000000fdf23d56 new 00000000fdf23d42 (20)
>>> ip4_output_if: et0
>>> IP header:
>>> +-------------------------------+
>>> | 4 | 5 |  0x00 |       336     | (v, hl, tos, len)
>>> +-------------------------------+
>>> |        0      |000|       0   | (id, flags, offset)
>>> +-------------------------------+
>>> |  255  |   17  |    0xba9d     | (ttl, proto, chksum)
>>> +-------------------------------+
>>> |    0  |    0  |    0  |    0  | (src)
>>> +-------------------------------+
>>> |  255  |  255  |  255  |  255  | (dest)
>>> +-------------------------------+
>>> ip4_output_if: call netif->output()
>>> pbuf_add_header: old 00000000fdf23d42 new 00000000fdf23d34 (14)
>>> ethernet_output: sending packet 00000000fdf23d10
>>> ^^^ at this point a 350 byte packet gets sent to fecmxc_send for the
>>> NIC which looks like this via print_hex_dump_bytes():
>>> 00000000: ff ff ff ff ff ff 00 d0 12 ba f8 cc 08 00 45 00  ..............E.
>>> 00000010: 01 50 00 00 00 00 ff 11 ba 9d 00 00 00 00 ff ff  .P..............
>>> 00000020: ff ff 00 44 00 43 01 3c f8 f7 01 01 06 00 00 04  ...D.C.<........
>>> 00000030: 20 21 00 00 00 00 00 00 00 00 00 00 00 00 00 00   !..............
>>> 00000040: 00 00 00 00 00 00 00 d0 12 ba f8 cc 00 00 00 00  ................
>>> 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>> 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>> 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>> 00000080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>> 00000090: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>> 000000a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>> 000000b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>> 000000c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>> 000000d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>> 000000e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>> 000000f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>> 00000100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>> 00000110: 00 00 00 00 00 00 63 82 53 63 35 01 01 39 02 05  ......c.Sc5..9..
>>> 00000120: dc 37 03 01 03 1c ff 00 00 00 00 00 00 00 00 00  .7..............
>>> 00000130: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>> 00000140: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>> 00000150: 00 00 00 00 00 00 00 00 00 00 00 00 00 00        ..............
>>
>> Up to this point everything *seems* OK
>>
>>> on my dhcp server 'tcpdump -i eth1 -X -vvv' shows:
>>> tcpdump: listening on eth1, link-type EN10MB (Ethernet), snapshot
>>> length 262144 bytes
>>> 15:34:25.341167  [|llc]
>>> 0x0000:  0000 0000 0000 0000 0000 343d f2fd 0000  ..........4=....
>>> 0x0010:  0000 5e01 5e01 8000 0100 0000 0000 0000  ..^.^...........
>>> 0x0020:  0000 0000 0000 ffff ffff ffff 00d0 12ba  ................
>>> 0x0030:  f8cc 0800 4500 0150 001e 0000 ff11 ba7f  ....E..P........
>>> 0x0040:  0000 0000 ffff ffff 0044 0043 013c 6d78  .........D.C.<mx
>>> 0x0050:  0101 0600 1255 994f 0000 0000 0000 0000  .....U.O........
>>> 0x0060:  0000 0000 0000 0000 0000 0000 00d0 12ba  ................
>>> 0x0070:  f8cc 0000 0000 0000 0000 0000 0000 0000  ................
>>> 0x0080:  0000 0000 0000 0000 0000 0000 0000 0000  ................
>>> 0x0090:  0000 0000 0000 0000 0000 0000 0000 0000  ................
>>> 0x00a0:  0000 0000 0000 0000 0000 0000 0000 0000  ................
>>> 0x00b0:  0000 0000 0000 0000 0000 0000 0000 0000  ................
>>> 0x00c0:  0000 0000 0000 0000 0000 0000 0000 0000  ................
>>> 0x00d0:  0000 0000 0000 0000 0000 0000 0000 0000  ................
>>> 0x00e0:  0000 0000 0000 0000 0000 0000 0000 0000  ................
>>> 0x00f0:  0000 0000 0000 0000 0000 0000 0000 0000  ................
>>> 0x0100:  0000 0000 0000 0000 0000 0000 0000 0000  ................
>>> 0x0110:  0000 0000 0000 0000 0000 0000 0000 0000  ................
>>> 0x0120:  0000 0000 0000 0000 0000 0000 0000 0000  ................
>>> 0x0130:  0000 0000 0000 0000 0000 0000 6382 5363  ............c.Sc
>>> 0x0140:  3501 0139 0205 dc37 0301 031c ff00 0000  5..9...7........
>>
>> But here it shows the DHCP packet is not received.
>>
>>> Comparing to w/o LWIP:
>>> u-boot=> dhcp || echo fail
>>> BOOTP broadcast 1
>>> fecmxc_send ethernet@30be0000 342
>>> 00000000: ff ff ff ff ff ff 00 d0 12 ba f8 cc 08 00 45 00  ..............E.
>>> 00000010: 01 48 00 00 40 00 ff 11 7a a5 00 00 00 00 ff ff  .H..@...z.......
>>> 00000020: ff ff 00 44 00 43 01 34 00 00 01 01 06 00 12 bb  ...D.C.4........
>>> 00000030: 82 64 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .d..............
>>> 00000040: 00 00 00 00 00 00 00 d0 12 ba f8 cc 00 00 00 00  ................
>>> 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>> 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>> 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>> 00000080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>> 00000090: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>> 000000a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>> 000000b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>> 000000c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>> 000000d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>> 000000e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>> 000000f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>> 00000100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>> 00000110: 00 00 00 00 00 00 63 82 53 63 35 01 01 39 02 02  ......c.Sc5..9..
>>> 00000120: 40 5d 02 00 16 5e 03 01 00 00 3c 0c 55 2d 42 6f  @]...^....<.U-Bo
>>> 00000130: 6f 74 2e 61 72 6d 76 38 37 05 01 03 06 0c 11 ff  ot.armv87.......
>>> 00000140: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>> 00000150: 00 00 00 00 00 00                                ......
>>> ^^^ Note the packet is 8 bytes shorter
>>
>> Yes but that's just padding IIUC.
>>
>>> and on the dhcp server:
>>> tcpdump: listening on eth1, link-type EN10MB (Ethernet), snapshot
>>> length 262144 bytes
>>> 15:45:12.548077 IP (tos 0x0, ttl 255, id 0, offset 0, flags [DF],
>>> proto UDP (17), length 328)
>>>     0.0.0.0.bootpc > 255.255.255.255.bootps: [no cksum] BOOTP/DHCP,
>>> Request from 00:d0:12:ba:f8:cc (oui Unknown), length 300, xid
>>> 0x12bb8264, Flags [none] (0x0000)
>>>   Client-Ethernet-Address 00:d0:12:ba:f8:cc (oui Unknown)
>>>   Vendor-rfc1048 Extensions
>>>     Magic Cookie 0x63825363
>>>     DHCP-Message (53), length 1: Discover
>>>     MSZ (57), length 2: 576
>>>     ARCH (93), length 2: 22
>>>     NDI (94), length 3: 1.0.0
>>>     Vendor-Class (60), length 12: "U-Boot.armv8"
>>>     Parameter-Request (55), length 5:
>>>       Subnet-Mask (1), Default-Gateway (3), Domain-Name-Server (6),
>>> Hostname (12)
>>>       RP (17)
>>>     END (255), length 0
>>>     PAD (0), length 0, occurs 22
>>> 0x0000:  4500 0148 0000 4000 ff11 7aa5 0000 0000  E..H..@...z.....
>>> 0x0010:  ffff ffff 0044 0043 0134 0000 0101 0600  .....D.C.4......
>>> 0x0020:  12bb 8264 0000 0000 0000 0000 0000 0000  ...d............
>>> 0x0030:  0000 0000 0000 0000 00d0 12ba f8cc 0000  ................
>>> 0x0040:  0000 0000 0000 0000 0000 0000 0000 0000  ................
>>> 0x0050:  0000 0000 0000 0000 0000 0000 0000 0000  ................
>>> 0x0060:  0000 0000 0000 0000 0000 0000 0000 0000  ................
>>> 0x0070:  0000 0000 0000 0000 0000 0000 0000 0000  ................
>>> 0x0080:  0000 0000 0000 0000 0000 0000 0000 0000  ................
>>> 0x0090:  0000 0000 0000 0000 0000 0000 0000 0000  ................
>>> 0x00a0:  0000 0000 0000 0000 0000 0000 0000 0000  ................
>>> 0x00b0:  0000 0000 0000 0000 0000 0000 0000 0000  ................
>>> 0x00c0:  0000 0000 0000 0000 0000 0000 0000 0000  ................
>>> 0x00d0:  0000 0000 0000 0000 0000 0000 0000 0000  ................
>>> 0x00e0:  0000 0000 0000 0000 0000 0000 0000 0000  ................
>>> 0x00f0:  0000 0000 0000 0000 0000 0000 0000 0000  ................
>>> 0x0100:  0000 0000 0000 0000 6382 5363 3501 0139  ........c.Sc5..9
>>> 0x0110:  0202 405d 0200 165e 0301 0000 3c0c 552d  ..@]...^....<.U-
>>> 0x0120:  426f 6f74 2e61 726d 7638 3705 0103 060c  Boot.armv87.....
>>> 0x0130:  11ff 0000 0000 0000 0000 0000 0000 0000  ................
>>> 0x0140:  0000 0000 0000 0000                      ........
>>
>> All good there, as expected.
>>
>>>> I do have a i.MX8M Plus EVK board but will not be able to use it before
>>>> tomorrow.
>>>
>>> Please let me know your findings. I can test imx8mp as well but would
>>> have to reconfigure everything.
>>
>> So I did some tests on my imx8mp and I got DHCP to work on the second
>> ethernet port (ENET2) but *not* on the first one (ENET1). They appear to
>> be using different drivers (drivers/net/fec_mxc.c for ENET1 and
>> drivers/net/dwc_eth_qos.c for ENET2). No matter what I do, there is no
>> packet going out of ENET1.
>>
>> With a network cable plugged into ENET2 (ethernet@30bf0000):
>>
>> ...
>> Net:   eth0: ethernet@30be0000, eth1: ethernet@30bf0000 [PRIME]
>> Hit any key to stop autoboot:  0
>> u-boot=>
>> u-boot=> dhcp
>> ethernet@30bf0000 Waiting for PHY auto negotiation to complete....... done
>> DHCP client bound to address 192.168.0.39 (2066 ms)
>> u-boot=>
>>
>> Now moving the cable to ENET1 (ethernet@30be0000) and resetting the board:
>>
>> ...
>> Net:   eth0: ethernet@30be0000, eth1: ethernet@30bf0000 [PRIME]
>> Hit any key to stop autoboot:  0
>> u-boot=>
>> u-boot=> setenv ethact ethernet@30be0000
>> u-boot=> dhcp
>> u-boot=> echo $?
>> 1
>>
>> I enabled the debug traces in fecmxc_send() but I see nothing wrong,
>> the function is called with a packet and it returns success yet nothing
>> is sent out on the wire. Any idea what could be wrong?
>> My plan is to add more traces to the driver and compare NET vs. NET_LWIP.
>>
> 
> Jerome,
> 
> That is consistent with what I see then. The imx8mm (and all imx all
> the way back to imx28) use the FEC ethernet MAC so I would assume you
> see the issue on all of those SOC's. The imx8mp introduced a 2nd
> different MAC, the eqos which you are showing working.
> 
> If you look at my results above a packet 'is' received by the DHCP
> server but its missing something where tcpdump shows an '[|llc]' and I
> don't know what that means - something wrong with the link layer?
> 
> I feel like something is wrong in the header or packet alignment.

Good catch :) Here is a quick workaroud that works for me:

diff --git a/drivers/net/fec_mxc.c b/drivers/net/fec_mxc.c
index 2dc1364beec..85bf1a2b52e 100644
--- a/drivers/net/fec_mxc.c
+++ b/drivers/net/fec_mxc.c
@@ -658,7 +658,7 @@ static void fecmxc_halt(struct udevice *dev)
  * @param[in] length Data count in bytes
  * Return: 0 on success
  */
-static int fecmxc_send(struct udevice *dev, void *packet, int length)
+static int fecmxc_send_(struct udevice *dev, void *packet, int length)
 {
 	unsigned int status;
 	u32 size;
@@ -796,6 +796,21 @@ out:
 	return ret;
 }
 
+static int fecmxc_send(struct udevice *dev, void *packet, int length)
+{
+	void *pp;
+	int ret;
+
+	pp = memalign(64, length);
+	if (!pp)
+		return -ENOMEM;
+	memcpy(pp, packet, length);
+	ret = fecmxc_send_(dev, pp, length);
+	free(pp);
+
+	return ret;
+}
+
 /**
  * Pull one frame from the card
  * @param[in] dev Our ethernet device to handle


I believe the root of the problem is that lwIP uses malloc() to allocate
the outgoing packets and doesn't enforce any alignement. I need to
revisit that wrt. PKTALIGN.

Thanks,
-- 
Jerome


> Maybe the key is to understand what the tcpdump output of '[llc]'
> means:
> - lwip fec mac destination tcpdump shows '15:34:25.341167  [|llc]'
> - no-lwip fec mac destination tcptdump shows '15:45:12.548077 IP (tos
> 0x0, ttl 255, id 0, offset 0, flags [DF], proto UDP (17), length 328)
> 
> (Adding Joe and Ramon, the network maintainers to cc)
> 
> Regards,
> 
> Tim
