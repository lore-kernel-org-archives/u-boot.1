Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE88ED216B2
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 16:41:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A8A584167;
	Thu,  4 Dec 2025 17:41:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e9gyENNl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 335DF8415E; Thu,  4 Dec 2025 17:41:53 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50E4A840FB
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 17:41:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=max.oss.09@gmail.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-64312565c10so1821161a12.2
 for <u-boot@lists.denx.de>; Thu, 04 Dec 2025 08:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764866511; x=1765471311; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RVyYdEptj1fSqX/1Khs/dvjzd+gSn16pcOaSCEXVWP8=;
 b=e9gyENNlTOgsHu3vwlqwY3JtkSHEQJeJZbxIkQAgXmdb0GFWaDn53Q5QKQBri9SQkY
 VXboDIkgCFkX/5wpZs0Y+1VxJ+rllsIfrSEgs1qkLNporBLMkhS5Y30Cqdsrigp9tHUW
 GFYNVhow/TtqgOHUSxhmCoVbs4Mln7/SH6+QWB33G3CGpEwktvae1evxo5iLh7Z7YVel
 QillRw4bt213LCZJjzhdG8yNS2PPtuF4OVzi9dZdQ4UidITrwPTv3z60j7CuVydQxRbA
 p7HtgSOYOdz8rJEvCqiwjeYsHppoIiMr35utskAw+TKFAKUd988VSSbTFCwwCicaiUGs
 aoSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764866511; x=1765471311;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RVyYdEptj1fSqX/1Khs/dvjzd+gSn16pcOaSCEXVWP8=;
 b=jtW26sCqWl1fsJTMXgY/+7axTrh+hyK7hn68i2p07QWecKAZDUYp009oTTa5C2ndpe
 0t1Sb8UbpsBa4yXvUDKwlzi2fcwH68FD/RPudcjdEflXOUvHC8GM9AHfmk0Zbd2oMeFR
 hhYJqB3kFTUSTl3biUPZlkRswhDbLhtiUBTM0G3vyzqLX3O6bc9bStbgfqybw6ipF100
 JUf0/Cd8PmKiiM6MNI0AHybiFM+NUv06YRX5Ce8DhShJlXRMA+/FGbqBG2OOoc4ykWhf
 sNJx35g3l2IMFUiIF1zRxzpNoYyUGNVVABdL62aoc/ftX/S0drp+Pp7yk0oPi/eBfvps
 USMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRbbU1KwqCqZu7OJG3Af/KWpI0hHL+cu+Ptg0/rqhakBJ/Nrz3JGyx0wHrZyXxHadqYtIjspY=@lists.denx.de
X-Gm-Message-State: AOJu0YwWHU8l3ass0eXvF1XoUTRrdyF5sa5iu4ugRH5hw2PSasvPD27D
 pK4kZaXXWml/Xef1R1/B4V4FsevbaJEcfX6ZEdXN9833+/hfEJgGkBp9
X-Gm-Gg: ASbGnctTfpA4LAmGP6bhiSeXZ1AdRe7ntaQaFB8GVKLBm4FTLW4l08ofw3fxZbzEQjT
 3NRZ6m6JUevPf0ymC91Qz2s1HURLeeTH82QEgFFOyWDrS/v6XdPlfa6FYisR6JA9c8SXoNUCJlv
 lz6a+OguM23SZOHPSNIgSY4h37s3JMAR7x8Ysb8Zn6fjCemVwaMdqy+NQoJs426CD9TnjQOwt2c
 leeyTYwlavomQ6bdPfgAXPo1B5fDEDnFagVqrwlOuv10sDrG7I+4yxjOj6497BW3DgWXF/0Lucq
 R9CZnInZb8iPUF7semKm6tmaOSNFtm7EQA/hsbUlcqnDIIq9aQokd6bz7V+I6VtLIbeVHY9LKYa
 33XVoY/xIPdEAcUkFqFDAelJ+yXOs2v/u5mJKt8F7AdGRlvsYzLNNypUL4Qeogq8c5CxMz1qaL1
 rXIKV4mgwz/NbjBR1jZdQ3PJBOSNkaE0Up5Oi1+E3K+RSM3FkY1/r3Xr3qHsufCVpW+axRv4F2y
 fnnivdD7XG9L8Lh
X-Google-Smtp-Source: AGHT+IEGnSEJaGKT7sLesolYxaH9GxhxpXm55yJIkc2W14NQpsZtYWOd8cWUOPaD2OfLFvOJx2TUmA==
X-Received: by 2002:a05:6402:5254:b0:640:464a:56ce with SMTP id
 4fb4d7f45d1cf-647abd8996emr2962380a12.2.1764866510562; 
 Thu, 04 Dec 2025 08:41:50 -0800 (PST)
Received: from toolbox.int.toradex.com
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-647b2ec300esm1750465a12.1.2025.12.04.08.41.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 08:41:50 -0800 (PST)
From: max.oss.09@gmail.com
To: Max Krummenacher <max.krummenacher@toradex.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: [PATCH 0/2] configs: apalis-imx8/colibri-imx8x: use default for
 SYS_MALLOC_F_LEN
Date: Thu,  4 Dec 2025 17:41:27 +0100
Message-ID: <20251204164133.1677471-1-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.42.0
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

From: Max Krummenacher <max.krummenacher@toradex.com>

Drop setting an explicit value for SYS_MALLOC_F_LEN. This increases
the available space to 0x10000.

While U-Boot works with the current setting of 0x4000 increasing the
size for cmalloc helps if further space is required, e.g. when
enabling more DM managed devices.


Max Krummenacher (2):
  configs: apalis-imx8: use default for SYS_MALLOC_F_LEN
  configs: colibri-imx8x: use default for SYS_MALLOC_F_LEN

 configs/apalis-imx8_defconfig   | 1 -
 configs/colibri-imx8x_defconfig | 1 -
 2 files changed, 2 deletions(-)

-- 
2.42.0

