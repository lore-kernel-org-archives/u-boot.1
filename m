Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83DC3D2F02F
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 13:57:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7317D84109;
	Tue, 27 Jan 2026 14:54:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hd8o6IHb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D58968401A; Tue, 27 Jan 2026 12:12:22 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FC7A83FD9
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 12:12:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rgallaispou@gmail.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-4359a302794so3445247f8f.1
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 03:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769512340; x=1770117140; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mfiRf0Xi1teg0ba3fr6nrPSXhC/NbCpVL3VTFqOg5pA=;
 b=hd8o6IHbzZaaIC5szuUHzPPjLl3dGJneP8gBO7D55vodcskBjDgBRjUMZCkT+FwmHL
 NSV0c7QlGqvBXQMPrlTDpGt8oOR0OSrDPTSlpRoaAqYySnCxqHx+ABQWfLw9DdBlm8A8
 Wa42I3J5FY15exJ8C857s1/eMEEV8/K3FfuqVlnBKuifg76V4YxyilQe+h2eJxCK9Z27
 AhCET4BstzUbBE/p6D+TEYAy5ZHPOvqkUtNvVyDPQxuZrlB/bjAv7+rS7h96fqQ3m9px
 MuTLaJrEbaJKfuWKUo6YueY3d45eQtVb25cAm4d54HQ6gH8YyTij1SLdh3iZnKxE+sSp
 o60Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769512340; x=1770117140;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mfiRf0Xi1teg0ba3fr6nrPSXhC/NbCpVL3VTFqOg5pA=;
 b=XlYq/F05Ax75+p42edEfKHaePp0Tkm+EaB2RsbMEkccPetquhRRGCJ9xsCYe1MBdVS
 r3u321VSzqO4pRsrZibv7eTuTVnsVwmeVdRgIryzesxXxuEkKvFaC3qrXSovRqdR5KED
 W7y+lQTOwAwSbB8y2abcO3SGuTLwQtwUy+0GDdjNj8UPgWUWGg9nDa4wsDRyQWMwbZO9
 iHNEhRBKa+q7ytuLZTuMABLzCbBXwX8bfFkcDFTY4eNwEka+JoCJqWD4hJrcT/rASjZx
 WLxPRSq4DG9PUZHgRyhfy8E7UHkeyWu/LIGsD53zRWyUd7CxhjgboKxMPvtgnmaeJld+
 +NkQ==
X-Gm-Message-State: AOJu0Yxt2QUb8rz4uyPsU1+BT3dOR+6PLyxHqo8Wj3OgnAgHaRWCNiIg
 EJFigUEgzZKd6b3wZHTBvSZe6M9e0X7te4AS4dDj/3hMulFLwjprgD7p
X-Gm-Gg: AZuq6aKA4NWJYlI2+jq2tDWMFSSeHeeMU/2lmep9Sjtclv8a9pdUje0cbbbVu/qAMsY
 0t3R3flgKzjDzzrL32StBB34+dvVMwAI+UZsfvTwfZx0Kdufoxbgs/FZKLhw9qBeNmG1FOvUvOO
 Ht4t67RokIW/xI6L5JDjACvLz18+5dePMdZM/5SbQqCkOtT2rePJsca306rzF+EYQB7D2IlM6rE
 XH41YIiJt01rjXcQ4XA5XJVi7w3cTUKp0uDIIbfGYhmu4I7t6NCzHNcFLr840LzUQxD2RlFYA3i
 8MWmgYSx03VFBglsZG1emEqY98HYQX9OJdlTCIsIpt0OvqnBm/MtqSaw0B0Y2Iul6Oiar3Y359G
 wSAXplgX/CRMad9rRng7Bil7cdO3+u9DrHSIiYvCrvn0eewNZ3lJHLrJf+8PaT13p70mJFPfmKL
 bm490Hc4la0s7mRKPewWOdOC4=
X-Received: by 2002:a05:6000:290b:b0:435:bbde:dd43 with SMTP id
 ffacd0b85a97d-435dd1d459dmr1883532f8f.61.1769512339632; 
 Tue, 27 Jan 2026 03:12:19 -0800 (PST)
Received: from localhost ([2001:861:3385:e20:f99c:d6cf:27e6:2b03])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f7c9cesm38150144f8f.41.2026.01.27.03.12.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 03:12:19 -0800 (PST)
From: Raphael Gallais-Pou <rgallaispou@gmail.com>
Date: Tue, 27 Jan 2026 12:11:58 +0100
Subject: [PATCH v2] video: simple_panel: add support for
 "rocktech,rk043fn48h" display
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-simple_panel-v2-1-c50d5b23881e@gmail.com>
X-B4-Tracking: v=1; b=H4sIAH2deGkC/3XMywrCMBCF4VcpszaSCcRGV75HKRKSsR3IpSRSl
 NJ3N3bv8j9wvg0qFaYKt26DQitXzqmFOnXgZpsmEuxbg5JKo5K9qByXQI/FJgoC7RUlkcZee2i
 XpdCT3wc3jK1nrq9cPoe+4m/9A60oUJiLMV4ptNb5+xQth7PLEcZ9378TWmCnqAAAAA==
X-Change-ID: 20251207-simple_panel-1a910ee5175d
To: u-boot@lists.denx.de
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Yannick Fertre <yannick.fertre@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Philippe Cornu <philippe.cornu@foss.st.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, 
 Fabio Estevam <festevam@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1088; i=rgallaispou@gmail.com; 
 h=from:subject:message-id;
 bh=S41yA5oIJx+XS3IoW0b3HnYAfGA2Sig0igWQl/Dvhs8=; 
 b=owEBbQKS/ZANAwAKAechimjUEsK1AcsmYgBpeJ2B0FXYJe2v/L9CP1FkXiAPnErIXG/xT3jn8
 bchls8QXMSJAjMEAAEKAB0WIQQgmXv2E+fvbV/9ui/nIYpo1BLCtQUCaXidgQAKCRDnIYpo1BLC
 tTWDD/9CVrVYcaieErFKVjD7Lw2Hf1lif7aSHfkfWd4G7qUac6Ealvh2lv/ILxJGVOFQVIdrnYp
 AGKTE/gj1KKgnLHPcXEgFAa0DY7woInH/0xjEhj1gjXV6CqCf3zgeIb8wkSm3LsJghlyTv47mmh
 XRriT58NBg6cxNbdfkg3HyotSJuLeI83Dqpc34QiLspQFAp+nvNSIDoqA+hLcfEnSBXxRfBKLiw
 aqTNehZraEyyN+r3QBmwR5k2oXjND2lwCxlVXX7grLEyxt2xY1PgMr6ZKJtr+XTFPU14Pyw8uVv
 dxq39jV28YEb9evLcslGJ7RIdThNW2kqpzQ1cA32FDgF7VxKnynpRXoVk/vmgiy7RktY61DOLQL
 Yf0mRxOYSi6/ZwHNI8ns+AGpdaIQR2NQn4a60ZvG50OrdS4pU2PgkpADZqlVCIHD72VGH94UJpw
 uPYsFkoSjy6SzobO1ExNxO8k+tSeKBtWYvsNn2eVIkpHWCF97uewG5eVztyq8BGigr9vN0/2d5q
 rqGEtJVsew0NGqi5lPAflFqJfpyt0bXFZjuR9RFJzlsdGXaxz8KJiYcc3YZbC7x/ndXLEAxu1Ik
 ANEx9wm9CNjqMax7IANvPeNd1S+JQ+o+N/lJYanklv7A3eDcEFIeXwIlziIkbajqEQyH+f30x3H
 Vrw6SUyxBIysuZA==
X-Developer-Key: i=rgallaispou@gmail.com; a=openpgp;
 fpr=20997BF613E7EF6D5FFDBA2FE7218A68D412C2B5
X-Mailman-Approved-At: Tue, 27 Jan 2026 14:54:50 +0100
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

Add the compatible "rocktech,rk043fn48h" for simple-panel driver.

Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
---
This patch has been tested on stm32mp135f-dk board.
---
Changes in v2:
- Rebased onto latest origin/master
- Removed unneeded blank line
- Link to v1: https://lore.kernel.org/r/20251207-simple_panel-v1-1-8688d221aacd@gmail.com
---
 drivers/video/simple_panel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/simple_panel.c b/drivers/video/simple_panel.c
index 8fa7ea4e87c4..1cf587f973be 100644
--- a/drivers/video/simple_panel.c
+++ b/drivers/video/simple_panel.c
@@ -251,6 +251,7 @@ static const struct udevice_id simple_panel_ids[] = {
 	  .data = (ulong)&panasonic_vvx10f004b00_data },
 	{ .compatible = "tfc,s9700rtwv43tr-01b",
 	  .data = (ulong)&tfc_s9700rtwv43tr_01b_data },
+	{ .compatible = "rocktech,rk043fn48h" },
 	{ }
 };
 

---
base-commit: aa4f687977a449686498236722ee5e93d8b39918
change-id: 20251207-simple_panel-1a910ee5175d

Best regards,
-- 
Raphael Gallais-Pou <rgallaispou@gmail.com>

