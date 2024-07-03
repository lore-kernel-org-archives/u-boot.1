Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 674BBC2BD09
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 13:43:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2DA88882C;
	Wed,  3 Jul 2024 15:42:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="bEkV0GDr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 484AB88826; Wed,  3 Jul 2024 15:42:51 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66F3988818
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 15:42:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=B.Hahn@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1720014169; x=1722606169;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=skNcbTWXtiHN2KaudjZjm3W4Q68l5mwj+dd1eWQF0TI=;
 b=bEkV0GDrWrZNqfs9yI382X2UcCQKXufnT9SwSAPskrP8/G0jeUNWeiEgu97XEaIe
 Xwkn5DUvI4YvCG7BNyK0WXUXSy6RShCNpmh/uUsvE6f4UNR+ZBtGJ13CuAxVXZhb
 gkD5P6S6q75HiQmal18/0BJgMfS+J3hvEIs++cqnpxQ=;
X-AuditID: ac14000a-03e52700000021bc-20-66855559e0a6
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id DF.61.08636.95555866;
 Wed,  3 Jul 2024 15:42:49 +0200 (CEST)
Received: from llp-hahn.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 3 Jul 2024
 15:42:48 +0200
From: Benjamin Hahn <B.Hahn@phytec.de>
Date: Wed, 3 Jul 2024 15:42:39 +0200
Subject: [PATCH] configs: phycore-imx8mp: Disable CONFIG_ANDROID_BOOT_IMAGE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240703-wip-bhahn-disable_config_android_boot_image-v1-1-d584437da4ff@phytec.de>
X-B4-Tracking: v=1; b=H4sIAE5VhWYC/x2N0QrCMAwAf2Xk2ULWiqK/IlLSNVsDmoxWVBj7d
 4uP93B3GzSuwg2uwwaV39LEtMN4GGAqpAs7yZ3Boz/iGYP7yOpSoaIuS6P04DiZzrJE0lxNckx
 mryhP6mrwJya8+JEwQC+ulWf5/m+3+77/AIedq/19AAAA
To: Teresa Remmet <t.remmet@phytec.de>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, Benjamin Hahn
 <B.Hahn@phytec.de>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720014168; l=890;
 i=B.Hahn@phytec.de; s=20240126; h=from:subject:message-id;
 bh=skNcbTWXtiHN2KaudjZjm3W4Q68l5mwj+dd1eWQF0TI=;
 b=/50OeviFUKgOnTQXZUGI4S/tFEJvPNOv83gthVqgECn2gaqhTHo/XE8v1ZhVoCWO7UTqqhL2+
 /KOv0X3CoptDDhjiWnfviRBXvVLfPxr+dlZIzh3DXfpwLyyIw7+4jQX
X-Developer-Key: i=B.Hahn@phytec.de; a=ed25519;
 pk=r04clMulHz6S6js6elPBA+U+zVdDAqJyEyoNd8I3pSw=
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCLMWRmVeSWpSXmKPExsWyRpKBRzcytDXN4PlrNouHV/0tpk7azG7x
 dm8nu0X3O3UHFo+ds+6ye7w6sIrd4+ydHYwe/d0trAEsUVw2Kak5mWWpRfp2CVwZZxY+Yiz4
 w1Zx7PEnlgbGiWxdjJwcEgImEtsfzGbvYuTiEBJYwiRx+PocRgjnAaNEw/4tLCBVbAJqErve
 vGbtYuTgYBFQkdh/1AjEFBbwlmj6YA9SwSsgKHFy5hMWkDCzgKbE+l36IGFmAXmJ7W/nMEOU
 xEk03+pmA5kuIXCCUeL8xZ+MIPUiAtkST9YbQbRGSbybGARiSggIS2zaqQVRvYtJYnHvbFaI
 eKLEztdyIBOFBGQlbp7fAvWIvMS0c6+ZIexQia1ftjNNYBSeheS2WQi3zUJy2wJG5lWMQrmZ
 ydmpRZnZegUZlSWpyXopqZsYQSEvwsC1g7FvjschRiYOxkOMEhzMSiK8Uu+b04R4UxIrq1KL
 8uOLSnNSiw8xSnOwKInzru4IThUSSE8sSc1OTS1ILYLJMnFwSjUwrks7zGlq6/1gQlx+RJl8
 5ZnTl85ISBxo0Tes+PDGYB4fpwAf3/2ig+vYHdp3CsebBPI/4d4WdUv0v3OzS9aMg1ODZddk
 naq8nxth2bWraD2L08yzN727rma1Z98LzbmcfYBL9PWia8xzpPOsoleoNR2rYe38FG48b/W7
 lv2ZizgDDYq0Tl5VYinOSDTUYi4qTgQAI9/w1GcCAAA=
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

CONFIG_ANDROID_BOOT_IMAGE gets enabled implicitly by FASTBOOT, but we
don't need that feature.

Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
---
 configs/phycore-imx8mp_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/phycore-imx8mp_defconfig b/configs/phycore-imx8mp_defconfig
index 57e320af6030..280ebc9237ee 100644
--- a/configs/phycore-imx8mp_defconfig
+++ b/configs/phycore-imx8mp_defconfig
@@ -25,6 +25,7 @@ CONFIG_SPL=y
 CONFIG_ENV_OFFSET_REDUND=0x3e0000
 CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x48000000
 CONFIG_SYS_LOAD_ADDR=0x40480000
+# CONFIG_ANDROID_BOOT_IMAGE is not set
 CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y

---
base-commit: 65fbdab27224ee3943a89496b21862db83c34da2
change-id: 20240703-wip-bhahn-disable_config_android_boot_image-326ea0921a03

Best regards,
-- 
Benjamin Hahn <B.Hahn@phytec.de>

