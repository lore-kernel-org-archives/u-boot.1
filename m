Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20B96F4369A
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 12:44:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E10A78426C;
	Fri, 17 Apr 2026 14:43:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SePKLmqN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D09984201; Thu, 16 Apr 2026 16:45:05 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EF50841C2
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 16:45:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=micbis.openwrt@gmail.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48374014a77so105949725e9.3
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 07:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776350703; x=1776955503; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wuAzHK5KC8yD7Za8YXNhQGv4356/N2bl4iAgmIWEcuw=;
 b=SePKLmqNraknXWLg0gf1oNyVZqleOvUtjJZ7RNxhdz0PHgDOEiJBiwXfVk8JREM9eY
 axS/bH/yMGbpA+WEkkF5G9QkSSjg/bSf+BS/ATSG5whai4O1gGIsBCP1OSx2vwbb4nOA
 mHsH1zIin0Izr0WMPllZqEkLIMZNmUZLhKCtf4j+DLnjK3WWGawE4sfcWjY5J4oHRPVG
 2L85aOQv82Ma6hp2/M+hoLOyP3AZSGnErHYZycnlrVG+q1RAi8zZB0DbliFHWtNg4Vwy
 dru1IjO0HKNq7rA+rhxHyLZpBXt+Ng4+Z2NmbeRHjbAXCfMOJtkUCi9KuuvsBHJVJhh/
 ShYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776350703; x=1776955503;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wuAzHK5KC8yD7Za8YXNhQGv4356/N2bl4iAgmIWEcuw=;
 b=p+AFWH5gEOkP+mUs7N6ZbkZ/FvM0HT0jXH6tS7GIOhr2stfPQf3sL6VlE9ms+7Kqth
 Ez9pMJD/mBT1XTZwppy+3+6i29kpFMCXSZHRzYCs+BcyX5yeWiKUOvSfsnzDICRtZncQ
 jjY0PbA5lYG/Bk72oWtVFavwTkbTEceW+ozhbAh403HE+JVnjSkJZ6vz1BQNxDsq/n6A
 RuhheQsEw2mC+Ijv6gq5Tlf0DD6kko/5gKwCqwDH9iUqjBJ9lIXtEUIi3p3ZWbxpMgRC
 +8jc0QZKuEM4Og69kPXUuTDmOTW39G4HiSQmjEiMrBjt6wWX0ONZzfitbhSqBrcHR5w2
 sDoA==
X-Gm-Message-State: AOJu0YzBtQW6fnG5f2kMbB0UWRnuyd7BAFzFw0l0nozhZ8mojc2SSN0P
 0djSKpTaXQw7oOehcaj65sHsoNcY6uZP/SxmPeoWrHwBXA4H/peTUbwYZAV4UnFfYys=
X-Gm-Gg: AeBDietMavSf51QI7lsHEKJCok3Lol+VxRP1wtHMckGXPVAk4RyzqJaF8FQBXXBD/HU
 m/SEhj+P70h52L6b+ZF159X9Bs8JnVrayG98gxKCOZXGjFGPoXVm3fMCFBkJ7f7JG+30Js7PAJF
 lOBLZ4gcvzlMUa3CHN4KZfjNZKNbLFo34r7gwpIDv8T0X3xbWzPVwwD/5nLsMd8YU7FnHVjTdfA
 oBAQXMf4HgBu39OfDpkkzmscYnXWBqHwO9CAfyfPmVRvV7aHWmvBNel6xXsAy+Ln2nyBwAz8+H/
 TgMO45IasruycWG0S8d0FnLYhwG2rxaGj2LyBQGXIKRhhZzi5DZ61gKU7+W7ihQpLxFHJP+tveo
 33Wxt+9LEU6k66onHnMFIoEqslEu9H0DUmi5CKSsGaBcYY6tTF8KBRmRZOVPPmcf5blxH0Sq17/
 GHCo867ZJAMQzDpCFlK5Jjrz1WZFhB3pLWL7uo7UM8
X-Received: by 2002:a05:600c:1391:b0:486:fe23:1707 with SMTP id
 5b1f17b1804b1-488d687116amr373059095e9.20.1776350702343; 
 Thu, 16 Apr 2026 07:45:02 -0700 (PDT)
Received: from localhost.localdomain ([151.70.144.55])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f58163cbsm58756775e9.1.2026.04.16.07.45.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 07:45:01 -0700 (PDT)
From: Michele Bisogno <micbis.openwrt@gmail.com>
To: u-boot@lists.denx.de
Cc: marek.vasut+renesas@mailbox.org, paul@pbarker.dev, jh80.chung@samsung.com,
 peng.fan@nxp.com, lukma@denx.de, mkorpershoek@kernel.org,
 trini@konsulko.com, Michele Bisogno <micbis.openwrt@gmail.com>
Subject: [PATCH v2 1/2] regulator: rzg2l: implement connectivity notification
Date: Thu, 16 Apr 2026 16:44:25 +0200
Message-Id: <20260416144426.12728-2-micbis.openwrt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260416144426.12728-1-micbis.openwrt@gmail.com>
References: <20260416144426.12728-1-micbis.openwrt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 17 Apr 2026 14:43:59 +0200
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

Implement CON_CTRL manual connectivity notification.
By setting SEL_CONNECT and CONNECT_1, the UTM+ core is notified of
connection status in peripheral mode.
---
 drivers/power/regulator/rzg2l-usbphy-regulator.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/power/regulator/rzg2l-usbphy-regulator.c b/drivers/power/regulator/rzg2l-usbphy-regulator.c
index 0354555d0b5..03f8dec4f08 100644
--- a/drivers/power/regulator/rzg2l-usbphy-regulator.c
+++ b/drivers/power/regulator/rzg2l-usbphy-regulator.c
@@ -9,16 +9,22 @@
 #include <renesas/rzg2l-usbphy.h>
 
 #define VBENCTL			0x03c
+#define CON_CTRL		0x020
 #define VBENCTL_VBUS_SEL	BIT(0)
+#define SEL_CONNECT		BIT(4)
+#define CONNECT_1		BIT(0)
 
 static int rzg2l_usbphy_regulator_set_enable(struct udevice *dev, bool enable)
 {
 	struct rzg2l_usbphy_ctrl_priv *priv = dev_get_priv(dev->parent);
 
-	if (enable)
+	if (enable) {
 		clrbits_le32(priv->regs + VBENCTL, VBENCTL_VBUS_SEL);
-	else
+		setbits_le32(priv->regs + CON_CTRL, SEL_CONNECT | CONNECT_1);
+	} else {
 		setbits_le32(priv->regs + VBENCTL, VBENCTL_VBUS_SEL);
+		clrbits_le32(priv->regs + CON_CTRL, SEL_CONNECT | CONNECT_1);
+	}
 
 	return 0;
 }
-- 
2.34.1

