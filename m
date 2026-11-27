Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E93606A31C
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 06:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uUH2QKbN;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZKOeA9AO
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B1F9D40A3C;
	Fri, 27 Nov 2026 06:36:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rd64ABXlxRJ6; Fri, 27 Nov 2026 06:36:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9D943409C7
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795761392;
	b=JT6mFeUJDdS2ZgdkrF5sgz+vrIfLUw/aYeUNDrMKfNkQIY4a51xQsdRPz7+kvfEsnKXn
	 3+s7FNS+SXD7pMQ4zA8mE5pLDmFKBRx4dMS5makD3UMjZCrqQUGpHA3/njkd7wLEnsHKh
	 1HOP6HZPU839NkV3YzDDmEF2J8XmM7nXEsvk8VcgXO+JkZu8vVXhkcr5EYFjEEbO712MO
	 BSgiedjMYP0YaTYsjlyrye2hY11nrGK7HkDdnJR6BrlMOzWHQ7TMYmNFf3OC4QfCpeiTm
	 i6LEDI/RBQT89acGxv00H9/PwI+VDqsQg3xCgz/5oGGSmN0wY1Lu4D5Vf3OXchwdW0w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795761392;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=eTVz9he4ojeIJrv/0miiKKBXZ1ypKfKGRF9w46na14E=;
	b=mrW+eZzArEI+tSZ22ROkyHUZQfa1BedGnOiGom0SfsX4Lr67szJdIcADJSWvKvWpxkxG
	 rvITP8/PbN+WVFItyY52lCLt0Fdn6xZhWf1r7Xmj3IKuuA4oHPTlC5GXm8yxyJB10TlwJ
	 vmHnKkahWJGvmhoFKtpuHsB4yWH6LWMLS+n9wAxxgLXFXj6/Y1UsYsZ3bG00wTO1ydWxa
	 DNzn/+EDSC/ViMsqYbMup9qN66mLLmozL0gXK14id4nu+zWAoxEDPzhcd/mBElpLp5lpZ
	 Bl6HAK1U8kQO3Qq610jfP3b02oWmx3On5T/BoGis4UPqEzgURiPnvCOU37n+w4UyDkA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795761392;
	bh=eTVz9he4ojeIJrv/0miiKKBXZ1ypKfKGRF9w46na14E=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=uUH2QKbNSRfdRI9nmSu1+8UMd6+nuYbCnHgzkHgG2QLWtywU3+jmvtomBsN/G2MFZ
	 58/3WwBskHoWt2kR+Db+o1LGVz9Ue5bholgj53ckaTEm/r/J4F1MrufJozYelB+hdC
	 qZRKySImqL0xJ75Q2FDjyGqQ1qiYmwT/+CR7MgDuwIA0TKw49/ckFy3cd9PT0wH76O
	 KQjZ+DvySfL17jsc6I/cyZt0f2QjBH+tIt02zld5/1zkxC0kUl7PDd7rnoenQ9Elmb
	 6MMUP6fNhCB4tjQdymWUkBi6FpQ29N9Ix4RPfWA4BDIZZT2xRAA9FHw02BfknEuA2c
	 hegegA7w4uGsg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9D943409C7;
	Fri, 27 Nov 2026 06:36:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 94345266
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 06:36:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 91DED60A4E
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 06:36:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5vJlnvv5tPsn for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 06:36:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A8F0960A63
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1329; helo=mail-dy1-x1329.google.com;
 envelope-from=visitorckw@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=ZKOeA9AO
Received: from mail-dy1-x1329.google.com (mail-dy1-x1329.google.com
 [IPv6:2607:f8b0:4864:20::1329])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A8F0960A63
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 06:36:30 +0000 (UTC)
Received: by mail-dy1-x1329.google.com with SMTP id
 5a478bee46e88-386bd881d39so8436690eec.1
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 22:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795761389; x=1796366189;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=eTVz9he4ojeIJrv/0miiKKBXZ1ypKfKGRF9w46na14E=;
 b=ZKOeA9AOKxL1rDfupi4/kOf9DdY2vJbOd41mQ4YT4/pnX1qS9Qu62GG0/pcsX0ncyx
 nMfeM2La/sO7OgKHajnBuWE+/rGsLYlImL6giZP8wAT2kug7flG/5ZkHuiZ5kBPDDffZ
 lXUP27EdXEHBy1NejxMReJs8ThXV/Xq22+rsrAz7PpKyY1QYBT4WyEGr0s3+d8nWLSIV
 KtVuOeHPevyLChZ7BTf1ZnZ66LNDRDzPU1rba/CgtSoE8ZvBeL2nKn9GIsAS0QaALAwR
 vInWg41hK0Oi4TGkyyNCzQlrrtkDNlhHLTpy6+oKX9hiAxkijcErruFiCUWcqu4CcunB
 0emw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795761389; x=1796366189;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eTVz9he4ojeIJrv/0miiKKBXZ1ypKfKGRF9w46na14E=;
 b=D0FS/kVyXzIey4EyCcYSf6STjvvFZ9qCm+gwu8YqI65GxnCcqoMrhMcAWqnUhCj2Ab
 TmRZwkIqzHNZ2MbZDQVwMMswB6YEhoRqe3+Cq8aY0iUi50LBkRD+yXMhG50DO2MGpsDR
 DLGEFdt+Z6iuhyeuBQW5VGWrmNqt68mzf/ifL09acneFggaztijK0E81j1htYdKn+X24
 sDwOiDxpMGLWFMlMDpb4ypSJ5HgyXFOQkjzdaXObiL88GosqDgO/hkoUY2XhQX+bcF4q
 KCf972YhaTU54AxVAxUz/lsvMsljne+nMop40GxvLiVCBSgNiiwXsScqIWo3y+pCzZk8
 2MUg==
X-Gm-Message-State: APuU4Z/E2JQoieg1l6xPjYgL4FxYGTWhEMm3/9x1EPRBpv9VlH2zCELA
 5Du03nF9YBFMNIBt2neygGzHNxPHM2rVhfL1vzTSr1Aj2dnCmCBdljOf
X-Gm-Gg: AZFdTZdFPeJJtOU+bPwYiQEPrFHNW/u9EAJq8S6FDQADniBhcjwGox08xQjWLXN+/a0
 rFk1FkNYzQDD28GtHxZSNFAIY71GHQdJBA6TBYoUAr1aGMMjpfEeN3ijEAA3SkSsEnIuFr8kacD
 lSY1H+2XiXtgEv3aLc/bdF/8HNJI6bwOvg7pnTLccUWqgP8K0i2Z3DH2q8xeCzO2ZG4hcc+L/rW
 cCIwLZ9qACh8sP2FjsEHwdybqWgeGVdDd41BLONe9sTu5kvGxjg1izJgq4/r/vuvZX4k8gKX6IR
 t8xB3pswrkQhM6x7GNJwECqIxxmY8guH3ipjmOQMU7sKA41aptjYCCzUduIgk2c3t5aDsBeAI5H
 OnFdY6zeFh5p0jt8f6YRZtIrO3Yg8MpvYUBCRuzB9OiCo/Eh5tBr3P/+g3EffFrykvWN2myZOby
 FSyOjvjnUsJfTVSq/bk+fqChSQL0mlBzaC3jBmm0ZoUWzMnvFl7hA6PXPfPBYwQRHlFF2yLJ30v
 yuwrqc4115Krb9j4JdSJmQdXmyJ0usD57y1eG0tmX0CPHZWLn6TUlPlpWf++aCpyNwJinn3PvLn
 Dm+BHJyX0p9gnJkKCgvise+LMPb1ncgG14ry/MrDSR4rD6z3W6xZPUxMUwcxROwD47b/+WZdIRr
 cP+IoCsw1CjjUWV300WVRUF0/
X-Received: by 2002:a05:693c:8083:b0:376:6530:248f with SMTP id
 5a478bee46e88-38570a3717dmr27592982eec.24.1795761389323; 
 Thu, 26 Nov 2026 22:36:29 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com
 (55.11.81.34.bc.googleusercontent.com. [34.81.11.55])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385672c6f31sm67452444eec.15.2026.11.26.22.36.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 22:36:28 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: trini@konsulko.com,
	ilias.apalodimas@linaro.org
Cc: u-boot@lists.u-boot-project.org, sjg@chromium.org, marscheng@google.com,
 eleanor15x@gmail.com, jserv@ccns.ncku.edu.tw, visitorckw@gmail.com
Subject: [PATCH v2 0/8] arm: google: Add initial support for Google Tensor G5
Date: Fri, 27 Nov 2026 06:36:12 +0000
Message-ID: <20261127063620.399391-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds initial architecture and board support for the Google
Tensor G5 SoC, referred to in code as LGA, and the Pixel 10 series
boards based on it.

U-Boot is built to run as the BL33 payload. This initial port sets up
the MMU mapping and DRAM bounds, disables the APC watchdog left running
by earlier boot stages, and enables the serial console.

The first three patches cherry-pick the upstream LGA devicetree bindings
and sources from devicetree-rebasing using tools/update-subtree.sh so
that this series builds cleanly on top of next.

Tested on real silicon:

U-Boot 2027.01-rc3-00221-g7f8c292cf873 (Nov 27 2026 - 06:19:48 +0000)

Model: Frankel
DRAM:  2 GiB
Core:  7 devices, 7 uclasses, devicetree: separate
MMC:   
Loading Environment from nowhere... OK
In:    serial@db62000
Out:   serial@db62000
Err:   serial@db62000
=>

---
Changes in v2:
- Rebased onto next
- Cherry-picked upstream devicetree commits via tools/update-subtree.sh
- Added SPDX header to arch/arm/mach-google/Kconfig
- Dropped SYS_CONFIG_NAME and include/configs/lga.h
- Lowered LGA_BL33_RAM_TOP to 0xbe000000 to avoid LMB overlap
- Added doc

Link to v1: https://lore.kernel.org/u-boot/20261016040216.3636305-1-visitorckw@gmail.com/

Douglas Anderson (1):
  arm64: dts: google: Add initial dts for frankel/blazer/mustang

Kuan-Wei Chiu (5):
  arm: Add Google Tensor SoC architecture support
  board: google: Add Google Tensor G5 board support
  arm: dts: lga: Enable console UART in U-Boot
  configs: google: Add lga default configuration
  doc: board: google: Add Google Tensor G5 documentation

Peter Griffin (2):
  dt-bindings: arm: google: Add dt bindings for frankel/blazer/mustang
  arm64: dts: google: lga: fixup #size-cells DT warning

 MAINTAINERS                                   |  10 +
 arch/arm/Kconfig                              |  21 +
 arch/arm/dts/lga-u-boot.dtsi                  |   9 +
 arch/arm/mach-google/Kconfig                  |  18 +
 board/google/lga/Kconfig                      |  11 +
 board/google/lga/MAINTAINERS                  |   6 +
 board/google/lga/Makefile                     |   3 +
 board/google/lga/lga.c                        |  65 +++
 configs/google_lga_defconfig                  |  10 +
 doc/board/google/index.rst                    |   1 +
 doc/board/google/lga.rst                      |  37 ++
 dts/upstream/Bindings/arm/google.yaml         |  48 +-
 dts/upstream/src/arm64/google/lga-blazer.dts  |  15 +
 dts/upstream/src/arm64/google/lga-frankel.dts |  15 +
 dts/upstream/src/arm64/google/lga-mustang.dts |  15 +
 .../src/arm64/google/lga-pixel-common.dtsi    |  22 +
 dts/upstream/src/arm64/google/lga.dtsi        | 411 ++++++++++++++++++
 17 files changed, 698 insertions(+), 19 deletions(-)
 create mode 100644 arch/arm/dts/lga-u-boot.dtsi
 create mode 100644 arch/arm/mach-google/Kconfig
 create mode 100644 board/google/lga/Kconfig
 create mode 100644 board/google/lga/MAINTAINERS
 create mode 100644 board/google/lga/Makefile
 create mode 100644 board/google/lga/lga.c
 create mode 100644 configs/google_lga_defconfig
 create mode 100644 doc/board/google/lga.rst
 create mode 100644 dts/upstream/src/arm64/google/lga-blazer.dts
 create mode 100644 dts/upstream/src/arm64/google/lga-frankel.dts
 create mode 100644 dts/upstream/src/arm64/google/lga-mustang.dts
 create mode 100644 dts/upstream/src/arm64/google/lga-pixel-common.dtsi
 create mode 100644 dts/upstream/src/arm64/google/lga.dtsi

-- 
2.56.1.839.g22a8290db9-goog

