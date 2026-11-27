Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208A7606A324
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 10:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mwy3oyGn;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=04afyBBu
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EA29D8122C;
	Fri, 27 Nov 2026 10:31:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hPD5SEp_7LIc; Fri, 27 Nov 2026 10:31:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D3A8E81220
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795775471;
	b=QEYUSqvCpDatywj77Gv9zB3ETsoM24TjXo/vS6HE9aXPltMXLyHJaBR3LNSSwWemKP3N
	 CKx5Pj5UPAHtOlJGrZuHD4aTryGjnMxehjb+IQY4CvGG8ok0AO2jSd91aLFOpr+o3SUua
	 mz5h6IKHdwuuf5xwCZO1amCmncuC6r2UBWxoEvPi6Dc4uoJ44/IkiJ77WCnFUg02LHxBu
	 i05cCRHbK1bHLWmLQUg8qgt2o/vdUvVf1XCzoNKiol+plPlhrlfrm3mHrAdt2vPanffzP
	 X4kyzzwNNYl4/3rlTBOnTaTCte7g3IqQ4HL79RwxQ7JU1o65HOUFF3papbA3BW0Eb7Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795775471;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=kd1mvAEyZZv1zR1UCdSBXqmvuq+OTXlA1kqdlGgnSaQ=;
	b=jCFnZnhOSwULkIq3B2ClBZ6cWeZxKoPbhSzOt8bdGCxvy7b4WvbV5d8jI5UDLZwTdPH1
	 5P7M8bbKig159NCqktYSNISo1lQ7k0vzmwbdVXuWTsquOuOuFcVUARBgWGwSIGdE7WmHp
	 Y7vp0ujFNHDFolIGg3DXuzXtacnCICKuoH/RItc9ad+4N9u0ams+QYmotCfeWG3tbpK5U
	 cYYOh5CE1yc8jJgNwDSl+Xys48SOyw67XGuZ8ExOBAKAJEUa+5Clx7+vf2BUI5bxSd/vr
	 3bljLSNVZoUvEAjD/qhYT65bV1fF5B9oHVca1n4GetdG2hyDFV+rj1eRBNrACBTojzA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=04afyBBu;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795775471;
	bh=kd1mvAEyZZv1zR1UCdSBXqmvuq+OTXlA1kqdlGgnSaQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=mwy3oyGnsgdg09lJkBCYTImzhqr+Cd5r5UBRICKWqgYYgH1lgJBEapy8RmBWto5EN
	 stZejDUxP5vip6OosmmYEDTPxCGdsg1dPMjzGR6ancQZg3j14kFnhv0V7nEqaO07nB
	 XEVOv+Y5z1M9IBsCkvw00W4E3kaJUqOoQyHFhjAWw/7jMKwHpDIlCzxEA5EO23P6+X
	 iUOwNuWX9RIx11DVTdmEQPSvsu6NyoqsHsoK+blnssVKuCmchs82qLnczumJ6zuVl4
	 enJrdM/u1wxsVKCTxsj8L+TVMNDaiH90uaJ41lwvFEAMVL/25CMKte6upCCzI7YnSJ
	 vKEgXaHxyaF4g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D3A8E81220;
	Fri, 27 Nov 2026 10:31:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 26D09D1
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:31:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1534881220
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:31:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VkXs5t0at0iA for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 10:31:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 21BC28121F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1335; helo=mail-dy1-x1335.google.com;
 envelope-from=linux.amoon@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=04afyBBu
Received: from mail-dy1-x1335.google.com (mail-dy1-x1335.google.com
 [IPv6:2607:f8b0:4864:20::1335])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 21BC28121F
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:31:08 +0000 (UTC)
Received: by mail-dy1-x1335.google.com with SMTP id
 5a478bee46e88-386cf1041cdso4874156eec.0
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 02:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795775468; x=1796380268;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kd1mvAEyZZv1zR1UCdSBXqmvuq+OTXlA1kqdlGgnSaQ=;
 b=04afyBBuhPEzrX2nKSIFvKipZApSHFhFG+65WgqcY7qKiL22KSf0ra5LhSPz2UtkGO
 J86+ByzF58sF3CWbGZw8s0fuftjBZH9aA07Ce0KMq5CwNPY9tEFcDZZJ0N+6QGXdPqie
 Bz9Z0eZc58DX3ZtWVawfMWbzDS/jEQCsaQphtqsK1tufqz4A4x9+t4EbOzhctQFvwdfD
 IdEPbQLFY3ey3IbU2C06R7Jt6Urj1XEMlsNTaOH7vKKqsfXGH7x0ZL319p5L68zFlcFw
 nBWRpROq7UWRURnuH+AG3sC4HK5wtI8BODA1sh6YwHS6y62Og1bWW6zt2IVSW0vuPDGd
 qzWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795775468; x=1796380268;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kd1mvAEyZZv1zR1UCdSBXqmvuq+OTXlA1kqdlGgnSaQ=;
 b=fV/aie+3sXJ9Pps7yCIxNNdaBHVDvo7iWDxxl76pJNgfs3zf5n2L4SpSsgvQoCXo7l
 8mzg9oBwuH9tu95CAGLjZmxAba5szD5xpXm/x04Eq2GR4zt3ZR4aYbimB4pj3gT9n6Pw
 BkqEF6NQG+am+6qZkPQW/57gg7ILSa0BeLa6DDmyDL/p6o9JW/nfqi+qb6oxxgII+2Xj
 q9i/wNG8RLT2pUaBM+3MAJ8AXhPrOmw3PZ9jnoppfsaB3qDYDVa5/5HvDuD6yPX4Fryh
 nH2MpGRE3KklfpazFw3DX8u7aTC1BKCLIS2oMH4XOr6VAqxgrB3oBrxWp1w9OU7ddsjj
 7n5g==
X-Gm-Message-State: APuU4Z8HIhSZ+fO7dUbdcRDnmxnifISNIc3WZb+jGv9BoKfREato2C5B
 G9Rlx1jfL46xmFrO2hv2PR0mf/yukbNIBMBC5xPMvg6ZLygTtejI4qk2mdO+fQ==
X-Gm-Gg: AZFdTZcwXB6+c5gBMrPcURE8GZDTJeofF7UI8sEKq89sjDPjt89v4hllFXiynZIXqqQ
 CEoX3V0exH43OOFUGQs/LjBbnVSFkS4XHphOp7+3RxzensjtWyUBFcf28Ewus8doLAyGXsQk1x4
 jDhG0b7Zl+J1Hb2CujvjBYWwVvjlujNiAhUX7DkXPi499Z6kTDHXei7FkbanJEMb8FqWqAeBcH4
 MOr9teeZR3SZmGfhpOhrXiOQTaxQbV/S8xqPM4jg+2A2Du/NOxfXR0ikSSZaXq09anVjhoUke2Y
 pvoVt0+aVFbmM6N6aWiBqsp/PO+C/azgJWF87enh8Zx9CBOyRoRzTqa58karvyMBHAn2AV/iJH6
 Ry1Obicj7TbD/pe7MpfdG7z46uFiaipP76xvHZTMcICh4EVOyXkgBO690g5gVF4VBSF5r1+ojZ4
 u7oe88/tYdg7DwQkwsflycr4ThF2qQ2Dk20dgozMV1Zp6jihYHG9cDrYz9lIkZiMu/yqbDp+HJv
 wosAufU85hYrhPQk+EN7o1+EbwZy2vza0fPJQ4m83X2wa+qCqmH//w7VFDoUnMMBOM+fEGLA2bh
 T3JPR3aXAayRMT1i9JvfYWpPWqFT
X-Received: by 2002:a05:7301:6083:b0:386:a01f:a36b with SMTP id
 5a478bee46e88-386a01fa8d8mr28478727eec.35.1795775467648; 
 Fri, 27 Nov 2026 02:31:07 -0800 (PST)
Received: from arch-rock5b ([45.112.0.246]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385666e7fc3sm63369991eec.8.2026.11.27.02.31.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 02:31:06 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Anand Moon <linux.amoon@gmail.com>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Yixun Lan <dlan@kernel.org>
Subject: [PATCH v3 00/13] riscv: spacemit: Add GPIO and pinctrl support in SPL
Date: Fri, 27 Nov 2026 10:29:59 +0000
Message-ID: <20261127103030.4647-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This series improves SPL initialization and SD card support for
SpacemiT K1-based boards, including the Banana Pi BPI-F3 and
MusePi Pro.

Start by consolidating common U-Boot-specific device tree nodes
and properties into a shared K1 DTSI and removing redundant
board-specific overrides.

Add GPIO and AIB clock support in SPL, followed by SPL support
for the SpacemiT GPIO and pinctrl drivers. This allows GPIO-based
card detection and device tree-based pin configuration during
early boot.

Improve the SpacemiT SDHCI driver by adding voltage switching
diagnostics and selecting the appropriate pinctrl state based
on the requested signal voltage rather than the timing mode.

Adjust the SPL stack and malloc configuration, retain the GPIO
and pinctrl nodes required during early boot, and enable GPIO,
pinctrl and MMC UHS support.

Finally, enable uncompressed multi-DTB FIT support in SPL and
update the Binman configuration to accommodate multi-DTB SPL
images. Using an uncompressed FIT avoids the additional memory
allocation required for FIT decompression within the limited
SPL SRAM.

The series lays the groundwork for supporting multiple K1-based
boards with a single SPL binary.

Changes in v2:
v2: https://patchwork.ozlabs.org/project/uboot/list/?series=535531
- Consolidate additional common U-Boot properties into
  spacemit-k1-u-boot.dtsi.
- Reduce duplication in the board-specific DTSI files.
- Retain board-specific configuration where required.

v1: https://patchwork.ozlabs.org/project/uboot/list/?series=530594

Thanks
-Anand

Anand Moon (13):
  riscv: dts: spacemit: k1: Move common U-Boot nodes to shared DTSI
  riscv: dts: spacemit: k1-musepi-pro: Drop redundant DT overrides
  riscv: dts: spacemit: k1: Move common U-Boot properties to shared DTSI
  clk: spacemit: k1: Add GPIO and AIB clock support in SPL
  pinctrl: spacemit: Add SPL support for K1/K3 pinctrl driver
  gpio: spacemit: Add SPL support for K1/K3 GPIO driver
  mmc: spacemit_sdhci: Improve voltage switching diagnostics
  mmc: spacemit_sdhci: Select pinctrl state based on signal voltage
  riscv: spacemit: k1: Adjust SPL stack and malloc configuration
  riscv: dts: spacemit: k1: Retain GPIO and pinctrl nodes in SPL
  riscv: spacemit: k1: Enable GPIO, pinctrl and MMC UHS support
  riscv: spacemit: k1: Enable uncompressed multi-DTB FIT support in SPL
  riscv: dts: spacemit: k1: Support multi-DTB SPL images in Binman

 arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi |  86 -------------
 arch/riscv/dts/k1-musepi-pro-u-boot.dtsi  | 113 -----------------
 arch/riscv/dts/spacemit-k1-binman.dtsi    |  30 +++++
 arch/riscv/dts/spacemit-k1-u-boot.dtsi    | 133 ++++++++++++++++++++
 configs/spacemit_k1_defconfig             |  14 ++-
 drivers/clk/spacemit/clk-k1.c             |  29 +++--
 drivers/gpio/Kconfig                      |   7 ++
 drivers/mmc/spacemit_sdhci.c              | 144 +++++++++++++++-------
 drivers/pinctrl/spacemit/Kconfig          |   8 ++
 9 files changed, 306 insertions(+), 258 deletions(-)
 create mode 100644 arch/riscv/dts/spacemit-k1-binman.dtsi
 create mode 100644 arch/riscv/dts/spacemit-k1-u-boot.dtsi


base-commit: 9d67454e920b3908529c9fc642a8c911db040896
-- 
2.56.1

