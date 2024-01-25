Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 698BBC47422
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 15:54:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 675878783B;
	Thu, 25 Jan 2024 16:54:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="EvSjdDBb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEEC28785A; Thu, 25 Jan 2024 16:54:51 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA1FA877BC
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 16:54:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D35CD404A5
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 15:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1706198088;
 bh=jGcJcjPdErD1nDhA76P64BoqkaCrwD1NyMvuzTpgjtQ=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=EvSjdDBbGv+/f21KJ4249YHuWosH6r2tfS7Z6tgyiQ64vkfITXkPltwh3PaHLWC2F
 6EjbEyBF6j4+yaZNWrAqTXeWNdcLXclKrsStdmK3dx/fiWZqzMlnFeHZt3UZlP4ugs
 XRKbT+8EB+cwX86bGoKrNTaD9ldS5YJ6akzuTn/Lbl5QykiBMwFanufVhmlmba5EzW
 XNWqvLf2nEUnANYinj4uR8/AFgeyRzQnX556kzaekV4NHHCAdd6x3WfC6w9kmsIwya
 G8g2awjjWDUsGJBrEXrnfl2ynUImKNactJ8MfVA42axp3iXfHGm1WgI0HxhuYSlTeW
 MOT3u2S7Sx0Ug==
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-337d988a508so3348505f8f.3
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 07:54:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706198088; x=1706802888;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jGcJcjPdErD1nDhA76P64BoqkaCrwD1NyMvuzTpgjtQ=;
 b=kwXbqpZJjXl+sIqPFxo9yrtxIbzXeQkLU46TxHejVoniyTDMEBE+NybH/VfJDQw9z0
 x3e+JQnXm4smlDaGYMWF4I0fjKIbMcn/ovPvt+kkBqr9dpUpvVBLyC71aH4oHdFHgwxB
 lTbX71MEDqxj1nTqgFYWJ/UmfakRrSk4VWvp8SrIED43ezazYx6OvPDjnYz6xdruOgDz
 9343pHaYOfatHsDdAJ4kS6MIe8Mhwe3V+Nw87BVM67ErIIC+vbWMvdtAx/v0bNrr1b+g
 N2W/GG2YwVWqvyK5mVLj5Wsw9gBAt9XXuatAGnvBZz14NmRP4FKgvLzVKZxLpBouum9/
 c9cA==
X-Gm-Message-State: AOJu0YyBB21JpNaNljXA70d9kGZx7Rm0s7DPVqPrzJs8qAZXZajOV3e7
 8wyedIql4FgDzeo75xXNyBAnM7MuRzqDmvNIUP7d3wZhsVD1EytM7mJFJ/6vXj+EVrOyjtrtrJx
 qhVhgRMGQIPvJVXmHxP34ytWXZWDzJ0Ny0QhBaiv6Gu2+8oI5SkaGvykJOj3lSpLWFq8=
X-Received: by 2002:a5d:4c4c:0:b0:337:7096:f54c with SMTP id
 n12-20020a5d4c4c000000b003377096f54cmr685315wrt.125.1706198088384; 
 Thu, 25 Jan 2024 07:54:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFph1LtzKaKcM0rDriXiDrq/41rASwvRg8yznvxmLt0mPvDpx4q7CF9/cVON0gLoaV4uexstA==
X-Received: by 2002:a5d:4c4c:0:b0:337:7096:f54c with SMTP id
 n12-20020a5d4c4c000000b003377096f54cmr685305wrt.125.1706198087994; 
 Thu, 25 Jan 2024 07:54:47 -0800 (PST)
Received: from workstation5.fritz.box
 (ip-178-202-040-247.um47.pools.vodafone-ip.de. [178.202.40.247])
 by smtp.gmail.com with ESMTPSA id
 c16-20020a5d4f10000000b003393592ef8dsm10557471wru.54.2024.01.25.07.54.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 07:54:47 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 0/6] cmd: provide command to display SMBIOS information
Date: Thu, 25 Jan 2024 16:54:32 +0100
Message-ID: <20240125155438.47617-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
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

U-Boot may supply an SMBIOS table or they may be copied from QEMU.

Provide a command to display the SMBIOS information.

Currently only type 1 and 2 are translated to human readable text.
Other types may be added later. Currently only a hexdump and the list of
strings is provided for these.

The following prerequisite had to be fixed:

* The definition of SMBIOS type 2 lacked a field.

v3:
	enable smbios command only on sandbox and qemu_arm64_defconfig
v2:
	for generic boards we only can assume that a type 127 table exists
	email address updated

Heinrich Schuchardt (6):
  smbios: type2: contained object handles
  cmd: provide command to display SMBIOS information
  doc: man-page for smbios command
  test: unit test for smbios command
  configs: enable smbios command on sandbox
  configs: enable smbios command on qemu_arm64_defconfig

 cmd/Kconfig                  |   6 ++
 cmd/Makefile                 |   1 +
 cmd/smbios.c                 | 191 +++++++++++++++++++++++++++++++++++
 configs/qemu_arm64_defconfig |   1 +
 configs/sandbox_defconfig    |   1 +
 doc/usage/cmd/smbios.rst     |  93 +++++++++++++++++
 doc/usage/index.rst          |   1 +
 include/smbios.h             |   1 +
 test/py/tests/test_smbios.py |  41 ++++++++
 9 files changed, 336 insertions(+)
 create mode 100644 cmd/smbios.c
 create mode 100644 doc/usage/cmd/smbios.rst
 create mode 100644 test/py/tests/test_smbios.py

-- 
2.43.0

