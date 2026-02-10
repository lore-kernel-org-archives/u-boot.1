Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD01EA3F22
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 16:11:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 100FB83D17;
	Tue, 10 Feb 2026 17:11:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SVRjB6oe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD15180FA1; Tue, 10 Feb 2026 17:11:30 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF0F280FA1
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 17:11:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4806f3fc50bso49603015e9.0
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 08:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770739888; x=1771344688;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gLMXeRJzk/F1MP3iOK1XQj2/8Y/Iv20RFR4qmixR/78=;
 b=SVRjB6oeXYsTiEf/dD68zf2z5DOnayjc+lAmE0ufyJZTRyjiaFtujsDZGq5VC9OwOS
 HRxQnhrX/ArkF/JPP3Y8TDoUF4QURlT0H9Kdexh/e20zm8FHjcolmUK5yS+MFDMyrXbg
 fO0dE9Uuisg86bAGVdDHLaVby5XmO+9HX162AAFpqTJH5LDiNfztBehnYnaIjewMqEE1
 DxtSZsL+USo4dkQksDWUWEWqk7Gi8f+K9dTAvDSkbQILCn0V8s4hh+Fmn2inf4ccbhxE
 pZbjAaX5D2eSmm6/uM3VL8v6bIiR9TGdrhjiSjSLdkLbFQbJ6OMqcGqZtF4EzNWqbxZR
 R4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770739888; x=1771344688;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gLMXeRJzk/F1MP3iOK1XQj2/8Y/Iv20RFR4qmixR/78=;
 b=mu4hy2V3sNIepc1QIUFFQBAm0WYYqumfWgmVOp/PVcmIlORL/DFXXrFItpdb5FnWO9
 LgbU/UkVrcT4pt6wmvzD+RlHx/efeoijMuDDOHfo5PKr1O9u1A0kE74shXu1d9D/x5I/
 ZsCsxXsu6t0WQeeJA3wiQ4UtuZR+tgWHWJTZ22vq5yPJt5rxymkIfQB+SniZppmgauCz
 WMaXUh5YIbuew9guEZ+f5DDv35LRJOm9yWLU1mbkM/bX1ZzDz0Q0EUfgGLu8OTynQki3
 bH46feAZT2XeAc1QPOV9v0I5p2M5GUEWzy+tOif8FK2wCX+qXqTnd/1QxFvTEuoE16oC
 dtDQ==
X-Gm-Message-State: AOJu0Yxp2Da4R6tTqHTYJgzVRiLSMWTN7w8v6C77ooKrVB6PvT3QDi7T
 7rSdX8kU1X4a+V2deL4iyb8+aq1tshJg8+pl0HA76Mf6UrkJE30simUmqyQIs+D/tsY=
X-Gm-Gg: AZuq6aL1Mca8v+MwnTb7pSalJTzGJnx+x40uwF/C4yMHAqHphcQc+uH/Jj9UTk0jHqJ
 MJ8KNmQvkMKhilKKB8ZwoeYqJ9tQIx49e44bpJ37cGuHTVJwXDjvmVSN4R1P0rGqwd9d7b57M8z
 2fjkUKjkhLmAIUJcRQSGnirRDHHMH5siQoM5HcjFbWjnNsA40jk1/AeksDBFGe7jsX8faXjyaoV
 dlktfBGWJBmWVyBTrL4M7vdgAI1ggJHnxcSwyJWvmss2MTJ2F2ToC4wawZC+E/eOaQlbBQzdPdI
 7sb8f/chmAMs9C4QXUslwTKykdY0yLiwMZ+IC636bEW6Cc2X5J7+RW+/NpctlIWy5eIlbhhqKEg
 RZ3dNraPx51VHVPvZpKk4uRxWvukpGJiOMQMZEAcxg5omwb6EwsD+4V9KKGjPlYC2h8i0I1EV8x
 Obbg8ykNJWPufcqPI9KhMxEoJ3I3GBqNyWADjDElDrPITrgp3hG+HKaIr0/mJmtV/fdGqUkNuWF
 CqsN4HDvkFjFwuzxkXxFQ==
X-Received: by 2002:a05:600c:c16d:b0:475:dd89:acb with SMTP id
 5b1f17b1804b1-48320216097mr206367325e9.22.1770739888283; 
 Tue, 10 Feb 2026 08:11:28 -0800 (PST)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-43a2-d2f0-c793-0a1b.rev.sfr.net.
 [2a02:842a:d52e:6101:43a2:d2f0:c793:a1b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d7e50casm62994595e9.8.2026.02.10.08.11.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 08:11:27 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 10 Feb 2026 17:11:18 +0100
Subject: [PATCH 2/3] drivers: ufs: add helper for phy_initialization callback
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260210-ufs-ufs_hba_ops-cleanup-v1-2-bf12e31de4a9@baylibre.com>
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

Introduce ufshcd_ops_phy_initialization() as a helper for invoking the
phy_initialization callback from ufs_hba_ops.

This mirrors the existing helper pattern used for other ufs_hba_ops
callbacks and keeps the call sites consistent and easier to maintain.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/ufs/ufs-rockchip.c | 10 ++++------
 drivers/ufs/ufs.h          |  8 ++++++++
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/ufs/ufs-rockchip.c b/drivers/ufs/ufs-rockchip.c
index 0384244387d..cad753d5990 100644
--- a/drivers/ufs/ufs-rockchip.c
+++ b/drivers/ufs/ufs-rockchip.c
@@ -30,12 +30,10 @@ static int ufs_rockchip_hce_enable_notify(struct ufs_hba *hba,
 	ufshcd_dme_reset(hba);
 	ufshcd_dme_enable(hba);
 
-	if (hba->ops->phy_initialization) {
-		err = hba->ops->phy_initialization(hba);
-		if (err)
-			dev_err(hba->dev,
-				"Phy init failed (%d)\n", err);
-	}
+	ret = ufshcd_ops_phy_initialization(hba);
+	if (err)
+		dev_err(hba->dev,
+			"Phy init failed (%d)\n", err);
 
 	return err;
 }
diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
index bc839a43704..74125b1ab31 100644
--- a/drivers/ufs/ufs.h
+++ b/drivers/ufs/ufs.h
@@ -756,6 +756,14 @@ static inline int ufshcd_ops_link_startup_notify(struct ufs_hba *hba,
 	return 0;
 }
 
+static inline int ufshcd_ops_phy_initialization(struct ufs_hba *hba)
+{
+	if (hba->ops && hba->ops->phy_initialization)
+		return hba->ops->phy_initialization(hba);
+
+	return 0;
+}
+
 static inline int ufshcd_vops_device_reset(struct ufs_hba *hba)
 {
 	if (hba->ops && hba->ops->device_reset)

-- 
2.52.0

