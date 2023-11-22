Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E293C61D9C
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 10:21:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60E6F875A2;
	Wed, 22 Nov 2023 11:21:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="t98EFMnK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00143875A2; Wed, 22 Nov 2023 11:21:31 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4793C86E95
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 11:21:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-9e1021dbd28so893210666b.3
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 02:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700648489; x=1701253289; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Hnq+sN92tWAQssVcJm8uF1iiijuELo5gIx0ZKsVbPVM=;
 b=t98EFMnK/znkoP2369BNF8UgbA00d5rba2u1MfvZCBZB0mmmyzMgzxcDnlhMCIKWh5
 7C8flHNpgmmvZ1mXF9sMukIZlWVIR4x2bfRLX0o4PDvvXGuX0XuN0c6GDSip/P6qjJXe
 C/j0F0rRiT4k8f2BW9AoCB5sUiImtR8GcPvY3cJ3WTmZzbEi1FPkJzk9ZAGvtt4AdjTn
 Neu1dPET70uSVkoMUa9HPdErM8fvwfMqS9vO8dGfKetFg7OJFg3DFWkq1mjW2tSwPRcy
 yYSUP+vfhH4SVc2/3J0JiYuBsgTJpjv6IftOxZriUzeChHG3tfzHDt3R8QBV+7FvGuKM
 0SvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700648489; x=1701253289;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Hnq+sN92tWAQssVcJm8uF1iiijuELo5gIx0ZKsVbPVM=;
 b=N8NHRBF6Wg4sYTmstwNgVOLg54jgsHyf0rY4EokIfuOAZBtq2qn5kRT+tTwe39a7+a
 /QKIKC5Ysgggc+AS2985S7hcJMPR9VXqrzu55WYPjtK2eGcsIToxzJ6ki2n1nBgnR8r0
 uWhR6/EYaQVoO/CBQQULcHlPGTj+qNE6IB7gXmUPtfMKFx2o+MGYj9jJGlO+2q/Oth+x
 XfgQi+3ep9WfiMlhvEcO3uk1h+7XCg5CG6WU1P+JyDRlTkyeHX6H0vr2qGqYk3p/2ZNv
 4DuWH4sNGkwNyHQ9GwaJsdvUDKmshiad/rTdpomH23zFoXu1mBID48TtzkqCBYkr90/R
 P+Yg==
X-Gm-Message-State: AOJu0Yyth4ARBxjAnllJvvk32smqrG4HczFDeVavQ6DarhUHROIhjy9+
 pg1jg0WxDVE0S19H2TmuGYz4qxJuQUYB68IWGV0=
X-Google-Smtp-Source: AGHT+IEqncjiNOMc4bnkDXaxpzpqwx3rBIYhe3L6l4URFWeTJ8DZbTTCM9hpBfKQ3jemaqiLtXmsiA==
X-Received: by 2002:a17:906:7398:b0:a01:a503:359d with SMTP id
 f24-20020a170906739800b00a01a503359dmr1270331ejl.9.1700648488823; 
 Wed, 22 Nov 2023 02:21:28 -0800 (PST)
Received: from localhost.localdomain (ppp046103219117.access.hol.gr.
 [46.103.219.117]) by smtp.gmail.com with ESMTPSA id
 f10-20020a1709062c4a00b009e6af2efd77sm6332017ejh.45.2023.11.22.02.21.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 02:21:28 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: u-boot@lists.denx.de,
	trini@konsulko.com
Cc: xypron.glpk@gmx.de
Subject: Pull request for tpm-next-22112023
Date: Wed, 22 Nov 2023 12:21:27 +0200
Message-Id: <20231122102127.14866-1-ilias.apalodimas@linaro.org>
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

Hi Tom,

The following changes since commit dca7a8958f8d0dbd53072caa4353353e062d80ca:

  Merge tag 'v2024.01-rc3' into next (2023-11-20 09:19:50 -0500)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-tpm/ tags/tpm-next-22112023

for you to fetch changes up to 9086e8f04d268a989193470de7cc14e4a577e6f5:

  tpm: remove superfluous check in tpm_tis_send() (2023-11-22 10:03:55 +0200)

Minor changes from Heinrich removing a ptr check that is not needed, since
by the time we get to that function the device is up and running. Since we are
late in the cycle for 2024.01 release I prefer this going into -next since it
doesn't fix any bugs.

As expected the CI had no issues
https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/18689

Please consider pulling
Thanks
/Ilias

----------------------------------------------------------------
tpm_tis_send-cleanup
----------------------------------------------------------------
Heinrich Schuchardt (1):
      tpm: remove superfluous check in tpm_tis_send()

 drivers/tpm/tpm2_tis_core.c | 3 ---
 1 file changed, 3 deletions(-)
