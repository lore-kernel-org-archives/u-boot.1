Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A7F7F483EC
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 19:53:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD74C8421D;
	Mon, 23 Mar 2026 20:53:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="P4Fda1OV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4734A841D5; Mon, 23 Mar 2026 20:53:00 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 824688409A
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 20:52:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7d9bba96f7dso711771a34.1
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 12:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774295575; x=1774900375; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=T3fqY45OTrRxEQTNn18ikEjXPp0o/JAjAZGMGGUVRaI=;
 b=P4Fda1OVZsgz5jXfGBXxem1bxwlDC/z/o+WM1c6gdcLaqqwxKqwCrI+nWKxu6oOW+f
 rs0mFv3l4djtzCrz0G2nM/u9004DG/2eGBZP2aLpWDfpOdUCvkjZJxz/ZOaLaTysPo+J
 QRBiaULvnBamQ6CJhplkmj2iiYB2KYQ5QBz8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774295575; x=1774900375;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T3fqY45OTrRxEQTNn18ikEjXPp0o/JAjAZGMGGUVRaI=;
 b=TjWAe9qLOgLfyB8s68mBUwVja+JAFjxkUzKxMASRTLR5rF1ZXRZJ8wI72bFXbhYa7O
 rYwDER1x5FQT3tRgTRTbrKZ9kFoBxQgqfzARVKjYvnrsYXbmxg/rIEHqR5dQB1B6wIUl
 HsGutzpTvL4jEWp+k20G2AroX/i5RtzbpPnUObBftgt3ObeGQYlJ4GoHkTtAi0tLRP6q
 HKNkHySUbeJora2YNWRcrDkeOrhThPjpq0v5Ay3SI4OQTmOGeWxeAn+Trhcy6FLp/uy8
 BLT1xWEWTl2TEUv+Uh9nzEWds3lY3ftJimT8OqrJr/m3p/UCQfHbb/8YMOuA9iVP5pnY
 Bt2w==
X-Gm-Message-State: AOJu0Yzh8Du5dIWFyXjaMkCYuBKkpuP2Anjshf+ZM7Lphxmawj2mfVhk
 vJzKvF0+DPa+2lCzu95lUTuPMPRQlIBPtxyMp/uIdreWQH67UxWuP5I/2mZyZch2q6aHh9Komfp
 ua2kp0zE=
X-Gm-Gg: ATEYQzzQMNhakXSmDyxTjLjDOjM8l7+HAD1iZimGnerzeIauaYOb0rpW+7srkZU8XZS
 pLrtkQ6uqsO4WbAE6p6wR3Cgqu1rK1CrEh7uIhMojkU2sUqWMqn2jM/Gds9TESK9oqH3OuqwB2p
 0lwvmN6oR27gtD6cHCJ8ujnnQWIybPQeWjxwRszfL/pZOHt41qqHFmnrnlIU8GfnYeQrOeUNBuJ
 CSrl3id1PSgF+iALbNol/uK3194F5CCP+ea7VMad4ZLcjfIB+VZ+6LchlmlcPUChAK7APXY4SmB
 /3lKQTpZHkrxul/f9gRCcN6A61SoUQXoSFEVHdnhqEQN9xd4o+FVZ05lgeoLzi5T6zuOhk3HGuk
 sNAdI6FZ707h3/8pPT6byYmUjnEYNwKiEtICDxZQE6V5N2BiI2WMP/mDWrXu41r+rHBwrKyZwGo
 BnpUUBJBNXeO7Wv/tS+5CPPCB2Orb7Mc1Hqce27adTMp6WmEhYMAmFVjZ5fsIDeaRhx9iSE1ogy
 TXTKjauyNRfiou0wlO5p+9/IadPgYwbsRvJuHxI5xFCOy+nV/s=
X-Received: by 2002:a05:6830:838a:b0:7d7:d615:3040 with SMTP id
 46e09a7af769-7d7eb028dd3mr10717231a34.17.1774295575233; 
 Mon, 23 Mar 2026 12:52:55 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7eabe623dsm10563736a34.3.2026.03.23.12.52.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 12:52:54 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@arm.com>
Subject: [PATCH] net: cmd: Correct dependencies for CMD_PXE
Date: Mon, 23 Mar 2026 13:52:53 -0600
Message-ID: <20260323195253.2363485-1-trini@konsulko.com>
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

The CMD_PXE functionality can only build with CMD_TFTPBOOT enabled (or
we get undefined references to do_tftpb), so express this dependency in
Kconfig.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Jerome Forissier <jerome.forissier@arm.com>
---
 cmd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index a90102b8cd73..1210e8b9dae0 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2313,7 +2313,7 @@ config WGET_BUILTIN_CACERT_PATH
 config CMD_PXE
 	bool "pxe"
 	select PXE_UTILS
-	imply CMD_TFTPBOOT
+	select CMD_TFTPBOOT
 	help
 	  Boot image via network using PXE protocol
 
-- 
2.43.0

