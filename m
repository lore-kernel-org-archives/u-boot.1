Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83A04103E18F
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 14:45:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 629D284101;
	Wed, 18 Mar 2026 15:44:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="QANQTH60";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3088184142; Wed, 18 Mar 2026 13:47:06 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 478D98422F
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 13:47:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b980785a0bfso57505566b.3
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 05:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1773838022; x=1774442822; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5djuh3PDQ/u+e6jGr3na3275o3z+bhSlgRAUtQdYa9M=;
 b=QANQTH60gfEFEpTSZhMqKsY4nWUAURBKybhP6+A34ZvrWOxNxsAPBsj6l6xaTweAc/
 iAoQ3K3/PU0mop0l7qMzVExz9aOVOkMBF5dOVOQnp7odL0KAIeZ8chyh9bPPeJvAHdct
 t3LQQC6NVylI6yaWPribRV6QEPgbc6hguL43a+X9g3vmsjL7WMvPW04Jen5KM60EBMMD
 UJWCc4ZuxDaenjlsUyAYmW/t3FAF9p2pwr2a8k3OyTlEJPI5GX0/mKC2xeZNT/1jkJuC
 0+dvKT8PMkzFfga3rOaBRBD0DdytOHSAc51IsYPyVQ619LG2k/TMljDoa9v26yibjySQ
 o4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773838022; x=1774442822;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5djuh3PDQ/u+e6jGr3na3275o3z+bhSlgRAUtQdYa9M=;
 b=EkXIebPRU9klO6Y3uGouZC4ZSuAY65KchIrT/N2RegnyV5zqAFO71Tr3yhPFHc0T57
 uGFsu7DOXQe2a7iTfqYQ5UtTYcxQztMNNb4pZNdIb5SfdmQEb0dL56aPtWJTzioJMAdA
 tFy3FyffhfXsk37r5OzMsetR9MSXVFz2jo0B2J2POB7Bm6MAx6sEpsDDjfKQbgUS0ADY
 avSikd+1Lgbd4rkydDNzlVSjpP7XdbQg/KOiCVrciInArOEXHbMpTC4zkw1t/Yq4DCPl
 h2UbxUScr5xlPhMHVJn2o92ztZJDZi/tnjQ+h0rzFaRSv9hFXGxJfywR77Ga3BNmsNwB
 E+Qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVE0hZFIrX7dqBJs1eT5X7wHw9ioOqTYcXZBYJPdm7nhxypEeyswyYU9+0rxYn9FPVnWtkgKJ8=@lists.denx.de
X-Gm-Message-State: AOJu0Yy4RWbEDXTUQekHlF13nLI4/bcQG89n847KxcEYvWW6jZYI+EZK
 vXG2rORhpnZgfWSEia934aS5Av0h5BNPzUuXNUKX1giHBUhG/t5dP+0FGSQg0FLS9bQ=
X-Gm-Gg: ATEYQzxlgPhKalil3Unp/mCnEu6CUDWM5w7W+qVnr4MP6Aq132benqsyjJevIcbE0FB
 ly3o1nb8ScMLvTDghEn7/KAE50AxT/pFZ0MD3vuBsBk70b9q//FCJYIPL+Y12ShD+ykna0v2hOg
 hjW0vIh1CBFgyjLd3UL+FdyiFwhwy7ngUfmno1M9KteVv73sA2GjJCnCpLaZ/gGuNs4a3P5Yl63
 rkAHDIdxuGFRT6tic2d/QTnLF8fFYXuBu3Iq5O2iwdKxTZXbvuCkpps/uz6XXjeZbiuq4wBwIG4
 uGev6Ou/zlWakvwM4BMBa7giG3azseU7cVulsaSFyQnfZFB3DVf7QH80mgaD2I9UN6osDJMWMXS
 LtLYu7wLxkc8M7SY8MGIcla8SImvbgrC1gcM8vDW5f6rPhCjCYJ8YiLJPFETRaq5UQphISBFUeR
 MzeUFEjPbpOPhhVagOnh6qn/eCrkWd6/t1i2AZQQL5FIE9WHJ2oBEJl4eanaGVDElZPmcPZuvtx
 jM9pw==
X-Received: by 2002:a17:906:c145:b0:b94:19e5:5c46 with SMTP id
 a640c23a62f3a-b97f4344cb5mr204684966b.0.1773838022223; 
 Wed, 18 Mar 2026 05:47:02 -0700 (PDT)
Received: from [172.16.220.101] (144-178-202-139.static.ef-service.nl.
 [144.178.202.139]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b97f142cf16sm206080366b.20.2026.03.18.05.47.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 05:47:01 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 18 Mar 2026 13:46:33 +0100
Subject: [PATCH v2 7/7] board/qualcomm: add debug config fragment for Milos
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260318-milos-bringup-v2-7-650b91dd75d8@fairphone.com>
References: <20260318-milos-bringup-v2-0-650b91dd75d8@fairphone.com>
In-Reply-To: <20260318-milos-bringup-v2-0-650b91dd75d8@fairphone.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Danila Tikhonov <danila@jiaxyga.com>, 
 David Wronek <david.wronek@mainlining.org>, 
 Alexey Minnekhanov <alexeymin@postmarketos.org>, 
 Lukasz Majewski <lukma@denx.de>, Aelin Reidel <aelin@mainlining.org>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Rui Miguel Silva <rui.silva@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Sam Day <me@samcday.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773838014; l=631;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=c3nAmCc1r4SL0J4u/rIfX0YmicXWAU0dTqZz8N4Rg2M=;
 b=aW8+mI5nrmVWM229gbCT4YC8AeixytknXnA7qnA4ZR87W7AZ98bqi3efqW9QxAL3fbD8p7ILd
 ytHYBaHB5GOBGaPS1MgErClr7ERQOeXs2Uehs6JtHuSSOAof9LgTJcL
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Mailman-Approved-At: Wed, 18 Mar 2026 15:44:14 +0100
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

Add a fragment similar to others to enable earlycon.

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 board/qualcomm/debug-milos.config | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/board/qualcomm/debug-milos.config b/board/qualcomm/debug-milos.config
new file mode 100644
index 00000000000..a4cdd13f226
--- /dev/null
+++ b/board/qualcomm/debug-milos.config
@@ -0,0 +1,5 @@
+CONFIG_DEBUG_UART=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_DEBUG_UART_BASE=0xa94000
+CONFIG_DEBUG_UART_MSM_GENI=y
+CONFIG_DEBUG_UART_CLOCK=14745600

-- 
2.53.0

