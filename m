Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B1DFD2ECF7
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 12:09:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82A5583A8F;
	Tue, 20 Jan 2026 13:09:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="CclGI0UB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A7E183A9F; Tue, 20 Jan 2026 13:09:28 +0100 (CET)
Received: from mxout2.routing.net (mxout2.routing.net [IPv6:2a03:2900:1:a::b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B48783A8D
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 13:09:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=linux@fw-web.de
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
 by mxout2.routing.net (Postfix) with ESMTP id 8BB44601CC;
 Tue, 20 Jan 2026 12:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
 s=routing; t=1768910964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BMhFZWd/605NWR6tzl3ezQUty2CpZYcmd7OUJbjzNmE=;
 b=CclGI0UBQYNh5vO1GrDkMnEfuvxlWaKvxxumcjD2+TMyE/StUNqwRQCOmrMVnnUlI31j6T
 nw45l0B2ZSMnV+cTfIgvQEMzSFpmX4klnVB1HlchoH6kH54+Xwpdut5MWxdMmAArkaQGdy
 WSe7GA1f601ysM9bGjDLwc1O2vWZGgQ=
Received: from ehlo.thunderbird.net (unknown
 [IPv6:2a01:599:a30:b62f:dfc6:3662:ef04:540b])
 by mxbox2.masterlogin.de (Postfix) with ESMTPSA id 2AE4D10029A;
 Tue, 20 Jan 2026 12:09:24 +0000 (UTC)
Date: Tue, 20 Jan 2026 13:09:23 +0100
From: Frank Wunderlich <linux@fw-web.de>
To: Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
CC: Frank Wunderlich <frank-w@public-files.de>, u-boot@lists.denx.de,
 Daniel Golle <daniel@makrotopia.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4=5D_cmd=3A_mem=3A_add_function_?=
 =?US-ASCII?Q?for_getting_ram_size_for_use_in_scripts?=
User-Agent: K-9 Mail for Android
In-Reply-To: <7906ae57-4700-48fd-8740-66b8626640f1@cherry.de>
References: <20260118105021.19760-1-linux@fw-web.de>
 <7906ae57-4700-48fd-8740-66b8626640f1@cherry.de>
Message-ID: <1CBAB275-C7DD-4E52-87D8-B648BE9A4981@fw-web.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mail-ID: 1cc5c7d4-41c9-47bd-a6ae-ba08f1e41c30
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

Hi

Thank you for your review

Am 19=2E Januar 2026 11:22:07 MEZ schrieb Quentin Schulz <quentin=2Eschulz=
@cherry=2Ede>:
>Hi Frank,
>
>On 1/18/26 11:50 AM, Frank Wunderlich wrote:
>> From: Frank Wunderlich <frank-w@public-files=2Ede>
>>=20
>> Add a command for getting detected ram size with possibility to write
>> to environment variable=2E
>>=20
>> example usage:
>>=20
>> BPI-R4> msize
>> 4294967296
>> BPI-R4> msize m
>> 4096m
>> BPI-R4> msize g
>> 4g
>> BPI-R4> msize g ramsize
>> BPI-R4> printenv ramsize
>> ramsize=3D4
>> BPI-R4>
>>=20
>> board with 8GB ram:
>>=20
>> BPI-R4> msize
>> 8589934592
>> BPI-R4> msize m
>> 8192m
>> BPI-R4> msize g
>> 8g
>> BPI-R4> msize g ramsize
>> BPI-R4> printenv ramsize
>> ramsize=3D8
>> BPI-R4>
>>=20
>> Signed-off-by: Frank Wunderlich <frank-w@public-files=2Ede>
>> ---
>> v4: drop rounding to full MB/GB as it leads to wrong display
>> v3: add missing ifdefs
>> v2: add Kconfig entry
>> ---
>>   cmd/Kconfig |  5 +++++
>>   cmd/mem=2Ec   | 32 ++++++++++++++++++++++++++++++++
>>   2 files changed, 37 insertions(+)
>>=20
>> diff --git a/cmd/Kconfig b/cmd/Kconfig
>> index 5c611fb3016e=2E=2Eb82b17195b7e 100644
>> --- a/cmd/Kconfig
>> +++ b/cmd/Kconfig
>> @@ -974,6 +974,11 @@ config CMD_RANDOM
>>   	help
>>   	  random - fill memory with random data
>>   +config CMD_MEMSIZE
>> +	bool "memsize"
>> +	help
>> +	  Get RAM via command for use in scripts=2E
>> +
>
>Only available if CMD_MEMORY is set, so need a depends on=2E
>
>I'm wondering if this new command isn't more suited in cmd/meminfo=2Ec? M=
aybe even extend the meminfo command instead of creating a new one?

Can put it in meminfo too with depency cmd_memory=2E

>>   config CMD_MEMTEST
>>   	bool "memtest"
>>   	help
>> diff --git a/cmd/mem=2Ec b/cmd/mem=2Ec
>> index d5d7ca2790bd=2E=2E9dcfeacbbcc5 100644
>> --- a/cmd/mem=2Ec
>> +++ b/cmd/mem=2Ec
>> @@ -33,6 +33,7 @@
>>   #include <linux/compiler=2Eh>
>>   #include <linux/ctype=2Eh>
>>   #include <linux/delay=2Eh>
>> +#include <linux/sizes=2Eh>
>>     DECLARE_GLOBAL_DATA_PTR;
>>   @@ -711,6 +712,29 @@ static int do_mem_loopw(struct cmd_tbl *cmdtp, i=
nt flag, int argc,
>>   }
>>   #endif /* CONFIG_LOOPW */
>>   +#ifdef CONFIG_CMD_MEMSIZE
>> +static int do_mem_size(struct cmd_tbl *cmdtp, int flag, int argc,
>> +		       char *const argv[])
>> +{
>> +	u64 memsize =3D gd->ram_size;
>> +
>> +	if (argc > 1) {
>> +		if (!strcmp(argv[1], "m"))
>> +			memsize =3D memsize / SZ_1M;
>> +		else if (!strcmp(argv[1], "g"))
>> +			memsize =3D memsize / SZ_1G;
>> +		if (argc > 2)
>> +			env_set_ulong(argv[2], memsize);
>> +		else
>> +			printf("%lld%s\n", memsize, argv[1]);
>> +	} else {
>> +		printf("%lld\n", memsize);
>> +	}
>
>Flatten this like so:
>
>"""
>if (argc <=3D 1) {
>    printf("%lld\n", memsize);
>    return 0;
>}
>
>if (!strcmp(argv[1], "m"))
>    memsize =3D memsize / SZ_1M;
>else if (!strcmp(argv[1], "g"))
>    memsize =3D memsize / SZ_1G;
>if (argc > 2)
>    env_set_ulong(argv[2], memsize);
>else
>    printf("%lld%s\n", memsize, argv[1]);
>return 0;
>"""
>
>Otherwise I see a few issues:
>- rounding not made explicit, (also it's truncating and not rounding I be=
lieve here?)=2E Why not print the actual value here as a float (of course, =
not using floats)? I vaguely remember some of my Rockchip board printing 1=
=2E5GiB when booting up (cannot verify because this happens due to a bug in=
 the SDRAM init and isn't easily reproducible)=2E We do have some boards wi=
th 256, 512MiB of RAM so we should be clear whether we are printing 0 or 0=
=2E25 since that will influence how to do math operations with the variable=
 containing the value=2E

I have dropped my previous round because it leads to wrong values and i wa=
nted to avoid floating point numbers=2E But yes 2 decimal digits seem to be=
 needed to give correct output=2E I guess var is then string,not any floati=
ng point type=2E

So for GB sonething like this:

u64 ram_gb_x100 =3D GB_X100(gd->ram_size);
char buf[16];

snprintf(buf, sizeof(buf), "%llu=2E%02llu",
         ram_gb_x100 / 100,
         ram_gb_x100 % 100);

env_set("ram_size_gb", buf);

>- what if I want to save the byte size in a variable? With the current im=
plementation, only mebibyte or gibibyte sizes can be stored=2E I would sugg=
est to argc-- if m or g is passed, and then compare against argc > 1 in whi=
ch case you'd use this third (in case m or g is passed) or second (if they =
aren't) argument to store the value=2E

Good idea, thinking about how to implement this the correct way :) as varn=
ame could be "g" or "b" too=2E

>- missing documentation on the base for the environment variable=2E We ha=
ve some commands setting hex digits in variables, some others in decimal, s=
o this needs to be made explicit so that people know if they need to transl=
ate stuff before using it (or how to compare two numbers against each other=
)=2E Here it's decimal according to the code (maybe we should have it in he=
x instead? I am not sure what is the expected base for variables :/)=2E

As i want to use it in scripts to choose correct bl2 file for bananapi r4=
=2E Imho decimal is better to read here,but it should be mentioned in doc=
=2E

>> +
>> +	return 0;
>> +}
>> +#endif /* CONFIG_CMD_MEMSIZE */
>> +
>>   #ifdef CONFIG_CMD_MEMTEST
>>   static ulong mem_test_alt(volatile ulong *buf, ulong start_addr, ulon=
g end_addr,
>>   			  volatile ulong *dummy)
>> @@ -1404,6 +1428,14 @@ U_BOOT_CMD(
>>   );
>>   #endif /* CONFIG_LOOPW */
>>   +#ifdef CONFIG_CMD_MEMSIZE
>> +U_BOOT_CMD(
>> +	msize,	3,	1,	do_mem_size,
>> +	"get detected ram size, optional set env variable with value",
>> +	"[m, g] [envvar]"
>
>Explain m and g so the user knows when typing help msize=2E
>
>We need tests in test/cmd/ and a new entry in doc/usage/cmd/ for this new=
 command=2E

I see this note in checkpatch,but as i rely on dynamic value and i saw no =
test for mem yet=2E

>Cheers,
>Quentin


regards Frank
