Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46AF6C3ABB2
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 12:24:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82A1E8393F;
	Wed, 28 May 2025 14:24:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZGZExNDx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 323F38394F; Wed, 28 May 2025 14:24:16 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BAA483923
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 14:24:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a376ba6f08so2861981f8f.1
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 05:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748435052; x=1749039852; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Xiabt2mYXQ+2ib7a+5gCYULrnag1U9LAFFfDHgYmKzk=;
 b=ZGZExNDxrysnBWL4FaaH4RvXjE7o/Cq+Us6UUSeSdZqcH7W8mkNvX4XiIGt8tqADei
 jQP7nlEVt982VzHuPam1DAnEqgp2vRYIt1GuP5BS0hDrGDSBGikN30qCYewVm4XoCcvA
 MufmKoirkm4kmQEKTq/M0046wkkL8WqCcMadaDm5WU+JnaGaAG5Zm/7stT577J49O7bt
 ZCn5rqR9c9qmutRk2UUbjKBdJ2N5UdmKjs+ocFqLt4SZG+fXHTifrEXxIruBDcql46kn
 CRS6316fz8T5akd0+4Zww+ZHrQpDe2SpFdl0ZUvlzxz2prWcrThS/STLd9EbwwavWrL+
 UFPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748435052; x=1749039852;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Xiabt2mYXQ+2ib7a+5gCYULrnag1U9LAFFfDHgYmKzk=;
 b=hrgt5LWZDQVqzsHaTw1CROn2qk2INpfEAW08Fr7IHnI6ahHvV+yUcXD64Vwzyv37CL
 RS4+Vt3R/g5RJysQPOvs77prjVs+TSlSM1mPZPTmvK+5Jv3Y1ZpswaBIIvaQYHe5Dpce
 ZhNTEytCUS91xMSSXYB24tk9DgYQIf9BweNrjqSDfAgGnqmT01unI2LRN3UDldumdzhz
 00ykinhSH1N3Kj0Uf72jr8/7txllc2ulByhg+9sz0tTUnT3KMIqm4vhrkCgGGepAr8Uh
 8PFDeUrawoVMm+YFVWMddaR3vfMy+fpY77FwtzlYZE6YSAQg2s/F4+M92CUxbmz+7BLF
 EvnQ==
X-Gm-Message-State: AOJu0YyPUeTJ5uDmB0d0N4P63x+4O99a4vBG9vqISgsQtQAAFKsCeL0n
 HZ7pi73iHhBdwZkH+aHF8ZS8OZabJjv0VdZa9dOkl/gI7gaCIFlnNZxZ/Dn9AmBNlNyLl1bvu+b
 amy7hR8M=
X-Gm-Gg: ASbGncsnyQ9JA0Rc8sbTX8ZzMllkISkeubgJLd5yooQvrV8bxF1e2ecgFGJ8EnGwSPd
 4YcNVU6W/Lzn4PTl3cGTuYbDHyOXazwAAxsbooat8XKEQM430zF2NW9HxVw7/2C3b9qKW660ftu
 APN+bVU+n+B2iq+/WXA9P+/S5EmyZawlkZOzafQ6f7AseWwcgenQLqGhYfBz3/vQ7mJ+skulWDh
 akhC4a3vFrpxOdMS+W2a//c+221ie5MclMNOoUHzfRtVm7EH2mymMpPuFtFI41h3WEwCvOE19UL
 QM+pGA8dnxe6li0Hw0ViKq8TwD1y01PdVcXrYVv6/+0B+6nJiMyGGJ9E038f60yH2vJ9YS6xQEM
 /5K1lwxKHf9qoPLRu5Es61agOeso4
X-Google-Smtp-Source: AGHT+IE98PRgGFj5gaKvVwwmaVJfagQuuCjH9tP7Th0sTX1Pzr62zaughy6Sp/0WWn4u0yUqc6JD+Q==
X-Received: by 2002:a05:6000:18ae:b0:3a3:6b0c:a8a3 with SMTP id
 ffacd0b85a97d-3a4cb45448amr14162592f8f.17.1748435052132; 
 Wed, 28 May 2025 05:24:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:447d:d693:d6e:d842?
 ([2a01:e0a:3cb:7bb0:447d:d693:d6e:d842])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4eacd78fesm1336312f8f.72.2025.05.28.05.24.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 May 2025 05:24:11 -0700 (PDT)
Message-ID: <ebb48519-a02b-4b06-a801-f9c05fccd428@linaro.org>
Date: Wed, 28 May 2025 14:24:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: lwip tftp not working on imx8mm
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot <u-boot@lists.denx.de>, Fabio Estevam <festevam@gmail.com>
References: <CAJ+vNU3H1vjbvyZTycBQhufii5SqyTnk4AaMRk_ztGY10g9joQ@mail.gmail.com>
 <6e667ef9-9fa0-441b-8520-46e7bdbc344a@linaro.org>
 <CAJ+vNU0kY=iNR6Q3PR6+x=wqv2932=1E+Ci0CwvURCPh6JD5-A@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAJ+vNU0kY=iNR6Q3PR6+x=wqv2932=1E+Ci0CwvURCPh6JD5-A@mail.gmail.com>
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



On 5/27/25 18:35, Tim Harvey wrote:
> On Mon, May 26, 2025 at 5:17 AM Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
>>
>> Hi Tim,
>>
>> On 5/23/25 20:31, Tim Harvey wrote:
>>> Hi Jerome,
>>>
>>> I've enabled LWIP on imx8mm_venice to see how it's doing and while
>>> dhcp/dns/ping/wget appear to work great, tftp is broken.
>>>
>>> Enabling LWIP_DEBUG shows the following:
>>> ip4_input: packet accepted on interface et
>>> IP packet dropped since it was fragmented (0x2000) (while IP_REASSEMBLY == 0).
>>
>> Hmmmmm IP_REASSEMBLY should probably default to 1.
>>>
>>> I tried enabling IP_REASSEMBLY in lwip but that seems to change the issue to:
>>> ip4_input: packet accepted on interface et
>>> ip4_input:
>>> IP header:
>>> +-------------------------------+
>>> | 4 | 5 |  0xc0 |       108     | (v, hl, tos, len)
>>> +-------------------------------+
>>> |    10568      |000|       0   | (id, flags, offset)
>>> +-------------------------------+
>>> |   64  |    1  |    0xe25b     | (ttl, proto, chksum)
>>> +-------------------------------+
>>> |  172  |   24  |    0  |    2  | (src)
>>> +-------------------------------+
>>> |  172  |   24  |   21  |  251  | (dest)
>>> +-------------------------------+
>>> ip4_input: p->len 108 p->tot_len 108
>>> Unsupported transport protocol 1
>>>
>>> Any ideas what the issue is here?
>>
>> Not really :-/ Does the transfer work with a smaller block size?
>> (CONFIG_TFTP_BLOCKSIZE, default 1468, try 500 for instance). You could
>> also enable CONFIG_LWIP_DEBUG_RXTX in order to get a full hex dump of
>> the messages going into/out of the lwIP stack.
> 
> Hi Jerome,
> 
> My config was with 4096, setting it to 1468 works and anything above
> that seems to cause this failure.

Good to know.
 
> Some sort of fragmentation issue?

Quite possibly, yes. In any case it does not make much sense to use a
clock size that causes the packet to be larger than the PMTU (it would
be sub-optimal) but it should definitely work, especially since I don't
believe PMTU discovery is implemented in lwIP. I add this to my to-do
list but feel free to investigate further :)

Thanks,
-- 
Jerome
> 
> Best Regards,
> 
> Tim
