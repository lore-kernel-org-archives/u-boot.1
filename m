Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83A96E9B266
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 13:57:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9570C83EBA;
	Tue, 24 Feb 2026 14:56:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="FwYHYxcN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3DAB83D8A; Tue, 24 Feb 2026 11:26:41 +0100 (CET)
Received: from mail-106118.protonmail.ch (mail-106118.protonmail.ch
 [79.135.106.118])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 812B482BF2
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 11:26:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=krotti83@proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1771928798; x=1772187998;
 bh=D5qsXI47bN0ei110FJ+F6LcmPUvO2WD6msHs2w0Cx24=;
 h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=FwYHYxcNdie4koI9Gr9Rf/gT7Ba45KUR9KmRk04Vusu94Tqn10RhCgKHRrJZ+ZSgf
 +A98bZf3EdTHRTMu7oHNLvEm2Y93/zDj8SZH6wBN6HvlUwX2w+g5bGn+Jd4TLz0zrs
 LEbjVv9csyWsdoJ1Qw27T7qm4XLwP9dR35bZIy83lL1G+UGLq3hIk6U5m45T2qS2G8
 NjzmtqAJDdvSGo6wEowAovt3/uZR+gKIY7K8DcxtKCI+xz0Aa4qw/GyVT19DBsKIjy
 fHG9tXxzlf6WShaPwDN2V3bijiGUROzZz6mgtATy82Gde6+tgPrEqj5H3o9wyl7ykt
 21dM63rw9jKjA==
Date: Tue, 24 Feb 2026 10:26:35 +0000
To: u-boot@lists.denx.de
From: Johannes Krottmayer <krotti83@proton.me>
Subject: QEMU: arm64: bloblist not found and alloc space exhausted
Message-ID: <a1cd73a2-582b-447b-bb3c-e88afcf99545@proton.me>
Feedback-ID: 148511850:user:proton
X-Pm-Message-ID: bf3b8d5eb33a51935fe499d76ab7ea898d59e036
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg=pgp-sha256;
 boundary="------a198cb52fb2a41e01d37faeb782500fcff2277e2c2604a937b6d4fcc7ea1d6e8";
 charset=utf-8
X-Mailman-Approved-At: Tue, 24 Feb 2026 14:56:44 +0100
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
--------a198cb52fb2a41e01d37faeb782500fcff2277e2c2604a937b6d4fcc7ea1d6e8
Content-Type: multipart/mixed;
 boundary=1cdb815950907bafc5593e2f40e8582c1f7b0fe91b392089ef94b91c68cb
Message-ID: <a1cd73a2-582b-447b-bb3c-e88afcf99545@proton.me>
Date: Tue, 24 Feb 2026 11:26:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: u-boot@lists.denx.de
From: Johannes Krottmayer <krotti83@proton.me>
Subject: QEMU: arm64: bloblist not found and alloc space exhausted

--1cdb815950907bafc5593e2f40e8582c1f7b0fe91b392089ef94b91c68cb
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I'm tried to compile U-Boot for an QEMU AArch64 environment, but get
some error messages in SPL:

--
Bloblist at 0 not found (err=-2)
alloc space exhausted ptr 400 limit 0
Bloblist at 0 not found (err=-2)


U-Boot 2026.01 (Feb 24 2026 - 10:22:15 +0100)
[...]
--

Started the QEMU instance with the command line:
$ qemu-system-aarch64 -m 4G -machine virt -cpu cortex-a53 /
bios u-boot.bin
$

Also the same errors when I use TF-A and OP-TEE with enabled
EL3 and EL2 in QEMU and "u-boot.bin" as BL33.

Has somebody noticed the same issue?

I used the configuration "qemu_arm64_defconfig".

-- 
Kind regards,

Johannes K.


--1cdb815950907bafc5593e2f40e8582c1f7b0fe91b392089ef94b91c68cb
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
--1cdb815950907bafc5593e2f40e8582c1f7b0fe91b392089ef94b91c68cb--

--------a198cb52fb2a41e01d37faeb782500fcff2277e2c2604a937b6d4fcc7ea1d6e8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wqsEARYIAF0FgmmdfNsJENZhmZzqxMCeNRQAAAAAABwAEHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmfUUOH0/jvP9GfqdtMv7t8tFiEEGl1uDpESklxP
VqyG1mGZnOrEwJ4AADO/AP98LHRJ43NZHoBua/b54ZD+uY0G2wGSfeTFVSsU
+iFk6wD7B9p7VAbDDkyvU72aQ/VCK4x57tgE8cKHxmms6bSCvQM=
=b5TA
-----END PGP SIGNATURE-----


--------a198cb52fb2a41e01d37faeb782500fcff2277e2c2604a937b6d4fcc7ea1d6e8--

