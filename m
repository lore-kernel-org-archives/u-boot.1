Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EBA9C5AC67
	for <u-boot@archiver.kernel.org>; Sun,  9 Aug 2026 01:43:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B4BD260638;
	Sun,  9 Aug 2026 01:43:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d5bPs1ZfS6WH; Sun,  9 Aug 2026 01:43:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0FE346060C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786239791;
	bh=f7gTnst1ObcpWJcDdLLFCucJ+ml8SftcAaXv8W2OuxE=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=aX1IfepTeLJpyrHLSL9+rKBPF+5J2IRDAG03ntAV7INUIhqX4a1swhyMn0d01fT5R
	 4VtusP1Auymd/LJgY4XzLv+C4KI6A8gHgecwWvvwmdMVF5UaWYV36MaXo0yRnC3TDr
	 A3OIvYVWTNV85Ct0e3yAhsnU4LzBZ+7mahZ32jxtaQwFr6j+NAJW+a/64l81fXx6y1
	 +x6wuxlO5RiLBrYqOBtKfncpQJg/B9NYkiT2vVLSij+HSjPsmAFB4lNvprjJD2Fop+
	 zRBGtx9spz0XgGSUOT2tzFpPoG2misE/UGhme8Du5I4KWG9KgvxFI1Q0wyIVLRsBVk
	 KePFZcTyCMGow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0FE346060C;
	Sun,  9 Aug 2026 01:43:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 36AD7218
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 01:43:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1D49940597
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 01:43:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G8qgK1H4HoP1 for <u-boot@lists.u-boot-project.org>;
 Sun,  9 Aug 2026 01:43:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.151;
 helo=mout-p-101.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 16C2C40592
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 16C2C40592
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 16C2C40592
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 01:43:08 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hHgd66mPDz8tR9;
 Sun, 09 Aug 2026 03:43:06 +0200 (CEST)
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/3] arm64: renesas: r8a779g3: Add PCIe firmware environment
 on Retronix R-Car V4H Sparrow Hawk
Date: Sun,  9 Aug 2026 03:41:40 +0200
Message-ID: <20260809014258.447774-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: k5c7ctz97kcrzjr9jomxk4cdzt8r384s
X-MBO-RS-ID: 4f63b69d4351654bf8e
X-Rspamd-Queue-Id: 4hHgd66mPDz8tR9
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1786239786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=f7gTnst1ObcpWJcDdLLFCucJ+ml8SftcAaXv8W2OuxE=;
 b=Sfx2Hf4pkVjz68rQYBV0rPEETWK4wIH1v1te98RLnET+eRhc65R95HfOGsM2RQ6MJWrd6Z
 h2A+7EgtOi95G61QuCRgS9zS8hx7mxtGlMdweqoOTrd/di5M3DhZ0SxkS5ZykSWoxC4p7m
 QyJNISyh25h00jVBppX1ioWPiTP14/jP+TBqF4FCcwNt3i+lD/p17Csyl+RQ+b3DYeXPed
 MX6l/1RgJhozPNmktg2K7kOE822qhTdm08RVPS7miZ52V/HsnjxT+rg/+Bf3VHYtbY1tlg
 w0ZjpbWnpl1N12910BlD72yXJDYa9bo41okjRv7TviJVF7YcEwfKklV5wfuvyA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1786239785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=f7gTnst1ObcpWJcDdLLFCucJ+ml8SftcAaXv8W2OuxE=;
 b=bt45BmAFCP2JhlKG23dW+18c+PylE7v5CATWCe3Qn83boj42XgQZEgm3YUGRiPYTbUg2QZ
 L+reONJWD90GjBZTlWe8XhZL9S/mlsuiYxeQyDoeeIjTI2mxmFkMirxeZgFOS4VgpRukqV
 lchgupgR5nb3iYao0zgYFOwaD4EcTx9jtd9VL6akuj+Ek+S7FWq128P3H4CjKqaM0KABbM
 d3sjd7vfHeZC3+F5mh9Xolciipz1D99dh5/qAyQ7WbSJ2S8YVJdW5ztVcvqjnl9rvz108y
 Pgbrwtlnv64QTEvh+qXt0SC7577P3fuxKqqjRJLsCv5ccgRl2hHeI5CM3RcvfQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=Sfx2Hf4p; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=bt45BmAF
X-Mailman-Original-Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=bt45BmAF;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
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
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add PCIe controller firmware handling environment to Retronix R-Car
V4H Sparrow Hawk. The "renesas_rcar_gen4_load_firmware" script is used
to load PCIe controller firmware from SPI NOR offset 0x300000. The
"flash_pcie_fw_to_qspi_from_mmc" script is used to write the firmware
from SD card to SPI NOR offset 0x300000 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 include/configs/sparrowhawk.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/configs/sparrowhawk.h b/include/configs/sparrowhawk.h
index 0524e39229c..731455c9d8e 100644
--- a/include/configs/sparrowhawk.h
+++ b/include/configs/sparrowhawk.h
@@ -11,4 +11,26 @@
 
 #include "rcar-gen4-common.h"
 
+/* Environment setting */
+#undef CFG_EXTRA_ENV_SETTINGS
+#define CFG_EXTRA_ENV_SETTINGS						\
+	"bootm_size=0x10000000\0"					\
+	\
+	"renesas_rcar_gen4_pcie_firmware_sf_offset=0x300000\0"		\
+	"renesas_rcar_gen4_pcie_firmware_sd_path=lib/firmware/rcar_gen4_pcie.bin\0" \
+	"renesas_rcar_gen4_load_firmware="				\
+		"env set renesas_rcar_gen4_load_firmware_addr 0x54000000 && " \
+		"env set renesas_rcar_gen4_load_firmware_size 0x8000 && " \
+		"sf probe && "						\
+		"sf read ${renesas_rcar_gen4_load_firmware_addr} "	\
+			"${renesas_rcar_gen4_pcie_firmware_sf_offset} "	\
+			"${renesas_rcar_gen4_load_firmware_size}\0"	\
+	"flash_pcie_fw_to_qspi_from_mmc="				\
+		"load mmc 0:1 ${loadaddr} "				\
+			"${renesas_rcar_gen4_pcie_firmware_sd_path} && " \
+		"sf probe && "						\
+		"sf update ${loadaddr} "				\
+			"${renesas_rcar_gen4_pcie_firmware_sf_offset} "	\
+			"${filesize}\0"
+
 #endif /* __SPARROWHAWK_H */
-- 
2.53.0

