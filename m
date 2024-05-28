Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DBC4C25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 08:32:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 090D38844B;
	Tue, 28 May 2024 10:32:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sOFuKkr0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C08188445; Tue, 28 May 2024 10:32:03 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0070E88402
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 10:32:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4202ca70289so3950165e9.1
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 01:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716885120; x=1717489920; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0ArycN0QT0TaP3jow08wKrVxnF6CKy1/87pBzkaMND0=;
 b=sOFuKkr01RROqPGBVnlxeO/L+SWISEhBxY6ilATSoYEUuigW3An8nVAiTpoKUAjdG1
 RuIqMAhs+pfjl02Z2tYef+e06Oj8/jcAGiMremjwl2ze6JHtQ0LeNIFPIDX/GG3ntffd
 Vg2mCnOoSB//RuPv4XPp2j9cKhv8W5P+0K/0TA5akvKFcB2KXECjtRn3wzem531aolhr
 EPORkHT7yzgYAs9zCt5g+JTCaSEQQo4Vp/gHqH0ywCCCLhIqYIdRfrH8qN70BIJIDRvT
 LFTMrB138gjRxut1BBWkDjggcXLc1xMdx+U3XTX0IxLV63lg2spDRYrYhk7jl4fmeOe8
 5KFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716885120; x=1717489920;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0ArycN0QT0TaP3jow08wKrVxnF6CKy1/87pBzkaMND0=;
 b=RfDosUtNOvtalVOfQloF8dj2nXEt9+CZaLh5cF75cNGgD50uaXZRB5+/IIeUaN/Lvw
 S29X6OMEOt15vyIjNfdcAh+8xF7d3jnPbAGU+khU0lm42L+W/EXYZRtakvlqW9y+t77r
 4r0uFyF+HT7QHrnmYK4KANxAVYn4z1MBVG1nSyqRhJOCvDrTnXJ8irPxryBWU3bgZIdz
 Tghzz/rc+nIJHHacuFAWRzIVjbvTY66BUK6xVYU/7+LjOtBvHxxFhgLyqfYfgrR+Gt6p
 hKJYaxXCcGbepOL85yLCJVLWbmFO4geHAat01NflZBIr4DYRoltPV0dfyFMjj7Dl1PR3
 ZHPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSL5HvxaVviXkceNzIunkkjU981wdhNWK45YepF6mpLmi618QShm0fjrW+6zCUBn9b3ZIuWq1+43mp0lEf+T9m5l3fmg==
X-Gm-Message-State: AOJu0YxfRjUBMimIQaDND/Dq8SIafpXF4GXjeqoqZWAchKZuE8KFrMVE
 J/9yApIQhLbAXDGr2/4vktU+1xPs7lA5acFEG2O+Craecpy5SZJgYBFjBbFNGo4=
X-Google-Smtp-Source: AGHT+IFLjHMr8nzf4qObHzymk2pcA/+dmKbv/vSaHsmGICkKdiCqmR3XW5RGvmIvo2SjQOp/0n9c0Q==
X-Received: by 2002:a05:600c:6b1a:b0:418:ed23:a9f0 with SMTP id
 5b1f17b1804b1-421089dc44cmr87569145e9.18.1716885120196; 
 Tue, 28 May 2024 01:32:00 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42100ee7f1dsm167122035e9.7.2024.05.28.01.31.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 01:31:59 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/5] pinctrl: qcom: allow setting pins configuration for
 sepcial pins
Date: Tue, 28 May 2024 10:31:52 +0200
Message-Id: <20240528-topic-sm8x50-pinctrl-pinconf-v1-0-54d1e9ad7dfa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHiWVWYC/x3MQQqAIBBA0avErBswS7KuEi3KxhooFY0Iorsnr
 T5v8x9IFJkS9MUDkS5O7F1GVRZgtsmthLxkgxSyEUpqPH1gg+nQtxIY2Jkz7n+9s9hqVc80dbV
 eLORFiGT5/vfD+L4fLJMz/W4AAAA=
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1145;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=LXsTu+X1EAX/TsZtrsG04qPiAoJvKR6/UQr3MkOCVTU=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmVZZ8GGG0gbTLWTtSCZyCihNVjAkQixe1CWj033o7
 C0WCLoeJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZlWWfAAKCRB33NvayMhJ0ZvtD/
 4wD8nyU5pHZ/KupgYzA0JAJTMlL9TjjOHX7G/VXWZOh0OEPdFnKOBJK7nglho0gul5ENQN0GDBd7Bi
 teTIO14JzBK+SDceEte0ZE9PcoFa/9VWiBE67tLEKnaS8TJiPy2f+DcSVVdycEWJKuvuVZl5VxTo7k
 M452ctHLv30SjcicBZokQn5Fs8g3jEV9wZ2iRTdTUpQF6hdN5WNBnyxKSUxQO3YdloJu87Lk+y5nJN
 4p7j3aXfXK81zywimsoeDWN4IwA2Zno2vz+EkoyYICo7rRlSbFhIzsX7BTx+xWIziqou4K/jP8g64T
 7kRKwQCL7cwEdF4S7l67q+Tod+IEbIa03mZSwJwTDEbk0QpQJpX/AOITj19REzjvJ3bhNEfpFFbN2n
 RFtRdXC3sWgTDewxAYKupMVJDA3W5+cCZYYKuhMbFi77yuy808ymxIev9Zbv5asegTKs2/FeMJN0G3
 +N3iaSI5MtVaVFMADpho1g2LXlHFX3CKkTtS/id87Rh7pVbcZkHhhiyoyF2oxSvXvhbXupSFu01FoP
 cIwuAlbQ8qauLknVup18wGKHF4BrEErDPckih9JZgQl0ppU7A/O5CbrU6U14g1svwHq1I06AoL7PoP
 P1kyIndRAiyCPdYk7SqI0lnqdzaC0UjHfIkzOiq+zDXRuISF+cL9ua6We4pA==
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

Add the msm_special_pin_data and implement special pins pinconf_set
for the SM8550 and Sm8650 SoCs.

SDCard support requires this in order to detect and use the card.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (5):
      pinctrl: qcom: add support for bias-pull-down
      arm: mach-snapdragon: gpio: introduce msm_special_pin_data
      pinctrl: qcom: add support setting pin configuration for special pins
      pinctrl: qcom: sm8550: add special pins pins configuration data
      pinctrl: qcom: sm8650: add special pins pins configuration data

 arch/arm/mach-snapdragon/include/mach/gpio.h | 16 ++++++++++-
 drivers/pinctrl/qcom/pinctrl-qcom.c          | 38 +++++++++++++++++++++++--
 drivers/pinctrl/qcom/pinctrl-sm8550.c        | 42 ++++++++++++++++++++++------
 drivers/pinctrl/qcom/pinctrl-sm8650.c        | 42 ++++++++++++++++++++++------
 4 files changed, 119 insertions(+), 19 deletions(-)
---
base-commit: 7e52d6ccfb76e2afc2d183b357abe2a2e2f948cf
change-id: 20240528-topic-sm8x50-pinctrl-pinconf-7853bea938df

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

