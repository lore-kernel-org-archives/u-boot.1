Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 219FAC25B74
	for <u-boot@archiver.kernel.org>; Mon, 27 May 2024 06:15:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DF3387D5F;
	Mon, 27 May 2024 08:15:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yrqcAG8Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52A4688228; Mon, 27 May 2024 08:15:10 +0200 (CEST)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB32887C75
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 08:15:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2e72224c395so85206561fa.3
 for <u-boot@lists.denx.de>; Sun, 26 May 2024 23:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716790507; x=1717395307; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dwxI66VAYJF0FDH3lf4LfwD2O50HJxN/ySLMQfQdVr0=;
 b=yrqcAG8Yz9XYCM+OIARNugx5HFW9sz+wkKVJPdG+zbPGKUGQQnCJoDE7qieiAbB/iE
 JP0WgSWyN3qGJWT9D+xjO4MZyzHtL/4YqYhaMOF7OKCFogZaD6bHrwAZWwy5j30jV+32
 Ut5UlBxMSJ+DkPet0gBpMJ6Xz7Nr4U8R7w7Q0IwvT8tAakrTWGXXDWztJvM0Tj3LHYv4
 khr6SVI77u9x08aQ915/DCYfMwTAfypv646aKo7vcrei6wbE+oL3SqYbb6bxqLMg8aRe
 mIVl46/04XP/ujPHgM4zPYCx7/Y8KHKIdy7ScsImrCSnCpleyqoRvyuGe1YVvcSszPXT
 8JTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716790507; x=1717395307;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dwxI66VAYJF0FDH3lf4LfwD2O50HJxN/ySLMQfQdVr0=;
 b=qCKx/XKXgx0wVJ3ddHRq7ZHIkRFOIbh/VdVulEOGmx/kWRztOjh8C7Zf0dmDElqxXw
 tHg4LjGKK+liP3U1jSdFvxwknclBWYndRQfawgk0mTH1tCh8B9QQ3AiD2W1K3AoISMsQ
 giaf92OwggB8cAzGglz1RGoXe5cba46PuVdsyKW6crYeYBqsRy8KIv6lvYwV4KRlg+aW
 vZRlfzXlgpWHpN48OQk6BkZk+gixi3zrVIftHHtn3B+BxvieEsTrmrplGlvfPP9IxXwo
 ks1zzStYM0WUp4pAOF8heGx65ISnO2i3EttmkipKjD0Q6/sf9D13fBdH2LOjKIqRSNwT
 D+Qw==
X-Gm-Message-State: AOJu0YzUpfpqZ3G3Q6eMwNH2sd/rY5d/qv6tAONZeYEQsyNweEaWwtO/
 0Y6ULSKhOIurgz0bXDDwSWuS84d55jPhEdVTDTWwW+hCC6a9tBHNjhHXXnoLR4Jix2kt9n1fyvm
 l
X-Google-Smtp-Source: AGHT+IE9tSD314DBF5fZYLd+9KptTL/AsqmDDf8yT8pyIKpRxbs4R7r+NrjToETCRSkmsAMCqHnwNA==
X-Received: by 2002:a2e:9f43:0:b0:2d8:8eb4:11a6 with SMTP id
 38308e7fff4ca-2e95b08c1b7mr49767911fa.12.1716790506975; 
 Sun, 26 May 2024 23:15:06 -0700 (PDT)
Received: from localhost.localdomain (ppp089210091242.access.hol.gr.
 [89.210.91.242]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-358a33e6f03sm2794517f8f.36.2024.05.26.23.15.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 23:15:06 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: u-boot@lists.denx.de,
	trini@konsulko.com
Cc: ilias.apalodimas@linaro.org,
	tharvey@gateworks.com
Subject: Pull request for tpm-master-27052024
Date: Mon, 27 May 2024 09:15:04 +0300
Message-ID: <20240527061504.19822-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.1
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

I know it's not early in the release and although this contains a new feature
apart from fixes, I prefer this going into -master. The added feature
is on a TPM cmd and is harmless. If you only want the fixes please let me
know and I'll send the rest in -next

The following changes since commit a7f0154c412859323396111dd0c09dbafbc153cb:

  Prepare v2024.07-rc3 (2024-05-20 10:05:16 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-tpm/ tags/tpm-master-27052024

for you to fetch changes up to 89aa8463cdf3919ca4f04fc24ec8b154ff56d97e:

  tpm-v2: allow algorithm name to be configured for pcr_read and pcr_extend (2024-05-27 09:00:27 +0300)

The CI https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/20873
had no issues

Please consider pulling

Thanks
/Ilias

----------------------------------------------------------------
Tim fixed
- An inconsistency in the reported active PCR banks.
  This was only affecting EFI applications requesting the
  active PCR banks from the TPM.
- Adjusted the error message when a reset GPIO for the TPM
  was not found. It now prints a reasonable error message,
  instead of just printing that GPIO was not found
- Enhanced the tpm command functionality. We can now define the
  algorithm(sha1, 256 etc) we want to use while extending or
  reading PCRs

----------------------------------------------------------------
Tim Harvey (3):
      tpm: display warning if using gpio reset with TPM
      tpm-v2: add support for mapping algorithm names to algos
      tpm-v2: allow algorithm name to be configured for pcr_read and pcr_extend

 cmd/tpm-v2.c               | 49 +++++++++++++++++++--------
 drivers/tpm/tpm2_tis_spi.c | 21 +++++++-----
 include/tpm-v2.h           | 77 +++++++++++++++++++++++++++++++++++++++++--
 lib/efi_loader/efi_tcg2.c  |  6 ++--
 lib/tpm-v2.c               | 82 +++++++++++++++++++++++++++++-----------------
 test/py/tests/test_tpm2.py |  2 +-
 6 files changed, 177 insertions(+), 60 deletions(-)
