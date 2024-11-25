Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCFC7D58D69
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 17:13:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E481B89A3E;
	Mon, 25 Nov 2024 18:13:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OonBbbiU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33EAD8961D; Mon, 25 Nov 2024 18:13:02 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF6BD89491
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 18:12:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-434a2f3bae4so4366555e9.3
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 09:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732554779; x=1733159579; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5ikNlsr/DyG1NHQwLKQZibbM4r/skLXj1kvl8s3ycFU=;
 b=OonBbbiUVqOoB+OeDp+Ce97Uq9be5tEcjwbl8ZXbREdbzPHoW0BPMQFu9+DoNSAFsx
 APUejPGuXhTclzcoYFptmD8dhth2GjKiN6Fim0arUmoXP8vOgI9BfORL7askVYE79EJR
 yovtOeeZ1H76x3xd0iFv4DhhwFRlsRl3kioXeHxZH38HGRQ2sOI2mUsVvgZifuwcOt03
 Lwmv2AiCfHBKw1LUVNExGVJS8iYKDkkMDUqcREyknTGgvSr2rUHCFHsqJ9L1aAAFhyA9
 G64pCrJnuWwocp8yZ8kPuDjwp7RRTqq4gwOywsaFN7WMDyn5agpozK6oA55eqxsiOJN/
 qyDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732554779; x=1733159579;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5ikNlsr/DyG1NHQwLKQZibbM4r/skLXj1kvl8s3ycFU=;
 b=Qof2c4b/VWlsIZPTKHBGHUyXzmsUsFz0gGtk/OAMjFk660Lw+b3PLiObrtPCasFIGI
 yOCj5ydLxkjwp/8K/dLu3Kph5FYsYVzGIiSXFLZUThARylH/y758INY7efLxI1CjzrBN
 6TtVwkJ+4HQBiDjyc6BEgOcsPFtDnBLg+7uDX/atAEPPoxS6QpBdq6dwH4ykQ3W+xVyB
 pJG44d8MDppx6YjOQq7wuFOmKGWt2N9RYXsgl++1+BBgebd2/a/s0+On+Q4gXk77Qm8d
 lFS7zCtiYbcGtg8KxVcxfrS/6uRVbMfydhmLq/GpW+SqHUDBgbUxBvq9QorC1qzm4PeB
 zBSg==
X-Gm-Message-State: AOJu0Yzcc8f97zJW9EI28aLzuw9LAQL4tWcabPIPPkDwEvlPZ8YLayyX
 FUixAcpgyCOrVNfmuL58TcDLNoFbcpoKhZtruVKIalZVQachwW8vl3NfvlHLOGE=
X-Gm-Gg: ASbGncsxaB0yE+kz4I4bLhwb572gidIeXfoXTJZHlYL6h7aIJp1Y9WbEo6WfyaYl0Ul
 GO+93aaN4ComIKzR3p1IC+UxsTXIC6WTFUl7sFoJXVqXHGfWTx17dkky9nzbMgjMXlWlERpC5kf
 ueij+jZT+NNzZf2MgmPDf3Ih+sC2VefVTOyKcrWoc+m1AuZg1xZISqQ74XE+UI5SGRK2nTpzDUx
 2qKmRkyLc7pXLXLqPm3ecDUmtTt1EzVx89WgvCwLn/ZDJ5OeDqWcIraS80K4cHUHidBXFg=
X-Google-Smtp-Source: AGHT+IHxSkqXKpPLUTbK8aA7v49XZ6U14nTw1Yxf2eZrUda/baQYLIm8gTSwnGIoS5fkFUBB1UH8Hw==
X-Received: by 2002:a05:6000:4802:b0:37d:4fab:c198 with SMTP id
 ffacd0b85a97d-38260b69dffmr11972118f8f.26.1732554779381; 
 Mon, 25 Nov 2024 09:12:59 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fcff017sm10919419f8f.108.2024.11.25.09.12.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 09:12:58 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/2] rng: msm: support newer SoCs
Date: Mon, 25 Nov 2024 18:12:55 +0100
Message-Id: <20241125-topic-sm8x50-rng-v1-0-52b72821c3e9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABewRGcC/x3MTQqAIBBA4avIrBtwrOjnKtEidLJZZKERQXj3p
 OW3eO+FxFE4waheiHxLkiMUUKXAbkvwjOKKwWjTEJkWr+MUi2nvn1ZjDB47aqzTmkw9EJTsjLz
 K8y+nOecP7YkEkGIAAAA=
X-Change-ID: 20241125-topic-sm8x50-rng-714cd0012391
To: Robert Marko <robert.marko@sartura.hr>, 
 Luka Perkov <luka.perkov@sartura.hr>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=698;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=i+jQ0s02Gc+xhwz73ZKYjGJbRDxvjUuoJDVr8w5+Byc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnRLAZzNZzn8lF8ZNYWNLouWGZ49tctiTtxc1Xg8zj
 Di9I88GJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ0SwGQAKCRB33NvayMhJ0ahXD/
 95PpwsbV503kuqes7IZYONaedt9BOZWj+tjXgU7irTi4O2S6fl5zSuIRul4oTZVlf6IiVxCVpjFe1q
 /vo6izElJ08SUo5iET3bOyS8U2ROpC+d7+M0utYynq1ZOGuTi+oYhcKtsqdgrVHupVSmBt7GAhHfN0
 0xrwmC6IKZjPkXfB6dF88f+hlYlCwS18acMToGF9/riHbwGJxyI5RUPwwaiytog148xaxHxiEe9IY/
 LR0d/bZI687WOD+iexHhVq1hL7ATetB9D8oA9Ys7GeUHRcQqP5uhqZtGuzH96vZuFz7WRRIhmy1GL7
 lI0xUPfrj64yfntU9LctNkBnX9ctrKVTXRChi64f7IzqOOtLM0n4QjgLT8ABwS9dUsmF95GucUg8z9
 UT3fO2ncn+cUiI0NGPZgELd6BIdTFOSlYjB+CK6GzXNOImXK7xTU2xwsaICtSVZN8mDiGbozbgOlqW
 7grohsvlhmxg9dXviB7VsXOsXED4aA7ji1sl1JBhl3Ul0uWeGZPr7gkeEKrmhMIzXeZOIXYX30yRhA
 6oaS1FeB23UeFzlpNcgrlJ83QnIGVEj5NzMSUiHIBL2JuA2Zh8YCBjfdnqHruMyMFr9jA7i3QV/7AH
 DAqiWz8QGpOp7TxMMDjD52Io+TjVczDaDt0EL6Km+He9xuu8OINok3EiLPtQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

Add support for RNG on newer SoCs which shares the
RNG hardware between different Execution Environments (EE).

Also enable it by default to fill KASL seed when running Linux.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (2):
      rng: msm: add support for newer Qualcomm hwrandom IPs
      configs: qcom_defconfig: enable RNG driver and command

 configs/qcom_defconfig |  3 +++
 drivers/rng/msm_rng.c  | 13 ++++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)
---
base-commit: dc1859f8d2ac3faaa5e2e1d465ec4bd8980520a5
change-id: 20241125-topic-sm8x50-rng-714cd0012391

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

