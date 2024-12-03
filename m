Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE0DDE74AD6
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 20:57:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F43B89534;
	Tue,  3 Dec 2024 21:57:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="av4o5+/b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8740089534; Tue,  3 Dec 2024 21:57:45 +0100 (CET)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8360489662
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 21:57:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 4A0D4A40C4F;
 Tue,  3 Dec 2024 20:55:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C426C4CECF;
 Tue,  3 Dec 2024 20:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1733259462;
 bh=Xqk/BqHln+FZYvFZeoovpaqzJvda0u2XbYEVg57+fzo=;
 h=From:Date:Subject:To:Cc:From;
 b=av4o5+/b7fNpBI9uyyIkTN7tCCA99uc5ibSUfwEuhivjL5h77RwiqGbgus99mn1br
 XStOAtp8t9Uy56vd8QqQnGuOLZLCyaGWiz86B9+R8p+M4hl/iV2orX1Xik9iyOXN3e
 P80SrGx7KJG1v0azeXRAppd2FsAgFjCxG0wAlYklHWmH9A7BUHrZkSE9J8S16kreXO
 10VBRk52VsKv5domJT63THnAUAqFLJ1pgQjMcnOHLBjKTK2r7ho5o6ynJwdst4+ojb
 L9rzJduD/TkEOuTApKJOMt150KhZRgJTZqGukh/Eh/FI+suKADR2bXHeUVBfsVscUQ
 byzWE73DcFUPw==
From: Roger Quadros <rogerq@kernel.org>
Date: Tue, 03 Dec 2024 22:57:36 +0200
Subject: [PATCH] phy: don't spam console if phys property is absent in
 device node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-nophys-v1-1-a5fdbccd2af9@kernel.org>
X-B4-Tracking: v=1; b=H4sIAL9wT2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDIwNj3bz8gozKYl2DJFNjyxRDC+NEQzMloOKCotS0zAqwQdGxtbUA3Ul
 1eVgAAAA=
To: Tom Rini <trini@konsulko.com>, vigneshr@ti.com, nm@ti.com
Cc: j-humphreys@ti.com, srk@ti.com, s-vadapalli@ti.com, 
 u-boot@lists.denx.de, Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1003; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=Xqk/BqHln+FZYvFZeoovpaqzJvda0u2XbYEVg57+fzo=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBnT3DDIGoBjFpRsOnHhvHt/wjjDNuabxGZkmA1b
 8/Ji5Q/SNSJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZ09wwwAKCRDSWmvTvnYw
 k6eyD/9e8nTh9yXUewU4drpA5btzCpu9h3o2aNWHjgseVB7butFSOEDRFIpgeKZeL5WyC9JOLK9
 0hU4mCSsAZLcOhjfBe0tiARMHwgkNBxHHgqF8CnXWE48knqI8o+Mm2R2baK9HNCsbROo7/EId83
 PCuaLUVX2v92sGeXLOdmSv2RLg1ps7xUMksks6ujNPy8AZQVZLJY1MsglmcPQ0BNNl7KVm1TIgJ
 3PCOrSgJ2TfGN7GR3wJWFieos9y4ElJI4qa4f2HVYR1tJH3chaAIjmolJvSy1Gic5zSrgRWeg4j
 i0UQMQqILFIXssu/adiHS0nv3kRH95Ce3Zo+cH+WkZT7dnsva+sESYx7/4uZVYGFJJcpNN/0PZX
 IQ5d/+WVafK7JfbjlN4AzTselH/52ebCyj76+cNtdBHpqifxiWZ2Hc7pmxBMeRddb5C2u9s3i94
 DK7ROvviRaXEEE+FlODfryocfRVnNbDPKxhuwDVDB+ziNxTBaYbnNIyInxuEmsugfhZt23JTy1J
 LEdFI1fA68yVr02lv6hL2z9O/k3u7kSuAXRmKPWzefboKdy+kLi+rmNPVKKlh4PX698hjOk2EdZ
 X9wM6O0VdhclWJcrF2Z23xkta9BKWNPbWrP4VR3AiaIRhVWkA7CpDiqrpGRzVIWsUv1u+rrA1gd
 uDwni+56U8O5ChA==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093
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

In generic_phy_get_bulk(), if 'phys' property is absent in
the device node then it is not an error condition.

Change print message verbosity to debug to avoid spamming
console in such cases.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/phy/phy-uclass.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/phy-uclass.c b/drivers/phy/phy-uclass.c
index 777d952b041..714be123856 100644
--- a/drivers/phy/phy-uclass.c
+++ b/drivers/phy/phy-uclass.c
@@ -415,7 +415,7 @@ int generic_phy_get_bulk(struct udevice *dev, struct phy_bulk *bulk)
 	if (!dev_read_prop(dev, "phys", NULL)) {
 		phydev = dev->parent;
 		if (!dev_read_prop(phydev, "phys", NULL)) {
-			pr_err("%s : no phys property\n", __func__);
+			pr_debug("%s : no phys property\n", __func__);
 			return 0;
 		}
 	}

---
base-commit: 3073246d1be682071d8b3d07d06c2484907aed60
change-id: 20241203-nophys-0b539d183a16

Best regards,
-- 
Roger Quadros <rogerq@kernel.org>

