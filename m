Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37630C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 02:36:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6018788679;
	Fri, 19 Apr 2024 04:36:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dJzSM+od";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08EDD885D7; Fri, 19 Apr 2024 04:36:39 +0200 (CEST)
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com
 [IPv6:2607:f8b0:4864:20::a29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54A1F8866E
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 04:36:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-4dabbf19e1eso455178e0c.0
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 19:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713494194; x=1714098994; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6FsYid/+PER9spMIEMLVUsCzS2tJS1Q3YlPlE0t+fMw=;
 b=dJzSM+od+UjM0oBkfnF4nAMRQoVNxxXJJO/cygk7o9Y+DakPzlAzFUHzkiv1F8szNc
 FV2dkxTT4N4tfvq4STuw57GP1SfopGFqRpiNfTY8kBazT8tRhQqV6/YTBpm/HUB7Sa4R
 kWyvGJ315Unyd0aul3ZFKW2ulilBgerbG1UE0L/+TxT6FpKNUhm1iAk4ctPWB7+or/4j
 RkaYvvSFuxW7/9TOgZ57d2z8xUJF3KRjgPOW40tasSlK/rdiRkx72LVcLgz3ecE0t7Cp
 xM+VbuEMWqY7Hg2SKd1xColBI7iKXCCaEzQV/FKwUsB2XwI36OWCF4poGx/GVFxBp2Bg
 BdEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713494194; x=1714098994;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6FsYid/+PER9spMIEMLVUsCzS2tJS1Q3YlPlE0t+fMw=;
 b=LPX2Cm3c87iq7EdpVdP0o9xCZJVGWoSKRiBv80xxmeb4oFKTM5R866aHkYH6ahp8Iw
 HALSbMu1urJ6KUTCYwm6hWWYzSlvZj37LGzXh2olxyx1272UgqB6kdX2bNy4w55NKFeD
 gKWXBb8ySLx7sGidJcBz3oAiUfCpl9fKrgEkc+4y4HlWBtTCXlUvxN2/NnKTH2qPJjhY
 9dbT/LCxfdqWfsbKR/BQNPiX6CRukuwA6ScG76VaLxe2nZzo9CpZnoLG9/e9iixHIkEu
 z1eu1mQSM1c37RV1oGzX739uh+vf6+ldBtYmI1Iq+H1QyU5BM3bMyHxVDaNfsexV8x1u
 T3OQ==
X-Gm-Message-State: AOJu0YyRkco/87bKIn8zk470VgYrE33R8FoqoWKtGyktSHk/mg7XXpvC
 QTtmnNZpxYGG4fOCs4lP8cd74QBx0QE7oQEe9yG8/wnjT6QjgnnRY+tc+Q==
X-Google-Smtp-Source: AGHT+IHyteKt6/uDuaFHRI8V8RQY29kW2savoRGlgdIMhVqtMecXJ+S1O1wd+dOHTMOF3Lquqb5FIw==
X-Received: by 2002:a05:6122:903:b0:4ca:80c5:7544 with SMTP id
 j3-20020a056122090300b004ca80c57544mr773203vka.4.1713494194326; 
 Thu, 18 Apr 2024 19:36:34 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 b3-20020a0cc983000000b0069b588747dbsm1181234qvk.132.2024.04.18.19.36.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Apr 2024 19:36:34 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Sean Anderson <seanga2@gmail.com>, Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 0/3] patman: A fix and some new tags
Date: Thu, 18 Apr 2024 22:36:29 -0400
Message-Id: <20240419023632.29078-1-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
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

This series has a fix along with a couple of convenient tags.


Sean Anderson (3):
  patman: Fix tests if add_maintainers is set to False
  patman: Add Commit-cc as an alias for Patch-cc
  patman: Add a tag for when a patch gets added to a series

 tools/patman/func_test.py                         | 10 ++++++++--
 tools/patman/patchstream.py                       |  7 +++++++
 tools/patman/patman.rst                           | 15 ++++++++++++++-
 ...cast-for-sandbox-in-fdtdec_setup_mem_siz.patch |  2 ++
 tools/patman/test/test01.txt                      |  2 ++
 5 files changed, 33 insertions(+), 3 deletions(-)

-- 
2.37.1

