Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA0BE77180
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 10:23:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7175680219;
	Thu, 12 Dec 2024 11:21:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mHdJgLao";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82E608021F; Thu, 12 Dec 2024 11:21:40 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CB038021A
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 11:21:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-aa69251292dso78012666b.2
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 02:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733998897; x=1734603697; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XMdDi6fGDTicSDJhNvFMAhZc2SJXBJzimu2zJfHxbR8=;
 b=mHdJgLaoBfwwQb+tBrTrSjvOYIIJx241ruNHpbngcgKPnjD6A353KuWto2B9kXmhP3
 Ot5djfL6I06M4UXKVjVWLIcfydiRvLk7cMFaYKPczbTVJgPJMMRcmfYuZ0sgTF6yBHA8
 kZmnSGSD22XvkDFhCkQt4oanEDtpR51hbYnWb8yjiSQ2i85uDtixXRcHSuy4vMXeVL19
 qtWImn50EN4rfJa7ETJ46egGi6t932ZnIHoNbh3z1D2tEVw01MmnRhr3JLd9BGk+wM5F
 VXEFa0PvKthPDEvlnvwHWuraeYjVUucxW+fzo+s8pXsfLYO6L8nUnBaiiHJr3EhWGu12
 3IvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733998897; x=1734603697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XMdDi6fGDTicSDJhNvFMAhZc2SJXBJzimu2zJfHxbR8=;
 b=B/IV6XTAfvudTyv+Ej8NsCRAcMgu4nbProCEouHS5i9GUGGlRe5N/2862JXpU9npOP
 t1UuPG1VrdrEgubB/R0Yzq4AG56TPf1p4D8K9AycvcQOJTaNbv+EPgaiJbgwjJ05c51I
 q2LTsIXJHNMv1XhnOzbFaVVuNZaS+QTwwgs+8HgCqTrRoaRuAac323RfdYH8zbUfOu4F
 zC+7C+lUG4aLHqIaF/hZzKxC9WK9pYRPtaGPAu4mvt+XLkH9/Og48j9c1ZrGsM2AJ1Wy
 7RrDbz2kO7quxIHM5BBH/y6Q3T4pFMq7qzo7+Do8yu0csXbDoO4PiemDcl/+4u4IjXez
 EXHg==
X-Gm-Message-State: AOJu0YwSej1OkYWcipewRgjayhsoGC8mQElE72DgzPcsxUUf3iHTPXFp
 a1q2sYfaLyPu9zbuKOJmyTwZUTK2FYkJjd87zZlBVowAf9WU3vYY
X-Gm-Gg: ASbGncsBrKlHNGVZ+I26IhdoC9N/ptbsQtUOh9Hep0obXVuHDpnlm+wm4pfRj5STWJQ
 wvJz3ZmGx38VleTPpD/F18CV51L/m+0xFu8KPjPBtQMf8u3SZ0UxMZgf5NRNlXAaCl6W/TWHML5
 1ACexlrVZdyiixTo7BsncTRwy5Nb+ZGAxgt6DbGsQfhvUss0D1190FlCRjHFnyfujYLSxzITIuX
 ssorMahLnTphplkr+ktEop6eT5dWPTe9DM74sTBLfNgyHzo
X-Google-Smtp-Source: AGHT+IEStsvCi74bQ7GpTbT79kTXIccMJIt+ncVK8e8L/nfkdiYma2oCmJD55vA82aNA3EgHZmL1YQ==
X-Received: by 2002:a17:907:3a98:b0:aa6:707a:af59 with SMTP id
 a640c23a62f3a-aa6b13d2f91mr574707466b.50.1733998897324; 
 Thu, 12 Dec 2024 02:21:37 -0800 (PST)
Received: from xeon.. ([188.163.112.48]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa67d6fcd3dsm646818066b.80.2024.12.12.02.21.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 02:21:37 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 10/12] video: tegra20: dsi: enable DC only if it is
 available
Date: Thu, 12 Dec 2024 12:21:17 +0200
Message-ID: <20241212102119.6466-11-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241212102119.6466-1-clamor95@gmail.com>
References: <20241212102119.6466-1-clamor95@gmail.com>
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

Perform DC configuration for peripheral device type only if DC
registers are available. This is handy, for example, when DSI
ganged mode is used and slave DSI has no DC associated with it.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/tegra20/tegra-dsi.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/video/tegra20/tegra-dsi.c b/drivers/video/tegra20/tegra-dsi.c
index 6cf6cffc0e4..0b395dbf9fa 100644
--- a/drivers/video/tegra20/tegra-dsi.c
+++ b/drivers/video/tegra20/tegra-dsi.c
@@ -66,12 +66,14 @@ static void tegra_dc_enable_controller(struct udevice *dev)
 	struct dc_ctlr *dc = dc_plat->dc;
 	u32 value;
 
-	value = readl(&dc->disp.disp_win_opt);
-	value |= DSI_ENABLE;
-	writel(value, &dc->disp.disp_win_opt);
+	if (dc) {
+		value = readl(&dc->disp.disp_win_opt);
+		value |= DSI_ENABLE;
+		writel(value, &dc->disp.disp_win_opt);
 
-	writel(GENERAL_UPDATE, &dc->cmd.state_ctrl);
-	writel(GENERAL_ACT_REQ, &dc->cmd.state_ctrl);
+		writel(GENERAL_UPDATE, &dc->cmd.state_ctrl);
+		writel(GENERAL_ACT_REQ, &dc->cmd.state_ctrl);
+	}
 }
 
 static const char * const error_report[16] = {
-- 
2.43.0

