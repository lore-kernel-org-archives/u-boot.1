Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A63A6CD6E64
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 13:18:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4180186D21;
	Wed, 11 Oct 2023 15:16:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFC5485423; Wed, 11 Oct 2023 15:16:28 +0200 (CEST)
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B806986C59
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 15:16:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng@tinylab.org
X-QQ-mid: bizesmtp83t1697030160tzw4efsd
Received: from ubuntu.. ( [111.196.129.4]) by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 11 Oct 2023 21:15:59 +0800 (CST)
X-QQ-SSF: 01200000000000F0I000000A0000000
X-QQ-FEAT: uGhnJwy6xZLrnwHZlAOhiGfyhyMzjzXdRzLRu7RN4GvtvpiOc0Hj2HDDTTpSF
 1X7LjFdmmPqktwY9wxwTpXywpr0cDW558/ALck8POyihLniG0LtX8z/QV6JdjPNV0vr3bGc
 eDC7DOiHMhd6qltZ0wWBUJchuJ0xpSKZbR/4x7N/G4PZk87v+OHOhg4fefvifC+3oOwOdHc
 He/5OcqbNdqvOgFUvKmppP6kb69suQHbVoUaseGNwO4LawCTFVeeqxQpklgR3dizDzvkVQn
 5cGYAzY6wdQFsNLKU5vqyonUe2njuK5jIJ6UFoPg/FycDuxfWPAUkAMg26Ukae920eM9rVe
 2zR8f4QUBsMgDas6SLz/a+5s2EpLuOL4+rwP54xfKjTPtOxvMI=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14302156895766321997
From: Bin Meng <bmeng@tinylab.org>
To: Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>
Cc: Simon Glass <sjg@chromium.org>,
	u-boot@lists.denx.de
Subject: [PATCH v2 2/9] ufs: Add a line feed to the end of some dev_xxx()
 messages
Date: Wed, 11 Oct 2023 21:15:45 +0800
Message-Id: <20231011131552.14665-3-bmeng@tinylab.org>
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

Add a line feed to improve readability of some dev_xxx() messages.

Signed-off-by: Bin Meng <bmeng@tinylab.org>
---

(no changes since v1)

 drivers/ufs/ufs.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
index f534d6e29f..96801866d3 100644
--- a/drivers/ufs/ufs.c
+++ b/drivers/ufs/ufs.c
@@ -320,7 +320,7 @@ static int ufshcd_disable_tx_lcc(struct ufs_hba *hba, bool peer)
 					UIC_ARG_MPHY_TX_GEN_SEL_INDEX(i)),
 					0);
 		if (err) {
-			dev_err(hba->dev, "%s: TX LCC Disable failed, peer = %d, lane = %d, err = %d",
+			dev_err(hba->dev, "%s: TX LCC Disable failed, peer = %d, lane = %d, err = %d\n",
 				__func__, peer, i, err);
 			break;
 		}
@@ -441,7 +441,7 @@ static int ufshcd_make_hba_operational(struct ufs_hba *hba)
 		ufshcd_enable_run_stop_reg(hba);
 	} else {
 		dev_err(hba->dev,
-			"Host controller not ready to process requests");
+			"Host controller not ready to process requests\n");
 		err = -EIO;
 		goto out;
 	}
@@ -930,7 +930,7 @@ static int ufshcd_copy_query_response(struct ufs_hba *hba)
 			memcpy(hba->dev_cmd.query.descriptor, descp, resp_len);
 		} else {
 			dev_warn(hba->dev,
-				 "%s: Response size is bigger than buffer",
+				 "%s: Response size is bigger than buffer\n",
 				 __func__);
 			return -EINVAL;
 		}
@@ -1179,11 +1179,11 @@ static int ufshcd_read_desc_length(struct ufs_hba *hba, enum desc_idn desc_id,
 					    &header_len);
 
 	if (ret) {
-		dev_err(hba->dev, "%s: Failed to get descriptor header id %d",
+		dev_err(hba->dev, "%s: Failed to get descriptor header id %d\n",
 			__func__, desc_id);
 		return ret;
 	} else if (desc_id != header[QUERY_DESC_DESC_TYPE_OFFSET]) {
-		dev_warn(hba->dev, "%s: descriptor header id %d and desc_id %d mismatch",
+		dev_warn(hba->dev, "%s: descriptor header id %d and desc_id %d mismatch\n",
 			 __func__, header[QUERY_DESC_DESC_TYPE_OFFSET],
 			 desc_id);
 		ret = -EINVAL;
@@ -1302,7 +1302,7 @@ int ufshcd_read_desc_param(struct ufs_hba *hba, enum desc_idn desc_id,
 
 	/* Sanity checks */
 	if (ret || !buff_len) {
-		dev_err(hba->dev, "%s: Failed to get full descriptor length",
+		dev_err(hba->dev, "%s: Failed to get full descriptor length\n",
 			__func__);
 		return ret;
 	}
@@ -1323,14 +1323,14 @@ int ufshcd_read_desc_param(struct ufs_hba *hba, enum desc_idn desc_id,
 					    &buff_len);
 
 	if (ret) {
-		dev_err(hba->dev, "%s: Failed reading descriptor. desc_id %d, desc_index %d, param_offset %d, ret %d",
+		dev_err(hba->dev, "%s: Failed reading descriptor. desc_id %d, desc_index %d, param_offset %d, ret %d\n",
 			__func__, desc_id, desc_index, param_offset, ret);
 		goto out;
 	}
 
 	/* Sanity check */
 	if (desc_buf[QUERY_DESC_DESC_TYPE_OFFSET] != desc_id) {
-		dev_err(hba->dev, "%s: invalid desc_id %d in descriptor header",
+		dev_err(hba->dev, "%s: invalid desc_id %d in descriptor header\n",
 			__func__, desc_buf[QUERY_DESC_DESC_TYPE_OFFSET]);
 		ret = -EINVAL;
 		goto out;
-- 
2.34.1

