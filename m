Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB96C52D6F
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 09:04:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 865D588B2D;
	Wed, 21 Aug 2024 11:04:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="n2lgmQ1F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FB6788B52; Wed, 21 Aug 2024 11:04:41 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E746488859
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 11:04:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5befe420fc2so3883054a12.3
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 02:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724231078; x=1724835878; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Furhfl79LUuMzq3QQbLTTsFs1UckIW95QzbJTjgo6eg=;
 b=n2lgmQ1F6ICiEnWGkE/xb/g8mDFGv1ZrOq10rrTRGvyfNDmihjopXw2mD2CYIqLv8G
 PPevHX5yyKgCnPB2TiI5oUjh1CleuQza2bgPniNLhi+Ql/awSQMFczP0vYWjG6+319UX
 blLRR60jDeqtthgM+F3IQMih7gFrIsHl6bu+l0tkrVTpXZN873netYU9b3/cFHaj2wF8
 XGzUHMVA+9keDoJKqO7I648abJBAi/nrk498lMt5717uEZaLeP10QIT2yQvcb2hyFDeM
 814VF7svvA1Az6r9VFxQUTZGrjlTshogeGpqJdI7YPHVu8WgczsEK/2lvWcxjUOogxkx
 K09Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724231078; x=1724835878;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Furhfl79LUuMzq3QQbLTTsFs1UckIW95QzbJTjgo6eg=;
 b=ecUcTDDf0wZ3M7Su5DmP+1F4hvIrJQcnnbt2BOugUVxjTFdTRU2HiGsXmdTSpu4S+E
 qZG+noGUcP7YoNW01x34gx6rq80Z0FMAPdYblgKEtGLCVsy4NZzoB7O5db5itdfk+fAz
 rCzTaaoc0Fpk1JHyzJIbDk0mxZxRxTDbQ/04IaBsxhcW2iSqXL6Sy6xmPjERLwmOEbW1
 udaXMwTgVtr+Y/i2DJIP9u0YjOolm8JjePjTWT0GyY/kFJt1GE7BAK1J1SA7MLc9ZQkR
 IKZN2HqcktlDR0km0vUxkgQ2jnvM4yZuV4OumsxFyiOC9wzvdB/ws15OsJjLE0MvZTO2
 18oA==
X-Gm-Message-State: AOJu0YzyvyNLw3E6LS6SjTqOiMhqNEsfUWiJGcxWI5aX2NXcLSaVLBfR
 y+XMJRrUKvQc7o6dL/vVJ5VDcNnPndQF+2eVgsfd9+RUSAmucdB/hgVrPTp2Au4=
X-Google-Smtp-Source: AGHT+IEU3F9cvqjajlEqij0Nxf1iV+q1lDjurs9KFMs88ExNXRHed4QoGp/ws3SECN+JNR1z6+WoKQ==
X-Received: by 2002:a17:906:4fcd:b0:a6f:4f2c:1936 with SMTP id
 a640c23a62f3a-a866f8ef598mr76116766b.44.1724231078043; 
 Wed, 21 Aug 2024 02:04:38 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:913b:e313:d80a:1316?
 ([2a01:e0a:3cb:7bb0:913b:e313:d80a:1316])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a83839471ecsm873073666b.156.2024.08.21.02.04.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Aug 2024 02:04:36 -0700 (PDT)
Message-ID: <6c4cd266-dfec-455b-ab10-79763f246e9b@linaro.org>
Date: Wed, 21 Aug 2024 11:04:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@linaro.org>
Subject: Re: [PATCH v8 00/23] Introduce the lwIP network stack
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>
References: <cover.1723050310.git.jerome.forissier@linaro.org>
 <20240807204400.GJ1626301@bill-the-cat>
 <d9fe273b-ab60-44eb-bef8-cbde3af8ab1b@linaro.org>
 <20240816184019.GD1626301@bill-the-cat>
 <7bf0ed1a-96f8-4970-a06d-7a572774b263@linaro.org>
 <20240819220844.GI1626301@bill-the-cat>
Content-Language: en-US
In-Reply-To: <20240819220844.GI1626301@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 8/20/24 00:08, Tom Rini wrote:
> On Mon, Aug 19, 2024 at 04:53:51PM +0200, Jerome Forissier wrote:
>>
>>
>> On 8/16/24 20:40, Tom Rini wrote:
>>> On Fri, Aug 16, 2024 at 06:21:24PM +0200, Jerome Forissier wrote:
>>>>
>>>>
>>>> On 8/7/24 22:44, Tom Rini wrote:
>>>>> On Wed, Aug 07, 2024 at 07:11:44PM +0200, Jerome Forissier wrote:
>>>>>
>>>>>> This is a rework of a patch series by Maxim Uvarov: "net/lwip: add lwip
>>>>>> library for the network stack" [1]. The goal is to introduce the lwIP TCP/IP
>>>>>> stack [2] [3] as an alternative to the current implementation in net/,
>>>>>> selectable with Kconfig, and ultimately keep only lwIP if possible. Some
>>>>>> reasons for doing so are:
>>>>>> - Make the support of HTTPS in the wget command easier. Javier T. and
>>>>>> Raymond M. (CC'd) have some additional lwIP and Mbed TLS patches to do
>>>>>> so. With that it becomes possible to fetch and launch a distro installer
>>>>>> such as Debian etc. using a secure, authenticated connection directly
>>>>>> from the U-Boot shell. Several use cases:
>>>>>>   * Authentication: prevent MITM attack (third party replacing the
>>>>>> binary with a different one)
>>>>>>   * Confidentiality: prevent third parties from grabbing a copy of the
>>>>>> image as it is being downloaded
>>>>>>   * Allow connection to servers that do not support plain HTTP anymore
>>>>>> (this is becoming more and more common on the Internet these days)
>>>>>> - Possibly benefit from additional features implemented in lwIP
>>>>>> - Less code to maintain in U-Boot
>>>>>>
>>>>>> Prior to applying this series, the lwIP stack needs to be added as a
>>>>>> Git subtree with the following command:
>>>>>>
>>>>>>  $  git subtree add --squash --prefix lib/lwip/lwip https://git.savannah.gnu.org/git/lwip.git STABLE-2_2_0_RELEASE
>>>>>
>>>>> For v9, I think it would be good to do a CI run with NET_LWIP default
>>>>> and seeing what fails from that too. There's a few problems still
>>>>> leading to a lot of failures, in that case. Thanks.
>>>>>
>>>>
>>>> See here: https://github.com/u-boot/u-boot/pull/635
>>>>
>>>> I fixed a number of issues, see the commit descriptions. As for the
>>>> remaining ones:
>>>> - There is no http server in the CI so the wget test I added fails
>>>
>>> Ah yes. So the test needs some enable-me type flag, like other tests
>>> that require external configuration.
>>
>> Can you please suggest how to do that?
> 
> Well test/py/tests/test_net_boot.py for example.

Thanks. I'm adding a skip variable for v9.

>>>> - tftp is super slow in QEMU (~145 KiB/s) which causes timeouts. This is
>>>> for two reasons: (1) the tftp windowsize option is not supported in lwIP
>>>> (while the legacy NET does support it) so the sender waits for an ACK
>>>> before sending a new packet; and (2) the latency is very high due to
>>>> memcpy() being incredibly slow in QEMU (I am mainly referring to the
>>>> memcpy() call in tftp_write() in net/lwip/tftp.c). I measured ~20-60 ms
>>>> to copy a few hundred bytes (!) and if CONFIG_USE_ARCH_MEMCPY is enabled
>>>> it is slightly better but not much (~15 ms). Also it seems the QEMU
>>>> networking emulation is fragmenting the UDP packets because with
>>>> CONFIG_TFTP_BLOCKSIZE=1468 the tftp_write() function never receives
>>>> 1468 bytes but only a few hundreds at a time (max 544 bytes).
>>>
>>> I thought you fixed that? Or was that only for on real hardware?
>>
>> It works OK on real hardware...
> 
> It should be fast enough here too.
> 
>>> But also, some of those numbers sound unusually terrible to me. We can
>>> get some bad luck with the free instances, but, still.  Are you sure
>>> there's nothing else going on?
>>
>> ...and yes that's absolutely terrible. In fact I found something curious.
>> With the following patch applied to provide a memcpy() speed test:
>>
>> diff --git a/cmd/test.c b/cmd/test.c
>> index b4c3eabf9f6..35b8d62af61 100644
>> --- a/cmd/test.c
>> +++ b/cmd/test.c
>> @@ -7,6 +7,8 @@
>>  #include <command.h>
>>  #include <fs.h>
>>  #include <log.h>
>> +#include <stdlib.h>
>> +#include <time.h>
>>  #include <vsprintf.h>
>>  
>>  #define OP_INVALID	0
>> @@ -215,3 +217,49 @@ U_BOOT_CMD(
>>  	"do nothing, successfully",
>>  	NULL
>>  );
>> +
>> +static int do_mtest(struct cmd_tbl *cmdtp, int flag, int argc,
>> +		    char *const argv[])
>> +{
>> +	ulong t0, delta;
>> +	void *src, *dst;
>> +	long sz;
>> +
>> +	if (argc < 2) {
>> +		printf("Usage: %s <size_in_bytes> [dst [src]]\n", argv[0]);
>> +		return 1;
>> +	}
>> +	sz = simple_strtol(argv[1], NULL, 10);
>> +	if (sz < 0) {
>> +		printf("%s: %s: invalid argument\n", argv[0], argv[1]);
>> +		return 1;
>> +	}
>> +	if (argc > 2) {
>> +		dst = (void *)hextoul(argv[2], NULL);
>> +		if (argc > 3) {
>> +			src = (void *)hextoul(argv[3], NULL);
>> +		} else {
>> +			src = malloc(sz);
>> +		}
>> +	} else {
>> +		dst = malloc(sz);
>> +		src = malloc(sz);
>> +	}
>> +	if (!src || !dst) {
>> +		printf("%s: out of memory or NULL address\n", argv[0]);
>> +		return 1;
>> +	}
>> +	printf("%ld bytes from 0x%p to 0x%p: ", sz, src, dst);
>> +	t0 = get_timer(0);
>> +	memcpy(dst, src, sz);
>> +	delta = get_timer(t0);
>> +	printf("%ld ms\n", delta);
>> +
>> +	return 0;
>> +}
>> +
>> +U_BOOT_CMD(
>> +	mtest,	CONFIG_SYS_MAXARGS,	0,	do_mtest,
>> +	"memcpy() speed test",
>> +	NULL
>> +);
>>
>> I can see that there are ranges of memory that are very slow to *write*
>> to (and the loadaddr used by the tftp test happens to fall in that
>> range):
>>
>> $ make qemu_arm64_defconfig
>> $ make -j$(nproc) CROSS_COMPILE="ccache aarch64-linux-gnu-"
>> $ qemu-system-aarch64 -M virt -nographic -cpu cortex-a57 -bios u-boot.bin
>>
>> U-Boot 2024.10-rc1-00195-g35ce7016c9cb-dirty (Aug 19 2024 - 16:42:15 +0200)
>> [...]
>> => mtest
>> Usage: mtest <size_in_bytes> [dst [src]]
>> => mtest 1000
>> 1000 bytes from 0x00000000466baed0 to 0x00000000466baae0: 0 ms
>> => mtest 1000 0x2000000 0x00000000466baed0
>> 1000 bytes from 0x00000000466baed0 to 0x0000000002000000: 22 ms
>> => mtest 1000 0x00000000466baed0 0x2000000
>> 1000 bytes from 0x0000000002000000 to 0x00000000466baed0: 0 ms
>> => 
> 
> This is all very strange. Can you investigate a bit please?

OK, so this was actually a red herring :-/ For some reason I kept using
address 2000000 for my tests and it happens to be memory-mapped I/O
for the flash storage in QEMU. That's why it is so slow, but we don't
care.

The qemu_arm64 failure in CI was actually caused by DHCP not setting
${serverip} so TFTP would fail afterwards. This is fixed in v9.

Fixed also are the r2dplus_i82557c and r2dplus_rtl8139 failures which
were caused by calling free_pkt() with a length of zero, as well as
the "dm_pci_phys_to_bus: invalid physical address" error on
r2dplus_tulip (eth_init_rings() was called too late).

I am now runnig CI again. It should hopefully be all green. Stay tuned
for v9 ;)

Thanks,
-- 
Jerome
