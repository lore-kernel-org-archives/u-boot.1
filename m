Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC53B606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 12:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZNW8hB+h;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AJmJ9uRL
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9564060739;
	Sat, 24 Oct 2026 12:16:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1CUuUGLTen2u; Sat, 24 Oct 2026 12:16:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C11D36073E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792844195;
	b=drxB0k1j6be50hQ+RwszfirHSN3uN9qhJda6ug/1k2g8C9hRLU8KS1D3FYfsL5chz9N2
	 Q2E3TGogGeuxShJZqZn+xYLh/FkXEPpVgquBy8Z0AdI0D96x3WAJGnj7BzqPjGvvPimpB
	 zF5B9catyGu1evKQ0OR81sfC8Via9jDRuNF/pivBVIYUXCL1KXu+3CY6wXcmEp/9Ut+FO
	 OrCSyHpC/J18TezFLqXBsvpz2D/4uY+87xjuiJpogfvhMBh7B98uSK7lXsRuaeZbzrJX7
	 dUm802g1C2I4dUSZ6YpBtZldwr+KQmJYvXKNwmC7qPK2uFn311edjOxTRlf0wOjAG1g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792844195;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=nBzyIO6i6JGdACT3CFO+eVgZLcix6DEV2QtLH6NPNBM=;
	b=hcBwvaCWWLmJ+cMvtw5GHq7JzazonUCfstjhU8csDepSFrzzlawu9Ibi2z4TnCBN5NJE
	 uxG9L0JeuTQBbhaziCVg6xAr9IssVKAEK4bX3sN9i0Tcq8TUJ2KMwdYkpcBk+DNF4qBRd
	 2/t2jNpYbWa8ZL+8CBFnfQGvWLoDZJbGJXwUJoNqwLAeq6ZxcLikaXXBAWqPRWbUYWdXH
	 4QNfrpu/hMFFticOpDz0oQHPzglrDiMgsA2Ndsvgb2cBedMGxFXHI7v2eMJZm8FVivwGL
	 Y7cqm9rEHZH3rTOEd690mUw+wnAIepDGMWRG0u1v65/Ya+fnPJImoPdjTJy0P08+5UA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792844195;
	bh=nBzyIO6i6JGdACT3CFO+eVgZLcix6DEV2QtLH6NPNBM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ZNW8hB+hKIDJ8E8bniRRoBqO5Xp6m/8i58HNd16zzJdrsGWNWPdSRI+eEuH3SX5n0
	 0wegD7bmjtGmyo6m9CwZJHnIIBti7qtvfNtlu2wUeYKMdUYu+tg8/FqAtO60UxXPPR
	 G54yRZENQQs4TmkLOZvUMGZThcaXLs8piCKYb+MMNRn7U+xdRW1Xf1lnxzeJRNXVZy
	 HFvxyaREuSSPqNrRM3tnP4/92VWucneuluvAD3vILaUwiLeHQobjB+Xm811lwlgerQ
	 lmwBm7jdyO2fOdSyygnh4G64Ca388TDF1gxMR2JdxAliJHo2GyWRRcIOH0RT5bmrN+
	 Sv7HVZKPqu4QQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C11D36073E;
	Sat, 24 Oct 2026 12:16:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C786B279
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 12:16:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B9570400E0
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 12:16:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wWGfu_Gp-uEO for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 12:16:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A3D3B400D5
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792844194;
 b=Jai4Pasw7sDWoegGXBAeGvTtsB7hhIlcfTP7GbN0wAK3Vf/TBhClz3i7PqB4xqk+m6xp
 EuBETE2zNUn6Acaz1sybgF0fj1mDPKVEbqDxPCsBhk8qnOkubJcT3JxkIyboqc7x8ZiRh
 qS4nrkp390mPJVjTcsb0xFH3dML+xsR+5BJXkYO0NySu+E4kBVX2clsBtITxKpoZfv33q
 YvccG4UChIB7YQ4QUbHV/MJa4Ehg1cltWyZQBy3zRoQLehPl/T5nzGXAqbcML238LhTKA
 2jCXyGC1dGubyopThH2bmwSH0Mi2s1WqHEx5mnaF8chhrxXPE4/7RQwSNtR4gAGAkSA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792844194;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=nBzyIO6i6JGdACT3CFO+eVgZLcix6DEV2QtLH6NPNBM=;
 b=Q4SRwheKsMcu75MauciPW5Vl2q5pxn1/cpQbPdrlsRJqfOu1/Ydax6D4IOzEgmiEo4D4
 8z/NhqftvHdlnoeQvgeefTOciVDa7vB1l/23mnNO5uq7Qh6KAuurqPL7AnEfxrSnNZhad
 OVIXrE/+TOckNf3mCNcd0jMq3NeicYntMWn1U45UtbeIFi6aHRDZn3jqauGwXG5yK8RS+
 I3pwqQBsV5IYtNqmrT8/lKltBXXdlKUqIhRzssMwWdIEuWqxNjUDYAkRQJZRV7G1mEu/K
 CyfjnJnyxQV+44W/Z2TpzAJ5UaiUFZ6dWLIiToGi/c/1xR4PlvPCdwUryabxC3XNUNA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=AJmJ9uRL; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=AJmJ9uRL
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A3D3B400D5
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 12:16:32 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a2069b9710so15504205e9.2
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 05:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792844190; x=1793448990;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nBzyIO6i6JGdACT3CFO+eVgZLcix6DEV2QtLH6NPNBM=;
 b=AJmJ9uRLMnxBUJ0eYXnKfMB15rC1T/sfuKv9jhw6bcqkA+1F9+0PpOXAUC/y9ydEfr
 VPh6r7zwUECPmjQzHVQu6QRrucQ/gD/Z84ZWpJeteaOxqUwQ9Mj4Wd2GdKMgof/1XUqL
 qzHdGutl3Bjoyvouw4/SzzlVPUXXPJKnhA6qrUASDzML/Dr+x8bqgrbSq156xeEON/1l
 Renka13zCvYDy7F6F/6UmsL+N3gX1vFADX3yzTrq6UJPYzIIMEj3vs1ttTWWpdBO5+qI
 BIDFpmXbGdfTC0A3+6QUlOpd0WnxHSQWBUGr9AyRZRYEXLFJM35RPLgwTdH7ypue1Xdy
 9vQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792844190; x=1793448990;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nBzyIO6i6JGdACT3CFO+eVgZLcix6DEV2QtLH6NPNBM=;
 b=f8a3LhvGrKYTK5aetvrJk75025WiVWtZypHvJ/O6WO868s8yOFhez2O+cCJNZsvLRa
 oL5OPxX8sjSaGEJVsxmaWYHd4lpOUP5lBMnt6q+k7kXLZP/hI477GTl5cohN11uFrUUz
 Itj/nT3J5y7IhdGgCzaj+JdaBxPB/EvB7F5uy8uvbjzpia/3Keg5tK/4bNw1EVbGjCa3
 iPhi3PypBzmFWPrx4W20r3JWCbRe3vtli9/zAi2cNlm0WgKHwi/egR1U1QyCKMz07DKh
 sMEhYkZhsorTW2dmb2r9LvnnK9cs5yBy5T58Pyhg6bfJ3NrdSX5OdLryeNP0gj+yh74A
 tuKw==
X-Gm-Message-State: AFq9FYJpygHohdmx26/OHbSeCLViCY6Jm16rDrKQ/X5g9O8hUVxo/IK0
 ttnn2yrEZj6ctAFncW5QsPpcHigQnFIvOk0AH8TYxzlR/RbqHZu/1wPPrVHkfEd3
X-Gm-Gg: AYBFou2Q/WdrDL0nS8i6tRPaLrh+gSnuzkcE+Un1cjrQkhfM82B0sJyzfxLftoos1uz
 gZCbgKxhD4pbXR2R0KZlg6RXhub8a08L0H3KxrPrbtpCp29dbqINWRIHJTpLX6rSoLR3uqhfFz1
 8BNuzwIj7QSB9ZHDwhdFpH6f/EpoiLz8XtTFnosUtmuB9nCyiSiZnnFdP/Nf8CyyRg0EDM9IOEX
 +OCLr75tkJV7gH8NJKvtRCwvZhg/kV8KvpglBzOi4RGMQ62b+7DYVZpuI2+Ou5Gt4tvE0iscY4W
 BmaP1GT3Tt4yhA/G2vfoDPdz6/+HssIt7/CXANlzpnhU9UQmYWANNV3AXTMpnhMkUYefN0l/4ic
 cSAGp6QYWtFUORouacdcgNxJFom5jE8lrUJyM7UN8rNZO0yFkDH1hopWCN+xFlBrte+Da56nb2j
 pgz4ENDVFf4ACAa+6ylUBu0Qe/eTcdpjV3LeKiMd7kimmKG325d6nF25zEhjFzMUTptRozwRVPJ
 vpeXTbvBpygM9SFwk34oBLTQLqbqdQmFpluvgsSEcJ4lcHCLYYi0wIs6w==
X-Received: by 2002:a05:600c:1f94:b0:4a1:e774:370c with SMTP id
 5b1f17b1804b1-4a35acbcaf1mr26253735e9.30.1792844190099; 
 Sat, 24 Oct 2026 05:16:30 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a5697a7sm47767725e9.7.2026.10.24.05.16.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Oct 2026 05:16:29 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Charkov <alchark@flipper.net>,
 Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH RESEND 0/9] block,
 disk: Check block sizes and partition tables of devices
Date: Sat, 24 Oct 2026 12:16:28 +0000
Message-ID: <08c6c3f7-4241-40ab-8a60-383b9408b6b3@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is a resend of the series posted earlier today, now with the
patches inline: the first posting carried them as attachments, which
b4 and Patchwork cannot use, as Heinrich pointed out. The patches are
unchanged and still apply to master.

U-Boot scans the partitions of a block device as soon as it probes it,
and takes several sizes from the device and from its partition tables
as they are. A USB stick or SD card that U-Boot merely probes can
therefore make it read or write outside its buffers. This series checks
those sizes where they are read.

Block size. A block driver sets the block size of a device from what
the device reports, and only the virtio block driver and the host
command check it. The partition and filesystem code sizes buffers by the
block size, expects a block to hold a 512-byte boot sector and converts
between bytes and blocks with log2(blksz). So a USB stick, SCSI disk,
ATAPI drive or NVMe namespace reporting a block size below 512 bytes,
one that is not a power of two or a huge one makes U-Boot read or write
outside its buffers, in the partition scan run when the device is probed
and in the filesystem code after it.

Patch 1 adds blk_valid_blksz() and has blk_post_probe() refuse a block
device whose block size it rejects, which covers every block driver.
Patches 2-5 check the block size where the USB storage, SCSI, IDE
(ATAPI) and NVMe drivers read it, so that each refuses such a device
cleanly: the USB LUN is skipped instead of failing the whole stick, no
SCSI block device is created, the ATAPI drive is treated as one without
a medium and the NVMe namespace is skipped like an inactive one.

The upper bound is 64KiB, the largest logical block size Linux accepts;
the GPT code is already tested with block sizes up to 32KiB.

Partition tables. Patch 6 checks the header size and the size of the
partition entry array of a GPT, as Linux does, before they size the
CRC of the header and the entry buffer. It leaves
alloc_read_gpt_entries() alone, so it applies with or without Benoît
Monin's "disk: efi: Reuse the GPT entries buffer with simple malloc".
Patch 7 walks the chain of DOS extended partition tables in a loop,
bounded by the number of tables read: a table linking back to itself
adds no partition, so the limit added for CVE-2019-13103 did not stop
the recursion. Patch 8 makes room for partition number 256 in the UUID
made up for a DOS partition. Patch 9 has the TCG2 measurement of the
GPT check the primary header it reads itself with validate_gpt_header(),
now exported: the partition driver falls back to the backup header when
the primary one is not valid, so the measurement could still take its
sizes from a primary header that the driver refused.

Patches 1-3 and 6-9 add tests: DM tests on sandbox, for the GPT a test
in test/lib on a blkmap device, and for the TCG2 measurement a test in
test/py that starts an EFI application from a GPT disk on sandbox and
checks PCR 5. Without the series the new tests fail; with it they pass,
as do the rest of "ut dm" and "ut lib" on sandbox_defconfig with
CONFIG_ASAN (but for lib_crypt, which ASan flags without the series
too), and every patch builds on its own. The test/py test is skipped
with CONFIG_ASAN, under which sandbox cannot run an EFI application; on
sandbox_defconfig it passes, as do the other EFI, TPM and GPT tests in
test/py. The IDE and NVMe changes are build tested only, as sandbox has
no emulator for them.

Ana Bobillo (9):
  block: Refuse a device with an unsupported block size
  usb: storage: Refuse a block size the block layer cannot use
  scsi: Refuse a block size the block layer cannot use
  ide: Refuse an ATAPI block size atapi_read() cannot read
  nvme: Skip a namespace with an unsupported LBA data size
  disk: part_efi: Check the header and entry sizes of a GPT
  disk: part_dos: Walk the extended partition tables in a bounded loop
  disk: part_dos: Make room for a three-digit partition number in the
    UUID
  efi_loader: Check the GPT header before measuring it

 arch/sandbox/include/asm/test.h  |  20 ++++
 cmd/host.c                       |   6 +-
 common/usb_storage.c             |   8 +-
 disk/part_dos.c                  |  47 ++++++---
 disk/part_efi.c                  |  48 +++++++--
 drivers/block/blk-uclass.c       |  15 ++-
 drivers/block/ide.c              |  11 +-
 drivers/nvme/nvme.c              |  33 +++++-
 drivers/scsi/sandbox_scsi.c      |   8 ++
 drivers/scsi/scsi.c              |   4 +
 drivers/usb/emul/sandbox_flash.c |   8 ++
 drivers/virtio/virtio_blk.c      |   3 +-
 include/blk.h                    |  20 ++++
 include/part.h                   |  23 +++++
 lib/efi_loader/efi_tcg2.c        |  16 +++
 test/dm/blk.c                    |  41 ++++++++
 test/dm/part.c                   | 146 ++++++++++++++++++++++++++
 test/dm/scsi.c                   |  37 +++++++
 test/dm/usb.c                    |  45 ++++++++
 test/lib/part_efi.c              | 161 +++++++++++++++++++++++++++++
 test/py/tests/test_efi_tcg2.py   | 170 +++++++++++++++++++++++++++++++
 21 files changed, 839 insertions(+), 31 deletions(-)
 create mode 100644 test/py/tests/test_efi_tcg2.py


base-commit: acc808479730e13e74199119eb9b2b9113999244
