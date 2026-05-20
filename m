Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 347D9CD4F3D
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 13:09:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C7D984815;
	Wed, 20 May 2026 15:08:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="u/giWVpj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9767A8486D; Wed, 20 May 2026 15:08:49 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D588D8484F
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 15:08:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48fde648a71so35726495e9.0
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 06:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779282526; x=1779887326; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tN/qDQqtEoKWRxN8LZOfklkSi3lwivfNRSoozOstraY=;
 b=u/giWVpjroAv3fttYJmdFCRFkJ6HkRvunYVgs3O7dRsK4PQar61w9A0GFclnQnYKsx
 UzA1INHN2ekUC/Z17rQvdu58TKMqtESqTaybfC1l4qvuob4uZtZFs0GmrcjLDXQCx5oC
 0LoMWXUULWox3GXnIF6VQQL0OprwrlLOPdn7MMl/mT4mnQbxMTcA7mG7potOOl1Ly8ic
 9eHICL3CVEFzIA1ltJi3vpYcsmUjzNV+G3xp5bsgpYdDKAjineuHmEwktOxfCaIveuPf
 1me6VTBCFkBciJl+sWLdCfhH3BYK+8dGCBcwuNWLqbNN9of1BW4ismWmM2Fs6hMtRBv8
 B3nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779282526; x=1779887326;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tN/qDQqtEoKWRxN8LZOfklkSi3lwivfNRSoozOstraY=;
 b=Sv3U07TsNdH78Kb5npXayVVgqdQD0N7FxTFicospa8v1COkJXhdQpEMKGcOiJ5XoA2
 oc5inVn7t1K7PQErhrdY0eVnTXpBvyse5cYbfI3ytj0zbXMJ5leWkk9mYrHDe28VIScO
 AQuQ10Pr/eXoPvZj/DbwnLQphDHZ+h2cImzNgiH19Rzhjt+xFKK2HFx1I1YzmEZzf5WV
 lzrWf11/q3yisLzbW/ZmyG9ki9KUrxh3rH+e4AfNCOnlTuOMCmPbpy26u936uhGUCk9c
 wlz6AsKkzyFE/ARC9h1ueqMdJlRj/QgHNpAd0V6LoA53tNCyke1JZ/7hUCEqaAsvs8qV
 AsYA==
X-Gm-Message-State: AOJu0YzhLW6qSD2UvQBjF3sAqLZrtpW5TvvpjFT0eOHq2My3BNS3Z/ly
 qU8kImlMlQm/p33iGEyaZszvZXJuiWgraMe3vjsSKlvR2zlw6OWFDZGktBC3WdIppHs=
X-Gm-Gg: Acq92OEdgAZPssJNF5/CND6/Jov83sq0P83KWBVPHRo/RQpgsEHYWV1BaV3VSAuuHqw
 PJVceIDiccv8RGWQ7ZrUfp6qZK+Zxrf0Q55pwzHKJE28MGfgmP6Y9JnSgYJI3RLEmFp2ssBgpXY
 94Trkk8tvE5KcFU6KJVojKtX3Pg0e5HVdh8eGlv7grlUyAL8Cstdvio8qS/+BS7p1IBQYJ6aq6N
 hfngwwzEhRY39rBcxy/cPnPG5QZhkK33IoPPWgwfmvMzSjLM0bSTgCS2qCYYrbjWDixFGTpqay2
 uHGuMKgiVdfn1LgIpzGLq42WH3RJzsFCrews/rmLJmagQu0lH41RZ4xYeWyPPjgHrg8a6e5Wkm+
 cX7lnaHPeD0J+3WPvuf9Cr4GnAtMh+NrP42er7+X2LQt6KIq7yp7ttmhpL4IJxZEhkIzJM2FYTa
 EUMKtZgjAu0WNyWWo/3+F63+AU6DiNXgA82R6CXFmw+XD5lsvbdq5dPsYfzm+glAuiWw==
X-Received: by 2002:a05:600c:8485:b0:48a:5339:a46 with SMTP id
 5b1f17b1804b1-48fe537fb70mr73481435e9.9.1779282526223; 
 Wed, 20 May 2026 06:08:46 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe5694fcasm371316615e9.5.2026.05.20.06.08.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 06:08:45 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260508122128.512798-1-marek.vasut+renesas@mailbox.org>
References: <20260508122128.512798-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] nvme: Staticize and constify driver ops
Message-Id: <177928252549.3008922.14483053677972678879.b4-ty@b4>
Date: Wed, 20 May 2026 15:08:45 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.1
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

Hi,

On Fri, 08 May 2026 14:21:21 +0200, Marek Vasut wrote:
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-ufs (u-boot-nvme-fixes)

[1/1] nvme: Staticize and constify driver ops
      https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/4e91d9ff3324866d5cdfc0bc73e3382ce6fcc3d7

-- 
Neil

