Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C4F2C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 18:12:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CB3984AA8;
	Fri, 10 Jul 2026 20:11:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jy9JJuSf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F06F84B51; Fri, 10 Jul 2026 16:33:16 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BDCE84B07
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 16:33:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ivitro@gmail.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so9107605e9.0
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 07:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783693994; x=1784298794; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hi6O5Eh9UyndTaZu3CFnXlmviaTHKB0+i8r0EC915Zw=;
 b=jy9JJuSf+hw+3fmA4PzdmOqemXtirS3ejU2jnEeAEhC3bKhy028xSvoFZ/wbYANgwk
 iXoWdiPOA17Uvhe1smGn0I/Fhin4Ss1gijS7LxPj4j7vwUzeKuN3fxpmIixgma78cbZD
 chNIaklrAVJIi72Wlt8DkeHTl/mFtYkeKupJWlMkrkU8QyeKKo6bkmfjG5hW88MH8w+c
 PvZQJucQYz06CZme3FA7/kOz1Mq6YQ/0UJO3SuYiHQPij9scQSML6Rk3rwYZLfGOzu9x
 u9DdWzfVk/V6xFycUK4bcq6JOI5ONZa8X1o901Mx5jsfE4p5lbk/4sOUKAY9DvyacT+G
 nmVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783693994; x=1784298794;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hi6O5Eh9UyndTaZu3CFnXlmviaTHKB0+i8r0EC915Zw=;
 b=Y1RvNq8RSMlMAHh1jR91EjyQr8XlYIJ3kj7902zfxxneXRIVFy9bv6T7In4rDD0UnT
 XVjfWdoQDtPpIvRrUmQ6lADxR6A7IgnP6CB9/NFeUxYxlKKQiMoQ2UIKInCmG8vafb+p
 8qC8Rs4fq0M99FWX6Ou9af3tXnsUex2i1YhCs5fQH4lcIK79YjfYc/xqDEZMRQv/ksp1
 9b6x7XPSQXGpFI8hY7ebFQrx0lA+OW6jp0SZo98G1xxiySkjjpa7bCNeW+Se7DABEDdm
 Bk6ivxg9NoCY+JE93TDPVKDczQTZA/rWdq7XcPLS6kBelPJYfOMKVbN+9DfFrup2rlet
 cI1Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RqAelOLjSOHiK+XwSiMaZe8ppj21ehBhsCdZj93ka44g1MB6SO6ZYzZ6vp1abKn3lE+eaZOABc=@lists.denx.de
X-Gm-Message-State: AOJu0YycuDE74QxiZhKP7f7wdqy6KvmV2m9olT6Pwynb+23wkssywYBg
 a27RXgt8L/NX8kDlo9fprZtqa7N6QIjHeCtAOspI7Zb+N0zh76UqsjEy
X-Gm-Gg: AfdE7clfYkpLq+AMaNubaJxVsPjCscbc+eh44DQM+OdtlliYOhsiJF1vXRvZwZ3iFZg
 hdepqxYrmyuZG1uPhKhrAoIvroc8Rmikt1/lJJsMOOxoMnl0Cm2L2WXwechaGXUlryjLGopZbDc
 dE6ffusrCEBpyjDzS3wexE27Px3aRt+1ud+bgtzV67zkCzfcyxP4JqR6pVXUwKFX7x2kxfQUmdH
 odNp3steTZsyUOnzNDSscCbAkWxk+uTbn1q2EDyBv8ha+1/38DftmXAvWeXZ+ops0Iapk0CZsaa
 e4lcwhBp2nDMIiHhskF+25G9HF4bVhqLqv1nocgT8JxQP77v9yqj7It0Ny6hRO9PvjnoMFvJPaR
 VLS+Ow/CbQyIdduqRgPHZzHv+HpAkJRV1BI7BMiSjdMzT36nrmQu65RSgtVlvZymdYT6quw54OW
 xXXM0NL7o6ctIRZ2k=
X-Received: by 2002:a05:600c:310f:b0:493:d1e0:a4f1 with SMTP id
 5b1f17b1804b1-493e6c05de0mr106213325e9.0.1783693993759; 
 Fri, 10 Jul 2026 07:33:13 -0700 (PDT)
Received: from vitor-nb ([2001:8a0:c4c6:f00:3cb5:ed02:715f:532b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d83bdsm60549688f8f.13.2026.07.10.07.33.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 07:33:13 -0700 (PDT)
From: Vitor Soares <ivitro@gmail.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Vitor Soares <vitor.soares@toradex.com>,
	u-boot@lists.denx.de
Subject: [PATCH v1 0/7] toradex: tdx-cfg-block: Add new PID4 entries
Date: Fri, 10 Jul 2026 15:32:58 +0100
Message-ID: <20260710143258.285091-9-ivitro@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 10 Jul 2026 20:11:20 +0200
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

From: Vitor Soares <vitor.soares@toradex.com>

Add new Toradex PID4 entries to the common config block handling.

The series adds new Aquila, SMARC, Apalis and Verdin module variants.
For the Verdin Wi-Fi/Bluetooth variants, update the board-specific
variant selection to use the Wi-Fi variant.

The new PID4 entries are:
- 0229 SMARC iMX95 Hexa 4GB IT
- 0230 Aquila TDA4 Octa 8GB IT
- 0233 Apalis iMX8QM 4GB WB IT
- 0234 Apalis iMX8QM 4GB IT
- 0235 Apalis iMX8QM 8GB WB IT
- 0236 Verdin iMX8M Plus Quad 4GB WB IT
- 0237 Verdin iMX8M Plus Quad 4GB IT
- 0238 Verdin iMX8M Plus Quad 8GB WB IT
- 0239 Verdin iMX8M Mini Quad 2GB WB IT
- 0240 SMARC iMX8M Plus Quad 4GB WB IT
- 0242 Verdin AM62 Dual 1GB WB ET

Vitor Soares (7):
  toradex: tdx-cfg-block: Add smarc imx95 0229 pid4
  toradex: tdx-cfg-block: Add aquila tda4 0230 pid4
  toradex: tdx-cfg-block: Add apalis imx8qm 64gb emmc pid4s
  toradex: tdx-cfg-block: Add verdin imx8mp 64gb emmc pid4s
  toradex: tdx-cfg-block: Add verdin imx8mm 0239 pid4
  toradex: tdx-cfg-block: Add smarc imx8mp 0240 pid4
  toradex: tdx-cfg-block: Add verdin am62 0242 pid4

 board/toradex/common/tdx-cfg-block.c        | 11 +++++++++++
 board/toradex/common/tdx-cfg-block.h        | 11 +++++++++++
 board/toradex/verdin-am62/verdin-am62.c     |  3 ++-
 board/toradex/verdin-imx8mm/verdin-imx8mm.c |  3 ++-
 board/toradex/verdin-imx8mp/verdin-imx8mp.c |  4 +++-
 5 files changed, 29 insertions(+), 3 deletions(-)

-- 
2.54.0

