Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CACD6C5DF97
	for <u-boot@archiver.kernel.org>; Sat, 22 Aug 2026 08:58:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4FB0A4099D;
	Sat, 22 Aug 2026 08:58:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AQYZ1NchC8sR; Sat, 22 Aug 2026 08:58:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787389128;
	bh=iGm5cbthMDAruPSQfe9X1qbKRCgrGUM7Xwf1XWX2lhI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qYETOMePcNqRRFO1fYBbRTFy7bpEM0aBEwSE6J3ArREeTVcVSts6IquHNI5KcKlm4
	 quvctRgR4PUq63YgLfWlvpq8q2wwq7nHzGLm1qERgZvHHpyApFryymvlgXn57Vd/JL
	 wD5YNv+K/gDFgfCeC1ed0PRyTl0uqRukfBbSIc2qSE8Nr05CZSLq9CCE2D90389RR0
	 IeDR4GG3kxGQf0WRpnqEzVBO+I2hVZKp9237hVoLCwjRt4zsLVbtii/Sb3lL893yWu
	 dGGxRYXY8wqY7oj5iz2YjELFd7/ZdRmnOyF9n2vLNg0BMGszi3qBn9XXW1B25dDWoM
	 LqQx+NcZ6wNpw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 629AF4098E;
	Sat, 22 Aug 2026 08:58:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0554439E
 for <u-boot@lists.u-boot-project.org>; Sat, 22 Aug 2026 08:58:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DD7624011D
 for <u-boot@lists.u-boot-project.org>; Sat, 22 Aug 2026 08:58:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yp5PL0Drgx0W for <u-boot@lists.u-boot-project.org>;
 Sat, 22 Aug 2026 08:58:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.15;
 helo=sender4-op-o15.zoho.com; envelope-from=junhui.liu@pigmoral.tech;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech
 header.a=rsa-sha256 header.s=zmail header.b=lLF1XasM
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1D6844005F
 for <u-boot@lists.u-boot-project.org>; Sat, 22 Aug 2026 08:58:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1787389099; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Da/c68yqYAN3zK+CkS/WQoc0/1d0IDzNVxiB/6rYpj3cAB0NVo/esaTuJ/VUOi/twaK/SJcTQGr8edQ4IAqju9gJ5kSD3dbnoDDruXxLIOnICsnyv95pZaWYkuuTnLZ5HC+eom+TSK1eHFX3XmubRou7go3OauRCfLUlFjK/1b0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1787389099;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=iGm5cbthMDAruPSQfe9X1qbKRCgrGUM7Xwf1XWX2lhI=; 
 b=SPpVRDt6z/1SZ15ms56WXM6KZMPNBAeY6vp6b43NYwl+X19pbvePV38beJgbZwb/06TSWxP54NeoaFMF3vL+Ax3n1VSnWEyxTXUW0EaOc9dk3fIjJU34tKcEwFzNY3sMAUayXvQEBgdl2SwvrGORA6ZZcPZsBUfzJ2huYBYmqw8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=pigmoral.tech;
 spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
 dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787389099; 
 s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=iGm5cbthMDAruPSQfe9X1qbKRCgrGUM7Xwf1XWX2lhI=;
 b=lLF1XasMSlMgvxQsDV2Ok5wd+RnWqma37pUZhIjlzYf9UMlQgVPUHnWgUXeax75/
 QBxuYBzn+F0iQ9OAcNJ+o92VFxk5HKexgjnWdw/CUR8vupGeporwnU1R9Et4tLciYeT
 kSckEVyTmOwo96HqDB+fXBda9QUnIcZqFWl4gxLY=
Received: by mx.zohomail.com with SMTPS id 1787389097887108.69226741373689;
 Sat, 22 Aug 2026 01:58:17 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Sat, 22 Aug 2026 16:56:48 +0800
Subject: [PATCH 2/2] doc: board: spacemit: document the AIHD image format
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260822-spacemit-aihd-v1-2-bf4c41993891@pigmoral.tech>
References: <20260822-spacemit-aihd-v1-0-bf4c41993891@pigmoral.tech>
In-Reply-To: <20260822-spacemit-aihd-v1-0-bf4c41993891@pigmoral.tech>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Junhui Liu <junhui.liu@pigmoral.tech>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Daniel Golle <daniel@makrotopia.org>, Randolph Sapp <rs@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Guodong Xu <guodong.xu@oss.qualcomm.com>, Yixun Lan <dlan@kernel.org>, 
 spacemit@lists.linux.dev
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5349;
 i=junhui.liu@pigmoral.tech; h=from:subject:message-id;
 bh=TppxxHs8uaplvhWDG+SqdhZj9ud3kHMI/j3HknXjcH4=;
 b=owGbwMvMwCWWvDb1VEXc8j+Mp9WSGLI6U3ofemQ9Y/Te/cxVesX0HAuX33lek9p2es+4obvlU
 9gE240zOkpZGMS4GGTFFFm4/MX/WevwfDsi0HofZg4rE8gQBi5OAZjIr7uMDIuL/3jvCVt6xC6E
 8ypr4sOD2y4lf9hZofqhaqFPh7NCQzTDX4GrG0Obtxaoiha++BJzM5h94f3Ci0v0LU76dTDm5Xr
 +YAcA
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

AIHD is the first-stage boot image format used by the SpacemiT K1 and K3
BootROMs. Document its layout and the K3 non-secure CRC32 path currently
supported by mkimage.

Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 doc/board/spacemit/aihd.rst  | 145 +++++++++++++++++++++++++++++++++++++++++++
 doc/board/spacemit/index.rst |   2 +-
 2 files changed, 146 insertions(+), 1 deletion(-)

diff --git a/doc/board/spacemit/aihd.rst b/doc/board/spacemit/aihd.rst
new file mode 100644
index 000000000000..9a14fefc4d75
--- /dev/null
+++ b/doc/board/spacemit/aihd.rst
@@ -0,0 +1,145 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+SpacemiT AIHD image format
+==========================
+
+The SpacemiT K1 and K3 BootROMs load an AIHD image as the first-stage
+bootloader (FSBL), either from persistent storage or over USB in MaskROM mode.
+Vendor firmware calls this image ``FSBL.bin``. The format is named after its
+AIHD header magic.
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
+    $ tools/mkimage -T aihdimage -n k3 -d u-boot-spl.bin FSBL.bin
+
+K1 images and RSA-authenticated K3 images are not yet supported.
diff --git a/doc/board/spacemit/index.rst b/doc/board/spacemit/index.rst
index a5e35ee12ab6..45ef54f1543b 100644
--- a/doc/board/spacemit/index.rst
+++ b/doc/board/spacemit/index.rst
@@ -5,6 +5,6 @@ SpacemiT
 .. toctree::
    :maxdepth: 1
 
+   aihd
    bananapi-f3
    k1-spl
-

-- 
2.55.0

