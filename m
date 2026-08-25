Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E839C5DF9C
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 00:15:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DFF766069B;
	Tue, 25 Aug 2026 00:15:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M3kPwUyK-X4Y; Tue, 25 Aug 2026 00:15:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787616954;
	bh=kCKRS+eeqigDWoX1kOCmxQChRB0+6TQ7MA62ZJ6v8IU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yFHRwCkRi/NXmnsf3iQDSHN7xHYKUcnP1HtW3Ubpoj1h8rf7OAh3rG7yOwpZ6U8T/
	 oSR5uybTNh19tnbRoWhvzCT/pDQw0DiDxDGC5NX/7spAi9GghPVszSMchki6tq4TZv
	 cJjAnKAHL6rRA/0erhb4VDEiielw9epIQnqk6YCG7fp1oephJi7YnKWIr3x3yDy+vK
	 1wmTJk8JA/WdVrxCKod9JK8cKkM0zhRKgnvafwlpPxCzI2USevYK+8qFngu3OLXDfQ
	 dDR6fJvbNxcTpES4x7xR30GBHV5lBEDdzCvasp+I5Lz83SDWpOMxsYpX/pMNVxZQ3+
	 KLhSlKk6oZlIA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4C87F60667;
	Tue, 25 Aug 2026 00:15:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E00A8396
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 00:15:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D1E2F80C74
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 00:15:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KArhPS0zS9G1 for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 00:15:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::330; helo=mail-ot1-x330.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=hoA3j586
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4B2CC80BA4
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 00:15:50 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7e9ecd7216cso3226346a34.3
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 17:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787616949; x=1788221749;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kCKRS+eeqigDWoX1kOCmxQChRB0+6TQ7MA62ZJ6v8IU=;
 b=hoA3j586KmE+VKBY5uh7pnCSI8BEteXnCyk1P5Fp0kiztko7iVwajk7QCInPAjBiEG
 1wkXQxLrrYBXmLm+wi80+C6F6zD9HChWUoYBJHytGKKfHX8TydUTNKmJZNmUH9tBrucQ
 QSId3Rk4ejd6fJzC8cLGI5tUIc/Z88krkdivqANJzIcXeAoylS+LySrO0Hxi5pGVFA/B
 thxbLnwSW5xDFF2Ofe0go0mzpavsO3f3DLfQ/LJqKg4qD6nWcUCTxJlFOTf3CQZT/kZ9
 gqNO0ED6LOCnj3mPtPQXaz7UfLDmFeABCPxTDVCHdum4xtZqLxIk93/a9Y+XW8PbEhzn
 o4/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787616949; x=1788221749;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kCKRS+eeqigDWoX1kOCmxQChRB0+6TQ7MA62ZJ6v8IU=;
 b=ZMeJq4Bm9ez3srPfYQtsuxOOxF11O6UMKOxC+TSOlgxA/iCCcrobAMGN+WgEs5EsM/
 91GD6ILcCfRdwsKmQOb3JJarRbqZvqTGqoPul8BG+Pu3tCE/LnGBlsdSXsIuke+0ChPH
 Y/kKOQ0HgUSX5dHtlLvjq57+rJbVk9rutFISTmmxHhDTkRol/zpUV8XHO//yiQFKYlOE
 Z5dDqW5KA2/Wx0R7Qm59fmJ4IaWW71E3ne1yMNw0A4xp1kMKx7ZYjFszEA790XCk9/Bm
 /9q3ZAJyuHrGyEeRH+SiRrzKDb5KJX1kmjOlah+/HUGhbqqtUPgtP9zaSZ0twAwq4Ie+
 EmFg==
X-Gm-Message-State: AFuF++nIDR4C/UQa8xms3i/pQQM58je2lQ3KmYF50jln7D4tuwXiN4dh
 CXzjXKhWQ4ODGbWgjHmSgJWp4MFada3SV1gTOpVmzeLGfmsbA5aeI27xMvJuBzoHDzM=
X-Gm-Gg: AR+sD1037PsajCuldlC8AMA2bgjVkCbVgPXVZyxFTNeqOsFKPySsqtmta9FoCWDkubo
 21L+8nPsECz2UR2Axsa4bHSnk/g+o3/nrjmSQN+7O4Wslj1DQ//pbluVtLdTYkQDv+Zev/rFrkk
 V/WTv7FXYKBxFp8Ps4/MoEOdRUmzeRrm8BGkMY8tnQ12CpwQrbVAilFBPYIQcyPNf1FmHpYsHfY
 c/UcCDQ3s3asFVq5/tADEiuxecm1eOydciPvb7ozzGFZc9NQ8FRd5LUlPVb+UvVMSY2eOVV5Qr1
 /uCRNoVz56rCJQlvVan76liIpMDebT3bNXkuxeTsxY48eIClMxXSi824HxZwnacWQEtuKR0J8Nr
 ygk/bWlisoiSRbfT8iX2sFI/gPUufaJXDQaMECsYMhmJCFEAPXd6RxK8epMcq6wpDm9RjjVvcKN
 Cdvf6hnreN95J7F1D1Ono0xf7uLZIauIwivGfzZdY/qDj3zpA2MHt3RBAlNHzAxPIwGA==
X-Received: by 2002:a05:6820:2086:b0:6aa:d13c:a709 with SMTP id
 006d021491bc7-6b1904db0abmr2118748eaf.31.1787616949141; 
 Mon, 24 Aug 2026 17:15:49 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:29ca:5dba:5fc1:6f13])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-46383499862sm7004227fac.9.2026.08.24.17.15.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 17:15:48 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Peng Fan <peng.fan@nxp.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 David Lechner <dlechner@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, Julien Masson <jmasson@baylibre.com>
In-Reply-To: <20260807-mtk-pmic-mt6366-v2-0-d9fdef581fb1@baylibre.com>
References: <20260807-mtk-pmic-mt6366-v2-0-d9fdef581fb1@baylibre.com>
Subject: Re: [PATCH v2 0/5] power: mediatek: add MT6366 PMIC support
Message-Id: <178761693647.2485046.4039479383925420134.b4-ty@b4>
Date: Mon, 24 Aug 2026 19:15:36 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1000; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=/pY+EBlzPZ4kskY9XUl4uQkDH3ujPSWg4/6rYlGjYyE=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqjN6sFGlOSwXoYERCTYbI7E5yIoC+v7fsezads
 xtdjiJEo7qJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaozerBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ALsoH/3Uouv2OI7Xixvj1Y526ogOkWz65GjG7avgHHz7
 CaiLPM7iWATdU8h0ZHG9ZK92WaH3z0Vu4EkMTpasChrUYU914Z4W4/jVcYUYFXELY0iLqMGid+B
 WdsZf8gK6sNCAdG9OGClm9Bjiz3qihpDlgjj5b47IIUV3WvySLrozs0M+U0tvw346pv9+DxhdoH
 UmGkqFaCUdhgdgRi4tsoPec9ScdVuQTpvniDRW0MJu+YN8y188xdbGcIHJW0iq97SXcKywL0gfH
 /hlskQEgIsew+P2K6zyWJt2Z3K/5r+zr7Wk93DEHvmgrINB0dbGKpaW8HXpPKTsR9ChUTo30uwN
 i5HA=
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

On Fri, 07 Aug 2026 11:01:27 -0500, David Lechner wrote:
> power: mediatek: add MT6366 PMIC support
> 
> As part of bringing up Genio 360 EVK, we need a new PMIC driver for the
> MediaTek MT6366 PMIC. This uses the same PMIC wrapper as other Genio
> platforms but the PMIC itself has a different register map, so gets a
> new driver.
> 
> [...]

Applied to mediatek-for-next, thanks!

[1/5] power: regulator: add MT6358 driver with MT6366 support
      commit: 669d102dd71235eba34160a0d560000949c188c8
[2/5] power: pmic: mtk-pwrap: fix clock names
      commit: 8362d7784d24b3b9e80f3bc22ac1308f1c802f79
[3/5] power: pmic: mtk-pwrap: use mt8195 fallback for mt8188/9
      commit: b237f66ab0500bc82c41fd687c77b91dc1f76bfa
[4/5] power: pmic: mtk-pwrap: add mt6358 PMIC
      commit: c276634d2964bb80ed647206cb9324995ab69b3e
[5/5] arm: dts: add mt6366 PMIC include
      commit: 029624b342fe8cf7c827171fe5c7817a09d21d64

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

