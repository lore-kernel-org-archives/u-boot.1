Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BAC7C4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 12:51:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A2EC87215;
	Tue, 14 Nov 2023 13:51:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ohX5B9dv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F5AC871FC; Tue, 14 Nov 2023 13:51:18 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EBBC8702E
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 13:51:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40a4d04af5cso22587975e9.0
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 04:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699966275; x=1700571075; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Xg0Af9kVs9r1ZRiVLF3z/lBzyy+MPSi0ag82lxRq9kU=;
 b=ohX5B9dvXkr5n7YNIn6CZpda21BvuMLRhGkA92fmCtxrJeXZWTmghCUIDSyl7g7W5v
 69clgzDJpNC6cgB9q7sb0Fu8rHHixfSh7CEj8FSPZJ+F9EtCgEOLV3mgiNfLGMWD3P+W
 N6iAoPO3KgGpQEKXO5sn5lmYUZrNDEvjdtBH9Qoimt/WiJu/N1tI428NmHrjCPcQwx6T
 DYbini9tv2n9GyqHGjwolOmmtOm1JOyb9bImwDSW6Yhf0l3x0o4gp2TNn9aAepDE8tHw
 lBom/5O20y3V6EPImoj6nJdJmXWZswHLs+TyduEyZPq4yp+FKlTbozXlNeefQn3pFeFf
 5tKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699966275; x=1700571075;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Xg0Af9kVs9r1ZRiVLF3z/lBzyy+MPSi0ag82lxRq9kU=;
 b=QuUGT+ncIp32zqrTnDv1lqZMdcUZqQZ24tu4krMouArGs5nZh/1RrAHY5m0Psps7Z3
 fCtPbX4Pai6REWcJv54lNosqtQMbNSS2HySgnvgXpnvqs07jRdhguUXj31khZzw8yRRH
 t/nnV9jM4n/N5U9xAW8ky46fuUFMAELig/M432BsRD8SvOGA1bQJtAnVJ+UBagRvK8uL
 rpheENIG2CoxbzhUTyEzi8VDgCtCQ+0rjFoiSjvfZqabg7b4nxrY6KG/BeRBsNX95Cf2
 Q3EajcH7DlZNYmrcFMrXigUW6c9cPOCscRgM+i+twZMOw0aCuc1nLlyLfQ/mwZ7Ee2gy
 r4Ew==
X-Gm-Message-State: AOJu0YzwXV0tdJgkQvSxGc6w5QWw6ecena1kTfzR3WDmixQiqNN+FulZ
 8zmn9TZEeirDKN9NxY/3waisuNlHkVGSWuS793xs7g==
X-Google-Smtp-Source: AGHT+IFS58TD/lTB4WP9R5/wNkaGq5siEvG2YsG5+Wr1YZYxgPNgbWPH7O9Zq6bXtusHAKFY/fWxtA==
X-Received: by 2002:a05:600c:474b:b0:40a:4609:9c90 with SMTP id
 w11-20020a05600c474b00b0040a46099c90mr8470876wmo.29.1699966275412; 
 Tue, 14 Nov 2023 04:51:15 -0800 (PST)
Received: from lion.localdomain ([79.79.179.141])
 by smtp.gmail.com with ESMTPSA id
 n7-20020a7bcbc7000000b004064cd71aa8sm11263451wmi.34.2023.11.14.04.51.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Nov 2023 04:51:14 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH 0/2] serial: msm-geni: rework oversampling and fix clk API bug
Date: Tue, 14 Nov 2023 12:51:10 +0000
Message-Id: <20231114-b4-geni-uart-v1-0-48c8ba9dda36@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD5tU2UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDQ0MT3SQT3fTUvEzd0sSiEt1UYxMjSwtzS1MLgzQloJaCotS0zAqwcdG
 xtbUA9MabJF4AAAA=
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=1468;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=oPW7p3AZbd10fNoDyTBQEqT0PQTAPL6a8bzJXaediG4=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtTgXKdrQp5vOu/H6e69XxHU9r3csfBt3JGrMk7z+E4bf
 v1wpPVQRykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZjIPUeG/6Gn4tRCfynu+aLB
 c+cdx6/uJwfmVHhw3j9yVDXqvK9qHT8jw7bbV7R57n//zGIbIqsY8LJJdN1pvYLNl+evW9T+lW3
 7t08A
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

These patches improve GENI UART support during init by implementing the
parent property read directly rather than via a misc device, and fixing
the error path when the clock can't be found.

In my testing, the first few lines of UART output on platforms with
non-default oversampling values is often garbled, this is because the
parent misc device hasn't yet probed and so the clock rate is incorrect.

It is simpler to just access the geni-se parent device directly rather
than via a misc device, especially as we only need to read a single
register for now.

Additionally, this series makes it a hard requirement that the GENI UART
node is a child of the generic geni-se controller. This allows us to
print a useful error if DTS is incorrect rather than attempting to
continue without reading the oversampling value could result in a lot of
confusion during platform bringup.

---
Caleb Connolly (2):
      serial: msm-geni: don't rely on parent misc device
      serial: msm-geni: handle devm_clk_get() errors

 drivers/misc/Kconfig             |  7 -------
 drivers/misc/Makefile            |  1 -
 drivers/misc/qcom-geni-se.c      | 41 ----------------------------------------
 drivers/serial/Kconfig           |  2 --
 drivers/serial/serial_msm_geni.c | 40 ++++++++++++++++++++++++++-------------
 5 files changed, 27 insertions(+), 64 deletions(-)
---
base-commit: f3fc930d775ef5c1b7b74b1427491a17680e66ae

// Caleb (they/them)

