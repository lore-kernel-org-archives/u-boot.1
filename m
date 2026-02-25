Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6920DF55438
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 02:01:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CD3F83D8A;
	Wed, 25 Feb 2026 03:01:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="Enoipemk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 657B683DCB; Wed, 25 Feb 2026 03:01:48 +0100 (CET)
Received: from mail-106118.protonmail.ch (mail-106118.protonmail.ch
 [79.135.106.118])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9713C83C39
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 03:01:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=krotti83@proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=mkmhchfamvffpp4cefq4gg6fqq.protonmail; t=1771984904; x=1772244104;
 bh=YiSBh+kFPehMUyRqhUh0J3UBBoeEIY9jtQjicEkcdCA=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=EnoipemkhzW85p7gi1/qXdfXZAjLJiAfdw23MoCpgrb8WKi1by7TI9oX8FIB7MWIZ
 8SrIOu2+LfOyC1knyfM0etUDXFAzBgczGNmT9nONDxPuZY1UasFkzjEims66hWxG/g
 qNe1ek/cuIEjHJcKyH/Y2l8FXj1OMPoWj5JH8xC00MU55QIlEqlvp3V9KHNXtKBSvn
 uxOdZ9j236vA16jgZnTFd+nlM4yz2YqKjrks547JJVTVduNIe3xyOJaFJkRW5p3tv9
 uaTSzXgEi9ZXqksOnnpk7jIc23C40aErpU8tgo3yuqVYK0hDc6LqcDw3RZBVTd8M2f
 N2ujSawD5uYnA==
Date: Wed, 25 Feb 2026 02:01:39 +0000
To: u-boot@lists.denx.de
From: Johannes Krottmayer <krotti83@proton.me>
Cc: trini@konsulko.com, tuomas.tynkkynen@iki.fi,
 Johannes Krottmayer <krotti83@proton.me>
Subject: [PATCH 0/1] doc: emulation: qemu-arm: add secure state steps
Message-ID: <20260225020042.20823-1-krotti83@proton.me>
In-Reply-To: <20260225004838.GA1593142@bill-the-cat>
References: <a1cd73a2-582b-447b-bb3c-e88afcf99545@proton.me>
 <20260224170908.GZ3233182@bill-the-cat>
 <37429ec3-d174-44d3-b113-bf6ce6d71096@proton.me>
 <20260224193312.GB3233182@bill-the-cat>
 <02e49242-da72-4bcd-a428-f7e8c9aee742@proton.me>
 <20260225004838.GA1593142@bill-the-cat>
Feedback-ID: 148511850:user:proton
X-Pm-Message-ID: 68e47cf2c3e1456e8544d2301a3bc0d72271c08e
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg=pgp-sha256;
 boundary="------f411a97ca07840db9c597fcb5a809b703d79dfaf2b538e55d7bd632d5160c0b1";
 charset=utf-8
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
--------f411a97ca07840db9c597fcb5a809b703d79dfaf2b538e55d7bd632d5160c0b1
Content-Type: multipart/mixed;
 boundary=1adecace022473cf2b1e3385ed54b40c335f3adf853cad0064a0b8914b37
From: Johannes Krottmayer <krotti83@proton.me>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
	tuomas.tynkkynen@iki.fi,
	Johannes Krottmayer <krotti83@proton.me>
Subject: [PATCH 0/1] doc: emulation: qemu-arm: add secure state steps
Date: Wed, 25 Feb 2026 03:00:41 +0100
Message-ID: <20260225020042.20823-1-krotti83@proton.me>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260225004838.GA1593142@bill-the-cat>
References: <20260225004838.GA1593142@bill-the-cat>
MIME-Version: 1.0

--1adecace022473cf2b1e3385ed54b40c335f3adf853cad0064a0b8914b37
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I added some initial build steps how to build TF-A and OP-TEE with
U-Boot and run U-Boot with the specified option in secure state
(enabled EL3) in a QEMU instance. Currently I only added the 
build steps for AArch64.

I also add a note the current used version from OP-TEE:

CROSS_COMPILE will be no longer accepted. To successful build
OP-TEE for AArch64 the variables CROSS_COMPILE64 and
CROSS_COMPILE32 must be set. The AArch64 built also needs
the 32-Bit edition from the ARM toolchains, otherwise the
building fails. Current version is v4.9.0.

TF-A v2.14.0:

Sine at least version v2.14.0 the build system creates a
binary (qemu_fw.bios) which can passed directly to QEMU.
I also added the steps how to create an image from bl1.bin
and fip.bin with dd, if qemu_fw.bios isn't created.


Johannes Krottmayer (1):
  doc: emulation: qemu-arm: add secure state steps

 doc/board/emulation/qemu-arm.rst | 86 ++++++++++++++++++++++++++++++--
 1 file changed, 82 insertions(+)
, 4 deletions(-)

-- 
2.47.3


--1adecace022473cf2b1e3385ed54b40c335f3adf853cad0064a0b8914b37
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - krotti83@proton.me -
 0x1A5D6E0E.asc"; name="publickey - krotti83@proton.me - 0x1A5D6E0E.asc"
Content-Type: application/pgp-keys; filename="publickey - krotti83@proton.me
 - 0x1A5D6E0E.asc"; name="publickey - krotti83@proton.me - 0x1A5D6E0E.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCkNvbW1lbnQ6IGh0dHBzOi8vZ29w
ZW5wZ3Aub3JnClZlcnNpb246IEdvcGVuUEdQIDIuOS4wCgp4ak1FYUZyS2dSWUpLd1lCQkFIYVJ3
OEJBUWRBdm9MdzByd3hVZEZsMyszSytnTWhkTnlTK1p3WjU2Q0hlc2xBCndyKzhzalBOSjJ0eWIz
UjBhVGd6UUhCeWIzUnZiaTV0WlNBOGEzSnZkSFJwT0ROQWNISnZkRzl1TG0xbFBzTEEKRVFRVEZn
b0Fnd1dDYUZyS2dRTUxDUWNKa05aaG1aenF4TUNlUlJRQUFBQUFBQndBSUhOaGJIUkFibTkwWVhS
cApiMjV6TG05d1pXNXdaM0JxY3k1dmNtZnQwODBDTndEN0laNnB0eVgvVzhucHhhRFlwT0x6Zm05
Y21aK0hUUGJZCkN3TVZDZ2dFRmdBQ0FRSVpBUUtiQXdJZUFSWWhCQnBkYmc2UkVwSmNUMWFzaHRa
aG1aenF4TUNlQUFCdy9RRUEKOVVkYTBubVA4Q1g4UW1PciswNEY5U3g0c1NSUHhza0NsdE5rWlRW
RHROb0JBTjFlL3I5TnFZbUx1MjI4eHlVbQpmMHBkVXFlallJTytPT0lFZFFhMEZQd0V6amdFYUZy
S2dSSUtLd1lCQkFHWFZRRUZBUUVIUUJjYVpHMlZxK1MxCmV0Q2NSWDVJaGZnSHJCTFhIcGV1SzJC
VmZxZFNFVlltQXdFSUI4SytCQmdXQ2dCd0JZSm9Xc3FCQ1pEV1labWMKNnNUQW5rVVVBQUFBQUFB
Y0FDQnpZV3gwUUc1dmRHRjBhVzl1Y3k1dmNHVnVjR2R3YW5NdWIzSm44bk5IbWtwbApTakU0b1pU
WDVDZVlsamVGcmowd2pNWERNWENXZzdNNytnc0Ntd3dXSVFRYVhXNE9rUktTWEU5V3JJYldZWm1j
CjZzVEFuZ0FBZGdBQkFMc2p0elBMYjBnVytUQkFzVXNGNjNZUW1BRXBsUm55RWwxQ20rclJNZXJv
QVA5dVRkVFUKdThGL25ab0RUS3BxcGM4L1RqakhkU2JWMzMyUmhBdW1NSmQ4Q3c9PQo9TXJhaAot
LS0tLUVORCBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0t
--1adecace022473cf2b1e3385ed54b40c335f3adf853cad0064a0b8914b37--

--------f411a97ca07840db9c597fcb5a809b703d79dfaf2b538e55d7bd632d5160c0b1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wqsEARYIAF0FgmmeWAIJENZhmZzqxMCeNRQAAAAAABwAEHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmeFwGAZ2+WZLbFC4wFMB8clFiEEGl1uDpESklxP
VqyG1mGZnOrEwJ4AACvTAQC77Sdo01N9VHU3pxbcVATxrh8DgpY+eTGvSz4a
zrsh4AD+OMcsnoh2SdjamElmMmW64fTEnw57gLUp77HnYXwsVAQ=
=O5aA
-----END PGP SIGNATURE-----


--------f411a97ca07840db9c597fcb5a809b703d79dfaf2b538e55d7bd632d5160c0b1--

