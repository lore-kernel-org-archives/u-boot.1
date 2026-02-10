Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18C75EA3F22
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 16:11:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D5C58366F;
	Tue, 10 Feb 2026 17:11:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qoud4iwt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FB8083D71; Tue, 10 Feb 2026 17:11:33 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19AE480FA1
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 17:11:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48068127f00so10005925e9.3
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 08:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770739885; x=1771344685;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HqBRgDpZJP2U8F0S28f0Rg9bzEutOpM4vTlCePpV8nI=;
 b=qoud4iwt6VhTVNT2UnHUYlDME6Hz+VTF4Ix+oH6X9JsEio1lBmy7BwK7rr6oJc5ual
 oIllGG8YI0/Zo+qFl8v0CJ6r5rRFw1B4ecqjjXNFLBv4VdTQPlTATN5yWSS09Xyepa83
 1tSC2DQrxMuONnVuWK3x0EeXIGj0D7XwFGG/0kobJ26qZ57aTdW64yy2aADP+gzzqjTK
 i79c2+1JaWNQzUu7bJ4qM4sYpFfUyZQb7NNu78KOpBS26csv1w+65xJsK34bUmKVEhpC
 9/HaA89gXwkvt65R2+VCtEBlwv5VkBhutCYq/pYozxUfUNaih+zhnFPjYvdbzbGjCgmQ
 ECtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770739885; x=1771344685;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HqBRgDpZJP2U8F0S28f0Rg9bzEutOpM4vTlCePpV8nI=;
 b=o3AYgh3WTvU/LdfCNLY995clkBYPpgUrdMN61KTYtRtDuMQqm5gXp5MkV4FvObOB7d
 UpwKk6KoK+u+lJ4rEaDcPqbtsz+rZ8ljEWbu66y6flIkCZxpGzbLQ2lIZLr5OtHLF6Sf
 EbpXkG8l7e/I3myqbHoMi/aSNsVnf9i1M2om4oa3kA+m2QbKLqVgklTD1af/RqQR3Ynn
 zEee8ufjRMM+gTtUML630h0vvpgZl9HF1xCflxy9Qr9xueGnbC2q5CWAGg8tinoXZ/sj
 FGJUMFjAN1EfH06yuulLhRkyN1Eh3BkPq8/oxATTo+NveA/rJp2fPZKJpq0Z5tVHtGv6
 dipg==
X-Gm-Message-State: AOJu0YxjpIk6hzG9PdCz/8iG1OFz/eNPB4XeABT7jPmlbv4WMzUR2+y7
 6ZevRIPivYfyCK6xpVsaIXNFYWw9TtkmuDT3l4OchFofXQ3Uh0VDNzJiZkJApfUuXeY=
X-Gm-Gg: AZuq6aKzJnHiE3VRjYh50MCo3DS2VzRMDB+9sipwPbIMUGPr2mIPXe/6hm4bMAlLRdh
 tIEwU80wAWrCOSmZaxBx7D0s5xXitSf014+I1KJzHrCFkyCQC2/B5d9GJjxM432N9yTLsM+PS5D
 Ng6Kgk60ErQjqU39Y7uIIOxrOUQ7L01uaY/G3LxXOkiOu8pLBo7mfDm5nOjPAh00VDemQv9p5U4
 ReoPjwWaFOHBBGeler1eFCzWHSRBp6LvrHbGgdXt/n64Xc1EuzcEmROb1fakYGIL0eQ6e23gFkq
 xtbJSHdCoOl5cPZKAoVDMTZVzuvqjwyVUDZgS/tT/o3j0+fWFizFm/ARfdvHtp+oyCDmPV0Ygpu
 2kMGVGh2LXON2A/RTiFU8K8pkUp9Pjwhj23GI/VqRoQ8aSF89HkLNs5IzFb1JHAiSfNVnIJwxR0
 Ta6Z+Klok+Z5J6atd1aT1FmqaCp3TFtZYbnZtfDsY/RUVoJ8s5GXfegGXJEoEktAz3tjirRFB5f
 vW+YrYJEJ5IGjt+9ajeZFQNLt+eQrbv
X-Received: by 2002:a05:600c:8b56:b0:477:6374:6347 with SMTP id
 5b1f17b1804b1-483202311acmr188619515e9.22.1770739885436; 
 Tue, 10 Feb 2026 08:11:25 -0800 (PST)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-43a2-d2f0-c793-0a1b.rev.sfr.net.
 [2a02:842a:d52e:6101:43a2:d2f0:c793:a1b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d7e50casm62994595e9.8.2026.02.10.08.11.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 08:11:25 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 10 Feb 2026 17:11:17 +0100
Subject: [PATCH 1/3] drivers: ufs: handle return values of ufs_hba_ops
 callbacks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260210-ufs-ufs_hba_ops-cleanup-v1-1-bf12e31de4a9@baylibre.com>
References: <20260210-ufs-ufs_hba_ops-cleanup-v1-0-bf12e31de4a9@baylibre.com>
In-Reply-To: <20260210-ufs-ufs_hba_ops-cleanup-v1-0-bf12e31de4a9@baylibre.com>
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>, Bryan Brattlof <bb@ti.com>, 
 Udit Kumar <u-kumar1@ti.com>, Jared McArthur <j-mcarthur@ti.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Michal Simek <michal.simek@amd.com>, dlechner@baylibre.com, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.3
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

The return values of ufshcd_ops_link_startup_notify(),
ufshcd_ops_hce_enable_notify(), ufshcd_ops_init(), and
ufshcd_device_reset() are currently ignored.

Check and propagate these return values properly and emit appropriate
error messages on error.

While at it, remove the ufshcd_device_reset() wrapper, which just call
ufshcd_device_reset().

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/ufs/ufs-uclass.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
index 3c8e4299259..8d60b72fc57 100644
--- a/drivers/ufs/ufs-uclass.c
+++ b/drivers/ufs/ufs-uclass.c
@@ -127,11 +127,6 @@ static void ufshcd_print_pwr_info(struct ufs_hba *hba)
 		hba->pwr_info.hs_rate);
 }
 
-static void ufshcd_device_reset(struct ufs_hba *hba)
-{
-	ufshcd_vops_device_reset(hba);
-}
-
 /**
  * ufshcd_ready_for_uic_cmd - Check if controller is ready
  *                            to accept UIC commands
@@ -512,7 +507,9 @@ static int ufshcd_link_startup(struct ufs_hba *hba)
 	int retries = DME_LINKSTARTUP_RETRIES;
 
 	do {
-		ufshcd_ops_link_startup_notify(hba, PRE_CHANGE);
+		ret = ufshcd_ops_link_startup_notify(hba, PRE_CHANGE);
+		if (ret)
+			goto out;
 
 		ret = ufshcd_dme_link_startup(hba);
 
@@ -598,12 +595,18 @@ static inline void ufshcd_hba_start(struct ufs_hba *hba)
 static int ufshcd_hba_enable(struct ufs_hba *hba)
 {
 	int retry;
+	int ret;
 
 	if (!ufshcd_is_hba_active(hba))
 		/* change controller state to "reset state" */
 		ufshcd_hba_stop(hba);
 
-	ufshcd_ops_hce_enable_notify(hba, PRE_CHANGE);
+	ret = ufshcd_ops_hce_enable_notify(hba, PRE_CHANGE);
+	if (ret) {
+		dev_err(hba->dev, "Controller enable notify PRE_CHANGE failed: %i\n"
+			ret);
+		return ret;
+	}
 
 	/* start controller initialization sequence */
 	ufshcd_hba_start(hba);
@@ -635,7 +638,12 @@ static int ufshcd_hba_enable(struct ufs_hba *hba)
 	/* enable UIC related interrupts */
 	ufshcd_enable_intr(hba, UFSHCD_UIC_MASK);
 
-	ufshcd_ops_hce_enable_notify(hba, POST_CHANGE);
+	ret = ufshcd_ops_hce_enable_notify(hba, POST_CHANGE);
+	if (ret) {
+		dev_err(hba->dev, "Controller enable notify POST_CHANGE failed: %i\n",
+			ret);
+		return ret;
+	}
 
 	return 0;
 }
@@ -2182,7 +2190,11 @@ int ufshcd_probe(struct udevice *ufs_dev, struct ufs_hba_ops *hba_ops)
 	/* Set descriptor lengths to specification defaults */
 	ufshcd_def_desc_sizes(hba);
 
-	ufshcd_ops_init(hba);
+	err = ufshcd_ops_init(hba);
+	if (err) {
+		dev_err(hba->dev, "Host controller init failed: %i\n", err);
+		return err;
+	}
 
 	/* Read capabilities registers */
 	hba->capabilities = ufshcd_readl(hba, REG_CONTROLLER_CAPABILITIES);
@@ -2226,7 +2238,11 @@ int ufshcd_probe(struct udevice *ufs_dev, struct ufs_hba_ops *hba_ops)
 	mb(); /* flush previous writes */
 
 	/* Reset the attached device */
-	ufshcd_device_reset(hba);
+	ret = ufshcd_vops_device_reset(hba);
+	if (ret) {
+		dev_err(hba->dev, "Failed to reset attached device: %i\n", ret);
+		return err;
+	}
 
 	err = ufshcd_hba_enable(hba);
 	if (err) {

-- 
2.52.0

