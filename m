Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68A32F54AD2
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 16:09:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEDFD807C0;
	Tue, 24 Mar 2026 17:09:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JXQAeAsw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DFA1838BB; Tue, 24 Mar 2026 17:08:59 +0100 (CET)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3C6880087
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 17:08:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-67de15e8452so21123eaf.0
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 09:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774368536; x=1774973336;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z85D4nCpITnX2+c0Bvl9PXCpM6h4xhbD46rLw8H+Sws=;
 b=JXQAeAswOq5mWfRISUpRwfHMHVoVb17C+50AxB2wrUSSjp/M9b6OPtC8WDqhQNK6Mg
 CIyLwIg2NGh4jycYa34NJhQgUUCLH1e4arWk5J5vEKpDmLXOq1DU17N+AHQIP/d0ibW0
 JTWEERpxQKP9J/1ggIl4sNayIQi0pxTBDMtW7QwdzTyvAUgFv44bWgluHUJmgBM3Px7K
 p47YfArNSlRP7ZCrFlD+EZ7aQW8FXw7vai1b8GpT/y/RjscSWwo4mKc3Zgn0D72+r7uI
 qQT9wm4b3gVabIldbY/acp1ZncnGzTNuF7IeVVc2KWrv8leyCI2DToVizerUbVBygIHW
 RJzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774368536; x=1774973336;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=z85D4nCpITnX2+c0Bvl9PXCpM6h4xhbD46rLw8H+Sws=;
 b=YKzyu3TOOYJF23Txd3NTpud5jNMpzuKkn7OB1Neawi6nD9uyFkTBzfe2gyWm4CnwKy
 JJ8w81PrSBlu/V1mz5jYoFfq3YPjE04vkYXyEfD5ix7JWldUW1xbvUA/gMxDbKvS4xVM
 u6+q/xoEbRM1W3Dycz2BCO6SLFTcF6fgDyOeHOzuSiIPG5PacmJHieFJ/XBkdUZu2TXq
 +G6n88dYAHZ8IzbnPhWmX8GaM9xxUB01ERBUKz7a/RkNOM5JhsfwFrufEX1eBKzeTJv7
 wX/kYSecDFaFkeZa2JAXVc1w3fu0B90gPWEoUw94nGbBTbOzC8WhqFeSzbHI5/d6aKad
 T7vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJk3S+nIkbCpcTyhQ7drU0NlCP1It3pqX/LgClGYIHAvdEyP2dPsphsOvdLtwU0fEKX+5ctCQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzotlSuyuUx0VYuUgAicjYNeZYR/jvvYBMTF7EdUsqdG85dPD5Q
 OgR0h0eWcMrhQEEBhwH/AwstYYt7T1fuL4N3Ig0ECZXtrwwbTW0A58DCCzax2uGY4Vjc87WFsEq
 R4WL8
X-Gm-Gg: ATEYQzweLztsmWJ/aQVb5KdmyT1Y9J0i0KBMBYZygJ/0gEqxxnWJpkR98Dt4OwHgtVu
 5HUUsoh5GNSp+3jfFw+Hvp4ctGzQsFvz9unPjbUaBmN2eA9n0lcjK37wwWgkJLNlIfIOqR0nzD7
 p6kDBTvhKY9ktsRZ1IuKqhOPHZ/UFPV9uuqY15XOaUK9FfnUKFNPqSan4TyM90cMIwhv5dF6lSk
 ZASKBok8ohbCJT5K11qdg3MpOBJWDraUGBjz9tavBHXOrDahNjuWnsulumguqM7NOn+HO5StH+B
 dARA2u/1wuuNH9gDKw4nM49svX2lrqXFSKz7Huhq+Dro1ULahXQocsTcB48hkjhkv/56Tu5Y2aZ
 TSQPLzwrrsvA8TCgGkb5xAjb1O4Oq20RysgwHbf5ky7zKXbrsF9JHIZZp+qkrj8J1XH/TJC2QxN
 fZ3zqHGcgwV84LSzY82/09G/Ox1/Rc8gxd8CJgYw==
X-Received: by 2002:a05:6820:1606:b0:67d:e770:748d with SMTP id
 006d021491bc7-67dff4e99c1mr151151eaf.15.1774368535703; 
 Tue, 24 Mar 2026 09:08:55 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:8a85:a776:3f75:a1d])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41c144015fbsm14068215fac.0.2026.03.24.09.08.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 09:08:55 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 =?utf-8?q?Macpaul_Lin_=28=E6=9E=97=E6=99=BA=E6=96=8C=29?=
 <Macpaul.Lin@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
In-Reply-To: <20260311-mtk-custodians-v1-1-000f9025b54c@baylibre.com>
References: <20260311-mtk-custodians-v1-1-000f9025b54c@baylibre.com>
Subject: Re: [PATCH] MAINTAINERS: add new MediaTek custodians
Message-Id: <177436852301.3897241.11997471326327322783.b4-ty@b4>
Date: Tue, 24 Mar 2026 11:08:43 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=310; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=vKULl+DO6iUktTO5qGFca1EsnWXX3bWX3ag86FsF5kU=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpwrcOwWUUuWVdaXxKwhkMHyO6HtKLiAS+a4Gbz
 mfJLBLQIIqJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCacK3DhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AL50H+gKODQLd0DmofLyGjEbF3B9eqWOtxcKQ8Wgy68o
 zTh1L5fssMbF6R78mf2TyCRXaVBCJNZLg3uNzw9M/3Ok4PG3mU8JZ3GiM3DzutJEYYH2M4uEDMQ
 +Q/JskCK3Mq5ykEyWR1WbdYIE2WGiCEheEGrOnV/QztrT1s/m3l3x5bPZIxQqJlVKRNtr/ifaiX
 SBVPP9P+jq7VP/ygz7+mzZnY92ogI2zcWvi+l1HKLJ2tpHLWIJ1aGh1NQ7bWITtTkPRqmGwpKep
 V/6VwNsltxVfos5HnAI+ceHaLCIKruxaK+9nD2L8Ckg19gZgcJo/g+TEearE/tWFZbWTWOMCBiE
 fTcU=
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

On Wed, 11 Mar 2026 09:52:49 -0500, David Lechner wrote:
> MAINTAINERS: add new MediaTek custodians

Applied to mediatek-for-next, thanks!

[1/1] MAINTAINERS: add new MediaTek custodians
      commit: f82f50caa1d5c1a9e4e2982a05da58416da356d6

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

