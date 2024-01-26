Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DB05C47422
	for <u-boot@archiver.kernel.org>; Fri, 26 Jan 2024 12:25:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D41D087C26;
	Fri, 26 Jan 2024 13:24:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="AOX6eLtx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25D0C87BBC; Fri, 26 Jan 2024 10:25:41 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05763878AA
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 10:25:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=piotr.wojtaszczyk@timesys.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a293f2280c7so9548366b.1
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 01:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1706261138; x=1706865938;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=r7Pqrr7BDDT65ASHJTxB5D+GRiaFKxCGiIcpt+J0OD8=;
 b=AOX6eLtxu8o0uuF4mwrv3Qy31/Px6wzLVlgedDY+5yTi8eblFWbmld0lDphY9SvJME
 GyEzoaj9wVywfcwl8yQGnOy/qdVVe7ibNpHih4Gmr+D5ZJRA0p/zXNdi7reNNYCyGuqk
 pGB+eFbGh6atgExici16EQicxuOHIWA60xvWY2MLGKmc0al/RIHvFLJedSrXtrMtjXrf
 DSfq0/+EC+dxnS/msFJqiqSt953GvNUQsj36uCCt7gNhSxfOWE29/lTnVk/W4GmBdJlq
 4V+PZDL4qG7NLgmXvbfXyjmW5gfw3NT0f1+Nh3XoPW0pcoI86ChjcguKbEx9Cx4dkJBJ
 MeqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706261138; x=1706865938;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r7Pqrr7BDDT65ASHJTxB5D+GRiaFKxCGiIcpt+J0OD8=;
 b=ATrarG+1H0lD/J7SC1+dRFU96RhcAVcTVd7sxhsQDLjM4Qs6lnypzUUPgeZkfJ5ZfR
 jONUMoZd49KqCpMAWwPS9fzNembliYle1jeO6P30I6+paaGEvCfUTYpWpydpewUfzIUD
 nA4WbxXjh+XF7f74Gcl7mVX5Z1reLloasN5HzcWk2LwwR1O/dirA5R6fmC1nl2BSt7QV
 MEujHcrqgmUfcLSBsei3lzCHZOzWt9AH3jz8OChN5jEQZpHrGUSn5mWKrY7jvJMmbsUK
 jpFL+Svg40Y5+vvboA5jqgSqA7erYr8RuG3svYpuYwsVh28MLNsRdwuBnLvlWnNVAVhS
 rs5w==
X-Gm-Message-State: AOJu0Yw/lEmSldchGmiOlWvaWlLhOQd2Cp61tSj6cS89IxJyiysd5sDM
 DK0L3/ZnddXlwmgZIhit1NTkldi/B+51d32ljC8k28ml6cwpZiJUH8ag2LHD9O9AMo2kgK+TkJI
 K
X-Google-Smtp-Source: AGHT+IFhHKgfN0M6AdNqJSM8Sta98hV2f7nS/UeZgZwANi/Vx/OrBukXHOJF1oGXr5r3/tRyambQIg==
X-Received: by 2002:a17:906:ae50:b0:a2b:63ca:cee0 with SMTP id
 lf16-20020a170906ae5000b00a2b63cacee0mr308603ejb.11.1706261138174; 
 Fri, 26 Jan 2024 01:25:38 -0800 (PST)
Received: from localhost.localdomain ([91.216.213.152])
 by smtp.gmail.com with ESMTPSA id
 t24-20020a1709064f1800b00a349a5f9f77sm416208eju.47.2024.01.26.01.25.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jan 2024 01:25:37 -0800 (PST)
From: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
To: u-boot@lists.denx.de
Cc: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, Xavier Drudis Ferran <xdrudis@tinet.cat>
Subject: [PATCH 1/5] usb: ohci-generic: ignore ENOSYS and ENOTSUPP errors from
 clk and reset
Date: Fri, 26 Jan 2024 10:25:28 +0100
Message-Id: <20240126092533.20709-1-piotr.wojtaszczyk@timesys.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 26 Jan 2024 13:24:57 +0100
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

If a machine doesn't have CONFIG_CLK set the call to clk_get_bulk()
returns '-ENOSYS' error which should be handled the same way as
'-ENOENT' error. The same applies to reset_get_bulk() and 'ENOTSUPP'.

Signed-off-by: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
---

 drivers/usb/host/ohci-generic.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/ohci-generic.c b/drivers/usb/host/ohci-generic.c
index ceed1911a9..28512c081f 100644
--- a/drivers/usb/host/ohci-generic.c
+++ b/drivers/usb/host/ohci-generic.c
@@ -28,7 +28,7 @@ static int ohci_usb_probe(struct udevice *dev)
 	int err, ret;
 
 	ret = clk_get_bulk(dev, &priv->clocks);
-	if (ret && ret != -ENOENT) {
+	if (ret && !((ret == -ENOENT) || (ret == -ENOSYS))) {
 		dev_err(dev, "Failed to get clocks (ret=%d)\n", ret);
 		return ret;
 	}
@@ -40,7 +40,7 @@ static int ohci_usb_probe(struct udevice *dev)
 	}
 
 	err = reset_get_bulk(dev, &priv->resets);
-	if (err && err != -ENOENT) {
+	if (err && !((err == -ENOENT) || (err == -ENOTSUPP))) {
 		dev_err(dev, "failed to get resets (err=%d)\n", err);
 		goto clk_err;
 	}
@@ -72,7 +72,7 @@ reset_err:
 		dev_err(dev, "failed to release resets (ret=%d)\n", ret);
 clk_err:
 	ret = clk_release_bulk(&priv->clocks);
-	if (ret)
+	if (ret && (ret != -ENOSYS))
 		dev_err(dev, "failed to release clocks (ret=%d)\n", ret);
 
 	return err;
@@ -95,7 +95,11 @@ static int ohci_usb_remove(struct udevice *dev)
 	if (ret)
 		return ret;
 
-	return clk_release_bulk(&priv->clocks);
+	ret = clk_release_bulk(&priv->clocks);
+	if (ret && (ret != -ENOSYS))
+		return ret;
+
+	return 0;
 }
 
 static const struct udevice_id ohci_usb_ids[] = {
-- 
2.25.1

