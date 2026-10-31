Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5CF606A31C
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 18:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tePVPspQ;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=lVzRL+am
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 33C5780E57;
	Sat, 31 Oct 2026 18:16:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1-4OXNhMDW1l; Sat, 31 Oct 2026 18:16:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C5EED80E13
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793470587;
	b=Y3av6hcoYxE4jRO0JzAkLZkO0LefPBajtBPJ1vcKudUddkf7xn6BnCgWAY2Tp0VjGSs2
	 +3wxtd+7TgXkrt2cvgaYzJz0/kVdBl6ejJfP4i9UgDxbZZYR9dLwUURidsr3V4nPr0FgB
	 zGV05w1eNAWd+CB5u3V7WSDZnoAQbmzIISqNR7DnJwM8l/2MkxZ3Lsf+t1tOuONyhUeFR
	 A08i64O4tuMJpO7PhlnozujFaspOTYdS+afecWNt7jeragr2G9IrCnh7Lk26MqLo18/Nr
	 y9YMuNfdC4kMnYwHb/wq2PI84xoszsvvXduR53nTA9+CEGlfswC6Befmus4zous4K6g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793470587;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ahAWr+mskSmueUDb4rQ+Ba3asOfeqgHdA9R6RkXkJIY=;
	b=cE9A9llO9ZVFgEWjrSqGnBSmGX/cMZK2vZXrNxNQYPFAW14cSgFXgNfNeb93EzdyS9WB
	 sqoaQqjbdGr2x6BXTSnKnMolixybYoEUolo7KcuZB3W/dyNqHeO+tuX8f75bizrPwrPbl
	 /YoqsOWOfm49aGbioC4HHucilL7JeC9PxSDXztN4a9AirpGlOr/qoSXw1n4oLbsCBYj4x
	 veW2TVp9dlFwvVomFHlpwAWviNRHTPohJ29AOgnWGcr/xJ+CsPcDJiJzOt8iPbR0jfdap
	 eWSfC0zpkVyfUpVpIy71aLN8RJy5aMXQKjVjTp3+K4Gemv4O9N27cy8Lk2b162TFpCQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=freeshell.de;
	dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=lVzRL+am;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793470586;
	bh=ahAWr+mskSmueUDb4rQ+Ba3asOfeqgHdA9R6RkXkJIY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tePVPspQprhTgCXCA5LNDECkPr7/NRVXhtdYeATvAC8pi5JfrrRZpdUS8sZX78o5y
	 Oxd/R+Z+1jEpn4U0z5FrcW6sf1sTiNvAPAUSaARtbZuPu0rzjRludv90w2iKJMUcYL
	 AzzC86PYaqSFEJpoQ7MW5BI2AHExqE9UfGGH4HUni/9HrA6lRhzkIh1kfrGl+zmLMv
	 y2mepzkbmK/EO9rsgK0dB0IyUyCFtrqrRjzMJ0sz3vZB0RfrryDMAEHIYPTVUejwzT
	 7H4KBUwv8bPIF/swYrhK6CzhBI2otOwc7SKngGhcArnRAQxUrn4tkb+s0iCYxdsLfy
	 DtZQWtqFmN+ag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C5EED80E13;
	Sat, 31 Oct 2026 18:16:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B1E04380
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 18:16:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 978A180DCB
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 18:16:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ly4Sg6RCO8dY for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 18:16:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8D40480E13
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793470583;
 b=Bh4z0Ar1HwfIX2xUodY8JIlauQhQ8gjSFyqy/3bZvBO+uVZOrI5duvtXG1Wd+GRbSSBr
 L+Lj6jBvxyrr/OzRlBCpJWkcMAEtL0cmghVn5N8jDh7pNaJ53MA4SrU2wH+vAfQW5Sd2K
 5uwgFFwtblJs/Euglvqgc83u7eY09hnH9GacWoZLwyJFfOq5rWquOpoY78Y1pMr230C0x
 BvUFZZlAvDIqaqV+6UyNBIzmvhGQ2F4bgphxhg1TMblyKbdre8N2GDCR9ebf2KKmxCuFr
 HyyqUJroo1Z/aS8X+ZN1I/B3YRfciaeKTGQt5VHheyhZAtafV9AvTvL4JEJ9TsvR97A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793470583;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=ahAWr+mskSmueUDb4rQ+Ba3asOfeqgHdA9R6RkXkJIY=;
 b=muNYqQU/jwhfckzZQZJdiq8E1zSu88sTsvqqKdTfEatQsZoigMYbTi/8XCGDf6A57RB6
 wt1Mtj5Z7nwa+13nNtnugO0w5WtcRiNmYdh7KFi4XnIbAbBOfpvvA41UPqNMolVNCrkKX
 z0AOA+rBDda4l+e49sgTMSbeypGKo5x05+EVs2O+j0qPYuLfs8ZFJA/AJdhIdQOx0LxI/
 b6ott3woOcM2wMJb0nnKqZwePUSSuFrFFx9fq5aUCLHXuzFxgJ/OI3/U8oevCnj5AtW8o
 GvLQbNOaIoI0lMTKrtJRm2molIJMKZAMLVsJjOJQOyuRBs0AhIoX++zRTGFkhR/ZdfQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=freeshell.de;
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=lVzRL+am; 
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:231:482b::2;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=lVzRL+am
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8D40480E13
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 18:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1793470533;
 bh=ahAWr+mskSmueUDb4rQ+Ba3asOfeqgHdA9R6RkXkJIY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=lVzRL+amm1/MrxmHBXCHN8/B9qHYWlgwuqXsqPiKTL+vQ/Zr2rPy7BqRSv8GRgkrt
 pEXrCVRJSRhdFmt+RO1nNGEJiEp/AWNIx1aWD4e3nx2+8wsSzLnsEpBG5yw9mNYM6S
 uwwkcsZMkFkMQ41rn3UBzlYYe+AikyevAEE4l6HHokJu+y0AjABKXLkrvPXgFlkb+i
 OzFGhS7JbS6vTLkAM/ei5vkZLAtoHM6PHg1Q6I82Qn5YO1K+kPDX2aNG28mItwCjao
 +074RIC3B2U9W7yoXKq7AgAYI23wLFIvdAc9lJVltunMaklaEL6enkQwDoHsBQ4q+p
 rZXRxMChzjlIw==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id AD2CCB220B98;
 Sat, 31 Oct 2026 19:15:30 +0100 (CET)
Message-ID: <404dd2df-40ee-450e-b8c8-42d8509ba6ed@freeshell.de>
Date: Sat, 31 Oct 2026 11:15:23 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/6] riscv: dts: spacemit: Clean Up K1 U-Boot Device
 Tree for SPL Initialization
To: Anand Moon <linux.amoon@gmail.com>,
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Cc: u-boot@lists.u-boot-project.org, u-boot-spacemit@groups.io,
 DaveWK225@protonmail.com, eric.chung@riscstar.com, dlan@kernel.org,
 pericycle.cc@gmail.com, tim609@andestech.com, leo.liang@sifive.com,
 me@ziyao.cc, trini@konsulko.com, docular.xu@gmail.com,
 raymond.mao@riscstar.com
References: <20261029134705.3767-1-linux.amoon@gmail.com>
 <20261029134705.3767-2-linux.amoon@gmail.com>
 <20261031115645.3197359-1-alan.tseng.cs@gmail.com>
 <CANAwSgTnTtozrtCj498eDdZMN76Lkkyixsc=9wr6zEXpiebi4g@mail.gmail.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <CANAwSgTnTtozrtCj498eDdZMN76Lkkyixsc=9wr6zEXpiebi4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Anand,

On 10/31/26 09:45, Anand Moon wrote:
> Hi Hung-Chun,
> 
> Thanks for testing this series
> 
> On Sat, 31 Oct 2026 at 17:26, Hung-Chun Tseng <alan.tseng.cs@gmail.com> wrote:
>>
>> Hi Anand,
>>
>> Thanks for sending this. I tested the series on a Milk-V Jupiter,
>> booting from SD. It reaches the U-Boot prompt, but the SPL no longer
>> finds the PMIC:
>>
>>   Get board name:k1-x_milkv-jupiter
>>   No PMIC (-19), leaving rails as found
>>   DDR firmware: [0xc0820740]:0xf0227179, size:0x8d98
>>
>> With a Jupiter -u-boot.dtsi that has the same i2c8/pmic block this
>> patch removes, the SPL sets the rails before DDR init:
>>
>>   vdd_core, value:900000
>>   vdd_1v8, value:1800000
>>   vdd_1v8_mmc, value:3300000
>>
>> The commit message says the regulator configuration moves to
>> dts/upstream, but k1-milkv-jupiter.dts there has no bootph tags and no
>> vdd_core/vdd_1v8/vdd_1v8_mmc names, so the PMIC is not in the SPL
>> device tree and pmic_init() skips it. It works on this board only
>> because the rails come up at usable voltages. How do you plan to let
>> the SPL find the rails?
>>
>> The new file is also not picked up until 6/6. U-Boot includes
>> <dtb>-u-boot.dtsi, $(SYS_SOC)-u-boot.dtsi, $(SYS_CPU)-u-boot.dtsi,
>> $(SYS_VENDOR)-u-boot.dtsi and u-boot.dtsi (scripts/Makefile.lib),
>> which on K1 means k1-u-boot.dtsi or spacemit-u-boot.dtsi. Nothing
>> includes spacemit-k1-u-boot.dtsi until 6/6 sets
>> CONFIG_DEVICE_TREE_INCLUDES, so 1/6 to 5/6 build without any K1
>> overlay, which breaks bisection. I have not built each step. Naming the
>> file k1-u-boot.dtsi would get it included from this patch on, and 6/6
>> would not need DEVICE_TREE_INCLUDES.
>>
> I think configs/spacemit_k3_defconfig uses the same approach.
> 
> CONFIG_DEVICE_TREE_INCLUDES="spacemit-k3-u-boot.dtsi"
> 

Please split up the dts reorganization changes into three-or-four
patches [A], ([B]), [C], and [D]; The initial transition to this as [A]
should be not adding or fixing any nodes:

A1. New file 'spacemit-k1-binman.dtsi' with '#include "binman.dtsi"' at
the top just after the copyright identifier

A2. '&binman' sections from per-board k1-*-u-boot.dtsi overrides should
merge and be moved appended to spacemit-k1-binman.dtsi

A3. New file 'spacemit-k1-u-boot.dtsi' specified by
CONFIG_DEVICE_TREE_INCLUDES, with '#include "spacemit-k1-binman.dtsi"'
as the very last line of the file.

A4. Merge and move from per-board k1-*-u-boot.dtsi files any properties
in devicetree root that are rejected by upstream for devicetree-rebasing
subtree. The content should be inserted after the copyright identifier
and before the last line of the file '#include
"spacemit-k1-binman.dtsi"'. An example of this is the memory controller
reg override in which we specify a sensible fixed-amount value so that
the bootloader bring-up can function, but this configuration would never
be accepted upstream. If not for [B] this should only be the memory
controller reg override, apparently.

B. Resolve the presence of /aliases and /chosen nodes in
k1-musepi-pro-u-boot.dtsi compared to the lack of such nodes in
k1-bananapi-f3-u-boot.dtsi and then upstream and/or merge and move any
resolution to spacemit-k1-u-boot.dtsi ;  I do not understand the
implications so maybe you would find that this can be ignored unchanged
and then removed in [D]

C(n). Import to per-board -u-boot.dtsi and spacemit-k1-u-boot.dtsi all
the proposed upstream changes (i.e. bootph-pre-ram hints). These should
be grouped by upstream patch discussion thread or commit id so that from
view of u-boot git tree one upstream discussion thread (patch or commit
id) is referenced in a comment within the dtsi file(s) that import it.

D. Delete redundant nodes and properties from per-board dtsi places
where they are redundant. This deletion is not combined with [C] because
we should be able to later do a git revert of [C(n)] when a
corresponding commit lands upstream.

There is going to be a considerable amount of per-board overrides that
are identical over a subset of per-board override -u-boot.dtsi and so
duplication is preferable as it is (from U-Boot git log) logically
grouped by commits that reference a particular upstream discussion or
commit id. That is also to say further organizing some changesets in
additional dtsi files to be included from a subset of per-board dtsi is
considered, but I am not yet convinced it would be helpful rather than
just duplicating it among the per-board dtsi files now and having a
sensible git history for reverting later when appropriate.

> It is consistent to use the same naming format for files.
>> The MusePi Pro overlay also set sdhci0's cd-gpios to GPIO 80 active
>> low, while k1-musepi-pro.dts in dts/upstream has it active high, so
>> removing the override flips card detect on that board. Was the
>> override fixing the upstream polarity?
> I haven't verified this yet, but we can retain the override if you prefer
>>
>> Two other things I saw, neither caused by this series: the SPI NOR on
>> the Jupiter is a GigaDevice part (JEDEC c8 40 17), which needs
>> "configs: k1: enable GigaDevice SPI NOR flash support" [1], and
>> U-Boot reports 8 GiB on this 4 GiB board, a known issue in
>> ddr_get_density().
>>
> Yep, you can enable CONFIG_SPI_FLASH_GIGADEVICE in the
> configs/spacemit_k1_defconfig
> 
>> [1] https://lore.kernel.org/u-boot/20261027154347.1392094-2-alan.tseng.cs@gmail.com/
>>
> You likely need to update the regulator name in your upstream patches
> to match the specific naming convention of your board.
> 
> for example
>                regulators {
>                         buck1_0v9: buck1 {
>                                 regulator-name = "vdd_core";
>                                 bootph-pre-ram;
>                                 regulator-min-microvolt = <500000>;
>                                 regulator-max-microvolt = <1050000>;
>                                 regulator-ramp-delay = <5000>;
>                                 regulator-always-on;
>                         };
> 
>                           buck4: buck4 {
>                                 bootph-pre-ram;
>                                 regulator-name = "vdd_1v8";
>                                 regulator-min-microvolt = <500000>;
>                                 regulator-max-microvolt = <3300000>;
>                                 regulator-ramp-delay = <5000>;
>                                 regulator-always-on;
>                         };
> 
>                         aldo1: aldo1 {
>                                 regulator-name = "vdd_1v8_mmc";
>                                 bootph-pre-ram;
>                                 regulator-min-microvolt = <500000>;
>                                 regulator-max-microvolt = <3400000>;
>                                 regulator-boot-on;
>                         };
> 
> You can verify this using the command below
> 
>  # dtc -I dtb -O dts spl/u-boot-spl.dtb |
>     grep -n -E \
>     'regulator|pmic|reset-controller|reset-gpios|vmmc-supply|vqmmc-supply'
> 136:                    pmic@41 {
> 149:                            regulators {
> 152:                                            regulator-name = "vdd_core";
> 153:
> regulator-min-microvolt = <0x7a120>;
> 154:
> regulator-max-microvolt = <0x100590>;
> 155:                                            regulator-ramp-delay = <0x1388>;
> 156:                                            regulator-always-on;
> 161:                                            regulator-name = "vdd_1v8";
> 162:
> regulator-min-microvolt = <0x7a120>;
> 163:
> regulator-max-microvolt = <0x1b7740>;
> 164:                                            regulator-ramp-delay = <0x1388>;
> 165:                                            regulator-always-on;
> 170:                                            regulator-name = "vdd_1v8_mmc";
> 171:
> regulator-min-microvolt = <0x7a120>;
> 172:
> regulator-max-microvolt = <0x33e140>;
> 173:                                            regulator-boot-on;
> 298:                            vmmc-supply = <0x3d>;
> 299:                            vqmmc-supply = <0x3e>;
> 
> If you get this working on your boards, please consider updating it in
> your patch series.
> 
>> Thanks,
>> Hung-Chun
> 
> Thanks
> -Anand

-E
