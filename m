Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D6C8C47422
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 07:53:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16F1B87A1B;
	Wed, 17 Jan 2024 08:52:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="JO4MTsXV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C9BB87A07; Wed, 17 Jan 2024 08:52:34 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34A9686F67
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 08:52:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1d5e004f592so6920395ad.3
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 23:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1705477950; x=1706082750;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2MbhmCjMjsQhtMKE6tIbTGO+JtqAoVrIP5FN7iVn9DY=;
 b=JO4MTsXVYiMWM+LGiLVdMCh4+uqrdZsyWJmojNoRqiWb67bFAshRYXeVF9nP+ejjVY
 Q5B6No/jJkVCAhY5jQfywYNhAEXo0iHLpKqoC1VpvK2aip+5qCM13tU/DxXnE53Erxn1
 IvF3njliZl0N7uTvqajuowTJyQrXzgXQrNZAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705477950; x=1706082750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2MbhmCjMjsQhtMKE6tIbTGO+JtqAoVrIP5FN7iVn9DY=;
 b=tkfbaFCqhlHlKhQZit/brw9YBWgOl0Qjxqa9q7JAPVxmTWZWpw87vBF8axx44gOsLp
 z3tvx3jm7TGsxi9o+QZwPo/bAo8aHK8Ui9umspTPWu0UolW18URaxf9KcIIO0n5LuDgp
 4XagUuxD9So5t2FpPE1XNFtAHqWhrl/W0eIsgbfDh4TffkyOEm6bdPTfAwonhMX1cfDj
 LILJ4qtTpPbnHR2tI8VELUWVVbKLmt1WHmgIpjyWH7oK1lNmuYJ+Ht7HgLI+HRWXgcyf
 cYfcsY9K3KSZT6inZLcQshF+EU71O0C3724rHfIro9LXZIjGJr35zYCgGoaPA5nJ8VlC
 i8pQ==
X-Gm-Message-State: AOJu0Yw36eMd4M6xmPSyvtIjsNq5wV4Bt5AHmAomR8HPjhXhWjyVL5tO
 bXIpF4esQSoVw0vtx9BcACgI443nhk6VaVlDBcLAwMvTaZVqvw==
X-Google-Smtp-Source: AGHT+IFUIM/WwuZx3gb9aFdNs0UnWeD+P5VceQ37rBghYmC8kjqwGtyiAODL4tTz/zfbPrem9vEO/A==
X-Received: by 2002:a17:903:188:b0:1d5:ea55:8ef1 with SMTP id
 z8-20020a170903018800b001d5ea558ef1mr1698764plg.37.1705477950568; 
 Tue, 16 Jan 2024 23:52:30 -0800 (PST)
Received: from localhost.localdomain ([183.82.41.50])
 by smtp.gmail.com with ESMTPSA id
 e10-20020a170902784a00b001d5081be740sm10718624pln.62.2024.01.16.23.52.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 23:52:30 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Anatolij Gustschin <agust@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Heiko Stuebner <heiko@sntech.de>, Andy Yan <andyshrk@163.com>,
 Robin Murphy <robin.murphy@arm.com>
Cc: Da Xue <da.xue@libretech.co>, u-boot@lists.denx.de,
 Jagan Teki <jagan@edgeble.ai>
Subject: [PATCH v3 04/17] video: dw_hdmi: Add read_hpd hook
Date: Wed, 17 Jan 2024 13:21:41 +0530
Message-Id: <20240117075154.58747-5-jagan@amarulasolutions.com>
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

From: Jagan Teki <jagan@edgeble.ai>

Add support for DW HDMI Read HPD status.

Signed-off-by: Jagan Teki <jagan@edgeble.ai>
---
Changes for v3:
- check hdmi->ops
Changes for v2:
- none

 drivers/video/dw_hdmi.c | 3 +++
 include/dw_hdmi.h       | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/video/dw_hdmi.c b/drivers/video/dw_hdmi.c
index 3a3b9b7a21..989b7ab2db 100644
--- a/drivers/video/dw_hdmi.c
+++ b/drivers/video/dw_hdmi.c
@@ -946,6 +946,9 @@ int dw_hdmi_detect_hpd(struct dw_hdmi *hdmi)
 		return -ENODEV;
 	}
 
+	if (hdmi->ops && hdmi->ops->read_hpd)
+		hdmi->ops->read_hpd(hdmi, true);
+
 	return 0;
 }
 
diff --git a/include/dw_hdmi.h b/include/dw_hdmi.h
index ba2ce5ea7f..a1f0e64507 100644
--- a/include/dw_hdmi.h
+++ b/include/dw_hdmi.h
@@ -538,6 +538,7 @@ struct dw_hdmi;
 
 struct dw_hdmi_phy_ops {
 	int (*phy_set)(struct dw_hdmi *hdmi, uint mpixelclock);
+	void (*read_hpd)(struct dw_hdmi *hdmi, bool hdp_status);
 };
 
 struct dw_hdmi {
-- 
2.25.1

