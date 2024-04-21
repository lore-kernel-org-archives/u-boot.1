Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B08C4345F
	for <u-boot@archiver.kernel.org>; Sun, 21 Apr 2024 20:48:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50287881EA;
	Sun, 21 Apr 2024 22:48:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Qe2IjWm+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8744880A1; Sun, 21 Apr 2024 22:48:46 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4F4788306
 for <u-boot@lists.denx.de>; Sun, 21 Apr 2024 22:48:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-34801b1bc4aso625880f8f.0
 for <u-boot@lists.denx.de>; Sun, 21 Apr 2024 13:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713732524; x=1714337324; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pBVP5Przalv5yDifebRQMPqx2ky2ObH1wFnKyIU+1QI=;
 b=Qe2IjWm+cwkJDzIMUc7E79gCOcnR4nHJzwDm0bqhJYGIEW+j8JLSAljzlgI/RnHNNP
 aKMEPBe4ebZZFkinjUhAnJAU5bIynGyt9mpwSz00iWOYyUGgX46o9+dr94bRtGHVwYxb
 IGkuOdm0JnjTAEEVEjVex/UsP13b5T15Yr7CWSoX1NcWnerEc0xXxBUmCVUgZ5TZ01Qe
 hk6o/8eUH3Ey7pvOn7c0ecA07z0ZUG8v1EUpRbUnSshB47md/KAsDi8oviap3HZE9wWk
 j70fTRYoprVAOz+DXOx13LAuaQ/CQUj6rqPeoEHgITwC6fReff0HfO8IhAAqdaMgNn70
 BTLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713732524; x=1714337324;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pBVP5Przalv5yDifebRQMPqx2ky2ObH1wFnKyIU+1QI=;
 b=E2ouHr5M9f9URpQ+Dmp3z1ZZrWW51n5ANYoCJZknuESjc3mKL5EfXiNsTKLTLIFIrS
 0HQjkwnGObvLqmdivLFfnMKeIN/73UchsgUy1Q+ThP4QkIZooDJQ7pP/Wa6FXejpk40C
 AnzGhQRZa/gEjv/ToPxhv/MBdIddqmQqlnlQfuUbV7Efykb+c61SfznK77bu0JgjbX8U
 B89VKKrIJYdTYDiVePSuvRmcRRKtDCGndrDCjdWns6fo/7Yao+b1ll144D8fb+UBBujJ
 TKUYAK1UNX5K/RvqRrfplu2qH5W/sZY2esxt375Tz1PGD2+49Ivi9seYBsiyS9KHpZM8
 OPWQ==
X-Gm-Message-State: AOJu0YzQ37wuGwwp6XQi5G4OCqeWRkthkyn60ndotETP7TSzL2D1kaDm
 BZ6TvSZGvTwa0zGGl1XBcz79oMyY5r2AlQI7jSgKdKzj6Qrc7V34sTA5mu99sks=
X-Google-Smtp-Source: AGHT+IFCVszhrEAcAeumM5ZwtY5C1i0LwroeKm9itB5NWBhU8StQRgDh4a0NYsd1VAgo+zSnU7uvgQ==
X-Received: by 2002:a5d:67cc:0:b0:347:c3c7:9636 with SMTP id
 n12-20020a5d67cc000000b00347c3c79636mr4934571wrw.0.1713732523854; 
 Sun, 21 Apr 2024 13:48:43 -0700 (PDT)
Received: from localhost ([109.108.76.111]) by smtp.gmail.com with ESMTPSA id
 gc24-20020a170906c8d800b00a55ac217235sm1139045ejb.90.2024.04.21.13.48.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Apr 2024 13:48:43 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@gmail.com>
To: u-boot@lists.denx.de
Cc: jens.wiklander@linaro.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jorge Ramirez-Ortiz <jorge@foundries.io>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v1] tee: sandbox: check for buffer size
Date: Sun, 21 Apr 2024 22:48:39 +0200
Message-Id: <20240421204839.2129998-1-igor.opaniuk@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Add additional check for buffer size when reading out persistent
storage value and provide back actual value size.

Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
---

 drivers/tee/sandbox.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/tee/sandbox.c b/drivers/tee/sandbox.c
index 8ad7c09efdd..86b16a3bb8d 100644
--- a/drivers/tee/sandbox.c
+++ b/drivers/tee/sandbox.c
@@ -174,7 +174,7 @@ static u32 ta_avb_invoke_func(struct udevice *dev, u32 func, uint num_params,
 	uint slot;
 	u64 val;
 	char *value;
-	u32 value_sz;
+	u32 value_sz, tmp_sz;
 
 	switch (func) {
 	case TA_AVB_CMD_READ_ROLLBACK_INDEX:
@@ -267,8 +267,12 @@ static u32 ta_avb_invoke_func(struct udevice *dev, u32 func, uint num_params,
 		if (!ep)
 			return TEE_ERROR_ITEM_NOT_FOUND;
 
-		value_sz = strlen(ep->data) + 1;
-		memcpy(value, ep->data, value_sz);
+		tmp_sz = strlen(ep->data) + 1;
+		if (value_sz < tmp_sz)
+			return TEE_ERROR_SHORT_BUFFER;
+
+		memcpy(value, ep->data, tmp_sz);
+		params[1].u.memref.size = tmp_sz;
 
 		return TEE_SUCCESS;
 	case TA_AVB_CMD_WRITE_PERSIST_VALUE:
-- 
2.34.1

