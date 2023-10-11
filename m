Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28FF8CD6E56
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 10:10:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A03E86DFD;
	Wed, 11 Oct 2023 12:08:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="paBxZM4t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB99786DE7; Wed, 11 Oct 2023 12:08:04 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 864DA86D20
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 12:07:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3a707bc2397so977839b6e.0
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 03:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697018862; x=1697623662; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=elX7B9lHvziN8IPqrJUEHKLzx5CF1FboA+ePTZUlIak=;
 b=paBxZM4t5Mz8x7ApK+ULS/0+KPuI5U9E8D8Sx1MhYVJbDY4yhUiFmgIXu4UTyCDPyw
 mOZdi4hlVJMWfun+bZzVH/JP6t/itNJfsm7GN/vTmbI9TwDYvGCyfIt0HJAY62Osi5hU
 EQHpCv48kVKuX1y6CeIsKlvrwMpHbF8eIhXuz3QnboVUNU1CAlCndrAZRYqEx1cw6x6O
 h6FLNgW5zAeMmPqd6orqd6I1tnfBPEeOn/WGqg8+HUMul4vOuPB7oY7SJHaztM/zJBMJ
 ZrVuZyHonnVsz4J9WQxvVD7yAfWXET+pWPmdlFLpcJJyzzDr1AO0qYXLh3nq29Zfy+Ym
 7bLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697018862; x=1697623662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=elX7B9lHvziN8IPqrJUEHKLzx5CF1FboA+ePTZUlIak=;
 b=AcNx4HOUA5POpULoxrqgmlf37Q6wSMXqoWsPO956UjqAp9f331fDtIjI61GXBIQuah
 rY41D9ntNJk96YbhQjE//lW10N1GrvIRhPbqwJE2u6UfJQwpc+0LqxdFJNnlghmj5TG4
 TpRBb4YQVYWKnQANjT48Yp14qslmHdxpqCxK2HztiCvjMQGyfzJ1g0BUIZzpRTG0C87/
 PTodK+bOzi9XOf0odegLiUnCZU/rekziaeuvRlCNq1ZBOsFSEF9+3LnvLCxlHjRpmx9Q
 vYc/adPbQWcFFFZwCBmVwqNptKC2eA4qzt4uX5lEilrKTpcR6El3SRyb3ONT6COtOOXm
 hz7w==
X-Gm-Message-State: AOJu0YyyGfdNAvWHtJ4AlNfri94qot6X+v37VZmLVlRRm7CSvaEzP08L
 piX1nmEUpfomuORD8r7W/2HLDw==
X-Google-Smtp-Source: AGHT+IE30Xryskzlh1w2NPh3IKNR8pomgGoBkNsgx8wAj+GuC1Ja2K5zGL0d0F0y2R0Yz8/WGMbSVg==
X-Received: by 2002:a05:6359:b9a:b0:147:eb87:3665 with SMTP id
 gf26-20020a0563590b9a00b00147eb873665mr16337393rwb.3.1697018861985; 
 Wed, 11 Oct 2023 03:07:41 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:5c6c:b11a:476c:8ebb])
 by smtp.gmail.com with ESMTPSA id
 e4-20020a62ee04000000b006889664aa6csm9663358pfi.5.2023.10.11.03.07.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 03:07:41 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: etienne.carriere@st.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v6 08/14] firmware: scmi: add a version check against base
 protocol
Date: Wed, 11 Oct 2023 19:07:01 +0900
Message-Id: <20231011100707.1007417-9-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231011100707.1007417-1-takahiro.akashi@linaro.org>
References: <20231011100707.1007417-1-takahiro.akashi@linaro.org>
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

In SCMI base protocol version 2 (0x20000), new interfaces,
BASE_SET_DEVICE_PERMISSIONS/BASE_SET_PROTOCOL_PERMISSIONS/
BASE_RESET_AGENT_CONFIGURATION, were added. Moreover, the api of
BASE_DISCOVER_AGENT was changed to support self-agent discovery.

So the driver expects SCMI firmware support version 2 of base protocol.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
v6
* new commit
---
 drivers/firmware/scmi/base.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/firmware/scmi/base.c b/drivers/firmware/scmi/base.c
index ee84e261945a..1d41a8a98fc6 100644
--- a/drivers/firmware/scmi/base.c
+++ b/drivers/firmware/scmi/base.c
@@ -481,6 +481,7 @@ static int scmi_base_reset_agent_configuration_int(struct udevice *dev,
  */
 static int scmi_base_probe(struct udevice *dev)
 {
+	u32 version;
 	int ret;
 
 	ret = devm_scmi_of_get_channel(dev);
@@ -488,6 +489,13 @@ static int scmi_base_probe(struct udevice *dev)
 		dev_err(dev, "get_channel failed\n");
 		return ret;
 	}
+	ret = scmi_base_protocol_version_int(dev, &version);
+	if (ret) {
+		dev_err(dev, "getting protocol version failed\n");
+		return ret;
+	}
+	if (version < SCMI_BASE_PROTOCOL_VERSION)
+		return -EINVAL;
 
 	return ret;
 }
-- 
2.34.1

