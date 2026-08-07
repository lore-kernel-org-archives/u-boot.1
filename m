Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A52DC5AC7A
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 19:17:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 38D1A407A1;
	Fri,  7 Aug 2026 19:17:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OXRV82jyU34z; Fri,  7 Aug 2026 19:17:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9F70D4098B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786130231;
	bh=ATJnei3vGdFuqB0xz8BvMW7RaCMF5Lyp++DQh5qxeGc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=agQ61yXr3vkm3YJXtVrCLV1JEA3lEVCBU7zWb7SBoOk5K8UIrWZLUrENkLcjhNPUj
	 lcK6dT+Ktr9WYvxomxziKDrUyHWB222UjzEwShSOrnn8tSxh1NVxKHAcbGrR3t+1F7
	 zm5+vQx3UjzBs8fToqk31wWgUbQXounDTIzHI7zbq3E+VXKlsrtXWoMORrqwiIEeeE
	 qUcCEiCLDOMRBZDvRcB9FLBxeDPGjiZWaCjIsuxaRwONX0mHxqzdo016Hmm1d0KYDt
	 3r2u7V22oO05SCDHNBGUWtePc+Mi1Vv7BAvmaEEh/gVfwKydzv6dyGw6hSILFuCcnB
	 sAk2rZOOTfnbA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9F70D4098B;
	Fri,  7 Aug 2026 19:17:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 85AF0259
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 19:17:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 83A8A40207
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 19:17:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q-OxgDS8cE4F for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 19:17:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::229; helo=mail-oi1-x229.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 51849400C7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 51849400C7
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 51849400C7
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 19:17:09 +0000 (UTC)
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-495b27007d0so2260419b6e.1
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 12:17:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786130228; x=1786735028;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ATJnei3vGdFuqB0xz8BvMW7RaCMF5Lyp++DQh5qxeGc=;
 b=rC2ZOnxGJd7nIRwQBUx1H4VMLGgfyLzEo2ndwFkn5fRO9xhw/tTBsNxLfC7PVeTi4j
 VFnWL1Zwa34sUfDteLmmaRhADSJ4r2I3ddAhXddviym65DUcUBiFZaDnEZmjVlk+8KSq
 k8RpzwRP3GWs2JeGfFdOwU6qewOorYDa14zhKm7g/BJdcDBwA63/g6iLOwbWu/6rvQez
 xHxBdmZg/RQ16IJzM1+sjhXavHCOJSm+y/6s69romzVGVl657exLRkBF2gZrDOVj4+H/
 9nk+xTuaC25uzYXWUKPW8rxm81hIsPfkU4CmOWTrxaU/GM6XEOSoILojf0zvRA1vo9N4
 Rn5A==
X-Gm-Message-State: AOJu0Yy3Eu2CrP3JSmtzuxKydn2BLOarQpxnSi7U2C3htkwbg+jprHkN
 bHuM9p9BA4/0k3Lo36l1pPEnXjQZjp4WGHtCBZqq9vl/Z+FgSQ7dws7JXZIw2rJPcx8=
X-Gm-Gg: AR+sD11nwzQD7FPjS8/PFFEr8/1BswUz21FTfZoUxE55IKa6HNfhjTQTi+wiS2hcq8C
 79iLo+FKd+bEnrwF7yArFJZPQ59hjiEDb23/Sdn59Ka1dWLUxTDzLkxZe/HBE7Al2fwZX4bsUUh
 Yc7Ld6zID0NOqoJTf7w5B2XGB7iwl0F6vXmdgAuFZtsE0W1IQ9Tc3BwUvofVr3zBc0WPm19kkcr
 +drSum3cUM4ylEqbKW/LhMGbREz+FwtHFPHWi9MvZjeyADbGXI5Ce//X+4TzhDAQPPPRiiiX9Od
 i8N2P4BgWkRDxJee2JibJTEwPDN59wU53q08Qgl8y/Y5cgR2GPUyahkiNVZd6ug9VPXhfCGfMN2
 HE/+Dmq6mLjq8sIxb4IxVB+xqUICvKGJn/IlPm+X0PGTdkT02Hx7NnY7hQUiBKXaSxGsWwciDIc
 KMtmLyB3ZrJZg/S6GuwIE01DFdOIEoR0iEBlGZEOl679sVJNNtDGx1TtmGpuWjjcO5
X-Received: by 2002:a05:6808:170e:b0:497:df42:1e05 with SMTP id
 5614622812f47-4b13323c85bmr6557585b6e.8.1786130228207; 
 Fri, 07 Aug 2026 12:17:08 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:b714:88c:313d:dee2])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f35b5acbcbsm1875251a34.11.2026.08.07.12.17.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 12:17:07 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 07 Aug 2026 14:16:29 -0500
Subject: [PATCH v2 1/4] pinctrl: mediatek: select PINCONF
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-mtk-pinctrl-kconfig-cleanup-v2-1-509a8f833181@baylibre.com>
References: <20260807-mtk-pinctrl-kconfig-cleanup-v2-0-509a8f833181@baylibre.com>
In-Reply-To: <20260807-mtk-pinctrl-kconfig-cleanup-v2-0-509a8f833181@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Sam Shih <sam.shih@mediatek.com>, 
 David Woodhouse <dwmw2@infradead.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Mingming lee <mingming.lee@mediatek.com>, 
 Fabien Parent <fparent@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=918; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=QTaeYTaOWB8sdEccuUt7KljcFcMaHuvZkHdv3fomIvA=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqdi8WPw4AbKsABVG85J/NtTfoSF05jc/QQ0aQZ
 hsENUuuWjmJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCanYvFhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ABzQH/08sqVDjRHnYjgNFv4DRZCO97pXfHK6b3pJllqs
 0ySA3EIJU2kWv1NNL0kITDsAHJSIRgW63ndulftt6foYhJ+TmMk9Q2/KahUsRKC+bqRlrkyjD4Z
 5AisnNkGQnwcUUTgP0GGfvtm2EmLcUwPrci3c2Xlvrpk6VJ9w93CpiMMOVWqsC440RBLXBN0NNS
 ag6cE7cjEmAElWT/BGITswJyBl7mTIwGUCVo689YPrCPuKf6bEh4MjrSnOB0ACT8Sv+tZ19NZ4M
 n7HTYeqH0C+G5IGP3eZR4nDCa38z2jS6VKSRYabPvDC49PlH3+U3mLDdVKvipHmspzAoulykss9
 YNwk=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786130228; x=1786735028;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ATJnei3vGdFuqB0xz8BvMW7RaCMF5Lyp++DQh5qxeGc=;
 b=NlzBas8HQ+bRS60Lsc2PQQwWmu8AaS55ZRw11J0/ug/w6UmI7Py7ahyKj228PvDXOf
 ruiI5rB5mWH/E5kfjB/ipficEIZjU6oO2koJ1FvfJivEuPtUWqTSMKXIoKcCE6toyRBz
 aFtFWImirGCjkmLWS9RinbFQ7r1hwKQks6S7HAdVQRpH+ip3mqqJ+ODPomvRiqp5cZRT
 Oc/LVJfhaElJUsu0X+DhX0J53nBb8w56i0MhRX/F2LHWHHhBXAc5e7JuCDUKL8X+dRKV
 YOFL/82lthd0OF2ESAQbpn5vUiK/m5rH4lt6lI6l5CJIA1JE5IvGqx0aZq/dW7p8Rq2v
 CPuA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=NlzBas8H
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
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

All MediaTek targets include pinconf registers so we should just always
select PINCONF instead of requiring each config to explicitly enable it.

MT8518 was the only target that didn't have PINCONF already enabled in
the defconfig, so it will be enabled there by default now. (This was
likely unintentional as the MT8518 driver does define pinconf registers
for drive and pull so supports pinconf operations.)

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/pinctrl/mediatek/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
index 5a90d74a9e1..42c7c8b8c80 100644
--- a/drivers/pinctrl/mediatek/Kconfig
+++ b/drivers/pinctrl/mediatek/Kconfig
@@ -2,6 +2,7 @@ if ARCH_MEDIATEK
 
 config PINCTRL_MTK
 	depends on PINCTRL_GENERIC
+	select PINCONF
 	select REGMAP
 	select SYSCON
 	bool

-- 
2.43.0

