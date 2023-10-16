Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C457CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 06:47:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D30786E2F;
	Mon, 16 Oct 2023 08:47:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="njHdpbnb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3B7486BCE; Mon, 16 Oct 2023 08:47:20 +0200 (CEST)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F9F486C3F
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 08:47:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1c9e95aa02dso24115975ad.0
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 23:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697438821; x=1698043621; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1yClAL1OyfbKc6TszWmib6hvyd044g2R3J1uiGAvAPE=;
 b=njHdpbnbY+LTFADNYMHstJBpLXGayXKh8mEGx4CNOism+mpYWqVkjW+4MP7xnaStQV
 SpM3roSbcBUn/GJxzBjEG7yeNpDmjb6b/RkIPgIAzxiNtNs6aP7XhH6p8fFMh06QMT/a
 SiiznhAklFVVxSxuA14c2dkGHtvIhXIdi6VPbyMsn7tiH+4g697ieqdSckLtPEnHehnW
 aHyP/PzQZyo+z2f7bioFUyq6fsM0vdU9vjYwifYusIrXCdd1bnNVubE/a5fwuqUFtWAI
 WZtFKanTtL/XNujilxz6RJM9eSw+aL6JU1ftHnW6MT87lx9cZo2C2zJKWqFPxeOmnw9X
 LSTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697438821; x=1698043621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1yClAL1OyfbKc6TszWmib6hvyd044g2R3J1uiGAvAPE=;
 b=XDpDSxuRNnhMflFqzlcImzSRh01ViKR+8dwcS179DNSTROwQgu6ghLri1XXRh6tMrW
 N2sHnd69L+QUOcvKHtVWzTiPKThHp9VDLB5eH7YwUPf2g7JRuVIuZJW7kLU8R3ZuksmV
 pbz9aSTvkafWPQd7m9XZN30Jezpo8asf1DrOYRGCXe/QY4lN2rF9jyp8bYVRPED3X7IB
 HZeji9ZSeIxl3jM6/M3tyNS/Frl8oQvC0GRUEhKQ+Uvvo90uxEIPoFtsz4oss6oU74yf
 Y+7fV0LLbFB+o67aZxJaTRWtSGkK3lh/edgYOy2UCOvqcd/iReyRIDhia0wsI60Yl+8V
 M4ow==
X-Gm-Message-State: AOJu0YwOaHukmn07wTyzpCTLDuw3vj06xlh36Mmt4DVFr5F99RSRTOJm
 1VFsBj8VPxGtmOIYUenqZu70xFbuSh04zDQTadY=
X-Google-Smtp-Source: AGHT+IHb8Q8gXebKbmSxDxtM/nT+9ZDKFKMsHw7L2x7e5UJwVaE3XUx4TG3tojsfEd+Et8V160HvPQ==
X-Received: by 2002:a17:902:f54b:b0:1c6:e1d:8be0 with SMTP id
 h11-20020a170902f54b00b001c60e1d8be0mr10683006plf.2.1697438821439; 
 Sun, 15 Oct 2023 23:47:01 -0700 (PDT)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 i18-20020a170902eb5200b001bdeedd8579sm7687534pli.252.2023.10.15.23.47.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Oct 2023 23:47:00 -0700 (PDT)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v7 6/9] efi_loader: add CDROM short-form device path
Date: Mon, 16 Oct 2023 15:45:23 +0900
Message-Id: <20231016064526.2410856-7-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016064526.2410856-1-masahisa.kojima@linaro.org>
References: <20231016064526.2410856-1-masahisa.kojima@linaro.org>
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

UEFI specification does not mandate to support the short-form
of the CDROM media device path.
Fedora installation ISO image is identified as CDROM media
device path, supporting short-form CDROM media device path is
required to automatically add the boot option having default
file of Fedora installation image.

Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
---
 lib/efi_loader/efi_device_path.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
index ed7214f3a3..ac673ab117 100644
--- a/lib/efi_loader/efi_device_path.c
+++ b/lib/efi_loader/efi_device_path.c
@@ -110,7 +110,8 @@ struct efi_device_path *efi_dp_shorten(struct efi_device_path *dp)
 	while (dp) {
 		if (EFI_DP_TYPE(dp, MESSAGING_DEVICE, MSG_USB_WWI) ||
 		    EFI_DP_TYPE(dp, MEDIA_DEVICE, HARD_DRIVE_PATH) ||
-		    EFI_DP_TYPE(dp, MEDIA_DEVICE, FILE_PATH))
+		    EFI_DP_TYPE(dp, MEDIA_DEVICE, FILE_PATH) ||
+		    EFI_DP_TYPE(dp, MEDIA_DEVICE, CDROM_PATH))
 			return dp;
 
 		dp = efi_dp_next(dp);
-- 
2.34.1

