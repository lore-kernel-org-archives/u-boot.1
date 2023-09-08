Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 069F1EE57F1
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 10:24:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71706869D3;
	Fri,  8 Sep 2023 12:24:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="1iq9XNOi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84545869E1; Fri,  8 Sep 2023 12:24:21 +0200 (CEST)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F205D869D1
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 12:24:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1c1ff5b741cso17098665ad.2
 for <u-boot@lists.denx.de>; Fri, 08 Sep 2023 03:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1694168656; x=1694773456;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hYVEvu/EevuJFzLrZroJH5SVPAN7FUEn2IPmbRaCxJo=;
 b=1iq9XNOi/tyZzbotsKIrF/ZBqPpvAN3AmZQdXkxVaIuEDAggH08rLGlHsZ7urxvJN+
 ynG0u9Y94LlcAzpzW6D0FVvc3Mm4YdyZaHCXFbvMo5tOzkmai/jVCYBKVhN0FDT9qWav
 ogbJR5s8neS+bh1/ORIhmrkAvqhThCXGgoOaFzgq3qWibnJQ8FRTAETazh1XpfKJEIdW
 yK9yw1Fm9wPLL8SB5FKXUuGbpcebTdC4IGYp1kYhrQc622IS8AbhKwDgWRLtJKOWw1/6
 XBLR7h/6Tz5LWaManX/OxBA5uCUtVBVR3pTx/qofWHvtjedbVMokdmZlfFPdzCAx56FQ
 QFYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694168656; x=1694773456;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hYVEvu/EevuJFzLrZroJH5SVPAN7FUEn2IPmbRaCxJo=;
 b=lt03hMH2191FWiEsDTPXItwb2DMGnv3BRLES1c9eL4w0W+HlJeqob429zNP0PbYIpn
 CE3NIb/ce6kPX3575ljb8xaUkAVnvja8GTkN6fq6tIrXTRil1bD8G+MmagTNJpyXN+ZX
 eUMk3ix4imcirdSjObSqpP7c04lDUz58O5HlVX09PxNkesD+ae/g9KpkjyMM6HDzkI6c
 T7ZePqbdCirkKOjcDHALJtahKFYvqCNI2przUNeWSynEl5LACsoKlQc7ai1oRxqW4Ecx
 nRANv+fvldyLSJWw0XcwVwjZKjvHgTQ6/uye7qOLNKpjV0FMJbS+zskZxr3wR85nJ0Om
 Qtog==
X-Gm-Message-State: AOJu0YwQlH5N2TNF0cjCmaHQTiXDibj/niqWrraUALu+a75rEWW6a4ru
 2soYZcKgCAwEesIFoZvrWWy3MQ==
X-Google-Smtp-Source: AGHT+IEpYQWNfZmXcVDuGAtmZANRKnwjIWkZmrYx87krKu9f6S8vNRGOwX5CiOi3Bew2u/7T8qdfGQ==
X-Received: by 2002:a17:902:db11:b0:1bc:61d6:5fcc with SMTP id
 m17-20020a170902db1100b001bc61d65fccmr2147959plx.51.1694168656097; 
 Fri, 08 Sep 2023 03:24:16 -0700 (PDT)
Received: from [192.168.137.2] ([149.199.80.131])
 by smtp.gmail.com with ESMTPSA id
 e3-20020a170902ed8300b001b1a2c14a4asm1266326plj.38.2023.09.08.03.24.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Sep 2023 03:24:15 -0700 (PDT)
Message-ID: <9d45165f-fc88-4615-969b-0aafc7d43f13@monstr.eu>
Date: Fri, 8 Sep 2023 12:24:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: sandbox trace errors in CI loop
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
References: <7d128f4a-b972-0535-ac06-bd600ba2e37c@monstr.eu>
 <20230907181411.GX305624@bill-the-cat>
From: Michal Simek <monstr@monstr.eu>
Autocrypt: addr=monstr@monstr.eu; keydata=
 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
In-Reply-To: <20230907181411.GX305624@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 9/7/23 20:14, Tom Rini wrote:
> On Thu, Sep 07, 2023 at 05:30:03PM +0200, Michal Simek wrote:
>> Hi Simon and Tom,
>>
>> I am preparing pull request and I see that CI loop is reporting issue with
>> sandbox trace and I have no idea what's going wrong here.
>>
>> This is the first problematic commit but have no clue what it has to do with trace.
>>
>> https://source.denx.de/u-boot/custodians/u-boot-microblaze/-/commit/8c5f80d11b29536979ac41a6087fb8938f45bbf2
>>
>> If you have an access you can take a look at my queue to see that only this
>> job is failing.
>> https://source.denx.de/u-boot/custodians/u-boot-microblaze/-/pipelines
>>
>> Thanks,
>> Michal
>>
>> collected 1152 items / 1151 deselected / 1 selected
>> test/py/tests/test_trace.py F                                            [100%]
>> =================================== FAILURES ===================================
>> __________________________________ test_trace __________________________________
>> test/py/tests/test_trace.py:292: in test_trace
>>      check_function(cons, fname, proftool, map_fname, trace_dat)
>> test/py/tests/test_trace.py:117: in check_function
>>      out = util.run_and_log(cons, ['sh', '-c', cmd])
>> test/py/u_boot_utils.py:181: in run_and_log
>>      output = runner.run(cmd, ignore_errors=ignore_errors, stdin=stdin, env=env)
>> test/py/multiplexed_log.py:183: in run
>>      raise exception
>> E   ValueError: Exit code: 1
>> ---------------------------- Captured stdout setup -----------------------------
>> /u-boot
>> trace: early enable at 00100000
>> sandbox_serial serial: pinctrl_select_state_full:
>> uclass_get_device_by_phandle_id: err=-19
>> =>
> 
> I don't get it either since I see this on master with trace options
> enabled per CI:
> $ ./u-boot -T arch/sandbox/dts/test.dtb
> trace: early enable at 00100000
> sandbox_serial serial: pinctrl_select_state_full: uclass_get_device_by_phandle_id: err=-19
> ... rest of boot proceeds ...
> 
> So the test should be failing already if that was the problem.
> 

I don't thin it is the problematic part.

When I look at
https://source.denx.de/u-boot/u-boot/-/blob/master/tools/docker/Dockerfile?ref_type=heads#L225

clone is done from
git clone https://github.com/rostedt/trace-cmd.git /tmp/trace/trace-cmd && \

https://github.com/rostedt/trace-cmd/blob/master/README#L5

we should be using git://git.kernel.org/pub/scm/utils/trace-cmd/trace-cmd.git 
instead.

I installed the latest version on my PC and run it via pytest and this is what I 
am getting.
You see that trace-cmd report is returning "failed to init data".

Are we wired to any specific trace-cmd version?

Thanks,
Michal


$ ./test/py/test.py -p no:random-order --bd sandbox --build -s -k test_trace
+make O=/home/monstr/data/disk/u-boot/build-sandbox -s sandbox_defconfig
+make O=/home/monstr/data/disk/u-boot/build-sandbox -s -j12
==================================================================== test 
session starts =====================================================================
platform linux -- Python 3.10.12, pytest-6.2.5, py-1.10.0, pluggy-0.13.0
rootdir: /home/monstr/data/disk/u-boot/test/py, configfile: pytest.ini
plugins: forked-1.4.0, xdist-2.5.0
collected 1152 items / 1151 deselected / 1 selected 


test/py/tests/test_trace.py /u-boot
trace: early enable at 00100000
sandbox_serial serial: pinctrl_select_state_full: 
uclass_get_device_by_phandle_id: err=-19


U-Boot 2023.10-rc4-00005-gb8dbddc83ab4 (Sep 08 2023 - 12:20:25 +0200)

Reset Status: WARM Reset Status: COLD
Model: sandbox
DRAM:  256 MiB
trace: copying 009a442c bytes of early data from 100000 to 0e000000
658075 traced function calls
trace: enabled
Core:  275 devices, 97 uclasses, devicetree: board
WDT:   Not starting wdt-gpio-toggle
wdt_gpio wdt-gpio-level: Request for wdt gpio failed: -16
WDT:   Not starting wdt@0
MMC:   Can't map file 'mmc1.img': Invalid argument
mmc1: Unable to map file 'mmc1.img'
Can't map file 'mmc1.img': Invalid argument
mmc1: Unable to map file 'mmc1.img'
mmc1 - probe failed: -1
mmc2: 2 (SD)Can't map file 'mmc1.img': Invalid argument
mmc1: Unable to map file 'mmc1.img'
, mmc0: 0 (SD)
Loading Environment from nowhere... OK
In:    serial,cros-ec-keyb,usbkbd
Out:   serial,vidconsole
Err:   serial,vidconsole
Model: sandbox
Net:   eth0: eth@10002000, eth5: eth@10003000, eth3: sbe5, eth6: eth@10004000, 
eth8: phy-test-eth, eth4: dsa-test-eth, eth2: lan0, eth7: lan1
Hit any key to stop autoboot:  0
=> => trace pause
=> => trace stats
         276,625 function sites
       1,568,061 function calls
               0 untracked function calls
       1,213,676 traced function calls (898312 dropped due to overflow)
              36 maximum observed call depth
              15 call depth limit
       1,024,122 calls not traced due to depth
       1,213,676 max function calls

trace buffer e000000 call records e21c4e8
=> => bootstage report
Timer summary in microseconds (10 records):
        Mark    Elapsed  Stage
           0          0  reset
           0          0  board_init_f
      40,753     40,753  board_init_r
      91,689     50,936  eth_common_init
      91,699         10  eth_initialize
      93,786      2,087  main_loop
      94,644        858  cli_loop

Accumulated time:
                 10,148  dm_r
                 11,269  of_live
                 25,652  dm_f
=> => trace calls 2000000 1000000
Call list dumped to 02000000, size 0xde3b30
=> Call list dumped to 02000000, size 0xde3b30
=> host save hostfs - 2000000 /tmp/test_trace/trace ${profoffset}
14564144 bytes written in 3 ms (4.5 GiB/s)
=> +/home/monstr/data/disk/u-boot/build-sandbox/tools/proftool -t 
/tmp/test_trace/trace -o /tmp/test_trace/trace.dat -m 
/home/monstr/data/disk/u-boot/build-sandbox/System.map dump-ftrace
9842 functions found in map file, start addr 3e000
call count: 1213676
+trace-cmd dump /tmp/test_trace/trace.dat

  Tracing meta data in file /tmp/test_trace/trace.dat:
	[Initial format]
		6	[Version]
		0	[Little endian]
		4	[Bytes in a long]
		4096	[Page size, bytes]
	[Header page, 205 bytes]
	[Header event, 205 bytes]
	[Ftrace format, 3 events]
	[Events format, 0 systems]
	[Kallsyms, 370293 bytes]
	[Trace printk, 0 bytes]
	[Saved command lines, 9 bytes]
	1 [CPUs with tracing data]
	[6 options]
	[Flyrecord tracing data]
	[Tracing clock]
		[local] global counter uptime perf mono mono_raw boot x86-tsc

+sh -c trace-cmd report /tmp/test_trace/trace.dat |grep -E '(initf_|initr_)'
   failed to init data
Exit code: 1
F

========================================================================== 
FAILURES ==========================================================================
_________________________________________________________________________ 
test_trace _________________________________________________________________________
test/py/tests/test_trace.py:292: in test_trace
     check_function(cons, fname, proftool, map_fname, trace_dat)
test/py/tests/test_trace.py:117: in check_function
     out = util.run_and_log(cons, ['sh', '-c', cmd])
test/py/u_boot_utils.py:181: in run_and_log
     output = runner.run(cmd, ignore_errors=ignore_errors, stdin=stdin, env=env)
test/py/multiplexed_log.py:183: in run
     raise exception
E   ValueError: Exit code: 1
================================================================== short test 
summary info ===================================================================
FAILED test/py/tests/test_trace.py::test_trace - ValueError: Exit code: 1
============================================================= 1 failed, 1151 
deselected in 2.13s =============================================================


-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs
