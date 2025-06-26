Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55106C7EE30
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 16:39:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE2E382E5A;
	Thu, 26 Jun 2025 18:39:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YCMJyvM4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9066482E08; Thu, 26 Jun 2025 18:39:33 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1C8D82B34
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 18:38:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a4f379662cso1083456f8f.0
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 09:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750955935; x=1751560735; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=H0PGYBzstd9/Qo/nzkuGLGlYcNlQlUTQIB/aZ3ewJAs=;
 b=YCMJyvM4ZjiHCfVEhp1WM638T/di9hvQwZrZhJMsMtVeDHm6wRM1E89nLMn8NhbZ2t
 5g90QjjhurrAyuh3Ga0U9Agx7k1GOabDYUTz2wajjGJr1ezTdQD+XqkWC1jyELEIHm9i
 Y6w33ysgnPCY6I45kY1BN3sOtpUxyLvqZlWBNhd53cEEKhix62vkKQYv2JOSBRGDfAKM
 yCLUVMoGaPuexZW4vY0PncO/rxRaU0wM9V95YA7vWnm3pNlORPckfsE8FumvmA/DH+Mf
 Ia9a0f4Uvno/mvXS4J7ztDXsYo8huzVqxoz1MMGHRx0xgJaTYi9r2E7SCu8M/SHlE/Z9
 iM5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750955935; x=1751560735;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H0PGYBzstd9/Qo/nzkuGLGlYcNlQlUTQIB/aZ3ewJAs=;
 b=vOU4kulcC3J7hQYVfYgJYfYTcyThmMWKPMiI21CdPmzfjObJaMqhExrM12fnZ6Eblj
 reziSSwdTidpF6Z5N9e7T+aqpFvhKIfQaNC/K6r7e+5x7zJt+uCXUd7lZ/FR46RA9D8V
 0SFT3/z6CSOzajgxp5GF5jZzn8GWLhOzjgz4KasxSPb/X8/OfCvHtfYPYCISahxyqAIT
 y4NF+yYf9xgjedq58iE4UYXpPME9OOnYMSCd/VXgcsc2nlEZT5BEK2DMntGVnq2LA8IM
 9DVShy9d7gAOUYdz1vHuHQSRNWXH7W18d2S1qQ6b62a7tP1EA+vQ7motpQ0BiryvY3Dp
 QMqQ==
X-Gm-Message-State: AOJu0YxaI6cwf9UA2CtoHtwvzS16LFKIQRC1sglmq+7lf5KDLb7bLXTX
 hO3xWyGf18iW/cIx3kV5qPtVFv3Ngnleo3vU5EGUGyOmp8CHe3LQyASQRyznHkG+fWsn+vJrcKW
 t+Zgp5URPmQ==
X-Gm-Gg: ASbGncupu3fUhNuZ5Az0omBLDrnuvAoCIsLt3JMj3guoi6eDP5IrIo9PmXiDjtl9kiS
 tBH+6pldit2avQ612aSYwGK77CGMV6DSOuth7Ilzx6iwswMvVVBxf9fOMSkvvGw15lnNxm4dfLm
 0p/fMiZVrvQT911ftTjGjFnAKJyL1k2eSPL6a1xLPQ18AC4x/ooVxVSe0smJz7kYk0kcmVbsX1w
 YGD1zv0nE7xDSmlgC7SOLasjU5LtVXBOetn46GfmoFKQx+WlDMq70MNzrxJ6H52izkUAfGJVgLn
 5mRDOYEIsCiSgJD7WVOedLwGxCAO4YUb8PNdnt182VP/V1aAsY2knt2yFK3mnlcEJ+u1Ch0/bZg
 7X4JjQ6KYG2STzQ==
X-Google-Smtp-Source: AGHT+IGFtpPIh30SXtQ2ptBIbJb8675r6OznITHuQMV5djVjAgnJeIryZ2CU5CpyHiGmLAbreHXWww==
X-Received: by 2002:a05:6000:4022:b0:3a4:ef36:1f4d with SMTP id
 ffacd0b85a97d-3a8fe4bd02fmr240252f8f.38.1750955935337; 
 Thu, 26 Jun 2025 09:38:55 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:ee3:2301:12b:81c6:a008:45a3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e52addsm336091f8f.47.2025.06.26.09.38.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 09:38:54 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH v4 0/2] Prevent use of unitialised variable vhdr
Date: Thu, 26 Jun 2025 17:38:53 +0100
Message-Id: <20250625-abootimg_fix-v4-0-df7af00e87b0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ13XWgC/33NTQ7CIBAF4KsY1mL4KbS48h7GGArTlsSCgYZom
 t5d2p0xdvlm5ps3owTRQULnw4wiZJdc8CVUxwMyg/Y9YGdLRowwQSQTWLchTG7s7517YUElIdY
 0XEiNCml1AtxG7c2wolGnCeK6eEYo91vP9Vby4NIU4nurzXSd/mnIFFNsgMpKaKOaWl0ezusYT
 iH2aP2U2Z5mRRPLlLCGdhTYj+Z7mhetOk4YKNmQ2n7pZVk+ntHXkT4BAAA=
To: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
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

Ensure that vhdr is initialised so that its value is never
accessed when not initialised.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
Changes in v4:
- Fix another instance of the same bug
- Link to v3: https://lore.kernel.org/r/20250625-abootimg_fix-v3-1-9f302e96807d@linaro.org

Changes in v3:
- Just initialise the variable rather than exit early
- Link to v2: https://lore.kernel.org/r/20250625-abootimg_fix-v2-1-0d295dc1f1e2@linaro.org

Changes in v2:
- Add unmap_sysmem(hdr) in the new exit path
- Link to v1: https://lore.kernel.org/r/20250625-abootimg_fix-v1-1-ce1645ac9879@linaro.org

---
Andrew Goodbody (2):
      cmd: abootimg: Prevent use of unintialised variable
      boot: android: Prevent use of unintialised variable

 boot/image-android.c | 2 +-
 cmd/abootimg.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
---
base-commit: 903eb123236ccbd8ef05d43507a2a910b785bd56
change-id: 20250625-abootimg_fix-51600dc8356a

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

