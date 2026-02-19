Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 321EDE9A057
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 17:52:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21FB683E48;
	Thu, 19 Feb 2026 18:52:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="d959tls4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7253883E63; Thu, 19 Feb 2026 18:52:20 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90E0B83E48
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 18:52:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4806f3fc50bso14033135e9.0
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 09:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1771523538; x=1772128338;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m/L2k49Axo36HmTk3ychvt4IfhkRbfJbkWri6gh4E9Y=;
 b=d959tls4g6T5BFn8rbeHtmb6EJ73bfycMV7t+fWt8+1+HW7Ev1hl8FZZNs0IoDz4Vs
 LpKqQoBAycvzFZKa7LrJkuOCvsVQKEamifBNT/JuLotVPl8q46jhpka+PVmVpxnergnu
 a+Pqa78sRMfQy8W/BfefO5TrXe8VGlnO30Wl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771523538; x=1772128338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m/L2k49Axo36HmTk3ychvt4IfhkRbfJbkWri6gh4E9Y=;
 b=bf3GMaWosu308ZQYaDEQprLLe7KdpJoXsS1gKkzQ+q1FDDgpbjjHMIeQtqnDZx0f1L
 XM4ULNvbODdbwzwRx8NAVkmegR2LV+DCAF39Sjwce0sdrSc+ckhyY/XKvFzDuoXqw0AU
 HN3BC52M+tlUaEw/rqamBJLtq7JYsjogywRCkKyGiO+3BcTge5PnngjuvADgmrqPVEbQ
 X8mdvB9w9oEKmWpoothdUI5i3pW9IKv7DSFbKwooxHGvhj3N3hhMuxhLLRSZomHR2GHg
 /YWf1DJoWTEX8RGcSC8pYurmvqcBand19n/d4kiHUnfoY9TlX0lWpccHI/IT+54szIWS
 Srig==
X-Gm-Message-State: AOJu0Yy0rBioN3hTuAwbYHUC5F+H4q2cnfPZ19f4rrw+ONb87uUmvWa7
 9WyqP+zGw4UKCV5wkVr0gU/O6M0uTrMjYVxla4kNLnRTBesq8s/rJO1ZQoslHg8wWpiTknfm1OW
 dKoR5
X-Gm-Gg: AZuq6aKFlKheyCH/RvJzOR4uuOM/GXHkQwUnrlFg6NAikR6Qd1GxsLWpmtdNMj3lPlt
 Zh97vkyddvvexRKRrJ3+qIye2N8QPwdtVmhZAhfQXwYNqDMV9V4VA1oliSBD5A2hHLSGEBhUbzf
 uytNkX4DgqUaqBfoam1caVzl3G0s0KM2HVWckk+uMmMQDxrSdDtqK5C2e3vmpvzBBBJceGGC9df
 9NtGCNlouZbZxFCTssi7NuAU9QqUaDpEw+T5uFuLurF3XnhlHjQHcEm17EPxyJWE/1bDx2Ez3PI
 dJQMfYslT7zNdxvTdDPbcKdghTuMBBXuIcSaTQCzQhYOZTSLL/xsT2QNUIPldYLBvplrZlbYkwm
 uc0jQVqTFIjlFTKni9VXp86TFhwi1WRbiL2isAue6YRrcL6+dhdbT9PqEvDdF1xPgaYpzR2KLfe
 4dab5nHkjk5Uz/aZKnKDzaKJfcdgbyHlQ6yfN1R0EKy1sUKNolFMbe6LQDtOnPdjMD1nE7i7O0V
 9pMphuUmK3BTDCvAOiZdD1kD0UENclztuKggDjreAjcvtKtok4xmfs1XzIGQOgV1m5DXUfHlwAh
 xhf7oGRXU11/mHAFTvJae95R
X-Received: by 2002:a05:600c:4e45:b0:47e:e48b:506d with SMTP id
 5b1f17b1804b1-48379bab48bmr391159925e9.16.1771523537844; 
 Thu, 19 Feb 2026 09:52:17 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-95-248-31-95.retail.telecomitalia.it. [95.248.31.95])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a31b0e63sm35485005e9.2.2026.02.19.09.52.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 09:52:17 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Patrice Chotard <patrice.chotard@foss.st.com>,
 linux-amarula@amarulasolutions.com,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 7/8] spi: stm32: extend support to STM32MP25
Date: Thu, 19 Feb 2026 18:51:18 +0100
Message-ID: <20260219175130.2839234-8-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219175130.2839234-1-dario.binacchi@amarulasolutions.com>
References: <20260219175130.2839234-1-dario.binacchi@amarulasolutions.com>
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

