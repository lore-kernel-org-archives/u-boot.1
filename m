Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3655C369B5
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 21:17:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CF7982982;
	Mon, 14 Apr 2025 23:16:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sifive.com header.i=@sifive.com header.b="SxCLUtS1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57BC38211F; Mon, 14 Apr 2025 21:30:21 +0200 (CEST)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1154D80FF7
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 21:30:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=samuel.holland@sifive.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-224019ad9edso61387685ad.1
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 12:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1744659017; x=1745263817; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9v0PAvzZ4krbgV2hSvifPiEp6oAmkhQ1iABMoUnQ5hQ=;
 b=SxCLUtS1p/pe+jxqESoG7uUkvJ3wN7AP6XQDT4tVNmm16PcuW9a+LVnWODAo18UXNS
 jgwbY2ojeVYQZWyRuk0/f5vbMSuW5ZGgVemIeuO+wuqhbNxpTAz/YqLtZHnuvqMEhVnh
 3N+P1OvFvfr5muyO/EucjRKZ+wGr2x5cm+A7yWMfn1vNCRExjf7yxFZkZ31sUWZYGa9w
 UCAS85sOGueJTvVz9wPEtnvdEU7R6W0pcb9+DTYz51X8t7LWxeVZ0RwOwLGfOfFfAmEh
 BNLwC8hjTiAq8SUG8ho733RyIMF/FsqluKtkIBiLK5sXoxNsjEYj2OHllFhCws3cofUi
 3/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744659017; x=1745263817;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9v0PAvzZ4krbgV2hSvifPiEp6oAmkhQ1iABMoUnQ5hQ=;
 b=mFqxa8arP9o0rlk2J478lI4jbTtP3XMcJmbYUE0ucnMaMDUFnfaJ7bOigNSdfLlyd8
 hzu9cW62ie1IcbF4WPtplWQyObYqVkrx9TA4E5emwbbspAeWsk/WktgWGzbHp4wlFPnN
 f2esdsGtOJKYQqe4xo5AbVBC6qgKYPkOGG4n8s8cEyOo0fXL+ivlX06NDQnThZtvmLBU
 dFcUMyDW0J6HEWDrH0c/42gg499Lpg8sp4QWQjK7yxX+ulOgd3SH5XH03ED8dTtsC8H6
 pajjUc4jY45R5tL/Lgbh2sCtkkt9WGv+QfUYR2wyUGP/7oXV/1RhuTmw0MddCfarEnuN
 919Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2/wnYd3aW5UfkPFGSc+dr6jnggNxg0gqRIol54ewHCii6kWQe59/64/HMTFkJBjBlRs8q7mE=@lists.denx.de
X-Gm-Message-State: AOJu0YzrXkZWd0K3b2kFdxthuOMB0FEQbGuntLT88H1nV8KOqzFmtGfx
 fXYwkiimmfelQ4rIaq71v8a3PWwH+Nmx+swOkrMWP2FC8cEnCWzs6z9dgpfmqhE=
X-Gm-Gg: ASbGncsnMnuctVka+XPetyugEYBSBQJj8E6M4H69huwFcSAztKpm9nXD/0nNFNZfAXk
 dx1NYjwKEagLZ3Q/pkM3UOwQ/Z7majl2HONmhObaAQDh9Cnju5uAOwxxCzulLZrcbC8bF8ncfxR
 NxnZ4hZQyTut1ND26sAdgJuSJTFaLExNbpjmYsSzdHQ7hJCFuEBkMN1MPsyWVAuQrr0OleXNkYK
 HCwn9EHMxkMLDS83Hc/2EPRGGPtnM9YZ1dztwm5IG+YLTQpwWpyGxoQXxMJ3iUnvbInCnGJQ107
 6gCM081+GMISmq8oQcGlb/Hn4jWiXpvatw3FOTzTQkIS5oOf85JtaKq8ppqvcqA=
X-Google-Smtp-Source: AGHT+IHYPYsJMh2RsRfAVkjXOt90lphgAnNhr9D3532vHBttNwM8S4rv5c5Ktb9PPlYHOjt7Wh5d4Q==
X-Received: by 2002:a17:902:f712:b0:21f:35fd:1b6c with SMTP id
 d9443c01a7336-22bea4fc93emr203191195ad.45.1744659017390; 
 Mon, 14 Apr 2025 12:30:17 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd1fe6b4esm7011610b3a.0.2025.04.14.12.30.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Apr 2025 12:30:17 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Cc: Samuel Holland <samuel.holland@sifive.com>,
 Christophe Roullier <christophe.roullier@st.com>,
 Erik Schumacher <erik.schumacher@iris-sensing.com>,
 Marek Vasut <marex@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Philip Oberfichtner <pro@denx.de>, Simon Glass <sjg@chromium.org>,
 Stephen Warren <swarren@nvidia.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: [PATCH] net: dwc_eth_qos: Fix hang when freeing packet after stop
Date: Mon, 14 Apr 2025 12:30:11 -0700
Message-ID: <20250414193015.2094578-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 14 Apr 2025 23:16:49 +0200
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

If eqos_free_pkt() is called after eqos_stop(), eqos_stop_resets() will
have been called already. This may prevent accessing the MMIO space to
update the RX descriptor tail pointer, so we must skip the descriptor
maintenance logic. This is okay because the descriptors and tail pointer
will all be rewritten anyway during the next call to eqos_start().

This hang was observed after a failed TFTP transaction:

  eqos_recv(dev=000000047fb57330, flags=1):
  eqos_recv: *packetp=000000c3ffb5c080, length=151

  TFTP error: 'file <FILE> not found for <IP>' (1)
  Not retrying...
  eqos_stop(dev=000000047fb57330):
  eqos_stop: OK
  eqos_free_pkt(packet=000000c3ffb5c080, length=151)
  <HANG>

Fixes: ba4dfef1469f ("net: add driver for Synopsys Ethernet QoS device")
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 drivers/net/dwc_eth_qos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
index b4ec3614696..b9a2846b2d7 100644
--- a/drivers/net/dwc_eth_qos.c
+++ b/drivers/net/dwc_eth_qos.c
@@ -1173,7 +1173,7 @@ static int eqos_free_pkt(struct udevice *dev, uchar *packet, int length)
 
 	eqos->config->ops->eqos_inval_buffer(packet, length);
 
-	if ((eqos->rx_desc_idx & idx_mask) == idx_mask) {
+	if (eqos->started && (eqos->rx_desc_idx & idx_mask) == idx_mask) {
 		for (idx = eqos->rx_desc_idx - idx_mask;
 		     idx <= eqos->rx_desc_idx;
 		     idx++) {
-- 
2.47.2

base-commit: 739ad58dbee874a3ad3bddd116e995212a254e07
branch: up/dwmac-hang-fix
