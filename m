Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1673F606A320
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 19:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pkAw0SW8;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d/vdNQnJ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DA93980E1D;
	Sat, 21 Nov 2026 19:58:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UMlof4eicuEg; Sat, 21 Nov 2026 19:58:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D62BC80D62
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795291116;
	b=rC963azVFqH3w1jeVeXLktjsCELi4QBIWjPTkTxyJgIAYdId5ZKO0Gp8kYDPQfbC79TO
	 9R2w3kwKddc9rbsyzQzfuepGzU7dUGe9w0ZZNqM+ex0gBLzx2GvX6aJ+Wln4FQ4MtqCpF
	 WSJzR6XBhZypdetQsSTA1t+vYjPskqn2kYazH2xIMz2R4DjUGn/fUdGVAETrjTKaObCNH
	 xSuw90JQ4UI/EkkqU/vLbQDUZecizcxkU4tT0fM83pG3Fzx46WtTgrhDMOg1KFXjI85UR
	 aLI2HueSOFAZrO150D5dLn3oM3eFcQWOkzYCtluFuXZ592X32PTX05zUbNWn7/wVJ2A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795291116;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=YxGC/ONKj7rX+5YoiOeWAOmq5/dVOSn8FQ03vLuLPZQ=;
	b=CsOGd92na1d3fminNu4vRp18SV3BNvod7yyMdpggkZRL7DfZtrMg35WEAHl+Pfy21Cqx
	 zP4RZksfuSbkk2iO+g7EepywRwkCi4A1s5hqND0CNvQGd7kqCCaGgBpYJFsUnhEnFSJ7M
	 8biHSOaaCc7FovXeIT0AJXSWBbXC0SoD3qTI9HBPSAgj/76tz2EIVCn5o1by5OiCJonjV
	 UJH7YvslTMOvpSyaFLZFpb0GSwJxIX2UfDGhxMeuqDW7nkZLCGTSVLd5ZbAvD+F28fANj
	 8BByTEgF68aZdNV/zlbcDDIfBqSiy0mJgXfVdeRkc/4tN0LgoSmFNXFeOyvgc+hjJcA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795291116;
	bh=YxGC/ONKj7rX+5YoiOeWAOmq5/dVOSn8FQ03vLuLPZQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=pkAw0SW8YsPsda/r/HgWlp/+2mtalbTyPMXyZYXFGATNzmuOVl4DVzi7sWuOlvYI1
	 597HPTI3FikxTTI7JMzEKr5WXwuJc+H40fsa6LhxvDS+XYyOOYy06yopmnC5o5ij0Y
	 +XIfGu+fJqV1X/PkpinitglAkPy+/b7yaovdV9PSP6uq6V4IZ8+aQpk4UT8RBIOJEi
	 Fa+HxY+VxTh5BmMwP3PYxNgkgdPsba2fOrex7w/1rDVP2U/PAXNdqkhk+Lu1zWhZfP
	 K+xHxA0VjsN5hiWK54DH5K3A3eWM8cS2zo5huhy1eEaFeCyoIStKuSxTTolEaUD2tF
	 hzOJdtdyUwSeA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D62BC80D62;
	Sat, 21 Nov 2026 19:58:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id EF101759
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 18:58:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D4E8A6061F
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 18:58:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OfSCGK-Fyc_d for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 18:58:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D275460615
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1331; helo=mail-dy1-x1331.google.com;
 envelope-from=thallescampagnani@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=d/vdNQnJ
Received: from mail-dy1-x1331.google.com (mail-dy1-x1331.google.com
 [IPv6:2607:f8b0:4864:20::1331])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D275460615
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 18:58:03 +0000 (UTC)
Received: by mail-dy1-x1331.google.com with SMTP id
 5a478bee46e88-38431138772so2602163eec.1
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 10:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795287482; x=1795892282;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YxGC/ONKj7rX+5YoiOeWAOmq5/dVOSn8FQ03vLuLPZQ=;
 b=d/vdNQnJEiToG7j7jAD5Y+YZEI4laD/or2IUeGIW4eF5R1GmxfmshMsfaRJgw5YPG0
 GsoAlcQPnuJaFZZalbDtHKaqCvZTh8glYMwSttQrpAGG2+HcRwaVhd0aKlAbz/Quw9pz
 rOKppgmi6KIMh48QT5m8FqgddrNDmVRAiHmFCm7NKPcUHiJ+5ArMv9jDBOtuZdln8LBl
 UdiYpl9zqD+utEYDTKkujN5zO1Nuh+5xNDRFyTA7X5VrjuZcbo9LVpm+Ans0AJ/VPjc9
 /i+9wmdUs7OrIyU65D2NIqkzgulERgWwFHq5H2J+9XrzQ9zkDvwEYs4Mi+YaHpKY3xhf
 uv+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795287482; x=1795892282;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YxGC/ONKj7rX+5YoiOeWAOmq5/dVOSn8FQ03vLuLPZQ=;
 b=yljRyGXpcSImaw9Uw/Pu40i7anVdtGceTSFM8gnS7ueYA5XVxOFzwc3KdURZD0CpXV
 z9jd3w46421qnojC0yuiLFDiFmUOpNUDfNNX1kLtQuniL+RWF4P4eI0u3YSaDlb89tI4
 2fHMVHfT+A2qxTFV1JSRlia0tZjIGi48AwFjOdnCWyMIoHqzbi7mQJHa0cMrwPLpjjyO
 IySXvRn3h8tXfsn0JwVvoY+XiUHErafuhcyNnC+cncIhHUmD8DIzQu2Hteyh8hbKULwi
 Sv6XxTySaIOEbSWjmZ9GvaMJmp51P9LS2qc1I9+470c5tQAZch32wd+rJolh8KGXIZLy
 wGJw==
X-Gm-Message-State: APuU4Z+9/UlDLLqmbM3LMgEY2Bd2AVkWPHNPkDFK1e+WQZCnnqS6MBEP
 2meSM+Ftk2UwLPjcY86KEcR0MimLPFelhwhFx8P+X0+oaKWlv4calIi+Laeh2DOP
X-Gm-Gg: AZFdTZdzBopMOVuQ6VIjGbWngYVi7OPbkLxFURp+0UmeK5vivTAkuU55pSMxeOsM0Ph
 qYlcc5r9ml3zc53ayWVBWgbySKWkh84bBbV9dRwhLmGm0J5eiaa9vYwz6VcnsMELtaC0GS++tN2
 Tadj0V7e57x6ebCuuF5+ZFwTEzexi2Z00Lp2oFntOJLrsBY2/8JdUI/w82E4MTn/F7kBN49NJL6
 zBeRyyjU+G6Z3Pu6V82Cxu+LQIPJZ4jsqwqXWNO0TOLGngQOXbnFzcnT5FVWnT0HS+JuToq2bPS
 /kvd1NCMpfwJ/uFAtuyKz+OcskwBZh/TxxfMDUtAIVIJLeig2V3QLwxXJDobX4E4ae7ixXDJGm3
 ZZ4owx50kxlmfIGX2WItNudBK72uBC7bU3ATlsjD0mnSkzxo/EZFSznSl0U7UjxfYRc+HtyJ5Qa
 9PY6xde4sp5J+ofhCmD/u2KZznJIqVTEVu7miF8qJcmUs/4zoUU3gcj0qrU+KyGcTVmNjJZviVB
 5CZHsWMn+aGc2FvVUo2oeJoLymrIpSuDvtq8qOlEGJLhvHP9VVjnx9Qcpvcv5DxsmhiGx7efBMt
 RjqnYQdC+NdIms5o5v2geZ2GUfuC7RfP
X-Received: by 2002:a05:7300:ac82:b0:385:4b9:18f2 with SMTP id
 5a478bee46e88-3857093f077mr10218206eec.21.1795287482385; 
 Sat, 21 Nov 2026 10:58:02 -0800 (PST)
Received: from qqlt ([2804:14c:5b81:8b94:5fa9:2af4:7818:7c81])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-38566cd4efesm20383004eec.12.2026.11.21.10.57.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 10:58:01 -0800 (PST)
From: Thalles Campagnani <thallescampagnani@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: u-boot-spacemit@groups.io, Yixun Lan <dlan@kernel.org>,
 Huan Zhou <pericycle.cc@gmail.com>, Eric Chung <eric.chung@riscstar.com>,
 Leo Liang <leo.liang@sifive.com>, Tom Rini <trini@konsulko.com>,
 Thalles Campagnani <thallescampagnani@gmail.com>
Subject: [RFC PATCH 0/3] ram: spacemit: add native open-source K1 DDR init
 driver
Date: Sat, 21 Nov 2026 15:57:35 -0300
Message-ID: <20261121185739.531651-1-thallescampagnani@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 21 Nov 2026 19:58:34 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This RFC series adds a clean-room, GPL-2.0-or-later LPDDR4/4X DDR
controller and PHY initialization driver for the SpacemiT K1 SoC in
U-Boot SPL, removing the requirement for the external proprietary
ddr_fw.bin binary blob.

Hardware documentation and clean-room specification:
  https://github.com/NoBlobs/SpacemiT_K1_DDR

Summary of changes:
- Patch 1/3 adds the native driver under drivers/ram/spacemit/
  (CONFIG_SPL_SPACEMIT_K1_DDR): PLL1/PLL2 setup, MC/PHY Device_Init,
  MR8 geometry/density detection (x8/x16), address map, hardware DFC
  table, PI write-leveling/read-gate + independent memory-pattern Vref
  and per-DQ eye centering, and automatic rate fallback
  (2666->2400->1066, 2133/1333->1200->1066, 2400/1200->1066).
- Patch 2/3 wires CONFIG_SPL_SPACEMIT_K1_DDR=y into spacemit_k1_defconfig
  and board/spacemit/k1/spl.c, omitting the ddr_fw.bin binman blob by
  default while keeping the legacy external blob path optional.
- Patch 3/3 updates doc/board/spacemit/k1-spl.rst.

Testing:
- Banana Pi BPI-F3 (8 GiB Samsung LPDDR4X, dual-rank x16) and
  Banana Pi BPI-F3 (16 GiB Micron LPDDR4X, dual-rank x8) across
  1066..2666 MT/s.
- Native SPL built from this series (without DDR_FW_FILE) booted on the
  16 GiB BPI-F3 via FDL (2400 MT/s, 16384 MB detected, "DDR is ready",
  handed off to OpenSBI + U-Boot).
- Linux 6.6.63 multi-core memory soak up to 8 GiB (4x2048 MiB) passed
  with 0 errors.
- LPDDR4 (non-X) and native single-rank x16 paths are enabled in code
  but untested on silicon.

Questions for reviewers:
1. Should CONFIG_SPL_SPACEMIT_K1_DDR be called directly from
   board/spacemit/k1/spl.c as in this RFC, or converted to a UCLASS_RAM
   DM driver with a DT node?
2. Should the legacy external ddr_fw.bin path remain behind Kconfig
   during transition, or be removed?

Thalles Campagnani (3):
  ram: spacemit: add K1 DDR init native driver
  riscv: spacemit: k1: use native SPL DDR driver instead of blob
  doc: spacemit: update K1 build instructions for native DDR init

 arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi |   2 +
 arch/riscv/dts/k1-musepi-pro-u-boot.dtsi  |   2 +
 board/spacemit/k1/MAINTAINERS             |   2 +
 board/spacemit/k1/Makefile                |   2 +
 board/spacemit/k1/spl.c                   |  46 +-
 configs/spacemit_k1_defconfig             |   1 +
 doc/board/spacemit/k1-spl.rst             |  49 +-
 drivers/Makefile                          |   1 +
 drivers/ram/Kconfig                       |   1 +
 drivers/ram/Makefile                      |   1 +
 drivers/ram/spacemit/Kconfig              |  10 +
 drivers/ram/spacemit/Makefile             |  10 +
 drivers/ram/spacemit/k1_ddr_boot.c        | 300 +++++++++++
 drivers/ram/spacemit/k1_ddr_boot.h        | 116 ++++
 drivers/ram/spacemit/k1_ddr_eye.c         | 438 +++++++++++++++
 drivers/ram/spacemit/k1_ddr_eye.h         |  32 ++
 drivers/ram/spacemit/k1_ddr_init.c        | 617 +++++++++++++++++++++
 drivers/ram/spacemit/k1_ddr_init.h        |  62 +++
 drivers/ram/spacemit/k1_ddr_spl.c         | 117 ++++
 drivers/ram/spacemit/k1_ddr_tables.c      | 213 ++++++++
 drivers/ram/spacemit/k1_ddr_tables.h      |  86 +++
 drivers/ram/spacemit/k1_ddrt.c            | 627 ++++++++++++++++++++++
 drivers/ram/spacemit/k1_ddrt.h            | 116 ++++
 drivers/ram/spacemit/k1_ddrt_io.h         |  41 ++
 drivers/ram/spacemit/k1_ddrt_priv.h       |  25 +
 drivers/ram/spacemit/k1_ddrt_regs.h       | 277 ++++++++++
 include/spacemit/k1_ddr.h                 |  22 +
 27 files changed, 3179 insertions(+), 37 deletions(-)
 create mode 100644 drivers/ram/spacemit/Kconfig
 create mode 100644 drivers/ram/spacemit/Makefile
 create mode 100644 drivers/ram/spacemit/k1_ddr_boot.c
 create mode 100644 drivers/ram/spacemit/k1_ddr_boot.h
 create mode 100644 drivers/ram/spacemit/k1_ddr_eye.c
 create mode 100644 drivers/ram/spacemit/k1_ddr_eye.h
 create mode 100644 drivers/ram/spacemit/k1_ddr_init.c
 create mode 100644 drivers/ram/spacemit/k1_ddr_init.h
 create mode 100644 drivers/ram/spacemit/k1_ddr_spl.c
 create mode 100644 drivers/ram/spacemit/k1_ddr_tables.c
 create mode 100644 drivers/ram/spacemit/k1_ddr_tables.h
 create mode 100644 drivers/ram/spacemit/k1_ddrt.c
 create mode 100644 drivers/ram/spacemit/k1_ddrt.h
 create mode 100644 drivers/ram/spacemit/k1_ddrt_io.h
 create mode 100644 drivers/ram/spacemit/k1_ddrt_priv.h
 create mode 100644 drivers/ram/spacemit/k1_ddrt_regs.h
 create mode 100644 include/spacemit/k1_ddr.h

-- 
2.56.1

