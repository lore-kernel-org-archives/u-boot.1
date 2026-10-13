Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B821FCC6B0E
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 08:02:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7185860760;
	Tue, 13 Oct 2026 08:02:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b9sXzkpV9IWk; Tue, 13 Oct 2026 08:02:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A0FB160749
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791878548;
	b=Jfd66VK6C257QOWLfT/5j3gJNrRJeAEhNpzXwQ8NHfYSxfmqnzK2DVvTRbBhWxJEJ5oa
	 f708dmHcHH2rMC+Qhc67uuUq3fTOLJ7hSfuK15Pwera0VQe1DntbxxZVbTu/0Bh6rQ/ki
	 zVzGaGLF3gZKfplOfSQ3ttNUdJeiiJrcCbkhyo7J3qsbzuComYcPpl6nly+6MSc2bLxO8
	 1Nzf8rf00+wv5OsxWdEfjnWn2yieA1a4/2HN+JUKZvG04Js8moqAbuy6+N6vAfzSIDodE
	 QVDT0e+DX7kePiNrSHePuONsGsWeY9ys2aPJmUmVXlpWfYzs7W8EXnDitZ0J3YYwK8A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791878548;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=cMO9ppggzVvCl4dvVbTVJUZqWMj9dMcH4xn488f6WyQ=;
	b=eaAYUkDoP2lFrZyY4VPhqQiOojuBAmJzY7xPdDL0H4u+vDNHipcpBdU1wmGbsuhndLQ7
	 x5pUd45efbfawe+j32yMzVYWIv+p0mzWM3QRmhT845PBDzzt+9om7HX26FwaQdz46UTTo
	 CAa2dnmtZuD/4esbdDQh5ZAXg3aOIQXorRVht+v/dFjPJvod8Y5BTDPe6h0UPbVVX6gGm
	 xYjHo1rqj0LUT/x91EPN49efrl1nISADMnRb8LgCld3Cbwq4OTzlfW/yPbw9HrUQRjXiU
	 3ulb4gFJFFk/+nRrKoLCQ4e+loF7ZZt/ZNP9eGX2KKsac1VG0T23rMuRYyNSr7tJG5A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791878548;
	bh=cMO9ppggzVvCl4dvVbTVJUZqWMj9dMcH4xn488f6WyQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=cWwmwZSewFNJ6QrO6BRbYSNgpAI247tYdlcf/fmgpSWX0Knp0AbvVLTRWTn5q/I1K
	 8z9MmE4GGKTZCAQemHJz9aOwjXi6PAthc+ubPodzgvz9Ia5j+jpEvvUswf5A6P9qIN
	 f/jTrFSzNTAroq/xmCf7RihBHVSURPVtN5Eyv8QmfegEhEZHyb6ncP+3P4Ow854PEP
	 eufV1nF2CYQLVwIO6gWkqRL9Xqm1ea2wF/90Uvwga3sWTfZqSz7F9aVAknmoVf0daI
	 DBhkgGKhniQ0U+ThNVdiDYFzQR34rrt/RlHSxEt5Trlz9brd4Q2zHHiL5urwIJSjOm
	 gsUsq5jeH8x3Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A0FB160749;
	Tue, 13 Oct 2026 08:02:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 021A71E9
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:02:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E81FF80742
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:02:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a2myz1LcuSMM for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 08:02:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3396780AAE
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791878546;
 b=NelA7nnhm7RWX6hA/BFEAwIYaysxOiZKdqHswLxyNAb5FokwRU4BjlW9pgAWvah2k8fI
 Iks+oJs7KAvPtlhCBURwdh+xqDuZEGwxHw6Yi6mXAascrV6emgEHo+S0UW9k+1a8Cb4H5
 2xCQYVDgmgv6T/VL4PnUx5HL2LeakNOO+k1FmfeNfOMVeLVlgBHL2h03+TJ3PSnVXodA0
 iYXDM+maBiS0cjSvMJUBgfweECBCVTU9YrOMAH/GQxE+xu64toSapR2DATpKoB4M75TD0
 2eimbxiZpl+bkNNIdk7vtTo1fxSQ8/gLLUhAgpn42xCDmUlAUdFQ8JvAS3BSS92ybUQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791878546;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
 MIME-Version:Content-Transfer-Encoding;
 bh=cMO9ppggzVvCl4dvVbTVJUZqWMj9dMcH4xn488f6WyQ=;
 b=rVVVySMizRSpEHWNMq80YwzN1ts7LkXghuGAofe1+40puVahZQRfR6SpSimQkrba90hf
 RMShNGSUBVmCCQfusaCRKNpm9uo8W3Mj6fjQKqhMGW5sbjDPnfq0U4HmmEVEb8lHye+qK
 jsR6fncg43lAhkcjIdM09SXXDKuAagrWwC0v+Mvo9A1LSmtFmtNLqtHedGuV0CI6coyg+
 pDwdu2ewN95pk57VXhkqT7GvOBTfzKQKTMe0d0JOJBRHwJjUajSrJuKOlwlzURm880Vod
 FTRL7kvdmvbhLCuRu9AmGV5YgtpYL9hITafe6sl64TtyTCur/dTFVcF09Q05UkvJJTw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=UuOUx3rO; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com;
 envelope-from=jim.t90615@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=UuOUx3rO
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3396780AAE
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:02:25 +0000 (UTC)
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-3a8af3a704fso1248459a91.2
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791878545; x=1792483345;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cMO9ppggzVvCl4dvVbTVJUZqWMj9dMcH4xn488f6WyQ=;
 b=UuOUx3rOXqddrXIXkiBu1xuOt8IWTh424mo9NHk27P2yTT6Fke+Z8KOoZktrNNkXaN
 9mMhCVD3eoW/KaqYVgp9la+qO6Odm94SWKdDLkMhbF+VIYNsHTVNE1wCVIo7MxWNUHHx
 R0lwEKVI05ex3ncwvw1DcTUiEiyR/nn3bSyFXLVXEWsvhBsQ9zmSioeoVOslzIeGQwV9
 oxPLiMJJ5SRUS59++Gm1vCwIiBhW88v0cqJCciCq2Q1UOM1hy76++CWNaH8uutlbGz5J
 3gkVMzXJWH0siWfLUabp4zfX2ZxNlZD7O0ergcWAZk2ls0OUjYnkFXi0TtL+D+ItOSvz
 CLUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791878545; x=1792483345;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cMO9ppggzVvCl4dvVbTVJUZqWMj9dMcH4xn488f6WyQ=;
 b=zqmyGlTxMeXhFQ0CpM52Ryjh/euKuLb1IpcdDJXrEiMdIGOH4kPHBfSXJdfdtAVYlp
 oPVXF07zY4vl4l3xVUZAHkRq2kjTMWNzOZoj2bHMVlf0kTE58VbAvrTSJ5+H4ZUN7jCM
 X/ed4K+ZgK9r61h9CzCrSw+MM7huNrpkJxo38JlxMWqrozj/RbjULB2v1a1LewaTABxk
 yM/uRI/0594Y+C+Kam7lYIz1e6FE8uKRrR5otxBBioBnoAqLsP8SMRY6RZ6feuQcLV3e
 bhTsoOdkvz7leiZgV2V/bKPMgXi6B3nES+HNmvp97jxEHU35jdT2HLtYgaI7lKyHcA/9
 CpwA==
X-Forwarded-Encrypted: i=1;
 AKwUvByVe0vFyr5Lq69/CjELfetP/dzrz2I7MrfyjmpjCR1JXExT4svFnJnO06JGlE2MTZP2Qb5FGPs=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJ22d/0DjC1WWK4MZVsaFv4VKEkHVTvGVZ6G/mybSVAlC09PUph
 k0jOBH+HaqYp37FSU7wD3snC2hEAM176btiDl+Ms6IN6EIvbFDCXGcRm9jlZOw==
X-Gm-Gg: AYBFou3j0Zmu/iF15nIvSvYMvqK+NUUB7BTkjRWWeGQsTzV0dPEqXdaT29I21SnD/5N
 GLVzBfwjy3KMNxxKcXvadzfEVMg7DqnTt7bpA/kuozUNgQPRT9p8gw8dK/qw5vxiZjssOAYWx5w
 U6PfxTVYmyIJkIL6rsOeuu721qeOaopTlppVeixiyjcpFPlo76NZBgLrrSA0UyCJ/apSBA91Esc
 q/QVU/x0rVfzYTixE+JUviDP9NQe/kEWGiSAk2hoMY5JhUoGtIrFYS7w3UMGxJfiE39di7xwxKP
 hvNtdPoU6kkZL2CbM2YwEB1GH823+Dv9lYJsQQufQKJ14HcdDX4zQlP/t+AAKicwh0IyQyl52Ys
 Fx7q8oBJPBqMRxdhguhwDWxpZCX0wBO93qA13hGCsn4iI/Xjw178lNHPztcWTVaFbZMtwmly/67
 thd4vnfzT2FBtBxF8PcGI6NX/XoVWiRl5rPutSuTq2f43u3wgfAv42cnUO/hf61TpV4vud3CG02
 e+an4Qzgg==
X-Received: by 2002:a17:90a:d446:b0:3ab:2d17:51cd with SMTP id
 98e67ed59e1d1-3ab3a237f60mr9742870a91.3.1791878545010; 
 Tue, 13 Oct 2026 01:02:25 -0700 (PDT)
Received: from cs20-buildserver.. ([2402:7500:502:876d:a213:c5a0:c1ea:6547])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab3962f771sm9175090a91.2.2026.10.13.01.02.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:02:24 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com,
	jim.t90615@gmail.com,
	trini@konsulko.com
Cc: u-boot@lists.denx.de,
	u-boot@lists.u-boot-project.org
Subject: [PATCH v3 0/6] arm: npcm8xx: fixes and updates for Arbel NPCM845 EVB
Date: Tue, 13 Oct 2026 16:01:48 +0800
Message-Id: <20261013080154.1942483-1-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

This series collects a set of fixes and configuration updates for the
Nuvoton NPCM845 (Arbel) SoC and its evaluation board.

 - Report the correct DRAM size when a 4GB module is used with ECC
   enabled, where part of the memory is consumed by ECC data.

 - Drop the system counter setup from U-Boot. On NPCM845 those
   registers may be marked secure and reject the access; BL31 is
   already responsible for programming them.

 - Select GFX_PLL as the pixel clock source on the EVB, and enable a
   few additional commands and options in arbel_evb_defconfig
   (watchdog command, BOARD_INIT and SHA512 hardware acceleration).

 - Relax the default network timeouts so that large images can still be
   fetched over a slow link, and add a 'stopwdt' helper to the default
   environment.

 - Adjust the Ethernet PHY reset delay on the EVB.

The series is based on u-boot/main and was build-tested with
arbel_evb_defconfig and boot-tested on an NPCM845 EVB.

Changes in v3:
 - Rebase onto the latest u-boot/main.
 - board: nuvoton: arbel: fix incorrect ram size (patch 1/6)
   - Fix typo "nuvuton" -> "nuvoton" in the subject.
 - configs: arbel_evb: enable additional commands and drivers (patch 4/6)
   - Drop CONFIG_CMD_GFX.
   - Drop the duplicated CONFIG_GPIO_HOG=y line.
   - Drop CONFIG_SPI_FLASH_GIGADEVICE.
   - Update the commit message accordingly.
 - ARM: dts: NPCM: modify ethernet delay time (patch 6/6)
   - Split the overlong subject into a subject line and a body.

Changes in v2:
 - configs: arbel_evb: enable additional commands and drivers (patch 4/6)
   - Re-enable CONFIG_BOARD_INIT by dropping the
     "# CONFIG_BOARD_INIT is not set" line. Commit 70a4d1fa1ddb
     ("treewide: Remove empty board_init() function from all boards")
     removed the then-empty board_init() and disabled the option, but
     patch 3/6 of this series adds a board_init() that programs the GFX
     pixel clock. Without this the new board_init() would never be
     called.
   - Drop CONFIG_CMD_AES, it is not needed on this board.
   - Fix the missing newline at the end of arbel_evb_defconfig.
 - No other functional changes; the remaining patches are unchanged
   apart from the version bump.

Jim Liu (4):
  board: nuvoton: arbel: fix incorrect ram size
  npcm8xx: remove system timer configuration
  configs: arbel_evb: enable additional commands and drivers
  configs: arbel: add network timeout and watchdog stop env settings

Stanley Chu (1):
  board: nuvoton: arbel: Configure GFX interface

Ted Lee (1):
  ARM: dts: NPCM: modify ethernet delay time

 arch/arm/dts/nuvoton-npcm845-evb.dts |  6 ++---
 arch/arm/mach-npcm/npcm8xx/cpu.c     | 40 ----------------------------
 board/nuvoton/arbel_evb/arbel_evb.c  | 23 +++++++++++++++-
 configs/arbel_evb_defconfig          |  4 ++-
 include/configs/arbel.h              |  4 +++
 5 files changed, 32 insertions(+), 45 deletions(-)

-- 
2.34.1

