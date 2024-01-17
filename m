Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16480C47422
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 17:17:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B10687B78;
	Wed, 17 Jan 2024 18:17:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Xq6FS48f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D61C87B8D; Wed, 17 Jan 2024 18:17:26 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1D3987B6E
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 18:17:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-55783b7b47aso12292655a12.0
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 09:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705511843; x=1706116643; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zPHHlg9FdQ90XVd55iFRYgLj7sgCzPVYVcdb591IuIs=;
 b=Xq6FS48fvaBShdKV8ojM/1B9txDcr01liRICa50ex9y0w5Ed9XsXvCVQbHIqDoIVoo
 u3B08t48jejhl8qs+CTK87OyZlZorfox9l+fjBYKQ6bD31n2Dtqz3dH7K07xIPQ3Q1gv
 6jEbjMaZH8eC5Cg6eZVIAUHsUNQX0ArmWTJReV+H7mMYKAA7RCoqerUh5cjQCYV/DNRi
 bhkPvmOGGKMOrZMGJsIa9E6tSJQ0fWeFr4OiQBEW6xXIPsB+4/pwdb1tCHU6IsKtn5ST
 X6KAoF2pVNuSkCCeUSXGSHN2BG4XVADm3wnQyjtYg1j5xUswlOK8B3kIep3aDrMttvKH
 3H1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705511843; x=1706116643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zPHHlg9FdQ90XVd55iFRYgLj7sgCzPVYVcdb591IuIs=;
 b=DaNan2++iPM/0HiKdhI9ilvvNRQjnnYdLNeQ9yLC7aQni5BAFYTOX8hd21Kbt5Wgse
 7WmCS5y5IVYskIbgHbwprhgG2DmZjFZWnhMicZhSXs2+EU7HKh3sdZoRcaT8diKwx0mQ
 f5sQM0fBtpi+YxK1fjJzfuXXwGsPVhRXXb1kLmPpt8ljl92Sv7u01zIzwhnDgwx9J/+8
 cd6JSlJotNKA0+6hyISor8BHEpEkxVJ20jXzh/ir6Q4FF6VcPELaCTwCz4fu00JlmTTW
 lu69yE5Grle7dPwo+MZgbxH4glCUVQxQabf1DSjZ5iE8NJDo6++M6JDhr8UrNkKpf94s
 +jPw==
X-Gm-Message-State: AOJu0Yxzj7gLngu3losMUmekNi4vP6i4nq6eVx/+VGNH+VvH686huuO+
 r40bqC6d75+2s+b1/jQTgB0=
X-Google-Smtp-Source: AGHT+IHLFAoT3kzms/LDbDhvp2vnqi00AZP4XEzvx4u8jd1GUMLmChpyR8IyRfS1mRx0tzNeBnnAfg==
X-Received: by 2002:a17:906:1289:b0:a2e:d5c7:4b88 with SMTP id
 k9-20020a170906128900b00a2ed5c74b88mr634368ejb.109.1705511843153; 
 Wed, 17 Jan 2024 09:17:23 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 vs5-20020a170907a58500b00a2cbbebedc1sm6904976ejc.53.2024.01.17.09.17.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 09:17:23 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Anatolij Gustschin <agust@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v4 02/13] video: tegra20: dc: fix image shift on rotated panels
Date: Wed, 17 Jan 2024 19:16:47 +0200
Message-Id: <20240117171658.22324-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240117171658.22324-1-clamor95@gmail.com>
References: <20240117171658.22324-1-clamor95@gmail.com>
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

