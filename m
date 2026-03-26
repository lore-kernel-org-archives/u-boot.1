Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB3AD10A1E7C
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 11:30:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 813C4840AB;
	Thu, 26 Mar 2026 12:29:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="uSU65Ofy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB6E781E18; Thu, 26 Mar 2026 12:29:27 +0100 (CET)
Received: from mail-dl1-x1229.google.com (mail-dl1-x1229.google.com
 [IPv6:2607:f8b0:4864:20::1229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 952FC8409B
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 12:29:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-dl1-x1229.google.com with SMTP id
 a92af1059eb24-126ea4e9694so2001968c88.1
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 04:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1774524562; x=1775129362; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7/8nekwEWqLYzJapqy2+YcLFFqMEPhV7SBHv42/NPKk=;
 b=uSU65Ofyac6EuG5scFqWmHSiA7e/fOmeKIuvxxyaJMqC6eBJEMAOH4o5SmER2HMz2A
 olpGPUNc3bES8TyQmmd5fRKR4/2KfJyPLG/GYvSzqsE359vljUOjtVnt37AKhLOJd5EN
 /G3mGMiGqB6aW8vrOyyafjzATL0bkq2NLkDm1jidMYxXLp4dq8YhsUzsdFiQCKHO4gtu
 EL+VpO4zlY71LSXTYJzxsSegKTH8KriNLexAf13g15WNAnr4IXT86g1qgq7qIEkvubsY
 i/T6VjvrF2DngavV3MI4rl3Lw0qMgihiLL6DAEDeet9WbmbPBIv+SJ2i5Yv57CyRx2NP
 ir0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774524562; x=1775129362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7/8nekwEWqLYzJapqy2+YcLFFqMEPhV7SBHv42/NPKk=;
 b=WVhgNqZNWVPSn0fzPSVDRBfd6XgyHFsVu0qCXIfp9ssysI88Q8tDefS8JgAcdQfWNm
 Uo0zXJiSqq1GAzWERJycu0kqYLDg3dTvpD/3+sGkBnciTaEy5LelHpLlei7x46ngVPzR
 upKLm/cTg83Rpe9obbEfUViz9QC0HPYqOC5CNYP68f/ZmBzJ79uZCS5Be3cYbcJuToUr
 z7NupTTdp4QuWfEeFQZ9CrGQowJJkEYOP2jLMuwwxilz0u66teYxwqdSWBFZGXpjHxks
 7RSIlGJBx72rc4QeCUFp/mAiH5a6J5/retSpB4m94T0Uu3+uBRzboJPcMTth/r3U2gSD
 J4CQ==
X-Gm-Message-State: AOJu0Yx/5TEe6gfY9GE/YDZku2QKGzTtFHjEUpIDZ5vXhNfgv0kZVA3H
 UNABfgXmIhXG9lXy5vb4ApNYSEjfvlhPBB/rWCtTEIr0TKalDr+zwoGLDRENL/p+MUdnCQ17LjE
 SAjBRYiDOBHov29Xwp9fy71MUY2LWz5gsDeu+TfljrlzTNLmlzN3Jmy7sDNxJAugfVigOb68aEW
 Tl2tNlEcrxOsGuXmwtdAPi2lLV7J57OYVJMpKKZUgVkpk=
X-Gm-Gg: ATEYQzzlrVWHaQt9Xr4Bt5sDdKw0TTIG62qyTmgEF0skWcoHCKzi4OXBQrPBtrOYQEu
 b3YSslNP/U/ClLhP4k07aepPcsoeBC50gUzz97N7swBZFgzuxZni98vBJKyRQCvB+8XBijmOek5
 Ii28QAZqov3XMWfh0EeSodDZ2PxhGGHZ/h+BJliS0dbX1XGEN9Eq03EXl/6rdBryG9dRAPtvmnZ
 1qZ24juzzzfJY4rt56vlgp9W6VRHFHanohUEEWIkY88jasfNMHQke29OTRBdbFSIIhTncxHs+4e
 HtqhDUHeDpyCUUxtIqnxr2VvyZXUp3lART8cY6j4/M82QwXORvcB0A6vuDFx5O/F9IF5lWRcowV
 QuOWGsJyOn2T5MmeYW03EAIIE0RjqejdvnRUwWRoePhP9k7wAvJk0S9aOhniA+25qfctJPbV9mr
 IDOFXRATYjOk2Y9CTLOVDDXv3OoXeGePIkFxSM2ptavnGejj7M4uLJouENvoad2O41QHM5Q113+
 vwunijJTcktPyOlBAj74yrMg7WcQh9+PlslK67+
X-Received: by 2002:a05:7022:69a:b0:11b:f056:a1b3 with SMTP id
 a92af1059eb24-12a96e5d9eamr4194146c88.11.1774524562150; 
 Thu, 26 Mar 2026 04:29:22 -0700 (PDT)
Received: from fedora (cpe-109-60-83-68.zg3.cable.xnet.hr. [109.60.83.68])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-12aa7624247sm3729221c88.11.2026.03.26.04.29.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 04:29:20 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: u-boot@lists.denx.de, trini@konsulko.com, lukma@denx.de, hs@nabladev.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, gregory.clement@bootlin.com,
 lars.povlsen@microchip.com, horatiu.vultur@microchip.com,
 jerome.forissier@arm.com, marex@denx.de, daniel.machon@microchip.com
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 10/14] usb: dwc3-generic: add support for Microchip LAN969x
Date: Thu, 26 Mar 2026 12:26:51 +0100
Message-ID: <20260326112830.313874-10-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326112830.313874-1-robert.marko@sartura.hr>
References: <20260326112830.313874-1-robert.marko@sartura.hr>
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

Add Microchip LAN969x support, by using rk_ops as LAN969x uses single
node to describe glue and ctrl.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/usb/dwc3/dwc3-generic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
index 22b9ef0b24e..f0506be46c0 100644
--- a/drivers/usb/dwc3/dwc3-generic.c
+++ b/drivers/usb/dwc3/dwc3-generic.c
@@ -731,6 +731,7 @@ static const struct udevice_id dwc3_glue_ids[] = {
 	{ .compatible = "intel,tangier-dwc3" },
 	{ .compatible = "samsung,exynos7870-dwusb3" },
 	{ .compatible = "samsung,exynos850-dwusb3" },
+	{ .compatible = "microchip,lan9691-dwc3", .data = (ulong)&rk_ops },
 	{ }
 };
 
-- 
2.53.0

