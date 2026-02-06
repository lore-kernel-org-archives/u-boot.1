Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1790EE6B60
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 21:16:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E2C483A64;
	Fri,  6 Feb 2026 22:16:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XRDH7Acs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8529A83AA7; Fri,  6 Feb 2026 21:50:24 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A6E283642
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 21:50:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7d1866473b0so1359503a34.1
 for <u-boot@lists.denx.de>; Fri, 06 Feb 2026 12:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770411015; x=1771015815;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QUWMQOK+XMlC/RFdK8ywd+zc1BqNmygnM3K5nnOcsBA=;
 b=XRDH7AcsMcU/tKG4QHeYuq5xRviErfoW/gsNiJVDyzOE7f2DH1CBoAJ4m2JTcnyFpP
 /iwLa7hppbplxGvSOl3bhfBBJ5ZMA3T3Jf5cP+ZAVk/KYRbFkA0HlWpoMcYb/jxU+d6C
 1oAc4LDCYPVP0+vGQ75vJRmbuYcyQBIjMfeliHOdRk9LA5s43SCHAS1RpGXAMwS7uIe7
 N2Tw3OpzzKUQqcl3ssmnafA9FVMQkZqxws1vgCkGodQcJZicgDzestOSmFKSrSP7rApI
 KVXNO8qu6jXuFpjUmR5BLw6s79zASDl3+c+AjpcIo3Dfzyl8knEYdMEEKhmp7rMpiXqQ
 YSEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770411015; x=1771015815;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QUWMQOK+XMlC/RFdK8ywd+zc1BqNmygnM3K5nnOcsBA=;
 b=ZIMOCbHekrwQPZqGIUIrXTW+chCZ00gvjdWgVeFtx3H6qmXD2WTKDkhNpaHAULHit1
 99mUJMRM5vFP+W1bV8BncNCV1A35ATLlz2ZvqjJaL+Nt8/+H19P2RqJKvQ9DuP9r/ulB
 Vw6hZ64FwAFfdCSB8gnK5hGeGaMNvXS6mdGmuj0FviLb+w8go8CPgvhOzzL7UxpBx4/M
 d0uPLbNfr3azOlhrKrQgrVVp7ZLxp2Kv4uvz2zTrmQwZfJcrxaDPK9wLm5f3daiqP5sV
 Yp1qaeTk4hIbeI5LyBg4PIRxkV4LaY/FdL36ceLZJS2NFaFzU/o3hgfatQrh/o7BOPnS
 quAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+psrJXLeZkDqKepoGWRuddupv9WesAXEJEtolQkTbVZbaVwchGGe1WAPyASq+IllBA79CJls=@lists.denx.de
X-Gm-Message-State: AOJu0YyMLRxpdKTLeMNDigBXgmjt/p7frdBy8M48tX2L13hR6+rZqixO
 Tj8UQRW9m7+hyRIsDgvl1PT4Ltd/RMG9UtlqY8p2mcTTAw8m2LGyzv/5hITqTiMMpwJhNUL6AF3
 3Blkz
X-Gm-Gg: AZuq6aKZvV9rJFLUdF10hSmExP6ZEw8ooIitUWkB829QngW4j29ODOAv0BaDz+EW9vn
 owFzZlbr/FFpq83NtLxanNvKWhc13xGxCL+2JLvyve4b/oM1SVNhGY8cQ6wfaugwVLsxRVeOBTm
 TP0/rF4kIyvBcRJZ9irq0RF6/jN0Ib1QWDVeD8s4uSvpQmUwBkDLfdYHsxg6f6sYg6kGnPsVE1G
 pxe/u3RviW/bq/gUXWTojvDCSmLKnP8iqRLF8Rnxe8J437Tu8RKvFeGx7/fnzuBgj9odM8xvJtR
 Wtk2mOYaf6+9AX2v0XvM/mW+xoyfyQi3diGn31npLQ1jgDBBE2DC+hwziu5wxwlHKU9SNT0cm/X
 JYbF2dMXyI3xZvDl+tlkJ3dh1CxKqLSSbzHgNcjV96k5iaIFMQKwoJ4+mgpQ7bFKVz1JPET96Tq
 DfVtfBhx+4bswagxgVdoteOukneg==
X-Received: by 2002:a05:6830:6015:b0:7cf:d168:2120 with SMTP id
 46e09a7af769-7d464679ca9mr2250864a34.34.1770411015602; 
 Fri, 06 Feb 2026 12:50:15 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7918:a69e:53a3:9e1c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4646fb89fsm2334155a34.1.2026.02.06.12.50.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 12:50:14 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 06 Feb 2026 14:50:06 -0600
Subject: [PATCH] mmc: mtk-sd: add mediatek,mt8189-mmc compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260206-mtk-mmc-add-mt8189-compatible-v1-1-5243eb8b7e2b@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MTQqDMBBA4avIrDuQBBp/riJdpDOjDhqVJJSCe
 PeG7t63eRdkSSoZhuaCJB/NeuwV9tEALWGfBZWrwRnnjTMeY1kxRsLAXLuzXY90xDMUfW+CPrS
 Wn9RawwT1cSaZ9Pv/j6/7/gGLULNXbwAAAA==
X-Change-ID: 20260206-mtk-mmc-add-mt8189-compatible-6a71d5c710dc
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1648; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=0aRoNMokXsPgcN/hCPgJbXWELipJTSO2It7FnSacOjc=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBphlP/NnV0wxuYEzF5RzQ7n9CpzSaWIXbXAIeeK
 G+vkWeNn0qJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaYZT/xYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AWaQH+gLXRHRBv8kw+vSOlj+PgU0RyhlT0NZS7YQLqlI
 XdiXa5K9aOJf38/A0inN/02ZMqjGkqN9kUpELKEMXBkZdop4NX4C445nvxtRMR1LKX++EEffVNs
 Ndz9u4oUdtjj75m0eGRyS4z9mJNIh/GzgjOL6biKIlk1Pv67481awpf/ZdhLtcUelGeOP11+1xN
 Og7cgmCXGrnFLpNsd50bWJZqrKMtoN6dn1nTEYd4B6TXuy+FedMSrJWBDs8vQ9xUGfQCZLAZZP0
 ZW6av9V3BrLeHvyFhcsKq4qYawtTP61VDBWXDBrv90Z79gHH/exwAPIEYB5RpDtV9wt3185qMD/
 USGk=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Fri, 06 Feb 2026 22:16:28 +0100
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

Add support for MediaTek MT8189 MMC controller.

According to [1], this is similar to, but not quite the same as
mediatek,mt8196-mmc.

Link: https://lore.kernel.org/linux-mediatek/20251203-mt8189-add-mmc-support-v1-1-f5ce43212fe9@collabora.com/ [1]
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/mmc/mtk-sd.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mmc/mtk-sd.c b/drivers/mmc/mtk-sd.c
index 4928a880038..7a4bdee7496 100644
--- a/drivers/mmc/mtk-sd.c
+++ b/drivers/mmc/mtk-sd.c
@@ -1979,6 +1979,16 @@ static const struct msdc_compatible mt8183_compat = {
 	.use_dma_mode = true,
 };
 
+static const struct msdc_compatible mt8189_compat = {
+	.clk_div_bits = 12,
+	.pad_tune0 = true,
+	.async_fifo = true,
+	.data_tune = true,
+	.busy_check = true,
+	.stop_clk_fix = true,
+	.enhance_rx = true,
+};
+
 static const struct udevice_id msdc_ids[] = {
 	{ .compatible = "mediatek,mt7620-mmc", .data = (ulong)&mt7620_compat },
 	{ .compatible = "mediatek,mt7621-mmc", .data = (ulong)&mt7621_compat },
@@ -1990,6 +2000,7 @@ static const struct udevice_id msdc_ids[] = {
 	{ .compatible = "mediatek,mt8512-mmc", .data = (ulong)&mt8512_compat },
 	{ .compatible = "mediatek,mt8516-mmc", .data = (ulong)&mt8516_compat },
 	{ .compatible = "mediatek,mt8183-mmc", .data = (ulong)&mt8183_compat },
+	{ .compatible = "mediatek,mt8189-mmc", .data = (ulong)&mt8189_compat },
 	{}
 };
 

---
base-commit: e5e75ea8c7b8e6d9ce1ca8ec7a25fa8b3f6029a9
change-id: 20260206-mtk-mmc-add-mt8189-compatible-6a71d5c710dc

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

