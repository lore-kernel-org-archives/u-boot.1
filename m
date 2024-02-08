Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D8BC48260
	for <u-boot@archiver.kernel.org>; Fri,  9 Feb 2024 00:00:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6EF087873;
	Fri,  9 Feb 2024 01:00:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1707436823;
	bh=u2ikxEUKx29OkgXBgelqDg3m42C+73UOv/AWryGgVgE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=j+stuwHgxK6LlXg7+3AHljZ3yOyXfRMo/BTJzbX3Fc2UoNCcbb6LuPdbwxfHo8tfn
	 cmmnMptmwP+qsNa/uiH1FkNzsXYNDYtxmNahdYYJ22coP/cF2rcU9DzrDUfjPsE97p
	 oWK63yhulKqzIta+rdSfnqwOdVfrx1XGvzrAweoazjbhTPzA7B2viavvYH29gtj3EA
	 keP3QofnXMJUDVSPPJhVL33jyj2oIu1kghfLbavo6xmxXI7OB+YBscUCcyVuooKvEt
	 GbSc8cwtEQJ8veHGheItEsa1M2QQUrjN4X0pSKestvgxgo5FFwaBJxRBR7lVUq51As
	 ZqI5GWsT4aI2g==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 5118E8709C;
 Fri,  9 Feb 2024 01:00:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1707436821;
 bh=u2ikxEUKx29OkgXBgelqDg3m42C+73UOv/AWryGgVgE=;
 h=From:To:Cc:Subject:Date:From;
 b=I4Ey29XunoE7gKo/HF0w5STTrjkhwMd1fibrVOkoOCuYVaLT4zruwA7l++s6bF324
 HSlen/oaPAQBhSxTP584E+3Rsw7RogjAnlYEz0Qz5FU2vDuJt9pfq4PZbKr6KU/1dC
 j1Vjt6KOYkim92foOzevTT5XDIrYwogx05v7j5hW6khhDVVIHuYow86E6WfohKE6Kw
 AX38KwotrjCPfsJ2iZyRFlbpozVWymGqmjplwLAhrps4eLzc6e23nEul9kMSgI2Wpf
 c4m7bZ65VKhpIKD1WCafHJ2ZG4gSw2NT8/gXllzSQV8SAGquYuVCAVQjTuwI8oYm0N
 bEc2MOatICpNA==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Stefano Babic <sbabic@denx.de>
Subject: [PATCH v2] spi: mxc_spi: Add imx6ul-ecspi compatible string
Date: Fri,  9 Feb 2024 00:59:50 +0100
Message-ID: <20240209000012.455355-1-marex@denx.de>
X-Mailer: git-send-email 2.43.0
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

Recent i.MX8MP DTs use new fsl,imx6ul-ecspi compatible string instead
of the fsl,imx51-ecspi compatible string. Add the new compatible string
to fix ECSPI operation on i.MX8MP.

For details, see Linux:
48d74376fb68 ("arm64: dts: imx8mp: update ecspi compatible and clk")
8eb1252bbedf ("spi: imx: remove ERR009165 workaround on i.mx6ul")

Fixes: 451799a6ceac ("arm: dts: imx8mp: Sync the DT with kernel 6.4-rc4")
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>
Cc: Stefano Babic <sbabic@denx.de>
---
V2: - Update commit message
      - Specify kernel commit where this got introduced
      - Add Fixes tag
---
 drivers/spi/mxc_spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/mxc_spi.c b/drivers/spi/mxc_spi.c
index 33360a18329..e291092c481 100644
--- a/drivers/spi/mxc_spi.c
+++ b/drivers/spi/mxc_spi.c
@@ -670,6 +670,7 @@ static const struct dm_spi_ops mxc_spi_ops = {
 
 static const struct udevice_id mxc_spi_ids[] = {
 	{ .compatible = "fsl,imx51-ecspi" },
+	{ .compatible = "fsl,imx6ul-ecspi" },
 	{ }
 };
 
-- 
2.43.0

