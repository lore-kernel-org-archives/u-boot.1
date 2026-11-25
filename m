Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8D0606A31E
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 12:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cZy+IVHc;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L3+vShS5
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DA70D80CD9;
	Wed, 25 Nov 2026 12:20:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8kyJVHlOBB2X; Wed, 25 Nov 2026 12:20:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EB24C80CA6
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795609247;
	b=UWI7sgHOvZZbeS7ghGuHkVXYR8IYsQ64MdbaAqi69VS1Nbudr0Sbkur9FEoeedReA9nn
	 H/ymq4g/bTRPP3aeakzd6lLGngnV/PrUtM9qc3GBvx2ldGTIb4rLiJtjeFb9HNjmuVKDU
	 VH5bhmM0INjF8hxCk6Yp6j4naUjRe5btYSld7T0Mijw+E8A0rO1ETzsxTkzdtVanOLs5s
	 RWHAEc22opgDJI2f2jHL99/ALqr+rCuSPZDG+IKRL1Ns9fQohBsCboDHhoqmPD7cKphHc
	 4ZAcgH5/nQwbFtlud1jmc8e2SwprmguJ8qFiT3hEhe7tsx1TyA2a6W0Ksz/2e7cp9YQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795609247;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=RzwZrzxEy/8tE5FYI09//Mmvstg1m+uCPPnTB6xQLt4=;
	b=JPu9R3TEngkol0820sEdN7iAd0DPIbNXTuU1NItAWqX3exC9yekmrM2DNGQD2QSoBn8k
	 P+BTfEZQyv3JTFxK7cyitHZ6V2rMkqMefAflx8WvkLMm4sdnz8LOPhA2cWNvXjt4JzCIw
	 fTpq4R9GFSy9x+4LmnHbEHbPVl0g722HBh2IOv0bhCzRjtw4wJKIKZohedZpjdF6c8j5M
	 J+1bZkRGM5qosmaukVb/pJxc0/PM4V9zxbb4fS3F1iAkmWRgVpYgNT2a/dQqflMEm/gc7
	 c6lH+12C2xDJBf+dC0ESJnMK3kf77PMHCzCAx4slb0EKJNq+UU5a2QGryZXaetqz2Aw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L3+vShS5;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795609247;
	bh=RzwZrzxEy/8tE5FYI09//Mmvstg1m+uCPPnTB6xQLt4=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=cZy+IVHcv+iI8D+twx3s8B1yzCQ7ksKTflyFWePVpuPLna3UrriEhYkvXxwxheLYp
	 nDOVxcpW9MoEN0lLclcWRhFvokVD/fYUo536ZRV+8jisDJ4iUypiKuzo9RMGbprmpX
	 9UJXoMHIwZ2jOsEahYSf5gn1XJaVQ0G7c25aga0EHvP4KhUM+XNi+n+17haH0BKrDL
	 0hbE2W5mw42SPDOM8Uty5ts/evGhmgkFB0WfES/4ZqcrzU7sqJ5yBIoDg1IBXDelcr
	 e+G4znZceweWXST/3UZM3Ye2YLKWskn2xVh5mUQZfAFowI1R6h5+iuNyrT/GO5eFZg
	 rquE0pE3i0/MQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EB24C80CA6;
	Wed, 25 Nov 2026 12:20:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id AECC9325
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 12:20:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9FFA880CA6
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 12:20:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dYGYrp29X1FJ for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 12:20:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 95A7780C3F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::e2c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::e2c; helo=mail-vs1-xe2c.google.com;
 envelope-from=jpaulo.silvagoncalves@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=L3+vShS5
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com
 [IPv6:2607:f8b0:4864:20::e2c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 95A7780C3F
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 12:20:44 +0000 (UTC)
Received: by mail-vs1-xe2c.google.com with SMTP id
 ada2fe7eead31-7d2da1667b2so3506346137.2
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 04:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795609243; x=1796214043;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=RzwZrzxEy/8tE5FYI09//Mmvstg1m+uCPPnTB6xQLt4=;
 b=L3+vShS5madEk/Mp/JggvcF9xXtGBhTpKCE1sRaKpgsgJmdLdY4VDL/lX2KboByWku
 SiUezXoqZ+a2H2+7dSIUxW7+4/DBh3fqr1XeCG11vQ9UvWSf/LEnml9GcUt0igG5MZ5D
 jTobDc95BmUYF+orXsZSfWrEjnBj5KjY2hsewvrYAT/eReYySEAvA+XX7VAtLOc4LAT0
 YYFG63+xKr40SAdM2JeXHBityhqp7z455bz4lSDZsrmzzQ8MUsA0/7aQLAUd7Atsx7dC
 os1Fqj5zofxBdvk0vZ2xJiA/RhQggzz1AAHdc0bawtpErNKB+zX9fH7rvqG93AAJQlkI
 FWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795609243; x=1796214043;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=RzwZrzxEy/8tE5FYI09//Mmvstg1m+uCPPnTB6xQLt4=;
 b=aJmzOPx7W74f6OOybaAKNVD54jx/hOA6SfvYXZ698Yey1DtfuwqaTx4mRVlYufDi5n
 ejZuPYfGqJiidd16/ZTJKOoTicCh1t6WtRy/cTfdYobDO41cGCHY5F/i/35Xj80ZlUgt
 78G2k3IlTw8ecbDYOiwXyu/c3Q5wWhv8/kLplrDSM2BKN/uShE3SP+osL3js/oUDqYte
 qaSGF+zly19nzFAEbXY3UPuFsKbgxemawr9G3jWCqVFrNJGlvsyQ/Z1qNHXhTtcweAks
 dQwsjBCm039CzTNagAW4p82jlxJOf8wxULe4WHQBcR/mvoGB8iDds2YGCI8/zk090Beg
 Q8hQ==
X-Gm-Message-State: APuU4Z/JsSfCzOb/c1+x4xLA22VIQrQSKnRODFpM6XDCj1CCslJCnXDH
 ueng1K46ZyxwJ0lRJK6w6S/95226bUyAgBd58eowxoSPmquwtGUqptAU
X-Gm-Gg: AZFdTZf0JwtCHGCy3Jl8E3KRFADIwRfYUlT0ak5v3VKp8GgBOFn/65zYWGuRhr97TiY
 CSMmgXSE3AsWHRFpeJJ3LgNiqD/RQkM+z925Z2KXvz03HOvxkCIfeYJ22oGi30m080tMsCWNPR2
 eyoPlY0OaKQahfnX8pmujus1vexUTDbyFL0Hhk0wldxknyWq9RO6t97pP/iAAPSSk1b0qk2rY40
 63FqnQEAwV980ct2eDZBvPg1/WHIvmFllCGxZvN7PhNZ6cxxlDyJ5JY32c16PmdYgPSHwuDfBJi
 sQMIIDoC1O+LHAyo/ScmYDbS+HtBV5PoTb/0slN7pBKqzzugCxbiPWCn5MiJaHnYVaGZhiDOS49
 1ZqIhQsZSCRpvJM9ZX8tBhqgJg7Swru6PK/aDboy9La8qLzYNDzNBUzV8Rn/y4LfKaU3U0b+88i
 izsvwqSPNUWpBjfkVasqp1hYmWWR+Q4SCdnibJRZobjwuBQ2/m33Au7Fgy02U5brOuQ3kFJ/2q1
 hpV31ymk/A0PdloaV7OcoCKjEhl+OSqUCSuYcaK5ZcnjAKRFTjBxAIkRmiKuw9qW+cXD7IA+u4c
 lS6A5AHmaHyxML9aQvTliGW1qFG3OHBAZmU/G1iNUyosTQ==
X-Received: by 2002:a05:6102:688c:b0:7cc:2086:34c9 with SMTP id
 ada2fe7eead31-7d72b362702mr10022966137.2.1795609243094; 
 Wed, 25 Nov 2026 04:20:43 -0800 (PST)
Received: from [127.0.1.1] ([2804:14c:490:135b:b225:aaff:fe93:9186])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-99e6dec7cb5sm18636534241.2.2026.11.25.04.20.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 04:20:42 -0800 (PST)
From: =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>
Subject: [PATCH v3 0/3] board: sophgo: Add support for Milk-V Duo S
Date: Wed, 25 Nov 2026 09:20:27 -0300
Message-Id: <20261125-upstream-v1-milk-duo-s-v3-0-9ed94b63cbbe@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XNQQ6CMBCF4auQrq2hQyHUlfcwLqAMMBEotkA0h
 LtbMEY2LP9J5nszc2gJHbsEM7M4kSPT+YhOAdN11lXIqfDNIIREhELysXeDxazlk+AtNQ9ejIY
 7rmUBKoq1BJUy/9xbLOm1wbf7ty0+R+8P/2NNbjD2vY1PYr3+dpKjHV8hR5mXUZogZlBcqzaj5
 qxNy1Zygh0D8SEDnhEK8iRVItYK9syyLB91MyK3GAEAAA==
X-Change-ID: 20261014-upstream-v1-milk-duo-s-c4d2935c4298
To: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>
Cc: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Gui-Dong Han <hanguidong02@gmail.com>, Joshua Milas <josh.milas@gmail.com>, 
 Chen Wang <chen.wang@linux.dev>, Inochi Amaoto <inochiama@gmail.com>, 
 Lukasz Majewski <lukma@nabladev.com>, Peng Fan <peng.fan@nxp.com>, 
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 Hiago De Franco <hfranco@baylibre.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Michal Simek <michal.simek@amd.com>, 
 Yixun Lan <dlan@kernel.org>, Andrei Lalaev <andrey.lalaev@gmail.com>, 
 E Shattow <e@freeshell.de>, Zhuxu Ran <zhuxu_ran@zohomail.com>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds support for the Milk-V Duo S, a development board based
on the Sophgo SG2000 SoC with 512 MiB of RAM. The board uses the
upstream Linux devicetree via OF_UPSTREAM.

The Duo S gets its own board directory, based on the Milk-V Duo 256M
one. Apart from the devicetree, the two boards share almost all of their
configuration. However, they use different SoCs (SG2000 vs. SG2002), so
the Duo S is not treated as a variant of the Duo 256M.

The board doc describes the boot flow (FSBL, OpenSBI and U-Boot) and how
to build the boot image (fip.bin). It follows the same approach as the
Milk-V vendor SDK and the community-maintained meta-riscv Yocto layer.

The vendor SDK builds the Sophgo FSBL with the T-Head toolchain,
together with the Sophgo U-Boot fork. That build does not support a
standard GCC toolchain and cannot pack a mainline u-boot.bin into the
boot image. The documented FSBL build steps therefore follow meta-riscv,
which provides the board memory map and the FSBL patches needed to build
with a standard GCC toolchain and to pack mainline U-Boot.

Most of the boot flow and boot image generation is common to all
CV18xx/SG200x boards. For now, the documentation lives in the Milk-V Duo
S board doc. As Yao Zi suggested, a follow-up series will move the
common parts into a generic SoC document, referenced by the Milk-V Duo,
Duo 256M and Duo S board docs.

Hiago and Andrei reviewed these patches internally before submission,
hence their Acked-by tags. Since they already work with these boards,
they have agreed to maintain the Duo S support.

Tested on a Milk-V Duo S.

---
Changes in v3:
- Split the board documentation into its own patch, together with its
  MAINTAINERS entry
- board: defconfig: Keep EFI boot manager and EFI (GPT) partition support
  enabled
- board: defconfig: Enable the CV1800B RTC
- board: doc: Build the Sophgo FSBL from source, based on meta-riscv, which
  supports a standard GCC toolchain and a mainline u-boot.bin, instead of
  the prebuilt binaries from fiptool
- Link to v2: https://lore.kernel.org/r/20261025-upstream-v1-milk-duo-s-v2-0-192b68915c92@gmail.com

---
João Paulo Gonçalves (3):
      clk: sophgo: cv1800b: Add SG2000 compatible string
      board: sophgo: Add support for Milk-V Duo S
      board: sophgo: Add Milk-V Duo S documentation

 arch/riscv/Kconfig                       |   4 +
 board/sophgo/milkv_duo_s/Kconfig         |  30 +++++++
 board/sophgo/milkv_duo_s/MAINTAINERS     |   8 ++
 board/sophgo/milkv_duo_s/Makefile        |   6 ++
 board/sophgo/milkv_duo_s/milkv_duo_s.env |   8 ++
 configs/milkv_duo_s_defconfig            |  43 ++++++++++
 doc/board/sophgo/index.rst               |   1 +
 doc/board/sophgo/milkv_duo_s.rst         | 142 +++++++++++++++++++++++++++++++
 drivers/clk/sophgo/clk-cv1800b.c         |   1 +
 include/configs/milkv_duo_s.h            |  12 +++
 10 files changed, 255 insertions(+)
---
base-commit: 83b1ec64ede9998566e6a82b22848c20a33f4aff
change-id: 20261014-upstream-v1-milk-duo-s-c4d2935c4298

Best regards,
-- 
João Paulo Gonçalves <jpaulo.silvagoncalves@gmail.com>

