Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5919EEE499C
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 18:07:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC1E788ED7;
	Wed, 11 Sep 2024 20:07:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Uy8evf3j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1600189305; Wed, 11 Sep 2024 20:07:21 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE9BE88E83
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 20:07:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-374ca65cafdso95866f8f.2
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 11:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726078038; x=1726682838; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0DrxfZmwHQ3cnfO2MPjo1p1tMDvYMJ0K6H1TTyo0WUQ=;
 b=Uy8evf3jrkvwEvx2S5ZD0EpDvxM5FCWx3IzsvWKDg4P/zpX49vaAqZhphybKzNWy1A
 LXPbDTg5yMjXOuwoAGfXwomeJB0tSOy6Nz2UOYSQ2bw1Cj9yz5hV/6XKektYQZSk4FMX
 MasBI6Ac4KziLgbSXDSEx8A9Ma2dwxKPlWRRAZGCjcdk7ME/Zqa1kn42WQKwQ54XuVYz
 h25drqGQx+zAhuNPOpQBxBO6QINeDAwJxNiGfuUZcv3RE2Xf5YY/bnzjszZz6LVcAfpd
 0KfNaAliKLnLElaLYiyMOqC2iwJLq9lbBjC0vorVMoT7TZrHMdLFiQIX0Et5OQ5yL9+F
 Fs6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726078038; x=1726682838;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0DrxfZmwHQ3cnfO2MPjo1p1tMDvYMJ0K6H1TTyo0WUQ=;
 b=fKxtnWrbp8YSVIbmtwV3el/7HzZYVxYjrcWW3ESg7Fm3ho0HSH75JUtEK6ioMobaBg
 83S76bc+RKQGih+vJps5CcpAK3j0BJwg5pamRlcwRN32zCGZKkhQw2nHPmOWcY0z7iEo
 2js0YAhouZstq2haNt3O4T34npfs9YX6RpRrYH1d52XtvGkHK5N8qOFYDaGNGfuSTWqw
 YUjQhLmt5DHg8erRcwMRU+pRPuVL0oKm+J2qNQEPj4K7zcBsQk/R3kki/CypXYeeXW7w
 FbYFu2haSR+WzMo4nWVsnBI3hT1SrVanS8N7bOpjtv0DfDwv3D7Z3kXZXbD0vWne8rRh
 SAow==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPhzF3CUhtdjB+b2YXYKw+jSfjRunEdMaNmb5J/8LbQrsaK7KY+j434Qf12l1zLGEyZdgIn9M=@lists.denx.de
X-Gm-Message-State: AOJu0YxQp7/cC1ozoCF2nsLWVcnZY05WVuo7bHiwkPKPjDOxLPPblR2O
 Qnj+x/T2fEWu9y/dircbLwyoivjnQDnLd3zhl/HlQbVLmK8awyDDy3xMyn3HUJdEmE44tt3w68B
 i
X-Google-Smtp-Source: AGHT+IF+9nETDWChHXJ6S2uRpXx9MHWnhYo6gbEa+2nHmhuqJOE+W0NJ6eOq579C6opcscI10LJVsw==
X-Received: by 2002:adf:9c89:0:b0:374:ba3f:ad08 with SMTP id
 ffacd0b85a97d-378c2d5584fmr43062f8f.55.1726078038013; 
 Wed, 11 Sep 2024 11:07:18 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37895675b8bsm12192404f8f.54.2024.09.11.11.07.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 11:07:17 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 0/2] qcom: allow msm_gpio to set special pins direction
 & value
Date: Wed, 11 Sep 2024 20:07:13 +0200
Message-Id: <20240911-topic-sm8x50-msm-gpio-special-pins-sm8250-v2-0-c49834055128@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFHc4WYC/52NTQ6CMBBGr0K6dkz/UGDlPQyLiiNMAm3TIQRDu
 LuFI7h830u+twnGRMiiKTaRcCGm4DPoSyG6wfkegd6ZhZbaylpJmEOkDniq1lLCxBP0kQJwxI7
 cCJE8H1JnWVtjlHrZyqAW+S8m/NB6tp5t5oF4Dul7phd1rP9UFgUSSnnTxt3R1kY9RvIuhWtIv
 Wj3ff8BQSE+1OMAAAA=
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1111;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=hYjxmsBeM1pWtR5y9r0UIYPxsVZs3aqD1dKg7xI192c=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm4dxU8ZgWN+SIDT0JFENml6Ox4hpQ+C/KcU9M89Ua
 BlHE+j+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZuHcVAAKCRB33NvayMhJ0X73EA
 Ca/YJnVN8Qz9FmXOdSk7wTzfjxLg9mteKt7snusJGaH9OF+BpiEmwhaY48hLvoeaPNIHMaANeljZfk
 pZjEgxhVsTzahCaa3iYw2Wa2xjRnpUlUwz2tye3F06Qfwhmq4cMtt1HJAw6QaAV06dAcT7p6aHfqWL
 nF/Ofn1Lnj2BMCM+GHSpcE5o3m3FOePPLPhutldbe6U3VyR+Wfye2eFRD0qq5FxF/OR5M+k0AuG89y
 cgFu36EGBZ0OB6zOvG9cU/VU4q3rjW+JoAa/8O47/RKQCkix/9UQD/LykeW/zvpV2uPdYTilOTV8cj
 9cfr50YKQl4nSkxnqC+ns4ZRMBR9c/DEcHWEFdV+kGrBd2iMkXAFbdg8fW3HqvryqPYJtUP3Lzdgad
 NZT/JC3LH1qkNveMzzRtJ4RRlgLxIUo2bzkM/Se+Z4wqIpYyS0qtNMxnNnZ0eW4nl9UG1Z0E8JPAbz
 SzuTPiVA2Yu/Fj37GjHbZgaz7luhNP9dq8lReXzV81izdkEOmem6eOBxgLgmuLiT5l7eehEiym7xox
 uSl1XybkZCZRG+XMe2oKLKxkhnD3IcflkQLTAg1RjdDN98kzrkAj3iOKgIv3K7q3PW8iI4r9mVYTZs
 wpoA/Lh9zlvpRTknWowDV4hFaRixsbcTmc55auhyN1aghKH3eOkp3MTfj9TQ==
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

After struct msm_special_pin_data was introduced in [1], use the data
to setup the pin direction and/or value if supported by the pin data.

Add the proper msm_special_pin_data for sm8250 after sm8550 and sm8650.

[1] https://lore.kernel.org/all/20240528-topic-sm8x50-pinctrl-pinconf-v1-0-54d1e9ad7dfa@linaro.org/

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- dropped last line of sm8250_pin_offsets
- Link to v1: https://lore.kernel.org/r/20240910-topic-sm8x50-msm-gpio-special-pins-sm8250-v1-0-50623a7e4931@linaro.org

---
Neil Armstrong (2):
      gpio: msm: add support for special pins
      pinctr: qcom: sm8250: add special pins pins configuration data

 drivers/gpio/msm_gpio.c               | 97 ++++++++++++++++++++++++++++++++---
 drivers/pinctrl/qcom/pinctrl-sm8250.c | 42 +++++++++++++--
 2 files changed, 127 insertions(+), 12 deletions(-)
---
base-commit: ca55cf8104c0dd78aae45fa66dd8400ef1b3d0ac
change-id: 20240910-topic-sm8x50-msm-gpio-special-pins-sm8250-943311b483e2

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

