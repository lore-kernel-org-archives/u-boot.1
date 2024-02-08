Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B99E8C4828F
	for <u-boot@archiver.kernel.org>; Thu,  8 Feb 2024 17:33:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B1C287CDB;
	Thu,  8 Feb 2024 18:33:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1707413605;
	bh=DzV8kOJBWF4iMUJ6kkNOS1V12P6BsvGvgJgGcfh6O3g=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=hMny01YTJP+dIkbHkhxwM50c3VcF7T4SkvWRJa7tDc+/K7Rp2zWptN08OgOfRYIBq
	 +gPxB7iljDk0OsaI24hN2ZAKde9aGw9iBzsn8wLTAeLtJgQdP9BuCPuTZApZhhCp5/
	 aMjB75x5uCpTPI1WZqYYCAOeH/qLDxYjQsxJceRG0KifUY5Ta8oHY6AsFN+EjcwLjX
	 fN3PK7llbTpjkBF+Tx0WXW1/nC8HgC5UdWvVs1Wyx2h5CUDCEhjBCR3HKDnwIsq+Rt
	 Oz85773XIimddmYVhkqjHj3Su7QUTktfFd3iu6zQIixJjsB5K3Z8fiy0vdA609orW9
	 HvYYLGprVmm6A==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id C673987CCF;
 Thu,  8 Feb 2024 18:33:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1707413603;
 bh=DzV8kOJBWF4iMUJ6kkNOS1V12P6BsvGvgJgGcfh6O3g=;
 h=From:To:Cc:Subject:Date:From;
 b=lanIrmS1jLPMzfwCqIcg5zMvRg1gnFnGmCSTgExSLIQJB08MRuDrXxFKwMACyV/lR
 4LMw1ko3cDSv2kdO0dHdXQkZ5CFKvTUp9OplV9dyteySsqaYGrmx1N0x3ItQQtAjuA
 C5wZjEU4mtB5uzHzvxWn9teRGg36DZRHv6oQWzBykTNMqlX51b+Ilu8/j25XjoxvM2
 uwjkdopa4in3723OG9fGB55eenRPQDnic0jjnALBZSCtrYtEfu7D5v1YrlX5n+jp/n
 aEtD2RQohrpbl3PjF+LaF8LSosdFMqH8H9wW4VHKuIOUvjpndXpLA62ixg32iZAkUf
 sVQPP6+K++Stw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Stefano Babic <sbabic@denx.de>
Subject: [PATCH] spi: mxc_spi: Add imx6ul-ecspi compatible string
Date: Thu,  8 Feb 2024 18:32:56 +0100
Message-ID: <20240208173314.397582-1-marex@denx.de>
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

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>
Cc: Stefano Babic <sbabic@denx.de>
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

