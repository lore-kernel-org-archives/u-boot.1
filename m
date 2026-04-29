Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7308DFF8875
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 21:16:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1595848D7;
	Wed, 29 Apr 2026 23:15:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="l7msBO5L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63F3A84837; Wed, 29 Apr 2026 15:59:15 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F03684837
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 15:59:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-43d64313c39so9683056f8f.3
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 06:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777471152; x=1778075952;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=F580oyhz2uHlMsW9XS0EQv3NtI7Y8wjVpQml6aR8e/o=;
 b=l7msBO5LDoGhFQgMs1Vn7GpJSemUnPJRSRvjeRLR92Db+fUBdX/Pa6I04lvjIMH2nB
 txptZcYju8QbyauCxD9pyWE0hUt4urE0EuqGYOHngChTv9j7/HHiTFSe2VsRlt3SrO4X
 vUGsfJ8kjSncRdhL25ReRigxwPS5e2EqYNPHhHzi0hFcKSzaato1MPDvyLM/iXDnLKD/
 vkJaHwis197knmmyChVSXr8TzXmuG/BXN9A6lh5tRnfIIwi0iRWQ16CGR76CluPMDR1G
 Ol/s8AyyRNISXm9b/vv5MvFHHKDp1SsszRlgENR9LhFIXp26Kx0y9I1KN3hCZir5P2Yg
 n+TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777471152; x=1778075952;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=F580oyhz2uHlMsW9XS0EQv3NtI7Y8wjVpQml6aR8e/o=;
 b=Cx8qMNzSTuP0fqgBfyOlmwOtC9d16KSkdlSd/hmr/GAuiD7YHlCdLiUlov76qjQfhv
 S3lQP/UdSxcqvXKUmLKY+h9PBCLcRnSaEDohcFeesHQzPgZgUIwGBffajy1cuMnwyS8q
 THyi3VWHCZtXuidKjNICl3TxXzNeFX+EP6pEAcG52n7aLZDygLynQFWfe3mh4J7KagEM
 e9TU3NYMemhtQldBSiJEk/SZ6ov4vTEL+mFbS5Ew0uvVFfiEktA9+p06wo4gg86S54lY
 6PezAR58L03CLkw3gcL4Sj+UdzejZjdb8htlJYuuTf7DsHKwv5tsk4Jq/gUak2usVKD8
 k4tg==
X-Gm-Message-State: AOJu0Yywi+WlW5WWDIShxhMv6rbTofZ5dXx48I2qHa6IVqX/svA6cM/h
 ZK9nnY/mRjHfrrVOzfXoyrCtp2ozJdOKNxZCOl2c8floo+GRkTCorDqtKTgO7b6dvNQ=
X-Gm-Gg: AeBDies9XsBAk3j74ujEWzGExDJIigg8E2vjcf/DEX7JoRMlei43P24Zxgom+1quyhh
 XRCCybpoUXlmRUxxpozwJRZwM9A/Vx80YVlQmQGa2WPC3TaBSsM+CjkUadMVrd6VfM5eXvdjYFF
 o80Tm2YwFrEmxaAprQ0OBlMH7LG3iyQwWEyfwg7d5mUm73vI8U+vytw/r1/Vei/WL5iAi7LfHEn
 crdX2Hx6UKxXbphF4f6sFkeWR8NnfITKyfK9n8GTp9F2vUb7JIK472qqBSIzXTKtYaJfAAG3wFz
 Vy0tJHKHgu5mSOb3b/DoZFjytt3WPY2ySw3mr7jP2aO9dT70S6Vl1ApCSUGxjgTZ+Fm83EfdEXT
 SIo/mmW3WmyEHqE9g9318Iy6IrtA8rPpmonlijFH4ImuQ+qIiLBiBfCVdnND/M18uQnbXYAcMIh
 93iByYEwGO+EGMvUQCnjkXcUl6AJtrc8XY7Pn7gelBUoR5W5bh+COaan8QkxW9Ut/VN/Tmk4ARk
 LkzmKi/j79K/7m0MrzyHcFxjJthxSN9HKMVLWPxy3n0MnAIRLTNnHRG0ALy1HjCxnaEf2utTf82
 mHaY9dAWIj6lUcmvP+U=
X-Received: by 2002:a05:6000:40cb:b0:441:36b7:725f with SMTP id
 ffacd0b85a97d-4478e4c6250mr6986290f8f.5.1777471152435; 
 Wed, 29 Apr 2026 06:59:12 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b7ca64ffsm6289675f8f.37.2026.04.29.06.59.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 06:59:12 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 29 Apr 2026 15:58:55 +0200
Subject: [PATCH v4 2/9] MAINTAINERS: add maintainer entry for air_en8811 driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-add-ethernet-support-for-genio-520-720-v4-2-be54e17239b7@baylibre.com>
References: <20260429-add-ethernet-support-for-genio-520-720-v4-0-be54e17239b7@baylibre.com>
In-Reply-To: <20260429-add-ethernet-support-for-genio-520-720-v4-0-be54e17239b7@baylibre.com>
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Robert Marko <robert.marko@sartura.hr>, Simon Glass <sjg@chromium.org>, 
 Yao Zi <me@ziyao.cc>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Yanqing Wang <ot_yanqing.wang@mediatek.com>, Beiyan Yun <root@infi.wang>, 
 Ryder Lee <ryder.lee@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Peng Fan <peng.fan@nxp.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Philip Molloy <philip.molloy@analog.com>, 
 fanyi zhang <fanyi.zhang@mediatek.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Christophe Roullier <christophe.roullier@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Sky Huang <SkyLake.Huang@mediatek.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Tommy Shih <tommy.shih@airoha.com>, 
 Kevin-KW Huang <kevin-kw.huang@airoha.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Wed, 29 Apr 2026 23:15:47 +0200
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

Add a new entry for drivers/net/phy/airoha/air_en8811.c  driver.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ce4e9d58037..105590ffad0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -58,6 +58,11 @@ F:	cmd/acpi.c
 F:	include/acpi/
 F:	lib/acpi/
 
+AIROHA PHY
+M:	Tommy Shih <tommy.shih@airoha.com>
+S:	Maintained
+F:	drivers/net/phy/airoha/air_en8811.c
+
 ALIST
 M:	Simon Glass <sjg@chromium.org>
 S:	Maintained

-- 
2.52.0

