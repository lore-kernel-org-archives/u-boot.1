Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 092ABC7113B
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 07:44:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B6BE8645B;
	Thu, 24 Aug 2023 09:44:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=walle.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=walle.cc header.i=@walle.cc header.b="vQ7T63iP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5557986562; Thu, 24 Aug 2023 09:44:46 +0200 (CEST)
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8B8D863F5
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 09:44:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=walle.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=michael@walle.cc
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.3ffe.de (Postfix) with ESMTPSA id A89D05E7;
 Thu, 24 Aug 2023 09:44:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc;
 s=mail2022082101; t=1692863082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=6hTwAy3m6cwZUS1TCVI8PZa8R5Ws1ax4MkKePNYHcac=;
 b=vQ7T63iPcYH4mghclHHFPAhCK67GPck3CL0LJlZa0oSDbYfyJTPcQxmpHdpPj9n5T1W+Sl
 sMzlbHmmkP9JOwdu+2urg2VX/XkpS8LSSiABJHilUOhYqKibsNRoYu6D+RhBDvl8Oql+5A
 x2QMMOGQPJLaROe1Yzko17PzOa7rJeWTB8fxL/vTXnIjs6AzD/hFqW7YAo40zzwH11UScl
 doLdTmK1PpTPNh8pL1ozd/TMrV918J4AdFQGt+1x4+LheIljqFesEm2u97PXFwV4cnTVrX
 MdLCeFdNhtVH2T3U6qGh/HWeTYDFVXadtgdxciHdTmHvf6/3z28BT2R36Wvk5Q==
From: Michael Walle <michael@walle.cc>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Michael Walle <michael@walle.cc>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH] MAINTAINERS: remove Vikas Manocha
Date: Thu, 24 Aug 2023 09:44:36 +0200
Message-Id: <20230824074436.2929639-1-michael@walle.cc>
X-Mailer: git-send-email 2.39.2
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

The mails are bouncing with
  550 5.1.1 User Unknown (in reply to RCPT TO command)

Remove the entry and mark the ARM STM STV0991 arch as Orphan.

Signed-off-by: Michael Walle <michael@walle.cc>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
---
CCing other ST people, maybe someone want to take over instead.
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 84de9de531..57ede4bea9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -641,8 +641,7 @@ N:	stm32
 
 
 ARM STM STV0991
-M:	Vikas Manocha <vikas.manocha@st.com>
-S:	Maintained
+S:	Orphan
 F:	arch/arm/cpu/armv7/stv0991/
 F:	arch/arm/include/asm/arch-stv0991/
 
-- 
2.39.2

