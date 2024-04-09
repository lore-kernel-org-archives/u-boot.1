Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EF91CD128A
	for <u-boot@archiver.kernel.org>; Tue,  9 Apr 2024 18:03:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15A658817B;
	Tue,  9 Apr 2024 20:03:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QNa6ALX3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C48B88172; Tue,  9 Apr 2024 20:03:13 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FD4187F24
 for <u-boot@lists.denx.de>; Tue,  9 Apr 2024 20:03:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-56e69888a36so2976795a12.3
 for <u-boot@lists.denx.de>; Tue, 09 Apr 2024 11:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712685791; x=1713290591; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZgEG3rmw2m86fm+snm16flsW59XHaQ+wiKwyMIxO4Oo=;
 b=QNa6ALX3seQCPLf2+fWRHGYYqbCsKqt78z53IqXo24QPZ/ISr2gV5y45OXZYgKdSdx
 6ocQ6i+ouXgSSuIJQeibUrzMmSBQKByv5Uip6yfpGJu/nTwUYVJgLEu8MWeUuYn7A5MI
 gtN3Nci3D+SZEjFfGY69vJfFCicepWmnrcIG/M57TSN7F6VpT9clpOGhrLY7CjrPLoZn
 tJvSpp3S7WkZ8ykbDdTJMVHxdoLQIqQ7CZ1ttVl1O01zFI5C1APtDUmMwb1S94/L5gm2
 gPVA/dztX6SHgmwVh9oZ80QYyjozBCD3pUg0iMXK9Mbzd8mdGOiUmOMzBXMI+G4r6E8W
 LT/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712685791; x=1713290591;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZgEG3rmw2m86fm+snm16flsW59XHaQ+wiKwyMIxO4Oo=;
 b=FJfBdaPBZxunBkZcggPA7DB/AnUbZGkcB/a7/sKdcNLHoUIx6dp28feW7SawFUIygT
 Ysu5uiK1Wjo1Kd2Em6cBXj0MZwa9ifKd1zE4N8kpOba40QWfO5MiBq7YpOYtG5AQvFq+
 1huDWDVzQ4M5sUaZBSAPCtTf1eofbvE2qTfVIpq6KdvJkGatfAGnFEXjyoZC8uJPLFx7
 VXv7A9wM9u3L8W60JXxL2TdBNtqq3Zq5azr61Do9IgDfUCbqxam0jEexbR7kgLfkI/ZK
 D9hqiZpr+PIj1tjqi2MeAa2L7ZZBn7WzbSv9y8ib5eotxz4qaRx+3Mgck7BZtcZAqSsr
 knpg==
X-Gm-Message-State: AOJu0YyGX+5772IM2WkC/A9+ue5BUBU+Zi1L9i0PGD2DhPXXkv3w+wqp
 EE5aKc5Fr9PRnO0idmsQw5GUQ6Q2a5nj0NkLmyD2BvlOTSwAz0MVQUSvPZfDDDM=
X-Google-Smtp-Source: AGHT+IGirUAFI4X9YmxAu4iH7vI4Ic2woRQqt6bu+Wwe0D4NR0kXFwxtaq666j6TDh8pJYarMwfMHw==
X-Received: by 2002:a17:906:f28f:b0:a51:7b1c:bee9 with SMTP id
 gu15-20020a170906f28f00b00a517b1cbee9mr113460ejb.25.1712685791169; 
 Tue, 09 Apr 2024 11:03:11 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::570d])
 by smtp.gmail.com with ESMTPSA id
 d4-20020a170907272400b00a4e5866448bsm5928783ejl.155.2024.04.09.11.03.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 11:03:10 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 09 Apr 2024 20:03:02 +0200
Subject: [PATCH 3/7] mmc: msm_sdhci: print core version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240409-b4-qcom-mmc-fixes-v1-3-5039164ecbf7@linaro.org>
References: <20240409-b4-qcom-mmc-fixes-v1-0-5039164ecbf7@linaro.org>
In-Reply-To: <20240409-b4-qcom-mmc-fixes-v1-0-5039164ecbf7@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=721;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=sDXDePlQ5M1HOT4v1jH1rXmnlYmrOwy5I5iKM2kamzk=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmFYLY6DkWzkeQsDVIUh8fQK1f4IxoB/s7BkAeb
 ajP/UwbyLWJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZhWC2AAKCRAFgzErGV9k
 tv2JD/9S5szF6MUP6V3wUnJg4pE42iifFmnLmWtw+1pIz6IyAavJkeZ9Q6BNSoy+MXnAkC2bwPQ
 OAIwYtYw+NJbJnIONH10k5VYW/FxIx+VPNFN1y0zLbUZfXk5/xVNrX7csAYGRX2wELeUfF29LL9
 n3SWaPQYhCwaDrIJftH3hKfCrBHLT8pct6xvRxXWxqCSk1UUrvGZulHJPudvI9rTHreAnZc4cob
 zMFML7vCcAbgAH0EZ4KgzS2hrt5JGoUY9WPzv5xf4hK2FqoiYW76moq1RD2dPVVA2ZUE+v5ilEF
 RDibNu7uRKWb/+osoEHNA3zM2TWBeZ1dm4h3ZkaD+nJMxXfrot3IRZ4aeBroXl2Mkj3gubu9B49
 kWxdt3uRflJck9xQPtzuv2Lbi3Mh6k4FJlkcMohMYU5Snbuc1Cnx+oum5E3bghCUasAvI1W9JS9
 r7bh8LTLUnmMh062U0RQ+MmLCgSbjYpxkTsFpoaxYVPz/AA+CNgt37NiLjUuQkV4StL8otTsiNq
 UinbFR4e4LdzCxYwT+5svTRYuZVzwAkFLwVh/sQkhPrqfwFN+KboOJQayiZtidCAoaRB3sIJK5T
 mgK6QOhduZLpgxgmpRXUuXv0mgynBME4TXqdPRP2ihXBHDPJmGZy7F0IOvaJ5ENTbNrjhMZsf38
 VkPBynUZ6zHz15g==
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

This is useful for debugging.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/mmc/msm_sdhci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
index 5689b4765122..ea5d6b4cbbee 100644
--- a/drivers/mmc/msm_sdhci.c
+++ b/drivers/mmc/msm_sdhci.c
@@ -172,8 +172,10 @@ static int msm_sdc_probe(struct udevice *dev)
 	core_major >>= SDCC_VERSION_MAJOR_SHIFT;
 
 	core_minor = core_version & SDCC_VERSION_MINOR_MASK;
 
+	log_debug("SDCC version %d.%d\n", core_major, core_minor);
+
 	/*
 	 * Support for some capabilities is not advertised by newer
 	 * controller versions and must be explicitly enabled.
 	 */

-- 
2.44.0

