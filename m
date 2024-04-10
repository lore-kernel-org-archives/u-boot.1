Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E998CD128A
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 15:59:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4EB088120;
	Wed, 10 Apr 2024 17:59:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="y+NE6vmu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D12B788180; Wed, 10 Apr 2024 17:59:49 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8AC581EEF
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 17:59:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-343cfe8cae1so4328621f8f.3
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 08:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712764787; x=1713369587; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5bF7/MiJCkwq5CSaOBCiJpw0J0PXrNdvXk5+PvabVac=;
 b=y+NE6vmuRVjI6fvr6THN/MPT6SSoIrOl+kYbiiZAWWhGqOhIimlN88mQU+CMyJy/1K
 /sCza2WWlYk33N5A6HoEo30YBNKLRgCjukRliuHMVybUs+eEZggHwu4UFVfCxG8y1eB4
 eHqBXRfZJFPmkEFDDsp2Rk878c2g+7TF/MjkT4PkR3q+H7GJY9ECoLMfU51N9YuAunWp
 euujhYiJniNgofGbnD/TqToZEDx1EUfd2Ebpf/0xdcb5d+vn2NvUbJ5Jx7nwwDVAZE5p
 H9vSDFVqcXZp8nnBWMxMMrkik3zGBOJdVtT/xi7kfcm0UeDiYythqq2KnleSKBcXlGeo
 MzuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712764787; x=1713369587;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5bF7/MiJCkwq5CSaOBCiJpw0J0PXrNdvXk5+PvabVac=;
 b=spuBL8lyrW4edyw70Lih3Myl/JTV8b3oSRmEkaBVq8lJFJtujvlfdzwYMmDMwxeJ2j
 ptULUlL1RnyGIVHwuquO3G05ufNFZ53SZXTlPMxx7HN+D5zq1RGaeT47jU1yRRGbajTg
 GO83hywvwJUfJC9FQNGc8tRgwFpxqBz0aQLZ2bEbNTbPQJXayosoNT8XAWgvKrtA71Ov
 DxFTQytOESIGlRW1wewRPhHxTPzr85q34yekm7eX4DOB3v0DoCtNFrRDUZpmS10uzXHp
 ALDBAUFJOaca/z3brOi65w5cyX7JqagSYQ8XdKJ+egpEOWvbNRB73gW0ponq9/TdeGsN
 ySxw==
X-Gm-Message-State: AOJu0YzIfxfRummBilEjMJDULJF+rIJHWePYpkju4HtZENO1jmUVMTYd
 ZLPOkEOSeB0bjQS+93QG0O78/oaNQzg/SlS43lHKcVO2YqLUTOfWWroE7WbJwXo=
X-Google-Smtp-Source: AGHT+IFIoEOZm6/tmXuG+X7J7gNbQJSthg96kEYpkwQURcNa1kw/F0lvz6IOBUXOyCyV13SpBCYzMQ==
X-Received: by 2002:adf:f38b:0:b0:343:d06e:51cc with SMTP id
 m11-20020adff38b000000b00343d06e51ccmr2088595wro.66.1712764786887; 
 Wed, 10 Apr 2024 08:59:46 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 p13-20020a5d638d000000b00343ad4bca7dsm14039431wru.85.2024.04.10.08.59.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Apr 2024 08:59:46 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 0/3] qcom: support SPMI buttons on SM8550 and SM8650
Date: Wed, 10 Apr 2024 17:59:42 +0200
Message-Id: <20240410-topic-sm8x50-spmi-clients-v2-0-783e20d66c25@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG63FmYC/32NwQqDMBBEf0X23C0xrW301P8oHtK46oImkhWxi
 P/eVOi1zOkNzJsNhCKTQJVtEGlh4eAT6FMGrre+I+QmMWilryoF5zCxQxnNWiiUaWR0A5OfBZv
 SKlNYS+W9hLSfIrW8Hu5nnbhnmUN8H1dL/m1/1uKPdclRodPmpi70cm1uHgN7G8M5xA7qfd8/I
 FiLz8MAAAA=
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1010;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=n0L/UOba6jQfpoEoqIoHN93BliQ4c6mTp0DQMCoG2hA=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmFrdw7bzysg0j/wusvqDwnvkHJNzySfglFHzcj8w0
 gE3CEx2JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZha3cAAKCRB33NvayMhJ0Y0qD/
 sHRdRwIpUvmsYKrhRkgvyfOFv8AMeF6GNK623VIvFy5YtrGIOkiBvOGuB9/eTgPj9xA3+zFQG52AFa
 ozOd2b5nYv73OHGGDWt7Izmah/org+SwBoIGBQkqW309C3g6PcdyKhF8sKZCZVlKprN7FkFXjWoxVo
 DscHLMnNVUltUuGnUQJOM7uypVhQcoN2VO2A9jq0NIlRjJYQ2mJJpjNRscyeoxrZXzojGJctkD6FTT
 d9IJGPYs7c6Pbph6cJVc0YailO2AL6pwG1nsm/3RQVah7xdh6kSU7kifP6AS71xVasPQEqL1m1XeR9
 M8BiEXgqcEosQljZF//dEfhAGIyOaKNddan4j2fMd4mvLtFBTRLA+S60GFpT+hhH64yVVfbS+Eb00P
 jYbPM4vRDGO3r22sZtdBUrClQ/D5Gk9uccTQI2nRpntP3HcA7xZoD4fceVLmJDNlwup5Zu8oKuK3IS
 gvMywXKlKSfSrCLNByfaykn9N7pyc/58IJlYBRTxbeC7AeBptVyRYm3LKiWRzK3eYINlKqN2wJK9y9
 stJzHZRYmgfBL16q1v15u/50RTgNTuuNeWO7dEjZg2qM3e9IWYEFqpDJLH4mL2U+NqW6/VtJeoh2X1
 tHhksZ5npbb5UN6UBxqbxGHTtnqNt5oGK2jxnvdjLHCeuM9gJALuYYCm010g==
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

First add PMIC gpio variant on pm8550-gpio, then rework the
qcom-pmic button driver to support data structs for each PMIC
variant and finally add the data for the pmk8350 button configs.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- added missing qcom,pmk8350-pon compatible
- Link to v1: https://lore.kernel.org/r/20240405-topic-sm8x50-spmi-clients-v1-0-c28603ebcf18@linaro.org

---
Neil Armstrong (3):
      gpio: qcom_pmic_gpio: add support for pm8550-gpio
      button: qcom-pmic: move node name checks to btn_data struct
      button: qcom-pmic: add support for pmk8350 button configs

 drivers/button/button-qcom-pmic.c | 99 ++++++++++++++++++++++++++++-----------
 drivers/gpio/qcom_pmic_gpio.c     | 18 ++++++-
 2 files changed, 87 insertions(+), 30 deletions(-)
---
base-commit: f0e6aba1218bca578605697eed8aa94582bf57bb
change-id: 20240404-topic-sm8x50-spmi-clients-d9a085aae979

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

