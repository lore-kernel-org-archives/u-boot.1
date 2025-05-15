Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30D4CC2D0CD
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 15:58:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B8A682C79;
	Thu, 15 May 2025 17:58:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="BHtJE9ro";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56E5182C75; Thu, 15 May 2025 17:58:16 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7ADD782BC1
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 17:58:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ad23ec87134so224169966b.2
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 08:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1747324694; x=1747929494;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VcNSUsootR03eJMNGEAuDjuxaG1fXB5zONncT/XCNNU=;
 b=BHtJE9roW+sMCWOdi9IFGtE2q2Xd/0trg6g5SO3f6Wi8+cLI8JO3Z9TY/APW3hCnqB
 hsA9herV0dNPM6VHhz8yJ1gpkEh9Z9RNnmSzJFh98Nbczj5cQF1NQcqX6Jc64OPVqy+n
 T2VidtQECQ9UKsN/5XzXi+3rT4NhMKEXizyZCQLZ9TGZdL1vhc8NCSRvIlJ4zzct/I5b
 Mfza5LpMcF/VvmvKPavSHPBNItnLDdl66T4LajWJ8h+rbryTE0iYYTFFYsT4zCx67bJc
 zcrMLTm1ERKSBR2EKM8p514KNk/lw7NNMnBC0GU81fPZrFCffqQm/tt24n6MwhbzacnB
 zi0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747324694; x=1747929494;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VcNSUsootR03eJMNGEAuDjuxaG1fXB5zONncT/XCNNU=;
 b=ZreHKHduFf9iBCGqJk0byKpr0jXXmoDm057QxNTgjC0dGLkXo4QFXbLpAXgktjI9O5
 ZH3Isamxe9CUEmPitMXCkLQi3bQdYlVHhOpkSZTsGI9HSPdA4QhGaRWSUAm8widTZSDj
 vRgt5I4ASe39XOFshxrriJNpUGxbVsk58u2MPDrJWprRxpEahO8TMFMpjTHOFzwGznne
 NwC662dFGegHwURq/p8xvCUMyyKeTcQli47rvD5mfUvlcS/nEfeJLxm6t1W1j5cdCJDk
 OpsJBMTt2qFK2g85C1VWb09hWtugb0WNfkPNf+mVLI8RPcOWPklNWI8q1kEHrFB1OtCf
 so9Q==
X-Gm-Message-State: AOJu0YxEC7VsHpCg4yu5o6KDVgWMmoqa3JsLamyd7yp+yjTjEZzt6Np+
 ynz6NNWtTbC5B7sCjbpm5C+QO7zykkTXPYxvwV4F3nyDWSEMUgfq+uGgwnsWibU3+T8=
X-Gm-Gg: ASbGncv1zjvjTVRqc/WuKYlIYVw8h5u9SHSLmVKocJxtS0llkqoqcmTpFZD/xpW/CVZ
 dTA8rN6974yGmuLwbup6WZ4qAnpWn0Om1hDkm1KCuHmx0XaiXs9yqU3IvbLDy71W5KQWmFsscOn
 D+GaXoGgVbAD2SkY1FYL3Z8Bxtnf+EOr1Y2ebU8dsv+Dx5HzYNLxteNIehd590xcUmoSzI2bybF
 F4nyVcfKo4t37tSetUuY5bHVpKoDeZ7hTb4XIVNKiqWcPwR5VAv0dBu0tomvbnt/T5k2dx+W9/b
 YmEI3E8S3OUHvvwHLRMfeu9It3mQcOig6u1y9j3eA3LU8p9OdatfiQBXxebWeqVO
X-Google-Smtp-Source: AGHT+IESDMAXlvKgfWiJbZppRL19JTrJHNIqJsxAwaflbVslrEANT5VTlHi/BFU8zJ6sTt3bb+kjNQ==
X-Received: by 2002:a17:907:9281:b0:ad4:d9c9:c758 with SMTP id
 a640c23a62f3a-ad52d42a5a9mr24237566b.11.1747324693944; 
 Thu, 15 May 2025 08:58:13 -0700 (PDT)
Received: from [127.0.1.1] ([185.72.186.3]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d271916sm8698266b.69.2025.05.15.08.58.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 08:58:13 -0700 (PDT)
From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Date: Thu, 15 May 2025 17:55:46 +0200
Subject: [PATCH v4 3/5] ram: rockchip: Fix dependency of RAM_ROCKCHIP_DEBUG
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250515-silent_console-v4-3-dec6c8391f01@thaumatec.com>
References: <20250515-silent_console-v4-0-dec6c8391f01@thaumatec.com>
In-Reply-To: <20250515-silent_console-v4-0-dec6c8391f01@thaumatec.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
X-Mailer: b4 0.13.0
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

The RAM_ROCKCHIP_DEBUG can be used only if DEBUG_UART is
available, otherwise it won't have any effect.

Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
 drivers/ram/rockchip/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ram/rockchip/Kconfig b/drivers/ram/rockchip/Kconfig
index 67c63ecba047..d707d09c1c8b 100644
--- a/drivers/ram/rockchip/Kconfig
+++ b/drivers/ram/rockchip/Kconfig
@@ -15,6 +15,7 @@ if RAM_ROCKCHIP
 
 config RAM_ROCKCHIP_DEBUG
 	bool "Rockchip ram drivers debugging"
+	depends on DEBUG_UART
 	default y
 	help
 	  This enables debugging ram driver API's for the platforms

-- 
2.43.0

