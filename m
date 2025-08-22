Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03FF8CA0EEB
	for <u-boot@archiver.kernel.org>; Fri, 22 Aug 2025 18:35:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F7B28309D;
	Fri, 22 Aug 2025 20:34:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=grimler.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=grimler.se header.i=@grimler.se header.b="oBmXkdjv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7819282C84; Fri, 22 Aug 2025 20:34:41 +0200 (CEST)
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com
 [IPv6:2001:41d0:203:375::ae])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B0DD8304F
 for <u-boot@lists.denx.de>; Fri, 22 Aug 2025 20:34:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=grimler.se
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=henrik@grimler.se
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
 t=1755887678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uqOlLvnX41kRteRQJTyOeGc9Re/z333JMNKuFo+Q0D4=;
 b=oBmXkdjvIj4uhPk8xahIo5gCwfBlyZG1AW2el87COV50mUTubswgqOzul4Gbtf3O34vx/I
 /ONXw/jVy7MUdx0ZAlxNLzyx6YIurCULIbjZvToTumdfVvEbn3j+GGxpp4thvx0ENIt1Aa
 sU/OGLNG3jEBo2CKPz5BVz3Fu2w8OEw=
From: Henrik Grimler <henrik@grimler.se>
Date: Fri, 22 Aug 2025 20:33:28 +0200
Subject: [PATCH 06/11] power: pmic: fix typo and capitalisation in max8997
 Kconfig help msg
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-b4-exynos-power-v1-6-9e2f2f740029@grimler.se>
References: <20250822-b4-exynos-power-v1-0-9e2f2f740029@grimler.se>
In-Reply-To: <20250822-b4-exynos-power-v1-0-9e2f2f740029@grimler.se>
To: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: David Virag <virag.david003@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 ~postmarketos/upstreaming@lists.sr.ht, u-boot@lists.denx.de, 
 Henrik Grimler <henrik@grimler.se>
X-Developer-Signature: v=1; a=openpgp-sha256; l=797; i=henrik@grimler.se;
 h=from:subject:message-id; bh=sPSnBL/eafFevBEZtLeebqbiZmoOn+dIp3Vut5beqZc=;
 b=owGbwMvMwMW4gT3Pk7swMZvxtFoSQ8aKHcp5Rc9fpeo94ffV5uYxEPkQZHdv56wkxam3Fxyf8
 Sgp6FNvJ6MxCwMjF4OsmCKLTr3muumd8imSKx+dhRnEygQyhYGLUwAm4rqMg2HDgsgNLKkOoksc
 /yw2//FaYJ3NjXM1JfeW3rST7fO80fDFtpHfXaGvWOJoTHpQ2Ifs8N0HI13f7j7zXDrgv6VumfD
 KX9bNL+IZfQwtWbrOPq3euLK0g9vAMVGM+Ufs/iT+i6/5FlQrvgwP6k/TVk/7kt26KMqS9YrKdd
 GQc8mGsS63LGvver2/ILrtrtjHKyuueO++1vw71NZf58hnRib+TzWNuzW5eHsSLls7FM1kfNjeK
 DfvPtPGxJYnEQrnAkIaZZQuX1r0lfN1tmHht/DEK9N7WtcYZUUECTu9/G+9nCvHKfmY5mXbaeVt
 KRmeYt61Z4TviIYfrylkkkmwFL2zKbYxY/ZK06139NoB
X-Developer-Key: i=henrik@grimler.se; a=openpgp;
 fpr=2C7F29AE97891F6419A9E2CDB0076E490B71616B
X-Migadu-Flow: FLOW_OUT
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

To make the help message slightly easier to understand.

Signed-off-by: Henrik Grimler <henrik@grimler.se>
---
 drivers/power/pmic/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/pmic/Kconfig b/drivers/power/pmic/Kconfig
index ec7ccc3a63fda1ecfb5d605ab924d2685b8b7e5e..b1a5b1c2a1feae03fafb77bdfece832c8cac399d 100644
--- a/drivers/power/pmic/Kconfig
+++ b/drivers/power/pmic/Kconfig
@@ -228,9 +228,9 @@ config PMIC_MAX8997
 	This is a Power Management IC with RTC, Fuel Gauge, MUIC control on Chip.
 	- 21x LDOs
 	- 12x GPIOs
-	- Haptic Motor driver
+	- Haptic motor driver
 	- RTC with two alarms
-	- Fueal Gauge and One backup battery charger
+	- Fuel Gauge and one backup battery charger
 	- MUIC
 	- Others
 

-- 
2.50.1

