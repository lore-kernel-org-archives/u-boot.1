Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C244C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 18:03:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3AB987B41;
	Thu, 28 Dec 2023 19:02:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FpBcgmvW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15663879D8; Thu, 28 Dec 2023 19:02:23 +0100 (CET)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77A5387B06
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 19:02:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-50e72e3d435so3753487e87.2
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 10:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703786540; x=1704391340; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9W9W32Y1/i3q8FnsMLifXorFA4pb7qPKubD9mQ5V1hI=;
 b=FpBcgmvWFH9kqQN9hSdV8kUyw0E7ORDovoR2hDJxANLmvF4hhmE5THi8zFrK8EA9Wh
 qke6ZW8yrN6r/bRmVn2WNPhveet3xY0OJLb/ouEeFP+YvaFhSzIat/ZJ0+xqTlJkjDAq
 IRfhOFlUs/EvgIEG+D4F21WEuSmqlkJZsszJuYKHg1FMidOAhz0Pd2+cNhM0ztjF3MH7
 Frz7O3Pvp5CeQw4rt2QOV0iMP5tMfQA5K8jqrQcOXKDNjWPOVHFRYAXaFIaP6A35vkl3
 jSrJUg9C2QgBWAaKqv454vLwal/Hgpgd4EYJkpbp1I3HnEATpmbLs4ZrtYVW9oqG88Hm
 HBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703786540; x=1704391340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9W9W32Y1/i3q8FnsMLifXorFA4pb7qPKubD9mQ5V1hI=;
 b=idTMf7XgkxLFth6euJsRdS3sDHQwcn0PxFfmkAnKp0gveRvdMY38HA9QOPU2bPP7hn
 /o2loDYZeEb5/mrQPjo7/P/yOZsgdDOYQMPcICrw626zUsNK6kUhCHvnUH68QfCxVb+W
 J1R9T5xNw9PFtms0hIidE6/o+uCcQ3w62s8+dooRwS5GtF2ApJbp8joC33nSxwvYSXHI
 Zf4p+y/yyyLwwz0k8GqyIvhW2BJvR6XSASKvo2+mg17HesZ/BEp4T5rKjQpGsYfhp8bM
 Jwn+7b6yLkaQuUTrm+rqqdfT66adc8VbxQK/BTj16cuGebJmhdutIL6O4a6YdjvRpj/0
 0jEw==
X-Gm-Message-State: AOJu0YxmfKr6r5BeCe5+ztCiGGNuYIVHirH77v3sx8mAxTIKClGwL2ij
 xfQszu/nLAjl8MnM4FwWelY=
X-Google-Smtp-Source: AGHT+IEUCcOMJTAPmkN4nGO9Udyj5s6ZfLdnCQvPTP5uz6LhsCb2VcqKkxErO2B8RkUn+v+YzzBOdA==
X-Received: by 2002:a05:6512:11d0:b0:50e:6e7b:1acc with SMTP id
 h16-20020a05651211d000b0050e6e7b1accmr1858408lfr.129.1703786539684; 
 Thu, 28 Dec 2023 10:02:19 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 s4-20020a056512314400b0050e6b04a5b2sm1955101lfi.251.2023.12.28.10.02.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Dec 2023 10:02:19 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Bin Meng <bmeng@tinylab.org>,
 Ion Agorria <ion@agorria.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>,
 Sean Anderson <sean.anderson@seco.com>, Heiko Schocher <hs@denx.de>,
 Dmitrii Merkurev <dimorinny@google.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v6 4/6] common: console: record console from the beginning
Date: Thu, 28 Dec 2023 20:01:52 +0200
Message-Id: <20231228180154.50473-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231228180154.50473-1-clamor95@gmail.com>
References: <20231228180154.50473-1-clamor95@gmail.com>
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

From: Ion Agorria <ion@agorria.com>

Set flag to enable console record on console_record_init
and not only on console_record_reset_enable. This fixes
missing start of U-Boot log for fastboot oem console
command.

Signed-off-by: Ion Agorria <ion@agorria.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 common/console.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/common/console.c b/common/console.c
index 6f2089caa0..e6d7ebe935 100644
--- a/common/console.c
+++ b/common/console.c
@@ -821,6 +821,9 @@ int console_record_init(void)
 	ret = membuff_new((struct membuff *)&gd->console_in,
 			  CONFIG_CONSOLE_RECORD_IN_SIZE);
 
+	/* Start recording from the beginning */
+	gd->flags |= GD_FLG_RECORD;
+
 	return ret;
 }
 
-- 
2.40.1

