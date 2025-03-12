Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60BE4C28B2E
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 18:16:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3227C81DEC;
	Wed, 12 Mar 2025 19:15:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JfA6n6UW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58B6B800B6; Wed, 12 Mar 2025 19:15:42 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 609258141D
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 19:15:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ab7430e27b2so23083366b.3
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 11:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741803340; x=1742408140; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pMxJDRYfDGrz6mpTkDK6Qb8h0a3FmIit9teaHl/ItgQ=;
 b=JfA6n6UW5VkQlXGJQFowBaPeCAPkJmmPbPeaqvHkVKeZ8DBCR+qA99VAIzAkAnHzI9
 uuQ82i/P9MfkcDQpKTg2G7iIsymSdulesP20az+AADxiyeFqT0GSBWKMtNNqnrfJdo1W
 TS7RykjZnaTl1A3+Xi4T96hoEMS9+/nsvcdcQVnQRr3AJSfVBJE7cYH8uxVjRjypMlyI
 pl8qV2tDhpI8nTL6d5bMItxBj51onsDmDETykOJJnUmu3ckWSzi5qtSQYxH8Rji+7MJB
 QH3QYPeZgFvFEf/cowLcA+/pSHdtfCIsFV/bGspRVesxWWn/jyMxKEpRbPqw3Hl3Kwhv
 hqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741803340; x=1742408140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pMxJDRYfDGrz6mpTkDK6Qb8h0a3FmIit9teaHl/ItgQ=;
 b=tNwRhozKNf1VPr/Y20pPwgAOflbSohgq5uIHGEM+FEdb0CFJDCUcVZFBmVArnLu41l
 Ikd4BULU5ZzweQkH91tCAuIqFiBOM2LTkYFauqTRdyK+JHTaFwRUYi1cBhSAVAtzXVx1
 000FrRqnikrIQe7vffSos5gRm/T5Hcmswclm7KlC7ntZ+vi/uZB/Ldfv/8UPWFVQ76p7
 M0LNpHJ1i3in7EajwfX+zILIKZrZUAEM80jawxuUTMU1a7q8Cp1+7JvbkUXedmqgUVBU
 36GoiEmshfFCf8KtSCnamGky1eoZFto9JVTANTn4z9omEvOycfz5LBLfAKWXuX8DngL3
 ghug==
X-Gm-Message-State: AOJu0YyzJFsomnl9CZN3RGxX4WCOyq6bvWC9IeB14CD6DZl7bDVQIizB
 Bg7ce9JhDdWdGtV+7Moyo4lShkM8gbTNynmslGcFIAvPWuQ7oksR
X-Gm-Gg: ASbGncvuzJJJ+5pfDRzcpeK4l1kRieTpmJv57EBvHewiKJz2R0/aFTdKHaLjcJa/ogO
 UyrqTXkGDSnAIaxriLe2gDyw0YA7CK81qGMtV9/3DyjW7oBrob22RQkyaHNZO2kDjuFVVktuRy9
 guO6X5MIDtz9ahx3+84gCf2CbMUd485QedkCTVuYrFsLyNjihTc+Wz2iaHWsfe+3Qxjmk3IGw9a
 9g11CBiOL38/PY4m3r9/9QyJITuY/vhEgZ/KZengCbtgKVLkJRcueLQjzpxA9I4SCc8HMhd6QQd
 Etaifm/Wl+bgklL5feVuhh2qfPAdhJLFlNWT
X-Google-Smtp-Source: AGHT+IF3sXLdcwIbFk15divZ4Ft66INTfBr//3PrrvrN35mcd0+Hh3dz+r+/nnbcNZ9WNzVm/ivAqg==
X-Received: by 2002:a17:907:1586:b0:ac2:7cd1:3aa0 with SMTP id
 a640c23a62f3a-ac27cd1416dmr1748342466b.57.1741803339812; 
 Wed, 12 Mar 2025 11:15:39 -0700 (PDT)
Received: from xeon.. ([188.163.112.73]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac28c11561dsm641906666b.145.2025.03.12.11.15.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 11:15:39 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 06/11] video: renesas-r61307: fix reset gpio direction
Date: Wed, 12 Mar 2025 20:15:18 +0200
Message-ID: <20250312181523.121313-7-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312181523.121313-1-clamor95@gmail.com>
References: <20250312181523.121313-1-clamor95@gmail.com>
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

The reset GPIO signal operates with a low-active logic. The driver
needs to be adjusted to correctly handle this.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/renesas-r61307.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/renesas-r61307.c b/drivers/video/renesas-r61307.c
index 8552c3dd959..ef6fab1e953 100644
--- a/drivers/video/renesas-r61307.c
+++ b/drivers/video/renesas-r61307.c
@@ -254,17 +254,17 @@ static int renesas_r61307_hw_init(struct udevice *dev)
 		return ret;
 	}
 
-	ret = dm_gpio_set_value(&priv->reset_gpio, 0);
+	ret = dm_gpio_set_value(&priv->reset_gpio, 1);
 	if (ret) {
-		log_debug("%s: changing reset-gpio failed (%d)\n",
+		log_debug("%s: entering reset failed (%d)\n",
 			  __func__, ret);
 		return ret;
 	}
 	mdelay(5);
 
-	ret = dm_gpio_set_value(&priv->reset_gpio, 1);
+	ret = dm_gpio_set_value(&priv->reset_gpio, 0);
 	if (ret) {
-		log_debug("%s: changing reset-gpio failed (%d)\n",
+		log_debug("%s: exiting reset failed (%d)\n",
 			  __func__, ret);
 		return ret;
 	}
-- 
2.43.0

