Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D766606A32C
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 11:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ybGNrK1l;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=PcmwWWqz
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E7EF180F7B;
	Sat,  7 Nov 2026 11:09:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0PWQ8hFxG8K1; Sat,  7 Nov 2026 11:09:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3F65C80F44
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794049748;
	b=HNobLt7YKiLsQ4ry68CipujuBSbfnKPUSHbdY8hCvN5g8qB9nJwQdEm6SCC6MGi6Ov/x
	 /cd9/ZyWdifF7CtOWNBhjdMxnhcVBcBxUqw/w2ltQPhvIXFpIj8qdYoTrYYpda3jMsTbN
	 796plFgduFggbTBK+bUpOcJW2L/eOxSEFlr510/bGlI+tVME2kr2EUTf9hpvxwzfmA9HC
	 UhCZQi6qEQSgPg3iZI5WJGlrrXhxS1Q4DyEchtnF8vnMMb22LLsAwqSZTRsmBlaYkPnuR
	 k9pfwbrjY4VuCTOmzQou6U+6Upe5RkjnUJJhqbT9WNjB6T7aTuhC+AKLLc1mEotLetA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794049748;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=2uqmW3dtkz0uKG0yHzO7XxLmw1eC/QEa7kBvkUAWhtI=;
	b=LYBxXu23q6l3AlegcE7Z9KPPp+KqW/9MYsB0Do1DSC01qFTjFvlChqa5P+flKc1jlU40
	 69XRstmzolXCaZXVNKad8wEVoFU9vS/oJH7RFIDjgYjWmSzXMk8fsdwzjFmybbbmnFPJD
	 K3Z2JwCWgLafXH3Vf/DlhRrY+U7NNRkUO1cuWk0lZZu6iEGKFzUNbH9fQwM1GTMVvhp1l
	 Ac8oQ9Ie3Sx20AKCBlIEesNYUULP59v0+NBSaKpxQIVL65CZW0SKupkw2DNG3zfKGeIJU
	 vh8uxSnLOpcUEB3bBg/lgEuRh6E5RBZ0GMnqLfQ6gA0VwhRVHPOKXkmLRgJY5+sABuA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794049748;
	bh=2uqmW3dtkz0uKG0yHzO7XxLmw1eC/QEa7kBvkUAWhtI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ybGNrK1lQcD+o+v88eYq9nzqTmeXgZtWwSqeXBcOS/mWagoQRQJkGKSKFXUPF40R0
	 04WKVV2eKnEcG6tDgGpTjoCL0yYXlHLP+bVaIVgZY4zVRn22Jvqb8mt84L5O8d0mwp
	 wLpA1V6epD5E8br0Z+50WrJ0TdgbLez3TlWg2+cCxDMmR1z1HaJSaxDjfS/rlNDV5h
	 K3rbWW6OukXCm2XSBq+zg4OPGX/5JuNSfWdKe6yhwA/YrCD/gSr04DSk9CfoCHFiAR
	 oLeg8Wbk05vmyLqQNhd0RBdCWS98Mq3BhMP58govZ8Mi4PPukBTnlc/PBHZpICyv6N
	 b1F0hGF4baBFQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3F65C80F44;
	Sat,  7 Nov 2026 11:09:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 351D237D
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 11:09:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 265A94009B
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 11:09:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BZ5nrJwaSVG7 for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 11:09:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6A1444008C
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:231:482b::2;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=PcmwWWqz
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6A1444008C
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 11:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1794049703;
 bh=2uqmW3dtkz0uKG0yHzO7XxLmw1eC/QEa7kBvkUAWhtI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=PcmwWWqzH4OVKpldmjC07DB06wEYpViSbTESK4Fp4VOA76Tsu8ImBo6C0He3FXLBp
 Nj6jw6SfhxnN6Ohms1xCLfwLE+c+S2iQ4EhcePl7diZTqsDB+r0jvth9kB8suV4Li9
 RghGJh4YXUBn1+nvu6ImuqUlNZ+JGxpcBvVdi0/mbmBxR48Ygg1FlDyi7JWax6spOo
 L8LcLvAbz7Tb2wxkiLKFk9zlqknH7kOaQFpbagP+U1xuS56Z9y1bTUiDr+gv/1I3mX
 50C9hfO3CvBmXigMb3lYXiFXQp2HvePsPaFVtG8Kcj143TivGLuwaDcQ87IfYA+R0o
 PNzCVa684U4LA==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 93CFDB2216C3;
 Sat,  7 Nov 2026 12:08:21 +0100 (CET)
Message-ID: <c013c409-f8b3-4e3f-94e8-6aa6b0e1e5e5@freeshell.de>
Date: Sat, 7 Nov 2026 03:08:18 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] riscv: dts: spacemit: k3: Add SPL device and image
 descriptions
To: Junhui Liu <junhui.liu@pigmoral.tech>, Yixun Lan <dlan@kernel.org>
Cc: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>,
 u-boot-spacemit@groups.io, Tom Rini <trini@konsulko.com>,
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Huan Zhou <pericycle.cc@gmail.com>, Eric Chung <eric.chung@riscstar.com>
References: <20261106-k3-ddr-v1-0-1e60e1d78020@pigmoral.tech>
 <20261106-k3-ddr-v1-3-1e60e1d78020@pigmoral.tech>
 <20261106065916-GKC249737@kernel.org>
 <DMOUYFJ5XULA.3REWL8U5IZKY5@pigmoral.tech>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <DMOUYFJ5XULA.3REWL8U5IZKY5@pigmoral.tech>
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Junhui,

On 11/7/26 01:06, Junhui Liu wrote:
> Hi Yixun,
> 
> On Fri Nov 6, 2026 at 2:59 PM CST, Yixun Lan wrote:
>> Hi Junhui,
>>
>> On 00:40 Fri 06 Nov     , Junhui Liu wrote:
>>> Add the DDR controller node and mark the UART, I2C EEPROM and required
>>> clock and reset providers for use before DRAM initialization.
>>>
>>> Add a binman description for spl/u-boot-spl-mkimage.bin, combining SPL
>>> with the external LPDDR5 PMU IMEM firmware and wrapping the payload in
>>> a SpacemiT K3 boot image header.
>>>
>>> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
>>> ---
>>>  arch/riscv/dts/spacemit-k3-binman.dtsi | 24 +++++++++++++++
>>>  arch/riscv/dts/spacemit-k3-u-boot.dtsi | 54 ++++++++++++++++++++++++++++++++++
>>>  2 files changed, 78 insertions(+)
>>>
>> ..
>>> diff --git a/arch/riscv/dts/spacemit-k3-u-boot.dtsi b/arch/riscv/dts/spacemit-k3-u-boot.dtsi
>>> index 352e85e7de8..0976b2647b5 100644
>>> --- a/arch/riscv/dts/spacemit-k3-u-boot.dtsi
>>> +++ b/arch/riscv/dts/spacemit-k3-u-boot.dtsi
>>> @@ -4,3 +4,57 @@
>>>   */
>>>  
>>>  #include "spacemit-k3-binman.dtsi"
>>> +
>>> +&{/soc} {
>>> +	ddrc@cb000000 {
>>> +		compatible = "spacemit,k3-ddrc";
>>> +		reg = <0x0 0xcb000000 0x0 0x01000000>,
>>> +		      <0x0 0xcc000000 0x0 0x01000000>;
>>> +		spacemit,apmu = <&syscon_apmu 0x4e8>;
>>> +		bootph-pre-ram;
>>> +	};
>>> +};
>>> +
>> I'm not sure if it's a good idea to also move "ddrc" to mainline kernel
>> dts, at least to reach a consensus about stable compatible name..
> 
> I see. I can try submitting a DT binding patch to the Linux kernel
> mailing list later to get the DT node design reviewed and reach
> consensus on the compatible string.

I think it is "memory-controller@cb000000" and then whatever compatible
is decided; for starfive JH7110 it is memory-controller@15700000 and
compatible "starfive,jh7110-dmc". Compatible "spacemit,k3-ddrc" is
equally likely to be accepted as anything else.

Send it upstream and insist on either a bootph-pre-ram hint for the
memory controller node or adding a label and see what happens with the
discussion. I don't think BootROM touches the memory controller, so it's
a weak justification but it may be less objectionable to seat a
bootph-pre-ram hint there than adding a label to reference it later on
as something that Linux will never see a driver for or reference in any
other way. I wouldn't complain if someone objected that had a clever
enough SPL they could argue that this was wasting valuable SRAM for, and
wanted to reverse that as not a strictly necessary or correct hardware
description;  just flip it for a label upstream and whack it into U-Boot
&label { bootph-pre-ram; };.  The label just seems like it will annoy
Linux maintainers more than sticking bootph-pre-ram in there directly.

Usually in Linux device tree, nodes are rejected unless there is an
driver in-tree that consumes the compatible. The notable situation of a
memory controller which does not, and logically will never have, any
driver in Linux because any driver necessarily is at a phase before
Linux is possible to have running; this is allowable to upstream that
node to Linux device tree on discretion of the maintainer.

> 
>>
>>> +&i2c2 {
>>> +	bootph-pre-ram;
>>> +
>>> +	eeprom@50 {
>>> +		bootph-pre-ram;
>>> +	};
>>> +};
>>> +
>> For adding all "bootph-pre-ram" properties, I'd like to see patch 
>> submission to mainline kernel tree, see similar thread for K1 SoC[1]
>> so eventually it will get synced to a proper directory under dts/upstream/..

I'd suggest just the BootROM SPL loader modes -adjacent nodes first...
that is going to be the bulk of it and the most effort but also does not
depend on what you do in SPL here now. Thankfully there is vendor
participation to answer questions about BootROM internals.

>>
>> But, I know it would take long time for the upstream dts hit into U-Boot
>> tree, so a compromised solution is that we temporarily accept this patch
>> before the sync, then fix it up later accordingly..
>>
>> Link: https://lore.kernel.org/r/20261024092558.143621-1-alan.tseng.cs@gmail.com [1]
> 
> I agree. However, since our SPL support is still incomplete, we may need
> to add more nodes for pre-DRAM initialization. I'd prefer to wait until
> the bring-up is complete and submit all the required DTS changes
> together, rather than sending multiple incremental patches.
> 

Device tree upstream is a hardware description for reference by software
and not the other way around. BootROM is hardware; what the possible
state of peripherals is as configured by BootROM SPL loader modes should
be described in devicetree for any SPL consumer loaded by the BootROM,
and bootph-pre-ram hints are a reasonable mechanism of filtering just
this for SRAM-constrained environment.

The additional bootph-pre-ram hints, not described by covering what
BootROM touches, might also be allowable but that is not guaranteed.

Start with sending a series to LKML with bootph-pre-ram hints for what
all BootROM SPL loader modes might configure.

-E
