Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5BD5C27C4F
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 12:45:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA94F88907;
	Thu, 13 Jun 2024 14:44:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OjQy1RZ2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC773888F2; Thu, 13 Jun 2024 13:10:34 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFCD3888F6
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 13:10:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a6ef8bf500dso102236766b.0
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 04:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718277032; x=1718881832; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xFqKPNJ72o9/wknPsjhm4e1xJFjgwdxeCZsRwZeeCQA=;
 b=OjQy1RZ29xjC2dAIp4x8h3IajD+ErHZXS3qWc3hCJeQ7ZTkMhXIYfFbbjODzrbwSse
 lAO9uBC/VQ9LWWmwliA68wzLFW4X2dJjvDwjZjfrDyL3rw2vA2gPIzMwPA/MMS0SwVji
 sRLbjcTLjUzKRdTJuoQCn/8UNL3vkhcDenzwFNtTEfcSggIscaL2lYjB9icBh0VVveOA
 umJzSG+415wguVQ0c4kMBr19scWi/xFh/kChwdW4dHqz28W9U5d0+zHN+wP56KBl8YUo
 z0rvOagIOH1LeDwEjQWRfKKa5iJBm+vCJZnH9g8UtcbdIxWcmErEc5RTJHsN6xJYhR9b
 HUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718277032; x=1718881832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xFqKPNJ72o9/wknPsjhm4e1xJFjgwdxeCZsRwZeeCQA=;
 b=Q/oPI68d+dIf60W3HVjm6qWcL5h0FeWy4tYvLReZziSyVhM4Vm+44RseQ2o6CnQSHA
 WZXp3K+G0N8W9+uNUhXytzL1nDVjrI+nuwMrVSeM0hB1W+P3ycV0svSskS4UvX+aqy7+
 by0nPQGwor3SQygoojBEQSXXvQ2yZ/uQryvSlZm4E8Ek0xIXR6QOBalnDu2MvzlG3FtR
 9ZqX4pDI44OAdBTU8BJB2ZiSIp0bg/GY53uEofMy2tiBRaW8CsLxQgtlv5L8R/c4i0T2
 7+0OIE0bfFHwg3EUNSmfOJ1zfcLNDYl+EsxdYDrPaIKOojJHkIDcGdpQEK57CLlru71t
 4ntA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX01GeA9dqaixl53BoxhVaz9YlOQCsQ+EuRd59yl+k+O7dm2Kqh/Km3sHVS9wUt3vJ5cunljEZYTRl3j+1dRWncwIKEVw==
X-Gm-Message-State: AOJu0Ywd0ATAfxsv5TR20bMiJnJADWtAFZ4Dw/rVqIBN9EswuQo5+4DB
 pIyih7vDjVBqm3HYEDjv++yDxbYBHvOHdsXJ/gxC67IR9sGCWzFp
X-Google-Smtp-Source: AGHT+IFErzAgeuaHpt3Hh+LQN/qLXxRbTiRmrhbKs7741ahIDyvhTulxygRyVl+a0P3en3vO+TWhSg==
X-Received: by 2002:a17:906:f109:b0:a6e:f3d7:4107 with SMTP id
 a640c23a62f3a-a6f47f80572mr299945866b.72.1718277032124; 
 Thu, 13 Jun 2024 04:10:32 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-a6f56f416dfsm60580366b.164.2024.06.13.04.10.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 04:10:31 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Heiko Schocher <hs@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Bin Meng <bmeng.cn@gmail.com>,
 Sergei Antonov <saproj@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Simon Glass <sjg@chromium.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Mason Huo <mason.huo@starfivetech.com>,
 Mark Kettenis <kettenis@openbsd.org>, Sumit Garg <sumit.garg@linaro.org>,
 John Crispin <john@phrozen.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Minda Chen <minda.chen@starfivetech.com>, Marek Vasut <marex@denx.de>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Stefan Roese <sr@denx.de>, Peter Robinson <pbrobinson@gmail.com>,
 Sam Shih <sam.shih@mediatek.com>, u-boot@lists.denx.de
Subject: [PATCH v2 11/14] pinctrl: mediatek: mt7981: init device before
 relocation
Date: Thu, 13 Jun 2024 13:09:29 +0200
Message-ID: <20240613110949.11076-12-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240613110949.11076-1-ansuelsmth@gmail.com>
References: <20240613110949.11076-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 13 Jun 2024 14:43:53 +0200
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

Upstream kernel linux define pinctrl for uart0, hence this pin group
and pinctrl driver is needed before relocation. Add DM_FLAG_PRE_RELOC
flag to init and mute mtk_serial error on early serial init.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/pinctrl/mediatek/pinctrl-mt7981.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt7981.c b/drivers/pinctrl/mediatek/pinctrl-mt7981.c
index 3fa198ed79c..4bc4abe6518 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt7981.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt7981.c
@@ -1050,4 +1050,5 @@ U_BOOT_DRIVER(mt7981_pinctrl) = {
 	.ops = &mtk_pinctrl_ops,
 	.probe = mtk_pinctrl_mt7981_probe,
 	.priv_auto = sizeof(struct mtk_pinctrl_priv),
+	.flags = DM_FLAG_PRE_RELOC,
 };
-- 
2.43.0

