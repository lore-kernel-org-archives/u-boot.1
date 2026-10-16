Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E20CCCA462
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 08:02:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2E72D4084E;
	Fri, 16 Oct 2026 08:02:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1bs94ZbpdXeB; Fri, 16 Oct 2026 08:02:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6DC034090C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792137738;
	b=R3dUuSoYAhsHXrDC/ainvfsMWr+dCfZGRTljqaO9//p92ZcC5YbzUi0XT4dpPbl+/YPf
	 ILMCYYtRii4x4BwmVzDvsRU1+MIN28qwMYlCYdbNhmFWNqUxJ4Mq9/J6HNPvjGavnVad5
	 IMulIj0FBQNGCyuKOKYuwRy5bY19zjyPCVOfcRnaeoMhjHv28lBHyBr7XfVuEoqpvDjik
	 YSBuz3OxZW4+V9uWphXOHk/ULGszKnQOQpPdHWJ7fPNzWs6z7IFLTrjK3eMkeXnzzI8iR
	 K6+M+zXuGTfXVeozWlOJ2UFUORRobN0mdIuDXS7DTwjkD3MX7tYS/tZM3Im5GzZRmWw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792137738;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:X-Pm-Submission-Id:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:User-Agent:MIME-Version:Content-Type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=85widLegvCKUrbhBeVjnRBFE5lvXh2BQ0wlAl0Sh13k=;
	b=YdfEfQX8kgXvYzaAHRHz798uFeZb/qmSdWlEgoh4UwOfAxBsd2vhQYZG36Eft+JU0uAE
	 JgsmFVAj9hHZrKRnwUVinq60M2I7Tfx+5HXhtDrVR9sn0X/5T3vjdSmlQYdT+AiJgoVIv
	 bLWlvysg5y4PqCAqqKho4W5PoTWsUFyWpXsMJorZbywWhkNp5XvSf1WkTenZT26Eyhg3q
	 IjwBy8l5CwkcsYoe/VORKEkr1WAh4zuKPS9PTYmatMCYJ98sKgc1KWe1N92VXtpl+Xq3I
	 OnKkHRoAOaV15okFOTqjBEfnFiEqA8XSOBDghyppR2st2wBL4ALOSLuyoC9P3Ys5gyw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=rasmusvillemoes.dk;
	dkim=pass header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.a=rsa-sha256 header.s=protonmail header.b=g02kq0b9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792137738;
	bh=85widLegvCKUrbhBeVjnRBFE5lvXh2BQ0wlAl0Sh13k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vNpACuqbM4swwjEt6Ndu+2AbR2lmo9jJI7PycwM4ES2fznZ/734NeLGmGKi+wzFgx
	 P5hGZ77D7Uo2xiOBebz2rq9kZjOOgpa2cXfJZF54uM5mM72Bo+NlTaD0SkKsvAyaxg
	 R8ttPJcvtKRu+qO/M0d8L9i5t8O3MdHC/fvx1cmnrL5qTD3Nwbmi/YusO8X55+n/Qz
	 ukrWB1ORRudYHL7hz2dMY0GeY0jmTcXGZoUBeNItItZZ66aYTG78NGHJl2NwXLPwW0
	 ODrW8zwcbLQuRwMdKQTyIFOAKeTMApCimbZtJE8wO39q8yNNDhbEbMaUSHFJ2JBtyV
	 Q969MytDCZzTg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6DC034090C;
	Fri, 16 Oct 2026 08:02:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id AB787362
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 08:02:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9D1F64090C
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 08:02:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AueRbOEe4T85 for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 08:02:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EA7F54084E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=79.135.106.113
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792137735;
 b=qPR/SVBcgJBZNUAVP4V4aC+oj52/XKd46rHIt7rVv4Xf6KCgVAeF9PkxCH2StFFRoTeO
 xEXZVzdCeCns+QWhYjfSfH2fd47dkIgCJ3+FmpaJiIC2QLUBZiVB+7hOPG7BkFF7KFgP0
 WcsMMunC+FdjmACcRN6bD6SLLuKnoMs5xj6ph56v1CGPQlffGZ7+IE0GV7JFOLdyH4mHT
 kPe90k5j3YqJ8ULDBgQJAd15eRbiuT3xwFRcNtNStS9rXeR6zkNTGSJi9niIV8cqzmiYw
 y1JQfM/TcNdqJeFZ+G9b4+MD9UmV7z7XxqVhjDKxsdqmTrbw5nPuny+dRYqd2B1nhaA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792137735;
 h=X-Greylist:Received-SPF:DKIM-Signature:X-Pm-Submission-Id:From:To:Cc:
 Subject:In-Reply-To:References:Date:Message-ID:User-Agent:
 MIME-Version:Content-Type;
 bh=85widLegvCKUrbhBeVjnRBFE5lvXh2BQ0wlAl0Sh13k=;
 b=jgOuh0XxWhSrCEq3zDH37vUE+v7zqPwI2aZu8PgqDEpd5oYRZ/MjI9x1LL1S11jwrYM5
 7kASZus57ZRP/VCevFaTFZ1qlOd9SmgPancm5aVaonGnCPsYPr5rfeLh3jBjUA5LYbTzG
 jolMnIXFN9dcxKy4AGy3HvSCK9fhxprPXux0K+0WfIlVe/wcW1cG0TokpIuOPTHoAVfZF
 ky5sTQ36G1lQdk0W5lGBI7wIBz38TNXNyZwpMrQCoQ7ACrI0MF0wWy8Q9xbiPnuS1vk80
 imGp1PVbBq4nY6D854ylidkd8VbWZn9IlYiEUkKOEaD0jYu92qDUukAQZgQC80KSOHQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=rasmusvillemoes.dk;
 dkim=pass header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk
 header.a=rsa-sha256 header.s=protonmail header.b=g02kq0b9; 
 arc=none smtp.remote-ip=79.135.106.113
X-Greylist: delayed 164695 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 16 Oct 2026 08:02:13 UTC
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk
 header.a=rsa-sha256 header.s=protonmail header.b=g02kq0b9
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=79.135.106.113;
 helo=mail-106113.protonmail.ch; envelope-from=rv@rasmusvillemoes.dk;
 receiver=<UNKNOWN> 
Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch
 [79.135.106.113])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EA7F54084E
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 08:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rasmusvillemoes.dk;
 s=protonmail; t=1792137730; x=1792396930;
 bh=85widLegvCKUrbhBeVjnRBFE5lvXh2BQ0wlAl0Sh13k=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=g02kq0b91bHfBZXr5XL/riuxQyMFoMDOCh9HAEaxXahl0WbXy63NDF0JQW3Icxncc
 FGqgwWDFK54dW1+27jV0nmUQyL8mp6wGszpn0RMP5BnJWQEcfKXvF472BdC8C/utPH
 uFze3DxZNBNkM0UuH+kslNej+HXfXhOfu7gnvG2ub9UHvFbBHnJW3DmQnoKukOlBWk
 VhWZ/PxymHKME5Xul8JohcDg1DiIAcJwZrPzIg2wkayhtaOP1mjOehw92omwgyXjBW
 KFicPkT4nBwpZF6X2kIuIBtU2spQFnDAOevRlWIzhmNEBm4gphWOn6ESzVurYlCAi5
 Zf4GEY1GAmW8Q==
X-Pm-Submission-Id: 4j5cq52KLVz1DDXV
From: Rasmus Villemoes <rv@rasmusvillemoes.dk>
To: "Marcel Ziswiler" <marcel@ziswiler.com>
Cc: <u-boot@lists.u-boot-project.org>,  "Tom Rini" <trini@konsulko.com>,
 "Simon Glass" <sjg@chromium.org>
Subject: Re: [REGRESSION] Re: [PATCH v2 5/9] lib/string.c: implement
 strdup() and strndup() in terms of memdup_nul()
In-Reply-To: <5eae035c16410c2ab0808e3897fb56ea47b23aee.camel@ziswiler.com>
References: <20260421075439.16696-1-ravi@prevas.dk>
 <20260421075439.16696-6-ravi@prevas.dk>
 <AcudIuPdPJ5-kqSj6e-s_SQbe9Z8Q5HcjiZsubil4biPj9gti7a9LBnOeY9773esCblkiUJI8hX-N9MbZi_fjg==@protonmail.internalid>
 <eb6c3466ddd897979fc08742e721d911fafef190.camel@ziswiler.com>
 <dkoQtduO2VZZSg_twn6aEON3-1NIERFMb5inRq_5NFYBZoJupMdXDBX_2xw5aceIk258QYzLZqn1b6Fyfrr5KQ==@protonmail.internalid>
 <87wlrm2fcg.fsf@rasmusvillemoes.dk>
 <87h5iq2b5a.fsf@rasmusvillemoes.dk>
 <3LJVTgui0zyiZVaS8LXbBjfYdBiNyhkZtbw-OL2UG6IhaHZ7X136oWy2d1pyHVMeW3rwROI2mlWh_mRc6SIPUQ==@protonmail.internalid>
 <5eae035c16410c2ab0808e3897fb56ea47b23aee.camel@ziswiler.com>
Date: Fri, 16 Oct 2026 10:02:08 +0200
Message-ID: <87ld7y13b3.fsf@rasmusvillemoes.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Fri, Oct 16 2026, "Marcel Ziswiler" <marcel@ziswiler.com> wrote:

> Thanks Rasmus
>
> On Tue, 2026-10-13 at 11:38 +0200, Rasmus Villemoes wrote:
>> On Tue, Oct 13 2026, "Rasmus Villemoes" <rv@rasmusvillemoes.dk> wrote:
>
> Yeah, overflow check sounded too easy, but I did try that for a start. Still hangs.
>
> Then, I tried which one actually fails and it is strdup.
>
> If I just add size_t len = strlen(s); to the top of the old working strdup() function, it also hangs. Strange.
>
> No, wait a minute, it just gets called with null strings, yes.
>
> But the new implementation should catch that as well. Strange.
>
> Somehow it does not like another level of indirection. But I haven't quite figured out what exactly it is that
> goes wrong. Will keep prodding it...

Can you tell me the exact compiler/toolchain versions, and if using
clang, can you try gcc (and vice versa of course). Is it a 32 bit or 64
bit target?

Also, even if I can't read risc-v asm very well, can you paste the
disassembly of the old and new strdup() functions. And the exact command line
used to build lib/string.c, found in lib/.string.o.cmd . For both U-Boot
proper and SPL (i.e. spl/lib/.string.o.cmd for the latter).

Because playing around with this code in godbolt I can definitely see
the compiler eliding the NULL checks in some cases, but that also
applies to the old implementation, i.e. I see an unconditional call of
strlen(). But I assume godbolt's toolchain always sees userspace
<string.h> which has __attribute__((nonnull(1))) on strdup(), and we
don't. But it can also be the compiler which "knows" that strdup() has a
non-null contract, i.e. the compiler might have a built-in prototype for
strdup(). Anyway, there are too many variables in play here, so I'd like
to narrow it down a bit to your exact setup.

Rasmus
