Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 522F4C677C4
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 12:37:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B96C682C49;
	Wed, 11 Jun 2025 14:37:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="qE9aujrk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F72A82B7C; Wed, 11 Jun 2025 13:51:37 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7776282B20
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 13:51:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ad89ee255easo1188517766b.3
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 04:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1749642693; x=1750247493; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1aROTCpSUU0aZ02NwtmjKwuatkbaW7YVvzkZ+TI2vzI=;
 b=qE9aujrkGXQlKDzjtAYiqM2mY5Ay5cK+PqXfkeR+7A/SBIzdRfxvIrxZhpj8jeA/zF
 QUuYe5TT10B2X4IiL1j1ClAqLZ09lVwRYAle2L+tdiOt3+wKINtveSTHybTb0owJ9eNy
 EXKrR9LHIQECVkFIJUmJMx1D/lNkKqhX1pGYKMA2eQRAEAQrFr/1jL83EljHNi9294Og
 jhOC/6fQtT3IfrhFdDv1Gu/lTM0790i0YavKfF3YXUbik8I/uAajRgAgAgHLmzzi4zUc
 lW9JTMZXHcUbYUPvrr8kFTrnDMPQbN3JzBB0W2/qXZCqRmz8Ko0/sqe9+sreaudGruO0
 FZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749642693; x=1750247493;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1aROTCpSUU0aZ02NwtmjKwuatkbaW7YVvzkZ+TI2vzI=;
 b=A8UwgpmQXasuMwnKWxZmCEEVXaxoPeKzJVu0qcTnA0GoRpSiRJ0lWFDVkg87o5G4D+
 sQ7oi3/3Ai8WGac9hasupkFayvOd/VXY2Y48Nw7nDzFtRjrTwws8CjMrwbqtlWfAhEB4
 coHGjkzcfWvFV7gJyOZcvAiNI2RnHrRFEKjlJ60IIYNfrzKXtD7fLuiOaXsAkd6KnxpJ
 LV0hTDGg4OfjVB+opkX6phhYVEQOr4H3GB2k3CGTtIzE7alTMafPIQJkrktLEdE0lk6K
 p2rAVvLX89VbyMEI4Ys4gHo9Z+/pxYxBMXUKBIRuiuYXbx+CCM11hq5ENNglNjUypcfe
 d3/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxDsh0rBQSwk7mJiADYaiozIP0TUmEa0aljSBw1c7BiA4yxovnZE3HrB4W71porCXrmm9rczI=@lists.denx.de
X-Gm-Message-State: AOJu0YzoiDrOKGzWzAvX4wth9yefpkBWiY2AY1iRyxOe/VtoOf8tW1NE
 FM0CfP3iwy4reXKog95Uj26zqs3YFWqmdtZrX7+p8y+OWXSVKOxDZ73Zw2SS3IXn4+U=
X-Gm-Gg: ASbGncuwMsVbYSVw3N4JV6/wq8X0hpSzyrPsNNdTOpqggVVn5P9xWaIrJab3s6vwU3d
 2a08xQY5o94opQn0B8qrsym67/mLDoXjsaP8fOfxcfBDLgrHHIDTJUeRH9uzZ/VY7EpWwgRGYXG
 vVmQsv2Pq0txdKuENGZQzk5/t/OGMfG3B2QqFBps5L4A4XZnqTlhfQMIOhQ/zUNdoQSpGm4IPR6
 tGVolrBAodEsmJd0Pq+3wbffNDp89rsZ4jqm+qjj+Cbq11vT18AyLcc0n2BNcE7c5JlKv0M5Q/j
 9DEgqbh7zYlBQFz+mSJNF1c3kEMwXCrWE+LyeaIuYxiEvkhG3yf3+muuK25Aqb5esoYOS5nNfh5
 BU3nsUBwoNAwt9+j610eUOHdhbDbXYo53
X-Google-Smtp-Source: AGHT+IGxmtGT3+06bGFGj3+Qxaf+Lv/ZC4eG70o93v6rCizXcVkCtaoT021zUIKBE4kp6ZFM8djd7g==
X-Received: by 2002:a17:907:6e8e:b0:ad8:9c97:c2dd with SMTP id
 a640c23a62f3a-ade8c72f339mr271301066b.17.1749642692872; 
 Wed, 11 Jun 2025 04:51:32 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl.
 [144.178.202.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ade1d75467fsm891666166b.14.2025.06.11.04.51.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Jun 2025 04:51:32 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 11 Jun 2025 13:51:23 +0200
Subject: [PATCH 1/3] doc: board/qualcomm: Fix commands for compilation
 missing CROSS_COMPILE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-qualcomm-doc-update-v1-1-5cf8cd94974d@fairphone.com>
References: <20250611-qualcomm-doc-update-v1-0-5cf8cd94974d@fairphone.com>
In-Reply-To: <20250611-qualcomm-doc-update-v1-0-5cf8cd94974d@fairphone.com>
To: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749642691; l=1060;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=kpK2lsgassTNco1gXQpquNOqPMSTRuciyVe/ijqv1aU=;
 b=zDCFzJvXXlXt9r3cvgIw/ekL0lwxWNLP5Yyoqye+60a79JuYSi4OpmV7STQmfxRTd7Rp9wNUI
 xNjDQDIrPOWClZDERxz29xrwM4ghGvScQh3URBAVzr8Zcl5ygmgB0il
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Mailman-Approved-At: Wed, 11 Jun 2025 14:37:25 +0200
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

One needs to set CROSS_COMPILE also for the actual compilation, not just
for the kconfig step, otherwise the host arch compiler would be used.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 doc/board/qualcomm/board.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/board/qualcomm/board.rst b/doc/board/qualcomm/board.rst
index 003d59a18ebd3f19db568fa59e9fd06906e209f2..64427ba5be793978f54dd51c2b24e55fcd78ea8f 100644
--- a/doc/board/qualcomm/board.rst
+++ b/doc/board/qualcomm/board.rst
@@ -88,12 +88,12 @@ As above::
 Or for db410c (and other boards not supported by the generic target)::
 
 	make CROSS_COMPILE=aarch64-linux-gnu- O=.output dragonboard410c_defconfig
-	make O=.output -j$(nproc)
+	make CROSS_COMPILE=aarch64-linux-gnu- O=.output -j$(nproc)
 
 Or for smartphones::
 
 	make CROSS_COMPILE=aarch64-linux-gnu- O=.output qcom_defconfig qcom-phone.config
-	make O=.output -j$(nproc)
+	make CROSS_COMPILE=aarch64-linux-gnu- O=.output -j$(nproc)
 
 - gzip u-boot::
 

-- 
2.49.0

