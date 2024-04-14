Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 098F0C4345F
	for <u-boot@archiver.kernel.org>; Sun, 14 Apr 2024 17:00:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46D0087FC1;
	Sun, 14 Apr 2024 19:00:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="u6ZmkYXC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66CFC88052; Sun, 14 Apr 2024 19:00:54 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC2AB87F6F
 for <u-boot@lists.denx.de>; Sun, 14 Apr 2024 19:00:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=d27d=LU=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1713114022;
 bh=zI7uQ8p/kUOjOKS9hOi5mgRfFjCYCudOvmBg5yuaVLM=;
 b=u6ZmkYXCt4xrqNOI7G+rIor64CNe29dMvetFjVtx/EmJDafi6uPwfF8iIAV95B5JKb/bvsWwZ
 NuMr6nw60pIJA2uz4YrzlYw0HwccrRqMLYjHRw4DfyJjdcVwK46s7WqqwmqMJqpJ8DDsbd6xerk
 XM5kjsrcdcowWKTvOlQF7KSmlpCIyK7WFK/58Ao/DPqCbvf3rn3QEf0Om4lFcQEzkuWKAVs34zb
 XYPRfWD3RW7i3oXHD6sDslR9nJxst/Ox4ySGY0cJ53gXxkvZB6Ngo0xRx1ouMpgYSCu8LZpVSis
 YvMWvYTwxO2SS9j2NhDckdbH19I8MyHl27dzfdKrzKew==
Message-ID: <50dfa3d6-a1ca-4492-a3fc-8d8c56b40b43@kwiboo.se>
Date: Sun, 14 Apr 2024 18:58:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/16] pxe: Allow extlinux booting without CMDLINE
 enabled
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: "U-Boot Mailing List" <u-boot@lists.denx.de>
References: <20231215041919.2197788-1-sjg@chromium.org>
 <171279991820.196936.155872099351797064.b4-ty@konsulko.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <171279991820.196936.155872099351797064.b4-ty@konsulko.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 661c0b1e222b0995dec39151
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

Hi Tom and Simon,

On 2024-04-11 03:45, Tom Rini wrote:
> On Thu, 14 Dec 2023 21:18:58 -0700, Simon Glass wrote:
> 
>> This series is the culmanation of the current line of refactoring
>> series. It adjusts pxe to call the booting functionality directly
>> rather than going through the command-line interface.
>>
>> With this is is possible to boot using the extlinux bootmeth without
>> the command line enabled.
>>
>> [...]
> 
> Applied to u-boot/master, thanks!
> 

This series is causing boot issues using extlinux in bootm_run_states():

  ERROR: booting os 'Invalid OS' (0) is not supported

Following extlinux.conf was used:

  label linux
  	kernel /Image.gz
  	initrd /initramfs.cpio.gz

Before this series booting works, bootm_run_states() is first called
with states=0x1 (BOOTM_STATE_START):

  Scanning bootdev 'mmc@fe2b0000.bootdev':
    1  extlinux     ready   mmc          1  mmc@fe2b0000.bootdev.part /extlinux/extlinux.conf
  ** Booting bootflow 'mmc@fe2b0000.bootdev.part_1' with extlinux
  1:      linux
  Retrieving file: /Image.gz
  Retrieving file: /initramfs.cpio.gz
  bootm_run_states(): images->state: 0, states: 1
  bootm_run_states(): images->os.os: 0
  bootm_run_states(): images->os.arch: 0
  bootm_run_states(): boot_fn: 0000000000000000, need_boot_fn: 0
     Uncompressing Kernel Image to 0
  ## Flattened Device Tree blob at edef8410
     Booting using the fdt blob at 0xedef8410
  Working FDT set to edef8410
  bootm_run_states(): images->state: 1, states: 1710
     Loading Ramdisk to ecdfd000, end eceb274d ... OK
  bootm_run_states(): images->os.os: 5
  bootm_run_states(): images->os.arch: 16
  boot_fn: 00000000eff2b83c, need_boot_fn: 0
     Loading Device Tree to 00000000ecde8000, end 00000000ecdfc97f ... OK
  Working FDT set to ecde8000

After this series booting fails, bootm_run_states() is first called
with states=0x1710.

  Scanning bootdev 'mmc@fe2b0000.bootdev':
    1  extlinux     ready   mmc          1  mmc@fe2b0000.bootdev.part /extlinux/extlinux.conf
  ** Booting bootflow 'mmc@fe2b0000.bootdev.part_1' with extlinux
  1:      linux
  Retrieving file: /Image.gz
  Retrieving file: /initramfs.cpio.gz
  bootm_run_states(): images->state: 0, states: 1710
  bootm_run_states(): images->os.os: 0
  bootm_run_states(): images->os.arch: 0
  bootm_run_states(): boot_fn: 0000000000000000, need_boot_fn: 0
  ERROR: booting os 'Invalid OS' (0) is not supported
  Boot failed (err=-14)

Looks like booti_start() -> bootm_run_states(bmi, BOOTM_STATE_START) is
no longer called due to changes in this series.

Regards,
Jonas
