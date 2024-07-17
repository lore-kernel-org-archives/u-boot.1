Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEDF9C3DA4B
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 08:31:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3492388701;
	Wed, 17 Jul 2024 10:31:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Kclp9S7t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2643088A2A; Wed, 17 Jul 2024 10:31:17 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 135F18841D
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 10:31:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-367b8a60b60so3611798f8f.2
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 01:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721205074; x=1721809874; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/ocTnmw0SK6ENImHbH5Yh414L7kxhVBNp6y5PLDQDuY=;
 b=Kclp9S7tABdby5PKTLJ48I19AUHa7M8cmGwuaqWkivw/8u7vRdusSWqqdDAUwvUJF2
 Q8D0jii0ytBbWieSdmzY+ARRxP5duVFPCK3268Eo9B/N2Pz4LTt6DYccNnjE0L2ay7l8
 Ymani58UYJyBObZOZg/FubdcssK3xrX8YS+GE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721205074; x=1721809874;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/ocTnmw0SK6ENImHbH5Yh414L7kxhVBNp6y5PLDQDuY=;
 b=ZmytLkNCpUQbWIMMsfpPV54oJiksnTSzJAw7/LV4XXMJbJmQoQrC10YeugWVvKOHPF
 zjMwdtCQJzInumdxyXK77mWQPnPEeGBfzO4yCfSJFoYQC6pgPgeW/j0xJdlN0x3qAJRn
 zTaYc+UZHW6gvVRirf04GqscSclqocJRpN/D9+RvzL9Wp/9vc/jKT7k6kgs/TUDW3+p+
 sfZZgKCkcMD84xYuHARkTucm+f4hKUoxlE07DqFpNgszEt5GwwscQW6i5025vjTL/0td
 z8HSl+eHRQwB2VMVMRznGJ3b67jA58mm3FDT471u/yBGAaVVtHsMWiGy6anPVTdQAjGn
 Y6nA==
X-Gm-Message-State: AOJu0YxbiGAVU3yxGdLJ85SLuXTfP4UtNDhfBOcYNXAQhUtjfdCw8rHg
 tgBpIxmo4oHPX6Fru6KNtjfI8L1IJ8M5ieqjfjw3JvcXijFReb9NMU8KYudJo6aDAFwBECIltSg
 =
X-Google-Smtp-Source: AGHT+IGF2cKOhDeAwtcZ7k/YFUvn7xprAIS5YDTkq9AOjmMkGhtJ7TcRoOeEkgGT/pCsO0m93gzIKA==
X-Received: by 2002:a05:6000:1f8a:b0:368:3f6a:1de8 with SMTP id
 ffacd0b85a97d-3683f6a1fd3mr46894f8f.11.1721205074119; 
 Wed, 17 Jul 2024 01:31:14 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dafbb5bsm11069930f8f.80.2024.07.17.01.31.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 01:31:13 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 00/14] doc: Add documentation for bootmeths
Date: Wed, 17 Jul 2024 09:30:50 +0100
Message-Id: <20240717083104.1963431-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This series adds some documentation about most of the bootmeths and
tidies up a few minor areas.

It also fixes a bug in network-based booting of a script.

Changes in v3:
- Drop extra 'and'
- Fix EENOTSUPP typo and add quotes
- Link to pxelinux from extlinux
- Quote the %U
- Quote the list
- Use quoting on function names
- Use quoting on list and function names

Changes in v2:
- Add new patch to mention automatic binding of bootmeths
- Adjustments from Heinrich's comments

Simon Glass (14):
  MAINTAINERS: Rename BOOTDEVICE
  doc: Move bootstd into its own directory
  doc: Mention automatic binding of bootmeths
  doc: Add a description for bootmeth_extlinux
  doc: Add a description for bootmeth_pxe
  doc: Add a description for bootmeth_qfw
  doc: Add a description for bootmeth_cros
  doc: Add a description for bootmeth_sandbox
  bootstd: Tidy up comments on the boothmeth drivers
  bootstd: Correct handling of script from network
  doc: Add a description for bootmeth_script
  doc: Add a link to VBE from the bootstd docs
  boot: Correct indentation in efi bootmeth
  doc: Describe the bootstd settings

 MAINTAINERS                                   |  4 +-
 boot/bootmeth_efi.c                           |  3 +-
 boot/bootmeth_extlinux.c                      |  2 +-
 boot/bootmeth_qfw.c                           |  2 +-
 boot/bootmeth_sandbox.c                       |  2 +-
 boot/bootmeth_script.c                        | 53 +++++++++++--------
 doc/board/starfive/milk-v_mars_cm.rst         |  2 +-
 doc/develop/board_best_practices.rst          |  2 +-
 doc/develop/bootstd/cros.rst                  | 33 ++++++++++++
 doc/develop/bootstd/extlinux.rst              | 29 ++++++++++
 doc/develop/bootstd/index.rst                 | 15 ++++++
 .../{bootstd.rst => bootstd/overview.rst}     | 43 ++++++++++-----
 doc/develop/bootstd/pxelinux.rst              | 27 ++++++++++
 doc/develop/bootstd/qfw.rst                   | 20 +++++++
 doc/develop/bootstd/sandbox.rst               | 17 ++++++
 doc/develop/bootstd/script.rst                | 52 ++++++++++++++++++
 doc/develop/index.rst                         |  2 +-
 doc/usage/cmd/bootdev.rst                     |  2 +-
 doc/usage/cmd/bootflow.rst                    |  2 +-
 doc/usage/cmd/bootmeth.rst                    |  2 +-
 doc/usage/environment.rst                     |  2 +-
 21 files changed, 270 insertions(+), 46 deletions(-)
 create mode 100644 doc/develop/bootstd/cros.rst
 create mode 100644 doc/develop/bootstd/extlinux.rst
 create mode 100644 doc/develop/bootstd/index.rst
 rename doc/develop/{bootstd.rst => bootstd/overview.rst} (95%)
 create mode 100644 doc/develop/bootstd/pxelinux.rst
 create mode 100644 doc/develop/bootstd/qfw.rst
 create mode 100644 doc/develop/bootstd/sandbox.rst
 create mode 100644 doc/develop/bootstd/script.rst

-- 
2.34.1

