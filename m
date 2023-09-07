Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E7CEE14D3
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 07:54:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 298BB8646E;
	Thu,  7 Sep 2023 09:54:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Hy8FYKhZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70863864A5; Thu,  7 Sep 2023 09:54:55 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4BA486400
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 09:54:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from workstation5.fritz.box
 (ip-178-202-040-247.um47.pools.vodafone-ip.de [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 1D9253F6F7; 
 Thu,  7 Sep 2023 07:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1694073292;
 bh=B4r00yK8jKhPf+832jWJZyyF1GgVW/BdIqjbTlqreIQ=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=Hy8FYKhZi673lFwFIbodylN1rKXp2ed60BSCQMp+XE3djGccCsMM5rlJ+cKpQXsmV
 Hwz+YSuMWcim7wPfXjrhnEkws2L9O7aEM8OhDccJIoYEtw1rUbW0RqwrRPhJKCRxjB
 9tjfEz4eyfUyeswHOFUZxzUxxOJgSDw1pnYtZ1CMcwZaf9JUmjWWafDDMOr0bWlIh0
 /nWBR7DV/C+XgokMQrw9OZrSSYd09vtfMKtpG/Ou/JMCFMw5EaMcPTZP6V2RJ6XkrN
 J6lXU5ylyobC/bV1DNgVdtP2uaUqcUanptUVT0u/1UUZOiAM7GglshCDBLVD1ZRisI
 AaFhZ9px1haVQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Ovidiu Panait <ovpanait@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Chanho Park <chanho61.park@samsung.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] timer: document the unit of the timer rate
Date: Thu,  7 Sep 2023 09:54:42 +0200
Message-Id: <20230907075442.156556-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
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

To avoid confusion document that timer_dev_priv.clock_rate and
timer_get_rate() yield the timer rate in hertz.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 include/timer.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/timer.h b/include/timer.h
index 311ce6b2c3..091d8dfa22 100644
--- a/include/timer.h
+++ b/include/timer.h
@@ -55,10 +55,10 @@ u64 timer_conv_64(u32 count);
 int timer_get_count(struct udevice *dev, u64 *count);
 
 /**
- * timer_get_rate() - Get the timer input clock frequency
+ * timer_get_rate() - Get the timer input clock frequency in Hz
  * @dev: The timer device
  *
- * Return: the timer input clock frequency
+ * Return: the timer input clock frequency in Hz
  */
 unsigned long timer_get_rate(struct udevice *dev);
 
@@ -87,7 +87,7 @@ struct timer_ops {
 /**
  * struct timer_dev_priv - information about a device used by the uclass
  *
- * @clock_rate: the timer input clock frequency
+ * @clock_rate: the timer input clock frequency in Hz
  */
 struct timer_dev_priv {
 	unsigned long clock_rate;
-- 
2.40.1

