Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF8D7C44501
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 14:35:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53C0384CDC;
	Wed, 15 Jul 2026 16:34:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="Z8bNxUOP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01E8984AAE; Wed, 15 Jul 2026 15:37:15 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1830784A12
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 15:37:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c1671ec8692so154354066b.0
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 06:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1784122632; x=1784727432; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=48xawhx64iRX0SokXJV5N13V8IU+RPdJHUOEtKJxrtc=;
 b=Z8bNxUOPA3HhOAe1ZFlR9jeXV91kWcQ90gJuoLlhOYFmZXqwf8cyaFuKK31uA3wKL5
 8Wb0vT9QSOzRBXRW5t+mar4QRQPGP01gxdnqnNkQNwFSBiNhTsANV1cyqIO4SSo8+XsH
 g5QGrNXbqIvGYFoLv6oeMLfUQhy/aU8zXYstJMDhGXGdV8ZUrPaRTHsuWf7yay/NVyBw
 XWyniaRuZCyKBgmRuadooCXEnCX+Wm0jHSLWQQlaUXI1Kpuu2OqPTIDlDUomlkArfQXS
 jhOEO0u4gd2JCNJq8HFtHtfLw62/C4W0rj3763ROmPu4ZldT97gEQl1bLIbAtYP5nhJg
 kNew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784122632; x=1784727432;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=48xawhx64iRX0SokXJV5N13V8IU+RPdJHUOEtKJxrtc=;
 b=a+CiLHAcODnlANMlwrrDk+D/IeBTHjhxrjVXgALivT+bxk4jLPyBnKzm0DgeDEor7Y
 Y4yKeWh1XNWuvnPz60ifxoMRhAMpPtyOvtEt+KQYpc81PCeD+/dIdfbQkgaoalRC4zTr
 s9KLqxkhdS+/F/fihgagZe8oWIqt9L++o6XhsqYxcoM4yjxXxyoL+M32GQmnJm7KVbx3
 EKDQCHILQToqRDXyPtOlZHQJr85EeHjkHnZyANtMudEAE/WBGJPGtLJ/WjB8x7Pbwu0e
 mg64NhbSSpuITGM30hrkX481LkglVTzlOSkfEb0dIYcbtmXVyPUzRVRrZpQZAZeaeen1
 EQMA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpvuiP4nEhtXo5RHoZWwW0sIGrmkYd618Cg7lxiNxcuOmHv+MPce1sv58Ce7tbkk7005eYq3gQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yy0lORFOrKMsKuzQ97e50fS4oUR/xABjd2ok50/PV4sdzrFloxF
 HIlvnwsb0cg/twLnwNthI4fRkK2VGmAPSBdiZQyVt3d17wzZgnT2tLKpMV+7lSBn0c8=
X-Gm-Gg: AfdE7cldyxsVKY/3pFCz1yx6n7aHae25QSpAXPSdiu6F5kW88E70Shmqtuk9UlzbnZK
 A3Dp0DZxAoDFFspLXgcAptNHtYyhj3NLBBF3q6wF676zSckLNE520vf2/s5SBBdUbSSr8YTISlf
 29TalB0ToBmXSbFOFvk1hYrKDHJUO878+KY84wEBY5pM/UT59gFKmMyriP984OS+Cby/7gmCVWu
 mm6jItdyxo3645pk2/Hz5J8FX4wA5zmmCZw83nweAFVTBU62s1FRggups8E+TYUF0WKltk754Nm
 ekjHBpaauR6wFk2SkgngvMlyoJBfmiFAcbq8D6Q/5CErWFJFyKrvYi5M3HDRdCrwzDzrShLOOu7
 5okpH8bNwoIPJXDdUjMygZTSjPYfCw0hCRpRrq2ZzZVj1f81C0llI5uPAC9dL51aW1VUXGRT8iF
 zFQEAARj4HYJj3GXmqMv6h8Kd+HkqLdgPMwm42PXklz4OzoF/YKUcCybCe/uEmRGL3JW4=
X-Received: by 2002:a17:907:6d14:b0:c16:4df6:176b with SMTP id
 a640c23a62f3a-c1679187965mr219104866b.20.1784122632447; 
 Wed, 15 Jul 2026 06:37:12 -0700 (PDT)
Received: from [172.16.240.102] (144-178-202-142.static.ef-service.nl.
 [144.178.202.142]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c16871962cesm29896166b.25.2026.07.15.06.37.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 06:37:12 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 15 Jul 2026 15:37:10 +0200
Subject: [PATCH 4/4] phy: phy-qcom-qusb2: Add MSM8953 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-qusb2-msm8953-v1-4-b6e638599e02@fairphone.com>
References: <20260715-qusb2-msm8953-v1-0-b6e638599e02@fairphone.com>
In-Reply-To: <20260715-qusb2-msm8953-v1-0-b6e638599e02@fairphone.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 David Lechner <dlechner@baylibre.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784122629; l=756;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=o5Ozbq1LR/jWoKhXo6KR7lbaGWGKrWy5z2jrP/QIAEY=;
 b=kkuri/Uz7GKff9o/m/hLW2iHIuwUK8wYZR9PTI1lagGDFgmU4ZOF7FzljhReIsfwbBrdcquQP
 3PbGqWMMbJNCmpCh+U4v8AIf/LWsoDJdEKnlbaI1lo26CRT+4fAWHFe
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Mailman-Approved-At: Wed, 15 Jul 2026 16:34:36 +0200
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

The MSM8953 SoC can reuse the MSM8996 config, just like in Linux.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/phy/qcom/phy-qcom-qusb2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/phy/qcom/phy-qcom-qusb2.c b/drivers/phy/qcom/phy-qcom-qusb2.c
index 01e64542c89..783122fe6cf 100644
--- a/drivers/phy/qcom/phy-qcom-qusb2.c
+++ b/drivers/phy/qcom/phy-qcom-qusb2.c
@@ -535,6 +535,8 @@ static struct phy_ops qusb2phy_ops = {
 };
 
 static const struct udevice_id qusb2phy_ids[] = {
+	{ .compatible = "qcom,msm8953-qusb2-phy",
+	  .data = (ulong)&msm8996_phy_cfg },
 	{ .compatible = "qcom,msm8996-qusb2-phy",
 	  .data = (ulong)&msm8996_phy_cfg },
 	{ .compatible = "qcom,qusb2-phy" },

-- 
2.55.0

