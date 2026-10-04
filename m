Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB182CA5FE2
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 05:13:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A0B944058A;
	Mon,  5 Oct 2026 05:13:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FdiP-fkOsbuE; Mon,  5 Oct 2026 05:13:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 990F1406C4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791177186;
	b=QAb9v0ohIGBqIc2cFTrVBsXlG/JNtIxgOnVm364F8ZoCC1+zfC7dLDrQFF9Vx0k20hNa
	 BR3PrnZdnG1VSeWFZs5ligJv17FSNdVtDY+NY3AUms2Zm+xCzB4N7II2mDv0uuzPRKzC3
	 WV867B1+QI5v/WUs1zzPYYwpo0OWmzeX/97DYco/2E702MVCXh3+1Z4yAnYOlqRP36J8Q
	 MLjEW5f1SgIa7Xf/sgof/P56wxQGmuhBF88B4OuFsoKV5E4cpj3vNRj/blrbp4keVPbM6
	 VoFccaGm59Pfb10VkT59uB65u3cxtwqlYbF+XfR0Luy/h5eUs/M7SLmjPFp4agzDJJA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791177186;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=BPg+A4Nvehw3RO3Q2ZE9cG5yAhTNS/WzAOfoxfsEjbU=;
	b=C+VDBSr1/Prz/ITzV/91A919YoURGwkYk1warWTrnXwG59VvmByDLzUu8b1zOuGQggM1
	 y4JfReo9OFcL6gem0hw/qj5acttrlqvmY47QcC4oaVzd6MxvbGpJQJs73MwAhaku+qFEW
	 TMq60MyL0zFk1LwChLvfhIqa7YaQvyaoSrqbuAwgnImpFPJYy7HaxIkxkACxaVik4amc0
	 Xzbg9bmrPnkFyYo02sxAaahQb1RY9v9C1fxRd2gb7baRpaEIljtUfgC1HU2y/LVETrRft
	 Z6pSHDCQBmy/idSCsxCjTDKLPw8gzkQSmDWAc6HRA+x516GkjZSgmw0qjtd+vxgXD5A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LR6X8o2r;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791177186;
	bh=BPg+A4Nvehw3RO3Q2ZE9cG5yAhTNS/WzAOfoxfsEjbU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=UcURuYLoUtdMrhHiPgi6sCGWZW+WGLXtFvJpBfZ7bvIY2zro5L2GQTLmK5lWY12EZ
	 HGmm5spPvPLFo9nWF6xse3NcBP/j6jX0CsUxkyXbNB4NVEjF6MXBDzc9yL4Ta4DkuE
	 yJz6ZVYKnBZSHJKHJPZIzRSydPQBaCGENsZXIsWO2OBunlC7N6luOLwgk81G0Xc/yF
	 D9U5mJzu7rffhbGDblqhP9+Rs7eZIZd3QdcbmeFCFFIgfV2uFx1OGYhZo8uTWBevBs
	 NRhB92c/0wjvuTAuNLr0BpFY8QN+2WMTg+ojX60y62UXzOCB/HvQfYVXqvWu/BW3O0
	 SpyPclq66Arvw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 990F1406C4;
	Mon,  5 Oct 2026 05:13:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D2F3A22B
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 19:23:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C3E8F40401
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 19:23:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S38VP4z0-aZC for <u-boot@lists.u-boot-project.org>;
 Sun,  4 Oct 2026 19:23:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D71DB403FF
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791141787;
 b=F01PMJXq974ojFU/qy3vxaxKam3D+21dXoxRDafHos1/ziFtZ3kOOTwtODe8jSy9q4BH
 YZZYLI1mo7qmi5BC5xnmwAVUBX6wYNz+YbnBSGcvLkzfpQRQUKJLX4MkSK1/Q97avzt2b
 84K0ItdM8qQaYQv/3bjm38+EX6T+vLdWpPxrK/S4AZbN5EFv9p+1EExhUceCGi2mGIYCt
 KksRHlGfkBy4TWbmtV9cXA7Fk7/lYAaB6S/zCg5nBmHNXs/i6JktqiHVh5Bys4c3KCAAN
 +IgMMpTkhr6Dydt0T50OODU/B1qvcIJPi+cjZGgylmHxAPH5RWG4ICNa/K+Z3O0nLeQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791141787;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=BPg+A4Nvehw3RO3Q2ZE9cG5yAhTNS/WzAOfoxfsEjbU=;
 b=jzEOs2d+drgXz5OIMUV3tswIFVPdcIGG4jmvsnqDKj+ax1lkz2MJmSsx7bOJfNddIrcu
 DmolgXUdMcRMvNeviW5Im/Ks+pX4cPNbYjj7U1zNiYCH0dv7PSZlUoyDCeLFJXwA6R0sK
 /SAoMjOXT7UJm8nuXlsUZKD091toK1JQN6ONpcCOSG1lxkAmGazpkNZJSd/wCOY+RJlcd
 RzTTbWyymk3QbTbIiGvnLU0Z4vYK8+6Nx8qVQ2m36B/MtxjfaX92BotJozhxCC+6hfaFY
 vi6ojOHtjAlTQDpbges/EBWZvicjooXkUG4ACwFO2mptWIV14tWRPLxH8LwzPVvhE2Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=LR6X8o2r; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=LR6X8o2r
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D71DB403FF
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 19:23:04 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 4892460210;
 Sun,  4 Oct 2026 19:23:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DD517C4AF62;
 Sun,  4 Oct 2026 19:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791141782;
 bh=JQ03nq7PcuueRAYZVYslWIEzYaiw128hRWdFq3SXHQw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=LR6X8o2rRAl0cWgpi40qbAK29/bl6wdcghPrjFMmSGPyXu9rtNjVGJJGGOIxSg+NQ
 SaYRBhUoj8VFqqZ0jFDfrY95veQNRbVEE+a00XQx39YjsYL8XJ1pwR39vViZXDQMS0
 ABfY2DgmXOs7rtfaHyvOhOIN2JhWMb4IuFsmFAfmE7W94OnXpOs91UeZK11Cj+Dpho
 Jzzh5F3msLW4I8fSXsHd7z0/rJtyGUEk6Snd+cpDH2qEC3FrUn/VayNtemqqwmhM9N
 pSfxLw3OMgW+KwpAX9E9MzkFSgV/nZR5OG1+/fVCrbikqnCinHS+6U5fqJ4ZI8g2zI
 lf69ffHKHbeyw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id BC7A4CA5FE6;
 Sun,  4 Oct 2026 19:23:01 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Sun, 04 Oct 2026 21:22:34 +0200
Subject: [PATCH u-boot 2/8] ufs: add device-quirk infrastructure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261004-b4-ufs-sony-v1-2-54e71c95ba62@protonmail.com>
References: <20261004-b4-ufs-sony-v1-0-54e71c95ba62@protonmail.com>
In-Reply-To: <20261004-b4-ufs-sony-v1-0-54e71c95ba62@protonmail.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 David Heidelberg <david@ixit.cz>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Padmarao Begari <padmarao.begari@amd.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>, Jared McArthur <j-mcarthur@ti.com>, 
 Michal Simek <michal.simek@amd.com>, Udit Kumar <u-kumar1@ti.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Tuyen Dang <tuyen.dang.xa@renesas.com>, Alexey Charkov <alchark@gmail.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Simon Glass <sjg@chromium.org>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Marek Vasut <marek.vasut@mailbox.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, Peng Fan <peng.fan@nxp.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, Janne Grunau <j@jannau.net>, 
 Julien Masson <jmasson@baylibre.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Markus Niebel <Markus.Niebel@ew.tq-group.com>, Petr Pavlata <petr@acrux.cz>, 
 Petr Hodina <petr.hodina@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791141780; l=6445;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=1Lha72qJKrT8yi3f7UMplATT3CjbB55Lsc65hh24lgs=;
 b=uu+dq7vpUwSeeBFeuYjTMQPHfOegDQSNGyE+IcVr/iGxTQdm96gI9FCWv2UmDVdVdT84vSTxd
 cgPw6kOtpkvAVVUXNwjMRfr16ZUX/QJEhV6CRPZuhSib8tAm3qIlcbx
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Mon, 05 Oct 2026 05:12:03 +0000
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
Reply-To: petr.hodina@protonmail.com
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Petr Hodina <petr.hodina@protonmail.com>

Infrastructure (ufs_quirks.h):
 - struct ufs_dev_quirk plus UFS_FIX()/UFS_FIX_REVISION() helpers.
 - ufshcd_fixup_dev_quirks() applies the table (and sets NO_PURGE for
   devices older than UFS_PURGE_SPEC_VER) from ufs_start(), before power
   mode negotiation so link quirks take effect.
 - hba gains a dev_quirks field, distinct from the host controller
   quirks (hba->quirks).

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 drivers/ufs/ufs-uclass.c | 52 +++++++++++++++++++++++++++++
 drivers/ufs/ufs.h        |  2 ++
 drivers/ufs/ufs_quirks.h | 87 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 141 insertions(+)

diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
index 56118a0ee46..05b95c510b4 100644
--- a/drivers/ufs/ufs-uclass.c
+++ b/drivers/ufs/ufs-uclass.c
@@ -29,6 +29,7 @@
 #include <linux/dma-mapping.h>
 
 #include "ufs.h"
+#include "ufs_quirks.h"
 
 #define UFSHCD_ENABLE_INTRS	(UTP_TRANSFER_REQ_COMPL |\
 				 UTP_TASK_REQ_COMPL |\
@@ -1866,6 +1867,54 @@ out:
 	return err;
 }
 
+/*
+ * UFS device quirk table. Entries are matched by manufacturer id, model and
+ * fw revision; UFS_ANY_VENDOR / UFS_ANY_MODEL / UFS_ANY_VER act as wildcards.
+ */
+static const struct ufs_dev_quirk ufs_fixups[] = {
+	/* Sony Yoshino/Tama: block PURGE/UNMAP to avoid bricking */
+	UFS_FIX_REVISION(UFS_VENDOR_SKHYNIX, UFS_MODEL_HYNIX_32GB,
+			 UFS_REVISION_HYNIX, UFS_DEVICE_QUIRK_NO_PURGE),
+	UFS_FIX_REVISION(UFS_VENDOR_SKHYNIX, UFS_MODEL_HYNIX_64GB,
+			 UFS_REVISION_HYNIX, UFS_DEVICE_QUIRK_NO_PURGE),
+	UFS_FIX_REVISION(UFS_VENDOR_SAMSUNG, UFS_MODEL_SAMSUNG_64GB,
+			 UFS_REVISION_SAMSUNG, UFS_DEVICE_QUIRK_NO_PURGE),
+	END_FIX
+};
+
+/**
+ * ufshcd_fixup_dev_quirks - apply device-specific quirks
+ *
+ * Sets hba->dev_quirks based on the UFS spec version and the per-device
+ * fixup table above.
+ */
+static void ufshcd_fixup_dev_quirks(struct ufs_hba *hba,
+				    struct ufs_dev_desc *dev_desc)
+{
+	const struct ufs_dev_quirk *f;
+
+	/*
+	 * Devices implementing an older UFS spec must not be issued PURGE /
+	 * UNMAP, doing so erases the bootloader on affected platforms.
+	 */
+	if (dev_desc->wspecversion < UFS_PURGE_SPEC_VER)
+		hba->dev_quirks |= UFS_DEVICE_QUIRK_NO_PURGE;
+
+	for (f = ufs_fixups; f->quirk; f++) {
+		if ((f->wmanufacturerid == dev_desc->wmanufacturerid ||
+		     f->wmanufacturerid == UFS_ANY_VENDOR) &&
+		    (str_prfx_equal(f->model, dev_desc->model) ||
+		     !strcmp(f->model, UFS_ANY_MODEL)) &&
+		    (str_prfx_equal(f->revision, dev_desc->revision) ||
+		     !strcmp(f->revision, UFS_ANY_VER)))
+			hba->dev_quirks |= f->quirk;
+	}
+
+	if (hba->dev_quirks)
+		dev_dbg(hba->dev, "%s: applied device quirks 0x%08x\n",
+			__func__, hba->dev_quirks);
+}
+
 struct ufs_ref_clk {
 	unsigned long freq_hz;
 	enum ufs_ref_clk_freq val;
@@ -2175,6 +2224,9 @@ static int ufs_start(struct ufs_hba *hba)
 		return ret;
 	}
 
+	/* Apply device-specific quirks before negotiating the power mode */
+	ufshcd_fixup_dev_quirks(hba, &card);
+
 	ufshcd_set_dev_ref_clk(hba);
 
 	if (ufshcd_get_max_pwr_mode(hba)) {
diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
index e3368a516e4..d4bcb7a1773 100644
--- a/drivers/ufs/ufs.h
+++ b/drivers/ufs/ufs.h
@@ -707,6 +707,8 @@ struct ufs_hba {
 	u32			version;
 	u32			intr_mask;
 	enum ufshcd_quirks	quirks;
+	/* UFS device (not host controller) quirks, see ufs_quirks.h */
+	u32			dev_quirks;
 
 	/* Virtual memory reference */
 	struct utp_transfer_cmd_desc *ucdl;
diff --git a/drivers/ufs/ufs_quirks.h b/drivers/ufs/ufs_quirks.h
new file mode 100644
index 00000000000..f5aa47722db
--- /dev/null
+++ b/drivers/ufs/ufs_quirks.h
@@ -0,0 +1,87 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * UFS device quirks
+ *
+ * Ported from the Linux kernel (include/ufs/ufs_quirks.h) and the
+ * Sony Yoshino/Tama downstream UFS quirks/hacks.
+ */
+#ifndef _UFS_QUIRKS_H
+#define _UFS_QUIRKS_H
+
+#include <linux/bitops.h>
+#include <linux/string.h>
+
+/* true if s1 (the fixup pattern) is a prefix of s2 (the device value) */
+static inline bool str_prfx_equal(const char *s1, const char *s2)
+{
+	return strncmp(s1, s2, strlen(s1)) == 0;
+}
+
+#define UFS_ANY_VENDOR		0xFFFF
+#define UFS_ANY_MODEL		"ANY_MODEL"
+#define UFS_ANY_VER		"ANY_VER"
+
+#define UFS_VENDOR_TOSHIBA	0x198
+#define UFS_VENDOR_SAMSUNG	0x1CE
+#define UFS_VENDOR_SKHYNIX	0x1AD
+#define UFS_VENDOR_MICRON	0x12C
+#define UFS_VENDOR_WDC		0x145
+
+/* UFS Samsung models */
+#define UFS_MODEL_SAMSUNG_64GB	"KLUDG4U1EA-B0C1"
+#define UFS_REVISION_SAMSUNG	"0100"
+
+/* UFS SK Hynix models */
+#define UFS_MODEL_HYNIX_32GB	"hB8aL1"
+#define UFS_MODEL_HYNIX_64GB	"hC8aL1"
+#define UFS_REVISION_HYNIX	"D001"
+
+/*
+ * Devices with a UFS spec version older than this must not be issued PURGE /
+ * UNMAP (secure erase) operations: on the Sony Yoshino/Tama platforms doing so
+ * erases the bootloader and permanently bricks the device.
+ */
+#define UFS_PURGE_SPEC_VER	0x210
+
+/**
+ * struct ufs_dev_quirk - ufs device quirk info
+ * @wmanufacturerid: card details (UFS_ANY_VENDOR matches any vendor)
+ * @model: card model (UFS_ANY_MODEL matches any model)
+ * @revision: card fw revision (UFS_ANY_VER matches any revision)
+ * @quirk: device quirk bitmask
+ */
+struct ufs_dev_quirk {
+	u16 wmanufacturerid;
+	const char *model;
+	const char *revision;
+	unsigned int quirk;
+};
+
+/* terminator for the fixup table */
+#define END_FIX { 0, NULL, NULL, 0 }
+
+/* add a quirk for any revision of a specific model */
+#define UFS_FIX(_vendor, _model, _quirk) {	\
+	.wmanufacturerid = (_vendor),		\
+	.model = (_model),			\
+	.revision = (UFS_ANY_VER),		\
+	.quirk = (_quirk),			\
+}
+
+/* add a quirk for a specific model and fw revision */
+#define UFS_FIX_REVISION(_vendor, _model, _revision, _quirk) {	\
+	.wmanufacturerid = (_vendor),				\
+	.model = (_model),					\
+	.revision = (_revision),				\
+	.quirk = (_quirk),					\
+}
+
+/*
+ * Some Sony UFS devices must not use the PURGE / UNMAP (secure erase)
+ * operation as it would erase the bootloader and permanently brick the
+ * device. This quirk disables PURGE-related functionality for affected
+ * devices.
+ */
+#define UFS_DEVICE_QUIRK_NO_PURGE		BIT(0)
+
+#endif /* _UFS_QUIRKS_H */

-- 
2.55.0


