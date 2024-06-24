Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD33C27C4F
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 02:23:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32FB4866F6;
	Mon, 24 Jun 2024 04:23:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jTJpNaMj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D35018704E; Mon, 24 Jun 2024 04:23:43 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE21083989
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 04:23:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-421b9068274so33606695e9.1
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 19:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719195821; x=1719800621; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VqJAov2AeAt7YuoUh+mfkC1qmWWZdswNuK0hQTCU1bk=;
 b=jTJpNaMjZad6Ur1UuH85Fhx3hI9NJzLTrgTZlP3s+S3fLfHHq0TiYOJ14zriSxfee5
 ZrMl5QgSLytwC8QUrfAuJy3y/V/ipk3nVfUCf0ueV3007KZjglqyAnJ5yZnZzc7cqKiI
 4MjYHTT/+gEaMiOgvvr+5IVrnmK0vKkyBI1h6IocwnWO/vPOaMWehT16cRqQI22vhZTc
 n13xdLYM5uCWL5zVXJByCsmtljK8o4jfLPUlvQ07fnpefMHXGD6+A4VdAs/t/0AksWxD
 YUo9MbPia53hMTPgOClxnduegGgYC6pyQaut/cWfqfbFE0NnvxJAaMIzhvvsNRNWNg/x
 x8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719195821; x=1719800621;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VqJAov2AeAt7YuoUh+mfkC1qmWWZdswNuK0hQTCU1bk=;
 b=C6V+Qw0UzAymjW+XB1hZ5TSNSlzMfYM4mGj7SlHMOz7ka4HFw7pf4i6M6ISXOtjQD8
 CNNyxUq85J3qlDwLkt1KNAgG2m7WO4OHJqNax54uv4kih/UYi3aFAZWwU6ElIPWjCB10
 Q0XOzXRH5xZCEmM7hJeXQnYjDOI8KLduQxpFbZtnLm5+YbhP92sXTbem/DdPWxYCXDmg
 aTSsrtX+oIAjmc7O64CGxGFgmgdu0rAE4xAFS/SedngUCwMTtITigqBafodq/Xj7JkMS
 7OmSOp2/V2rxg75J13ZrXYwJpHhDqlL2wepzXO3Qx8VZSIPQONmZeglt5YDNDDxr3r9M
 xsKA==
X-Gm-Message-State: AOJu0YwipJv94MgxepDs9iMKQ3InP7aiM9MbxmnWqH774vu/EtOJbmgg
 g3yqNtOd4Ig9aJLEtkaTjUPznQZ3+YWV6rR0y83jzVeONsD3daW4o6Tsh1Dpszw=
X-Google-Smtp-Source: AGHT+IH8fs/833jdC02q8wOviqHDr3saUryBWwcDzyDnu618nmKhbao/af7lzUhoAZq9astIXsfSGg==
X-Received: by 2002:a05:600c:3590:b0:424:95be:b627 with SMTP id
 5b1f17b1804b1-42495beb6dcmr2150435e9.0.1719195821137; 
 Sun, 23 Jun 2024 19:23:41 -0700 (PDT)
Received: from cymric.caleb.rex.connolly.tech ([2a02:8109:aa0d:be00::52af])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57d305616f5sm4121242a12.80.2024.06.23.19.23.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 19:23:40 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	u-boot-qcom@groups.io
Subject: [PATCH] spmi: msm: correct mac_channels for v5 controllers
Date: Mon, 24 Jun 2024 04:23:29 +0200
Message-ID: <20240624022333.2380607-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.45.0
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

Commit ee1d8aa5ecf7 ("spmi: msm: support controller version 7") broke
support for channels > 128 on v5 controllers, resulting in some
peripherals (like the power button / pon) working but others (like
gpios) reading bogus data.

Correct max_channels for v5 controllers.

Fixes: ee1d8aa5ecf7 ("spmi: msm: support controller version 7")
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/spmi/spmi-msm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spmi/spmi-msm.c b/drivers/spmi/spmi-msm.c
index 58c676423f40..49aad439648f 100644
--- a/drivers/spmi/spmi-msm.c
+++ b/drivers/spmi/spmi-msm.c
@@ -270,9 +270,9 @@ static int msm_spmi_probe(struct udevice *dev)
 		priv->max_channels = SPMI_MAX_CHANNELS;
 	} else if (hw_ver < PMIC_ARB_VERSION_V7_MIN) {
 		priv->arb_ver = V5;
 		priv->arb_chnl = core_addr + APID_MAP_OFFSET_V5;
-		priv->max_channels = SPMI_MAX_CHANNELS;
+		priv->max_channels = SPMI_MAX_CHANNELS_V5;
 		priv->spmi_cnfg = dev_read_addr_name(dev, "cnfg");
 	} else {
 		/* TOFIX: handle second bus */
 		priv->arb_ver = V7;
-- 
2.45.0

