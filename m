Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA8BF5A8C5
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 20:41:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DB6984479;
	Mon, 20 Apr 2026 22:41:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="CJuLXCT8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7A6B844AF; Mon, 20 Apr 2026 22:41:46 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D0BC843E3
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 22:41:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1776717704; x=1777322504; i=xypron.glpk@gmx.de;
 bh=LpF7Xt32s54i3VCpozTTql+RRebH3QjtGs0GQM0NfZo=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
 MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=CJuLXCT8MVAAhs791WfMWH1T/wcsWtNVu5Cj8cW5Gv8qlrFexUQZjVLXFY6bH/ce
 /ZeeMPfuwudA39g7mnaYgAFTyobzye8PzU54C1RCAJG1o9cEoE4V82qWo0MMAivAu
 r9x1AGz39wTq+9UHpVK/bezEdqRzuG0BJMCzd0GGhXDuiKeqo0r8ZYN5GP26cVy9Q
 3cEFNPNg/2QmuZzAJ8X+Lu2BEaLPHQeSzuWX9kXRLEhhHIG1DFE+9FdhmlSH+LggB
 yYcd/kvlJUdwdbGj3zIbS9iGDNUAojDXMY5H1FVu0WfgZWIBBjF9q+v+ATIo1kC+I
 u7516D7PY1Mru0B3PQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M3DJl-1wGHog464T-00F3za; Mon, 20
 Apr 2026 22:41:44 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Tom Rini <trini@konsulko.com>
Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Johannes Krottmayer <krotti83@proton.me>, u-boot@lists.denx.de,
 Heinrich Schuchardt <xypron.glpkg@mx.de>
Subject: [PATCH RESEND v2 1/1] doc: emulation: qemu-arm: add secure state steps
Date: Mon, 20 Apr 2026 22:41:14 +0200
Message-ID: <20260420204114.6495-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:59OWFI8a7cuwmbCQgmlLG5Rl3dva8EiWDGVzfgHVBx/P+EtPH4T
 DctNXuBFJAL5faYSvnJFw8jMoIZQLReMtOelduyETGqFXn5T6LMb7eEUWxSZoScdhTkz21J
 X7VSqKHT7wznI53K/w+yPor1hi0nZpK/97ChOo2eSsQp1DF4o1ZoDztzjaNKFMNAHmkV4gR
 gXCV5EEigF18TAWNbvICw==
UI-OutboundReport: notjunk:1;M01:P0:h95oeCwrYTk=;x9R7EeeqPxca+ILUZ5BpVWYXIEb
 J9/zC34nF9O8SURuXY3qOoddqi+sNEsvFyzE2boUH9CrvNMxkKuw6R7CWhsktXCQHEqy5neJP
 PtVVjziDUg+MlDhsamtirRmvXJrZamEcr57tugfvtxMkNKmbyGxt8uY8YZ+dQQJttBhosthG5
 yXroRWVk8bxcka2XTOpjcoU3LYTgKtIEuO649SjhKPh9kJ1/SFFeDW91fcokZMeAlvJdCHO/B
 b3oyR9kfMtVIONPjE28ewIel7NhGv/Nktn6DQYFmywnj0CETFUvYdAwENvCOAvW2cTa0fQRXJ
 fJSuKo0IBwv4dQcAyPGukKGib4X4k3UOsUJFqT7FI7HlNv4JRhVNHr9hwJVY7YA7/J4REgMxW
 OYC3ohg3eEqfXGECeLFC+ZLTjMe0TmUpZ0wYcakI3MOmV/qLkCsQoYPqFwtMbrhZQzKa/0cnC
 6WntPNBSxZMt1QjFHEaklNuzeFIv9nHm2+xdTmUfvwcJ4LKa9kxlO2IkJOFX0rTgxE0evTyPx
 xD/fMpbb6LfXOC5xz6Zat+PUYrfRcSXY/iFR8VXIMXvdAezP+QR9QIflcvdZxFjHdc/ndqTR4
 x15FsSeTf+O1oSHbhIeuRTht9mHdBBVCtYpxUxyWgAiuG5e7+6EgpW761Q59Eg2LVE7cFGtYy
 LrF15ulh2WPQBtHMtmNS2+i9wT6n/0gVWf9q99f8tisw4BiFAz9iRrGloNrK2VDGafeSuIHUY
 D0m085ENUTqyw1oFqkRyg6Zkz+NaQZB7aqXD46503nh85Hdd6qjOr6nTNQ09NCVt9TzlqsVnR
 jFs+1MVGXKCObh3g+Pabe2DG1rEhArQCkdEy//pLeXPPyw4Vt59rrjuxDGVlqefy/WiOkwUJk
 dkFbp4vbLOqDxtwO3aC7JKOjm7Mi2u5VQXaKuahUZdB9WN1aiKu4rdpUUKmxIU27kH0zQF7+L
 EJTUsTiEpVa95HiZbpY58USdEQFfslCB72PpofLLS34DZkDh0QADvFIXNLuVhgJiVoktPdiVO
 zmxRmTnsYCYmwP54OgdNTGq08c13xFgkCUjIBtAEL7ig96riERdMR8UJl7ZC0/hEcbwtyo0GR
 SOytdkrqDPRhBeUHibGIPRqa/IiiLTR4gHMk5jUMd3D0R52nKSeHaNV+Xvz2DYDjeU/UHm0wK
 PI7uEfjr/TYyE355MqMz+jW1izQnJ9bHpa4kowsO5olCr0vh3ibJ5G/TBzh4FKDLybjj3AFiW
 hwzsqJnYmKJuAPoZO/sN/XWS3HMDPgHIHtQDULXXjkgpcvfuCBusfJayKY0sZGDZdqALQjVFS
 GyI5Za3rNyIFacdCpGFxeliKvBPQFkoH/OmK5UWcZmkVYnHao5fnnWXaqoIjaxLv2UOEaQvus
 xjjrZcGGnAGCIQwQ52ZFptDlzh6HZqlmaZDfS4MXjNYw68VHONyxl1BWj6jAIrgyrxNw9U4uG
 /yiKWkYHzxijYWw2ZSNc+bplff2FDAM4CG4XK7xVBC/oYlNNe7LSlVEu2pXnw4Be7+2a4VKK1
 3tKBe22M1U3igmHsvs7y1b2KAyDnsNbeHdGaq4lT6QswnFeMQ9H1RJLXAeZrPl0yFcjOu9f5w
 VPNq1XBoxYSUqHScg6g9GMIJ/vhq+L4ltgTEvFgfK4440AHyumv8WHnlq8Jx9XfNa68Nrr+wX
 Az5QNn9OZMRyurG/Ym0WlcJAAHw6Er2VQJp6QXhBOWzx2QualoLBK3h581kCQi4WkbCVwwwUS
 nNr0t4cfPk3HLmWtNLd+rsg0m5wqJkRJ8RfEwB0uPY67EARnOcgfIUmjexkkko5vIUoUA/93l
 vFGF9qweZAfdD6ajN6R7PzkWs/8CH2a7UwiRWRKTIceNZcLwKvDAxEFS7NIXuR+WC4GCzFUAW
 fyD+t+sIwt1WM7UdF/b70e5QXMrbUSeyCO0oznpi2CjQojvUWAZTWUB73vcfh0fOZDjl2iKWj
 F88oiVVe9wh/ooA7bVOtQ3LTKX0V9u6SIYCyzmj8lJqMKd+V2+3DrQs35hjAfqN9kbquXN4Xw
 HqH+ReBMaym9/0l4gXfBJYq7d2mJ153H45VFca6/fGzKh4xGDp7seB1hr8FbURT8+kVDEb2jH
 TjpRnIf3xqvqZj89vEgMgQNZNEFgxxoNfjyr9zb6KPBQJ4QDThdTs9wXIckLtlJehWfP3NWOy
 mwCDXkj31VT8XxbdUBiAq2vOzDTyO5GsqtZU+Ff6mVMakLIup2Lc4HbbwgkQy0KX4tafUk9CB
 szjxCTurqYDIydqbQGka8xOK4z5dkfeU4tpHR2cTs7d17Pj06rBEulJsdQfLaBwy+pAehuieP
 i5kt1jECJAUWEsnD3GyXObCazE04tswkpCIy6PH8cNUuGj72zWJYH+l/7Lbzayo9nFAx0t8c2
 bEbpcGhs8vRAOn6Eg1AKpDYt494uUUQFae2SN/33+KzAwzIBHt27bxOhzoibkP3pTRWcaUKVk
 y0U3EsLUtUELHXWFjnCpGc/S1TBYnl4/I/UoS50OTC0yh2HI2RlKAcuxRiUzTejF81QJSJjh6
 35dpLFgw12pfxjkNrZoaS95LmtWco7qed5EsbdzXnMwZRDN9tkKMtCtCji5CAM+pllqIn3+8J
 dbBi+85lrcSTt6FVJ7jwa8Qh6m2E1NF7XaarVNCunBKRgdSCiwhZe54uo5f34KT4wJ6M0MvSY
 qCZqyyT+pv6RfLkO75mBJeG6xlJj4fz8f2wx+THFb15ybIQjoCIoGWs4x1k+OyEElvQgUJRu0
 xCMOk12s0lDD636Uy9sirkKt6o1fYcyO3Ej0tvxt9Hf4x28dJMib6+42FgNHmnwzQ8e0hKRrK
 AUiTx/qHENFEKA+tWD9z6qR/QCuvhWCPlJakNsyaUF4xd0whUBo05jSWfzd7Gkbif4AxIan8a
 Y5E2lJAkvBMSx+g9ShF3rhmf6nBuwcpJTQJ8CB2w0e8QFSYHzFriSGttVbQJSzKAXSht4p1as
 d5LSvmrrB5iHVFZNsXHjeno4szPKXtmqylA5n5aNwHUHC0E4IQhrDY5VpF+fOOUZ3v4IsEWzW
 +Y4Kmby8TMHLAo1lBZGxt0vUKyqT9/TwjpVRR6soK/y+anZ8dgYOmcdRCZbJPkg+Uu5WoXX8R
 hG+l3OYKQe3I80ix20HXI61eH1diz63YkWWjmlUiG4161Q0Vefnvbvt0Zu7E4H0vA0wao9g6u
 FejT3I+bt8AWIQ99WBE6A2vSriS77NAaCijWkVRwJMat5KV5cSTlhkkoKTv1RNhHolUO28rQT
 obYuiyfIOK6MIbrkBsH2Czx2ibO8wNgmAPL6Ggp1QUd/kCK13o21eekmve8cWVywIWjlceD71
 LSlR6+xqda7cxE0nRthRL4Tk/kgd1eVnNNY8jVPpow0Tbu5fxYK8LNRteUgnc2+Nm98YSy0nu
 3ptZTUYl103RiaKXEFlhiHP3LSXRzr8f+KhxWsJXu4a8cerqeIOxJ4QxgBpJaxUIUg90KHDO/
 qyD//MGlMGoCWw7W2Mr6MkzlYJVdF3QDrqqDb8KkGHyExTvXjrmg6y1Yb6usKd6jWK/BWfuaP
 1sJMRiqwSNbYU+9/C5ODmoJ3FO5iNc7QbmGeZcHaLgmcQd/8l+nT+hxvpeTdV2nU274BSHuKY
 io8mwWP0hMierYSgLNv5NqK9wzD+I1yCMvCzK6R6uiIFkFruDbYIQyHuxn2T3HTkGdRF+S0sr
 KJzJGopotW5f4xqUW0TM+yob3et1SaQSCAvtBKYgpX2RoG69pHSX2px49TDme74OrSFMcrkhr
 NKFJ/1AkfwJWnr8ED/bY94yNnB0xT92b0YcH8Z6sugOdOnDYJjqwFS5dog6qi1z6IOWO4UqC/
 x5EI5AOy9V5fqmNKtryHMXixWABZVBjK3yeL0iYXlJ5gYMzX+KodkRkhBzWox7RCMYAOaSiZA
 GZJ3c1lSScgZNi4ToXIRPgW8+heRiDZnPq9BFJiQYsDJGIueL8pwTUuxkE/oeohRxfuGZeVaO
 pK7H5HmOl1eqlMZB/l7RZ4djxhy/cdrlQapDP0NnZzOiV1S1ppsAv2hWelBxLDr8e2I6SL3e9
 mlsqEExQgk0BEtfKCN1SA8MTEFu46axGBSaOstR32qeFpuYoWvmhnU3YeNLLsqaN21pmOF2il
 bPmb+gL8nWkltxFBNqa0kH/8smNJW6JsKiwGmAYw0Astm6hNWmT/qCuASdERNl/MxsyEweb9H
 SZzUDkpIfSBZDtcGpIo4FO3Pc4pf023u6Mpb87bMSoXV27tVRI3AADIzQZ+Frp4VXOJf+VoUJ
 8RKmwOOQk9ckowF4QVP6Flc044PEpWTsBmrGVVmqlr7tX4GtrBWKuTK4jNlleTHZ4jFq4oXVd
 wV93C/873a2+Lsbcw2qy7goUDjyTo3/M9S8EdQSR1XUOBDD/mBUNVnYr5RhNVYpu1myStzW7R
 cL3NnHUiDy33k0YhFZCAqJfTqWv/aW9IR6yKYdwUyQ3YvIDaCWx/zTprZckhejdW/zymIOfCT
 YOaonrli3PaBaIGGdAYdn9sw2on+MUexjIREE71meS3MOpqltjX1BzXRTzcZu0XXHWZIu2YCR
 dV+R1/dcFESVJq3OC6FJXRv5hDhRzTXLuwi3Hc+PZs/MdDHVyyCyJGYi0O6j8KKA7+UAh+aVS
 zsBBnFWZ41pl57xOFM+BNK8rctVjvjqjf1dBJweKC+QCLgIb9WdhRAs+xo07iufeKhegKXVdg
 jcHepDOjPTTDDAgYbqcoKlCEQwvWut+kJibymL4spmsXZaVyIxQnn/VI3ZRWtffwLgCW/zIYk
 PxqH0SndRLib7/JGAy/yPPHWBV2cqq1ztM2lyrUyIzzPRuMyUlHXGThrcc2IU8/NPhDuEUU5y
 yMDU0OxeqHQO+mpQbPbwTMD8qwa7hZAU8IJBBa9MEcg5c/h2Lwd654UWsibXDwLLeA/5fIp96
 bYwOe8DnQge6F0L1rBuZGlLRNL7XpNTXN/tI+v5pik5pNjRKD60hScwYV2qf061Yo/0ceuFMq
 yxdBvbX50/pywGoP0BaRFLlhLdRi2jR6ZTAkl0BqaDFlF/AHaTb/1DxZJ5Hv1AdqWD5bxCAZJ
 me3HlBBL7ME5z7AyiLCRGaVPIuFpt/kA6vycbtLOPdQhf06ME9pfrMLZX1I6oB5T6Ygvqz9C9
 kzeE2Aiuqtt4ElAOtjS7LLPs+n4+VWq/0RUCNC7i7IKEtmaVlI4Uby2F+zyrmgAAW23TqVtbG
 Iu/dIusAi7wZAjaFt0/JkwRq7XhBuEHeHK7tUIIAwuat7NBMIBzo71dRXl+B8WTPgtWcPDxqe
 oTjjf9NoPNhON+f2VpzvWYUeYF9EEPZTOKflOHhouW+tkkZFPaK8kUK5QgPD94RfQDL6zuvNN
 RboUJQ8FBOdU2vJxp1SDh7ZkDgrlI6+Cu4R341EkoZF+8/+30Gppz/jIssRFxX59QFP720gvn
 KICnKYfg9EJdoeKWpIAPDXjx8TR7WA6UOycd32e5FdAvSHbbIj/xymS6Qdxvqs9w16
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

From: Johannes Krottmayer <krotti83@proton.me>

Add build steps for building U-Boot in secure state with
TF-A and OP-TEE. It includes the full steps for building
OP-TEE and TF-A to use with U-Boot. Also a short description
how to invoke QEMU with enabled EL3 and EL2. EL3 (machine
option secure=3Don) is required to run TF-A.

Signed-off-by: Johannes Krottmayer <krotti83@proton.me>
Acked-by: Heinrich Schuchardt <xypron.glpkg@mx.de>
Cc: Tom Rini <trini@konsulko.com>
Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
=2D--
 doc/board/emulation/qemu-arm.rst | 88 ++++++++++++++++++++++++++++++--
 1 file changed, 84 insertions(+), 4 deletions(-)

diff --git a/doc/board/emulation/qemu-arm.rst b/doc/board/emulation/qemu-a=
rm.rst
index 1c91c7f3ac6..9e993ca9783 100644
=2D-- a/doc/board/emulation/qemu-arm.rst
+++ b/doc/board/emulation/qemu-arm.rst
@@ -24,8 +24,78 @@ Additionally, a number of optional peripherals can be a=
dded to the PCI bus.
 See :doc:`../../develop/devicetree/dt_qemu` for information on how to see
 the devicetree actually generated by QEMU.
=20
-Building U-Boot
=2D---------------
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
+On successful build 'u-boot.bin' should be created. It's necessary in the=
 following
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
+    export CROSS_COMPILE64=3Daarch64-none-elf-
+    export CROSS_COMPILE32=3Darm-none-eabi-
+    make PLATFORM=3Dvexpress-qemu_armv8a CFG_TRANSFER_LIST=3Dy CFG_MAP_EX=
T_DT_SECURE=3Dy
+
+At least OP-TEE v4.9.0 for AArch64 needs both compiler (64-Bit and 32-Bit=
 edition) for
+a successful build. On a successful build following files should be creat=
ed under the
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
+    export CROSS_COMPILE=3Daarch64-none-elf-
+    export BL32=3Dpath/to/tee-header_v2.bin
+    export BL32_EXTRA1=3Dpath/to/tee-pager_v2.bin
+    export BL32_EXTRA2=3Dpath/to/tee-pageable_v2.bin
+    export BL33=3Dpath/to/u-boot.bin
+    make PLAT=3Dqemu BL32_RAM_LOCATION=3Dtdram SPD=3Dopteed TRANSFER_LIST=
=3D1 all fip
+
+On successful build the following files should be created under the direc=
tory
+'build/qemu/release' from TF-A::
+
+    arm-trusted-firmware/build/qemu/release/bl1.bin
+    arm-trusted-firmware/build/qemu/release/fip.bin
+
+The following file is at least created with TF-A v2.14.0 and can be direc=
tly passed
+with the '-bios' option to QEMU::
+
+    arm-trusted-firmware/build/qemu/release/qemu_fw.bios
+
+If the single file ('qemu_fw.bios') doesn't exist, 'bl1.bin' and 'fip.bin=
' can be
+concatenated with the command 'dd' alternatively::
+
+    dd if=3Dbl1.bin of=3Dqemu_fw.bios bs=3D4096 conv=3Dnotrunc
+    dd if=3Dfip.bin of=3Dqemu_fw.bios seek=3D64 bs=3D4096 conv=3Dnotrunc
+
+Building (non-secure)
+---------------------
+
+U-Boot
+^^^^^^
 Set the CROSS_COMPILE environment variable as usual, and run:
=20
 - For ARM::
@@ -38,8 +108,18 @@ Set the CROSS_COMPILE environment variable as usual, a=
nd run:
     make qemu_arm64_defconfig
     make
=20
-Running U-Boot
=2D--------------
+Running U-Boot (secure)
+-----------------------
+
+- For AArch64::
+
+    qemu-system-aarch64 -machine virt,secure=3Don,virtualization=3Don \
+    -nographic -cpu cortex-a57 -bios qemu_fw.bios
+
+For additional QEMU command description see running U-Boot in non-secure =
state.
+
+Running U-Boot (non-secure)
+---------------------------
 The minimal QEMU command line to get U-Boot up and running is:
=20
 - For ARM::
=2D-=20
2.53.0

