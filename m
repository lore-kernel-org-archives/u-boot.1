Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 600FFD715C7
	for <u-boot@archiver.kernel.org>; Sat, 24 Jan 2026 06:28:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E34383B86;
	Sat, 24 Jan 2026 07:28:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="N6U0s88m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9739683B99; Sat, 24 Jan 2026 07:28:40 +0100 (CET)
Received: from mxout2.routing.net (mxout2.routing.net [IPv6:2a03:2900:1:a::b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5ADC83B72
 for <u-boot@lists.denx.de>; Sat, 24 Jan 2026 07:28:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=linux@fw-web.de
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
 by mxout2.routing.net (Postfix) with ESMTP id 8BF445FCAD;
 Sat, 24 Jan 2026 06:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
 s=routing; t=1769236116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LwrkD5VFIdrGZZfnhl8Nv/zufxsvJs+SFJv5VVvV/gA=;
 b=N6U0s88mJ7n9Z9Z58OENRyb30XWU5SjvtzV/EvW9B+5ivvzu+uJvPKMumqrMzobIyWz0+A
 ufPd6ubDR/VnbGMh91yICu9ikiAA1Jj0rWdT8YyLxkRdq8EhU555coxXpNqAqfK6NQepYS
 3laEdogbN9MDA+i+GUF/LYjjMpkLs0A=
Received: from ehlo.thunderbird.net (fttx-pool-80.245.78.113.bambit.de
 [80.245.78.113])
 by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 262B136009F;
 Sat, 24 Jan 2026 06:28:36 +0000 (UTC)
Date: Tue, 20 Jan 2026 20:54:44 +0100
From: Frank Wunderlich <linux@fw-web.de>
To: Quentin Schulz <quentin.schulz@cherry.de>, frank-w@public-files.de,
 Tom Rini <trini@konsulko.com>
CC: u-boot@lists.denx.de, Daniel Golle <daniel@makrotopia.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4=5D_cmd=3A_mem=3A_add_function_?=
 =?US-ASCII?Q?for_getting_ram_size_for_use_in_scripts?=
User-Agent: K-9 Mail for Android
In-Reply-To: <051b12b8-cd2a-418a-bea1-d08ed8b61516@cherry.de>
References: <20260118105021.19760-1-linux@fw-web.de>
 <7906ae57-4700-48fd-8740-66b8626640f1@cherry.de>
 <1CBAB275-C7DD-4E52-87D8-B648BE9A4981@fw-web.de>
 <585f12d6-4d4e-46b3-ab52-049adf7d216e@cherry.de>
 <BC982812-6A96-4B47-A7CB-3F2DE868CCEC@public-files.de>
 <051b12b8-cd2a-418a-bea1-d08ed8b61516@cherry.de>
Message-ID: <2A8E4C03-402F-439D-B366-EB1D2DBA0A82@fw-web.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mail-ID: 9ffe026f-0ef5-4c85-b3cd-f660159ccf33
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

Am 20=2E Januar 2026 18:55:55 MEZ schrieb Quentin Schulz <quentin=2Eschulz@=
cherry=2Ede>:
>Hi Frank,
>
>On 1/20/26 5:09 PM, Frank Wunderlich wrote:
>> Hi Quentin,
>>=20
>> Am 20=2E Januar 2026 13:47:00 MEZ schrieb Quentin Schulz <quentin=2Esch=
ulz@cherry=2Ede>:
>>> Hi Frank,
>>>=20
>>> On 1/20/26 1:09 PM, Frank Wunderlich wrote:
>>>> Hi
>>>>=20
>>>> Thank you for your review
>>>>=20
>>>> Am 19=2E Januar 2026 11:22:07 MEZ schrieb Quentin Schulz <quentin=2Es=
chulz@cherry=2Ede>:
>>>>> Hi Frank,
>>>>>=20
>>>>> On 1/18/26 11:50 AM, Frank Wunderlich wrote:
>>>=20
>
>[=2E=2E=2E]
>>>>> - what if I want to save the byte size in a variable? With the curre=
nt implementation, only mebibyte or gibibyte sizes can be stored=2E I would=
 suggest to argc-- if m or g is passed, and then compare against argc > 1 i=
n which case you'd use this third (in case m or g is passed) or second (if =
they aren't) argument to store the value=2E
>>>>=20
>>>> Good idea, thinking about how to implement this the correct way :) as=
 varname could be "g" or "b" too=2E
>>>>=20
>>>=20
>>> You could also force the use of the first argument to be able to dump =
to a variable=2E
>>>=20
>>> memsize
>>> memsize b|m|g [varname]
>>>=20
>>> memsize would be an alias to memsize b=2E
>>> memsize b var stores the byte size in var=2E
>>> memsize m var stores the (truncated) mebibyte size in var=2E
>>> memsize g var stores the (truncated) gibibyte size in var=2E
>>=20
>> I could also drop the first param and always handle as MiB=2E=2E=2Euboo=
t also prints ram as MiB and not GiB on initialization=2E
>>=20
>
>It does print GiB on Rockchip SoCs, so there doesn't seem to be a "standa=
rd" for that=2E
>
>> So only choose between print or set variable and no "floating point" ca=
lculation needs to be
>> done=2E=2E=2Eand result is simply an int=2E Afaik there should be no mo=
re boards with less than 1MB
>> ram,or am i wrong?
>
>Not aware but that would be quite the headache (you need to load *some* s=
tuff in RAM, e=2Eg=2E U-Boot itself (well maybe it could be in SRAM only?),=
 the kernel)=2E I would say, it's fine to truncate at MiB level=2E
>
>> I think this makes most sense=2E=2Eand keeps code small and clean=2E
>>=20
>>> You could also decide the prefix your size argument with a dash and if=
 no argument with a dash is passed, it means it's a variable name and the d=
efault is in byte size=2E
>>>=20
>>>>> - missing documentation on the base for the environment variable=2E =
We have some commands setting hex digits in variables, some others in decim=
al, so this needs to be made explicit so that people know if they need to t=
ranslate stuff before using it (or how to compare two numbers against each =
other)=2E Here it's decimal according to the code (maybe we should have it =
in hex instead? I am not sure what is the expected base for variables :/)=
=2E
>>>>=20
>>>> As i want to use it in scripts to choose correct bl2 file for bananap=
i r4=2E Imho decimal is better to read here,but it should be mentioned in d=
oc=2E
>>>>=20
>>>=20
>>> OK=2E Considering test (https://docs=2Eu-boot=2Eorg/en/latest/usage/cm=
d/test=2Ehtml#numbers) compares numbers assuming they're decimal if they do=
n't start with 0x, this is fine to do (we would need to prefix the number w=
ith 0x if we were to store it as an hex value)=2E
>>=20
>> But this means numbers can be no fload and filesize is wrong as it retu=
rns hex value without 0x prefix=2E
>>=20
>
>Yes to both=2E I was actually agreeing with your implementation (using de=
cimal) being the best option because we can directly use it with the test c=
ommand=2E
>
>>> Can you tell us more about the initial issue and how you plan on fixin=
g it here?
>>>=20
>>> That sounds like a board file (board/=2E=2E=2E=2E) would be potentiall=
y more appropriate for this? What is this bl2, why does it need to be diffe=
rent based on DRAM size, isn't there anyway for U-boot to pass the DRAM siz=
e to bl2 and only have one bl2 binary for example?
>>=20
>> BL2 is bootloader after bootrom (ATF)=2E The board can have 2 different=
 ram hw
>
>Is this a typo? You say later that you want U-Boot to select the proper B=
L2, so necessarily U-Boot is loaded before BL2 by the BootROM?
>
>Do you mean ATF to be "bootrom" or bl2 here? (I'm assuming the latter)=2E

Bootrom (hardware bootup) -> atf bl2 -> uboot packed into bl31=2E

>> configurations which require BL2 compiled with different options set=2E=
 The purpose for uboot
>> command is checking available ram for updating the BL2 via tftp and pic=
king the right
>> file based on current installed bl2 via detected ramsize=2E
>>=20
>> The issue is that 4gb board does not boot with 8gb ram bl2, 8gb board b=
oots with 4gb bl2,but
>> cannot use the 8gb (only 4gb)=2E So i tried to make a detection mechani=
sm to select the right
>> file (tftp,usb,=2E=2E=2E) for current ram configuration=2E
>>=20
>
>If BL2 is TF-A, do you have an open-source implementation for your board =
(maybe https://github=2Ecom/mtk-openwrt/arm-trusted-firmware?)? Would it be=
 possible to pass e=2Eg=2E a Device Tree to TF-A to pass some information? =
I'm assuming we must be configuring somewhere the DRAM address ranges so th=
e kernel knows where to put stuff=2E On Rockchip, we use the Device Tree in=
 TF-A (ATF) to know to which serial controller to write to and at which bau=
drate (downstream TF-A blob from Rockchip doesn't support that), wondering =
if we can do something similar for Mediatek? This way you don't need to kno=
w at runtime what to do, it'll automagically do it, and that for every boar=
d with the SoC supported in TF-A=2E

Yes this repo and yes TF-A,but there is no way to detect ramsize / or conf=
ig automaticly in bl2=2E Dram calibration is a binary blob there=2E So we h=
ave to flash the right bl2 and use uboot to update to=20
newer version or to another bootdevice (sdmmc -> spi nand -> emmc=2E So my=
 usecase is=20
for installing/updating bl2 only=2E

>>>>>> +
>>>>>> +	return 0;
>>>>>> +}
>>>>>> +#endif /* CONFIG_CMD_MEMSIZE */
>>>>>> +
>>>>>>     #ifdef CONFIG_CMD_MEMTEST
>>>>>>     static ulong mem_test_alt(volatile ulong *buf, ulong start_addr=
, ulong end_addr,
>>>>>>     			  volatile ulong *dummy)
>>>>>> @@ -1404,6 +1428,14 @@ U_BOOT_CMD(
>>>>>>     );
>>>>>>     #endif /* CONFIG_LOOPW */
>>>>>>     +#ifdef CONFIG_CMD_MEMSIZE
>>>>>> +U_BOOT_CMD(
>>>>>> +	msize,	3,	1,	do_mem_size,
>>>>>> +	"get detected ram size, optional set env variable with value",
>>>>>> +	"[m, g] [envvar]"
>>>>>=20
>>>>> Explain m and g so the user knows when typing help msize=2E
>>>>>=20
>>>>> We need tests in test/cmd/ and a new entry in doc/usage/cmd/ for thi=
s new command=2E
>>>>=20
>>>> I see this note in checkpatch,but as i rely on dynamic value and i sa=
w no test for mem yet=2E
>>>>=20
>>>=20
>>> There's one for meminfo, but honestly I'm not sure it's a test that ma=
kes sense (just checking whether some fixed strings are printed and not ass=
ociated values that are printed afterwards)=2E I haven't written a C unit t=
est in U-Boot so far so won't be able to help there=2E But we really do wan=
t docs in doc/usage/cmd for any new command=2E
>>=20
>> Not sure if such test makes sense except checking if function returns a=
 string based on unknown gd->ram_size (which depends on the host running th=
e test i guess),or can it set before runing the test so that i can just che=
ck the formatting/calculation of the string?
>>=20
>
>I don't know=2E It's fine for me if you don't write a test for this, I'm =
not sure if you can mock the DRAM size for example=2E The point would have =
been to check you're properly truncating and reporting the right size as we=
ll as writing to the specified variable the appropriate value in decimal=2E

Maybe Tom can answer this?

As far as i see meminfo also uses gd->ram_size and called without paramete=
r and=20
seems to check for fixed strings (container which runs the tests seems lik=
e having 256MiB=20
RAM=2E=2E=2Ewhen this container changes,test will fail i guess=2E

<https://elixir=2Ebootlin=2Ecom/u-boot/v2026=2E01/source/cmd/meminfo=2Ec#L=
60>

<https://elixir=2Ebootlin=2Ecom/u-boot/v2026=2E01/source/test/cmd/meminfo=
=2Ec#L17>

>Cheers,
>Quentin


regards Frank
