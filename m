Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EFB2C4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 17:24:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 283DC8869D;
	Thu, 18 Apr 2024 19:24:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YjF4Ke07";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5ACD8868D; Thu, 18 Apr 2024 19:24:33 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1E3588690
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 19:24:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-344047ac7e4so1440499f8f.0
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 10:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713461071; x=1714065871; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AKk1HXynJELPsVsKzwXRRlp1cAx2xoVp94ao9pwKbDg=;
 b=YjF4Ke07v8DvkIA53rER2O5WoRJtYGNHuqJfgR5sNLObhrXZcWJxoYC3SSms0wgRgC
 3P9uC4D7K7DroPXUrhXtxk7XE8CJlQJmTfDFHow9Xt8zImtnmdQluolb0VSxgw9Tt3FU
 8nssqVigQmzGs8J+13n60QADK5Kyyr5nIzmvZO4N1hR7hXPttI5qpuyEA8PWUSrnmhhN
 Nie8xco7RVdSIJ0RzUtGCGwdsBxBC/eNuc6TQMIsteA1gvXBHs6rHL4dSsCiTBxdhftS
 wXu2HNJ/DUl04TegK4q9eXQhxRr67ZG70WV/yqvsA6q1Ad9yeDznA66IvjllnYMX9/g+
 KAIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713461071; x=1714065871;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AKk1HXynJELPsVsKzwXRRlp1cAx2xoVp94ao9pwKbDg=;
 b=Ww3+HwnbUq7QAVM6yVxUhbuQafSHHsqmYNITXUmjtUEVCeRIs7IvMkDrUnxksFzhpI
 ZWD9xo+2X+zAkHg4LlujMlEuABQiymcr5hlwA2OrQUsS8dVcQr4/FR2nwrJIAIlMnBNP
 loDXw6BfBfykT3Kn7y4Ndjzi7Oy7cPqj89PPHLthnjpyPvgzb9i4eFL65eywcJc9taBz
 ezWSborzB7GHRDcCk4YT+6OipVZOD3Rp3fxkZ9qnzqVAh/z/dO/RJ3iz9CWNerL2Vp7j
 lAEOTRRjTc8DZ06xSkDd3eMhvqQxuanL3w05fYucZWEAEy5vvBQFfP0c70uMJR4fDWvL
 lWHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEQliyXggyAPrLYYMNpdgX+gTXXFFfTxy4QxRYYkH9IWUsw4LH1iMrRLZy4MLmyFVmmV4WVZdQH5GB2SurqcegePF+4Q==
X-Gm-Message-State: AOJu0Yyu5PA/LysBdFj8iZKjZv2HOvtpQntfHl24wmbhyvETiktUtzVQ
 ZJmDoPh2e95aOownqBS8bPpHnnQ6izvfqdrfxQ4ORgsE6GM4ZzI3IbhtgS+xCC0=
X-Google-Smtp-Source: AGHT+IEguAvC0r6sF04KTNhvKGiRewVjXgpZun1h1APmpwAMoZCA0gtk1dXG5/mA7kJiCH9MCSFb2A==
X-Received: by 2002:a5d:598f:0:b0:34a:3e3a:ffaf with SMTP id
 n15-20020a5d598f000000b0034a3e3affafmr569437wri.0.1713461071325; 
 Thu, 18 Apr 2024 10:24:31 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 e32-20020a5d5960000000b0033ec9ddc638sm2301799wri.31.2024.04.18.10.24.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Apr 2024 10:24:30 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 18 Apr 2024 18:24:11 +0100
Subject: [PATCH 3/3] qcom_defconfig: set SYS_INIT_SP_BSS_OFFSET
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240418-b4-qcom-rbx-fixes-v1-3-e524eb29ae86@linaro.org>
References: <20240418-b4-qcom-rbx-fixes-v1-0-e524eb29ae86@linaro.org>
In-Reply-To: <20240418-b4-qcom-rbx-fixes-v1-0-e524eb29ae86@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marex@denx.de>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=659;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=+DrL5OT8uZAQkNDq/x40/GExjdlVo4KiZn1LUniI+eA=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhjTFcK+N4WlrJlnYPfiZ87RcZG2a1eUJlrdDdUJ7EhxeX
 DzJt9Opo5SFQZCDQVZMkUX8xDLLprWX7TW2L7gAM4eVCWQIAxenAEykz5GRYZfZa+uUFbaPD2q6
 /DZIzpzSf9skwHTXnFvBkQZMxzuueTL809/6QOrAt3v3PL1uKfYf8NA3lfqduiXUK/e21Wu/sJS
 ZDwE=
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

Give us lots of room for the appended FDT.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 218a9a769682..7b589f0bf7a7 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -3,8 +3,9 @@ CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_POSITION_INDEPENDENT=y
 CONFIG_ARCH_SNAPDRAGON=y
 CONFIG_DEFAULT_DEVICE_TREE="qcom/sdm845-db845c"
 CONFIG_SYS_LOAD_ADDR=0x0
+CONFIG_SYS_INIT_SP_BSS_OFFSET=1572864
 CONFIG_BUTTON_CMD=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_BOOTSTD_FULL=y

-- 
2.44.0

