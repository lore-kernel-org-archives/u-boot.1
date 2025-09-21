Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96579CAC59A
	for <u-boot@archiver.kernel.org>; Sun, 21 Sep 2025 17:43:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05760832DA;
	Sun, 21 Sep 2025 19:43:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PfMrGg2J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4261B833E9; Sun, 21 Sep 2025 19:43:36 +0200 (CEST)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F9938317B
 for <u-boot@lists.denx.de>; Sun, 21 Sep 2025 19:43:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-36295d53a10so28680101fa.0
 for <u-boot@lists.denx.de>; Sun, 21 Sep 2025 10:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758476613; x=1759081413; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=c6TZC6M0i3v4FxxtzfW2lMlnTMuKs2gjzDhBEStUmwM=;
 b=PfMrGg2Jfp7gIRGrFxGdgy2mzEiY/XuSVxnOBJ2ifVTeq8pFpvkeI7S8z1TwR1ETfa
 tGX6NTA5xRMC8pl/inAkC5e6CvD2XecGeJ/dCTOfSto6/vbajvTGad/glJQqfO12ilQg
 firHY82eykuZsZ0k97hzj/AXvx/uOWS32vIgqqOjr29+hLTnA0BELH8DdoM2l+rmwxxE
 BMSe/V0rQ1wiESnyXamTEEQeMJweu4PDalIICwU40r4OM1FTWuZJlDf1V7t11nk+ijCd
 oB2EM9gtqGF7Up2DEJOmgyMaEUER/SlmfpZuGIMIqBw9SjgQ57o3MaQ0ccHX6CkYoMjO
 a0ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758476613; x=1759081413;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c6TZC6M0i3v4FxxtzfW2lMlnTMuKs2gjzDhBEStUmwM=;
 b=QWs5z340UNFVArbhCX6es3N2s0xPHLXq7phLVm/YUX1yZjAbdNSiE75OACRPz/3WyS
 b5uYuF7ok1iQdhoIo/JCeWroELSPMdVP5QTCsGPmVHiPy1KYCsd3ILVtMWmfRU2lOSxj
 WDDg5o/ZZvVjPeizt6Gj1OlI5YrF/zpZwv+IByGyUhCSNECFQIFDNr80KmcnmQCaXQCx
 r7y7q0EcIAtMS5TBPBI5a/djYBU+z+i+KQmllV4O6WaxBuLw+UKZoORqD2OwjtCrMf6F
 7nDCjfl/VnOX3aiFY9tDLPKB96tL5zSb+9DjjMcazSeNvPDo2LmSiLk/KRb2zk8+152g
 sc4w==
X-Gm-Message-State: AOJu0YyrFf58BcMMBYj0tZjkZhkyoJeQFrJpCm2DLcARJSHp4od7fptq
 o45XhtXi0eT27wu8GcFflWJADnZ4aEwS9X3pXdM1PqohRleOdLHijj9d
X-Gm-Gg: ASbGncuuwI2tPgAugtemmnU9/lbspGKHz6OPq6CKP8dL8sd082jCifgYNLYI+VBYeom
 8aky+kTHTpbqcKr5bEZvI1JJ+kkYXfwlgzWFpjWu0D6VYQ8KSDqfmhiEKaLSy3ct60hVjVteibx
 QiEzMmaq9YROgENZ4IKc2P1gCJoNf9ZN9IU1MO5Et3ztVDuYOgd6gl1VmY4g3ItyckEpRpRb2G9
 AZVAnB12IGw9AgIBLMAzCm6Wpr/EL1jJYr7TFYQihSC0JHv8YwOVrAcdvqe4AMEE6Itz/MlpSTW
 uBjdSvZEa2xBelK9ato88a8H3ltwmpv7+Zy+1Xv8upOmTijY6c/iPm/o7v7oPsox97NMMRgDLMX
 rMZJU1agzgL6nWQ==
X-Google-Smtp-Source: AGHT+IHMt1iEZ+REUgh6/yp1eEkQ8dDkElUs/DofIxhB2g5396WUadrJw/rN7VzMqIqaUKM5L0kXPg==
X-Received: by 2002:a05:651c:4393:10b0:336:c290:b321 with SMTP id
 38308e7fff4ca-364147be9dcmr23386361fa.13.1758476613240; 
 Sun, 21 Sep 2025 10:43:33 -0700 (PDT)
Received: from xeon.. ([188.163.112.70]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-36815abf943sm8473761fa.61.2025.09.21.10.43.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Sep 2025 10:43:32 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>,
	Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/1] Tegra: remove ATAGS support
Date: Sun, 21 Sep 2025 20:43:11 +0300
Message-ID: <20250921174312.154990-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
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

Remove ATAGS support from defconfigs where it is set.

Svyatoslav Ryhel (1):
  configs: tegra: remove ATAGS support

 configs/chagall_defconfig         | 3 ---
 configs/endeavoru_defconfig       | 3 ---
 configs/grouper_defconfig         | 3 ---
 configs/ideapad-yoga-11_defconfig | 3 ---
 configs/mocha_defconfig           | 3 ---
 configs/mot_defconfig             | 3 ---
 configs/n1_defconfig              | 3 ---
 configs/ouya_defconfig            | 3 ---
 configs/picasso_defconfig         | 3 ---
 configs/qc750_defconfig           | 3 ---
 configs/star_defconfig            | 3 ---
 configs/surface-2_defconfig       | 3 ---
 configs/surface-rt_defconfig      | 3 ---
 configs/tegratab_defconfig        | 3 ---
 configs/tf701t_defconfig          | 3 ---
 configs/transformer_t20_defconfig | 3 ---
 configs/transformer_t30_defconfig | 3 ---
 configs/x3_t30_defconfig          | 3 ---
 18 files changed, 54 deletions(-)

-- 
2.48.1

