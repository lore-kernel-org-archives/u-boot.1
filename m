Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA4BBC83F17
	for <u-boot@archiver.kernel.org>; Thu, 10 Jul 2025 21:56:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66EDF83726;
	Thu, 10 Jul 2025 23:56:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=on-the-web.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=on-the-web.ch header.i=@on-the-web.ch header.b="h8dwuy5q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 475AA835FD; Thu, 10 Jul 2025 23:50:25 +0200 (CEST)
Received: from mail-10626.protonmail.ch (mail-10626.protonmail.ch
 [79.135.106.26])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B2A0835B6
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 23:50:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=on-the-web.ch
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sputnik@on-the-web.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=on-the-web.ch;
 s=protonmail3; t=1752184220; x=1752443420;
 bh=D1CGpFjXfuw5dancmrqf4sN6u69ABpRkIISyzZB2rT4=;
 h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=h8dwuy5qga6O78e+AfDqjkQ9Y7tOJreq4kePV6vMGRWOg7Uz1xOR/W6eM5nlilwu4
 v9HdBfHApg6ixzYZGla13U2KGWqM86Kw5lPc0LCAXvhPd6okDjG1UyzkGL9VKerxcb
 ovMDWNrhJXqu4rI/RbJtoSYO4yqeKUnGAUHzzPmqX/CR252HK9HTF0zHnjGV8KJEL9
 gn525efAsDQ0qDEacGQfyxz6ocjKvECvbJaWzJtc4t3tpL+m7CbeiKYcwmjCgcIOrq
 w1G/98mMOTbGD/bmzverZXf2HeucQQghWsbMwZluRAI6pBZtu5rFrmmJaq/wkO/EoI
 m9Z+MZ6R2SFEA==
Date: Thu, 10 Jul 2025 21:50:17 +0000
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
From: Martin Herren <sputnik@on-the-web.ch>
Subject: Looking for mentoring submitting my patch for SYS_BOOTM_LEN
 adjustement for riscv
Message-ID: <ZuEBDA2GKTZJzMfYunZN62OM1OpnpKwMbwVlOleqz1CUxcyor7Hpb0FivfZzPJQxk36MFaqr9-ut_SbeSHmh8XwvkEdeWtTVLVQTLqq-Om4=@on-the-web.ch>
Feedback-ID: 61562450:user:proton
X-Pm-Message-ID: afdddbb1aa1e0d43e7a7c1ff0b65511d333f85a3
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg=pgp-sha512;
 boundary="------49acdac164ed39146818ef00fdcec9c704700d80fb2001c53343fe6bd2421c36";
 charset=utf-8
X-Mailman-Approved-At: Thu, 10 Jul 2025 23:56:14 +0200
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------49acdac164ed39146818ef00fdcec9c704700d80fb2001c53343fe6bd2421c36
Content-Type: multipart/mixed;boundary=---------------------fdccb7c07309d098ea00a8203c325001

-----------------------fdccb7c07309d098ea00a8203c325001
Content-Type: multipart/alternative;boundary=---------------------e4545c861256b3b739e619566348dc5e

-----------------------e4545c861256b3b739e619566348dc5e
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

Hello all,

My first post here. Is there someone willing to mentor me to submit my fir=
st patch ?

The patch is the following 3 commits:
https://github.com/u-boot/u-boot/compare/master...MartinHerren:u-boot:set_=
default_sys_bootm_len_for_riscv

It adjusts the SYS_BOOTM_LEN for RISCV to the most commonly used value.

For context, working on rebasing the Allwinner D1 branch on some u-boot fo=
rk to up-to-date U-Boot I saw that the strange way in which SYS_BOOTM_LEN =
was patched in Yocto's meta-riscv layer was not working anymore, so I trie=
d a clean fix and thought an adjustment of the SYS_BOOTM_LEN's default for=
 riscv might make sense.

So if anyone is willing to mentor me in submitting this patch this would b=
e welcome !
It is mostly the patman part that is still a big unknown for me and i'm af=
raid of spamming far too many people trying by myself otherwise.

Or does this patch not make sense at all ?

Thanks !

Martin
-----------------------e4545c861256b3b739e619566348dc5e--

-----------------------fdccb7c07309d098ea00a8203c325001--

--------49acdac164ed39146818ef00fdcec9c704700d80fb2001c53343fe6bd2421c36
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wrsEARYKAG0FgmhwNYsJkIiu+thqKlAPRRQAAAAAABwAIHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmfVW+Jgi4R+gc9+6ERnOdtF7ywyRgX4U+hKRffq
j1CJkxYhBCYHlZbYUMXC4ILtW4iu+thqKlAPAACDnQEAiWNK0DbvevE/zSeu
qbsR2w6DfMuNOSwM7SQAGllXNrUBAPu0c1xQ4g9lxbKUWxXdsXCz+0Divg3M
2kXrwlVRrikF
=PmL8
-----END PGP SIGNATURE-----


--------49acdac164ed39146818ef00fdcec9c704700d80fb2001c53343fe6bd2421c36--

