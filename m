Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89404CCF9F0
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 12:16:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45BF883771;
	Thu, 30 Oct 2025 13:16:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LbGF7LAa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35736836F0; Thu, 30 Oct 2025 13:16:33 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAFB2836F0
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 13:16:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6406b8e1fb8so595363a12.0
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 05:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761826590; x=1762431390; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3RLz4oestISMNZfX8zyQD2h8Z92Eu9UHkf3y6JTJEEY=;
 b=LbGF7LAaJRvsTDZA5XVgmw2LEihmSlCTriXDMVYdenGhdiRlqJQymThqvY1/99QO63
 nS3VsDVyxPx8gTtw81un32mFpArO3/j0PSjwt1Hjrcsi5wmPn8bGQ+EubzAr0gUaJx2A
 /aDdbdLFtAKMcz9ZGUpScDo8anMWieYOvCCsW8fqi6jt4Uu0WQifI5pQjDt3P2IgSzdj
 detGPmq5JADsM2xpUAAS0EYZrwiMe+gzICz2/YVo2PNiBTcHVtPOCVs7R6iAcGidm/8V
 86GuE1UepQOnBR1cwgn+O1dCdvuRcpXWPbKJ3CFf8GPetm2F0BN7HlvxOAj0lkmBxBQh
 H4xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761826590; x=1762431390;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3RLz4oestISMNZfX8zyQD2h8Z92Eu9UHkf3y6JTJEEY=;
 b=uBBZ74hKPULFhcYmCs6XSoUc44eEE1FSA/MrClNNr2xBQAVxB0tgwATcpnOkGxhJCg
 g+xuWHloNwfV97CybjQXlSeGxRl0j2QEcHcaKK5xvrS/gnTlwFEB/FKV8Zkuv569cPQ/
 qtg+s5cYcwEelC+XMno/etVtDYlm7xKGOVlnK1NxfbQDocgkm+OYqjFuaeHWTJf02Ec6
 bAI/dP99+ku8zUOqyTxIGXtsbi53kBm7e3wi138iiyrokgX+dhYEgFnnmqNFIfDXiYw1
 fZDMlgkZlu7xJcy+z2XRIa9Gp9eyBs1m+snk6YKd1xE2mElKu4/+m5l0TMV7oOKSXTI1
 YbBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJwBkE7R+AdoW89PJ4OcLhp6hEhsOD9IGrJldT+vxtP5CUFqrx4iMTCQm0/ZWkX+1Yi+Hv+/o=@lists.denx.de
X-Gm-Message-State: AOJu0Yw40qsRbcn8EoBRto2oA3NCAKO5tK8fT04W8NRRectqrJc6i/iq
 Zuk8iGpLfD/mXk9MRIYCc/miS4BH9Gge9pG8g6Ejku7INTRoqjhWxLioDe4f1cEMV3ZHxsVP45Q
 7VahZymg=
X-Gm-Gg: ASbGncteDygWHLwUU8bV+nO1Sx/h73lYE4OpBnr9Dq5UmwhKMnJizjPLettnT5p2nyJ
 sH+Llh1BQBmkWEIUnTGNl4BLTJ8kqX9qVVdYgHOoghhmPhIReXefC0z6lgd9QW9JZFIWpN0BdOW
 bge4wYw8J8yenXTmfG3XveC8irAoUFLo74SWN5xcFVxoRhK5L3vZlzxCNcfVNBgGUiXGMbJCQEV
 ntAcvgMgS3BID18S2tET3yVWArUZQnxsbmqeZ3yknv8AdxE+fXyzKcVGrcjqCAPL1JWUjnCkWBO
 A84KU9s/tT/8auLpVmpQ/zmpEC1rEU17tTWsyh2LqTdJuZ3CO5Ab1IUH1eVhooTIPulPNHlXQJ8
 IBdvTH4UzlFbezl+UyI+iLqDoCCjO7Bur29XvSa29JdSTN+/BVeFMyLt2m53J3gvAcWb1PoWnrH
 tQ+1DOkB3iHiG4zcJvVyjEtCfa0uxVyQoyialCazBqt3bQ77B+lssNKYE=
X-Google-Smtp-Source: AGHT+IH8T+GQNR9uVqYkrSvyTyhJswKJKgTlKI7yapjrTkJy2C9UfqBOa64n4Lz2xcmgq10B2zsgQQ==
X-Received: by 2002:a17:907:1c21:b0:b29:b4ac:d2a8 with SMTP id
 a640c23a62f3a-b703d5b4b18mr719908966b.57.1761826590030; 
 Thu, 30 Oct 2025 05:16:30 -0700 (PDT)
Received: from lion.localdomain (p5b29e67b.dip0.t-ipconnect.de.
 [91.41.230.123]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d8548eda6sm1710123266b.75.2025.10.30.05.16.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 05:16:28 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>, 
 Rui Miguel Silva <rui.silva@linaro.org>, 
 Jens Reidel <adrian@mainlining.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
In-Reply-To: <20251005154443.71477-1-adrian@mainlining.org>
References: <20251005154443.71477-1-adrian@mainlining.org>
Subject: Re: [PATCH] gpio: qcom: qcom_spmi_gpio: add compatible for pm6150l
Message-Id: <176182658847.4111945.4514077562627567766.b4-ty@linaro.org>
Date: Thu, 30 Oct 2025 13:16:28 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-52d38
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


On Sun, 05 Oct 2025 17:44:43 +0200, Jens Reidel wrote:
> Add support for the GPIOs in the PM6150L to the new driver.
> 
> 

Applied, thanks!

[1/1] gpio: qcom: qcom_spmi_gpio: add compatible for pm6150l
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/bf83c6036e85

Best regards,
-- 
// Caleb (they/them)


