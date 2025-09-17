Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD07CAC5A0
	for <u-boot@archiver.kernel.org>; Wed, 17 Sep 2025 16:24:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B730A83826;
	Wed, 17 Sep 2025 18:22:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="JhySQFtl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7347B80C93; Wed, 17 Sep 2025 14:52:36 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8456A8354B
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 14:52:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-afcb7322da8so530986566b.0
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 05:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1758113554; x=1758718354; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BgpGsBTDpsCi2s7O28cAuDPFsW0d/jkSn055CIPbDok=;
 b=JhySQFtl3EgTvu7AbwxyRQyeIvolMbdAL6j+jgLqsBGtBbb+BRySrWGzOaKSl/b1C1
 va8BYGVCE4G2lsujnORHLpXqQCW5U6AM+4TDYvs2yRS1QuewzCYEDogwWCrF11sTCk2C
 dgUtYIu3gnfMbrVcnZKqZS/wMXBKzN19axM0bVLHn+f5B7rAgnlgHq0tRfe9UvSrFD5C
 07rOPkBlKnsfVSSodNX95p0M7ntob6Vj5ZOnkm7pjOgL8jpeEYzm0rV75q37ee9jF9io
 H8oqAU1e/hx/E9FeG1twj27ypyNaLKoTYLQtQbaZo/gcYf1BXzxT0RMgZBzx0CRIC4Jf
 eBEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758113554; x=1758718354;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BgpGsBTDpsCi2s7O28cAuDPFsW0d/jkSn055CIPbDok=;
 b=nlI6sDryemkYZrG+4NvwpDX6SWBuDLjqmzTb8k5MmxQ4jziWJvLM25Rr+I3DPyBS45
 kcE1tgcCpd//sSF0g75JzSpQpmzAB8hWwxm9y7oWr3ed2lY1DTmIZnCTgQzFjocXO8Pg
 4Zt7Lo3vc8fn58CLGAxKe0mMdrms1U4fLkrpunZsUK6TiSQevhTNM3i99vujfJMmAuRR
 W0aUAelNz8xufcjUyPw2E6bnassUPo1fCdl+cOHWpmuwc0FdD1d8hutX0nhkdngqvSYU
 hzgosrMdGrZQEmeI9JfPcaCBkXGkGLdm/sV0i3CoPExAMu5TmYD3dqm5lWE+meo0ZYgv
 0mfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUB8D3h+A4XA65FarTpSVmsq2Q3/fMNITqaUEtYAK1EfM+RrDOkzJCZCFo0pR/BStbplwbWRKA=@lists.denx.de
X-Gm-Message-State: AOJu0Yxbu/M3hns9SeHOOejtmb02SIMNGCd/fjINJ7tQMWDs4FapQvHe
 kuqN73DSpoylEHkyRrBKXMAJYzAhQ5H8zLO2z+q8PGX9MHgWziFSwqm690onhN3FWsk+dfViC0R
 K5v0B6lVbUA==
X-Gm-Gg: ASbGncsalzD7WjiY6Pcm/UZuOHz1n73lETUJz5wWJgm1NZm35YqYTmcUqcTRnijzSmE
 M3rl7r5T3YC2JIcfQ9u/vV5IwdU0ZwY3vFArGs8rf83JBHwIbQAEl4/Jz6AqV/3575CCQZE5bul
 OUCRCIeBO1C0iCjCQ0Cg6p0xjx0QjzrM1q+CBSDlC58AzRoCITcf6J8ORJ5Kot5069DaYf2NcWz
 iPg+MNmjIiC+exTdUqCp72wfLQ9tr1B6ehfWza95TlNrB3rOL9aO4DFS+ufUkJevsvcZ3UIs+Ub
 3aSwEbXP+FYFoNbErmkBOqiiJE76F1n5Zuvs/ezCsQWagmOhcxqXTk1DNtMgkualYPUh+8zEZG+
 Dh7E/WvxMJsJMXCCKurCGTraK83YSFTbc+1TqikutCj3bBKXnuWQib6+CiWKvCMsTO9o7JA==
X-Google-Smtp-Source: AGHT+IEXXb1gmZCSfimx+bN3LyEG87NeaWveobXqMxZO6rjrGY3nZ8wN6oyECnFCH23zn2rAeGP+7A==
X-Received: by 2002:a17:907:7203:b0:b04:5a74:b674 with SMTP id
 a640c23a62f3a-b1bbb742599mr267516166b.58.1758113553888; 
 Wed, 17 Sep 2025 05:52:33 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl.
 [144.178.202.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b07b31287cesm1382485066b.30.2025.09.17.05.52.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Sep 2025 05:52:33 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 17 Sep 2025 14:52:22 +0200
Subject: [PATCH] gpio: qcom: Support GPIOs on PM7325 PMIC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-spmi-gpio-pm7325-v1-1-6b75c2c62d8b@fairphone.com>
X-B4-Tracking: v=1; b=H4sIAAWvymgC/0XMSw6DIBSF4a0Qxr0NoFhhK40DoVd7BygFNU2Me
 6+PQYf/Sc638oyJMHPLVp5woUzjsIe8Me7f7dAj0GtvroTSwsgH5BgI+kgjxPAolIZSa9kVxph
 Oer7fYsKOvif5bK5O+Jl3ebrGP2zZyVayhhyqQgtwiYZ+jiBqVCWKrnZO2UUdrmszgh9DoMmy5
 TjepYDkS95s2w9A36d1yAAAAA==
X-Change-ID: 20250917-spmi-gpio-pm7325-4551f3999f1c
To: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758113553; l=1690;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=bOzlVCID05o4+Hdjqg0M46Iz2HFUNYJ/1xaX7aQVj2c=;
 b=jjWniN7HKAGEff+H7Z+H/vsuSMfA6WWA0GBTCbPzFY0VpQ45QxG23mUsz+xYGHp9spr0Lq/OB
 4navcJ+Ez+BClXtwH8NoNgVm0dojkLMkBMTaqt1D3zCDwWJ247694JV
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Mailman-Approved-At: Wed, 17 Sep 2025 18:22:41 +0200
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

The GPIOs on PM7325 work fine using the qcom_spmi_gpio driver and
enables the use of the Volume Up button Fairphone 5 smartphone.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/gpio/qcom_spmi_gpio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/qcom_spmi_gpio.c b/drivers/gpio/qcom_spmi_gpio.c
index 3f3c98e2d935a34bb030532025e8765a2dd2b186..c540648497d7f958dca51e9be399c5443a8eeebe 100644
--- a/drivers/gpio/qcom_spmi_gpio.c
+++ b/drivers/gpio/qcom_spmi_gpio.c
@@ -744,6 +744,7 @@ static int qcom_spmi_pmic_gpio_probe(struct udevice *dev)
 
 static const struct udevice_id qcom_spmi_pmic_gpio_ids[] = {
 	{ .compatible = "qcom,pm6350-gpio" },
+	{ .compatible = "qcom,pm7325-gpio" },
 	{ .compatible = "qcom,pm8550-gpio" },
 	{ .compatible = "qcom,pm8550b-gpio" },
 	{ .compatible = "qcom,pm8550ve-gpio" },

---
base-commit: 18973d4b0801ec6d7fddc0084601036b5c3b08ad
change-id: 20250917-spmi-gpio-pm7325-4551f3999f1c
prerequisite-change-id: 20250618-sm6350-bringup-08e24e0f8bb2:v2
prerequisite-patch-id: f0b44882a110259dd421dc3fd223cf3569e32f2d
prerequisite-patch-id: 8aeea48ec719d8c8f2f2533f0a121cb206bc9d8d
prerequisite-patch-id: cad2258c74346db458bf00bfcfa7cf28bbaa5384
prerequisite-patch-id: 662587c7dbb756b1a4ebc7094b8fc76bbf692ca8
prerequisite-patch-id: 1f3bc441288f9f39da49f3352b2b859186d4f599
prerequisite-patch-id: de48fae371ec03c10baf56714aff89a449323c75
prerequisite-patch-id: b98fd5098930e14ddb1818921abaed1a204d7d07
prerequisite-patch-id: 0f12120d67ad63d2332f9dc095219f6c00e1df3b
prerequisite-patch-id: 51738fdbf87d833f90106b60e874e74286b84fad

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>

