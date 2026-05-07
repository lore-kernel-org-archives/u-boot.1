Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8906CCD343F
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 15:04:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B55C684AE8;
	Thu,  7 May 2026 17:04:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="k8yOofon";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3164184B44; Thu,  7 May 2026 17:04:29 +0200 (CEST)
Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch
 [185.125.25.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D2EF84ADD
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 17:04:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246c])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gBFs559XbzKMY;
 Thu,  7 May 2026 17:04:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1778166265;
 bh=LhCIIWS41fpKpje/gue2trfaAkxrmwHaARPch1lQol0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=k8yOofon/ZCyppfb9AeEe+xWKvOUThvSQ9NrPOmSVV1lXE5HeL6Pcfz9xE6tEBfF+
 bs1CpZHLyXboIT2sHUl8Y4hO0sfYqyFpLqQKmNDKd8ngDRVfmYOX3abcM40zuqPNoV
 sa6ld0rwaHfI2sIfZ4bXyOQV/60nbomkvlKvUgQ4bjEctiWrd89KBSEoSrh5oYvHNu
 vbZescvmlJ4SV5V204yGpCz4zuHY/s4Nwq1zTqRUyd9KUW24pGen+Ff7357tEy7f7r
 7ilZNCOtgJ28BGLgtz/rBKZONR5UshLQU20lc+ZYRlXPXFUdnu5/k+5H95PYfVwJ7c
 X3bvXMS0+YoNA==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4gBFs50zJCzW96; Thu,  7 May 2026 17:04:25 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Thu, 07 May 2026 17:04:06 +0200
Subject: [PATCH v2 2/3] doc: usage: cmd: reset: fix typo
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-doc-sysreset-qcom-v2-2-37fef7a9cf92@cherry.de>
References: <20260507-doc-sysreset-qcom-v2-0-37fef7a9cf92@cherry.de>
In-Reply-To: <20260507-doc-sysreset-qcom-v2-0-37fef7a9cf92@cherry.de>
To: Casey Connolly <casey.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Bin Meng <bmeng.cn@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

"Do warm WARM" doesn't mean anything, I'm assuming the intent was to say
"Do WARM reset" so reword.

Fixes: 34e452dd0252 ("doc: usage: Group all shell command docs into cmd/ sub-directory")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/usage/cmd/reset.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/usage/cmd/reset.rst b/doc/usage/cmd/reset.rst
index 366b17eea16..88261293924 100644
--- a/doc/usage/cmd/reset.rst
+++ b/doc/usage/cmd/reset.rst
@@ -20,7 +20,7 @@ Perform reset of the CPU. By default does COLD reset, which resets CPU,
 DDR and peripherals, on some boards also resets external PMIC.
 
 -w
-    Do warm WARM, reset CPU but keep peripheral/DDR/PMIC active.
+    Do WARM reset: reset CPU but keep peripheral/DDR/PMIC active.
 
 -edl
     Boot to Emergency DownLoad mode on supported Qualcomm platforms.

-- 
2.54.0

