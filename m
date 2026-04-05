Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA61E9D800
	for <u-boot@archiver.kernel.org>; Sun,  5 Apr 2026 20:18:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE58E807C0;
	Sun,  5 Apr 2026 22:17:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RsQ3Oboq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15BE683CD3; Sun,  5 Apr 2026 21:59:32 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31AA983A41
 for <u-boot@lists.denx.de>; Sun,  5 Apr 2026 21:59:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=simons.philippe@gmail.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b9c745e18a0so456511966b.1
 for <u-boot@lists.denx.de>; Sun, 05 Apr 2026 12:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775419170; x=1776023970; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aMc5kXl3weurPF0mKftZUD8fbnFIJScXSWMm4hhZUyg=;
 b=RsQ3OboqyFTIXHWRDlHQSrSYUCg8el7oT3rB3YPRN8z/gTOFWxGGrVN7WOPAWWoGqB
 P1QwetvmHTOs395gZ0zq5SeVMdvd+UkQoiH9tBlcpam/G+pCs6yKy4IziMz8saESJVrZ
 lqr8krRJl4HXKr66avPD8l5PmJVrN8O0O6uRNgFRSo28D5KBAHWmHjGvhV5+RgSwuF/7
 RdMBXCRBn19IkDhfkD8W4ViLjvskgIXx6uH9ihOTCCZoh5lhkq9cUHJx8c/SowMObW5F
 D/BzcvH8ja1JULMdUPfKjZ8Ch6f+U9V18SNis6rT87228sBLZnAB3wvQCvUZkLC1QvuT
 lvvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775419170; x=1776023970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aMc5kXl3weurPF0mKftZUD8fbnFIJScXSWMm4hhZUyg=;
 b=SRMt5jmkbUeWfqS/k//FeC924JOvsFyXDUm7HBJTpjuxdFFBI9alFwYYTfQjp5dmnX
 sF8MgYSXk6Gu4nUcDATmUqQZXrEyDW36OsUnuXZPf5hZs33wX6kzZp0REvJiWUkJ6jFz
 3DGx3dbvXpbpc1FlBajG0nym2P1vgQgfwFYhhCt1iFk/IxKYlIUZK77x7KUJGRabNSXZ
 SYAzp768Bd2TQD76zP25NCHEQrQS55Q1KBWPZvaBc5paQw7cCg2uMRhWb69oiThv+5F6
 d0R/COehwDJMkD6v+BWzVu6iipra+hKlwUio4xZLsMoa/XjUo/k0y06skmjS1j36t4li
 bXyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVas+swttlPjMOT6O+meK25yLDqKSqb1Iqx93FgVENrIsiNYSNEJVnVz0/0GqyvQqoBsJhXX1o=@lists.denx.de
X-Gm-Message-State: AOJu0Yy1rna1Y7ldEbLwQd5Ro/b7/ogI5doW0FYTFNNG/RPTNXE3FxJV
 s3J6U6xBilErn2YZotY+iCLTzLz5EWVuzOLFBD++ZZ00/+4F0sfTvngh
X-Gm-Gg: AeBDieuA9vGC9hlUfmbgjZf3/XgcpHSwBuPGYVimH5OplsMbVV0Jtxq3N1ZSmeITsgG
 Gqu13KWFEA2Fdv5oJlly9/wLDz3m7AXcCGvZrzkboK/NfMZ3kqG0vYXKpGhLHs88HKrwWRga+5V
 KwTmacb61Bw/Dc68xPbZEhCQuCLURGZ+/bEFDQCcj8m1vLJUPmjKIPCRVAVsw1PXbNTSAfNqDyQ
 ZRKgy1LuXFmTXyazjzI/DmmPwlnHKS6sYKNUyVslgAqEyWvuLuBYv6fKCl3cVbpcGlFu2mQAFgn
 q5xoqD3FnhRopdL2bJndke5bldf/siqn0zO5Lj954dMvnEb9Ahv4dvshajJqTkhGZGGPCZryrpV
 epv1pAi510QrsNlIuVpQhQzBd1rHAPb4ZVDnRXfL42KF2Tqr/hyMZIWzg5Fdjxh0quMzz7IZK9N
 J6o9luJUONMBNqf4fFI9ZGhDf/w/vZSIAXrQXjviMhVMQbBh3XJkNxrLkANjEDGjsFKflUisveq
 +ttqwYQxg==
X-Received: by 2002:a17:907:9727:b0:b98:284b:53b with SMTP id
 a640c23a62f3a-b9c65867709mr472771166b.14.1775419169474; 
 Sun, 05 Apr 2026 12:59:29 -0700 (PDT)
Received: from bob-linux.lan (113.73-65-87.adsl-dyn.isp.belgacom.be.
 [87.65.73.113]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9c3c97209csm421157066b.12.2026.04.05.12.59.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Apr 2026 12:59:28 -0700 (PDT)
From: Philippe Simons <simons.philippe@gmail.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Paul Kocialkowski <contact@paulk.fr>,
 Cody Eksal <masterr3c0rd@epochal.quest>,
 Philippe Simons <simons.philippe@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Mikhail Kalashnikov <iuncuim@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH 1/2] sunxi: H616: dram: fix LPDDR3 TPR6 parsing
Date: Sun,  5 Apr 2026 21:59:26 +0200
Message-ID: <20260405195927.2837914-2-simons.philippe@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260405195927.2837914-1-simons.philippe@gmail.com>
References: <20260405195927.2837914-1-simons.philippe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 05 Apr 2026 22:17:20 +0200
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

From: Jernej Skrabec <jernej.skrabec@gmail.com>

When a user copies the vendor value of tpr6 into the mainline U-Boot,
the code parses the tpr6 parameter incorrectly and writes the wrong value.
Fixes Vref parsing from TPR6. Proper order from LSB to MSB is DDR3, DDR4,
LPDDR3 and LPDDR4

Fix that.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
[adjusted commit message]
Signed-off-by: Philippe Simons <simons.philippe@gmail.com>
---
 arch/arm/mach-sunxi/dram_sun50i_h616.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-sunxi/dram_sun50i_h616.c b/arch/arm/mach-sunxi/dram_sun50i_h616.c
index 3345c9b8e82..42a0550e015 100644
--- a/arch/arm/mach-sunxi/dram_sun50i_h616.c
+++ b/arch/arm/mach-sunxi/dram_sun50i_h616.c
@@ -975,7 +975,7 @@ static bool mctl_phy_init(const struct dram_para *para,
 		val = para->tpr6 & 0xff;
 		break;
 	case SUNXI_DRAM_TYPE_LPDDR3:
-		val = para->tpr6 >> 8 & 0xff;
+		val = para->tpr6 >> 16 & 0xff;
 		break;
 	case SUNXI_DRAM_TYPE_LPDDR4:
 		val = para->tpr6 >> 24 & 0xff;
-- 
2.53.0

