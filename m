Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE8BD47CDA
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 10:57:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A7EC830E4;
	Fri, 16 Jan 2026 11:56:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="g8eNQAdX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20D4D839DD; Fri, 16 Jan 2026 11:56:29 +0100 (CET)
Received: from mx-relay54-hz1.antispameurope.com
 (mx-relay54-hz1.antispameurope.com [94.100.133.227])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E08282BF2
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 11:56:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0469552be2=max.merchel@ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate54-hz1.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6,
 headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out04-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=hY0nk/ZnIubl94Fvml8LgG/EtgDOKhCTciniFvJEcx8=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1768560986;
 b=bmkFdu33whYVBWVPSLv7HsaEkxUYt90LWP7x4rSzrYiO9LgRN9293+p1k0v40DrnlgM4dOdN
 UlQyK+SKhUku7QZgNHSacn+ffXJ+Dq/LHzBw9r3OWi7CKxMyfI1UH2R4YKT+xYTkHoBT5mqSyGz
 klRD3OnhIySDzzEDUMDXFv7TkOj0jPzsWAONksmnKnPVVDJf5cPtgXe421q7xyJlkGKiC07aLCY
 bYLm7KkZHd2hbbmPQJ65MExz2x+IiIyS/XO8WFfQ/e5AN3cazmLpweuijwM3b+Jucwe4maEyrZf
 rNms8mEuYSX/HpMRsluB1tkSbMl8HS6Wv0G9dTEdtOYzA==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1768560986;
 b=HwOcVwq783NWBOSTYIBRO2KQnZQT5dhwMmqbDdrlHvtJkKKjkiFkgO62Em0QXycNsicHeVzo
 SHFZBdaiY2RlDj/KCUk0GVZyeLx+FwCbT71KyiCODaRecerWtmiPRNrG3R543nQpwF2NUR6nRuW
 jrUyAEILj8wmaTFTbCVOD2TX4GLesQboMre7WOms8f1PAsmXea7KK+Pmn07yTqXFzR01/PytL25
 JeEIst4E1OI5T9tadOa3A+yZJbjOrvZzMWxbBTFLUG37v8y9gSKBgvCV8jXf1bJBTjarXb7zfm6
 /a7sPUuAtr1FQFPRb6QOnxtScJiS+Q1hvZ2GPc03feFvA==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by
 mx-relay54-hz1.antispameurope.com; Fri, 16 Jan 2026 11:56:26 +0100
Received: from merchelm-W2.tq-net.de
 (host-82-135-125-110.customer.m-online.net [82.135.125.110])
 (Authenticated sender: max.merchel@ew.tq-group.com)
 by hmail-p-smtp01-out04-hz1.hornetsecurity.com (Postfix) with ESMTPSA id
 E90A02207DA; Fri, 16 Jan 2026 11:56:04 +0100 (CET)
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: Max Merchel <Max.Merchel@ew.tq-group.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
Subject: [PATCH 2/5] board: tqma6: Kconfig: select default SoM variant based
 on SoC
Date: Fri, 16 Jan 2026 11:53:36 +0100
Message-ID: <20260116105351.2934665-3-Max.Merchel@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116105351.2934665-1-Max.Merchel@ew.tq-group.com>
References: <20260116105351.2934665-1-Max.Merchel@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-cloud-security-sender: max.merchel@ew.tq-group.com
X-cloud-security-recipient: u-boot@lists.denx.de
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: max.merchel@ew.tq-group.com
X-cloud-security-Mailarchivtype: outbound
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on
 mx-relay54-hz1.antispameurope.com with 4dsxbn2rwWz1f0tH
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1,
 IP=94.100.132.6
X-cloud-security-Digest: 5d13bfae41dfdd5d86def1bd4312993e
X-cloud-security: scantime:2.085
DKIM-Signature: a=rsa-sha256;
 bh=hY0nk/ZnIubl94Fvml8LgG/EtgDOKhCTciniFvJEcx8=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1768560984; v=1;
 b=g8eNQAdXWJtBFp33XO7Z4IYaQUWSKGd7Wm4hTqolUkL8tQTx0tZQ6yma0BB4x8bMPu6LD0C2
 Da45qOuslU/BTE2D+VdlSFUSYNMBKDN6KBLGjeuohubt5Qh0s5ORof4Invy8zptzfIB6NfHRtWM
 p3vpdETscwmO+mIAMUGTF7aL9tfHl1Q37y+WCCkQznRpYVMexlR/v9SmFcY+fcMEa6ls0P2w4/a
 szf/L+8l2eYSdDPNCweYXHllxGmZAzNTjb7lqaODJDpy7s21XlUAQarg0J1OEWN/HQagry9PACm
 gHYQy0eLyI342AbOsFcjwzPFXzCXsjxbXwJmu5gywP23Q==
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

Defaults for SoM variant should depend on SoC variant.

Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 board/tq/tqma6/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/board/tq/tqma6/Kconfig b/board/tq/tqma6/Kconfig
index 5bdaceae204..e62228d73d0 100644
--- a/board/tq/tqma6/Kconfig
+++ b/board/tq/tqma6/Kconfig
@@ -11,7 +11,9 @@ config SYS_CONFIG_NAME
 
 choice
 	prompt "TQMa6 SoC variant"
-	default TQMA6Q
+	default TQMA6DL if MX6DL
+	default TQMA6Q if MX6Q
+	default TQMA6S if MX6S
 	help
 	  select the TQMa6 module variant. The variants only differ in the used
 	  i.MX6 CPU type and DRAM
-- 
2.43.0

