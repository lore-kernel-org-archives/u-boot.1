Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE7AC87FCA
	for <u-boot@archiver.kernel.org>; Sat,  2 Aug 2025 00:14:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAF2A83BE1;
	Sat,  2 Aug 2025 02:14:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=ixit.cz header.i=@ixit.cz header.b="Qy8eV8sD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1105183BD3; Sat,  2 Aug 2025 02:14:04 +0200 (CEST)
Received: from ixit.cz (ip-94-112-25-9.bb.vodafone.cz [94.112.25.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAD0E83B86
 for <u-boot@lists.denx.de>; Sat,  2 Aug 2025 02:14:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ixit.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=david@ixit.cz
Received: from newone.lan (unknown [10.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ixit.cz (Postfix) with ESMTPSA id EAFB7160AAE;
 Sat,  2 Aug 2025 02:14:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
 t=1754093641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=cvSLk8DYHoH4D2a19fnpf6N0H4n2iKWIdWF0EjLmi2M=;
 b=Qy8eV8sD9V+KuJb5MlQHfRl1qUNpZ5ecZdreoMSragH0LbH5BYlRkmZZeV3pojCOqh+Tq+
 CM3xIvb2fL9I8+04bMmRGC7wWCK0/iOwI5HkX6khCxd1XUAyp6oS5Fis4YkpT95Vim8IHO
 cUPYZ+GIHGHyil1coODY2doHw4xZCgU=
From: David Heidelberg <david@ixit.cz>
To: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Luca Weiss <luca.weiss@fairphone.com>, Simon Glass <sjg@chromium.org>,
 David Heidelberg <david@ixit.cz>
Cc: u-boot-qcom@groups.io,
	u-boot@lists.denx.de
Subject: [RFC PATCH v2 1/2] doc: board: qualcomm: document Pixel 3 / 3 XL
 support
Date: Sat,  2 Aug 2025 02:13:56 +0200
Message-ID: <20250802001359.2122103-1-david@ixit.cz>
X-Mailer: git-send-email 2.50.1
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

U-Boot does work on Qualcomm 845-based Pixel 3 and 3 XL.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 doc/board/qualcomm/board.rst | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/doc/board/qualcomm/board.rst b/doc/board/qualcomm/board.rst
index 642c5095261..12ff15f49fc 100644
--- a/doc/board/qualcomm/board.rst
+++ b/doc/board/qualcomm/board.rst
@@ -38,6 +38,31 @@ with appended dtb, so let's mimic linux to satisfy stock bootloader.
 Boards
 ------
 
+blueline
+^^^^^^^^
+The blueline is a Google Pixel 3 phone,
+based on the Qualcomm SDM845 SoC.
+
+This device is supported by the common qcom_defconfig in combination
+with google-pixel3.config config fragment.
+
+The DTB is called "sdm845-google-blueline.dtb"
+
+More information can be found on the `Google Pixel 3 page`_.
+
+crosshatch
+^^^^^^^^^^
+The crosshatch is a Google Pixel 3 XL phone,
+based on the Qualcomm SDM845 SoC.
+
+This device is supported by the common qcom_defconfig in combination
+with google-pixel3.config config fragment.
+
+The DTB is called "sdm845-google-crosshatch.dtb"
+
+More information can be found on the `Google Pixel 3 page`_.
+
+
 starqlte
 ^^^^^^^^
 
@@ -131,5 +156,6 @@ Other devices with boot image version 2 can be built like this example::
 	fastboot flash boot boot.img
 	fastboot erase dtbo
 
+.. _Google Pixel 3 page: https://en.wikipedia.org/wiki/Pixel_3
 .. _Samsung S9 page: https://en.wikipedia.org/wiki/Samsung_Galaxy_S9
 .. _DragonBoard 845c page: https://www.96boards.org/product/rb3-platform/
-- 
2.50.1

