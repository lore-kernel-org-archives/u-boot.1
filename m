Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7878CA0EED
	for <u-boot@archiver.kernel.org>; Thu, 28 Aug 2025 13:52:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D92C833C8;
	Thu, 28 Aug 2025 15:52:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="TWEmy3yg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31ABC831C2; Thu, 28 Aug 2025 15:52:47 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C41A833C8
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 15:52:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id ED3C93F7C7
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 13:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1756389163;
 bh=rnmDVvKLfEt+JQuQ0VJjpz2QxR5o6E0cFi+dEsf3w3I=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=TWEmy3ygtEIIbwGL1mNBXCHkbUYVr056COhg/FWbq6oPYQLl/Z8X+36TZEJvbsRMo
 w7YKiv6iUxy8WIEjBPWVFhkgtJkx1sXpjdUBIXJ6nxKf2Gu4EDCrKdg4dSnkiZBOw+
 5R5IVdPwcRuId6M2m9hrOam/fAAhjY2BlSu5vmEndrzPqYR1bA80DDnQuVm1nLAJno
 ZI+NcomAc/+41EQE3Goil6hDIvHfmbWkynWnduyBTw98Br+EQcPuzNAFjyUbKKflMA
 Q3xjuhurJByU5GYOWDPNQBSefsqZwrZ37NQAlXbMQ9pTo/4zK0U6C5GYrHR96aODNG
 KvtUwR8TexKfA==
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3c6ae25997cso597022f8f.0
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 06:52:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756389163; x=1756993963;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rnmDVvKLfEt+JQuQ0VJjpz2QxR5o6E0cFi+dEsf3w3I=;
 b=oIQSAmH9iW5fDo55ENIS8WW3k0g0lTO+CRJHrMg3Y3gYxkQryKdSHWygPNGHyBv7OC
 gVCqfRAAgTsRao4CnGuc0nmaBpcRY1t6diAk1FV9c3Rpm2asGDK3fS2fOpHanLahV7nM
 GusExRYzRjeIASpXZ11j6w27+jzuLL6rcpf3PgYfuW4wb7gCMkZ/6ZIgq/Apn58yB/MF
 SLUFqFkUWQKtowIqggJED3zcjXivf+VZ6l97a71s0f6oMPGKTWVr/0HOFi4FN+pGP0lH
 al65jkmhmodKpw74v4hDGZfSdN0Iw3RPP+JZVBL8np6U13WfpFNbiRnwTo5zZL8uEDWK
 DOqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV98daqE2wzeyb2rEtWhV2jLujfIMmsdVw0OLIeVRolzgUVNBBqNUkWIoZ7jiel5yaUBKDELFo=@lists.denx.de
X-Gm-Message-State: AOJu0Yx2HIxU0uzdaQoxj13dMR0erTD6ScSPiYpl6ASAIiw+/2AWoNDN
 FoHi5lPkx2p2wz9AMN3XSBrQoqvwyYbOdWGSKAFp54/dVTbCZQiqms8gYNhrSniIRXwy8fD/zx4
 q0DNMsKBvNrEvOqmp1MRTN/EcYbtl8crcjFwuwJ4grqFt6mwqyHcaimoNu6f4R8AmVz1R+kU=
X-Gm-Gg: ASbGncsZYIT8SemdZPFAf56Yy4r4OjnmOJBjy0itxLSqdRp0qTAIsVWGx15e9qIFbnm
 B9Gknfg0TF5KKuLFEzak3nTl4nfGpAAHQOowlXjnfWYLHefdkOvOIZNYYqCvmiZ8LrTw+N10VZY
 KYFGpi1KzYjsiyt0wuQiHfE9Z6HImu4cYRKVDthmkSGI+69HRAn8IdxSafa3gtUlHkxEPNt5kae
 f72frQ/u/+Wbqisu8wm5UlQOUfD1ij+wwM2BfGmTLcknCxbWB5sie1GwEChGxpOv+4dWc6dl8sU
 Q0bzZG5NzobB+0qbNdpD+CnmUhS/GUGLc5hpYAvJsuIFQSdXBBGCIPyqMD8Vc3sniKdMpog+hS2
 GU732A4qwT0jQiFlUf41yrzZUNsfFhf4=
X-Received: by 2002:a05:6000:26c3:b0:3cd:f441:9217 with SMTP id
 ffacd0b85a97d-3cdf44196c8mr2133009f8f.3.1756389163450; 
 Thu, 28 Aug 2025 06:52:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEh8eMimdQDHTkpBRJIpuM32tEDTLhFxkqQsj2NFxMylA00inEQ/JAorjT8cYXdWButh+q0Q==
X-Received: by 2002:a05:6000:26c3:b0:3cd:f441:9217 with SMTP id
 ffacd0b85a97d-3cdf44196c8mr2132981f8f.3.1756389163003; 
 Thu, 28 Aug 2025 06:52:43 -0700 (PDT)
Received: from workstation5 (ip-005-147-080-091.um06.pools.vodafone-ip.de.
 [5.147.80.91]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cd5997658fsm5005439f8f.46.2025.08.28.06.52.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 06:52:41 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Greg Malysa <malysagreg@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, Ye Li <ye.li@nxp.com>,
 Simon Glass <sjg@chromium.org>, Anshul Dalal <anshuld@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] spl: SPL_DM_SPI_FLASH depends on SPL_DM_SPI
Date: Thu, 28 Aug 2025 15:52:35 +0200
Message-ID: <20250828135235.26711-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.50.1
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

The SPI flash driver does not build without SPI support enabled.

Fixes: 4151f4f822bb ("spl: Rework and tighten some dependencies")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 common/spl/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index ab05536bd02..f34b96efc02 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1141,7 +1141,7 @@ config SPL_DM_SPI
 
 config SPL_DM_SPI_FLASH
 	bool "Support SPI DM FLASH drivers in SPL"
-	depends on SPL_DM
+	depends on SPL_DM_SPI
 	help
 	  Enable support for SPI DM flash drivers in SPL.
 
-- 
2.43.0

