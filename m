Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E0CC282EC
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 13:49:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91A59817D3;
	Mon, 17 Mar 2025 14:48:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vKF+VjZm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BA1D8081A; Mon, 17 Mar 2025 14:48:34 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4233C81A0E
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 14:48:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4393dc02b78so12802475e9.3
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 06:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742219309; x=1742824109; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5b+ZHfzQcwIlJqw/4Oc17X4EhmylAD6RUCQJvWke7x8=;
 b=vKF+VjZmelEz0SWlAcme+I+dypJuZtsA+qKDmobfDuFnM4zwveM+dvnWsqsUvZlg2c
 PBGLlHzkyqw3J9T0oiPVhXcxgyC4zs4gRmfNK+fQMZfsGeA1QPj5P27iTOfHZHxNIQot
 YWs+rVaDRoo2sRWIChB1Y2w3TBU1QhSLuE001QMzDNNCzV+IEMrKp/XR743CKb2oLTti
 O6qBKtWAtJbqWBNiohXioPXMBzVhyMn10KAITYvG5pbVfvCSRY6AqM1LznBenA0ElmyL
 wKRAh9JYtAGd3A/0+qKRjOTw6ws0qxGfiODqMc0vgzKBqtWAvGevjr6qgKs0O/EyTpPF
 hB7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742219309; x=1742824109;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5b+ZHfzQcwIlJqw/4Oc17X4EhmylAD6RUCQJvWke7x8=;
 b=Ovfchusp8HTAxkNIFWzricD50DPnQd1faEyZeodLM1XILm6B/deUKHGq3KZp+zVjWk
 3WSYI/qYkSW6Ri8+97lkCp0nbx/RZHQH45oj1l4qX+wMHZlgPzQeqOvG9+XgCayZleaP
 vkXrAGHkY2RGkR+ILSp8EyTL48KExmpt1HuXsTUfHtBnWyCbLQXgnGmMtuMl5ksyKVYM
 Dj/Qh2wwPOlsI2Lnw2kUbTD+0FkWLagstWWh6Pe5+2chm23zDt7mcxrdzUChggV4ccaE
 LdSW8ZXlqoqGuCjRks7XpooB6liziqAX++MQphNznH+FGwVIvxRsR0uSeziH90xWF0oe
 dctQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXy8xgayi/epDJaUDQvC++XEsVlNJm6JKNcg45JDFm9EWJKPOnjbbpg20F6GQLyPeHQFTbemhU=@lists.denx.de
X-Gm-Message-State: AOJu0Yy5MeuXw9Rlt2fNRlHn6lN9jl/IXS4KhHWSnw7p0cbl6BM8eNNV
 VoJJSffWyF6eP7nAmkLKDp54HOHe7Bb5sqop003eFOmaVytIeV4Dv+mDS9vG2ro=
X-Gm-Gg: ASbGncvGiMFcx/+Z1vG19ksBiVL9iw6jdfHJE/RJhJkQ0Hx3XU2/Ywz0av4LwlgdKza
 oUvogX/XThuC2mKGMw27g/upt9KTzyYgBRJ9aRY7l3lDjyhDp8DbuFxzc9S55kaD4z6RlaTVnJz
 Z4AxZJpdOoZw0YEuYQZxIo5PSvRduQynATRKQHXP6NQPjBDxlQ6i3m6QXubc9Vo1GCQ/eG1dlv1
 xo/XXwncpKVMw/TV7KLYPr28kvdCoY+waNdpTE11Sw8EDnsJk0rQ0o9klwlrW3YGuoF6rAruhx1
 +MWXr0WBufwFcy39BXrGiBEEA/L+QEW+xrtRrmsmUtEZDrEnxNp0eB93l1QW
X-Google-Smtp-Source: AGHT+IHWq6d5u8liVu8pWKSj8yIt07gRIoP9pIbhFX9M5idHrzwflmUN3cUpwlj84j4kvZAsJDnaJw==
X-Received: by 2002:a05:600c:3504:b0:43c:f616:f08 with SMTP id
 5b1f17b1804b1-43d23cac26dmr86229135e9.8.1742219308726; 
 Mon, 17 Mar 2025 06:48:28 -0700 (PDT)
Received: from [192.168.1.116] ([2a0a:ef40:1d11:ab01:670b:cd84:4753:5ae9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d200fae4asm105655945e9.27.2025.03.17.06.48.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 06:48:27 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: Markus Bauer <Markus.Bauer2@tria-technologies.com>, 
 u-boot@lists.denx.de, u-boot-qcom@groups.io
In-Reply-To: <20250122-pinctrl-sc7280-v1-0-8bdba72e6366@linaro.org>
References: <20250122-pinctrl-sc7280-v1-0-8bdba72e6366@linaro.org>
Subject: Re: [PATCH 0/2] Snapdragon SC7280 pinctrl
Message-Id: <174221930756.73541.997675939471317652.b4-ty@linaro.org>
Date: Mon, 17 Mar 2025 13:48:27 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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


On Wed, 22 Jan 2025 16:02:50 +0100, Caleb Connolly wrote:
> Introduce and enable pinctrl support for SC7280 and QCM6490, similarly
> to other platforms.
> 
> This was missed during RB3 Gen 2 bringup.
> 

Applied, thanks!

[1/2] pinctrl: qcom: add sc7280 pinctrl driver
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/51ec7fdb64b3
[2/2] qcom_defconfig: enable PINCTRL_QCOM_SC7280
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/77f0638576a0

Best regards,
-- 
Caleb Connolly <caleb.connolly@linaro.org>

