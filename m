Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDFF7EE49B2
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 22:17:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8A8D867C3;
	Fri,  1 Sep 2023 00:16:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.b="XYBgCNHa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC788866DA; Fri,  1 Sep 2023 00:16:41 +0200 (CEST)
Received: from s.wrqvwxzv.outbound-mail.sendgrid.net
 (s.wrqvwxzv.outbound-mail.sendgrid.net [149.72.154.232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08B4786680
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 00:16:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=bounces+31435339-7456-u-boot=lists.denx.de@em2124.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=from:subject:in-reply-to:references:mime-version:to:cc:
 content-transfer-encoding:content-type:cc:content-type:from:subject:to;
 s=s1; bh=f8iSGl9Mq/SMKQJywosgipuAmjLKo1uP1b1FIxQ+p/c=;
 b=XYBgCNHaBouvXAGOE7JfIFVOIkce+AV3V9qhtMXYmOesIeFKOmQR9jaqF5skFtnQHQ7c
 M1acpuf8GHP+XJ16tFDQPhBfmVpMg5pUeRbOsFnR/+DIl/LHaj6eEc6KFgsHlmeBtBXDVj
 0mhvpufg2QqMGGxtOOG2qFC83S46khlch6yOIHs3XX/ZSW0czqeJRafJSbSEYxy5FITX0M
 17HvW7bftpazXWbhTm9wTCKZsQkXUens4OoIOgvvITLWDJXI/c/iipUkzPRXMuXJj8G3c5
 c5JB4mwnpo5LxN6TKYPONpUE26kcJ3dCUf8MR8K4+JC3Q9dBch2OXMz3+hJQ4+xA==
Received: by filterdrecv-77869f68cc-4fn5s with SMTP id
 filterdrecv-77869f68cc-4fn5s-1-64F11145-C
 2023-08-31 22:16:37.271762182 +0000 UTC m=+7172154.699490775
Received: from bionic.localdomain (unknown) by geopod-ismtpd-5 (SG) with ESMTP
 id Ff4zoASMSXeGuwAzZMdOKw Thu, 31 Aug 2023 22:16:37.025 +0000 (UTC)
From: Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 4/6] scsi: ceva: Use generic_phy_valid() helper
Date: Thu, 31 Aug 2023 22:16:37 +0000 (UTC)
Message-ID: <20230831221629.1027552-5-jonas@kwiboo.se>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230831221629.1027552-1-jonas@kwiboo.se>
References: <20230831221629.1027552-1-jonas@kwiboo.se>
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h=2FjQ2gfkz8xq60x+4?=
 =?us-ascii?Q?GV1YjaO3Xl0e0ivUmPIF7zSw3XLCXtGffTvDlaf?=
 =?us-ascii?Q?VcNPTBZa9kIuojdQiYu7gDWjMijKSPOxv=2FUtNBl?=
 =?us-ascii?Q?rDHjxgZtyuV6EYekYAha3qgm3d8wqLtNWwBGOhy?=
 =?us-ascii?Q?TYjy+MAmwB8XbePMi8DcwhakBtMTnQhIzy3ld9?=
To: Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
X-Entity-ID: P7KYpSJvGCELWjBME/J5tg==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
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

The documentation for struct phy state that "The content of the
structure is managed solely by the PHY API and PHY drivers".

Change to use the generic_phy_valid() helper to check if phy is valid.

Fixes: f6f5451d469b ("scsi: ceva: Enable PHY and reset support")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/ata/sata_ceva.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/sata_ceva.c b/drivers/ata/sata_ceva.c
index 47366438fdfd..7769d4f99efd 100644
--- a/drivers/ata/sata_ceva.c
+++ b/drivers/ata/sata_ceva.c
@@ -217,7 +217,7 @@ static int sata_ceva_probe(struct udevice *dev)
 		}
 	}
 
-	if (phy.dev) {
+	if (generic_phy_valid(&phy)) {
 		dev_dbg(dev, "Perform PHY power on\n");
 		ret = generic_phy_power_on(&phy);
 		if (ret) {
-- 
2.42.0

