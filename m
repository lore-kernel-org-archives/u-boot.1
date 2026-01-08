Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2755D232C2
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 22:13:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B1FB8415E;
	Thu,  8 Jan 2026 23:13:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Rq5k8Xqz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC860842DB; Thu,  8 Jan 2026 23:13:07 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD9D38415D
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 23:13:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+david.ixit.cz@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id F181D4444D;
 Thu,  8 Jan 2026 22:13:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CCD6CC19424;
 Thu,  8 Jan 2026 22:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1767910382;
 bh=aaJS6O2g0heQM1gZYRRUlRYZDQrHUwH4WyvQBnJ+K7I=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=Rq5k8Xqzt9ctZCN85GUsed3BIznQl81joiry8+L5/jp9MXfbyKmTiIic1wDAZXuXW
 fySyrjG4GVux2IagrFlhk0hMfUqRYPST1iv460XIK/1LRuLfiegna5k3vCMW1Au/yh
 go1R18bdG1bSoVThXydGcn/aYnQLHKq6Ok3v82hM1iP9FOFPdJ/5QsM2C88Jjz/ps+
 ihpUS5mjCJHfY1SbBXas5uiT52UnzAp427tmmvW7VUC+Db+asn4q0f2v6I82P7SvyQ
 xNq8yyTDmRsA8gNLoQ5odGS+MxcXCWL2cqHcSee1padAI+GKx06hWEU/HQyIoPMLGH
 H2uAKAGZu6xEQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id C5875D232C0;
 Thu,  8 Jan 2026 22:13:02 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Thu, 08 Jan 2026 23:13:01 +0100
Subject: [PATCH v4 1/2] doc: board: qualcomm: document Pixel 3 / 3 XL support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-pixel-config-v4-1-76a2212b69a5@ixit.cz>
References: <20260108-pixel-config-v4-0-76a2212b69a5@ixit.cz>
In-Reply-To: <20260108-pixel-config-v4-0-76a2212b69a5@ixit.cz>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de, Petr Vorel <petr.vorel@gmail.com>
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Luca Weiss <luca.weiss@fairphone.com>, Simon Glass <sjg@chromium.org>, 
 Petr Hodina <petr.hodina@protonmail.com>, 
 Matthew Croughan <matt@croughan.sh>, phone-devel@vger.kernel.org, 
 David Heidelberg <david@ixit.cz>, Simon Glass <simon.glass@canonical.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1672; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=hNetKZ+Gddro+OaLlOoaiaAKLTKqtCw0Cv7t5elrvAA=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBpYCvtYbVwQVtX+//qbGMJliHa2ykjFvvx2GxPy
 N+SZitDgTOJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCaWAr7QAKCRBgAj/E00kg
 cuk6D/4wZIi16z6PBPdae34tlgM+74SrAsyIUMD7N+WVNOYVe3DJDXSNCuAa6EbIKEvOlxBJr/d
 xVLk85zYTcvKrwAOXYS9BMITx4gbhukMJgfNdbDsI2F+a/DXt5V8qfPRCe9+G93fuh7/A51LcvF
 7d83wFF/HLcWYEq5FLW/SgCdKK3RrfqoXXlmBb8aTGHGldFocy9wfvJcBDNGXO5VJgHyQQwkleg
 bWA90TLluAPrIcdamZFRZ/XdZ2HGbkrwfPx3tCXCNuNUYce7GebZ2W8ijJiCjVjec5/gL686T11
 gbEzETCuIm0nkUAmw2AUc518lJphaisnY8pXyPf5dWE2/4in6pNKmqEAF09S4VYSJDnuZiu3hvI
 XQjvzgkLTH/DdD9CqoXvsKF8z8j3qlVa/zoqMTsUDOqiVJna3CTzCftHqSGc5UmW0FHhWZqq2GG
 2dWmyjJ6kVvhw+547GWyD2DjB4SJaqNJOC6syEGRvQOVyqpYedMhFXAndZOwp/rTA+cSxH3yceL
 briG5wEYONjnTs3mk0j9Se6kMYS+4lBGCbSaHrNKV818OZUCQfFRnCR7zehgq0eb7NguK9afip6
 dZdFVgGinZ6oH8vJ5IoZGY0U+dxUONl3DKhTWhe7BMmXfTVjeUA+vGbpDcXu3j3ukeykhn6NhX6
 +pTX9/cOUleSabw==
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

Reviewed-by: Simon Glass <simon.glass@canonical.com>
Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
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


