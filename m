Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 455B8EC8734
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 15:30:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 524BF869F0;
	Thu,  7 Sep 2023 17:30:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="W76tOwPg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5CF0869CA; Thu,  7 Sep 2023 17:30:09 +0200 (CEST)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97196869F0
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 17:30:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2b9d07a8d84so18312921fa.3
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 08:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1694100606; x=1694705406;
 darn=lists.denx.de; 
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H0bCzUqENR1zy7hh/9jC6sJtqmdvib0IDy7cvisNK+A=;
 b=W76tOwPgyn2YQ6MR75QaelOgguvYB3S0PufN/mK8zz2TxQiFBr7dSe6Rc0N6/L1GqK
 1nHIatX33mq3kBSn/IwqIFeMqNdStqSYyIChwBYwun8z01+9lCUhS6gs62ix022WAZc5
 cTwHWvJgIq5syzvwCXZgNVetrMsj/eGe43uz2w9Q/WYyOhZIfcKGL0Vr4YYx8/1VKvyK
 obKeVNQv8KLx6gILfwQQmUAbw5KVepr+IlZ/nlmbn8daMTJJyaEr1xtN2s0pQr2rEtyI
 toUluSFBq6rhCLCVUjgJCCnVnrKUfRQsfaLVs8H42/bs5eQIshtDzGe9JUW1r2lMV1gN
 eRLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694100606; x=1694705406;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=H0bCzUqENR1zy7hh/9jC6sJtqmdvib0IDy7cvisNK+A=;
 b=HZOfzJPT+zhB4VHFah0yVaeXXJQFCvqvD0nXxgmXCOtioFN4NpOm/07+F5VEoiViFU
 l4Fo/10Adt4Ojxd1UB68jwJxll86Wo17xM2RD0Tw02KIsoe+pK6HZewzVYwr9yK616DD
 pi20ozHbDnIWm7aXXp1aXo16cy0gj6iZClgXRekb1Vsbjr0xBGWl0fFayS1MH0yV2tuf
 hrdKsHsYtZZffdgwvKRis/5YfnIK9RWgKz/+8LDn48E8UA6q/sB+AUxobAMbbXpn7uPj
 wO8GCQ/phOElB/3aVSTtA+z1iigWaMD3dVE2PlSbdBWZhWImVvw+lEuKxwUYfsU2UxrI
 CGSQ==
X-Gm-Message-State: AOJu0Yxe26UvWMPzGZiCJn8C+IJgtXvfqXhtgf6V712irUC0A9j7bTBF
 rmli+FAU07gNxniluLFzeZLagsUco21hoEyr8MfL2Q==
X-Google-Smtp-Source: AGHT+IGXzlF3+vfom8q4TDsE3rHdxflF+0rv/ufgasm2y4oGZlLdf0uOcLTtgIPlnsnTg/pGo+az6w==
X-Received: by 2002:a19:2d17:0:b0:4fe:2d93:2b51 with SMTP id
 k23-20020a192d17000000b004fe2d932b51mr4990317lfj.27.1694100605614; 
 Thu, 07 Sep 2023 08:30:05 -0700 (PDT)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
 by smtp.gmail.com with ESMTPSA id
 x24-20020a170906805800b009894b476310sm10547208ejw.163.2023.09.07.08.30.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Sep 2023 08:30:05 -0700 (PDT)
Message-ID: <7d128f4a-b972-0535-ac06-bd600ba2e37c@monstr.eu>
Date: Thu, 7 Sep 2023 17:30:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
From: Michal Simek <monstr@monstr.eu>
Subject: sandbox trace errors in CI loop
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

Hi Simon and Tom,

I am preparing pull request and I see that CI loop is reporting issue with 
sandbox trace and I have no idea what's going wrong here.

This is the first problematic commit but have no clue what it has to do with trace.

https://source.denx.de/u-boot/custodians/u-boot-microblaze/-/commit/8c5f80d11b29536979ac41a6087fb8938f45bbf2

If you have an access you can take a look at my queue to see that only this job 
is failing.
https://source.denx.de/u-boot/custodians/u-boot-microblaze/-/pipelines

Thanks,
Michal

collected 1152 items / 1151 deselected / 1 selected
test/py/tests/test_trace.py F                                            [100%]
=================================== FAILURES ===================================
__________________________________ test_trace __________________________________
test/py/tests/test_trace.py:292: in test_trace
     check_function(cons, fname, proftool, map_fname, trace_dat)
test/py/tests/test_trace.py:117: in check_function
     out = util.run_and_log(cons, ['sh', '-c', cmd])
test/py/u_boot_utils.py:181: in run_and_log
     output = runner.run(cmd, ignore_errors=ignore_errors, stdin=stdin, env=env)
test/py/multiplexed_log.py:183: in run
     raise exception
E   ValueError: Exit code: 1
---------------------------- Captured stdout setup -----------------------------
/u-boot
trace: early enable at 00100000
sandbox_serial serial: pinctrl_select_state_full: 
uclass_get_device_by_phandle_id: err=-19
=>
----------------------------- Captured stdout call -----------------------------
=> Call list dumped to 02000000, size 0xde3b30
=> +/tmp/sandbox/tools/proftool -t /tmp/test_trace/trace -o 
/tmp/test_trace/trace.dat -m /tmp/sandbox/System.map dump-ftrace
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
=========================== short test summary info ============================
FAILED test/py/tests/test_trace.py::test_trace - ValueError: Exit code: 1
====================== 1 failed, 1151 deselected in 3.32s ======================
-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs
