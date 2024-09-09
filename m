Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5765ECE579
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 10:30:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E83EE88D9C;
	Mon,  9 Sep 2024 12:30:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GZCJ6i/L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A96DF88D94; Mon,  9 Sep 2024 12:30:40 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C227988D9A
 for <u-boot@lists.denx.de>; Mon,  9 Sep 2024 12:30:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5c2561e8041so4573388a12.2
 for <u-boot@lists.denx.de>; Mon, 09 Sep 2024 03:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725877838; x=1726482638; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Mi15XKWYmicpB8d0P38/d1YCpd8kNtO2VsH8ZAQ+ugQ=;
 b=GZCJ6i/L70fCFvSYDoSuPUQ0MBkrAgOlf6h9P0XzesUxQX53JPPjucKFjYNLT7gRas
 2zOXe5k9y8DDG0yTL+VZFy1kHEu15jRQyUttGb716Krageljpl15bGUNvVdRP3dU/jBo
 /yufOYn4G/8AV6RyVT7m2NI+2eR3XOqCwRL6mBVDB12XlHK5QMBydl9RTrmZTFbJx5U3
 LihpOxCJTKFyT/FYYgHME/7V2b1qOhPgvoiVK8Jlz+F9gYT5KifrZHf7cWdjpZIb+xl0
 LDfE0rWHmgx7gnSBH6CrMrCNIw9XbwzjKPgJfOA3oLAL30w3CNwoW/BgUUh5Owku2K8o
 HA1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725877838; x=1726482638;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mi15XKWYmicpB8d0P38/d1YCpd8kNtO2VsH8ZAQ+ugQ=;
 b=Urz1BKw8R3oJauqDICDcHgVAFF39Zhmn0VcZONs+GcJw9+MHnu4UWIENvcR7bXlkfe
 tC79xufF+fQp9FuIrmyWb/Sbtik8DHWHwoEPDu5I9CE6j405hSoA88ehxcaMoKEWtz6v
 ecaPV9IFiUKmlqJckbpDR8r2cAA6PZoPs8ddZLtWCX1EzQUQYhpvpMqR+qV7Kkl9MMT7
 w4oIKIXypyyK5cPd25JLs+O4ZmPne1pkyvgbK2sFD4MDMuTsRwzYKewvcTiVsxoHn925
 V5W42fM6oomXwHZCFbZYfUmryuXQjuTaiiKUY8i0DhRPq7Fpts1TNVLahrGWmrxMx5T7
 rgdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUItVri7N4p5o0rnGjaPUjzlPI5Ecb8r6MTPXEHOJ/0ue/nk5T77ZhUYf3xG0Dc2CdtBoEGvhk=@lists.denx.de
X-Gm-Message-State: AOJu0YxMD8oumYYZD5z82w9d0En+eLEBe3j3kUGhsc1Rq8INpl2PFNkx
 kIYhGgkym/HjckwPaknj1PCKhZlASk5OUTS9UxataDGr0fehVAZ6ZECFZhLsxd0=
X-Google-Smtp-Source: AGHT+IF67gVHCUZIgXJ9Lu+DcdX+NMvev9DXM05wF3yuti1bdkZ5fk61Ob5QzlLXgnyJphIGPoDdWw==
X-Received: by 2002:a05:6402:35c1:b0:5c2:112e:f106 with SMTP id
 4fb4d7f45d1cf-5c3e95354f8mr5028043a12.3.1725877838028; 
 Mon, 09 Sep 2024 03:30:38 -0700 (PDT)
Received: from lion.localdomain ([2a02:8109:aa0d:be00::8db])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd46733sm2822287a12.27.2024.09.09.03.30.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 03:30:36 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 09 Sep 2024 12:30:33 +0200
Subject: [PATCH v3 2/2] qcom_defconfig: enable stub clock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240909-b4-clk-stub-v3-2-ef09307534d5@linaro.org>
References: <20240909-b4-clk-stub-v3-0-ef09307534d5@linaro.org>
In-Reply-To: <20240909-b4-clk-stub-v3-0-ef09307534d5@linaro.org>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=724;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=S563xq/0B3eIs5xDd1khgPjrL40NOHgJDl9j8z56vEY=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhrR75zy+T734cmnAk5lv7FjeKdf82bj21D6lJu821ztyR
 c42Pb63OkpZGAQ5GGTFFFnETyyzbFp72V5j+4ILMHNYmUCGMHBxCsBETmgz/Hffq7/VurdkdV60
 8RVjaa4boedO/zDZ8X/jzDWxWXwR69oZ/lcf667MZ65I4z96Sab70YU1rIIN2d/NlE5+rV64xGt
 qgA4A
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

Enable the stub clock driver for rpmcc

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index edbb624baf0c..2e8422dc1a88 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -48,8 +48,9 @@ CONFIG_CLK_QCOM_SDM845=y
 CONFIG_CLK_QCOM_SM6115=y
 CONFIG_CLK_QCOM_SM8250=y
 CONFIG_CLK_QCOM_SM8550=y
 CONFIG_CLK_QCOM_SM8650=y
+CONFIG_CLK_STUB=y
 CONFIG_MSM_GPIO=y
 CONFIG_QCOM_PMIC_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_QUP=y

-- 
2.46.0

