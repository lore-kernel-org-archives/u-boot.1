Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E778FC61CE8
	for <u-boot@archiver.kernel.org>; Sun,  8 Jun 2025 07:42:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E55B8811AC;
	Sun,  8 Jun 2025 09:42:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="it+9kOFh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 430AB807B1; Sun,  8 Jun 2025 09:42:39 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61EC380C93
 for <u-boot@lists.denx.de>; Sun,  8 Jun 2025 09:42:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8E61044704
 for <u-boot@lists.denx.de>; Sun,  8 Jun 2025 07:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1749368556;
 bh=7D2hFo94hyg1WwY2QpeaWAVPYAnGh4FPMqTtnKSqWKM=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=it+9kOFhjt6flju/vcQeqwhUMi5fw0TfwBhDBlWE520Gu2AonKqunQP5mAdTK4w38
 PE1gxsW2+jZa2v/UWjexJSVsGTU5o/Hw6gPTuitzeB0XhDO+HbGkpPlIJGRg/Kfz71
 FhUwAPamBWOOHPL/X8k+kl+ZZhSxvCdyIanA1H558j86hb+LnYw5MDwQfLqpoP99Rj
 vGkoMmupdTai5wArbaU8SPUAS2MOagnL2BvBoZ+rn7ThNpbHLWgHPUPsfCrsCqcpju
 bZsFtSk3NbnuArQp5OUi58E9hY2UyUJ/9qSItFqxsoKQZMuLRkIgY57Oauj69jqNjv
 MFd4J8qDM3HRA==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-451d7de4ae3so22141935e9.2
 for <u-boot@lists.denx.de>; Sun, 08 Jun 2025 00:42:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749368556; x=1749973356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7D2hFo94hyg1WwY2QpeaWAVPYAnGh4FPMqTtnKSqWKM=;
 b=Op/tHfxB86Ax2cHuv825U9gdWwijNH0M9gfereEO6F5gDZIAKq0JmW1A4CyogH+WUJ
 2/2l+ECPuvfsmkTq5rbN5h72Eh7+tbUzX9XUcXyPrQH6c+cwBPGyY3rJ8lLDmq/nkKvZ
 PfCVuJX5l+We0Lu+keAmi7mbY4N0iR4UOYY2U49uZR+H0ZqnUGMYSfse+1zONw0TLr91
 cbOqOvlX7R3pyDIS/Bw8jRcqS8hAH+soE0pXPkdGa5XlK/ZcIIz3sEyOpuZ0dssHULOy
 ETHfW62UfbyYBFr1vDuZsWUMQy31vLlo3OCSD9fUEpCEHpXjVEj5qPbPT/e0jtl/tgGV
 LJ2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoAEFzWSBMhtqEB1wkFUNe/jHRVOpcM2QBn+Oh4UODi0G8Knh10b8/ytANO/vRohbocO+j5x0=@lists.denx.de
X-Gm-Message-State: AOJu0YwnFmZqKY6hTFL6naS4buOqNRXXTGZJr7Q43TQt+LMPiv57XvCA
 v3cJ1IbJv93zc43eKwGB3WpP0TYjhxAEemR8/0a0t8GlFXrP8I6eIpIXSsZ3dm8yhsZvwN3cfkn
 lfQdeTmWqhk35nSUvRnQcxJVEwOWya4VE0jPp4d2W9/kxlSJK+8KJL+WQm/pGrMgPyLUbLUM=
X-Gm-Gg: ASbGnctymLbYrQr1EDfme1nT9gxonTpYGc8vvf5Dp2H6xrUnkIrBbSc2BHchHAGwd5u
 HnZfOI5Mn1Kv5fiHVRq3TlkJw30QRFMhUQHhir8EdsJ5lBGpi4KTHvXDVxN6tVaIZQFjShzJaMZ
 Zu6ZdjA/dBMu9R9G7tPLxrBXFHPkKZQ2ZWOXzvSkC10+YNcc1IrIHy7PsLnOsd99nVa0oP5SRlF
 wFyD3xkYA98sv49fucMamDRj35dVCNuMO/StjltYkP309P38rsFzlAlomSXXb+xqCHtkDL6X+yi
 1COMOP3xAfGHpHukM/KOQDoAfNVjAEAAWc4Yfd0Bvncnr+WmHyC0DCisJVHr64C+ETK1wZxXWwv
 1CciZBMRxpR4ucwqpAB5oJEzJ
X-Received: by 2002:a05:600c:8b08:b0:440:9b1a:cd78 with SMTP id
 5b1f17b1804b1-4520141635bmr108131605e9.10.1749368556029; 
 Sun, 08 Jun 2025 00:42:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEl8Epae6L2cNb+VsotSaHIbdEDr3c09BeV6dYZNlA7bAoqEmYVoMKHo+CyZVAKaZFR7nLKZg==
X-Received: by 2002:a05:600c:8b08:b0:440:9b1a:cd78 with SMTP id
 5b1f17b1804b1-4520141635bmr108131365e9.10.1749368555609; 
 Sun, 08 Jun 2025 00:42:35 -0700 (PDT)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45209bc6c6csm78285635e9.2.2025.06.08.00.42.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Jun 2025 00:42:34 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Parth Pancholi <parth.pancholi@toradex.com>,
 Vitor Soares <vitor.soares@toradex.com>,
 Sean Edmond <seanedmond@microsoft.com>,
 Casey Connolly <casey.connolly@linaro.org>, Bryan Brattlof <bb@ti.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/3] verdin-am62p: include linux/sizes.h
Date: Sun,  8 Jun 2025 09:42:26 +0200
Message-ID: <20250608074228.12407-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250608074228.12407-1-heinrich.schuchardt@canonical.com>
References: <20250608074228.12407-1-heinrich.schuchardt@canonical.com>
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

Avoid build failures

In file included from include/config.h:3,
                 from board/toradex/verdin-am62p/verdin-am62p.c:9:
board/toradex/verdin-am62p/verdin-am62p.c: In function 'dram_init':
include/configs/verdin-am62p.h:13:33: error: 'SZ_2G' undeclared (first use in this function)
   13 | #define CFG_SYS_SDRAM_SIZE      SZ_2G /* Maximum supported size */
      |                                 ^~~~~
board/toradex/verdin-am62p/verdin-am62p.c:63:65: note: in expansion of macro 'CFG_SYS_SDRAM_SIZE'
   63 |         gd->ram_size = get_ram_size((long *)CFG_SYS_SDRAM_BASE, CFG_SYS_SDRAM_SIZE);
      |                                                                 ^~~~~~~~~~~~~~~~~~
include/configs/verdin-am62p.h:13:33: note: each undeclared identifier is reported only once for each function it appears in
board/toradex/verdin-am62p/verdin-am62p.c:65:28: error: 'SZ_1G' undeclared (first use in this function)
   65 |         if (gd->ram_size < SZ_1G)
      |                            ^~~~~

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	drop change in board/toradex/verdin-am62p/verdin-am62p.c
---
 include/configs/verdin-am62p.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/configs/verdin-am62p.h b/include/configs/verdin-am62p.h
index eef360ee9b6..c3464bdb838 100644
--- a/include/configs/verdin-am62p.h
+++ b/include/configs/verdin-am62p.h
@@ -8,6 +8,8 @@
 #ifndef __VERDIN_AM62P_H
 #define __VERDIN_AM62P_H
 
+#include <linux/sizes.h>
+
 /* DDR Configuration */
 #define CFG_SYS_SDRAM_BASE	0x80000000
 #define CFG_SYS_SDRAM_SIZE	SZ_2G /* Maximum supported size */
-- 
2.48.1

