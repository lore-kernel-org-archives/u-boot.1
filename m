Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8852FEE7FF7
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 13:42:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB1D386A2F;
	Fri,  8 Sep 2023 15:42:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="TR2pRtqP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74AEB864C1; Fri,  8 Sep 2023 15:42:35 +0200 (CEST)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0357986A21
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 15:42:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-68e3083aa1dso1957207b3a.1
 for <u-boot@lists.denx.de>; Fri, 08 Sep 2023 06:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1694180550; x=1694785350;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KI504J+8IuIjGdhEhA4ErfU1y5yARUFkUHs01rDHI2E=;
 b=TR2pRtqPsgfx2XDhNQKnNmxDNZh4Lk+NwAdj67A9eOySq7DNg9vpVc3dLNa0771/xV
 U5wVwu7vppUdQwy/AXfihPXNY0eCIbpCZDOztZY+mypMDgGgt/dATC0o1wA8jdAJIJD+
 IAhPvDxShpvB2W3bjQIuED/WUJajEfAKX6xBrJvnNHcNm7f8IoDdAu3FOiNMI57rgyLk
 zfDman8QdF71NYYREdpbHBKRKUi4h8uLlY+4BsKKbMqK5PW6E865k/Ho7V+gfvLmkMak
 H8S0UmEHhrfiRvuOuK3oR8ka+9O0Qtv6CBN9MIIJOLGw2csZZpYYsa6NQc/nWouKKK/R
 0GkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694180550; x=1694785350;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KI504J+8IuIjGdhEhA4ErfU1y5yARUFkUHs01rDHI2E=;
 b=tK1m430kaEDnOD50l5itlpMFWqnz3wJigPqcgPZdzTnsnFh4J33mAWB/bhz8/zqmHJ
 aPKJo0fiB1sCI0qMSzjkPOghvCCDXybU8SDq0rd5g+wrv6ZvL0JlYehtruj7UcwZniMu
 TnbsA6z4HelieonkbF4MI6308CtgIR2hdoPU6dwODGHOSjxOzc8mOJMlh/tXwGjpTDC9
 /1SbIWFwCqY4sW8hhrgDZlM3dGTuseeKkxxGTf/2ozYEXq+XCk/xvFhpt2DHkHas7WpC
 7FXA+f/g8GxTid7YJJss2ftVlgysbZSj/4jiwPV7Jq9gRvgAQoql5VXICqGbW/BwAuTy
 9ywA==
X-Gm-Message-State: AOJu0YwTS70wBr8OaIItj+X1HOGFVtry3j5nhNAvyivGfpcvhXDI2ySO
 18Sgj4ToemaPk1hieuiSSTo5kg==
X-Google-Smtp-Source: AGHT+IFn5hGgoXnbK4ho1U9/aO3YwqRLNBXsPppA8j/xyeSLdv3+6V1K4H1CWF1tfhDFO24T0Yfg3A==
X-Received: by 2002:a05:6a00:2349:b0:68b:bf47:d7b0 with SMTP id
 j9-20020a056a00234900b0068bbf47d7b0mr2664875pfj.3.1694180550171; 
 Fri, 08 Sep 2023 06:42:30 -0700 (PDT)
Received: from [192.168.137.2] ([149.199.80.131])
 by smtp.gmail.com with ESMTPSA id
 r19-20020a62e413000000b006875df4773fsm1337081pfh.163.2023.09.08.06.42.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Sep 2023 06:42:29 -0700 (PDT)
Message-ID: <fd3a2682-0215-4026-a51d-de6364e06a69@monstr.eu>
Date: Fri, 8 Sep 2023 15:42:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: sandbox trace errors in CI loop
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
References: <7d128f4a-b972-0535-ac06-bd600ba2e37c@monstr.eu>
 <20230907181411.GX305624@bill-the-cat>
 <9d45165f-fc88-4615-969b-0aafc7d43f13@monstr.eu>
 <20230908133415.GA305624@bill-the-cat>
From: Michal Simek <monstr@monstr.eu>
Autocrypt: addr=monstr@monstr.eu; keydata=
 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
In-Reply-To: <20230908133415.GA305624@bill-the-cat>
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



On 9/8/23 15:34, Tom Rini wrote:
> On Fri, Sep 08, 2023 at 12:24:10PM +0200, Michal Simek wrote:
>>
>>
>> On 9/7/23 20:14, Tom Rini wrote:
>>> On Thu, Sep 07, 2023 at 05:30:03PM +0200, Michal Simek wrote:
>>>> Hi Simon and Tom,
>>>>
>>>> I am preparing pull request and I see that CI loop is reporting issue with
>>>> sandbox trace and I have no idea what's going wrong here.
>>>>
>>>> This is the first problematic commit but have no clue what it has to do with trace.
>>>>
>>>> https://source.denx.de/u-boot/custodians/u-boot-microblaze/-/commit/8c5f80d11b29536979ac41a6087fb8938f45bbf2
>>>>
>>>> If you have an access you can take a look at my queue to see that only this
>>>> job is failing.
>>>> https://source.denx.de/u-boot/custodians/u-boot-microblaze/-/pipelines
>>>>
>>>> Thanks,
>>>> Michal
>>>>
>>>> collected 1152 items / 1151 deselected / 1 selected
>>>> test/py/tests/test_trace.py F                                            [100%]
>>>> =================================== FAILURES ===================================
>>>> __________________________________ test_trace __________________________________
>>>> test/py/tests/test_trace.py:292: in test_trace
>>>>       check_function(cons, fname, proftool, map_fname, trace_dat)
>>>> test/py/tests/test_trace.py:117: in check_function
>>>>       out = util.run_and_log(cons, ['sh', '-c', cmd])
>>>> test/py/u_boot_utils.py:181: in run_and_log
>>>>       output = runner.run(cmd, ignore_errors=ignore_errors, stdin=stdin, env=env)
>>>> test/py/multiplexed_log.py:183: in run
>>>>       raise exception
>>>> E   ValueError: Exit code: 1
>>>> ---------------------------- Captured stdout setup -----------------------------
>>>> /u-boot
>>>> trace: early enable at 00100000
>>>> sandbox_serial serial: pinctrl_select_state_full:
>>>> uclass_get_device_by_phandle_id: err=-19
>>>> =>
>>>
>>> I don't get it either since I see this on master with trace options
>>> enabled per CI:
>>> $ ./u-boot -T arch/sandbox/dts/test.dtb
>>> trace: early enable at 00100000
>>> sandbox_serial serial: pinctrl_select_state_full: uclass_get_device_by_phandle_id: err=-19
>>> ... rest of boot proceeds ...
>>>
>>> So the test should be failing already if that was the problem.
>>>
>>
>> I don't thin it is the problematic part.
>>
>> When I look at
>> https://source.denx.de/u-boot/u-boot/-/blob/master/tools/docker/Dockerfile?ref_type=heads#L225
>>
>> clone is done from
>> git clone https://github.com/rostedt/trace-cmd.git /tmp/trace/trace-cmd && \
>>
>> https://github.com/rostedt/trace-cmd/blob/master/README#L5
>>
>> we should be using
>> git://git.kernel.org/pub/scm/utils/trace-cmd/trace-cmd.git instead.
>>
>> I installed the latest version on my PC and run it via pytest and this is
>> what I am getting.
>> You see that trace-cmd report is returning "failed to init data".
>>
>> Are we wired to any specific trace-cmd version?
> 
> Wait, no, what's going on exactly? The github repository is a mirror of
> the kernel.org one. So yes, we should correct to point to the main one,
> but the top of tree in both cases is commit
> 354dccca52e805ce1b22e2b62cbae8c265886c27.
> 

I dig into it more.
What it is happening is that when sandbox u-boot is bigger trace.dat file is
placing information to different offset then it is recorded somewhere in header.

Wrong placement

0005b000  20 70 65 72 66 20 6d 6f  6e 6f 20 6d 6f 6e 6f 5f  | perf mono mono_|
0005b010  72 61 77 20 62 6f 6f 74  20 78 38 36 2d 74 73 63  |raw boot x86-tsc|
0005b020  0a 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
0005b030  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
*
0005c000  89 df f6 1d 00 00 00 00  dc 0f 00 00 00 00 00 00  |................|
0005c010  06 00 00 00 01 00 00 00  01 00 00 00 af e5 0a 00  |................|
0005c020  00 00 00 00 ef dc 09 00  00 00 00 00 06 00 00 00  |................|
0005c030  01 00 00 00 01 00 00 00  af e5 0a 00 00 00 00 00  |................|

Correct placement for trace-cmd

0005aee0  75 70 74 69 6d 65 20 70  65 72 66 20 6d 6f 6e 6f  |uptime perf mono|
0005aef0  20 6d 6f 6e 6f 5f 72 61  77 20 62 6f 6f 74 20 78  | mono_raw boot x|
0005af00  38 36 2d 74 73 63 0a 00  00 00 00 00 00 00 00 00  |86-tsc..........|
0005af10  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
*
0005b000  36 f8 92 3f 00 00 00 00  e0 0f 00 00 00 00 00 00  |6..?............|

And trace-cmd want to decode data available at 0x5b000 offset in both cases.

It means I expect proftool is not correctly generating offset where data is 
present. I don't understand how it works but I clearly see based on trace-cmd 
that it points to incorrect location.

Thanks,
Michal
-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs
