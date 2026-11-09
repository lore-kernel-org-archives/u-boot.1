Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D50606A321
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 08:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=btZRzo3L;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.a=rsa-sha256 header.s=key1 header.b=RDKlRk3O
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D718560739;
	Mon,  9 Nov 2026 08:01:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GMFvlW3haTUq; Mon,  9 Nov 2026 08:01:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B1E426061D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794211283;
	b=ryAqRiduoUduGcWqhrGPJ+YdSgS52fmxVD1Es5cVumWAAHyN50WhJhCyRPfnUSN6Vq/X
	 N6yqG4MnZl/xL3J2U7rT1IiMKnBWyHcPRSEb9o3ZQ4orZa/YQxurP1nep9/Wfq+4w+5qe
	 WBTil29SS1lBW7d6B1Bd7aNu/RHKsICQeLEXstuMt6ophC1DwOh89pGi8vO/3ruKxMpyC
	 b+xE5sv8Xkq7kfHAfeuzHjCzMPOCPzI0SeEwfV6fcl0UBI8YpDBk71c54NTdvGkgF136a
	 crgiclPJzzMM4GfA/dRBHh1++ZfpU7dxRVdhO7cdVZ7oF2M46XpBd7vr976Iyd8BmfA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794211283;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:X-Envelope-To:
	 DKIM-Signature:X-Envelope-To:Received:X-Mizu-Trace-ID:X-Migadu-Flow:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ZgKkzjYhAsJy4AEss0yLnt3OHyjvDwbSqfJwvTcFrVQ=;
	b=Y6SG9xvbTtFEQ02kVbZmSD1SGCcqBbmCxuPehIXG6AOlgfZBnCdPyFWERqFJzhWhka4e
	 JzWwIAhl1CXS+4VAJIlY7+x6qhtpYN/WfbLfA6+ZwajL1qwqeg/aNV5Jy1gvgw0z1HIc8
	 3yU+bdSX4moWH7+qN1qayKHlfkux/apXhdRPdhorKXzfaEe/S21xD5DtA/yT5HTjDMLso
	 KC2LXe7gwAyN71YakrH4GDs1ATTsl7lgKGTl/ZSyDjElI2G5Q4FiGIY/vUNAErZmJsciJ
	 U+uKiAhvZ7kA3cXBC5Zt0nuIP8nYGg9WLE4Rbt9lOEVz/9UGh7FHs1IRA6JHTuBl7UA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794211283;
	bh=ZgKkzjYhAsJy4AEss0yLnt3OHyjvDwbSqfJwvTcFrVQ=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=btZRzo3LEh5jMeY2UxIh2tVkmLYZtnDtPVMomsocJszvEmaTyTw4UW0ex6quUYJ40
	 1oTMUzlRotVAQP1z/XY0f21SUM71+CyAyZdQihDS8ab6exU++48KChSB2bV255hyvx
	 aGjf63pl9iflsLz2uIPutXXu/I6SS8CMiJuVy51AknRM/ocBY0UoILR8oX0454iiAd
	 Si3sld0AsYV88ktiLr/YR7wZxYgCaOd98WuIWUTaYgIm4puNTeCpMiNkxhsiDQ9CPb
	 GQLnDOcMcftehuKfQrCqORiEMF/TN7F2wd11Ut8hX1oWFCkDOoQovpXpQQDPb2+12i
	 AGsK4OlpyBepA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B1E426061D;
	Mon,  9 Nov 2026 08:01:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3F7F8235
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 08:01:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 25907405E9
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 08:01:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N_iAI0CLXrkO for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 08:01:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 94561405D9
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:41d0:1004:224b::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:41d0:1004:224b::5; helo=mta0.migadu.com;
 envelope-from=funderscore@postmarketos.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=postmarketos.org header.i=@postmarketos.org
 header.a=rsa-sha256 header.s=key1 header.b=RDKlRk3O
Received: from mta0.migadu.com (out-5.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::5])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 94561405D9
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 08:01:18 +0000 (UTC)
X-Envelope-To: u-boot@lists.u-boot-project.org
DKIM-Signature: a=rsa-sha256; bh=l2JnWO3NELQ4N8zPYA4mIZkYuS7s0v1rRr3lrefPWXM=; 
 c=simple/simple; d=postmarketos.org;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794211276; v=1; x=1794816076;
 b=RDKlRk3O1YskZKzJ0TsK8YypDKez8LwHK+ofl0j3ntrYJcVHkiM8K1pmmAqqLOPSxgfKaoeC
 0E7TN6V66g0Cw7uUCOsm4JqxEM23Y/roqIczk27lXAyUFbtdzBWdV8y9Oefg2dsjWkPH8naWksR
 shXtH90ea7owlsR7X8DfB8WIZWz7SDWnELWlosfefOZ0IK1SN0KcVJ/Td/T4UUP7CrN46vGDcCw
 pstek30Hp9wq0moexatP+SSOMuVi4YU7qkUW1LoW2wOLPPDqNCQU65B1XjWqZJ5qjALI8a7wX4t
 cWQTy4X7peWOQNHxyZCsUL4p4/LLMorzI2+NRZhhf9WpQ==
X-Envelope-To: u-boot@lists.u-boot-project.org
Received: by smtp.migadu.com with ESMTPS id 23faf738ea9d0e9e;
 Mon, 09 Nov 2026 08:01:15 +0000
X-Mizu-Trace-ID: 23faf738ea9d0e9e
X-Migadu-Flow: FLOW_OUT
From: Ferass El Hafidi <funderscore@postmarketos.org>
Date: Mon, 09 Nov 2026 08:01:02 +0000
Subject: [PATCH] block: add legacy block support for TPL
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-legacy-block-tpl-v1-1-aeee138e9288@postmarketos.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQwNL3ZzU9MTkSt2knPzkbN2SghzdZNMkA8tUE6OkZOM0JaC2gqLUtMw
 KsJHRsbW1ADSJvlViAAAA
X-Change-ID: 20261109-legacy-block-tpl-c5b09e42bc3f
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Alexey Charkov <alchark@flipper.net>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Julien Masson <jmasson@baylibre.com>, Carlo Caione <ccaione@baylibre.com>, 
 =?utf-8?q?J=C3=B6rg_Sommer?= <joerg@jo-so.de>, 
 Johan Jonker <jbx6244@gmail.com>, Denis Mukhin <dmukhin@ford.com>, 
 Ferass El Hafidi <funderscore@postmarketos.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3913;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=l2JnWO3NELQ4N8zPYA4mIZkYuS7s0v1rRr3lrefPWXM=;
 b=owGbwMvMwCXmrHl2/av2XeKMp9WSGLI+1h7/4PD6Qbre9+bw7e3nRazVmlxMguPOzH/z5HPSi
 ozgP1XpHRNZGMS4GCzFFFnOh+5P3v99Y6j09keBMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 IZChY8TAxSkAU20xn+F/3sJTreuurdv8yKl1vtpuobbvmd16H+3e1OXcuOC5sL1uHsP/qB3X9eO
 NRZYe2Md9Uzvj7aUFV0WZlqvcO9R54aNz6fWbvAA=
X-Developer-Key: i=funderscore@postmarketos.org; a=openpgp;
 fpr=CF55BF63BFF7B1551BB7E2514329CDAFEA87BA17
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Legacy block support is only selectable for SPL. However it is
useful in TPL too, where the full block driver (with DM and whatnot)
will not fit.
Add a TPL_LEGACY_BLOCK kconfig option to enable legacy block support in
TPL. Note that it is hidden in menuconfig (just like the SPL variant).

Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
---
As I've been working on some TPL support for Amlogic I noticed that I
could not choose the legacy block driver (while I could choose it for SPL).
Given we only have 44K available, DM is a tight fit there so I'd rather not
enable it where possible to save space.

Adding the ability to select the legacy block driver in TPL seemed like
a good option for the same reasons it is already available for SPL
builds. And indeed it works just fine there too.
---
 disk/Makefile          |  4 ++--
 drivers/Makefile       |  7 ++++++-
 drivers/block/Kconfig  | 12 +++++++++++-
 drivers/block/Makefile |  2 +-
 4 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/disk/Makefile b/disk/Makefile
index c16876e2073..18b839f6ecd 100644
--- a/disk/Makefile
+++ b/disk/Makefile
@@ -10,8 +10,8 @@ ifdef CONFIG_$(PHASE_)BLK
 obj-$(CONFIG_$(PHASE_)PARTITIONS)  += disk-uclass.o
 endif
 
-# Must have BLK or SPL_LEGACY_BLOCK to support partitions
-ifneq ($(CONFIG_$(PHASE_)BLK),$(CONFIG_SPL_LEGACY_BLOCK),)
+# Must have BLK or LEGACY_BLOCK to support partitions
+ifneq ($(CONFIG_$(PHASE_)BLK),$(CONFIG_$(PHASE_)LEGACY_BLOCK),)
 obj-$(CONFIG_$(PHASE_)DOS_PARTITION)   += part_dos.o
 obj-$(CONFIG_$(PHASE_)ISO_PARTITION)   += part_iso.o
 obj-$(CONFIG_$(PHASE_)EFI_PARTITION)   += part_efi.o
diff --git a/drivers/Makefile b/drivers/Makefile
index 5403206159c..989be07cd02 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -74,7 +74,6 @@ obj-$(CONFIG_SPL_USB_GADGET) += usb/gadget/udc/
 obj-$(CONFIG_SPL_WATCHDOG) += watchdog/
 obj-$(CONFIG_SPL_USB_HOST) += usb/host/
 obj-$(CONFIG_SPL_SATA) += ata/ scsi/
-obj-$(CONFIG_SPL_LEGACY_BLOCK) += block/
 obj-$(CONFIG_SPL_THERMAL) += thermal/
 obj-$(CONFIG_SPL_UFS_SUPPORT) += scsi/ ufs/
 
@@ -82,6 +81,12 @@ endif
 endif
 endif
 
+ifdef CONFIG_XPL_BUILD
+
+obj-$(CONFIG_$(PHASE_)LEGACY_BLOCK) += block/
+
+endif
+
 ifdef CONFIG_TPL_BUILD
 
 obj-$(CONFIG_TPL_MPC8XXX_INIT_DDR) += ddr/fsl/
diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index d44cf4bcb6b..e6f1d82267b 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -15,7 +15,17 @@ config SPL_LEGACY_BLOCK
 	default y if SPL_AHCI_PCI
 	help
 	  Some devices require block support whether or not DM is enabled. This
-	  is only supported in SPL. With this, the blk uclass is not used, but
+	  is only supported in SPL and TPL. With this, the blk uclass is not used, but
+	  instead a legacy implementation of block devices is used, with all
+	  devices consisting of 'struct blk_desc' records.
+
+config TPL_LEGACY_BLOCK
+	bool # "Enable Legacy Block Device in TPL"
+	depends on TPL
+	default y if TPL_MMC || SCSI || NVME || IDE
+	help
+	  Some devices require block support whether or not DM is enabled. This
+	  is only supported in SPL and TPL. With this, the blk uclass is not used, but
 	  instead a legacy implementation of block devices is used, with all
 	  devices consisting of 'struct blk_desc' records.
 
diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index c827fa81a2d..e88914db283 100644
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -6,7 +6,7 @@
 obj-$(CONFIG_$(PHASE_)BLK) += blk-uclass.o
 
 ifndef CONFIG_$(PHASE_)BLK
-obj-$(CONFIG_SPL_LEGACY_BLOCK) += blk_legacy.o
+obj-$(CONFIG_$(PHASE_)LEGACY_BLOCK) += blk_legacy.o
 endif
 
 ifndef CONFIG_XPL_BUILD

---
base-commit: ed869863c7e2aca50d57a05d843830dd843138c4
change-id: 20261109-legacy-block-tpl-c5b09e42bc3f

Best regards,
-- 
Ferass

