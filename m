Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F39A1C4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 14:19:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BB9F89176;
	Fri, 26 Apr 2024 16:19:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="we9A648x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E884789175; Fri, 26 Apr 2024 16:19:45 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74E1087F4A
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 16:19:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-51b526f0fc4so2851438e87.1
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 07:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714141183; x=1714745983; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fnoJ2f12+jdQQKO8LXDQqLjeZqAqNUj5ojTEb/bxl2U=;
 b=we9A648xWHTu4Hljfb3xrPzVgGyLoCRjkpmP3f1L5Xj6+KC7yxuc2Zyag0dqCOiye7
 Pdxw86Et/X43y3iAyd+uPuLT8QRbfPJN3/6y5m9VvqzIj9xJawHU3lo808PzD66HHcbb
 sMPFF5wUsIFxl1AqX/bJkZEna/KWNLbd/NZ7yZFY+OE+DIZ06HzNFxoRjK9FQn6yVzex
 JfkFLm2LGkVuSM/sErO4KVnOv9+LoX7rV7/eicTteTr/dn5Ed6wkZWZB/OzLE5Ngi8qt
 suk4bHx369G0wwJ3gl75ZgjJfXvv6EDGPvJFXLYu4d5milLwkGObm1o1neHTCZIXp/zz
 rhIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714141183; x=1714745983;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fnoJ2f12+jdQQKO8LXDQqLjeZqAqNUj5ojTEb/bxl2U=;
 b=FFx48P8nrwdJHgEuW7qWGG7Zc9W6oNIoQY/mDdAZly7FV7eCKPgFMRsx9OQIyp4OxJ
 rQEej67Xdwg5+YrEOeufxPX7quJ1FMSuOdQD5xcMVdoXgvMQ0AomHzxvOoGfmV6MtqIh
 NjX0lWElSMRehgP+30mzqI6IhY79kDbZDXJzxEJMaSid/M+c/DAU8p4v1LY0tweDppnL
 zbY3W8SesdoHDBlM0EL9K4sBz5Nqg6q0JpyxK4+7ZydywYAOOLcSh430CZRumhrMg3qk
 NAr6QY9GiuZftm++trRHzJw6mwxWIVUeKElG0P8QoNERPRYWYTYBjziwk9V89n0sTde9
 6bzQ==
X-Gm-Message-State: AOJu0YyLM5jNwgmOlrZkvzfOYJOnZ8mPoZXeLbSWHv/6xXogbdbRnhMJ
 hLtYJ3fgKB/gwkokYgyrohKX+mgq2ZiV5EAfxjdVi0VXhFTc21o9SlqnJFIMKQ4=
X-Google-Smtp-Source: AGHT+IFEsYRuXMoOs40pmGh3tRE/KLkzscaTyMtQWHUytdHJSpfRATJsqRVkCXfFfH5bA/0VI4SBtQ==
X-Received: by 2002:ac2:42ca:0:b0:51c:a631:7360 with SMTP id
 n10-20020ac242ca000000b0051ca6317360mr1437402lfl.25.1714141182549; 
 Fri, 26 Apr 2024 07:19:42 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::9b06])
 by smtp.gmail.com with ESMTPSA id
 ds2-20020a0564021cc200b0057059d26756sm10041182edb.76.2024.04.26.07.19.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Apr 2024 07:19:42 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH RFC 0/4] efi: CapsuleUpdate: support for dynamic GUIDs
Date: Fri, 26 Apr 2024 16:19:34 +0200
Message-Id: <20240426-b4-dynamic-uuid-v1-0-e8154e00ec44@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPa3K2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDEyMj3SQT3ZTKvMTczGTd0tLMFF3DRNPEJEMTC7NkI3MloK6CotS0zAq
 widFKQW7OSrG1tQB80rZrZgAAAA==
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Richard Hughes <hughsient@gmail.com>
Cc: u-boot@lists.denx.de, Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4171;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=x49t2DMVg2TWIuwsmRQTtlWVqdPL8x5yRhJl+xeFc9U=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmK7f9KmIboiUoF6O982WSZ3jeikrBZHcQh9Z8Z
 eo9cuRyf2mJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZiu3/QAKCRAFgzErGV9k
 to8lD/4riGK6WQuVEddamtL/fKEpFUEHwXHLzfEKZDGSrh25NJnR5dAk94hWnSaWrFmJwd9byHl
 qnR4q+AKJ11YOvZvaBIaIPS3KGR1Z6weLElENszKDxhLMOCaGHT/FpW2M6LiSH3rf0ZVx2AebZH
 EwgzVmhCbsLMziJx43twtT0GpVBVYTtTO7yAVgLgcKVARNESCfXQzretFPFNhOq2gIrjyBTm1Q9
 /VP2g1zBb3po2IejMFStKQycL1mjMklj2v1SsOHYdFhzLvriLgusWtD2ztbjR0Fc/D3rA1yzLBy
 BAKje38TUJVRDaRN0OEV4oLeMI9m3761E5op9og/udJzmWzLkXCNgnOFswfboleenqr4XPWdiJd
 1Hos6zh88n4WaA27mjZaomix+RQ4XUD0/I+q5jIGqiAyaS16lGczPkpjqxY2y6ZkY40gvGhfivX
 NnBKvuvxaF+pikDi49X2KP7MmIjVqDjt0hOz8oDArzH+8jliOPiL+Ze/HbEJAVtYaviZd8+1Pnf
 5qTLXlCXNMfDV0sBssJ+QkEgnRPjQxBU1S1RnGqAMAMXNN6mjEGDtcG3uUCM9w6FLnaqTAyu0oE
 JM+8U0Pd8C8ZR6ayFF/AGCQ30GZmk7WmNsW7830cS4TiBeOJvNLBkVur9U2YxcU2NYGOM4gmsK5
 w0X0K+MhPTS0jKg==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

As more boards adopt support for the EFI CapsuleUpdate mechanism, there
is a growing issue of being able to target updates to them properly. The
current mechanism of hardcoding UUIDs for each board at compile time is
unsustainable, and maintaining lists of GUIDs is similarly cumbersome.

In this series, I propose that we adopt v5 GUIDs, these are generated
by using a well-known salt GUID as well as board specific information
(like the model/revision), these are hashed together and the result is
truncated to form a new UUID.

The well-known salt GUID can be specific to the architecture (SoC
vendor), or OEM. Exact rules on how these are used (e.g. if vendors
should be told to generate their own for their products, and if that
can be added upstream, etc) will need to be decided.

Specifically, the following fields are used to generate a GUID for a
particular fw_image:

* namespace salt
* soc name
* board model (usually from dt root model property)
* board compatible (usually the first entry in the dt root compatible
  array).
* fw_image name (the string identifying the specific image, especially
  relevant for board that can update multiple images).

Once generated, the GUIDs can be printed with the "%pUs" format string,
these can then be stored externally to U-Boot.

The SoC name field might be controversial, it could be generated from
the last entry in the dt root compatible in most cases, or in some board
specific way. It might make sense to remove this field if it is
unfeasible for some boards.

== Usage ==

Boards can integrate dynamic UUID support as follows:

1. Adjust Kconfig to depend on EFI_CAPSULE_DYNAMIC_UUIDS if
   EFI_HAVE_CAPSULE_SUPPORT
2. Skip setting the fw_images image_type_id property.
3. In board_init() (or anywhere before the EFI subsystem is
   initialised), add a call to efi_capsule_update_info_gen_ids() with
   the board specific info.

== Limitations ==

* Changing GUIDs

The primary limitation with this approach is that if any of the source
fields change, so will the GUID for the board. It is therefore pretty
important to ensure that GUID changes are caught during development.

* Supporting multiple boards with a single image

This now requires having an entry with the GUID for every board which
might lead to larger UpdateCapsule images.

== Tooling ==

Not part of this RFC is a tool to generate the GUIDs outside of U-Boot.
I suspect this might be a requirement, but it makes sense to decide on
what fields we use first.

The tool should take in the salt, DTB, and a list of fw_image names. It
could also accept values to overwrite the individual fields if they
aren't derived from the DTB for some reason. It would then generate the
expected GUID.

A potential idea here would be to integrate this into the build system
so that it prints a warning if the GUID changes.

== TOOD ==

Missing from this RFC are unit tests for the dynamic UUID feature, these
will be implemented for future revisions.

I would appreciate any feedback on the above.

This follows a related discussion started by Ilias:
https://lore.kernel.org/u-boot/CAC_iWjJNHa4gMF897MqYZNdbgjFG8K4kwGsTXWuy72WkYLizrw@mail.gmail.com/

---
Caleb Connolly (4):
      lib: uuid: add UUID v5 support
      efi: add a helper to generate dynamic UUIDs
      doc: uefi: document dynamic GUID generation
      sandbox: switch to dynamic UUIDs

 arch/Kconfig                 |  1 +
 board/sandbox/sandbox.c      | 28 +++++++++++++++-------------
 doc/develop/uefi/uefi.rst    | 35 +++++++++++++++++++++++++++++++++++
 include/efi_loader.h         | 28 ++++++++++++++++++++++++++++
 include/uuid.h               | 16 ++++++++++++++++
 lib/Kconfig                  |  8 ++++++++
 lib/efi_loader/Kconfig       | 14 ++++++++++++++
 lib/efi_loader/efi_capsule.c | 33 +++++++++++++++++++++++++++++++++
 lib/uuid.c                   | 33 +++++++++++++++++++++++++++++++++
 9 files changed, 183 insertions(+), 13 deletions(-)
---
change-id: 20240422-b4-dynamic-uuid-1a5ab1486c27
base-commit: d097f9e1299a3bdb7de468f0d9bbc63932f461cd

// Caleb (they/them)

