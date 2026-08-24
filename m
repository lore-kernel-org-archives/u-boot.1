Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 418E4C5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 14:23:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D910E809B5;
	Mon, 24 Aug 2026 14:23:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XXZB2Hpl2Wuk; Mon, 24 Aug 2026 14:23:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787581407;
	bh=1XyMCBw3wLNIgBFhyd3ayoFM2ZNp5PJyAsiGH3j0vZw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=HCaMDBihk/g9CwGKdKTaU5K0kAzL5uqM03+HsDm6QVSgwbr3pLenvG9cav7Z5Vc8y
	 O04MGhzGlvoVN8lkrpgmEEksbo1ar7Y4xNHr1y+ZtV41OuFc9QckF2GhUtmHPWvNPd
	 WsaEDBtu7ld/32/yaTkdFlATinwP1CR1Tab8iUjak6FNlkGNYUzphcq2G3q6klXyVB
	 sppoZBldihlb3ucHXIbD3EgXhun7ADazOgpNmeJ7Vqie+K79/VCNAC8jyAPnHT1GFD
	 E+5ejSvCebxrgJq2qRA77awFWmby4WB/ITRJYh64hWvUIYSU3rtDiOMDR9QATclmJJ
	 /zIMOmeixwsQA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0FCBE80994;
	Mon, 24 Aug 2026 14:23:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 41C9B3AD
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:25:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3F93A60600
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:25:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9cn3C9_5KYCv for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 13:25:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f32; helo=mail-qv1-xf32.google.com;
 envelope-from=sanderson@brivo.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=brivo.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=brivo.com header.i=@brivo.com header.a=rsa-sha256
 header.s=google header.b=GneLPTZQ
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4BC10605FF
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:25:22 +0000 (UTC)
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-90a6b298889so28130186d6.3
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 06:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brivo.com; s=google; t=1787577921; x=1788182721;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1XyMCBw3wLNIgBFhyd3ayoFM2ZNp5PJyAsiGH3j0vZw=;
 b=GneLPTZQCzxFVKUdOD8SCPJSUw2o79GgcpGnJTMpEqNkeGkF5Nls4IlO+8UEosp1qw
 LaOP1IN7kt3Edafb2ylLRrlwvYErDRnTBG1AfIU0jXUfvFDGN2DvMhNIcPsuhIKtEiEA
 ZQzqPT042jnfYgJX1BixmOrmmCd1bW7MtA/y5AUvwGUfptCu+6ZFOkCYEhrXNGBgBRt6
 7fBsv/NGFVN6YjX6QTfNXTc56DW7axejR/2DjditADcnezfTSWJvDRmQNKblVec+SsoK
 fV3Z847KLIE5pjO3LpfpKhZLXvqJ1Vz9PI93/VReKVUs3rbK8lSivXRkDemgVysK1HjX
 aolw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787577921; x=1788182721;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1XyMCBw3wLNIgBFhyd3ayoFM2ZNp5PJyAsiGH3j0vZw=;
 b=Fqs6IuGF9NcmTv5VT2mZ6854fPETILhlW/+DMvuAhdhPQZlVbzjkHECRwyacimEgEJ
 PNpeKC8mU1DTEDfC78a7NJ9bYMyLuwuLbGeatpwQFFsBFC3bQBYsdiBLldowho6E9sYr
 052582JId/gXlU1xFt+raToL5/bUn3JC8x5ysVpl8UmTs0s65BeXtbyG8p+q/iZ1aqE7
 jpTgI2TUpqx2ybWfgdhg9EcWFOQIqhWlOfnfiMbYS9BtTXlkXb58znrNU/9tRGg7FNIZ
 e9A1KJhDMGqgKZo5abNamIurrZiYKYJlKZenQq8gonqU8vYy8YAz/OOa3CDIwZNFlYZ/
 R1nw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrDpKdCBpow9ISqjorYrWk90nLQ/ev1Tm1DC+SPhmbb3cwI2JhF85706wjJ9zW3szkfUpsfutQ=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++m+o8NN2Rzv/wFE9zH26uB5Ax9MmeAY4EHZre03LVbSLQMhsJxa
 M0QPvpSJHmtCSHHBg+Zbdc+gbdNQKITHORTitnWjC63rqnU4ZcHypAjPV6xBTVOKqdzraX4/ZIN
 fgIKw2qvp6TV0Z37XzYaKMO14dgRoIg77KD1ZRqnw3NIpjQXw1EHc7LpVOQNWngo=
X-Gm-Gg: AR+sD13RXwnbDCK152AeApljnHCG3WQJOujMQVd/UgCBwDWjauOAEYa8BXUuu+WT01w
 APruAk/zDmjBhD7osPigbYx83w7zGwzahpTUN2XikwLD7p+ZSwGmSoJJQNyGhaVJ6dqqIeTloM4
 cfkPO1dOa4CURPK5kupgWQ/XgA6dhUIH1ivNwDgxBHq7KkZ39EOqK91SXYiQnnbtaujh+Fo1qjZ
 K6px1IiWKt0Gh2Yxi8SAtjSPhY+4YaIqJzsXDyIgZa+O7HrfJsXeaz9RKd45g1+sq50dYARayeG
 W19GPo9tN+3iR7ME2z2eAclkD7XMYFDbDjdDkq7y5/sbo74XnuQVCZZmFzQ+eUuefMmmQWHhyA1
 aXHNhjSan7czXeT3mmQh61d4MZDRuTle6O+iv3YqZmmFggI9HGXHxp0Qax4RZEjMuJ/PyVRhQ/a
 gq/DFKrINi+3Ph78d04luCrm/mOvrJefjNboxFzl2fOEo70PglivY6
X-Received: by 2002:a05:6214:2c0f:b0:90c:281f:e7cd with SMTP id
 6a1803df08f44-90c8f9f6fd8mr182720716d6.21.1787577921246; 
 Mon, 24 Aug 2026 06:25:21 -0700 (PDT)
Received: from strozzi ([66.193.28.125]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90c939314b7sm61980306d6.30.2026.08.24.06.25.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 06:25:20 -0700 (PDT)
From: Sean Anderson <sanderson@brivo.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, u-boot-amlogic@groups.io,
 Sean Anderson <sanderson@brivo.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v2] mmc: meson: Parse devicetree properties
Date: Mon, 24 Aug 2026 09:25:05 -0400
Message-ID: <20260824132518.522252-1-sanderson@brivo.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 24 Aug 2026 14:23:26 +0000
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

Signed-off-by: Sean Anderson <sanderson@brivo.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---

Changes in v2:
- Remove Upstream-Status tag

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

