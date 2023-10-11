Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 072B5CD6E64
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 13:22:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AC1E86E25;
	Wed, 11 Oct 2023 15:18:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3221D86E6B; Wed, 11 Oct 2023 15:17:58 +0200 (CEST)
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
 by phobos.denx.de (Postfix) with SMTP id D815586E51
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 15:17:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng@tinylab.org
X-QQ-mid: bizesmtp83t1697030177tmbrambr
Received: from ubuntu.. ( [111.196.129.4]) by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 11 Oct 2023 21:16:17 +0800 (CST)
X-QQ-SSF: 01200000000000F0I000000A0000000
X-QQ-FEAT: /rrU+puPB7SvHAAUQFBfbZeHpGF+b+Pj1TQMXkJvqJ0CQmkp/1S6rbcIpbSJJ
 W1J2oFlMm9w2pQJy4ab28KaAmsh4pOcDYUKD2hp7FY1P6265rqrsxoTJghLjpPYiWdk8bD8
 OrE1ro3aPeo/aZwhDLZzqCuCbFMEzY5thtFXDWxa2SbMxD0NaZOMjWPz6+FU8ozVeuoT9Os
 Rwnt1Nr9RDArk+0t7VBEnbhlanjwlzkxpqu9jrx/AbA7FQlskkyVuq4WWjOTN4o7xFg73Rw
 C/LYw/BSx4V5x5oLVtWjN1wX5r9YPJAkQk1xZjCIFpA31fb/EcYOGcXm9SsB01Fp6iWQq5L
 najHcpoFfkt2hMBUEIbM+nplv7hgKLXKqS2uyNY
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4434716918789676729
From: Bin Meng <bmeng@tinylab.org>
To: Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>
Cc: Simon Glass <sjg@chromium.org>,
	u-boot@lists.denx.de
Subject: [PATCH v2 8/9] ufs: Handle UFS 3.1 controllers
Date: Wed, 11 Oct 2023 21:15:51 +0800
Message-Id: <20231011131552.14665-9-bmeng@tinylab.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231011131552.14665-1-bmeng@tinylab.org>
References: <20231011131552.14665-1-bmeng@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz7a-0
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

Extend the version check to handle UFS 3.1 controllers as well.
Tested on QEMU emulated UFS 3.1 controller.

Signed-off-by: Bin Meng <bmeng@tinylab.org>
---

(no changes since v1)

 drivers/ufs/ufs.c | 3 ++-
 drivers/ufs/ufs.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
index fb2a607ef1..6287ce91a3 100644
--- a/drivers/ufs/ufs.c
+++ b/drivers/ufs/ufs.c
@@ -1953,7 +1953,8 @@ int ufshcd_probe(struct udevice *ufs_dev, struct ufs_hba_ops *hba_ops)
 	    hba->version != UFSHCI_VERSION_11 &&
 	    hba->version != UFSHCI_VERSION_20 &&
 	    hba->version != UFSHCI_VERSION_21 &&
-	    hba->version != UFSHCI_VERSION_30)
+	    hba->version != UFSHCI_VERSION_30 &&
+	    hba->version != UFSHCI_VERSION_31)
 		dev_err(hba->dev, "invalid UFS version 0x%x\n",
 			hba->version);
 
diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
index 9daaf03d22..816a5ce0ca 100644
--- a/drivers/ufs/ufs.h
+++ b/drivers/ufs/ufs.h
@@ -782,6 +782,7 @@ enum {
 	UFSHCI_VERSION_20 = 0x00000200, /* 2.0 */
 	UFSHCI_VERSION_21 = 0x00000210, /* 2.1 */
 	UFSHCI_VERSION_30 = 0x00000300, /* 3.0 */
+	UFSHCI_VERSION_31 = 0x00000310, /* 3.1 */
 };
 
 /* Interrupt disable masks */
-- 
2.34.1

