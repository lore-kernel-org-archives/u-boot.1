Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C6BCA101A
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 22:42:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 580008888F;
	Sat, 31 Aug 2024 00:42:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="PluzpdOY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 501948888F; Sat, 31 Aug 2024 00:42:48 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B09DE886E5
 for <u-boot@lists.denx.de>; Sat, 31 Aug 2024 00:42:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=a7c1=P6=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1725057755;
 bh=h5GCOaDEm7NtkuqE5WZNb1QEzm593bFc/jFSRJp5UBg=;
 b=PluzpdOYh1VHbBok299/GiPap473XYhExBVilDTMxhGE27bYTZHYjgtw/OdAg1SAvlQl53fo6
 Cu41uSuKfSW9qVkAnTBmXGKUfdSF7nCmbtk9SK07a72dgU2rI5hAy2mot5f6UFUwW6oqRnG/Y81
 C5pFIEO0sRms3fgfXMluCskgt3z5fkezkAYpZpQjacdhGM1qIQw20Ve2Qiu/muRZJVg0GW8UuRm
 mS401HYUrq6XDMVYW882IivUN+AQaqtQboeqeHVZcyyChdZY9SQYZYxDh8WTeGbmXpTT20KD3Ha
 e6O8AZAGHuoLtatHq6cuM02/vQ2Z9+JR/KB4te1R0u0w==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Cc: Jonas Karlman <jonas@kwiboo.se>,
	u-boot@lists.denx.de
Subject: [PATCH] regulator: rk8xx: Fix buck get and set enabled state on RK806
Date: Fri, 30 Aug 2024 22:42:05 +0000
Message-ID: <20240830224207.2568205-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66d24ad86aeca15848b5ea55
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

Wrong POWER_EN reg is used to get and set enabled state for the RK806
buck 4 and 8 regulators, also wrong POWER_SLP_EN0 bit is used for
suspend state for the RK806 buck 1-8 regulators.

Fix this by not adding one to the zero based buck variable.

Fixes: f172575d92cd ("power: rk8xx: add support for RK806")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/power/regulator/rk8xx.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/power/regulator/rk8xx.c b/drivers/power/regulator/rk8xx.c
index 34e61511d884..3f5ec02b3824 100644
--- a/drivers/power/regulator/rk8xx.c
+++ b/drivers/power/regulator/rk8xx.c
@@ -415,7 +415,7 @@ static int _buck_set_enable(struct udevice *pmic, int buck, bool enable)
 		break;
 	case RK806_ID:
 		value = RK806_POWER_EN_CLRSETBITS(buck % 4, enable);
-		en_reg = RK806_POWER_EN((buck + 1) / 4);
+		en_reg = RK806_POWER_EN(buck / 4);
 		ret = pmic_reg_write(pmic, en_reg, value);
 		break;
 	case RK808_ID:
@@ -494,7 +494,7 @@ static int _buck_get_enable(struct udevice *pmic, int buck)
 		break;
 	case RK806_ID:
 		mask = BIT(buck % 4);
-		ret = pmic_reg_read(pmic, RK806_POWER_EN((buck + 1) / 4));
+		ret = pmic_reg_read(pmic, RK806_POWER_EN(buck / 4));
 		break;
 	case RK808_ID:
 	case RK818_ID:
@@ -541,10 +541,10 @@ static int _buck_set_suspend_enable(struct udevice *pmic, int buck, bool enable)
 
 			if (buck + 1 >= 9) {
 				reg = RK806_POWER_SLP_EN1;
-				mask = BIT(buck + 1 - 3);
+				mask = BIT(buck - 2);
 			} else {
 				reg = RK806_POWER_SLP_EN0;
-				mask = BIT(buck + 1);
+				mask = BIT(buck);
 			}
 			ret = pmic_clrsetbits(pmic, reg, mask, enable ? mask : 0);
 		}
@@ -592,10 +592,10 @@ static int _buck_get_suspend_enable(struct udevice *pmic, int buck)
 
 			if (buck + 1 >= 9) {
 				reg = RK806_POWER_SLP_EN1;
-				mask = BIT(buck + 1 - 3);
+				mask = BIT(buck - 2);
 			} else {
 				reg = RK806_POWER_SLP_EN0;
-				mask = BIT(buck + 1);
+				mask = BIT(buck);
 			}
 			val = pmic_reg_read(pmic, reg);
 		}
-- 
2.46.0

