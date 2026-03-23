Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18174F483EC
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 19:53:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52038841F7;
	Mon, 23 Mar 2026 20:53:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iO6RKgUk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16182841D6; Mon, 23 Mar 2026 20:52:56 +0100 (CET)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6ACA984199
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 20:52:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7d9b1c57a4cso1434986a34.3
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 12:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774295571; x=1774900371; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=9Llebjgc+JKaGCGldTEKDzkFJ+S2Va8kQciaJV1Lwng=;
 b=iO6RKgUk3M4lZahHUzGo7fizrSBE0qm3CpAwTIq+LYU20MjT/74iH4p8FGwEBDwyhL
 8yF6tRh/gEwNCOTp6335EsSDShqGAkG92KQG1B4Hk8oy26gk0ink8mh4h+7Dz6jAfmX8
 PmGV1VaawC0k4pjBAKSOjXwObsJ4ML9MJGRIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774295571; x=1774900371;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9Llebjgc+JKaGCGldTEKDzkFJ+S2Va8kQciaJV1Lwng=;
 b=Z3H81TczxXgyTyMnwLVtRd6J6KGvSoJqwKJM5payN/ZWcWnIq1eNB+YiH9kTGU8SO+
 XI6CfvJX3ght+d+oDFH8ZzfKzJb7jgBzp0CnqHDD8sMaNEELN8PmG2AYsW4h+GVjWEoY
 4yxNXkKH+QCi/CznuNA/L7ToEsO5aQAJN6HQ8egKYo76moUinI7MPo64zpXpOVec9gdx
 5n5oO19N6X4GJsbnCoTKcg6qqfNTXTURwzAX4Iekkao+EXWd2dwGUjxujurA2h3lJJTV
 3HtcUvT/47pdQp3CCq4RdqIapO5zu4jQl9Pt5ZOMDROplqFEkPMFBTVUlr89S59WjPk6
 RHbA==
X-Gm-Message-State: AOJu0YypPsgYQrvGjBk5Wvc7gDcS78EP8XuF61UUeHoPY8zZ0zHCec+b
 J3gHblZlSuivBU5Uest60TdlV46IhE/X85XBlF9Mv7WDv9tz9P8iJWhbVg5i5qP9EQMYNwxu438
 cmsjnV1k=
X-Gm-Gg: ATEYQzytimZWZVxyI8EU99QJ6/33NJmElHStELWrtt0IpL3HYzaSbOXh/x+mqf+fchO
 oapiIddOGXmYqJt8EUkr0IXPTSQOzaS1/f/Hhq6YayjV1wBf5HsD9B02D4zrka8qSPCEmCzonZt
 OVAPuwfehjP9L64/Yj5ZO53AlS4SLy/Vea7oez/M9X0blBQRU5pRwMMWRvH2P3ySY0rNPs/7zBc
 RDBkqov3D8NRUgEQa52nlYjM/dXEcrBDyQX5Ekyaxol1g4bhpekb2Q8pqsk9uftQY+EO9fSGYA2
 sJvkud3rtBX01x0WpHdjT2at+ogE7H5J2pDuh5NRs5+xMYVYV3HIqp9+Z3z/BkBeXDJQ0+KUOTM
 a3M0Ccm7DLSW0RSunG9Jw3zv5P9HUXUYgW2NVQ2h88zqi/5aMzpZVdYSHbSE+livG+Ht37OVTfr
 DU+fU78nS0YJr40ZQjnMc80bUDm5gYL4/UdezvEgnhGKsTQKNWmQnIjaQ6KnP1Nftn7/ZjbLFHn
 VoqcmlbYlAPLQMhUAw5uxx9n5a2iRLV9kJ2cjDiWyWIUI4QY+ft++JEZcGwkA==
X-Received: by 2002:a05:6830:4985:b0:7d7:da1d:4472 with SMTP id
 46e09a7af769-7d7eae57842mr9307114a34.8.1774295570967; 
 Mon, 23 Mar 2026 12:52:50 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41c14e45213sm10351042fac.18.2026.03.23.12.52.50
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 12:52:50 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] cmd: Correct dependencies for CMD_BOOTD
Date: Mon, 23 Mar 2026 13:52:49 -0600
Message-ID: <20260323195249.2363452-1-trini@konsulko.com>
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

The CMD_BOOTD functionality can only work with CMD_BOOTM enabled, so
express this dependency in Kconfig.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 cmd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 24dc7fa54273..7712cb9f3afe 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -292,6 +292,7 @@ menu "Boot commands"
 
 config CMD_BOOTD
 	bool "bootd"
+	depends on CMD_BOOTM
 	default y
 	help
 	  Run the command stored in the environment "bootcmd", i.e.
-- 
2.43.0

