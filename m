Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF92BEA4FC3
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 14:33:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 521B683D17;
	Mon, 23 Feb 2026 15:33:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BcSykBXf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B46FD83D17; Mon, 23 Feb 2026 15:33:33 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B17AA80077
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 15:33:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48379a42f76so34217705e9.0
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 06:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771857209; x=1772462009; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pq26o5Rue29JVqQhANhlT1MtJwUHBdQKBfocG6u2YXM=;
 b=BcSykBXfKgjdu5c+Ia5p4gfjP+qHRZWWbR1q/2cJzTTn9e659I0XjVIyh5ch4dQ3PY
 zVY87zZMLdkd4+dpWSflLAGPWyboglw8fNahS+KQnl8svvWbKRzFIC/eWw8InVwLjGPH
 xQXBKx5JFFWISb8LO9er9wMbxZx3MfepbvpAR5oBf6SIFCbvmNTSapcrznV9OCFODhjU
 AgWDx7Gwl5Ra6VEmV7QHxXOAnoRxK10IF809W5LZze4v7+T9vc9ZI+hjWOO/a/q/suXr
 1zHd8PdXZZFMRpqvlQEQQBqG+2aUHiw0vk5ksqjifc6LZjGxO0upRrQE3eXFamXWNIpu
 T5IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771857209; x=1772462009;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pq26o5Rue29JVqQhANhlT1MtJwUHBdQKBfocG6u2YXM=;
 b=oe1HgqK68Id/9gPc1rYHXxNCqtuKm5tU4bz3WOrxC4mbAZorupoVRm7F6I90kvSq8+
 W4kUIM8xV6NnYQnBPiqDkpGDCZARLizb0FvfUryUX0/J2CSFIm19RlEL1dT6azKYVdSY
 /aAqvLPal51pMHrGQd3mhVLHI+62niJcUQ+T+3vxtGXjJkiVf5wceR+teHILMdZlk3TB
 2tdCMyHjeSwvino+NQmzOta/sgUNGfo+wL34B1vGql8TCdTT2F5vCItA4BHMPDuH93Yq
 L2jzzAT4klItAzxDeNhADSS8XJ9vkcwWIHz7MiHibMXkb7/x+XoVkxkuSlIoj1Ea76fz
 fn1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9HiNqxprjc6QZ/3if158yvHs+Aw66blgzptWCt6UXKE7ml51D+1yqD1DMUwyD+JGn86KqYf8=@lists.denx.de
X-Gm-Message-State: AOJu0YxAHcQDMrqcXvcfXUa0W3RojGrrmNY94UlHBCm6q+HuVEKeCNFa
 qKi0qjMLWiRU6UUcoW5vuu3yo+48qjPGSXpbnXeVWuhg9NkhzV8dK9IOTX8JlyIIs1I=
X-Gm-Gg: AZuq6aI8oup59ja3h+3dd7H84ysMJ3SeJBYGM8FFOnAubLhEU81a+eilPasCxysqJp3
 /uUEj7Pr+dBB0wsX9ZZMbWPVN0oybZ8v9mITdF0EqLaIx55u+QDXyHt1mvptuSuXQ1JfrtNFyPE
 k/g6Oh0TfOjjNm/L+xkoCdLsh4lj0BrlmUk3701YZ7kvNo36pw1eQVNM5EgIJcgbFHtsOXqrn0N
 dST/nEn2MZqIxGY+rKUgeg6m0RWXsNUFmf3ws/x9o4RjVTTHicWziX91sqrmuFNTW2PMdeMSs6Q
 RMZmJZCwh5UbspSMyxzcV0mImkj3gbc8WWZMzXxwBdb+iFcekiUAyP66cqZMn8mFWGyJg1pOz8W
 vdyD3eW4Szr9VnUcSHK1tzux1E98SvXQqgqnh+Y7sIas4RB1lE3OMPOXcsBVHZnfDIbVW7AGKT3
 /V5lXydWBElwaSviWrgbUDb/g2+BSS
X-Received: by 2002:a05:600c:5020:b0:47a:814c:ee95 with SMTP id
 5b1f17b1804b1-483a95fc1d3mr154778335e9.12.1771857209148; 
 Mon, 23 Feb 2026 06:33:29 -0800 (PST)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a4303447sm86493695e9.27.2026.02.23.06.33.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 06:33:28 -0800 (PST)
Date: Mon, 23 Feb 2026 17:33:25 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Peng Fan <peng.fan@nxp.com>
Cc: Tom Rini <trini@konsulko.com>, Alice Guo <alice.guo@nxp.com>,
 Ye Li <ye.li@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>,
 Valentin Caron <valentin.caron@foss.st.com>, u-boot@lists.denx.de,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Khaled Ali Ahmed <Khaled.AliAhmed@arm.com>,
 Michal Simek <michal.simek@amd.com>, arm-scmi@vger.kernel.org,
 Linus Walleij <linusw@kernel.org>
Subject: [PATCH 1/4] scmi: pinctrl: add pinctrl message IDs
Message-ID: <62727b8bc822e07ad546d9e9fe4373a372a3f1b9.1771856828.git.dan.carpenter@linaro.org>
References: <cover.1771856828.git.dan.carpenter@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1771856828.git.dan.carpenter@linaro.org>
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

Add all the pinctrl message IDs.  I renamed SCMI_MSG_PINCTRL_CONFIG_SET
to SCMI_PINCTRL_SETTINGS_CONFIGURE so the naming matches the spec better.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/pinctrl/nxp/pinctrl-imx-scmi.c | 2 +-
 include/scmi_protocols.h               | 9 ++++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/nxp/pinctrl-imx-scmi.c b/drivers/pinctrl/nxp/pinctrl-imx-scmi.c
index 781835c68527..cf76b14d3731 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx-scmi.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx-scmi.c
@@ -69,7 +69,7 @@ static int imx_pinconf_scmi_set(struct udevice *dev, u32 mux_ofs, u32 mux, u32 c
 	in.attributes = num_cfgs << PINCTRL_NUM_CFGS_SHIFT;
 
 	msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_PINCTRL,
-			  SCMI_MSG_PINCTRL_CONFIG_SET, in, out);
+			  SCMI_PINCTRL_SETTINGS_CONFIGURE, in, out);
 
 	ret = devm_scmi_process_msg(dev, &msg);
 	if (ret || out.status) {
diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index ecab021b4728..90b1bf76d5d6 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -1088,7 +1088,14 @@ struct scmi_voltd_level_get_out {
 
 /* SCMI Pinctrl Protocol */
 enum scmi_pinctrl_message_id {
-	SCMI_MSG_PINCTRL_CONFIG_SET = 0x6
+	SCMI_PINCTRL_ATTRIBUTES = 0x3,
+	SCMI_PINCTRL_LIST_ASSOCIATIONS = 0x4,
+	SCMI_PINCTRL_SETTINGS_GET = 0x5,
+	SCMI_PINCTRL_SETTINGS_CONFIGURE = 0x6,
+	SCMI_PINCTRL_REQUEST = 0x7,
+	SCMI_PINCTRL_RELEASE = 0x8,
+	SCMI_PINCTRL_NAME_GET = 0x9,
+	SCMI_PINCTRL_SET_PERMISSIONS = 0xA,
 };
 
 struct scmi_pin_config {
-- 
2.51.0

