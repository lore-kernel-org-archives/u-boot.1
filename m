Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E625C369C2
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 09:50:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F6158070C;
	Tue, 22 Apr 2025 11:50:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DE55810F4; Tue, 22 Apr 2025 11:50:12 +0200 (CEST)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4513A805D7
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 11:50:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.35] (unknown [98.97.24.15]) (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 885E5B4C12AF;
 Tue, 22 Apr 2025 11:50:08 +0200 (CEST)
Message-ID: <ff43d790-6f54-4207-a1e3-18594c64f0b5@freeshell.de>
Date: Tue, 22 Apr 2025 02:50:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] board: starfive: visionfive2: Drop setting of
 $fdtfile
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
References: <20250422064541.635210-1-e@freeshell.de>
 <20250422064541.635210-3-e@freeshell.de>
 <7C8FD49C-EDAD-45C5-8800-104D9CAAB372@gmx.de>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <7C8FD49C-EDAD-45C5-8800-104D9CAAB372@gmx.de>
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

On 4/22/25 00:28, Heinrich Schuchardt wrote:
> Am 22. April 2025 08:45:26 MESZ schrieb E Shattow <e@freeshell.de>:
>> Remove board detection logic from main payload that is duplicated from SPL
>> and do not set convenience data into $fdtfile environment variable. U-Boot
>> "starfive visionfive2" board target(s) now boot on recent upstream Linux
>> Kernel releases without this manipulation since the JH7110 OF_UPSTREAM
>> migration. Changes to $fdtfile by users (i.e. following newer or older Linux
>> Kernel releases) should follow the advice in general U-Boot documentation.
> 

> We cannot expect that users have a U-Boot installed in SPI flash that matches the Linux they intend to boot.

Yes, but we must. We cannot expect that EFI System Partition will
contain the correct single dtb compatible for many on-disk versions of
Linux Kernel that we have no possible way to know which one will be
booted. This is not any better... we're chasing a problem that is not in
our domain.

From the downstream userland there's limits to U-Boot EFI variable
writing (yes, still today? or has this changed) that prevent U-Boot from
being informed by Linux distro-managed installation about the correct
device-tree pairings for Linux Kernel boot entries that should be loaded.

If that (EFI variable writing) were usable then we don't have to do
anything in U-Boot since it's a userland issue of parsing the model and
figuring this out when updating EFI variables.

In case of non-EFI then we're still doing it wrong and also not
consistently over U-Boot boards that are OF_UPSTREAM;  there would be a
mess of `fdt print` parsing to try and implement it as a U-Boot
script... and I don't know of any userland boot menu updating tools that
try to parse out the dtb path from Fdt as of yet, at least not for the
jh7110 targets I am familiar with.

The strategy I like to think of here is to make this generic and
maintainable. Current approach to copy-paste detection logic duplicated
from each U-Boot board target SPL to main payload init logic... it
served some immediate needs to get riscv64 over the starting line with
Linux distros but it smells weird and should get cleaned out.

> 
> Linux is known to break device-tree compatibility between versions.

U-Boot releases from before JH7110 OF_UPSTREAM migration would just do
wrong things because its internal Fdt was not consistent with any
release version of Linux Kernel. Now since OF_UPSTREAM it is consistent
with some known release version of upstream Linux Kernel. You can say
now with certainty that U-Boot release 'x' will work with Linux Kernel
version 'y' and intermediary boot loader versions (i.e. GRUB).

> 
> Without U-Boot providing a value of $fdtfile that matches the board, U-Boot will not pick up the device-tree on the ESP of Ubuntu's installer image which matches the kernel version.

Meanwhile, require a certain release version of U-Boot for a given
release of the (distro) installer, and then (distro) fixes userspace to
do something more robust. If making EFI variable setting outside of
U-Boot work properly is not feasible, and you must keep fdtfile var
setting, then on to your next point that it should be *consistent* and
general, applying to all OF_UPSTREAM board targets across U-Boot.

> 
> Please, keep U-Boot providing a value of $fdtfile that matches the actual board.
> 
> It would be preferable if that name could be based on the choice of the configuration by SPL instead of duplicating the logic. But I am not aware of logic that provides the configuration name to main U-Boot. Maybe we should simply match the model or conpatible string.
> 

Yes, Heinrich. For Simon, do you have any thoughts on this? The question
is broadly: we have this callback at SPL phase that selects for dtb from
multi fit and how can we bring some information of that outcome (namely
the dtb pathname) forward to the U-Boot main payload?

Is this to be a new (or existing? fdt print?) scripting command that
emits such info? An immutable env variable (such that i.e. `env set
fdtfile ${ofmake}/${ofmodel}.dtb` is valid for pre-boot) ?

-E

> Best regards
> 
> Heinrich 
> 
>>
>> Signed-off-by: E Shattow <e@freeshell.de>
>> ---
>> .../visionfive2/starfive_visionfive2.c        | 61 -------------------
>> 1 file changed, 61 deletions(-)
>>
>> diff --git a/board/starfive/visionfive2/starfive_visionfive2.c b/board/starfive/visionfive2/starfive_visionfive2.c
>> index b8cd509bc89..039a32f1874 100644
>> --- a/board/starfive/visionfive2/starfive_visionfive2.c
>> +++ b/board/starfive/visionfive2/starfive_visionfive2.c
>> @@ -17,14 +17,6 @@
>> DECLARE_GLOBAL_DATA_PTR;
>> #define JH7110_L2_PREFETCHER_BASE_ADDR		0x2030000
>> #define JH7110_L2_PREFETCHER_HART_OFFSET	0x2000
>> -#define FDTFILE_MILK_V_MARS \
>> -	"starfive/jh7110-milkv-mars.dtb"
>> -#define FDTFILE_VISIONFIVE2_1_2A \
>> -	"starfive/jh7110-starfive-visionfive-2-v1.2a.dtb"
>> -#define FDTFILE_VISIONFIVE2_1_3B \
>> -	"starfive/jh7110-starfive-visionfive-2-v1.3b.dtb"
>> -#define FDTFILE_PINE64_STAR64 \
>> -	"starfive/jh7110-pine64-star64.dtb"
>>
>> /* enable U74-mc hart1~hart4 prefetcher */
>> static void enable_prefetcher(void)
>> @@ -45,51 +37,6 @@ static void enable_prefetcher(void)
>> 	}
>> }
>>
>> -/**
>> - * set_fdtfile() - set the $fdtfile variable based on the board revision
>> - */
>> -static void set_fdtfile(void)
>> -{
>> -	u8 version;
>> -	const char *fdtfile;
>> -	const char *product_id;
>> -
>> -	fdtfile = env_get("fdtfile");
>> -	if (fdtfile)
>> -		return;
>> -
>> -	product_id = get_product_id_from_eeprom();
>> -	if (!product_id) {
>> -		log_err("Can't read EEPROM\n");
>> -		return;
>> -	}
>> -	if (!strncmp(product_id, "MARS", 4)) {
>> -		fdtfile = FDTFILE_MILK_V_MARS;
>> -	} else if (!strncmp(product_id, "VF7110", 6)) {
>> -		version = get_pcb_revision_from_eeprom();
>> -
>> -		switch (version) {
>> -		case 'a':
>> -		case 'A':
>> -			fdtfile = FDTFILE_VISIONFIVE2_1_2A;
>> -			break;
>> -
>> -		case 'b':
>> -		case 'B':
>> -		default:
>> -			fdtfile = FDTFILE_VISIONFIVE2_1_3B;
>> -			break;
>> -		}
>> -	} else if (!strncmp(product_id, "STAR64", 6)) {
>> -		fdtfile = FDTFILE_PINE64_STAR64;
>> -	} else {
>> -		log_err("Unknown product\n");
>> -		return;
>> -	}
>> -
>> -	env_set("fdtfile", fdtfile);
>> -}
>> -
>> int board_init(void)
>> {
>> 	enable_caches();
>> @@ -98,14 +45,6 @@ int board_init(void)
>> 	return 0;
>> }
>>
>> -int board_late_init(void)
>> -{
>> -	if (CONFIG_IS_ENABLED(ID_EEPROM))
>> -		set_fdtfile();
>> -
>> -	return 0;
>> -}
>> -
>> int board_fdt_blob_setup(void **fdtp)
>> {
>> 	if (gd->arch.firmware_fdt_addr) {
> 

