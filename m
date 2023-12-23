Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 131F3C46CD2
	for <u-boot@archiver.kernel.org>; Sat, 23 Dec 2023 01:04:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47E7B869F7;
	Sat, 23 Dec 2023 02:04:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="fAB0JG+V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 647728753D; Sat, 23 Dec 2023 02:03:58 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E2A08646E
 for <u-boot@lists.denx.de>; Sat, 23 Dec 2023 02:03:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1703293430; x=1703898230; i=xypron.glpk@gmx.de;
 bh=iMdIailWBqKvUth1Fh4xN6yeSkiUWJI8s1cPvu2eg1E=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=fAB0JG+VQZd+ZkhR8stQ3dZgrPw7m5ybSooiHLf2SXYiHkCW0SLyNQYEEzV62LYC
 GWvqa/oxuy7aeE3rkW/APjKWDCzFKXLphUWDLfkaJ+iE6KJHu6gIJkVOqEPZAMJVW
 Q0KO3EtLOzsLmPmFD/WDFG/7tey1jzMES1IZAPoLan1Aodj002RY3b9NRiniP/9kn
 fObCq8DWz81O8vcBsmzcCKErOK+lF+VnjeyQHp1KXZJ1kgPjiy7pqCPP8uBQTqtOu
 w7V4jiJR0BJCgSfuriAR58kgpyvQ/pa3+0rTFZsfPRA7dvdfmLlIRoV0Txo4Wdl4j
 rbLk9avqwb1vZStJ3A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from x13s.fritz.box ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McpJq-1qhEhA0HcA-00ZtMP; Sat, 23
 Dec 2023 02:03:50 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v2 0/2] smbios: copy QEMU tables
Date: Sat, 23 Dec 2023 02:03:32 +0100
Message-ID: <20231223010334.248291-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:g/Cb5zTFXwYpmzdyG19KeshlKETaDKJzlWQW7ZF26RNf6EWVkou
 FTgb3B6tNAydjj1l1yEpHC4tCDo7ATQ5ZKLr7FnD4uqisCoycIIHfebIvhKuZ1v7Si342pY
 Cad1AIge2hvJfmxNXWfWctFUszPt68iABGx7vYBM41FJC+KxhUCwzVmVNJMLIlGKERGuBUN
 KFcmsdDN8xpf6URnvt4hQ==
UI-OutboundReport: notjunk:1;M01:P0:42O8tkPQiws=;W6jSTCgCT1gKcVhDcAPkZLv9xCP
 +IW69AfB6WIZVn3dX57ldndHxnMDP3rGG/cJGw4xf5khikD+Q6f3kZ/C+716wFi5YW1fFlboH
 8q5pqsqBYfDkKQBWC/0Fs0xmB6m4ZL2ySHNM/VR0+Yb2YOVbrLBOc+oqGproExgiJRiFdVB/q
 sXzKmJo+OYiOtknBrLbYbC5xgvWNWGdDIzSOnRrP7Tx1+W+3+XKgQeD5JtcG0XYkeKbsDQzSs
 I4J41/cT6ggvX0SOzxqn2FVe7K5GcMNbPeNmDkub8I6hlrNasGruEvuzaCC6AUW0oReljyoSS
 a2dHzcgmXViux1R57tcGSV38QSYnNFO7uxN2wLpG8gomkM4YVcxlbioT3bVXJ4eGzr+d+aY5Z
 pTFVnWxW4QS5Z4JoGEhFqyxHiMOHdtrV1IuFCPO0YhgOPei/fZmjryZT+Gzm5EgzRC/ifEPvw
 teWpqkLKgiux+DvNyS8heuFHuRosoKrQBngxFlBdSjASd9y0ngD5PtN+kSXs+MTufllwDfBm9
 jwXMxORnAveNfu9QTIk27s4MJupF9n1J8gvvi/akQTmfHDQk0G0vvmyowIKS7cpbSbRrn0Cgr
 T1vW+pDANPgxiHqdiEIYhD1rKSNubkSuihc8GZv5/i2K5VBfKxOx9jb2axkBzJntT4DC7VpIa
 HyDXusNaEypKNriQh5OpdcVSiGVjkxQbse/E5utErmzgP+YT7L9Ri5nC+K8bXR2htPTJCx5TS
 vaygFwfKhJOtpUcDftku/5ovZ8gVNMRLUZiXOzwICogePlvqgP8r90h5m+4z9bf6/Ays448fA
 SzE7WsO175TmwP2ln9JLprJqiuc/hFhVrcF8wr1fo3RJdGOtnxlhQPbDISQhguUlBWHhu4k21
 jBPU/l+2YLWCu8rm0CRqQcqVWaZm7K5GU4lzlehshx8AwoIplEX6hUK0aUQfktWrdYusO2biE
 S5bBsFJGrFH45cxmg+t4elOaSPI=
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

QEMU provides SMBIOS tables with detailed information. We should not try t=
o
replicate them in U-Boot.

With this series we add code to copy the QEMU generated SMBIOS tables to
RAM. efi_smbios_register() later installs the SMBIOS table as EFI
configuration table for the OS to pick it up.

If we want to inform about U-Boot, we can add a Firmware Inventory
Information (type 45) table in future.

With 32bit ARM I did not see a correct SMBIOS table being transferred. We
need to check if our code in qfw_read_entry() is 32bit compliant.

For providing SMBIOS support in QEMU for RISC-V I have sent a patch
upstream:

[PATCH 1/1] target/riscv: SMBIOS support for RISC-V virt machine
https://lore.kernel.org/qemu-riscv/9183a3fb-b9f7-470c-b9a6-8d8cc6dce7c3@ca=
nonical.com/T/#t

Currently we have a predefined constant TABLE_SIZE =3D SZ_4K in
lib/efi_loader/efi_smbios.c. We should strive to refactor the code in
future to provide the length of the SMBIOS tables in global data. But
that is beyond the scope of this series.

Further we should find a matainer for drivers/misc/qfw*. It would be
plausible to add it to 'ACPI' maintenance.

A test via a new SMBIOS command is supplied in

[PATCH 0/5] cmd: provide command to display SMBIOS information
https://lore.kernel.org/u-boot/20231223004429.247301-1-xypron.glpk@gmx.de/=
T/#t

v2:
	fix parsing of SMBIOS anchor
	enable copying on x86 and 32bit ARM/RISC-V

Heinrich Schuchardt (2):
  smbios: SMBIOS 3.0 (64-bit) Entry Point structure
  smbios: copy QEMU tables

 arch/x86/lib/tables.c       |   2 +-
 drivers/misc/Kconfig        |   7 ++
 drivers/misc/Makefile       |   1 +
 drivers/misc/qfw_smbios.c   | 197 ++++++++++++++++++++++++++++++++++++
 include/smbios.h            |  26 +++++
 lib/efi_loader/efi_smbios.c |   4 +-
 6 files changed, 235 insertions(+), 2 deletions(-)
 create mode 100644 drivers/misc/qfw_smbios.c

=2D-
2.43.0

