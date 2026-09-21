Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE05C982EE
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 14:56:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8E6E240723;
	Mon, 21 Sep 2026 14:56:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 63QFoS5CzD5X; Mon, 21 Sep 2026 14:56:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B3D4340738
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790002560;
	b=oWR+kmLUt551hGehjhVpdtcA83QHmeWZfEaQChq1/1TubIqHMrn5uvILktceKaM5LPCs
	 SXpWo7M4ZbGNvYohtI/LR4xctSD/6jieDCzEtEa8pYLJh/NDcCWZuPqa5xN4kQYg6cXbM
	 vcggeiWN4/CjjPGs3Cbpb9FFeEzSgTCjU/bPtPOCdUtcpWZU/BuIv1JornqTSRM9EvwtI
	 gHh1jaxvL154eskLthsHBR/BmO0wSnvmQ6jpwnS0mpPh8NT4rTTu0/2xalEw+u+XEODu7
	 J04fe16+fchKJjsqv57Jr4Akp77d6e2vHOv//QWLRCFuZ1Jk3F//M6M07fycJSZUENg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790002560;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-ZohoMailClient:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=SH7xLS3O407MhBroxy2A7tbQSAEpOwkTiqTlopZlE0k=;
	b=lcr9NwZJwgaqW69tUiNaJQYCxYnDY9qggvwL77gN1MqQ/q4qvR++wRlvQg1T5vArMgHY
	 Xe1BWCbcIAv2HS2/c+SBDcrPpqhrc5p8thV4I+vyChnvNsAuIvPvGJdQ7OMxCf8h4tuV5
	 p5Y6fljHcdx4ePwBuLCT2+pMgXzc5l67zz8aVXxD/ExVCXL6oKNmc9ibR0NHwBbEKDGfQ
	 Vww+3NHH8ruvuGOTvifQ1y21vC5Ipu6+OLA3W62PI9nMh8RyyTOY9sc3RQE/9ubJouOEJ
	 do9ilpNCE71qnNtcAGR3arMQg6sUtqCYTdLd76CdpSwurjUYVbeb4bBJp7KCo14kXrg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790002560;
	bh=SH7xLS3O407MhBroxy2A7tbQSAEpOwkTiqTlopZlE0k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VkPQOm9201Ff92xk0aPIhHzjpr9B+xGPLNLxU/rFsmB3HytXv15m96hB+t0g+jL9j
	 5jwT22WbgeC5H+LCrh7GNm3v68Z7u4BF2g+65oJjsh3899TOy6Bnm1OFraJPLxDXeM
	 5bluR3KWpg+4p1mTkSriCQGV7bjmNg/JsD2Ol1TS/AxuvDUnGKD3ksQfilX6toCfLS
	 CoFsuPfK4j9ktgaP76DNc6Zc59/1puIMIPKVKsFguelMMEj2Sed0asL5h8AFOpSk14
	 L9KM+gcJJ3yshIjcBUIMSxreTH5LwrTwDv3yb9flmaiRFJD4ZoOuAbRaCdwAFebSXA
	 l5lpCEeJPgA1Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B3D4340738;
	Mon, 21 Sep 2026 14:56:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B36BF522
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 14:55:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B071280C1A
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 14:55:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PPh7BVRKOn-0 for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 14:55:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B29AD80A86
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790002558;
 b=YzcAD9oWdnUJLviL9IEaXHcpn61eGpvM5kpNA+g6RZHjrlLZ+P/Ov5Cg+KU/r6hFWC+I
 jSRObyNSwhnQCnr+dguk8dNcsyh1d7sn+lcVe0TwWkMIx+nYGaUpxc8IDe9Yidf0Jfm1i
 1I5vqE0FaCwDky+Jsh7/GBkI77FndoHOBHa6Z4ZklxIYwBQByLkq1NoJg8iyxfzLwgTj1
 0Sdmj9Ly6tM72phB2JVMOTGe+HSc9IGqEnWt1xhuRAPK1QZOgcy3TQPRepYyFRaKFIFqs
 srDz8XYG0j/E1dTNx+j1ZRZgXMkPCX/Pq515yB2EBNflTozxjCszxwDITkfyoin0FEA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790002558;
 h=Received-SPF:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-ZohoMailClient;
 bh=SH7xLS3O407MhBroxy2A7tbQSAEpOwkTiqTlopZlE0k=;
 b=oqlVMS4t8Br5Km//Fy/Bl7U11dvuOBoQGhXuRM1zI5kpzFewYp7GjbyMm1rUpD0xlaG8
 gPPvbZtShRfidahgZ5h7C44MXdb97vqDqIwEZTCF6rJ85S0lM3xxDTNJgC6VrqHtuJzSd
 HLcq6WC/DgMWvy9ca05A6AKatcX2POHVA6t+MQOO78B15EWk+dn4J8s1Pl/dfjs7XAVEz
 PPkDEvknYvc5cF+LaKDw5ElpcGcXuwYWGqFASzbMeUbxIlhprGSdWhWtdAa2+0MbSZDco
 c/fk8dsEQRa85etwE8HwpHlt02HcwEGdW7r3E/v6NcKQUDAGzQ41CwVucmXE74+UUMA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=none header.from=pigmoral.tech; 
 dkim=pass header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech
 header.a=rsa-sha256 header.s=zmail header.b=KrMgEnHd; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=junhui.liu@pigmoral.tech;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech
 header.a=rsa-sha256 header.s=zmail header.b=KrMgEnHd
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B29AD80A86
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 14:55:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790002528; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=RW8n8pPM6WZzxu5V4+TwG0BInPMTDrB6+gbu0KpsiQp/dXOqetiyhGAfcBWxETrmQCuwSwS+P+KOFgnOifmuyFSd586fkkTmFmUcraYq+VsSVccHo5U9pUwNzKqNdUEoBoYIhaFaIx5KPE33oA6wzqGJhY+I8500sIJ7wMGu6ys=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790002528;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=SH7xLS3O407MhBroxy2A7tbQSAEpOwkTiqTlopZlE0k=; 
 b=EcpdtQp+2DGqQPmmp7AfAx4N0Sih9+wT01sfGJDImueyyWIbdf+cAA2cfjsgnwDXYGJlJ3ZMb3BooxglCfpVZqGcNZC3/V5nB/1FBKDwG2NzCOMT/lWDrDj0v99LdyVahHsjGb5NPmm78Tf1dEGFqmGwJINpGQ9ubUtXsdh28ew=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=pigmoral.tech;
 spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
 dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790002528; 
 s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=SH7xLS3O407MhBroxy2A7tbQSAEpOwkTiqTlopZlE0k=;
 b=KrMgEnHdbzR/GsrCtjCHlDEhrVHSnuOZbqe7k6XQWk7AU4uhRmG70u79T+T54uNE
 8ZtKX+jra/t4zM7YlLkBfagDRlsd53k7e5b7Wup/afED6+LABIxyS5JosxTHFV/DruP
 lGIqkAtXs34sVpMw8UhJvD0alPCsb+7NyU0dj0YY=
Received: by smtp.zohomail.com with SMTPS id 1790002527490298.21682590776913; 
 Mon, 21 Sep 2026 07:55:27 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Mon, 21 Sep 2026 22:54:39 +0800
Subject: [PATCH v3 2/2] doc: board: spacemit: document the SpacemiT boot
 image format
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-spacemit-aihd-v3-2-f660fc85d2a5@pigmoral.tech>
References: <20260921-spacemit-aihd-v3-0-f660fc85d2a5@pigmoral.tech>
In-Reply-To: <20260921-spacemit-aihd-v3-0-f660fc85d2a5@pigmoral.tech>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Simon Glass <sjg@chromium.org>, 
 Daniel Golle <daniel@makrotopia.org>, Randolph Sapp <rs@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, E Shattow <e@freeshell.de>, 
 Yixun Lan <dlan@kernel.org>, Yao Zi <me@ziyao.cc>, spacemit@lists.linux.dev
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5375;
 i=junhui.liu@pigmoral.tech; h=from:subject:message-id;
 bh=St5vEHdH5FMMNMUXZFJXszI6K8c7n91kRESeYWu2m6E=;
 b=owGbwMvMwCWWvDb1VEXc8j+Mp9WSGLI2urruiX+zfwqDmMnJpONZccdmODkE77CXf23xk9H9Q
 m2W8WXmjlIWBjEuBlkxRRYuf/F/1jo8344ItN6HmcPKBDKEgYtTACbytJnhrxwXO1sNp45x2qGb
 Sr+sHjDfTNuya6uz7ORdTde/GiyvKGdkaLE/afrW43J+8f/3Yh/MDcsr83RSOPSmcgYwCJSLvFH
 hAQA=
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=openpgp;
 fpr=15B30CC69C4BF0CC3C08F85A2A90CDC122DF37BF
X-ZohoMailClient: External
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

Document the boot image layout shared by the SpacemiT K1 and K3
BootROMs, including the metadata headers and authentication areas.

Describe the K3 non-secure CRC32 path supported by mkimage and provide
an example using the "smtimage" image type with "-n k3".

Tested-by: E Shattow <e@freeshell.de>
Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 doc/board/spacemit/index.rst    |   2 +-
 doc/board/spacemit/smtimage.rst | 143 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 144 insertions(+), 1 deletion(-)

diff --git a/doc/board/spacemit/index.rst b/doc/board/spacemit/index.rst
index a5e35ee12ab6..5797ada37d15 100644
--- a/doc/board/spacemit/index.rst
+++ b/doc/board/spacemit/index.rst
@@ -7,4 +7,4 @@ SpacemiT
 
    bananapi-f3
    k1-spl
-
+   smtimage
diff --git a/doc/board/spacemit/smtimage.rst b/doc/board/spacemit/smtimage.rst
new file mode 100644
index 000000000000..19a5c9972f75
--- /dev/null
+++ b/doc/board/spacemit/smtimage.rst
@@ -0,0 +1,143 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+SpacemiT boot image format
+==========================
+
+The SpacemiT K1 and K3 BootROMs load a SpacemiT boot image as the first-stage
+bootloader (FSBL), either from persistent storage or over USB in MaskROM mode.
+
+Image layout
+------------
+
+K1 and K3 share the same layout. A fixed 4 KiB prefix contains two 32-byte
+metadata headers, key slots, and signature slots. The aligned SPL payload and
+a trailing authentication area follow::
+
+    offset                                    size
+    0x000  +-------------------------------+
+           | root RSA-2048 modulus         |  0x100
+    0x100  +-------------------------------+
+           | header0                       |  0x020
+    0x120  +-------------------------------+
+           | key-selection metadata        |  0x1e0
+    0x300  +-------------------------------+
+           | OEM public-key slots          |  0x800
+    0xb00  +-------------------------------+
+           | signature0                    |  0x100
+    0xc00  +-------------------------------+
+           | reserved                      |  0x3e0
+    0xfe0  +-------------------------------+
+           | header1                       |  0x020
+    0x1000 +-------------------------------+
+           | SPL payload (32-byte aligned) |
+           +-------------------------------+
+           | signature1                    |  0x100
+           +-------------------------------+
+
+For payload size ``P`` and ``A = ALIGN(P, 32)``, the image size is
+``0x1000 + A + 0x100``.
+
+Metadata header
+---------------
+
+Both header0 and header1 use the following format:
+
+.. list-table::
+   :header-rows: 1
+
+   * - Offset
+     - Size
+     - Field
+     - Description
+   * - 0x00
+     - 4
+     - ``magic``
+     - ``AIHD``
+   * - 0x04
+     - 1
+     - ``version``
+     - Anti-rollback image version
+   * - 0x05
+     - 1
+     - ``secure``
+     - Zero selects anti-rollback bank 0
+
+       Non-zero selects anti-rollback bank 1
+   * - 0x06
+     - 2
+     - ``reserved``
+     - Reserved
+   * - 0x08
+     - 8
+     - ``image_size``
+     - header0: prefix information
+
+       header1: aligned payload size
+   * - 0x10
+     - 8
+     - ``load_addr``
+     - Unused by the common authentication code
+   * - 0x18
+     - 4
+     - ``header_crc``
+     - K3: CRC32 over header bytes ``[0x00, 0x18)``
+   * - 0x1c
+     - 4
+     - ``image_crc``
+     - K3: CRC32 over the payload in header1 only
+
+``header1.image_size`` records the aligned payload size and therefore
+determines the location of signature1.
+
+Authentication
+--------------
+
+K1 and K3 apply different authentication policies:
+
+.. list-table::
+   :header-rows: 1
+
+   * - Area
+     - K1
+     - K3 non-secure boot mode
+     - K3 secure boot mode
+   * - Root and OEM keys
+     - RSA-2048 moduli with an eFuse root-hash check when secure boot is
+       enabled
+     - Unused
+     - RSA-2048 moduli with an eFuse root-hash check
+   * - Header CRC
+     - Not checked separately
+     - header1 verified
+
+       header0 ignored
+     - Both verified and covered by RSA
+   * - Image CRC
+     - Not checked separately
+     - Payload CRC32 in header1
+     - Covered by RSA but not checked separately
+   * - signature0
+     - Verified with the root key over ``[0x100, 0xb00)``
+     - Unused
+     - Verified with the root key over ``[0x100, 0xb00)``
+   * - signature1
+     - Verified with the SPL key over header1 and the aligned payload
+     - Unused
+     - Verified with the SPL key over header1 and the aligned payload
+
+K1 verifies both signatures even without a programmed root-key hash. In this
+case, the root key comes from the image and is not authenticated by hardware,
+so the image, keys, and signatures can be replaced together.
+
+K3 uses CRC32 in non-secure boot mode and hardware-rooted RSA in secure boot
+mode.
+
+Creating an image
+-----------------
+
+U-Boot currently creates only K3 images for non-secure boot mode. Package an
+SPL payload with::
+
+    $ tools/mkimage -T smtimage -n k3 -d u-boot-spl.bin FSBL.bin
+
+K1 images and RSA-authenticated K3 images are not yet supported.

-- 
2.55.0

