Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E75ACA5FCE
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 05:12:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 268BB80DA5;
	Mon,  5 Oct 2026 05:12:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZBz8zXKUl3od; Mon,  5 Oct 2026 05:12:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1D6C580D83
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791177167;
	b=rXavPXLlVqK4Kn6wERNVR8yLjYPl127A6dVe5dDANmcdYTyqz3YTRQPwNsSG/fmsOxtq
	 ATXemkCX5bT4bOSsTw0hrnMAuSKlQZ+cTPtc5IeFVlE5aaC0w1tquNTunzouqL0xomodx
	 gYnyOv5KNJbVwYsg3al3LMWyUGHUL2QFbNGoqeYQB6Ob3Sk5fQ6ou5RoLOGLb3btpQPZ+
	 gsff4j8cYgehNu278hzpSC+naD0I3SOe6o7DvjjG94+nXBIbeM5Qs4qu1afqwEtIDasSP
	 RKQQ5LiytnsUr59aZYNVtmkVMIb1PSDVI9R3R37dAQPH6LVhmGpCeGdOVASWarxx+fA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791177167;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=jZnBOItmo+GWl+bvWPicKi65rqcFkMNhrrePDc5Ubys=;
	b=gJJ/+XxbKEl8cM6PTGg9X5t59UtsvUAhb2+AGs1FbllDRNML+VrSuqFcBkW0NlTa4cTF
	 P1hU+Mscl9vUejGxW/ekGITfLfZrDwFBkKizPTME/axxVV2kaS2txQdKy6m4tuNB//uJI
	 3pk0veNbsjHITWAju4lTWu1hvlFlxYkZm2jky9qZZQPwXVeHi3ezh+rGw0ADMcxcR5qZN
	 fwexPKQTTwiOcp7JsgkcKIlQR1DttOW9JuaQgMIV6XjVXQm8uZbZXo5mnSUCW9y7i21Dy
	 D8WTd3yxKCVfVw32yWnPOKhbDq27VapJmXVUw3TVdM8FuHp6B0CJ/HeuJxmrcvEVxjw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791177167;
	bh=jZnBOItmo+GWl+bvWPicKi65rqcFkMNhrrePDc5Ubys=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=pxnz3+VAThmO9uObcmUiPXs7vjNgX+Wpr7f7/DajH5vVoxc1/SeZjmhQe7/EgTPFP
	 Tr5RETTvEg00goZyxxVv/pnUxrux6bxN7ivuhxHwkwAirreqhgXNMBuWvCz5iNRhs+
	 Dr1bjUKjep2ODoAIoAhOo1v6FUUqQt1tTz5NxGl2fVCBqj4y2C/EHw70ArwInceyfX
	 3Uw4ChbKLpFG093tpY7FUcj1HqcwIYutEKS2KfgxpOX67eNPN0pCmCc3T2RlKk2xJg
	 Q9zwhzoW2DVMBMee1eDvxcycVGc5+XNWsrGoTbFU06jESA0IaaWN+2dWM585sPSw/V
	 ndjQOMhqSxafQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1D6C580D83;
	Mon,  5 Oct 2026 05:12:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1704422B
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 19:23:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 08E8540075
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 19:23:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sj4ffD_EP9Wb for <u-boot@lists.u-boot-project.org>;
 Sun,  4 Oct 2026 19:23:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 4F79540004
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791141783;
 b=gPTfqWuTw3Zr8aqsTE519vjl9kOHdKeHa9Ijhzpcqyv1i+qYFivP7Jeqg7EQ/1qUkSKj
 ArKBuQhczgf4fwDpXcjpy3Dv7MzUamFU9aONCYYTtoGHGNXyR/+GMuykhZATZcIgMsl67
 lKfmoHCIqvRycangtmuYdqL9KQ3MYW1LH5rtcS8xEuB7fpE/X111R2CU8/HG+BfkQ4WZ9
 AW+8d4ZurLuYhVr7vaWFZGFkIQRSlSqkH00dhRDnlZE+P2rGUP19e9y/VmNRYYmXEUFic
 4hiPf2Fy6ZTLrsUeR5O2ABZQ965y7bPywLIfkSQX43Eo6wjPKNvnPwQK7oGHEkuVn1Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791141783;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=jZnBOItmo+GWl+bvWPicKi65rqcFkMNhrrePDc5Ubys=;
 b=IcCbtjkrVVmgP+dXvcsjKaC/ptm6sussP2chlw4EpDGPa4BW0TTpgKeK22vno4IllCCO
 /wbOywPD+ENpgJ938ztrrnE/g5PobrHLSdRI7kFS1fbEXE9fCmeWMkw2KapSw+OuOctMJ
 Y83Ig6kbLLHHGr9i1Bf32cczMrPjX63YiEkiUOoUskf3EK7uRjhQAegcsVb6uPaQumKb3
 /zsUSHK0G3nTM4PNMKNurmGesBsJ2bX7g04dMcmIkLIywc9w0QbyN2N4+1rwHtNiCdps4
 KJR8DFVvj8axrfL3f2ERaSddNYg0faOPM+qCLWe4OdaqO8SAUfICOFp56PAZosv7ZHQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=mPJTON4O; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=mPJTON4O
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4F79540004
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 19:23:03 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 521CF43FB6;
 Sun,  4 Oct 2026 19:23:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2121AC4AF67;
 Sun,  4 Oct 2026 19:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791141782;
 bh=MX6QpjcDLG3OdJxrWqdT8Yu78yba7xC++J2GgWxmHGw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=mPJTON4OInJN+/Iao+QiBG2Jglxct3OD4Db+tLmoZKHRRuL9stRoebsaxlrLRDIZ8
 /W0ZBE0FE4r2qgoe4oX3TGpeA95/i2aUDQSSe81oksG2cRwIFbQxQz+W+TB515iXVV
 429lb3S3+UtWB6basyIRu4Vbl4G4gU02aXYkSGiAYHdKWFzTZAIyY6C3xhZblUTPiO
 2jBxlRy/nA7bmEfkospqMieK6o3Xk/iMqI8fJuKSM9pMjUpaftEAmm7qeKANnT2iI8
 g9Fn/AkVSoa05ZVcNEFvPZrriFLNvP1njNw4+7AcQsiAFZg5dgxJPkJAl7KcI7nTV9
 HV/W252BTzMgg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD05CA5FCE;
 Sun,  4 Oct 2026 19:23:02 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Sun, 04 Oct 2026 21:22:37 +0200
Subject: [PATCH u-boot 5/8] scsi: ufs: refuse erase/UNMAP on NO_PURGE devices
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261004-b4-ufs-sony-v1-5-54e71c95ba62@protonmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791141780; l=2283;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=6DAUFUAuX1kh2EGKP1zZL/kXMWnZ7K3mF+wCJzqM3dU=;
 b=Ut927M9BiT1NPo6Nh2l1okrMvskxdhzJMVL35MAcgfIyhwmuwG+cruu4TVWm1yBKApEJ+adE1
 SWVhUXsQT9HBtikSNFSeBYALm289PVEJUAExxBGyYMkKYl1LCTLlR8p
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

Enforce the UFS_DEVICE_QUIRK_NO_PURGE quirk on U-Boot's only path that
can reach a UFS device with a destructive UNMAP: the block-device erase
op (scsi_erase() -> SCSI_UNMAP). On Sony Yoshino/Tama a PURGE/UNMAP
erases the bootloader and permanently bricks the device.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 drivers/scsi/scsi.c      |  5 +++++
 drivers/ufs/ufs-uclass.c | 12 ++++++++++++
 include/scsi.h           |  5 +++++
 3 files changed, 22 insertions(+)

diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index 50e7d749921..ba7834ea035 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -300,6 +300,11 @@ static ulong scsi_erase(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt)
 	lbaint_t start, blks, max_blks, blocks;
 	struct scsi_cmd *pccb = (struct scsi_cmd *)&tempccb;
 
+	if (uc_plat->no_erase) {
+		printf("%s: erase not supported on this device\n", __func__);
+		return 0;
+	}
+
 	/* Setup device */
 	pccb->target = block_dev->target;
 	pccb->lun = block_dev->lun;
diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
index 977ffebc21f..7dfba3ac1ac 100644
--- a/drivers/ufs/ufs-uclass.c
+++ b/drivers/ufs/ufs-uclass.c
@@ -2366,6 +2366,18 @@ int ufshcd_probe(struct udevice *ufs_dev, struct ufs_hba_ops *hba_ops)
 	if (err)
 		return err;
 
+	/*
+	 * Some devices must never receive a PURGE / UNMAP (secure erase): on
+	 * the affected platforms it erases the bootloader and permanently
+	 * bricks the device. Disable the SCSI erase op for the whole UFS
+	 * device in that case.
+	 */
+	if (hba->dev_quirks & UFS_DEVICE_QUIRK_NO_PURGE) {
+		scsi_plat->no_erase = true;
+		dev_info(hba->dev,
+			 "NO_PURGE quirk active: SCSI erase/UNMAP disabled\n");
+	}
+
 	return 0;
 }
 
diff --git a/include/scsi.h b/include/scsi.h
index 2520a8b8fe6..fc296285dd5 100644
--- a/include/scsi.h
+++ b/include/scsi.h
@@ -275,6 +275,11 @@ struct scsi_plat {
 	unsigned long max_lun;
 	unsigned long max_id;
 	unsigned long max_bytes_per_req;
+	/*
+	 * Set by the controller driver to forbid the erase (UNMAP) operation,
+	 * e.g. for UFS devices whose PURGE/UNMAP would erase the bootloader.
+	 */
+	bool no_erase;
 };
 
 /* Operations for SCSI */

-- 
2.55.0


