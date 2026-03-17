Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C685BFF6E7C
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 21:08:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38EA38409B;
	Tue, 17 Mar 2026 22:08:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BfrAMtLn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B53C5840BE; Tue, 17 Mar 2026 22:08:31 +0100 (CET)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E5EF8407E
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 22:08:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-466ebbf7ff7so2093300b6e.1
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 14:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773781708; x=1774386508;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vTO/qa+gQjcc4VWwLufLb7R/5sqsFlPeniqM7kzd2nQ=;
 b=BfrAMtLnYzwS+SntmGarY3Z8oCDag+/Rhrt0fvTeAthEh7i2rePdtVJYuB4rBPZAFL
 J6BzuR7MQqoh7wUm2zTWCLEK9eW0hC5t9bfAeaReBLyIgYFRzfLeki3VfUsrxGsXV50f
 qYd37kzMbnOF1FPrhIRLs1S3yK1hvrZItl2JvbEf+BCoQIQOX+z8YmkqMsimcKodSNfw
 tzomTVf8Tk/z9vqw5sVrpYKIbz+ChBI7jwC6R+2ct9Jm9R2pgMRBfh9kGbq0JA03uPc7
 NmtZxcIz/ZLFSqATEdwbO4QCsbzkpR/SsbHOWPp82hQVw9MFcTT39ivpNfYWAgRCBHSZ
 NQrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773781708; x=1774386508;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vTO/qa+gQjcc4VWwLufLb7R/5sqsFlPeniqM7kzd2nQ=;
 b=WdWyiNw0Mh+l3BNF7klG2ncDjrVVCUnOBxLfPw4hIlXTEDhiKbvV+7Veop6lB9CvY9
 Evnj6tira/ayRqeZGMmiSIH5LNQocFBZYcdYizo46Wt01dXbhsuYFo08Xavxle3d6nJ9
 2zVSoehmgesZQ+uAsCA9+9wvTCuu6/T9s0HAUX1J5k86GGruGnxec7oWUtxxOUQ13EyP
 QcyoUoT4VRWAlcdYFPjn5nEGF1ObvnW51Oo9VGgGjeuVAFQFUMdqJfJYw2n0FdK1oZN+
 WBiGkb5dKLT7ysGHwAfOtPSXcy2uC0QWJpCtgfaVVc1aROK2xqwGaHU+V0dPQ7viohzB
 uJyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeGsaFSBsjDNmYp2mc/clCz6JsfNccnfejNjDMslgg7BK/X+Hd6rwrLmk55qMxOVTebcvCsrY=@lists.denx.de
X-Gm-Message-State: AOJu0Yz7cTPGtk5e4l/QQRI6GUx6395+uzeLy5HEcCanOmTqc/frgGSM
 bq6VXBaVVlNHEEkYt9Foyq1oE5X+o57SZwMXshm+QbR6vX7TMFKY6pBEicXkMPpmCx8=
X-Gm-Gg: ATEYQzyxgsBX/F9VWC5uTIgz1ojk9Wb7New0b3NElocT9U/uhRfsXyzIH2SXLtv2PoZ
 HE+kLg71LTqfHuQ7BgMFy8G5/+VWfXrUkgMYkZBQ6nBx+PAP0YJV7Syz+YXK4lkjVWgCjVXqqc5
 l03l1xeJgRKAo84sUuIqE4IRJ5sTQMxJDwqIIt9UvB+K3DJPUANGluTsM8HugkRcOaQP6IHVXu6
 DxBzHogMMO8Gn4iJwb0XrgT4s2JfDzkT0Gjhnc8CCwzRSce41XMvUzI8AzdHCgyeIVI+TjEBR+j
 D1e9UCpy6qUzv6ZNyudu686xxb04ZsyRalVelusSXOWoiTj3lHwC6VYTdgqXKRu9E7BKsei5/WR
 H6Ze1mWSZi4QfsCcyQSqgUdy8ahvDGB8R90/ph/TGQfaYxvdHLTmnIWCFUPv3m3OzI4V9RLTt/7
 ADPkJw1SDqgARftu3eOqFklDfJ7r4=
X-Received: by 2002:a05:6808:17a6:b0:467:ed9:ffaf with SMTP id
 5614622812f47-467b9fcd262mr618867b6e.0.1773781708035; 
 Tue, 17 Mar 2026 14:08:28 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:6995:28aa:eeda:102])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-467ba8d309bsm378256b6e.6.2026.03.17.14.08.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 14:08:27 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Julien Masson <jmasson@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
In-Reply-To: <20260305-clk-mtk-fix-mt8188-rates-v2-1-0ce2b5212775@baylibre.com>
References: <20260305-clk-mtk-fix-mt8188-rates-v2-1-0ce2b5212775@baylibre.com>
Subject: Re: [PATCH v2] clk: mediatek: mt8188: fix CLK_TOP_CLK{13,26}M
 rates
Message-Id: <177378168788.529399.17509341539541813601.b4-ty@b4>
Date: Tue, 17 Mar 2026 16:08:07 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=334; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=8Qyb7eWuo4O2wkMVB/dUWpdSE1hvAl3Ab8oaiLndC3k=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpucLCM4FjrMe+8Pe5kEcuKaJjjGLONCVVMFcbX
 vL4EG6kuDOJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabnCwhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Av8kH/ApwkuUV2DvlznTdwAiwqt6oy1i+E7+P+1Tdjgf
 1V+VayTr8bFMCZaDfvoYSfI3Tv2S6J2pA9Pb36WMDjmzxqmo+Xr8scI59I4CcVq3dd6rOXiLXz0
 sTizSewbGt0PjTMprnQJb/tPATUYZRs1ATMPck0skjhs2PKDcfCUUKzJ/gHMnAluhjwpm8Vc1j/
 4kFnQYVfPt0CPfwzzz/gGKVc5X4VNWqxOL0OCFsGKBB68EBGUQiYGasWpF+QcNdkUbcCS8+M9Ge
 IRLTVRgQJUfbckAn+lMGeTWk8x5FG8J1NAd4zws0eyFf/HWaeQHKnXP5Tk4T1/mdGqWcS9WnUXe
 ed4k=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

On Thu, 05 Mar 2026 18:45:11 -0600, David Lechner wrote:
> clk: mediatek: mt8188: fix CLK_TOP_CLK{13,26}M rates

Applied to mediatek-for-next, thanks!

[1/1] clk: mediatek: mt8188: fix CLK_TOP_CLK{13,26}M rates
      commit: 4f821825c82c9a44ba3b94772a10820d8990129c

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

