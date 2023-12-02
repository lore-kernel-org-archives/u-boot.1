Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F35C4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 15:35:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3189087687;
	Sat,  2 Dec 2023 16:34:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BAdrVOjE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 564FA87616; Sat,  2 Dec 2023 16:34:33 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80DA387687
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 16:34:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1cfd78f8a12so13751825ad.2
 for <u-boot@lists.denx.de>; Sat, 02 Dec 2023 07:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701531268; x=1702136068; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OfTAuELbCIeziKocT5KGmV7sVN+asJ/FudJfxlEycy4=;
 b=BAdrVOjEXvxuKmSErizVhiytgVSYDGq5TFRgp1caurk00CQBmnh/Vuhsd5NwOtMu/M
 Qh02Kx9uCzSvyUQnHa72iHc+qbqge4k+nlj+IaMwozx2zrETvSAYtJ8HRRKK/IU74aj9
 ovTfdGMHQ8NIaiTl0ff2OniLas2CdWmuOFocc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701531268; x=1702136068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OfTAuELbCIeziKocT5KGmV7sVN+asJ/FudJfxlEycy4=;
 b=YrxApw8DD9yQIZikTMdzqA9rVTbZvZIOYfwHEOFBfueRnjqf57ZoG1sC/L8C3mYS9b
 6XEIdp5QhIyLffikQr3fjud+zdVDyE5XUFipqtngksd/V79Nw3BuqOajo+zV+AHrvJ6q
 BhhZp6MOl+Ob1DRaFKq0f0xvQPo1CbSbWUe/rs94gfiW6FOTvwxy1oMihfBta/6R9fFo
 KOsBARkUibH4N4deXFJJVt9J7m6dFBHW6MbJocFZpppPBXnBosb34/dx0ZAAblKDgyn4
 DOom1tX0dlboIKqXypLYXQMoApndG1greTBXXBPdM6ytIN+EpxggQqKeq8xQO1TSEEIT
 J23g==
X-Gm-Message-State: AOJu0YwhWVe/lasSo8/VpBIUm6J/QLIhk6jAIpaHdgJTBFDgfHZqvqle
 SExHV1XSUDN02LlsbicmyB99QhUt80wFha5ssPRzoQ==
X-Google-Smtp-Source: AGHT+IEUyKglnGwmye8e/zuaffQ6IWYMufWUuYktpgtxQFQt2slL6g2G3PhfpsL4+ncxL1l215zKMQ==
X-Received: by 2002:a17:902:bc4a:b0:1cc:5cbf:50d2 with SMTP id
 t10-20020a170902bc4a00b001cc5cbf50d2mr1269951plz.59.1701531267862; 
 Sat, 02 Dec 2023 07:34:27 -0800 (PST)
Received: from sjg1.roam.corp.google.com ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 b5-20020a170902d30500b001cf8546335fsm2869217plc.5.2023.12.02.07.34.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Dec 2023 07:34:27 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nikhil M Jain <n-jain1@ti.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH v2 4/5] sandbox: Increase cyclic CPU-time limit
Date: Sat,  2 Dec 2023 08:33:51 -0700
Message-ID: <20231202153400.537050-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231202153400.537050-1-sjg@chromium.org>
References: <20231202153400.537050-1-sjg@chromium.org>
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

Now that sandbox is using cyclic for video, it trips the 1us time
limit. Updating the sandbox display often takes 20ms or more.

Increase the limit to 100ms to avoid a warning.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/common/Kconfig b/common/Kconfig
index 5906a4af7c33..f3f6f495adfb 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -636,6 +636,7 @@ config SPL_CYCLIC
 
 config CYCLIC_MAX_CPU_TIME_US
 	int "Sets the max allowed time for a cyclic function in us"
+	default 100000 if SANDBOX  # sandbox video is quite slow
 	default 1000
 	help
 	  The max allowed time for a cyclic function in us. If a functions
-- 
2.43.0.rc2.451.g8631bc7472-goog

