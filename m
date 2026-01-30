Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B913CE6BF20
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 15:41:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0EEE844F9;
	Fri, 30 Jan 2026 16:40:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="j3PMSqND";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7A4A83C30; Fri, 30 Jan 2026 16:39:41 +0100 (CET)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E0A684073
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 16:39:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=george.mccollister@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-45c889aba0dso1879218b6e.0
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 07:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769787578; x=1770392378; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ou31N2bIYACjItqJcEW75pMzIlhBo5xV5AC1nz57qYc=;
 b=j3PMSqNDAPk4MMF3l8FkVHTgruMScDvj9R0SprBYXbvSI1Q4fNnxyg6TIgOv82iVNW
 Ho//i+SKy5UFmRzsfHFEFZVoiXe/0klxe67e2Ida0qo66GlwFX3gEh+f5hHsGVW+lqPE
 Xfk+6lOn4ZK8HMgBSgVGZ47aiYmT+hn8wjiuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769787578; x=1770392378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ou31N2bIYACjItqJcEW75pMzIlhBo5xV5AC1nz57qYc=;
 b=WOa66F1xg+T+Ck/gzM1nTq4a/dcN7SyxUXJXbNN8oVYV1ypWdNfAlO5O0WuuVeey0q
 074JFZghcynkO0ccZlP73ilFycghh3ZhPlNIQQBAiDjFdBWdtd7Q/YrTCOs4MtawHMcL
 GobmPBdPoN4bGFl9AF7bNe5U9WwEawMl/ySV5lxqklWGwOq9Dyw7eCB7w5BfDM5Eati3
 dUkOi3soJkr0Tu1/h2twttp6VmmtOR05dtH56vH11XzuPQPr9gD1Q01xK7BjeWWUZlNN
 lR2iBKBBhOHJ9fDZTU+7Ygws1Plz1fAyGayC04FRUwam8JNa8r6MGWZI9nVDOAjDpwIw
 SS9A==
X-Gm-Message-State: AOJu0YzWfCzW0qhChGhWh1AiahEB4//bXt3SCelhD5vt7Fm/ru6mik8f
 xwLHcvSMvM2e6zFwbAMRhni1vDdhGCu14Linyhu3rmhUZKIr+Yz0mdbaT+qg6IYVx2R8/LRmgBP
 Uq5Ag
X-Gm-Gg: AZuq6aJjqxanAkNvtrRHUJBwph2Bk6icB2ffYFYEixFsLeEhKZrpFBOuoN4dcv+gQUd
 TDb4zZkXw0qHZ+QO2Lfnb71TnTRT88Q2Rsm742OqFml3NnFBOOq5bRcSwuwrAp789jSXSj7XOHh
 A85ELgB7lfkX6hdem1pdetWJvuXJG3TMm+47R2eac9+63SvLd65kXiyLtaKR0ozOFCqWYU1WRW2
 gpg54754Qf5dDNRowVJmhh9tstsbLSbAZl1PEJtCmOHKrbEIeqUSepAvqTk42J9xhMUqNY6dNv1
 SLHw8vnjzzQneBZazBaFla2VJxircadadIiOwWTtGPMwTGFfHv6bkHMlLB+wZo4UXThIKWy8/Cp
 5eAmVHh2neJDQAacCnpTJuYKBO20EBsDYDZmpDSvNRSoQji5TX+jowO/pG+yoRzS0OB6Yw5o8Qw
 uIof58d0nG3dA+16BaG302LNit0ounUs02AUbOsERLAvYMdw==
X-Received: by 2002:a05:6808:f8a:b0:45a:7084:cbd3 with SMTP id
 5614622812f47-45f1e2b88d0mr3557837b6e.15.1769787577785; 
 Fri, 30 Jan 2026 07:39:37 -0800 (PST)
Received: from ryzen.localdomain ([136.33.243.183])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4095752ef7bsm5944934fac.16.2026.01.30.07.39.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jan 2026 07:39:37 -0800 (PST)
From: George McCollister <george.mccollister@konsulko.com>
To: u-boot@lists.denx.de
Cc: Bryan Brattlof <bb@ti.com>,
 George McCollister <george.mccollister@konsulko.com>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 5/6] pci: pcie_cdns_ti: Add PCIe support for J722S SoC
Date: Fri, 30 Jan 2026 09:38:05 -0600
Message-ID: <20260130153856.2049575-6-george.mccollister@konsulko.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130153856.2049575-1-george.mccollister@konsulko.com>
References: <20260130153856.2049575-1-george.mccollister@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 30 Jan 2026 16:40:08 +0100
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

TI's J722S SoC has one instance of PCIe namely PCIe0 which is a Gen3
single lane PCIe controller. Add support for the "ti,j722s-pcie-host"
compatible specific to J722S SoC.

Based on:
https://lore.kernel.org/all/20240524092349.158443-1-s-vadapalli@ti.com/

Signed-off-by: George McCollister <george.mccollister@konsulko.com>
Tested-by: Bryan Brattlof <bb@ti.com>
---

(no changes since v1)

 drivers/pci/pcie_cdns_ti.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/pcie_cdns_ti.c b/drivers/pci/pcie_cdns_ti.c
index ff56ba3930c6..38804f1c09c7 100644
--- a/drivers/pci/pcie_cdns_ti.c
+++ b/drivers/pci/pcie_cdns_ti.c
@@ -855,6 +855,11 @@ static const struct pcie_cdns_ti_data am64_pcie_rc_data = {
 	.max_lanes = 1,
 };
 
+static const struct pcie_cdns_ti_data j722s_pcie_rc_data = {
+	.mode = PCIE_MODE_RC,
+	.max_lanes = 1,
+};
+
 static const struct udevice_id pcie_cdns_ti_ids[] = {
 	{
 		.compatible = "ti,j7200-pcie-host",
@@ -864,6 +869,10 @@ static const struct udevice_id pcie_cdns_ti_ids[] = {
 		.compatible = "ti,am64-pcie-host",
 		.data = (ulong)&am64_pcie_rc_data,
 	},
+	{
+		.compatible = "ti,j722s-pcie-host",
+		.data = (ulong)&j722s_pcie_rc_data,
+	},
 	{},
 };
 
-- 
2.52.0

