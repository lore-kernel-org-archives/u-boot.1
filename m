Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEA1DC28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 18:01:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C84A4800B6;
	Wed, 12 Mar 2025 18:59:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BshOId6T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9473819C3; Wed, 12 Mar 2025 18:59:33 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 070A48056A
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 18:59:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-ab7430e27b2so20545666b.3
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 10:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741802370; x=1742407170; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NU1OCCgxgCfllYdZ1CE7KS/i9tfwC2tCf5rJBvgNxVw=;
 b=BshOId6TEVvmQ6PxVX2qoWZYw6Iierbbl+oCzbFmZLh3NGVCLWgpOc8jxaaVm0u+fq
 MrZnTLIG6M0g/A/sieRSIrGqcqfA3SaPsfI83SDu9SmmKS3Rl6zOazBH9pTIOrOLUuf1
 K7lc/E5IWT2NaHQFFZRYBf+emGwqS9zK5TOwkVZpDo4+hIQlwlvJoOcuMdJOpVZ0B0z7
 8ud7bhlABclG0vwTO/FH1F1R5JmvVyQNaKOXdi0oyoPMgQ07OFJ8GPH7kGhoafy+Numz
 b61QkeF6qpWwoYRAarRRGigbIiqJ9zo/SSb3fevgSSdaxg6UaBsCHBZPd2JDzykiUbY/
 +ZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741802370; x=1742407170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NU1OCCgxgCfllYdZ1CE7KS/i9tfwC2tCf5rJBvgNxVw=;
 b=bmaw5nCYf9zhJ6XSCkjo1XZo1urJ+pXF6zzIJQqLW9AWGQOCKqn+YivhP6husDJzv8
 68pqD//vEFzHVaauUkhKV7A4x7tg2wZTzfcJatFp0bd37mM2sLfuxMRIb7U59qmf7rWW
 z0ETMXUwVHr9U3zNBFemTiAAGj6AfDth5Dx883VoLgwZRCEtW95/QqU+NrYPVJDecOQf
 1gyphnh+50YCQy2F8OdiPW6SGF9yxSGghpZcnswdoiuYw3HWHCr5WsxIn2geQRl+x/iu
 Q+vjvZoh/xKC8gSWJxZaBC9/4mF1vLpZPA2C9B32gtKc/JvmjgC8Ca9SBg+0GGy1LMLo
 YgwA==
X-Gm-Message-State: AOJu0YwVKXV7sy/M3BRPT/5jw5SKkR1IxeRmy7tPMKwdPm//92/YnLSr
 GXqudhflcy53MY09rvDJKcwhHOe/9yH8HuT2FnYiLPpLtDW0IHTBgI7JnA==
X-Gm-Gg: ASbGncvydVcSy8DalsCP1xACske+H8XqFASbhLv+UQ34uVTdrRSkdq6n8L4o/50BFPp
 Vebq3tsSRRhgBS4/dQpD6y40xdwpftxUPxVzygATdOhFNBHeX8GcAujvfa7ZoY2fHnwoPgYcb+o
 cO6YVeh29xs4175uo+45/4nRZpdzJwGog145Fhb1WECP+4/VieRn6C1GtnaIsuuxDGySBw3WasK
 OVTVtYx/38sb5PwGe2aVYOXy/EKDakQD09xVQ4SOgxhz2w/gU+5XqHIvPfZJMvqdOdtPTceQ549
 oKZ0wPzQs6IcBt9TWvIOPpRfhr2cD+phLP1U8hHSQpzu+1E=
X-Google-Smtp-Source: AGHT+IFaCIHxBJHK8fTF1qpMwWKnhuT8DEBrFCFfSAgCwt9mus5QVf3bpssWF4natRdK0bRfZYtJfQ==
X-Received: by 2002:a17:906:90d:b0:ac2:690a:12fb with SMTP id
 a640c23a62f3a-ac2690a1410mr2011285866b.17.1741802370347; 
 Wed, 12 Mar 2025 10:59:30 -0700 (PDT)
Received: from xeon.. ([188.163.112.73]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac2394825adsm1125291166b.56.2025.03.12.10.59.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 10:59:30 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 10/10] video: tegra20: dsi: respect speed mode used for DSI
 commands transfer
Date: Wed, 12 Mar 2025 19:58:57 +0200
Message-ID: <20250312175857.120313-11-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312175857.120313-1-clamor95@gmail.com>
References: <20250312175857.120313-1-clamor95@gmail.com>
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

Use DSI message flag to set correct speed mode for message transfer.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/tegra20/tegra-dsi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/tegra20/tegra-dsi.c b/drivers/video/tegra20/tegra-dsi.c
index 3ce0d33e380..a2a22fa0fe2 100644
--- a/drivers/video/tegra20/tegra-dsi.c
+++ b/drivers/video/tegra20/tegra-dsi.c
@@ -251,6 +251,9 @@ static ssize_t tegra_dsi_host_transfer(struct mipi_dsi_host *host,
 	value = DSI_HOST_CONTROL_CRC_RESET | DSI_HOST_CONTROL_TX_TRIG_HOST |
 		DSI_HOST_CONTROL_CS | DSI_HOST_CONTROL_ECC;
 
+	if ((msg->flags & MIPI_DSI_MSG_USE_LPM) == 0)
+		value |= DSI_HOST_CONTROL_HS;
+
 	/*
 	 * The host FIFO has a maximum of 64 words, so larger transmissions
 	 * need to use the video FIFO.
-- 
2.43.0

