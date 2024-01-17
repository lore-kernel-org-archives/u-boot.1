Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A736C47258
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 17:19:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1796E87BC0;
	Wed, 17 Jan 2024 18:17:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QJ3R5ifu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3803879F4; Wed, 17 Jan 2024 18:17:35 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D2A987BC1
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 18:17:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a2eb5c4dad6so94170066b.1
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 09:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705511851; x=1706116651; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yb+ttg64tTztrEbozQVb9yMpLf6tqGcEI47p0nRhVwA=;
 b=QJ3R5ifuOI1X/3Pt/H0P2o5XDRrBSYZIZzk2vRdapklJxy6CkTYOmeXQYfItaouN76
 T6Yh15wFq8XiNOsW9pwkQtH0aGtBHrSOjljyzEbUymY73orfM09AnPlnugIAIDLd23XT
 rvEZViY+vyRPO5QR8bL6SAnAZmU/fW/g0dm4evIb/OuHYgDHjTrWkazIo50BOLS3SW/C
 V8Y/GoW6w+YfoRH0Q5scMKB3iOPtDO6XgYbKwcNfZ/CrrHhlR7hjOVzovaEfw71Y0XSL
 CnkFFZhjk2OO0AE4MEIE0TaTiJcFmt/sPkqrZg5esdHNhXAMT9kE12ziRy8tNkrnX6WM
 3Xsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705511851; x=1706116651;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yb+ttg64tTztrEbozQVb9yMpLf6tqGcEI47p0nRhVwA=;
 b=sdZuVp6V7sOUiCVHUY8K7Bw1bNT5FbdfHzcp/RvsPAnGrcVUyv+/m1yLJqolXJRTdS
 S0olDN97oGrTvUXkdLF5HATWlpFlxPL922Jsxapzh6+7gHlKKm/b0bbP+z1HFRePum7N
 pBB9w+pM9P388p+T2zplp9XkAZWEHWyLFCSlxt0/2pxWMiwJQKQjOFM4ga7IVvHTmxnM
 p/xGcmqB8tUwDnQxiy+ReVpj//kIZs1gtTFCYWoQut3UGUJ1dKw0E+xUua40TsekqmWT
 YkwEFVRqnMtJyQHfBLJ7068Rq9Q4vwdrmS8YFSaJQQ3RVCf3KzB/mlv/X+GT6q6YTxYm
 6Djg==
X-Gm-Message-State: AOJu0Yy7Qz2PTRrL0ql1+uA3EEzslG6jQ9Rf/UZS7ihwJL+OUc1O/8VA
 nZjCg0mD+obQWUUFprozhVc=
X-Google-Smtp-Source: AGHT+IHOw1TM1+PFi6loRIyokohNUdccWH8hFVnW8rni2sfG9Hj580jA+EIMH8isypILrt9NICtIbw==
X-Received: by 2002:a17:906:3852:b0:a27:5342:aca4 with SMTP id
 w18-20020a170906385200b00a275342aca4mr5094472ejc.3.1705511850879; 
 Wed, 17 Jan 2024 09:17:30 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 vs5-20020a170907a58500b00a2cbbebedc1sm6904976ejc.53.2024.01.17.09.17.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 09:17:30 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Anatolij Gustschin <agust@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v4 13/13] video: tegra20: dsi: set correct fifo depth
Date: Wed, 17 Jan 2024 19:16:58 +0200
Message-Id: <20240117171658.22324-14-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240117171658.22324-1-clamor95@gmail.com>
References: <20240117171658.22324-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Jonas Schwöbel <jonasschwoebel@yahoo.de>

According to Thierry Reding's commit in the linux kernel

976cebc35bed0456a42bf96073a26f251d23b264
"drm/tegra: dsi: Make FIFO depths host parameters"

correct depth of the video FIFO is 1920 *words* no *bytes*

Tested-by: Ion Agorria <ion@agorria.com> # HTC One X
Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # Nvidia Tegratab T114
Signed-off-by: Jonas Schwöbel <jonasschwoebel@yahoo.de>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/tegra20/tegra-dsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/tegra20/tegra-dsi.c b/drivers/video/tegra20/tegra-dsi.c
index e60a1d2ac4..4bd1ca7280 100644
--- a/drivers/video/tegra20/tegra-dsi.c
+++ b/drivers/video/tegra20/tegra-dsi.c
@@ -859,7 +859,7 @@ static int tegra_dsi_bridge_probe(struct udevice *dev)
 		return -EINVAL;
 	}
 
-	priv->video_fifo_depth = 480;
+	priv->video_fifo_depth = 1920;
 	priv->host_fifo_depth = 64;
 
 	ret = reset_get_by_name(dev, "dsi", &reset_ctl);
-- 
2.40.1

