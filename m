Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A82E1107BCE2
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 21:00:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FEF284324;
	Fri, 13 Mar 2026 22:00:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J8TjZGjX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2B4C84382; Fri, 13 Mar 2026 22:00:18 +0100 (CET)
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com
 [IPv6:2607:f8b0:4864:20::a36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC7AF84324
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 22:00:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-vk1-xa36.google.com with SMTP id
 71dfb90a1353d-56b6c3e0166so607704e0c.0
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 14:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773435615; x=1774040415; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y3F1Df++OARSWejb+JMakGLfa2p5XMTlr810JPbqr7g=;
 b=J8TjZGjXsgt3r+7d4bLrdVMSt04Fza4LawBCyJGGdNY2V022FQ8WjmuiwXOD2Ay5lk
 +o1UIGFzfr+FnI1OMsI9A8TCkuq9TtgOhPE1weiK3+NFOQEu1Z+xTo4JwdnOTpi1dMZ0
 R34+e5KhCvAXeAj5jFACzfhQGg9qj2iH1gKjxsF/hHDdm0topSYvdUkkkuC1vCPLKgMV
 JuSjUSWVifo/NaUvbnWHOjyJ7i26tFdq8/F+hcSves8rdvbKcZVrXQ7PJ+EWsWpvwO8c
 bmSzc8LP9L8GYXqlfMWzpHlpP6JxHK1U8hBqAik6UGHKPV4d35Gg+PnJuQlAP5xGr9PS
 Jxkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773435615; x=1774040415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=y3F1Df++OARSWejb+JMakGLfa2p5XMTlr810JPbqr7g=;
 b=EOKGNexuZ7zlf7+9ipfdhRmDDNpIRQNOuEy4NLquEPvXsIxWfw6EyKYmgRPZqzeUor
 FgXI0Gv1DEz9VP8OBaq6qVE5mx5KWGieTMYHy5sG08jtB4hW7sfHjznKfex/k/4Dc+8A
 MQGZ8BeFATCOZOcF/Dk7JUaXPOTFN1p0vywgGAUz5otF9reft2pAIVdLl2ZkXl/amiYt
 WQJPKiLT1rHAS2GMuhM1KJQ8TZWrBS4jkoIeU1hIObY4E2nMPKLNUBVRWJ0GNKvtbEQa
 2VsIR5n4uwrOXZpFwAN2/ZQBsWtFeDjC/rigS8FSO1gds0LRTUycO08zqXuLMJyXgvfs
 TOHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPehDbuMc8fWCO2AReEag7VLNsd4o1JrzVrYrpVmqomX9duYwDsNjS8+h9RISqgUxUyti5ZNE=@lists.denx.de
X-Gm-Message-State: AOJu0YyrNtHtj9MZ9UXpeo7ZO4pGvUz7oGXzoyB9J3q+H+F5oT0a1SVL
 LmfUgpFZEQgWQ2GXKhD2hgwmGvutuV7AIUg2edEmBEeVRb0aZZAY4Tp+
X-Gm-Gg: ATEYQzw+fFSNRCGlK5Fk5221sa0RdeSHl/E56U+FU7X1L+6GUUE1ynkzZz15FqFVJzD
 MDnqql6sh8gzyOIoaax6zZU9kF/iRImNLVV7tBTIhY3OBgiWpZZfLJG1azlSe0Dp6/oqRwzDNd2
 2ScmCE9rVLk4Nk7liEFcpIH6Inox+AcCB0jI4EhaahDI8fdr7v1JS29g71SfAGCmk7E3U+6BtRT
 Hd5ftUQ9rPM5j6jdh5SfGMibBkBfkUZRFqPkjgTtzJdg7+79YDGq9gz0UY/2E1zbNunoPgf++yt
 L0q49f90gO6XiXUcWHFRqofUXEG9VxRXZKBdquhnX5pdkEWt7BS+fQDeb1nK/p500XTBRTfFrZb
 kuC1SGp2vl6FmM9n4q210WXRiGMB9XPo/ZDALUFW0HpsQpZAYguUGxP/Qgk3aezfE2ah7SckfeW
 A+2bUQNOyW/uSkJPc4/oi85XOmPPANyizSkGqEZhXx45mO7jDDzYnT+7JMnnXRvCL1fQ9XUA==
X-Received: by 2002:a05:6122:458c:b0:559:6788:7b55 with SMTP id
 71dfb90a1353d-56b614bd00cmr2244895e0c.3.1773435615556; 
 Fri, 13 Mar 2026 14:00:15 -0700 (PDT)
Received: from fabio-Precision-3551..
 ([2804:1b3:a803:148f:efd2:3409:d560:acc5])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-56b4648dd38sm4466066e0c.14.2026.03.13.14.00.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 14:00:15 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: peng.fan@nxp.com
Cc: uboot-imx@nxp.com, u-boot@lists.denx.de, marex@nabladev.com,
 trini@konsulko.com, Fabio Estevam <festevam@nabladev.com>
Subject: [PATCH 2/2] doc: imx95_evk: Fix the binary name
Date: Fri, 13 Mar 2026 18:00:05 -0300
Message-ID: <20260313210005.781958-2-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260313210005.781958-1-festevam@gmail.com>
References: <20260313210005.781958-1-festevam@gmail.com>
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

From: Fabio Estevam <festevam@nabladev.com>

U-Boot produces flash.bin as the final boot image when building for
the i.MX95 EVK, but the documentation refers to imx-boot-imx95.bin.

Update the instructions to use flash.bin when copying the image to
the SD card.

Signed-off-by: Fabio Estevam <festevam@nabladev.com>
---
 doc/board/nxp/imx95_evk.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/board/nxp/imx95_evk.rst b/doc/board/nxp/imx95_evk.rst
index e87d7e27b618..593981e6a651 100644
--- a/doc/board/nxp/imx95_evk.rst
+++ b/doc/board/nxp/imx95_evk.rst
@@ -152,7 +152,7 @@ i.MX95 B0 silicon version on 15x15 LPDDR4X EVK
    $ make imx95_15x15_evk_defconfig
    $ make
 
-Copy imx-boot-imx95.bin to the MicroSD card:
+Copy flash.bin to the MicroSD card:
 
 .. code-block:: bash
 
-- 
2.43.0

