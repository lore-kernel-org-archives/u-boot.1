Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5266BC677C4
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 19:15:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE64382B18;
	Tue, 10 Jun 2025 21:15:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HkGuGuqq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E14EA82B20; Tue, 10 Jun 2025 21:15:09 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AC5182B07
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 21:15:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3a53ee6fcd5so1942521f8f.1
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 12:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749582906; x=1750187706; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YjAFFsIXA7ruDXqDpQ0i3WJMmJRMTOoW2XMsOK1VMGw=;
 b=HkGuGuqqSFANl4/7/FIwrv+Zakf9FK4k7EZW1SwbtZOrceFaEOsBZv1g9aLfCFsN1R
 NGINLv1YRKzWlTO/oYapkl1aJI1flBkViuxHtIutTUUdx/Rozfva0xmWm45K66rEQdBg
 9Zhml4WYvbxKR5DMGmqhGy/lQMNHmrcpqeHuOXse+N5idVZSW4W1/2/UJyzIxdSRzdPS
 w6/69Pr8DpMiKPZVF3ayPDoqOfQgM3xJcXHuEfbIoVVLj6RSXh/aW/V+iAp714H6JVpy
 ALAxtAxsj32GCgboXhzgqNpW6oke2WvGHhMuGQN3kbCRM9QiGjeM0xa95v2ILJDiaYqs
 7R4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749582906; x=1750187706;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YjAFFsIXA7ruDXqDpQ0i3WJMmJRMTOoW2XMsOK1VMGw=;
 b=vw+WexZrzKfLKD/j56OXlp8DDjetWRS9x/Ao1/zayP2F6aftZ6vDNWGz7NB1rx11mT
 07lpFKxrvNii+3bPu9pYK0agufmuxP+kIa7xqlW0qQJWvUY+79a8f2oAxYLoB3WMeZsH
 evTa6yH4WGD0sw1cZL5HceysrytGpokpNcJf57YwNAwgHyniKRF41zHmsIoUdIJojvxm
 jE/l3yMYoD2oXk6xxJqkVITidCa4Zcy2T0D0OmvXAiGo0bkRhPdPyA3ZqE1IA2MAAEYy
 uUd4jf/S3baaE1saeAk3X0hYSgAMIaAd5t9BIhX7U/6SW/P/6wBDVcFBABQduTE2Rsqf
 XLqg==
X-Gm-Message-State: AOJu0YzoU8/xhAZN6l7pGQj38hDMpi8xMVWmP8LKLf3J83muScrHLqjt
 2l1LwixKKi+NSJzOgcl1milC0lFVgSx5VyXbG8c2hefqHqdOWpc5h4Fr9mKDL+OShe/MlJD6EiO
 2EHRw
X-Gm-Gg: ASbGncuWB0IoqeoW1k2WhnZaodewYipPdNz1HKqR2eqt69cqYoSf8FUaufpdriCuM4U
 KGBQwzADt6+bpbC+QpTwfGNrjNnYqyi+djct0pXdVDuujl8eLyyGeDkkoSPjreiZhxvj00kT3Zr
 nQd8/w1RMAXobSAneD5p9R6lkoiH4Bub6LWwByTU1eL2hubw5bw6S7TZNs4BOkGMOv55nISaCHO
 oiFlQQXNa8oKWoXN+zmLN6vgMnwx9Zz1JFv/hana/rJ8MdGwRE84JJNZhLn9BtYriOg5uT7eNR6
 u3R0FsHdXZs3R88RCh14hYlkSQr6yVcBhqeI+l+hqhbio44GnWwDWCpiYnPM/ZIMBbh7cjOX+an
 YQik2fRaqI4BPK2FMKMKbVaVpQLqVzblb70jz6TYQyFJMfWBXItA=
X-Google-Smtp-Source: AGHT+IG8oyX9YHJHC6swuBws4T5rbeCnUuJ+WwKuMesM4uxrDcdm/eRzMZGjIZGXOkf52q+aaqqTSg==
X-Received: by 2002:a5d:64e3:0:b0:3a0:b84d:60cc with SMTP id
 ffacd0b85a97d-3a558aa5ab9mr134727f8f.2.1749582905666; 
 Tue, 10 Jun 2025 12:15:05 -0700 (PDT)
Received: from localhost.localdomain (ppp089210105145.access.hol.gr.
 [89.210.105.145]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4521375b5e1sm151958445e9.37.2025.06.10.12.15.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 12:15:05 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: u-boot@lists.denx.de,
	trini@konsulko.com
Cc: ilias.apalodimas@linaro.org,
	sjg@chromium.org
Subject: Pull request for tpm-next-10062025
Date: Tue, 10 Jun 2025 22:15:03 +0300
Message-ID: <20250610191503.1708064-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.49.0
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

Small updates for testing TPMs for -next

The following changes since commit 59d00e20fced23e6463aa09db889dd548baee677:

  Merge tag 'v2025.07-rc4' into next (2025-06-09 16:28:28 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-tpm/ tags/tpm-next-10062025

for you to fetch changes up to 693b7a738d6d23001da7c6224449b3d300efd1da:

  test: tpm: Skip failing tests on coral (2025-06-10 19:35:58 +0300)

The CI had no issues
https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/26601

Please pull
/Ilias

----------------------------------------------------------------
Updates from Simon cleaning up some tests, with the intention of being used
in sandbox and actual hardware.

----------------------------------------------------------------
Simon Glass (4):
      tpm: sandbox: Support self-test continue in emulator
      tpm: Convert sandbox-focussed tests to C
      tpm: Drop unwanted special cases for sandbox
      test: tpm: Skip failing tests on coral

 drivers/tpm/tpm_tis_sandbox.c |  1 +
 test/dm/tpm.c                 | 77 +++++++++++++++++++++++++++++++++++++-
 test/py/tests/test_tpm2.py    | 86 +++++++------------------------------------
 3 files changed, 89 insertions(+), 75 deletions(-)
