Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E22D10775E1
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 16:45:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FE5083A41;
	Wed, 18 Mar 2026 17:45:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="b0mHOx4j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05F2F8352B; Wed, 18 Mar 2026 17:45:24 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C9CE8341A
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 17:45:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-439c9bdc1eeso5495f8f.3
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 09:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773852321; x=1774457121;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eN4co72ZlE1rJXhNPP3hvOkjerOSH1ei99Kw3bwFntA=;
 b=b0mHOx4jwRd6P/avg/QBKL11SY16tCAkvcs6iUP4Dd+mKbjRN7S1vpjKNkAkjks/Kp
 yMVqJZi1hF05WBeJg5u5RU9LtjGGMkoa3tLP9WYH9/oWVjoYD/eeVSQXmv9dXjUCcS2d
 CAspNRVTqVBWcAOxTsNJKIx5XUTgAps1PNRFuacz+P+lOkTYfglg89V52oB4gcRTLlOB
 8RmQLM8yq4bMt+JlVDbmPooWSNgg7sYV2XQroEwB7EQpaqEsATUApt3BeVj+ryXuoC+Y
 jSYkp659CHl6NSyuA5mqcbSla7djIdsglROqf0FnSDNpaOFNcEnxFd79Bbzr6BdBn7QC
 L8xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773852321; x=1774457121;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eN4co72ZlE1rJXhNPP3hvOkjerOSH1ei99Kw3bwFntA=;
 b=D7vn6ljrQRCjsXL3bobHcDBb7rO0VgACYVwA5qAL68h3x0QsWBLmZFYTGzbQePUKSa
 sRwghTSz/ofgsGSOVxR646iOF6p6lk06Ct1ZKQU2uKPD84SGabkgbM2vwmBnD1SMcf1F
 sIoXruh24BEWFxh+wJbqzJBRLtnJM5/p9DvX81yNvMopybpFmnhc8WuKr2RlBjGXnp8K
 JQRZDWHiPFHhoTNEQdx1p0aATID7vwxkFyjwdAzSp68OUZW8hKA5ApZKoMtIl5Om1Er1
 uMCaY/qUGLjmMcL8ZwDyHB3a+CSHRRlNJLk2sho3HfMNHACeOONnHZCItjY/jk2qBier
 UM7g==
X-Gm-Message-State: AOJu0Yz+gth+qRMAuub7vDwbuNeCiGX9RNkOHlCVK+sxz1Yr64NJmyUu
 aug6hK+Uioyn7qSUfbuT3itx1e7/vqARJXtwsaQViSmyjukOipV4188KWYNRvWOUDSXtPD8aZAq
 YOLqTemo=
X-Gm-Gg: ATEYQzxNMGZpwfebPKOFSHfdz9SQr3GsLg7QoK6rCY+PzKu5E84O9KPb7QBiC/onb+t
 6yp9e1iTpDFeUv2zejQUboVBMMB7QO04dBz1WatviPUjF5fcOytDG0bLd2JvaL0muTQb9x+8L0F
 25qJitVYiZQ7GFTL6KbeOL0kIUmw8TG+DqchzZNKEJMKDaCVvWb+/scoIBHNb6WzbgKO1uBDpDA
 NsKbT1BZgYfk+uGoSk6lGZ7G4qrgtyEmxMAE9H1Jq/WROog5IJwU99i/bjGdkQUrIygVdl2osAn
 jtTnQzjNRuFQQTKXTmoX3dgySAzyYmVsELI3VJosNps297NVioCeUlo1kQzGkEiCmg8se2xIpVk
 Tm2t8tRIlSC47hes8XWYErC9ZTbKXZOLdOAC1GfhdIYUW1OGcL6iNtll+/DbV5ah16wUFUNI+fR
 hyQAlcIQoRJGZxZUfQpRdT77fhfvH+miqD6ADpAfSWytnc5u/YQyOT5Fsguhw9UG0K4HGRYUxz2
 n1KcpaHC6HnZQaO+xzj4L1glULkPinEBSV/jt+JiQ1ikr/kBILF10Zy1JC5rmCexaPCgu0c4ZWb
 1akD134=
X-Received: by 2002:a5d:5f82:0:b0:439:b440:b8b5 with SMTP id
 ffacd0b85a97d-43b527c7746mr7059229f8f.43.1773852321428; 
 Wed, 18 Mar 2026 09:45:21 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-b535-6f9c-731f-0b89.rev.sfr.net.
 [2a02:842a:d52e:6101:b535:6f9c:731f:b89])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b51852a64sm8612085f8f.14.2026.03.18.09.45.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 09:45:21 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 18 Mar 2026 17:45:23 +0100
Subject: [PATCH v2 1/6] configs: mt8390_evk: remove useless
 CONFIG_SYS_BOARD
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260318-rename-genio-defconfigs-v2-1-1f77580d72f3@baylibre.com>
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

There is no board directory for MT8390_EVK so CONFIG_SYS_BOARD can be
removed

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 configs/mt8390_evk_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/mt8390_evk_defconfig b/configs/mt8390_evk_defconfig
index 06437be625e..99272f17989 100644
--- a/configs/mt8390_evk_defconfig
+++ b/configs/mt8390_evk_defconfig
@@ -1,5 +1,4 @@
 CONFIG_ARM=y
-CONFIG_SYS_BOARD="mt8390_evk"
 CONFIG_COUNTER_FREQUENCY=13000000
 CONFIG_POSITION_INDEPENDENT=y
 CONFIG_ARCH_MEDIATEK=y

-- 
2.52.0

