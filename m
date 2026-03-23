Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B98EF483EC
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 19:54:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1238084255;
	Mon, 23 Mar 2026 20:53:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ctzFKB3C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99EAF84227; Mon, 23 Mar 2026 20:53:07 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D9AF838FA
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 20:53:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7d7653db148so2596841a34.2
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 12:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774295584; x=1774900384; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fqlI3zO38bjXifNjeh350Fir+rYyM2eI7Gs8myzRE+U=;
 b=ctzFKB3CXxko7sRKQN71HTGpi4qFoxqIP887MkmED0RvWCBbpBKZTJ3XjDG8FX4MC5
 nSd6km+epfMynGbQPVW3W/ma4p2Y6qV2nw2A2d78msODf97KCb0VDtjQglYl21ltVB2C
 Lsh21ezctpLvxeIan1X1Z5wGo9u6Om8Wl7RVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774295584; x=1774900384;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fqlI3zO38bjXifNjeh350Fir+rYyM2eI7Gs8myzRE+U=;
 b=JOqAvTj4ZIAitqxI2dRdJnbaccVNMijhz14JlfR3kAuVI1VYNUKFlSY1zinXdaCegL
 4PO6GJyx55zK9gqHwg4znl+BbSFuADDTbUFuvOe0WFiMxUPv7Yw7T9LaUCpxF+kqTSEi
 IdYzABIapK5uihM7Cz7S3JCEvf8sedJuksqZAd1AgS+aWUvgG5w0c13RWztbrkPkkn9O
 PQHGR8FPqeneJd6GhuiN3HHkm4V354VG2TiP33NnhbDGNlV7oQWOaNF05OyU1BOLpAJ9
 wTRndfQomuwvAn9Q7V0kDKx3XRGsBhwexWNgZl9EDmALQoxMqmxkOqX4TnM/jgDp/lOW
 UdRg==
X-Gm-Message-State: AOJu0YxQIb4WtYp9s4VXqLjJUoSxLh80/lmqd2DOhHqjvcf3QHaUFmRW
 eQEB8c/OHJjD2whiVsx5WWV3nnxQulQmhNtTm9VhxhLSDIFmn5gXEYi8sIm69cXxgqeeqh81JtJ
 VFF6u
X-Gm-Gg: ATEYQzzF5GmRGho+WJi+6CN8MSXot1btAfQXlNRQnQAtIiaOYN66dE8zkVBmAMW585K
 ZDqiIKsT9q90lGyncUIgkjWZZ/aTRI/X8vIU43Jf3JSjmhuccbHsQL73Pu5XKOwUWYJe0iCVl7R
 NIs4nI701eZs1SZ+6f47ZICtY1N204TbRcAKRqEuGMt+aGscHNHUc7C9471nMFkuJ3pSoPy4h2D
 EptBJPG9+ZBLBhsjzEnqjBepOa7sewSFqRGOs/Q9dz/oTom5nHk39L8FylRbxXVbbo62/VUORCo
 gehFIvtRnlIoJP7TCujlAQD578D1e0NZatmawN16GALknb5IBtGwu9KC+rbF077w7ANINexdig1
 4gjpjNJMhEp4N6bd8pTs43d0rXmVMrEWeanZ/LXbyf8VmAzCveN3U8HpJPvXPfy88Bz4HcMLv12
 yUkQA3an0R0TQPvCuUGg8+DLITOtMwhxwJ9oK+CMVtyT1WiCpnzkQDV10hXKgs8T8R8LXjFsoFh
 PiFTcKotmXd2W8eYszw1W+NH1bJPvO36010OSohnNLFST8TdYB0tjrM3616ig==
X-Received: by 2002:a05:6820:4d05:b0:67b:dc97:119f with SMTP id
 006d021491bc7-67c22bc874fmr9108551eaf.9.1774295584031; 
 Mon, 23 Mar 2026 12:53:04 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67c252c892dsm7143255eaf.4.2026.03.23.12.53.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 12:53:03 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Casey Connolly <casey.connolly@linaro.org>
Subject: [PATCH] power: regulator: qcom: Correct dependenecies for
 DM_REGULATOR_QCOM_USB_VBUS
Date: Mon, 23 Mar 2026 13:53:02 -0600
Message-ID: <20260323195302.2363577-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

The DM_REGULATOR_QCOM_USB_VBUS functionality can only work with DM_PMIC
enabled as well, so express this dependency in Kconfig.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/power/regulator/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/regulator/Kconfig b/drivers/power/regulator/Kconfig
index 4f39e46cebd5..a4ee5f1335ad 100644
--- a/drivers/power/regulator/Kconfig
+++ b/drivers/power/regulator/Kconfig
@@ -244,7 +244,7 @@ config DM_REGULATOR_QCOM_RPMH
 
 config DM_REGULATOR_QCOM_USB_VBUS
 	bool "Enable driver model for Qualcomm USB vbus regulator"
-	depends on DM_REGULATOR
+	depends on DM_REGULATOR && DM_PMIC
 	---help---
 	  Enable support for the Qualcomm USB Vbus regulator. The driver
 	  implements get/set api for the regulator to be used by u-boot.
-- 
2.43.0

