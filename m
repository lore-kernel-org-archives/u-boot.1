Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10C25E7E0D0
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 18:12:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DE1C83C65;
	Mon,  9 Feb 2026 19:12:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BROCj2Ro";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0666383CBD; Mon,  9 Feb 2026 19:12:06 +0100 (CET)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D90983C5E
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 19:12:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-59e3810df30so5478286e87.0
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 10:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770660721; x=1771265521; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ot2NVwtmgs0XqE/spxXwYxLoUInx0SZ8WzmxlqwpmNI=;
 b=BROCj2Roc792adc/gohmpzvnkaZeYCH8UH/u5s+1fUUZ/Dz4hqqxw8ig/CuKiipVBh
 H2vNwR5UWrggwCrb+KvTEb/kenQBZU1SM7wkSZmp+cnVPtS3dXB2sHa/zWqIrk+qgEmW
 xbP4ZwBHYi5UtzRv6MD4PqJPiX5cJ5VQ9bJ6C3alCVTMcplVxnrgrfCSLHCOCX41q/QK
 EBmRPMXrJES7l6NlWv2dxj89lmbprZlP78WInhBJm3p+E8xIpl7ZFbgjFwoNz1L5rJOi
 gyG9HpdYGQoxtUBInZsXjOoOWthDR5PeUv1AgDvAckKrUAHAcYkZIUpbSo2h4rgRNokL
 86bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770660721; x=1771265521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ot2NVwtmgs0XqE/spxXwYxLoUInx0SZ8WzmxlqwpmNI=;
 b=v5sV29ZpNUA5J1uM2Yxle5B5Jk0R6BDIig3wCfDK8J49NClmxzompOqQ7xb9VXH0LX
 4YNQuMl+XJdDxWG1/RIBgVYGuRx1U6PbZUQ4Gx9F1+TMKBuKBivLzOv06n9f39bkEzhh
 zxNrUJoXrSCUNlYsskt5XwhBmJkusR5ZN9uIzhzlpnO0RbwDSe3YvHUxjJAWRqlRfLVP
 gnJuGE+whVWZKWRGXNd63y+F7NgbjPNEO0DsqI7lZ7fcukhMlqyVgjjWEO3IXF4ql0VO
 eUaV9ElP6nueHtGGVL9rS/W4WYDYq2BB4/aH67/n0RLZIqKr8UB8t5QGGi5FF0+nfZQc
 l7/A==
X-Gm-Message-State: AOJu0Ywdk6vLRWJWomWKMFmjoI7Zft/TpGH9bObQojVAwLzkaZ3RjrbQ
 2wuiWElZZ40nBymY5QPKfDofw7uPYptJy8JOhiqmWpCYbiJs50dffp9E
X-Gm-Gg: AZuq6aIolnsK6JZ/U1uooAC8T2Dg5TrREeDC1X496tCAZMidqpeCJm0oCXW7AbH7yhn
 XEtnTH6YRvPDaDR/JzmrJIQi10sW4LNoA+MnozcenkkHDyy/X1Oqi1+GZWLVyAHibT4As8WtxaF
 pxgJOTT2Zub7X0rGS9SonqW9DY2MC2lVsh85TM8VpUsSkviuqcrhCk2Tc31DSYW+FUWX+pstYkq
 OP2z4R+7S5FwV1yO3u5Mb+yHnhh0XLmGNVDb68Za6ANqT6ioD7H+KxkKlYuI0kM90NvTbYLaoq6
 MNR/9jzd58ofu38zuEkwAHuTU+yCCn+K7a05uEh02o7aOH346cgGNOZP8scSAZxdnaMqUrG8/Aq
 QQgyZTW9dtn93jDYr7K2Cpp1hXUV7jcPGw+WHQgEx1rwxBR6OuYV2HoRL/g8mcqruOvQK+wiWTV
 T0
X-Received: by 2002:a05:6512:39d4:b0:59d:e65a:26ba with SMTP id
 2adb3069b0e04-59e45152d78mr4088657e87.27.1770660721289; 
 Mon, 09 Feb 2026 10:12:01 -0800 (PST)
Received: from xeon ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-59e44e25e4bsm2792801e87.88.2026.02.09.10.12.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 10:12:00 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 2/5] power: pmic: cpcap: add Mapphone and Mot compatibles
Date: Mon,  9 Feb 2026 20:11:46 +0200
Message-ID: <20260209181149.32714-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209181149.32714-1-clamor95@gmail.com>
References: <20260209181149.32714-1-clamor95@gmail.com>
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

Add Mapphone and Mot compatibles supported by Linux kernel.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/power/pmic/cpcap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/pmic/cpcap.c b/drivers/power/pmic/cpcap.c
index f2076afff43..2fbbc7e80f0 100644
--- a/drivers/power/pmic/cpcap.c
+++ b/drivers/power/pmic/cpcap.c
@@ -112,6 +112,8 @@ static struct dm_pmic_ops cpcap_ops = {
 static const struct udevice_id cpcap_ids[] = {
 	{ .compatible = "motorola,cpcap" },
 	{ .compatible = "st,6556002" },
+	{ .compatible = "motorola,mapphone-cpcap" },
+	{ .compatible = "motorola,mot-cpcap" },
 	{ }
 };
 
-- 
2.51.0

