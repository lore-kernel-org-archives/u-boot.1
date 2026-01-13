Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9CEBD2D11E
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 14:50:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C6E5800AE;
	Tue, 13 Jan 2026 15:50:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NkIdbqIh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB3ED800B6; Tue, 13 Jan 2026 15:50:36 +0100 (CET)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 976B580050
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 15:50:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-65d132240acso4665948eaf.1
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 06:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768315833; x=1768920633; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=g1nQJQaes8E2dZwpEGRXBKF/VeSOmVFXpWKS9RJ6cXU=;
 b=NkIdbqIh8YA5u23KOAPsryGjsKHbgaYwkgD4yCiHtzESbYkOPVLZ4QMzd63HpKADvb
 bRuLQEBmFzkaOG5/AnFKlHoJgpPPBHOa9Hzy0OOMh/0pKeja5rdiBIepieF4l+3eN4oP
 lvQO/LDg3zQ/17dLN6w5f9lFWK72mMR40/R/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768315833; x=1768920633;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g1nQJQaes8E2dZwpEGRXBKF/VeSOmVFXpWKS9RJ6cXU=;
 b=aouRXAN1XF2FQEW2Erf6ZclMbFImMKA6FucoYE2OQuZh2Kq/UuCyLMu3XanBESIrPo
 V2Wm50XM1jnJFfYyyQl9GRezPLfvlEmm9LRPVHRKZQpRCTQpjJeU8nAzPTgViodZNj9N
 RrVRLR6HsO/MGmRcjW49EyZpORbNSNSm8FkosR32MGl2qKNJMdDTYMtF2fcO4iH51tjc
 DcpF5q7wFU4DeQXjQaTn1z1/srfzjh9yt32gUPyXBas8i/aDICdVYSqeOHSPz2csjHSA
 ET7UpEO4vu2/PKdgPF/XX1Te7tDrQZu6kc4GYdOeR/2OX80+3UCXPrrNoiC1Le2GKPu3
 dgEg==
X-Gm-Message-State: AOJu0YzM+ynByjVfnrXQuQFs44DxeBVRnU4MAdZt5CS/IXDyP7HuKvZ5
 1tSNd69KGEpcwxq1h3MCvragqVUeINGaOTV3UhH+UqO2k6nYzrOj5Od2PmzNSTm/ypG3UWmeTE4
 g0v35L8g=
X-Gm-Gg: AY/fxX6maVTjkRgo8AO7VEXPNfVLK2byke8pGG2KrAZnYhCSTB2ZV+zNz7IgFdYs542
 UWFd9vUKRqEBBzO5gwaBJXLiw3oLMPVc7G0wdNg7dydDFt6UxV0pmRtFyD6kzhWJUodrQ+der8Z
 OckGJINX8vnrj9iztWgAXVhooYrol/O3ZOH0fF6XxohN9o8Iz031RxP41Vc0tpnu7k306bbvQON
 NTvWVS4/lfz2lPaj4QBVRuOu2+Y9Wcwm93mQ3iAuC+32UlShLJ1bzqSsfO54hVVTwEJHiYgi/Me
 YdkN36Ju78rU6/huB8te7B60b9lij8LyB6VAsZUZJB+pI8UgA36JS28K+T7DV0RWZT088+KpVHJ
 Ay4MVQYM3cVpBnaCvWxh9/XEH+nPOXeNIjXLh/Q4W+Ebx1e1G+SYL2Vsh8dnIC9rKWmP2TLbbbm
 w/0reqrJSlEVuAZsb5/tpnPRspm9p8+7Dv/FuZNqbZuyjqVbsHbg6IVS5APta9CET1ur4P0ty/G
 9DLV6V6wOFPlIutw0PYs7W8mRTpysJ1iK3BaN49dg==
X-Google-Smtp-Source: AGHT+IHQInzeiW07r835Mr4++kyvG7s6ScJ206JIyvbIVSBCBbUc0SWnnQdpNbbfYBAKxBdxxPci8A==
X-Received: by 2002:a05:6820:658a:b0:65f:1296:7690 with SMTP id
 006d021491bc7-65f5508802dmr8082331eaf.83.1768315833367; 
 Tue, 13 Jan 2026 06:50:33 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65f48cb131asm8850613eaf.9.2026.01.13.06.50.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 06:50:32 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH] doc: Update urllib3 version for building
Date: Tue, 13 Jan 2026 08:50:31 -0600
Message-ID: <20260113145031.2030859-1-trini@konsulko.com>
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

The GitHub dependabot tool has reported one "high" priority bug,
CVE-2026-21441, with this package. Update to the patched version.

Reported-by: GitHub dependabot
Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 doc/sphinx/requirements.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/sphinx/requirements.txt b/doc/sphinx/requirements.txt
index dd433e2bb156..e313e4f09468 100644
--- a/doc/sphinx/requirements.txt
+++ b/doc/sphinx/requirements.txt
@@ -24,4 +24,4 @@ sphinxcontrib-jquery==4.1
 sphinxcontrib-jsmath==1.0.1
 sphinxcontrib-qthelp==2.0.0
 sphinxcontrib-serializinghtml==2.0.0
-urllib3==2.6.0
+urllib3==2.6.3
-- 
2.43.0

