Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB35CCD184
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 02:46:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 474FB83FAE;
	Fri, 10 Oct 2025 04:46:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=socionext.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB2A683FAE; Fri, 10 Oct 2025 04:46:11 +0200 (CEST)
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
 by phobos.denx.de (Postfix) with ESMTP id 78DCA83986
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 04:46:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=socionext.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hayashi.kunihiko@socionext.com
Received: from unknown (HELO kinkan3-ex.css.socionext.com) ([172.31.9.52])
 by mx.socionext.com with ESMTP; 10 Oct 2025 11:46:05 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
 by kinkan3-ex.css.socionext.com (Postfix) with ESMTP id 9A9092069FC4;
 Fri, 10 Oct 2025 11:46:05 +0900 (JST)
Received: from kinkan3.css.socionext.com ([172.31.9.51]) by m-FILTER with
 ESMTP; Fri, 10 Oct 2025 11:46:05 +0900
Received: from plum.e01.socionext.com (unknown [10.212.245.39])
 by kinkan3.css.socionext.com (Postfix) with ESMTP id ADE881757;
 Fri, 10 Oct 2025 11:46:04 +0900 (JST)
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH] ufs: Fix wrong bitfield usage for Data Direction in Transfer
 Request
Date: Fri, 10 Oct 2025 11:45:57 +0900
Message-Id: <20251010024557.673787-1-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Commit d232d7fdbf6f ("ufs: core: sync ufshci.h with Linux v6.12") updated
the Data Direction values from bitmask values to simple enumerations.

Before:
    enum {
        UTP_NO_DATA_TRANSFER    = 0x00000000,
        UTP_HOST_TO_DEVICE      = 0x02000000,
        UTP_DEVICE_TO_HOST      = 0x04000000,
    };

Updated:
    enum utp_data_direction {
        UTP_NO_DATA_TRANSFER    = 0,
        UTP_HOST_TO_DEVICE      = 1,
        UTP_DEVICE_TO_HOST      = 2,
    };

However, the U-Boot code still uses these values directly without shifting,
and resulting in wrong bitfield placement in the Transfer Request
Descriptor.

This fixes the issue by applying the necessary shift to align the value.

Fixes: d232d7fdbf6f ("ufs: core: sync ufshci.h with Linux v6.12")
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/ufs/ufs.c | 3 ++-
 drivers/ufs/ufs.h | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
index 91f6ad3bfef9..b224388229a4 100644
--- a/drivers/ufs/ufs.c
+++ b/drivers/ufs/ufs.c
@@ -746,7 +746,8 @@ static void ufshcd_prepare_req_desc_hdr(struct ufs_hba *hba,
 		*upiu_flags = UPIU_CMD_FLAGS_NONE;
 	}
 
-	dword_0 = data_direction | (0x1 << UPIU_COMMAND_TYPE_OFFSET);
+	dword_0 = (data_direction << UPIU_DATA_DIRECTION_OFFSET)
+		| (0x1 << UPIU_COMMAND_TYPE_OFFSET);
 
 	/* Enable Interrupt for command */
 	dword_0 |= UTP_REQ_DESC_INT_CMD;
diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
index 53137fae3a81..cf11be3e0b46 100644
--- a/drivers/ufs/ufs.h
+++ b/drivers/ufs/ufs.h
@@ -77,6 +77,9 @@ enum {
 /* UTP Transfer Request Command Offset */
 #define UPIU_COMMAND_TYPE_OFFSET	28
 
+/* UTP Transfer Request Data Direction Offset */
+#define UPIU_DATA_DIRECTION_OFFSET	25
+
 /* Offset of the response code in the UPIU header */
 #define UPIU_RSP_CODE_OFFSET		8
 
-- 
2.34.1

