Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5591EC7EE30
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 20:17:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB65382E08;
	Thu, 26 Jun 2025 22:17:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=dujemihanovic.xyz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b="Xw/9mAbj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 348C582977; Thu, 26 Jun 2025 22:11:46 +0200 (CEST)
Received: from mx.olsak.net (unknown [37.205.8.231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6D6A80C83
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 22:11:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=dujemihanovic.xyz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=duje@dujemihanovic.xyz
DKIM-Signature: a=rsa-sha256; bh=fT8sGVswUFc1EX4mM3xDwBV4/k3wMHWK4mGzL50rQmw=; 
 c=relaxed/relaxed; d=dujemihanovic.xyz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:Message-Id:Message-Id:References:Autocrypt:Openpgp;
 i=@dujemihanovic.xyz; s=default; t=1750968700; v=1; x=1751400700;
 b=Xw/9mAbjxNLsvN4pJPcePZQfW1ZvOC/U07S4kFzeOl4M1jFchSdxo/0A7Sd5w2k3fj61Vrqj
 98Dm2Ut8YmhWlz6gWrVk+h6iz5CVUhL7e2ux99RqWqS/llC5YoO/RhmNjOwefkJXlYEbqIfTZGC
 JOlDbaQPX7OVLmjDweq/LTcD5N5zWTOU4jSj8RYJUTuROXMjhtr+OzocjDMVysm6yDguwxqsVSt
 VxOl32MWsYmmPHFHbFHdaRxbQin2ysdy+27NyrkSnI0D5p+PINC7V6rfMLAqjmV1rsS+b03dHvH
 y7/eRJJB/S+xi6Co+KAblx3cD5vSgvOWt4v+crbjRD8wA==
Received: by mx.olsak.net (envelope-sender <duje@dujemihanovic.xyz>) with
 ESMTPS id b5fb34da; Thu, 26 Jun 2025 22:11:40 +0200
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Date: Thu, 26 Jun 2025 22:11:31 +0200
Subject: =?utf-8?q?=5BPATCH_v2=5D_mailmap=3A_Update_email_for_Duje_Mihano?=
 =?utf-8?q?vi=C4=87?=
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250626-mailmap-v2-1-f300b8b12ae6@dujemihanovic.xyz>
X-B4-Tracking: v=1; b=H4sIAHOpXWgC/2WNQQ6CMBBFr0JmbU07QklceQ/DotKpjLFAWm1A0
 rtb2bp8Lz/vbxApMEU4VxsEShx5GgvgoYJ+MOOdBNvCgBIbqVELb/jpzSxIKXQna2qHFsp6DuR
 42UvXrvDA8TWFdQ8n9bP/jaSEEq1uWi2twfpmLvb9IM/leErcH5f1A13O+QvPFJGHpgAAAA==
X-Change-ID: 20250626-mailmap-e112f3da4f2d
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2391;
 i=duje@dujemihanovic.xyz; s=20240706; h=from:subject:message-id;
 bh=H0rjsMrphNtgqtIRSXIQFYA4Qtx6EnJl7eAwHjIL/zw=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDBmxK6tXsZpe81ParMJ+VCaBf8pZkX+qdhGn6uZPdepQr
 qxoCvjUUcrCIMbFICumyJL73/Ea72eRrduzlxnAzGFlAhnCwMUpABPxNGVkOCbi6HQ//dc0Dh3T
 RTkxr5SmSgjYMU7IFg9JqkhhCMrdwvCHR0lcT3K63H91OVODCwkHVN3Xn3D/+ueFYuvy0vItaRf
 ZAA==
X-Developer-Key: i=duje@dujemihanovic.xyz; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03
X-Mailman-Approved-At: Thu, 26 Jun 2025 22:17:13 +0200
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

I'm moving to a new address, so map my old one to it.

Also update the MAINTAINERS entries.

Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
---
Changes in v2:
- Update MAINTAINERS as well
- Link to v1: https://lore.kernel.org/r/20250626-mailmap-v1-1-765760da24ba@dujemihanovic.xyz
---
 .mailmap                                 | 1 +
 MAINTAINERS                              | 2 +-
 board/samsung/coreprimevelte/MAINTAINERS | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/.mailmap b/.mailmap
index 830a263b983653beb89d8632c075f2a22bbd1f6d..629d0ca95a8149dc15073e50cf65bac3d3d1c897 100644
--- a/.mailmap
+++ b/.mailmap
@@ -39,6 +39,7 @@ Casey Connolly <casey.connolly@linaro.org> <caleb.connolly@linaro.org>
 Christian Kohn <chris.kohn@amd.com> <christian.kohn@xilinx.com>
 Christopher Obbard <christopher.obbard@linaro.org> <chris.obbard@collabora.com>
 Dirk Behme <dirk.behme@googlemail.com>
+<duje@dujemihanovic.xyz> <duje.mihanovic@skole.hr>
 Durga Challa <durga.challa@amd.com> <vnsl.durga.challa@xilinx.com>
 Eugen Hristev <eugen.hristev@linaro.org> <eugen.hristev@microchip.com>
 Eugen Hristev <eugen.hristev@linaro.org> <eugen.hristev@collabora.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index d62dd35a385bf50cb48831049a3ee1189d75f579..893977ad1df927f5676598ed24f011f13867c6ff 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -391,7 +391,7 @@ F:	drivers/pci/pci-aardvark.c
 F:	drivers/pci/pci_mvebu.c
 
 ARM MARVELL PXA1908
-M:	Duje Mihanović <duje.mihanovic@skole.hr>
+M:	Duje Mihanović <duje@dujemihanovic.xyz>
 S:	Maintained
 T:	git git://git.dujemihanovic.xyz/u-boot.git
 F:	arch/arm/dts/pxa1908*
diff --git a/board/samsung/coreprimevelte/MAINTAINERS b/board/samsung/coreprimevelte/MAINTAINERS
index 0902117e8b3dc9da782e61728ad9b10ee077229c..9dccd041ffb04a4ef2c5e8011e7500aef1a3e2a0 100644
--- a/board/samsung/coreprimevelte/MAINTAINERS
+++ b/board/samsung/coreprimevelte/MAINTAINERS
@@ -1,5 +1,5 @@
 Samsung Galaxy Core Prime VE LTE support
-M:	Duje Mihanović <duje.mihanovic@skole.hr>
+M:	Duje Mihanović <duje@dujemihanovic.xyz>
 S:	Maintained
 T:	git git://git.dujemihanovic.xyz/u-boot.git
 F:	board/samsung/coreprimevelte/

---
base-commit: fb4a488eb91b089912ffbc9a74d0527f0f2c79ac
change-id: 20250626-mailmap-e112f3da4f2d

Best regards,
-- 
Duje Mihanović <duje@dujemihanovic.xyz>

