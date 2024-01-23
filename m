Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C9EC47DDB
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 17:20:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC86087E67;
	Tue, 23 Jan 2024 18:17:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Nr38dw1Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45A2087D61; Tue, 23 Jan 2024 18:17:32 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5537E87DD6
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 18:17:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a2d7e2e7fe0so777122866b.1
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 09:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706030236; x=1706635036; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1i01SyKX8F3P2rsPYsskPptwo3VebpTco09Xd3yBJfk=;
 b=Nr38dw1QrtIlKyscfCFneop25t5EEgpYYnWPRX7bk9JHaYHBQkcngET+4wMNqnYtTA
 LD501cwFQR2swc0XVHFutklEJJn/MFbWW6gg39lsBLs+Sg0/oFoNzf0FGLXNkP6AjZXC
 NfNtkIq5NPvDlyN31SGqmeS2EU/Ec3MglTNij+Z9Pu+hlz3rtqxyTOsNIssPzFMaUcQh
 ctC6Deahuq3oKOuEVc9eWA3R9Zcj2+Pt1oXh92Zw5YCAR6HThb+usQznVy+3IJvSx+IC
 qXt2FM1MmVBblrlVEdBl+ctZgQ5t4SJCJuIjzFAI9FW0gWZHTpnglfzleAL5Cfnu3lO8
 XidA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706030236; x=1706635036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1i01SyKX8F3P2rsPYsskPptwo3VebpTco09Xd3yBJfk=;
 b=HPEB173Qd5sLTEDiT7eh5TLk/gmQvprkb0iqi1kjRX4+R6xMdxopJ1sAJUwnU+tUqZ
 hUf4ARsLWYysLF2pXSsUrtO2CDDgraBt1gzFAB87ddFmjp0WAnjJm8YK/w36pbDbHJ0i
 JRzPmgnZPlKn0V3fEIZK4WkV5QXJwSAWswqkIjKGDKxe4sHuY1aJNBTefifNNpdtdOju
 KPJ/R6o0BHFJLmNevcSurFUoI5YwQcAHyJrkkmM3gtFu67feJ6wrHw7CUJdt2dBw44Jz
 bPB+ShykgUVTmxIXwa4lh83ba9GSLVuY0s0aGz38oSiS+Xg5BQ+8dbNB5QLq282ZdXrH
 czKw==
X-Gm-Message-State: AOJu0YzuL3jOWGJfPNay8PSSMhAhqvzMtnF7TkeCdgpla/GF/kCAu31Y
 avslXQyirqGvzjYy2bCE0CHBr070voWtinRHvxKL2x3lxTDIHA2z
X-Google-Smtp-Source: AGHT+IGrvht2leyn4f5rwR17BMkArfIKNSRhdgS0Zt5lJ5pd+iqzoK6RLO9LhY+iFT3tS1nM0soo9Q==
X-Received: by 2002:a17:907:8b87:b0:a2d:f6b9:b94c with SMTP id
 tb7-20020a1709078b8700b00a2df6b9b94cmr131267ejc.20.1706030235594; 
 Tue, 23 Jan 2024 09:17:15 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 m27-20020a1709060d9b00b00a2c7d34157asm14269068eji.180.2024.01.23.09.17.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 09:17:15 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Anatolij Gustschin <agust@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v6 17/18] video: tegra20: dsi: set correct fifo depth
Date: Tue, 23 Jan 2024 19:16:32 +0200
Message-Id: <20240123171633.246057-18-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240123171633.246057-1-clamor95@gmail.com>
References: <20240123171633.246057-1-clamor95@gmail.com>
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
index ddd74540f2..7d63557d1b 100644
--- a/drivers/video/tegra20/tegra-dsi.c
+++ b/drivers/video/tegra20/tegra-dsi.c
@@ -873,7 +873,7 @@ static int tegra_dsi_bridge_probe(struct udevice *dev)
 		return -EINVAL;
 	}
 
-	priv->video_fifo_depth = 480;
+	priv->video_fifo_depth = 1920;
 	priv->host_fifo_depth = 64;
 
 	ret = reset_get_by_name(dev, "dsi", &reset_ctl);
-- 
2.40.1

