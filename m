Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D92B4D46634
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 23:04:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF88480325;
	Fri, 16 Jan 2026 00:04:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Fd/FU4aS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1ACF583623; Fri, 16 Jan 2026 00:04:12 +0100 (CET)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE6B783623
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 00:04:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-40427db1300so874669fac.0
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 15:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768518247; x=1769123047; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lxbslhuX9B+AQZZiUPcMHYHD/jxDmFqkcDPyK8p1TP8=;
 b=Fd/FU4aSCWVAd67+t5X77zrPj0KTSJ23bDXyY9/yXM1dihiIu+L4IXBTWmrZ5XkYZx
 bIUslQvH+jTAh2KFEGtOUlV14xpL7xzFgJb/S7XwqeeiEE4rF/7QF2PnFP53zIeHHzih
 fV7rcRSIAuLLvNq1aU2L9kr64qspsGIQWzdYezUy2kvBeN3+udDl/UUP+JbW9+dIduxv
 b6iNtaXbYnsVnsr7RpJ8jTio2hCchIQpbJ93bX2dzLLuF1Mbu12Me9Z2gjzAq7PNrS2F
 LJNwcFVwlKyLaaE1cYoB15jgvgOtdXVgdolaHbBX/D7pstaEdx59Gk9CLs6tcZoHZdJm
 8a3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768518247; x=1769123047;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lxbslhuX9B+AQZZiUPcMHYHD/jxDmFqkcDPyK8p1TP8=;
 b=vKsilx9aPo2ZGgx5U08OuO7mPT+ATHlyPQVvSUw6ODXGqq7ax7bVJwV34FkoNRVC9O
 9PmjHVD3eNTYtc2DF/cuOW12cj2hD2P9z4n23CkNT5Czlw3g9o5GnuZr4n9/4DALwv6d
 nUmJJjCEAw/DgjuhO665MWi0+eTK92nvnKH4tC42SKjTKqNyoE6hTLVzJCOTkCTji1Rc
 iH4pv0Tn1/Rb7FC9elyMVfwV00I620TCxUPokm6AFWY9N1g0paCs7Fryf0zYQfL5rEl6
 U7mqLwAQcof629RExDmA0cYmnuiFqRiRbQ8pDnPh+MOA3PDeaZRnu9u+yZS0xnbWhIk3
 X7Bw==
X-Gm-Message-State: AOJu0YwX33+n8llsrrzimXvmVSeJNUnM9XwmmSiewg4gc0rIUScvLidW
 j6sRQ091Zsnbn8T27pMubxYIIQmkLwi+RfojQoVT45ZODIhwmUtEAMlWsBkrjw==
X-Gm-Gg: AY/fxX591K8nmR9khRhw5YuFDT5RTdOGhx7K995WCiZrGJhx+0Y8jaVHKAPIcX+Pibx
 ZzbIByAXZI9TAslUed7C5Gz8rzYbQ7UWemVYrqN0K3i7HnQGjP2cLiocan++5jyNSeRVvlDC5+T
 f6ylml2cBPMEqEYuWZLn+cCxZC0dI1H+jMlLuUdSv6VbJG8NC9pCuA8OTjuHm35SwFL5TfPxERG
 8asmPfWLf8d812KwnB6YDp+nAyRVmW06v8dYqcnxzN8FIOcY5sNnr/ldTwb9dM1WLW+zshCv4vd
 HOvq0XFBJjNpUHUU06PrdjbY/+XA6eLaCgxFb22vNO3p51adiGkvEQo/6/omylIjUTxlLRHg6Vn
 z0ZzZqWWpHfJYyn+RCdiZz/PhoQT9+x5glhuBPCyuiGTn+7Hajic6nWCgAdTs7Cy2BXTh9beuss
 wSk+RJASxY/md7ycKUyPA=
X-Received: by 2002:a05:6820:216:b0:65c:fc52:c338 with SMTP id
 006d021491bc7-661179c27demr574502eaf.50.1768518247234; 
 Thu, 15 Jan 2026 15:04:07 -0800 (PST)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-661187a0000sm394787eaf.14.2026.01.15.15.04.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 15:04:06 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: thinhn@synopsys.com, neil.armstrong@linaro.org, quic_varada@quicinc.com,
 felipe.balbi@linux.intel.com, mkorpershoek@kernel.org, lukma@denx.de,
 trini@konsulko.com, marex@denx.de, macromorgan@hotmail.com,
 Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH V2 2/4] usb: dwc3: Increase DWC3 controller halt timeout
Date: Thu, 15 Jan 2026 17:01:33 -0600
Message-ID: <20260115230135.183158-3-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115230135.183158-1-macroalpha82@gmail.com>
References: <20260115230135.183158-1-macroalpha82@gmail.com>
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

Since EP0 transactions need to be completed before the controller halt
sequence is finished, this may take some time depending on the host and the
enabled functions.  Increase the controller halt timeout, so that we give
the controller sufficient time to handle EP0 transfers.

This patch was originally submitted to Linux in 2022, but is required to
use USB gadget mode on my device in U-Boot.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=461ee467507cb98a348fa91ff8460908bb0ea423

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 drivers/usb/dwc3/gadget.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 2b01113d54c..d2ae892d554 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1396,7 +1396,7 @@ static int dwc3_gadget_set_selfpowered(struct usb_gadget *g,
 static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspend)
 {
 	u32			reg;
-	u32			timeout = 500;
+	u32			timeout = 2000;
 
 	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 	if (is_on) {
@@ -1425,6 +1425,7 @@ static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspend)
 	dwc3_writel(dwc->regs, DWC3_DCTL, reg);
 
 	do {
+		udelay(2000);
 		reg = dwc3_readl(dwc->regs, DWC3_DSTS);
 		if (is_on) {
 			if (!(reg & DWC3_DSTS_DEVCTRLHLT))
@@ -1436,7 +1437,6 @@ static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspend)
 		timeout--;
 		if (!timeout)
 			return -ETIMEDOUT;
-		udelay(1);
 	} while (1);
 
 	dev_vdbg(dwc->dev, "gadget %s data soft-%s\n",
-- 
2.43.0

