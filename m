Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CB2FD111A3
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 03:30:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3500E89140;
	Mon,  4 Nov 2024 04:30:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=opvolger.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=opvolger.net header.i=@opvolger.net header.b="vZ1L/v49";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DF8288F33; Mon,  4 Nov 2024 00:30:25 +0100 (CET)
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7691888EB
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 00:30:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=opvolger.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bas@opvolger.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opvolger.net;
 s=protonmail; t=1730676621; x=1730935821;
 bh=UUnR+Ez40GD2TXBzQdIF+5MQkS2oPKKR/2kza4fQYVc=;
 h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
 List-Unsubscribe:List-Unsubscribe-Post;
 b=vZ1L/v495LEQ5QhIVEUu/euHR/8WMjCTG7ypvnKGvc+AeaE1pQ0zRc4AYw3ntz6mA
 rc2buzJ3s2bYv6lcyu3F4qUdU9ERpuMY2q4Ct4rNZyIrg+nQBZGjvRYFgxSqrGMbXo
 klySERQRJyQrMCkEbU5IUtsQsj4MpC/TvVXRahENWw61CODmm2tZYim6p6XfeGw4x2
 eKivbscaLtidTe/iCch8pxRfmacbmap3Y/8e2TTN5YgRUmUYKbFr51v44wynh8b1mR
 0unwwpe19uy62Bls+EWB1cbpo+0B7EA+hlMYhCXkrYlbOJUg06k7ygtlTOGf87ITEL
 0nhb0mjNUopbA==
Date: Sun, 03 Nov 2024 23:30:15 +0000
To: u-boot@lists.denx.de
From: =?utf-8?Q?Bas_Magr=C3=A9?= <bas@opvolger.net>
Subject: Fedora 41 drops OpenSSL ENGINE support, u-boot can't compile anymore.
Message-ID: <a0da63e8527876ed60cfce25700793600ea2304a.camel@opvolger.net>
Feedback-ID: 122982170:user:proton
X-Pm-Message-ID: fcb4cb0770769bf24ade6ac36332f449a493e68f
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 04 Nov 2024 04:30:40 +0100
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

On compiling on Fedora 41 you will get the error:

fatal error: openssl/engine.h: No such file or directory

It was already legacy:
https://docs.openssl.org/3.0/man7/migration_guide/#support-of-legacy-engine=
s

Fedora 41 has removed it:
https://fedoraproject.org/wiki/Changes/OpensslDeprecateEngine

So after updating to Fedora 41, I can't compile u-boot anymore. (I can
compile it in a docker-container). But this will be a problem for more
people.

The code that gives the problem is here added:
https://patchwork.ozlabs.org/project/uboot/patch/20170106191417.6115-1-geor=
ge.mccollister@gmail.com/

On GitHub I have created a branch that can compile now. But this is my
first c code in 20 years (only done this on my highschool for 3
months).

https://github.com/Opvolger/u-boot/tree/opensll-without-engine

I think you can make a nicer/better solution.

Greetings Bas.

