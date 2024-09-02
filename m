Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BEE1CD13CF
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 05:33:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D08788970;
	Mon,  2 Sep 2024 07:33:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA6E288A0A; Mon,  2 Sep 2024 07:33:36 +0200 (CEST)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07F3F888D7
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 07:33:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=aspeedtech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chiawei_wang@aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 2 Sep
 2024 13:33:26 +0800
Received: from mail.aspeedtech.com (192.168.10.152) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 2 Sep 2024 13:33:26 +0800
From: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
To: <trini@konsulko.com>, <sjg@chromium.org>, <bob.wolff68@gmail.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH 3/4] image-fit-sig: Remove padding check
Date: Mon, 2 Sep 2024 13:33:25 +0800
Message-ID: <20240902053326.3273410-4-chiawei_wang@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240902053326.3273410-1-chiawei_wang@aspeedtech.com>
References: <20240902053326.3273410-1-chiawei_wang@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

The padding algorithm is not mandatory for all signing algorithm.

For example, ECDSA does not require a padding method. The RSA case
which needs PKCS padding, the belonging info->crypto() also has the
check on the validity of info->padding().

Thus, remove the info->padding check from the upper, general layer.

Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
---
 boot/image-fit-sig.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/image-fit-sig.c b/boot/image-fit-sig.c
index fe328df4a85..d06e6cc8ed6 100644
--- a/boot/image-fit-sig.c
+++ b/boot/image-fit-sig.c
@@ -95,7 +95,7 @@ static int fit_image_setup_verify(struct image_sign_info *info,
 	info->required_keynode = required_keynode;
 	printf("%s:%s", algo_name, info->keyname);
 
-	if (!info->checksum || !info->crypto || !info->padding) {
+	if (!info->checksum || !info->crypto) {
 		*err_msgp = "Unknown signature algorithm";
 		return -1;
 	}
-- 
2.25.1

