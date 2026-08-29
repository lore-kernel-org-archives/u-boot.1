Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF095C61DCB
	for <u-boot@archiver.kernel.org>; Sat, 29 Aug 2026 19:21:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 568F64074C;
	Sat, 29 Aug 2026 19:21:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fFUQjn6JifVh; Sat, 29 Aug 2026 19:21:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788031292;
	bh=cfb3e/UB0DQhKkXpZ1iXLErP0hjzE27pmsyU39CKzSU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=TxvTH7pFHFF7Xlw+UAVDW5SFmDk8nFu0LT+adpGfnseIzniXioUuwU1JiMw1agQFO
	 MqZl3df+D+TQXoi3UQXR7S/XfguFRtbJ2geDXnnsh2pEGIyeaHcx4hEOUjIOZEpLJQ
	 aGtM9nnReL7scDI+HGLw4WLX8zdC2EmKGQYlRSKUP8SdyKGmmddvS7/B7NzSgENUEV
	 eTOrFwKX1hjhhjBb9VniAlikTqCxC7CvYKSGONLGgQaDl4jelWjAI6AUNWt4vNhAbY
	 82TCsgC2OlDMU7sDE78LuLhVAVREzWDdkizTErdRqVzXE/R3PLt4JsSH6FIA0y6vBo
	 VnHmDtZz4PJ9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 41528406F6;
	Sat, 29 Aug 2026 19:21:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B8227127
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 19:21:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AA8F64007B
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 19:21:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rLiOZsK3zT2q for <u-boot@lists.u-boot-project.org>;
 Sat, 29 Aug 2026 19:21:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::52b; helo=mail-pg1-x52b.google.com;
 envelope-from=visitorckw@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=b/IjhBGl
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E9EE540059
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 19:21:29 +0000 (UTC)
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-cc147d86bebso2374342a12.0
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 12:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788031289; x=1788636089;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cfb3e/UB0DQhKkXpZ1iXLErP0hjzE27pmsyU39CKzSU=;
 b=b/IjhBGl/qfRGu59Lda6NeUQ2p0b7XzOT72Hv1JOpWIiVpAAO4rtabrx2096qX62WX
 r+j+HJ0er+qJweydjJAig1BDIuxDGwFDeASWS4Dx4gyO32XLhOyzsIAtsNRaFsQTMhBO
 Xv8Uy6Dj6GHpy6wW51paDj2QYN3lH2NfHANX45DI085dCl7p8XcombhthsFh55j10Ldc
 irOVWZqMtoQ1NswNliB41cz5n2zz3tP00ThJFIf04HTEncZemnUzL+U6aPpNF2UeTCz8
 /KYagJ3rE22FJyA5Nov+0dyEbrvXctebmXRRNmesZFn+YBUNkOWfpvipZdriN52ZlPjd
 bXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788031289; x=1788636089;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cfb3e/UB0DQhKkXpZ1iXLErP0hjzE27pmsyU39CKzSU=;
 b=OaghsBhk2LmYNT0PE1cNkW15eFlhhyIx0cfRyQkMGZv/1HayI/KYO3g17yWuLcMQ81
 Y3dKJ8v6a3YxwrQq1CP3cU3gzLekhQZ3mH6HdFTLGq4aQFr6t/273VYdjuKSxIytYtyg
 2IELHzp4zcT+9MZ87LxdMpNZGad3RrthSteiRMt6vMpqRABMe9FMs7wrC6ZEioHjpQ2X
 iasAKkyOvbx85emufSstyC7D81opWtoQRdudBQgZF0iKCpMUrMbhQ5DEtGBewRfzXyI8
 uPUbM6drSRJ+eJJhIsKbvHwohxCGqHhuyeXiu7KoX+FbH3aPAIjercrAdPdA0LfAtlax
 KsRA==
X-Forwarded-Encrypted: i=1;
 AKwUvByXNemLS+C2Ya56YU6j7JnEvXHuaQ9Hwe6f39Kbq5Ov4n7oAPoNzqjGclAMMm5QSA314/V+C40=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nZCQcjRo119RawMUd0Wiivgj/U36Z+Fy/8nkK644Ac8SZXDWzE
 ohjcmPPws++ZIyHu/SFg4QkU74Xm4AtknaUhfP7PIysK66B/pLG3FjMH
X-Gm-Gg: AYBFou3ktUbEqHNacBiz4oA8reUdVkOt29SPVnmTJ/1BDeFKMfySLE+qJzf+KYbOdGu
 xxA7Zy6JN8LpvRq4Zj0KeaQaiobGPqtqU3Rv94moZbYKwH9nexczrIX3d4YirfNb1Qkzz670528
 XIFPod0wVHlYdNsj/HhM8T5UDasUAgtTT8iwGla4U0hzLxWXkQ9gTzazzv9BIZMRBQ77nwl6kTJ
 vU5toPoJAknyVJ/vVFJjrzjvkQdf5MWt4Dc7id52ZFYSeAcgO6/kwdrKby720rt70m0G4Jl6f19
 ToE1fAG0iomhVWhO81Q1gWT/TcfqE5KWBzLels3evBpRrsUyLeWACMWSGTm6e5VHrZT6557wRgN
 XXPR6WaGsJmj7XdBlCSuh19evioo7pN2v/bUb2UGX7piBJYPtAQsozR0kqPAjCR/fU4cb4QSim4
 NLRWuaaGn/QrrSI+WFjRi/jrUwvFK9GiRRmAq8ikonK587Svt3OWS9m5YpLja/79si5/iypV2fa
 VEHnWDd2cwNFAumYa5Zo9xPjgxGbzVWDiShiz9xAAsItX2a3y8j7vW5gGdO1Jng6A==
X-Received: by 2002:a17:90b:4b90:b0:398:c6e8:3fc2 with SMTP id
 98e67ed59e1d1-398c6e840e0mr984822a91.4.1788031288779; 
 Sat, 29 Aug 2026 12:21:28 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com
 (184.247.229.35.bc.googleusercontent.com. [35.229.247.184])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b0ea7fa9sm12837034a91.4.2026.08.29.12.21.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Aug 2026 12:21:28 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: trini@konsulko.com, tuomas.tynkkynen@iki.fi, bmeng.cn@gmail.com,
 sjg@chromium.org, jerome.forissier@arm.com
Cc: jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, marscheng@google.com,
 u-boot@lists.u-boot-project.org, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v2 0/6] fs: Add 9P filesystem support over virtio
Date: Sat, 29 Aug 2026 19:21:13 +0000
Message-ID: <20260829192119.2658328-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
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

Add 9P network filesystem support to U-Boot.

It allows U-Boot to directly mount host directories in virtualization
environments via virtio.

The functionality has been verified on qemu arm64 by successfully
loading a Linux kernel image and an initramfs image via 9P, and booting
to the Linux shell.

To test with QEMU:
  -fsdev local,id=fsdev0,path=/path/to/host/dir,security_model=none \
  -device virtio-9p-device,fsdev=fsdev0,mount_tag=rootfs

U-Boot usage:
  => virtio scan
  => ls 9p rootfs /
  => ls 9p 0 /
  => ls 9p - /
  => load 9p rootfs $kernel_addr_r /Image
  => load 9p rootfs $ramdisk_addr_r /initramfs.cpio
  => booti $kernel_addr_r $ramdisk_addr_r:$filesize $fdtcontroladdr

Changes in v2:
- Introduce DM UCLASS_9P and dm_p9_ops for transport devices.
- Support selecting devices by mount tag, sequence index, or default.
- Integrate 9p into disk/part.c and generic VFS null_dev_desc handling.
- Consistently use 9P2000.L naming across subjects, code, and Kconfig.
- Add kerneldoc comments and separate filesystem header.
- Add timeout handling, feature negotiation, and remove callback.
- Add 9P documentation.
- Add automated pytest and enable in qemu_arm64_defconfig.
- Fix error checking, bounds checks, and memory leaks.

Kuan-Wei Chiu (6):
  net: 9p: Add 9P2000.L protocol support
  fs: 9p: Add 9P filesystem support
  virtio: 9p: Add 9P transport driver
  doc: 9p: Add 9P filesystem documentation
  test: 9p: Add test for 9P filesystem
  MAINTAINERS: Add entry for 9PFS

 MAINTAINERS                    |  11 +
 configs/qemu_arm64_defconfig   |   3 +
 disk/part.c                    |  16 ++
 doc/usage/filesystems/9p.rst   |  55 +++++
 doc/usage/index.rst            |   1 +
 drivers/virtio/Kconfig         |   7 +
 drivers/virtio/Makefile        |   1 +
 drivers/virtio/virtio-uclass.c |   1 +
 drivers/virtio/virtio_9p.c     | 119 ++++++++++
 fs/9p/9p.c                     | 185 +++++++++++++++
 fs/9p/Kconfig                  |   8 +
 fs/9p/Makefile                 |   5 +
 fs/Kconfig                     |   2 +
 fs/Makefile                    |   1 +
 fs/fs.c                        |  25 ++
 include/9p.h                   | 203 ++++++++++++++++
 include/9pfs.h                 |  60 +++++
 include/dm/uclass-id.h         |   1 +
 include/fs.h                   |   1 +
 include/virtio.h               |  12 +-
 net/9p/Kconfig                 |   5 +
 net/9p/Makefile                |   5 +
 net/9p/client.c                | 408 +++++++++++++++++++++++++++++++++
 net/Kconfig                    |   2 +
 net/Makefile                   |   1 +
 test/py/tests/test_9p.py       |  82 +++++++
 26 files changed, 1219 insertions(+), 1 deletion(-)
 create mode 100644 doc/usage/filesystems/9p.rst
 create mode 100644 drivers/virtio/virtio_9p.c
 create mode 100644 fs/9p/9p.c
 create mode 100644 fs/9p/Kconfig
 create mode 100644 fs/9p/Makefile
 create mode 100644 include/9p.h
 create mode 100644 include/9pfs.h
 create mode 100644 net/9p/Kconfig
 create mode 100644 net/9p/Makefile
 create mode 100644 net/9p/client.c
 create mode 100644 test/py/tests/test_9p.py

-- 
2.55.0.897.gb25b4bd76c-goog

