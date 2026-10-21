Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A49606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 12:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=G8ENJLNu;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=nHZ2H+zc
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6ECB46085B;
	Wed, 21 Oct 2026 12:55:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p_6K-fmONlah; Wed, 21 Oct 2026 12:54:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5EC0760818
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792587299;
	b=tb8HLMROTcOl3or0nVGO/WwWpOch82YMcHzK8l1Zz8x2Rc97hFyZ7FvNfPK9ayqSk8kH
	 lJbNxaHyrLRSmx314S7Ggjy5tRrbQzavHsMpe9Gyum8/7o7sTUJFbwCfx29oxPKrs49aU
	 g2/aG5lniSTKaVAGfoLUCf4zG3L9SwHL67Wz11+NcLbje4ZPE7Do60r5U8//aozNlLp6M
	 HOynvSIIhnZObZfW7ZUmLlInW/0yGpUC/sTU+Bb/h0ycvRdHsO6DiFgZk/5z3UoOatM2l
	 JjyzXggfaXqtmVqU17O1MYpWxZJEGLFJg6MM7aPuAjUcMpExee0x7/vBw01IrlHT6BA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792587299;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Hi9HDBpzLFA7jOJ7jdgcQbgAxp7r00KuFszb8ylGuB4=;
	b=MQvzvvEzi3cwbqTpRKT3bGwvlr9Zh9V2sq8f2ETK+5S76BR2w2q3C/AUad1ujchIO0VV
	 7jkuD2VcX14g6ejxU+ZiA8Qv1ZDav9qL+Yz3dkfZlOwPMYV3KgbLEQHNSN4yzxVylPzUr
	 mnVFULSPcHcsEHGGPGuE8R2b7WnmEM3sgcvbfbS3hzwwUDW4T/KSte/SG6rUU5k6hikEJ
	 rzsYrBRIt714NREbv1QeTOVSa+/0VbrQyhzhSaI69Mhamlt1Lhg4sCSa5x5I0P8micNFu
	 pFLDoClQIRAEtovO9wsZe+iNfzWZYniizfS0N4puVDLBpLyRVKYyem3tJHC/eocK0kg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792587299;
	bh=Hi9HDBpzLFA7jOJ7jdgcQbgAxp7r00KuFszb8ylGuB4=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=G8ENJLNu8bUaD26NJH4IQhxvi7JlI9B4t8WpF0SDstnd+hmdp/Q7eGtCr00Tg7ny0
	 c4Ay36qiyKCTMHtB3Q6TxOWRvo8SeSa+wjTlHKmzKw085FBYrW6+G6CJZIq5J98+d1
	 gSXhC7hx2dyCzeFzcWNqVct3ag7mW8LQuW4ZKuaUmhkh1aIHjmyqTfKlBiNhT9/8kp
	 IgwcKarVyqZQqiZzZA+5N4dNoeJq/sJdq7AKTj7/w1qTQ51xoP9nKsmkPPrV4D/edH
	 5+KRXqF9i2+Z+CMrJmwgu6D2CGZbQY+7WHAV9GgEARzCi2IxdIqi9zH/Tx7jGaiukv
	 FvJtGte0rJViA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5EC0760818;
	Wed, 21 Oct 2026 12:54:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B2D10930
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:54:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A460140866
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:54:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JtCO3n_BzbDj for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 12:54:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BBE784082D
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::e36"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792587296;
 b=ktZlCs/xgyEwakYPBL+oXa78Rw3kbegxC/NQfaYYysdx4bpciqerPWjSbGrkFL04ODAi
 2Q/+TynRJ6Rzu+05/5XODmCpY1jKEhI6RxUKiUPxi8DahD5h2aUeqF9Qlx7/UcScJ39Yc
 6xSkjFhJhHoc/JShkCgajE/10wQjpcXg68w9FQeGpgaFIOW7FtXNzbjLL96aywjVaDhFc
 3Iiem74hMJud7E9P+h08MT4P0/nlDEEWKwS36aeNC3vU4Thvwjg0qhmIwoJI6AH/ItrfU
 RhGnmRhf/4W869g21+2xPyR9UtRKChgBENS7Vs9xCkrRD6bD4pko4e6urfKxBFbCOIg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792587296;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=Hi9HDBpzLFA7jOJ7jdgcQbgAxp7r00KuFszb8ylGuB4=;
 b=DqVdHFe7Zq0gmFHX9Q086sP5osAHGnuUEQviRBk29aQb2a5T71xpGWrOy4lbGuvHiTp7
 LBqXZOkAPd3WLY4xzDAAP8CkNRzZQVeMi0/SihtlEALZO5DU+ClriIFUgRAG4PALKAhQB
 8ymRlNYl2lxOPbdtvvTB4t65XOT42/Qtd38oCXm9XqZdevph7H6POyjAitECPAORq9fa4
 l9Q8U5aODhOWQQNnDbuUWQqyBrgmmiYOUiSe0JYW736DRhK/5xcVko79HvnuN+Fd0nD5E
 xQOYsVyE9bRAeuo7NVY9xGqAlBqXR3pzX8B9rd2HPD+09E1sI8PcbQ3qwLJfhiMJBow==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=nHZ2H+zc; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::e36"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::e36; helo=mail-vs1-xe36.google.com;
 envelope-from=hfranco@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=nHZ2H+zc
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com
 [IPv6:2607:f8b0:4864:20::e36])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BBE784082D
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:54:51 +0000 (UTC)
Received: by mail-vs1-xe36.google.com with SMTP id
 ada2fe7eead31-7cc0e865dd1so205285137.1
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 05:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792587291; x=1793192091;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Hi9HDBpzLFA7jOJ7jdgcQbgAxp7r00KuFszb8ylGuB4=;
 b=nHZ2H+zckNPktRHHLJQbgzD1k0bS5CSTQClRNmd6GMVYa8yRGFkBav5vbcJslNp/ON
 z0I58cY2VyHW9zqUTuuSa4tGb3hAgzs22lT6fuF0Z203t9QpmlLiro6L7/D5F/ZEk82M
 NuTC6d5PPFThfJmu7eV/bSoelKQf2qfTeutQq7dQhD/Cq3zuzaP2ji547ByFc7MUwzZe
 GE9fcLh93i1wisLPWChwfgOlVeeWTibsSd9qC0lsNalDs09aH01fpKxj5vUJlTjhORzK
 3T2TyfH+ehAzAS5jLC1rdKbODE89sj6XE8VMcdj5fAWA9x7ml4KxqVzeCfFfT7WuJdXD
 cqrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792587291; x=1793192091;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Hi9HDBpzLFA7jOJ7jdgcQbgAxp7r00KuFszb8ylGuB4=;
 b=Khwvi1qdylshvZx+iTmm5xa4cHfIYt/xigDKxMNHoHDGCRTcjUbyZEU8d+PZrQBBOk
 TXty/AFbCW2a5f5UCY77FgWskNmNCJ5zMkWJH3r4a4Ay+1ZnGA5Gu9pL6wOfsU1WsDLK
 PY8semGYCejYY+qAAsZLB7nquYAJ71IPmKzFvrUF8S/YT/Y2x29vkZ5WemcQtNnggTfP
 05QsCdL0iGWHmY92xBDfw7qJ3pVCDd0Hg71v9cZkGw6cTfZmEy00Z3WipWzoaK/5CO+7
 FaQWInArfz/wcDZuJA9SEoVOWg73bDF485BFSg/lrrShWAro4aVwUh+fVdB2/x5JFDPJ
 mQTw==
X-Gm-Message-State: AFq9FYI8q03uQrWOVoEHDJPp/a0edlo3uH7toItcPwsBDMdDBNbELF+7
 d9AzbMH1KsYhlkQvNvsSFi0qzm74xA+Qtg8vR82OfI14OUWXUydTHBWdJPQo9szU5NE=
X-Gm-Gg: AYBFou2nUwFGCEAe58+mtiNYkzsTMqIhC9YXm06MHGhvTnkvmOD3DDf2XeTZnag4FIl
 UzWolWUGu04l/T9gf77zhtoMaGNWMEkBfB0MqiUvB8kG4uLFUFbqZZpSGrLCvV9sNxBGylnQNVw
 0y4LvduJ2bYbFypwtkAfS9FOmMGYeBnru6++dItcAVhQM0l/7bmR66XNw41jf98mDFrAOrhLiQH
 /GoydyoUrEqQhi8OSR7kC5hPmZPLQFXM1+PwcYf1OuY2dejLluqp3u6xRCTqcTjVHpWt/QZd4at
 67E5otX3iCLpWNrcwFaVkdoySxzj/On0krJDtt+WFY91LvGJXwQCtgtZ7KtB2GO2lGgRb5vfHI7
 yAqqbz2mESMgZIjCYBan6oGFYkJmsbdqFgIAu8gELe1ginRDKHxshA4HCFOmC5+HuIIbCWDM78h
 /DfQy92PNJP3YphtoC/t4o4vhc+MGSUnY4yG9RZa+iDNl5jqS0RIgAagVopWJuioQUK5VKxxXpk
 5HhoHKRHAlUNS6DkEbHMLBJfWpQtK15zkoeBgoJsTB760MP0gl2VquAx8DlFCFFC58GrftiM5NN
 QIUfxgHpl4PUOw7siu0=
X-Received: by 2002:a05:6102:5489:b0:7a6:b8fe:e834 with SMTP id
 ada2fe7eead31-7cc926d293emr659403137.27.1792587290763; 
 Wed, 21 Oct 2026 05:54:50 -0700 (PDT)
Received: from [127.0.1.1] ([2804:14c:4c5:8bf0::33ca])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-990d0e0ba56sm3013863241.1.2026.10.21.05.54.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 05:54:50 -0700 (PDT)
From: Hiago De Franco <hfranco@baylibre.com>
Subject: [PATCH 0/8] riscv: sophgo: add SPL support for the Milk-V Duo
Date: Wed, 21 Oct 2026 09:54:16 -0300
Message-Id: <20261021-milkv-duo-spl-v1-0-ee7618860237@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/02OQQ6DIBBFr0JmXRqgapWrNC5UhpZWxQKSJsa7F
 2sXLt/k//9mAY/OoAdJFnAYjTd2TMBPBLpHM96RGpUYBBMFZ/xKB9O/IlWzpX7qqUChGyzKvNQ
 cUmdyqM3nt3erd/Zz+8QubCP/hMP3nERhj0HbeKSdHQYTJImb6MwZHB+QZLuySlQHfWtt8EFRn
 inMMUN2QS2jgHpdv73+TIzWAAAA
X-Change-ID: 20261017-milkv-duo-spl-2e2fae6858f1
To: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Marek Vasut <marex@nabladev.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Kongyang Liu <seashell11234455@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Bin Liu <b-liu@ti.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Andrei Lalaev <andrey.lalaev@gmail.com>, Zhuxu Ran <zhuxu_ran@zohomail.com>, 
 Udit Kumar <u-kumar1@ti.com>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds SPL support for the Milk-V Duo (Sophgo CV1800B, 64 MiB
DDR2), so the board no longer needs the vendor FSBL to bring up DDR,
configure the PLLs and hand off to OpenSBI and U-Boot proper.

Currently this board only builds a bare u-boot.bin that depends on the
vendor FSBL (and the vendor fiptool) to do all of the early hardware
bring-up before U-Boot starts. With this series:

- The SPL is loaded directly by the BootROM from fip.bin, built by a new
  binman entry type that reproduces the fiptool image layout (param1
  header + BL2 header) without depending on the vendor tool.
- SPL enables the C906 caches and T-HEAD ISA extensions, brings up and
  trains the DDR2 controller/PHY, and initializes the PLLs, all ported
  from the Sophgo FSBL sources [1] (plat/cv180x).
- SPL also takes over the RTC power domain configuration for shutdown,
  warm reset, power-cycle and watchdog reset, matching what the vendor
  FSBL used to configure.
- SPL then loads the FIT image (OpenSBI, U-Boot and the DT) placed at
  offset 0x40000 of fip.bin via the BootROM ROMAPI, and hands off to
  OpenSBI, which starts U-Boot in S-mode.
- Board documentation is updated.

Tested by booting a Milk-V Duo board from an SD card (fip.bin on the FAT
partition) built with this series (SPL -> OpenSBI -> U-Boot -> Linux).

This series used the help of Claude Opus 5.5 to read the FSBL and turn
it into U-Boot SPL.

[1] https://github.com/sophgo/fsbl.git

Signed-off-by: Hiago De Franco <hfranco@baylibre.com>
---
Hiago De Franco (8):
      binman: add Sophgo CV18xx FIP entry type
      riscv: cv1800b: add SPL support
      ram: sophgo: add CV180x DDR2 driver
      board: sophgo: milkv_duo: add SPL support
      board: sophgo: milkv_duo: initialize PLLs in SPL
      board: sophgo: milkv_duo: enable RTC power and reset
      doc: board: sophgo: milkv_duo: update documentation
      doc: board: sophgo: milkv_duo: document the SPL boot flow

 arch/riscv/cpu/cv1800b/Kconfig                     |   2 +
 arch/riscv/cpu/cv1800b/Makefile                    |   4 +
 arch/riscv/cpu/cv1800b/spl.c                       |  31 +
 arch/riscv/dts/cv1800b-milkv-duo-u-boot.dtsi       |  92 +++
 arch/riscv/include/asm/arch-cv1800b/rom_api.h      |  36 ++
 board/sophgo/milkv_duo/Kconfig                     |   5 +
 board/sophgo/milkv_duo/MAINTAINERS                 |   6 +-
 board/sophgo/milkv_duo/Makefile                    |   1 +
 board/sophgo/milkv_duo/spl.c                       | 250 ++++++++
 configs/milkv_duo_defconfig                        |  18 +
 doc/board/sophgo/milkv_duo.rst                     |  76 ++-
 drivers/ram/Kconfig                                |   1 +
 drivers/ram/Makefile                               |   1 +
 drivers/ram/sophgo/Kconfig                         |   6 +
 drivers/ram/sophgo/Makefile                        |   6 +
 drivers/ram/sophgo/cv180x_ddr.c                    | 140 +++++
 drivers/ram/sophgo/cvx16_pinmux.c                  |  54 ++
 drivers/ram/sophgo/ddr_patch_regs.c                |  39 ++
 drivers/ram/sophgo/ddr_pkg_info.c                  | 110 ++++
 drivers/ram/sophgo/ddr_sys.c                       | 635 +++++++++++++++++++++
 drivers/ram/sophgo/ddr_sys.h                       | 108 ++++
 drivers/ram/sophgo/ddrc_init.c                     | 476 +++++++++++++++
 drivers/ram/sophgo/phy_init.c                      | 193 +++++++
 tools/binman/etype/sophgo_cv18xx_fip.py            |  89 +++
 tools/binman/ftest.py                              |  54 ++
 tools/binman/test/vendor/sophgo_cv18xx_fip.dts     |  18 +
 .../test/vendor/sophgo_cv18xx_fip_bad_offset.dts   |  16 +
 .../test/vendor/sophgo_cv18xx_fip_collection.dts   |  19 +
 28 files changed, 2454 insertions(+), 32 deletions(-)
---
base-commit: a58e2b7af42c179ace2c6210de0a219fa3f3cf3c
change-id: 20261017-milkv-duo-spl-2e2fae6858f1
prerequisite-change-id: 20260929-milkv-duo-bootstd-14de5e4e03ef:v2
prerequisite-patch-id: 0aaa37872f2b82c2abfc84364f9256c7cb3394fe
prerequisite-patch-id: 927c8bc825dd9897467da6b194ae8c7c411ec874
prerequisite-patch-id: 7c0fedb64aabab799b72eef81efc8becec8f44cd

Best regards,
--  
Hiago

