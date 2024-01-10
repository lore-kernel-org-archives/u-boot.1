Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B19C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 07:44:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA04B87A8B;
	Wed, 10 Jan 2024 08:44:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IqqD0K/T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04D7887A7F; Wed, 10 Jan 2024 08:44:07 +0100 (CET)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6148187905
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 08:44:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-50e7abe4be4so4853527e87.2
 for <u-boot@lists.denx.de>; Tue, 09 Jan 2024 23:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704872643; x=1705477443; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zPHHlg9FdQ90XVd55iFRYgLj7sgCzPVYVcdb591IuIs=;
 b=IqqD0K/TXmwmMes3Q673NB7E2yd5nj8M4iIFCvOMwzV8A3FnSBqCQpYUmXCK3ZCU/6
 /dT3PPgGGwpl6KO6NRBW8e/JRDvtGefqavor9+8aWXUshs6kpIsfyK2hu/uN4NCENf4S
 2TKcp9tlR8GFuvfTAuL3ANDYSchh01VanTM1bYxs+yxUm1jJ/IBYLzXzlsmcuQyQTuee
 rEyIeccQuO8bwKGqOa3mBzu/iNBKLcl5ONqXRsfxbXwPBjoO7W+Ujwbi7Z3hEvh0mjCt
 A9EBbxTO/b9WRO15FMbPAhWNO1WEv7IuBXgeLZna0QAG6HUgs7auR+V/LyIyWwOyMBXV
 /4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704872643; x=1705477443;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zPHHlg9FdQ90XVd55iFRYgLj7sgCzPVYVcdb591IuIs=;
 b=HRokuBpRq97xilIePtQ2ry4IRQfjADyU43Sm2wb7OjZGB6wbYy9gLys7cWtpdLfimG
 Q89Mx87wfAFKcuLsYfQKGzwRFQEjfcZGsU+s33+EQ5+Zs1qsMeE4YfpSYU7Ysu+K4xyo
 bVU3BA0kaodmcDCiUnYy5/HBIL1HMwVI5PKiV2A1Z0obsRqpZrSGA8HJcAvkh6jc91CE
 ev+NNqTugVktLy7Hi6PlegQjPrYpoPXqfAYQR6rWvfgzA1lOKdbukZ9vVqYrXB7Wd2Jj
 ghCbpos7beGYM0xF10biicezGV+c5Mpaa4w6klLU/PDunlzgm1qAuMLDtss7obFQE6Qq
 cD2A==
X-Gm-Message-State: AOJu0YyIsMB1MGQ87pstGPzPhBg+6S/g2p1hDas/2zFO9TRdPisvF0FD
 HYnTyoBnefGcDvcOpz4eJVo=
X-Google-Smtp-Source: AGHT+IGDoKhi8KreOBQrVM+4sDxojtHendEnYfpfjxyi0p2vllWnjV6Ky4B2+TmfWqpaTclCwbSFiA==
X-Received: by 2002:a05:6512:310a:b0:50b:e713:574d with SMTP id
 n10-20020a056512310a00b0050be713574dmr174112lfb.75.1704872643406; 
 Tue, 09 Jan 2024 23:44:03 -0800 (PST)
Received: from xeon.. ([188.163.112.64]) by smtp.gmail.com with ESMTPSA id
 lh13-20020a170906f8cd00b00a2bd425eab2sm312282ejb.2.2024.01.09.23.44.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jan 2024 23:44:03 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Anatolij Gustschin <agust@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v3 02/10] video: tegra20: dc: fix image shift on rotated panels
Date: Wed, 10 Jan 2024 09:43:34 +0200
Message-Id: <20240110074342.38331-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240110074342.38331-1-clamor95@gmail.com>
References: <20240110074342.38331-1-clamor95@gmail.com>
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

Subtracting 1 from x and y fixes image shifting on rotated
panels.

Tested-by: Robert Eckelmann <longnoserob@gmail.com> # ASUS Grouper E1565
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/tegra20/tegra-dc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/tegra20/tegra-dc.c b/drivers/video/tegra20/tegra-dc.c
index 7605e77bc1..bcc2748623 100644
--- a/drivers/video/tegra20/tegra-dc.c
+++ b/drivers/video/tegra20/tegra-dc.c
@@ -242,8 +242,8 @@ static int setup_window(struct tegra_lcd_priv *priv,
 			struct disp_ctl_win *win)
 {
 	if (priv->rotation) {
-		win->x = priv->width * 2;
-		win->y = priv->height;
+		win->x = priv->width * 2 - 1;
+		win->y = priv->height - 1;
 	} else {
 		win->x = 0;
 		win->y = 0;
-- 
2.40.1

