Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B17AEC5DF97
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 13:42:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1E5EC6078B;
	Wed, 26 Aug 2026 13:42:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tz8xQYohlb5N; Wed, 26 Aug 2026 13:42:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787751766;
	bh=JRrLNo9ivFMQ3sMzWZbmNrze4fRiJ1n6Q9zLq+snw0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ByINo/b5htJ51AcSbFdsjRHvkWJnMav+TD3Jt6SATyq71rUkJj/G5dfZqJjBQm6tr
	 Mw9wwJXqo53YWML9OWPWf/oL0ACDIPaX1E+Je8ZwqZVOU6UARORaUdvbeUN+DAzlH9
	 hhPl8njVSLdhk2urQHfefRP+GIoZ6qSFESbvU8qTm4CTsXuYCABpQd/pGCDfoPbZxK
	 EUqg4Tquul9HgOVFSJeHGX/MtR5j8sAkrhU9tTv/KC2spQYzyoGuj2w/1KU+KzfeYg
	 K0c4clDivX2P7MVFoquPkyOMkVFrk250+XspgEU39IOOHj2sSx9gwgCTRtP7PL8t0w
	 K+PNbA2MntLIQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7188C6077A;
	Wed, 26 Aug 2026 13:42:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 226BC3C3
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:35:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0917740108
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:35:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t77_FNeArayY for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 13:35:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=34.2.90.19;
 helo=sonic.asd.mail.yahoo.com; envelope-from=maskachoska@yahoo.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com
 header.a=rsa-sha256 header.s=s2048 header.b=UdvKONNz
Received: from sonic.asd.mail.yahoo.com (sonic-asso1-0020.asd.mail.yahoo.com
 [34.2.90.19]) by smtp2.osuosl.org (Postfix) with ESMTPS id A07AB4005F
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1787751315; bh=JRrLNo9ivFMQ3sMzWZbmNrze4fRiJ1n6Q9zLq+snw0s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=UdvKONNzAB4azNjuZ6hrp0a+Il5WsKRCy0U0LggBPrLXyEI10GXSMwOtKg63AvWxbHdI+YabCLlCG69JUip4MLDmacRW10CsY8beQ83cOuMVUY7RXONr+1f8cGy7m2xIXwJnGQWu3Zw6FvXkT873O8kaXHhGBNMQTQbspG/wf+W9r5nGnhmzu+vBXrBg0+uD0K3xP2Bv49OIytWpK1fpl5VynM5IWYzL7oc6flZTp4HEl+INDeuDQEShtT2/dEyQ/PItLvHAhm+fnsuMgiKvrcPr8KgWaRBlaVwtSMEzpXsyzQPMXQIyIgNtL7U0fSGPFLN5/tX56iyGOr0Fbnsrbw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1787751315; bh=uF9X0Tcd3eEQ71Cn9NZj3sF5ArzLUOr1cYPcEsg3hU8=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=nEGLPNK54yIBDTKzgj5EIm7xejqJybi8U+ALoqXKuNoMOn9Qk/z0SqB3wkgtKBmlwPpQA5bKmeRo/BegCBfAUztPOv6Oa3lQWivCgMphgqaVOK8ZWl3iCmg/t0b86Vl8CC/yKEJaacWDPXR5ymu84HsAxZubfmtSzei4Kh1bMv1XNixtdQw6yhvuavvgNDoU46FrMKRWZ6mLwdGEFb+7AGK9fYbYJapKRRNgSFg721XsZYMNvS05G5VARxNY0S1VJAhPt730Vwt0H2boqDbmwkSrcSae4OTT2KHQRhaQ2PLDbOIMRf6//XcNNi1nwLJfnxzFfIx5Ix6S9h0IN9nC8A==
X-YMail-OSG: oUJ4LkwVM1kLVBY8Ft41aE3sja792RAo.Dup.rYj0Vou1TIHA1Lct9M9xhVWLB7
 3gIPH9zy3ne1Ee7RI1rrmZBDgYD7z2ho2rv6Es8PnHvYQhHMJmeRsWFi0ZqlosqP._1d0dOYO4TX
 XLNEMvxKGbBXTUIX6TDyaP0IY2UXMszODKF1IVWWMAN8vTshcJbzz9wTK86rteIxER4K_vjCV4f.
 bS.6xFTt_SgoOygl1JBHULHAgUXLrX9N1BQGVVZucXCCVr6R6lBBsItHa0_HUpTeqdjWfmUe6Yyg
 LdrhRBRbUHKWnk83eKPikyhmcFKttGq5rgkGfgskwPUEjwyQWlpPLdWa80j8zWF0atD9Et3Di6xc
 MQS7cWEhqM8BR6h.Rk.shTGzKYP2CvX3hUoSVdDOX0KdfRqTuIjMh6EwNrkIx4cOeDKD7RiET3.t
 mR1G0xCMuQrCy3p_ALZRtC4W9KDFqC.pzJgTHGgFRP3XiqA6YYB_R8b.VGKl0JJ9QxVWRiIHYMuL
 Z65tCVF_7HEqX_GyFakIuBRhpt95ZKa0cZUQERgsiyDIRuF45bq83fjZcci2pOWOt0lcvuLuIBFd
 01B0NdIROl0n.0XaNlVMpyUMapVAg796KNYkWS9n1oLabol.jYY1W1jYvrzy1HmgbxO.O.G87z4z
 Z8xx4QqQmMLqIDk2aKDIU.3Uqprr2eOhZU6nLzzQauiv5Y7JYtJLaKZShHk19yfgvHLYvEqBvXrN
 DkDt3mv2wXtd.Rn08Gw7x7AkiJXTUtIC14uvbLSwDxA_b.JXuknZuTLu3UH9K3AB2rHQdY5Qf9dQ
 bBtUpUdnHYIGKp9dee.xa_7qzcbKpMRTSrR6QO9NNzAoRVYM1blITIg6k5Xu8JRIXYqmgtauAPxI
 9tP9of3emW0Bda8Z1IPjekYKkA4UfC7_Q1jyH8MkkvLBJEq0oTi8NzomOTLjHfQH.eH.7baq3_JL
 rhOKItiIr8rwwc3Y0MDexCU4W9lG3I_RtQUhO0mAlNXa1iFViStIUnZ3dH1FWJuPJZ8ozYT8.r5o
 Lxjhc.BHELoPfxlydZ9Baz2hg6SfoTjuAly8t3zcf3ig1WJt4K3Db7vNlJW8GDn_WIEdzm0i9X1R
 eo6xTDCSgmMiBBTA0gQEFm.LdCELZYXdLZDvzAc4YnmiMr7Ql5zA_xL15XmF2IW9hE9Vhj6lWb0E
 TEp2wM5AFxq8apUSVcbiO8p.Q1FRqhUYLqBNZu6PbsCkAx1yzBkEjCset8cDDOhzkr49KOvwO2WB
 DA.giku9wsxwvPbSbBByhiFy8b8.iVq96ur8X8Bj2VEIKmra9Uy358lhvusmfCf99uVOIZco8FSS
 sQgPK0gEpSttXg7sL8pshP1A0FLuAkUDpVY5u4d2b.zj6N.7f2NUijfWxpxw_Pz2s08lHlvbSaiW
 l.ePvLxsboaSpE1yr6eKx4qn3y0nNCHkOZ1NjUZUQ9hatBD9XqLgkq4fOY1q1sQZmwAThoaAou6R
 t_JiW7rbJ5Jl7dSWePo6zdrEJzRMm5GmLYcAnY0H3RwnlAfgrOnfhQkqHhHy56.ElZ3vRBAZtC9m
 mfgdQbRmEt2fFhWihaRJALKsaECn3C.KgW9VXB2HBNUG0RkhJCK4W3asugOLK0lPHN2EPs8FFAMw
 L6TYPyWSJuahrbwbSLWOXXyuuanfsEGUZaV.JCL0VpcGDTk4NLHu6ItHqyNc2eb5hY1y8adW2Qp1
 wEGqaPHDgcZJsNynLgZFnzUp7JZIgirYxAnpPmGPibTWeWpAQqkdfWtP80hOs2jtVeRSutHpE4gm
 R3sRpb71NrkHUlmhg3VZiVmoAN9V0Zr33u2nNvSSq._48ReXQoXGHTM.6oyl63Dv_JKzlVt38quI
 rzez1CdwH9SozDSnEqQP4FfGeVcrdYQoZPfVygVWeiVItGOr8KORwgdKEVBt88e8Sv0xVcIXVio4
 Igrik05HR4F0n9Jb5RsNFpfqT6eMyXuLwXbDXJ.7Db44NPsQ0iwnBkc450pCKp74qwrZTWZtzmsl
 9ymUq9rKG7ak7uQh_VHAgo07kVr08c_t9ivekMCnjXiofHcEurF4F3dGbewKOJWTJJq.8BpH9L11
 0xmB_5TbXXSq7fZPVgk8q
X-Sonic-MF: <maskachoska@yahoo.com>
X-Sonic-ID: 2ddfab6a-e69e-49f0-9d0f-26c7246d0809
Received: from sonic.gate.mail.ne1.yahoo.com by
 mail-asdoutdeli-p-cin-asso1-prod-sonicconsumer-svc-102 with HTTP;
 Wed, 26 Aug 2026 13:35:15 +0000
Received: from dip100.lsn.sg3.yahoo.com ([106.10.223.109])
 by hello (SMTP) with SMTP ID acc4f7a299298e219e9ccf723c2619d7;
 Wed, 26 Aug 2026 13:35:10 +0000 (UTC)
From: AK Sharma <maskachoska@yahoo.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@arm.com>, Marek Vasut <marex@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 AK Sharma <maskachoska@yahoo.com>
Subject: [PATCH v2 9/9] doc: board: econet: add EN75xx documentation
Date: Wed, 26 Aug 2026 19:04:43 +0530
Message-ID: <12f5eb5ed45d3898e56e4c6eeda4bffd10ac56b3.1787736704.git.maskachoska@yahoo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1787736704.git.maskachoska@yahoo.com>
References: <20260825222211.712836-1-maskachoska@yahoo.com>
 <cover.1787736704.git.maskachoska@yahoo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 26 Aug 2026 13:42:25 +0000
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

Add the EcoNet documentation index and the EN7528 board documentation.

Signed-off-by: AK Sharma <maskachoska@yahoo.com>
---
 doc/board/econet/en7528.rst | 66 +++++++++++++++++++++++++++++++++++++
 doc/board/econet/index.rst  | 10 ++++++
 doc/board/index.rst         |  1 +
 3 files changed, 77 insertions(+)
 create mode 100644 doc/board/econet/en7528.rst
 create mode 100644 doc/board/econet/index.rst

diff --git a/doc/board/econet/en7528.rst b/doc/board/econet/en7528.rst
new file mode 100644
index 00000000..32f51bfc
--- /dev/null
+++ b/doc/board/econet/en7528.rst
@@ -0,0 +1,66 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+EN7528 reference board
+======================
+
+This target provides the U-Boot port for the MIPS-based EcoNet/Airoha
+EN7528 SoC (MIPS 1004Kc, little-endian), used in many GPON/XPON ONT home
+gateways. It replaces the proprietary multi-stage TCBoot flow with the
+U-Boot TPL, SPL and U-Boot proper stages.
+
+Boot flow
+---------
+
+The boot ROM starts the TPL from the uncached flash window at
+``0xbfc00000``. The TPL enables the Front-End SRAM, initializes the serial
+port and reads the DDR calibration image and SPL through the early SFC
+reader. After DDR initialization, SPL loads ``u-boot.img`` into DRAM.
+
+Build
+-----
+
+The RAM / chainloaded build has no external dependency:
+
+.. code-block:: bash
+
+    make en7528_ram_defconfig
+    make CROSS_COMPILE=mipsel-linux-
+
+The reference board additionally packages the vendor DDR calibration blob
+(see below). Build it with ``BINMAN_ALLOW_MISSING=1`` when the blob is not
+present:
+
+.. code-block:: bash
+
+    make en7528_reference_defconfig
+    make CROSS_COMPILE=mipsel-linux- BINMAN_ALLOW_MISSING=1
+
+Defconfigs
+----------
+
+- ``en7528_reference_defconfig`` - reference board (DASAN H660GM-A)
+- ``en7528_ram_defconfig`` - RAM / chainloaded build
+
+DDR calibration blob
+--------------------
+
+The EN75xx TPL runs a small vendor DDR calibration stage that is not part
+of the U-Boot source tree. The TPL reads it from SPI-NAND at the DDR blob
+offset (``0x8000``) with the early SFC reader (see ``tpl/tpl.c``) and
+executes it from FE-SRAM before DRAM is available.
+
+Obtain the blob by extracting the FE-SRAM DDR calibration stage
+(``spram.bin``) from the device's vendor bootloader and flashing it at the
+DDR blob offset. The reference-board binman image expects it as
+``arch/mips/mach-en75xx/en7528_ddr.bin`` (``en7512_ddr.bin`` for the
+EN7512 reference board).
+
+Expected images:
+
+- EN7512 / EN7521: 20336 bytes,
+  sha256 792068a4573b20cb8c39cb27df06c45683c11034e6fd07da24ddf7084828faa5
+- EN7528: 23152 bytes,
+  sha256 c2ff94b25100d46c0f2d8b42ebeb887bd6bfd0d49cd1ba5df61eea84ac227540
+
+Providing a source implementation of the DDR2/DDR3 calibration to remove
+this runtime dependency is a known TODO.
diff --git a/doc/board/econet/index.rst b/doc/board/econet/index.rst
new file mode 100644
index 00000000..d691db07
--- /dev/null
+++ b/doc/board/econet/index.rst
@@ -0,0 +1,10 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+EcoNet/Airoha
+=============
+
+.. toctree::
+   :maxdepth: 2
+
+   en7512
+   en7528
diff --git a/doc/board/index.rst b/doc/board/index.rst
index fcb4224b..60d75003 100644
--- a/doc/board/index.rst
+++ b/doc/board/index.rst
@@ -29,6 +29,7 @@ Board-specific doc
    coreboot/index
    emcraft/index
    emulation/index
+   econet/index
    gateworks/index
    google/index
    highbank/index
-- 
2.53.0

