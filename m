Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F203EC4167B
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 09:04:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC9F787661;
	Mon, 11 Dec 2023 10:01:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="dmsvo2TW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5408A8764C; Mon, 11 Dec 2023 10:01:52 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAA8787727
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 10:01:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1d098b87eeeso37023555ad.0
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 01:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702285308; x=1702890108;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tMSOqDUiHg3x8Ta8RjINlgr9WbHH1qo96WZyRpls9Vg=;
 b=dmsvo2TW2VI56ZuZfdqS1Mt0SVI4I3PuqMwstxs4tpTJV0GsSuVPn5UewgjuRI+1CM
 41Vtf0WqTWV5Qu6YN9pOPDmp/qpzCR140UwScI7yBVL0XuH8vtZT1XxlVAvZSy22h76b
 Q3TUJYbivV9g0zvrMyrNSl6qTuTeGgAp9bDFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702285308; x=1702890108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tMSOqDUiHg3x8Ta8RjINlgr9WbHH1qo96WZyRpls9Vg=;
 b=YGgt/9o2/xa3cPspWmqckOJHy7PrO49gXntluBJe88oNH2BzJ9qgNY9J2EPaasx94J
 LMVQSDKqyGrcV9VttIKiA2rr8RVaOU3RkFAusdl0LIHw8rcyjNxlOROoUpZYxutmTS1Z
 TZYDjatrConfnpDtMHO/kqYqsfTgUBgpDhh5oh86f2qwlEtx9e/1KkMf2r1xqKMnhdAP
 oFhnUSwgav7WI6/EqthGRfVEB3db5aAHVs5kqL7YDWwBgjcWh8W/AR2ELYQjUJc65MFZ
 KdmGvtmCZC48mrEtI/dQ1wdxsz506iskg3VjA4OZaCdPHjjmWcmHG65GAGqWsvF74deA
 wzDg==
X-Gm-Message-State: AOJu0YyWPWoq1MBHK0ERVaq7D4IWfGZv1Iqc6FtwwjPZtaHAge4Fa8mj
 WwT8BsTbmLZ/mpid80rl2Avp3FRPkMJq3r3d2nUHyw==
X-Google-Smtp-Source: AGHT+IEmdDVg4DPQMXpJQglpFY/AkY7yBMe3JDPj4UU9Zx4TSCoRhMyh8Ft399FNb3wRHLxquExNpQ==
X-Received: by 2002:a17:902:8498:b0:1d0:6ffd:9e32 with SMTP id
 c24-20020a170902849800b001d06ffd9e32mr3260161plo.132.1702285308158; 
 Mon, 11 Dec 2023 01:01:48 -0800 (PST)
Received: from localhost.localdomain ([49.205.242.204])
 by smtp.gmail.com with ESMTPSA id
 e21-20020a170902d39500b001cfb93fa4fasm6080779pld.150.2023.12.11.01.01.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Dec 2023 01:01:47 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Anatolij Gustschin <agust@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Heiko Stuebner <heiko@sntech.de>
Cc: u-boot@lists.denx.de, Da Xue <da.xue@libretech.co>,
 Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 16/17] configs: evb-rk3328: Enable vidconsole for rk3328
Date: Mon, 11 Dec 2023 14:29:38 +0530
Message-Id: <20231211085939.5478-17-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231211085939.5478-1-jagan@amarulasolutions.com>
References: <20231211085939.5478-1-jagan@amarulasolutions.com>
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

