Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B1CC9830D
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 02:56:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9642240DFD;
	Thu, 24 Sep 2026 02:56:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v9_1acaBqRZD; Thu, 24 Sep 2026 02:56:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org BDF7140DBB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790218563;
	b=VngP5h7YOyDD6EQaAcDGPEX+CdI6DgHNHxLlgyrirn1NgWQzfswQH9126CZQQpJi1NYH
	 +BCSVjU+Ec/TbZdLko1tYrtxzKkQ0HaC+Ri9lB2MkkXFAqv47VeLY4R18WG87rI4agT2f
	 omPvsTdDhG9b6RFw/IyY/ElzirUoiAjQfoER65HS2Xerm33jc8MofeiuUxkUKLSP8JpJz
	 oWA26DjGgJMiYtgqyuX4AyFoYB3gG2WQJBOWsjnqx/XbQTdiAmjyTupJuPG5DU6JhNvRm
	 L4sp9Bm9ExoA/OAP+4QEcGtZ9J2w61Aot/J1kJ9+tqMjUGm7ExOgOzhzuJaMbP7tr8w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790218563;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=X4DqjjqZg1GKClzaXINzwSDydN/QRH0CwfphCDIVVGM=;
	b=SfHuqWiL+zkb1ZIruTfB/UBiZiAkLWFC/scPr08mCXvb7E/NiYxQoXzvhcTLiEuolCtP
	 1gdK4xITOvbYWx6Ar/0ldmS8b6sTx12wix8Zbw3oPXzyiHDfBrSRzXn2zCzWijTiEvMez
	 q3Co0UCJa1owxP6kAMywSzDDJdpAhDfpvSRcjDMLO9lAnW+hIPMvva+sGk6TT9DwVwrms
	 rxZdUWHxPUuNA67wX2bzimH/dwzsxpY0YIka5HL4vfgOa4mTnl2ujjackZLpk935Osbor
	 nDS6qH7qV9w1gbn06yGQpGoP3C5pfOghr+6YeE7Or23Bm4bSyVrhWfNWR8e15NP5jhA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="a/yuMN+K";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790218563;
	bh=X4DqjjqZg1GKClzaXINzwSDydN/QRH0CwfphCDIVVGM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=CRp9x6UMRAEC3GtLTmnZuGVArpoWJ3dxYToMF+RuTBJ6cnSdaUzIKesS867vMfUUF
	 Z0tB9OjxcIqMLBjV5gGP9XYxYYgJ+aLfJ+RzMtLbhb8MKUgIDVmuwMEJgfw+OB83Hw
	 1kYknESvGSABuL62Ba61Vw9Z2r0WApfkF2ay/Hohqaxx4Ks19HR54zxqyg78dHRTqu
	 C0mcEAkeMQcmLYyiJMCfHaStqJNbx58W/yUlK6at6WWbkq2u0f+FO8wpUP38QXfdu7
	 bnA5C8Mfxn5TVurnAp2AS+L20PrjNxXvxW5/Ug1fxsR+qj2wOWZ5uVEZC/0solkqm2
	 CYZs3hwc9gJHA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BDF7140DBB;
	Thu, 24 Sep 2026 02:56:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CD20C3A9
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 21:40:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B318C414F5
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 21:40:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BB9Nyo-k3iwo for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 21:40:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9E441414F4
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::1b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790199645;
 b=TVPv1AhUSsTCfdV+4mmUt+E23lMkEJduSxfiQr8w0ZVWcz5DvRS4aCpbU7lAnombis17
 0GaYl9EJTqsvbLWCTvgwQMPKseWmoevYMQbi6IPLKxrmVv5bPqf6WikdVTssnrPeZFTMC
 mhx+2TbjFj+YNzrkWxyF8byveAszvLJdkHZWgBFC7al2wecIg6xJw95dMT8AYtXL7W599
 GFCdbK8wupqNJgSIurnN9IT2t/Oh0KBg6Etrpk7uz71SNxC9LdrVgQNBDO3LhLUK0ERji
 c3XCyXMxnSvhf+Hhf5aish7buzNnHi41mxISeD0cQuosthFP3Jln0JAbTKBNC05Avkg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790199645;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=X4DqjjqZg1GKClzaXINzwSDydN/QRH0CwfphCDIVVGM=;
 b=hLFJkYQKon74xyDcS5/eobIN6QJoY9EKJJBynswa+k0N1M68EmUHn/zF6ME/zo2ulYsX
 mH/A6svTwYWya5YMOah4aOqeqPalA4SIBYx/9U1VL8izk5WLPAsmvuAMSO0F6Yx7eTTik
 7m8W9GzyMk8mOU+37tPCTOPhPq+lEYsYEkVTCCSEGF0biemWM3nMlqFfZFqqW9W+dRcXS
 xZaOaAmYAT+NNREbqt2vtWha+QuxS80e1v67+GSlVD1BFyr8QpeGsaW16VivCQE3ET9tL
 veC7+Pkw2sv34dX7e8XMT4lHYyHMzZyQSWksVoGMI09Y+Bo0USGKQfuIC17Z4GZuq3g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="a/yuMN+K"; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::1b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::1b; helo=mail-wr2-x1b.google.com;
 envelope-from=joaofl@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=a/yuMN+K
Received: from mail-wr2-x1b.google.com (mail-wr2-x1b.google.com
 [IPv6:2a00:1450:4864:30::1b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9E441414F4
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 21:40:44 +0000 (UTC)
Received: by mail-wr2-x1b.google.com with SMTP id
 ffacd0b85a97d-482f633ecdeso1153985f8f.2
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 14:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790199642; x=1790804442;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=X4DqjjqZg1GKClzaXINzwSDydN/QRH0CwfphCDIVVGM=;
 b=a/yuMN+KGPMwJAgZd6EW7gVUiTaRKtCp+EOiiNfjgjvualEb7D2yvCAs7ps1ZAORF9
 XuN3xJYSTfnY9cCVgMaGU82g9uLZHzd/UUy1mlnCgYmE7hFpcmD8lCAR9mhJ5HJUHzQt
 yQp+0NgxSvKAjh+qjM++pPze3Nw3aiZIxzd9JYfB5e/jrsoCnmkPKB4fVyLXBqjWuAF1
 1AscLc6toOLfbIsCeAA3CShdQJu3lRA+7RXDb8b7lJKXS0G562HbvEwEhawMg6jM3AJ8
 JUWzkLWY6vm5met7HCxQGNkCJu/MrZ35HyvvgqH34kT54Jra4lcJrTMfVdamnLbO6zTo
 YbiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790199642; x=1790804442;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=X4DqjjqZg1GKClzaXINzwSDydN/QRH0CwfphCDIVVGM=;
 b=HXv2WDAkjHhgQkWFPfwTECFtDUSb6g2o+foRLLha/ff36QTw64YuENNTiuKHtcCG2S
 6lCLow5qKB8mcASVBnpTiE7PlBRpc/iOE7s5JUIblvqNQHru1vKlpym80SGxPxhLTK8/
 WfypS+NZQrMVfsOV55V09DSXd3QPxYXKnsa0vsZogoP6opzN1ndBNfrouG9FUwoWk7CC
 Fu/SB8mXO+KDoI5zgk9yBbVIDUW5kSAUK+GZGTU3xiQv2QSqiYvaKzesQC4cuZm7b1uJ
 2bvn5aEdGn8SAeLNDlXxwr3eWFdiBb+JFDR17zwAOoC6qjEttD7gAGe6JFonxUlY/yG2
 4Bmg==
X-Gm-Message-State: AFuF++mY15kVUzbDG6z5j6XdhDXNjjBxp66dzHlaRfGhorwj0LmPhIML
 qGFFX7szxPzDBXZUYWDU8Q8tmm7AFfIuJR/jykFyvBvhxVGdYHlsdJSN/5xnsrBOF2c=
X-Gm-Gg: AYBFou0MB7XhTfyZbD3BAFOOXuKUQcyTQ0xLc2Zhbz6eBGhmcSXQmKd1xnrET3NeK9t
 kb/DXd3rfHRpcNtl4nQfxT88pVSm21BQl3SVofs9u565N85fAX3Rk6KtCtteLID87pVGAQoqXck
 Xx7bDaZMi31HxLPOJnOFLorlbaR01q9L1sFeqlT9SObRRMs4iIEQ/xJ2ydvmKAYLDAhK1MXukiJ
 7xMdBnjzGmoskb93mYVi301GhFVd8Cvuz1+jd5eDWmuqqGyKmpl/jDkOwlbjzDRYYWCCswoijQ0
 bgRwah2tVcTJA0ZjfMGsl6FLYNakrchjjbAAuSIZYhCI/L0OZRJ5kgbpuotSiUX9TsoIqB1ySbS
 ZTVO+Y/G0YkYDF1saHxDO64Q2E6dCRydS38s1JoRbcQCwSNHNnYVfObXkf/nqkDC8gNMmraMR1W
 XdGwwUjAvJujC7fmLgVmA1adOe9ykCKyO4fo9LAf8fKyxnMIcVIillnjJdohfcGaVbYDuyReRKx
 TstLP4KHvxeIT6QScOIy9IFB7Ie1Lo0/Os/M/5s5U1P0vP5fXmlzzPH+NI=
X-Received: by 2002:a05:6000:40dc:b0:487:ff2:12f4 with SMTP id
 ffacd0b85a97d-488717781c4mr657412f8f.40.1790199642415; 
 Wed, 23 Sep 2026 14:40:42 -0700 (PDT)
Received: from rrouwprlc0373.. ([81.172.79.249])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4886876c119sm10309950f8f.15.2026.09.23.14.40.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 14:40:41 -0700 (PDT)
From: =?UTF-8?q?Jo=C3=A3o=20Loureiro?= <joaofl@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, sjg@chromium.org,
 =?UTF-8?q?Jo=C3=A3o=20Loureiro?= <joaofl@gmail.com>
Subject: [PATCH v6 0/3] spi: Introduce driver-model support for SPI EEPROMs
Date: Wed, 23 Sep 2026 23:40:27 +0200
Message-ID: <cover.1790198142.git.joaofl@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 24 Sep 2026 02:56:02 +0000
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

This series adds a UCLASS_SPI_EEPROM uclass, a driver for AT25-style
parts, a sandbox emulator and a DM test.

v6 is a resend that fixes two problems with v5, and makes no other
functional change.

Tom reported that v5 broke the sandbox_vpl CI job. Patch 3 added the
sandbox SPI EEPROM emulator to drivers/misc/Makefile with
obj-$(CONFIG_SANDBOX), which is not phase-aware, so the emulator was
also linked into TPL, VPL and SPL. With it in the image, sandbox_vpl
stops right after "Trying to boot from sandbox_file", and the CI log
shows nothing useful. The emulator now sits in the existing
"ifndef CONFIG_XPL_BUILD" block next to the other sandbox emulators,
as i2c_eeprom_emul.o does. The "vpl or test_spl" test.py selection
used by the sandbox_vpl CI job fails 12 tests with v5 applied on
v2026.10-rc5 and passes all 12 with v6.

Simon pointed out that v5 was threaded wrongly on patchwork. I had
sent it with --in-reply-to pointing at the v4 cover letter, so the
patches ended up in the old thread. v6 is a fresh thread with all
three patches replying to this cover letter.

Testing on sandbox: "ut dm" gives the same set of failures as
unpatched v2026.10-rc5 here (all environment/fixture related), and the
new spi_eeprom test passes along with spi_flash. The sandbox_vpl
test.py selection passes, as above.

Changes in v6:
- Patch 3: build the sandbox SPI EEPROM emulator only in U-Boot
  proper (not in TPL/VPL/SPL), fixing the sandbox_vpl CI failure.
- Resent as a new, correctly threaded series.

Changes in v5:
- New patch 1: test/dm/sf.c now asks for the emulator attached to its
  own slave rather than the first one in UCLASS_SPI_EMUL, fixing a
  heap corruption once a second SPI emulator exists.
- Patch 2 commit message reworded: imperative mood, "driver model"
  rather than "driver mode", and it now explains the motivation.
- SPI_EEPROM_CMD_SIZE removed. Address length is an addr_len field in
  driver data, overridable from the device tree, so 8-, 16- and 24-bit
  addressed parts are handled.
- AT25_CMD_* opcodes moved to a private header,
  drivers/misc/spi_eeprom_priv.h.
- Read path no longer computes "offset + size"; probe() rejects a
  "size" that does not fit the configured address width.
- of_to_plat() dropped; geometry read in probe().
- "size", "pagesize" and "address-width" follow the in-tree atmel,at25
  binding (dts/upstream/Bindings/eeprom/at25.yaml).
- Compatible list taken from that binding, plus the "atmel,at25"
  fallback.
- Kconfig: "depends on MISC" dropped, help text expanded.
- include/spi_eeprom.h converted to kerneldoc.
- Sandbox EEPROM node in test.dts follows the binding.

Changes in v4:
- Emulator frees its backing store in a remove() method.
- Full kerneldoc for sandbox_spi_emul_get().

Changes in v3:
- Reindented with tabs; the series is now checkpatch-clean.
- Dropped the no-op write stub in favour of returning -ENOSYS.
- Removed dead code, fixed the read bounds check, corrected the
  AT25160 geometry, switched to u8 types and added a MAINTAINERS entry.
- Added the sandbox emulator and the DM test.

João Loureiro (3):
  test: dm: sf: Get the emulator attached to the flash slave
  spi: Introduce initial driver-model support for SPI EEPROMs
  sandbox: spi: Add SPI EEPROM emulator and DM test

 MAINTAINERS                    |   9 ++
 arch/sandbox/dts/test.dts      |  16 +-
 configs/sandbox_defconfig      |   1 +
 drivers/misc/Kconfig           |  15 ++
 drivers/misc/Makefile          |   2 +
 drivers/misc/spi_eeprom.c      | 267 +++++++++++++++++++++++++++++++++
 drivers/misc/spi_eeprom_emul.c | 130 ++++++++++++++++
 drivers/misc/spi_eeprom_priv.h |  18 +++
 drivers/spi/sandbox_spi.c      |  37 ++++-
 include/dm/uclass-id.h         |   1 +
 include/spi_eeprom.h           |  95 ++++++++++++
 test/dm/Makefile               |   1 +
 test/dm/sf.c                   |   9 +-
 test/dm/spi_eeprom.c           |  46 ++++++
 14 files changed, 643 insertions(+), 4 deletions(-)
 create mode 100644 drivers/misc/spi_eeprom.c
 create mode 100644 drivers/misc/spi_eeprom_emul.c
 create mode 100644 drivers/misc/spi_eeprom_priv.h
 create mode 100644 include/spi_eeprom.h
 create mode 100644 test/dm/spi_eeprom.c


base-commit: a06e89ab05eaa2b8344d521319399333cd760ae5
-- 
2.43.0

