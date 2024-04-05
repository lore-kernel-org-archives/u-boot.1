Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF37CD11C2
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 08:15:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9911F88489;
	Fri,  5 Apr 2024 10:15:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vejRqtbd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8FB388485; Fri,  5 Apr 2024 10:15:18 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2AEB88483
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 10:15:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4162ec14805so4044355e9.1
 for <u-boot@lists.denx.de>; Fri, 05 Apr 2024 01:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712304916; x=1712909716; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8kRACGqO/kH6rcXblm5SndTFfh0xEjNz34Gips+G2YI=;
 b=vejRqtbdQw8ETLeoKiiHw/AejriuwciBIsBZ8EWm8PXcCMPGPwLUjKbQe0I4cHxhKH
 qRagWdZRQ5o4XYX1927KNC/Sbi/HEZ8D37f+rpI031AJ7e6AW5al//E7jP2Q8BkYDWl3
 V7VSUMxvpXfmD71kry+LGKWfdH2wsvc6MZd5BGJisGUAPlxbG4h81PVT19bbdNiXhZLM
 67Y+KGcaJozILgw+40E2xuomEw8PM8GbdzcOMZ9cBtQdruLTOR6SUAaDUR3uQwTy6NVk
 O/Z9o3lxe2I0JuMsElq9wDhxLm2/18SAjZ8WMNUBsEi3OYwFYUNkpZQqqBLJv5YV9EGW
 B8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712304916; x=1712909716;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8kRACGqO/kH6rcXblm5SndTFfh0xEjNz34Gips+G2YI=;
 b=vvkE9n0ZS2OZtjQnzRL85DZJXhXEGTPNP4JCJiF+xPYDpDRwiXlv8DAqxZpF8YfB6f
 nbiMga7gGoC58YM4oIp0p4dNY/S6VE6IZIFkcMoQLdPA6br8pOYRgNAvoGh+mlw8gN5E
 DtqmkVCJg5almukBxk5qh+x+iJk+Tzlh18QEtOHmvavLgn3wOb2dgMIiBMH9jIhEGsyU
 pPLV6ROp2DoD7AXX1dC8IKkrH2Ym8fc2LinNZD134Y8YaJq1IbDVxRxNQYTUUACKCPNz
 +DdAjEdgllyXwxxK3eELggJqy4u/CRYTzMQozMlCeQxrTZ6Lw7fqvpflpleUJrzkutSa
 Ad0w==
X-Gm-Message-State: AOJu0YygpfpNQ5HxnY/F433m6D+KRYZhepchNVZ5zovWXRfq4yJoY/Wi
 6JAWESBiwNB39dQz8fnzcA61+R4Ib6lfaMJ85HZGiGPLIr+aTjE0nZx2ffR7L3o=
X-Google-Smtp-Source: AGHT+IFrX/V6nTugyxtb+aWK04wKBxPN0yxjtsVtndf0axZLDfxLzot1AF9CRbmV6bvkbYR93SZUVw==
X-Received: by 2002:a05:600c:6a06:b0:413:f3c4:4d95 with SMTP id
 jj6-20020a05600c6a0600b00413f3c44d95mr775996wmb.10.1712304916251; 
 Fri, 05 Apr 2024 01:15:16 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 jg24-20020a05600ca01800b004162d5233d5sm2034407wmb.42.2024.04.05.01.15.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 01:15:15 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 05 Apr 2024 10:15:12 +0200
Subject: [PATCH 3/3] qcom_defconfig: enable SM8550 & SM8650 pinctrl driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240405-topic-sm8x50-pinctrl-v1-3-92d563c28c90@linaro.org>
References: <20240405-topic-sm8x50-pinctrl-v1-0-92d563c28c90@linaro.org>
In-Reply-To: <20240405-topic-sm8x50-pinctrl-v1-0-92d563c28c90@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=609;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=ftkCu5SnSPhvzn0864yOAr62OD2UyHqBhzDLvUv/NTc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmD7MRql6/dyuXQsX11ioTddz6jMw5w33aGWWQz9ly
 AO3sfHiJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZg+zEQAKCRB33NvayMhJ0X+IEA
 DA6H5X86EFr2rJ6AE5mPVJWQWutvsSZLNcJlUDrENuKYpOVJ5xWeLsFbFGSWUHuX93f2euBv2SCnSv
 Ymnl4KvFEPSDpPX11EqV1y1KJUuI4mYDyyijKfmkUWmeOKhv6MU7WG4aC3yhJquPKANb5AKttmhsaY
 YIY2FESgityzr+wrkVT+3QdzjSL3klJAfxnDByUk1Whl4TwGMnMNPduaiCIsjPoD6NUqcBxY0odXOv
 vWJfbMp2XCqV5e8LhLWQxkECn5mZkvuGufHxLdV4hsuSFyNBTh4g/vAW4ctqt0Y2keJqBNiVx8RYeA
 /8I1jyIRNVyyzX7G/1eSUVMYsKHkJHeaSk8LD8QHM8LAPFYBFOKpz7VTNQVZ3QmUnbJek1zq9Yk36v
 NsO1Jm3fhEkv+L1xHM/5bz8OlkmwiEl6nWCIbl3uTPqj78idejyJPfXowXl+ansjcQjxnr2aCrX6Z2
 3bUTp1NLAlKDN3zLMDnpX8ZxF/Fxc32PCgba17RjpG3wH5OuWe46HvaapecjWaubvze2kvGXSnl+Q9
 C6jfKbQrBYA21cp2RJyna2InGwvjUh13++0VXblBTlFfyqOWzle1THAWj4YFq9ZeyHmaYzZOHgwvQx
 14lC6YuxAoM+2DIBDg82ODQO8UAES7FKbzVI+NHd+itayuQ1iG5rPg57EIzw==
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

Enable the SM8550 & SM8650 pinctrl drivers for Qualcomm defconfig.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 configs/qcom_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 222db6448ab..a92b6ef7911 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -43,6 +43,8 @@ CONFIG_PHY=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_QCOM_QCS404=y
 CONFIG_PINCTRL_QCOM_SDM845=y
+CONFIG_PINCTRL_QCOM_SM8550=y
+CONFIG_PINCTRL_QCOM_SM8650=y
 CONFIG_DM_PMIC=y
 CONFIG_PMIC_QCOM=y
 CONFIG_SCSI=y

-- 
2.34.1

