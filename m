Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E3FC369AB
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 12:54:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D27DE82A33;
	Tue, 15 Apr 2025 14:54:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ignj3efn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D94282AF6; Tue, 15 Apr 2025 14:54:04 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4281E8214D
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 14:54:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-399737f4fa4so3189938f8f.0
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 05:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744721641; x=1745326441; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+JXTWeKo37DgleHbE9xQhU6ZlwHefxgTdQhwA6K9Or8=;
 b=ignj3efnHw506Ya3R15mdN/LlBRL0c8hozabifI00XdB0M9OIKiRmmY+5FNjMyqEqA
 zfDihfbGPk7VI5Q56kcHNTiGRDMbOEaSO9zSAMLbSYIMCtd/kk2wSAMezWIltsOjzkud
 +IsexxTKdX8vDt8M7xLJHVTujSvuJQwidBtxXj/ZZdwtuoSplSv0zvFSccW6HMigE7fD
 n9raRQ40MXJqG8WxT8PxNYToaAmu5uhJlrLCjNe3DJWRWgL4wQYR1vrWSw1HBN3KZv41
 qtbVhzD8QjqdWHy03epfIDQKkM7UAfur4r3Bm0vFGGPaIrt1xXi9E0PJmlRTuKV8NbkB
 UhiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744721641; x=1745326441;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+JXTWeKo37DgleHbE9xQhU6ZlwHefxgTdQhwA6K9Or8=;
 b=WCFLhoKuR9sG9QRndzMXjQRzNgNZpBU2J6AchNETsBhsHUmfNPYe8Tns3rITI8v3on
 WlOMviJe3E4AecyArt3a6nhC/e0dy+RXp2nOjLuDJ/a6yxrElxAXEoXWPN3MGDrOg8iO
 4p/LiiaWEg5iL4ZOyLAWZz31O+1vbLYXiCQOGlxPLhDna3mlkh5MGTb4xir74dEe6LPw
 Fmpe+bgd/ipzZmHbmseScqzXyzPRTwDPrUJeux+pagZDhCS0h2Yy5NSO6W5cfrb9p0F3
 bK6CzV5eA5Wx4GrGDBneA3Nwa1JO90QuuyY5lo/xKSzs/bNs4yXEqJnfrgfdeCdt8NWc
 e3eQ==
X-Gm-Message-State: AOJu0YyPVs97DaHG0OGq5tZtdaLYMbp/QjBWeeSYlcUCGb9wnOz0rJvO
 nDoaBz0duHlgV5wK/IIIXwuptgKNxoeiQEFsf5uTSHSBRPhQhBjVwkARU+A8AvN7ztnasEQSJBP
 Rqj0=
X-Gm-Gg: ASbGncvV2bF8LAjDxsB42gW4IKU8QPy7SicqJVSc7vLtY2YBtT9tQn9ZxeHxg+BWPEK
 7ynR7Q0Q2LnqqWEaKQczC3CLwID4t4wJ/ZjJm7RAr4Q9CeiMmFx2ajhVkqBGoIuvrs3vScnAcX5
 N4bpDLAlGbIYM9b22Jb5YVnE9PirriW48BzUp8r3pRsyOkm62RAJYFAq1hnB3qMOV+Gtmz1RPqm
 JxsieRw064pFJuBROIBr9NafQcgw4sdVyTNUh/r7NbQw9Q6s85SPIt91Ws0fzZ4qFL8tAXPBxbq
 OmGG2XPvG7QHhfh5q7umvIS0UObIb7oqSiX6GEVhaZrtMlZJ
X-Google-Smtp-Source: AGHT+IHJ3LHBxz2afC3yKFqNTqX8RmrWJIQu4FdnxmGrgS47Io3SgQR0wx3LQ84O5ufTys546gH+gA==
X-Received: by 2002:a5d:588a:0:b0:39c:223f:2770 with SMTP id
 ffacd0b85a97d-39ea52035e1mr13922078f8f.15.1744721641528; 
 Tue, 15 Apr 2025 05:54:01 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6ebc:6ce:770e:95f9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f233c8224sm205921315e9.22.2025.04.15.05.54.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 05:54:01 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: [PATCH v1 0/2] ut: fix print_guid() and enable UNIT_TEST for
 qemu_arm64
Date: Tue, 15 Apr 2025 14:53:30 +0200
Message-ID: <20250415125345.427420-1-jerome.forissier@linaro.org>
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


There is a bug in the print_guid() unit test in test/common/print.c when
PARTITION_TYPE_GUID is not enabled but either CMD_EFIDEBUG or EFI are.

The first patch fixes the issue and the second one enables UNIT_TEST in
the qemu_arm64 defconfig so that the unit tests are run in CI (this
platform has CMD_EFIDEBUG so the bug applies).


Jerome Forissier (2):
  test: fix print_guid()
  qemu-arm64: enable UNIT_TEST

 configs/qemu_arm64_defconfig | 1 +
 test/common/print.c          | 2 ++
 2 files changed, 3 insertions(+)

-- 
2.43.0

base-commit: 8c98b57d72d5e5b94ed064fe1041e51216165334
branch: fix-qemu64-ut
