Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78926C36008
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 07:45:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D32F781E5B;
	Tue,  1 Apr 2025 09:45:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yK2YlaKx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A489081F4D; Tue,  1 Apr 2025 09:45:24 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96786801BE
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 09:45:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3913d129c1aso3764602f8f.0
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 00:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743493522; x=1744098322; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CzfY7RiiTttBlCJoMJ5fyBTUEP50uBYWCkKQ55b3GJ0=;
 b=yK2YlaKxHDG4SiZF5BZTCBuQ6X7bBzyJSNZZU1EKTvwhr6C6C6ggZqidHfZOmt8nRT
 s9T8B8uM1bbpowN7hmGf18M8oIiT0lmVOjvPBVh+VfYjnmRe6CzAjGfpvTeXb1waS0JR
 AT9S+/aoVkdj4Uus5msE5pKrHPMApAkryOqcwLwc0/myiMj7yzXNgYXP2Odleru51Qo5
 upyMXzM2E4Qi+OBbbUgCd56MmKVWZ1hgE5mBWhFrQUUDufzxq9pFudjkN8QpTNuiyVK5
 Nldy2zj9SjZdxPT7u1+AytfEgna+mI9y/30FMoQG3iOn/vh36MN7M44O8Pgv+VHzHgaA
 uhAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743493522; x=1744098322;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CzfY7RiiTttBlCJoMJ5fyBTUEP50uBYWCkKQ55b3GJ0=;
 b=bYBokewL7QrA+3o9hXPLiFgxxWQ+17Tsjtqz75jTXjD4uIXeTLO98hPUh4UfJYUAbU
 vmUD3XoaGCBm52wIHTjzq8pPs5y0tsv8JTIpioGm6XS9YlIO4e6hM3ZiMY8xSXWP+YK0
 5fk5CQ8Mekn6z5qpvWVHDcIsm1SmzRDcfyU1uBka2YFtIC7GrcfVfAMP90m+JwDrvpmm
 epdhkebEajTVxAkMqVtDuAx1IURPxBin+PMRv3Uxoc55RD1uLs18YMmac6kscDy3hxM6
 lHKQw+4D5aSsebhjipjc6XXOW/u3zJsyLsQWc9RiLc+/fsaaG+M070fenZ2kDSuJ33H4
 fjzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfYL9h4ncxUddx7NQ7xGhjQYzJFgwjpoCLTAwn+Au52Ha+Rz96BNt/hCWbv7Mra/NxbxehO5A=@lists.denx.de
X-Gm-Message-State: AOJu0YzaYmtXzua7lCltdwD1Kr3jSo4xAiyPkA4PaUGcAqYKzcHZ1E7h
 KvYFNwOXQ2MYN7tc3PLTbLmLnVNTScqoGgSnWahNRrP/zyaDWD0FKB62psq6X6A=
X-Gm-Gg: ASbGncs7Dacofz3wmX8rh+z9FKLo8zBM4BgbVvd8ADtFdMUgHcsJHA+YZpkYvf/lekB
 4XV+u1+7GLFZ41yqWZjDgeLzwnzP5Kweunmdoe0JJ9kDBvpgmoNylS2x4dRHtBW8/9aoM6BdwOl
 oWuYZzvVuXeMQivrTt3/HZfMAq6gQHzBG8a+8YfqQ52hilykI5eB5w5Qgm0o8EVgeCP9J0sGgdO
 q0iut+nB8SfOq8DiT+VxnQzenbZq6ShvTYN6AhPn4A0ci9BhkdivnXF1MfWzyt/655gjtG/lA36
 pxYgS/dVPx+UDsKZADHTTZ8PZhWbefeVCr8PoYUwv+/qitBt33YVwnVADyJtmC/heA==
X-Google-Smtp-Source: AGHT+IGVjeSE98hnYww5KbHAeOORTkQGBhj7B7mAeMS2vOIRhk/NH7L4wKXiBtNzCMWoSBhC97MudA==
X-Received: by 2002:a05:6000:4029:b0:39a:c6d1:c343 with SMTP id
 ffacd0b85a97d-39c0bf299b6mr13747549f8f.10.1743493522102; 
 Tue, 01 Apr 2025 00:45:22 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d8ff02f9csm148715295e9.26.2025.04.01.00.45.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 00:45:21 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/2] gpio: msm: fix special pins handling
Date: Tue, 01 Apr 2025 09:45:18 +0200
Message-Id: <20250401-topic-sm8x50-msm-gpio-special-fixes-v1-0-a1148a02bb16@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI6Z62cC/x3MQQqDMBBG4avIrDsQJRbtVUoXY/rXDhgTMqUI4
 t0NLj8evJ0MRWH0aHYq+KtpWivaW0PhK+sM1nc1da7rnXct/1LWwBaHrXccLfKcNbFlBJWFP7r
 B+D5OIoOHnwRUT7ngCnX0fB3HCRYDIXB1AAAA
X-Change-ID: 20250401-topic-sm8x50-msm-gpio-special-fixes-69baa84e4bae
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=635;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=i668oumj6ubGZQNlBEAiUKNnXueF/JPOlEjXajJgD7w=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBn65mQh5TM+f6BZ/+ctTaPTjPvD9l7ziwnIkit026z
 1RHClViJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ+uZkAAKCRB33NvayMhJ0cwaEA
 CLvwZHStu+fR8fNCyg5jx9HP9jWbYgKbb42ftTMhI3Ia8tGtgrDO7kOUGL8H12rRv6rX3GfhDAS3YY
 ZgwRc82cgs858Rk3NtkdREojrt7cn6x/xouOkE2izeeehZdfcV11y7QqR5W6ReOvx4QcVi7OZEp0oN
 aacnUyEuqgbR1PJoqfLX3WhTRN4ECtsrfKL3ykuWurwlCIw9UKOnUHo7ROD/D/IGQbvVpzAxPDRx0l
 TU//3zDADDfwrQPIUAIZoWQzUlImGNRlREo/VM1RIFj1KqMx2EetGhOmdwttflYrd1eKcxWO//lzPn
 pzFcAdvmz4xCzNBpq0rOEo2r0R5+hzo7+7yk8WpWz4LnNcvvQoE1PNvrEEfoF1FuSBzuAY6dE7RPDu
 eFcvLXCzRVeZolbgcz/431fjy860CuuAneEygW6ok8F8j2RyIbblvvi3wfHDFkZ169NfPmRIgb16G+
 0gnGz6ntTTZuPYjvA+KqYIcctIM2UGHnotQ+7MC09n5gTEkQq6D4nDbkoBD7Wnfw0ZxgRSQ4uuiOey
 X9QITpbvAvW2go/eRNIy3xyvjRRDkMIIZJ1BcNh+yspBaxBbJn3TpDss6o1/shhXC2ir2O1S4cvxF5
 gI6d+3W921C9n2p4AcOOaMuO6wTJQpdPMyCqdh5mKkVgauRRqB0V789c0e9A==
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

Fix special pins handling of get_value and get_function
to show correct state in gpio cmd.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (2):
      gpio: msm: fix get_function return for special pins
      gpio: msm: return correct value return for special output pins

 drivers/gpio/msm_gpio.c | 45 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 5 deletions(-)
---
base-commit: 5ca70325b64f760bf4190f206a0e88dda495e3d2
change-id: 20250401-topic-sm8x50-msm-gpio-special-fixes-69baa84e4bae

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

