Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD71DC67861
	for <u-boot@archiver.kernel.org>; Sat,  6 Apr 2024 14:02:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C327087F00;
	Sat,  6 Apr 2024 16:02:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="un9ZUU1A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 006A087F3A; Sat,  6 Apr 2024 16:02:21 +0200 (CEST)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94D0E87EA8
 for <u-boot@lists.denx.de>; Sat,  6 Apr 2024 16:02:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2d858501412so35763631fa.0
 for <u-boot@lists.denx.de>; Sat, 06 Apr 2024 07:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712412138; x=1713016938; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=128MPsUpnBMBJL7kWRT++tO9IWOd5ocVBD7CqfU2C40=;
 b=un9ZUU1ADNB61xaLh+6yNh5KxkbHKTvTYEEEzt0L098/tqNBFvgwSvsvRfSn7Wfzy/
 Ww16th5cSo/mEf0SZbrJqka0XOHm8dzPeAbtKuoCkdBm3kughvt01JjpcXjAuWKoUjvx
 NCwNER+bk/IvXNJ//X/oNbJ4KhVPt0jKiUc39i4aThJXJNlGCiavZ9FP6qsejw+Y8T2I
 PUZCNUcMhBtpvG18uSAT/S6bKbAQDHVm0cbnfzbMynjjeA0azx6eL9uFbrJYxZW81CmP
 leu9iMCPr2eO2s4+MaAAuXovHO3DJ9k3jBBtU6oz6TNRyIryuDzbheoLtuS/axPG+lEf
 iO1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712412138; x=1713016938;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=128MPsUpnBMBJL7kWRT++tO9IWOd5ocVBD7CqfU2C40=;
 b=NNzEsVCKniTjOsI6mOhT8klZj1Q59zWYCdfMQ/cNFOZ9JcouGI8PgPy6qWmI7yQrWZ
 sT/VwOPPk+2BPK3CS17QAZhOwxWFGXjgfMrr6xTE7KVSZ+9WEhJTCXfg1SjPcfXxRMfz
 x7UNGTHV5n2I96rtyiFlD/bh0sHfjbOwrqtXj9QDMURHhwBrJ1VgH7ChEu7slKtfC+aY
 e5TwXNR378CVU6HpoIdZ3kR5jcleekBJtVCfY6Bi+5SUOOSi109J/VVB98HJSmPUpyAZ
 8ytNjnGZFhy6/S2TwtKMsaN5bND/IYD5Ehj7A2aa3dGQrJ107McqzavSB4ZNVeqRY+XX
 BSYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6CrW4CPyaltSE50Q+EKOLuMbgNeM6YRuDKBwHFZ2QSaNMQmwbMx5yy2V+CkjGpwpjeciB/az2lL4LoxDMIrIF5q1Ftw==
X-Gm-Message-State: AOJu0Yzds358gjPKgl8sMBqb8MNIvhzSIr/JTwAe8hl48RB8p1Asegq/
 4ypvgoQYgrJF/+LRipKVIjVRomquW+AgrxEVAcC4T7vrrEUV4uKQuqOw5yT52SA=
X-Google-Smtp-Source: AGHT+IEnmTD1d1UwovMAzh0XRdzwdHweYKGXtvNFFZi3KiFR5PG7Pj0FOpWYxeW/k8KHkeK62NBXUQ==
X-Received: by 2002:a2e:bb85:0:b0:2d8:677a:8dcc with SMTP id
 y5-20020a2ebb85000000b002d8677a8dccmr2651608lje.47.1712412137671; 
 Sat, 06 Apr 2024 07:02:17 -0700 (PDT)
Received: from hades.. (ppp089210071137.access.hol.gr. [89.210.71.137])
 by smtp.gmail.com with ESMTPSA id
 j19-20020a05600c1c1300b004163de6cfabsm1729756wms.11.2024.04.06.07.02.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Apr 2024 07:02:17 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de,
	kettenis@openbsd.org
Cc: caleb.connolly@linaro.org, sumit.garg@linaro.org,
 quic_llindhol@quicinc.com, ardb@kernel.org, pbrobinson@gmail.com,
 pjones@redhat.com, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>, Bin Meng <bmeng@tinylab.org>,
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Eddie James <eajames@linux.ibm.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Weizhao Ouyang <o451686892@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v1 0/4] Enable SetvariableRT
Date: Sat,  6 Apr 2024 17:01:51 +0300
Message-Id: <20240406140203.248211-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.37.2
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

Hi all,

This is an updated version of [0].

When EFI variables are stored on file we don't allow SetVariableRT,
since the OS doesn't know how to access or write that file.  At the same
time keeping the U-Boot drivers alive in runtime sections and performing
writes from the firmware is dangerous -- if at all possible.

For GetVariableRT  we copy runtime variables in RAM and expose them to
the OS. Add a Kconfig option and provide SetVariableRT using the same
memory back end. The OS will be responsible for syncing the RAM contents
to the file, otherwise any changes made during runtime won't persist
reboots.

It's worth noting that the variable store format is defined in EBBR [1]
and authenticated variables are explicitly prohibited, since they have
to be stored on a medium that's tamper and rollback protected.

The original RFC was just enabling the memory back end. This is a more
complete version and we should be able, with small adjustments of
userspace tools, fix SetVariableRT. If enabled the firmware will add two
new RO EFI variables after ExitBootServices.

RTStorageVolatile -- contains the filename, relative to the ESP
VarToFile -- an EFI variable that holds all the BS,RT, NV variables and can
be copied to the file defined by RTStorageVolatile.

If any errors occur during the variable init, the firmware will delete them
and adjust the RT_PROP table accordingly, disabling SetvarRT.

- pre-patch
$~ mount | grep efiva
efivarfs on /sys/firmware/efi/efivars type efivarfs (ro,nosuid,nodev,noexec,relatime)

$~ efibootmgr -n 0001
Could not set BootNext: Read-only file system

- post-patch
$~ mount | grep efiva
efivarfs on /sys/firmware/efi/efivars type efivarfs (rw,nosuid,nodev,noexec,relatime)
, disabling SetvarRT.
$~ efibootmgr -n 0001
BootNext: 0001
BootCurrent: 0000
BootOrder: 0000,0001
Boot0000* debian        HD(1,GPT,bdae5610-3331-4e4d-9466-acb5caf0b4a6,0x800,0x100000)/File(EFI\debian\grubaa64.efi)
Boot0001* virtio 0      VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,0000000000000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,850000001f000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,1600850000000000){auto_created_boot_option}

$~ efivar -p -n 8be4df61-93ca-11d2-aa0d-00e098032b8c-BootNext
GUID: 8be4df61-93ca-11d2-aa0d-00e098032b8c
Name: "BootNext"
Attributes:
        Non-Volatile
        Boot Service Access
        Runtime Service Access
Value:
00000000  01 00

[0] https://lore.kernel.org/u-boot/20240329071929.2461441-1-ilias.apalodimas@linaro.org/
[1] https://arm-software.github.io/ebbr/index.html#document-chapter5-variable-storage

Changes since the RFC:
- Return EFI_INVALID_PARAM if attributes are not volatile
- Add EFI_WRITE_PROTECTED checks for BS, RT *only* variables
- Add 2 EFI variables and allow userspace to write the file
- Add selftests

Ilias Apalodimas (4):
  efi_loader: conditionally enable SetvariableRT
  efi_loader: Add OS notifications for SetVariableRT in RAM
  efi_loader: add an EFI variable with the variable file contents
  efi_selftest: add tests for setvariableRT

 include/efi_loader.h                          |   4 +
 include/efi_variable.h                        |  15 +-
 lib/efi_loader/Kconfig                        |  16 ++
 lib/efi_loader/efi_boottime.c                 |   2 +
 lib/efi_loader/efi_runtime.c                  |   1 +
 lib/efi_loader/efi_var_common.c               |  43 ++--
 lib/efi_loader/efi_var_file.c                 |   1 -
 lib/efi_loader/efi_var_mem.c                  |  90 +++-----
 lib/efi_loader/efi_variable.c                 | 210 +++++++++++++++++-
 lib/efi_loader/efi_variable_tee.c             |   1 -
 .../efi_selftest_variables_runtime.c          | 116 +++++++++-
 11 files changed, 401 insertions(+), 98 deletions(-)

--
2.37.2

