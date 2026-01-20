Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45013CA5FA0
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 16:09:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7C1483A6A;
	Tue, 20 Jan 2026 17:09:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=public-files.de header.i=frank-w@public-files.de header.b="A/P9Utf5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 838F983A9F; Tue, 20 Jan 2026 17:09:52 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0360083A2B
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 17:09:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=public-files.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frank-w@public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
 s=s31663417; t=1768925379; x=1769530179; i=frank-w@public-files.de;
 bh=2jt1+8y77xLgm6ruBAYiqa+BQCkA5TDkmb25/KL1Ew4=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:Reply-to:In-Reply-To:
 References:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=A/P9Utf5yjj7I2m9kc+LdJnWY4uTS36jYCEF6BPs0VqmZSI+wGp5WVvnvcu2JN+T
 SSjBiUbCWJlAEdcGfWjNa3NAPtTkFWdZiIgJexdWnsFw1GwIFtOMBVr6OG/ZUNlwy
 nSGyofdC61iwn3Vd/JjmtWNKVHu9xKXWK+a7Ux40Q+IJG6RasELo2LNRVxM3HY41X
 9dsaBRllH4Nr1jndSFNwBin9Mj/2uteLbNusli/XBp9iuDXW3gxfK4HyvOT4Gl31Q
 DLRXHrm0GkM1xhUpUpc2ERSjCNfkKs0A1ZzpDXNNX5bTtfvSncAF9bALl2Rujg2wu
 xGaQxvXuzbS/2mNExg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ehlo.thunderbird.net ([80.187.70.20]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MMGRK-1vP3WG3Xio-00OShO; Tue, 20
 Jan 2026 17:09:38 +0100
Date: Tue, 20 Jan 2026 17:09:35 +0100
From: Frank Wunderlich <frank-w@public-files.de>
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Frank Wunderlich <linux@fw-web.de>, Tom Rini <trini@konsulko.com>
CC: u-boot@lists.denx.de, Daniel Golle <daniel@makrotopia.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4=5D_cmd=3A_mem=3A_add_function_?=
 =?US-ASCII?Q?for_getting_ram_size_for_use_in_scripts?=
User-Agent: K-9 Mail for Android
In-Reply-To: <585f12d6-4d4e-46b3-ab52-049adf7d216e@cherry.de>
References: <20260118105021.19760-1-linux@fw-web.de>
 <7906ae57-4700-48fd-8740-66b8626640f1@cherry.de>
 <1CBAB275-C7DD-4E52-87D8-B648BE9A4981@fw-web.de>
 <585f12d6-4d4e-46b3-ab52-049adf7d216e@cherry.de>
Message-ID: <BC982812-6A96-4B47-A7CB-3F2DE868CCEC@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HFRfza5BxonJREC3seRX+yWWXHpqK/K8MGwtgnyQMWgaQXPhL0g
 wIpqa2m5AO184RnjrZKTL97NArClEIt4d98jJhMzjrQVM0KLBY6SzotgX/oIK486eLvFmBx
 b9ZMWVfYqtb+VIP63awEMQSnQmsRiL8qVNg3IBUSlO+L7k1UmGZatg3iHCiiT8AkJyXMEHk
 wGIzYhLJNoxliRJ8QGfSg==
UI-OutboundReport: notjunk:1;M01:P0:LAh4HcffXDs=;qVdCv3nnpTv2xc3OkV/UjNpGJ3C
 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
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
Reply-To: frank-w@public-files.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Quentin,

Am 20=2E Januar 2026 13:47:00 MEZ schrieb Quentin Schulz <quentin=2Eschulz=
@cherry=2Ede>:
>Hi Frank,
>
>On 1/20/26 1:09 PM, Frank Wunderlich wrote:
>> Hi
>>=20
>> Thank you for your review
>>=20
>> Am 19=2E Januar 2026 11:22:07 MEZ schrieb Quentin Schulz <quentin=2Esch=
ulz@cherry=2Ede>:
>>> Hi Frank,
>>>=20
>>> On 1/18/26 11:50 AM, Frank Wunderlich wrote:
>
>[=2E=2E=2E]
>
>>> Otherwise I see a few issues:
>>> - rounding not made explicit, (also it's truncating and not rounding I=
 believe here?)=2E Why not print the actual value here as a float (of cours=
e, not using floats)? I vaguely remember some of my Rockchip board printing=
 1=2E5GiB when booting up (cannot verify because this happens due to a bug =
in the SDRAM init and isn't easily reproducible)=2E We do have some boards =
with 256, 512MiB of RAM so we should be clear whether we are printing 0 or =
0=2E25 since that will influence how to do math operations with the variabl=
e containing the value=2E
>>=20
>> I have dropped my previous round because it leads to wrong values and i=
 wanted to avoid floating point numbers=2E But yes 2 decimal digits seem to=
 be needed to give correct output=2E I guess var is then string,not any flo=
ating point type=2E
>>=20
>> So for GB sonething like this:
>>=20
>> u64 ram_gb_x100 =3D GB_X100(gd->ram_size);
>> char buf[16];
>>=20
>> snprintf(buf, sizeof(buf), "%llu=2E%02llu",
>>           ram_gb_x100 / 100,
>>           ram_gb_x100 % 100);
>>=20
>> env_set("ram_size_gb", buf);
>>=20
>
>I believe we should be using GiB and MiB, so multiples of 1024, which mak=
es the part after the dot more cumbersome to calculate=2E
>
>Likely something like
>
>gib_per =3D (gd->ram_size % SZ_1G) * 1000 / 1024
>gib =3D gd->ram_size / SZ_1G
>
>This should give us
>
>250
>1
>
>for 1280MiB for example (1=2E250GiB)=2E Still=2E=2E that would truncate a=
t the MiB level (but is there really DRAM chips which aren't multiples of 1=
MiB???)=2E
>
>I'm not sure this is worth it, especially since that would make the varia=
ble a string and I don't think string comparisons are appropriate for compa=
ring two numbers :)
>
>We just need to make it explicit that the value is truncated=2E
>
>>> - what if I want to save the byte size in a variable? With the current=
 implementation, only mebibyte or gibibyte sizes can be stored=2E I would s=
uggest to argc-- if m or g is passed, and then compare against argc > 1 in =
which case you'd use this third (in case m or g is passed) or second (if th=
ey aren't) argument to store the value=2E
>>=20
>> Good idea, thinking about how to implement this the correct way :) as v=
arname could be "g" or "b" too=2E
>>=20
>
>You could also force the use of the first argument to be able to dump to =
a variable=2E
>
>memsize
>memsize b|m|g [varname]
>
>memsize would be an alias to memsize b=2E
>memsize b var stores the byte size in var=2E
>memsize m var stores the (truncated) mebibyte size in var=2E
>memsize g var stores the (truncated) gibibyte size in var=2E

I could also drop the first param and always handle as MiB=2E=2E=2Euboot a=
lso prints ram as MiB and not GiB on initialization=2E

So only choose between print or set variable and no "floating point" calcu=
lation needs to be=20
done=2E=2E=2Eand result is simply an int=2E Afaik there should be no more =
boards with less than 1MB=20
ram,or am i wrong?
I think this makes most sense=2E=2Eand keeps code small and clean=2E

>You could also decide the prefix your size argument with a dash and if no=
 argument with a dash is passed, it means it's a variable name and the defa=
ult is in byte size=2E
>
>>> - missing documentation on the base for the environment variable=2E We=
 have some commands setting hex digits in variables, some others in decimal=
, so this needs to be made explicit so that people know if they need to tra=
nslate stuff before using it (or how to compare two numbers against each ot=
her)=2E Here it's decimal according to the code (maybe we should have it in=
 hex instead? I am not sure what is the expected base for variables :/)=2E
>>=20
>> As i want to use it in scripts to choose correct bl2 file for bananapi =
r4=2E Imho decimal is better to read here,but it should be mentioned in doc=
=2E
>>=20
>
>OK=2E Considering test (https://docs=2Eu-boot=2Eorg/en/latest/usage/cmd/t=
est=2Ehtml#numbers) compares numbers assuming they're decimal if they don't=
 start with 0x, this is fine to do (we would need to prefix the number with=
 0x if we were to store it as an hex value)=2E

But this means numbers can be no fload and filesize is wrong as it returns=
 hex value without 0x prefix=2E

>Can you tell us more about the initial issue and how you plan on fixing i=
t here?
>
>That sounds like a board file (board/=2E=2E=2E=2E) would be potentially m=
ore appropriate for this? What is this bl2, why does it need to be differen=
t based on DRAM size, isn't there anyway for U-boot to pass the DRAM size t=
o bl2 and only have one bl2 binary for example?

BL2 is bootloader after bootrom (ATF)=2E The board can have 2 different ra=
m hw
configurations which require BL2 compiled with different options set=2E Th=
e purpose for uboot=20
command is checking available ram for updating the BL2 via tftp and pickin=
g the right=20
file based on current installed bl2 via detected ramsize=2E

The issue is that 4gb board does not boot with 8gb ram bl2, 8gb board boot=
s with 4gb bl2,but=20
cannot use the 8gb (only 4gb)=2E So i tried to make a detection mechanism =
to select the right=20
file (tftp,usb,=2E=2E=2E) for current ram configuration=2E

>>>> +
>>>> +	return 0;
>>>> +}
>>>> +#endif /* CONFIG_CMD_MEMSIZE */
>>>> +
>>>>    #ifdef CONFIG_CMD_MEMTEST
>>>>    static ulong mem_test_alt(volatile ulong *buf, ulong start_addr, u=
long end_addr,
>>>>    			  volatile ulong *dummy)
>>>> @@ -1404,6 +1428,14 @@ U_BOOT_CMD(
>>>>    );
>>>>    #endif /* CONFIG_LOOPW */
>>>>    +#ifdef CONFIG_CMD_MEMSIZE
>>>> +U_BOOT_CMD(
>>>> +	msize,	3,	1,	do_mem_size,
>>>> +	"get detected ram size, optional set env variable with value",
>>>> +	"[m, g] [envvar]"
>>>=20
>>> Explain m and g so the user knows when typing help msize=2E
>>>=20
>>> We need tests in test/cmd/ and a new entry in doc/usage/cmd/ for this =
new command=2E
>>=20
>> I see this note in checkpatch,but as i rely on dynamic value and i saw =
no test for mem yet=2E
>>=20
>
>There's one for meminfo, but honestly I'm not sure it's a test that makes=
 sense (just checking whether some fixed strings are printed and not associ=
ated values that are printed afterwards)=2E I haven't written a C unit test=
 in U-Boot so far so won't be able to help there=2E But we really do want d=
ocs in doc/usage/cmd for any new command=2E

Not sure if such test makes sense except checking if function returns a st=
ring based on unknown gd->ram_size (which depends on the host running the t=
est i guess),or can it set before runing the test so that i can just check =
the formatting/calculation of the string?

>Cheers,
>Quentin


regards Frank
