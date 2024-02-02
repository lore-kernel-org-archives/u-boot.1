Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E825C47DB3
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 12:32:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87DE087D14;
	Fri,  2 Feb 2024 13:31:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ascXEuLV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7A988784B; Fri,  2 Feb 2024 10:44:45 +0100 (CET)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74BC48756C
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 10:44:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-5cdf76cde78so1661496a12.1
 for <u-boot@lists.denx.de>; Fri, 02 Feb 2024 01:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706867081; x=1707471881; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KWbNK5uKrC4n/Qp+LBjLBAtqjWjCTwD1r+mlRBb47hc=;
 b=ascXEuLVi/Lov1znrY2BLTqOUVOVX+vX4JZJZPHp0GMTYRqc9LcOVfyuS+Mv6oOvBT
 pGjCYDjdL+jRw8iqMHtCwiJHYMfxSQr0PWa7J37s1Y41vP4ed6SDA8oP8ILTdzp91goT
 yzrEB6gloPuw1aK3NCy4JIS1oN5pGdPWiuZx56To8vFsRuyeljymChuSMt2ZIDol6myD
 ccshzNQ91PSDpnGitJjaXBP/O6fF5CNQXsZT3NgHhitNn1h46rAb34UjizB+DRoFAr71
 qiFqeC+/nCvlRgUpUa5PfvzvjHPFG/uiEfVmL+SlMSOXYNIcQmKNyXcGXlm+jE8Z/JEx
 jOdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706867081; x=1707471881;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KWbNK5uKrC4n/Qp+LBjLBAtqjWjCTwD1r+mlRBb47hc=;
 b=s9VezPkW5wLH4axUMb/dLlTxY7SR0XZU9s9zA/rClJYdA14DheUoKupbABUlVm9BPK
 ufPZuiqg9ckS2g7pZSe8NDobBOpbxoKzZqi1ovRzg3SeJSFkNhNskSxuSM9ogGOF3rBw
 xRoRIDhZLom985A0pE7M8Q4TOFLiiJsp3vKpJnHy+wZfEInCcswcEcG3dSXKmOCSNjTL
 kx6VpUeoJmi8QMnOGORv+U8J5ljCfwDeBsX/4zvqMVR3fylzFhXkEy/3WYTch4Fi7SdO
 wNTJZJRsj4ZMtwV1bxAyXQck14VQJ8mqsIYaCXriT8AC0Cj48JkfcUOnT/98nSwO0ARv
 J/fQ==
X-Gm-Message-State: AOJu0YxRTe3D98LqhP4FmpltGy9TB0eJ8ocm7Oe+Gc7a0FwPwFgsFaoc
 LhnFeexGZRkja/GAqjwg9iZCnQ/+pDJdc61J0q8tfE/EEW195qLI5wlXNkS/kK+2eW5f
X-Google-Smtp-Source: AGHT+IElOwBIlTHtPM6/TYRCF7ye0nY3SheDTubGpGOruLdvlzPG+s4CIUEoe41xAqOuBPF99JnnWQ==
X-Received: by 2002:a05:6a20:f398:b0:19c:9a26:b958 with SMTP id
 qr24-20020a056a20f39800b0019c9a26b958mr1464500pzb.35.1706867081237; 
 Fri, 02 Feb 2024 01:44:41 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCV+bGbl30ZzP0ZcZtp2k+HuIE6cFBEBIa3J7zqVdYR/JN4COSyhUTMT7dTFDlvS+pdkccyXnGk6PggKu60AXlomm+zVcGwJW5Ph2NTa/Ma8mk/9n+InWg==
Received: from localhost.localdomain ([125.126.161.226])
 by smtp.gmail.com with ESMTPSA id
 fn27-20020a056a002fdb00b006dd8985e7c6sm1190979pfb.1.2024.02.02.01.44.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 01:44:40 -0800 (PST)
From: Kongyang Liu <seashell11234455@gmail.com>
To: u-boot@lists.denx.de
Cc: Leo <ycliang@andestech.com>, Rick Chen <rick@andestech.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/4] riscv: dts: sophgo: Add sdhci node
Date: Fri,  2 Feb 2024 17:43:35 +0800
Message-ID: <20240202094418.334221-4-seashell11234455@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240202094418.334221-1-seashell11234455@gmail.com>
References: <20240202094418.334221-1-seashell11234455@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 02 Feb 2024 13:31:24 +0100
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

Add sdhci node for cv1800b SoC.

Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
---

 arch/riscv/dts/cv1800b.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/riscv/dts/cv1800b.dtsi b/arch/riscv/dts/cv1800b.dtsi
index baf641829e..11b84b5e79 100644
--- a/arch/riscv/dts/cv1800b.dtsi
+++ b/arch/riscv/dts/cv1800b.dtsi
@@ -7,6 +7,29 @@
 
 / {
 	compatible = "sophgo,cv1800b";
+
+	sd: sdhci@4310000 {
+		compatible = "sophgo,cv1800b-sdhci";
+		reg = <0x4310000 0x1000>;
+		reg-names = "core_mem";
+		bus-width = <4>;
+		cap-sd-highspeed;
+		cap-mmc-highspeed;
+		sd-uhs-sdr12;
+		sd-uhs-sdr25;
+		sd-uhs-sdr50;
+		sd-uhs-sdr104;
+		no-sdio;
+		no-mmc;
+		no-1-8-v;
+		src-frequency = <375000000>;
+		min-frequency = <400000>;
+		max-frequency = <200000000>;
+		reset_tx_rx_phy;
+		reset-names = "sdhci";
+		pll_index = <0x6>;
+		pll_reg = <0x3002070>;
+	};
 };
 
 &plic {
-- 
2.41.0

