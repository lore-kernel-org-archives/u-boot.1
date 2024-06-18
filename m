Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB9B5C2BA18
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 14:58:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5962F88263;
	Tue, 18 Jun 2024 16:58:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HPULProc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A51CB88204; Tue, 18 Jun 2024 16:58:41 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9AD98838E
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 16:58:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-57d0699fd02so34301a12.0
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 07:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718722718; x=1719327518; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=o1K8xV0vnW2i9kLt8X+1mRCYkaqXwgzJer4r36WS63A=;
 b=HPULProcgzsTO/5q+mTx4ltQ52LaICKXxi5+aZCsWA2C7clcSvlF7o5yc9fF8BL2ud
 zBMVF+mA7ypAiRoJoKyOqiwbzTARyPnxhkiN0Xy25G8bWU8LNE78HcByxYrWruAx0ThX
 jI1Uneh8WDfvBPSg56UL8H3khv1vd2I5QbNH4RQ4dL9w0L9hnQyc5KfGE8/iwqwLzWxq
 9CUcAfQftOwFO1xUcKawHRa4JSO4dYPp1TBAGK2g5f43e301JkJ+nw441Mu+7oFbse9d
 +zkh70I7w7T1ES0Fy4pnskgYEbnTgSKMBHX89fCRyBMgER05GMSCzNR6pZIjXX/JeGxR
 Pl7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718722718; x=1719327518;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o1K8xV0vnW2i9kLt8X+1mRCYkaqXwgzJer4r36WS63A=;
 b=v/Q5HSX2/SJwlJqnjpcPayLzZ5Pv8Tua3lvd+D0+t6wZKUyweBwKapE9JcGjyPax8S
 sUuGH5OYZMObg3BXAvUbVh/sTsu3Srj0+ukB1ZUsuNzorqOV0rNIahvV6HqbVGOpsnzZ
 O/sfeu7PeGb1FJYpRl05nTPE+GaxeopftG8LWNGr0VlFJf+a6LTM5cVCouPRTLeeCWn6
 2rSVSUkLXngDs3z/ISR9faXwJNz4xVZc/pZSiAexx5I+NnH7X7ihmqc6f/4IIZSN5ch8
 y3ym3jAd4jYmy/Bi7NEk3GLpmQkTgIDNQsYMAm5nG8Dixpk2z5a1IgWCHzEE6yU8a3t1
 auzA==
X-Gm-Message-State: AOJu0YwPXfAo4pncNb3oobZ2RIbQzHUu92BdD+noICFStAJltV2PEUKh
 rq1kJBN8D/74H+VeRUDB/w0QeDShlePF8zunnCugFqyVulxqbMRls4uuuDo7tJgVg3ZEJGFMkAN
 Ml+FFsA==
X-Google-Smtp-Source: AGHT+IE3fx/+PKtuS8U+qqqQ5ZAwocZ0QuQ9Dfk9ABFBNKvnl9OCP/xpOi4q0kphI7e/uInxH6LjlA==
X-Received: by 2002:a50:9ea9:0:b0:57d:669:caf2 with SMTP id
 4fb4d7f45d1cf-57d0669cbd3mr137734a12.25.1718722718061; 
 Tue, 18 Jun 2024 07:58:38 -0700 (PDT)
Received: from cymric.caleb.rex.connolly.tech ([2a02:8109:aa0d:be00::52af])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57cb72da824sm7831523a12.29.2024.06.18.07.58.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 07:58:37 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH] eth: asix88179: reset during probe
Date: Tue, 18 Jun 2024 16:57:57 +0200
Message-ID: <20240618145759.3296876-2-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.45.0
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

In some cases (consistently in my case with an embedded board) the
ethernet controller will time out on the first init but always succeed
after reset.

Let's reset the controller during probe so we always start with it in a
known state, and don't have wait for the first asix_wait_link() to
time out.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
I see this behaviour consistently across three Qualcomm platforms that use this
controller.
---
 drivers/usb/eth/asix88179.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/eth/asix88179.c b/drivers/usb/eth/asix88179.c
index 7bfd285b3aa4..a0aa5c25e428 100644
--- a/drivers/usb/eth/asix88179.c
+++ b/drivers/usb/eth/asix88179.c
@@ -628,8 +628,14 @@ static int ax88179_eth_probe(struct udevice *dev)
 
 	usb_dev = priv->ueth.pusb_dev;
 	priv->maxpacketsize = usb_dev->epmaxpacketout[AX_ENDPOINT_OUT];
 
+	ret = asix_basic_reset(&priv->ueth, priv);
+	if (ret) {
+		printf("Failed to reset ethernet device\n");
+		return ret;
+	}
+
 	/* Get the MAC address */
 	ret = asix_read_mac(&priv->ueth, pdata->enetaddr);
 	if (ret)
 		return ret;
-- 
2.45.0

