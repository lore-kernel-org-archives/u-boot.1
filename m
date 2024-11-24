Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF74E6780A
	for <u-boot@archiver.kernel.org>; Sun, 24 Nov 2024 20:29:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87FCB89903;
	Sun, 24 Nov 2024 21:27:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uX+CQiLr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51546899D0; Sun, 24 Nov 2024 21:27:49 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6390895B1
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 21:27:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5cfcb7183deso8220339a12.0
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 12:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732480064; x=1733084864; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xddMWgdhIA943YyfjJXuDDfnCAKdDdvEQznM/dPME+Y=;
 b=uX+CQiLrmHyG0NhvtY/jqWEyrKaFW7NbJjRP6aN3YwWzAOnTngFZXv/EI1cBmSajMq
 k6Q+dL6ezskUgz5fP07TMhow17uiVINT7IEC0HCYmwOdTuYYN5BppWuIzNut4TTfe13v
 xB2dW3uSFm8ncRadxJGW0M/sgTRoN6BUZkBxUpTTW76O1FeLKPYV0MoBmwujEpihPTjP
 scVhZdOWovNiUz+5aKwCx430T98KUvLfUGeg/HN10zTFTt/yY4WyXq+gesRUU8Ny3lzl
 Kjv84W4u7yV2LbK5rSA//xwMobwXrOMDKUwPeyyjs5apMIgYqvBPKHEApqaV8bA6pFd7
 Uqqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732480064; x=1733084864;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xddMWgdhIA943YyfjJXuDDfnCAKdDdvEQznM/dPME+Y=;
 b=mWUmPdC/J686jAQuRm3vCHoUI/yFuZgfmOu8tmwvnHGEocIbn8iuBisLfTxV4ahR6S
 3agAQX4xh1BXCEsbDlnGaUDFeVut+viEq9LDhOL9qfBKW70fGB9VB7LUrjFzpLYxxD2U
 Ux3Oyu7xTjUWxQgeiCJ49RDPmULvtM87kTeaJBjsNMXwIn2OIzEJhLaHY6zPyl4/93WR
 JzDA0Nsy0Pzou0RWuTmO3d/ILeFR9tt/2dhCBEPtAexuxAhYDn4pzS2FE4QUTGzexNVM
 T8/h9qIc8ZOZuqTtDHKERxc/zvAG+Zht15LAKFA3D2hO74YdtLH3VA6BjN3oreru436E
 xpLQ==
X-Gm-Message-State: AOJu0YwPXRpyrs81MKXLgfRUgpOXP1SkhiyIweuIqksD0pnf2Ak4boFz
 c6iNBrbAxH2enMWavnhMkovMhsmJMxvgVjL42t+eyHOMB7/EuUozETux2Fu72do=
X-Gm-Gg: ASbGncuQ1SAZRaE2RaEPvXcLXxTwhCy+KfudZuz21dKvTLmhsdCLg1T92YpC9hpucli
 qnziF1x1kfRsaozopKfM7P5cV0GlqBV2JSohoF6PbjInEupQWtzyZRZG9gsuhdL9Ra16c74rxPV
 pmpujS3eSIIxkrYNowVEly08yq5cEh3JCI4DcSebxs77QnibQbpnhWwtgd8bIoOd0OS4z7VTPdj
 ppWDJEieFLoVnTupqWUp00rqG2VLNeCjpqhgCh6phXderfwB4VGHIti90cmmOAYpWsw
X-Google-Smtp-Source: AGHT+IHAsnzA7lddGNe4oET619LY+wX1Mm7FexdMm68Yy3g1Bbrb1RGZqG/wd/V0V6M5cMLwla3KCA==
X-Received: by 2002:a17:907:d23:b0:a9a:170d:67b2 with SMTP id
 a640c23a62f3a-aa509d5c3e0mr1261638166b.29.1732480064345; 
 Sun, 24 Nov 2024 12:27:44 -0800 (PST)
Received: from lion.localdomain ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa50b28cda1sm378720666b.9.2024.11.24.12.27.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Nov 2024 12:27:43 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Sun, 24 Nov 2024 21:27:05 +0100
Subject: [PATCH RFC 09/14] common/board_f: init malloc earlier
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241124-b4-efistub-arm64-v1-9-3e33f0340071@linaro.org>
References: <20241124-b4-efistub-arm64-v1-0-3e33f0340071@linaro.org>
In-Reply-To: <20241124-b4-efistub-arm64-v1-0-3e33f0340071@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Anatolij Gustschin <agust@denx.de>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1324;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=TdQaHg2gZo8/a+Qm8OtrnXXmL8zMHHJSf56iwUc+Lfc=;
 b=kA0DAAgReTBFn7kwMhcByyZiAGdDjDKiuBiefUhk/AZCqh4hfQttzWhFCqcyKkYKRvMs6En3b
 oh1BAARCAAdFiEEF8imOYKt0z8ot6DQeTBFn7kwMhcFAmdDjDIACgkQeTBFn7kwMhefjgEAuLCM
 70oEUioBeQ6jRwHbferbCV0L82RSQfaJ7jCMmgYA+wTg8J3mo+qVzMxwEzTFXReUccfZOR7r5Qv
 59uuyXjoH
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Currently the early malloc initialisation is done partially in
board_init_f_init_reserve() (on arm64 at least), which configures
gd->malloc_base. But it isn't actually usable until initf_malloc() is
called which doesn't happen until after fdtdec_setup().

This causes problems in a few scenarios:

1. when using MULTI_DTB_FIT as this needs a working malloc (especially
   for compressed FIT).
2. Some platforms may need to allocate memory as part of memory map
   initialisation (e.g. Qualcomm will need this to parse the memory map
   from SMEM).

Move the initf_malloc() call earlier so that malloc is available during
fdtdec_setup().

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 common/board_f.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/board_f.c b/common/board_f.c
index 98dc2591e1d0..bddfa6b992b9 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -867,15 +867,15 @@ static int initf_upl(void)
 }
 
 static const init_fnc_t init_sequence_f[] = {
 	setup_mon_len,
+	initf_malloc,
 #ifdef CONFIG_OF_CONTROL
 	fdtdec_setup,
 #endif
 #ifdef CONFIG_TRACE_EARLY
 	trace_early_init,
 #endif
-	initf_malloc,
 	initf_upl,
 	log_init,
 	initf_bootstage,	/* uses its own timer, so does not need DM */
 	event_init,

-- 
2.47.0

