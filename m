Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 110E6CAC5A2
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 20:59:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 454EE88DC6;
	Tue, 17 Sep 2024 22:59:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="R9TZN+lr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AA6688DDF; Tue, 17 Sep 2024 22:59:47 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA5BB88DAE
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 22:59:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=2cee=QQ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1726606774;
 bh=pTNybO2oM+NnRCZbvVrWKp7JLrCmyT9rOwn02BAo/fE=;
 b=R9TZN+lrTqzzvfeH3UMVn0wxWOVZWNBp2d+CPtZXR4qcO7pYWtoJy2tG4aZtiPaAN0Xb5ozXQ
 vaWbR3wAtCImcpQRlc6g7jw3iUIqgWGaKfmfoL2br7apV9KitMDv8eDJ4hhoIjm1U5iYuXPHEBb
 wiuXTDbUmYmXSl0Y5Xlhcvy9gCRFzlSXp7JOc0oJNSqpNOvWiXdQjENmsIyfsheDmWld5AlPdst
 uF0DKPmZ2T55ZMWmhsFi3xrtiB5QuAGUsScfMTO+irtsm+CHMyK58aLszxiC4PLk7Ot23HdCerP
 zs2I+rN+pZ2IIgzpaBcrYZZ/pbpZyEdsGJXZPjf4a4bw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 1/2] regulator: rk8xx: Fix buck get and set enabled state
 on RK806
Date: Tue, 17 Sep 2024 20:59:17 +0000
Message-ID: <20240917205922.648088-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-ForwardEmail-ID: 66e9edb1d8ca6c13c64ed531
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
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
v2:
- Move buck + 1 related changes into a separate patch
- Collect r-b tags
---
 drivers/power/regulator/rk8xx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/power/regulator/rk8xx.c b/drivers/power/regulator/rk8xx.c
index 34e61511d884..b910943c2c46 100644
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
@@ -544,7 +544,7 @@ static int _buck_set_suspend_enable(struct udevice *pmic, int buck, bool enable)
 				mask = BIT(buck + 1 - 3);
 			} else {
 				reg = RK806_POWER_SLP_EN0;
-				mask = BIT(buck + 1);
+				mask = BIT(buck);
 			}
 			ret = pmic_clrsetbits(pmic, reg, mask, enable ? mask : 0);
 		}
@@ -595,7 +595,7 @@ static int _buck_get_suspend_enable(struct udevice *pmic, int buck)
 				mask = BIT(buck + 1 - 3);
 			} else {
 				reg = RK806_POWER_SLP_EN0;
-				mask = BIT(buck + 1);
+				mask = BIT(buck);
 			}
 			val = pmic_reg_read(pmic, reg);
 		}
-- 
2.46.1

