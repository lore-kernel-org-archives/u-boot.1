Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0495AC36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 09:54:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA93D82D6B;
	Mon,  7 Apr 2025 11:54:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wJmv168s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98BC382DBC; Mon,  7 Apr 2025 11:54:42 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85A0982D5E
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 11:54:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ac339f53df9so715718466b.1
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 02:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744019680; x=1744624480; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3/9FooFiI1nym4BjJls227Ycp/feHMXkdw+ASKYqbc8=;
 b=wJmv168s7b7xpO3PbAAo0DF1A6iAiIDkBQoLd6wE0PWkVyQaV7SPcfcWloTVr6gRJE
 wbeF3LwdGlY3hyso5z1fOqA1BO/fEilk79x9UsSVt0epPO72QDhV/hIZqd1VWSoVgu0j
 M641KUth9c9XmYdDUW3EEzphDQeT4T3IJ368PLjrmW6JeJaXzSmubuInGjOL1+QDAZYQ
 WuHJm6emet7D7HTnYTQAnGNYuFMgcjH8NW5hzIg6gcqy3MxEkVMsz5vd9BMuFw3yal+a
 13JhCwk33q2fIkVXlcw7L7mEqm0d3YdKue1i0vDDtDhURTxxaBwxkLJ/e9zyIGd+D/MD
 Xpeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744019680; x=1744624480;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3/9FooFiI1nym4BjJls227Ycp/feHMXkdw+ASKYqbc8=;
 b=BDiLH/EV9s74da/C04USOA5CaSQS+5jk1n8Ut/lCBSGmodo/sPUPBhfasSKVGXhaVR
 TcKS2xZbsmtBUoRc0P4Xr/ju5J2w+dFZtpaVeX6upkz4Dsdu28pvrEB26stsrSI3JrbD
 PxbE+s7hqx+vlKp9GYQB0WaHp3TIjdSR5G4zF6k4Xtn7xMsvZQ/iMuSfI0fYzxX+8OqZ
 kGyZ0uFHNWAcsWqOhP+KRAhBN3YxZVwkM+1fFIzOmbJyaryb5CLB82Cg7fIm3ruVZa2z
 FqdzF76HgU+Zg4LscoLT0CXFUpLf4DkrGACN0IxTAREde+YEMaBPvvJyyVJgU/ZeFSQD
 zOyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCURtC9MIxkl+QhAl8SFKvKQGlbPCth3aHthKSoA6gc+XLFQdmSBkSD/aT1NsSKTD0uzPnmgVUs=@lists.denx.de
X-Gm-Message-State: AOJu0YxEmwLIljoBt5vl7+15r0wM3jjvz0OGlMfWNDpzJEdxlA3kpII+
 tpGJGCEPOZQ4/QkVRoZKRngMRbVEyl5l5rZLm8OOlprO6VEG6spGyBIsPR9QHyQ=
X-Gm-Gg: ASbGncvDOt7YGNZ+eObFebi1XndPW+39agDA9FFR3fZm+kvA4sExQH/cUVz5KT5ESWz
 o7HWepYdFlJQvk44XeOTguufkwD5PmHH1HTZ69tv9GsaJNUfmeY1t/FwALDorymFnB/iQoJBqmp
 Oex5Kp5350UIbaLTVinSN4Y+KpJKM6GCYh3RQmj8dV5uMdof4hLP8KEKVsUx1/PoW9gk88UnTbb
 jbSn1K75YI/Nk9Qx/EvgdOY+aukhHIocth6zGjBFIfH0pem+gwFL1y5rMlgy3yL7R7eCpMCPg48
 cJTI2znbM06fmCfFAYJZjwpmLX4E6vCb98EO+s5swE77oaMeRc1v4af/2g==
X-Google-Smtp-Source: AGHT+IF7zwEtijhDtuCKDSqyGPrxX/72tPG2n6vwcVNs6of5rbcrmi+6tqFcgbgFpLCsxJVIfs4XFQ==
X-Received: by 2002:a17:906:7951:b0:ac6:b8de:1a74 with SMTP id
 a640c23a62f3a-ac7d18941b7mr1181236166b.15.1744019679691; 
 Mon, 07 Apr 2025 02:54:39 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef30:7d3f:b102:5311:c65b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7c013f6b5sm735733766b.109.2025.04.07.02.54.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 02:54:39 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Mon, 07 Apr 2025 11:54:22 +0200
Subject: [PATCH 2/6] usb: host: echi-msm: Drop ulpi definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-ehci-msm-fixes-v1-2-f8b30eb05d07@linaro.org>
References: <20250407-ehci-msm-fixes-v1-0-f8b30eb05d07@linaro.org>
In-Reply-To: <20250407-ehci-msm-fixes-v1-0-f8b30eb05d07@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>
Cc: Sumit Garg <sumit.garg@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Jianfeng Zhu <JianfengA.Zhu@sony.com>, Jacky Cao <Jacky.Cao@sony.com>, 
 Sam Day <me@samcday.com>, u-boot-qcom@groups.io, u-boot@lists.denx.de
X-Mailer: b4 0.14.2
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

These are unused.

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 drivers/usb/host/ehci-msm.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/usb/host/ehci-msm.c b/drivers/usb/host/ehci-msm.c
index dd1d527a3a2c3f38df747dbb41cbb84bf76286e2..60b2dc44d3d35ddc5b8cf37f70bbccd91c5e962c 100644
--- a/drivers/usb/host/ehci-msm.c
+++ b/drivers/usb/host/ehci-msm.c
@@ -24,7 +24,6 @@
 struct msm_ehci_priv {
 	struct ehci_ctrl ctrl; /* Needed by EHCI */
 	struct usb_ehci *ehci; /* Start of IP core*/
-	struct ulpi_viewport ulpi_vp; /* ULPI Viewport */
 	struct phy phy;
 	struct clk iface_clk;
 	struct clk core_clk;
@@ -138,17 +137,11 @@ static int ehci_usb_of_to_plat(struct udevice *dev)
 {
 	struct msm_ehci_priv *priv = dev_get_priv(dev);
 
-	priv->ulpi_vp.port_num = 0;
 	priv->ehci = dev_read_addr_ptr(dev);
 
 	if (!priv->ehci)
 		return -EINVAL;
 
-	/* Warning: this will not work if viewport address is > 64 bit due to
-	 * ULPI design.
-	 */
-	priv->ulpi_vp.viewport_addr = (phys_addr_t)&priv->ehci->ulpi_viewpoint;
-
 	return 0;
 }
 

-- 
2.47.2

