Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A393BC7115C
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 08:01:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE62382C2F;
	Wed, 18 Jun 2025 10:01:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="RCoJJISN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0638482CF4; Wed, 18 Jun 2025 10:01:12 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0767882B20
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 10:01:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javierm@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750233666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=E8PmH3+u/v1k6HqT4A76sRqQa1CoX32NMHUy17l0uvk=;
 b=RCoJJISNFpN4tK5OyJEc8ZedBO59mjs6fhHIvtrzkrVQKtaqgPP46/s1ZbdOn3jynSMcou
 QsXzEyxhLti/aas3O4Pl2sPMVQTfQ4ZmQ6ZMgBQgceYEeWgwAqw5xSj/zNmfSAEb8rddmo
 L/QAikXtravS862+cXd7NlVYRdWFsOU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-kKnM5WH4OtqSIqTrnTlRXA-1; Wed, 18 Jun 2025 04:01:05 -0400
X-MC-Unique: kKnM5WH4OtqSIqTrnTlRXA-1
X-Mimecast-MFC-AGG-ID: kKnM5WH4OtqSIqTrnTlRXA_1750233664
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a5780e8137so229798f8f.1
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 01:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750233664; x=1750838464;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E8PmH3+u/v1k6HqT4A76sRqQa1CoX32NMHUy17l0uvk=;
 b=d2d+NiMHwlwdQiM0onEZZC928a9VVx7Uj9a2Z7FxNJy5TRVwM9N9ALT+EhcSnuvPUK
 HU2oKK2SHiCfkzLFPQV6zT6A2k4dJXJG7SgvLBdm1KXdkqQDAIdjhu295IK21ZeUaKQ6
 pF3b0ia3S6ul3vLikRdhybK50nDv2O63gbksm/wmOKVpDUWXk5Ls7iLMHpHCZgFC2N0E
 yrAgW5Jh18Sz9EzYOsgTUU/0vYaagqcMM7nGDwoZmORk+X0LMsQcOTqoS4EvybC9x0Zt
 60sTe5v3XZ9TWXTdSxra5YvFHv7V/WjxGl9ZuhnlkGpqVBCO5qF0Ey5Jqrj3cwjbVC2k
 08Mg==
X-Gm-Message-State: AOJu0Yy6uqgxKTYKrjpAnwB814j2nJLlzkAci8zBsRg0lmC6xKqy7L8J
 TMgi63zAGjsZHxVL8xBKvPZAocjQAwvdmh1JlfpKjc5bEOO5NgJDqAq6cmjqlREKC0201oUuOHu
 t9KorbBEPvWTKmhasIbtWe+/awO74ExZk1eYcmOOzxjWU773/86jlRHTvP5uzzeiLEjgUTzkVTV
 tnkQ9JlDQnQRzwD+S7jtTEHHU5LfaovLjwD7I0sw==
X-Gm-Gg: ASbGncu8eQtGLLkb2KvUIZnzyFGH1y5dJHCfoOXy8ev3jwPMdGowzO3lmXX4ZULQ0Yx
 hsCdf1WxWYJyS7li4nHYEgjq/q2503aSUViojjlp6Plv2/NVuOJiaMOofrjiS7NP5/9zGpDI4K5
 oxnTLBsIjNimx6JW+v2IZsd9xIrzPIqK4KECLe8C5f5DcLPK5qjVfe/IWW78bIC8QXy4zo2jCT3
 m7N/F5U729fOE8vTvMRwfFFMlEzqxWp5ZuhRh11e+NOQiP1+vY0NL91T+rwXiPLvZHTsgfg+2QY
 GUuvyEFwthmsvG9DmVf+xo05kDSCaZaaWLbUXCn0rhh8VnA=
X-Received: by 2002:a05:6000:2011:b0:3a5:1220:36d4 with SMTP id
 ffacd0b85a97d-3a58e2654admr1185707f8f.22.1750233663769; 
 Wed, 18 Jun 2025 01:01:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjPOQQt7iHZ8xClYGrORR2pcpwXJnVcgLnr7dEtC9MwCyHPv3S32XmU11K1F3KrmztPyWXMA==
X-Received: by 2002:a05:6000:2011:b0:3a5:1220:36d4 with SMTP id
 ffacd0b85a97d-3a58e2654admr1185608f8f.22.1750233662415; 
 Wed, 18 Jun 2025 01:01:02 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568b2a6a5sm16061544f8f.74.2025.06.18.01.01.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Jun 2025 01:01:01 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, mripard@redhat.com,
 Tom Rini <trini@konsulko.com>, alexl@redhat.com, mkorpers@redhat.com,
 eballetb@redhat.com, mskrivan@redhat.com,
 Javier Martinez Canillas <javierm@redhat.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Maks Mishin <maks.mishinfz@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>
Subject: [PATCH v2 0/4] efi_loader: add EFI_PARTITION_INFO_PROTOCOL support
Date: Wed, 18 Jun 2025 10:00:34 +0200
Message-ID: <20250618080056.1973311-1-javierm@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dE3-pOv6YP_uubLnxK6_YspQwrHfNZmVgA4K66J6tYk_1750233664
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

This is a v2 of the series, the first version can be found here:

https://lists.denx.de/pipermail/u-boot/2025-June/592237.html

The EFI_PARTITION_INFO_PROTOCOL implementation is added unconditionally,
because the u-boot-size-test.sh reports the code increase is negligible:

    ./u-boot-size-test.sh qemu_arm64_lwip --all
    ...
    01: Merge tag 'u-boot-dfu-20250616' of https://source.denx.de/u-boot/custodians/u-boot-dfu
    02: disk: efi: Move logic to get a GPT entry into a helper function
    03: disk: efi: expose the part_get_gpt_pte() helper function
    04: efi_loader: disk: add EFI_PARTITION_INFO_PROTOCOL support
    05: efi_selftest: Add basic partition info check to block io test
        5    0    0 /5              qemu_arm64_lwip
    Completed: 5 total built, 5 newly), duration 0:01:32, rate 0.05
    /tmp/qemu_arm64_lwip/add-efi-part-info-proto-v2/boards.cfg is up to date. Nothing to do.
    Summary of 5 commits for 1 boards (1 thread, 8 jobs per thread)
    01: Merge tag 'u-boot-dfu-20250616' of https://source.denx.de/u-boot/custodians/u-boot-dfu
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
       aarch64: (for 1/1 boards) all +144.0 rodata +16.0 text +128.0
                qemu_arm64_lwip: all +144 rodata +16 text +128
                   u-boot: add: 0/0, grow: 1/0 bytes: 148/0 (148)
                     function                                   old     new   delta
                     static.efi_disk_add_dev                    636     784    +148
    05: efi_selftest: Add basic partition info check to block io test
       aarch64: (for 1/1 boards) all +563.0 rodata +179.0 text +384.0
                qemu_arm64_lwip: all +563 rodata +179 text +384
                   u-boot: add: 1/0, grow: 1/0 bytes: 384/0 (384)
                     function                                   old     new   delta
                     execute                                  36428   36796    +368
                     partition_info_guid                          -      16     +16
    (no errors to report)


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
 lib/efi_loader/efi_disk.c                    | 38 ++++++++++-
 lib/efi_selftest/efi_selftest_block_device.c | 29 +++++++++
 5 files changed, 139 insertions(+), 29 deletions(-)

-- 
2.49.0

base-commit: 17012e3068d047ad71460f039eeb0c3be63f82a0
branch: add-efi-part-info-proto-v2

