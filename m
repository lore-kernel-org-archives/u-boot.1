Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1403E67816
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 00:35:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33D8A89137;
	Sun,  3 Nov 2024 01:35:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Vf801pI1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 299D889157; Sun,  3 Nov 2024 01:35:05 +0100 (CET)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C4F58910E
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 01:34:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-20cb47387ceso29985935ad.1
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 17:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730594095; x=1731198895; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UqcGr2HQBaHTpFA41xPMR3mQ5RKUGrYCbqTQW9Ba9TA=;
 b=Vf801pI1PU/oeKPfSDbu60J95VLbnTPpl4vzphXIokZMewdlfnGbA9yNdIJnr1PmR/
 4rgteK2sm5lwQavTar4FCNphM2EfQlLdem8qSUsOCkbM+uLOzTqPIs1gA9nnVAyILyvC
 GoZByh1L6lCjNAZqaXrlEUWLoBEmrlhlqSRYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730594095; x=1731198895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UqcGr2HQBaHTpFA41xPMR3mQ5RKUGrYCbqTQW9Ba9TA=;
 b=T/ezs7vpM9ZOicqWfrBd1e1bw8pP9mkONYs10VwsCPDz0/s1knMGmWnOS9OddkDhG/
 2OzaxxhY08RS5I05NsG/n7WOr5Uflms1mGe//kU2Qa1MBxUjgfyYzHRSrRVup0GiZAfS
 uvzTE3P+NJffPzn+oHUkK0slBFYU4yiplw57EeVyNrvw/2l3Gja2cr25E+9DXphc1T4+
 nTVWM3WHwADi0c4Cb+X52Xn1k84mT30etG2ZoTm2gGEr6VyRDclsEdSoOT2EdOwYqHfc
 pPsNRC40GpkcjZTkSQE90gDwEusYBldFvcMaRneBvl5k9ad49MZePHWfj7dIL9QDe0QU
 r4rg==
X-Gm-Message-State: AOJu0Ywa8a8SGn5UM7da7kTLQJxSLeN//qIOT2jfkroQuMCDvyjSnadX
 o2PworAOwdZSAI4bHirBFDheVETyvllz5IlX+x6igBDJj1L8ys3XZsNQ6LjQGUAKLj6831z8qaU
 slQ==
X-Google-Smtp-Source: AGHT+IGAYrnpfiu/S5p6SXZHIv5fg56cq4EaZ+CY5eW4XFxa/zOaZ9lKSW7cDm1RrzVnUXUHKvoqcQ==
X-Received: by 2002:a17:902:ecc5:b0:20c:7181:51cb with SMTP id
 d9443c01a7336-210c6892b62mr395281765ad.18.1730594095474; 
 Sat, 02 Nov 2024 17:34:55 -0700 (PDT)
Received: from chromium.org ([205.220.129.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211057a63f2sm38987995ad.168.2024.11.02.17.34.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 17:34:54 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Samuel Holland <samuel@sholland.org>
Subject: [PATCH v3 04/25] pinephone: Drop status-LED code and use LED
Date: Sat,  2 Nov 2024 18:32:56 -0600
Message-ID: <20241103003322.626036-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241103003322.626036-1-sjg@chromium.org>
References: <20241103003322.626036-1-sjg@chromium.org>
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

Drop the STATUS_LED options and enable LED and LED_BOOT instead, since
this is the new way to access the LED functionality.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Combine removal and enable patches

Changes in v2:
- Add a patch to enable LED and LED_BOOT for these boards

 configs/pinephone_defconfig | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/configs/pinephone_defconfig b/configs/pinephone_defconfig
index 9d39204a439..272fce1c1a4 100644
--- a/configs/pinephone_defconfig
+++ b/configs/pinephone_defconfig
@@ -11,8 +11,5 @@ CONFIG_MMC_SUNXI_SLOT_EXTRA=2
 CONFIG_PINEPHONE_DT_SELECTION=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_OF_LIST="sun50i-a64-pinephone-1.1 sun50i-a64-pinephone-1.2"
-CONFIG_LED_STATUS=y
-CONFIG_LED_STATUS_GPIO=y
-CONFIG_LED_STATUS0=y
-CONFIG_LED_STATUS_BIT=114
-CONFIG_LED_STATUS_STATE=2
+CONFIG_LED=y
+CONFIG_LED_BOOT=y
-- 
2.43.0

