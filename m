Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0885D0D171
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 20:28:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA9F1840CB;
	Wed,  7 Jan 2026 21:28:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="qZhkYNRO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4C75840CB; Wed,  7 Jan 2026 21:28:23 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70F1A83B21
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 21:28:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+david.ixit.cz@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A5FBB43224;
 Wed,  7 Jan 2026 20:28:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B18BC19425;
 Wed,  7 Jan 2026 20:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1767817697;
 bh=4TFE6/tpJkofw5lAQLj/8ijiTNk01r+hunM9CxLJzak=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=qZhkYNRObkGaWzy09j3IzNNjMmtMS/m/rk4Y5PHc9j/fiLfH53eOFMif7EL3D4DCX
 HGxz1muWvwEGbB7uVZRCZh2UV17zO4E+YgYFfmBngU60+cRcExIgwidCKaNHWJFwxt
 048Gs344SKIOsK4n1+f30fPlPcAB6XUxqlHuU7204N8k0esP+CRIKPWctIqeVrITjT
 rMw8IzmrpSKNPg8mU2ua02nzbC5zLkTOCAo0DBR/AlsRMzxr8UTdXY0bA6vAtdZEsz
 0NUYfMlqhUtco94uohXW19e9Y4iYjY+O7MTNewkZTBhASAiQgoHhYoKw4s5RowmiXX
 fFwDuVYIqF5uQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 74305D0D171;
 Wed,  7 Jan 2026 20:28:17 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Wed, 07 Jan 2026 21:28:15 +0100
Subject: [PATCH v3 1/2] doc: board: qualcomm: document Pixel 3 / 3 XL support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-pixel-config-v3-1-02a25e3fdcfa@ixit.cz>
References: <20260107-pixel-config-v3-0-02a25e3fdcfa@ixit.cz>
In-Reply-To: <20260107-pixel-config-v3-0-02a25e3fdcfa@ixit.cz>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de, Petr Vorel <petr.vorel@gmail.com>
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Luca Weiss <luca.weiss@fairphone.com>, Simon Glass <sjg@chromium.org>, 
 Petr Hodina <petr.hodina@protonmail.com>, 
 Matthew Croughan <matt@croughan.sh>, phone-devel@vger.kernel.org, 
 David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1561; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=tR/yDcGYe9KsmThFZVe68c8YKtFLwect8VpgVOCqg3g=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBpXsHgrGbQl1CKKnlCPl9/w8vSdapSI0bgUT92Y
 YkGVkR/pT+JAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCaV7B4AAKCRBgAj/E00kg
 csDCEACdzHGycxGA/+CFDj/RO2QxjSgtZWDoz1U0Pdq2WCwLzeuGMZDr3/g/Lv3p+V90sgbnqk+
 2TUZPGIhJcjXyfrCyqp4JQ4PbBDZTGOr38qwYbs/dfKN32JTGe5rX5+5EaJOMQJ5TU8VP+HwBki
 r2G8hEe9n6lEe2inIMkI8/igivB91P6KyZG/9IPHv6IoGE34caaMBG7a/fJJw01CmMyPcpp/2jV
 a3Yigoveorjz0VIJFYim/mE4tysM2OPrMntqOkDuf3WQfOyGkiXy24padsO/qocUIy2FZOJen4v
 xPoJcY2rNXXTM8BA1t5rYj4H3ldtDYFTm5qp99H/cR+fL5hkUJ1B9F2xN08cyN50eXhMW04VCjN
 bd/6W+jjOrmqVpoVSuQIgSXP9qybfPGwdxlG8hB68cba2KPL140ZPHrjlb+9U0qjbQrYB7vNJpW
 d1GasNklvSVQ0cla6CmOHDmV7PKjm3Mu/ByowxshTt4kLxMEcqeANIP0kY+BGlcJBHlQR398Xa8
 jt25OteAUYiEc0zel9/9gYj+3ygVO20+MlD2xqT3lG2bDCpm2XCRAtKISA9iLH9+02du+HHRSt9
 zlyquMVwoqgnT4S+SaGadHIHSWClgUEcS0HFeHFU8BnRRQd+Gl2tEiM2lSLAaUs9mo69ULn8TPq
 rSrUaJUTDhTKtXg==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
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
Reply-To: david@ixit.cz
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: David Heidelberg <david@ixit.cz>

U-Boot does work on Qualcomm 845-based Pixel 3 and 3 XL.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 doc/board/qualcomm/board.rst | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/doc/board/qualcomm/board.rst b/doc/board/qualcomm/board.rst
index 642c5095261..e5dbc9816b9 100644
--- a/doc/board/qualcomm/board.rst
+++ b/doc/board/qualcomm/board.rst
@@ -38,6 +38,25 @@ with appended dtb, so let's mimic linux to satisfy stock bootloader.
 Boards
 ------
 
+Pixel 3 (blueline) and Pixel 3 XL (crosshatch)
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+blueline refers to the Google Pixel 3, and crosshatch to the Pixel 3 XL, both
+powered by the Qualcomm SDM845 SoC.
+
+These devices use the common qcom_defconfig with the google-pixel.config
+fragment for configuration.
+
+Use the following commands::
+
+	make CROSS_COMPILE=aarch64-linux-gnu- O=.output qcom_defconfig google-pixel.config qcom-phone.config
+
+The DTB is called:
+
+ - "sdm845-google-blueline.dtb" (Pixel 3)
+ - "sdm845-google-crosshatch.dtb" (Pixel 3 XL)
+
+More information can be found on the `Google Pixel 3 page`_.
+
 starqlte
 ^^^^^^^^
 
@@ -131,5 +150,6 @@ Other devices with boot image version 2 can be built like this example::
 	fastboot flash boot boot.img
 	fastboot erase dtbo
 
+.. _Google Pixel 3 page: https://en.wikipedia.org/wiki/Pixel_3
 .. _Samsung S9 page: https://en.wikipedia.org/wiki/Samsung_Galaxy_S9
 .. _DragonBoard 845c page: https://www.96boards.org/product/rb3-platform/

-- 
2.51.0


