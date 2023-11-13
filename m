Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DEA3C4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 03:00:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0ADD686D33;
	Mon, 13 Nov 2023 04:00:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Xg/q/jHk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABC5C87076; Mon, 13 Nov 2023 04:00:14 +0100 (CET)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79DC386DD2
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 04:00:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-35743e88193so17153935ab.3
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 19:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699844408; x=1700449208; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+xoSFFQtoqyZDdsCcVqLGmNl/eFAsBaGw1HuSpxCR2k=;
 b=Xg/q/jHkSUh11mLyxB5l2qxGhxl9Mo/87HJeBf9cmWMkaZJqhHYfhNVg87o/UcMDwT
 UOVx4zGYUsa6cBtrHWN4zzK520Lr8O4vE+yU1N1CI74Awn/Std22tk0TXT26A8wXN5yv
 pfi9yh7f+rice7JZpeXytsxJsQVStCjEGNocE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699844408; x=1700449208;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+xoSFFQtoqyZDdsCcVqLGmNl/eFAsBaGw1HuSpxCR2k=;
 b=WFrOSZLf4YO5VIk/y48wz7T7ziAfm+oMlxoUsVmmzbrLR0b8OXNDgZdwDtLeJ40+RC
 iB0ut/fMzDdHI+8EdOQCte4OHAhuZnvyKAJ41HEvmG3D0cPMU4HDk6ZsElDif9o/OBwo
 Jr2GJd1rM1cWvtTu1WmUZxeri9wlLA/B2IGvKXnK1VpHeSkwDUZr2Dk1b4mIkknvAp9J
 P1bas6oF1DlKEX2bIs7V1pitBIFTXvfEy8h95m3T6OJYS7/jdlJi9pcA+wp2TnjUY8jT
 XMwtPP1LTvOBSf1zMhAGzXZ643tFu2B3CdX2xWznIX9GWBGw/cUmSurXDrxynYHWBZJY
 pISA==
X-Gm-Message-State: AOJu0YxO2CfOGjRHpvR4+eJbTKCcXIi8FyN/YIQ6hDAQf3ZV+8LgFXOI
 AnS8M4zA5xnzMG7ZaWebK/mW9Furxw1t3K7Mlac9iQ==
X-Google-Smtp-Source: AGHT+IGVxdso/Z1r0+MzbqMH9pLnd4HHldG1GgkCzjeCNdvNYixgIK6FRcSxw0qOyr9dnMEsdn/e7g==
X-Received: by 2002:a05:6e02:216a:b0:357:a049:91c4 with SMTP id
 s10-20020a056e02216a00b00357a04991c4mr6003955ilv.22.1699844408089; 
 Sun, 12 Nov 2023 19:00:08 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 c16-20020a92cf50000000b0035134215863sm1350914ilr.55.2023.11.12.19.00.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Nov 2023 19:00:07 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 3/9] turris: Use checkboard() instead of show_board_info()
Date: Sun, 12 Nov 2023 19:58:23 -0700
Message-ID: <20231113030001.240020-4-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231113030001.240020-1-sjg@chromium.org>
References: <20231113030001.240020-1-sjg@chromium.org>
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

Boards can use a sysinfo driver if a particular model name is needed.
Update this board to use checkboard() directly, rather than having a
weak function laid on top of a weak function.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 board/CZ.NIC/turris_mox/turris_mox.c     | 2 +-
 board/CZ.NIC/turris_omnia/turris_omnia.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/board/CZ.NIC/turris_mox/turris_mox.c b/board/CZ.NIC/turris_mox/turris_mox.c
index 63b869921943..3489bdd74bda 100644
--- a/board/CZ.NIC/turris_mox/turris_mox.c
+++ b/board/CZ.NIC/turris_mox/turris_mox.c
@@ -562,7 +562,7 @@ static void handle_reset_button(void)
 	}
 }
 
-int show_board_info(void)
+int checkboard(void)
 {
 	int i, ret, board_version, ram_size, is_sd;
 	const char *pub_key, *model;
diff --git a/board/CZ.NIC/turris_omnia/turris_omnia.c b/board/CZ.NIC/turris_omnia/turris_omnia.c
index 19c5043fcbaa..adeb69a205be 100644
--- a/board/CZ.NIC/turris_omnia/turris_omnia.c
+++ b/board/CZ.NIC/turris_omnia/turris_omnia.c
@@ -962,7 +962,7 @@ int board_late_init(void)
 	return 0;
 }
 
-int show_board_info(void)
+int checkboard(void)
 {
 	char serial[17];
 	int err;
-- 
2.42.0.869.gea05f2083d-goog

