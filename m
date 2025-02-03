Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 076A6C02190
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 05:17:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1589280087;
	Mon,  3 Feb 2025 06:17:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dS5x+yXF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BDCB801BE; Mon,  3 Feb 2025 06:17:35 +0100 (CET)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF7C080079
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 06:17:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-216426b0865so65794215ad.0
 for <u-boot@lists.denx.de>; Sun, 02 Feb 2025 21:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738559851; x=1739164651; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VJqmWAMDmUmyiqFwJgRcCgshT08h6XyD0w71Mhe6zrc=;
 b=dS5x+yXFl148aaKBy4iPUTOCCoiJ/WDVdLl3tJ9ws/kPJoG9rmFfvkAKb2dgNYbQvV
 qVxpXQQKs/7iEsCZxAdF9B42qvAO6x5e/8uyLoVGZZgTtjN25xCst7YFWtVdSeWODYp7
 xe7sxcLGcIL35y0/l+Gfse++x2puOMMqbi828pp0J6hJdcl6SNP3vcetNn0yhM7r+oWf
 7IzhjtpGFGEyY8srVMakLsLZRWR3x63lmEdGeMASXdTXPwhJequqW1TIcq/wpVLgmCYM
 +c9JiyKSBaoCmwWaLsLsOgk6vhF3+M5xSB5FiVtF+CEOKdDsJTytwSlC5/Rw0ycUUBJL
 Y0oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738559851; x=1739164651;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VJqmWAMDmUmyiqFwJgRcCgshT08h6XyD0w71Mhe6zrc=;
 b=Lm89t846up3nHWAf5NwJVH9vwz0XQLZDXB++kuoLM+nCBnJTo/cYlmLUIznri0kNUb
 U61prRBduf7Vpm/yhT5ivfKeg7PZp88M03/g6oIC5A2ozdoe4N064TQXVnvGapMVa/Ad
 b9C1FAhiCENJaEWrW1cO3g8g2Ex96iHqdqG61HSsRYj0r/ktGXQh+K36tDEW5X24jLBx
 D7cgnjv65Ja+uYr26ZTjPr/9ejXagMu23XUH/+aSE6o7mQx5kgsx3FgAdgTL8mRmKVg5
 sJoOL0CAtXZOtNGqUvryPupNfYk+aD6AK/cXi78c0H9yTfYYcapyAL9dCt583fHBPQcd
 lBDw==
X-Gm-Message-State: AOJu0Yz4LjgGXonsLBDJXsYYGcjUtkdN9X0pt8XwJeIz3ZpwAm3GMVzn
 /kuEMnJuPWFkx6bZZVf8tKASlpqLyKrTJ82n4UmdWzTqDBDivR1lFJ79W3nA
X-Gm-Gg: ASbGncv2+C6EnDUOBudpprlmtNN8CqI9tZC7iEGzwPRPysDHoCIp91HCoYLLGGhn7vz
 B6lf6/bJpxF8HOoLwBHBGryvLNp2vz+bDFGE7OmBOeIhHyyJpRkgjBnVPihG1B6/M6KZyfKRo2p
 msx9NknlL6OacD48gESyy9fAKsxX8KKe9yyhOtDMUb4cqNizSVBKMnWIisNtXeHuiLdUrfKX1Pa
 uuz/0rnK7mp7JyBCyGKCcjYWi3Li4gYeFo6aodEsux5x1P2CsaVGjMPpoym0qzOR+v6cS/1GGzn
 Su9v1BU8IjBTfU1QnDoiJ+qAmUMcGxFAVlSoyNMJx5jZnx/RZLiBrDbCxthm/dZW6cEnvuMeRI8
 I1RGZ3w==
X-Google-Smtp-Source: AGHT+IEcDiuzxDly5Ed3Bt9zcoqSOLI+g/PEJqFSxn5e+zz2CkLuclJw1Gg7CwoPemxGG+PqP+Br/A==
X-Received: by 2002:a05:6a20:d04f:b0:1e1:a9dd:5a68 with SMTP id
 adf61e73a8af0-1ed7a463257mr30047353637.1.1738559851196; 
 Sun, 02 Feb 2025 21:17:31 -0800 (PST)
Received: from ISCN5CG2520RPD.infineon.com (sp49-96-228-226.msd.spmode.ne.jp.
 [49.96.228.226]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72fe6539fc4sm7508639b3a.73.2025.02.02.21.17.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Feb 2025 21:17:30 -0800 (PST)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, jagan@amarulasolutions.com, vigneshr@ti.com,
 tudor.ambarus@linaro.org, pratyush@kernel.org, tkuw584924@gmail.com,
 Bacem.Daassi@infineon.com, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [PATCH 0/2] Add support for Infineon S28HL256T and S28HL02GT
Date: Mon,  3 Feb 2025 14:17:10 +0900
Message-Id: <cover.1738559198.git.Takahiro.Kuwano@infineon.com>
X-Mailer: git-send-email 2.34.1
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

From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

Those are 3.0V, 256Mb/2Gb NOR Flash devices with Octal interface.
Same fanctionalities with 1.8V version that are already supported.

Takahiro Kuwano (2):
  mtd: spi-nor-ids: Add support for S28HL256T
  mtd: spi-nor-ids: Add support for S28HL02GT

 drivers/mtd/spi/spi-nor-ids.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.34.1

