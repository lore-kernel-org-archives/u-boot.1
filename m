Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 954FDCC6B1D
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 14:48:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5B2C680E33;
	Wed, 14 Oct 2026 14:48:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N6TLnwJCg89G; Wed, 14 Oct 2026 14:47:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 778D280E3D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791989279;
	b=UcadtZQFHM9/mfetdenGgGXMM7dv3GMgiQpeXUHsWy6p73snp5qhpNN43gwXbX6W8SGu
	 Lb7V07I73/EwIKMFeNi/S7rXTFa2PR2j+2CWIT7/qe0UmZbihFv6mFYmt7nZmlRTMdbJ9
	 iYbNfOnrsuMJC+L1UAFtk/6cUX1dcO/aJVzm8YQMJSXh/gYSKmCUwuk8tcMia+SyWvCxA
	 lD/LP4BS1hCZZp4IF6ZqxGMmt1rcvURD4sTg++4FkzX2ENBKjS1gs8GLGUaHHwhUPN50v
	 PYMeYTVsHJzXFqHx5G+ASXvoCK41Cx2ykUU95LeE2cb7BWMaxzdxKmmstdyUBxejb4Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791989279;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=V8EATC96jxiqHM1HCxkUmga2fiHex0u2ll+dpjjpe8A=;
	b=oCoyz/RXrdD4CQoMd+vTEPF5u0ZeE/nS1jtAYI7Lzx3l+GX8chlk9skH+c1iYZp32pQR
	 Dpzc3p0O43wIY6BLVGxw0W8FOlBnogCNNXHzBBhZxclEqn4G47nIY3X+Dr4RoThyvr7eg
	 mGiDWRrPWWKyNEhr7z3VNoMP5YQJH8ugPrbi7flwR4R1E5WBeWJNFUDhFNsZW8xvOCTjw
	 2qiu6TrW0be1yHVUCpSfpj+qfJcvOlBtTOC3ujV00q0i3AUHOLLLhDk8h/aZIEFUOE+2V
	 cZucnt9B95uj0tTaJS3bVUzY/7UAE8cv/0PemP4iQ8Zrrq3viT04oEekpVvkqMTHIew==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791989279;
	bh=V8EATC96jxiqHM1HCxkUmga2fiHex0u2ll+dpjjpe8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XYa0bCiXQrMQuv2dqHfpORKyuaCyogTN3351PzoDszsre5RjAUOZLh9mp+l9NPptl
	 rURv8pOmNYwr03UVncCNZ+pbfCj+Hsj1VgdciImQG7J5lqHDsB2XsH2oDGiS6mKn2i
	 MC8Uu/PS5VCcjd9kjYOvZs/j1VqZpzGo9CJfURZGo2uKgJ5YEy/9UjKfUnwszdOuaW
	 WdVTNX+dTdEtdh0ENxI86aTyJBrerVlBWbxIFxcZPNtrw6UYA9VmifXK1LaC/gHu3L
	 kUw++ezRZ7h+XFpXX+hjzGA2NeKL3QcE7VT96qNAWEdn15qfcH0I2tG/wfpj2jTsq1
	 c8NdfWT7pYsRQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 778D280E3D;
	Wed, 14 Oct 2026 14:47:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A4878769
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:47:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 96C1F40753
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:47:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Sui1naMv_eaN for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 14:47:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CE86B40752
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::132f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791989278;
 b=lXTGXJ+olSzEJBhZHLTIYAP4GDaHSKLYHkTcVM8h5nKD5madDBaOUGHnb24IZu7eemNT
 bJ4XqXnCpVf5rFmbSnpO0XbIHdFX94xOLMR2zcXyxvMv3uvoOwGq92O6piGcuwUdOSxD3
 nmvQWxEuZfRiIcKzW1nWBHoZ3fHK0HWXwrlKeUS/p1Yt4BZmLTXYPZPw1cGKsqp5zjpyF
 YbL4hIns3u476sojMpH4fhqYSj/mgd1igiVfYLDi5PQ2DWfml7c4d4gCRqLVyj17flu0m
 j50JOP1KbYzqwPuwYS+8wr6tvp5qDE9DnwZdKOB4W7LF7wyNVG0pwBPBSYQx+XKPpAw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791989278;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=V8EATC96jxiqHM1HCxkUmga2fiHex0u2ll+dpjjpe8A=;
 b=c+8ZCHJYuP6e5fgm4XyUeh56uzBQ00BmmcZz92qQHu0Ytt8V8yX1yZzmdj/R+NQvcO7z
 9+KXrlR8posx///lviSJzEkxRXll7gigrQdkea5JZWo7AlkeQrfCq1IG0XouMpIpquEVq
 MuceMp6td8DdIrUZ7ZJytNC7wWAndbcSFwsfcGToato4nhB9j8tI5641IkwFJa5qOYJFT
 VGJRCNTM2zHwWQ7uE5j9mISfj8BrQcvMxN1IsUv5XpbUFSnN01QAx+RATjfIIQeK9umWH
 K5/b5FqJzHCcy7KPUnFuvunaUeAxQqh0qqpVUO6AJm5pjJo8LSOmYska2SwsQ1AFjcA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=BAIzT9pt; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::132f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::132f; helo=mail-dy1-x132f.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=BAIzT9pt
Received: from mail-dy1-x132f.google.com (mail-dy1-x132f.google.com
 [IPv6:2607:f8b0:4864:20::132f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CE86B40752
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:47:57 +0000 (UTC)
Received: by mail-dy1-x132f.google.com with SMTP id
 5a478bee46e88-33bf40b0c8bso886150eec.0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 07:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791989276; x=1792594076;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=V8EATC96jxiqHM1HCxkUmga2fiHex0u2ll+dpjjpe8A=;
 b=BAIzT9ptoSkWV7jIGvfLAWl7RBi07ffBu04eVNHD1kXEh3R+O0QcTRPsmsOT9k931b
 BJDt3hFYwpyVxWismWqdm8zhQkggRVrrTb47WcPaGL8mOu9Dj3UEEfjXs1VSHJivIml2
 wGEuIUNcKXLVYnSBsJPoGgXstdrG0dAJXzqF+lA1RUaXy2sCuUQL4EStf+Z1nsI7AC7f
 CFCdzi4o0R64gXTOljLLqj9PzrkLuvPcRW6Wu5YtYA/inbGxhQeSnaZXaIEZvuGjL4OY
 8Rn8w6355FZeqwrh6sUgXIYBMhnYVoCMqtcR+PXsbKzG5CNP/O8+6uh5UrU8dHxnCwbE
 eCjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791989276; x=1792594076;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=V8EATC96jxiqHM1HCxkUmga2fiHex0u2ll+dpjjpe8A=;
 b=0712t0X1Umhr8lkmwRUnxJIcMvpSMqATZEIdGayNh30IFYWHrIzGZKlPP3OiwaN22r
 ZjNlFdyZP5TuC1J4jVmvbVzqhrNthp4W0Z5Ovxy8oa5iFfmM3koI3AF6Fi3X0XEbVpoi
 kWNDZ5P7fYeM1rLFMoweD6m+0mbmlRJjmkJh5/uOmnMmkgnTz1Mp7YILVhixEAzXP0tI
 vnLYFano2iDba2MNuhES7YI9STbpYXZDXHOmxvbgHxOM2ta8ZcCeL+WCD6aSZHc/Jctr
 FQ2ZoYcpmN8DKAaej9wWP8TxiQCE7rWTVMsTm+IHTYp4q56JrEER0Xm0+/q71rnAsoGL
 /TAw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzpA8UnWO857rfDRRozjp7/Ix3b+15EvaWGzErOxfatNqCYXEfB/3cimU/CmMzMOBpGB2I8JXg=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJlE4wBh7X18Cp+iShjRBpvwvSEWfrffEXhP/39wkwLgoZPFggT
 OJopYiuawDAacEzCGIp3sHbjAQr0ZBg5LjzHeJ6aYky+H0/R204NpTqR
X-Gm-Gg: AYBFou3AXitInaxDRDU691xMtUkbChzIxXWlTfYJP8d6R6MCkd0HEXeNzA2NKuBlUTB
 TQwFejZl8cMOE1KYml6eOBAzuMRQUEBDg6mKaQNvVKOiZHxUT+d3PIcG/Qx0O7a9l/Q7OW+exy2
 M2fYms2K9B004K5JxJr+7Crh7CWR2dVaH/eDz9aOpeZGDDC8XQeYXoVsiMAHt6pTHAZ4DwzOnVd
 ioDe1Z/dm3TTZ27WecBNddDvfuM6NvEKqJKqWo8usXxHQT73/R3BGySnMEKmW9joq1SzYbkySE5
 zVNW9iRsMmuvjl06Mgu7xifAfWrZ9z0vokSvLqh5QavisNcbJhNsNSjsuIig9UAVD2CpdFj8dX1
 wEHcGKA3tHMkdQ+SfNeiqLRhrZpMm0g5HCKC2bP2ellZYXPyJqDPgqxeB7dioIaVsOzkU+oW8dD
 Xe/pNP9Pbx2owvtJnGQUuxobw7Kz7naU0lBmPng5s4qGURugN11RUv3JPVxeOOPrJAisCaoTfVx
 2W3jDTPWuuAAjrf83sRXcMOSR2wd99Jf13oc+EdT4oOWKAWaARtEgk6yAWO+aJl/wbi5ROxMdtw
 4iPwj9Hj7XkJcnwAZNDsSfwqtzHjqTkhTVNLlhkTAWO0s5QlmuNawA==
X-Received: by 2002:a05:7022:b051:20b0:17b:fea8:1425 with SMTP id
 a92af1059eb24-17bfea8145fmr5396982c88.30.1791989273818; 
 Wed, 14 Oct 2026 07:47:53 -0700 (PDT)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a2d2db98sm44840639c88.10.2026.10.14.07.47.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 07:47:52 -0700 (PDT)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>,
	Tom Rini <trini@konsulko.com>
Cc: Leo Liang <leo.liang@sifive.com>, Tim Ouyang <tim609@andestech.com>,
 Yao Zi <me@ziyao.cc>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.u-boot-project.org
Subject: [PATCH 3/4] riscv: qemu: Switch to standard boot
Date: Wed, 14 Oct 2026 22:47:23 +0800
Message-ID: <20261014144724.1763675-4-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014144724.1763675-1-alan.tseng.cs@gmail.com>
References: <20261014144724.1763675-1-alan.tseng.cs@gmail.com>
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

Replace distro boot with standard boot, as the QEMU Arm targets did.
Move the environment from CFG_EXTRA_ENV_SETTINGS into qemu-riscv.env,
keeping the same addresses, and replace BOOT_TARGET_DEVICES with a
boot_targets variable that lists qfw first, then the devices distro
boot scanned.

With distro boot, a kernel passed with -kernel is never tried, as
distro_bootcmd has no qfw target. With this change, booting U-Boot
from pflash with -kernel, -initrd and -append boots that kernel
directly.

The sysboot command is no longer enabled, as the extlinux boot method
replaces it; this matches the QEMU Arm targets.

Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
---
 board/emulation/qemu-riscv/qemu-riscv.env | 15 +++++++++++++
 configs/qemu-riscv32_defconfig            |  2 +-
 configs/qemu-riscv32_smode_defconfig      |  2 +-
 configs/qemu-riscv32_spl_defconfig        |  2 +-
 configs/qemu-riscv64_defconfig            |  2 +-
 configs/qemu-riscv64_smode_defconfig      |  2 +-
 configs/qemu-riscv64_spl_defconfig        |  2 +-
 include/configs/qemu-riscv.h              | 26 -----------------------
 8 files changed, 21 insertions(+), 32 deletions(-)
 create mode 100644 board/emulation/qemu-riscv/qemu-riscv.env

diff --git a/board/emulation/qemu-riscv/qemu-riscv.env b/board/emulation/qemu-riscv/qemu-riscv.env
new file mode 100644
index 000000000..9e691616b
--- /dev/null
+++ b/board/emulation/qemu-riscv/qemu-riscv.env
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+/* environment for qemu-riscv32 and qemu-riscv64 */
+
+stdin=serial,usbkbd
+stdout=serial,vidconsole
+stderr=serial,vidconsole
+kernel_addr_r=0x84000000
+kernel_comp_addr_r=0x88000000
+kernel_comp_size=0x4000000
+fdt_addr_r=0x8c000000
+scriptaddr=0x8c100000
+pxefile_addr_r=0x8c200000
+ramdisk_addr_r=0x8c300000
+boot_targets=qfw nvme virtio scsi dhcp
diff --git a/configs/qemu-riscv32_defconfig b/configs/qemu-riscv32_defconfig
index 2801e0b21..e16a0c6e2 100644
--- a/configs/qemu-riscv32_defconfig
+++ b/configs/qemu-riscv32_defconfig
@@ -7,7 +7,7 @@ CONFIG_SYS_MONITOR_LEN=786432
 CONFIG_SYS_LOAD_ADDR=0x80200000
 CONFIG_TARGET_QEMU_VIRT=y
 CONFIG_FIT=y
-CONFIG_DISTRO_DEFAULTS=y
+CONFIG_BOOTSTD_DEFAULTS=y
 CONFIG_DISPLAY_CPUINFO=y
 CONFIG_DISPLAY_BOARDINFO=y
 # CONFIG_BOARD_INIT is not set
diff --git a/configs/qemu-riscv32_smode_defconfig b/configs/qemu-riscv32_smode_defconfig
index 69f25349d..4629bf3ac 100644
--- a/configs/qemu-riscv32_smode_defconfig
+++ b/configs/qemu-riscv32_smode_defconfig
@@ -8,7 +8,7 @@ CONFIG_SYS_LOAD_ADDR=0x80200000
 CONFIG_TARGET_QEMU_VIRT=y
 CONFIG_RISCV_SMODE=y
 CONFIG_FIT=y
-CONFIG_DISTRO_DEFAULTS=y
+CONFIG_BOOTSTD_DEFAULTS=y
 CONFIG_DISPLAY_CPUINFO=y
 CONFIG_DISPLAY_BOARDINFO=y
 # CONFIG_BOARD_INIT is not set
diff --git a/configs/qemu-riscv32_spl_defconfig b/configs/qemu-riscv32_spl_defconfig
index 790bcb72b..94827f35c 100644
--- a/configs/qemu-riscv32_spl_defconfig
+++ b/configs/qemu-riscv32_spl_defconfig
@@ -13,7 +13,7 @@ CONFIG_RISCV_SMODE=y
 # CONFIG_OF_BOARD_FIXUP is not set
 CONFIG_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x80200000
-CONFIG_DISTRO_DEFAULTS=y
+CONFIG_BOOTSTD_DEFAULTS=y
 CONFIG_DISPLAY_CPUINFO=y
 CONFIG_DISPLAY_BOARDINFO=y
 # CONFIG_BOARD_INIT is not set
diff --git a/configs/qemu-riscv64_defconfig b/configs/qemu-riscv64_defconfig
index a32eb95f2..1103a3dd0 100644
--- a/configs/qemu-riscv64_defconfig
+++ b/configs/qemu-riscv64_defconfig
@@ -7,7 +7,7 @@ CONFIG_SYS_LOAD_ADDR=0x80200000
 CONFIG_TARGET_QEMU_VIRT=y
 CONFIG_ARCH_RV64I=y
 CONFIG_FIT=y
-CONFIG_DISTRO_DEFAULTS=y
+CONFIG_BOOTSTD_DEFAULTS=y
 CONFIG_DISPLAY_CPUINFO=y
 CONFIG_DISPLAY_BOARDINFO=y
 # CONFIG_BOARD_INIT is not set
diff --git a/configs/qemu-riscv64_smode_defconfig b/configs/qemu-riscv64_smode_defconfig
index 084960460..9d50df410 100644
--- a/configs/qemu-riscv64_smode_defconfig
+++ b/configs/qemu-riscv64_smode_defconfig
@@ -8,7 +8,7 @@ CONFIG_TARGET_QEMU_VIRT=y
 CONFIG_ARCH_RV64I=y
 CONFIG_RISCV_SMODE=y
 CONFIG_FIT=y
-CONFIG_DISTRO_DEFAULTS=y
+CONFIG_BOOTSTD_DEFAULTS=y
 CONFIG_USE_PREBOOT=y
 CONFIG_PREBOOT="setenv fdt_addr ${fdtcontroladdr}; fdt addr ${fdtcontroladdr};"
 CONFIG_DISPLAY_CPUINFO=y
diff --git a/configs/qemu-riscv64_spl_defconfig b/configs/qemu-riscv64_spl_defconfig
index 5c1ced65b..2c0e42045 100644
--- a/configs/qemu-riscv64_spl_defconfig
+++ b/configs/qemu-riscv64_spl_defconfig
@@ -12,7 +12,7 @@ CONFIG_ARCH_RV64I=y
 CONFIG_RISCV_SMODE=y
 CONFIG_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x80200000
-CONFIG_DISTRO_DEFAULTS=y
+CONFIG_BOOTSTD_DEFAULTS=y
 CONFIG_DISPLAY_CPUINFO=y
 CONFIG_DISPLAY_BOARDINFO=y
 # CONFIG_BOARD_INIT is not set
diff --git a/include/configs/qemu-riscv.h b/include/configs/qemu-riscv.h
index 63078ee41..d9ca371d9 100644
--- a/include/configs/qemu-riscv.h
+++ b/include/configs/qemu-riscv.h
@@ -15,30 +15,4 @@
 #define RISCV_MMODE_TIMER_FREQ		1000000
 #define RISCV_SMODE_TIMER_FREQ		1000000
 
-/* Environment options */
-
-#define CFG_STD_DEVICES_SETTINGS	"stdin=serial,usbkbd\0" \
-					"stdout=serial,vidconsole\0" \
-					"stderr=serial,vidconsole\0"
-
-#define BOOT_TARGET_DEVICES(func) \
-	func(NVME, nvme, 0) \
-	func(VIRTIO, virtio, 0) \
-	func(VIRTIO, virtio, 1) \
-	func(SCSI, scsi, 0) \
-	func(DHCP, dhcp, na)
-
-#include <config_distro_bootcmd.h>
-
-#define CFG_EXTRA_ENV_SETTINGS \
-	CFG_STD_DEVICES_SETTINGS \
-	"kernel_addr_r=0x84000000\0" \
-	"kernel_comp_addr_r=0x88000000\0" \
-	"kernel_comp_size=0x4000000\0" \
-	"fdt_addr_r=0x8c000000\0" \
-	"scriptaddr=0x8c100000\0" \
-	"pxefile_addr_r=0x8c200000\0" \
-	"ramdisk_addr_r=0x8c300000\0" \
-	BOOTENV
-
 #endif /* __CONFIG_H */
-- 
2.43.0

