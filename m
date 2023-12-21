Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A69C35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 14:25:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CC2E8775F;
	Thu, 21 Dec 2023 15:24:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KtgC42ue";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 742CF87863; Thu, 21 Dec 2023 15:24:45 +0100 (CET)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 752B887845
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 15:24:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsankouski@gmail.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-50e64eb3bc7so128034e87.0
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 06:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703168681; x=1703773481; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pqPwzW2pdcrwF/XRGBsDjhf23ajnajiHe05Gy1y9Trs=;
 b=KtgC42ueYj/x7I8jj4C2lEPa+WJPeWRP3+3+2SZsCpcMn87nlYEsBTyZEldSfOmJ7X
 VLq9SvzHbg+ihEFz1sHebZZPcalpYhONotbKqzEqn4VmiUi3eOPiThzYTm3D0sJpxmAl
 5FndYZEdJV4fCULdDELBpUfqfXtbzWg42TnM1rL2is6v+t93uAfGpKYr66FurUVwwZXD
 Clss0beGJv1M/eAoZLrKLchePha6fOiVuLxGVyn3P/steFp8OxGg1bRmXSBytTRcEQKN
 K5WttDA7D3RdwnTAzYppRx3Ydp8/v1q2gm7SqT+w/W88kjTH3VgAMVOzcTNv2XKwoHpg
 0yjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703168681; x=1703773481;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pqPwzW2pdcrwF/XRGBsDjhf23ajnajiHe05Gy1y9Trs=;
 b=PAbu4tkXVMVjbXJqThgS2sMCXA6r0QYxW5MZEsJ78CySSQ8CyRItngy5u4WBWtPFrV
 bGDv0lXIGxevY4NQFzcqPOvhoEcRSjnitj3nc4Z/EVJhWrP0t8S6gnieWoD6hJFjISfX
 3Ldy/RLJn1CCnIjm76Wv8cMtPdv2ZyXzXIqM/9Yn20Dsh2In1YlOQ3oJAhMiMTkKa32l
 s0rrSzgPlQE4GaZwEcpEj+8QmPIgZwASS6EBFoj2xKUnusw7N+nVhBgWwyQWVRGMzyVm
 c6eHnH1PaUfUcEAczjMMJoNyM843aMGaaTwD9CeulZREi1LABklV8d1ChEtpLUf4Sc6u
 0KfA==
X-Gm-Message-State: AOJu0Yx8nYajI003mlz7ThdbiuI650aSkTXHelKLkktHzS1X5lNGAMrn
 zuXGa2XdcAcQDK2IFkSHhsFyJfFNstY=
X-Google-Smtp-Source: AGHT+IGYq3MARlU6SIUyod7pPVGSskUmsP3OcEUNGPJAuwwGGYo2cZugwKD5ZEYXXSg25I7k7dvdcA==
X-Received: by 2002:a05:6512:20c1:b0:50e:588b:1f9a with SMTP id
 u1-20020a05651220c100b0050e588b1f9amr527182lfr.34.1703168681084; 
 Thu, 21 Dec 2023 06:24:41 -0800 (PST)
Received: from debian.localdomain ([37.45.245.217])
 by smtp.googlemail.com with ESMTPSA id
 q17-20020ac25fd1000000b0050e3719148fsm280653lfg.235.2023.12.21.06.24.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 06:24:40 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
To: u-boot@lists.denx.de
Cc: Dzmitry Sankouski <dsankouski@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Subject: [PATCH 2/4] arm: dts: starqltechn: add ufs support
Date: Thu, 21 Dec 2023 17:24:07 +0300
Message-Id: <20231221142409.82877-3-dsankouski@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231221142409.82877-1-dsankouski@gmail.com>
References: <20231221142409.82877-1-dsankouski@gmail.com>
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

Add ufs storage support.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>

Cc: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Dzmitry Sankouski <dsankouski@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
---

 arch/arm/dts/starqltechn.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/dts/starqltechn.dts b/arch/arm/dts/starqltechn.dts
index e6d57d2668..5bb1a7f90a 100644
--- a/arch/arm/dts/starqltechn.dts
+++ b/arch/arm/dts/starqltechn.dts
@@ -54,3 +54,11 @@
 &uart9 {
 	status = "okay";
 };
+
+&ufs_mem_hc {
+	status = "okay";
+};
+
+&ufs_mem_phy {
+	status = "okay";
+};
-- 
2.39.2

