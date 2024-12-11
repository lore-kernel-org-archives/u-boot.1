Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61544E7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 16:32:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21ADC803D1;
	Wed, 11 Dec 2024 17:32:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="bi9yI5TE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A83AA803C7; Wed, 11 Dec 2024 17:32:11 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88FEA803AE
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 17:32:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5D55A3F467
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 16:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1733934722;
 bh=boLrYZCctI7yuyeGxQPh0oE1hQgzNY9JJCIuChFhkus=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=bi9yI5TEpggxx6wIOM5LA6cLIJXK9hRSJYcDD6U82t0dwmwQZGoRSJ/aZAd3Iu9Ul
 feTYFAq/nrneBZftQE7r2ZjMOQLi41+QW9+obDjrUsOboofbb8KDoRMqkZjfDxVSpb
 vUpndm5ubsF98dR/+ySQAjVf9Af5PJRWOBnkISwTkO4PJif74quAAYrGxeK5D8wnvC
 nmArYTfFivJ5jCGNJBFACKGBcwoLh0QWkBOXgzGJ3P7+vSCyqqY0e3EEskVa5l1eR5
 ztAfE+lOUJdn+oeaisKCckR9ilkJTUjosEOYWQStVYodu4felZLlcqxOFgJbaKNNDu
 xMTq3kQQhs8Pw==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4361b090d23so8467725e9.0
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 08:32:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934720; x=1734539520;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=boLrYZCctI7yuyeGxQPh0oE1hQgzNY9JJCIuChFhkus=;
 b=BERGv5bT7BtuWkMyK0p8bsnkMSRRU/ayd5KboZB/9MrgOcMDt6hpRNhoowbUa47fdE
 bI12UStxbJcxatCQtZ+9Bh0QrVB59IoMRolJZMXRyUj/Ehbh2axvwjg8Xk5f4cazuFhu
 BjqmNOxzwFbVpigpNP57WB5MtTDBy5d2prRikpphG7Z5rPOQkJdhLtHc/lJY6IUoIbxT
 kcKo6JxpAiKGlKyfXTy4HrH/lNOC8Lowr8RMHojDKy9IDjcDfn0zU+OaS9403Z/ceLDl
 PsLQLTeAZRJas9B55eU+bW0t7+rY8tUIPnHn0GsGvl1ihvu5pNlKZPeqDZb4SL+A1ddP
 zMoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1p7DpjmkXvZgeCi27RhgatKDG1W7Uh1wQIf508cBjsFGtEeV4ygT7/C9DDSohYRMvPx+xThY=@lists.denx.de
X-Gm-Message-State: AOJu0YxiyuJaavri5qeK46FYuxXmII9IhzfYeVX36yrnsnrNlBEFKvRt
 JW3glK7SlqPbmZ7uPLVoY75NRUVc1Ps5pOnXPmZOWReqyUX4ksLYthjiVEkB03whgJ4NTagZ22N
 u6LPYOQBSSJQydCYKwmQT/4muQ7UJo252jx8iC+Ohz2e/Kk0CiP6X6nu8NY53CNVwHY0=
X-Gm-Gg: ASbGnct2xhZR7+a7LK6Gu1K+zcJnZxrY6yLh8MmwQgePhD3o0gQD2dmaIYFGTg2A4fj
 NrdKVfgBG40XWe9JSnnjRtT4mdAGIGUbBf0o7XdCRr5cGUdkD/owY5wA2AWfDSKpOfEBcGwvlvC
 MUS+6eCmLwwHoRGDN72ndavs+N8DK6KLPt+eNalc0jqnDB9O85RgFvQxJh1T1++/q3wCviBAxnj
 yeCVh8dDtP3wtlP++xUBW+ROSIuw9tcpTyToJ+WCt3NIdxhILw3NRDlfKKlNpKa/q4MDdD83bhN
 /XmqpYkf1HZpDrqYg28oc6uNj+Y6h8a/jC07Ef3vKPm/tEB2bLntioLi
X-Received: by 2002:a05:600c:468b:b0:434:a968:89a3 with SMTP id
 5b1f17b1804b1-4361c35ceffmr27494685e9.9.1733934720690; 
 Wed, 11 Dec 2024 08:32:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHA7iaXWiKsyPc8QgnbjRkmEnT9YiaSUx4gW4VbG+TeuEVMsnod3cnCTpSjcPAiXWRhOF+ujA==
X-Received: by 2002:a05:600c:468b:b0:434:a968:89a3 with SMTP id
 5b1f17b1804b1-4361c35ceffmr27494435e9.9.1733934720352; 
 Wed, 11 Dec 2024 08:32:00 -0800 (PST)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3878248f521sm1627311f8f.16.2024.12.11.08.31.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:31:59 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Ashish Kumar <Ashish.Kumar@nxp.com>, Gaurav Jain <gaurav.jain@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Jason Liu <jason.hui.liu@nxp.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/3] board: freescale: typo volatge
Date: Wed, 11 Dec 2024 17:31:52 +0100
Message-ID: <20241211163154.56272-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

%s/volatge/voltage/g

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 board/freescale/ls1088a/ls1088a.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/board/freescale/ls1088a/ls1088a.c b/board/freescale/ls1088a/ls1088a.c
index 9f4eb4811d9..9606434e8ff 100644
--- a/board/freescale/ls1088a/ls1088a.c
+++ b/board/freescale/ls1088a/ls1088a.c
@@ -690,7 +690,7 @@ int get_serdes_volt(void)
 	dm_i2c_read(dev, PMBUS_CMD_READ_VOUT, (void *)&vcode, 2);
 #endif
 	if (ret) {
-		printf("VID: failed to read the volatge\n");
+		printf("VID: failed to read the voltage\n");
 		return ret;
 	}
 
@@ -716,11 +716,11 @@ int set_serdes_volt(int svdd)
 				   (void *)&buff, 5);
 #endif
 	if (ret) {
-		printf("VID: I2C failed to write to the volatge regulator\n");
+		printf("VID: I2C failed to write to the voltage regulator\n");
 		return -1;
 	}
 
-	/* Wait for the volatge to get to the desired value */
+	/* Wait for the voltage to get to the desired value */
 	do {
 		vdd_last = get_serdes_volt();
 		if (vdd_last < 0) {
@@ -778,7 +778,7 @@ int set_serdes_volt(int svdd)
 		return -1;
 	}
 
-	/* Wait for the volatge to get to the desired value */
+	/* Wait for the voltage to get to the desired value */
 	udelay(10000);
 
 	return 1;
-- 
2.45.2

