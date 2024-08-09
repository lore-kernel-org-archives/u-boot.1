Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E2ECC3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 00:49:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 482AB88BC7;
	Fri,  9 Aug 2024 02:48:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DFWsasWd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 888B088B9F; Fri,  9 Aug 2024 02:48:58 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3383188BA4
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 02:48:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a7a8e73b29cso162139266b.3
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 17:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723164536; x=1723769336; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gUmKdA3keNnEz1rgLV6xOfK0Cqu1oWkwLayT3IpBx4M=;
 b=DFWsasWdcoTBr90FL+qVpp1PH3ak+ri522S1v/HRsVmJkabEMbf56dtqBM+Srgi6do
 5A+JNbJX4brEIcvqRnd/rMuY5kJHpbQPXoz9tLDl+YtsajFbiagV1hKpMLa1JSw2BpHk
 OmFz7q5Xov1CADGKPnHcrjn6VliNRzvL4gaDFypogzRUc5zbcstRyMQf0e2Ool5wXdqL
 FwK+XmnyLi/k2+Qf555bzi+klHTgBHqPdsFUmgABlbqx3gQDCEw3x+nwjlFG49qOewZP
 DChIDEtMJRckadWIolGojgH/Ezo9rJHhOCdQXmeY8a2NI29t0UWU/SF4Jv5kaa71o676
 FqPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723164536; x=1723769336;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gUmKdA3keNnEz1rgLV6xOfK0Cqu1oWkwLayT3IpBx4M=;
 b=nb9C3WeOHIbU0a2VUfJCM8ZOcMUlr+BR0NJuToyfxm6Wf+EBOczLDxAB+J0nGcG/jT
 Vmlg/n6erUYdJznDDmI5CQOkS4Wexfwu+labVO9y4B2meEK18wYgV42Upyzv8cLhn8nS
 La95eCPjsVhTDn3B22fkQoMq5nYPr61gcIZpPPwbig/cbMkE9J7fz5RiN8AqLjJKcPdP
 h20IoPhSp8pTjjn23CZq/cVM1Te46Is33KXq7amum/jvBJYv8e5dM+rUQRY9upL14ExP
 +tS2KpXolNgSPWTiRlr/gqp47aOtT6HHOc4/nPYrbOHyVl9/toCdZMOIg/Rz8gkzFuxy
 ulAQ==
X-Gm-Message-State: AOJu0YyxDbYuF1R/X7QF8pym7caJ1fzyHEjBebdzasxOYyT3jGCD4jz3
 5fp073KKKH6Nsxb9AftcmX3Kj4vUaiM6xPvVGcTCj71UdvgYpqjFXDQDlmmD9T4=
X-Google-Smtp-Source: AGHT+IElT/rYFf7SlmGEPMRjUjCpJlbADON0Ud5TzeYIdZfboihcnsFQXuZOeZrXqgjtDs2GUlqxJQ==
X-Received: by 2002:a17:906:f59f:b0:a7a:ca07:1de3 with SMTP id
 a640c23a62f3a-a8090f04409mr258110866b.56.1723164535512; 
 Thu, 08 Aug 2024 17:48:55 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9c0c9f5sm789811466b.50.2024.08.08.17.48.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 17:48:55 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 09 Aug 2024 02:48:48 +0200
Subject: [PATCH 5/7] qcom_defconfig: enable SC7280 clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-b4-rb3gen2-v1-5-7c73fe05b37a@linaro.org>
References: <20240809-b4-rb3gen2-v1-0-7c73fe05b37a@linaro.org>
In-Reply-To: <20240809-b4-rb3gen2-v1-0-7c73fe05b37a@linaro.org>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=613;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=bsVabFFdCKoICFHGj7Y59IMp0QbKFSpxIo/0rzdcLMg=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmtWdwqEJGx57FZggajsBxIlb6kXPNl/kg5plap
 UYncYaex66JAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZrVncAAKCRAFgzErGV9k
 tosND/9Z+DTgxRR7S+e+kjb224TkfcDRHIjc0b6mqookVmNHAFzE8Fhs5g49eJOOA3udYlI3ulN
 pFQ9new1MAumAu5YUCd/hQp8BPAVfg6bHOOxxf2JGUMZystXtFBI4oU9V5eAbR1sFRh/qgtl/Wo
 /6t35qM90lROsQG3CZpQjI3JiiK9ZO4/+JT/oPP+d5IwOQZYDvSnrxGOk4AqVI6mQrpCHzyx4d+
 0cWGxTClwedViW46UT+J9+6GN3amqP3Ze49SdMUzL2nosae255tOBo+6P/cThOONnWXT0Mx7iSH
 RZoCPQFdtYYEAdqC+PYR8zdrqemSY/x0T9G5ihY973t/HxhW0MPRsYpXsoL9BVf2gMOvWOC7Lxw
 SudCE+jHZHTVOFGHDyydeg+T6R+BYvsED85ejGujsEY+3KbgaooP3x0XHS3G07NBUireYtbxSza
 iUbqiM7vKrnJlFcLzoighL9KYvRrSAsFq6B7hMYiXxxniDI2dw42vr8jjqeOXlYDVemHXjVQZHN
 ZS2v01OaZb3RtzAEgvMK9R86/NJUIWh/nrPU/if8mxc/xGpxK2seAZ4jVgNSfj37KhppifAEiKY
 66fyrsLtG2cZrI61rkmxeZWW/lLwagZTTXvMI9jLl5gGFzkDimPh6yPVom/ZhwI3kpNhW48kRQ+
 XqsyXtIx+nEYVFA==
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

Enable clocks on SC7280

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 24b71ba7be29..1a079264a554 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -44,8 +44,9 @@ CONFIG_CLK=y
 CONFIG_CLK_QCOM_APQ8016=y
 CONFIG_CLK_QCOM_APQ8096=y
 CONFIG_CLK_QCOM_QCM2290=y
 CONFIG_CLK_QCOM_QCS404=y
+CONFIG_CLK_QCOM_SC7280=y
 CONFIG_CLK_QCOM_SDM845=y
 CONFIG_CLK_QCOM_SM6115=y
 CONFIG_CLK_QCOM_SM8250=y
 CONFIG_CLK_QCOM_SM8550=y

-- 
2.46.0

