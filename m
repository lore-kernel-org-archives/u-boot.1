Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B256C54747
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 01:49:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 316E988C30;
	Wed, 28 Aug 2024 03:46:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Z42uiQnU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B74F88C1D; Wed, 28 Aug 2024 03:46:06 +0200 (CEST)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A16188BC0
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 03:46:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-829f5e9d8e9so48861539f.3
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 18:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724809563; x=1725414363; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ee8Hg90R3rAamhddmBgUP9+hBAv5kaW1ENhd1jfn7dc=;
 b=Z42uiQnUWeXuIgZ+7glDcsALi+nEbEyFI7UWeXlySJQoCPwrCWSRW6VDKvD3cRvXGc
 33zmuiB847bZW8+6Pqe+ZaXJQuc4+klAShJgoSgY5fHMKeQXgyU8sIeinFpCbNXgU2sv
 FU9bLg7hYEuSoOHgSimM/6dUGsIfX39CmA/e0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724809563; x=1725414363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ee8Hg90R3rAamhddmBgUP9+hBAv5kaW1ENhd1jfn7dc=;
 b=KMFgKzdy9LfW/rRgAHYtqa/uPfYFcr8QFGtGv6U25BceOmsJTJdQx2db2te2q5O8EY
 MFTJQLza3ljcgi9//zREpTbTp05XStBCZ+s6rYFMhFfEIUPN7CngucrUoZuUfwXdOxZA
 aZ3SdJgAPHslkVX1GOE4PsUXxXCXo3IT1tY7GFZBOhZmsvWUoIEE5Jn9rkkdLwXtbfpI
 Eg7W+t9ScVXo0BSlUQ2pisAYjJrSjRSM2nAUHzFyX2SkkBGQWS7aFH/COhdZZz7EmgqK
 2ZiSJrPXGy5XanQHf5nlWRJyGOP54N5+sEixSOFiGVUavISr8sQM4wTwKRDKHOuWg59p
 DSGg==
X-Gm-Message-State: AOJu0YyePWRoCD4SEmWDwarStOgd54HPsM27nUG/45CqSjmkkH5yZbgK
 BheVnTXucbDja16d6VKWyWVsiXlBUO4V19WreqdRhOINiVz+vHS1uwjYz4HOPHgJskCto/Fr+gA
 =
X-Google-Smtp-Source: AGHT+IE3eSyWfp9Nd7zTQJu8kFSZ6P7QY/gnygOD9N7lJlSJ0VZzZXakCkIuhqOUveqM2iirxl0bxg==
X-Received: by 2002:a05:6602:2b04:b0:81f:803d:cbe7 with SMTP id
 ca18e2360f4ac-827881ae8bemr2038735839f.12.1724809562950; 
 Tue, 27 Aug 2024 18:46:02 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ce70f5ca7csm2898342173.63.2024.08.27.18.46.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 18:46:02 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jeffy Chen <jeffy.chen@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 Wan Yee Lau <wan.yee.lau@intel.com>, huang lin <hl@rock-chips.com>
Subject: [PATCH 18/18] rockchip: Provided SPL control over efuse presence
Date: Tue, 27 Aug 2024 19:45:37 -0600
Message-Id: <20240828014538.3322013-19-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828014538.3322013-1-sjg@chromium.org>
References: <20240828014538.3322013-1-sjg@chromium.org>
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

This driver should not generally be present in SPL, even if misc devices
are enabled. Update the Makefile rule accordingly.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/misc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index e53d52c47b3..ff984d7b191 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -68,7 +68,7 @@ obj-$(CONFIG_QFW_MMIO) += qfw_mmio.o
 obj-$(CONFIG_QFW_SMBIOS) += qfw_smbios.o
 obj-$(CONFIG_SANDBOX) += qfw_sandbox.o
 endif
-obj-$(CONFIG_ROCKCHIP_EFUSE) += rockchip-efuse.o
+obj-$(CONFIG_$(SPL_TPL_)ROCKCHIP_EFUSE) += rockchip-efuse.o
 obj-$(CONFIG_ROCKCHIP_OTP) += rockchip-otp.o
 obj-$(CONFIG_$(SPL_TPL_)ROCKCHIP_IODOMAIN) += rockchip-io-domain.o
 obj-$(CONFIG_SANDBOX) += syscon_sandbox.o misc_sandbox.o
-- 
2.34.1

