Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FCE3C4707B
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 00:21:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C1588749F;
	Fri, 12 Jan 2024 01:21:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="smJtRZS9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30B1187227; Fri, 12 Jan 2024 01:21:26 +0100 (CET)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 845678785F
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 01:21:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6d9f94b9186so4917949b3a.0
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 16:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705018881; x=1705623681; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4CXhHkqDkh0yruT4BmxEJAuPv/pHat6fPqz/gdfnhOQ=;
 b=smJtRZS9kRhtx8Uqch0n+p4dTJW415pLtMmogMlj9kazmYaRcU3MFoqkSaDMpNb4Dv
 20UHDMqd/bJOjHEHH4HqadANRj0s8mDf7sBPyz2xEPcdey655SeisUu3+DDgeP1lDy/u
 Kkd4nJjYb9VMw/lEz72h2fe1Tce5okHRfsgRS3VYXTF++a7mKZ4fxR/nQQbsK3X/MdES
 DhwWyNOaqd8Nf0FyNuOYHtZVqfr2ybRb0nkz8rG1epb1wS5AfOBDWQ/SMkBJCvwXNs/E
 QOFlvGGJvSK67hm2r0aLSt1Hu2bzbgmLoIPHiNy8ip79gePsOFpxm2mUeMdZKn1izer/
 giMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705018881; x=1705623681;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4CXhHkqDkh0yruT4BmxEJAuPv/pHat6fPqz/gdfnhOQ=;
 b=LNvKBobChMMKOaCNI/4qjuP4JIi+bp/bFhFleZqc23v60FzodmuMbMXnJwD1N3vs/g
 Uv3WvFzLLTqx0FZ7N1FK9UjRJRxIRsCurwLqMt+sippDWM6oTH9MBZBFJHA61iE5H5a3
 Jk6uUl6+nn2XT5FFoD/KVN9+qgaXC6yyFTDZBmejQAhdk3eGba/8cMVluabJ+p7CCjRH
 UGiWEijTCl7ZZ2somz3ZbdJKaJ31M6u71NXTxo5LqJjcTuDvznld8MYHvLXqSF4uPnhj
 CPW3e/6H6d4JK1CY9GQKuuzLX2iH202Bx18CO/8RMtBmzYpeg78eRp4uiD4sqIaC02U/
 KlaA==
X-Gm-Message-State: AOJu0YxEtpn4WHhptTSame2A7nyPN5D9/oqyevr0k52pJQB9kZqqRoQf
 kDQ1nPxZaHxi8zmqv0IcRol16z6jzFlx5qBwbxHwbdMkRDg=
X-Google-Smtp-Source: AGHT+IHpolYN+aTdgfcpKY+QYEDvGRaM2Ck3b5Qyg44MrQllbAJwxPwRaN2opyYvHBOyRLh8K/jmDw==
X-Received: by 2002:a05:6a20:160e:b0:19a:2733:1ab7 with SMTP id
 l14-20020a056a20160e00b0019a27331ab7mr216782pzj.57.1705018881358; 
 Thu, 11 Jan 2024 16:21:21 -0800 (PST)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 lc18-20020a056a004f5200b006d9cf4b56edsm1876359pfb.175.2024.01.11.16.21.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 16:21:20 -0800 (PST)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v3 0/3] fix auto-generated boot options
Date: Fri, 12 Jan 2024 09:19:20 +0900
Message-Id: <20240112001923.976414-1-masahisa.kojima@linaro.org>
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

This series aims to get aligned to the EDK II reference
implementation for auto-generated boot options, and tries
to address the following issue.
https://source.denx.de/u-boot/custodians/u-boot-efi/-/issues/13

This series is based on the heinrich/efi-2024-04 branch.

[Changelog]
v2 -> v3
- rename misleading function and variable name
- fix comments

v1 -> v2
- fix make htmldocs error
- fix bootmenu python test failure

Masahisa Kojima (3):
  efi_loader: rename check_disk_has_default_file function
  efi_loader: auto-generate boot option for each blkio device
  efi_loader: auto-generate removable media boot option first

 lib/efi_loader/efi_bootmgr.c | 138 ++++++++++++++++++++++++++---------
 1 file changed, 103 insertions(+), 35 deletions(-)

-- 
2.34.1

