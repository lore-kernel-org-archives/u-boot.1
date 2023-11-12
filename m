Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB7F6C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 20:08:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 317C787528;
	Sun, 12 Nov 2023 21:03:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OK9JbQHw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8BC3874E8; Sun, 12 Nov 2023 21:03:55 +0100 (CET)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB397874E8
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 21:03:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-7a93b7fedb8so133387139f.3
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 12:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699819431; x=1700424231; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5O1x3AjmvcmOi8KgnZxnyKTRikVflrMpw1zI81fdYTY=;
 b=OK9JbQHwGryreezkwaDzMonALEA+X8nBWAqYhT5fZY2hxLoKUiXE0ho3x7gJb0i+ZB
 xCxxz4+iqpJhjYwhxW/3Ygmt8LD2/J+2Xe+5bBx0YsptwSp/Aph7MXJU+IR3bz2xycSk
 O7sghUE2gqYz4j7o7hP/1Fg28RouXZHEFvkks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699819431; x=1700424231;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5O1x3AjmvcmOi8KgnZxnyKTRikVflrMpw1zI81fdYTY=;
 b=QrfuCk5INMgibn9sNunutoz8hlxMjNpwNRbaNyUu1tBbFwPr6WSq+GyFDOPHuj5mF/
 lXknjFQGdVTqZWqyyuuSdSwimDJ6EZr1UEQxddHulumSxswdeKCUbzIqGRF5sPUwCDKZ
 d51k1XDOoRxHr9iOYsn6yTczYAYcF9ayb87CtjW94xAyZfHB3wCZRTSTHWGqm1nmP/It
 sEFHgkAWDTUm5eDTjp+e3nJvixObBYGloTJ7tE5FxZdXdhu18PIMm3cC4gzUyCKrGHBS
 d6Thcrypk9bTdS/f8GjS6SFffX/ktKtsuhrgXsHSSXS36GAAPDlr2vhym1fchbS6hrhF
 JKGw==
X-Gm-Message-State: AOJu0Yz00J6NYBMnIIaa52ij6cGDx51jDtj6X+1XBOpcCF4yA55UC+Pd
 KLSRvVsP265cFYkYyylP+3dlgzrLLn6+x9RhsZS2Sg==
X-Google-Smtp-Source: AGHT+IEVGuVClbRaAdXiUSRX6W8NXZJGCrmNkcDxNHtXuhzwKtXqCFqEIEeaSvTL4yPaEdcK00gsLA==
X-Received: by 2002:a05:6602:2e89:b0:7b0:1c03:55ae with SMTP id
 m9-20020a0566022e8900b007b01c0355aemr6537922iow.1.1699819431464; 
 Sun, 12 Nov 2023 12:03:51 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 g33-20020a028524000000b0045903dcfa05sm1239951jai.109.2023.11.12.12.03.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Nov 2023 12:03:51 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Pavel Herrmann <morpheus.ibis@gmail.com>
Subject: [PATCH v3 1/2] dm: core: Correct reference to DM_SPL in SPL_DM_STATS
Date: Sun, 12 Nov 2023 13:03:46 -0700
Message-ID: <20231112200349.172779-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
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

This does not existing anymore. Update SPL_DM_STATS to use the correct
Kconfig option, which is SPL_DM

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Split the patch into two

Changes in v2:
- Add new patch to correct references to DM_SPL

 drivers/core/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/core/Kconfig b/drivers/core/Kconfig
index fe5c41d57ecd..209d90e01fa5 100644
--- a/drivers/core/Kconfig
+++ b/drivers/core/Kconfig
@@ -88,7 +88,7 @@ config DM_STATS
 
 config SPL_DM_STATS
 	bool "Collect and show driver model stats in SPL"
-	depends on DM_SPL
+	depends on SPL_DM
 	help
 	  Enable this to collect and display memory statistics about driver
 	  model. This can help to figure out where all the memory is going and
-- 
2.42.0.869.gea05f2083d-goog

