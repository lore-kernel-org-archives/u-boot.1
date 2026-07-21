Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8340FC44529
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 08:42:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3869980DDA;
	Tue, 21 Jul 2026 08:42:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0YPvh19fgzR9; Tue, 21 Jul 2026 08:42:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4B39880E13
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784623365;
	bh=1P9JxUm7QFfk36bkgo/nSZZPOeLOVMX4i1UxGo6LQiE=;
	h=Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=sek5jDZ/8Q5bg8NrIbKtbB53zGZ1wY81QyPv5oUDgk0VaZgaAkgcbtHNyxBjCMChm
	 A+scew/NQx1lYcScWVd7xn02iRqB5pcAMLLNKp5xx6o8RJLv6M6/DZAl9oyoLeqj7j
	 6f/XiFJCxCtUSwNYyLYrmaohzXuR4BKDqOkVZLHD8sGHb2eN26T1GaBRYQkmHdkzNH
	 RzNZ2UYUA+HyxEVtxrTesbaE8RALFXLrjC+5yjsDSRpvkUN0+pAzwG5yFAWaZ+YT7V
	 9VEMr+nQcu45FlHx7UDIPToocnPYFWW2txNIA4j/28oFWiut85KgSjYciFOV3sN/eY
	 mWKsN5UgAqCfg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4B39880E13;
	Tue, 21 Jul 2026 08:42:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7F4F51099
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 08:28:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 650FC4084E
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 08:28:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 728JBqcyv5Vd for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 08:28:22 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=william.bright@imd-tec.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 27FBD40844
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 27FBD40844
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 27FBD40844
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 08:28:22 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F936803F6; Tue, 21 Jul 2026 10:28:20 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5756482991
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 10:28:18 +0200 (CEST)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4954a32cf1eso16251785e9.3
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 01:28:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784622498; x=1785227298;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=1P9JxUm7QFfk36bkgo/nSZZPOeLOVMX4i1UxGo6LQiE=;
 b=Bd4KDKPQotOuQLDdAsZkmUFdL7uhIFKdxOeyEIxBb0QGuwaj8qXTwbcF4PeP9bvSIi
 CsaUAaN3uTT5Fx6JnAm2A1/rJr+TBY63SM099HK33tTIgl5iqWJJEZYEXc/dayLWeFjj
 ttXAtXBulFKlLkod3CqIxHpoRplbYV8AJQlL8L3kaxUkSvsoHF7+4chzGVtbvRvHkJKB
 IYYQnaRupsAXqS+rN1LE5dvBXfSZfBMW6RZheJvkrgkzulnAfKBm/h+DLkgPn0IAfKYN
 BCXWaLQ/rVylGUsJB4h9XkCtiGwzsbxIoblc59TOn4+SvOdLFUF1jJbAWZA/SoKnRdEJ
 +DDw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrt+JN8ptIA1WvS3okPK/p5niLa7voSzWCPNKFil1kNrC5RXY5RmnCOxC4lJoaJ30MvmtdESjw=@lists.denx.de
X-Gm-Message-State: AOJu0YxgQ9vCX8Bvuyvk9MaC2y2Ep0IT3b71EHDeXANX2p54b4NL84ts
 +W2GdTX9g3vFPZ9VRnSpOlfezAOE6UmPg3u65hYYR2lOZPguooxQz6XuUv09LhhM/T8=
X-Gm-Gg: AfdE7cnpwfeAZddw9+aIq3h2dvlN0/Q3sbtc1pqnHomzm2rNXeZkruVWlnA3Vnki8jD
 I6swafyM1js0ziPaEiEJ6zA60TzoAzYKUv3MZwTMrRcoQ2cgDk6wvY7JQhu60k6loMDbGAwJ17t
 IEHBmpyQqHDsGLdij5J5g1NRbaGPCy5NFFrTJGPUz9swnpyLmyOJcPrJm2OtKa4ixWQuuTXtC1S
 mWI2rpicBQ7P/BDPxpdctayEox8w7QzOVgUGta/Cm/aelgN0KGYopa4XW0DhsAxJMqvPLTT3fmv
 g+8th8/ozBNIImM8HDJkGxSBvUkS6fZ/RU/6Jw6MhpsXPIptfSOZ0G/jQZadLpGUyIiIAiTSMMx
 kXS5Se0IiDq0T24jjjJuDjv3dGbFUGcQYe9BxR53EZOplergVH3zWmadz6g8L1nPv7Ro23gXdvU
 gyyRIpzpyfc/P31j/L8MI4qAeKK2DawoJPH/AIsWONuuooEqNpuUEjB662Or+T6R4dkxDD83JXB
 O8=
X-Received: by 2002:a05:600c:190b:b0:495:4d35:5eab with SMTP id
 5b1f17b1804b1-4954d5a2d76mr169766995e9.24.1784622497776; 
 Tue, 21 Jul 2026 01:28:17 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:23c6:272d:c801:b15c:980c:616e:f2b0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956546de4fsm51876455e9.1.2026.07.21.01.28.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 01:28:17 -0700 (PDT)
Date: Tue, 21 Jul 2026 09:28:08 +0100
Subject: [PATCH] clk: sm8550: Add GCC_CFG_NOC_USB3_PRIM_AXI_CLK support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-sm8550-fastboot-clk-v1-1-657a239e3ccc@imd-tec.com>
X-B4-Tracking: v=1; b=H4sIAJctX2oC/x3MSQqAMAxA0atI1gZqpCpeRVw4pBocKo2IIN7d4
 vIt/n9AOQgr1MkDgS9R8XtEliYwzN0+McoYDWSoMCUZ1K2y1qDr9Oy9P3FYF6wKdhmxzWlkiOU
 R2Mn9X5v2fT/2UDEFZQAAAA==
X-Change-ID: 20260720-sm8550-fastboot-clk-86ef12e532de
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 William Bright <william.bright@imd-tec.com>
X-Mailer: b4 0.15.2
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 21 Jul 2026 08:42:44 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=imd-tec.com; s=google; t=1784622498; x=1785227298; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1P9JxUm7QFfk36bkgo/nSZZPOeLOVMX4i1UxGo6LQiE=;
 b=dInbrHRiWnM8nGaWtAq5w8qZBw9OxEPMtwJ+F4G5LdpAvipyvJi8/23CWo1ikE3SD+
 tCOT8gRIj7aLyesz+Jw9LQV37xHN8Dkv1wNz0O0LyLiebbDSY5QJKU2LL2LFp02FJFJ3
 8ERk/uCXvTLGLgmO1zVTJnpVtTWzFFIXptAJ2CYYIuBaNOFAPB6F6CYW/PEQWh/4pmkR
 6gBR6eWdKk3CU3Oy2wTHBJ3/wbAqbq4r0S5cjj8GpA7xj7ws15I9nHqqp037ahjAFBWT
 +Fli2vF2TGiwcAiCFYe3Dc99P4wvTKNQ0xFsLGjo7IcjMr3GayhEAew5RFtQi9g3buzK
 Ws7A==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=imd-tec.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=imd-tec.com header.i=@imd-tec.com header.a=rsa-sha256
 header.s=google header.b=dInbrHRi
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=imd-tec.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=william.bright@imd-tec.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=imd-tec.com header.i=@imd-tec.com header.b="dInbrHRi"; 
 dkim-atps=neutral
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
From: William Bright via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: William Bright <william.bright@imd-tec.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

GCC_CFG_NOC_USB3_PRIM_AXI_CLK is missing and is required for usb_1. The
missing clock entry was ported from the upstream Linux sm8550 clock
driver.

Link: https://github.com/torvalds/linux/blob/b95f03f04d475aa6719d15a636ddf32222d55657/drivers/clk/qcom/gcc-sm8550.c#L1346

Signed-off-by: William Bright <william.bright@imd-tec.com>
---
The following warning logs were being printed when starting fastboot on
the sm8550-hdk:
  fastboot 0
  gcc@0x100000: unknown clock ID 11!
  gcc@0x100000: unknown clock ID 11!
  No USB device found
  USB init failed: -19

I found that there was a missing clock entry for
GCC_CFG_NOC_USB3_PRIM_AXI_CLK which I have ported from upstream linux.
---
 drivers/clk/qcom/clock-sm8550.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/clock-sm8550.c b/drivers/clk/qcom/clock-sm8550.c
index 7c06489b9c4..3d5a410ba33 100644
--- a/drivers/clk/qcom/clock-sm8550.c
+++ b/drivers/clk/qcom/clock-sm8550.c
@@ -122,6 +122,7 @@ static const struct gate_clk sm8550_clks[] = {
 	GATE_CLK(GCC_AGGRE_UFS_PHY_AXI_CLK,		0x770e4, BIT(0)),
 	GATE_CLK(GCC_AGGRE_UFS_PHY_AXI_HW_CTL_CLK,	0x770e4, BIT(1)),
 	GATE_CLK(GCC_AGGRE_USB3_PRIM_AXI_CLK,		0x3908c, BIT(0)),
+	GATE_CLK(GCC_CFG_NOC_USB3_PRIM_AXI_CLK,		0x39088, BIT(0)),
 	GATE_CLK(GCC_CNOC_PCIE_SF_AXI_CLK,		0x52008, BIT(6)),
 	GATE_CLK(GCC_DDRSS_GPU_AXI_CLK,			0x71154, BIT(0)),
 	GATE_CLK(GCC_DDRSS_PCIE_SF_QTB_CLK,		0x52000, BIT(19)),

---
base-commit: 8a905a58e3b4832c4cd7dc0e8a596a6d7ce19562
change-id: 20260720-sm8550-fastboot-clk-86ef12e532de

Best regards,
--  
William Bright <william.bright@imd-tec.com>

