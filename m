Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A32D3C3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 19 Aug 2024 15:03:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A461A88CE8;
	Mon, 19 Aug 2024 17:02:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LV/nmuW+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CCB788CF2; Mon, 19 Aug 2024 17:02:12 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E6D18641A
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 17:02:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7095bfd6346so2427873a34.0
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 08:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724079728; x=1724684528; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y7L7XYgaJVmhWh8Td1afpcf2JPka7r6HJoVdHQpIxxo=;
 b=LV/nmuW+K2opTHtgnY8y772ZMs3Fp7+IbpgzgkbJt6jbqODq1HeaqKcJYAG6arAXeh
 poY0wuAYoIVbK9NlQHPflGawbqC1ZOCoFnb3MzJRKQlZkQkDdhMmV08B5QihkKzRVu9e
 IBRxyTlKxr/vB2UWiNZgEgYJc1GyIeA6X3IXi3OljBtlczHw4JDTKFhDfjM0LnVJ1xyM
 KvJTYkp+FfUOxig5Hi5QUt+KkZ9TYrBJloXAznzKv9r3sfimsO4tLyS8Z5UVXJPs+ruw
 teoEctXN0mu1KN4GrTtmJeNsSMNg8/04noe+d2F1hGwIdN8zpzhuRPGWTW//9VN+gnBX
 L0Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724079728; x=1724684528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y7L7XYgaJVmhWh8Td1afpcf2JPka7r6HJoVdHQpIxxo=;
 b=oPM/U5+XNp8NqpnU9ZFoywcqCRtz7LB9rwDMQrOJ5dZmSwSRx3JaptpOkMAXltb+bF
 aFi2ECK5rLssZEIxY9+QU49IJhBr71w1AqFhSBb8im5oergC+QZNVJ+5EwxtctVHItP7
 3M6chgrAj9xH50wVf1Tmm3//RbBVp+jHGEKN7fFHgAHKic8TudjGalczUT+EwNedRLmg
 2KeBTAujej33ucxMM0/9818ooGErEnKyGl7ZxDqURPL2/jEaJ/wuCOKEFhVFBXBSYd+j
 Iz61xunqLUR3fj5Nsx2jojBcmWzQbPV49dwfyl/DojiIfGnqb/39jxrbfoQPTI20oS+Q
 EERw==
X-Gm-Message-State: AOJu0YyYdDxRYPk96AasTnZfNkeuMOWSTjsY0n0H4szb8KkM+EFalKn/
 NhQhdDZsCvY8ExnyoTgOmVojdABXALIV986vlcrUsfotcVkE3n6nBn9PCg==
X-Google-Smtp-Source: AGHT+IF1EMJQi3Gj4vbnERpTMm+6/3nB0U7rkJ6fZFkVwL82+R8VzL3pFHt5nZ6fakvl2RaWSoMgJg==
X-Received: by 2002:a05:6871:ca14:b0:270:130f:cee3 with SMTP id
 586e51a60fabf-2701c3418e1mr8402671fac.10.1724079727884; 
 Mon, 19 Aug 2024 08:02:07 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf::54])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-27004432d18sm2945189fac.7.2024.08.19.08.02.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2024 08:02:05 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, jernej.skrabec@gmail.com, neil.armstrong@linaro.org,
 hdegoede@redhat.com, andre.przywara@arm.com, jagan@amarulasolutions.com,
 trini@konsulko.com, ryan@testtoast.com, iuncuim@gmail.com,
 sumit.garg@linaro.org, Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V2 7/9] sunxi: Correct TPR6 parameter for H616 DRAM driver
Date: Mon, 19 Aug 2024 09:59:36 -0500
Message-Id: <20240819145938.503221-8-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240819145938.503221-1-macroalpha82@gmail.com>
References: <20240819145938.503221-1-macroalpha82@gmail.com>
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

From: Chris Morgan <macromorgan@hotmail.com>

Correct the default TPR6 parameter based on suggestion from Mikhail
Kalashnikov. [1]

[1] https://lore.kernel.org/u-boot/4c003cab-c8b8-484d-924d-084e71fe666e@gmail.com/

Fixes: 4b02f0120a4b ("sunxi: H616: add LPDDR4 DRAM support")
Suggested-by: Mikhail Kalashnikov <iuncuim@gmail.com>
Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 arch/arm/mach-sunxi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index 17666814c5..f1dcc0d105 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -87,7 +87,7 @@ config DRAM_SUN50I_H616_TPR2
 
 config DRAM_SUN50I_H616_TPR6
 	hex "H616 DRAM TPR6 parameter"
-	default 0x3300c080
+	default 0x33c00080
 	help
 	  TPR6 value from vendor DRAM settings.
 
-- 
2.34.1

