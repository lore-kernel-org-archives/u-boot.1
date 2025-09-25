Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2FC9CAC5B5
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 20:56:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BB1E830CA;
	Thu, 25 Sep 2025 22:56:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AlqO7i1V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 641D08362A; Thu, 25 Sep 2025 22:56:27 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1007B835FE
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 22:56:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-30cce872d9cso1477570fac.1
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 13:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758833784; x=1759438584; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=HNimXRJPgHz/aY/lZadFqXEcFtcSXHH+7/Ef9Qng4XE=;
 b=AlqO7i1VvvGPpWROklhXVJGNISLfgyWIpFGi6I7lzBmI7lrF0ez1gKMYDePLKV/NPJ
 WUrXgS23jo6uys3n69dCuur68FbLJbyB/0lGf/KiYh3eIsDgtq+w87vjLtGkMdI1dYLx
 Erw1iTVQClZ4lGvaCX2v7RpudTLoMulGO7v/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758833784; x=1759438584;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HNimXRJPgHz/aY/lZadFqXEcFtcSXHH+7/Ef9Qng4XE=;
 b=uAAvaLgjykT++vktrzMRPOlHvuriE2ZVFk1hG7WWraD4DEywtnCGoNakoIvzJ3VAiQ
 SZu68aRLKReKn96qfwwji/mFB6CE5tJ/BIzTqOQxTuD9Hcj2S+V2OIljCxQ2N61+hHWG
 TnzsBlAQHUmOnEhk+J40gCLnIhKjwqR0VqTKXHU+8f5VYKoTC55xEFeOTQNSol0SIajP
 uxeeC4TXk4RL9FyfWPZeorSOAAnVE9s7mPlckfc9Zf0pqi/nfBBJCENe3XQTRugLupbY
 jSsQmiI33P1iLbtlAx1u437MONErqkAj7fHHrccFwV+jqXSv0gzQE9yg7fSLHFRqnb9a
 2mDQ==
X-Gm-Message-State: AOJu0Yxr22349CSeFufI2tEDBe+Dv0qfgLZwabLkWGDz5b20FFVwLZjQ
 TWStOKR5/URXPxMAIivm+XBB0OI/5HqONjNSVBf6l3vrjr8tS9EL8aZhikH6Fze56sgeTz2470g
 QjY5xStU=
X-Gm-Gg: ASbGncs/bw7kZuo1QloQhPcOcaL7gs8qrMbJNXXnLHAPtcU31ZEcOYGv5zCtv+PLulf
 +hJSLaQz51NjbhEkAv8VXzpfOKBfHdDqP+d7Zul3FZPyukdCODb1wOQM+/OdOWISmcu6MLQnRVs
 8HMtY3htlYQ6g+OkwPPgSy6rfWSd7WIS49jvCjUIaIBBN8pAdxMv/44bl6bVAIlmpIrtB2u4IwY
 RTTpvzvEiMC7fUjcTxNc6VUYQin82gwuRT5aexX+zdqxgu427j6K1FmYxuWlcm2CVGxcbY9/lRP
 mf/Y8Cmnq7qJdnBKWHVN+SmdXCYn30oDax8OLZnzHMCGKWjJfU01uvN5CP39PbIXtPV40dJDPEr
 SRYO+4fJvNydsNnXD6esCZiclZDYv1CmJs604RLu/t0vUgZ8jrfKCRhdHGAIrjARY2RB5ow==
X-Google-Smtp-Source: AGHT+IFf4nIYcbl7Oln/WwMX2MQRKWCAAoH6PPN7piXQ6L4wKKszKOEP8nE4zRNuOJpi4fggkNKLsA==
X-Received: by 2002:a05:6871:2b04:b0:2d6:2a40:fb9d with SMTP id
 586e51a60fabf-35ee7f96c25mr2118421fac.28.1758833783713; 
 Thu, 25 Sep 2025 13:56:23 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-363a15c03dcsm846339fac.4.2025.09.25.13.56.20
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 13:56:21 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] thermal: Make U_BOOT_DRIVER entries unique
Date: Thu, 25 Sep 2025 14:56:20 -0600
Message-ID: <20250925205620.3562599-1-trini@konsulko.com>
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

All instances of the U_BOOT_DRIVER must use a unique name or they will
lead to link time failures due to name space conflicts when both are
present. In this case the driver was reusing the ti_bandgap name.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/thermal/ti-lm74.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/ti-lm74.c b/drivers/thermal/ti-lm74.c
index 7d56f75df064..0310d3330c01 100644
--- a/drivers/thermal/ti-lm74.c
+++ b/drivers/thermal/ti-lm74.c
@@ -44,7 +44,7 @@ static const struct udevice_id of_ti_lm74_match[] = {
 	{},
 };
 
-U_BOOT_DRIVER(ti_bandgap_thermal) = {
+U_BOOT_DRIVER(ti_lm74_thermal) = {
 	.name	= "ti_lm74_thermal",
 	.id	= UCLASS_THERMAL,
 	.ops	= &ti_lm74_ops,
-- 
2.43.0

