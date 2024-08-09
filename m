Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9055FC52D7C
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 18:56:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E253688C01;
	Fri,  9 Aug 2024 20:56:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kRkSsgH4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3567988BB5; Fri,  9 Aug 2024 20:56:07 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C69B88B07
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 20:56:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a7abe5aa9d5so307337966b.1
 for <u-boot@lists.denx.de>; Fri, 09 Aug 2024 11:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723229764; x=1723834564; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FJKTGxjShl9Ohvx4fWTK3ulhwf/WVnhZPrAMCsdVmf0=;
 b=kRkSsgH4gf1LHdzbt2/tCbXNnDgn9PZn/X2h9HNoOk2i/NEdmpmIBril59S9pzM/g1
 EegCOjD+t4azaCjimzkzhnbVVWVlY17IPEd0TMhIKuZQkSjtC71PSJ6RJZMHJ9ml9WMn
 xT/FVXrt4Ofoq3R8DTXrJEcEx7bjeQ6LKxm1VbMPSj1yTEBd0F3GA+MvJHljCe9iGaXg
 I8iFV0Xfm/oQ2yRityx9ay3MicuSUl4HmHEItabxd4KiVQUs6IIGVkLODoOaPf+yebsC
 oFPzMI2DhQN6G757hnbQhLUqX3EwSXLNYjo+SMlqXGaiDUDcKzn1MIHxEvP5qdFZNw/J
 G72g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723229764; x=1723834564;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FJKTGxjShl9Ohvx4fWTK3ulhwf/WVnhZPrAMCsdVmf0=;
 b=TMsMd6TGySroDncnPBCM2rzvlZVBxvJXOaXrly/HqgEFxE0a6HLVzea/6QGQPVQHJJ
 KKV+JY/IH0uhuYncRLC1u3e+XmY5b7W6i01i5TEQLiRV1dlBXgPRmszLEzySyRiz5aWr
 WlsITjqMwFMQDC1PXduTRmwj/I4/skFJ3w8gVsw2dEVYdOm1XagpLZtG09o2c2AKipK3
 EgnoqM17vQsNQSNkQoBTgYdWwGROWHlIIxSljEmMMiRqQhz7uVhtRNw6H91hdNGqE9Cc
 Tj6EYahFwjlqOGNl7ko5muMGZNpOmY49+YkeunG5HBJlx3s/E9zeR1aFaKXPb9MbXsuk
 HxHQ==
X-Gm-Message-State: AOJu0YynDpwnsYdPJ+hQHrOvG0nI2bIhlcqfI8aarkoVdjbs/UtZZMQb
 g8fUsLoBWy7zEdY47eKhbUljP1bo4blO+vDztzd+VO+36Gl3igK5cxdbcaOBw18MjwrTTIE5LRQ
 3
X-Google-Smtp-Source: AGHT+IFBYCY5WBn4WZDrBNXxfEQFeRBpFtWn4lWkToi6JBdfq7vEMtMVIZOxSY3cTzqtdcIquC+hxw==
X-Received: by 2002:a17:907:984:b0:a7a:387c:23f8 with SMTP id
 a640c23a62f3a-a80aa54a24bmr159180766b.3.1723229763446; 
 Fri, 09 Aug 2024 11:56:03 -0700 (PDT)
Received: from localhost.localdomain (ppp046103060252.access.hol.gr.
 [46.103.60.252]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a80bb2421besm1885966b.207.2024.08.09.11.56.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Aug 2024 11:56:02 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: u-boot@lists.denx.de,
	trini@konsulko.com
Cc: lukas.funke@weidmueller.com
Subject: Pull request for tpm-master-09082024
Date: Fri,  9 Aug 2024 21:56:00 +0300
Message-ID: <20240809185600.1581967-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
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

The following changes since commit 6f4c31c2b658358628b5b0fa801f55c7477c7585:

  Prepare v2024.10-rc2 (2024-08-05 18:13:42 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-tpm/ tags/tpm-master-09082024

for you to fetch changes up to c686b38db8f84e5537b8371ac59a5b364662eda4:

  tpm: call tpm_tis_wait_init() after tpm_tis_init() (2024-08-06 14:01:14 +0300)

The pipeline in https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/21949
showed no problems

----------------------------------------------------------------
Back when the TPM subsystem was refactored tpm_tis_wait_init() ended up
being called after tpm_tis_init() which initializes values the former needs.

Since we added more TPM chipsets since then sitting on an i2c bus, this patch
folds in tpm_tis_wait_init into tpm_tis_init and makes sure it's called in the
right order regardless of the bus the TPM sits on.

----------------------------------------------------------------
Lukas Funke (1):
      tpm: call tpm_tis_wait_init() after tpm_tis_init()

 drivers/tpm/tpm2_tis_core.c | 28 ++++++++++++++++++++++++++++
 drivers/tpm/tpm2_tis_spi.c  | 30 ------------------------------
 2 files changed, 28 insertions(+), 30 deletions(-)
