Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D997D2F347
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 17:29:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2988E80325;
	Tue, 13 Jan 2026 18:29:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=freeshell.de header.i=@freeshell.de header.b="XDZJAQ3I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9733D80433; Tue, 13 Jan 2026 18:29:34 +0100 (CET)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25867802C1
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 18:29:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1768325361;
 bh=a6eMBbH42x6H7FkpOs5+j+RjRVySYDLY9Ihx2SQvvkc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=XDZJAQ3I6B4XXNeanx/E8hejLSfDNq1otmg6st183yfMxaJnIpibNM7bKRn00ES8w
 akAoSlSSg3SgATY4KOuX8ZOQgPbwCujTamobFW6kDsLfNsqEgssPw6i6oteJootWvv
 GtWdP6UoNdU7IbVN/fhhx528TvfflLVsHLcx5GsGFYgLk3duF5cqAqLs58nU3HX8vF
 r/7F3pr8Tx5G1rIQQ17h87IeGqRjKQAWyp5QK2pVMuxj4vvSC942WgnIq28SR7ZHQb
 FYF/GYZVFQ2tO8IpIFulth3QRXYu+XX4wyvqm9Y79vqTXlfo1AY8cL0C37VKfudxwk
 VcCpE+7PBWpMw==
Received: from [IPV6:2605:59c0:2078:cf00:c0b6:e37b:5515:2b98] (unknown
 [IPv6:2605:59c0:2078:cf00:c0b6:e37b:5515:2b98])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id B9E7EB220343;
 Tue, 13 Jan 2026 18:29:17 +0100 (CET)
Message-ID: <873d73f0-34fe-4445-8745-f98734637b0c@freeshell.de>
Date: Tue, 13 Jan 2026 09:29:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] mkimage: Detect FIT image load address overlaps
 and fix related test/DTS issues
To: Aristo Chen <jj251510319013@gmail.com>
Cc: Nishanth Menon <nm@ti.com>, u-boot@lists.denx.de, trini@konsulko.com,
 sjg@chromium.org, alpernebiyasak@gmail.com, al.kochet@gmail.com,
 paul.henrys_ext@softathome.com, bb@ti.com, y.moog@phytec.de,
 w.egorov@phytec.de, francesco.dolcini@toradex.com, ggiordano@phytec.com,
 n-francis@ti.com, afd@ti.com, d.schultz@phytec.de, d-gole@ti.com,
 ravi@prevas.dk, carlos.lopezr4096@gmail.com, quentin.schulz@cherry.de,
 alice.guo@nxp.com, Aristo Chen <aristo.chen@canonical.com>
References: <20250914110021.4103-1-aristo.chen@canonical.com>
 <20250924113733.uz6hozszbuynemtc@giddy>
 <20250924114317.742ae4ntrb4mvuyq@expert>
 <b07919da-f3fe-49ca-8f76-ab057d8af58a@freeshell.de>
 <CAJwFiGLHDEPMsFyBhX=ogQxX_C+8ac-_9_jeiZYyo=3o0M8ZHA@mail.gmail.com>
 <CAJwFiGLXgsnb75HT45L5Xo-N4LmCBeLGwPi8Yr5zZzNo7mrVNg@mail.gmail.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <CAJwFiGLXgsnb75HT45L5Xo-N4LmCBeLGwPi8Yr5zZzNo7mrVNg@mail.gmail.com>
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

Hi Aristo,

On 1/13/26 07:09, Aristo Chen wrote:
> Hi E Shattow,
> 
> Aristo Chen <jj251510319013@gmail.com> 於 2025年11月5日週三 下午8:21寫道：
>>
>> Hi E Shattow,
>>
>> E Shattow <e@freeshell.de> 於 2025年9月24日 週三 下午9:31寫道：
>>>
>>> Hi Aristo,
>>>
>>> On 9/24/25 04:43, Nishanth Menon wrote:
>>>> On 06:37-20250924, Nishanth Menon wrote:
>>>>> On 10:59-20250914, Aristo Chen wrote:
>>>>>> This patch series enhances FIT image robustness by adding **memory
>>>>>> region overlap detection** to `mkimage` and fixing existing overlaps
>>>>>> in DTS files and `binman` tests.
>>>>
>>>> [...]
>>>>>>
>>>>>
>>>>> Looks like i see a build regression in linux-next after this series.
>>>>
>>>> I fat fingered that one.. sorry, I meant u-boot next.
>>>>
>>>>
>>>> Fails at commit 4d84fa1261eb, last pass was on commit d81c1118580f
>>>>
>>>>>
>>>>> https://gist.github.com/nmenon/b2fc9e7680cc296062c7dced94105f76
>>>>
>>>> I  believe there are outstanding comments on V1 that have'nt been
>>>> addressed either. Can we revert/drop this series for now while the
>>>> comments are addressed?
>>>>
>>>
>>> Similar to Nishanth, I am seeing a build regression, itb.map:
>>>
>>> ImagePos    Offset      Size  Name
>>> <none>      00000000  <none>    itb
>>> <none>      00000000  <none>    fit
>>> <none>      00000000  000c1698  uboot
>>> <none>      00000000  000c1698  u-boot-nodtb
>>> <none>      000c1698  00202128  opensbi
>>> <none>      00000000  00202128  opensbi
>>>
>>> Yields this error:
>>> ...
>>>  MKIMAGE fit-dtb.blob
>>> Warning: not able to get `load` of node 'fdt-1'
>>> Warning: not able to get `load` of node 'fdt-2'
>>> Warning: not able to get `load` of node 'fdt-3'
>>> Warning: not able to get `load` of node 'fdt-4'
>>> Warning: not able to get `load` of node 'fdt-5'
>>> Warning: not able to get `load` of node 'fdt-6'
>>> Warning: not able to get `load` of node 'fdt-7'
>>>   CAT     u-boot-fit-dtb.bin
>>> ...
>>>   MKIMAGE u-boot.img
>>> Warning: not able to get `load` of node 'fdt-1'
>>> Warning: not able to get `load` of node 'fdt-2'
>>> Warning: not able to get `load` of node 'fdt-3'
>>> Warning: not able to get `load` of node 'fdt-4'
>>> Warning: not able to get `load` of node 'fdt-5'
>>> Warning: not able to get `load` of node 'fdt-6'
>>> Warning: not able to get `load` of node 'fdt-7'
>>>   COPY    u-boot.dtb
>>>   MKIMAGE u-boot-dtb.img
>>> Warning: not able to get `load` of node 'fdt-1'
>>> Warning: not able to get `load` of node 'fdt-2'
>>> Warning: not able to get `load` of node 'fdt-3'
>>> Warning: not able to get `load` of node 'fdt-4'
>>> Warning: not able to get `load` of node 'fdt-5'
>>> Warning: not able to get `load` of node 'fdt-6'
>>> Warning: not able to get `load` of node 'fdt-7'
>>>   BINMAN  .binman_stamp
>>> Wrote map file './itb.map' to show errors
>>> binman: Error 1 running 'mkimage -t -F ./itb.fit.fit': Warning: not able
>>> to get `load` of node 'fdt-1'
>>> [Config: conf-1] Error: Overlap detected:
>>>   - uboot: [0x40200000 - 0x402c1698]
>>>   - opensbi: [0x40000000 - 0x40202128]
>>>
>>> make[1]: *** [/tmp/u-boot.2.git/Makefile:1339: .binman_stamp] Error 1
>>> make[1]: Leaving directory '/home/es/build/u-boot'
>>> make: *** [Makefile:198: sub-make] Error 2
>>> make: Leaving directory '/tmp/u-boot.2.git'
>>>
>>> If you would like to reproduce the issue, use config
>>> starfive_visionfive2_defconfig and pass to OPENSBI env variable the path
>>> of opensbi object 'fw_dynamic.bin' built using PLATFORM=generic, with
>>> the ordinary gcc riscv64 toolchain. The starfive visionfive2 board
>>> target in U-Boot supports multiple vendors and boards selected at
>>> runtime and is an example of a more complex FIT usage that you may be
>>> interested in for comparison and testing.
>>>
>>> Best regards,
>>>
>>> -E
>>
>> Sorry that I didn't noticed that my previous email sent to you was not
>> including other people
>>
>> Long story short, I am now able to reproduce the overlap issue that
>> you have encountered, and
>> I spent some time trying to understand what is opensbi, please correct
>> me if I am wrong
>>
>> AFAICT, there will be 2 types of firmware built, one is
>> `fw_payload.bin`, and the other is
>> `fw_dynamic.bin`
>> - fw_payload.bin: contains the next-stage binary, so the file size
>> will be bigger
>> - fw_dynamic.bin: provides information about the next boot stage at
>> runtime, so the size is smaller
>>
>> and here are the size of these 2 files built in my environment
>> ```
>> -rw-rw-r-- 1 ubuntu ubuntu  273048 Oct 25 14:49 fw_dynamic.bin
>> -rw-rw-r-- 1 ubuntu ubuntu 2105656 Oct 25 14:49 fw_payload.bin
>> ```
>>
>> When using my overlap checking mechanism, and passing the
>> fw_dynamic.bin to build U-Boot,
>> there is no overlap issue. However, when using fw_payload.bin, there
>> will be an overlap issue.
>>
>> AFAICT, the SPL will load the opensbi firmware(assuming fw_payload.bin
>> here) first, then load
>> U-Boot into memory, and then jump to opensbi firmware, so I was a bit
>> confused why the
>> overlapped opensbi still works?
>>
>> I will find some time to figure out how the whole loading/booting
>> process looks like, but it would
>> be greatly appreciated if you can share some insight, thanks!
> 
> I finally had some time to revisit this and managed to get a VisionFive2
> board for local testing.
> 
> While trying to make it bootable I noticed the following docs:
>   - https://docs.u-boot.org/en/latest/board/starfive/visionfive2.html#second-stage-bootloader-opensbi-fw-dynamic-bin-u-boot-main
>   - https://wiki.gentoo.org/wiki/StarFive_VisionFive_2#Building_OpenSBI
> 
> Both appear to recommend using OpenSBI’s fw_dynamic.bin when building
> U‑Boot. I couldn’t find any guidance on using fw_payload.bin together
> with U‑Boot, which made me wonder why fw_payload.bin was used in your
> earlier report.
> 

Likely I mixed up the filenames when writing in conversation, as I did
when writing on the opensbi mailing list about a dependency tracking bug
in opensbi build system:

https://lore.kernel.org/opensbi/0d6bf7c7-7605-4ad6-a35c-54efc5230fb8@sifive.com/

and

https://lore.kernel.org/opensbi/36cfe431-40fb-470d-b50e-00a139d480f8@freeshell.de/

...which is clearly a mistake to write "OPENSBI=/path/to/fw_payload.bin"
when it should instead be "OPENSBI=/path/to/fw_dynamic.bin",
acknowledged in the follow-up message:

https://lore.kernel.org/opensbi/32873fc7-2cc8-46d5-9f4e-3a16cf95f48a@freeshell.de/

> Could you clarify whether there is documentation (or a specific
> requirement) that calls for fw_payload.bin in this flow? If the intended
> path is fw_dynamic.bin, then the overlap issue disappears for me
> 

For the VisionFive2 and derivative boards, I intended to refer to
fw_dynamic.bin only. If I mention otherwise it was in error or for not
knowing what I'm looking at and reporting more information than
required. There are RISC-V boards not related to VisionFive2 or its
StarFive JH-7110 SoC that do use the fw_payload.bin approach but I think
I just didn't notice the difference when transcribing to e-mail.

> Thanks for your help and guidance.
>>
>> Best regards,
>> Aristo
> 
> Best regards,
> Aristo

Thanks very much for the follow-up,

-E
