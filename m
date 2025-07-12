Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2D72C83F10
	for <u-boot@archiver.kernel.org>; Sat, 12 Jul 2025 04:49:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D701B805D7;
	Sat, 12 Jul 2025 06:49:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88B0B806D8; Sat, 12 Jul 2025 06:49:21 +0200 (CEST)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AFA2803DF
 for <u-boot@lists.denx.de>; Sat, 12 Jul 2025 06:49:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.54] (unknown [98.97.24.39]) (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 05141B4D10AB;
 Sat, 12 Jul 2025 06:49:17 +0200 (CEST)
Message-ID: <e6083876-b5d4-46cf-8572-7b7fb88a9b09@freeshell.de>
Date: Fri, 11 Jul 2025 21:49:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Please pull net-next-20250708
From: E Shattow <e@freeshell.de>
To: Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
References: <da51a8dd-0171-4197-bac1-6571f134d6fa@linaro.org>
 <e2387d0f-a53b-4534-8f76-f60bbc818807@freeshell.de>
Content-Language: en-US
In-Reply-To: <e2387d0f-a53b-4534-8f76-f60bbc818807@freeshell.de>
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



On 7/11/25 20:12, E Shattow wrote:
> 
> 
> On 7/8/25 02:36, Jerome Forissier wrote:
>> Hi Tom,
>>
>> The following changes since commit b379335f141e3ddca0cdbb5d9d39af0444530542:
>>
>>   configs: Resync with savedefconfig (2025-07-07 14:15:18 -0600)
>>
>> are available in the Git repository at:
>>
>>   https://source.denx.de/u-boot/custodians/u-boot-net.git/ tags/net-next-20250708
>>
>> for you to fetch changes up to 203be3197de1016236f55652ce8ee4cbfe3035ad:
>>
>>   configs: qemu_arm64_lwip_defconfig: enable CMD_SNTP (2025-07-08 11:07:37 +0200)
>>
>> ----------------------------------------------------------------
>> Pull request net-next-20250708
>>
>> lwip:
>> - Call sys_check_timeouts() and schedule() on RX to fix an issue on
>>   boards with a watchdog and simplify the code
>> - Enable IP_FRAG and IP_REASSEMBLY
>> - Add support for setting the TFTP blocksize at runtime
>> - Fix DNS initialization in wget
>> - Add the sntp command
>> - Move code from net/lwip/${cmd}.c to cmd/lwip/${cmd}.c
>>
>> ----------------------------------------------------------------
>> Jerome Forissier (13):
>>       lwip: remove net/lwip/eth_internal.h
>>       lwip: move net/lwip/dns.c to cmd/lwip
>>       lwip: move net/lwip/ping.c to cmd/lwip
>>       lwip: split cmd/net-lwip.c into one file per command
>>       lwip: split net/lwip/wget.c
>>       lwip: dns: do not return CMD_RET_FAILURE on successful resolution
>>       lwip: dns: do not print IP address when a variable is specified
>>       lwip: add net_lwip_dns_resolve()
>>       lwip: ping: accept host name when CONFIG_CMD_DNS=y
>>       net: extract function net_sntp_set_rtc() from sntp_handler()
>>       lwip: add sntp command
>>       doc: add doc/cmd/sntp.rst and remove doc/README.SNTP
>>       configs: qemu_arm64_lwip_defconfig: enable CMD_SNTP
>>
>> Tim Harvey (5):
>>       net: lwip: call sys_check_timeouts and schedule on rx
>>       net: lwip: enable IP_FRAG and IP_REASSEMBLY
>>       net: lwip: tftp: add support for setting blocksize at runtime
>>       net: lwip: move dns init to common function
>>       net: lwip: wget: initialize dns if a hostname is used in a URL
>>
>>  MAINTAINERS                       |   1 +
>>  cmd/Kconfig                       |  13 +++++----
>>  cmd/Makefile                      |   3 +-
>>  cmd/lwip/Makefile                 |   6 ++++
>>  cmd/lwip/dhcp.c                   |   9 ++++++
>>  {net => cmd}/lwip/dns.c           |  33 +++++++--------------
>>  {net => cmd}/lwip/ping.c          |   6 ++--
>>  cmd/lwip/sntp.c                   | 134 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  cmd/lwip/tftp.c                   |   9 ++++++
>>  cmd/lwip/wget.c                   | 222 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  cmd/net-lwip.c                    |  50 --------------------------------
>>  configs/qemu_arm64_lwip_defconfig |   1 +
>>  doc/README.SNTP                   |  17 -----------
>>  doc/usage/cmd/sntp.rst            |  72 ++++++++++++++++++++++++++++++++++++++++++++++
>>  doc/usage/index.rst               |   1 +
>>  include/net-common.h              |  13 +++++++++
>>  include/net-lwip.h                |  16 +++++++++++
>>  lib/lwip/Makefile                 |   1 +
>>  lib/lwip/u-boot/arch/cc.h         |   4 +++
>>  lib/lwip/u-boot/lwipopts.h        |   8 ++++--
>>  net/lwip/Makefile                 |   2 --
>>  net/lwip/dhcp.c                   |   1 -
>>  net/lwip/eth_internal.h           |  35 -----------------------
>>  net/lwip/net-lwip.c               |  81 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  net/lwip/tftp.c                   |   8 ++++--
>>  net/lwip/wget.c                   | 207 ++++-------------------------------------------------------------------------------------------------------------------------------
>>  net/net-common.c                  |  23 +++++++++++++++
>>  net/sntp.c                        |  23 ++-------------
>>  28 files changed, 637 insertions(+), 362 deletions(-)
>>  create mode 100644 cmd/lwip/Makefile
>>  create mode 100644 cmd/lwip/dhcp.c
>>  rename {net => cmd}/lwip/dns.c (80%)
>>  rename {net => cmd}/lwip/ping.c (95%)
>>  create mode 100644 cmd/lwip/sntp.c
>>  create mode 100644 cmd/lwip/tftp.c
>>  create mode 100644 cmd/lwip/wget.c
>>  delete mode 100644 cmd/net-lwip.c
>>  delete mode 100644 doc/README.SNTP
>>  create mode 100644 doc/usage/cmd/sntp.rst
>>  delete mode 100644 net/lwip/eth_internal.h
>>
>> CI link: https://source.denx.de/u-boot/custodians/u-boot-net/-/pipelines/26989
>>
>> Thanks,
> 
> I think this broke something with DNS? Build from 6bb0679377ab with
> starfive_visionfive2_defconfig menuconfig says PROT_DNS_LWIP [=y] but on
> following use of dhcp command then wget use says that DNS is disabled (!?)
> 
> Adding CONFIG_CMD_DNS to the config and all works as expected again. Is
> support for DNS now tied to having the dns command or is that a bug?
> 
> Best regards,
> 
> - E Shattow

P.S. What I describe actually goes back to commit
a383869d6b58b3d66a91460a8b1a6fdcc09a1fe9 ; I'll send a patch.
