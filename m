Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF113CC6B1A
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 14:47:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7EB686072E;
	Wed, 14 Oct 2026 14:47:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ISFAXKSIX5U6; Wed, 14 Oct 2026 14:47:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B24F5607C3
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791989253;
	b=oqfroURVs+OyUOSJGUpMeN2zNHgYl1Ar2/9kOD8CIek6TSnh2a8lSHHWk537id2wnIwf
	 k61/Ll0V4vCtXT4taOC4JyPc+jhNJQDYNpt/reEdqM0Xmv8aWwodX7xKCy6nGqYPRVnX4
	 e5hKFC3QfcZ4kCQtl/0XvlAXDtp+mbZm42DSlEHpRdDx2EcAuKJqWU3/zoEt4I9C9NfHW
	 +XpF2ukBVFg3pTKz6ba0DACdTeyi7ZB37gyFaL8qc2b/uw6uUaAtp13pxyNJIaJNRG0nP
	 qNQyNINZf4mPdvFNUQCEdMrarepuTP6ZUWgoxASFwdg4M2bYzlYRYgrjSIeKismncog==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791989253;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=OBrcqDIF1lWrwnL7pV/GzbcUUZclO71EpJnHQRqsamc=;
	b=gQfe/zCwbuxbN5biEX8nduf5anX7hdUfP18x6mV5IkS7R3AUYUHjyM9DPR6QtoQh/jYn
	 JL4AzM2gc99oPRn8af7MOzZY2zsJZzzLMNT/xIVWt6xscBZcn7ujCeG4PncCPjOMTR88B
	 hLP3V/TDQrMeYU5svslnI27IRgxrDx7tVCGIBQR+gQQq+C7zKn3CutblM5V7jo55FKKaz
	 8ji/WRZ1GhHk8p9DAfMe0f8BTWtDAgvXg18UeC9VqakfZH7dF9kFlJPLCMmMoygEkdFnD
	 OVJvRmOYJfQG7RVmql2kCP5A0if8R4DLDSkyolXF9+TPDCPhlWhrJD0IIgHyiwKU7IQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791989253;
	bh=OBrcqDIF1lWrwnL7pV/GzbcUUZclO71EpJnHQRqsamc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=vWGCc/h9kR7VUCu66oWBYBg6dlrSbcVmYcZ6XrVIBwy5oxV/ToF0CXQDxO8fGQjiJ
	 rFIs64v3QsmeHhNf8tjV+iY6WDrT26CfK15iAJPEgGeAJ4CeMZy2K41L2mOmO75APE
	 50FtL9lakUTMX5c/JdoL0hNUlOCimrEeqIlh+zDt8AydzZQAKGt1yR0VqhyAZiR6ZA
	 1O7HW5RdnIPoEJOTtq1KE5ISN6tfmYG2VL/NWO4Q6ij5NdaXhS6u09YCgv8RWtiN+P
	 B17HQxhpmkaYQ3JsYTvDajzUztkEGebaNchAsXuPMWFcv0EnJfOnNAHR71ohqcIttO
	 AFWb/SWYsxshw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B24F5607C3;
	Wed, 14 Oct 2026 14:47:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 80DABE4D
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:47:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6715B4019A
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:47:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oZd1sgcU9H8A for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 14:47:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A5DE640189
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1235"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791989251;
 b=l7RGEY0m65TjXMuRpOqbQV0+M8vmpa2v/2OvvFse2vPyt8TQh4vJoI0fBV9hqBMW39EH
 HFeAZgygBsLhT394VUvmYJCuDhg1oI98fKucRDMVvam6qKIay7Kp8cjhEsMOmgKaxnwCx
 cHhDqqDWirod2L/ib1SrKJWJIDMi/zc98eAeTjgz4JSVlFa+Q0NwyA4JEBMJDE1CeuoU/
 q5VNyxSsHs10uRKP6N5AR84IwjHMzSQkT1TxQS4+LZ9JaCfIdjryI1+kUmBlxJbqN17Ik
 ykuNHpdoGuYQrAKBrUcfXSMwNz3fw1UyLl28bqwBmk4P0+vh7FkF47uqO6syhpogpwA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791989251;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=OBrcqDIF1lWrwnL7pV/GzbcUUZclO71EpJnHQRqsamc=;
 b=CkTbbBPLGrXSWvFEXeE5PMlVFvUVMXrShKDD+fDc9iSccjgnCOBhWowqhuljTknWw8AG
 BcaB0wc32p5ifmBHkuoN1TnHO47E75WFGLO07XCo4NY0GyoEKGAYrPr9EhuglaiBJ8EWM
 tpCmt3v2l2N5i8pLhY5TrA0GsjmLVwdraGnYTpQEGRhZBpuj9CxnXNBXGgKs+rgr+mre1
 nQIBCq+i8kKF/NrqwF3nNda1LsfkA/iWXxvRE5pe81GSx2jvNcx7avy0DpmEagb1LX2yb
 GPw7S/yRyBBVCixQdjZsbrt7kBYtFUqsKXzl6cRUPZnd2pb7dWpE91Sh5xHQOBJ+Q/Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=erjmk9WG; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1235"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1235; helo=mail-dl1-x1235.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=erjmk9WG
Received: from mail-dl1-x1235.google.com (mail-dl1-x1235.google.com
 [IPv6:2607:f8b0:4864:20::1235])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A5DE640189
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:47:31 +0000 (UTC)
Received: by mail-dl1-x1235.google.com with SMTP id
 a92af1059eb24-15354aa70e8so2731902c88.1
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 07:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791989250; x=1792594050;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OBrcqDIF1lWrwnL7pV/GzbcUUZclO71EpJnHQRqsamc=;
 b=erjmk9WGuv2saB/sfbnmI2B7jT2DAvASrfZkjgMksNfutkI5JfjENszVlAuIJ3EEiY
 FQHYXttmQ9/7JvBZnWIiA1SZQYGw/OvnXkZwRwECRR0C8K9uNxTejIDf0iPTn3U0M+dZ
 js/iqsQPXc5rZtPEPHKdJU5bEjf6k8u1a2cjLSiGjl5yYlQqm4JUFfQQX+IgIl4AKmez
 Fonp1553mPceM1HRI0S0lIb5ChTIE+5Ilb7indpPKt37GE3+D7aGjAjxw3xigr4X1krI
 xEoLI0qCyii+QZwl4SDSmWHmYSgzb6hspJijdbX7R7YItoRu9FbmiQzhIXxso7rwXSS0
 0FVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791989250; x=1792594050;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OBrcqDIF1lWrwnL7pV/GzbcUUZclO71EpJnHQRqsamc=;
 b=z4xPjUKc76MSfIRe5bL2X0wNrlyIHuafPsbBTM4hXzr7rh4y5yEO4LtzFYpDVrgJOH
 Mwm3HnRbxYIk7fBKUmiohs/z402Une9vqLQgOzd9hdLcmEFjJEQwLnDaoJcZRwOE0F+3
 FvKlL+nXfd8DE/meNK5s5YIdyr7YCAuwitbJkNeHTJkSjrfMNo+l3lXFnUax/DxQYXDP
 b5ntc6QIK2ZA3wIp8FIJ0/MhcXV+PRxl7Z3+Rf9iTA325AJAurNtb0Dl90A3Ff6pwAvR
 ysSoPOlOYfMdfbnRJZPAsJBJB8/Fwqc/5CJzOHIIv3pVT5nhN3PAa9YBhOpnOUQfMIJj
 H+aQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzmNcbDZfZS63uoArGUGud3kL+Xjcv8Fxac+p28vAT2puDDMpbtQZtiha/YNCu/jbHo6AKf1Ks=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJpJm74qR0EHZpc0vPRBZMdRKje16Gmxb++Ujm8VAbm7sjSn74O
 xqFE6h0JgTgiYvkGbWOHlVXpIFirlcrtT32sME8ahwcUZmQ7GrRxaAhF
X-Gm-Gg: AYBFou1kb2MHh0G8C8bZDX1ddxNTzbNShPWzU8FI0YK4JNFitfKM333wV9eLzxSrM93
 5l6XTnlE01I6ZVI2Iyz772To3LsbHf4pB1Jwpw5ANfX0W+isUFjX87sEMPzmb+mYs0rciDLnyQ/
 xR8SUL8CV/4+KhNpSqcaIEbO+pWOVd3VE0xgTDTzaoOI5nB1Cp9Dz71FDIK07IeIOeBJWCMJj4P
 Ga1mwPsRy2vRPY6x6YMtA1YfGhjHquiZz6m8RsvfnoSDj9+GImAdI7U/2sh6cjEJCJweNXKAvxN
 4YbPGJn2kqeNsdfBCZHh5e567d2LMSZiNah5BDhGaKywosRbY8kenjq8AyTlHIsbXvvITT0TEyj
 TCGJVRW5s2J3jRuWVf9a6M1OsGnWIccfuS5YOy4SPjVHVwyf7h5HUX3yDWjYcuwp1BufHUU+NSU
 U7Lq5kkR5U1jZq8eaYEApS/4gBqv+dvIKt3A5HSNezQwcTndk5Gbhjy93NYSz12NEi7Lf/G9dVN
 wzzhDjuzOjfklnFXaSMeT8cBYeiD1999ko1E8BiSqCyZpwIk3myPCIRoL2y3bsMMwB6ow+mWUeK
 Ia8sdTpfeTg3gVrghAik4y0FsT9194QQuGZpyT4eztW01q2ow2uEpA==
X-Received: by 2002:a05:701b:4314:b0:166:862b:9bcc with SMTP id
 a92af1059eb24-16a5f01dfb5mr24880055c88.18.1791989249867; 
 Wed, 14 Oct 2026 07:47:29 -0700 (PDT)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a2d2db98sm44840639c88.10.2026.10.14.07.47.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 07:47:28 -0700 (PDT)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>,
	Tom Rini <trini@konsulko.com>
Cc: Leo Liang <leo.liang@sifive.com>, Tim Ouyang <tim609@andestech.com>,
 Yao Zi <me@ziyao.cc>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.u-boot-project.org
Subject: [PATCH 0/4] riscv: qemu: Boot a kernel passed with -kernel
Date: Wed, 14 Oct 2026 22:47:20 +0800
Message-ID: <20261014144724.1763675-1-alan.tseng.cs@gmail.com>
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

When U-Boot runs from pflash on the QEMU RISC-V virt machine, QEMU
passes -kernel, -initrd and -append through fw_cfg and leaves booting
them to the firmware. U-Boot ignores them today: QFW is only enabled
with ACPI, and distro boot has no qfw target.

This series brings the RISC-V QEMU targets in line with the Arm ones:

1. Enable CMD_QFW (and so QFW_MMIO) by default, and keep SPL_BLOBLIST
   off in the SPL defconfigs, which would otherwise fail to link.
2. Stop disabling initrd relocation, which checkpatch would reject in
   the .env file of the next patch.
3. Switch from distro boot to standard boot, with the environment in
   qemu-riscv.env and qfw first in boot_targets.
4. Document booting through fw_cfg.

Tested with QEMU v11.1.2 and the Debian trixie riscv64 netboot kernel
and initrd (Linux 6.12):

- qemu-riscv64_smode built for pflash, run with -kernel, -initrd and
  -append and no input: U-Boot boots the kernel through qfw, the
  kernel gets the command line and unpacks the initrd.
- qemu-riscv64_smode with a GPT disk holding an extlinux.conf on
  virtio-blk: standard boot boots it with the extlinux method, as
  distro boot did before the series.
- qemu-riscv64, qemu-riscv64_smode_acpi and qemu-riscv64_spl boot to
  the prompt with the new boot_targets and bootcmd.
- qemu-riscv64_smode and qemu-riscv64_spl build at every patch.

I could not build the riscv32 targets here: my toolchain lacks the
rv32 libgcc and fails to link them with or without this series.

Hung-Chun Tseng (4):
  cmd: Enable qfw by default on QEMU RISC-V
  riscv: qemu: Do not disable initrd relocation
  riscv: qemu: Switch to standard boot
  doc: qemu-riscv: Describe booting a kernel through fw_cfg

 board/emulation/qemu-riscv/qemu-riscv.env | 15 +++++++++++++
 cmd/Kconfig                               |  2 +-
 configs/qemu-riscv32_defconfig            |  2 +-
 configs/qemu-riscv32_smode_defconfig      |  2 +-
 configs/qemu-riscv32_spl_defconfig        |  3 ++-
 configs/qemu-riscv64_defconfig            |  2 +-
 configs/qemu-riscv64_smode_defconfig      |  2 +-
 configs/qemu-riscv64_spl_defconfig        |  3 ++-
 doc/board/emulation/qemu-riscv.rst        | 12 ++++++++++
 include/configs/qemu-riscv.h              | 27 -----------------------
 10 files changed, 36 insertions(+), 34 deletions(-)
 create mode 100644 board/emulation/qemu-riscv/qemu-riscv.env

-- 
2.43.0

