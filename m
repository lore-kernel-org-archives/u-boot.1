Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDBF1CD1284
	for <u-boot@archiver.kernel.org>; Tue,  9 Apr 2024 14:49:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 519BF87D91;
	Tue,  9 Apr 2024 16:49:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jbW68ebz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37A98879A0; Tue,  9 Apr 2024 16:49:31 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DD57871A5
 for <u-boot@lists.denx.de>; Tue,  9 Apr 2024 16:49:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2d89346eb45so27957281fa.0
 for <u-boot@lists.denx.de>; Tue, 09 Apr 2024 07:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712674167; x=1713278967; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jcUvu7F9VQWJvhBSOtr4mdawuGkcnOi4sf9abOUiZKk=;
 b=jbW68ebzmmQkqB00ybuNuwOS60BRWhxwD9CYFPFFWyIhjuz1/2FFoknx4b95aEuvA7
 vtIiZru1YP5zb9LQIVTyHAeD6St+Wy3LsUaHKtJa9X3oot5Sm96ADSbhJOIL3K35Afub
 h/1KQc+z8I5goqjJY8bATCnzN9VYRRT8cVzgU5qOWta5I+VOAMkeHBhwg+7AeZ9GEQP4
 13eUFYmUIEVwv+bg5ZwjiP77QCYIZM/LWfHQKKk2S/ccmuyanGh3KAQcoLt2Tio6iFq8
 xCslSi0RuXe84RImi0IviACkoK4UpUtgdJSwksbPzCylXqky9+J4cQxwLCn+XuvJsWOp
 6h7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712674167; x=1713278967;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jcUvu7F9VQWJvhBSOtr4mdawuGkcnOi4sf9abOUiZKk=;
 b=JlBsSxeBZnsFq7SEwVH7+4fJP05eq9nrbkyCWh89HHFPF4UUKMQok0/IkRcERDiXTb
 CPA1eIPoZLGMzKxn4BXIHSTqiwaJd8NIoZGwpDcYnxTG+paBMgk9sNT9xxkvd/ZzjUa4
 OZU3+IiqW1gF0YgMXr/UwgcwA6bLN10BKvAk0m3MMYqthK8YtY0hUIsWeOg+AzqTb55P
 OmC0HNKR1b895rk4faJ1HpqMGYtZV+BOGNzRMB+qYj+AxDjC+JwfQdu8hcQIQuldVym5
 0nhhnouGAE/idWURZXELtqXrETNhdMfSL604q8aS8ocQrf+jYWQEbGEBJ3A/Q4uh9Q7r
 KVNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWR0WN6yDR0AClbmywPinwq55v1S4/W8bqorN96fmDLZaKDImK8D2Ly8KeqZTrOe4N5UsHNhGSRfEC4yg5+5uT0hcGecA==
X-Gm-Message-State: AOJu0YzsYPbdGqVCRJXC49gvUCmA1P8J3LWuFgnPQMjE9VUZ2e2MTGc1
 iyb5L9tPWwV/hTBlnTX5ZC6p4l3ctaIn1ddqr3z/Ds5JWBTlEnef9D8Js4HIrJg=
X-Google-Smtp-Source: AGHT+IHG99ewFutYw39kIdVVvo0sDFXiW6dHGqdZeXeej23c3RgZhjZgHUysZ7Y3cnuX95QvSmqpgw==
X-Received: by 2002:a05:651c:2c1:b0:2d8:2d0a:7b9b with SMTP id
 f1-20020a05651c02c100b002d82d0a7b9bmr44786ljo.14.1712674166668; 
 Tue, 09 Apr 2024 07:49:26 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::570d])
 by smtp.gmail.com with ESMTPSA id
 c27-20020a170906d19b00b00a51a00142bdsm5776947ejz.212.2024.04.09.07.49.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 07:49:26 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v3 0/2] upstream DT compatibility
Date: Tue, 09 Apr 2024 16:49:23 +0200
Message-Id: <20240409-b4-of-upstream-build-vendor-v3-0-f096de0c513b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHNVFWYC/x3MQQqEMAwAwK9IzgZKDYh+ZfHQ2nQ34LaSqgji3
 y0e5zIXFFbhAmNzgfIhRXKq6NoG5p9LX0YJ1WCNJUNmQE+YI+5r2ZTdH/0uS8CDU8iKYe7JU+w
 tDw7qsCpHOd/9M933A39Y6EptAAAA
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1951;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=prm3RbC4/mAwcJZYsjrasjsJlp7+FOXSP4ABHBsQsNQ=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmFVV1cpEhkVwbauaZgs9xieUW1IheMIYwLnWwy
 ERXOC3IjE2JAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZhVVdQAKCRAFgzErGV9k
 tnidD/93I/D6ax89GV7amYrEXil+CdyPMmsZ6hSWj+/UGln92cai0RA+GWU4HNAXxUXy1fxVDGh
 pwvd0aFx/c9HPjbQfy9xg5DoLTFXqlwtzSRniVpmn2GgLYbxMerTqt+BAlI9VRuY5CU33pLi2oM
 x052rN+2M3QRG3jlVs3Rm9MEZk+0QX7wHtFzfEjMprZs7pJpzRjtFzYE6CHEYvwkmkrDlX4mp1G
 Zli4ZqJjsLC9FwTtVp0g7G6sjwTD6vH/A5WVWwyg3Qsw7o+rqFgC/FuBBSePOmEpZkmY4yDOQ1h
 RUnD6mAff2U7qjkoGm5KgNeQSTkqSfPZcfQXShTznBjck7qrWsw/+36EJGBGsXW/YeOJCsyDPTD
 PtyyIom9jo3vZRU6FfPrPKdU6AU6ewwbV6kXha12hcUyLrJdi6MeMVw3VUfH341guMrnCo0LUcg
 +8dSewTM/tEmMtz3zre0QRwBy1SLqvE+iFbYmix6WpY6IHZTHV1x8LFi/scBEm3D4E+3PF1ZKhR
 +iOk6P/EwmVqpQxfw6xjwxyA2ErqsvshiqidMALMDqrPJvwaMeOS80LrbxXrMjFkZjGQ88a3EuP
 lfjFslh+AIPgBKLYIeWhGReVFgwaBOTY634iyxGbFnqGD4XAV7pwzQpnyK0gZlW+INrRRE231Hz
 LGH5htR3rk/hiow==
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

This is a subset of [1]. With more platform maintainers switching to
OF_UPSTREAM I didn't want to get in the way (it has also proven more
difficult than I hoped to remove only the fully compatible header
files).

This series removes only the dt-bindings headers which contain generic
data like GPIO flags, input event codes, etc.

It then implements support for building all DTBs for a vendor with
OF_UPSTREAM_BUILD_VENDOR. This removes the need to maintain a set list
of DTBs that can be built by U-Boot and opens up the possibility of new
boards becoming supported "by default" just by landing their DT
upstream.

[1]: https://lore.kernel.org/u-boot/20240321-b4-upstream-dt-headers-v2-0-1eac0df875fe@linaro.org

---
Caleb Connolly (2):
      dt-bindings: drop generic headers
      dts: support building all dtb files for a specific vendor

 dts/Kconfig                                    |  24 +
 include/dt-bindings/ata/ahci.h                 |  20 -
 include/dt-bindings/gpio/gpio.h                |  42 --
 include/dt-bindings/input/gpio-keys.h          |  13 -
 include/dt-bindings/input/input.h              |  17 -
 include/dt-bindings/input/linux-event-codes.h  | 806 -------------------------
 include/dt-bindings/interrupt-controller/irq.h |  19 -
 include/dt-bindings/leds/common.h              | 106 ----
 include/dt-bindings/mux/mux.h                  |  17 -
 include/dt-bindings/phy/phy.h                  |  26 -
 include/dt-bindings/pwm/pwm.h                  |  14 -
 include/dt-bindings/spmi/spmi.h                |  10 -
 include/dt-bindings/thermal/thermal.h          |  15 -
 include/dt-bindings/usb/pd.h                   |  88 ---
 scripts/Makefile.dts                           |  13 +
 15 files changed, 37 insertions(+), 1193 deletions(-)
---
change-id: 20240409-b4-of-upstream-build-vendor-dc74b4f72e9a
base-commit: eb1aaf535683880a4ac3517fc568792fc20cfe3a

// Caleb (they/them)

