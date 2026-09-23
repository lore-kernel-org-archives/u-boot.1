Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D591C98304
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 21:30:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1BBE4412F8;
	Wed, 23 Sep 2026 21:30:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2MxGINtmnxsp; Wed, 23 Sep 2026 21:30:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 53DE5412F9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790199040;
	b=WcujHJ7t78E6UUxsJ29a8Aucgj1TPuQ8zdPvsF+eOoPlWc0VZ4F1F/cE9EDcUHj3tn0q
	 4R0fYWBDWlxknSaZaSW8XIu4Xwgf+spsRK5AcPnBqvi5fHOjRABhzNzEcnGdXyt/GUeFO
	 moLeVrNPvOJj1Shxc+rdB32XSPSmrwIo4UH9jbJMMcqSxuxh236xlf4OCvHIzMjnQ4ke+
	 QfRXKCYRPIj5IuI+FqLiCUtvJ4MyQXLkJmwOlNn0KC/p6SyGGssNXn4wDjqa4MeTe0xDq
	 skdSJMQVRkK0WUHjezWStbLNXaBTbAod3Rv/nbdnvbDjYdeJLwuxbNRE964GyMez/1w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790199040;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bwITO6OwtCfAhgXCS/7HLjWP3HYkwPe7jLHGizHOfQ4=;
	b=Wsh97WEpixFbatWRv8Brotv8WydNNxkl5GMd/v4TZ/qnxw70qbCFB6hsM2sEjDFf3iBP
	 yVPEbqbfXuGLJ+jFo2Gbqr80AIzQKpBsszUKvuhmHDhppKkYojCBHfieFxYAqH//fsJST
	 Vd5HJH1MxLlv4ZAcpTPLAdNfigy/urYyc9PUN/cXgbYHgBW4M9wP0r1dl/dKt/5hFUKhw
	 yWGE1/1N4ty8YWDBPYV8tRgZnOsMl/LD9NGbpWq6pdXzKRmYipdv9hy6ndcssx5FsoCeS
	 FCFenF3F+ZuSl9KjB/OEZiCvN/wxnxCjOHBQ6BMzoX9efI3xaKma7UbvTACmyzSq39g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790199040;
	bh=bwITO6OwtCfAhgXCS/7HLjWP3HYkwPe7jLHGizHOfQ4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=u6yc8mdd7DA5q0mjharEKvBkurhgXNBDyOnBkh7EBcxnOzpahVfQRq2qEMLqH/p8C
	 /ZP/DuGZlCTtlSDoEkFMN66O83ePqza4MuG1szIWxXPJIrBy2pUOFHO+UgWY7P6jN7
	 TrazIUL1S5MtAk1LTkOHkLvp7U+VwptoJxbi/aiEekm71+i0kB8+dTCveFvohZMAnT
	 JA44WfhHpYY/6tOBupgSd7+P5nbHwlH7KrBQLr8ogORz89xZa/JsqLuGqB9HeuhvKU
	 zYQCuqRaBdgO3cqtccRRxM4yUVyyO2kti9oQ1Y4/JlNrz0EF9u8S1koq1td7eyGNqZ
	 0GueUquEmjCyg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 53DE5412F9;
	Wed, 23 Sep 2026 21:30:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 830593A9
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 21:30:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7473E60B85
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 21:30:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LHILLKlr-AJS for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 21:30:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9F88860B3F
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790199037;
 b=QoaqsrdxtkZQpOulP9qklBF3UBrViVtxlWhXiw3Gr7qhC2ev96AC0f7Fv4W1AJ1NgHAM
 32rfzJrlF/9+pQYB6E3u27BOpONbyWhcGuYy81XEu2Y13mFqlimXqO50JYiOr30OX/heL
 ZxbJd+eJ+3AFWjYCxzs7boAdGEhcrEYLQXxv+BpXTqUq6iT1Lb4bHkFwbHCEqgL9hZum1
 nqMNtzMk3f7hMrmeWUS8Wa1LNTg6TYECh5rEAPnQSZG/1xpfzbifbigulwpctIHP0jQ9z
 lqrS+6Rw4O/IuwipGwweRCImBFgCbtuyPaW1fQahKKiQzNJ413h4jpEs3JlNiagKVGA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790199037;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=bwITO6OwtCfAhgXCS/7HLjWP3HYkwPe7jLHGizHOfQ4=;
 b=X6gtLUIF5E6Ib7TRhXFFt4DytJS5XfJKjkyWyqoFU/tnh2+KRSKILE3WdcFDjR1DV06x
 28dUrBWgx1NCIbbZ0gGHOzVx4VUf2j4KGjkV9Yye+6DSC5t01Yk3mbRblP7CArnBoY+7J
 ZB9K5+gbBxuF4vChuxW3Om5NXMs+ik61eTsEBTJJBt/M6ZLf6tVATJJiM1zPCWHsK14JH
 vulzmYkUtFnfzGwoayhaGIiwPMFK8UEwd6RayuR+qDC4EFG6E0t7XoxzIb6qdoiCsiStQ
 SQ9YTDMwUaD658sM7GMeEGfHwQ3Tc2vaFgvFLDRp7g6bhi3TQ/hja0YXDPtPTjwmcIA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=TKvj25Or; 
 arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com;
 envelope-from=visitorckw@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=TKvj25Or
Received: from mail-pj2-x10.google.com (mail-pj2-x10.google.com
 [IPv6:2607:f8b0:4864:39::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9F88860B3F
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 21:30:37 +0000 (UTC)
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-396ccb1a98dso917176a91.0
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 14:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790199036; x=1790803836;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bwITO6OwtCfAhgXCS/7HLjWP3HYkwPe7jLHGizHOfQ4=;
 b=TKvj25OrkizdZmtvWNyY8yZ0WwgxncgKr6VTO/x946SByA3sZgDWIECRl643Qe8cD0
 je6ee14oCBrrlcGB6wsrKJjm3xUv/biukPT/8/pGhwxbr9wV5dG4NqjONI+rXqYUGV8j
 bc+uAhnVK8Ay94gP8huCFinvU1ny6yDyKKmyq8Crhq4nVjJ2Qf+SsaeehM96hleU6P58
 YoZaY2JISZoBmxOPs1CG4+GI7QPs4g0WmMmtXr3rp8eE6yTZ90Plh2oFOu4c4HuDZa2N
 Lpoa2VfW9rufRI0CGtW577of/jj4ya8YbaqgNNJJFsf0m80V1yxkquMplDUSr202lhPZ
 qUlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790199036; x=1790803836;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bwITO6OwtCfAhgXCS/7HLjWP3HYkwPe7jLHGizHOfQ4=;
 b=WoG3UT75x4Md1EIE99sbiDsb/0iwg5/0dHF8sK+wDqHIl/Tze2ddHFcOTorpg1RQi/
 Hfyr59fnmLwzH/BGNlisLIzLI19R+I1+a/uiWOkl+fpuTrAeVMZxe4RLIX9UEoHSIs1+
 v++THJMI22Eq6cW9/mh0f2DsqevEXVpf6jQJ0ISJuvgaFOHQWCBEcITfNldcKeotNKLE
 POREAbRBttvoXs0SXgVpP+WhfN6FY51qOuhUqbU8MjoJPeECZkm7IKRWc7Yw5aiNzgdi
 dcGmfBK5jU+SPx5znHMiqlh9IAaNDgZUSqJmn9qMDd/PsvqemNti6IopdmcwQf+hEqo/
 HNvQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwQoRrgbHd1HvZybHHMKgsYD/DvySMBHcu61SwILJs0mCIupMBBW1vAcxstpAKcbiXOADB0KwM=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++k+mRmbqujSUPg+J5mfSwTMvCtFgy1TCBg8/t4zie+f2gX7M2wb
 2wjxSFdFlVaH3HKA443mIfcDKSW53q3N9I0/ZFWOmuotYPRnJoTRJu/e
X-Gm-Gg: AYBFou1A5acBIw8iMdnC+NLrnQgLRjcoqfF5bDiZJjgPcjwdnpLGGPnO9h2r4wUC/UM
 VbUSELrEfIKHR8WbCc3JoaTUv49PIJ1Yg+c8GFwq0hACTcC3jYIgM1lvOhzhNqYIu4kmfllpnfp
 Qs/Ur7UkDEzB1+96QRsuzZHY8ep9m93l3GozTXsukQC90wt6lbX73fkmVzCmHV30djw9a0/rnpx
 yufZjGHVmEKBkcdD6EzWU6BnP8BKtWoI4sLDV/h9wpFE8cJtyaKmM8+BriT1u0kQvglgUyl4iPm
 Uq2gxLhTZBJ3wpzP2TFfxT2hF/qkP4sAIJaMlItXDjsL9cjqGIngP6JtpgHXXGJAe7tgguNOv+3
 wM0Asi8MgREubkJg/+GoZPl+HROD4jMAvJho6PimEZSL3ZsXrzVDDtsMmAeYXnzF5hfPY17mwP2
 avcETK4Gzme7e288wLpX7vTmtHbwwqAXJVWQRdsKZKz/A0YRE3iEh9iNfVTy5DFzJj119UTjYGh
 n0Edh7uryz+4nfxP8T2dsByDFN4qbLPxgbdWCSMw8cz63NZsLcW32eZ4WhMNGRMsRV2PQR1RYon
X-Received: by 2002:a17:90a:d607:b0:39e:6c6a:656d with SMTP id
 98e67ed59e1d1-3a09896a58fmr326495a91.48.1790199036489; 
 Wed, 23 Sep 2026 14:30:36 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com
 (202.176.229.35.bc.googleusercontent.com. [35.229.176.202])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0973c4fb4sm909513a91.17.2026.09.23.14.30.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 14:30:36 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: trini@konsulko.com, tuomas.tynkkynen@iki.fi, bmeng.cn@gmail.com,
 sjg@chromium.org, jerome.forissier@arm.com
Cc: jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, marscheng@google.com,
 u-boot@lists.u-boot-project.org, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v3 0/6] fs: Add 9P filesystem support over virtio
Date: Wed, 23 Sep 2026 21:29:56 +0000
Message-ID: <20260923213002.1070404-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
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
environments via virtio. This is useful for loading kernel and
initramfs images directly from the host into the VM during development
and testing without having to rebuild disk images or set up a TFTP
server.

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

Changes in v3:
- Return received byte length from virtio_9p_request() and check it
  against the reply header size in p9_request().
- Call virtio_del_vqs() before virtio_reset() in virtio_9p_remove().
- Use double backticks for literal text in 9p.rst.
- Assert expected error strings in test_9p.py negative test cases.
- Add doc/develop/pytest/test_9p.rst.

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

 MAINTAINERS                    |  12 +
 configs/qemu_arm64_defconfig   |   3 +
 disk/part.c                    |  16 ++
 doc/develop/pytest/test_9p.rst |  10 +
 doc/usage/filesystems/9p.rst   |  55 +++++
 doc/usage/index.rst            |   1 +
 drivers/virtio/Kconfig         |   7 +
 drivers/virtio/Makefile        |   1 +
 drivers/virtio/virtio-uclass.c |   1 +
 drivers/virtio/virtio_9p.c     | 120 ++++++++++
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
 net/9p/client.c                | 415 +++++++++++++++++++++++++++++++++
 net/Kconfig                    |   2 +
 net/Makefile                   |   1 +
 test/py/tests/test_9p.py       |  82 +++++++
 27 files changed, 1238 insertions(+), 1 deletion(-)
 create mode 100644 doc/develop/pytest/test_9p.rst
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
2.56.0.rc1.310.g51773c2048-goog

