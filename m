Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D06BAE6F079
	for <u-boot@archiver.kernel.org>; Tue, 23 Dec 2025 09:29:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BF9783EE2;
	Tue, 23 Dec 2025 10:29:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JeaY9Wkl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C817183F4C; Tue, 23 Dec 2025 10:29:40 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 825A983BF1
 for <u-boot@lists.denx.de>; Tue, 23 Dec 2025 10:29:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-430f5ecaa08so2152362f8f.3
 for <u-boot@lists.denx.de>; Tue, 23 Dec 2025 01:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766482178; x=1767086978; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tJP7EAtmkUkw61d2c+evq30/RuLZhPfLyOH24mrKedU=;
 b=JeaY9WklVbbXLOz9EFR49ecVov1rwHlHguKjE5hIt3DNjNTaqr56qkKgmLJxDEpm07
 wNMHwHc3D1FE7pkBHpNBLFqO203tebJVA5cVlT2DKriVaCFEy5erW8RSO1B31sgRX3WT
 GW3CSB7um/iBkq/27ajCxWkqX1q72Xu5zEy1LQ+tYYM77UgKpNKTXYX395wU7ktwqF2Q
 qheXDnTcdtbGQoHcVhw7aKCDpoMPezopgTTt89hkV/91cmcBVR1cbCfzytxZpx/7OOkt
 +PBNCMMe5lcaPsrdbJnz5xhOXUj2HIRwik4nUkt0X92HtCa29XRolSYjuK1wXoWDs6Rc
 mmVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766482178; x=1767086978;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tJP7EAtmkUkw61d2c+evq30/RuLZhPfLyOH24mrKedU=;
 b=GU/CaI+J4zbElilpH1TEMg0poaTmgMNI/xZMCqEyU1Vm79j6x5keMdpXmuQH3kvPP3
 EC74ulLEPeLF2oXz/K0doPguhqfgcADxxDeKaGEMYWvkIRkKix2pfscq+SfNfGd7a0N/
 QnM/2a+AUVH9cfDoc9ucicZlqK8K/kMvVczRwR1UdwFj6xdIOrOgh6Cl2e//f3dpfWRv
 XwNOLI1aUVPUhZENd47nmZ8+SHlfKEZRPg/wehglWWXN+GSljGtVchzxR19xMdTpXuwf
 AaMzlcq6+aB14hKT2t5CjsJ0CLozo9aKr7lsj7M/cYyruZP0oqD7RWYKA5r6AOPMRSV+
 mDsg==
X-Gm-Message-State: AOJu0YyWS0/eoDRM3ODSB56XEfO0RsTmfrJGDlMd/GYLkwBEXu8Mcx2K
 s1nmK5DeySCh/NVKDsJ6eddvRN29/AgaYUMk0c4kztREEGc8wK1Xnjv+pC/NiA==
X-Gm-Gg: AY/fxX6tWQhh1VNVJ5yTsxjxv/zvbYndOR+ZKyyUr+AHfgBrOP2FlXU4eSGG3aLE1Kw
 MA0XLmywxQ97fwAoDbL7OMKn8yEVNlMjTuvyUjYubcK+lcDM28uYJeJ8Jbad5RXW8xwL8ZUOfLL
 28DXJ6AcQzG28bueC5ZrbbM5725hoF+Lwr76nMios0lhdYFJOnPbcgS1LyRbecE3XONGHubXOco
 6ViCnM5MCCOyqp9CYknBGFJlb3sK30LCyzvbUEN7aFxB4aI/wsDPJ3oY3+u3sO0U1OfXf/TfDRb
 nOiGC4yVZHsoaS0yIbZHAUyBQXkXtpcZsYG+y6nI1xkPtYLZKGxZOAziM8Pji6FYIAvzjrFKlEj
 w3q1z/+DoSjghofKYP8SGAKzQPZrsZ4jWyDp3v8MWlm3WOnco3Lc4kbvq84/09Xnov5lvWy8SHt
 rU
X-Google-Smtp-Source: AGHT+IGG+0Ae/RA0818ttMdI+woWrEBCSrXVORugySXMGpqj3NlON9Sag1mOrgieZyMUy/298oD+Dw==
X-Received: by 2002:a05:6000:2204:b0:431:a0:7dea with SMTP id
 ffacd0b85a97d-4324e4fcdd7mr13320476f8f.40.1766482177684; 
 Tue, 23 Dec 2025 01:29:37 -0800 (PST)
Received: from xeon ([188.163.112.70]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa477bsm26996719f8f.36.2025.12.23.01.29.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 01:29:37 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Please pull u-boot-tegra staging
Date: Tue, 23 Dec 2025 11:28:58 +0200
Message-ID: <20251223092858.5563-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
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

Dear Tom,

The following changes since commit d24f4ae65433aa7720c075a9f1d1aaf7e1985ced:

  test/py, buildman: Update filelock package version (2025-12-18 10:28:10 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-tegra.git staging

for you to fetch changes up to 5467cd5ffdbd6bdd042affb681db3615d41a4f1e:

  configs: tegra-common-post: Stop disabling device tree relocation (2025-12-21 17:01:12 +0200)

----------------------------------------------------------------
Tom Rini (1):
      configs: tegra-common-post: Stop disabling device tree relocation

 include/configs/tegra-common-post.h | 3 ---
 1 file changed, 3 deletions(-)

Thanks,
Svyatoslav Ryhel.
