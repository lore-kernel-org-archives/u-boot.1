Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 542F6C48BF6
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 14:43:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCE9287F9F;
	Mon,  4 Mar 2024 15:43:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Eb+ayxQ2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55DD387FA5; Mon,  4 Mar 2024 15:43:05 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 388E487F92
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 15:43:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=o451686892@gmail.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1dc0e5b223eso38606235ad.1
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 06:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709563381; x=1710168181; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=s3gN8yvx3YsApxeozUaLudTl9itR1P7nL7O/aSKL96o=;
 b=Eb+ayxQ2BsThKF1nuaY+aMuBr2j+ZU/asnBIzFxlMxRjtQMoQV8AC6qoe47AsETqDf
 hU9jUMfb9ZkxdSmdUyyjV4J/+n+Z3EmpNMJB+uGYml6bETQhEaJgISOeTce9kr1onhe6
 oPszz7ZO2+KKvPQLPWMA8WBYVh5D2DWAUN0UGc5Jq/jcY0cU5U6Fj9OqnWT4ChDh/VAP
 B7M26O+eHdfNCFAA45r14nJnayDhfhydqfAuANqHOgbfkdhZNYkPOVg52FsKuiSoLkmQ
 5v7Mb4eySgjrMAnvFrfWW8kZNEKNX1xsp7foArCxF+7lMUTsDYB0NsJH8sUNLFaz6Rz/
 WkVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709563381; x=1710168181;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s3gN8yvx3YsApxeozUaLudTl9itR1P7nL7O/aSKL96o=;
 b=ZI88J1QhbSWb6kRmueq2JGQA75aXbeS+6qu+7OU4zwlNDm/TXpdt9EtJ+gK+0w3/9a
 9D7dbDgjdYZPYZ1AMNQV5JsxZqf68oE5weNW/j0UGh+oROUvd7hFOycIYUsMnFeS2PEz
 UyCfucXSla5oXsNKPsxsWTfbMwLRzAQIKTL8Lcumx8ilw7YLAB0M9gKZvFCnpKEeI+uC
 14UuO/lLaeotBcYsjFEpXBNUO9JkmNj9+SXzKDWu6ssF9hxRZ6U66CmsRjpj1U4pm4Bj
 xiulfl0wTCgs/dpGKGd07nOZBEvVb5DTkgdZyfXTlYrRrz0oSjh2UTm7ZD2GtFX4AYSk
 662w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgSZUtYRWoVIMnhCp9C0XvJvDvSvkjWq2K3CYk7ecRqHyrUx/IshBQY0kgG2QZ1QDTYsR48AqKI1xo3xitD93uV1JneQ==
X-Gm-Message-State: AOJu0YxKoeEns6K8GaVw08FgYX+ElJZZ4YVlFKTU5JE0v9oX1F/zilhj
 gUFXobeRUX4PsffYLFd83cA77QoeWBYUMCC4xh6aq9tVNO9Fty2f
X-Google-Smtp-Source: AGHT+IEaqBc8SICuoJyf86TP0ZL1DmSX0kDsBWacLng7t1pjtZg1FSQvidTl1ApQBV+mD9eX77FFBw==
X-Received: by 2002:a17:902:c408:b0:1db:916e:d77a with SMTP id
 k8-20020a170902c40800b001db916ed77amr10039500plk.2.1709563381355; 
 Mon, 04 Mar 2024 06:43:01 -0800 (PST)
Received: from ownia.localdomain ([8.210.91.195])
 by smtp.gmail.com with ESMTPSA id
 lc8-20020a170902fa8800b001dc8923a2c4sm8629529plb.294.2024.03.04.06.42.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 06:43:00 -0800 (PST)
From: Weizhao Ouyang <o451686892@gmail.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Weizhao Ouyang <o451686892@gmail.com>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, u-boot@lists.denx.de
Subject: [PATCH v4 0/3] Random Number Generator fixes
Date: Mon,  4 Mar 2024 14:42:39 +0000
Message-Id: <20240304144242.11666-1-o451686892@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This series aim to fix smccc bind issue and add a list command for RNG
devices.

Changelog:

v3 --> v4
- update doc/usage/cmd/rng.rst

v2 --> v3
- remove fallback smc call
- add Fixes tag

v1 --> v2
- check SMCCC_ARCH_FEATURES
- update commit message and rng help info

Weizhao Ouyang (3):
  firmware: psci: Fix bind_smccc_features psci check
  driver: rng: Fix SMCCC TRNG crash
  cmd: rng: Add rng list command

 cmd/rng.c                 | 23 ++++++++++++++++++-----
 doc/usage/cmd/rng.rst     | 14 ++++++++++----
 drivers/firmware/psci.c   |  5 ++++-
 drivers/rng/smccc_trng.c  |  2 +-
 include/linux/arm-smccc.h |  6 ++++++
 5 files changed, 39 insertions(+), 11 deletions(-)

-- 
2.40.1

