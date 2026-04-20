Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E190F5581D
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 11:30:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E204484309;
	Mon, 20 Apr 2026 13:30:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="i13cATjq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5161C8430F; Mon, 20 Apr 2026 13:30:01 +0200 (CEST)
Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch
 [79.135.106.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FAD883E16
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 13:29:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=krotti83@proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1776684597; x=1776943797;
 bh=ai6c7uDUWb1q6YOur99NKGjcEHtAzyXjb0zHuL+U/DY=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=i13cATjq+r9Hr3Mb1qq42vDxBHVoyMgrMuR0tuYYmSRatASB5FDprGgaMUbUYwO+5
 DHn0Kif61Bx2JTRwnR9yR6SzFwA3whgkeun2pR1vS/dv+BwRydHP9MIRMe/5gWo7XW
 zMn05kKuZ2ZIa61sHuJtCLyf1z7dXGG6LtWujBnTcJ6QyR+i+vLXTvN03shMDlGLVF
 bzOtPlwOmmCGa+9yGBZWss3iZuKCWqPsHoX0vrS+MTUhEGeIsEub1iEYpDLvlAmB02
 zBO+E7fxdidMQbD/wyCXUBcy2vQbaLgHsakQcrNw8WYcSUDDtMBg682JaiIuXzKzzK
 DCpVpl8sX6K3g==
Date: Mon, 20 Apr 2026 11:29:51 +0000
To: u-boot@lists.denx.de, xypron.glpk@gmx.de, sjg@chromium.org
From: Johannes Krottmayer <krotti83@proton.me>
Cc: trini@konsulko.com, tuomas.tynkkynen@iki.fi,
 Johannes Krottmayer <krotti83@proton.me>
Subject: [PATCH v2] doc: emulation: qemu-arm: add secure state steps
Message-ID: <20260420112815.1448132-1-krotti83@proton.me>
In-Reply-To: <CAFLszTiH0T56YgWhjp6hiXMTswcgu-yp-ivSKS3u4JoPMJDBKA@mail.gmail.com>
References: <a1cd73a2-582b-447b-bb3c-e88afcf99545@proton.me>
 <20260224170908.GZ3233182@bill-the-cat>
 <37429ec3-d174-44d3-b113-bf6ce6d71096@proton.me>
 <20260224193312.GB3233182@bill-the-cat>
 <02e49242-da72-4bcd-a428-f7e8c9aee742@proton.me>
 <20260225004838.GA1593142@bill-the-cat>
 <20260225020042.20823-1-krotti83@proton.me>
 <20260225020042.20823-2-krotti83@proton.me>
 <CAFLszTiH0T56YgWhjp6hiXMTswcgu-yp-ivSKS3u4JoPMJDBKA@mail.gmail.com>
Feedback-ID: 148511850:user:proton
X-Pm-Message-ID: 82bfb3b5f183d211d3b77889838abee73230c2a7
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg=pgp-sha256;
 boundary="------7d89ee979fa324c35dfa3bf7c6a37a5b377ceb077db4317b47724c5ffc990ceb";
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
--------7d89ee979fa324c35dfa3bf7c6a37a5b377ceb077db4317b47724c5ffc990ceb
Content-Type: multipart/mixed;
 boundary=8dabed0eedbf2dd986c983d0fd84845d15d14ddb963db5d6d0f661c41797
From: Johannes Krottmayer <krotti83@proton.me>
To: u-boot@lists.denx.de,
	xypron.glpk@gmx.de,
	sjg@chromium.org
Cc: trini@konsulko.com,
	tuomas.tynkkynen@iki.fi,
	Johannes Krottmayer <krotti83@proton.me>
Subject: [PATCH v2] doc: emulation: qemu-arm: add secure state steps
Date: Mon, 20 Apr 2026 13:28:15 +0200
Message-ID: <20260420112815.1448132-1-krotti83@proton.me>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAFLszTiH0T56YgWhjp6hiXMTswcgu-yp-ivSKS3u4JoPMJDBKA@mail.gmail.com>
References: <CAFLszTiH0T56YgWhjp6hiXMTswcgu-yp-ivSKS3u4JoPMJDBKA@mail.gmail.com>
MIME-Version: 1.0

--8dabed0eedbf2dd986c983d0fd84845d15d14ddb963db5d6d0f661c41797
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add build steps for building U-Boot in secure state with
TF-A and OP-TEE. It includes the full steps for building
OP-TEE and TF-A to use with U-Boot. Also a short description
how to invoke QEMU with enabled EL3 and EL2. EL3 (machine
option secure=on) is required to run TF-A.

Signed-off-by: Johannes Krottmayer <krotti83@proton.me>
Cc: Tom Rini <trini@konsulko.com>
Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
---

Changes PATCH v2:
- Fix typo (OT-TEE -> OP-TEE)
- Fix grammatic and correct spellings
- Fix line warp and formatting
- Add 'git checkout' for the specific (tested) version in the used build commands
- Change misleading filename 'flash.bin' to 'qemu_fw.bios'


 doc/board/emulation/qemu-arm.rst | 88 ++++++++++++++++++++++++++++++--
 1 file changed, 84 insertions(+), 4 deletions(-)

diff --git a/doc/board/emulation/qemu-arm.rst b/doc/board/emulation/qemu-arm.rst
index 1c91c7f3ac6..9e993ca9783 100644
--- a/doc/board/emulation/qemu-arm.rst
+++ b/doc/board
/emulation/qemu-arm.rst
@@ -24,8 +24,78 @@ Additionally, a number of optional peripherals can be added to the PCI bus.
 See :doc:`../../develop/devicetree/dt_qemu` for information on how to see
 the devicetree actually generated by QEMU.
 
-Building U-Boot
----------------
+Building (secure)
+-----------------
+
+U-Boot
+^^^^^^
+
+- For AArch64::
+
+    make qemu_arm64_defconfig
+    make
+
+On successful build 'u-boot.bin' should be created. It's necessary in the following
+steps (building TF-A).
+
+OP-TEE
+^^^^^^
+
+- For AArch64::
+
+    git clone https://github.com/OP-TEE/optee_os.git
+    cd optee_os
+    git checkout 4.9.0
+    export CROSS_COMPILE64=aarch64-none-elf-
+    export CROSS_COMPILE32=arm-none-eabi-
+    make PLATFORM=vexpress-qemu_armv8a CFG_TRANSFER_LIST=y CFG_MAP_EXT_DT_SECURE=y
+
+At least OP-TEE v4.9.0 for AArch64 needs both compiler (64-Bit and 32-Bit edition) for
+a successful build. On a successful build following files should 
be created under the
+directory 'out/arm-plat-vexpress/core' from OP-TEE::
+
+    optee_os/out/arm-plat-vexpress/core/tee-header_v2.bin
+    optee_os/out/arm-plat-vexpress/core/tee-pageable_v2.bin
+    optee_os/out/arm-plat-vexpress/core/tee-pager_v2.bin
+
+TF-A
+^^^^
+
+- For AArch64::
+
+    git clone https://github.com/ARM-software/arm-trusted-firmware.git
+    cd arm-trusted-firmware
+    git submodule update --init
+    git checkout v2.14.0
+    export CROSS_COMPILE=aarch64-none-elf-
+    export BL32=path/to/tee-header_v2.bin
+    export BL32_EXTRA1=path/to/tee-pager_v2.bin
+    export BL32_EXTRA2=path/to/tee-pageable_v2.bin
+    export BL33=path/to/u-boot.bin
+    make PLAT=qemu BL32_RAM_LOCATION=tdram SPD=opteed TRANSFER_LIST=1 all fip
+
+On successful build the following files should be created under the directory
+'build/qemu/release' from TF-A::
+
+    arm-trusted-firmware/build/qemu/release/bl1.bin
+    arm-trusted-firmware/build/qemu/release/fip.b
in
+
+The following file is at least created with TF-A v2.14.0 and can be directly passed
+with the '-bios' option to QEMU::
+
+    arm-trusted-firmware/build/qemu/release/qemu_fw.bios
+
+If the single file ('qemu_fw.bios') doesn't exist, 'bl1.bin' and 'fip.bin' can be
+concatenated with the command 'dd' alternatively::
+
+    dd if=bl1.bin of=qemu_fw.bios bs=4096 conv=notrunc
+    dd if=fip.bin of=qemu_fw.bios seek=64 bs=4096 conv=notrunc
+
+Building (non-secure)
+---------------------
+
+U-Boot
+^^^^^^
 Set the CROSS_COMPILE environment variable as usual, and run:
 
 - For ARM::
@@ -38,8 +108,18 @@ Set the CROSS_COMPILE environment variable as usual, and run:
     make qemu_arm64_defconfig
     make
 
-Running U-Boot
---------------
+Running U-Boot (secure)
+-----------------------
+
+- For AArch64::
+
+    qemu-system-aarch64 -machine virt,secure=on,virtualization=on \
+    -nographic -cpu cortex-a57 -bios qemu_fw.bios
+
+For additional QEMU comman
d description see running U-Boot in non-secure state.
+
+Running U-Boot (non-secure)
+---------------------------
 The minimal QEMU command line to get U-Boot up and running is:
 
 - For ARM::
-- 
2.47.3


--8dabed0eedbf2dd986c983d0fd84845d15d14ddb963db5d6d0f661c41797
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
--8dabed0eedbf2dd986c983d0fd84845d15d14ddb963db5d6d0f661c41797--

--------7d89ee979fa324c35dfa3bf7c6a37a5b377ceb077db4317b47724c5ffc990ceb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wqsEARYIAF0FgmnmDi4JENZhmZzqxMCeNRQAAAAAABwAEHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmdogv4+wMmyAUbORU+htSToFiEEGl1uDpESklxP
VqyG1mGZnOrEwJ4AAMrUAQCtGkkrm02Dry8Ug6FBSTlAf/HevWA7cVfrGhmP
ovB47gD/fPgMaGaewlfO0xOUTEXDRsuTICthQwUYcAaXNusR/Q8=
=7ih8
-----END PGP SIGNATURE-----


--------7d89ee979fa324c35dfa3bf7c6a37a5b377ceb077db4317b47724c5ffc990ceb--

