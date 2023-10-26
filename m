Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5278DC25B6B
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 07:32:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF1DE87B22;
	Thu, 26 Oct 2023 09:32:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB9DA87AF7; Thu, 26 Oct 2023 09:32:40 +0200 (CEST)
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D9D087AF7
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 09:32:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel@ziswiler.com
Received: from toolbox.int.toradex.com ([213.66.31.70]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0MFNDu-1qjpVo0ykW-00EImG; Thu, 26 Oct 2023 09:32:28 +0200
From: Marcel Ziswiler <marcel@ziswiler.com>
To: u-boot@lists.denx.de
Cc: "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Stefano Babic <sbabic@denx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v1 1/2] imx: spl_imx_romapi: fix comment about stream(usb)
 download failure
Date: Thu, 26 Oct 2023 09:32:19 +0200
Message-Id: <20231026073220.244387-2-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20231026073220.244387-1-marcel@ziswiler.com>
References: <20231026073220.244387-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:wWYmREQw2E0rt+yeYVP2RVj+2KuE4wyI5pIlKj2b19+O9n6LiB3
 Cs1g9YsbBXvWJ5Tcbkyvm5aNC7eHvhK8vj/wqYN0OgBpwoiz+iG3ycvXbVdxm+MP/TXBSIw
 LbThvaA/1M5OJdnaMuZIRHeERLVVA0K2rZL7/bGuSZ9nLRkY9UGg2pl1v5E4IyWCZqYR7k5
 5KxioSYS4UIZk35WVDNPA==
UI-OutboundReport: notjunk:1;M01:P0:sUFyeljQUhQ=;e7UHsu4FArHdqBTDgZ3oy7xrZ+k
 yPzGIcjBzjOPmCePVgW5/DOSmf9qL5T5B/ZJdm4dUs4BDiNsUsEo2l6jFpRS10HJgETVwpvcG
 oM57Y0GPYQQl9xF+GbBlYcB10qx3Zb1IGAtnSzp0UMAZVkNoUcQ8w1WcvIeJOWYD5Pi7zIO/C
 wkkwYzALliwtS6I9judGOwLfL0gUbquSaj5O3K8TpWRnqFCVk8gN8o8TmPLmkBwWhuN7oWqut
 3Ik/FlwlkZ9PyslmFXOy/2C3a8HxOEiVfBd169t/LmgMJv/Wnl6ikL63OdaaHuHaXTghn2QuH
 YNnMgk4Ou+3Dx9GOiGyEhRcr7p+weq+NU9LDvdsJ9DPAzhDTMLcz6PRTD1sqbcLTT6VARXWr9
 ISFsia0jpMNLV9OHONA5CY/ROOc2gvX+4oHDHbKN1E5/Ny419L5Hz/8cwCeTdId/zHRsuWNGv
 dA5rlS05dE0RDCjHkqDnIW1jMOzZzdQFFp4Qz4jGrG6yCH8y92K9Jh/que8rdrgsKlCwN5VYm
 5ACD0/JjitucuNeVveaP1N8zGqxkLl+xqUKqHE5EYe18BfIb0lewb5Zoptor6sYOEt1Lo9423
 J6JbCUu1inVass1uNuZY2JKMA3AuW0x6uD4VO9EmrK3FGFIras+eJ1JaffYldWu+FrGtzwtn8
 1U9lyIDaSpi8bG7qKTYtGUx8ro2qQKxqmL8ctD3iJsigfiPlBRhKCVsth414vEDtf6A/7dmPB
 tONieDTEICPbkxr0k2lilyjxFeToAGz5Ng+e+JA98yvcMAJZxj18EYKY8pT8z6VgGrywjyZFt
 R7IasG887k1EHYaYjBQi8NKiJtW4TpAxhPAqhIjkNMn0iXaKZBQ3H3cow1Np5WEv3HFeAYt7J
 ETEP3r0wCYCmd0Q==
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

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Fix comment about Stream(USB) download failure.

Fixes: 1cbebc786276 ("imx: add rom api support")
Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm/mach-imx/spl_imx_romapi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/spl_imx_romapi.c b/arch/arm/mach-imx/spl_imx_romapi.c
index 93d48e56aca..cb220869b50 100644
--- a/arch/arm/mach-imx/spl_imx_romapi.c
+++ b/arch/arm/mach-imx/spl_imx_romapi.c
@@ -285,7 +285,7 @@ static int spl_romapi_load_image_stream(struct spl_image_info *spl_image,
 		ret = rom_api_download_image(p, 0, pg);
 
 		if (ret != ROM_API_OKAY) {
-			puts("Steam(USB) download failure\n");
+			puts("Stream(USB) download failure\n");
 			return -1;
 		}
 
@@ -305,7 +305,7 @@ static int spl_romapi_load_image_stream(struct spl_image_info *spl_image,
 		ret = rom_api_download_image(p, 0, pg);
 
 		if (ret != ROM_API_OKAY) {
-			puts("Steam(USB) download failure\n");
+			puts("Stream(USB) download failure\n");
 			return -1;
 		}
 
-- 
2.36.1

