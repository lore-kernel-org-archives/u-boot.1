Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D897EC4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 11:43:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0349884F3;
	Tue, 23 Apr 2024 13:43:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nXrhx7BA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DEC788597; Tue, 23 Apr 2024 13:43:22 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 584588859A
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 13:43:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a524ecaf215so563142066b.2
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 04:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713872600; x=1714477400; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y9SVR1G7h51KOA3Qll09a/Mal2o6YfDQsK/35+Lkxco=;
 b=nXrhx7BABJOEqbryjOlt3PzF6Ln9Bfij8HSeo8QOAa/KXKk+JKABk/Zz17Gpx3bfBA
 nIbIrivVwQckIDfz1rMZuAtoO428EWTQktNcXz1ikQOKFzueEJ6u8VviztHcPJuvqu2e
 EctPtizi+hMT4buEvKpoT9a/I8q+Nj6HcU6P6tP0v3gvm4B+B9IT8y35hTy1V8GVuj0P
 Wz5Tw3YB8DFXYmsL4DkfYo4t6CHq2EbU/pUzk0bj0Noi4uoH+GYdKkn8WFwxr+MKGaT9
 lws0GU3NcxOm5ZJCJuiUVsT59vjZvowROxwX/WpDVR/r52kpVstSnCgr/TQ7ScbbUajG
 B5ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713872600; x=1714477400;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y9SVR1G7h51KOA3Qll09a/Mal2o6YfDQsK/35+Lkxco=;
 b=hyZW2EcxoAZCxGK4pMYI3YGB3a8v6RIssKlsGIvXI3UeQ/aN8GgtGp7vqAjIrrmuVw
 vPQRcBWmwT9FsFK7YoZASVTJIDtdYA3/ML0R06OElcFtTc6GWsMmgKDApIY5423ywTTZ
 rI8hvea3SXvpvC2vlUOuWHb+YfaA3kNMIveZ83f0Eb3u8bGAtKrQQNfHkegXkZWkc2Rg
 iMIyrj+0QCX0i+febczGj69ZgJHJyJ1zWcko9rxt+Ecu6W+Y4YKNX62t89i+ef6Tp7uE
 uFjzJYlqimPlnnuIN1NNcfrPGGDySutVNcnM2SmDjpMiLCgI7zt4Lqhc1TxyXoApDk75
 ucIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVORoZGMtvhMsV1VPzvaHQwd0+fOh/v2TCo+8z4vRYdk6ZGXfcneZOOXpnHUHAUmjQsYSEUFRTEZETuitWF2qvCnn6e1g==
X-Gm-Message-State: AOJu0YyLg1pv2sC5BmCAbOxgnuu0bBw4+LNZV6Z5m/4K+c2f2/+UGV4k
 p+plvUaE/ExAVOJIEiPdCBaOHBZRrxd9verOdoLX3aAv4EJ8xUYD/P6GHfimbfc=
X-Google-Smtp-Source: AGHT+IGOtBUEhFx17aJwfC19uaN1Xrlpk2HaBOzFmdHskw59F5p/tMNoGXMwRqUV4NeOWKhfKz/ang==
X-Received: by 2002:a17:906:f0d8:b0:a52:6e3e:c55c with SMTP id
 dk24-20020a170906f0d800b00a526e3ec55cmr7265870ejb.70.1713872599887; 
 Tue, 23 Apr 2024 04:43:19 -0700 (PDT)
Received: from [192.168.0.114] ([2a02:8109:aa0d:be00::1795])
 by smtp.gmail.com with ESMTPSA id
 n4-20020a170906164400b00a55967a9038sm4507528ejd.95.2024.04.23.04.43.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 04:43:19 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: trini@konsulko.com, neil.armstrong@linaro.org, sumit.garg@linaro.org, 
 u-boot@lists.denx.de, Robert Marko <robert.marko@sartura.hr>
Cc: j.beck@linefinity.com
In-Reply-To: <20240422114359.219762-1-robert.marko@sartura.hr>
References: <20240422114359.219762-1-robert.marko@sartura.hr>
Subject: Re: [PATCH v2 1/5] pinctrl: qcom: allow selecting with
 ARCH_IPQ40XX
Message-Id: <171387259908.2280908.12386109784659288068.b4-ty@linaro.org>
Date: Tue, 23 Apr 2024 13:43:19 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev
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


On Mon, 22 Apr 2024 13:43:24 +0200, Robert Marko wrote:
> IPQ4019 pinctrl driver was moved to the dedicated Qualcomm pinctrl
> directory, but the KConfig depends on ARCH_SNAPDRAGON only and thus
> PINCTRL_QCOM_IPQ4019 cannot be selected when ARCH_IPQ40XX is used.
> 
> 

Applied, thanks!

[1/5] pinctrl: qcom: allow selecting with ARCH_IPQ40XX
      commit: 622f676801f3d4a45524874ab8bf6ee498acbb5c
[2/5] mach-ipq40xx: import GPIO header from mach-snapgradon
      commit: a2830931490952b3130c22fd3259123b27ee9889
[3/5] pinctrl: qcom: ipq4019: adapt pin name lookup to upstream DTS
      commit: c88f0b12595f250ae7192c7427a9ca75dbdc59d9
[4/5] pinctrl: qcom: ipq4019: enable DM_FLAG_PRE_RELOC
      commit: 1dd073b3a9738325569c71028962924ab69a3e1c
[5/5] pinctrl: qcom: ipq4019: support all pin functions
      commit: 8c4c6a268e35523e6a8130f93c51b60a6341e8a2

Best regards,
-- 
Caleb Connolly <caleb.connolly@linaro.org>

