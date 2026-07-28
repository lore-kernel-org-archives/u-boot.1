Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E67AC54F4C
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 13:21:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EF8D060895;
	Tue, 28 Jul 2026 13:21:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sn4JEV5vi4lZ; Tue, 28 Jul 2026 13:21:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D2EAB60887
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785244861;
	bh=TaliDTzxnTUNXqPFJDu4nG95ht57hYF+ipQQtMB7XdQ=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=w7mM6UgNSygMsCcvsPYA9lShkoqZO1iYX2JrcYxty/nytoMW62AZHhLdchZpVL5Jd
	 arFk0r7frsEeWRmOKEG80vwceqqAy1gsfJGkV8CvEZPjfa4+oyBEAAFGIbkv2dU0/z
	 o2qgA+v/brDcLdIQEQcBIn08OHDN5zKPfVhuHQGEclg0YG6Btn2SSbXP1iNlX39h4X
	 AVOuTAMZiGxaEtEdtzSS42i85uvLStje5mD3Ky5nUx0nW0FdGYkH8XF8padY3kOfrK
	 Qhh2oWZYHOyXy6i40OxO2SqsrZsfPNXRzIS1Vy7liSeXXYaR/wMNj73uoQI+1+IwGq
	 HbFkOCtCYu+ow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D2EAB60887;
	Tue, 28 Jul 2026 13:21:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 563ED194
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 13:21:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3B78760887
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 13:21:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A9tR1iCfy1iA for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 13:20:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 5884260884
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5884260884
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5884260884
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 13:20:57 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-49550ec592cso6212955e9.0
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 06:20:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785244856; x=1785849656;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=TaliDTzxnTUNXqPFJDu4nG95ht57hYF+ipQQtMB7XdQ=;
 b=BBr0h5V3GQcojRFwTdPwCn4YGufeJM8tCOtOnGWI5Zsamvnn2mhf3yCo9KJsEvLGVu
 LXm8RzbcZf449/GvpDILngYZ+uylz/Vt9vGRPrtrAwivKheD7Oz7pEi0aRSGo6gtwpRx
 RPyTv0RzeVI0icRTCimhYGl/dZ5UH/DuqiNc5aCGSF6ftQDnFlCxRLn4ML5vhe1rNgrx
 wS7zwYdrjE/p5XukvOwmScZlKkeBb7pUFChSzGT9kUZ2icuF90I4D6pOfsedavE1oAQb
 kMPeJLEoDyiuGuc6zGPxJhKCrcQD41c5zm6/EUMu82lj/56tlonJDTFUiwz00cXV7scQ
 lrdw==
X-Gm-Message-State: AOJu0YwJYE1v43f7Lp7n6lI7oUvGuylj/MtKdhcJn7Hhlms6PQ+a4JLV
 SFaRb6Es527dnFB9wCgS6Eodky/oYkdrHG1BdDCKkmEM5J5pq9B+lg5CUzsfPInLuas=
X-Gm-Gg: AR+sD10RqL3NNGEpDblgawR3JdrH/aFGIEvWTNZUhKpjt3MWjB8iWfFyrO6atUrdTVE
 jw5OUbvrTYNb7xLSXnmOSXEVAUkoRmsRmlEDH/Q2SRaj3tY13FUOiQdtES/3hhaIA6W1+/df8ND
 Adxy0BXZMm01RYdkeo0o/4Mw45JH8SuKbIl2+ol1GSr7NPijrGVMgKhvjzTzKQNligqI3k0Ddc0
 SJJILwFOZUVj331pP+BvgwDeDTvD51SLh/nR42HFHIIVNWJ/tyFreO1gbQ3SALIr7mOT3fpsKiY
 kprW/augNGVs/g9fA0XYKXS6IOf2eoK+wz4dyCm+4oHGb0qUd9oZVwJCWB+SwmILCCF1fD7uY2A
 S1keex6/6YoYxhKfyM7OcCC8iUxU1VERKa1Pd7OkUbeZSFRv8dIRXVOdfWx7ZHFVkIZD0WiRGDA
 aDYGukUKFh3Gyhgi1vNYZ2DZidQfLstN650rDr+Yb7w0qsGzxHCD4hUDJXFfU=
X-Received: by 2002:a05:600c:46cf:b0:494:1f7:8057 with SMTP id
 5b1f17b1804b1-496c641e6dfmr26637785e9.1.1785244855627; 
 Tue, 28 Jul 2026 06:20:55 -0700 (PDT)
Received: from [127.0.0.1] (host-87-0-90-136.retail.telecomitalia.it.
 [87.0.90.136]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957bd9e980sm306898645e9.0.2026.07.28.06.20.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 06:20:55 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Subject: [PATCH v2 0/5] firmware-owned devicetree for EBBR / SystemReady IR
Date: Tue, 28 Jul 2026 15:20:42 +0200
Message-Id: <20260728-ccaione-upstream-ebbr-v2-0-4efb529140d6@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNTQ6CMBBGr0Jm7ZhatCSuvIdh0RlGGSM/aYFIC
 He34AFcvuR971sgSlCJcM0WCDJp1K5NYA8ZcO3bp6BWicEa60xhHDL7pAiOfRyC+AaFKKA1jnN
 DkvvcQ9r2QR762bv38sdxpJfwsMU2o9Y4dGHej6fT5v37mE5oUIqz5apynuRyIz+/lYIcuWugX
 Nf1Cwaw+0bPAAAA
X-Change-ID: 20260706-ccaione-upstream-ebbr-206c30be3a3a
To: u-boot@lists.u-boot-project.org
Cc: Ahmad Fatoum <a.fatoum@barebox.org>, 
 David Lechner <dlechner@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Carlo Caione <ccaione@baylibre.com>, 
 Simon Glass <sjg@chromium.org>, Quentin Schulz <u-boot@0leil.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Johan Jonker <jbx6244@gmail.com>, Randolph Sapp <rs@ti.com>, 
 Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, Peng Fan <peng.fan@nxp.com>, 
 Vincent Jardin <vjardin@free.fr>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785244856; x=1785849656;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=TaliDTzxnTUNXqPFJDu4nG95ht57hYF+ipQQtMB7XdQ=;
 b=QNwoPf1KNi1cRc1jAkU3NKK7vvg+V834BCtISMwgMIQKYDCQaSsqdaC/1AnOT3I4gQ
 uq7qkC9mit/ZWbjaG+NcYfD+gxPZiiYPWn51Ty0cLAUpltMXt58IniXxDzjCG6aWfegh
 FPNBISD+Ru6n2lH3vMaVGF9tX91ABGnqsAkmifJmR80/owMx9Ij+u4Rz9ytJptVOMa8w
 40DLmfKL5Xcu03ElLQYhXJijsyVTN2nozLlVh/pzXiaa28nuKW7Sp2yZh6H1vKyAK6cD
 jYqKgJQ7tx2FrgyV0cJdGYeaXM6cZGiQipT4jxir9j04nsDPMUd+vUeC/7ZnEYe341Ig
 1mGA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=QNwoPf1K
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

EBBR-style firmware (SystemReady IR) owns the devicetree: the OS is
booted via UEFI and receives the devicetree from the firmware through
the EFI configuration table instead of shipping its own. U-Boot has
the handoff mechanism (efi_install_fdt()), but no generic way to say
which devicetree the firmware owns or where it lives. As a result,
platforms carry downstream commands to provide it.

This series adds a generic loader for a firmware-owned devicetree FIT on
a dedicated GPT partition:

- one FIT ("fdt.itb" by default) carries the base devicetree and its
  overlays. FIT configurations describe the valid combinations, so a
  signed configuration authenticates the base, overlay set and ordering;

- a standalone 'u-boot,firmware-fdt-block' control-DT node points to the
  media device through a 'firmware-fdt-store' phandle. The node selects
  a partition by type UUID and/or name;

- 'fw_fdt_part' can pin an A/B partition and 'fw_fdt_config' can select
  an explicit configuration. Otherwise compatible best-match against the
  control devicetree is used, falling back to the FIT default. Configuration
  chaining is rejected so each combination remains one authenticated unit;

- one staging helper owns the EFI policy: use fdt_addr_r, enforce the
  size cap and distinguish an absent source from a configured source
  which failed. Both the EFI bootmeth and EFI boot manager use it;

- once a source is configured, any failure to assemble the devicetree is
  fatal rather than silently falling back to an unverified source. Every
  image is verified up front so a corrupt overlay cannot be silently skipped.

The loader itself does not depend on standard boot. EFI is its first
consumer, but the source lookup, FIT selection, verification and overlay
assembly are generic.

Patch 1 makes an FDT passed to efi_bootmgr_run() outrank a Boot#### FDT,
as an independent behaviour fix. Patch 2 adds the loader, binding,
documentation and shared EFI staging policy. Patches 3 and 4 integrate
the EFI bootmeth and boot manager. Patch 5 adds sandbox coverage.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
Changes in v2:
- Make the loader independent of bootstd and describe EFI as its first
  consumer.
- Describe the source with a standalone compatible node which points to
  the backing media through a phandle.
- Rename 'boot_dtb' to 'fw_fdt_part' and document both environment
  variables in doc/usage/environment.rst.
- Factor EFI staging and fail-closed policy into one helper used by all
  three call sites.
- Track the assembled FDT's ownership explicitly and own the FIT filename.
- Select FIT_BEST_MATCH and add explicit compatible-selection coverage.
- Split the passed-FDT precedence change into its own first patch.
- Build the entire sandbox source topology at runtime, store mmc11.img in
  persistent_data_dir and add staging, configuration-chaining and corrupt
  base/overlay fail-closed coverage.
- Link to v1: https://patch.msgid.link/20260706-ccaione-upstream-ebbr-v1-0-e742cdd6abe5@baylibre.com

---
Carlo Caione (5):
      efi_loader: bootmgr: preserve a passed devicetree
      boot: add a firmware-owned devicetree source
      bootmeth: efi: use the firmware-owned devicetree
      efi_loader: bootmgr: install the firmware-owned devicetree
      test: boot: add firmware-FDT source tests

 MAINTAINERS                               |   3 +
 boot/Kconfig                              |  24 ++
 boot/Makefile                             |   1 +
 boot/bootmeth_efi.c                       |  45 +++-
 boot/firmware_fdt.c                       | 420 ++++++++++++++++++++++++++++++
 boot/image-fdt.c                          |   3 +-
 boot/image-fit.c                          |   9 +-
 configs/sandbox_defconfig                 |   1 +
 doc/develop/uefi/firmware_fdt.rst         | 112 ++++++++
 doc/develop/uefi/index.rst                |   1 +
 doc/device-tree-bindings/firmware-fdt.txt | 150 +++++++++++
 doc/usage/environment.rst                 |  11 +
 include/firmware_fdt.h                    |  95 +++++++
 include/image.h                           |   4 +-
 lib/efi_loader/efi_bootmgr.c              |  39 ++-
 test/boot/Makefile                        |   1 +
 test/boot/firmware_fdt.c                  | 411 +++++++++++++++++++++++++++++
 test/py/tests/test_ut.py                  | 181 +++++++++++++
 18 files changed, 1492 insertions(+), 19 deletions(-)
---
base-commit: b635d43bca429500cb8ef20aa151cb5773b9a8a5
change-id: 20260706-ccaione-upstream-ebbr-206c30be3a3a

Best regards,
--  
Carlo Caione <ccaione@baylibre.com>

