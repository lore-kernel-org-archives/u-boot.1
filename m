Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC22CE75428
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 06:26:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94AD387214;
	Tue,  3 Oct 2023 08:25:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ikyhidk5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E01B87203; Tue,  3 Oct 2023 08:25:52 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1DD787211
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 08:25:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5043a01ee20so604953e87.0
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 23:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696314348; x=1696919148; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cOAMR8uQ7AIukEgE07sxvY580KQDj+NcF1W0RijSo6o=;
 b=ikyhidk5xTW9IPFD93U2uIomqYVbbWbWrF3jJA8XY3e7+lQw3SR04Fw2yG67F7+GO5
 mSVv2mFTdOqWhu0bXAJrIPOBevjp9hc8knkaYgSMZL7COtnmRpoylw4vHEhdVEXLTbgV
 OUNqhkE2EmfVONahZ1tFjcNpp0+1NLr0NhuZHdjj9M2sXI1YF2TV0ed/LoigvDr2BhVF
 hlkAWEdTP5xTaaehhKFtdwfnWJAEjJTcg2vax5e+rOPgGyI+8kF+ZPj6acgSsP0bAP26
 gwdVQP0hAioz1icmVV2XW2SPMAS1yIfhvDpb3z0T211SdyMhBpRojA2mWung1VHAnHtK
 lntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696314348; x=1696919148;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cOAMR8uQ7AIukEgE07sxvY580KQDj+NcF1W0RijSo6o=;
 b=rfAfd/3XO/bEdt9yxKzlBEod4tD794Y0UAVRvZlL3jK8eiQ04km68c2je51qsDkBaF
 240uFpjZdJmw2TBoLG2q4dU6my4AHWXgQd0dueKFMty3PqOJo8oN1T5M/ehUKoTB9F+l
 9qZLebniAEeGlBwpax7j4jgPozZ/ls9rx3ZAn8PA30sPH48LZS3cB2fEJcIT75iWt10u
 OU8wwfd2hH4MLYl5tl/JOtINvFHl0mJoTmXRXwGgqedjFWvCe398OJUD2kEStuh3NS3c
 7J6Wo90cLByewY6bcOh5be6I3q1YgpBkc0XpymkQIVq7JmPD7enOUvpQkZ/Qdhmj1OFY
 dcPQ==
X-Gm-Message-State: AOJu0YwOaiI1qwGsE3n/nQHtD5xlBUoOV0kJppcWf6goafR9zjSr8XQQ
 lphJ3TkxJ776C18kQoDXMIs=
X-Google-Smtp-Source: AGHT+IHdjwgV8wCrMxQPGytPhJrzm7As6qcB3RRQJQycscc3T2sLEX+2VUP6uyFCWum0f0Mm2qIsxA==
X-Received: by 2002:ac2:42c6:0:b0:503:3b5:a65 with SMTP id
 n6-20020ac242c6000000b0050303b50a65mr9330935lfl.31.1696314348020; 
 Mon, 02 Oct 2023 23:25:48 -0700 (PDT)
Received: from xeon.. ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 c10-20020ac244aa000000b005031641b40asm74615lfm.159.2023.10.02.23.25.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 23:25:47 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Anatolij Gustschin <agust@denx.de>, Simon Glass <sjg@chromium.org>,
 Jonas Karlman <jonas@kwiboo.se>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v3 2/3] video: simple_panel: use
 regulator_set_enable_if_allowed
Date: Tue,  3 Oct 2023 09:25:33 +0300
Message-Id: <20231003062534.42325-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231003062534.42325-1-clamor95@gmail.com>
References: <20231003062534.42325-1-clamor95@gmail.com>
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

With the commit 4fcba5d556b4 ("regulator: implement basic reference
counter") the return value of regulator_set_enable may be EALREADY or
EBUSY for fixed/gpio regulators and may be further expanded on all
regulators.

Change to use the more relaxed regulator_set_enable_if_allowed to
continue if regulator already was enabled or disabled.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/simple_panel.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/video/simple_panel.c b/drivers/video/simple_panel.c
index 6a6473eb0e..efb122b534 100644
--- a/drivers/video/simple_panel.c
+++ b/drivers/video/simple_panel.c
@@ -114,11 +114,11 @@ static int simple_panel_probe(struct udevice *dev)
 	const u32 dsi_data = dev_get_driver_data(dev);
 	int ret;
 
-	if (CONFIG_IS_ENABLED(DM_REGULATOR) && priv->reg) {
-		debug("%s: Enable regulator '%s'\n", __func__, priv->reg->name);
-		ret = regulator_set_enable(priv->reg, true);
-		if (ret)
-			return ret;
+	ret = regulator_set_enable_if_allowed(priv->reg, true);
+	if (ret && ret != -ENOSYS) {
+		debug("%s: failed to enable regulator '%s' %d\n",
+		      __func__, priv->reg->name, ret);
+		return ret;
 	}
 
 	switch (dsi_data) {
-- 
2.39.2

