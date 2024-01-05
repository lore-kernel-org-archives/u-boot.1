Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E897C3DA6E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jan 2024 07:23:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 050228798F;
	Fri,  5 Jan 2024 08:22:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bK+mVHgK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D96498795B; Fri,  5 Jan 2024 08:22:42 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91403876C4
 for <u-boot@lists.denx.de>; Fri,  5 Jan 2024 08:22:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5534dcfdd61so560933a12.0
 for <u-boot@lists.denx.de>; Thu, 04 Jan 2024 23:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704439359; x=1705044159; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9W9W32Y1/i3q8FnsMLifXorFA4pb7qPKubD9mQ5V1hI=;
 b=bK+mVHgK6FoCtspUinP1qSNuFsEXx0TPazsBN32OdiBjCeETyC/ZbYD+7D0pxgDDmS
 7zoOLNtUtHIZcVxk/OJaciXe1GvfUmMmsPIgEYFM3P4lyTGGCEfbNNHpFWyTTGEXKqDY
 yPxDDE8bWHULtjhJmtDlADuJaxoPDQbkWS24fmCZ3TEG0ntAXLHztVhIdHveoD9/DulT
 Mexk/m9GlemEwdmtgGlg3Utc4CUaHolbJHjTXoqWeEAGYSCXUCqdaP1eqCVHPQOA/k6C
 q0a2rMKa6Asp5a26I87Arh5Q9fGdtR4/zjRyQpYFlCaIfmnTkuKaESGK3SsqkQd69Cl7
 IGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704439359; x=1705044159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9W9W32Y1/i3q8FnsMLifXorFA4pb7qPKubD9mQ5V1hI=;
 b=m3ZNq6RgZsH6uzaeWL16BV3iqFQF7BQKs5YTxhiWWVc6erarZmBORdUlkcZWjpjW+m
 UKFgjoPwgRx7ogtKU5It5DkBp23HT+tf2vlC3AZPgEyQHc/ybUkP8GPJXVO1EuJhJjAz
 5jmvSiz0NpmxHqARn221Ojyb1r3qxCxDolYdB397cGMpfbdZbzKf7kVs33CTLfk85AH4
 rUMutws752XeEasRJWc/AZfNnj5RwOZWNM8Rex4dRzk5pXUIWY3LE8JFWtRWjlm7Tjq2
 OEEkLdLjXcuCegb/IR+u1H/bDxfxCbkFvsAUD0fKzxW6T7j5POWE+/J+6X+iiG6hPuop
 AtNA==
X-Gm-Message-State: AOJu0YzTvyrppm+Ua2X3Dvf8/gGHc8dO4sMxaB9pxmrUFamQ+6TknXaG
 KbcKPMEs3wEehe7gyU5EwSA=
X-Google-Smtp-Source: AGHT+IH9Joq93/oEc4Qdt9j9vja1ORKpfVIwPZn4N5xmzcWsRzmaVT6ZDvDnqFixtgkJ14eOKJubHg==
X-Received: by 2002:a50:9e06:0:b0:554:8c9d:c3ff with SMTP id
 z6-20020a509e06000000b005548c9dc3ffmr1745430ede.29.1704439359018; 
 Thu, 04 Jan 2024 23:22:39 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 dd5-20020a056402312500b0055627eeb8b9sm636471edb.32.2024.01.04.23.22.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 23:22:38 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Bin Meng <bmeng@tinylab.org>,
 Ion Agorria <ion@agorria.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>,
 Sean Anderson <sean.anderson@seco.com>, Heiko Schocher <hs@denx.de>,
 Dmitrii Merkurev <dimorinny@google.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v7 4/7] common: console: record console from the beginning
Date: Fri,  5 Jan 2024 09:22:09 +0200
Message-Id: <20240105072212.6615-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240105072212.6615-1-clamor95@gmail.com>
References: <20240105072212.6615-1-clamor95@gmail.com>
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

From: Ion Agorria <ion@agorria.com>

Set flag to enable console record on console_record_init
and not only on console_record_reset_enable. This fixes
missing start of U-Boot log for fastboot oem console
command.

Signed-off-by: Ion Agorria <ion@agorria.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 common/console.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/common/console.c b/common/console.c
index 6f2089caa0..e6d7ebe935 100644
--- a/common/console.c
+++ b/common/console.c
@@ -821,6 +821,9 @@ int console_record_init(void)
 	ret = membuff_new((struct membuff *)&gd->console_in,
 			  CONFIG_CONSOLE_RECORD_IN_SIZE);
 
+	/* Start recording from the beginning */
+	gd->flags |= GD_FLG_RECORD;
+
 	return ret;
 }
 
-- 
2.40.1

