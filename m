Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79A02C79FB6
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 15:52:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 01C5A607C4;
	Wed,  9 Sep 2026 15:52:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lRgqJeQj3NZq; Wed,  9 Sep 2026 15:52:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B273460608
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788969170;
	b=tWHbgA1z+X43ehz7BeZKE4u9wJiowBcS/P1Q2KuC7ScGhC+8zfCFlL/zCHUdlitjwFmW
	 nAUX+klpNAQ3z+j+KhLIJW7pPBk3lp/0C/m4HQiruOyMm2I/CtLebkh4aPQDrnRBqWVOG
	 FVwgTpK2xU6GJZpA7qzffR2PZAGvkm5Hzll6wZ/aguiUWKxaR2ozUJxDgj8kK+1J8cdLy
	 Mgoc6yleR0ZK48DnYNyi4JcWQsSxbMsSGJbQwdbZpKUQcA1a6qMblwLJ7Icl/wtxl4bow
	 VK9fgRB5XTkjAPPHA9OA0m0ovfIJ2JEVFglucfSdc6ZNDM7c/8gkV+tw31X49jgOwCg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788969170;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-ZohoMailClient:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=w6zzq4tGGhquLe6UQ/IqzEJFehOL6lsEtW+jwzPJSfk=;
	b=AnntC/Rw8oFPYBE2HWkkHSiXBaenjpYjPf26Il5W8adaIhZIQNYIVCfzRvMETe464gnn
	 ER8PXV9L2hjbmXidjAuGZSW/hqfAVLvGEY6cyPi8+BdGC7H6W0EswqEbG/c3nS4+O/Nml
	 rCTCIHnFSAfmpqJ+I33AHLhqj0YmYFoCbemWttH72Fye3itrXuV57DlGvX7UnqLyjdVho
	 tFe+QK8MXWgUsFGv8g13nLciPYQRnAmaXamlT62R64jHUaMqLJofBnBmvagto44jd3uqG
	 8E37NhVMZtJm3U9EalP2oFMuoc0fRj6K2Dt+1rLyp6dlVMaNeJlf+/2Nl+wqqaIZhkA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788969170;
	bh=w6zzq4tGGhquLe6UQ/IqzEJFehOL6lsEtW+jwzPJSfk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jzUoha6ovhv76XPjjcajOyr17L7I/jqyej8Dcnzyvcgkz0AjFHPRY7xXUMBC2hSnC
	 jsjeDs2uZnn20QZPlUTMqww83CSaIWSxp/yPCZc7xPcPXXS5uGfoYWL5OyqEUyn2UV
	 xgNGczvbxRpvRM8ZH5W5qDBXOZBoLzpeCNlS+3N8OYrcaIVFC9KfekuvB5avRW49xH
	 VsO2ecSNnf/A3ssEfVnZPiI3myHPSz2B4hK29hUXaoV3EyPZdZImsaCFVsWhCvMoug
	 Q5GapAs0ZhIAr8AeRjEhbFEhVpRnKZNh26nkvKu7pLZoGBQkhcgt24wLH60P1WF2Ud
	 tfCuQGoKsWWLA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B273460608;
	Wed,  9 Sep 2026 15:52:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A43582D2
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 15:52:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9258A806F2
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 15:52:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iu7lZEUz6eYL for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 15:52:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org EC9C18029C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=136.143.188.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788969168;
 b=O2gyzbjtTI2jgq0dYEmwbQj+2vxT7tmqmatZYwYRbwDXPLtYmdemsoJ404tFopuxDTL8
 cB9RglCCnBkZXRy6PA++mJorE58tpnMMRQan17alNwsEuFgindTpWEUzjtF89ltPxPD3T
 H35Tms1cy53udBrd5PaETsHKhDQDe9lec+/aguFLd5Bj3SP16RqFcEVMVwMGrvQw7+RWR
 um7oCdUPZa5QPy/vXlGNMCt3LBpa7KCpClqAg9QJbSb6/66PJQT3nOpGeAcw0L/tFwUjR
 FsVtJLXhBelxWQ+bDOQhmenZP/wNw1pnRhCFz6YaaT+yG8oRYWeVuwO2Jj9Os7L+4Rg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788969168;
 h=Received-SPF:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-ZohoMailClient;
 bh=w6zzq4tGGhquLe6UQ/IqzEJFehOL6lsEtW+jwzPJSfk=;
 b=SL2AUqpi2Oj1J3JIHyT64Hj5eV6/LuVt/iP9d1okyxMO4vF09J4byzPSFnQubuJYf4UY
 YPuolMSlhK9/ZBxTCEbvCQeRhOPDGmkwAeQZsAV9vFnvZ3r53ZDule3yhAWyXIp2IDzEh
 4n6rKIKUj8g3f0OSgPY3hxD1o+4Eb24bpryYOixPHgNtfa7MQHcaD/7kcdFX/uuCJIEfa
 Ho3hji+RlgEbTIyaSoj0qS601DzusZNZF/Xr/btLZoOt1lUPb7KBdPvNDE+BczaXI69va
 vaxgaP9ZBa6DCyb1kcbgUPCizTMjR9GAiNsMqprb7wBgsFQdCcyjyx82izYfU/L963w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=none header.from=pigmoral.tech; 
 dkim=pass header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech
 header.a=rsa-sha256 header.s=zmail header.b=o8qnqSzJ; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.15;
 helo=sender4-op-o15.zoho.com; envelope-from=junhui.liu@pigmoral.tech;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=pigmoral.tech
 header.i=junhui.liu@pigmoral.tech header.a=rsa-sha256 header.s=zmail
 header.b=o8qnqSzJ
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EC9C18029C
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 15:52:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1788969142; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=MZzo1loyiqQByPKxiiwJiOjGwzOjt7Lx1+Bbt0hJ1yqy64f/ONWuPmlvXUvxZFyg6RRlQ7vuREDN/YdgvPCKDZ7gjZ3C0cOywyfj1nadpqxZKNX4fxy0o5REXRLYmx2l8O4b6Ce7mjGtclvUM519ByFLEBmkR4C5nQInlAwnfGA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1788969142;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=w6zzq4tGGhquLe6UQ/IqzEJFehOL6lsEtW+jwzPJSfk=; 
 b=a3t0/izeoF6LY7Sqh8GJBuffJi+/nJwWTCIdG2XyX4E4/CbYXrWhtUsC8PDcRQVzD6VCnYVKD886hvpPEevYeFtPVl2ZHKwTRm2eUPLTQuQAk7+RA7GSB6DTYVesCu8II8Q6uE3H0hV6wKciIsRTpCnsRXM1ciEovQ7vBwrFvQI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=pigmoral.tech;
 spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
 dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788969142; 
 s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=w6zzq4tGGhquLe6UQ/IqzEJFehOL6lsEtW+jwzPJSfk=;
 b=o8qnqSzJD6z07NF+CNXe6KOAaqy4pBdYp9SnE+Al6Xi22LpBXtnnYmQZ5vwOLYaH
 ZOqIzEfaOBGch2K0oIupdky9qTZfdCsoRcx353cK9TqbYV00MpP0ZrPjQIyka4gHgJH
 JcsKqNmuK+s23rkGySGzLDUpLLxHvim4druVNxYQ=
Received: by mx.zohomail.com with SMTPS id 178896914030794.50219767383362;
 Wed, 9 Sep 2026 08:52:20 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Wed, 09 Sep 2026 23:51:09 +0800
Subject: [PATCH v2 2/2] doc: board: spacemit: document the SpacemiT boot
 image format
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-spacemit-aihd-v2-2-780e98cf2fec@pigmoral.tech>
References: <20260909-spacemit-aihd-v2-0-780e98cf2fec@pigmoral.tech>
In-Reply-To: <20260909-spacemit-aihd-v2-0-780e98cf2fec@pigmoral.tech>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Simon Glass <sjg@chromium.org>, 
 Daniel Golle <daniel@makrotopia.org>, Randolph Sapp <rs@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, E Shattow <e@freeshell.de>, 
 Yixun Lan <dlan@kernel.org>, spacemit@lists.linux.dev
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5374;
 i=junhui.liu@pigmoral.tech; h=from:subject:message-id;
 bh=3uvel5a9qRu2FYnNf3EA6uNL6gvopvxjdQ2FmJxvde4=;
 b=owGbwMvMwCWWvDb1VEXc8j+Mp9WSGLIWNsx2VXx38KjylMa9/7h+RrmuWb1M/1tJuOqUsh9z4
 p99Y4qS6ChlYRDjYpAVU2Th8hf/Z63D8+2IQOt9mDmsTCBDGLg4BWAix70ZGbqOhnvVqG+9eO6V
 e/7rhQ3BP6Vmyt/NXpBq9XbSb509DksZ/ucxe1/lWZBiUC19njmqoXx377aP904e/6+9+v7N/jm
 5J5gA
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
index 000000000000..edcc3091e8e7
--- /dev/null
+++ b/doc/board/spacemit/smtimage.rst
@@ -0,0 +1,143 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+SpacemiT boot image format
+=========================
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

