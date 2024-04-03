Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A723CD128A
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 12:08:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FF9C88389;
	Wed,  3 Apr 2024 14:07:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fwnHO3GY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C2F28838F; Wed,  3 Apr 2024 14:07:54 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D48ED88367
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 14:07:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a51320fc5d6so55100066b.1
 for <u-boot@lists.denx.de>; Wed, 03 Apr 2024 05:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712146070; x=1712750870; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dJza8irKGD1LCWutbG2pawgU5HuytyqoLzmIGB2jhMo=;
 b=fwnHO3GYAn2CAuIbL8DdLWSSMGVT+tR5JdijB9eNKQHCus0SX5Bcq0qzXgIZ7wjobj
 Iu0JewLKVhlR5ggFXigwSk4N49x1xJHTeNgSWB3nqv6HL++uSCLPAgkUZUpp4DhCQI5A
 zy1omTBIr0LBuM8ygnS+5hEoQoQQWioMDJwURxrSX8/jjfNEmIPB2WxaFiHF5G4Me0EP
 1NDcTPN7McEBzIvPMyIBhJzQl6uYfEiFgO5gbfxWHZv8ccCwQ9mmQB87FF+ZVBakApxK
 hBeLES61O0u1szc5ryXmpYc2nGDHO3QNnEIpsh9k5Qe48pgAUIEGL4ZYQjOpjGdy7xfV
 ifyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712146070; x=1712750870;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dJza8irKGD1LCWutbG2pawgU5HuytyqoLzmIGB2jhMo=;
 b=iboQdB/XUQ1/RcorTySC72oGr41NDLSfEyiXZJmxCu5banoCuLocSs4NdtQU4dBDd0
 oBW5Wb4WcxqLbaQ8j2J2iFS46RD+JsGWkX+jr0OUEx3oQc1T+2OHJHfvCSry7rI5ykg3
 /x0pWMCrNne9Qf90913JjO/bIfLIbaTcEzafkaOkhlRG7I3qLYY+waJcYXC3G9osa31v
 UeurQj57qAcINxUGAl6oVC78qIcfnTjnAU/oiD4UUfCZN1lAYlhNGJvS2mGfRbgzUbcx
 6735wlLyTysHWv80MnOO467pln3iEppnMEg7awp02KpENJxDItaM1VztQiGm9LgOudH5
 Wh+g==
X-Gm-Message-State: AOJu0YxbEnTt5iaAIeXAfE6p9KhtJQanHRmt2K+3MwHWfz2ICOzFgkQO
 4XRlNU7fY+Y6TrtWD5mL+cd8wBMXtoHeYhj56Ctn3ez2ryss2+zAnaQBN89AV4c=
X-Google-Smtp-Source: AGHT+IGQCcKDbZK1EZ4wjhPKwQ6QBUtTZlNfidIei9rx11T2I+9pErK90YlS3j1OLD5loSSvk63KIg==
X-Received: by 2002:a17:906:46db:b0:a51:763e:b788 with SMTP id
 k27-20020a17090646db00b00a51763eb788mr460710ejs.40.1712146070341; 
 Wed, 03 Apr 2024 05:07:50 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::38e6])
 by smtp.gmail.com with ESMTPSA id
 lr20-20020a170906fb9400b00a46a04d7dc4sm7654674ejb.61.2024.04.03.05.07.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Apr 2024 05:07:49 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 03 Apr 2024 14:07:36 +0200
Subject: [PATCH v6 01/16] mailmap: update Bhupesh's email address
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-b4-qcom-livetree-v6-1-130f8f50b538@linaro.org>
References: <20240403-b4-qcom-livetree-v6-0-130f8f50b538@linaro.org>
In-Reply-To: <20240403-b4-qcom-livetree-v6-0-130f8f50b538@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Bhupesh Sharma <bhupesh.linux@gmail.com>
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=1165;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=XSvtB4NoCXg6pY1Nq/qGGGjasqOo57hNo8/eyKot594=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmDUaQdJWqOJj/3btMERubBnuE8mU26MvMG4hTz
 rjs1ma/V1aJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZg1GkAAKCRAFgzErGV9k
 ttItD/9zubcpV2vuUddY7HYzDoSXrRb+t9CcPRSgVtPoE/kxe+oNsAXkBKUgNO5fCp7vAy36G1A
 tNZ53fu/RLvVvWFlyY2JwIUR9w6vRbil4jyPKIOpAeF6hEC91IyqRqvsvENOGcRBtpBQZYds8TA
 dtdrKSTuq5R7L0OcqM3iH152tGJHEn3bx1gNWm5TpHM0REVG4jqbKSV39FT4gREC4O/VuqNrsvp
 jXf3QN+NOXy65n6nVwyFCQ7wQ6cCXX3xExn5VgrsuowvdJobK/V2MhOjYCe+DjfNWON4P7jrGgM
 ok9+dKbCxV6qlNmkSGCAQyddQcX8owBW+SM3XDo2EmUnR8kg/T0YA+GEZgFYS6nTKLaJG8WgB+A
 hI35RpaAgGTBbSud9hYxkFFf+lOaStOtA8elndG7/m18yNnhipzHq+INyOhz4BeLCeVPQTe/FVK
 fcZd0ZIUuFGJkjJtHwOOyGr+jYZo4VuT3i70crybJzaG/hOBrFqBlrjZjJo/ds7OjCRgCAdFFoF
 HWaxoOY2tGE49ROEhteYDh02Vd0A8CamZuX6Rd4m/55lRemUX72HNGHK+kVHk5HDU98J+WDf4ue
 rPOftyV+756o7CniwPMQ5pMoNZFTjGx01t+sIhkLU1hOppTRbh3atPDWTa9122hKlxHlxMvwK0n
 hrO27WMMH20YLmw==
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

Update Bhupesh's email to his new one.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---

Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index d1f08f3eca8a..f6e0847b2168 100644
--- a/.mailmap
+++ b/.mailmap
@@ -29,8 +29,9 @@ Ashok Reddy Soma <ashok.reddy.soma@amd.com> <ashok.reddy.soma@xilinx.com>
 Atish Patra <atishp@atishpatra.org> <atish.patra@wdc.com>
 Bharat Kumar Gogada <bharat.kumar.gogada@amd.com> <bharat.kumar.gogada@xilinx.com>
 Bharat Kumar Gogada <bharat.kumar.gogada@amd.com> <bharatku@xilinx.com>
 Bhargava Sreekantappa Gayathri <bhargava.sreekantappa-gayathri@amd.com> <bhargava.sreekantappa-gayathri@xilinx.com>
+Bhupesh Sharma <bhupesh.linux@gmail.com> <bhupesh.sharma@linaro.org>
 Bin Meng <bmeng.cn@gmail.com> <bin.meng@windriver.com>
 Boris Brezillon <bbrezillon@kernel.org> <boris.brezillon@bootlin.com>
 Boris Brezillon <bbrezillon@kernel.org> <boris.brezillon@free-electrons.com>
 Christian Kohn <chris.kohn@amd.com> <christian.kohn@xilinx.com>

-- 
2.44.0

