Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB9FCC6B08
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 09:39:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F34EE80C72;
	Tue, 13 Oct 2026 09:39:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8Lr38FjwFoiG; Tue, 13 Oct 2026 09:39:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 818E680C71
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791884372;
	b=KGozw/S9cj8qIhQIeH+lC/BgcFmTo1VwfZF4HStIQMWTHH9uXt68sh8Zxzy9QJRxT8B4
	 4nXqZN0gXhh4frTuit1oZS7X4UozD0mMl1TO80YM1efuMKUv7DBexOcr3Fd2SffBxBLzS
	 YRzEmfwqcxWKLGh4Q+d9v2fHfBH+doycjaKMNUSN/ELHoRZ2X5AfoBuAPH2AAN5XqYpY/
	 Ni/Z7d5WWiXNGv+4nn07HWfJJs818GLcS6cCXElxpHRdBBI1JD3VWGWNoDczmWRoPfpGE
	 BWgUbE3LLgjGP5wYmilgUctPmLotjHfNYbmfmS+rK1Rxn4NNGNotw2YsFd9pXsrstGw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791884372;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Pm-Submission-Id:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:User-Agent:MIME-Version:Content-Type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=O8VPq4Ysk0F6sPbdVjaViCQX9YtG8uJL05QdVIrA8xA=;
	b=MKD/EJEI7+Zhx9/vdd3jV8fiEoCzS14z5gh76A/CzZ2L3znRm/9YGf4dJM8g5rybX9lp
	 6/t7eWb8P4nR5ButhMzVUfCtcThNZ9I3FUj2knJehIAjnia1GCNJHwCETxHzXcL5oB29n
	 XFMqGMtfiZMQxE7ICugdx/pPWqQbJfgI58C3+yW2go9cDD9qzieKtRKq26eePXTKm3pDi
	 ZTCL1r5XvAJ0V5EHwkpnyoiXdkGD2KDeVGNtrIxKMVQcJQpJ7q6fiUhlOXHt/UQbDEmKq
	 x5m3sbd/chPKdIl1smZNC1aOYXNHHTE/jJIgg9W+VRrWNRo024NPW7UJGFSdG7+IELQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791884372;
	bh=O8VPq4Ysk0F6sPbdVjaViCQX9YtG8uJL05QdVIrA8xA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nuHKX6pK8I2sLFMK2B6usYkPvzncDaCwRRaW6veaWGk8Fxqe1/CRiZhqFtGqEaRcg
	 8T4gaQSfKMWmn08vw265ezTKbksc28LkRKqWSwEHW8iBU9uLd4KiM+BluSVZvC127/
	 wZATqZpMKg7Wyq7cf950PumzBUYFc4FiQzuwfHNcWe/1Yc193WalSvjQZ7Gttc36a7
	 mWaR0CV9rM1clDiq8+dv1IK+/FACnztjg4xS86I0iAkbjmeg5Gdt7etxxP+fLSgW7n
	 aRQ9koXuuUdlzIXI3fcqxG2MVRnhad29PCQuMgycSJqvQ2+mrUl3zIp6yp1iBAGOAK
	 yBwYfnvzwBgOA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 818E680C71;
	Tue, 13 Oct 2026 09:39:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8C3412E0
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 09:39:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7D89A60679
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 09:39:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EGyZunX9X7xC for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 09:39:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6CA5060629
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=109.224.244.102
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791884369;
 b=ERcGa/U227OB/2XQ1zeMHaBGgdewtPocDuY/06fJSwzv9zcBWIJXai9CNPmeiQbtLDwN
 Zgrzjfn8xXYw89yPLYqZLrCSSvnDzFJXkuO3lhmwXLB2qa3i42erqSj+A6ubOc7STnMl/
 7waNoJ3Xa3UyPjgyW3fXVn0LTpzvX9L+w5nBagbktQC1UciOAWsp1EUePEMj2zdH0R+48
 WF4QWll5GfgB4kgZikzsPIRgHLFTB25zJwMKGGjuvweRb8wiswLjivx/SloZSexErn8eF
 +9ceCuOwwUuRLf5ZczMWqEkTiySdfsCNJKVJfnVw3boxKFzmMQrFOZ26gxKF3bQIdFA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791884369;
 h=Received-SPF:DKIM-Signature:X-Pm-Submission-Id:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:User-Agent:MIME-Version:
 Content-Type;
 bh=O8VPq4Ysk0F6sPbdVjaViCQX9YtG8uJL05QdVIrA8xA=;
 b=QFSIvS5Kd3noMIOuR+odzWAdwO6UoiEcCTRD0663VYQOALc0Ql4b6/MC+nzLYUhbLXyH
 p7Om8FiwbojY+GGvho/vhvb7cwdiN5m8A15Wwu7d908tVeLHtuzzlyjJa+qLbKj2F2NBm
 uzdNcln3ISXqNnF7YsInXuaPB9CTwcb5F8mzTW/rgzUa4GOgE3R8+7pK4ItKFed54/hGZ
 JK3lSiHZm1HYM+05XNAUob8mT9W/MCuoMrIp8zfuFr826sXEkiUJ5dP+Qezbt9IQAmIqs
 zwohC4jupDC+bUfAat0kl1A4MV10zzrICZ5U0OsAQK+BTPqT483c1MY3jc0/144xKPg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=rasmusvillemoes.dk;
 dkim=pass header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk
 header.a=rsa-sha256 header.s=protonmail header.b=U4smhavP; 
 arc=none smtp.remote-ip=109.224.244.102
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=109.224.244.102;
 helo=mail-244102.protonmail.ch; envelope-from=rv@rasmusvillemoes.dk;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk
 header.a=rsa-sha256 header.s=protonmail header.b=U4smhavP
Received: from mail-244102.protonmail.ch (mail-244102.protonmail.ch
 [109.224.244.102])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6CA5060629
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 09:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rasmusvillemoes.dk;
 s=protonmail; t=1791884309; x=1792143509;
 bh=O8VPq4Ysk0F6sPbdVjaViCQX9YtG8uJL05QdVIrA8xA=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=U4smhavPGxujm6G7DnHAqD1xo/ZJbgADr4SJp9WWzF+Kru5Z29oTCWhi+IqiCw606
 ERRkquWlb00d9Y1S7gqK2DBgnYOTLcLyKwVwY0Nx0GN4I8g2txShknKnoB95TbUqzg
 mN5EnmGoQuzqv42CpsTzD+JvmcC9Vm89AyTnuFhwhrUEuUkMrKtaVILjkV87XLRZPm
 pi+rTaxXX3lb1LzcQYWK+nTVoYyBE5xMf8HMcKYtZbCQs0kmsdHzXuo1hPXFyHtLHB
 TX8I77Ymfn2sOvj/Ul5g6q9I9fo0UVHyj5akJrCUBeRDnMPRZlIrRi4v4kKidcR5Wy
 FcWyi7kBLumEQ==
X-Pm-Submission-Id: 4j3q5Z2zf0z2ScWw
From: Rasmus Villemoes <rv@rasmusvillemoes.dk>
To: "Marcel Ziswiler" <marcel@ziswiler.com>
Cc: <u-boot@lists.u-boot-project.org>,  "Tom Rini" <trini@konsulko.com>,
 "Simon Glass" <sjg@chromium.org>
Subject: Re: [REGRESSION] Re: [PATCH v2 5/9] lib/string.c: implement
 strdup() and strndup() in terms of memdup_nul()
In-Reply-To: <87wlrm2fcg.fsf@rasmusvillemoes.dk>
References: <20260421075439.16696-1-ravi@prevas.dk>
 <20260421075439.16696-6-ravi@prevas.dk>
 <AcudIuPdPJ5-kqSj6e-s_SQbe9Z8Q5HcjiZsubil4biPj9gti7a9LBnOeY9773esCblkiUJI8hX-N9MbZi_fjg==@protonmail.internalid>
 <eb6c3466ddd897979fc08742e721d911fafef190.camel@ziswiler.com>
 <dkoQtduO2VZZSg_twn6aEON3-1NIERFMb5inRq_5NFYBZoJupMdXDBX_2xw5aceIk258QYzLZqn1b6Fyfrr5KQ==@protonmail.internalid>
 <87wlrm2fcg.fsf@rasmusvillemoes.dk>
Date: Tue, 13 Oct 2026 11:38:25 +0200
Message-ID: <87h5iq2b5a.fsf@rasmusvillemoes.dk>
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

On Tue, Oct 13 2026, "Rasmus Villemoes" <rv@rasmusvillemoes.dk> wrote:

> The only other difference I can see is the U-Boot version doing a tail
> call
>
> 	return memcpy(dst, src, len);
>
> which relies on memcpy() being defined to return the dst argument. Now,
> usually nobody uses memcpy's return value, but it can make code slightly
> more compact, and any custom memcpy() implementation (e.g. in asm) _must_
> honour this, as the compiler might transform
>
>   memcpy(a, b, c);
>   return a;
>
> into
>
>   return memcpy(a, b, c);
>
> [I know this because I played around with this in godbolt a few years
> ago, and I think found that gcc did this but clang did not, or something
> like that].

Just for my own future reference: I misremembered slightly regarding the
gcc/clang behaviour, but I did file an llvm bug report back then. That
was just very hard to re-discover because my name was not included when
llvm migrated their issue tracker to github, but it's this one:
https://github.com/llvm/llvm-project/issues/46610 .

> So my best bet is that your platform uses a custom memcpy() which does
> not have to right return value. Can you try changing that last
>
> 	return memcpy(dst, src, len);
>
> into
>
> 	memcpy(dst, src, len);
> 	return dst;
>
> and verify in the disassembly that the compiler hasn't changed it back,
> and then see if your board boots?

As for this hypothesis, I did quickly look at riscv's asm memcpy(), and
I don't see anything obviously wrong (it does have a "save for return
value"). But the arithmetic and comparisons are somewhat risky and
not-obviously-correct, I think. For example, doing

	/* Unrolled wordwise copy */
	addi	t0, t0, -(16*SZREG-1)
	bgeu	a0, t0, 2f

to see if the end of the destination buffer is at least 16 words ahead
of the a0 doesn't work if we happen to work with addresses very close to
0, i.e. something like

  memcpy(32, from_somewhere, 256)

would certainly fail. But I know nothing about riscv, so I can't really
read the asm properly, and the "close to 0" thing is unlikely to be the
real problem.

Nevertheless, another thing to try is disable CONFIG_SPL_ARCH_MEMPCY
(and CONFIG_ARCH_MEMCPY for good measure) and see if that makes a
difference.

Rasmus
