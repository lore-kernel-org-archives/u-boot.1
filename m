Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38DBDC48BC4
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 10:42:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D658E87D94;
	Tue, 20 Feb 2024 11:42:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="CpHWhGJ1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F4D4879FE; Tue, 20 Feb 2024 11:42:22 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 927F187F52
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 11:42:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=B.Hahn@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1708425727; x=1711017727;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fzffMOtwCqYzBQGmCXit5LVLIx5L6B8TWkFYw7c61mY=;
 b=CpHWhGJ1pDxe6ShcRzY0ayZmDtqJih7WdSjTT44lYtYS1MYpTocfj10pqipSBwXH
 JN32IUJdVbvBKz7B74kPg2g3mDVRx4zsu2Hcl9oO6NFr3TIVIqfhQhocEeGLTNtX
 aXuciIB4/dqy1bonpTMaTkV4gW9WGab+0QCc2nM4UMc=;
X-AuditID: ac14000a-fadff7000000290d-8c-65d481ffabbf
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 66.CF.10509.FF184D56;
 Tue, 20 Feb 2024 11:42:07 +0100 (CET)
Received: from llp-hahn.hahn.test (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 20 Feb
 2024 11:42:06 +0100
From: Benjamin Hahn <B.Hahn@phytec.de>
Date: Tue, 20 Feb 2024 11:41:44 +0100
Subject: [PATCH 2/3] phycore-imx8mm_defconfig: Enable CONFIG_IMX_TMU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240220-thermal-support-v1-2-f6a97d8d6481@phytec.de>
References: <20240220-thermal-support-v1-0-f6a97d8d6481@phytec.de>
In-Reply-To: <20240220-thermal-support-v1-0-f6a97d8d6481@phytec.de>
To: Teresa Remmet <t.remmet@phytec.de>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, Benjamin Hahn
 <B.Hahn@phytec.de>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708425726; l=591;
 i=B.Hahn@phytec.de; s=20240126; h=from:subject:message-id;
 bh=fzffMOtwCqYzBQGmCXit5LVLIx5L6B8TWkFYw7c61mY=;
 b=ZvJsaP77lmJyfsLfOmDIgpHrFF+4D7cSz8VAvcNRViDQA43hIfBn3pIr0FSxDqlqF1RKVxIms
 s+v8wn2a1oyDom+XYYARA6JTXCgAGGJ/kOacKjqvnw2eNLU4kMkI9NM
X-Developer-Key: i=B.Hahn@phytec.de; a=ed25519;
 pk=r04clMulHz6S6js6elPBA+U+zVdDAqJyEyoNd8I3pSw=
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGLMWRmVeSWpSXmKPExsWyRpKBR/d/45VUgx+LWC2mTtrMbvF2bye7
 Rfc7dQdmj1cHVrF7nL2zg9Gjv7uFNYA5issmJTUnsyy1SN8ugSujr+sHY8FFloojtw0bGP8y
 dzFyckgImEhsW32AsYuRi0NIYDGTxPZvPewQzkNGia6b35lAqtgE1CR2vXnNCmKzCKhK9DzZ
 zwhiCwu4SFw6MZ8NxOYVEJQ4OfMJSxcjBwezgKbE+l36IGFmAXmJ7W/nMIOEeQWcJPqeyoKE
 hYDMxb3/wW7gFHCW6H+2BKxTRMBV4ukeQ4ghURLvJgaBmBICwhKbdmqB3CUhsItJ4l/TH2aI
 eKLEztdyEANlJW6e38IG8ZS8xLRzr6EeDJU4smk10wRGkVlIrpyFcOUsJFcuYGRexSiUm5mc
 nVqUma1XkFFZkpqsl5K6iREU9iIMXDsY++Z4HGJk4mA8xCjBwawkwstSfiVViDclsbIqtSg/
 vqg0J7X4EKM0B4uSOO/qjuBUIYH0xJLU7NTUgtQimCwTB6dUAyOz8bbdKUxLZ7KF2/d3xG2t
 Pbd+dtDE94uYZmjbcRhz+zPxJIsqdMUdWbK7x8H5pUuKzvfEF5PZ7bf2rLELP6Ii+vzOs9e7
 ju59XaWi/qR15YbjdqpvWv+c+Me9i3/upT+P62J29z78+eefik5F0mWzlzyPbS8krBWNL/gf
 tsJYM329YO2izGlKLMUZiYZazEXFiQCOiSnRaQIAAA==
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

Enable the imx thermal driver to prevent booting when the system is too
hot.

Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
---
 configs/phycore-imx8mm_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/phycore-imx8mm_defconfig b/configs/phycore-imx8mm_defconfig
index bcc38d51a7b9..3a81ea7bd23d 100644
--- a/configs/phycore-imx8mm_defconfig
+++ b/configs/phycore-imx8mm_defconfig
@@ -128,4 +128,5 @@ CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
 CONFIG_DM_THERMAL=y
+CONFIG_IMX_TMU=y
 CONFIG_IMX_WATCHDOG=y

-- 
2.34.1

