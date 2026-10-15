Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC142CCA462
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 23:40:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5EFE060ACC;
	Thu, 15 Oct 2026 23:40:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SoFUPNUrkKzf; Thu, 15 Oct 2026 23:40:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5564160AB6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792107608;
	b=h3hPCBoMULLh2SGMzS42jzoiMtH2naga3N9hHIKGMQ7y9QEKnHhp/e+zyjOIuJxmWXU2
	 zWz9fAYB/Tb0V7mx8P7Pa3OMIyfaeL5bT1+cg3bqn0CMrue/K8Fl60vGpQb9VZ2VFESex
	 ZDVx3Zm95h0peVZsaEJGcreiuYlQNLNnwE8r9Ij345c0XNqhCzu3WS+xkxlwcaQJIKaXK
	 hmKc60wtIXOn+iC3dgiqxC//zTehsfyfaPOox2FqXrRuKHX8VWxEYVJk7k+GJwpr6IIIH
	 rMNg1p1fco2z2rGE9tB5sw+MNt+f9FseE0dX8due0335/QXH8bQI+69oKnJSwVUlD4A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792107608;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:Subject:From:To:
	 Cc:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-Provags-ID:UI-OutboundReport:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=I54KflXh6sERCELYkyv4vKYcjHZzobPWY23ob2ZGQWg=;
	b=qAeVoZNLWf+vd0EuSKQj5L17/e43xSKqPSJ6C8ETOX20605l3OEdQxDn5DpEKCL6Z971
	 3/kSVsorJO4n4KUaFoYtzZw+tE2bREYvr6n5+VMjO2SY2Q+dOb05L1FLdjsbgPHf0ap3Y
	 HHF+tJCNLDuhEGX/f7g3JJOz70n3tMe7gaWlo3kPKaAEkwhmpbO2W/QQ1AeEowNxUB62T
	 Jrswd/dumlLf6rpH1tOnnOvGU0crLa6yv0jLIyCJkhhEe8o5xBdAwcxlEMJbiyBSd1DV2
	 YSkRB9lcUd8jRGVK/DwMpA89bgnrB8wZ7TbfI1S/hZcQTn5LyzZYj3XOlse5kpXl64w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=ziswiler.com;
	dkim=pass header.d=ziswiler.com header.i=marcel@ziswiler.com header.a=rsa-sha256 header.s=s1-ionos header.b=gzED3bCr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792107608;
	bh=I54KflXh6sERCELYkyv4vKYcjHZzobPWY23ob2ZGQWg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lHuTFqIsw0hW8uM+x5O/OoLvL1Xm/QWUR+9KCG386OT0KCX/oGSkN86m+fAQoB0w5
	 w/DCKNyn1KZS0N1P3cnhRCpCZ/vtD8kxSW5cSqcsaf16WCz1MPIsxXqrol9T7pwExd
	 RzB0XEjYDOQPh6EVCx0u4T1o+DkwOoF3IdQNhuEBowdgLcyA6ztzPWSN02STo2zWVB
	 CqoRvCm+9+D4e68C6Ln9WuQ6y94xriz44wk5HNy4CO0HUAmPD9zIphGQLojqRuZWen
	 c5/vQ38+3KbqesYucXApSiStoI887kde8P6zAE4ntrdmkzIVapGagHV9z+xgsnQ2uZ
	 Uh3W2cHySAlwg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5564160AB6;
	Thu, 15 Oct 2026 23:40:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9693079D
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 23:40:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9435B60AB6
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 23:40:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id klt3oYqikkU9 for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 23:40:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2235D60A9D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=74.208.4.196
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792107606;
 b=fM5uxKLQqYVxEf5SGiI2CFA71CA4qWhIFW2eUK5qREk60IvOAGNBVooStO+EDOujSKxz
 7wDYTbxGjeUJy8VsJoMoS3kLnQ7Xm+1MuXC0ktqzGv/qyIfi+nbPxruzYRZmOPmBCUOIc
 6S1pe7DciYpWWuBa4kdwdLwAR3sgezVBljZU6/HBTB/SxpVnPjF1Hn92cfZ6XA1N7TlAS
 Zfo/sbAz7yQGoE3Li/Md0JOvBqhHqeKOHZBn6tX42Ss8bSdGfng6zYU/RBCSMzG6PznMo
 l+1t2g5GNa5PpDZDFy7Eebs7MdMp798hxZToKZLZWp/GMWffN2t1EfL3rb/gBtazgqQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792107606;
 h=Received-SPF:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:
 Subject:From:To:Cc:Date:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:User-Agent:MIME-Version:X-Provags-ID:
 X-Spam-Flag:UI-OutboundReport;
 bh=I54KflXh6sERCELYkyv4vKYcjHZzobPWY23ob2ZGQWg=;
 b=g3zMWijPSbIsXlhw/xz8jzc0rOyPPgFlpgTU46dJi4aqCekHj8H8FR2+d+JIl61dnXTE
 SM8M1QWt2jnajk/lSt0K1KX0cIYeD+10LGtuQ1ZpN7yXuE7jQxYizGH7PU9oJhDnPNOLT
 t9MJycZXhtY2CD0eGS0G8pghYbsepHe0LFdY53tiKuHUr1LaAG6fHal1iZSw9b/+ex/Ex
 8XxDJP46VJzoNG2ekfwBixMpIMzRzhFxM27AwuDIkwMElLD4s8Qn4d2NAAoH6nlc+RBUi
 copf//1kmkZ30iVoOXBJ8VFRCRS2BZQeOYOmC+F5ule5+2TctelAHIQqBFG1OZT3ZjA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=ziswiler.com;
 dkim=pass header.d=ziswiler.com header.i=marcel@ziswiler.com
 header.a=rsa-sha256 header.s=s1-ionos header.b=gzED3bCr; 
 arc=none smtp.remote-ip=74.208.4.196
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=74.208.4.196;
 helo=mout.perfora.net; envelope-from=marcel@ziswiler.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=ziswiler.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ziswiler.com header.i=marcel@ziswiler.com
 header.a=rsa-sha256 header.s=s1-ionos header.b=gzED3bCr
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2235D60A9D
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 23:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziswiler.com;
 s=s1-ionos; t=1792107597; x=1792712397; i=marcel@ziswiler.com;
 bh=I54KflXh6sERCELYkyv4vKYcjHZzobPWY23ob2ZGQWg=;
 h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
 References:Content-Type:Content-Transfer-Encoding:MIME-Version:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=gzED3bCrtpKWRpWasDy3NIyj/ugtsFPa9HIQ/nDmp9iM9Tvw1QBMaVsS0W+om45O
 NVL+uMgXCegFoRJYbyVJ/K9888kVl3wIYIKk5KYI5OmQGZ41U5urTPv+bx1X1uG95
 1SjVfFd763ERHT338cuR5pm57FuLeuMazVfeDgH6xITTniCMr/WWoY2TbmUphKi18
 4s6LArn206nlNHQGCcPCYQsRrctRfYfwxoAAFoorVhzrSqBVnkqNIYkl2a2kahvGB
 TDQCmuQtpLEO70MTxYI0NXOjXfX01vDg81CyswGPTTD/rjLAGYTST52/hnu7luzZO
 SRwB72XInKlrHlE1tA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelay.perfora.net (mreueus004
 [74.208.114.78]) with ESMTPSA (Nemesis) id 1MOznU-1wykmO2KTM-00NuGV; Fri, 16
 Oct 2026 01:39:56 +0200
Message-ID: <5eae035c16410c2ab0808e3897fb56ea47b23aee.camel@ziswiler.com>
Subject: Re: [REGRESSION] Re: [PATCH v2 5/9] lib/string.c: implement
 strdup() and strndup() in terms of memdup_nul()
From: Marcel Ziswiler <marcel@ziswiler.com>
To: Rasmus Villemoes <rv@rasmusvillemoes.dk>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, Simon
 Glass	 <sjg@chromium.org>
Date: Fri, 16 Oct 2026 01:39:53 +0200
In-Reply-To: <87h5iq2b5a.fsf@rasmusvillemoes.dk>
References: <20260421075439.16696-1-ravi@prevas.dk>
 <20260421075439.16696-6-ravi@prevas.dk>
 <AcudIuPdPJ5-kqSj6e-s_SQbe9Z8Q5HcjiZsubil4biPj9gti7a9LBnOeY9773esCblkiUJI8hX-N9MbZi_fjg==@protonmail.internalid>
 <eb6c3466ddd897979fc08742e721d911fafef190.camel@ziswiler.com>
 <dkoQtduO2VZZSg_twn6aEON3-1NIERFMb5inRq_5NFYBZoJupMdXDBX_2xw5aceIk258QYzLZqn1b6Fyfrr5KQ==@protonmail.internalid>
 <87wlrm2fcg.fsf@rasmusvillemoes.dk> <87h5iq2b5a.fsf@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.0 (by Flathub.org) 
MIME-Version: 1.0
X-Provags-ID: V03:K1:CRdLFzgL/ZLMF8hMBWAEoK6RC2DJue9NjSk9Iw6qOug9MNwGeyc
 DpA0pO0FFJ3/be/5WjVNrEGOYRiIrc0lwLNIQ3y13UdawIIIXJ0hrMMQTKqoCUFurUlSRya
 Cyn/J2lryO665sywiWoFCT4NARqvgrwNEi4Y5iaOwN0JlR6DGt4BXrFPmj7yWuT6+2nNeQ7
 mu08lnR8JNhmBfF30TRwg==
UI-OutboundReport: notjunk:1;M01:P0:c7OMYJ7yZq4=;CXA7PtADltbzkXHjtTPg7kbVoUE
 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
 b6RGpxGAgS2U0e+HOXA==
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

Thanks Rasmus

On Tue, 2026-10-13 at 11:38 +0200, Rasmus Villemoes wrote:
> On Tue, Oct 13 2026, "Rasmus Villemoes" <rv@rasmusvillemoes.dk> wrote:

Yeah, overflow check sounded too easy, but I did try that for a start. Stil=
l hangs.

Then, I tried which one actually fails and it is strdup.

If I just add size_t len =3D strlen(s); to the top of the old working strdu=
p() function, it also hangs. Strange.

No, wait a minute, it just gets called with null strings, yes.

But the new implementation should catch that as well. Strange.

Somehow it does not like another level of indirection. But I haven't quite =
figured out what exactly it is that
goes wrong. Will keep prodding it...

> > The only other difference I can see is the U-Boot version doing a tail
> > call
> >=20
> > 	return memcpy(dst, src, len);
> >=20
> > which relies on memcpy() being defined to return the dst argument. Now,
> > usually nobody uses memcpy's return value, but it can make code slightl=
y
> > more compact, and any custom memcpy() implementation (e.g. in asm) _mus=
t_
> > honour this, as the compiler might transform
> >=20
> > =C2=A0 memcpy(a, b, c);
> > =C2=A0 return a;
> >=20
> > into
> >=20
> > =C2=A0 return memcpy(a, b, c);
> >=20
> > [I know this because I played around with this in godbolt a few years
> > ago, and I think found that gcc did this but clang did not, or somethin=
g
> > like that].
>=20
> Just for my own future reference: I misremembered slightly regarding the
> gcc/clang behaviour, but I did file an llvm bug report back then. That
> was just very hard to re-discover because my name was not included when
> llvm migrated their issue tracker to github, but it's this one:
> https://github.com/llvm/llvm-project/issues/46610=C2=A0.
>=20
> > So my best bet is that your platform uses a custom memcpy() which does
> > not have to right return value. Can you try changing that last
> >=20
> > 	return memcpy(dst, src, len);
> >=20
> > into
> >=20
> > 	memcpy(dst, src, len);
> > 	return dst;
> >=20
> > and verify in the disassembly that the compiler hasn't changed it back,
> > and then see if your board boots?

Tried that but also did not help. But I will do some more disassembly analy=
sis...

> As for this hypothesis, I did quickly look at riscv's asm memcpy(), and
> I don't see anything obviously wrong (it does have a "save for return
> value"). But the arithmetic and comparisons are somewhat risky and
> not-obviously-correct, I think. For example, doing
>=20
> 	/* Unrolled wordwise copy */
> 	addi	t0, t0, -(16*SZREG-1)
> 	bgeu	a0, t0, 2f
>=20
> to see if the end of the destination buffer is at least 16 words ahead
> of the a0 doesn't work if we happen to work with addresses very close to
> 0, i.e. something like
>=20
> =C2=A0 memcpy(32, from_somewhere, 256)
>=20
> would certainly fail. But I know nothing about riscv, so I can't really
> read the asm properly, and the "close to 0" thing is unlikely to be the
> real problem.
>=20
> Nevertheless, another thing to try is disable CONFIG_SPL_ARCH_MEMPCY
> (and CONFIG_ARCH_MEMCPY for good measure) and see if that makes a
> difference.

Tried that which let to:

/riscv64-glibc-ubuntu-24.04-gcc-2026.08.27-nightly/bin/riscv64-unknown-linu=
x-gnu-ld:
arch/riscv/lib/memmove.o:(.text+0x8): undefined reference to `__memcpy'
/riscv64-glibc-ubuntu-24.04-gcc-2026.08.27-nightly/bin/riscv64-unknown-linu=
x-gnu-ld: relocation
R_RISCV_CALL_PLT against `__memcpy' which may bind externally can not be us=
ed when making a shared object;
recompile with -fPIC
make: *** [Makefile:2113: u-boot] Error 1

So I also had to get rid of CONFIG_USE_ARCH_MEMMOVE.

Outcome is still the same hang.

> Rasmus

Cheers

Marcel
