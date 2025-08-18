Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD339CA0EC6
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 10:44:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0177E803DF;
	Mon, 18 Aug 2025 12:44:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qGTSh4Ol";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF674829E7; Mon, 18 Aug 2025 12:44:31 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A66DD80107
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 12:44:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-45a1b05a59fso29853425e9.1
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 03:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755513869; x=1756118669; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zAuPZU9OpLisPwIDVULvSUnDayPGiCwn3doPWYHd/bo=;
 b=qGTSh4Ol6kj+oepmUvM4lzyavAV720svuaTp8idN7aHNeFtVLHscbjlmcSiJQtjbth
 K02UQY/ExdmiY0Nmm1SrPZf6VUkP5u88zSZQGsI3yH6bwPAOdP5y0QAvp9zQi5bhvTDj
 6Om0rNlGRU6tpEFNqCpcOIJ55V7X32YLv1TnMJBWMPlRgPwxzZKb0qvEa8dcP/PaF4gK
 8fIUxqzq/N6q1k4NW4hMZPwfdB/6IyCzXMgjOE0gSy5JSEU7PJ4mgpbaKLcDL1NmjtMO
 Esa1qDEODziAwzpZZiWWO0k+G3LutlTCRqOy/7+c2ynpCOE8puQUOvf1xJ20EpdNUJdB
 PDAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755513869; x=1756118669;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zAuPZU9OpLisPwIDVULvSUnDayPGiCwn3doPWYHd/bo=;
 b=LukduUXw3kJINgpFdPE3Kep9GYVirroUe5wQvihxgLnA+79tMvNuD1W+r9BcFpm/Bm
 sWbrOrX5a/t64fzzp/2+ZAvxHCJAnxi/2c7BkeYvlgZy2sIlbt0v/8YBxF+zY3vo8oIi
 tvPY88imHpA8jB/6uVIxRe51E673rsw98vxvRcs0cmakQVb3LH3Zef+pJUt/NgMXPnPk
 N9hV/jZwrNUlPrHMCad7uJTAJId2pa8vRt5LydPG7hBProR3aKbMMgqK0zPN+rVdr3Hs
 D6gPL7VcVItB1U8lKlpmDQyXwiKMM5McVGsVAIzvgOnFL8GJWRnfUumTW9p3NG9qkWt5
 kyRw==
X-Gm-Message-State: AOJu0YzsqA4bvTZnCi59oCnL3sT5gEPKCeIPzdixQ6/SGm83108/GkpD
 duEyAoP1fNmi8f6yVRcp83D/sKJ08QD3HSVHua22m0t9A7IEDRhO/i+XvKcEIxF1p/zDzMbmQnC
 T/7WO
X-Gm-Gg: ASbGncue3DTsqXW49/KN4z7qEPymuWs/ZHP7GZhH9pp1GxRQrr7Ma/UZVmeS2ibZ05Z
 IIwVA4jPNRY6j++dyvP09HF2PETeIcJpOWNhr8fOorWJUP7H5OBGlqOg3z4GMGaV0JcGssMpG1W
 kKQWcUbY/E9JEiwnl+0lwzM2S9RTUBTfVcDihmPVHsyM4iE+4E7mtNMWOLWgtrgomXZjadtBt3e
 aB44TcSTY5LDcoGqhFYb7Dw7gfOsK/TYKB/J9gabHUHbiYzoQ5gIyLXBU1tJWXbYfHGe2A7/dQq
 Y47MW94jC9RbmqKsZvhMSBz/mYRODpbTayvYzeT0IDLPqNtiZVug1eYGjxhLjUQEMI1Hp7aXqgS
 ouQwzrwKVoW7aD0aPbDTsf6fc8qMqI8x6FmXKnaL5SGytBT8OSb4=
X-Google-Smtp-Source: AGHT+IEK3K6Ch7reqeOoCBCYNF492oSoo236gHnRliR1xx60+btCSsUVBqMeZY+0nAeD57557y4E1w==
X-Received: by 2002:a05:600c:198e:b0:456:214f:f78d with SMTP id
 5b1f17b1804b1-45a2677ef3dmr60566815e9.22.1755513868981; 
 Mon, 18 Aug 2025 03:44:28 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:69b5:38a0:910b:c9c8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3bb652f75aesm12293643f8f.23.2025.08.18.03.44.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 03:44:28 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH v2 0/2] phy: cadence: Fix two Smatch reported issues
Date: Mon, 18 Aug 2025 11:44:27 +0100
Message-Id: <20250806-phy-cadence-sierra-v2-0-f2d309b170e2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAsEo2gC/32NQQqDMBBFryJZd8oYW5Gueo/iYhJHM9BGmYhUx
 Ls3eoAu3/883mYSq3Ayj2IzyoskGWMGeymMDxQHBukyG4v2jg3WMIUVPHUcPUMSViXwlcWmxpt
 zPZosOkoMTin6cKgfSjPrcUzKvXzP2qvNHCTNo65nfCmP9W9nKQHB9thU6InIu+dbIul4HXUw7
 b7vP/qxt3LOAAAA
To: Tom Rini <trini@konsulko.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

Smatch reported issues with an unitialised variable and an error exit
that did not set an error code for return.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
Changes in v2:
- Rework 1/2 to remove use of clk_names[]
- Link to v1: https://lore.kernel.org/r/20250806-phy-cadence-sierra-v1-0-2f0830caaacb@linaro.org

---
Andrew Goodbody (2):
      phy: cadence: sierra: Remove variable that is not assigned to
      phy: cadence: torrent: Set an error code for return

 drivers/phy/cadence/phy-cadence-sierra.c  | 13 +++----------
 drivers/phy/cadence/phy-cadence-torrent.c |  1 +
 2 files changed, 4 insertions(+), 10 deletions(-)
---
base-commit: 007610da2cca405ea7739fc120d90085be4b6ac2
change-id: 20250806-phy-cadence-sierra-c3208604bbf0

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

