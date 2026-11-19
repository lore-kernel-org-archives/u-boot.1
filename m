Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715E5606A325
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 01:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mMH2QKAy;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=J7617Jmh
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CE49260AC3;
	Thu, 19 Nov 2026 01:10:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2iCaTImCW6Ul; Thu, 19 Nov 2026 01:10:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DCFE960A9C
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795050648;
	b=fR0paOerpSaMjwlSxD9AnNNduyrY+IydFmRaHcw2of0EOE1NndYak8sfSmmjGZrIR+ZO
	 TQvDfo9DxS/qTD+x60N1Yyn3KJhdwyhJJvjP3oMmR1oZOESUiYrvxzCU+CKH2uPcDTEGA
	 pT5CE5ZcjgKtK4Y1G31GAY3oD2l6i1amS7TwKS5lNp4bMbbSteefsbUVDMVGk9D/f1qaa
	 qwP29QRyeqMQHJ2YufB3ySTn3+3nkobjZl8jUrXdc9KKujiUyCWHeuY8xjU9v9bk9oyiK
	 DaFZqCN7DbzVZgJAk6Er0cp3Cs3dgyrK4ZXaVO/dogB3yk2sGwymcV8blZI2bGOSJAw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795050648;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ppcwlP9n0xbgZMOP0WPW30EVeqKMaJpMUlKBWgYIVLA=;
	b=XI4AClYUYWX/rfGu+Jbbg1PzANPcOXPrioPvoBcKiOlsKJmGFMW9qovZTu0egHALzPjR
	 sIkaUomjHmvYkC7pn/WomgiFTaE/qbwEly4JX8omwWdLzzsfhjOa6L80TbwpDHdAfp6Wb
	 S7Viu3DpLXLIIZw3ZMDwuqsAjkMzm4dbAB2PG6jogwctcu+hVfsBxyBCBwUwx9BeR3afl
	 vgeH1r60jnAVN+N32P9/8BQHyybV/L8E2IrCXfsIIjLii0+5RSHzPy0toJ2EjRkLtFBfi
	 bBszSqt7h526Hr/gyit9VB6/L96hI8eXCSIrrxftpEQ2QmM3ugz70mOAlTdYkttZrHg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795050648;
	bh=ppcwlP9n0xbgZMOP0WPW30EVeqKMaJpMUlKBWgYIVLA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mMH2QKAyyGhNnvqjGrlFJdguU2UeRCB2OG/0FoEF3zlxcAw/LPS8CbKxHCGAYQErX
	 yDgcVBYvKuneKIZuYqGcDRM6cIn99HqW2hBML/qQyJ14v8Wv3AukJCinpjho2rtF2S
	 8wEnQ2w3oY12q5Y+Ehx7aOCxtmXGrIUJecOBHNjqaEBliSxsRdsH0XEvgRM0gJplcy
	 G4/F7QJtjwysINmPNPfJi+9fqf4JEsG6J8CcAoXB39iRUedyNByvUNc4v7YuPYoYPy
	 zDn7JD/iZnEscvUCTiGZJwPqb/hiiKKlKNP23BerV0lQmPBxCh1HqSLQtfL8y7vmUW
	 O/6wEUiPfhLZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DCFE960A9C;
	Thu, 19 Nov 2026 01:10:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2059A1C9
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 01:10:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 065B4407E5
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 01:10:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MMzdDlJyQ398 for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 01:10:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 50E1A407D3
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:231:482b::2;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=J7617Jmh
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 50E1A407D3
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 01:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1795050612;
 bh=ppcwlP9n0xbgZMOP0WPW30EVeqKMaJpMUlKBWgYIVLA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=J7617JmhtlMHDal0+QXQqp4cKh9fS/jmnC4cDxtjItRmWQLG8zoDve3wjwumTP0Q0
 OjQ6Gme836hVOqm1y/rsaF0cZGI/CyLe1X9CLP5iu6DBv0Xb3SSdec/ZZI1nVeJODl
 RRd5LNaMVQNBdJwdADg1Hpebw+STX8/5TKc1jW2KGDTqk1MHdyzllfi5rRla2hlPJg
 /5ZfNuYNIqG8Rhv8QTy1h6eAWOHm1JrGjezOM15OOLlE0/LVV+8d5wXGDao459nHEx
 +MqOUq+Ap2UPigPktNrEl40e1xzUgC7oP+MQQOC/ptyE8aMVs5F56d3FPSKNgO0AIj
 c2UhDoQiPnsnQ==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id C91B2B2200DD;
 Thu, 19 Nov 2026 02:10:10 +0100 (CET)
Message-ID: <d212d6c5-242b-4b4c-8bee-15a8e685ac1d@freeshell.de>
Date: Wed, 18 Nov 2026 17:10:03 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: Disable M-mode IMSIC and APLIC nodes in DT passed
 to next stage in S mode
To: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Cc: Yao Zi <me@ziyao.cc>, u-boot@lists.u-boot-project.org,
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Tom Rini <trini@konsulko.com>,
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
References: <20261118-mimsic_maplic_fixup-v1-1-52dea8f39779@oss.tenstorrent.com>
 <f5e87e76-ea5e-4dc2-9b28-4f9eadcfbf5d@freeshell.de>
 <CAEev2e9MeszAmxyyjbgyfMtG_Bt=Bc98O67jz9esNa--n5Tqww@mail.gmail.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <CAEev2e9MeszAmxyyjbgyfMtG_Bt=Bc98O67jz9esNa--n5Tqww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 11/18/26 14:21, Anirudh Srinivasan wrote:
> Hi E,
> 
> On Wed, Nov 18, 2026 at 3:05 PM E Shattow <e@freeshell.de> wrote:
>>
>> Hi Anirudh,
>>
>> On 11/18/26 10:00, Anirudh Srinivasan wrote:
>>> When U-Boot is running in S mode and is used to boot linux, the DT passed
>>> to linux can either be the bundled in DT U-Boot and OpenSBI use, or be
>>> loaded by U-Boot from some boot media. In the former case, OpenSBI fixes
>>> up the DT to disable the M-mode IMSIC and APLIC nodes on an AIA system.
>>> These controllers are to be managed by M-mode software, so this is done
>>> to prevent linux from trying to probe them.
>>>
>>> This fixup doesn't happen in the latter case because U-Boot loads a
>>> fresh DT from boot media. Add a fdt fixup to do this similar to OpenSBI.
>>> This gets rid of prints like this during linux boots.
>>>
>>
>> I think it is not necessary to mention specific software (U-Boot or
>> OpenSBI) in the lede paragraph of the commit message. That description
>> of Linux is a testing scenario (which is fine to also mention, in
>> secondary paragraph(s), or just omit from the commit mesage and leave it
>> to mailing list replies for cover letter and T-by tags). It would apply
>> equally to any S-mode kernel including U-Boot main app itself being
>> S-mode, GRUB EFI, *BSD, etc.
>>
>> Essentially we accept that for RISC-V there is other third-party
>> software which may integrate with U-Boot and we cannot know the
>> consistency of device tree state in this context, even when we have
>> provided some of these modifications in the form of device tree
>> overrides to that software. It makes good sense to do some fixup in
>> these likely situations. The important thing I'm reading for in this
>> description is, "what is it about the RISC-V platform M-mode / S-mode in
>> U-Boot that requires consistency checks of device tree properties at
>> runtime?"
> 
> Yes, I'll drop references to OpenSBI/Linux and just say M-mode and
> S-mode software.
> 
>>
>> Are these the only consistency checks that we foresee?
> 
> These are the same as what OpenSBI does (maplic and mimsic).
> 
>>
>>> [    0.000000] riscv-imsic: interrupt-controller@a0000000: no parent irqs available
>>> [    0.000000] riscv-imsic: interrupt-controller@a0000000: failed to setup state (error -22)
>>> [    0.000000] OF: of_irq_init: Failed to init /soc/interrupt-controller@a0000000 ((____ptrval____)), parent (____ptrval____)
>>>
>>> [   10.727605] platform cc000000.interrupt-controller: deferred probe pending: platform: supplier a0000000.interrupt-controller not ready
>>>
>>> Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
>>> ---
>>>  arch/riscv/lib/fdt_fixup.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 84 insertions(+)
>>>
>>> diff --git a/arch/riscv/lib/fdt_fixup.c b/arch/riscv/lib/fdt_fixup.c
>>> index 6dfd1a2d5b8..ce8c18a7b92 100644
>>> --- a/arch/riscv/lib/fdt_fixup.c
>>> +++ b/arch/riscv/lib/fdt_fixup.c
>>> @@ -117,6 +117,80 @@ int riscv_board_reserved_mem_fixup(void *fdt)
>>>       return 0;
>>>  }
>>>
>>
>>> +/**
>>> + * riscv_node_handles_mmode_external_interrupts() - Check if interrupt controller handles M-mode
>>> + * external interrupts
>>> + * @fdt: Pointer to the device tree
>>> + * @offset: Offset of node in DT to check
>>> + *
>>> + * Return: true if controller handles M-mode external interrupts IRQ_M_EXT (11), else false
>>> + */
>>> +static bool riscv_node_handles_mmode_external_interrupts(void *fdt, int offset)
>>> +{
>>> +     int i, len;
>>> +     const fdt32_t *interrupts_extended =
>>> +             fdt_getprop(fdt, offset, "interrupts-extended", &len);
>>> +     if (!interrupts_extended || !len || len % (2 * sizeof(u32)))
>>> +             return false;
>>> +     for (i = 1; i < len / sizeof(u32); i += 2) {
>>
>> Read the size-cells property, or comment why this is assumed to be
>> size-cells=<2> (and what happens on non-64-bit platform if this is
>> applicable or not).
> 
> We aren't reading a reg cell here. The 32/64 bit discrepancy comes
> here only then. interrupts-extended is always 2 u32s per hart, for
> both 32 and 64 bit systems.
> 

Okay, thanks for explaining. I think it would helpful to keep this
explanation as a short comment saying this and whether it is specified
by the RISC-V or the device tree specification(s) that
interrupts-extended list items are always always 2*u32. I can see the
code implements that 2*u32 interval, but the implementation does not
itself explain the question of why it is doing so.

>>
>>> +             if (fdt32_to_cpu(interrupts_extended[i]) == IRQ_M_EXT)
>>> +                     return true;
>>> +     }
>>> +     return false;
>>> +}
>>> +
>>> +/**
>>> + * riscv_aia_mmode_imsic_aplic_fixup() - Disable M-mode APLIC and IMSIC nodes in DT
>>> + * @fdt: Pointer to the device tree in which nodes are to be disabled
>>> + *
>>> + * On RISC-V AIA systems, M-mode software manages the M-mode APLIC and IMSIC.
>>> + * If S-mode U-Boot loads a device tree from boot media, the DT nodes for these
>>> + * could still be enabled, so fixup the DT to disable these nodes before passing
>>> + * it to the next S-mode stage.
>>> + *
>>> + * Return: 0 on success or error otherwise.
>>> + */
>>> +static int riscv_aia_mmode_imsic_aplic_fixup(void *fdt)
>>> +{
>>
>> Critically this fixup routine does not *enable* the nodes *for* M-mode.
>> I cannot think of a better name for it than you have here, however.
>>
>> Is this not an S-mode fixup routine?
>>
>> Maybe... "riscv_aia_exit_mmode_imsic_aplic_fixup"
> 
> How about "riscv_aia_mimsic_maplic_fixup"? It clearly states which
> nodes are being fixed up.
> 

That sounds good to me, yes.

>>
>>> +     int offset, err;
>>> +
>>> +     /* Disable M-IMSIC in APLIC-IMSIC configuration */
>>> +     fdt_for_each_node_by_compatible(offset, fdt, -1, "riscv,imsics") {
>>> +             if (riscv_node_handles_mmode_external_interrupts(fdt, offset)) {
>>> +                     err = fdt_status_disabled(fdt, offset);
>>> +                     if (err < 0)
>>> +                             return err;
>>> +             }
>>> +     }
>>> +
>>> +     /* Disable M-APLIC in APLIC only configuration */
>>> +     fdt_for_each_node_by_compatible(offset, fdt, -1, "riscv,aplic") {
>>> +             if (riscv_node_handles_mmode_external_interrupts(fdt, offset)) {
>>> +                     err = fdt_status_disabled(fdt, offset);
>>> +                     if (err < 0)
>>> +                             return err;
>>> +             }
>>> +     }
>>> +
>>> +     /* Disable M-APLIC in APLIC-IMSIC configuration */
>>> +     fdt_for_each_node_by_compatible(offset, fdt, -1, "riscv,aplic") {
>>> +             int len, imsic_offset;
>>> +             const fdt32_t *msi_parent = fdt_getprop(fdt, offset, "msi-parent", &len);
>>> +
>>> +             if (msi_parent && len >= sizeof(fdt32_t)) {
>>> +                     imsic_offset = fdt_node_offset_by_phandle(fdt, fdt32_to_cpu(*msi_parent));
>>> +                     if (imsic_offset >= 0 &&
>>> +                         riscv_node_handles_mmode_external_interrupts(fdt, imsic_offset)) {
>>> +                             err = fdt_status_disabled(fdt, offset);
>>> +                             if (err < 0)
>>> +                                     return err;
>>> +                     }
>>> +             }
>>> +     }
>>> +
>>> +     return 0;
>>> +}
>>> +
>>>  #ifdef CONFIG_OF_BOARD_FIXUP
>>>  int board_fix_fdt(void *fdt)
>>>  {
>>> @@ -165,5 +239,15 @@ int arch_fixup_fdt(void *blob)
>>>       if (err < 0)
>>>               return err;
>>>
>>
>>> +     /*
>>> +      * Disable M-mode APLIC and IMSIC nodes in DT passed
>>> +      * to next stage if we're in S mode
>>> +      */
>>> +     if (!CONFIG_IS_ENABLED(RISCV_MMODE)) {
>>> +             err = riscv_aia_mmode_imsic_aplic_fixup(blob);
>>
>> This could be clearer to say "When not in M-mode then disable M-mode
>> APLIC and IMSIC nodes"
>>
>> The subroutine name is already very descriptive but this comment would
>> be fully redundant if the function name is clearer about its
>> functionality, and would not need a comment. (See previous suggestion
>> about function name).
> 
> I'll use M-APLIC and M-IMSIC so there is no confusion about s-mode/m-mode.
> 

Sure, or, drop the comment here with the function being named instead
riscv_aia_imsic_aplic_fixup()

If it doesn't tell me why we're doing this, then the code is anyway
self-evident what we're doing so that if we're not in M-mode then this
riscv_aia_imsic_aplic_fixup() is called. It is not too much trouble to
then further read the description of that function itself where it is
defined.

It would be confusing if the code continues to read that when we're not
in M-mode to then do an "M-mode fixup". The revised function name
doesn't raise this question to me, it looks okay.

[...]

With that,

Reviewed-by: E Shattow <e@freeshell.de>
