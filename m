Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3580AC4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 13:07:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A7E28774C;
	Mon, 27 Nov 2023 14:01:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="u9of3zSR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0070C87762; Mon, 27 Nov 2023 14:01:16 +0100 (CET)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 189408772C
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 14:01:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5094727fa67so5974673e87.3
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 05:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701090074; x=1701694874; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T8fYk31XS3jH9NgQGQ9YE9gKLD7cDJzzODLb/f/UGdc=;
 b=u9of3zSRsAJuDjDrdOvct/gCEEIskxklxyN4iSIVimpKKYoTaTG/ag8g3xLVcEFSrk
 iDNqZpdRKGM3/IK5IMSwd8gdty6qDUiOFZGhJgyWnwGRZn2WShKzCexM4u31zKPozAV6
 F9JU2pkO+2bfNfiHOSWDKJi+MoMUNKXdS5pQdMMPQmTFVXT3SysQsD2tVat62lrPejoG
 YRnFquhGtqAkRY6D5zWm0sWRIQdtcAXq7Tb1n506e7pucB5KC92WR2D1l9BwQMVgbfDX
 1C31vXikvSeMaDU7UC6/jkpl1G4PLVUE/4SqAY0sbpBVo+yY/ZtlObOu4WEngLVCJgrh
 woOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701090074; x=1701694874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T8fYk31XS3jH9NgQGQ9YE9gKLD7cDJzzODLb/f/UGdc=;
 b=pmpXcXRZOb/kFipKi53Ibz/rac2QdQr5phPKZZvT/tG/4zUgaLaQWPzUyGq3j7KE/t
 l8m+MWwaoPCNTDPr/e4ug1sjwEbZPaaHDcUtX0+ZdtjnrHogRV+U8kNBIhoRICxyFimy
 Np7kiv1XTUNyiHR/owsjm+E+IC/qngaNqp3ydh1oQmHYcRmZ9jK9MfnNo3W3hskAF58T
 2qTCowmD88xpMvNLM9FDG6kMc477lYRCgimp48+iNPZshhj348OzxhWlhgNaqYRudnnu
 A8DnR5wplsvNdrbcVCf0n9BqFd8dXs/+YjxmR9BichpfikFyXaKjb4g/k6ujKL2xITjD
 w5ew==
X-Gm-Message-State: AOJu0YzvwhT9yhhppk9jb5WElB57kjcWApvyT6XKANJvEsN/SLW3zNtA
 EPJxLm8Fz9bt+36S9pb6YVpm1vMd6mE4oFFAxfR1Tg==
X-Google-Smtp-Source: AGHT+IEeFrR4MQLdCkIXva0NBXSAzZIqQJWT/E1vtj+i5mXPjeWgC0loDcwHgXtiF9MwCKwj/GOVVQ==
X-Received: by 2002:ac2:4c4b:0:b0:503:38f2:6e1 with SMTP id
 o11-20020ac24c4b000000b0050338f206e1mr10406090lfk.5.1701090074233; 
 Mon, 27 Nov 2023 05:01:14 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 f16-20020a19ae10000000b005092b887ba2sm1482489lfc.201.2023.11.27.05.01.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 05:01:14 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, trini@konsulko.com,
 goldsimon@gmx.de, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATHv11 28/43] configs/turris_omnia_defconfig: enable LTO
Date: Mon, 27 Nov 2023 18:57:11 +0600
Message-Id: <20231127125726.3735-29-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231127125726.3735-1-maxim.uvarov@linaro.org>
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
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

Decrease allowed binary size to fit lwip code.
u-boot-with-spl.kwb exceeds file size limit:
  limit:  0xf6000 bytes
  actual: 0xf8600 bytes
  excess: 0x2600 bytes

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 configs/turris_omnia_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/turris_omnia_defconfig b/configs/turris_omnia_defconfig
index afcd4a1eb7..4e965c795a 100644
--- a/configs/turris_omnia_defconfig
+++ b/configs/turris_omnia_defconfig
@@ -118,3 +118,4 @@ CONFIG_USB_EHCI_HCD=y
 CONFIG_WDT=y
 CONFIG_WDT_ORION=y
 CONFIG_EXT4_WRITE=y
+CONFIG_LTO=y
-- 
2.30.2

