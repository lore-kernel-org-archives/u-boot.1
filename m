Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC38C36014
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 20:57:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B6BF8215D;
	Thu,  3 Apr 2025 22:57:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="DCyZgSix";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA04C8219D; Thu,  3 Apr 2025 22:57:37 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A5648215B
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 22:57:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=fb97=WW=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1743713854;
 bh=w1YdQ4zrQpKqdEwiiKwUFPXh6nX9hHTsbOPE4exlCFA=;
 b=DCyZgSix4/sR9ief6MHmNHu5myzOdFeTQ+a3On2isUihq0ipgAr+4vls3wDmMzF4d3VJJY1Bm
 XIoCpVr6y2l5T/qmUHb1yq1lcOkrWLyTmkrUXWYde4cPZ2EzMzwl+uhSawrnAu4S4wafymGudzH
 A/1LD6aQ3QUMUjm3v4ojz4QOZrsCljK+yVWeMI5wSVCVeR47nuX6kdCHB6duA2ZGIOeRQkM5WXP
 dWU6SJH/uEUkZQynZ3yMlOA+1tM5LYOLVNj5v18Do50o/60x+Ab3Sy10zNew3R23g8VBgOoFztX
 A5V+DGdpY1YRHnE7GNBujFCgrL5Z8jt41HSZiLC3RzfQ==
X-Forward-Email-ID: 67eef63bf162ea8456d8692e
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.0.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <10a57d25-d484-4903-8f25-e373c451bc21@kwiboo.se>
Date: Thu, 3 Apr 2025 22:57:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/29] pxe: Precursor series for supporting read_all()
 in extlinux / PXE
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Adriano Cordova <adrianox@gmail.com>,
 Albert Aribaud <albert.u.boot@aribaud.net>, Bin Meng <bmeng.cn@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Julien Masson <jmasson@baylibre.com>, Leo <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Peter Korsgaard <peter@korsgaard.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Ramon Fried
 <rfried.dev@gmail.com>, Rick Chen <rick@andestech.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
References: <20250306002533.2380866-1-sjg@chromium.org>
 <174234008117.1788726.14383009154862416750.b4-ty@konsulko.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <174234008117.1788726.14383009154862416750.b4-ty@konsulko.com>
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

Hi Tom and Simon,

On 2025-03-19 00:21, Tom Rini wrote:
> On Wed, 05 Mar 2025 17:24:54 -0700, Simon Glass wrote:
> 
>> This series includes some patches related to allowing read_all() to be
>> used with the extlinux / PXE bootmeths.
>>
>> These patches were split out from the stb4 series, since it will need to
>> have additional patches for LWIP, to avoid breaking PXE booting when
>> LWIP is used.
>>
>> [...]
> 
> Applied to u-boot/next, thanks!

This series broke booting a compressed arm64 defconfig Linux kernel
(without module loading) due to changes in decompression buffer length.

My arm64 defconfig kernel (Image.gz) is ~24 MiB compressed and ~85 MiB
uncompressed.

Before this series the decompression buffer was 10x the kernel_comp_size
and now it is instead limited by the SYS_BOOTM_LEN Kconfig symbol.

A broken boot using current next branch:

  Retrieving file: /Image.gz
  Retrieving file: /initramfs.cpio.gz
  append: earlycon
  cmd 'booti' states 1f1f addr_img '0x02080000' conf_ramdisk '0x06000000:394d3c' conf_fdt '3df16350' images 000000003ffe53a0
     kernel data at 0x02080000, len = 0x00000000 (0)
  load 2080000 start 2080000 len 0 ep 0 os 5 comp 1
  find_other type 2 os 5
  ## Flattened Device Tree blob at 3df16350
     Booting using the fdt blob at 0x3df16350
  Working FDT set to 3df16350
  load_os load 8000000 image_start 2080000 image_len 2000000
     Uncompressing Kernel Image to 8000000
  Error: inflate() returned -5
  Image too large: increase CONFIG_SYS_BOOTM_LEN
  Must RESET board to recover
  Resetting the board...

Changing SYS_BOOTM_LEN from default 64 MiB to 128 MiB fixed the boot:

  Retrieving file: /Image.gz
  Retrieving file: /initramfs.cpio.gz
  append: earlycon
  cmd 'booti' states 1f1f addr_img '0x02080000' conf_ramdisk '0x06000000:394d3c' conf_fdt '3df16430' images 000000003ffe5480
     kernel data at 0x02080000, len = 0x00000000 (0)
  load 2080000 start 2080000 len 0 ep 0 os 5 comp 1
  find_other type 2 os 5
  ## Flattened Device Tree blob at 3df16430
     Booting using the fdt blob at 0x3df16430
  Working FDT set to 3df16430
  load_os load 8000000 image_start 2080000 image_len 2000000
     Uncompressing Kernel Image to 8000000
     kernel loaded at 0x08000000, end = 0x0d3b5a00
     Loading Ramdisk to 3cb51000, end 3cee5d3c ... OK
     Loading Device Tree to 000000003cb3f000, end 000000003cb509df ... OK
  Working FDT set to 3cb3f000

  Starting kernel ...

Do we need to increase the default SYS_BOOTM_LEN for ARM64 now?

Regards,
Jonas

> 
> [01/29] x86: Make do_zboot_states() static
>         commit: 299d24eddfeb18a7576187b3010d5462317335e9
> [02/29] x86: Rename zboot_run() to zboot_run_args()
>         commit: 95641f4bf98d3c90bfc4ae94515c98c440ffb2e1
> [03/29] x86: Drop duplicate definition of zimage_dump()
>         commit: 2de073527bb92b47d49366249cd3fdea5016bcaf
> [04/29] x86: Move x86 zboot state into struct bootm_info
>         commit: 75e85df7963f57e4bb80b3d805ba2295b1843911
> [05/29] x86: Rename state to bmi
>         commit: 00cfb598e740d8bad79097e7e069ad71d86bbd5a
> [06/29] x86: Move the bootm state for zimage into cmd/
>         commit: 4e36b1739b03e81ff395959b58fe33e67c4d2233
> [07/29] bootstd: Correct display of kernel version
>         commit: 1592ff27d502efdc79992f57c07ff0cf81bc9305
> [08/29] x86: Drop the unnecessary base_ptr argument to zboot_dump()
>         commit: c73da92304280b229e3d8dfd565fae5a24fe3ce8
> [09/29] boot: Use strlcpy() in label_boot()
>         commit: 0fd3ed1cd73d6b262c204c27cbe6dc1ad1c09e91
> [10/29] boot: Split pxe label_boot() into two parts
>         commit: ff9fef41fe4d329a5c76746cc45f9fbf8fdb9b12
> [11/29] boot: Split pxe label_run_boot() into two parts
>         commit: f6aa262f55b78e3a21dd020e47601320c2edec4e
> [12/29] boot: Pass just the FDT argument to label_process_fdt()
>         commit: 600bc21da54a300f2825a5e3088719b1ffd5ee53
> [13/29] bootm: Allow building bootm.c without CONFIG_SYS_BOOTM_LEN
>         commit: 7f10a7fe126dce5644d933af693eda40497d7755
> [14/29] boot: Convert IMAGE_FORMAT into an enum
>         commit: 3c7b13b075488ebcff2923b0a7b46cc11f39285e
> [15/29] boot: arm: riscv: sandbox: Add a format for the booti file
>         commit: 098407e67390ed0c369029bab0777a51e5a7bad2
> [16/29] boot: Support booti format in bootm
>         commit: d6bb0ea535e4384ed1975ee9c755488f5036a79e
> [17/29] boot: Support compressed booti images in bootm
>         commit: ecd50bb4643c9052e5f8b6171ab6c3905ed0ca70
> [18/29] boot: pxe: Use bootm_...() functions where possible
>         commit: b13408021d361fbae1c254307f139ad1e6def3d2
> [19/29] pxe_utils: Simplify default fdt in label_run_boot()
>         commit: feb8d7fd749413e889ba2c396654f473ba32034d
> [20/29] boot: pxe: Refactor label_run_boot() to avoid cmdline
>         commit: e2e87b840162ddf4ec8df3f235be98a74a964509
> [21/29] net: Keep the bootstage functions together
>         commit: 2c04afbc957d18e61813315a0694db903754a280
> [22/29] net: Tidy up the comments to parse_args()
>         commit: 3ccbc10cd9e3b28d67fe5008943a648b870db1e6
> [23/29] net: Simplify parse_args()
>         commit: f1ece5d86e5577ae9bb3325d65ed7003f3cbaf9e
> [24/29] net: Return the load address from parse_args()
>         commit: 4b6070e056fc2c11b7621c32151f95f7a045ac01
> [25/29] net: Return the address and size from parse_addr_size()
>         commit: f60421204816bd0aa40e9e43c18d4bc5861d3521
> [26/29] net: Return the size from parse_args()
>         commit: 25d51d3c798f6e256daa628bb2a9fcc36fde0382
> [27/29] net: Refactor part of netboot_common() into a function
>         commit: bfffdfaaf6f492865100197a5b141482799afc09
> [28/29] net: Drop #ifdef in parse_args()
>         commit: f278f0cb4996398720328ce33e057678f6ea4109
> [29/29] net: Provide a function to run network operations
>         commit: 0f094b8b146679c3980cd2febde4e902bbc4405d

