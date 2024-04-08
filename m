Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70B7AC67861
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 13:07:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E95FD879F3;
	Mon,  8 Apr 2024 15:07:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OwcEzX3A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 704BB8808B; Mon,  8 Apr 2024 15:07:21 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70FA5875E9
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 15:07:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a51d83fafa8so103729366b.0
 for <u-boot@lists.denx.de>; Mon, 08 Apr 2024 06:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712581639; x=1713186439; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GQnYPUUfoZl6JKn07Hm3NNG7elNz/aHqRKoRe9MU+wQ=;
 b=OwcEzX3AhiOGZaOq8zHhCfwMpiKMuEQpIAMwT6DHAz7rIJvIUjcWLhUU4XLYkexGq1
 842w2jWGs7ww/qqXRiHpEkyZ0UmLwBkV5zIkfQrCL3/0pDlvd8J6J870g4Rq5JnuB+tN
 x4wzE8pePso/4jluP5KJDtwAjkhl5AXzAX6MT3ZDQKvKlsVbVaAa8V5CIGmvoZQ6v5FU
 PU2Wz1gJWz5YiO6ESUJPLZCccMGC79ZdxEJSGC5Mp50XmQ276FCi+Ko46lGkkSKADfVf
 hloxjmeIXHYWHwSjDrwgl21KvHwDlfTug8evxAaN+vyhXIulItRu3orRN/pgSj7tlUjl
 ERQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712581639; x=1713186439;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GQnYPUUfoZl6JKn07Hm3NNG7elNz/aHqRKoRe9MU+wQ=;
 b=TXk8AynCs/97+MOIz3NJU3fAn/DI+md0yhI6+08Q2t+peD1aOAue+XSQ81M9hPMJz6
 Ix47ZJpPWeTOH85jcEB2LBkIW5zgme9hO/PAVy0D/EN/FmwKJlDdTDotZFNQuVY8KH6h
 ZQbXFpfEQNc8bHWYQTeKJDPpVMcRetVjfcaBfP3r+USb0iBz3TKCE59rS5JW7qJjTjb8
 RnXFpHELHbvwcmJxd0fJE3BjTXVsLZiApzFm88FyVyEMI5O0MX8xkH7y1mNescnshgSi
 jwqHSoHzNtvOda+j+QSOD45tG3KSmdF3rFEe5X5vPWvkC8RiSSf3rrLp+OQFbWmUa9Yx
 SEBQ==
X-Gm-Message-State: AOJu0YyMHUENGH1WC4ZDSm68yowkOcpxOy1ACRNS10CaG1XDZubkkqsA
 NXvQJ2wTixHTNiLkX4g/NmRldzuFprVdAm1R5R8KCBvpWVHFTWOUuCr57mDGKMc=
X-Google-Smtp-Source: AGHT+IH/EvbrhTggloCot283XLi+oH1IgjUdn9PEnjo4VDU6lYyeK1GePVAUrHKU5XP6VSvyeA/B/A==
X-Received: by 2002:a17:906:dac3:b0:a51:cdcd:5141 with SMTP id
 xi3-20020a170906dac300b00a51cdcd5141mr4140568ejb.73.1712581639088; 
 Mon, 08 Apr 2024 06:07:19 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::570d])
 by smtp.gmail.com with ESMTPSA id
 v10-20020a170906338a00b00a51ce37a708sm1998981eja.94.2024.04.08.06.07.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 06:07:18 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 08 Apr 2024 15:06:52 +0200
Subject: [PATCH 4/4] qcom_defconfig: enable clocks for
 qcm2290/sm6115/sm8250
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240408-b4-qcom-rbx-soc-v1-4-2db1d3658660@linaro.org>
References: <20240408-b4-qcom-rbx-soc-v1-0-2db1d3658660@linaro.org>
In-Reply-To: <20240408-b4-qcom-rbx-soc-v1-0-2db1d3658660@linaro.org>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=688;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=syfhv+OaBeB2yU9eX/b7ZApdQOzAdnvbntKngS39GQs=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmE+wBerMvM7Y69W/2MNZ1YdLfyz2+KPzSDL+Mz
 KxYDoB0+HOJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZhPsAQAKCRAFgzErGV9k
 tqpbD/9xhKPa9/COncQ7o2zswUS5JrvYChw/c1QQ0E8mTwaHMedfAh4020hd/+NvHOj6SHaoBKO
 /VDrA7lU5WB4I3vwR7k3HoHSbQfKh5pzTHFm1BbEnKhGumckby0W/mzCCOykvIkQWEO1QTcPkdW
 38YHMXArOvhJpkYxRYuKCx8gGAaLGUbsgT22gkw5B3W3VcC6QbW7I7Vn1Xr3Qo/17AG4ceP6fKw
 GhPVmNNUC3Ayi1GpFpUMZBXoLnT7F021TFkBrvfX2ZJN3ZeVOX162te9Ks4ejLQo1FyWZ9OKJgl
 k+jRakZmxIvAdnhuPMOiIWN9JWPTJFwYv81JNewd3axbyRzFb85w7/Jj2MMK9fIId/dW6PJttJe
 bjgnj2+tl3Fa98JltvH8eBDErLYu8neQrH3KDeuZwj9LPWgqXVBa05oTN5+85AdFY5S8daiBXny
 q1A2pDxN+Y5nOCzmNNp0z2vhxmfEkwT+cYJDc3+cd7ThW4R4Bsfv0FiKiJQgJXhsmNvN3srF+wK
 LjOGcKZp3JjthXky7V2b8JW+DxBfE/ANNCEUBFoTGrPulmxlHKk4DGlOctxKa/RxAb+4dwEj846
 EQqg65lHYGEa0bxi3n1Xji7fPTOA/5iJluXnyedd5QpeCzD2pxXb47rzXZEM6P/mUlGZW52C/+l
 DX+XHHVIme45tow==
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

Enable three new clock drivers.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 configs/qcom_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index bf3638be1b40..ae9c5b2461d4 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -35,10 +35,13 @@ CONFIG_CMD_BMP=y
 CONFIG_CMD_LOG=y
 CONFIG_OF_LIVE=y
 CONFIG_BUTTON_QCOM_PMIC=y
 CONFIG_CLK=y
+CONFIG_CLK_QCOM_QCM2290=y
 CONFIG_CLK_QCOM_QCS404=y
 CONFIG_CLK_QCOM_SDM845=y
+CONFIG_CLK_QCOM_SM6115=y
+CONFIG_CLK_QCOM_SM8250=y
 CONFIG_MSM_GPIO=y
 CONFIG_QCOM_PMIC_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_QUP=y

-- 
2.44.0

