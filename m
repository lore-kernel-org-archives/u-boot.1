Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF65C5516D
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 12:40:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D098860B69;
	Fri, 31 Jul 2026 12:40:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rmEzrpyxEI2f; Fri, 31 Jul 2026 12:40:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7010260AD0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785501637;
	bh=VQlvFNfjaRTnpQMUTzlWkCtETRvg3ueiHU844wGMBuE=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Vt9gtJSSiy+UCSgvCyXpcI+sP6kgnu/nyFFR+SRND7smJwjCR1iHgOKN6YgBClAHp
	 351K3bbUOHgpwHW8aaSmCJ8ke/0WLJ/kbKUcumTBAwjVNNLxZPlmXO3QoCFORGMGu6
	 VWwnTAvdIU6ccfMCT/BXpvuycoX6GlPJGlNj9NgIe2qG4UFvskEvrQ+2IKvmzUa5G5
	 OUF7UOIwhnVXIV5k7I2mEVKr+BVO1N7YOefQy2at3SkuN80cJJVlVNYQU32w/cFTly
	 M4QyL7hyiNw/ZLCuUanEKV775wRpbEjDEIzkO59X5SBMq0IkyDW8xwLK3r6YNKZXyJ
	 qfTkElDirsypw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7010260AD0;
	Fri, 31 Jul 2026 12:40:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9310869
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 12:40:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 84ADE4047C
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 12:40:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ysr8negjebUk for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 12:40:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42a; helo=mail-wr1-x42a.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 9EC5840471
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9EC5840471
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9EC5840471
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 12:40:34 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-4758bd3731bso944122f8f.0
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 05:40:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785501633; x=1786106433;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=VQlvFNfjaRTnpQMUTzlWkCtETRvg3ueiHU844wGMBuE=;
 b=TYrT5XkRCXlbeC2S6FmsyqmRujrOpIqs3UeA4QmN8wxAKoIrG72iFITSwUct9rgy/x
 xUELFnxYVlz4d2zYnkHqi6LHvAe0W2hEj15G4DRdq3Cqevh+4zfG4aWfSNRGIVfuiW9D
 iaWnjO5oKwtGzomjEHjU+zuTURCOt9kYVrypnVb5LUDWwf4d6UsGOIR7+vFh4Tw24aKP
 IVAOX/QARqkfw0ZpFSEPMSWlFrue6PezmWew0zz9dkoU7u39q+4+ZN9KDvpyURA1VuDz
 lAmVs5K/VFo3bVP7CytcASjcXnIfqG85CizD5UD5ooL1QLLNpjvgs9dib1N1LoRp/U/5
 t3aw==
X-Gm-Message-State: AOJu0YyOhujJSl/yrP5mKNRdwvGc8FwxANR/DXMhTk7zLoZeKd9COuVg
 vnHktqnEnMyZhkRgKGmztGqzyDHJ3OQhKWX1p3RisNftEOwfjRy3qWFUYNm6JfKZIU0=
X-Gm-Gg: AR+sD10H+X8WbMDljtiUaAgSkqPaW3pDQk1tGLHcGZsEbk1Gm0WhabusP7yPlLXN5Ae
 sksZGzwA1q0sMPhZ/RFFspp6jzek/pahcm4EAMI8ILtKZPadSyJo8T852V6sXD2nsyYiFgxM7pi
 SfCWrqIfKIBP6dCp3PKMydgDEbynaQsyGjqGwKJ5bvc4ovCa5bExV8XumNkoeIEqui7YAwvubPF
 RwmXReM/21yIuLMHXEnDcsSUKQf26PuJdbTGNYNOCgpj6ayCJzzF6cjezTvMTWBDxOkCBPNkN1O
 aWoddPQ+bkyLU//KpD+92muTdi01XByu8ojNayhFbQC7IQTObEJKDPBG4eqWIOhF9m0zI59BPa4
 u24ScNkWGfsLlzJ8l8aRSPFIXhvf23nb3w+DuA7KxeXVadjR8ChsNGeaBDKgFRs4Mj07JBw4Hi2
 EivdHR3BXS2l16/nUR+0avVLJxtBv/xD2JbIb19SHsa91HDOrRqZB4DQWIQkePcC/6Wm7fwo6JG
 trzD6sCIeS4kU5xzJyBQwOr6PDQ4abQhnvzy6vcLA==
X-Received: by 2002:a05:6000:22c5:b0:47f:8b0f:7172 with SMTP id
 ffacd0b85a97d-47fd32b09d3mr3977617f8f.6.1785501632621; 
 Fri, 31 Jul 2026 05:40:32 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-92-99-174-41.alshamil.net.ae.
 [92.99.174.41]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd41e296csm4493682f8f.12.2026.07.31.05.40.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 05:40:32 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Subject: [PATCH 0/6] disk: Fix the GPT layout on media with large logical
 blocks
Date: Fri, 31 Jul 2026 16:39:59 +0400
Message-Id: <20260731-gpt-4k-v1-0-a3f1f16b53ae@flipper.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDc2ND3fSCEl2TbN00iyTLVOO0xBQTcxMloOKCotS0zAqwQdGxEH5xaVJ
 WanIJSLdSbS0AqUvvV2oAAAA=
X-Change-ID: 20260731-gpt-4k-f8b9e3fad474
To: u-boot@lists.u-boot-project.org, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Tom Rini <trini@konsulko.com>, Anton Burticica <mouse@ya.ru>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Simon Glass <sjg@chromium.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Jacobe Zang <jacobe.zang@wesion.com>, Jagan Teki <jagan@edgeble.ai>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, Jonas Karlman <jonas@kwiboo.se>, 
 Suniel Mahesh <sunil@amarulasolutions.com>, 
 Klaus Goger <klaus.goger@cherry.de>, Tim Lunn <tim@feathertop.org>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4092; i=alchark@flipper.net;
 h=from:subject:message-id; bh=d9/h7e7+XaFFQA4mKZ5GkNrYJtODipHxb8xBHipURbQ=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTlTN+o65oxvziDReLICTbfJZnOJ9ZtmbGoqYZ7ReQxh
 3bhjw+1OiayMIhxMViKKbLM/bbEdqoR36xdHh5fYeawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 QyMdYx0jBi5OAZhqnp0M/53rp+yy3aFSZrGp41rOsiX+v8y1jBQCd17uLumTybBepsXI8Hin+fe
 fzUs5vNP/rVFw2/l78TJhbo6j19tTitjMrn4pZQUA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1785501633; x=1786106433;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VQlvFNfjaRTnpQMUTzlWkCtETRvg3ueiHU844wGMBuE=;
 b=g0ZM1u68KeaXonVFb6l3wKSVkJVeiabC90HsBydatwKj1kgiTghRcZ8y6RwPSsL4ll
 g3XWHT3N+VBVIaIj4w/bA4Da+rhDEXhHa9bxq4sZJUSo6GT3mOm3sFNetDvbgRpQ1BOu
 gcOjX1ZoShCq12R2O1LiN74Y1psaRXnLp13d9zUTn8KKZ6bI4Cay7RlMW+8iWf0iV4bB
 mqj7N42EjaJ/Wso83Y4s+GArBBLvONUZFMfBhBoO+proANJ57DWtXKeMOya17nK93hHF
 I/s9YnSslnTBT6ELx6dI8dX+il0QpF4CNOWefUi2zw8/LlPpzpm04yT2XpcMxXSStSDt
 E5dg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=g0ZM1u68
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The GPT partition entry array is sized in bytes by the spec, so the
number of blocks it takes up depends on the block size of the device.
U-Boot got that wrong in gpt_fill_header(), which reserved a fixed 34
blocks at each end of the disk. On a device with 4096-byte native
sectors, such as UFS flash, the backup entry array ended up 28 blocks
short of the backup GPT header instead of immediately before it, and
roughly 114 KiB was wasted at each end of the disk.

Patch 1 calculates the count from the block size and makes the four
places that need it share one helper, since they disagreed with each
other in different ways. Note that it also changes the 512-byte layout
for boards that do not use the default entry count:
CONFIG_EFI_PARTITION_ENTRIES_NUMBERS is "default 56 if ARCH_SUNXI" and
is set to 64 by a number of Rockchip defconfigs, and on those
first_usable_lba moves from 34 to 16 and 18 respectively. Existing
tables stay readable, since the entry array is always located from the
on-disk partition_entry_lba, and only newly written tables are
affected. Partitions given without an explicit start= will be placed
lower, though, and on sunxi first_usable_lba lands exactly on the 8 KiB
SPL offset, so sunxi and Rockchip folks may want to look at patch 1
specifically (none of the devices I have override the default).

Patch 2 is an unrelated big-endian correctness fix in the same file,
noticed while auditing it: a few header fields are read without
converting from little-endian, and one already-converted value is
swapped a second time.

Patch 3 is another unrelated bug that has to be fixed before any of this
can be tested: part_test_mac() reads one block into a 512-byte on-stack
buffer, so it corrupts the stack on any device with larger blocks. Since
it runs during partition probing on every device, sandbox crashes on any
access at all to a device bound with a 4096-byte block size.

Patches 4 and 6 add the tests. The C test sweeps block sizes from 512 to
32768 against gpt_fill_header()/gpt_fill_pte() with a synthetic
descriptor, and the Python test writes a real GPT to a host device with
4096-byte blocks and checks the resulting on-disk headers. Both fail
without patch 1.

Patch 5 is a prerequisite for patch 6: test_gpt_write_part_type() never
binds its own disk image and has only worked because an earlier test
left host 0 bound, so it breaks as soon as a test binding a different
image is added above it.

One known gap: test_gpt_write and test_gpt_write_part_type hardcode the
128-entry 512-byte layout, so they fail if sandbox is configured with a
different CONFIG_EFI_PARTITION_ENTRIES_NUMBERS. The new tests derive
their expectations instead, and pass at 56 and 64 entries. No sandbox
defconfig upstream uses anything but 128, so I have left the old tests
alone.

Tested by building sandbox (default, flattree, sandbox64, gcc and
clang), generic-rk3576 (gcc and clang), sonoff-ihost-rv1126 and
A20-OLinuXino_MICRO-eMMC on armv7, and boston32r2 and boston64r2 for
MIPS32/MIPS64 big-endian, which is what patch 2 is there for.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
Alexey Charkov (6):
      disk: part_efi: Size the partition entry array from the block size
      disk: part_efi: Add missing endianness conversions
      disk: part_mac: Fix stack corruption on devices with large blocks
      test: dm: part: Check the GPT layout for large sector sizes
      test: py: gpt: Bind the disk image in test_gpt_write_part_type()
      test: py: gpt: Test the GPT layout on a device with 4096-byte blocks

 disk/part_efi.c           |  55 +++++++++++++++-------
 disk/part_mac.c           |  12 ++---
 test/dm/part.c            | 100 +++++++++++++++++++++++++++++++++++++++
 test/py/tests/test_gpt.py | 116 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 261 insertions(+), 22 deletions(-)
---
base-commit: 100e12ea78c73071b9710f08b32fd4590019266f
change-id: 20260731-gpt-4k-f8b9e3fad474

Best regards,
--  
Alexey Charkov <alchark@flipper.net>

