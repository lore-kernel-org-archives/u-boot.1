Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB4C3E8B39F
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 06:53:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26B88839DF;
	Wed,  4 Feb 2026 07:53:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=public-files.de header.i=frank-w@public-files.de header.b="HXQPPcCo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67AAA83A36; Wed,  4 Feb 2026 07:53:31 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D687D839A5
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 07:53:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=public-files.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frank-w@public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
 s=s31663417; t=1770188008; x=1770792808; i=frank-w@public-files.de;
 bh=MksmnARt1IODPvJgOtuwlfZjHwfiaj1Jj1+TnjNn5fw=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:Reply-to:In-Reply-To:
 References:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=HXQPPcCoe6aV71HTODtRwH0HDbIZuCEvugKQkLnmOadDScTYz122TNtiC0YBKM8X
 yezYGIqIOPHZGduLK0QhhcGA4S+RGCQKuBCXKKVYKDcpFGcOsJGVr0JytGKfBNDR0
 WxGzx8mU/L4//0gamuPnpSUuTXa6FKS50iBQwaQnv2tm5aaAHnf0FB3bImccLwlgA
 4M6ZQa7uofRfHi+yBGiBuplZDLtAaYb+vbimSTJqBzO/XhUHYiGyzgUidiZxVSvsM
 qX1s11h6EqIfWOnUxMaglkA0wRijHfp1YYAv3Q9eU+baE08qP+euCoERGQzgCKiWo
 maIlgHzCm9DIoGjSVw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ehlo.thunderbird.net ([80.245.74.171]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1M2wKq-1vqoYN3SFI-007m6Z; Wed, 04 Feb 2026 07:53:27 +0100
Date: Wed, 04 Feb 2026 07:53:28 +0100
From: Frank Wunderlich <frank-w@public-files.de>
To: Simon Glass <sjg@chromium.org>, Frank Wunderlich <linux@fw-web.de>
CC: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Daniel Golle <daniel@makrotopia.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3=5D_cmd=3A_mem=3A_add_function_?=
 =?US-ASCII?Q?for_getting_ram_size_for_use_in_scripts?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAFLszTjBxGvTPbLXUF8tZQJXyrJmsJTbBx6c4-UfQbeqRfdsew@mail.gmail.com>
References: <20260117214311.706022-1-linux@fw-web.de>
 <CAFLszTjBxGvTPbLXUF8tZQJXyrJmsJTbBx6c4-UfQbeqRfdsew@mail.gmail.com>
Message-ID: <301E33D0-D806-434A-BD6F-962A0B513F60@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:i01dMPOAhj3eCXA9iiAZOYxjz5hzQXcxbY5+ux0+niE3+nNQQJu
 NxO+rpgiNJQAGfsx3shxB6BFK684o6+UfDRWDhm/7eIVkP9I7NF4gis2NuitYkee+vaHGfr
 xYKN8UyI7EBCsFgJEK6u3ImApEG8A9aaJClB0HLTlDERU4opst8OFejt+nmIRknJOuevqYM
 of37djztKTkuG9qVx908g==
UI-OutboundReport: notjunk:1;M01:P0:EkP3pOC3cPM=;KB9sMGs/9/q9yAFK0uZzrcEk6w6
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

Hi Simon

Thanks for your review=2E

Am 4=2E Februar 2026 01:23:24 MEZ schrieb Simon Glass <sjg@chromium=2Eorg>=
:
>Hi Frank,
>
>On Sun, 18 Jan 2026 at 10:43, Frank Wunderlich <linux@fw-web=2Ede> wrote:
>>
>> From: Frank Wunderlich <frank-w@public-files=2Ede>
>>
>> Add a command for getting detected ram size with possibility to write
>> to environment variable=2E
>>
>> example usage:
>>
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
>>
>> board with 8GB ram:
>>
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
>>
>> Signed-off-by: Frank Wunderlich <frank-w@public-files=2Ede>
>> ---
>> v2: add Kconfig entry
>> ---
>>  cmd/Kconfig |  5 +++++
>>  cmd/mem=2Ec   | 32 ++++++++++++++++++++++++++++++++
>>  2 files changed, 37 insertions(+)
>
>Please can you add doc/usage/cmd/ and test/cmd

I already did in v6=2E

https://patchwork=2Eozlabs=2Eorg/project/uboot/patch/20260125131254=2E2321=
0-2-linux@fw-web=2Ede/

>>
>> diff --git a/cmd/Kconfig b/cmd/Kconfig
>> index 5c611fb3016e=2E=2Eb82b17195b7e 100644
>> --- a/cmd/Kconfig
>> +++ b/cmd/Kconfig
>> @@ -974,6 +974,11 @@ config CMD_RANDOM
>>         help
>>           random - fill memory with random data
>>
>> +config CMD_MEMSIZE
>> +       bool "memsize"
>> +       help
>> +         Get RAM via command for use in scripts=2E
>
>I suggest a little more info in your help, so it is clear what the
>command actually does=2E

Ok something like "print ram size in MiB or set environment variable with =
same value in decimal notation for use in scripts=2E"

>> +
>>  config CMD_MEMTEST
>>         bool "memtest"
>>         help
>> diff --git a/cmd/mem=2Ec b/cmd/mem=2Ec
>> index d5d7ca2790bd=2E=2Ea067740d81c8 100644
>> --- a/cmd/mem=2Ec
>> +++ b/cmd/mem=2Ec
>> @@ -33,6 +33,7 @@
>>  #include <linux/compiler=2Eh>
>>  #include <linux/ctype=2Eh>
>>  #include <linux/delay=2Eh>
>> +#include <linux/sizes=2Eh>
>>
>>  DECLARE_GLOBAL_DATA_PTR;
>>
>> @@ -711,6 +712,29 @@ static int do_mem_loopw(struct cmd_tbl *cmdtp, int=
 flag, int argc,
>>  }
>>  #endif /* CONFIG_LOOPW */
>>
>> +#ifdef CONFIG_CMD_MEMSIZE
>> +static int do_mem_size(struct cmd_tbl *cmdtp, int flag, int argc,
>> +                      char *const argv[])
>> +{
>> +       u64 memsize =3D gd->ram_size;
>> +
>> +       if (argc > 1) {
>> +               if (!strcmp(argv[1], "m"))
>> +                       memsize =3D (memsize + SZ_1M - 1) / SZ_1M;
>> +               else if (!strcmp(argv[1], "g"))
>> +                       memsize =3D (memsize + SZ_1G - 1) / SZ_1G;
>
>Can you do something like this?
>
>memsize =3D ALIGN(memsize, SZ_1G)

V6 only does MiB to make code more clear, avoid issues on round and also n=
ot needing floading point=2E

>> +               if (argc > 2)
>> +                       env_set_ulong(argv[2], memsize);
>
>Normally U-Boot uses hex, so it would be worth mentioning that this
>command doesn't=2E Or even provide a -d flag to select decimal?

I can mention that result is in decimal of course similar to help text abo=
ve=2E=2E=2Eseems i missed this in v6=2E

>> +               else
>> +                       printf("%lld%s\n", memsize, argv[1]);
>> +       } else {
>> +               printf("%lld\n", memsize);
>> +       }
>> +
>> +       return 0;
>> +}
>> +#endif /* CONFIG_CMD_MEMSIZE */
>> +
>>  #ifdef CONFIG_CMD_MEMTEST
>>  static ulong mem_test_alt(volatile ulong *buf, ulong start_addr, ulong=
 end_addr,
>>                           volatile ulong *dummy)
>> @@ -1404,6 +1428,14 @@ U_BOOT_CMD(
>>  );
>>  #endif /* CONFIG_LOOPW */
>>
>> +#ifdef CONFIG_CMD_MEMSIZE
>> +U_BOOT_CMD(
>> +       msize,  3,      1,      do_mem_size,
>> +       "get detected ram size, optional set env variable with value",
>> +       "[m, g] [envvar]"
>> +);
>> +#endif /* CONFIG_CMD_MEMSIZE */
>> +
>>  #ifdef CONFIG_CMD_MEMTEST
>>  U_BOOT_CMD(
>>         mtest,  5,      1,      do_mem_mtest,
>> --
>> 2=2E43=2E0
>>
>
>Regards,
>Simon


regards Frank
