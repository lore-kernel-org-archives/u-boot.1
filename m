Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2759AC27C53
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 14:22:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FAD887FB5;
	Fri,  7 Jun 2024 16:22:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QxmewxB6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 266A687F6F; Fri,  7 Jun 2024 16:22:51 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F4D588047
 for <u-boot@lists.denx.de>; Fri,  7 Jun 2024 16:22:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a6ef7c2ad93so12321366b.3
 for <u-boot@lists.denx.de>; Fri, 07 Jun 2024 07:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717770168; x=1718374968; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jgyCaQJrBEugZgFxCORtabx8inoyp9FuBf7Um+61omY=;
 b=QxmewxB60OqV9zudPXNWaYK2wcjFO/lb+w6l2GkUIHTR2GfW5NJJE+LU2B0TsBBX2F
 PzljguH1JOfsJGZ7Eb4Cj6xIDqKUBxH8iDtpzYk5C+SigIMs250Jp+sqBvaG5z8WXOGC
 2R1WELc+3RrVZYB1gf1MTFt98hoJTPZiiT4HQJeczvDxhbUF10ZFMn7G9OlthmXWCqmb
 Gum1EVSJ8uF91rXk1rEIT7rVpJCV6n3pGNZJTncOTiGWRHnJmHAxu6IhlnZSCzkk4WK2
 hcR0r46L/ddcXxXm2MV5rkSDkUkmstW6CEEe1T//NlLKLTE1JifOH+/Z0V1mcj9YHMRI
 rO1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717770168; x=1718374968;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jgyCaQJrBEugZgFxCORtabx8inoyp9FuBf7Um+61omY=;
 b=aQQCZM9+Y3JSP1+Qt0Xa+vvIpE9l+dXQRIjXjxA1puZuNgj/WSyNmHkmBJwk8LUXm4
 TKA4ODPd1Y8+2gEwfbeWDrYWmY3iIv3C+OqIe+6Ymmjsn4uRB/hCU1y9lwOY80RttIBt
 +j1SWxh6yBTEzHvG6EC2Vm/g9KMbV8dRKARlhdF9iEXr67cE1ydupuMEgEPVRRU1NGH0
 rKpM6mGK+qd8Ad6RcNZLUK4ZGUnGcQwz+O2v6y9UENPI2SWpmT42AMsINVIdzFUqRbHR
 F8zKpc2xUEGAPYBc4w66/Ifn0AXG+psnqsbAwATmugb+dqAZm2IRvpgVwvd7xsNyNubQ
 L8pA==
X-Gm-Message-State: AOJu0YyXtuhVedclA+gwFTN2a6re/FlilKNNfe+6PPoqHLCPFfZolEYz
 Fn8cm4pjixLEydV+DmcgF1er2uejXJiEnHZoQ827qS990Q4eyRMD5pV8Pk9zk5Y=
X-Google-Smtp-Source: AGHT+IEBVFG/ltSmndvYX+i9XRLEElElRNyiH48WQab+jjBJvbZRa8D7mBgJqss4t8AUPEQEYJ5D9Q==
X-Received: by 2002:a17:906:bcdb:b0:a6e:f6a1:324d with SMTP id
 a640c23a62f3a-a6ef6a13335mr37074166b.69.1717770168376; 
 Fri, 07 Jun 2024 07:22:48 -0700 (PDT)
Received: from cymric.caleb.rex.connolly.tech ([2a02:8109:aa0d:be00::8090])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c805cc764sm251794766b.76.2024.06.07.07.22.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jun 2024 07:22:47 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	u-boot-qcom@groups.io
Subject: [PATCH] spmi: msm: disable read/write log
Date: Fri,  7 Jun 2024 16:22:16 +0200
Message-ID: <20240607142229.50709-1-caleb.connolly@linaro.org>
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

Most devices have buttons exposed via the PMIC, the button polling
therefore triggers a log spam if debug logging is enabled.

Someone would only ever want to log SPMI read/writes to debug very
specific issues, they can then uncomment these debug logs.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/spmi/spmi-msm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spmi/spmi-msm.c b/drivers/spmi/spmi-msm.c
index b0d6226041e5..58c676423f40 100644
--- a/drivers/spmi/spmi-msm.c
+++ b/drivers/spmi/spmi-msm.c
@@ -118,9 +118,9 @@ static int msm_spmi_write(struct udevice *dev, int usid, int pid, int off,
 		return -EPERM;
 
 	channel = priv->channel_map[usid][pid] & SPMI_CHANNEL_MASK;
 
-	dev_dbg(dev, "[%d:%d] %s: channel %d\n", usid, pid, __func__, channel);
+	//dev_dbg(dev, "[%d:%d] %s: channel %d\n", usid, pid, __func__, channel);
 
 	switch (priv->arb_ver) {
 	case V1:
 		ch_offset = SPMI_CH_OFFSET(channel);
@@ -185,9 +185,9 @@ static int msm_spmi_read(struct udevice *dev, int usid, int pid, int off)
 		return -EIO;
 
 	channel = priv->channel_map[usid][pid] & SPMI_CHANNEL_MASK;
 
-	dev_dbg(dev, "[%d:%d] %s: channel %d\n", usid, pid, __func__, channel);
+	//dev_dbg(dev, "[%d:%d] %s: channel %d\n", usid, pid, __func__, channel);
 
 	switch (priv->arb_ver) {
 	case V1:
 		ch_offset = SPMI_CH_OFFSET(channel);
-- 
2.45.0

