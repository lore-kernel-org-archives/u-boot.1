Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AEC3C83033
	for <u-boot@archiver.kernel.org>; Mon, 30 Jun 2025 18:56:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0C0981FEE;
	Mon, 30 Jun 2025 20:56:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="lO/uDfVl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9905182ADA; Mon, 30 Jun 2025 20:56:19 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA2578003E
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 20:56:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4bWFk03BF7z9t3C;
 Mon, 30 Jun 2025 20:56:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1751309768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rxZuILnZVyNhPqGBILYTSQpwYqH0uBfyfG0rr+jmKZI=;
 b=lO/uDfVl789JzpIraCFqxHA/hXyL2/8I+kOgpJkdcFGWe+9Ioeddd5aX1XZYIfC7+qGf89
 AF81bjevJbQgb+OnjoB1sPKpbx76lYkDIhSzmQvatDRWsexxLeqbAgBnmNautTlecdh+3z
 8GpPWauSZCtBi1y0gScxqAWn3/2+N5OtdCK2jlnFzC4hNYJxmrxp2MahSLbgLgUvqLdaYV
 ms/mCZWlNxGUge2ACTPg1SAHcvKNW+IXE8Fh652z4q6UElduY3/SPxOk4p+ZuZPwh2AKMp
 ZG8R9kIzQGDn79dPiSfi+BWz3QVgygSIyS6aL00idDOuRTH+akrVquBPYaUgaQ==
Message-ID: <b89fb021-9355-47f5-9472-677105440826@mailbox.org>
Date: Mon, 30 Jun 2025 20:56:07 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] Put common r7s72100 code in board/renesas/common
To: Magnus Damm <magnus.damm@gmail.com>
Cc: u-boot@lists.denx.de, Chris.Brandt@renesas.com, geert+renesas@glider.be
References: <175109975905.52679.4087457787402643705.sendpatchset@1.0.0.127.in-addr.arpa>
 <175109976650.52679.843396826887967830.sendpatchset@1.0.0.127.in-addr.arpa>
 <e64e154e-1f74-4235-a1db-38034a704716@mailbox.org>
 <CANqRtoSfcjBU=QJPoFVhZf368YHvKTXgjToRu2xEQ8hYreAD6w@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CANqRtoSfcjBU=QJPoFVhZf368YHvKTXgjToRu2xEQ8hYreAD6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: qao1wer3gybbtwqshjddzptncp7kn5ds
X-MBO-RS-ID: c811c2af570bcf748c6
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

On 6/30/25 2:38 PM, Magnus Damm wrote:

Hello Magnus,

>>> Break out SoC specific code from the GR-Peach board and put it into the
>>> board/renesas/common directory so it can be easily shared between the
>>> GR-Peach and Genmai boards.
>> I've pushed an SH Ethernet clean up patchset , defconfig split patch and
>> fixups for these two Genmai patches to [1].
>>
>> The SH ethernet clean up patchset removes all SH ethernet related config
>> options from include/configs/*h . The defconfig split patch deduplicates
>> the RZ/A1 configs/*_defconfig files. The fixup! patches implement a
>> couple of quick changes to this patchset, mainly duplicate newline
>> removal, sort of various entries, and deduplication of genmai defconfig
>> . No functional change is expected.
>>
>> Can you please test the [1] on Genmai and see if nothing got broken ? If
>> this works as expected, I will submit the SH ethernet clean up patchset
>> and the defconfig split patch.
> 
> Now I've tested the following commit and it seems to well on Genmai:
> 
> 1e87c1bfe83714e3b813e3200bb880c2a77b0ef6 (HEAD,
> origin/test-sheth-genmai) fixup! Add support for the r7s72100 Genmai
> board

Thank you for testing.

>> If you agree with the fixup! patches,
>> could you then please squash them into these two patches and submit V2 ?
>>
>> Also, please update the subject prefix on these two patches and add
>> "ARM: renesas: ..." subject tags .
>>
>> [1]
>> https://source.denx.de/u-boot/custodians/u-boot-sh/-/commits/test-sheth-genmai
> 
> Thanks for fixing up the code and yes I do agree. No problem about
> squashing the patches and submitting the result as V2. I also need to
> adjust CONFIG_TEXT_BASE to make the code execute from NOR Flash.

Can you try and enable CONFIG_POSITION_INDEPENDENT=y and set 
CONFIG_SYS_TEXT_BASE=0x0 , and try if that still works ?

That will make U-Boot into position independent executable, which can be 
loaded to any arbitrary memory address (as long as it is aligned to 4 or 
8 bytes), and started from that address. I think that should address 
this problem.

> On top of which tree would you like me to prepare V2?

I have posted series [1] and patch [2] , so u-boot/next with [1] and [2] 
applied would be ideal.

Thank you

[1] https://patchwork.ozlabs.org/project/uboot/list/?series=463012
[2] https://patchwork.ozlabs.org/project/uboot/list/?series=463013

-- 
Best regards,
Marek Vasut
