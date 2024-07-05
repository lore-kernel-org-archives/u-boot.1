Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C57C30658
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 14:26:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FFAA889AE;
	Fri,  5 Jul 2024 16:25:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=tq-group.com header.i=@tq-group.com header.b="ZgZXgsi6";
	dkim=fail reason="key not found in DNS" (0-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="XqWl3TPK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2AC88898E; Fri,  5 Jul 2024 15:27:30 +0200 (CEST)
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F2198861A
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 15:27:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.stein@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
 t=1720186048; x=1751722048;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=NAQ/YXrEAg/SuakVmkKgqfQBM+4AHQ22wrCvOuWydWo=;
 b=ZgZXgsi6ODQNISetM7HrX/0FuvRKfHo+kgty8jWbjRxlY5GsSlPXtfni
 LtOb980OPdNGpy6ROM+d3utEm37QTPjvICwPhmhMjXIIfQHtcxdomiH8V
 UPv0MzTdw4brSZ1iELYu/YzB3SXiKbd8y/FZ83+1pImc9pbOdJTC0inoE
 MhV8bqMjH5CO+wqAxsFpvgOmxGISBgxKYsgED4iB4k51E/sKMOd8lkCGE
 faqPVyYEY+bMnFU+YAayl8JmBOjlNghgerVS1HCMDYw3A+2s3sHst/fcP
 8FvqnxI8bX7kb9Yzoaokb3hgF4xU5mzqGG+Mhy5ZKbcP6HzInPf2o4CC2 g==;
X-CSE-ConnectionGUID: dtp26JWWTj26iVTmtdBEVQ==
X-CSE-MsgGUID: 11vCrSA3S2Cr/QozrFmQEA==
X-IronPort-AV: E=Sophos;i="6.09,184,1716242400"; d="scan'208";a="37770480"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
 by mx1.tq-group.com with ESMTP; 05 Jul 2024 15:27:27 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 86E34163D7D; Fri,  5 Jul 2024 15:27:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
 s=dkim; t=1720186043; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=NAQ/YXrEAg/SuakVmkKgqfQBM+4AHQ22wrCvOuWydWo=;
 b=XqWl3TPKFpkqYBDXupnSUaaDZfobkDX1m55PISu/97AXAKIae/n9TA5BN22+TaHPCnTyxL
 il8SS4DOOfhvWU3QInR6X1xe0kgSBxba6sE2pMTLG1wL/92/zh7YR+DcHpELaBFxibL4ni
 2mYeCo1JpRt8VofIvjLhzlsKhxq9o4h52KjzWX4hQhR+KboATKbEq62YO8BSmaTU0+ZxFi
 QtHB1pWPvelpMsRUud7lT9s3C3jqxkvK9mrvPoDZPFZHLIlDQjpma0t3bfRQGSOedBi4Yr
 oCRkXxTpTwuoDUJIBZVrls1SjtYfYVEpk21npIM6U2XsCaQ5qWGMg4L8Z0wz6g==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Tom Rini <trini@konsulko.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	u-boot@lists.denx.de
Subject: [PATCH 1/1] mmc: fsl_esdhc_imx: Fix error message
Date: Fri,  5 Jul 2024 15:27:24 +0200
Message-Id: <20240705132724.2865958-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Fri, 05 Jul 2024 16:25:29 +0200
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

Add missing newline character and also add the return code of
regulator_set_value() to the output.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/mmc/fsl_esdhc_imx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/fsl_esdhc_imx.c b/drivers/mmc/fsl_esdhc_imx.c
index a9b8d7dd67f..03de7dcd505 100644
--- a/drivers/mmc/fsl_esdhc_imx.c
+++ b/drivers/mmc/fsl_esdhc_imx.c
@@ -766,7 +766,7 @@ static int esdhc_set_voltage(struct mmc *mmc)
 			ret = regulator_set_value(priv->vqmmc_dev,
 						  3300000);
 			if (ret) {
-				printf("Setting to 3.3V error");
+				printf("Setting to 3.3V error: %d\n", ret);
 				return -EIO;
 			}
 			mdelay(5);
@@ -784,7 +784,7 @@ static int esdhc_set_voltage(struct mmc *mmc)
 			ret = regulator_set_value(priv->vqmmc_dev,
 						  1800000);
 			if (ret) {
-				printf("Setting to 1.8V error");
+				printf("Setting to 1.8V error: %d\n", ret);
 				return -EIO;
 			}
 		}
-- 
2.34.1

