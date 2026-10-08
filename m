Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E970CA600C
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 16:28:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8B94F407E2;
	Thu,  8 Oct 2026 16:28:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2LloInV7DI61; Thu,  8 Oct 2026 16:28:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A215A40A8B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791476880;
	b=WZLupVeKoHKTCrR0xG2hHr1uu5FzKPUPzaOLJi334j8Q23Sf4z+gGs31lu5aC2hPr2w1
	 0k6iL+5g8wA08vP2myQ35y2gZa3WcrvGCE91W7FR7s92YKMWO4rkj6HBOVlwvhtnqILt8
	 +Mcn8h5BILR4UoeeOXvPRu8I7oCxT+VLMc8iw0VMVa+A3mAZsjN6xxf1/YY2CHzw/tNaO
	 IzA9Rq6kw26E6HrjCg8CVQGOuwocjlhwZtOV6vxr+9WRIB9AtHc0XaSNKvRSeuu3QXQzk
	 sqhb1n3PrBntgLI32/dy5w9GCViCL7dFffBijS2oOe+/gocf/zY1XRMo0DMcDSUcX6Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791476880;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=CRzcFnEUKtW7q3EcXqL9c75qw0ieqcLqm30hFdmzD0k=;
	b=qo+NFE7CLB2pu7cY9y5twk7bT8UOURFD8ckd8jshuXut+ghPo8kMUvmxkZ6V5FJQoDUw
	 3ymQ1EzcuAQFUuhwB3Pr5wTAYJ1iLK4myLgMMpRQ2YxAm7CDxoGLXrPerTyAdi1xDeuEh
	 HTsW99CT8dcXxpsL6NzFr/59uJSR6bKicagbx+JlN1aTZ937WyWevgR0CpLjQeIwMDCn5
	 rZwkiBIFhRs18hrt7Bnzew0ToNk24FrkvEIoXFJV0nlaNz4VRsnGe1V6i+xzX57CffPs+
	 JKzsCNe/rwBL9DT7ESSbGxhQ/M4vllrFbevbp4rrtKN8I8Ttxhr2U/s6UXJUStwEsPQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791476880;
	bh=CRzcFnEUKtW7q3EcXqL9c75qw0ieqcLqm30hFdmzD0k=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Dalh0wQwp3qRgr0NOrtVtx/Y6Y6pj6rcPVSbbXvT1vohD93RumpaAsL7WDfHQvi4/
	 bb3OZVfSzNjEOfWzlDtegKxWkDdWIrcIjqzUwvU8tw9ZkE5QkvmQAQ41lz5n0rV/pv
	 lmrzT2lgMZcGoHnT9U+loXlz93re2F6lHiLyRTlmdpRSLOUEvddnmJfO4smw1zSUp6
	 ZERv8iKeYVFym2pgQfrxK+rMdi/hU16XAVPebi8Qr/Vf9UfHf+ATSrCkA3VDdpKySu
	 JJe6zkCpx+dN6RnrahGAKsQE4X+MqRN5N8j+5GcF5d7oA6WCmAnH3u0yXF07L5N4G6
	 maLx+Oo4nuisw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A215A40A8B;
	Thu,  8 Oct 2026 16:28:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C564E1A6
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 16:27:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AB8DF60BCC
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 16:27:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WRpG4ewehVRq for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 16:27:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2ABC260685
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1229"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791476877;
 b=F8WQLbKeMYBkCEJITUneXkQTOcCVoSTOSdWV4yYhSDKP54vwm5QdlioxjgsFS0L4yHHH
 PRKYFfPtSsQiT9Yoq4I+wogRafG9eBfTtGpipTHeeMG6zNX/FYsZTeWcc8FuP8fLg9+/G
 2j7uy5JyvMYsp2QFkwst3Do+N2UPBn4PHI/PY+pnMBMZ5WZoMYH4Oqd3t/kY6NePMKhNw
 lIxWuXVey8fR+iKFokrVAk9zvido0kKwD5EEwBAcJeRREqhoy+60tiY6k9QT2euWRH8k1
 JgCdhV4T3Zqe8h5FX6/OQ7SCIU+lQgL5L27vxcGeRtUoTegzVEtwl9nNg8VYiEg1EhA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791476877;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=CRzcFnEUKtW7q3EcXqL9c75qw0ieqcLqm30hFdmzD0k=;
 b=g+yQQMRdMD1By6UVlhLQv90y/yQIBlYLplOf1dwJ6AzuoU7G3VsPFEEDF/yrHrhj955Q
 WXAHam1e+sG9o7581WncXCOr0BI82DdLYis+5xFEU3dYPZ/HtP08yFzfT4MCfNZ1d6UGv
 +YMIYI0TGT9scGLNaXAG/mMInL1FD0d6M8ySAuXy/oax97g8trawfhhD/26UnTvvIfSAh
 MRzud4Rl3xYmSm1PEPGeRzxrtFy4i+2M0h03I38aTvLAN7chLHMPlcvZBMAiGG56D9cB7
 6OnnAkiUHsYKwgecsbBC9h7SzA72MPU/NRFUf3W4E6G8nk9NOpUfSZ/QPcH3rywlPwg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=qQ6IIR6Z; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1229"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1229; helo=mail-dl1-x1229.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=qQ6IIR6Z
Received: from mail-dl1-x1229.google.com (mail-dl1-x1229.google.com
 [IPv6:2607:f8b0:4864:20::1229])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2ABC260685
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 16:27:56 +0000 (UTC)
Received: by mail-dl1-x1229.google.com with SMTP id
 a92af1059eb24-141395927feso5203011c88.0
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 09:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791476876; x=1792081676;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CRzcFnEUKtW7q3EcXqL9c75qw0ieqcLqm30hFdmzD0k=;
 b=qQ6IIR6ZtqBs++pnvDN7B+kC+BIeBoGIpp1+6X8nhFKbzZNe0O7wgm7DvgMSF0kYNx
 pJz/eard/vGhHn4bjnfAbAJH5v0XGHjcxG55/IaHYYBDhPLCG5/MOjvmNTEkO4hUWUXR
 nQ+Z/nmocKjHz0v00He8hPevbbb+nrkr2+qkZ9p/S5bsabhjrlJqs2OPjoB4ESrkIGkm
 XUZ5EQJeuRX9E9w8Mpd1sT34dzwS/zrc6tDVdB5j9dh1NV6n/lBokyNDv5UHjmTf9QkA
 JcY+yNbZ9lrRjTAk+N0F5hW2RAbD3DP9yxx3V1bs1KnHSNPDdTCvgbJnhV5co3K9QV5b
 WoAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791476876; x=1792081676;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CRzcFnEUKtW7q3EcXqL9c75qw0ieqcLqm30hFdmzD0k=;
 b=a3knkO/CWM30qwufNIOx+/ZUY8nOqVD6EbLRQtqoWqHWeJjv02vDxzX2H8la9p47u0
 +pf8Z2Y+22y5DZ6Kp8HofidKaTWXxWgewmEbp1b0TLhHSnGSZi4TeADWCjGUPFfxClM4
 fp/kQWAdchQmlMD0fwbODo+rx1hI8PRMWjyZmehmf8Smywea+AkvCMFHsSgDQ7XhtVaL
 JYbbEcdjyDTOMUDVWA9Ve5kDHhE+Mb5l5l6/wHboVFidDJLur8qbgnt1BHPk7zXajfL6
 ejXp8Bdcm5Tw0ihml9O6dqTwSb0FRNdojFIOlVI7VqUBth3kM5dI37O7mmRfXGkQMLKp
 hexg==
X-Gm-Message-State: AFuF++nw9ptu883H2NqZTxcD29oCqfM5pP37GJ5rO3YmGAOyh6FllK4z
 JvM4JeTTH4a1g12guduHyGsjOTo0Bc8yrkgEEjVDi1umQFLMxm90Dx1f
X-Gm-Gg: AYBFou24UYcuI986eYDXVlingnTGbjFvXS9brN5u2medFYCGNY1CzzoJNnYiKM8Bqoa
 1Gyo2Opol8OUoHuC7t0XZWCjm79fyiy68DCMPvU9uvvUfq/M9TNIcZiNjBumFAaxGnpg7uXuINp
 24iKxPzb/lYRfivw7Jr58Hx8Mw7G8Dh0dJhwDrb9csPkk8/WbKL+bZvR92cPDSWGGDAj7Ob70xQ
 a1lklBtKVMZ3NyGZqRJ3qG0R/gA9/78s5+i/LXyTtdAJSybZU6oqYWq1YFwpPSz44DL5F7DgJfj
 jLUTXkVfrQkRT5Q9+mXRjohYKARIAHFo4F3ysLsjafqhfMtdzd6hWPitYK9fteMyxyiQVcmcnk5
 HgOQf0YicYBg9EhQ/V1j2znpNvAzUKVTJfSaHghfH2sUikiaIKYszBqt4Pe0KDoxhxbHnkS4wxe
 qTh7qhjGweHUWtsO9lk7mhfa+BSv6v7iqk0dv9Q0INXpyUDjlgHbRop9FMsfBMaCqTZG5/IIjT+
 ZsBI99j3JL26aQOiSgpKjB7apkwr50gQZnNVeMGwffz238=
X-Received: by 2002:a05:701b:2908:b0:148:bc4a:8356 with SMTP id
 a92af1059eb24-1620665f667mr6754673c88.28.1791476875488; 
 Thu, 08 Oct 2026 09:27:55 -0700 (PDT)
Received: from fabio-X870-EAGLE-WIFI7..
 ([2804:1b3:a801:250d:7bc2:e4af:4b86:fbf3])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-16919bf46b5sm186556c88.5.2026.10.08.09.27.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 09:27:54 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.u-boot-project.org, elena.popa@nxp.com, hs@nabladev.com,
 mwalle@kernel.org
Subject: [GIT PULL] Please pull u-boot-imx-main-20261008
Date: Thu,  8 Oct 2026 13:27:50 -0300
Message-ID: <20261008162750.1076441-1-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Hi Tom,

Please pull from u-boot-imx/main, thanks.

The following changes since commit e1dcad5512b81009eaf7e472c20a8a15db8c4a0e:

  Azure: Switch u-boot-test-hooks to git.u-boot-project.org (2026-10-07 19:35:44 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-main-20261008

for you to fetch changes up to b1424814877c3f1e60bc35b2b3d501d1a24df8c0:

  board: nxp: add MR-NAVQ95 board support (2026-10-08 10:23:44 -0300)

u-boot-imx-main-20261008
------------------------

CI: https://git.u-boot-project.org/u-boot/custodians/u-boot-imx/-/pipelines/1499

- Add MR-NAVQ95 board support
- Run the CAAM RNG self test on affected i.MX6 chips
- Respect BINMAN_INDIRS for external files.
- Allow selecting the SRK table index.

----------------------------------------------------------------
Elena Popa (2):
      arm64: dts: freescale: add the MR-NAVQ95 DTS
      board: nxp: add MR-NAVQ95 board support

Heiko Schocher (2):
      crypto: fsl: run the CAAM RNG self test on affected i.MX6 chips
      imx: hab: name the event left behind by the boot ROM RNG self test

Michael Walle (1):
      binman: imx9image: respect BINMAN_INDIRS for external files

Stefan Bigler (1):
      binman: nxp_imx8mcst: allow selecting the SRK table index

 arch/arm/dts/imx95-navq-u-boot.dtsi                |   6 +
 arch/arm/dts/imx95-navq.dts                        | 228 +++++++++++++++++++++
 arch/arm/include/asm/arch-imx/cpu.h                |   2 +
 arch/arm/mach-imx/hab.c                            |  16 ++
 arch/arm/mach-imx/imx9/Kconfig                     |   8 +
 board/nxp/imx95_navq/Kconfig                       |  12 ++
 board/nxp/imx95_navq/MAINTAINERS                   |   6 +
 board/nxp/imx95_navq/Makefile                      |  11 +
 board/nxp/imx95_navq/imx95_navq.c                  |  24 +++
 board/nxp/imx95_navq/imx95_navq.env                |  94 +++++++++
 board/nxp/imx95_navq/spl.c                         |  82 ++++++++
 configs/imx6dl_mamoj_defconfig                     |   1 +
 configs/imx95_navq.config                          | 154 ++++++++++++++
 configs/imx95_navq_defconfig                       |   1 +
 doc/board/nxp/imx95_navq.rst                       | 117 +++++++++++
 doc/board/nxp/index.rst                            |   1 +
 doc/imx/habv4/guides/mx8m_spl_secure_boot.txt      |   2 +
 drivers/crypto/fsl/Kconfig                         |  22 ++
 drivers/crypto/fsl/Makefile                        |   1 +
 drivers/crypto/fsl/jr.c                            |   3 +
 drivers/crypto/fsl/jr.h                            |   1 +
 drivers/crypto/fsl/rng_self_test.c                 | 157 ++++++++++++++
 include/configs/imx95_navq.h                       |  22 ++
 tools/binman/etype/nxp_imx8mcst.py                 |   4 +
 tools/binman/etype/nxp_imx9image.py                |  22 +-
 tools/binman/ftest.py                              |  29 ++-
 .../binman/test/vendor/nxp_imx8_csf_srk_index.dts  |  27 +++
 tools/binman/test/vendor/nxp_imx95.dts             |   1 +
 28 files changed, 1041 insertions(+), 13 deletions(-)
 create mode 100644 arch/arm/dts/imx95-navq-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx95-navq.dts
 create mode 100644 board/nxp/imx95_navq/Kconfig
 create mode 100644 board/nxp/imx95_navq/MAINTAINERS
 create mode 100644 board/nxp/imx95_navq/Makefile
 create mode 100644 board/nxp/imx95_navq/imx95_navq.c
 create mode 100644 board/nxp/imx95_navq/imx95_navq.env
 create mode 100644 board/nxp/imx95_navq/spl.c
 create mode 100644 configs/imx95_navq.config
 create mode 100644 configs/imx95_navq_defconfig
 create mode 100644 doc/board/nxp/imx95_navq.rst
 create mode 100644 drivers/crypto/fsl/rng_self_test.c
 create mode 100644 include/configs/imx95_navq.h
 create mode 100644 tools/binman/test/vendor/nxp_imx8_csf_srk_index.dts
