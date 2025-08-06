Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA9A4C87FCB
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 14:58:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D244883A5E;
	Wed,  6 Aug 2025 16:57:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FNw+DJiI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8524D83AB0; Wed,  6 Aug 2025 16:57:04 +0200 (CEST)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CE3D842F7
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 16:56:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-61b406bfa66so1093582eaf.0
 for <u-boot@lists.denx.de>; Wed, 06 Aug 2025 07:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754492214; x=1755097014; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sCyJfkGb31HFufMgWyy/oEdUsGGaGcw1y/kenmPvo1o=;
 b=FNw+DJiIgkiBVht4LorOX2n7JkKiWpwBw4tIf4NKeECwZLfmbp2t9XVNimIPeub5ty
 wtj0/ujEzgN/BlyTC/eTE/Vw32EHQAbZGNPXHkRyI/AFIcJVESOW34jnxtIcB0nKp1iM
 bQQObv+k2zt4BOX/pqy42U5f5dgpMesI2uu1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754492214; x=1755097014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sCyJfkGb31HFufMgWyy/oEdUsGGaGcw1y/kenmPvo1o=;
 b=EOwYyEmWll4oSQh6A93a7EqxThyao0v1nwT+RryuqmsBXynkRyNOhdbU5+jH2rqfRr
 /PuGgjNxfxXHxe/3RZNd4eMTMHGitIaaEWiIYeYWtxu/1DYLgX63P1BMMlNdEaoav2NI
 I0FI/XQOG2FL+KxPcLXHp8DFPsFDrp9blgDdm5sqpVV6822i3Mj3k/NAVNwjF2lidIIc
 jm2+Y/5UB0Z+YS45aOi6a6X2iKPtrp/coM1IpXAm8sGJMM79nLey8OSZ49MA+x9O3u/y
 YKaqseYRwuJ5ZPs9qDvYMlH4RzQ/ZmtVnpeTqXdQI5qUTihmgZi5jReR09XqGsiAWavf
 Sn9Q==
X-Gm-Message-State: AOJu0YwujagZBAIIwdyF81l8G8wyuoHdTxeAEsBhlXvBya2MSxaUDZ7L
 M+sGSqpodPdZKxXcIp0SsmJYuP0iii8hkX/oKns4milEnCQ2h6I//phtLN9SvP9R3dR33xEWgop
 8/3v68Ks=
X-Gm-Gg: ASbGnculmVV3KO+mVF5qajZwX3/N7TeiieS5dnm8JU729tZlB2iRisyAtoYYFjdrFeo
 40ks7e0MNJz1OpCawOGfTc7jJCNBNjB4ePFQ1eY3bEpSMEslBIRJ+ln0BfyFQdBZRT6e+5p3vI8
 j/jqgv33U4jEW5moVBfIjgFcklOCLXVwrv8fNcvoBENvcqzN97c+neolVSECHtpOHp9g2w6S2va
 pCB8HLRdgjb8Y8Zhme6aJRMpjDSuT44Gq79BceaIddMcic+HIymbYZILpfMuOrZ7aHGeR5zhGNE
 xbAm236yIHMNzJd6Cj20E4pjndYOfCfVxDIYd8S/xQdzxSkzcnLMYpdwQIrt0LxIk60fQI+8xZV
 XOc6q1Q9b0nN4Gn6tdW+S0IAtYrA6ZnKlOK7wWKIu4rSPFmBui1QZ0iA/o0g=
X-Google-Smtp-Source: AGHT+IGoop8HsnkkeD6FpAPsCoUq1im6pDeKASCHqiwbbxxHp9GDXjJwjayo27+yj0CMKYIUZRhYEw==
X-Received: by 2002:a05:6820:1785:b0:613:cafd:610 with SMTP id
 006d021491bc7-61b5f38b212mr2691239eaf.7.1754492214333; 
 Wed, 06 Aug 2025 07:56:54 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6199c99b222sm1644790eaf.28.2025.08.06.07.56.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 07:56:54 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH 5/8] video: anx9804: Only build when needed
Date: Wed,  6 Aug 2025 08:56:46 -0600
Message-ID: <20250806145649.1664724-5-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250806145649.1664724-1-trini@konsulko.com>
References: <20250806145649.1664724-1-trini@konsulko.com>
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

The logic for how to handle this video driver is slightly odd. Only in
the case of when CONFIG_VIDEO_LCD_PANEL_EDP_4_LANE_1620M_VIA_ANX9804 is
enabled do we need to have this file built, and otherwise we have a
dummy function in use. Correct the logic by only building this file when
needed.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Andre Przywara <andre.przywara@arm.com>
---
 drivers/video/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 03a52d1b30e6..5f9484ee8899 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -54,7 +54,7 @@ obj-$(CONFIG_VIDEO_DW_MIPI_DSI) += dw_mipi_dsi.o
 obj-$(CONFIG_VIDEO_EFI) += efi.o
 obj-y += imx/
 obj-$(CONFIG_VIDEO_IVYBRIDGE_IGD) += ivybridge_igd.o
-obj-$(CONFIG_VIDEO_LCD_ANX9804) += anx9804.o
+obj-$(CONFIG_VIDEO_LCD_PANEL_EDP_4_LANE_1620M_VIA_ANX9804) += anx9804.o
 obj-$(CONFIG_VIDEO_LCD_ENDEAVORU) += endeavoru-panel.o
 obj-$(CONFIG_VIDEO_LCD_HIMAX_HX8394) += himax-hx8394.o
 obj-$(CONFIG_VIDEO_LCD_HITACHI_TX10D07VM0BAA) += hitachi-tx10d07vm0baa.o
-- 
2.43.0

