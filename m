Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB801FF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 22:49:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B101846F1;
	Wed, 29 Apr 2026 00:48:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=bens.haus
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bens.haus header.i=@bens.haus header.b="KIMLjSc7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1B5384698; Tue, 28 Apr 2026 23:45:49 +0200 (CEST)
Received: from mail-106100.protonmail.ch (mail-106100.protonmail.ch
 [79.135.106.100])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 696BB84682
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 23:45:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=bens.haus
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ben@bens.haus
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bens.haus;
 s=protonmail3; t=1777412745; x=1777671945;
 bh=1j2yz/SyvuIIyWy9zKkYR+qw39R6lHTOapmze5dFUC8=;
 h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=KIMLjSc7S0F8/TtK5/6M/J9KOtr0LpunMbz6Ar+/jU9CbUhBzCz6iZxbS/3Dn0gfT
 69hJ6SRMWj1s97Ot9onFd+kPYMJOi/x3naXBfTEmw/fhcXGZy9hy7ghdaevRs1vwQ1
 b5js8Z7yo8gmnq/YysOjLJk8HXUfANIeQIpQh4DPbkm3F5prNnznBEV7fDeZui729A
 9JFwpPPUjLx28yswC9hKIE3JvQeh4TCmvw0qK5DpGTM/laQaw0jJ8ipcvVzlsmdkuh
 XMcbDYamqvBIf1UmeqNZY60ID8GJWt0MLr9B+sgaY28f9VI+zH2BiglBK6c8vt7e0i
 YW1IhmS1H4eAw==
Date: Tue, 28 Apr 2026 21:45:40 +0000
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
From: Ben Schneider <ben@bens.haus>
Subject: v2026.04 crashing on Marvell Armada 3720
Message-ID: <IRefanijM8fTzOXeGe-H5hmhRkm7pt4Q83BV6VcWKlWp0s4i8mYcONTQz-IVhvNWlGta4LtnfK7ti6gxlrqq8h8cotgG1S0Fs6_DviAHvyo=@bens.haus>
Feedback-ID: 124562356:user:proton
X-Pm-Message-ID: c28319cb733187796a59e29327b4edc23d16d5a1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 29 Apr 2026 00:48:15 +0200
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

Hi, with v2026.04 my device crashes on boot (v2026.01 works fine). It is an=
 ARMv8 device (Marvell Armada 3720). The config I use is mvebu_espressobin_=
ultra-88f3720_defconfig. v2026.07-rc1 is also crashing. The crash dump outp=
ut when trying to boot v2026.07-rc1 is:

"Synchronous Abort" handler, esr 0x96000044, far 0xd5380000aa1e03fd
elr: 00000000000369d0 lr : 0000000000036a2c (reloc)
elr: 000000003ff4a9d0 lr : 000000003ff4aa2c
x0 : 0000000000000098 x1 : d5380000aa1e03fd
x2 : 0000000000000000 x3 : 0000000000000000
x4 : 000000003fb07b00 x5 : 0000000000000000
x6 : 0000000000000000 x7 : 000000003fb07b20
x8 : 000000003faff62c x9 : 000000003fb00014
x10: 0000000000000000 x11: 0000000000000600
x12: 000000003faff6ec x13: 000000003faff990
x14: 000000003faff990 x15: 000000003faff3e0
x16: 0000000000000000 x17: 0000000000000000
x18: 000000003fb03e10 x19: 0000000000000000
x20: 000000003fb07780 x21: 000000003fb077a0
x22: 0000000000000000 x23: 0000000000000000
x24: 0000000000000000 x25: 0000000000000000
x26: 0000000000000000 x27: 0000000000000000
x28: 0000000000000000 x29: 000000003faff780

Code: f9405261 f9005274 f81e02a0 f9000681 (f9000034)

All code
=3D=3D=3D=3D=3D=3D=3D=3D
=C2=A0 =C2=A00: f9405261 ldr x1, [x19, #160]
=C2=A0 =C2=A04: f9005274 str x20, [x19, #160]
=C2=A0 =C2=A08: f81e02a0 stur x0, [x21, #-32]
=C2=A0 =C2=A0c: f9000681 str x1, [x20, #8]
=C2=A0 10:* f9000034 str x20, [x1] <-- trapping instruction

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=C2=A0 =C2=A00: f9000034 str x20, [x1]


I tried to look up 00000000000369d0 in u-boot.map, but it was not there for=
 some reason. Any guidance would be appreciated.

Thank you!

Ben
