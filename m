Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2B1910775E6
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 16:46:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFD8E83F14;
	Wed, 18 Mar 2026 17:45:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kwJSbMGr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A647A8352B; Wed, 18 Mar 2026 17:45:29 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9224F83CF3
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 17:45:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4853f2826f7so450335e9.1
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 09:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773852326; x=1774457126;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bsBtrGtUHvvfVd/7YjIEvSD6HZt2OGkBJvZHLWkXkao=;
 b=kwJSbMGrFsQ1OmXkPlwuZFkbJaOEJ3w+D3f0LtUtKQ5IV8lEBpIZ7xWmywhMOZaX3t
 rV/jrAy9wEL7qCn/U32YTu5O1ugqeMTUKYfaS49qsRNaDfiDf88QCgdSHwwjMLHIyzA/
 qNddKN8kM7CKZZAO8vnxjN//xahzZplXB7OzioVWIcVHxNny7ffZX8k0ZXQT+qYe7thj
 XNVTG75r1wfCM+gzILby0skF4c2CGDP7HqKFRtLJknEoU8RPL5L7QLSXD5scNHCpoFTV
 cBvVWldQHi66fXLfG2U/GZKkAb232ZjYQyNW/UHcZJQLgrtAlzR6sgZV20ozsXReBxBn
 m55A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773852326; x=1774457126;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bsBtrGtUHvvfVd/7YjIEvSD6HZt2OGkBJvZHLWkXkao=;
 b=lerov4yXDqpHTU2XSC50/3Rq8lqY3NlOys4+H8vtsE1OxIe7JOa9vsih/mH6nB0JP/
 Svf6FfZCXQ5NZTsfD35NskwVn4mXk6Qdn0EU9ey6JGgkZldc85th25yRtXsbw6bv0BBN
 PSbnlt1+B+867w2QChP6Jgk9iCA8fyrOVVpB1omsWALgE1CptQ6rOU3ePZ6KpSHUTeWN
 2jpV4yOQ6vt0oyslFb65kqjU4muwfmZRJ5IV3kutOh5Mt6LBARziY8OCo6aPS91TkM3d
 kSU3h4aM6mu5PgGAdBvLPwaMLPNPPJpGL3O0rcwdv7uPpW0wdcSpNJhlLc/43s86iVLo
 KALg==
X-Gm-Message-State: AOJu0Yy59J6oF3t+E+BnAjUEdYCLP35Xk1gf5jiI8Y3eiftcSZBp5jC1
 i0dwjGPvJQqJgh0Oxxs0qu2FgBAqZDhI5mRt930taittnnKODEz3a+KKvk5NPhSiJeM=
X-Gm-Gg: ATEYQzw7kWSz1N0Ze0o2dDCMP55ne/bNo9Tu3ABs+kDzDlSkNjBRxzIJ429A3o2/0pc
 /eG9lWvJ+iTfDAFpTri+w9Q5f1aAeEqV8dyyobnmAoeJGAM39tnzgXiSzFNFOD4bBvWt4DgWXlW
 7WWp6Q7Sk9ZMI7EZzpirfcUGL1OKlCteYdPLXAWJ/HQXiQat95UsGjmYYeSqad9G8uJJPNplUzy
 mzSviH/iDVMlfZoqpZiZ6QCWnU6KKF5XexqKi6++Wz+uVRRZYwkx1xGc08COC4/eU2vyn+SENYa
 DniqeYcBafUqctEULFUT3y7PkBJPhJ0yXh5ajuKBdcUqr5JDRh5Foj8jCTavd74NcmSGOqD4mf6
 R0v5X6jopCvb2Lybq5D2dT2lLnV6DMzyWQ2bBLrrVv1WC+d3LDMx8uvIHt6uW6CSM0YNBYMOYjw
 diIFhrKI6d+0oR3lYUa4IKIf888ltGO6kvRf9S+mbJbPckFVdsVdUpU0oqcjVu67V+4oD20T3uA
 6fcOzG/uOuJR8HKINiivqM+QVg347wm1I0HM0q/9EiLZ5sV0gZNn62CuU4qZEG3hx0oSClliF3v
 qgbePg4=
X-Received: by 2002:a05:600c:4685:b0:485:40c6:f507 with SMTP id
 5b1f17b1804b1-486f456feb6mr70262715e9.30.1773852325904; 
 Wed, 18 Mar 2026 09:45:25 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-b535-6f9c-731f-0b89.rev.sfr.net.
 [2a02:842a:d52e:6101:b535:6f9c:731f:b89])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b51852a64sm8612085f8f.14.2026.03.18.09.45.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 09:45:25 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 18 Mar 2026 17:45:28 +0100
Subject: [PATCH v2 6/6] configs: mt8370/mt8390/mt8395 add myself as maintainer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260318-rename-genio-defconfigs-v2-6-1f77580d72f3@baylibre.com>
References: <20260318-rename-genio-defconfigs-v2-0-1f77580d72f3@baylibre.com>
In-Reply-To: <20260318-rename-genio-defconfigs-v2-0-1f77580d72f3@baylibre.com>
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Tom Rini <trini@konsulko.com>, Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Julien Masson <jmasson@baylibre.com>, Peng Fan <peng.fan@nxp.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.3
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

Set myself as maintainer for the following genio boards:
- mt8370-genio-510-evk
- mt8393-genio-700-evk
- mt8395-genio-1200-evk

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 board/mediatek/MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
index 30aa71a0ce7..08cbd2ce49f 100644
--- a/board/mediatek/MAINTAINERS
+++ b/board/mediatek/MAINTAINERS
@@ -5,6 +5,7 @@ F:	configs/mt8365_evk_defconfig
 
 MT8188/MT8370/MT8390
 M:	Macpaul Lin <Macpaul.Lin@mediatek.com>
+M:	Julien Stephan <jstephan@baylibre.com>
 S:	Maintained
 F:	configs/mt8188.config
 F:	configs/mt8370_genio_510_evk_defconfig
@@ -12,5 +13,6 @@ F:	configs/mt8390_genio_700_evk_defconfig
 
 MT8395
 M:	Macpaul Lin <Macpaul.Lin@mediatek.com>
+M:	Julien Stephan <jstephan@baylibre.com>
 S:	Maintained
 F:	configs/mt8395_genio_1200_evk_defconfig

-- 
2.52.0

