Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA29FF8873
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 14:24:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6135E848BE;
	Wed, 29 Apr 2026 16:24:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="cldBEvgG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB573848BA; Wed, 29 Apr 2026 16:24:16 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63854848CC
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 16:24:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-479dc6d26e3so5514015b6e.0
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 07:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777472653; x=1778077453;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ptfECCtQYvh4ua8cuuB/1VEb+gWvTJcNzprX90ej/1M=;
 b=cldBEvgGbHbcMW6t7v7XV+1Ua5CKAGGvPmCqfYP8My5Q42qfKDoZ4rEDjqqWWzvyKe
 XVs+ZtlnyebTwsm2QImU8JLnh5UFdYHrh8bdAhZz4eWPg85v06ETNDcISlg57faJLX3J
 hd1RA1g/rQqvTasxoaCGF3sK0eVyZjert2cDJq3C0q/sNSWylZYoExCTEDlwCHsjqs6g
 bz8K4acS9PVfUQGiHLPHo2J828BYsrAraBsw7NtWhHjmGhaa9EXr5TUgs/Pg9LT9jr33
 /oTNlsjS8sW/Luta+wYGdzhoDp/MQOKGQYJkGibc71hc3DQCSA7NzO7iIZIaDXzRTDBw
 /jbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777472653; x=1778077453;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ptfECCtQYvh4ua8cuuB/1VEb+gWvTJcNzprX90ej/1M=;
 b=Zm3ohi5LS52vagqdp9Ica/HMu52pXbauiSvfEBMgXIauqRQWmf2wXn/So8rJn7GXy5
 C9jqzRASU5eKkGeb1jh+HkZO/a8ZJ02fO2bQRWNBsoufcbNzuTY9Mt+TBfRO9uD+C8zX
 n5MPhvF93nDIW5Q5hbiLhmAOuHerOE+ti+xc8qijsJ6SeFUKx78UDW5NfbMQ5d8eVxmx
 92iHXXxjGkBa3cnzcz/BUwegJ7fC2ccbncqVDabPqouAxEOeWjZ0j+9ukHxYTW5oLXxc
 mISEzBhyhhgivcOlS8aqCSAlB/jM4VWBOF6U7jeoKgJwgcVX5edyzNTQeq2gpAJvoHrm
 b3Qg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8su0nRIz4qRP8cx8FLYZEAsOdTclGCUwOpCXEJvfPMu8/VhLEEPwMf+Dq1tbz4xtMdw1dHZIo=@lists.denx.de
X-Gm-Message-State: AOJu0Ywj7TrS/KQ9gUyUmJ7ciMHwvLzrj0O4sPgdWwYS/xtdg5+gYq9d
 GnG9/9Y7grEOQADFeyqNEHCk+wjN2Zp5Eg8Jubhod+raVEL9KtrI8+/Pl6NdqC4KQsw=
X-Gm-Gg: AeBDiesBx74GkafZSLyx8HTYB8RRNxkopjc/Rennvs4Kyq3boNxjyR1/uO7viBfUKMg
 PVznZPIORKfBWhCAVVN8Gu/6ou/pX9iKwgQ0rTymB+tYttRqKxwReUuSDSyezsXexH5fzyW0chv
 CReK/Hc4Y1OMZErE7NkHXNAXFRnG3RnwdifVjxjy6O3qLiMAIrHjfheB2VucIGGQFv3o6p5sAoG
 Tea/Hb3YeDOqW7fKo1S16nVnx7EvgVVRr4ZP4ww+MAdKn6kHFMDKLdycLkJvCnfKpX6CV3fxgwU
 g0a9c17OlNW2aJ6lDAfkZZqBkHUoV+EaNeLn9SYyy8awqdFEk0QhoVX9vmJFUkzH/nc7SHkstLm
 8vuftr3/nhVynAVo609NyNap3F1xBEKU/jGKH7DNiQLo0jqTtVI2B6g0T1wpuYILXWl1LFlfAG5
 tQdBhR8WK+jqq6qHi0JFLuB32C5p2RQFz/itEi4iE=
X-Received: by 2002:a05:6808:e684:b0:46a:cf7e:4b5e with SMTP id
 5614622812f47-47c3dc65957mr1455689b6e.43.1777472652990; 
 Wed, 29 Apr 2026 07:24:12 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:1770:76c1:cfc7:3a0c])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4340e987d73sm2074676fac.14.2026.04.29.07.24.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 07:24:12 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <20260409-mtk-pmic-fixes-v2-0-73e83aa6345b@baylibre.com>
References: <20260409-mtk-pmic-fixes-v2-0-73e83aa6345b@baylibre.com>
Subject: Re: [PATCH v2 0/8] power: pmic: mtk-pwrap: add more capability flags
Message-Id: <177747260853.2560708.16176609841938006096.b4-ty@b4>
Date: Wed, 29 Apr 2026 09:23:28 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1550; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=4VvBmnQnFU2ysqBfy1YABbuXWgZ6AqmkebNzg9EW9l4=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBp8hSEsOmZmP2/cPVbuFhJNhED+ZB6+K7uGZbzS
 zjTM2pbmxKJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCafIUhBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Ai18H/3VofeCakChCOP4Dzn3rFFROV/dXSuAURYmgjhO
 MXhiW5oUTlvL/zvlz2YP5lhZa1om6Yz4dhSObrA58mob4thQ6uV1Tsa8+EA6zDCtLGu7OYU31AY
 XKBAxlRvBHgYiYfP0h04ohu4PI5xmVdbh+yhehbgfWLp5FPMV/O7eUViE8JWsqqs0zyWCU3v59V
 MxheYXa94MSeEXI8QTvAC3DJbXzcPMZ6sXJ5EYzIHdqTEyqq9n6d1WyYaBVLSRSnacfwrHBc0u8
 NAnvNWM7a2cJ8Cg50CjUMyFrTAmhvheuttI8Rjv/zjWDjwiNs4DMRLO3OkOxEg+ucw7wmlKdGx7
 h7IU=
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

On Thu, 09 Apr 2026 15:30:32 -0500, David Lechner wrote:
> power: pmic: mtk-pwrap: add more capability flags
> 
> After using the mtk-pwrap driver a bit, we noticed that there were a few
> places where it was writing to registers that were not defined on all
> platforms. The undefined registers are treated as 0, which is the DONE2
> register on the affected platforms. This could cause the DONE2 register
> to have an incorrect value, which could cause Linux to re-initialize the
> PMIC unnecessarily.
> 
> [...]

Applied to mediatek-for-master, thanks!

[1/8] power: pmic: mtk-pwrap: fix file description
      commit: 0f50131f99a68b53c08c3c41c1a2e3e421d6fdad
[2/8] power: pmic: mtk-pwrap: add PWRAP_CAP_WDT_SRC flag
      commit: 8fac923a5f15c3edd66bde274a80612387bb7bf8
[3/8] power: pmic: mtk-pwrap: add init capability flag
      commit: 6fbc2ca84ec33df70a464e9a12d64115f1a2844c
[4/8] power: pmic: mtk-pwrap: drop PWRAP_SLV_CAP_DUALIO on mt6359
      commit: 804e6702f3b33f8cfef15cdf45aafe77661c1a23
[5/8] power: pmic: mtk-pwrap: remove interrupt related code
      commit: 095458ef73672857d1b09c666375679dd399e4d1
[6/8] power: pmic: mtk-pwrap: use pmic compatible to select child info
      commit: 5f73fe49317db5ee348ee4daeadec3c082345e04
[7/8] power: pmic: mtk-pwrap: use tabs for alignment
      commit: 3dede5fed1ec9847daabee87da61e162abda7ecc
[8/8] power: pmic: mtk-pwrap: add MT8195 support
      commit: 4ddb07e24e7a13b0b9280c7cc6e0e2c816f32d25

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

