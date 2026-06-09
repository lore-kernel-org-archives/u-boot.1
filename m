Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77ED9CD8CA4
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 12:49:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6C35848BF;
	Tue,  9 Jun 2026 14:49:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="s+IkX1VU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD6EB848B0; Tue,  9 Jun 2026 14:49:23 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF59984881
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 14:49:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-68c76fb8009so7042995a12.0
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 05:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781009361; x=1781614161; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3XH5FlVA05zU8D6ppqpa+4acYoX9wSRY8+G16lvEq1o=;
 b=s+IkX1VUSXlG2jhDVE5P/earrmZ8Btx8CtzUJA2PD0Omfs6ZhJVEVycBvoM4wy0sAZ
 77YN3fogGL+DvpKzkxvdRz3fqVWWN7IOP5rnt2BSM4uxVUNqf3o6j/GpFgUsM6TtIqZw
 Efs8GJWKhgB7l6gIcK7ErVAp+V2UDgsc/OrNa3fEWSj2g0slcsUye3V4ietxDnBZwTiS
 4IKWA0dhm+GYW+jqMaZ6dR7oou5tNw2gNe3/uZLhrIX43NczaEj0AURkHvAiTRwDivOH
 g+uAnk/Z8JBkvgId8sQlMLGceqP7yQs8YEqahM0WIMMVjwjZg+i2gz81gfpBbXdsvcbm
 Zjcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781009361; x=1781614161;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3XH5FlVA05zU8D6ppqpa+4acYoX9wSRY8+G16lvEq1o=;
 b=ZCPuq1lMioDNyqt0DiEvO6fXCu9ZQNF4IUiNyF8+YNg62WVCUiND7CjeJdZchRzulP
 7S0Cgj9VbniUCgEXtZVvZYG+Nvz+QyB9JlpesIdner6NXCyzu3pIMxvAdubnOaqk6uEf
 xOlcuazMV3r24kUwcsVbxEsJ4LWyY1OrQh9zXWPm9oV06ubGrFzBtF7+DksrxqXImXm1
 T+X4QEs/MwH5ZzsnfW5bq6fYLZKgoXSK/4p7D2rgKAwl6sxsgbJYiPvkqbATV/MyS4bD
 NFi3BWHrK6T7kl8c0lBDkKD07fsEZdSNQ4SIk1U8UX+WlBLfa84R5YKvEMWx354YKMMg
 B9JA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9mn3kSTuVwboaLxOKOnonSUVGjkHpUpGsjZ5vRaICT0uaQ0YO67W+RmOJpAZJrSt7MLgwBQJQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxkWbxVZECHYio7UeimiLNWk0RudDOl1ChQKjYpu0LBxzOOVbkP
 cVKTeXIJY1G//fLRvc+At75QlDGV6ul4sCzXOkn/eo528+061Q3cavUQ3DIVyTrPV3c=
X-Gm-Gg: Acq92OEYWvNYoCPbZyXfXzGG8uTwdO+e47v3BD5XS8JGH8wjDiLWB6XypcGtu6Hl9Dr
 BC8wJNbBKciFhknwO/11d8htfnYAsohmZUpQcKReXo0vHdY+PGUFmGAVBarqu93GJDTA15EsvPh
 ObWFr4tdt8mPnLmWFbX33v5oNLp1SAkG83K38Vuuk+wbFp046Ml8sLdchZpJnSv6sLT0ELFgiPT
 G9dgDb56TkzzurwOUWP8lHu76UtFR+uZbA+kCqpWx36ey1nX9MORTGqei9rQRgNTe7ePQ4jo7Ls
 t1/+1REjzmld0xlojayrpMBCjRKSgGq/CLDXHZpHnsQ/FBzFEBLYeDHCnYDQ/BIPK2VR2gt47Ix
 wmGFp8Va1x3etsPKKvQxE0pXUeC7ZL/rE+gAUnjGhl/qxIG6AZF9Kp54wgIvX1fiVSvm9Tt4KU5
 BCXWOfjWrMDSffFMvNOQ3qrhw8jMlFGtQZNhj8Nh/xptH0zJwawOOg6dPgzGNkYKFKK7C3cPBl3
 qaQ
X-Received: by 2002:a05:6402:5cf:b0:66e:56a2:b67b with SMTP id
 4fb4d7f45d1cf-68fa524c4d3mr10139439a12.20.1781009361058; 
 Tue, 09 Jun 2026 05:49:21 -0700 (PDT)
Received: from lion.localdomain (p5b29e032.dip0.t-ipconnect.de. [91.41.224.50])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-68e65b55d81sm8689526a12.27.2026.06.09.05.49.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 05:49:20 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de, Sam Day <me@samcday.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260531-qcom-phoneconfig-fix-v1-1-110a1c542dc3@samcday.com>
References: <20260531-qcom-phoneconfig-fix-v1-1-110a1c542dc3@samcday.com>
Subject: Re: [PATCH] board: qualcomm: phone: fix 'Dump bootargs'
Message-Id: <178100935905.3342853.1450519362406990721.b4-ty@b4>
Date: Tue, 09 Jun 2026 14:49:19 +0200
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


On Sun, 31 May 2026 06:40:59 +0000, Sam Day wrote:
> This menu option wasn't dumping /chosen, because no FDT addr had been
> set yet.

Applied, thanks!

[1/1] board: qualcomm: phone: fix 'Dump bootargs'
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/84950cb21c12

Best regards,
-- 
// Casey (she/they)


