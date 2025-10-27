Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB63CCF9E0
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 17:07:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4FED83942;
	Mon, 27 Oct 2025 18:07:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="JkgD/+3X";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="R9xja9tU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7346839B1; Mon, 27 Oct 2025 18:07:25 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6CD98393D
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 18:07:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cwKgb4g4Nz9v4J;
 Mon, 27 Oct 2025 18:07:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761584843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4sj0/ZGsvxdv8BOoSyrqsHVdQzRawZXPzHAnggbvVK4=;
 b=JkgD/+3Xjbn9G6mxFmK3RhQ8wh61d7I3neRSl8NWrXbr5u4fzlDFasJLCdUh7EDMbNtdUg
 m0ZOwDpvtcUGb6w8GTcuNja4017sR6/i8lPyHepiNp0tu+GLiDuWvaDSE7RlgYRmpb4epS
 HKOaNF2YS6OlVRYaCWOuDFswbkGsHOo2OT2yCEsJ1roNHScirOhVyhpHNtkI66J7v5DTl8
 JkyW/n7po+haSW4XMHrtUu29io0GvRhUQrHmHXgOsTz5dYYltTAybufgdDOfWbLz37P60A
 mIlNXIFdBpPXd+CvYUBjEPS02QdK9Z07CwZhLTdxv+kd3zo5V7nilTBGbMb6rQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761584841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4sj0/ZGsvxdv8BOoSyrqsHVdQzRawZXPzHAnggbvVK4=;
 b=R9xja9tU09c9vnzpHqZ7wY7ATohERZ6+yZOK9RlEBCJjWUwdy6kkmvPBWEJmntGv/bc+zY
 hVdyLq1nMsQ2CUnlNgs5eQ0Uzn853TzPQoWa8ojf/FGvgPMrAb/WJDX22p5KwIwGlknGio
 mI0IpgvDGYkuiv+yNI8SUNkj5MDlv8pmTVUggdZa7eTaswRJrWeNSQzmbFlNL5pkuW7mMn
 f6ZJuIC9kwTYZpOMqC4MkOR9XhIB3FEgerlXLesC5/WMm9OvY4arMwfZP5O3JOF5M2HRg6
 pplsUKVFza1yfWzdjpPr6qKwD9gWQekD0nExUeHa1CqxbIFZlAtFe6d44GxKZA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, u-boot-qcom@groups.io
Subject: [PATCH 3/6] ufs: amd-versal2: Fix indent
Date: Mon, 27 Oct 2025 18:06:24 +0100
Message-ID: <20251027170706.29302-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251027170706.29302-1-marek.vasut+renesas@mailbox.org>
References: <20251027170706.29302-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 9bd9e896866c8c8769b
X-MBO-RS-META: j98pow6y6eawwcrnoenjoau4hcw46q9s
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

