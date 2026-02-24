Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7117F357AC
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 14:26:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F053483E83;
	Tue, 24 Feb 2026 15:26:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NoeT9Y1Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E1A883E83; Tue, 24 Feb 2026 15:26:28 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0294C83DEB
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 15:26:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-4638e6bb8a5so2078322b6e.0
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 06:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771943184; x=1772547984; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V98DcDEVw9ypv6/yDcF9dqN6UqdqvhFVhObW4ZVu87w=;
 b=NoeT9Y1YtF49kXqXD1aL+tSv20dmMPcVnYh3VxSnfb/P23aSb0Al8NcBuUPIZ0dmNN
 DEGJfQCnr/WINuCiugv8/s2yz7cyIaRwPc93J+GKwtocAqyVCYioasPYYobAxbcojtDb
 VLO4NFXTUa6JO7Vleq/A1VVpfDmCkkEnycBWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771943184; x=1772547984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=V98DcDEVw9ypv6/yDcF9dqN6UqdqvhFVhObW4ZVu87w=;
 b=HBFP0knRRE8EwRUtzmjmMdxqIxWTmv4gEgrdMSeUBMATkvk2Kaj2U0avsMMesMdmBZ
 WjNfvgVfInWDfxp1QbvMaU9W1UpKGq6pi4JSlxTKAIpkvjihjYyBqtr3ZOm3Su40z8DF
 nLmpf+SmLBe5lxbIi4nysU1w2nWUynuyH5rv+BMov+XBmH4HPbp/BJVRW6MjhcBj5z/z
 TyvOFsdpe5Ch2yE0xwhewjdnYHfkETbF5bGkxRsnNnpei3v/ZAh9cY0Pk0ocTTXtbxgq
 E3X93Gy9WbIxFw9sVfQfYv0K/RH1JnvfDVIsrbwZ6SWjRsprTlKgYXJeBxid1f9fPnoR
 V9sw==
X-Gm-Message-State: AOJu0YwVOS6AlU3TlvwLJMOW+XcewXmijfYY2IzswL7Oew3DrwLfcQsG
 LsD0a3ElWfurqZvkuIA+2Br4x1a2JGYEP0g+pUh+UZDMAhFsQYrNkY2MQR+EdjQK9bjQkzvLFz3
 1iIM=
X-Gm-Gg: ATEYQzw4hV9Y4IivlDBPyWG/HWGA7yo+18ywmdwyMQV4q+OsaT53DT90TTbpBtBMMrW
 QyCsCynLilOtOjHaGLt6nMOggB+X/txmNE1BHaNEtqGybQUlqFc+Yk7ZVGuc0zZ9hXFl8XG2Wtv
 ssklzZ8izQGUHFBGf0TlcHDBi8vybdwpWqt5pJaNNbaTT1834ZKPFCAfIrLJjYLuooR74C16uTp
 +YN/tQ3xabYJ2ITNx6/uA+H/BEQbXCqX2O8U2GBEzeXVwCvzEtKXHOw3dLeUqsV3OLnFMJShum/
 gRFHXt+KdLAffPyrUAu15hTJLYCi5rVhYUFGzBo7MoCURqxhf5vbiJeO99320IFOQ8930nJImiA
 6Pv6NSBYJHqKnkJRe3d7k7zTiNLZkZJrAZ/7JRr4GtCk9z7I72cgDoouqQxA1G8e10q4rnOzyNj
 exdKi7AW1HEV9d2vRgiaZa+T+PA2TBtw==
X-Received: by 2002:a05:6870:70a3:b0:404:33e1:3cc2 with SMTP id
 586e51a60fabf-4157ac44158mr5945264fac.13.1771943184120; 
 Tue, 24 Feb 2026 06:26:24 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4157cd5e168sm10199478fac.4.2026.02.24.06.26.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 06:26:23 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
X-Google-Original-From: Simon Glass <simon.glass@canonical.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 2/9] bootm: Remove active devices in bootm_final()
Date: Tue, 24 Feb 2026 07:25:44 -0700
Message-ID: <20260224142553.1608883-3-simon.glass@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260224142553.1608883-1-simon.glass@canonical.com>
References: <20260224142553.1608883-1-simon.glass@canonical.com>
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

Add a call to dm_remove_devices_active() there to ensure that active
devices are removed.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

Changes in v2:
- Replace 'efi: Make use of bootm_final()' with a non-EFI patch

 boot/bootm_final.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/boot/bootm_final.c b/boot/bootm_final.c
index 15ddbbe5e74..263cd95dcb3 100644
--- a/boot/bootm_final.c
+++ b/boot/bootm_final.c
@@ -6,7 +6,9 @@
  */
 
 #include <bootm.h>
+#include <dm/root.h>
 
 void bootm_final(enum bootm_final_t flags)
 {
+	dm_remove_devices_active();
 }
-- 
2.43.0

