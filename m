Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1952BC87FCF
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 09:17:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AFAF8449D;
	Thu,  7 Aug 2025 11:17:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zAO7fuE0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FCC18449D; Thu,  7 Aug 2025 11:17:03 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36CC58449C
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 11:16:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3b7910123a0so634691f8f.1
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 02:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754558219; x=1755163019; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5VIj3QtQ+AEenwlDLcz+MJAfM9HjT0ZrF34bSzCkYHc=;
 b=zAO7fuE0eyHDIpVSHSyYOE4S5aU5SgIggRQd8VHmruXd2O9ePf0qdWyuIAyTsn+Bre
 A8tJZDpgXOR1UYcFx6DXAfsN2cxwcgkcA67UP3krcNCRD+ErrgxkSDsvK2bWJ4ErMwZt
 Po3/QaohwVI0+v4XfMaLeKIO6yKXPSOYADHZoppgny3Itl5j0PH5VFOgAOXVwzLEU3Q4
 Ug6b/lHDkpTBvLZCaNCZgowHYnzO0ItUSRCuU021oprRIhiL+reRmf2WGNzwbcfhS6o1
 2bn2wdpv2W3ezWMN9TX/NVnlUjCnxh23VR08h3vQxEbIyYVsz6RASta/lLosBWIfel2l
 vX8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754558219; x=1755163019;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5VIj3QtQ+AEenwlDLcz+MJAfM9HjT0ZrF34bSzCkYHc=;
 b=c4Rd1Zcl1kwV70SAz2lIwZN++My03W56980YGl351/Y77RdmmiMWEi5F0UDZdnOWRW
 5ADNjSi62axaoLM55zy9pRPpvUDN+GNttW2EaxKFaPRg4i1nFv1k9vwr3bcR21IFqjKo
 KRB2UlWiQmhLlhY66K5Qs8d/R/djavLLq2Wdlz7yOxKy44aztBMjjpJJ+P8ae75Nhqoy
 VCJljjsJgDc6xxTPAuKXBgsCHcGzLhKJebM+GZNqPI0AxDCC5M1iX9XJayMy/WO9UGPf
 3n2j5nHbwJQ2BReyhizauUUhJ5Wpxv18MqbszaigJXNcr1/mSYfT9F4DngB6rpDwxY5f
 u+Kg==
X-Gm-Message-State: AOJu0YyOx/nxtQNnTNwhRcWocfERVV/KD7DgiSbV1MK+4mjm+4Xb6iuU
 5eeMckyjDjTC5DmTuOSyzUvWrCaPCUO6C5YbUuzeTPOb2RO+sWFT/LRJU1oeehruMNo=
X-Gm-Gg: ASbGncsuuyYK0i2Gwg+c9mWcyMD/kXPQNm1444drvsA1Ll7XC6eQFrazmAVE7yELQ3Y
 +fdTdAKKb/2VbjxNbqrthio8lhFg8klAuWj6Jl5XKEXzE9ebhU826IeLjzFNklsvprd4ijAhUhI
 1z66tIMGelcWbG9qCLNcLwyzuYsQMjThNllm2u9pbNYshuw0KpklXie153FSkDWkqaYxcTVVwG1
 9lMjQakJnPRux5bsK8100MseuAmJvVsm4YiLVKyByJL5jywbxr5khpKrZ++0zNWdxY5cgOreIN6
 zIzOGn/h3qbP3aFIbZvAkrEhpZAHv5HTy83GlUqIYf2Je2xcV3RsR9PVbjMmtpzIfAQiy8Yn+fj
 drKnaMHC5fSd9736Y6mraDdSaYVggphNTkxKF/n+RkHt41anPkJQ=
X-Google-Smtp-Source: AGHT+IHrnrOo+cW5KaAgr6VyONFnB+n6MQxoiDmeNJ5vT4LZoqBJQpbmYn9D9jE6XZLrZZhTa9NJQw==
X-Received: by 2002:a05:6000:2410:b0:3b7:994b:840f with SMTP id
 ffacd0b85a97d-3b8f41bf9b0mr4663825f8f.57.1754558218523; 
 Thu, 07 Aug 2025 02:16:58 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:377e:cf4f:d0ff:80bf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3ac158sm26501633f8f.4.2025.08.07.02.16.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 02:16:58 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Thu, 07 Aug 2025 10:16:55 +0100
Subject: [PATCH] pinctrl: nexell: Cannot test unsigned to be negative
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250807-pinctrl_nexell-v1-1-6f49a0656510@linaro.org>
X-B4-Tracking: v=1; b=H4sIAAZvlGgC/x2NUQrCMBAFr1L220AMNFqvIlKS+GIXYiy7RQqld
 zf1cxiG2UghDKVbt5Hgy8qf2uB86ihNob5g+NmYnHW9vdqLmbmmRcpYsaIUE5P3fsi5dxioRTE
 oTJRQ03Rk76AL5BCzIPP6P90f+/4D1kXLqnkAAAA=
To: Stefan Bosch <stefan_b@posteo.net>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

In s5pxx18_pinctrl_set_state testing count to be negative will always
fail as count is unsigned despite receiving the return value of a
function that returns an int. Change count and idx to be of type int to
allow the test to work as expected and remove the need for any implicit
casts. Also change pin to be u32 which is what all called functions
expect.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/pinctrl/nexell/pinctrl-s5pxx18.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/nexell/pinctrl-s5pxx18.c b/drivers/pinctrl/nexell/pinctrl-s5pxx18.c
index e7d0994f29e..a6ae5764fbc 100644
--- a/drivers/pinctrl/nexell/pinctrl-s5pxx18.c
+++ b/drivers/pinctrl/nexell/pinctrl-s5pxx18.c
@@ -130,7 +130,8 @@ static int is_pin_alive(const char *name)
 static int s5pxx18_pinctrl_set_state(struct udevice *dev,
 				     struct udevice *config)
 {
-	unsigned int count, idx, pin;
+	u32 pin;
+	int count, idx;
 	unsigned int pinfunc, pinpud, pindrv;
 	unsigned long reg;
 	const char *name;

---
base-commit: 3526f990b77fca1c933f1d8b24eb9385010a05bf
change-id: 20250807-pinctrl_nexell-bc6669ff52e9

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

