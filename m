Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DBCAC02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 16:27:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B80E80BA8;
	Mon, 10 Feb 2025 17:27:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VR8Lnyhl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE91D80AE5; Mon, 10 Feb 2025 17:27:35 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7E2380548
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 17:27:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-438a39e659cso31493015e9.2
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 08:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739204853; x=1739809653; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7c5uu1yLPOnid4qb59cfCziQR0prFTa8G6G5vQse1n0=;
 b=VR8LnyhlqjaUCyjFogPQRttul7ptxyF3xKIH32rOwrqvstg5IwceB2I1H7xpI1QmGU
 v2FhSSreAw3IC7YIhn9PdXt7kuFfqz918lyoh/QlrVVYiNK3jUuuIz2Imcw6MBkSku4j
 G68DyxLSmitu4vX8J6kyzVNsAQexnUPmJ0Sy3Pk8iACerMiL8ODFGhkPuzcw70d8ZQ1Z
 2wofbyXeyMgHzRZcCEhsMyRptjkI+RECrV/S9NYHIVnwF2CP2Y2IhMfsSmG9oXJGF1xI
 m7vB0e9Xu5lqxjHy6+w/71V7jS9wsgDjAlQ4juCE/pz3ZsHGKdp0f164sVt9wnaEghEU
 q/Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739204853; x=1739809653;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7c5uu1yLPOnid4qb59cfCziQR0prFTa8G6G5vQse1n0=;
 b=Z8GlSg8wHvhTbMVfayRvPs4/lxtXI/y0bjPQpI+aD1Cw5QdZsd1z05trwiIszP9vh/
 zzdf53qZSqfcgYZoCRcj+Kj8hDYYE5IgJUOkiGRr7XQVf28Je4M45boQZkGfdrqOZYe3
 xfprWvqT2MchmYt2znfppmsu6FEW+f5Fo5OnXZPQUbm+jzWeibqwKV9wHcLcofa25CMj
 pRKPUoMeVZQFzDS7IIqZyt/Qq/BUK7aGG4xAurWCi5eumk6U0nBS0+5pJo6QtYC5CcQ3
 hkyKKaN0XRI1JhJeK3aKj0FjWLvAXbwiYENx35eOaA6dJ22rwUCTGWQ3DaPmHtNQ0L8I
 s/Ig==
X-Gm-Message-State: AOJu0YxnTReau4Ui9CoGOpkcwLn9cE6liUWqVbszFlvInzIewqtSSIa/
 wgjtDQP9anWHXTH9euWJjsXbQZTg7mXW3fR7puLCFr1VScHRAotXISzc1NHBI4w=
X-Gm-Gg: ASbGncvp0UVnnW8mHbQaGhg6wLa6Yyix2ND/ctAtbmQzQ3Ob52vVUd69e4IKdOQdPec
 /YY6NvL5S2orJOjgEdlCRuVNJ+HXrJiE9d5pxX36/lkZytZaVMnPsM1l+qkYcFD/xABufFvjTDd
 AuI0DtSM3rHROaj1dUcrqDKPhwF2JDinJT/nXqu9pJ1h+/R/6aSCduvnLG9S/YGqELp30VNVBwR
 0zF2XzPY5km+wzPp4xnOf7wTs3wcA3E6FKZKuIfAbb9WoHfZJaAlbYqEBc4JMMfk8h36DpUxRQj
 FjPqokO36zpjFC543T2NZYCnqw9Oiz8=
X-Google-Smtp-Source: AGHT+IGMzXV8sJqFNINrBipSW87ZfYzH3iHP5H4AuGUodAz7XTVvoiruBnxJM7k50FESHOUXrv/rrg==
X-Received: by 2002:a05:6000:2c3:b0:38d:dbbc:3b01 with SMTP id
 ffacd0b85a97d-38ddbbc3d03mr5190425f8f.52.1739204853270; 
 Mon, 10 Feb 2025 08:27:33 -0800 (PST)
Received: from toyger.powerhub ([2a0a:ef40:1d11:ab01:7693:a594:d8cc:16e9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dd6080926sm6648295f8f.83.2025.02.10.08.27.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 08:27:32 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 10 Feb 2025 16:27:27 +0000
Subject: [PATCH v4 3/3] clk: stub: add sm8150 compatible id
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-b4-clk-stub-v4-3-f1e7d845f57e@linaro.org>
References: <20250210-b4-clk-stub-v4-0-f1e7d845f57e@linaro.org>
In-Reply-To: <20250210-b4-clk-stub-v4-0-f1e7d845f57e@linaro.org>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Julius Lehmann <lehmanju@devpi.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=759;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=Mxv8/JtvYAimZrcPTzj9h/t2wMA793CLnQvxY5lPNmU=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhvRVGh9mbNvWq//W+kTdIulf60+oan/nMvrzyMwvUvMMo
 5QX2/R5HaUsDIIcDLJiiiziJ5ZZNq29bK+xfcEFmDmsTCBDGLg4BWAi8w8x/I96HafyaNZ1dbuG
 tvlT4tYVp9ce/rDBYbVbfJB4fqBl8kOGPxy2T6vnHNZczed67lvirfbwq2ZhqducI8MuzzlmfCa
 z6gUA
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

From: Julius Lehmann <lehmanju@devpi.de>

Add support for sm8150 clock controller to clk stub driver.

Signed-off-by: Julius Lehmann <lehmanju@devpi.de>
---
 drivers/clk/clk-stub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/clk-stub.c b/drivers/clk/clk-stub.c
index ea817031fa6c0cc1ea21000273b5651be5d05e65..5fbbb07b7f7b93e619baf596064c4b3a3bfeecc0 100644
--- a/drivers/clk/clk-stub.c
+++ b/drivers/clk/clk-stub.c
@@ -49,8 +49,9 @@ static struct clk_ops stub_clk_ops = {
 };
 
 static const struct udevice_id stub_clk_ids[] = {
 	{ .compatible = "qcom,rpmcc" },
+	{ .compatible = "qcom,sm8150-rpmh-clk" },
 	{ .compatible = "qcom,sm8250-rpmh-clk" },
 	{ .compatible = "qcom,sm8550-rpmh-clk" },
 	{ .compatible = "qcom,sm8650-rpmh-clk" },
 	{ }

-- 
2.48.1

