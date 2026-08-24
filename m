Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21352C5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 23:02:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 73D05606A0;
	Mon, 24 Aug 2026 23:02:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yeJiwu9UMehV; Mon, 24 Aug 2026 23:02:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787612526;
	bh=9q+0Rs24hOciI07v+PIQtKnFMriR2vcEmKEFGbOlyl0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rqh42JGr8k+CpRuy+a5qBKXQqLEZ80O4qsd2jI5qBnHDtDEA1Ytz323GpkHLRoSHX
	 xEUgfQDlPOH6AsAuc6KAFJWnjjjBWHWSELO1L2zXrdsZ5TeZ39U2otMQWjUaZzoUxZ
	 RZp6ccHQ5JUjPeMR/bWWFxH0Ig9HJegWwlUF3TlCnHpRWKuvwlD2krkb1Vf4meJvDk
	 /sbB0P74hhJt4gB1VxpWyAIh3VCk91b3yrG6iAZQNt5YT9S8cnoBi9rd1v/2Nl+dh4
	 zT4xYqtqCivxqLBEwHMR60DtN+vstREw1R6J95cxhZcn9cLVV5oeiFkCgFeBjn5OwT
	 V7RNgNPx0HhBQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 873B76063A;
	Mon, 24 Aug 2026 23:02:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 55AD7118
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 23:02:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3C203405F0
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 23:02:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XtsmL8Ji-CrG for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 23:02:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::35; helo=mail-oa1-x35.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=SZHSNd2E
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F348F405EB
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 23:02:02 +0000 (UTC)
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-45eb2e6402aso2523080fac.0
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 16:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787612522; x=1788217322;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9q+0Rs24hOciI07v+PIQtKnFMriR2vcEmKEFGbOlyl0=;
 b=SZHSNd2E+fg/xvcG8bIp9kepkURmAG+G6LJjg49INbctP1ZaxRea0uxff51jWkgrUq
 7jKVaJAdrFNF/zmc/DlMx6fvzSEPHPgJW3A6KiBlQz3N6+PdjfPT2o/e2CM+lUYqsSh2
 Sr5aPDBUxJtpTcMTGoQmAMbbJ79Eg8MSB+i27ASHEO+HfH23c4ZZTCuy1W13wGoNnmnr
 bd7XW/S+6573HzT1r/eIpasEIg+7QACnUk2yONh9Xgo7NKzcuPZeb91dqUPYJ7kXLnH9
 BQ1tt4KzQaKV2HMPgNPldcqqsyufgR7xK0GVVNxzMxaduxxTtfWCO9FqrayAG88nF2Q5
 +MsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787612522; x=1788217322;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9q+0Rs24hOciI07v+PIQtKnFMriR2vcEmKEFGbOlyl0=;
 b=ht5gSbPfzELXiQD6//GBQsqLZqrDrDu3OyuLZO9uRTTo/kZKzJ5Y2reMshFpviJ+7r
 n7wRn8orTOPh99cI5MDCe/owAcVqzdjdWZfG4bGNx5kgBd2oUqjOqUH7y0Xw+WDMcgOV
 OwHZMAoxxHm+tAs+T8iunasW6rbc2y3Bku6Gy/7UDZT8/ZBhcvhxr13DJzu/e89wpLFb
 chCSySWYkpcseb2nyJO/bJATCd2f9JoLfqkFj+Uh7tTuKbu1Cb2i6Ct9oC+USEzc17uV
 /c70nEo9xaxJbSVC6MqkUwv2INA5TD3Lr/szUTOaSYplPi+r2SOZFZzbGGRk7cJ2/1F4
 Tb4g==
X-Gm-Message-State: AFuF++nUQKFUf4toqSiI8GMrs434YP980mk2QwKyL3UWrqyLFCW95rwR
 eFg3EF2+rf/NjdSTMT5RK8+UJO6aFq1+lAXgKQlXTpVjAxd6JAD5rN8gu4m3BsNzgvA=
X-Gm-Gg: AR+sD10jZWh/ERbJz+8PMwVwPyxIFFje6jAGiDT/95DOnUcGnQ/ZMaXrVOJ1vxja8/1
 w3AiiE9zl0Wr7vkSaVfABR8vIetJUGdSUmMKtUwl0imBak9LXRp8iMOXhXO/J88moRcLdo2s9qJ
 tDTYONqyNfFgMF2azWQT5PVTVLWvHbaV0IL1vXQ4zZPGsVMKfzt87SyiYmYnMkVlyB/P8jvnmmS
 rgRWeOdDUKgVtLUYIF2q7WSpIRhc2Csz8jj4NGJO9M/XHQnQbCDpdG/L8RirUncCZTMLbXJs9gW
 dY6M2m0tj+k8/m7EjhnYVQvPwwwFcftJK18GLRv/n63TyKMMdV17Gv2aUOI0qO4YVvezDuSAvif
 pPi6YZAO+YBMrFGmE9UYGzoI2s5KbIqY+EDrlZugBdhxvTKqZn6c1C4LbOGtvnEE6DakIPry5s8
 UMa3B25v8Jp+JlR2lOVS7dpApNdsSLQyBVeJwb5QYOKaS1KnNRAoNsw6fommk2KH8lvA==
X-Received: by 2002:a05:6870:8309:b0:43b:bb18:affd with SMTP id
 586e51a60fabf-46449304745mr2414945fac.8.1787612521936; 
 Mon, 24 Aug 2026 16:02:01 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:29ca:5dba:5fc1:6f13])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4638313340dsm6014440fac.2.2026.08.24.16.02.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 16:02:01 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>
Cc: u-boot@lists.u-boot-project.org
In-Reply-To: <20260805-mtk-tphy-v3-v1-1-f1d6268b8d89@baylibre.com>
References: <20260805-mtk-tphy-v3-v1-1-f1d6268b8d89@baylibre.com>
Subject: Re: [PATCH] phy: mtk-tphy: add v3 hardware support
Message-Id: <178761250951.2485046.12060742440732774966.b4-ty@b4>
Date: Mon, 24 Aug 2026 18:01:49 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=306; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=/2++tRKXcqwPvaRcxgDNf1rmPF0KxJRe90JsJ2/gtH0=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqjM1fxGcLGyn7DucvT3GYywb/EyhrlQzTvTwho
 1GJUL1/02aJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaozNXxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AdIsH/j5FB3LKOMhbwVsRzwCE4dz9NVN+3j6bfa4fzuV
 cDmxCqVvrNHc73u31MTLz9/tUW+8dCdidyZWgFU4nyfPMKI/FW9+v4mjdhJdomlN//yEWvD4W3x
 jvR7lOT27g4V588vmDfkDi2Zo59IzBia7CU9ib7Nf76S7OiLT6g6oxVqhtgl64GF6+9WQBpzzeN
 Ri7jtk7N1GP4nQCT8yi+lnghn4tpLPrlrmFBZTj5bURmZ8tzbyiDX+bljAn7S5jbxtkDNMEa8zX
 FCgEqWtoA4pwDcMKDg6f24g5LugceCvuIvGLq0el9JGTyiQ6IKhJj0GCp6b7OQjELse1uYKQfTo
 ZH88=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

On Wed, 05 Aug 2026 14:20:34 -0500, David Lechner wrote:
> phy: mtk-tphy: add v3 hardware support

Applied to mediatek-for-next, thanks!

[1/1] phy: mtk-tphy: add v3 hardware support
      commit: 7979d7a6f129a91bc4372410e19ec0de008cfed5

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

