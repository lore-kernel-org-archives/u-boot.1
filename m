Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0916E77188
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 07:19:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 384BF801E8;
	Wed,  8 Jan 2025 08:19:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="d/kZcev0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 798F9803DC; Wed,  8 Jan 2025 08:19:40 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B5908005B
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 08:19:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-aa684b6d9c7so2693200466b.2
 for <u-boot@lists.denx.de>; Tue, 07 Jan 2025 23:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736320777; x=1736925577; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ej2WAefs3dzl9rgjU/PenUkGPXnkcVL5BhytU6Ac9YU=;
 b=d/kZcev0YL6P1kSHxQZzWBqxxx3f2vYqpw8osoRMw4JMznOEv/zsRi0Yf+SjO1vmQB
 Wy0JdkuW7lK66gmD6dSuXGXoMEZC5R5H2c7k/N+0dJ8IAQFInJzjjHtZMdHg9xZgDmdJ
 7qPhjHPdO80gIw3XL9AI9cc0ttqlAR2BARLiC+WTUUkOaz7BZyKlvG3DhY0LCGJ3j7eL
 KsLb5ZOd2OUWao7WcGRMj7vbvpuEeu27FnLZsjlp2fw6i8Pi5PGzzMIDpF9BvqVrVRLD
 gRtGrm1kEMsv2goC7T/8MAJYw6ywjYcFzgXq46jvVppMwBt71xivmjaZHPwbYW+1fKK/
 UjvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736320777; x=1736925577;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ej2WAefs3dzl9rgjU/PenUkGPXnkcVL5BhytU6Ac9YU=;
 b=IuD5zhHtpZgiFQsNPLiI+eFZQTh0oK8wpSb9E8fIuJRhu/8/7hgDurtSq9W/61g7Q9
 sNzFZRK9mE9HQkuysiknlDNkPPG4Bl+qhfSvKBrc392L1BKHZkDi0LfQm6ViCIv5ztd1
 gMcoxuELhrWf4G1sfj75PW5PvgXwJdPA3J72x9uCiSRg0r+qfaIzNZz3P9pAnJ0kCT09
 qFJ5VPFZ6cYymvsLozV+/J9Lu8UuS9tngbhf/7hFSLBmosHt9d9ZC74MZXdm0K4s2nrO
 TkkUUIKyD2RLxILvxQ8nIDSj2fTzrxoa7qw5wel3ZMcpKWuV59PRNzILtNL/u3x78xBv
 +xJg==
X-Gm-Message-State: AOJu0YwsQ7WhXHVQjQQmRYyDqgDvPFDXZwgE2NkMQY/kNmgwNe4GfHBs
 pHVBiViAR2knN/22g958Ma294ayCdrHXqfUFbhg2cTnhG012WImV/Uc1/RijnkepTt1H4ilALGm
 L
X-Gm-Gg: ASbGnctRmPmOZvDqBji5oQnloXROJzbxZjHxFa+XD+h8snQHt8Jg9Mb/XuKKwFhOAuN
 dZN1bUrvEq5teOJAXYWAI80C8gTCFSrLl2ZPfkDwGVnDLpk5BD+Gojc8LoUXJTBaBTL7IDXJVwJ
 4QOdDQSTReV2Vf+1/lTcDuKB2jfPlQBt0N77UsEmIRc23T1WnU+jtegNYHkYPOTkqsJkKkuDqmg
 ZFv15WOTxvR5fVc86++gVg1Pcp6LFMovpnVpFRdHsi9PuDas83eEjEb4nrMC+zdUAsEI5yabiM2
 ifRiBbvrx8vVy8fFpJhs+rAe5uM/Ufa4nQ==
X-Google-Smtp-Source: AGHT+IFQJ+f+xdu5EN1K9cLNdNQDVqgq3WRcHH8aaTDdJdYl52iFLMWDmoh2zP52MCvXMzDfch4UyA==
X-Received: by 2002:a17:907:3e91:b0:aaf:74b3:80db with SMTP id
 a640c23a62f3a-ab2ab670608mr119469566b.3.1736320777513; 
 Tue, 07 Jan 2025 23:19:37 -0800 (PST)
Received: from localhost.localdomain (ppp176092181030.access.hol.gr.
 [176.92.181.30]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d80701abdcsm24881213a12.74.2025.01.07.23.19.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 23:19:36 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: u-boot@lists.denx.de,
	trini@konsulko.com
Cc: xypron.glpk@gmx.de,
	ilias.apalodimas@linaro.org,
	raymond.mao@linaro.org
Subject: Pull request for tpm-master-07012025
Date: Wed,  8 Jan 2025 09:19:33 +0200
Message-ID: <20250108071933.2908136-1-ilias.apalodimas@linaro.org>
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

The following changes since commit 6d41f0a39d6423c8e57e92ebbe9f8c0333a63f72:

  Prepare v2025.01 (2025-01-06 18:54:44 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-tpm/ tags/tpm-master-07012025

for you to fetch changes up to 70a3f0efa1a8ac5e13bb06660f602deb75360dc8:

  tpm: update descriptions in tpm headers (2025-01-07 15:45:52 +0200)

The CI at https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/24102
showed no errors. Also my internal CI that tests replaying the TF-A generated
EventLog passed with no issues.

Please pull!
/Ilias
----------------------------------------------------------------
A few changes for the TPM subsystem wrt to EventLong creation and measurements.

Generally speaking it's insecure for a TPM to not cap all the active PCRs
when performing measurements.
Up to now we had code querying the active PCR banks on the fly and reason
whether it should perform a measurement or not. Since a TPM requires a reset
to change the active PCR banks, it's easier and faster to store them in an
array in the device private data and check against that.

This relates to an interesting feature some bootloaders have. For example
TF-A can't extend a PCR since it has no TPM drivers, but can produce an
EventLog that U-Boot can replay on the hardware once that comes up.
The supported hash algorithms of the TF-A generated Eventlog are generated
at compile time. When trying to replay an EventLog the TPM active PCR banks
and the created EventLog algorithms must agree. We used to report an error
but that changed in commit 97707f12fdab ("tpm: Support boot measurements").

This PR also brings up the old behavior and an error is reported now while
printing a human readable list of the mismatched algorithms.

----------------------------------------------------------------
Heinrich Schuchardt (1):
      tpm: update descriptions in tpm headers

Ilias Apalodimas (7):
      tpm: Rename tpm2_is_active_pcr()
      tpm: Rename tpm2_allow_extend()
      tpm: Don't create an EventLog if algorithms are misconfigured
      tpm: Keep the active PCRs in the chip private data
      tpm: Simplify tcg2_create_digest()
      tpm: Simplify tcg2_log_init()
      tpm: Don't replay an EventLog if tcg2_log_parse() fails

Raymond Mao (3):
      tpm: refactor tcg2_get_pcr_info()
      tpm: add flag in hash_algo_list and API to check if algorithm is supported
      tpm: add kconfig control in tcg2_create_digest()

 include/tpm-common.h |  16 ++++-
 include/tpm-v2.h     |  99 ++++++++++++++++++++-------
 include/tpm_tcg2.h   |  12 ++--
 lib/tpm-v2.c         |  72 +++++++++++++++++--
 lib/tpm_tcg2.c       | 190 +++++++++++++++++++++++++++------------------------
 5 files changed, 258 insertions(+), 131 deletions(-)
