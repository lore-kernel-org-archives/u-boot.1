Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A28AC4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 17:27:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07E7E8869A;
	Thu, 18 Apr 2024 19:26:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mR+yLjzn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8EE9886AD; Thu, 18 Apr 2024 19:26:30 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E487188693
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 19:26:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-34782453ffdso1091193f8f.1
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 10:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713461188; x=1714065988; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ysUkJvznPlkaXDP3wq0WHW9sRVz3WIX/KBxeJN26Cj4=;
 b=mR+yLjzngSikE1JnznZ+MD6Xu9B+jg5AU0YCN4adoDzeQ1F2rV76zIFVPOxMaOUNb8
 +tC0xzTQyNUn8dFwTBkJXDabA7BypGTrGFLph3GK7fcTDkH7criVzDPYOrXGcRJATrRg
 WDi17b+OvnKqD9htO/ve7QClxdu7mamZTB4ArZXeGXqe4YiQUjV87A6DuW47jIp9Cf0N
 0rXsSa5mGTOTigKtrBuabrA0fVinahOpjVTzQPonuLayu+rJVC0jjbHnDhNt0neP7amf
 ZLh+0YzvqyZfXtIkUG58ZeTRY9EPNvG72PD38otYrVtZxHIo7yWWzNqTGSKQzGLF0xET
 P2yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713461188; x=1714065988;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ysUkJvznPlkaXDP3wq0WHW9sRVz3WIX/KBxeJN26Cj4=;
 b=RbqPEu0af+SA36FM6k0Dfal5goVBmJppLBqaLwqmGRenpuMKuSqNiHH62i6fhg2obX
 vzBSAvDJH7yKtT20zITbzCnkjP679kpnJc1qAa58kplPeprPMfP4MUhADceyIqGsU4Qm
 OTQhz5b6EW+Raow7/EGk0CC9ars13/TS26igtAql0uBAM0LcgjINR747ELWm7TjpNQpk
 khsWum+/OUy9/o+3ufQ9d2dnZEwTrf2yy6zcnNtXEV30rKO6kLul/vAu+Aobf5BwrAkJ
 nspqZ2MBAyOWHQNBIs3hYEEkmWC1Yh7cYJrZ753wjOp7wvi7ApgvjsoZhoL1etbucmOo
 lQLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIy7KnCwTGMpGcpLnn8rXkiYIipEyPANwSeRnljaG2OythkrTd27Crb6i19bkmNB1Rxmje/ENac3c6HUT7SyHUbei18w==
X-Gm-Message-State: AOJu0YwtkzurQWqcMEMSoCYQB2Vu5D1Kw7m4a8K0mw79csVMcXmNrswX
 TJt3clsgjUejpLS/3DKLM2zlnxhqzsq44taGOrH7jMcBGHYA1gJp7vKP0wVfJ3E=
X-Google-Smtp-Source: AGHT+IEydRrE9TlMXbtRh+Chhfgxk1d3ggz9dRk9iUdYtjQE6BBN4RyDUgSRFQMEGFJPfOpJr3pq+g==
X-Received: by 2002:a05:6000:70c:b0:34a:2a8f:db18 with SMTP id
 bs12-20020a056000070c00b0034a2a8fdb18mr1784451wrb.7.1713461188421; 
 Thu, 18 Apr 2024 10:26:28 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 u17-20020a05600c19d100b00416b163e52bsm7166057wmq.14.2024.04.18.10.26.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Apr 2024 10:26:27 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 18 Apr 2024 18:25:48 +0100
Subject: [PATCH 5/9] arm: dts: qrb4210-rb2-u-boot: add u-boot fixups
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240418-b4-qcom-rbx-fixes-v1-5-f5f19d52969e@linaro.org>
References: <20240418-b4-qcom-rbx-fixes-v1-0-f5f19d52969e@linaro.org>
In-Reply-To: <20240418-b4-qcom-rbx-fixes-v1-0-f5f19d52969e@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=589;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=sEeuLcHn4o6Fr54349Q/wHpTGLmNF2RBFRknZhKdS9s=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhjTF8H0WOrcajt3tZ7kwefNhn0szG71rRSZnzb0qcvXJz
 xUci+X1O0pZGAQ5GGTFFFnETyyzbFp72V5j+4ILMHNYmUCGMHBxCsBETk1k+MNzRuFOm6TlUotj
 inzcCd8/CV3jLm7VPDbztJS0+U5+JmGGf6ov8k/96L57YqmQsMkqhpqVD4UyBBkm3W88ZpBXzyw
 VHwcA
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Add a fixup to force dr_mode to host for U-Boot.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/dts/qrb4210-rb2-u-boot.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/dts/qrb4210-rb2-u-boot.dtsi b/arch/arm/dts/qrb4210-rb2-u-boot.dtsi
new file mode 100644
index 000000000000..7d1375f38c44
--- /dev/null
+++ b/arch/arm/dts/qrb4210-rb2-u-boot.dtsi
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* This is usually OTG but U-Boot doesn't support that properly */
+&usb_dwc3 {
+	dr_mode = "host";
+};

-- 
2.44.0

