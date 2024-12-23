Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B08B0E7718B
	for <u-boot@archiver.kernel.org>; Mon, 23 Dec 2024 14:47:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5BE1806FC;
	Mon, 23 Dec 2024 15:47:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="C1+QXOvg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6FD780704; Mon, 23 Dec 2024 15:47:49 +0100 (CET)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91582806D4
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 15:47:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7b98a2e3b3eso184037485a.2
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 06:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734965266; x=1735570066; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2yWbh1zWnh9x242OqYtnLdY02gWlC1YgLKwnLWJ2ygY=;
 b=C1+QXOvgZPbJaNyK20JVvbjwv94lFlc2QdQyEPgMB033bRxTB550s1Pk20w/MK5ryW
 BPwbSyIgVqDmbcS1KVOQaYH6YuRb04YHtHQnGDzJS+a/LoKEpMHGNTSFBfJN8lZEoHTh
 8L5LmPE5W3eaQSUhYIvbi0+OSfBT9n/0Sf9FnGNmGibR+XDdp29DhY4m/zowezqdLpZs
 M7fU0GMPzMDIRYNnKu1u4zx1Q7LtfP0ECgI4G5ukbs6E11bFx0anO+q1KWCt5/uN7vI9
 IuaGkS76ZyXeIDzqe4RbiUGAqWDXsZdmSGpWrlbniOAXXp4hvNyKC4OAbFKIXDXvKE6l
 DVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734965266; x=1735570066;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2yWbh1zWnh9x242OqYtnLdY02gWlC1YgLKwnLWJ2ygY=;
 b=CBtsJke9uVIpkDe+UsEgazjsGAOKGPbLsZlkFbr836WXORvsbL6hdAkkqSvulYc2Ct
 AKWA5gPLfuPGxEYAQE+4huwNEechbt9oqsVx1sJLWmyTJMM9cSrBilUdnvziSL0vGKS9
 viVNsxdofDXWrvnLPVeTY4g4Kxa2fHQidAbK81qLNT42dAgqR5tqIaLiqK0yWbIlUryt
 3nfDmEEET/EHgBlMLsGilDQ4PLqOzmNqa/9aLOkYUgE6zhG1onRZ63LYAz7iYLPA+sir
 3RTqYUzfAFQjJPponvz3ktvjLz8dsMEtmMl+kxAVer+LUiYCWjydxB1N0RhiZYbBFumt
 8BuA==
X-Gm-Message-State: AOJu0YxTlcPez5j9dhCFvY99OJZHfMJL/4KtpxjBDjQtn96ROx3sM2JX
 G9otm5y6RuIZ5SYJohojq3wVQTMWTHDMF+4oWmDBhOkkyhgr/ibDGeHPfY5oFFK4fmyWoFpxxf8
 1
X-Gm-Gg: ASbGncv+FEuYUWUeNzZEyB1ivcehdjxdk8BGPMz9rYYQdXD759Ga+UotxRf6va3HiF2
 f9+cxlnf872+9NhtErHLBh4VEj5QrfaFUdYckD5ZXt+sNCBfOygR5hOGOHkKeQL7N6q0mfQl2hs
 C4FNfPuSfbfbqeaQvnuh4hhJY2CSW5VqJHzDFPM0C6brXbZnCkSUd9QrLPXLZEr61JT0clfcda2
 N5jjVoZ1FSnjCHSz4FRtlAMeijrt+4lv1chb6p3LIBHqXMYGO+N/buPnrhpBX9ghgMXpqhBkcYv
 taAP4Zx3nRMqH+ZRv8BKeckyLhM5zJuoJXbp6S3Z6nuqXw3z5lMxT50=
X-Google-Smtp-Source: AGHT+IHdSFGHxbxFfz5RTabOHwNG6KXPmLPDrBlEhJ2kGuTXMfp8P0VA3Fvjsuii6A7tp7fVMrsDIQ==
X-Received: by 2002:a05:6214:413:b0:6d8:7ed4:335b with SMTP id
 6a1803df08f44-6dd2334bf3cmr219470106d6.26.1734965265975; 
 Mon, 23 Dec 2024 06:47:45 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd181bb519sm44243246d6.83.2024.12.23.06.47.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Dec 2024 06:47:45 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tim Harvey <tharvey@gateworks.com>, Simon Glass <sjg@chromium.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Eddie James <eajames@linux.ibm.com>
Subject: [PATCH 00/11] Tpm exit with error when algorithm dismatches
Date: Mon, 23 Dec 2024 06:47:22 -0800
Message-Id: <20241223144737.554992-1-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
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

This patch series add the logic to report errors when:
1. An eventlog is handed over from the previous boot stage but TPM device
   was configurated with an algorithm that does not exist in the eventlog.
2. TPM device was configurated with an algorithm that is not supported by
   U-Boot.
3. Failures observed when parsing the eventlog.

In all above cases, tpm_tcg2 should exit with error and prompt logs.

Moveover, this series include miscellaneous fixes and refactoring to
simplify the logics in tpm and tpm_tcg2.

Ilias Apalodimas (8):
  efi_loader: Don't warn if the TCG2 FinalEvents table is not installed
  tpm: Rename tpm2_is_active_pcr()
  tpm: Rename tpm2_allow_extend()
  tpm: Don't create an EventLog if algorithms are misconfigured
  tpm: Keep the active PCRs in the chip private data
  tpm: Simplify tcg2_create_digest()
  tpm: Simplify tcg2_log_init()
  tpm: Don't replay an EventLog if tcg2_log_parse() fails

Raymond Mao (3):
  tpm: refactor tcg2_get_pcr_info()
  tpm: add flag in hash_algo_list and API to check if algorithm is
    supported
  tpm: add kconfig control in tcg2_create_digest()

 include/tpm-common.h      |  18 +++-
 include/tpm-v2.h          |  65 ++++++++-----
 include/tpm_tcg2.h        |  12 +--
 lib/efi_loader/efi_tcg2.c |   2 +-
 lib/tpm-v2.c              |  72 +++++++++++++--
 lib/tpm_tcg2.c            | 190 ++++++++++++++++++++------------------
 6 files changed, 230 insertions(+), 129 deletions(-)

-- 
2.25.1

