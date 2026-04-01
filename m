Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB6C01112242
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 23:58:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A3B980517;
	Thu,  2 Apr 2026 01:58:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="AbYpXjOv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CC9A839DF; Thu,  2 Apr 2026 01:58:26 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB41F80212
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 01:58:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7d74dbfe84cso215036a34.1
 for <u-boot@lists.denx.de>; Wed, 01 Apr 2026 16:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1775087902; x=1775692702;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RCsbkBsZCpQtlsNZWvz8VuqDGKQYGELEdllt/tbEkRo=;
 b=AbYpXjOvbMjcn3ASagQUn/h8otpa5NFIFZcNdJhVrx1uppKut4EP3n9iTf5Z8vpSIT
 CtCqJxEhVmF8vwCERAi/NKC85PCmFCfD+a6bMvCob/WQBoTPgd9skChmqQXjBw2kBOZe
 zxfl5xc6F5L5OBXWIrsUo49gMUvqnXSaIS7q+16eHc3iArh2ROf4ugi+ODFB+mCZhd+v
 kMvAJQ3hsX0HRhuVjspXWzBDk5thkIIj+pDjjhKabH2h9ziPmODjS4XVQn31Dwwemfma
 GBCYxCNEKTtQnL9G5IZwgrct7zUI4Y+0oOkYKii6Z4z//0wQOaJlDbIYHYZe3/4hwIij
 EYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775087902; x=1775692702;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RCsbkBsZCpQtlsNZWvz8VuqDGKQYGELEdllt/tbEkRo=;
 b=ARoOClAMAuYtvCWgsYiwBlzVzOZ0C87jnYk5hQed0Uqib17LITUVIcizOBYdPkY94+
 P/gO5aGW9tQw5SA34DQYgM2WkFulal+hEIc2/pQBLmcic+mPXlc3GhIQfOB1+Vef6Y51
 QWgPfofiZ7ulcjrQmCKAmNRhziKvunpPeBPc/KK/j5r9qmdWCpDwMFsYFnZQzOPFpTc+
 9yDIkowwWOaLTiC5Cqvozo9wKuydeZM3lbcOc/20uCkfDxVaAFrwWqQ9I/bnWDhR1D0l
 tVX6vtM0VQd72/4cavgPEYYBTaL6aiHfq3FlQtAbhJdEQtiDPfDtsG1OzfWw9CRfS+IN
 XYZw==
X-Gm-Message-State: AOJu0YwZxIDh2YdfJ8j0kC2JoEuHSVSnjC9pTNNn+DnPlE4J3d2NJiG2
 58jlJBx3SaGnAx8Qw9M6V+1RKGeuTYShjjvOt6GApfxVtLpbsBZjZm2nbSKRNMF9BYk=
X-Gm-Gg: ATEYQzylqOcHjS1bZWcIjhFZcNESiCXdPeIspzHohpmkQUzyT/SqVID3+jQJ0hi6roS
 lN5JKtdaCjjWhZtmhvbvooQjY3o0XI0+LL1wuirC5jkDZoacZ8IzvezPB/jazWbGTSI7TjiR0DX
 JNV0GgbjSQwSgYvBEmkl4KTKSHEIYVSNDrNvB26D8F+qpOYgpfvtJRyiFS5g0qaR8PkpwLVibKn
 PeIOR0wx7M+HfWnxALgh22X72pE460HeM2sEY02pyS+eraVnnHs97/MeY99kzTGjdnnEEmzK1Fn
 d0QKqRhO7NRGHop/tGEhio9taZ5Q2X9BWW1icX7kpzjWcCYu8oxWJCU245z0jeP3z4RAJlyWpi9
 cHk0tweLtCRj2q9o1HcYTSmRe+jR1b70GIXkDWV6y6r61x7sq9MBaHwbW6UJs2sWFOmyfKhelme
 HrO1Y50Qs8TwfnKlIbCADfwahIPfi/
X-Received: by 2002:a05:6830:82ad:b0:7d7:f5d5:1916 with SMTP id
 46e09a7af769-7db9923dd5bmr3660424a34.11.1775087902675; 
 Wed, 01 Apr 2026 16:58:22 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:57c4:ef89:4ac4:d6d9])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dba72fcb47sm996374a34.15.2026.04.01.16.58.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 16:58:21 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: u-boot@lists.denx.de, Julien Stephan <jstephan@baylibre.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Tom Rini <trini@konsulko.com>, Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Julien Masson <jmasson@baylibre.com>, Peng Fan <peng.fan@nxp.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>
In-Reply-To: <20260318-rename-genio-defconfigs-v2-0-1f77580d72f3@baylibre.com>
References: <20260318-rename-genio-defconfigs-v2-0-1f77580d72f3@baylibre.com>
Subject: Re: [PATCH v2 0/6] configs: mediatek: rename genio boards
 defconfigs to match the device tree name
Message-Id: <177508786926.837601.4215347526669285336.b4-ty@b4>
Date: Wed, 01 Apr 2026 18:57:49 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1269; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=9W5xRlhJL3rfE84EKlWPpFUoOGMn2+KnTs5+E3sKeIM=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpzbEVs4qK2yupP/YBv3fq02DBgYKZdaCHy7yri
 1M6Uj9BwbiJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCac2xFRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AbPcIAI0/qrIRvGo5aRTNcN9wMVzUbfGzxMnKlw8apDJ
 2H+rVbSGPm2Vp82GliUipy+jSVghiLVrSKYz5BJfUlmAmfD1llvh1y8ndFXjzMycz3bzMaTd/WD
 7dWCgKjI1KoXW1Q2utaVTa26BBqzxn8zsbLqwAy/uZrfAru/9xnr/W2/jvHSveT3g+4ggc2fCV1
 RITdHuHYQeXOT5JPiRVkcFXMTifSW0b6ZG4E0vApqEkay4jS2UTTDBI6sbGNroKIGB4tiGtg1hb
 RafhqqB/S7d7K+5rhkQ3GsS0QGlHN5BwF/kmfpkjB1vvL1oYPtIXUCQBkUz+V6AsrTNAvmfrMDp
 gGsI=
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

On Wed, 18 Mar 2026 17:45:22 +0100, Julien Stephan wrote:
> configs: mediatek: rename genio boards defconfigs to match the device tree name
> 
> Rename the defconfig file for various genio board to match the name of
> the device tree. While at it, do some cleanup:
> - introduce mt8188.config to factor genio-510/genio-700
> - remove useless SYS_BOARD_CONFIG for genio-700
> - set myself as maintainer
> 
> [...]

Applied to mediatek-for-next, thanks!

[1/6] configs: mt8390_evk: remove useless CONFIG_SYS_BOARD
      commit: dfa3f88b1cbfd061b426db74e203bd6a23dc007f
[2/6] configs: mt8395_evk: rename to mt8395_genio_1200_evk_defconfig
      commit: 62852f9bfe5bb68021350450a0c3144dddd863f1
[3/6] configs: mt8370_evk: rename to mt8370_genio_510_evk_defconfig
      commit: 74284bc305d80f8d2c9c5b1077a9d25cfffa41fa
[4/6] configs: mt8390_evk: rename to mt8390_genio_700_evk_defconfig
      commit: 031106b23d9efb091c9d022a4ba675af9fbe98f5
[5/6] configs: mt8370/mt8390: introduce mt8188.config to avoid duplication
      commit: aca2e27e56fe9d0d1d67f627586b8a630b5645d5
[6/6] configs: mt8370/mt8390/mt8395 add myself as maintainer
      commit: 09bd64e2c303dfefb97317526f76128d0fd4e31a

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

