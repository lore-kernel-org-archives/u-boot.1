Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD8A5C4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 07:07:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6BA989076;
	Fri, 26 Apr 2024 09:06:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bD2tA+BR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A019388651; Fri, 26 Apr 2024 09:06:58 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52AD688651
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 09:06:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a5200202c1bso231491966b.0
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 00:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714115216; x=1714720016; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kHQDD+Y785fktlkPFPZzUM9vL6zCJt1KIjzLqg1U5S8=;
 b=bD2tA+BRBf8MFCtiPbCkVUzDR1/izyesoIXrJ7RBGEnnDofQVNVuvQgUZXsplGUMXy
 /kuv8a7EdjGBm65bzKenip5cMvEp3C+gqBc7HI0eezrNdQaj2ChwHA8F0Q677AmQcynX
 fGWKonE1tLdng+IhIGp+KbgHdzPGLqYxQOAPm4t5Ssw5kIq7Bt/8UEfNNB9fYfdN1z79
 AspanR4ieyzmjfmLYchfUUWgl6/u4h4SbUXOzzDEjWmxGp9HkVRtqMxbFviYzYjY9E2n
 p7GQZQrwv3bW00agrYrbQzrjStr7KA8/EkPAVMYJccAcPJQs0tADBMuHUouJYya1Z42+
 C6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714115216; x=1714720016;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kHQDD+Y785fktlkPFPZzUM9vL6zCJt1KIjzLqg1U5S8=;
 b=dMG6S5Mn77wQfKcsExnpUtsme3AozxC73UHnE2ua0wuUCccKdecWN42f1ks236+h83
 AwbpivzMOC5O8tZFhmDTLN2H83ihX4lJ4EU96gkn+6ms7FPWdAZYll2SrCayRuqWKsOD
 OVVkvMoH1qJUBs7D8FAFRbdPhT/+zSvMBDrggvbaiS8dOD2Gi0ofsau9pgWfR6LscAJo
 qXv3SomSAPj9UcMl+IioQFoDwfOBE8pW8oZHFecH4kvEEERXLB5ccDfkGmrsZX2UqiEW
 SDC4sRcvArW1sTAIBB6FNhrbDUFHf9K42X09XujrIZNoXhF3iHreSrmw4rlMcPjqjYJF
 KEoA==
X-Gm-Message-State: AOJu0YxFmzwHaAJwNSp0Poy0/N6WqnUdwtlSDlBpElgmjBIc9A7nRCl/
 P8b8lHgvONpBoYHk90J7rSi8f93OdzLiHTZDe5fjq8dAcEHamwfPjr4qQJBVdwFA/1YKA1gcOn3
 qGWU=
X-Google-Smtp-Source: AGHT+IGKatuLab+YJGZtpgdho/TmA2SVct3ShRayU3DXlnBWjLs56Ff2anpc70sirxbydCjz9qWakw==
X-Received: by 2002:a17:906:8312:b0:a58:9a74:57fc with SMTP id
 j18-20020a170906831200b00a589a7457fcmr1902852ejx.15.1714115215690; 
 Fri, 26 Apr 2024 00:06:55 -0700 (PDT)
Received: from localhost.localdomain (ppp089210108048.access.hol.gr.
 [89.210.108.48]) by smtp.gmail.com with ESMTPSA id
 r12-20020a170906280c00b00a55a57712b0sm6882169ejc.178.2024.04.26.00.06.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Apr 2024 00:06:55 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: u-boot@lists.denx.de,
	trini@konsulko.com
Cc: igor.opaniuk@gmail.com
Subject: Pull request for optee-master-26042024
Date: Fri, 26 Apr 2024 10:06:53 +0300
Message-ID: <20240426070653.4325-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.43.0
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

Hi Tom

The following changes since commit d097f9e1299a3bdb7de468f0d9bbc63932f461cd:

  Merge tag 'fsl-qoriq-2024-4-24' of https://source.denx.de/u-boot/custodians/u-boot-fsl-qoriq (2024-04-23 17:53:06 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-tpm/ tags/optee-master-26042024

for you to fetch changes up to 4242b3976fdc5c6e7b90fb5bf38c5c345a0a9d49:

  MAINTAINERS: add entries for tee-related orphaned files (2024-04-26 08:28:35 +0300)

The CI in https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/20537
had no issues

Please pull
Thanks
/Ilias
----------------------------------------------------------------
Minor changes on this PR.
Igor added some orphaned OP-TEE related files on the proper section
of MAINTAINERS and fixed a potential buffer overflow in tee-sandbox

----------------------------------------------------------------
Igor Opaniuk (2):
      tee: sandbox: check for buffer size
      MAINTAINERS: add entries for tee-related orphaned files

 MAINTAINERS           |  9 +++++++++
 drivers/tee/sandbox.c | 10 +++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)
