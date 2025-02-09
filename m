Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BC1DC0219B
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 18:31:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 823D8807D7;
	Sun,  9 Feb 2025 19:31:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="FTjd80j5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBE5B807FE; Sun,  9 Feb 2025 19:31:45 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 180D9803B5
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 19:31:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=e522=VB=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1739125901;
 bh=04OxRTR3TQps2Rnyilg+7gP0zKhkhjDMUbxtkCP5u+Y=;
 b=FTjd80j5+OP3F8bE2A3Qm62WLrWRc1e3J5t2BfqfeTdmTeV1zvtJc77CNPHHDs46hSG/MBXft
 LumthNGm49ngeIMayx+NVxcQ8Y6nLzZCtppUth0NkbYgkDJF1TcTd9T1pqreGOv8dY+4F+h3m8K
 Xjttq90vQ1XDczbZxOM1n/IaKr3fHQu3k+sNF+5AUxLD+sW7RTQNNgyeRecD5lQ/D935sUu2I5T
 DjTcn09OgPuoqV70+tHqYA1rDQEFYRfVv2ryD+U4RkJH9wBcCiGbAj3Re/MgjyUNVek8yo25AV9
 isAjOnN8Qdxh2aArYf24an/+jexIPRLZBbGWAk9rCMdg==
X-Forward-Email-ID: 67a8f4891fe61e2e0689cccd
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <6bdb4268-ba0c-4ff7-9019-64d9ef6882b6@kwiboo.se>
Date: Sun, 9 Feb 2025 19:31:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] rockchip: rk3399-gru: Fix missing TPL and SPL banner
 on debug UART
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, u-boot@lists.denx.de
References: <20250208224945.2641933-1-jonas@kwiboo.se>
 <CAFLszTj=NNZ=-uJojzPZ7WZbUe2HVp+OB8M2o2MFbKTHd1fbDw@mail.gmail.com>
 <20250209165856.GO1233568@bill-the-cat>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250209165856.GO1233568@bill-the-cat>
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

Hi,

On 2025-02-09 17:58, Tom Rini wrote:
> On Sun, Feb 09, 2025 at 07:28:38AM -0700, Simon Glass wrote:
>> Hi Jonas,
>>
>> On Sat, 8 Feb 2025 at 15:49, Jonas Karlman <jonas@kwiboo.se> wrote:
>>>
>>> The PP1500 and PP3000 power rails must be on very early for the U-Boot
>>> TPL and SPL banner to be shown on debug UART for bob and kevin.
>>>
>>> This series restore the early power on of these power rails in
>>> board_debug_uart_init() for both TPL and SPL to restore the missing
>>> U-Boot TPL/SPL banner.
>>>
>>> The reverted patches was introduced in v2024.04-rc1.
>>>
>>> Jonas Karlman (3):
>>>   Revert "rockchip: rk3399: Drop unneeded bob and kevin board specific
>>>     code"
>>>   rockchip: rk3399-gru: Enable TPL_GPIO for bob and kevin
>>>   Revert "rockchip: rk3399: Fix TPL build of bob and kevin"
>>>
>>>  arch/arm/mach-rockchip/rk3399/rk3399.c | 23 ++++++++++++++++++++++-
>>>  configs/chromebook_bob_defconfig       |  1 +
>>>  configs/chromebook_kevin_defconfig     |  1 +
>>>  3 files changed, 24 insertions(+), 1 deletion(-)
>>>
>>> --
>>> 2.48.1
>>>
>>
>> Thanks for figuring this out! I'll let Tom run this through the labs.
> 
> You should test it when you rebase your work on top of master again.
> 

Simon did a test-run of these two reverts and the addition of TPL_GPIO
and reported the result over IRC before I posted this series.
See https://www.irccloud.com/pastebin/tYAxuilC/

  $ pe
  e99d2863179 (HEAD) rockchip: rk3399: Enable TPL_GPIO for bob and kevin
  0cf50ad5247 Revert "rockchip: rk3399: Fix TPL build of bob and kevin"
  1973a377839 Revert "rockchip: rk3399: Drop unneeded bob and kevin board specific code"
  c2e00482d00 (us/master, us/WIP/06Feb2025) Merge tag 'xilinx-for-v2025.04-rc2' of https://source.denx.de/u-boot/custodians/u-boot-microblaze
  b3c09eb3652 (us/WIP/05Feb2025, tpm/master) arm64: configs: Remove SYS_BOOTM_LEN for TI devices
  93bcabd9b24 arm: Correct dependency for STATIC_MACH_TYPE
  b16e1db2a07 armv7m: kconfig adds the NVIC option and masks the GIC option when NVIC is selected
  e335f1e3bea Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boot-sh
  0f019056b2d zynqmp: Save "bootseq" environment variable in decimal format
  eade90fd005 arm64: zynqmp: Describe images without TF-A
  $ ub-int bob
  Building U-Boot in sourcedir for chromebook_bob
  Bootstrapping U-Boot from dir /tmp/b/chromebook_bob
  Writing U-Boot using method em100
                                             
  U-Boot TPL 2025.04-rc1-00144-ge99d28631796 (Feb 07 2025 - 07:09:15)
  Channel 0: LPDDR3, 933MHz
  BW=32 Col=10 Bk=8 CS0 Row=15 CS1 Row=15 CS=2 Die BW=16 Size=2048MB
  Channel 1: LPDDR3, 933MHz
  BW=32 Col=10 Bk=8 CS0 Row=15 CS1 Row=15 CS=2 Die BW=16 Size=2048MB
  256B stride
  Trying to boot from BOOTROM
  Returning to boot ROM...
  
  U-Boot SPL 2025.04-rc1-00144-ge99d28631796 (Feb 07 2025 - 07:09:15 -0700)
  Bloblist at 100000 not found (err=-2)
  Trying to boot from SPI
  ## Checking hash(es) for config config-1 ... OK
  ## Checking hash(es) for Image atf-1 ... sha256+ OK
  ## Checking hash(es) for Image u-boot ... sha256+ OK
  ## Checking hash(es) for Image fdt-1 ... sha256+ OK

Regards,
Jonas
