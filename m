Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B40C0C5B572
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 18:17:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 75A618112D;
	Mon, 17 Aug 2026 18:17:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U5KA0FIvx4zK; Mon, 17 Aug 2026 18:17:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5530281107
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786990652;
	bh=zbh3UhD9Jun5V7H7NQy9EsrhNmLnzjp5ZYGAMDpVKmQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=uie6tiHHbInh5bGz0XR0xhjLtukSM+RXy+yraZVFhXnqmjzhO/ri1dqVgdf/nHCgn
	 n0D85XHnTjkUGqzLUwL+Wh7eY0YSmWX+U9e6ZxXARz3/ajUedJKd2FuArNXXB8Fxri
	 exi1VatPD6mnnwFWq2y/UmbrHso+2eKTE9g+3eiVoQT55ERilFc1qKdjfKKu46O45s
	 yrYOwZNHzlJ5oTXWjzT1x4wBiNaVcx2Y6+/zFQ1hHYr2bqp+tplK0/GWtY/ZNID35V
	 fgAc84pWWYT/ftNn0p1oFoacDLzCviijQXn2AcyMXssjeDK8+DUStUttFnR9uaOE9s
	 iy7HCwi01Mwiw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5530281107;
	Mon, 17 Aug 2026 18:17:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 872CD2EF
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 16:37:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6CCB4607AD
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 16:37:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rqrwtxoBkL2u for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 16:37:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::82c; helo=mail-qt1-x82c.google.com;
 envelope-from=sanderson@brivo.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 9AF81607A8
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=brivo.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9AF81607A8
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=brivo.com header.i=@brivo.com header.a=rsa-sha256
 header.s=google header.b=DYgFbD9/
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9AF81607A8
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 16:37:04 +0000 (UTC)
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-51c08df8513so19732831cf.3
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 09:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brivo.com; s=google; t=1786984623; x=1787589423;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zbh3UhD9Jun5V7H7NQy9EsrhNmLnzjp5ZYGAMDpVKmQ=;
 b=DYgFbD9/bI/knUc84aLvvHYFbLo+ejpUs5HvqbsnuOiq1OtVW+qSV535QmEIdXowS/
 orPxI+II0rPK6Rs2HX5mQUmMWe5uxpfloMVDTyvVTZI5pYYDetxwenHz6G+tqu/P4bkL
 Icly0m++AtuFQtodvExwE5S535bCdZ6e+1T/V3Srqk9Da4RBTdReiaqfAOG5EwZ4qxh8
 qSj5xXMpR0ekfPeX0/RiAjB9HKRKgIptxmQqXhEapKE0JZhA/IilvRNtWJcSakmqW1lX
 X0sD0ip7Yh2j9MKvhpzT9pXc4eAlQ8PNNQQk9wHUlmf2umMzXxMndja+Tyk5cRHN/N6V
 94EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786984623; x=1787589423;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zbh3UhD9Jun5V7H7NQy9EsrhNmLnzjp5ZYGAMDpVKmQ=;
 b=IjTQoES9tt4/Zo4f8/ykMi/XqhaEeplErdHNnDVpL8pVfMglm1TouwZpC3d63HVakL
 yyEYE429gy1w8b/L1JaZTBvJTlfLKDFHSy0SP14seqNMj6Gs5Y2c6MBC3s8edi1M32Ms
 Ho5GMHiYCVVG/6XR96Oj+pMFsjWLaygpBlXtq14MkxzBIm4ziAoqPkSKLf4J1qqGfFzY
 Rbj8Gi7rvzlS8C8WRYfYSu6ioklVS9EpeeeZdNioDEy1Yl0jZ8iJUtX/9CB4RS2tqE73
 1nniq3iRANvRycJoA9bRuoxP4heOuTTdG4qxu6LzXdEX1MTiEDclPKy0zpCN+ghZrDhF
 3wlg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp02Fl+4bF1gvP4JRunU0Uc9EJSjTyc/AwR2qwRHtXP5GjY/OBXh3j1JzBGM57pMIhRrP52LKQ=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yyn48++AWsTXp8bUhlqDMMFFRHvW2qAOkVZPuvWviQ9SI1J0fO9
 OfaApjpUraRqm+lAteg8ekHnCZE9ReH1BzzwjzGu+iWQQfVwOGyLArOlSf3IupmY+gkFA6v5zxY
 fBM8jSNfREzpcqEEyciAjwtEHzEn7zZWSFRgT/+pE8bVzNvCdx816GBJkeJoZ6uk=
X-Gm-Gg: AR+sD11bHtwS2y43IwIyoctsMGN1plHp5MqzOTgvt87gJe+24eEdLAyZdBRvGildV5E
 FeVd6srQLwB4f9j8WmAB6SKUoQTsCrHtGgStpnVmHkT7ft37mWGgL3ZqD0ml3fCvL3UH/jp/5QF
 +p2NgLLjmcMh9SZkaG8YcTGmpWlA9cbAglPdgMffSwtrmcNkfdFfR8qGUb6Q8ewAP+j6646H/6i
 2je0UhvwoX+EeoXA39c3GgKukPC9qKcUjwwG46U5Vn+SDyBeXcKodx/xF8PAG+VSaTs73W7xQTl
 HZXKfgnIbzJaD5gFsVo6vhm8d5FXhl6ufCwTjp2gmpj48o96Ixfwx+7cpJbzv/ZXKtMPVuPfuTJ
 hxv3CeNXDuRTdAHSBy2p4Waqd1sLfyYY5X4uI49+p3WzGDwKJKQ0Cu+vNLeASF8G8oEzgulLVRR
 oVtQaexQAR3iqzpPxAeXxenp0y1o2ZcucnOgIJg2JjSstj7ABAiPW9DHdE1+DNt2zGgJd4zAbvV
 Xa9y6/PyJ2mOw+BcRkVh1emKJcvnzjQa53Qiw==
X-Received: by 2002:a05:622a:342:b0:519:8998:661b with SMTP id
 d75a77b69052e-52d85433854mr270381511cf.20.1786984622846; 
 Mon, 17 Aug 2026 09:37:02 -0700 (PDT)
Received: from strozzi (ec2-54-236-161-35.compute-1.amazonaws.com.
 [54.236.161.35]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52db623bfb0sm17882451cf.24.2026.08.17.09.37.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 09:37:02 -0700 (PDT)
From: Sean Anderson <sanderson@brivo.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io, Tom Rini <trini@konsulko.com>,
 Sean Anderson <sanderson@brivo.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] mmc: meson: Parse devicetree properties
Date: Mon, 17 Aug 2026 12:36:50 -0400
Message-ID: <20260817163652.1893650-1-sanderson@brivo.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 17 Aug 2026 18:17:15 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Parse devicetree properties so things like max-frequency are respected.

Upstream-Status: Pending
Signed-off-by: Sean Anderson <sanderson@brivo.com>
---

 drivers/mmc/meson_gx_mmc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
index 76af3873e15..b5b4e60d8ec 100644
--- a/drivers/mmc/meson_gx_mmc.c
+++ b/drivers/mmc/meson_gx_mmc.c
@@ -351,6 +351,9 @@ static int meson_mmc_probe(struct udevice *dev)
 	cfg->f_max = 40000000; /* 40 MHz */
 	cfg->b_max = 511; /* max 512 - 1 blocks */
 	cfg->name = dev->name;
+	ret = mmc_of_parse(dev, cfg);
+	if (ret)
+		return ret;
 
 	if (IS_ENABLED(CONFIG_SPL_BUILD)) {
 		cfg->host_caps &= ~(MMC_MODE_HS_52MHz | MMC_MODE_HS);
---
base-commit: d3e8597e46b635ec556a057bc42f0b0859654bdf
branch: meson_mmc_dt

-- 
2.53.0

