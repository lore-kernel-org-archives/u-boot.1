Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24800FF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 15:01:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B800B843D4;
	Tue, 28 Apr 2026 17:00:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="WRBI4Wa+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 145E284255; Tue, 28 Apr 2026 15:17:25 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15C6484150
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 15:17:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-43cfbd17589so8959875f8f.0
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 06:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777382242; x=1777987042;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JHdXH/OXUceNboGPWKDqrUgr/h8EL4kfl0FgGMreXUY=;
 b=WRBI4Wa+xguJKLBv/jZQxCZiqU3bIS8jmp610BjR9p4K1AXYEJHPwU0zjLW6s+CnoC
 Ejyg35d7R61DUcrSRWyPYCfIawcGDxazCa5/4/MRW5+v2zAYCO0sa4NQIl1++IL9NBHZ
 vtfpf7eI4pmXmBDrJN1dloRP7XLzQtPaFu1MO7xJgGkqB9cNvIybAAfFZ3Z19b95l/nu
 uo1OFlzoOJOXKvdBEepiqkm9zFyU9Zhk2duTZzuZOjhi0YgcZGfM+Xo9Cr9DOi/k6iD9
 jDxjUHhm8xWC/DZfJUoRPFq7UsVAtG+S5Sk+RoL9xyMsX7vNDyqKWZNB/g9iX2papGtu
 Z88A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777382242; x=1777987042;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JHdXH/OXUceNboGPWKDqrUgr/h8EL4kfl0FgGMreXUY=;
 b=bBu/wz/lcbx+AInfT62GYanUjDMtNzxAgZpjoNOmGhv7epguvmK7mZxKSraVpFwlZd
 4gHv1wpXBzefjbAeydcv7jbCU5wAC+wQR6RRRetKjJQzs7ODz/XtOvhv5IwjbTFz5aof
 290Y/CxW6wyHmnK1N5sUGX1vlbkQyGfSWOLcrY/d2u/1cf/ss6oN++DntJwgaLwEVoH+
 1eb3oVvmjEhwgLjpEFgLsjBnyLDJ9hx8vucI/jbXKElTnapXIHTfphEKfxPa8ePG36+j
 J/l+tQp5qtoAqzqFQTF6fTMIO/U/o3O3uZam6uxidkyWoDkO92Kapk2DqyAOgNzFkbfZ
 hJUQ==
X-Gm-Message-State: AOJu0YwKlYrznAXr1lyRILk2aG/+8AaLWQw1hhBJ1PTqL3mFnrow8vYW
 wPfxeNF157Xaq90YqKviP4ZQYb6VfpXowFLdzaR7381izmfEk1adJJM5lwNiewPXwqo=
X-Gm-Gg: AeBDieu5Vk/uR4NGuHGTKiBJqATw1LVEsIQQt5Y18Tt/LnS4OZ7Mo7XIKAL/BdSDtCB
 6UrG6OuReauw/rrLYVaBn/zPvr8kszm89VFohl25bwB/5tM9WpxUnBLbW7XlmK0xMWTAIfuDScG
 GDii3+enTsP8hiIEBhXlfgdBzkyspbGrx1u/Elpwn+AIMzV9l/9ORMP1GdWnn/ve39+hwx+evZF
 2F2lbNc4/IM3kABSxZYMZz6VgLvYC3vqXq19y2JtFNg1GNgYaqgcvfmGDUHijZ6HLaqv/UbRJN1
 0oVN3l2PCR2nPkeVmkbIatMaAVFP/SHshUewRJVc2XT/fatlnxsxjd0gOiQcvSVYC/Yam/Kj8rD
 cW3T1RsLCZfj88bGA/qS3T69TKK6oblTFy58FJkmogKXuhEjJyG6RiDfjKoAgy/P4Y4fNAKA67/
 UdNDodcMAgkTOJaE7/3fVtQhaDzjwrcIKOoCg/+mUfuB/4/sjeJB48u61vG+W2y5mE9McAEy/fd
 eFfnFn7ujxV6quUxEHSrCnpfYlqrdtnLa//6Q+tPC8L00zNvNs34E1hepOKMb3qa9tQboq+3ovF
 1BzFVfHbYotzgg/5sQtHjOYppHvP
X-Received: by 2002:a05:6000:18a6:b0:43f:e22f:606 with SMTP id
 ffacd0b85a97d-4464761c2c0mr5762436f8f.2.1777382242274; 
 Tue, 28 Apr 2026 06:17:22 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-1bf9-06eb-939c-90d1.rev.sfr.net.
 [2a02:842a:d52e:6101:1bf9:6eb:939c:90d1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4463d5ee9ecsm7139599f8f.16.2026.04.28.06.17.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 06:17:19 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 28 Apr 2026 15:17:09 +0200
Subject: [PATCH v2 2/9] MAINTAINERS: add maintainer entry for air_en8811 driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-add-ethernet-support-for-genio-520-720-v2-2-9cf2f0884bd8@baylibre.com>
References: <20260428-add-ethernet-support-for-genio-520-720-v2-0-9cf2f0884bd8@baylibre.com>
In-Reply-To: <20260428-add-ethernet-support-for-genio-520-720-v2-0-9cf2f0884bd8@baylibre.com>
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
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Tue, 28 Apr 2026 17:00:38 +0200
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
index 9d68e8e3bb7..40ba3542ca3 100644
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

