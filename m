Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CE88C7EE39
	for <u-boot@archiver.kernel.org>; Mon, 30 Jun 2025 10:23:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 149FF82E6A;
	Mon, 30 Jun 2025 12:23:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pEwbjkHF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B1AF82E6A; Mon, 30 Jun 2025 12:23:53 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DA9582E6A
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 12:23:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-453426170b6so27615425e9.1
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 03:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751279021; x=1751883821; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mwcmT35jTV6qzclTOMxM+U3UJoW3UZFvRwgO71O42uE=;
 b=pEwbjkHFb+L0fN2W40M58OyQP/DivWwx8L6MyXFEGC9cWJW5JntfjK8YAlAOGq6tr/
 w6hjaUHiZ2IblgeyBOKUS8WhviHF2e3Fsl9sLSbz2ne5F9HT1v/5B5n172xVL3VkkxuY
 0MEl6JBLkTajIptCYftfWrXT+yNiZW6+8Fj3yZKG9ljObC0/ZU+cH6vxszJlKba3FfP3
 qm9g0dbERmHLse1lYz46n8+rOciXChZlGz9ZFc1LziYHbw0h20VykcXA8ED4u05/eBr3
 bTHWqntPhTD0u0jDUmk/xVuQa5cxbXNBtmYWMGgmmwDE3iTn0UTI1iHigx97Xj/tjglf
 sF6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751279021; x=1751883821;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mwcmT35jTV6qzclTOMxM+U3UJoW3UZFvRwgO71O42uE=;
 b=lEUR9jzRLNv3LmPoHXgNIJ0P1lUVwK0cCiptpZkrxa79K/vb5aNggmo3XoDlfuwzWo
 mq/Li2j5NtMGDJ4Vvq8uyS8yh6RqJ+Ph9El5MLQ1IkBcihc3Vc/JYuObsgE9Wh+GvE11
 yV6TA0FzCy5mMoA3p7WQxgMmu4zgx9rifGcJOIexHWsFyL7d0L/ap1d9zg0X3C6xZ7Jz
 JmH4ohokT5UBpCC4ypc7qMntQ9Hvi9ggLkd7IfF53SqFJKz8TAov10V4yoCprLmsohpS
 /mmYxGBeIHtJWslbBUyazEvERv3Lc/l3x9pp6cgUQiAbwAo/4c874BoGK7S2/E6jaOhB
 AkUQ==
X-Gm-Message-State: AOJu0YwGReuEZNqKrt3us7gOWLYyimMWYHdeB+GkEAXe9g0svKzhekTa
 pLMAELYrYZtHa7wNIb2XHm9cUAGarbdQqTtyKyENmlcQEUlegvpZhFGOD3IMaBoCpn4=
X-Gm-Gg: ASbGncuBdAZgoW8YfVaVENV+3G2EQ45xOjhhewUCXJniv6uFyyuMtBUKaYc85P7I0Hr
 VEyAZ6e7ZsKGhZK3wIVOme40JJYaAVz/qz5hwHTdPee/z0+5mLMO5DByoPa2ctrqnkOC8+MOHXI
 IBB89zooIXPmFirXPkCjIVfH6+pZ5gEdM1qFwu5acJOtO0VJJgaZN7tPJigd9t5AvaDWe55H1j1
 VkDQguFnkrOnkdU+r+je9GDdIH4l3TmJkf7ZKTPPrXA4JVhuQByu0m1VcpfaGJSbr6vKY9HfZgd
 oBhMGoKdG5rCv9cABQwSdn1LcZ+RsDndqucf2stc2cuj6qIpX9q16a6TMPlsTVHUEXkb1JjaZWx
 RvyIGzE4Xbd7MaYk=
X-Google-Smtp-Source: AGHT+IEMJiO+wDbxXJIgyV3i0fDwhK8dts4UnoZu9iomk8QqYrrchiqxhZIQa3qX/l5jkzO3HGa/VQ==
X-Received: by 2002:a05:6000:2f82:b0:3a5:1241:afde with SMTP id
 ffacd0b85a97d-3a9802971a1mr9848347f8f.9.1751279020571; 
 Mon, 30 Jun 2025 03:23:40 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:ee3:2301:10fb:ba4d:cfb6:8c75])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e52a5asm10114085f8f.54.2025.06.30.03.23.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 03:23:40 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH v3 0/2] tpm: Attempt to return value not in enum
Date: Mon, 30 Jun 2025 11:23:38 +0100
Message-Id: <20250625-tpm_enum-v3-0-9ef117f6a7e4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKplYmgC/3WNQQ6CMBBFr0K6tqa0UMGV9zDGTGEKTaQlLTYaw
 t1t2Zno8s389/9KAnqDgZyLlXiMJhhnE4hDQboR7IDU9IkJZ7xmktd0mac72udEWdsgtlCjkoq
 kuIKAVHmw3ZiFCcKCPj9mj9q89o3rLfFowuL8e5+MZb7+aI8lLelJQAlaM9VX3eVhLHh3dH4gu
 SXyfyanjCII3VRaKinaL3Pbtg8avxvJ9AAAAA==
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Tim Harvey <tharvey@gateworks.com>
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

The function tpm2_name_to_algorithm attempts to return -EINVAL
for an error but that is not included in the enum tpm2_algorithms
which is defined as the return type for this function.
Add -EINVAL as TPM2_ALG_INVAL to the enum so that it can be
returned as desired. Update the code to use this enum value.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
Changes in v3:
- Rework first patch to have the header file include errno.h instead of
  the individual files
- Link to v2: https://lore.kernel.org/r/20250625-tpm_enum-v2-0-ea3f84f6b639@linaro.org

Changes in v2:
- Add patch to make use of new enum value TPM2_ALG_INVAL
- Link to v1: https://lore.kernel.org/r/20250625-tpm_enum-v1-1-73a1aff0bd4c@linaro.org

---
Andrew Goodbody (2):
      cmd: tpm: Fix attempt to return value not in enum
      tpm: Make use of TPM2_ALG_INVAL from enum

 cmd/tpm-v2.c     | 6 +++---
 include/tpm-v2.h | 2 ++
 lib/tpm-v2.c     | 2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)
---
base-commit: 903eb123236ccbd8ef05d43507a2a910b785bd56
change-id: 20250625-tpm_enum-098ee9a5eb6b

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

