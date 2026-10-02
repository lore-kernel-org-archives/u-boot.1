Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3879ACA5FCE
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 01:04:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0091E60BD3;
	Fri,  2 Oct 2026 01:04:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9fToduWkwyGj; Fri,  2 Oct 2026 01:04:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5926A60B5D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790903051;
	b=Wlov2EOrTTy2Dt6c3CZ4TlMJj5WG3PUXkyBH9lGPId0pIararz759FwfUfvdgAX1Qo/6
	 Zm3iyk/N1RbqPKhbkxi+IWK+jocpR4a5Zm/V/0Ux2r0Z1Fcb51HIcmU9D12wgfGblB+/a
	 xzZtJRpp91QpDMx9wK98lW33FMIDwlbzei8XpVJSJt+fJpLeDMonOv3mTlRaRvLZd5oAp
	 /cttqfXZyK3c7reKsUi2grmNeUGtP+byye3aNKeLzpg91/eMpUw0jLlui8qKWtABJztyL
	 HeV/0h4IK9Sdu5s8DaY/krWWrJmu4dS5/9TjdP7rTzDUk1lcoxRKPa1X6G3jFsTZSTw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790903051;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Uf8HNQJey/dLhCBM56zAelAII/H0ESSWyfxM1ERJzWs=;
	b=Dx3zIfQG0PJgmqXaO3Cf2mFbdmsv2u2b56cbhdYOeCAnILZr5n4mjMpW1kk3Pva60vra
	 kd4dYj9VMbi9siDz2LTaoWxuLAkghWWgEVTctT4BDuxOoN9v/7y4lU5hSLcFm+g/dC39q
	 b6+fAk/YsDd+MxpK6gsFmYQQj3hU4Qh/0rlWK1vOuDZEVz1ChlS4iSnZrdf1TZ7YEC+Yj
	 4Dz5GJab18G8XcDtt9930GbtkXcjnooyIBYgrdIMSBlYEB24oqLFwpPDNSTcJPR6+I0ZS
	 sraYuqcFGqbUjvW0bxIXKqyVWlQjL0YlKouSKiLsVbKq6tG1oy3fp0Trzkh0E6Y8m3Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hq7mPyhE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790903051;
	bh=Uf8HNQJey/dLhCBM56zAelAII/H0ESSWyfxM1ERJzWs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dO7/xTaLCtlVgFA1VC+XHw4tn7V5OAgHrmkZSuPA2sr21m5/PjcyBW5kuPxkf+s2H
	 NsUn34qLndOsvhnCgNGYNi60zO9mijVlvJdr48ifOcrabyEmeddfLmMnl2nGp4fuxt
	 GLIuy2YE7K8ahDhIgwX7qeuvBsf7ZdXyprIrp7IdRG9gsflcylUHiwk3liXSXKQUgb
	 shcLOlWXBKEg/rIaXnL0J4DcP3yajgM2GxTmu1imsI5imA1519go8Lhi6jbP56z92H
	 fkiKBjF9c+6Ogh9bBVolbAGKMDMKEKOrp8WuR7ifYZnnCvAO4MG4a0UT4Qo3MpkiWg
	 lBBtwEZzOOKvg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5926A60B5D;
	Fri,  2 Oct 2026 01:04:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6EE214D9F
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 01:04:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 601D360B5C
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 01:04:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W3q8-wLb0a5a for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 01:04:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 21AC360670
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790903047;
 b=H+2pDGK0J+Jd3SJxMwnEWzXzDRaKw4/JmpmUnou4CW8TWHwPXCL4TaRcjjfHyJQmcIt9
 WV1CqdBI++RvIBl+GOwKJxZwp2Klg3bBW/REj4Z8CyXoKZDkeBUAV93wnBMXbA4oo74s8
 dfBSUWOQZs3X0mHhyL3Wq1Ocklxsi7en69/UK/czdOlZg1yqOpyCHliFAEGAR/D9stReA
 n38Hp4//PibI2LxSS+jbUkt85rMbB9qIyC22ilkWe0Uh3jHf6SLyr/uv+SYg+sjbVKtso
 2cCjMS7obk6NyDVVGgqES80mmNm9BoH36cROmAzRw8Eiwsw/aKxYAVv4e8pMtJYOtcA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790903047;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=Uf8HNQJey/dLhCBM56zAelAII/H0ESSWyfxM1ERJzWs=;
 b=EOdRig34qwA32aJXUh6i0BhSIzUInDFTczepUc27Ipokwa4HLxmoDpjd+Dlhu9+ClrMx
 n9bJBvkHzUJtL/puxh/7jP5lIaK3B6IHrXefknZ196Gr+bh9ZKvIjdCVIE6OGfcOa1SjU
 axNZzLKbQcR7DPPGtvdBjAzDLoHVSWAWOxDh5wqZm2UQo8Ge3WVvMxjZ/LaVA9+RE65Hh
 SLKjJmEiHofvKnRff74GnFhDIpSjZACAPYODxmUrraugev360/n6dJTUwVf7WFwvKhohJ
 tpjXge/WdR35jZJ6uBpJ+pUdBBHSY9qkucphi9pDQI17bm+z7gz4XdJpLnIrrZwRucw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Hq7mPyhE; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=Hq7mPyhE
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 21AC360670
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 01:04:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BE51E60218;
 Fri,  2 Oct 2026 01:04:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A00011F000FF;
 Fri,  2 Oct 2026 01:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790903045;
 bh=Uf8HNQJey/dLhCBM56zAelAII/H0ESSWyfxM1ERJzWs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Hq7mPyhEydnEPs7lbbwlqodJUUKcLFMAd7kPsSVgePPB3tqKHSd9HyxHz8e9iR39b
 GS6pRiBoCKkFRVk6uDsZz8cIZYFsTXXVmt7riAHc9qPdxha3MaWqnE37BDyBywnTWz
 eVvxwXOS5mkYPr2hwTOM+9GvlfO5FeYjnvRAI1iUHwAeQOIJHU76oUvY+wnzkDWTDT
 89gYGq5p6d1s/fe4GLXzfk8/I78OEATxnQgkQpqR40o8uGbPcX9mjWsSIFZXuptcfr
 DpE/N+LExGhcNwRbsrClA+bi4R15pZk6INrkulhoHzB8HqesBFKSLrEyqV1wXg3AYS
 TAmIIoV9OAVNw==
From: Yixun Lan <dlan@kernel.org>
Date: Fri, 02 Oct 2026 01:03:14 +0000
Subject: [PATCH v2 4/4] doc: spacemit: k3: Add Pico-ITX board
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-00-basic-spacemit-k3-v2-4-fd6779a0317c@kernel.org>
References: <20261002-00-basic-spacemit-k3-v2-0-fd6779a0317c@kernel.org>
In-Reply-To: <20261002-00-basic-spacemit-k3-v2-0-fd6779a0317c@kernel.org>
To: u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Hiago De Franco <hfranco@baylibre.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7989; i=dlan@kernel.org;
 h=from:subject:message-id; bh=qpU86wBzYBeKKYMF32aCJ5eNii+DoYThm0DoExZq8bo=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBqvwL30VAkTsBC3O6btfyI/ROgq2YVvejL6UIs6
 NmhXdRrW0OJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCar8C9xsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+097Q/8C5ij94NTHKiJtphQIjU/pJT1lBWNaVBkiwV1y2Qu+ejM8h33SOS5s
 mK7ME+ec5o3rUrK3k3SGPTon15YoeOX60xLqmkFcaET0A2sESIBe0hxdAs7UUkrJWtOmK6VdYKz
 FtjMt/PHsdmAh63t6jTXU74jgsWDU/RtAHt6A0LI+yDc+E2ItJEWHtoI0drM1JsodMvZViFbB7O
 yOcJuClPKMgDKc85eWEETt/JCF9R2cHigQwK4zKkbo7eJQ9oC8lqiNM9Vj+yYO5DoD5WXhxOaOo
 i2Q5xJtZJcFO+YV+dRnsDlMRdT57D7IghqQGZ+Kphg+c8Pq6AKC33q75tEd0LxuFwPNFJVfhW9J
 bUoxh+4uN7aLeYwy+vpng8+8R/t1ChfGiEh3euD17CBb1dNSnKpaDhqVf5va9Bjp3e9UBHzVuDB
 NVL/F26vnlrGzdH1lFMH0qCaWm8w/b1ltTPChfri3MuqMBLb2xgNJx5LERqWchJ62RKML6e+CdT
 8LO91w3WD9HLuqE4akc0I3A2QtFtszjxh6tdDj3RGw2OWESLSy4ZaHBwsxBvRqCYPNPLMLduJtr
 /Uozwi0X8XODpi6iTvfdBKlxb0Ppz0/4XbLgLMLUV1wToArtYzsvXiUNGno+g4gnm7Fnnk9Nbpa
 fn2KBWxE/LQGHOX4BA+sPIOEPY9je4=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55
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

Add documentation for how to test the mainline U-Boot on SpacemiT
K3 Pico-ITX board, currently it still rely on using vendor FSBL.bin
file to initialize DDR and boot U-Boot proper, and the opensbi
firmware is built from an on-going mainline branch.

Signed-off-by: Yixun Lan <dlan@kernel.org>
---
 doc/board/spacemit/index.rst             |   1 +
 doc/board/spacemit/spacemit-pico-itx.rst | 204 +++++++++++++++++++++++++++++++
 2 files changed, 205 insertions(+)

diff --git a/doc/board/spacemit/index.rst b/doc/board/spacemit/index.rst
index 71854e5735b..51918f0acc7 100644
--- a/doc/board/spacemit/index.rst
+++ b/doc/board/spacemit/index.rst
@@ -8,4 +8,5 @@ SpacemiT
    bananapi-f3
    k1-mmc
    k1-spl
+   spacemit-pico-itx
 
diff --git a/doc/board/spacemit/spacemit-pico-itx.rst b/doc/board/spacemit/spacemit-pico-itx.rst
new file mode 100644
index 00000000000..dd29e3c31c8
--- /dev/null
+++ b/doc/board/spacemit/spacemit-pico-itx.rst
@@ -0,0 +1,204 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+SpacemiT K3 Pico-ITX
+====================
+
+Building
+~~~~~~~~
+1. Install the SpacemiT riscv cross compile toolchain_, or skip it if riscv toolchain is installed.
+
+.. _toolchain: https://archive.spacemit.com/toolchain/
+
+2. Setup cross compilation environment variable:
+
+.. code-block:: console
+
+   export CROSS_COMPILE=<riscv64 toolchain prefix, e.g /opt/spacemit/bin/riscv64-unknown-linux-gnu->
+
+3. Before building U-Boot, OpenSBI should be built first. OpenSBI can be
+built for SpacemiT K1 SoC as below:
+
+.. code-block:: console
+
+   git clone https://github.com/spacemit-com/opensbi-upstream opensbi
+   cd opensbi
+   make PLATFORM=generic
+
+4. Then build U-Boot as following:
+
+.. code-block:: console
+
+   cd <U-Boot-dir>
+   make spacemit_k3_defconfig
+   make OPENSBI=<OpenSBI-dir>/build/platform/generic/firmware/fw_dynamic.bin
+
+This will generate u-boot.itb
+
+Testing
+~~~~~~~
+Currently, in this stage, the U-Boot SPL isn't ready, and has no ddr initialization code
+Thus please test with fasboot command via USB download.
+
+First, retrieve Bianbu Linux image from archive_ and extract the FSBL.bin firmware.
+
+Second, hold the FEL button of Pico-ITX board, then press reset button and release it .
+The board will enter into firmware download mode.
+
+.. code-block:: none
+
+   sys: 0x10001200
+   bm:2
+   usb_init : enter 3296,3072
+   usb_core_init : enter
+   DWC3_GRXTHRCFG:0x4400000
+   ROM: usb download handler
+    rst
+   done H
+   setup= 0x1000680 0x400000,
+    rst
+   done H
+   setup= 0x290500 0x0,
+   setup= 0x1000680 0x120000,
+   setup= 0x2000680 0x90000,
+   setup= 0x2000680 0x200000,
+   setup= 0x3000680 0xff0000,
+   setup= 0x3020680 0xff0409,
+   setup= 0x3010680 0xff0409,
+   setup= 0x10900 0x0,
+   usb_rx_bytes : start len[4096]
+   setup= 0x3020680 0xff0409,
+   setup= 0x3040680 0xff0409,
+
+Run following command to test:
+
+.. code-block:: console
+
+   fastboot stage FSBL.bin
+   fastboot continue
+   sleep 10
+   fastboot stage u-boot.itb
+   fastboot continue
+
+.. _archive: https://archive.spacemit.com/image/k3/version/bianbu/v4.0.7/
+.. _uboot: https://bianbu-linux.spacemit.com/en/device/boot#21-firmware-layout
+
+Booting
+~~~~~~~
+Sample boot log
+~~~~~~~~~~~~~~~
+.. code-block:: none
+
+   sys: 0x10001200
+   bm:2
+   usb_init : enter 3296,3072
+   usb_core_init : enter
+   DWC3_GRXTHRCFG:0x4400000
+   ROM: usb download handler
+    rst
+   done H
+   setup= 0x1000680 0x400000,
+    rst
+   done H
+   setup= 0x2f0500 0x0,
+   setup= 0x1000680 0x120000,
+   setup= 0x2000680 0x90000,
+   setup= 0x2000680 0x200000,
+   setup= 0x3000680 0xff0000,
+   setup= 0x3020680 0xff0409,
+   setup= 0x3010680 0xff0409,
+   setup= 0x10900 0x0,
+   usb_rx_bytes : start len[4096]
+   setup= 0x3020680 0xff0409,
+   setup= 0x3040680 0xff0409,
+   fastboot_handle_command: max-download-size
+   usb_tx_bytes : start len[14]
+   usb_rx_bytes : start len[4096]
+   fastboot_handle_command: 00072b20
+   Starting download of 469792 bytes
+   usb_tx_bytes : start len[12]
+   usb_rx_bytes : start len[469792]
+   usb_tx_bytes : start len[4]
+   usb_rx_bytes : start len[4096]
+   fastboot_handle_command: continue
+   usb_tx_bytes : start len[4]
+   j...
+
+   U-Boot SPL 2022.10 (Sep 07 2026 - 11:31:13 +0000)
+   LPDDR5 total size: 16 GB, data rate: 6400 MT/s
+   DDR training consume 5625ms
+   ..
+   OpenSBI v1.9-72-g13a401f8
+      ____                    _____ ____ _____
+     / __ \                  / ____|  _ \_   _|
+    | |  | |_ __   ___ _ __ | (___ | |_) || |
+    | |  | | '_ \ / _ \ '_ \ \___ \|  _ < | |
+    | |__| | |_) |  __/ | | |____) | |_) || |_
+     \____/| .__/ \___|_| |_|_____/|____/_____|
+           | |
+           |_|
+
+   Platform Name               : SpacemiT K3 Pico-ITX
+   Platform Features           : medeleg
+   Platform HART Count         : 8
+   Platform HART Protection    : pmp
+   Platform IPI Device         : aclint-mswi
+   Platform Timer Device       : aclint-mtimer @ 24000000Hz
+   Platform Console Device     : uart8250
+   Platform HSM Device         : spacemit-k3-hsm
+   Platform PMU Device         : ---
+   Platform Reboot Device      : spacemit-p1-reset
+   Platform Shutdown Device    : spacemit-p1-reset
+   Platform Suspend Device     : ---
+   Platform CPPC Device        : ---
+   Firmware Base               : 0x100000000
+   Firmware Size               : 416 KB
+   Firmware RW Offset          : 0x40000
+   Firmware RW Size            : 160 KB
+   Firmware Heap Offset        : 0x57000
+   Firmware Heap Size          : 68 KB (total), 1 KB (reserved), 14 KB (used), 52 KB (free)
+   Firmware Scratch Size       : 4096 B (total), 1472 B (used), 2624 B (free)
+   Runtime SBI Version         : 3.0
+   Standard SBI Extensions     : time,rfnc,ipi,base,hsm,srst,pmu,dbcn,fwft,legacy,dbtr,sse
+   Experimental SBI Extensions : none
+
+   Domain0 Name                : root
+   Domain0 Init Order          : 0xffffffff
+   Domain0 Boot HART           : 0
+   Domain0 HARTs               : 0x0*,0x1*,0x2*,0x3*,0x4*,0x5*,0x6*,0x7*
+   Domain0 Region00            : 0x0000000100000000-0x000000010003ffff M: (F,R,X) S/U: ()
+   Domain0 Region01            : 0x0000000100040000-0x000000010007ffff M: (F,R,W) S/U: ()
+   Domain0 Region02            : 0x00000000d4017000-0x00000000d4017fff M: (I,R,W) S/U: (R,W)
+   Domain0 Region03            : 0x00000000e081c000-0x00000000e081ffff M: (I,R,W) S/U: ()
+   Domain0 Region04            : 0x0000000000000000-0xffffffffffffffff M: () S/U: (R,W,X)
+   Domain0 Next Address        : 0x0000000102000000
+   Domain0 Next Arg1           : 0x0000000102091398
+   Domain0 Next Mode           : S-mode
+   Domain0 SysReset            : yes
+   Domain0 SysSuspend          : yes
+
+   Boot HART ID                : 0
+   Boot HART Domain            : root
+   Boot HART Priv Version      : v1.12
+   Boot HART Base ISA          : rv64imafdcbvhx
+   Boot HART ISA Extensions    : smaia,smstateen,sscofpmf,sstc,zicntr,zihpm,smcntrpmf,zicboz,zicbom,svpbmt,sdtrig,svade,ssstateen,v,f,d
+   Boot HART PMP Count         : 16
+   Boot HART PMP Granularity   : 12 bits
+   Boot HART PMP Address Bits  : 38
+   Boot HART MHPM Info         : 16 (0x0007fff8)
+   Boot HART Debug Triggers    : 4 triggers
+   Boot HART MIDELEG           : 0x0000000000003666
+   Boot HART MEDELEG           : 0x0000000000f0b509
+
+   <debug_uart>
+
+
+   U-Boot 2026.10-rc4-00501-g9fba7b59df42 (Sep 22 2026 - 13:08:33 +0000)
+
+   DRAM:  16 GiB
+   Core:  433 devices, 15 uclasses, devicetree: separate
+   Loading Environment from nowhere...Loading Environment from nowhere... OK
+   In:    serial@d4017000
+   Out:   serial@d4017000
+   Err:   serial@d4017000
+   Net:   No ethernet found.
+   =>

-- 
2.56.0

