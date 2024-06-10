Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E743C27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 01:13:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 207DC88496;
	Mon, 10 Jun 2024 03:12:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KUVLh6qW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 069D987D46; Mon, 10 Jun 2024 03:12:34 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8059D88415
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 03:12:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6f99555c922so588309a34.3
 for <u-boot@lists.denx.de>; Sun, 09 Jun 2024 18:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717981948; x=1718586748; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lVo1KnMaaxcTD3uxagIxh+Vl8qN05WrLHUaAeLL9aiE=;
 b=KUVLh6qWZFjrmsriNqRdG8z/QPFx3NvoR8+oiy3zRQPEYB7WfeaXnvposrR5yU/VBi
 jGgscJyOJMWFg4QceQruE9ykBBuVWDLP836adYsRp37WgQM9P8PVpAFy+yboATuNdKMJ
 o0akkBEl8T12ONsFjDz8WwjayfVRtjyPYPnP6ZA6S6/T/ZeBlZeEZ4JobTEMqPN2oHN8
 SyXBMsSVMOBmDfcBg73DHkA8VMzmjhaqTd0ebSd0fPeNyiyKJoZE7g14bhNliI0EKeLj
 PU6UHR/1bYb0Eq2m98kcQjMNbbUuwOoM35o1VfUMyQBitS5zIa7PAgx1ozFW99dFawGO
 alHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717981948; x=1718586748;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lVo1KnMaaxcTD3uxagIxh+Vl8qN05WrLHUaAeLL9aiE=;
 b=v0stNS4b5ETwloukyREVJ8Mf+jEZ5Ap4cuyYUc8BkZ02W0mUIihdLNrEFJkcsy/1Nr
 UuH7b0eOd79wCdB5IJy8gw6ClATCtAvzSL786Zd5mNVFxlXO6xMet2kFmbwjZH0xtzGt
 FDwRlOKVDZHQGX8nnEKmwuCkilzQcbqHCjrsJ56RaggO3ED0eFvdkh2b6HWAIgVueieU
 4ebGpr8I2reB3SGLxlX7XoW5S85YWqipH+E1HcqGL8vlg7cfPj2D2BbCQ0WLztkJ/+as
 e7CYo+5V6Uhi8QJQcK2ngdE8Omn6frLF9yHnGUv19yEvQkqLDgBD0T3fe7Vc/B+Q5NHT
 u1Lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLg+L+x6hTabWGJw/iZLp/zEzODxKi8zOSxyGGNW3o/X1cU2w7RebVkHl5HkN2oZptkUEAggKm86/LppsXn7feJCr6vg==
X-Gm-Message-State: AOJu0YwG2K8u9TwzeWIKoe1Dg/eI7JLW9AYX/16SlTlvU+VPUcpuchkA
 +RfM45lsvfar6Y7yMVNY4QhMWeW6qTpPXED+mQpAil9Cy2FfU/hZpcKoSE6dpfs=
X-Google-Smtp-Source: AGHT+IHTFaVBwK6e/OawE7AMK/WZBioroUr6H/TGKWrHUINm4cL5zW+jp+C2BTDcLMcddf0FRCVg4w==
X-Received: by 2002:a05:6830:120b:b0:6f9:945f:7a6d with SMTP id
 46e09a7af769-6f9945f7f90mr3536322a34.32.1717981948276; 
 Sun, 09 Jun 2024 18:12:28 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6f95c79ad74sm1106784a34.47.2024.06.09.18.12.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jun 2024 18:12:28 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Glass <sjg@chromium.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v2 02/40] mmc: dw_mmc: Remove unused version field from struct
 dwmci_host
Date: Sun,  9 Jun 2024 20:11:48 -0500
Message-Id: <20240610011226.4050-3-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240610011226.4050-1-semen.protsenko@linaro.org>
References: <20240610011226.4050-1-semen.protsenko@linaro.org>
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

Nobody seems to use it, so just remove it.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v2:
  - Added R-b tag from Quentin

 include/dwmmc.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/dwmmc.h b/include/dwmmc.h
index 136a95b8cdb6..39024fb38aaa 100644
--- a/include/dwmmc.h
+++ b/include/dwmmc.h
@@ -163,7 +163,6 @@ struct dwmci_host {
 	void *ioaddr;
 	unsigned int quirks;
 	unsigned int caps;
-	unsigned int version;
 	unsigned int clock;
 	unsigned int bus_hz;
 	unsigned int div;
-- 
2.39.2

