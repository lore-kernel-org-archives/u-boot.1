Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC199C7115B
	for <u-boot@archiver.kernel.org>; Thu, 19 Jun 2025 08:34:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D398382CCE;
	Thu, 19 Jun 2025 10:34:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="LjkoaDwz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE7A782CCE; Thu, 19 Jun 2025 10:34:23 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98FC982B18
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 10:34:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javierm@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750322059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/bFhdaNHSWvZPudcCmaWgQmgWV3NMDVI2AFe/2bj7PY=;
 b=LjkoaDwzE/h4UVxG6IKkPbf/f1pPS0MkIZYMgdkTZW5vSh0vc49gl/lKGhDx9XM95gJwHY
 epqQG13DFLIO+HfISlIxM9UkkVgOAOdFlxBuXWB5o0SOOIOqAdm2O4zMiRp6YJFlqN+vqB
 VtPQ/m71UqFVQ+/eiXtNrc3ng1mRezE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-nM6v48VeNCeev2dfxqbGyA-1; Thu, 19 Jun 2025 04:34:18 -0400
X-MC-Unique: nM6v48VeNCeev2dfxqbGyA-1
X-Mimecast-MFC-AGG-ID: nM6v48VeNCeev2dfxqbGyA_1750322057
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4f7f1b932so348899f8f.2
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 01:34:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750322056; x=1750926856;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/bFhdaNHSWvZPudcCmaWgQmgWV3NMDVI2AFe/2bj7PY=;
 b=AISa3ZKbIAawgzuA6BtoAPEuSQSVJ5fRUtNjTTZUKKw5dh48Th7NkGaaXiXyoPKA0E
 j/44VTpissnxSfkF2wI1NvNaN00R8wctSaitA5NdyU/oaon2yVw01Oftz7+YbPEbT0nj
 9vG3Sq4JYykr0g6Ian1Pnz6qe7mG6ieCq/oTRTt56C5lxF8wAraZPKkMtZGbB0iIST2O
 VSy4RFIHN/ZZtmi9H36Bet3yJ+/rNlBnOLBm6pIDHmPBK88gkNqNp2HnzBEdQiWqumFr
 yP3xNFUzwALjn5JNfFXDNzy5/1de36UupKjz1P93DWi8yrtvXAtK4L/vUEZ+vVpkrvCQ
 zobA==
X-Gm-Message-State: AOJu0Yz4USF3hNMmW271z6CBeinD3r5CiP+8lNIsANArv1xHy5lu+JJ4
 bEFvQ3kJtH/eBtj+9cG1gvXY/4qnLzSiifhhKLPyI0FkTgSUAdEiogDPEBqSKaxX+ZGrOwN3ffJ
 LXCWysWRRGHmFGUS92yeYvvFyvALjimq1/9NKAUMrcBvQap28wsSU3HjNW0ElztjEZLeBHqeEcn
 mHeXcW7GYif5pvTpe65ibEZ7NA9GeVkO3+8fGfbw==
X-Gm-Gg: ASbGncsZyuFEWwTTGQkjwQ4YdQdCELZSgHe+DwcFYzGbSQaKgJ2EtcMWP2AyBTuPeEh
 n671hSg/4ZOUxLVuYBBkG1gpIhaBaPh8yfH8l5n1LgEfoc9CR7gYfzWXkCGnDc9ju0kmWdY+wyq
 JYNHGrpyXLUVhNz7ite5MmS5ngjxxQ8w9G6rGDojnCg1HLrA5z2BOT6yy7qxZc/WzvqYFgUMbQf
 wvGDjuOFK2jEeFPsX7WtCvpPBVInHWEgpjVnKmLkXN9MdeKwrIrb5sSPAAaA+FBsq5xo0Avm+CA
 Vcv37sVFNAE+NzlZW0bbk51wD86v/zvoxqJQRe9P1FxkWplsyNaW
X-Received: by 2002:a5d:64c2:0:b0:3a4:fbd9:58e6 with SMTP id
 ffacd0b85a97d-3a572e56e89mr16116487f8f.50.1750322056420; 
 Thu, 19 Jun 2025 01:34:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgPU1X04muCY5b3tijud+Fqc5/zeZ8eU/eIbhgL9+v3I/RdfMBaICHOpKhgD6mvsjWoWnLeA==
X-Received: by 2002:a5d:64c2:0:b0:3a4:fbd9:58e6 with SMTP id
 ffacd0b85a97d-3a572e56e89mr16116444f8f.50.1750322055833; 
 Thu, 19 Jun 2025 01:34:15 -0700 (PDT)
Received: from localhost (35.pool90-77-212.dynamic.orange.es. [90.77.212.35])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568a54af6sm18709366f8f.6.2025.06.19.01.34.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Jun 2025 01:34:15 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: u-boot@lists.denx.de
Cc: mripard@redhat.com, mskrivan@redhat.com, Tom Rini <trini@konsulko.com>,
 eballetb@redhat.com, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 alexl@redhat.com, mkorpers@redhat.com,
 Javier Martinez Canillas <javierm@redhat.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Casey Connolly <casey.connolly@linaro.org>, Heiko Schocher <hs@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Maks Mishin <maks.mishinfz@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v3 0/4] efi_loader: add EFI_PARTITION_INFO_PROTOCOL support
Date: Thu, 19 Jun 2025 10:33:58 +0200
Message-ID: <20250619083411.2214491-1-javierm@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3KEi5EjiB3XOh_fQjVXcchRFzcZ2ZL-0559DzO-ltZs_1750322057
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

This patch series implements support for the EFI_PARTITION_INFO_PROTOCOL,
to provide cached partition information for GPT partition types.

The EFI specification mentions that the protocol can understand legacy MBR
partition types, but that's for backward compatibility and not implemented
by this series. It can be added as a follow-up if needed, to make it fully
compliant with the spec.

Patch #1 moves the logic to get a GPT partition table entry to a helper
part_get_gpt_pte() function.

Patch #2 exposes that helper function to be used by the efi_loader.

Patch #3 implements the actual protocol support using the mentioned helper
to get the GPT partitions table entries.

Patch #4 extends the existing block io EFI selftest to also check for some
cached data provided by the partition info protocol.

This is a v3 of the series, the v2 can be found here:

https://lists.denx.de/pipermail/u-boot/2025-June/592550.html

The EFI_PARTITION_INFO_PROTOCOL implementation is added unconditionally,
because the u-boot-size-test.sh reports the code increase is negligible:

    ./u-boot-size-test.sh qemu_arm64_lwip --all
    ...
    01: Merge patch series "list.h/treewide: get rid of no-op prefetch()"
    02: disk: efi: Move logic to get a GPT entry into a helper function
    03: disk: efi: expose the part_get_gpt_pte() helper function
    04: efi_loader: disk: add EFI_PARTITION_INFO_PROTOCOL support
    05: efi_selftest: Add basic partition info check to block io test
        5    0    0 /5              qemu_arm64_lwip
    Completed: 5 total built, 5 newly), duration 0:01:57, rate 0.04
    /tmp/qemu_arm64_lwip/add-efi-part-info-proto-v3/boards.cfg is up to date. Nothing to do.
    Summary of 5 commits for 1 boards (1 thread, 8 jobs per thread)
    01: Merge patch series "list.h/treewide: get rid of no-op prefetch()"
    02: disk: efi: Move logic to get a GPT entry into a helper function
       aarch64: (for 1/1 boards) all -64.0 text -64.0
                qemu_arm64_lwip: all -64 text -64
                   u-boot: add: 0/0, grow: 0/-1 bytes: 0/-72 (-72)
                     function                                   old     new   delta
                     part_get_info_efi                          468     396     -72
    03: disk: efi: expose the part_get_gpt_pte() helper function
       aarch64: (for 1/1 boards) all +32.0 text +32.0
                qemu_arm64_lwip: all +32 text +32
                   u-boot: add: 1/0, grow: 0/-1 bytes: 200/-164 (36)
                     function                                   old     new   delta
                     part_get_gpt_pte                             -     200    +200
                     part_get_info_efi                          396     232    -164
    04: efi_loader: disk: add EFI_PARTITION_INFO_PROTOCOL support
       aarch64: (for 1/1 boards) all +176.0 rodata +16.0 text +160.0
                qemu_arm64_lwip: all +176 rodata +16 text +160
                   u-boot: add: 0/0, grow: 1/0 bytes: 148/0 (148)
                     function                                   old     new   delta
                     static.efi_disk_add_dev                    636     784    +148
    05: efi_selftest: Add basic partition info check to block io test
       aarch64: (for 1/1 boards) all +531.0 rodata +179.0 text +352.0
                qemu_arm64_lwip: all +531 rodata +179 text +352
                   u-boot: add: 1/0, grow: 1/0 bytes: 384/0 (384)
                     function                                   old     new   delta
                     execute                                  36428   36796    +368
                     partition_info_guid                          -      16     +16
    (no errors to report)


Changes in v3:
- Add ifdef guards for {EFI,DOS}_PARTITION being disabled (Ilias Apalodimas).
- Fix build in -next due missing part_efi.h header include (Ilias Apalodimas).
- Rebase on top of -next (Ilias Apalodimas).

Changes in v2:
- Add a test for the EFI partition information protocol (Tom Rini).

Javier Martinez Canillas (4):
  disk: efi: Move logic to get a GPT entry into a helper function
  disk: efi: expose the part_get_gpt_pte() helper function
  efi_loader: disk: add EFI_PARTITION_INFO_PROTOCOL support
  efi_selftest: Add basic partition info check to block io test

 disk/part_efi.c                              | 67 ++++++++++++--------
 include/part.h                               | 14 ++++
 include/part_efi.h                           | 20 ++++++
 lib/efi_loader/efi_disk.c                    | 39 +++++++++++-
 lib/efi_selftest/efi_selftest_block_device.c | 30 +++++++++
 5 files changed, 141 insertions(+), 29 deletions(-)

-- 
2.49.0

base-commit: ce2a7fcbd565d55b1d3fdc0e68edd50a21eca7d4
branch: add-efi-part-info-proto-v3

