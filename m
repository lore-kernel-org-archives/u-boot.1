Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9933CCD184
	for <u-boot@archiver.kernel.org>; Tue, 21 Oct 2025 15:35:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35BC48334F;
	Tue, 21 Oct 2025 17:35:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="P4PPAmc1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FB6E8334F; Tue, 21 Oct 2025 17:35:15 +0200 (CEST)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CEC6800D7
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 17:35:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-891667bcd82so720141285a.1
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 08:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761060911; x=1761665711; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mFWtvWtL3vzUDTQ9V9yVmtkSV+B+9IVqFLWpqVvOJUg=;
 b=P4PPAmc19jguvWIhGOVqpEcrLuWDVDrmbOV8ytV3puxoSyj06WcZtAHmnUSxa6Z13j
 MBH8qjWUFqWbfxx7pE3bNrI/KhFmplCdBzr9sUxsZcEXZn2s3zFn4OKEjMHJhu6Ce/sY
 MhxytBM1HTuVRYumAtCwQ9VS6Kl73XqYL2c0x9UAUiIDyttGt2e1YBrT0rS3NRtGpLNn
 FanrLO6UnsurfORvEq8v76qJewV0KdenkFEXgj8RlzrsNZS7ofTDjVVn/08FqSK5Ik7w
 ZxFORZpARgcn6lyFi3uF1GcVLVvxn52ew820gVkdZeSlHHV+/9kTmkAs+gXx/RdFDZOE
 F+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761060911; x=1761665711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mFWtvWtL3vzUDTQ9V9yVmtkSV+B+9IVqFLWpqVvOJUg=;
 b=OEFD022bNWiHPwFGkWkIHQZeRrH9IeFiAH5DEYoB4eSeNGnRUPsuPcCDOIsR6MZBME
 46BxQLJgLEOuIHWuiAJGbEW1xqp+s0KtyxQDCdOBPXIxajW0SWe6r36pIqrscAaY7zyQ
 Dj88Uqub159IJBUR9lbpa6R19aQixfOR+HWTmhfGB/FD0HqMx+DMg+7TMIKb/o6dHm9Y
 JA/Wb1FQDN4gP9PgfFIA6Sw6pZF43MrSNr9mRkIrmwgmhbLaxsdwnlrUqfP7ELRRgZkS
 nSfbtCz/vuT1a1cxrlGup5XMWQEfH+TayFaprGbkLqDouALJRO4LBzaCwAdCgs747/s0
 jQTw==
X-Gm-Message-State: AOJu0YzdA2PPqMBrE+FLV9VJLaLyjxn81P0paBDi+uUeOlHPxV7NVZ97
 YKgglGGxNuKhtSa+mxoFORWn2RPz3HHLNAsM4mqzelg+J2HzLgRgBLDOB4imHyHwommpEkfw6Oo
 /a7OS
X-Gm-Gg: ASbGncs+YaRxi1asOyZ34OsjMMWMUD7+pkKSVnzIMOvQnuZMu2FAL4yIHEMJaB+rpuT
 wkQal/KTd53wAlFETmob4aD6xKyUqlk/4i1RHFbuotmfycuMh9yf5IvJQky7qxTCs8xUmlGnvdk
 y+Z8lCNUYDtdNuV3khwKgAVfx6lZMFYPe7N92r5KCSnZzgvekVpM1D75vFZaXUxWMZ+lLDpFYEP
 zyWfxRkv11K3H2OPaamQlU6PWFu+iGi0m9c5ngdyg8SO3BkLgUtmwkHpPevjU3uG9V9CHSb9//P
 ZESjzYXOM22Ze6nu5AoJ6f+xWR0WHGyhzOvlfsEDdJR8hNoWAVH4sAn55RKNwVTHpnsLZITDvmk
 0QtPE2faIKwpvRQhb72pdgDk05uduHJLmBjeJ69oteFEmF47HBktdk55TsGih/P4XLzkEulrcAJ
 9p9FsoEGhXlB7rVcdVK8HGve9dU14=
X-Google-Smtp-Source: AGHT+IGGQtMOelVwjKGyta4ZfvZO5qQfOlx0lwLME0RTiBky9HCWQnpFblHwCdyofAnHCMa9ocJRdQ==
X-Received: by 2002:a05:620a:4413:b0:891:6a36:1bf8 with SMTP id
 af79cd13be357-899e7f4bc8amr19732685a.14.1761060911508; 
 Tue, 21 Oct 2025 08:35:11 -0700 (PDT)
Received: from localhost.localdomain ([209.227.150.67])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-891cf58e7bfsm777910085a.50.2025.10.21.08.35.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 08:35:10 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: [PATCH v5 3/5] configs: select CMD_BLOBLIST for Firmware Handoff
 testing
Date: Tue, 21 Oct 2025 08:34:35 -0700
Message-Id: <20251021153443.219326-4-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251021153443.219326-1-raymond.mao@linaro.org>
References: <20251021153443.219326-1-raymond.mao@linaro.org>
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

Firmware Handoff tests will leverage the same board type 'qemu_arm64'
with a new board ID 'fw_handoff_tfa_optee', thus select CMD_BLOBLIST
in qemu_arm64_defconfig for running the test.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---
Changes in v2:
- None.
Changes in v3:
- None.
Changes in V4:
- None.
Changes in V5:
- None.

 configs/qemu_arm64_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
index 12ed6b61239..a09b107746d 100644
--- a/configs/qemu_arm64_defconfig
+++ b/configs/qemu_arm64_defconfig
@@ -31,6 +31,7 @@ CONFIG_CMD_SMBIOS=y
 CONFIG_CMD_BOOTZ=y
 CONFIG_CMD_BOOTEFI_SELFTEST=y
 CONFIG_CMD_NVEDIT_EFI=y
+CONFIG_CMD_BLOBLIST=y
 CONFIG_CMD_DFU=y
 CONFIG_CMD_MTD=y
 CONFIG_CMD_PCI=y
-- 
2.25.1

