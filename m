Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F75C47422
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 07:55:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D9E587AE6;
	Wed, 17 Jan 2024 08:53:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="iDO4VTIP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14C4987AD4; Wed, 17 Jan 2024 08:53:27 +0100 (CET)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 547D487ADC
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 08:53:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6daa89a6452so6536824b3a.2
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 23:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1705477998; x=1706082798;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xnaJIRSC+ZETjxciKXBrnhtzl+6oNe9qGJlY4fC4tLI=;
 b=iDO4VTIPvQKBoC7CYIPQmmYZxr1rNPVG3PGvQihojx90c7HmnN2e3Q51T7bwpMSjAo
 h5/hMQxALsteS6ELFl6B7/c2NGPKTOwghq0bEhJChvRMfPn9vKUpiqQi/DtmT45LI0E3
 3W3Dv3Vjg+/rrDXi4X3gqPOux6Y1tgkGTOHrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705477998; x=1706082798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xnaJIRSC+ZETjxciKXBrnhtzl+6oNe9qGJlY4fC4tLI=;
 b=Mma+HzMNcI7QA0qdzoJpR2JKCsaS160y3zpMgPhD4QgIVbJRo1m3VhRBzsqqAEmSPB
 XiYB/DCilhnJ54XMyXWqih2vFTEWOr5/8nCs/D6cOkQ8rQPXrn70sYgi0SqLLm7qV7pr
 CMOVCFcetS0xMxWG2tmiKia4eV/WhKbFqeB9I4KI5cR/xkvMWyCY2KtFkgbR4mOcouU1
 hROaD5wubB+NxAUNeJtrfyTMErrZ+CXuEBdqeKBwUuY0V+hrBXiqoKLL+XOmuSQsxmRr
 WrZUwy7POZS7NuOJAYmip60gbj/UcPXSvgimqR4dYwM/Kt/hHb9IcV4E+/GbP8CQSd1S
 CVVg==
X-Gm-Message-State: AOJu0YzblzT7dsuJNFZ8xS5wZ3Ci2iyeQGBd7jgcgpOxyYlf6uO2MnGZ
 ZmQxiDvUQ19Wj90bc9ury4czqQKWOKJwbQ==
X-Google-Smtp-Source: AGHT+IHCx8YtoPmCZ8ZKA/7HbV3uJ79rO5AJQ0vqKVbfAlZhDYLPMI66suPSSVoLCy+SwxKFgsqh7g==
X-Received: by 2002:a05:6a20:c887:b0:19b:21b9:bdd8 with SMTP id
 hb7-20020a056a20c88700b0019b21b9bdd8mr2477012pzb.51.1705477998791; 
 Tue, 16 Jan 2024 23:53:18 -0800 (PST)
Received: from localhost.localdomain ([183.82.41.50])
 by smtp.gmail.com with ESMTPSA id
 e10-20020a170902784a00b001d5081be740sm10718624pln.62.2024.01.16.23.53.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 23:53:18 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Anatolij Gustschin <agust@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Heiko Stuebner <heiko@sntech.de>, Andy Yan <andyshrk@163.com>,
 Robin Murphy <robin.murphy@arm.com>
Cc: Da Xue <da.xue@libretech.co>, u-boot@lists.denx.de,
 Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v3 16/17] configs: evb-rk3328: Enable vidconsole for rk3328
Date: Wed, 17 Jan 2024 13:21:53 +0530
Message-Id: <20240117075154.58747-17-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240117075154.58747-1-jagan@amarulasolutions.com>
References: <20240117075154.58747-1-jagan@amarulasolutions.com>
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

Enable video console for Rockchip RK3328.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3, v2:
- none

 include/configs/evb_rk3328.h    | 5 +++++
 include/configs/rk3328_common.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/include/configs/evb_rk3328.h b/include/configs/evb_rk3328.h
index d10e5b1d2e..c985080f7b 100644
--- a/include/configs/evb_rk3328.h
+++ b/include/configs/evb_rk3328.h
@@ -6,6 +6,11 @@
 #ifndef __EVB_RK3328_H
 #define __EVB_RK3328_H
 
+#define ROCKCHIP_DEVICE_SETTINGS \
+		"stdin=serial,usbkbd\0" \
+		"stdout=serial,vidconsole\0" \
+		"stderr=serial,vidconsole\0"
+
 #include <configs/rk3328_common.h>
 
 #endif
diff --git a/include/configs/rk3328_common.h b/include/configs/rk3328_common.h
index e920ec7e5d..2c40674b22 100644
--- a/include/configs/rk3328_common.h
+++ b/include/configs/rk3328_common.h
@@ -26,6 +26,7 @@
 	ENV_MEM_LAYOUT_SETTINGS \
 	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0" \
 	"partitions=" PARTS_DEFAULT \
+	ROCKCHIP_DEVICE_SETTINGS \
 	"boot_targets=" BOOT_TARGETS "\0"
 
 #endif
-- 
2.25.1

