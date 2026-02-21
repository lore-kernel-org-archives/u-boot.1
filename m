Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FC03C61DDE
	for <u-boot@archiver.kernel.org>; Sat, 21 Feb 2026 09:44:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FC9183E63;
	Sat, 21 Feb 2026 10:43:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="dp1FYjm5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60AAC83D3D; Sat, 21 Feb 2026 10:43:11 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 853A583E62
 for <u-boot@lists.denx.de>; Sat, 21 Feb 2026 10:43:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4837f27cf2dso23968185e9.2
 for <u-boot@lists.denx.de>; Sat, 21 Feb 2026 01:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1771666989; x=1772271789;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bgG5cD+hbVHDRbzg/eLGiw+5QkTuTClXczKpZCB2jco=;
 b=dp1FYjm57fipl32Kq6ndNMM0mcr0x2xlkR6ATOiYddemD7tDY6yVEc6H6DPVVMLjJ1
 6WSFIDxlL1w9NNFBv0Oi/MB9VhyLSmIklAoJ7BhvFEVnMSZhcX7CcMIUtaquY1h4ZSD6
 FircbTVZQWC9s3B0D/nuygwcLAo7MstD5Rb5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771666989; x=1772271789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bgG5cD+hbVHDRbzg/eLGiw+5QkTuTClXczKpZCB2jco=;
 b=sbpkSvV1UYGWxrrw0JLG5wgb/mWeOEZ7P/tWm8LXJdYwfEpUugPkCDt6HOjysmNtDa
 ys0L0NPE5xd9J5uPtQXi9vZy7GPxmA5aIyr2vn+4vpYYDA7IRQzbv8DS4ROutJRkLvWe
 RQTRzHC9dE8tvAMU4G/HcsHwg+RGvkO6zYNtdQ9yl+gXmj6C689rAHh7maM5dbmZTCoQ
 Vt2V1qBtGQ2oi6MSihCa/hh8JMja0PwT4LdOP2HZlUsjOmz72o6hzpHay0k1RwVTLumk
 bfnZxj89rLDyGKmIsDQ1owgw+E6MoEha0VWDx4OnikdEKTOBfKvxFfBS98RHJi3v9Xqk
 grtg==
X-Gm-Message-State: AOJu0Yzk+XtazOlASPfW+W+NK4yhCtZXGanmjXj5ICMSZFM2kASkaSPc
 GNaGWE2WMqgTMLF2Bso/OnTnfYENdRgr8TC7tvfB8PG1vz32N/NdwaVN7HomsC5/+y38fs1k9E9
 lLy73
X-Gm-Gg: AZuq6aJ3Mmr/zkjWXK8kkH7xv/h4y1AL1RWzQpRt/dRV5KgPJpb6HVxRTyFPDWr0+MU
 wNUnJvmQnj745sME8FhMGscJlVth9KqJCYOmUDZwODuKh+gfiZruKKxtAWJwk0F2LFgXqMfXIid
 tqdKCT6iaUKA+G/hwtfli1KWMePnNv0sJysVka5985ccMFUcLmRavoMsRXjZCJsRzuapOLNIH8k
 5AkPNgJCEdUGX9wfwmAGVrsYFXYPqw1Z0ghyk8Fa1lAAbbyOe9LlWYGF7OBjBIqb6hh1HaOnk0y
 lAxWe4abU4cmaJtVoY21PVXWLA8HLtn9BL4KxoDKCgd4uvkAtJxAWYFoZhiBWghJfdkc21lvTWW
 zi4oLYYYG1kWktbM9/+1Nc7Bj7VOUZ2vzqSsgCn3kK166EOLwLWQQL2XPhXcVsq2JIcejEPHq0s
 2UDkN2AttqwPiuiNsHbUmh5RymKDEguehUkQ/XDwVU2szC68sKrYrThFNbvHK7Ao9IMHdqXwN7j
 0MShKVHgRng1ZBn4X+lu+X+Lnm3tUCZT0XEK5zqKCW1UJGLdAgbWK10gH8PSdMqzuK0VX09FJOL
 56tsB2B625O2bN83A7lv/z4R
X-Received: by 2002:a05:600c:a00b:b0:480:4a8f:2d5c with SMTP id
 5b1f17b1804b1-483a9637a86mr32258035e9.29.1771666988736; 
 Sat, 21 Feb 2026 01:43:08 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-95-248-31-95.retail.telecomitalia.it. [95.248.31.95])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a42f3968sm42694225e9.19.2026.02.21.01.43.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Feb 2026 01:43:08 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 7/8] spi: stm32: extend support to STM32MP25
Date: Sat, 21 Feb 2026 10:42:21 +0100
Message-ID: <20260221094252.3103034-8-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260221094252.3103034-1-dario.binacchi@amarulasolutions.com>
References: <20260221094252.3103034-1-dario.binacchi@amarulasolutions.com>
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

The SPI IP in this platform is fully compatible with the current driver
implementation, requiring only a new compatible string.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 drivers/spi/stm32_spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/stm32_spi.c b/drivers/spi/stm32_spi.c
index 39ea69c68174..903cc3702807 100644
--- a/drivers/spi/stm32_spi.c
+++ b/drivers/spi/stm32_spi.c
@@ -686,6 +686,7 @@ static const struct dm_spi_ops stm32_spi_ops = {
 };
 
 static const struct udevice_id stm32_spi_ids[] = {
+	{ .compatible = "st,stm32mp25-spi", },
 	{ .compatible = "st,stm32h7-spi", },
 	{ }
 };
-- 
2.43.0

