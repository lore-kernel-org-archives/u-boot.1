Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 684B01098783
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 13:07:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 969C584065;
	Fri, 20 Mar 2026 14:06:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aQvynVtk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BD0D83D71; Fri, 20 Mar 2026 13:52:52 +0100 (CET)
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com
 [IPv6:2607:f8b0:4864:20::f44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0928783CEA
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 13:52:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qv1-xf44.google.com with SMTP id
 6a1803df08f44-89c4feaaeb4so20514246d6.2
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 05:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774011169; x=1774615969; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R6O+pKFwNLypageFlQ8uCy5NsL1KTAHz+rsH7vM/YJQ=;
 b=aQvynVtkIwuEl2BQBPm/VFd/u61jSLd5Zn4IUO++qsECQmkvSxHjJVZPyXn9e06GLi
 3FN2KOgujB821G+6QzJ/ChEY2jCk6ohh/keXB1/KskvHSjfj3P+SdGrJ9DkFjvgsa6po
 pGiaoqoIVXIpM1ISrWWuGfUptoNQucFZc2kpNuS1SEhLmhh8EJr/IPaEitYFQRmkvnjD
 l89OWxvBzhUXRAF7kPOKEnTzKRkc8i6U/snV18ANydQDGaxOgMV6FZz0RQl9vsIVhrg0
 OWcAdo5uBv/W+lpteKdZYCU+kxIP6B+Jt+ZNp23vpUY1aGLVSg68hv2D97ssiILqgExH
 2Idw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774011169; x=1774615969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R6O+pKFwNLypageFlQ8uCy5NsL1KTAHz+rsH7vM/YJQ=;
 b=HeeZKDUWi1j8uIxwzObINS/u4hISzKOINQaEAtaPVrMaoXkFOVUyXTfrwqCoZmHxBC
 x7VSSVQ5wJcHXIYPhF6mDKElFYgMdGn0eSOgA7G6oyTqR6s2TO1xHmnuBNy4alwPIS+f
 BmAqr+bt4BDPviATzQSMOny5x6wAhMomOlR9bgC3mUIJ0vgdDVbnNNTPkkdT3ChrpffK
 dVdDJ+rRTNcbPIrciWIhneH7/rn+DIPVrqCfzQtatjCT9JSw9C8pboUnm3QKiXqmkEzR
 6RWYl4Ydz2B+z7rUQS4HccIyZTKmx5T2rtNOuCt3wc/dlVDhInRoYqjfxE9a353ov0fY
 JB3g==
X-Gm-Message-State: AOJu0Yxxhg+F7myJVWyGcOppEa3KlNKboWWFWPm+Ii597XMz0YlEZJoC
 j3o46KhKdnRbIAPfEuKd2SXmWwntBh3MXUnXg4p2xoZtzOjBnEdD5StDTSBLbFxXPTC54Q==
X-Gm-Gg: ATEYQzw7BrHrUNC2ms6RpuNsAPKOi/MGj5/beut1HHU2NVUeSjJ/Vl1WIuc258vjTjh
 7UC/7cWqLvd/uf3UNl2/LPiDpQ1J/wb9NifphKZXavbaQGNh88vyKe+iRk44dcoUpCVMT9fTr8r
 gBNX+kQuYyCX95F0E3tPt0aSzEXRDWYEyg7Fso9dB1OyN6fDPCss8R1zOfHWvrtK5ZEEmkO8Lo3
 vUSDAOyTpsoqfnG5NmnFhI5sG6izbkwB14f4huD/W3/Ccu3ti8ZLmx4u8Q363X2wm4AJIJ3yOeL
 wILNfPg2kuKy59ITxg7SnllG8zWg3fseZWImHC1UoFbVwrz4limhGZibcw49AhvCfsl3ARDCnQ5
 kFGhi2oa39cA6K7R0dNFIzlCtdvN6RND+9ZtLoncaQLlQJdJ6zqeQxcf0Do8Xrtp2S+2XSVDd4O
 rrGE00UIzVswrDM5dBCLnlNFn65rQy+yI5vg==
X-Received: by 2002:a05:6214:c4c:b0:899:ff66:8152 with SMTP id
 6a1803df08f44-89c85a54584mr44268646d6.39.1774011168740; 
 Fri, 20 Mar 2026 05:52:48 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89c8537c3b5sm19168166d6.47.2026.03.20.05.52.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 05:52:48 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, philip@philipmolloy.com, trini@konsulko.com,
 linux@analog.com, Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH 07/11] dts: sc594: Fix gige-reset line on EZKIT
Date: Fri, 20 Mar 2026 08:50:22 -0400
Message-Id: <6d8bebcc646b6a4e22ed734c6e05079819c9f909.1774008927.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1774008927.git.jcethrid@gmail.com>
References: <cover.1774008927.git.jcethrid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 20 Mar 2026 14:06:14 +0100
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

From: Caleb Ethridge <caleb.ethridge@analog.com>

The gige-reset line on the EZKIT was updated for the
sc598 but not the sc594. This commit aligns the two .dts
files since they are describing the same hardware, the
EZKIT carrier board.

Fixes: be79378 ("board: adi: Add support for SC594")
Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
---
 arch/arm/dts/sc594-som-ezkit.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/sc594-som-ezkit.dts b/arch/arm/dts/sc594-som-ezkit.dts
index 11154e65ed6..e1628ce2082 100644
--- a/arch/arm/dts/sc594-som-ezkit.dts
+++ b/arch/arm/dts/sc594-som-ezkit.dts
@@ -130,7 +130,7 @@
 
 		gige-reset {
 			gpio-hog;
-			gpios = <15 GPIO_ACTIVE_HIGH>;
+			gpios = <15 GPIO_ACTIVE_LOW>;
 			output-high;
 			line-name = "gige-reset";
 			bootph-pre-ram;
-- 
2.34.1

