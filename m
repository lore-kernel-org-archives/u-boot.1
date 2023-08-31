Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95F7BC83F10
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 14:56:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF748865A4;
	Thu, 31 Aug 2023 16:56:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1693493781;
	bh=zfByFcuqjKkNwBCtREtwT6Y2ZbnIhZwIDh6K8ApxkVo=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=OecrJk4YQct+Y4yioO/iKMncN1VcnEyVU/6RJPFXEphCbZlxbhv5npwerFMQMMK5q
	 ZhrWPnvUumn4u/OszWPA3X5xXIpzrV4oleNxmK5/zO/tUna/+ICI5B2tRSb1Fo5IT/
	 CD2qhbMG35KxOezbHT3fDloR2sirC5crPUXzh1mvS2BD5KnBkyO6LFO4dNcuFTG7RK
	 sEQE615eQyo244uhoEFGuj5R1tOZ7Sn1GNrIHBvd2twmLUf0w406Gc/i6oiebNfHq1
	 exdHbeVS2uhAhOyn5ISsDYlDQ+fvLB1/uelRDLhIk8HCcgmY4mqVk7ZaO05HNgkQXg
	 7c6zo6RhM1MeQ==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 464D0865A0;
 Thu, 31 Aug 2023 16:56:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1693493780;
 bh=zfByFcuqjKkNwBCtREtwT6Y2ZbnIhZwIDh6K8ApxkVo=;
 h=From:To:Cc:Subject:Date:From;
 b=Gs/+6sk79BX9+HBS5Z+ZuOml6xYpnYL4rU2yp9MSN+6fJGsL5OT7eqRcJhvgZ/PIZ
 b6D4BhaTq7HFTTWqGI6I36wSVes+sLSRjeb2Lhwy4skyRLxGNVnniln4xMUUb66nWE
 8sCqDL9z/loyJ+NSpf/UOiTmYwmqFJcJIC/CT63UNU776xiBfH0m/QBhmJc1jBFbsu
 rz8am+JLnIi5/yfv1TPDi+hnmk/pT8lhaW2mc+jdfF2E8XWc+5JgkOtQelTlA+iMf3
 cjWMlUz//4c0tWokLqnUawzL/yLdG59dZAsbwMolm9XiSrK3rxrtsr9FmQTqCWuD/v
 sWR6RCAVc0VrQ==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Stefano Babic <sbabic@denx.de>, Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH] imx: hab: Use CONFIG_SPL_LOAD_FIT_ADDRESS in the CSF example
Date: Thu, 31 Aug 2023 16:56:03 +0200
Message-Id: <20230831145603.80139-1-marex@denx.de>
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

The SPL authenticates image starting from CONFIG_SPL_LOAD_FIT_ADDRESS
address, update the csf_fit.txt to match.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Fabio Estevam <festevam@denx.de>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Tim Harvey <tharvey@gateworks.com>
---
 doc/imx/habv4/csf_examples/mx8m/csf_fit.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/imx/habv4/csf_examples/mx8m/csf_fit.txt b/doc/imx/habv4/csf_examples/mx8m/csf_fit.txt
index 3d79edf2813..97f3eea573b 100644
--- a/doc/imx/habv4/csf_examples/mx8m/csf_fit.txt
+++ b/doc/imx/habv4/csf_examples/mx8m/csf_fit.txt
@@ -27,4 +27,4 @@
   Verification index = 2
   # FIXME:
   # Line 1 -- fitImage
-  Blocks = 0x401fcdc0 0x57c00 0xffff "flash.bin"
+  Blocks = CONFIG_SPL_LOAD_FIT_ADDRESS 0x57c00 0xffff "flash.bin"
-- 
2.40.1

