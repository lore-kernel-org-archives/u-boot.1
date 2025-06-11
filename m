Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0491C677C4
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 12:37:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 670CF82BD9;
	Wed, 11 Jun 2025 14:37:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="lS1JdeyV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6321C82C65; Wed, 11 Jun 2025 13:51:35 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64BB282A4B
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 13:51:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ade30256175so960603766b.1
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 04:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1749642692; x=1750247492; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=V/iy2Z5rh5QiLyMdF7OYU8mFqMVhaUoMu+dliLU1apM=;
 b=lS1JdeyVbTSoXpVgshAfWoEJXG4NoN9ortPD1cOEozvbQpfmSBelOFa48isILmjHxc
 ERKezq/4hSOV6KHYNwDUMMM4cOFhwRt9kRSVIFIZ7Nh7qQviPK+hYTDqXTx63DkxuPXU
 zbjh/ByVKcRYe93EtUskRfcuZHbCq2EyQ9c6TRmrUy8DmKJxsNxGvKp2XFyuyEdYryhs
 31E4Q8zAeJ87o82+OqlH4jt1UiNUnP62dVwgXIBfb9TzF3b2LUUsTWzrqsvE4orH+IUb
 6GbCdn4EsApqiq86SVa/6X43Xgyk97pXc7LEKwDvPH/7aPw86lyCOl36iTEcHqAIoFmZ
 HJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749642692; x=1750247492;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V/iy2Z5rh5QiLyMdF7OYU8mFqMVhaUoMu+dliLU1apM=;
 b=PSN8hWP/z04zsQr/pzBDf1qk/ooHUJ6vNhC5sdOdLDYwMK9E+ENufJM03lXj0sVDuI
 wO3p8wG70Sff6FRQdUAkL+hHHj81woJpp3xDxtgIrIPrlBLqzr+lYsBe0mt1uospnja4
 RhydbGmM426NMYlI4l9ks3qDMtgB+zPJc4lxin9zsvwWwjGxcInuzD5h+qGCkY9I6vAu
 vbpfZv8eXwrrU5mgHa4meOHTOsCvMNHGuMulMxDK8dMiteSCtZsDOCdgWj60K8rMrhSF
 aMGQZHSko91FshUZpLBKYYKA8l3eDooUMavKPeCa+5su5NXFhiQrW/zj43DcobZPZ00a
 D1gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCViEeB1jSfiT4xpLagmTbRORQNb1CObg/NmwHm+lzw3lTCrWFKCkMm/CTDWZMrQeeBjILaWpzk=@lists.denx.de
X-Gm-Message-State: AOJu0YzUwRJlYmkGFRRaA/i9XBPHuOgs+J00ffxOeNJjnZhx1vYNNQBp
 twWEB7FjgE31Yf9+/6zaEHCmI9HKDf1SRKsep+I+QBPt/U1JIWfOja9qM+rcXcOAwPCSiQk9m0D
 iCSCE9Gk=
X-Gm-Gg: ASbGncvBr9RxNuYxbTiZGR1bLDcb+OENv4HbBD121XjzX3t6+rurUibuMkyTFeBc0Vo
 hBAMXkuHFQ1phyZlDIuY66lj+dZAdEaswpBiNW85coJvBMP3ttSVFJW0B3QdGGpzzgOCDSUlZs6
 G032NbXtqzPWNVQFb0uWIMfIe8mXXK+eZHwXNBBcFCL2AnSVHEXX1kksO8GqskM+Hg/ycG4+CJ+
 uj+A4Y1X1qNq4p2nkleE+BRLQyAd9bF829M6vYOCmcOrGy7LxBySZyKYGov1n11Q9OV102oCmEP
 +VGqy/pE2n9VL0wafX2OT0ozXzpiY3Ftxa2tYWpQJapTyjCtC0CmD2Vk98eZ4xPY8fUjaC+8sYc
 xaMSY6h3qlSlaLnpig5qdPtVztA7JdXtS
X-Google-Smtp-Source: AGHT+IGB6XI+RQ1uR4Nv9FJpjidXeqApShPGvs6b4bub+Qob+Miatf5/hHqeZFpZzvxM4ckKRPJlcg==
X-Received: by 2002:a17:907:2d14:b0:ade:3a7a:26cb with SMTP id
 a640c23a62f3a-ade898389bcmr302722466b.58.1749642692386; 
 Wed, 11 Jun 2025 04:51:32 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl.
 [144.178.202.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ade1d75467fsm891666166b.14.2025.06.11.04.51.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Jun 2025 04:51:32 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH 0/3] Update Qualcomm generic boards doc page
Date: Wed, 11 Jun 2025 13:51:22 +0200
Message-Id: <20250611-qualcomm-doc-update-v1-0-5cf8cd94974d@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALptSWgC/x3MTQqAIBBA4avErBtQ+4G6SrQQHWugsjQjiO6et
 PwW7z0QKTBF6IsHAl0c2W8ZsizAzHqbCNlmgxKqEa2UeCS9GL+uaL3BtFt9EtbKVZ2rdCuEgVz
 ugRzf/3UY3/cDLNDvHWUAAAA=
X-Change-ID: 20250611-qualcomm-doc-update-42f39f3a600c
To: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749642691; l=715;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=Maxy00Y/YwdU+3ubGDl90DCXK9ZjdYsPOKe44NScPhI=;
 b=WPdMxL6xzfhOXaEVwZrG4LFEyWqPEl1WH5vHn0bnV/K6v/ehM5eaiASjMlAA0b6UbR7z+Axt6
 sTqo/pngLNgBbm/IQ75OIJZ4Opz8MwpAjSYBFTopG0tRYH5oNmMnTni
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Mailman-Approved-At: Wed, 11 Jun 2025 14:37:25 +0200
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

Modify some text which fixes up incomplete instructions, and add an
example for packaging up u-boot for newer SoCs, with boot.img header v2.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Luca Weiss (3):
      doc: board/qualcomm: Fix commands for compilation missing CROSS_COMPILE
      doc: board/qualcomm: Replace buildman build instructions
      doc: board/qualcomm: Add example for boot image version 2

 doc/board/qualcomm/board.rst | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)
---
base-commit: d7c449c3d83a986d61e38d1762433c0607caf5c5
change-id: 20250611-qualcomm-doc-update-42f39f3a600c

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>

