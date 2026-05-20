Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D5C1CD4F3D
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 13:38:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74376846BD;
	Wed, 20 May 2026 15:38:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Q55knVfs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04C5B84832; Wed, 20 May 2026 15:38:37 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 008648464D
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 15:38:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so54149425e9.0
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 06:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779284313; x=1779889113; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vevyGvYdIWpznsKfawaWsmWPeAsQrhm+Lz6efZjmKX8=;
 b=Q55knVfsGJE36E5BTSpLOrWfyfgSt8MZ7s0BAlPfu7nOE9FdmqEoJFAlx/GcSPTtoJ
 tpOjen/VQVUAzCLYpBm6TnCo/NjDEyykwSliCAwIT/y3nDMKNYF9mkfvaomhwf+uKyBh
 NSme+0fN80ZT0D9jMfEX4yX6FediMDh3QATZmLvLMTfOdh4grM9Dq1zzhfSYx1WfH/Y1
 fqAyiM1EhvugeA7nzd0HLzM03ur2sZ06qFC6i6ugFhG3EQJ2wC8dcC3Nb1AcWTxcD9BC
 R5zZdgYroapL+0Y7LYm95kwcvG+/IZ5X02ZxIQgciSyovun0MPOyQbZg2n1C26+Yujtc
 RawQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779284313; x=1779889113;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vevyGvYdIWpznsKfawaWsmWPeAsQrhm+Lz6efZjmKX8=;
 b=cxnMatzg65VCfh3aSAOCzm0TQTSEpR/nFWjF1WO47SqRnKXf09M1rxMH3AJWCYKnIH
 5dNxQ0YydeD+zKLyunDkdJYtLwiG9XNpjXG6ednqBsuruWqgzLrrfgzbARUPioMfkKma
 vqiNcbx5cLkIJMCD+nU+Y2unp97mmDwpTClCuedDwcIpyziDspYnzRu3pMJjhaiCMOuP
 0bTej52CUIU7gxofWcd4sWAo8RvONpDAey7Eha/lduLI7MHV46c+1bZd3fEQxwQ6gFi2
 4ml6PPnAIiEOGBuzMW7oVaXIkEaVTM4ZFfY5f9ES5UkuSpMETM1pNBz+lJScV+k8eaAv
 yJkg==
X-Gm-Message-State: AOJu0YwwsM9aIuZy8qhR/P7llrY8Ont4tiIgFPmkFf8oQaz428+2P872
 0MMrjh5lguvbvmnijVld6ssS34jyrTe4peOox6WcUoqoV1RHzGdwGH+b69mwQNaYUVk=
X-Gm-Gg: Acq92OHyLvqMtqeTYoybywfTafPtznxSSreOxnsoTzhyCHxVpXLbLbpKtupqFyhYWdd
 zsh5jI9gTWYhIWKUu3OXZWeT0LB0AtRDFWTUDSiNCJEsexzPLDO/OILiWVrtANgC2CNmASHHUcr
 YKWOFxW7lQ4BBBCfJeVxlmnFe0j3mtyOjF68myLK4HdsaYKjShORSmSa3GFeMCKimi357VUzWRT
 HS+miqgyEHZw4jdJGc1NTnPaMEjdN4orG6A5K/oUSxm5vQS4SiH1pwlR2+smgkXKMq4+1E8Icfp
 siw1SWnTrbgGDNTIOETCLH56AZQgARyBCaYBhVH38XM/eLWfbFVXUFNNnIQ0RGY3ABOGu6C8hFK
 GWF2TksY0fc5eGIUykvOgB1LHreboCwvwQrnavjmszth/CY4TgIEIFV9gMhS3rY6Gth/RIVUwzU
 22dGD3nErZyRTEWaJAeCDr28FuRbjPLEr6L8hWxUzkBsDdzcg3GWQnZwF84GXpNbrW5yx97M6IU
 nh0wjk=
X-Received: by 2002:a05:600c:a406:b0:48e:82cc:4d4c with SMTP id
 5b1f17b1804b1-48fe6514939mr293833085e9.23.1779284313398; 
 Wed, 20 May 2026 06:38:33 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9e767d0bsm52466459f8f.3.2026.05.20.06.38.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 06:38:32 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Rui Miguel Silva <rui.silva@linaro.org>, Sumit Garg <sumit.garg@kernel.org>, 
 Tom Rini <trini@konsulko.com>, u-boot-qcom@groups.io
In-Reply-To: <20260507220549.209113-1-marek.vasut+renesas@mailbox.org>
References: <20260507220549.209113-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH 1/2] gpio: qcom_pmic: Staticize and constify driver ops
Message-Id: <177928431214.632715.8599487671391045293.b4-ty@b4>
Date: Wed, 20 May 2026 15:38:32 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
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


On Fri, 08 May 2026 00:05:31 +0200, Marek Vasut wrote:
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.

Applied, thanks!

[1/2] gpio: qcom_pmic: Staticize and constify driver ops
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/246b0f185ac0
[2/2] gpio: qcom: Staticize and constify driver ops
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/bc2811928806

Best regards,
-- 
// Casey (she/they)


