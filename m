Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7515EB8FB8
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 06:51:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCE7686545;
	Wed,  6 Sep 2023 08:51:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.b="a+ZVBRYK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A12F86589; Wed,  6 Sep 2023 08:51:43 +0200 (CEST)
Received: from s.wfbtzhsw.outbound-mail.sendgrid.net
 (s.wfbtzhsw.outbound-mail.sendgrid.net [159.183.224.105])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98F718652A
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 08:51:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=bounces+31435339-7456-u-boot=lists.denx.de@em2124.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=mime-version:subject:references:from:in-reply-to:to:cc:content-type:
 content-transfer-encoding:cc:content-type:from:subject:to;
 s=s1; bh=qwPvbTB46PRAIpVba+iQKwkewJEDQDtLP57KUyAjdD4=;
 b=a+ZVBRYKxET3DzVQBSqFEbGh06FWjbnjY8Il0lUXjIsC9S7guBkrANQ0fMQmR7irf4oS
 Wlz9h7MbXYqN95BX40Pyg6JrCQPMfDjVe9x85Ok0NIrl54mA0wEhwAIWfzcu27yCa7m6I3
 vE+TiFgjl6PG3Akr5ofTTet+VZlGhDwaDH4kraYed8Erx3dXtQ91RWOiI1k0WHI9v2ScQP
 IzE2oFoJT2OAkCE8kGXYpiILSx4ic7bXkuCyyi0gBXm/WfI5sqbIp2q6CnQ8QUSS8a2Q1d
 y0h2+mEbGmxgCxz5AP2ZG7YtfTED3Q+s1kGNyvy9GOFi+Kt62Rl3yYhFc9mw50JQ==
Received: by filterdrecv-65f68489c8-4txpj with SMTP id
 filterdrecv-65f68489c8-4txpj-1-64F8217B-1
 2023-09-06 06:51:39.080606886 +0000 UTC m=+1989841.446125336
Received: from [192.168.1.50] (unknown) by geopod-ismtpd-1 (SG) with ESMTP
 id KG-CxuCrRsyLRgjPQLzqYw Wed, 06 Sep 2023 06:51:38.755 +0000 (UTC)
Message-ID: <2a3123b0-a509-50f6-ebb1-d27e2668f8a3@kwiboo.se>
Date: Wed, 06 Sep 2023 06:51:39 +0000 (UTC)
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: Binman how to build using Rockchip BL32 binary as OP-TEE
References: <CAC928HYMtd=RZnZYW9CNc5wPjzGk11X0+RpcuwHMFEuUpv0C4w@mail.gmail.com>
 <c2b9e22b-e55a-03d3-1bac-f7801a8d60c4@kwiboo.se>
 <CAPnjgZ0isSOEBnPi4NWHwx=pm244kkYcavSMZAfrMa0wNDirwQ@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CAPnjgZ0isSOEBnPi4NWHwx=pm244kkYcavSMZAfrMa0wNDirwQ@mail.gmail.com>
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0hyQXP1Rn=2FCRQ8dMlK?=
 =?us-ascii?Q?R3RXK5ckZoke0pmWW0XIV+kJXGJ08LU27a8Q0Xw?=
 =?us-ascii?Q?mbItd4zLPz4wRwTPkYrkA=2FHZm+ZmXKbMS2mt0Hb?=
 =?us-ascii?Q?GLXBzFgHkL=2F0mZsaoZStzy0kjah8ssVGL4kG=2FZJ?=
 =?us-ascii?Q?aU4qJiGLqi=2FjO8BieKh62N6HdJ7rBhQ54tQ8w2?=
To: Simon Glass <sjg@chromium.org>
Cc: Massimo Pegorer <massimo.pegorer+oss@gmail.com>, Kever Yang
 <kever.yang@rock-chips.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, U-Boot Mailing List
 <u-boot@lists.denx.de>
X-Entity-ID: P7KYpSJvGCELWjBME/J5tg==
Content-Type: text/plain; charset=us-ascii
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

Hi Simon,

On 2023-09-05 20:16, Simon Glass wrote:
> Hi Jonas,
> 
> On Mon, 4 Sept 2023 at 10:52, Jonas Karlman <jonas@kwiboo.se> wrote:
>>
>> Hi Massimo,
>>
>> On 2023-09-04 17:05, Massimo Pegorer wrote:
>>> Hi,
>>>
>>> Is there any way for binman to package FIT with U-Boot TF-A and
>>> OP-TEE, using bl32 binary provided by Rockchip as TEE?
>>>
>>> I've tried with TEE=/path/to/rkbin/bin/rk33/xxx_bl32_vX.YZ.bin, but
>>> binman failed.
>>>
>>> In my poor understanding of Python code, it seems binman accepts only
>>> ELF format or a binary format starting with optee_v1_header, but
>>> binaries provided by Rockchip in rkbin repository do not have this
>>> header.
>>
>> One way that I have used/tested before was to create a tee.elf version
>> using something like:
>>
>> $ aarch64-linux-gnu-objcopy -B aarch64 -I binary -O elf64-littleaarch64
> xxx_bl32_vX.YZ.bin bl32.o
>> $ aarch64-linux-gnu-ld bl32.o -T tee.ld -o tee.elf
>>
>> tee.ld:
>> ----
>> ENTRY(_binary_bl32_bin_start);
>>
>> SECTIONS
>> {
>>         . = 0x08400000;
>>         .data : {
>>                 *(.data)
>>         }
>> }
>> ----
>>
>> And then make with TEE=tee.elf, however keep in mind that U-Boot may not
>> treat the memory region used by OP-TEE properly for aarch64.
>>
>> Regards,
>> Jonas
>>
>>>
>>> Thanks in advance for any hints!
> 
> Should we do something to support a 'flat' binary in the tee-os entry type?
> For example, we could allow it if so long as a fixed load address is
> provided? It might be a bit of a hack though.

Yes, it would be nice to have some way to support a blob with flat/plain
binary code and a fixed load address.

Personally I have no interest in using TEE-OS on Rockchip platform and
have only used above workaround for testing and to verify that a blob
could be loaded.

As vaguely stated, using a rkbin provided TEE-OS blob is not fully
supported in U-Boot/linux on aarch64. No memory reservation is made so
U-Boot proper or linux may use part of the memory managed by TEE-OS.

Regards,
Jonas

> 
> Regards,
> Simon
> 

