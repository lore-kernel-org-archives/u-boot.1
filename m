Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 443E5C2BBCA
	for <u-boot@archiver.kernel.org>; Tue, 25 Jun 2024 08:02:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACB0F881C6;
	Tue, 25 Jun 2024 10:02:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SHCiSHiS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A26F881C6; Tue, 25 Jun 2024 10:02:51 +0200 (CEST)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A089809A8
 for <u-boot@lists.denx.de>; Tue, 25 Jun 2024 10:02:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2ec1ac1aed2so63205751fa.3
 for <u-boot@lists.denx.de>; Tue, 25 Jun 2024 01:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719302568; x=1719907368; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=whFwOz9MgLNc6WEQ/IlbR1VeIIS4nklorO/j8muWJ2A=;
 b=SHCiSHiS/KI860v5TtTxkeLxB1yGYbbAFLt7OoFVP55QM2Pdzu+gLfk1RWjHE+olSc
 vLa3en/3FXbfwbzjEwuTRqoyL5AvaduDT8gr0APIsxXJtHPyk9N+TBDqBMDLWyeQ66oG
 YuNJ2SKqCL/PPeB32SKvsi5RK3S3EEpHUq1QsHvweYY8litDKviRyOgBOMgJm1g26W71
 9iQLhlqcnlph9XnRB3zqaMcLnhOiwJkZptmjAHVVVwyIUpAmyLj69eFMi8ojsg1IAxs4
 Wf+K+RfEmGal98MIiYB6h/KekHkQD9LoXAM2W8nDmdm1A0VFe3DILJxiWaIggoBrtDmp
 /kew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719302568; x=1719907368;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=whFwOz9MgLNc6WEQ/IlbR1VeIIS4nklorO/j8muWJ2A=;
 b=MivrCxknP+Ij7dslNIKMwUhiSoKvI3X6ad864ttRWKN5Pt9pMEBsXeasb1Y5/Gp4qI
 AvUhvtGpspUipe851RlXEwfvgbbx9/V4ZR+QR1CR+qDwRKeWNXp/S+JQhlTCkRsnZR1z
 4JS9JSFvvT0kNRBNZ8kW+ajGCcKQGaPoRREnfkjGym7vIYdPD0tX/SxuuM9RNotrJ8zA
 +8buGjhRmnI+lhguSEJNwf9NnDeCh9NlRKMiKZRNIbwKz7/PO759xOZPx6j1HeL1kfLn
 rcMmTQH6Kg+VncuIR31fdNxdKdQ4uGhZK7NTmakADt51aCX6zhW5ROV9z1c1Nqx2QyCB
 K4Og==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrpK4gc2ERi29fe6I9lV1kxXdxdPDRvpPRNfVBIUhxrel+/R5T1LizWnRHlm6n04wRdDxyESKHDexaI6TNAZV+QIIUSg==
X-Gm-Message-State: AOJu0Yy/mbnM2oOi8s68suE8M8whaWjXyRntvaf2kzPMpfl2nBXyapNH
 hBr9UYZIbgdZo70QL8d3TiKrzphvliGKcnzMTsfJ6bVUmK4SOInZmXfr8/MNcxY=
X-Google-Smtp-Source: AGHT+IF8NSuVQLaDEAl2sSnnb9akpjuiDcFL82uzjQqdwuiOOC7LmfiA+Ol65mB5HGbYvajYcpQZng==
X-Received: by 2002:a2e:95ce:0:b0:2eb:e840:4a1b with SMTP id
 38308e7fff4ca-2ec5b283b3bmr38806751fa.7.1719302568474; 
 Tue, 25 Jun 2024 01:02:48 -0700 (PDT)
Received: from [192.168.7.95] (679773502.box.freepro.com. [212.114.21.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36638d9c1d1sm12170243f8f.51.2024.06.25.01.02.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Jun 2024 01:02:48 -0700 (PDT)
Message-ID: <126507ff-2309-4147-bea6-1c4398baeeb8@linaro.org>
Date: Tue, 25 Jun 2024 10:02:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/14] Introduce the lwIP network stack
To: Tim Harvey <tharvey@gateworks.com>, Maxim Uvarov <muvarov@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>
References: <cover.1718638104.git.jerome.forissier@linaro.org>
 <CAJ+vNU0yGH6FKZsx+UZXvnQnsT13U9iKUb68=Fqc_z7J0XL14w@mail.gmail.com>
 <0db93742-f8d3-45b6-9d1e-e4f687c2d81a@linaro.org>
 <CAJ+vNU3ECDoquHLyA3ULac0HkUGbzggG-bDQ8v0F2vStyr47gQ@mail.gmail.com>
 <CAOMZO5A4MS9eZe24WBSu4omfhjmwtjM72ftdQBwDWGd1wFiLmw@mail.gmail.com>
 <CAJGZr0LCGaKN_G54HMOmQx8y7cuER_OLGP6Axf2ksUQLhoSF8Q@mail.gmail.com>
 <CAJ+vNU2X7n0VQjP0EZ7NpyVM-fKiqWQ7xL=MKGa3xQa+d4YXrA@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAJ+vNU2X7n0VQjP0EZ7NpyVM-fKiqWQ7xL=MKGa3xQa+d4YXrA@mail.gmail.com>
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

On 6/25/24 00:28, Tim Harvey wrote:
> On Sat, Jun 22, 2024 at 1:09 AM Maxim Uvarov <muvarov@gmail.com> wrote:
>>
>> пт, 21 июн. 2024 г. в 21:42, Fabio Estevam <festevam@gmail.com>:
>>>
>>> Hi Tim and Jerome,
>>>
>>> On Fri, Jun 21, 2024 at 1:08 PM Tim Harvey <tharvey@gateworks.com> wrote:
>>>
>>>> I tried your to-upstream/v5-wip branch
>>>> (042bea36eb9731079a3d7afffe3774d79e06ac5d) and it behaves the same. Do
>>>> you have something else to try/test?
>>>
>>> Yes, when I tested older versions from Maxim I could never get lwIP to
>>> work with i.MX.
>>>
>>> Jerome,
>>>
>>> Please try to run the lwIP series on any i.MX board, if possible.
>>>
>>> Thanks
>>
>> Packet not for us means that incoming packet DST MAC does not match to
>> the MAC address inside lwip. I.e. to MAC address set into lwip when
>> lwip_init was done. Original U-Boot network stack does not compare
>> MACs but lwip does. There is something specific on this board, in
>> general lwip with debug should print out
>> MAC used during initialization. This MAC should match to the MAC from
>> the incoming packet.
>>
> 
> It seems 'packet not for us' can mean a lot of things.

Yeah :-/ in this case I believe the traces are caused by unrelated traffic
(UDP port 138 is used by NetBIOS).


> I added a bit of debugging around 'DHCP packet accepted' and found I'm
> not receiving any packets from my DHCP server. So I connected directly
> to another board (isolated network) where I ran my own server and
> tcpdump and I don't see packets coming from lwip:

Ha! That's interesting.

> without lwip my server shows:
> # tcpdump -i eth1
> tcpdump: listening on eth1, link-type EN10MB (Ethernet), snapshot
> length 262144 bytes
> tcpdump: listening on eth1, link-type EN10MB (Ethernet), snapshot
> length 262144 bytes
> 22:18:01.043992 IP (tos 0x0, ttl 255, id 23, offset 0, flags [DF],
> proto UDP (17), length 328)
> 22:18:01.044391 IP (tos 0x10, ttl 128, id 0, offset 0, flags [none],
> proto UDP (17), length 328)
> 22:18:01.044454 IP (tos 0x0, ttl 255, id 24, offset 0, flags [DF],
> proto UDP (17), length 328)
> 22:18:01.044752 IP (tos 0x10, ttl 128, id 0, offset 0, flags [none],
> proto UDP (17), length 328)
> 
> # tcpdump -i eth1
> tcpdump: listening on eth1, link-type EN10MB (Ethernet), snapshot
> length 262144 bytes
> 22:22:41.602178  [|llc]
> 22:22:41.709978  [|llc]
> 22:22:41.867947  [|llc]
> 22:22:42.105202  [|llc]
> 22:22:42.502091  [|llc]
> 22:22:43.219079  [|llc]
> 22:22:44.497979  [|llc]
> 22:22:45.776884  [|llc]
> 22:22:47.054773  [|llc]
> 22:22:48.333667  [|llc]
> 22:22:49.611559  [|llc]
> 22:22:50.890469  [|llc]
> 
> What actual hardware has this been tested with? I think Tom mentioned
> he tested with an rpi of some sort.

Yes, I believe he tested on RPi 3B  and me too. Ilias has tested on NVIDIA
Jetson Nano.
 
> I don't know what the meaning of the llc msg is above but you can see
> there is no DHCP request.

Some more tracing is needed. Can you try enabling all traces in
lib/lwip/u-boot/lwipopts.h? i.e., replace all LWIP_DBG_OFF with
LWIP_DBG_ON in the #if defined(CONFIG_LWIP_DEBUG) section. And of course
enabled CONFIG_LWIP_DEBUG.
I do have a i.MX8M Plus EVK board but will not be able to use it before
tomorrow.

Thanks,
-- 
Jerome
