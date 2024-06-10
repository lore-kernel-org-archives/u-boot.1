Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1693EC27C5F
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 09:11:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6065A8843F;
	Mon, 10 Jun 2024 11:11:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Nj10usI3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7A77884A9; Mon, 10 Jun 2024 11:11:07 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4C15883F2
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 11:11:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A30943F722
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 09:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1718010663;
 bh=DSWicmw9JdU0vmKNFwEARBopNhyu1Y1MUUbuT2b9oA4=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=Nj10usI38YwQp4KdPCTohvWPQWJmWApPjmqbEmLosbKz/JTL4cSLgzhNi9Jye9ATo
 mBGhRcpcm0hbsc2V0QkSJYyk8Z8H0s5Z/7fkefxGdcYv39SjzvObDv1ZcJnrWpnjgu
 9nsXnQg3eufIZS2njaPAk2LybeWzhtuGIEiw5JDvBXZ+HLUQiQy7cp+gKGevt+ZPsy
 81gEMspSMCpjaSNgd6ks7HoU9hsHrmSCt/2FRt6YaFTNObY2DHpQKo9HAuC12shZsA
 mZb7Ey/M3p/ibghFLGieWMJWH3BrmZkB2+NKjXy0LxZjeTjpkifzosH0xXmjrYrhBg
 Kk80YWP8eFcqg==
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-52c893408b5so592928e87.2
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 02:11:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718010662; x=1718615462;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DSWicmw9JdU0vmKNFwEARBopNhyu1Y1MUUbuT2b9oA4=;
 b=raJ3qWlXVxPkubXgxbwH2kgwGJNFkfX2wDh3fSSSRMbVDyW0/KjSyo9xr0/pZxQ90W
 40RR4ehnqn/2jUSyS/0yZm3vxFGygdWbmA0vfKXd+4T8vHGudlJMH4cjrs+s5SUmZPqx
 yTH7mOPuyRpDsJfExRrJtqxJLGKoh8eIvNAxvM+1JpYGLi6MdO6TlirwQr8EOdb2c4Hz
 czgGpWFsRlzX2HITLFe3Iiz2uW4qnZJDv8SaW22ooaKjyunAk6kBbC+rhkoqq/4AfvOf
 k1OsxAbisZ5Dgqk7ry6XLx/cLd8ZpwuJSnF0NsKqAgMzLh1BdW58b3EwSInOvWUqSQPG
 ntlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHD8As5pKwd/Wtv0/UinCmCPph2BhocV3Rx31AwLiaKouWyOpheREA2NxBYGw6T2inJmWEwobQA7qEZ+uIkjRuf3nehQ==
X-Gm-Message-State: AOJu0Yw5lEQvbGQ0leqcICCnTn4ikEOKpMz5IElvh4vVXs0vL5PNOK9p
 RnW/HISWWgTYDZaHzUuVoenfmWdM92pxJSnhl11KR/FnTTjrKbOaADXeNnPK9sp1Qx8tPvvAvEN
 AJIJSMACK3gZGte4WWITWrNdRz0uGNNdqAEXg+8Iphfzk2ZFyflwVk+qnvbWvN2JSM6Y=
X-Received: by 2002:a2e:86cb:0:b0:2d4:50b2:62e9 with SMTP id
 38308e7fff4ca-2eadce34f1fmr58317221fa.14.1718010662661; 
 Mon, 10 Jun 2024 02:11:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9wB63I4x6fxRUusWAW1Bbbm1/VaHFl+LgnVmk0HmnHywDF6bXRpFDZfU9h0F83rfiqzueWQ==
X-Received: by 2002:a2e:86cb:0:b0:2d4:50b2:62e9 with SMTP id
 38308e7fff4ca-2eadce34f1fmr58316981fa.14.1718010662162; 
 Mon, 10 Jun 2024 02:11:02 -0700 (PDT)
Received: from workstation5.. ([2a00:20:43:88b5:6b2b:e162:4c45:5c4c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42183c08f49sm41059465e9.6.2024.06.10.02.11.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 02:11:01 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Shantur Rathore <i@shantur.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Bin Meng <bmeng@tinylab.org>, Mark Kettenis <kettenis@openbsd.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 0/9] efi_loader: improve device-tree loading
Date: Mon, 10 Jun 2024 11:10:48 +0200
Message-ID: <20240610091057.64463-1-heinrich.schuchardt@canonical.com>
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

In U-Boot EFI boot options can already specify both an EFI binary and
an initrd. With this series we can additionally define the matching
device-tree to be loaded in the boot option.

With the last patch the boot manager will fall back the device-tree
specified by $fdtfile in directories '/dtb/', '/', or '/dtb/current/'
on the boot device if no device-tree is specified in the boot
option or via a bootefi command parameter.

v3:
	Add missing '@' in EFI_LP_DP_PART_FDT description.
	Use calloc() instead of malloc() in load_fdt_from_load_option().
	Add missing '@' in load_fdt_from_load_option function description
	Rename struct efi_initrd_dp to efi_lo_dp_prefix.

v2:
	Update efi_dp_concat() instead of new function efi_dp_merge().
	Carve out a function efi_load_option_dp_join() which we can
	use both for the eficonfig and the efidebug command.
	Rename variables id_dp, final_dp_size.
	Rename create_initrd_dp() to create_lo_dp_part().
	Use enum as parameter for create_lo_dp_part().
	Put all related changes into one patch.

Heinrich Schuchardt (8):
  efi_loader: allow concatenation with contained end node
  cmd: eficonfig: add support for setting fdt
  cmd: efidebug: add support for setting fdt
  efi_loader: load device-tree specified in boot option
  efi_loader: move distro_efi_get_fdt_name()
  efi_loader: return binary from efi_dp_from_lo()
  efi_loader: export efi_load_image_from_path
  efi_loader: load distro dtb in bootmgr

 boot/bootmeth_efi.c                        |  60 +---------
 cmd/eficonfig.c                            |  83 +++++++++----
 cmd/efidebug.c                             | 130 +++++++++++++++------
 include/efi_loader.h                       |  24 +++-
 lib/efi_loader/Makefile                    |   1 +
 lib/efi_loader/efi_bootbin.c               |   2 +-
 lib/efi_loader/efi_bootmgr.c               |  75 +++++++++++-
 lib/efi_loader/efi_boottime.c              |   3 +-
 lib/efi_loader/efi_device_path.c           |  40 ++++---
 lib/efi_loader/efi_device_path_utilities.c |   2 +-
 lib/efi_loader/efi_fdt.c                   | 117 +++++++++++++++++++
 lib/efi_loader/efi_helper.c                |  44 +++++++
 12 files changed, 445 insertions(+), 136 deletions(-)
 create mode 100644 lib/efi_loader/efi_fdt.c

-- 
2.43.0

