Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 040CBE7542B
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 06:26:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F36D68721E;
	Tue,  3 Oct 2023 08:25:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JkmwjaVm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E47E87203; Tue,  3 Oct 2023 08:25:52 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C324E8721A
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 08:25:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5044dd5b561so596370e87.1
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 23:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696314349; x=1696919149; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TrrrJR5uwiMiXvc4TVg8NYc1Z2wMAqLDNUClbUu96E4=;
 b=JkmwjaVmF2xd48VHERGS0iUkZtBF46FM0i0KmsHdL4IU3+o9uuMSvan79nzKvP2pcR
 76EMz+fcI/obRQiMj/5RdN7PGc/wGmqrIb2ML1XuhQtTO7TnI37KG3XoKZCpSoyeOFxW
 /j2sSMjQ5Qx6T0rwEDkvVwwGeP2wv48ltfPuqwHpJ4uCA2Cl9erQ205pQF+xjyVh5oGf
 RLa04rGV+lzXZyC0NSueLve2yLauE8Ti2HisSeB9TsKr8tunLZSVlg/D2I+1F8UdKsif
 16D0OXwhDSit3u1yUFqVl4DOgmCoJ/7OdFNVwSKji6kYtWLK5bBZTLnghekPwWnSCZGR
 Y+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696314349; x=1696919149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TrrrJR5uwiMiXvc4TVg8NYc1Z2wMAqLDNUClbUu96E4=;
 b=ezO2KI44FlUTHuCSxjjPMMprA3sEmruKsXcIkpXHhaVITHPnJeRRj+2rI7h3DQ282m
 uFD0uIuZZyYtDaZK59mv0pUkhMlqI75Qf0bj886mmmaSK42shJXxkp4WcbU5d0eY3vM1
 VemRhOC8F3RFjkkAT5Piz6B2I95dmt/njHNZzGe7RiF1gj4C9J1Si/DnGdHjqE2CrNKa
 eCxi7VJsALh5MlVqLBxD64W37qxW2YarQoF+48JE3spsbl/531u/TjCaF6COz5QxSRjO
 12ehndr9iv9V1wku81S5F+whFbX0KOffgkp4rhCihxODB5wMe5djge0PLM5H7YdFfAG7
 ugxQ==
X-Gm-Message-State: AOJu0YxtwyhhwhD+aF0lTCel0p7XvVtMbZNEcHyIGHsoSqeY2Z5+uEk9
 BtBwZ4DLPPiReuiIpr9OHrU=
X-Google-Smtp-Source: AGHT+IE6tLuogxrK/Yt4tB1infEc4Z9h+dj8PjEavX64kMYf6uswNCKCASA5bvpxL3YNUohNv+sPFw==
X-Received: by 2002:a05:6512:3d17:b0:503:c51:74d7 with SMTP id
 d23-20020a0565123d1700b005030c5174d7mr12648696lfv.17.1696314348919; 
 Mon, 02 Oct 2023 23:25:48 -0700 (PDT)
Received: from xeon.. ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 c10-20020ac244aa000000b005031641b40asm74615lfm.159.2023.10.02.23.25.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 23:25:48 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Anatolij Gustschin <agust@denx.de>, Simon Glass <sjg@chromium.org>,
 Jonas Karlman <jonas@kwiboo.se>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v3 3/3] video: tegra20: dsi: use
 regulator_set_enable_if_allowed
Date: Tue,  3 Oct 2023 09:25:34 +0300
Message-Id: <20231003062534.42325-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231003062534.42325-1-clamor95@gmail.com>
References: <20231003062534.42325-1-clamor95@gmail.com>
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

With the commit 4fcba5d556b4 ("regulator: implement basic reference
counter") the return value of regulator_set_enable may be EALREADY or
EBUSY for fixed/gpio regulators and may be further expanded on all
regulators.

Change to use the more relaxed regulator_set_enable_if_allowed to
continue if regulator already was enabled or disabled.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/tegra20/tegra-dsi.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/video/tegra20/tegra-dsi.c b/drivers/video/tegra20/tegra-dsi.c
index 8c3404e085..b4cf4fad5e 100644
--- a/drivers/video/tegra20/tegra-dsi.c
+++ b/drivers/video/tegra20/tegra-dsi.c
@@ -831,11 +831,9 @@ static int tegra_dsi_bridge_probe(struct udevice *dev)
 
 	tegra_dsi_get_format(device->format, &priv->format);
 
-	if (priv->avdd) {
-		ret = regulator_set_enable(priv->avdd, true);
-		if (ret)
-			return ret;
-	}
+	ret = regulator_set_enable_if_allowed(priv->avdd, true);
+	if (ret && ret != -ENOSYS)
+		return ret;
 
 	tegra_dsi_init_clocks(dev);
 
-- 
2.39.2

