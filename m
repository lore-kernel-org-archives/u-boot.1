Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9F82C3ABB0
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 15:46:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD90B82AB2;
	Mon,  5 May 2025 17:44:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PezQC2kn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BA6482153; Mon,  5 May 2025 17:44:20 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86512829E4
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 17:44:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5efe8d9ebdfso529684a12.3
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 08:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746459856; x=1747064656; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0tjJBCLNxO1wfvCX5eYldMUU1dQjYuLWBULp1d1tc/I=;
 b=PezQC2kna8c9yrXDSzjVRxfxrTQp49bao+E4eN8ow6yGLU1s6OwiO0sxIMicpjWGCI
 qrM69GWFyGayXI9BzYlA4EoUv8lL+gsXKmUHFMRv1V2/hqlof4ArN0LAg6fSs5Euajy0
 flT6CihlHn95D2NCDHWVpxmGxV3PJ0kT8PAdw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746459856; x=1747064656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0tjJBCLNxO1wfvCX5eYldMUU1dQjYuLWBULp1d1tc/I=;
 b=sLIoG7fMX27jmaKg6ox9T6erxR+8T/dZdorQkMAxhZn6KeloZtx8scxVrKk0Uvl/0E
 FK1VWTInkUWrw+erpyYc3Et9E7P/BfJIjZoCHIOHm7l9IffHXp/Jx8OxpMbn6fdJdgy5
 rmiTxHbKEyuvgkYxnbM4KOIm1QiKqOWbkZ4p77xE5TyramYOWuac9wPewJ+DrI7aXP/W
 /hcachz0nNmGE9/KR3j7zObCc3vJrAM9PbpuIQRDR8+j5v+2Lb5FvCjtZEIqWzenOEOB
 lh3VmeIEh40ydyyx95iUEoPsR7k/dJCyDOrSR3z/OXs4qMusErkgY2PuTetPHHKfBhnS
 XdRw==
X-Gm-Message-State: AOJu0YzPWCra67KK0QDeO1W8aKItM1N2YX4eqtSG9Z44wmTqLYN+ZVBa
 Z3JEIW2JQIC0XAPwYR/H+aFN/pn6EulNW0TTWVCqkVQ+ug37/pDhecaX4TDKfr+Ltt2ZIdTTrLA
 Mdu2nKr0=
X-Gm-Gg: ASbGncu+Q1bQbz6N3+sAxqj7OE/Trst1qHS//OpPD8xizxQmvI5eKEeC1RGt7pPNxNP
 d0Ip3Y4Ys/3cQ933nlDXLhrcuiwSkBIs8ABtFf9CY5mqzMNPyOLPsbaYnnOZ3tos3J5WNRtiWrR
 4yC+33SyXIkZUIbj7u7mdCWBPJQ+pmy29cRZ+nu6hrYBrb+1nxIZiUel5gj9tCSZ87pQj6dpiV5
 6qsAhn41ueo2Ir1O2CtEmMiHdaHqq+XMqQfmJEfN0JOACJG78edIqxGc4Vivi68gXsKyUd8AdSB
 GV5LBklfpyBMOKr0V1uZQuEqXY7CdhHIvhRg
X-Google-Smtp-Source: AGHT+IHb/gsFS3BDdof/zSCtWkpMBmN6g1TKMXJBJMTqRLYylrx0C/GvU7jvHYmqExAHGdEGHJba9Q==
X-Received: by 2002:a50:858b:0:b0:5f8:624d:42cb with SMTP id
 4fb4d7f45d1cf-5fab05c23a3mr5574513a12.23.1746459856096; 
 Mon, 05 May 2025 08:44:16 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5fa778188acsm5561762a12.35.2025.05.05.08.44.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 08:44:15 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 16/19] expo: Drop space from object name in test
Date: Mon,  5 May 2025 17:42:54 +0200
Message-ID: <20250505154308.2911248-17-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250505154308.2911248-1-sjg@chromium.org>
References: <20250505154308.2911248-1-sjg@chromium.org>
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

Two of the objects have a space in their name. Change it to a hyphen to
match the other objects.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/boot/expo.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/test/boot/expo.c b/test/boot/expo.c
index b05e57b4f5a..517fb09d767 100644
--- a/test/boot/expo.c
+++ b/test/boot/expo.c
@@ -523,7 +523,7 @@ static int expo_render_image(struct unit_test_state *uts)
 	id = scene_txt_str(scn, "label1", ITEM1_LABEL, STR_ITEM1_LABEL, "Play",
 			   NULL);
 	ut_assert(id > 0);
-	id = scene_txt_str(scn, "item1 txt", ITEM1_DESC, STR_ITEM1_DESC,
+	id = scene_txt_str(scn, "item1-txt", ITEM1_DESC, STR_ITEM1_DESC,
 			   "Lord Melchett", NULL);
 	ut_assert(id > 0);
 	id = scene_txt_str(scn, "item1-key", ITEM1_KEY, STR_ITEM1_KEY, "1",
@@ -548,7 +548,7 @@ static int expo_render_image(struct unit_test_state *uts)
 	id = scene_txt_str(scn, "label2", ITEM2_LABEL, STR_ITEM2_LABEL, "Now",
 			   NULL);
 	ut_assert(id > 0);
-	id = scene_txt_str(scn, "item2 txt", ITEM2_DESC, STR_ITEM2_DESC,
+	id = scene_txt_str(scn, "item2-txt", ITEM2_DESC, STR_ITEM2_DESC,
 			   "Lord Percy", NULL);
 	ut_assert(id > 0);
 	id = scene_txt_str(scn, "item2-key", ITEM2_KEY, STR_ITEM2_KEY, "2",
-- 
2.43.0

