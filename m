Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C578606A32C
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 13:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZMl5tngj;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i9HAIF2Z
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2D9554075D;
	Thu, 29 Oct 2026 13:47:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 72QvimBdMEl7; Thu, 29 Oct 2026 13:47:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4A32740757
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793281645;
	b=LNdjNBt8/zmtCZTmCfbBcyjbxoNBAlZza0Q/R/lUmsOIaDccBSRt3N4LM6oG4zu53TyC
	 f7Sv2FADKpI4reZuXvOvdM6qVHAtsjoz9o7qEk8hod8yMpJjBcEg2LwL1EY6hkWgjYjII
	 R3g2+BlUUrYKV7HllZFEtdkMmyL0GMQoPZu2oE0JBaytoELoCqas1bD/ODVud2wJgKOXl
	 ShlE/rQtKP5irXYGC1NgM8KUbYsDRXLhTFIMx89HHnb55ooDA6mp537+LwC9P4mC0dxsS
	 pYHDUpE5mfu3zUWPFpYt/dJlRdo+DZi4spqkOMhj8ZM6zwNYvM1j2+Bv+cDlp0lEgiQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793281645;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=8G/I/0yz8/bwv8nQsRf9ndClxEqibZamCKP1A4pqecU=;
	b=BWrEBddsBCkiA2mF7XEnGgkIPgWqXLn+igCTOlM+oGLVPPZA4Ri8hTL73ks+b5tuDJK+
	 AQCDEioyB3exFZ5kds3agesehFn7I67H0QSUfH5K9QtwEH15u/tp5MDPAwhTTChChVbPz
	 IYnymIhwK6avyoW9tlmgWemCX3wRXYfKKQZNoRhf1hEjYw7frrofgDKAq3SJqsHpOhOSJ
	 6CoPBUpVHea+DSDjskoA4JIdL30TNzdnPhXPgktd5PZpDX2l1z/c23fRk/+y8AJtSmgj+
	 ShqxVah3fquvijlGCu2wCbOpQJivXhY6Ot6i6c+QNtdH9jkfu69uf2hyNzyzitY0r8Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i9HAIF2Z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793281645;
	bh=8G/I/0yz8/bwv8nQsRf9ndClxEqibZamCKP1A4pqecU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ZMl5tngjtZmlxThFUGffBFhuAYkSjqiU8Rh7XZXcE4s1qzmdA65GU596LzRkd/Ary
	 wFT8ya001XyZDV5Q/Nis9Xsagw/N0S5k1yTBN8k19ZpeSH40reXyHxVzDPlcHmrLi1
	 8omxVxDsWn7yZSFwXJmmEbuk3cKEVwsMydvDnNVW6kZSJXtER8ZmuBT+cKSKQTwNx/
	 Xwhp/GAdn1EizWPf3jKNCuUvxyssnyTiBD/ALc8E5bZRJb0rqeIr5AVfvjZFJHH7Gj
	 1WlbMvwbdCtbzQNGUh5A6i14v9EIJERf0Cw7b010LRl+bNtNUFX0K+RQ+gunkw17YE
	 yL38sI1Jlq1lw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4A32740757;
	Thu, 29 Oct 2026 13:47:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3F0002FE
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 13:47:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1D75040757
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 13:47:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3GT0RZsBlKvh for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 13:47:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2DA5A4072F
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::132a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793281643;
 b=QXZ8dMmXpr4k2cmaoAZ0nXevcEF2niyiBk9CLYSpoXZESogRQvQHIFuOYz9h2dqRZxJI
 maku0UiMmLvlZl9NUonz8NugsrVpa6MRCsefxzOUKidt4nBy3eFtDOAxGco28C9U+gMcQ
 nk5yMCrVB87t+0urVPvk7opJUlq1A2bwTeQzJJpmDvwquCc5mJ1O5JoVKVqjFvMgqmtu7
 6I+U3Kd6rq650BLGda4LeJCv1j82vJlt0TjdjOpfG9kdtqZEkn8ndZviyJdn23R7t2Qce
 OW4qc8GCII22+wIQP+rkgwkZXi77qNM6+O1Aqm+95XRbiaS/B6Dkl26uEUTd5LuG3Qg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793281643;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=8G/I/0yz8/bwv8nQsRf9ndClxEqibZamCKP1A4pqecU=;
 b=HJnoweCPdL8lHfHKnJii5KipFRodnc4dcxWBaueUhxNHkjkTt4mO3UGXkPwrt/kxHGLU
 PVnqkIOFR33Zxju1BT4pg3wNZoCId9v1Pwcb6w8DqhE1hFHpBEFTKxKW+EuU6M4s7aQ2B
 ZqPQvjq5Fz9o344TqRmdgCJ/H16SMnehtrqxehJiZt7XQLcAwZuXqMUbJXHx2YnI7tt0V
 wMIl6eHb3b0MtV3U4H4N76Unhg8sfxHNuH4ww9qShbjZz1om38EY0VHolbEEhEFR7YVbY
 /gnu6UjLa0zd1+XwuAavUAPln98Sl4f4k7fDniO+GzQmKXow//Qix5rkiImz5bSFXbw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=i9HAIF2Z; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::132a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::132a; helo=mail-dy1-x132a.google.com;
 envelope-from=linux.amoon@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=i9HAIF2Z
Received: from mail-dy1-x132a.google.com (mail-dy1-x132a.google.com
 [IPv6:2607:f8b0:4864:20::132a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2DA5A4072F
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 13:47:22 +0000 (UTC)
Received: by mail-dy1-x132a.google.com with SMTP id
 5a478bee46e88-3550c917fd3so3038558eec.0
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 06:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793281642; x=1793886442;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8G/I/0yz8/bwv8nQsRf9ndClxEqibZamCKP1A4pqecU=;
 b=i9HAIF2ZYp1xAtsfUjfTUp9iyfbDUXQaKuvA30IcsJAE/xIhZTyXiRtxUt2MnX81uC
 NBLkJkwxomUlCAieHa9UEpipqH/3EZMuUV1PQFLLv3tWMpeV4g+6pqG+ezSZ8qF1rIOP
 I+4fIOT3iu+i8YAEsHHc+YAA1vHEq+K12CCMcVn82JwxKvm6OI7VGvQ87Uq9n/uzblt7
 XHk8ClWlB/6ucaHgodnyZW+QIPfplwyGmfUjH1TRSvyjh3DTWJG8h+gYkpmjQgCMBOT4
 3f4TBJMjwzyuu11g189gpxsVcXyx+TfHCN97eMsJWJWy6iONEsPtqmdBexAN8Ye7Frb+
 /GrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793281642; x=1793886442;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8G/I/0yz8/bwv8nQsRf9ndClxEqibZamCKP1A4pqecU=;
 b=othDyLbeA9UiSoohMpkVkR2jOJVhb0kH1J+m2eefHXXIz4LdelYfQCKFFI8y4IXmSa
 yQujiCxTf7PRBHNqSWji3uan4/dXvJL6xNVU6rOoTImDmRqc1UlmDR+x9DLUQ+5NMvRM
 uBnAo0PQpqaBzUHtm8Z/8AeG6N65PIiEi8+dpjBa+neCd577ZkMTA4B3p8eVVGMwCkzt
 ciqSB3i9e7cLs+stAHDWmbeEnY4nPJMngZ1hFShe+LaolfP4upzxDmR+tFpz3xfb6p4h
 PNEesOKfqGZ84LHMYG0UMfGYdlzNas7r8OuHakPl8eGhf/X4k3/p5emhECH3g3cx+ljV
 e+EQ==
X-Gm-Message-State: AFq9FYKmDvYHdDRizEhi7Vs9NsplnIHZgvHJUBgMBFudon5/lTk4miyC
 2Qtbfukb97SvhpAKYU5Aa2/pUB4/X3Wtag+4X6ijKzxQHqAzojmL7ngZne+RQg==
X-Gm-Gg: AYBFou3IYtOok3vtT0qg1LKszMAOkq9f3tf/Yu0fsFE9wXFjTmk9taVH1OgGVV5x+aA
 w01/TWtkNeNyGkJYl5vbPEBCnEU90fA00NM0oq6tFzUN6xRrXtB89o69H8bYO7zToGGTSNoCPtL
 +q0yjC4QGIS3cKhId5Y8UdabzjOBYInYcVFXtLl9Qw8AQl1qSJN6RH5y89UbUatUDkB2suHlr1v
 grQZ2SHN6j+j4SWcT/PDJJ6CtECX+Nky93G9iMLEDQYjR7uYVexGZYasCWuWS7c4dXx3SyUK9lF
 lCQZp5CgJ946ZMVX7e9Xt2F0FiFSL7cpfRiUdKicP1rHivuSA7U82U6yqSqCzNZDr1FADJNkeO3
 2WncK6WMOGcPikeftWF3N9+6Ic82vOPvPPXaFpEZB259uEunZj4QwQPiOaXKlZPm2dGgFu4kxVZ
 i9lWObflGaQRwkuHK7skGeljEC2fT+hPW48a4zfHCOwkB8+Rs31SXSO0IuDJd60lMKxUSTfJk5O
 7xiq6PdtfBOeMFNaEgXVTg5NYqizu7fWJvEHNQlx6TYNXBSe/37haM5hFJhDFm3Y3ABCnC9Tk/u
 pWh1bMR+3uR7qfIwo56EEo5y1kHQ0YtyHJSRwH8pSPr6xtiVUBw=
X-Received: by 2002:a05:7300:e9c4:20b0:36a:13e1:c889 with SMTP id
 5a478bee46e88-36a20427d57mr8871265eec.36.1793281641859; 
 Thu, 29 Oct 2026 06:47:21 -0700 (PDT)
Received: from archl-rock5b ([45.112.0.182]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a2390a812sm18032339eec.14.2026.10.29.06.47.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 06:47:20 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Anand Moon <linux.amoon@gmail.com>,
	Yixun Lan <dlan@kernel.org>
Subject: [PATCH v1 0/6] riscv: dts: spacemit: Improve K1 SPL support
Date: Thu, 29 Oct 2026 19:16:49 +0530
Message-ID: <20261029134705.3767-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.56.0
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series improves U-Boot support for SpacemiT K1-based boards by
consolidating common device tree configuration and enabling GPIO and
pinctrl support during SPL initialization.

It also improves the SpacemiT SDHCI driver's voltage-switching
diagnostics and handling of missing pinctrl states, making SD card
initialization more robust across board configurations.

This series builds on the upstream changes proposed here:
[1] https://lore.kernel.org/all/20261024092558.143621-1-alan.tseng.cs@gmail.com/

The SpacemiT SPL uses the P1 PMIC to initialize the regulator
framework and enable the SD card and eMMC interfaces. Since boards
may use different device tree node names for vmmc-supply and
vqmmc-supply, the regulator configuration must be handled
appropriately for each board.

This series used above series to marks the nodes required during early
initialization with bootph-pre-ram, including SoC clocks, UART, boot media,
I2C buses, EEPROM, PMIC rails, and SPI NOR flash. This ensures that the
required devices are available during SPL execution.

Additionally, the series moves the I2C8-related nodes required for
regulator configuration into the respective board device trees.
This avoids duplicated board-specific settings in the shared
spacemit-k1-u-boot.dtsi and keeps the common K1 configuration minimal
and easier to maintain.

Tested on the Banana Pi BPI-F3 board.

Thanks,
Anand

Anand Moon (6):
  riscv: dts: spacemit: Clean Up K1 U-Boot Device Tree for SPL
    Initialization
  mmc: spacemit_sdhci: Improve voltage switching diagnostics
  mmc: spacemit_sdhci: Handle missing pinctrl states
  gpio: spacemit: Add SPL support for K1 GPIO driver
  pinctrl: spacemit: Add SPL support for K1 pinctrl driver
  configs: spacemit_k1: Enable SPL GPIO and pinctrl support

 arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi     | 121 ------------------
 arch/riscv/dts/spacemit-k1-binman.dtsi        |  29 +++++
 ...ro-u-boot.dtsi => spacemit-k1-u-boot.dtsi} |  80 +++++-------
 configs/spacemit_k1_defconfig                 |  20 ++-
 drivers/gpio/Kconfig                          |   7 +
 drivers/mmc/spacemit_sdhci.c                  | 118 ++++++++++++-----
 drivers/pinctrl/spacemit/Kconfig              |   8 ++
 7 files changed, 174 insertions(+), 209 deletions(-)
 delete mode 100644 arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
 create mode 100644 arch/riscv/dts/spacemit-k1-binman.dtsi
 rename arch/riscv/dts/{k1-musepi-pro-u-boot.dtsi => spacemit-k1-u-boot.dtsi} (66%)


base-commit: 03e45557e1f38a39a0c80fe30483130ff376cf92
-- 
2.56.0

