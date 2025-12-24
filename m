Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 268F0E7848C
	for <u-boot@archiver.kernel.org>; Wed, 24 Dec 2025 19:38:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 311AF84319;
	Wed, 24 Dec 2025 20:37:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mnAgOA9j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6E2E842FC; Wed, 24 Dec 2025 20:32:33 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56D64842B7
 for <u-boot@lists.denx.de>; Wed, 24 Dec 2025 20:32:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=george.mccollister@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7c75387bb27so2550055a34.1
 for <u-boot@lists.denx.de>; Wed, 24 Dec 2025 11:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766604750; x=1767209550; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mnYyL3t/GTmHYUTa9QepBA42KB6l6/Z4drmBQzUPYmI=;
 b=mnAgOA9jXWAxrrrbPZnWfvhAPwDjMSHZo9J5N34ZSYpXFUlo1JLI49OtXrcXNvlaP1
 2Ds28KBMQKztT/KR8AnwGFrfuqAycecmO1wN+mth+4ZUhNdw27zYynb5THgG223y7Ec3
 SPqwuPQEWMExczvj93zk9KTqxkO++oYYdgIVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766604750; x=1767209550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mnYyL3t/GTmHYUTa9QepBA42KB6l6/Z4drmBQzUPYmI=;
 b=imQ62Gvck/n3QeBRXElUvUFOnV/wxm0z/HNWeaTtdU8YEIGZmIuoVTBpwb/Rsh6nLV
 07hULIimuH/LUCNqIGR0TNWyuUs7lBbanzEN6Ff7prUjwKwryE+lTSo7vZBtJa/Y74VT
 3JekK3gjwlQOltm3GP5MINxtUViukqnulHTHlBD2u9ZSmYwOHksBubKwMEgYxyyK44Bm
 uwny9K5Mve6ThiIkwfYD+zJjbCuLUipwqffkvlgVuN3i+3Jh3eXpOME43y31fj8lok8n
 OAFF5sjFBkHojLo5kEytRV+VLqFXoRKF0zQQ+E8M5mh3ywB1CwplS3c2mJZZupqrpXS/
 BZyA==
X-Gm-Message-State: AOJu0Yyo1AzWZCKYcKkV4aLLcLLxxqQ/LH5xozjfskxXO1q2FoWcFzZV
 hz47hZwED7PEWRw8Exn6o32oGVYtyK260Z0Y0SIxBsUNKVT+zhTLTsmII/L95SDAqhHJcSwUkqb
 N0j3Bl14=
X-Gm-Gg: AY/fxX78QwuTiLu3JFaflpg1AAi+FtlJSUExuOhIPvuZDShRIDkP3H8qcsCp4WT7Dah
 76nhvEXozPjKQGBTKXYJ0aQgFxGvlYiW1olzUj6uHC2xzguePc/fALRFy1w9xHJeSg+y9Q5kGwJ
 bHUG04Tr5OvwFCWFGuTcLKmuSGjyqJ9xfRe806REMMbCvtTdzEd9SSrP/phM/tc1xvA9mTGE3ib
 7z22WroOrgdAORjNJzGJ4cer4PpDfCVlcRCHIPG3OL/OVU6TdORQbCYIRffnnoQLdoyQa70nbUb
 9TV/+P718BRd7WPTev01+6JPVCAZ6xPzwhSoa7onHatoqxQ7KobmQrgJjVErKeP2mixsYP+K+3n
 +O6c6lxRmS35VBGWXPjoklpWjnJiltDPTUZxa7Flu5aId1IWsX6pKoJ2rqvTHK7ImZdB2NsPAzC
 uej96UahgevgMrjivboKvvBJuOorG9L7DY+yy2Ez0xHHL7IA==
X-Google-Smtp-Source: AGHT+IHJfB85rfDI1qi/jc8pg7RCLdPuDR9+9jqU3SxnzQ1IYyAcu6JfVPJXNqkzL8/uyTmImIL74w==
X-Received: by 2002:a05:6830:2e05:b0:7c7:2df4:faa3 with SMTP id
 46e09a7af769-7cc66aa23fdmr8841760a34.33.1766604749825; 
 Wed, 24 Dec 2025 11:32:29 -0800 (PST)
Received: from ryzen.localdomain ([136.33.243.183])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cc6673bc05sm12049723a34.8.2025.12.24.11.32.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Dec 2025 11:32:29 -0800 (PST)
From: George McCollister <george.mccollister@konsulko.com>
To: u-boot@lists.denx.de
Cc: Bryan Brattlof <bb@ti.com>,
 George McCollister <george.mccollister@konsulko.com>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 4/6] pci: pcie_cdns_ti: Add support to provide refclk to PCIe
 connector
Date: Wed, 24 Dec 2025 13:32:02 -0600
Message-ID: <20251224193213.802246-5-george.mccollister@konsulko.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251224193213.802246-1-george.mccollister@konsulko.com>
References: <20251224193213.802246-1-george.mccollister@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 24 Dec 2025 20:37:54 +0100
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

Add support to provide refclk to PCIe connector.

Based on: https://lore.kernel.org/r/20210308063550.6227-5-kishon@ti.com

Signed-off-by: George McCollister <george.mccollister@konsulko.com>
---

 drivers/pci/pcie_cdns_ti.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pci/pcie_cdns_ti.c b/drivers/pci/pcie_cdns_ti.c
index 9d1d123a18cb..ff56ba3930c6 100644
--- a/drivers/pci/pcie_cdns_ti.c
+++ b/drivers/pci/pcie_cdns_ti.c
@@ -742,6 +742,20 @@ static int pcie_cdns_ti_probe(struct udevice *dev)
 	}
 	generic_phy_reset(&serdes);
 	generic_phy_init(&serdes);
+
+	clk = devm_clk_get_optional(dev, "pcie_refclk");
+	if (IS_ERR(clk)) {
+		ret = PTR_ERR(clk);
+		dev_err(dev, "failed to get pcie_refclk\n");
+		return ret;
+	}
+
+	ret = clk_prepare_enable(clk);
+	if (ret) {
+		dev_err(dev, "failed to enable pcie_refclk\n");
+		return ret;
+	}
+
 	generic_phy_power_on(&serdes);
 
 	ret = pcie_cdns_ti_ctrl_init(pcie);
-- 
2.51.2

