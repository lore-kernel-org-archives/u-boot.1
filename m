Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35039E784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:28:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D964871C5;
	Mon,  2 Oct 2023 03:15:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WY76MC5y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BC6A870DF; Mon,  2 Oct 2023 03:15:19 +0200 (CEST)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97B4B87127
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:14:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-34deefc2016so49916675ab.2
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209259; x=1696814059; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WZjxN4pn6mXpY3v4HVl0xQzsMPLllM4+ZVVcmuuw50Q=;
 b=WY76MC5yCPYtDsOajP1kPuEqc7zPoNz73skxShAY7FZqEEbafVN5tgVPkXX4AFQpfK
 nhvjxKdDfpRrFyuTkN6ZUy+7bxLZPeIlh8H+Wl3I16TI/FHGPXhoPI6xew8MwQgx/0ui
 wwDm0eHWDf2lw5HFXFcwk+3ycB+8tlsdpqSgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209259; x=1696814059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WZjxN4pn6mXpY3v4HVl0xQzsMPLllM4+ZVVcmuuw50Q=;
 b=F17mRJ+xv07o3pCyqt9Ia7rO8c1ja8XwIhD3O3RmlHC9VSTwLi/weXdjbCb4HVK3V3
 YDixU26oq51hw9uCG1z68V7Zmma9d3UXa/JEeV6T9yFGqbOxOm6M0nlh1pPmq0NIIvgQ
 9EDYyvYiY4lEG49mnTo5qWnN4MtDC4inI/imZnkC1K69RxHvgo4mOiCu81PO7yy/o8VI
 qf7ugKF1YSI2KXhiinNbjTW7plKpVelc3cRUoXhhZf0bCxvP3wIqUIAEpsFxRkZmHizM
 qZl6C7k+IXaQ6dY9TF0rXv08hoOjFw8HKDNgnh/ox+GYgWNdZzCPv4qg501D8XaUjYqp
 GGrw==
X-Gm-Message-State: AOJu0YyvPrBUFkHHjMq3HrlF73MkwYWBIK7EGdiQ9UgxPZqS9Vr00bbl
 hKQBSQX53RIit86tERH2md5CGyGWyIUEqMZnHX4=
X-Google-Smtp-Source: AGHT+IHDBPFyR52gY+SkPA3cANfQbUuGzEtBeWF0/1X9hITS0+6n6dE/OJIQlJCY2WX2kTN7JgGCdw==
X-Received: by 2002:a05:6e02:2166:b0:34f:bed6:60d4 with SMTP id
 s6-20020a056e02216600b0034fbed660d4mr13527947ilv.10.1696209259226; 
 Sun, 01 Oct 2023 18:14:19 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 bq6-20020a056638468600b0042aec33bc26sm3571046jab.18.2023.10.01.18.14.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:14:19 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v2 31/36] video: Mark truetype_measure() static
Date: Sun,  1 Oct 2023 19:13:35 -0600
Message-ID: <20231002011349.461284-32-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231002011349.461284-1-sjg@chromium.org>
References: <20231002011349.461284-1-sjg@chromium.org>
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

This function is not used outside this file, so mark it static.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/video/console_truetype.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/console_truetype.c b/drivers/video/console_truetype.c
index 242b8b71342d..14fb81e9563c 100644
--- a/drivers/video/console_truetype.c
+++ b/drivers/video/console_truetype.c
@@ -718,8 +718,8 @@ static int truetype_select_font(struct udevice *dev, const char *name,
 	return 0;
 }
 
-int truetype_measure(struct udevice *dev, const char *name, uint size,
-		     const char *text, struct vidconsole_bbox *bbox)
+static int truetype_measure(struct udevice *dev, const char *name, uint size,
+			    const char *text, struct vidconsole_bbox *bbox)
 {
 	struct console_tt_metrics *met;
 	stbtt_fontinfo *font;
-- 
2.42.0.582.g8ccd20d70d-goog

