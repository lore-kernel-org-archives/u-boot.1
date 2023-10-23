Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFD3FC001E0
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 15:26:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA1A886F97;
	Mon, 23 Oct 2023 17:26:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=hugovil.com header.i=@hugovil.com header.b="TWlx/CGg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 118598791C; Mon, 23 Oct 2023 17:26:38 +0200 (CEST)
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A064A86F91
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 17:26:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hugo@hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
 ; s=x;
 h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
 :From:subject:date:message-id:reply-to;
 bh=UHUrxPy2JT9tO7B5L5sM9AWy5THe6T3VKwgcbhZLymI=; b=TWlx/CGgBLtvPBojrlszz62a1b
 GV0dPOkm03PcHBeAV5P7RhFdUAIyQcPep585l5KmQM5g0g3R+siZjXDOChftRLfGvWy6rR/t8D167
 4PcPrvSpsbLcZEFBOltg2v6rvrOiy2XqKz9wiJ3q2Z2Z0D+13tH77NyqiClyOotzYRcY=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:60374
 helo=pettiford.lan) by mail.hugovil.com with esmtpa (Exim 4.92)
 (envelope-from <hugo@hugovil.com>)
 id 1quwp4-0004en-HM; Mon, 23 Oct 2023 11:26:32 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Michael Trimarchi <michael@amarulasolutions.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: hugo@hugovil.com,
	u-boot@lists.denx.de
Date: Mon, 23 Oct 2023 11:26:28 -0400
Message-Id: <20231023152629.2727547-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
Subject: [PATCH] MAINTAINERS: Remove non-working address from MAINTAINERS
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
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

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

The address ariel.dalessandro@collabora.com is no longer working:

  A message that you sent could not be delivered to one or more of its
  recipients. This is a permanent error. The following address(es) failed:

  ariel.dalessandro@collabora.com
    host mx.collabora.co.uk [46.235.227.165]
    SMTP error from remote mail server after RCPT TO:<ariel.dalessandro@collabora.com>:
    550 5.1.1 <ariel.dalessandro@collabora.com>: Recipient address rejected:
    undeliverable address: host mail.collabora.co.uk[46.235.227.172] said:
    550 5.1.1 <ariel.dalessandro@collabora.com>: Recipient address rejected:
    User unknown in local recipient table (in reply to RCPT TO command)

Remove this address from MAINTAINERS.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 board/bsh/imx8mn_smm_s2/MAINTAINERS        | 1 -
 board/variscite/imx8mn_var_som/MAINTAINERS | 1 -
 2 files changed, 2 deletions(-)

diff --git a/board/bsh/imx8mn_smm_s2/MAINTAINERS b/board/bsh/imx8mn_smm_s2/MAINTAINERS
index 1de816ca871..c7898278359 100644
--- a/board/bsh/imx8mn_smm_s2/MAINTAINERS
+++ b/board/bsh/imx8mn_smm_s2/MAINTAINERS
@@ -1,5 +1,4 @@
 ARM i.MX8MN BSH SMM S2 BOARDS
-M:	Ariel D'Alessandro <ariel.dalessandro@collabora.com>
 M:	Michael Trimarchi <michael@amarulasolutions.com>
 S:	Maintained
 F:	arch/arm/dts/imx8mn-bsh-smm-s2*
diff --git a/board/variscite/imx8mn_var_som/MAINTAINERS b/board/variscite/imx8mn_var_som/MAINTAINERS
index 367f72dfe4f..a0fb1546f2f 100644
--- a/board/variscite/imx8mn_var_som/MAINTAINERS
+++ b/board/variscite/imx8mn_var_som/MAINTAINERS
@@ -1,5 +1,4 @@
 ARM i.MX8MN VARISCITE VAR-SOM-MX8MN MODULE
-M:	Ariel D'Alessandro <ariel.dalessandro@collabora.com>
 M:	Hugo Villeneuve <hvilleneuve@dimonoff.com>
 S:	Maintained
 F:	arch/arm/dts/imx8mn-var-som*

base-commit: 4655b75335384e040358a2e3e478cc42f32a96c9
prerequisite-patch-id: 046349f916b24300d12c076e4cc3f02d81599e5e
-- 
2.39.2

