Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CB70CCF9E0
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 14:24:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DC5C83710;
	Tue, 28 Oct 2025 15:23:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Y290DfCi";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="pf5+kMw9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAD6880422; Tue, 28 Oct 2025 15:23:54 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 087E6836F0
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 15:23:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cwt0S5nv0z9tV7;
 Tue, 28 Oct 2025 15:23:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761661432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TdLcdt/t/vTBMoUmKVypEiXQkzyQ66UzDZ/WQm6zMo4=;
 b=Y290DfCikn462RfTdpIKuZ56lAVT9ZhHPoAjtREwFsQ/RsEiBIqR/0qv2yPtzitov79Utc
 LamXl92HUa2U4Px3DNv9bc9hNjNI/CxQcgeJv5VSkEG/bKffWhJdDsxRYA9WbGhylD91Gd
 BqWHPcIFTxKWnaLm+WGrxEadgMQpUdXZSxDOJQW3L0aN5FXT2COuC2QQew58m6FyAqMshb
 7VzHEym0pI/RsVuX4ufbYV4VzvOLE7TsFTKwv36LpMeRmuulXC5ZnDShyHhyuqpCYq60GJ
 7hefkAk273EzNMO786nX/M7tMY2CF6MTapHnwSIRr/wSELczw8fKSWLerdKsSw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761661430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TdLcdt/t/vTBMoUmKVypEiXQkzyQ66UzDZ/WQm6zMo4=;
 b=pf5+kMw9PBl6T/3aMRbc9h6hqEJFrQ0a8DKEfD+4Obmot9fL1gCu779b60fvTMQyq0fAEY
 4U26ef8vQksiLQNlHrWFqV+BwNsbwZ5P/xLzf1ez3PJzu8aU7cLEounkmTMCKbxZEnDcWI
 4B8rXn3b9AmtC4v+eGCdjwyeQzoty8CcHx0jwfpxttFCjMaQZQw8mOt0D134yAptyAt4af
 0gI5Ykce1Tqnsh6FUa3XlGEVhBPTJhycKWeJrWfNy5Xmq4ckj6BGxxxJOHpQfngFRuFBan
 PPZsgCWDaQNvysauAVavDpcO0038IoQaGV612+d02yO32vawvYgZFNK3jtYr0w==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, u-boot-qcom@groups.io
Subject: [PATCH v2 4/7] ufs: amd-versal2: Fix indent
Date: Tue, 28 Oct 2025 15:22:24 +0100
Message-ID: <20251028142335.18125-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251028142335.18125-1-marek.vasut+renesas@mailbox.org>
References: <20251028142335.18125-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 737783d46f2314054ce
X-MBO-RS-META: 5zojq9pbu3o9d1fui4tueuoccc6jwbre
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

Fix indent, use tabs. No functional change.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>
Cc: Casey Connolly <casey.connolly@linaro.org>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Neha Malcom Francis <n-francis@ti.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Sumit Garg <sumit.garg@kernel.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Tuyen Dang <tuyen.dang.xa@renesas.com>
Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: u-boot-qcom@groups.io
Cc: u-boot@lists.denx.de
---
V2: Add RB from Neil
---
 drivers/ufs/ufs-amd-versal2.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/ufs/ufs-amd-versal2.c b/drivers/ufs/ufs-amd-versal2.c
index 896dda2de4e..89931921ff9 100644
--- a/drivers/ufs/ufs-amd-versal2.c
+++ b/drivers/ufs/ufs-amd-versal2.c
@@ -330,7 +330,7 @@ static int ufs_versal2_init(struct ufs_hba *hba)
 		return PTR_ERR(priv->rstphy);
 	}
 
-	ret =  zynqmp_pm_ufs_cal_reg(&cal);
+	ret = zynqmp_pm_ufs_cal_reg(&cal);
 	if (ret)
 		return ret;
 
@@ -567,9 +567,9 @@ static const struct udevice_id ufs_versal2_ids[] = {
 };
 
 U_BOOT_DRIVER(ufs_versal2_pltfm) = {
-	.name           = "ufs-versal2-pltfm",
-	.id             = UCLASS_UFS,
-	.of_match       = ufs_versal2_ids,
-	.probe          = ufs_versal2_probe,
-	.bind           = ufs_versal2_bind,
+	.name		= "ufs-versal2-pltfm",
+	.id		= UCLASS_UFS,
+	.of_match	= ufs_versal2_ids,
+	.probe		= ufs_versal2_probe,
+	.bind		= ufs_versal2_bind,
 };
-- 
2.51.0

