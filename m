Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07DCEC83038
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 01:05:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3468282FCA;
	Wed,  2 Jul 2025 03:04:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oe6hklrl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60F4582FAB; Wed,  2 Jul 2025 03:04:21 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94A3081E13
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 03:04:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-408d7e2b040so3835583b6e.2
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 18:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751418257; x=1752023057; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=HyKQrennFr+W0G4HBcH8V8PmegK8Q0rbU1/hXPmy48M=;
 b=oe6hklrl1Pphkq8EIV8PK+1bqkCY6GaCiB/Fymy43Uv6JYKCJuUhGAYJGaLBuwsSeu
 2cUlPsUGi4NU0qFP0UO3G8pGYJ0aIBueOC/RYxPxDWPDkkoidpFf3JA7J4AeG5x2bzU8
 IC440NaincKYCgYJESm9PkDSxdv8dVIz11Xk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751418257; x=1752023057;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HyKQrennFr+W0G4HBcH8V8PmegK8Q0rbU1/hXPmy48M=;
 b=amTiirGKawhcg8UfQp6dEEI6i9pcpbbb/9ZDYAZ9ODv3votyQMAWyuaaYxTt0PvVtI
 hR97imOH6bC2bRbgrzeNvUPrMt2XMmslcU7c+p+bS0KKAMG8KXySJHgnpsr+Rcg9Kj9g
 3bHJfM7O7ySS/ppYEfS2qoSEeptcakayEZs8xjvNAq1bAYJhmjFsYWnlLNPtIaiC57rp
 /Vy6uHBXZznWmQ+FJvsO5IaIJmX9AZZkAfmEnP+Sf8CkKHjMFgX+adJo7QVRGb3AFFGe
 DRYe6ZjUF3SNcM1uIOaLLj75yb/L4QE1fwZHCMlm+1/GD7pDs9hl0fBhWP8dQcMBPzE+
 h3GQ==
X-Gm-Message-State: AOJu0YytXNOjpCGAYoLMkrVIcM/c9Re77qaQ0E4ssnRwN6EKXFsXr1N+
 Mcq5Cz6sWxcbXbHbXpAabIktom5pb6+DbvxqjuN1tN2H9nv77LQWThbQCTUVgOjZC40W8Dv/ERq
 QYlaz4/k=
X-Gm-Gg: ASbGncuymqqzkE0c6oCzKNoDQkp/jCOImHSCm/Orm12PtACUmeJ2Vi/vKjxEr05SRfX
 gGdAD0Y2IczG+3quKdomLSm/T4XBs831c36ZzMWcvZhfLlZ1/XJyphHpSQ3k5neYZIfxktax+VL
 zS/aKk8Gl6BOS14dTx0n5fM+Q2aw3AXsUopTOKeNYe+zDZ2ouhZArF28OkyL/hRys6xxCXirQhZ
 4hlVmzezlH0fxFE3GCEkcpjR7Ze5czF/nnfTe3jw/1Nh223/SJgLg07lX/S0p8cFrRkUJqKJswu
 l0aAtgx4YUA0hKbDsxv7DWolmiJsH+VZHAJRjvJpvQG+FBuJ8CEEFvXJqpxBXGsW7VLjKcveCdR
 KcPkfp+SJQy6IkEAfLic+YVQ=
X-Google-Smtp-Source: AGHT+IHyY5+Gz0WvJ3HXtuQZ+gBBTqUTZgLPbcoGFMYGiEHNVGmB5HcP9uiq7/aG9xuorTOjbVRvDg==
X-Received: by 2002:a05:6808:130f:b0:409:f8e:726f with SMTP id
 5614622812f47-40b8881832amr619370b6e.25.1751418257355; 
 Tue, 01 Jul 2025 18:04:17 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40b32420a6bsm2355809b6e.40.2025.07.01.18.04.16
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 18:04:16 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] crypto: nuvoton: Tighten some dependencies for the nuvoton
 platforms
Date: Tue,  1 Jul 2025 19:04:15 -0600
Message-ID: <20250702010415.18873-1-trini@konsulko.com>
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

The nuvoton AES driver cannot build without platform specific headers
being available. Express that requirement in Kconfig as well.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/crypto/nuvoton/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/nuvoton/Kconfig b/drivers/crypto/nuvoton/Kconfig
index 034fcadfcc89..0eb4396816ed 100644
--- a/drivers/crypto/nuvoton/Kconfig
+++ b/drivers/crypto/nuvoton/Kconfig
@@ -1,5 +1,6 @@
 config NPCM_AES
 	bool "Support the NPCM AES algorithm"
+	depends on (ARM && ARCH_NPCM)
 	select NPCM_OTP
 	help
 	  This provides a means to encrypt and decrypt data using the NPCM
-- 
2.43.0

