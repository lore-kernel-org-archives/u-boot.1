Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2238EE4996
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 22:30:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7524A871F6;
	Tue, 22 Aug 2023 00:30:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.b="MM9C0KZX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB2EE871EC; Tue, 22 Aug 2023 00:30:30 +0200 (CEST)
Received: from s.wrqvtzvf.outbound-mail.sendgrid.net
 (s.wrqvtzvf.outbound-mail.sendgrid.net [149.72.126.143])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B8CD87141
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 00:30:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=bounces+31435339-7456-u-boot=lists.denx.de@em2124.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=from:subject:in-reply-to:references:mime-version:to:cc:
 content-transfer-encoding:content-type:cc:content-type:from:subject:to;
 s=s1; bh=jqoXBi4yOFVzry9sebCRkPg/w5jtXFkl21osCppfTtk=;
 b=MM9C0KZXkF8/dDt1jPrM8+zkQGSEOoguesZltvoimjZbrkRXKwVIQNeOiVdu4P4UYBqm
 u5zpVOf5jdn3fYTpUCuIe/QysglFu/vUunoZVvKaUkiCGAijb6sIc6DWQCRv4B7WV0jl71
 8pWrDSnxXjaN18glL7Vta2/dLAaDanoaTybYgh7EXkZ/y56SKAWccwCT9o3e+CUehdB+y3
 QWqz6gRzGwN9Bm97zeDlp29A5AaMVtiVY3V35DSoP46Uox2szbF/AzHBy+rd++PIJ8OHl/
 mf/XTEkKqsFbi54YdxhKH9Aok9px4gEw8esmAjMGlJM8I7kOlPRZ31Xpo1w/pMtA==
Received: by filterdrecv-7765c6879f-vtjd5 with SMTP id
 filterdrecv-7765c6879f-vtjd5-1-64E3E582-2F
 2023-08-21 22:30:26.631219319 +0000 UTC m=+977713.104966274
Received: from bionic.localdomain (unknown) by geopod-ismtpd-7 (SG) with ESMTP
 id 8TaGmFaZQRefHLF6yYqaDA Mon, 21 Aug 2023 22:30:26.411 +0000 (UTC)
From: Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 3/5] regulator: rk8xx: Return correct voltage for switchout
 converters
Date: Mon, 21 Aug 2023 22:30:26 +0000 (UTC)
Message-ID: <20230821223020.3918620-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821223020.3918620-1-jonas@kwiboo.se>
References: <20230821223020.3918620-1-jonas@kwiboo.se>
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h=2FJpaTMi2J+YAZQoa?=
 =?us-ascii?Q?zjl0pHyj3jpnvojE7JshtFq6oXZ774vJkV98NgA?=
 =?us-ascii?Q?uVJ0sjrsJZ0qzgpKJnH8kCgiWMaS4Q6zUg6WKPd?=
 =?us-ascii?Q?=2F6WiJIJnVzMa2UX6=2FcNPr3hzBk=2FVrX8VtIpmgFx?=
 =?us-ascii?Q?X7zeo1GQofkN9lNaLjelPKX9PpVcmhlH4yC=2FG+?=
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Jaehoon Chung
 <jh80.chung@samsung.com>, Joseph Chen <chenjh@rock-chips.com>, Elaine Zhang
 <zhangqing@rock-chips.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>, shengfei Xu
 <xsf@rock-chips.com>
X-Entity-ID: P7KYpSJvGCELWjBME/J5tg==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
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

From: shengfei Xu <xsf@rock-chips.com>

The voltage value for switchout converters is always reported as 0 uV.
When the switch is enabled, it's voltage is same as input supply.

Fix this by implementing get_value for switchout converters.

Fixes: ee30068fa574 ("power: pmic: rk809: support rk809 pmic")
Signed-off-by: shengfei Xu <xsf@rock-chips.com>
[jonas@kwiboo.se: fix checkpatch error, update commit message]
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2:
- New patch

 drivers/power/regulator/rk8xx.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/power/regulator/rk8xx.c b/drivers/power/regulator/rk8xx.c
index 9444daa85c19..e80bd6c37230 100644
--- a/drivers/power/regulator/rk8xx.c
+++ b/drivers/power/regulator/rk8xx.c
@@ -1032,6 +1032,25 @@ static int switch_get_suspend_enable(struct udevice *dev)
  */
 static int switch_get_value(struct udevice *dev)
 {
+	static const char * const supply_name_rk809[] = {
+		"vcc9-supply",
+		"vcc8-supply",
+	};
+	struct rk8xx_priv *priv = dev_get_priv(dev->parent);
+	struct udevice *supply;
+	int id = dev->driver_data - 1;
+
+	if (!switch_get_enable(dev))
+		return 0;
+
+	if (priv->variant == RK809_ID) {
+		if (!uclass_get_device_by_phandle(UCLASS_REGULATOR,
+						  dev->parent,
+						  supply_name_rk809[id],
+						  &supply))
+			return regulator_get_value(supply);
+	}
+
 	return 0;
 }
 
-- 
2.41.0

