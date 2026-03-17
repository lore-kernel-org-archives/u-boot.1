Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E865BFB5EA0
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 01:27:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B489842DF;
	Tue, 17 Mar 2026 02:24:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TRy5uT4q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB7FE84285; Tue, 17 Mar 2026 02:24:52 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19DAE84285
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 02:24:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7d77b179b52so4486653a34.2
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 18:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773710688; x=1774315488; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=d4cN2aR/kn8/d1Difc5+SWvPhHaZaIC1rNRSVnO0zZM=;
 b=TRy5uT4q74hNVYRZD/kYjRT0g/44WD3KSrFs9TcNJE2+6IcmXcxOxJsWu11iPUbGga
 Tq+Jt0IyntAC8tYahDCAOUzylAqdM2zmwfLOfzmMMajsgDgRNbM0pxB/0vkDuMvg3cIx
 CvVDyqRVqrs4eoQYZxGU3kx3fkl7SsZ2vSBOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773710688; x=1774315488;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d4cN2aR/kn8/d1Difc5+SWvPhHaZaIC1rNRSVnO0zZM=;
 b=H/ihYcNCxY3RXv9jSsOGJo8zFlHfBToarJl2I3WpUW47MfE7m9MEDVp3x/ejlnPz0f
 oxpTQxsEcTMowak+RinDyW4DT3Szz/OfM3qE9SC69GyFUrmo06Uu/89rcqfrmGROxSs6
 iX0gKWdYHiny+sH23+U81023KofIL/U0h65ijJQh6S88g9meLXxcBwHtZhXkBaNTFUaz
 jbde+LTWl6pXByHGn26OqNYiHGiq00rbrfMCSEiC/gFctUSWtzTKfVXeDP6bUqX3kbVN
 FaeP2EZCCApzyxi7AqwfZukEBsOw+nuVy80Q3c+MZJOBoyn75Z6GQ3GJqpPgGuNpwOhs
 rU9Q==
X-Gm-Message-State: AOJu0Yx8DR81g2JFn9LU0Xz+1pC3Ut5L4EfP9k9hFRvNY5rJx3yvxYP0
 meAmDhA8Sw70txtXxmQ9WYpwCUAmjS95c+0FXlCe8P5mgA1mjafhBAnRtgIGbwmOmgtH8lGFD5Q
 kbDUP+88=
X-Gm-Gg: ATEYQzwptmg+JMnBha4IPEy3HeN37yCpx7pZmvGE3/m5w/CoEnP82+ByNbh1I/C+E63
 CZeAmAN78LE1b6KndjOTpia4Fk9hK1Qt5oZjzRwYmJV4u349/4qYU9sS6qMU1IoVlbiblsowkKj
 rvzDY6gz/p0idl687mEQrnY+h9xC7wcNgJWhLjZ4u/U8LSCjZnen7FRG1Q+/RIR9drpJrlcLjMc
 dkVXLugZNKv16VBdZXwJ3eorRyBosdJFMKpZDwZCQcwCSjY8tvgWbFJssHtzbTMIIGbiuC0wlrw
 WcMm+zQqqPTeFFlDzvbOsraLzXaqFRGzVAPbB7v7XAqGzXmD9O1+s2OpYXLYFNdsNT0f6vR+dPV
 uVvlJNHnRCsF5uhf5jAPiF8FEz955xWgRtK4Zf+r7JqlhzbeZY7PfWJr4b7GS9AzLoKjB+r2UgM
 bN4DqsE+VqvfYS0ttoF8tbrvVjhFvStTdk/tbIxOgYQx8l+gBGT+QAIdw7zqhmfEQfq/8BblhZK
 wkOuSfZAfA3J3O+Dyt0DKRhgERX/vkxF6kmItXCy7IZVpIifRE=
X-Received: by 2002:a05:6830:3914:b0:7d7:5e83:3a0a with SMTP id
 46e09a7af769-7d7824c5e99mr10071172a34.10.1773710687795; 
 Mon, 16 Mar 2026 18:24:47 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76ac8d43esm14729378a34.10.2026.03.16.18.24.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 18:24:47 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>
Subject: [PATCH] timer: Correct Kconfig entry for XILINX_TIMER
Date: Mon, 16 Mar 2026 19:24:46 -0600
Message-ID: <20260317012446.4162630-1-trini@konsulko.com>
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

As exposed by "make randconfig", we have an issue with the dependencies
for XILINX_TIMER. This symbol is a case where we have one that covers
both main U-Boot and SPL. In this case, we need to select SPL_REGMAP not
when SPL is enabled but rather when SPL_TIMER is enabled (and in turn,
SPL_DM).

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Michal Simek <michal.simek@amd.com>
---
 drivers/timer/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/timer/Kconfig b/drivers/timer/Kconfig
index 24c141c60ae9..500a25638a96 100644
--- a/drivers/timer/Kconfig
+++ b/drivers/timer/Kconfig
@@ -328,7 +328,7 @@ config XILINX_TIMER
 	bool "Xilinx timer support"
 	depends on TIMER
 	select REGMAP
-	select SPL_REGMAP if SPL
+	select SPL_REGMAP if SPL_TIMER
 	help
 	  Select this to enable support for the timer found on
 	  any Xilinx boards (axi timer).
-- 
2.43.0

