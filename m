Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 280C7C25B75
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 13:50:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EDF788789;
	Fri, 31 May 2024 15:50:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XS06/lHO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BDEA887A7; Fri, 31 May 2024 15:50:49 +0200 (CEST)
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com
 [IPv6:2a00:1450:4864:20::541])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0D21882B8
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 15:50:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x541.google.com with SMTP id
 4fb4d7f45d1cf-5785f861868so2525338a12.2
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 06:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717163446; x=1717768246; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/OLRhhOhyJrjsKvJG/xG3FjL8nzo96HwUzNfDyf5Zok=;
 b=XS06/lHOfbGC6Csz4H1cT1FX7KnvQhwnAR9I2XuQrOxViZS2y38h2DZ61d2yDQ/Jl1
 mHcrYdr+mwi1/Cn8RtpQX2l5ToeDpOiOGjkPcUZeUV67d5SSaBpac5Cxjt7A5gno7XZa
 N2sOR+VR754+Hnetx9TDiItIrjLABIKsVzVnyjAwqsbAftQGgG1ntGx6uGdeYFjT7TZl
 rHrmB/aDTIGJPPIJG29sTafQ/wixsdc4MvkG2vOqSiu1ASSiV6zJ8XCoqOot8uTKOXt8
 Bib4yX/drLcMueMZLlA+I/XG56O6dmMLanBRAiZfD1ZXcpEFlRI/jiF2eAKdmQQ1Nx7O
 buqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717163446; x=1717768246;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/OLRhhOhyJrjsKvJG/xG3FjL8nzo96HwUzNfDyf5Zok=;
 b=A91sjJe0J+mgYDPWvcrBVNjmxpkUtgP9CaUwi60llHNBHa17hrY8yXnyFW11BMI+mb
 VqaXPzdKy5myvSPKjrvlpHZntgw0UMiEZB2wXG9vTNZqcFylQFwv+rvtglHceDNRiz+w
 WHjA9qRefkBZ1YvOs3/jHkrpqvh44t2LqUhKwqVv97MD7cyIHz6MdN1u7ug+xK6kZg86
 eROUBgVJkHtK0Ys5of2c9ayuZkmO87iogn5J4PDkzps9jAO6RkiSpyr9voh54v5tvCLo
 5AWuyfHl9uUJ9W1ZcPO6EsnM2TFGXFiZOV/6yvp3Unax/FLrlMUjeOpZO9BZ9btuYVoq
 1BPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjgYBgTWqBIWSInwesjhMbVJmc/OVenkKGhbZiDidpPTu0n8OyOTCF1i+zGo8PSssJwD/AtrAH45ukUrbK19/+jEyO8A==
X-Gm-Message-State: AOJu0YyUy2xBbrCD1Z7n7ratIoVYrD2DmRwxz0oj3+BRny12BtwykLAU
 RPpavGFndjvWH+vGuaeZlGRkCejY125cGylWUdzsEFCINVNFguL6CX7hnGBY620=
X-Google-Smtp-Source: AGHT+IGsA2rlMnUuXVG+o8S2wOA5UQws8Co9gteAnCY+4v8OfYO68GuQfhu+kxEQE8XYGcYeqZ/AQA==
X-Received: by 2002:a17:907:36a:b0:a68:8c4b:2419 with SMTP id
 a640c23a62f3a-a688c4b2736mr88074066b.29.1717163445818; 
 Fri, 31 May 2024 06:50:45 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::8090])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a67eab84a99sm89442866b.143.2024.05.31.06.50.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 06:50:45 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v3 0/7] efi: CapsuleUpdate: support for dynamic UUIDs
Date: Fri, 31 May 2024 15:50:34 +0200
Message-Id: <20240531-b4-dynamic-uuid-v3-0-ca4a4865db00@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKrVWWYC/2XN0QqCMBTG8VeRXbfYjptaV71HdLHNox6oGTNHI
 r57U4gIL/8fnN+Z2YCBcGDnbGYBIw3U+xT5IWOuM75FTnVqBgKUUADcKl5P3jzI8XGkmkujjZW
 qKhyULF09Azb03sTrLXVHw6sP0/YgynX9WsXOipILjpXUCoVAp9TlTt6E/tiHlq1YhB+g4bQHI
 AEOiiaXQpfW4h+wLMsH3Aen2PAAAAA=
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4628;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=KTdXMTrbwG2ZHr2nxYUSSckx61XnjgNn9y+T9Ky57go=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmWdWz0ggPuiF5VSPakm41wVlHgizv4YLL5xO/C
 Cgt6HN2khKJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZlnVswAKCRAFgzErGV9k
 tqT1D/9q/GhtTTy2ko/wBwiP+2l9IjVlKec8pOiXB4b2xNna4B7zJp6bP6BaCcmL2aTvo6DymI8
 nTWw0FDeX5q3frZAzrFzxjrenBv3xsP44UCLtud8fS1Jpqn4Xd12QYceNbM9GLLgpGHhwDw/Hlc
 1PlDonu1obqJcrT3Hq5bOaqDn+t1r5hBn9YvG7rw7IhQyvOre6UcUjvBWSaix6MG7dwIDKTLwzq
 fv+2HjZqsxtnYPBD8a+PAzgCujMrZMy/iohSriRds+W2TBGRw40DgHk7mkJE1IckyJidlWvOias
 ijmB2msKftaDJ6dn1gZqAz4vVD+VGPdsQkqlsJMd+P9cbFtt2ddvX7c4b+e0Yjs5hBWoQypE1lA
 M770dVIQD0cnt/FSiZ99IpBkdlu6/FqWYwOM8246XiU3xwDh5OxrJ5tLR2Sy/bMi1U/ZvF9Lifu
 DBQ0jFP1pbJ+0FbU+jDew2GeavJKe97x2O8Scf++oZ7iAX0+OKB1mHmOUDirEw6UMoEsH2HhgWA
 p9pR+CRPbOCSd+O+pMXKwZ55Ne47v/qmPjf9tO/UUeTqgfUptWS2Bl0Y7nFU56lQ8sjwEPgQk6n
 Ztawm0Zl5eUoQ8ReU8RIOoeBCmn2MStKoAC0rvOyKhjjStEMpQLfJ8dJjYGGa2X9FZBl6zaaZnS
 G8qmRn4U+6nBcEw==
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
vendor), or OEM. It is defined in the board defconfig so that vendors
can easily bring their own.

Specifically, the following fields are used to generate a GUID for a
particular fw_image:

* namespace salt
* board compatible (usually the first entry in the dt root compatible
  array).
* fw_image name (the string identifying the specific image, especially
  relevant for board that can update multiple images).

== Usage ==

Boards can integrate dynamic UUID support as follows:

1. Adjust Kconfig to depend on EFI_CAPSULE_DYNAMIC_UUIDS if
   EFI_HAVE_CAPSULE_SUPPORT.
2. Skip setting the fw_images image_type_id property.
3. Generate a UUID and set CONFIG_EFI_CAPSULE_NAMESPACE_UUID in your
   defconfig.

== Limitations ==

* Changing GUIDs

The primary limitation with this approach is that if any of the source
fields change, so will the GUID for the board. It is therefore pretty
important to ensure that GUID changes are caught during development.

* Supporting multiple boards with a single image

This now requires having an entry with the GUID for every board which
might lead to larger UpdateCapsule images.

== Tooling ==

This series introduces a new tool: genguid. This can be used to generate
the same GUIDs that the board would at runtime.

This series follows a related discussion started by Ilias:
https://lore.kernel.org/u-boot/CAC_iWjJNHa4gMF897MqYZNdbgjFG8K4kwGsTXWuy72WkYLizrw@mail.gmail.com/

---
Changes in v3:
- Add manpage for genguid
- Add dedicated CONFIG_TOOLS_GENGUID option
- Minor code fixes addressing v2 feedback
- Link to v2: https://lore.kernel.org/r/20240529-b4-dynamic-uuid-v2-0-c26f31057bbe@linaro.org

Changes in v2:
- Move namespace UUID to be defined in defconfig
- Add tests and tooling
- Only use the first board compatible to generate UUID.
- Link to v1: https://lore.kernel.org/r/20240426-b4-dynamic-uuid-v1-0-e8154e00ec44@linaro.org

---
Caleb Connolly (7):
      lib: uuid: add UUID v5 support
      efi: add a helper to generate dynamic UUIDs
      doc: uefi: document dynamic UUID generation
      sandbox: switch to dynamic UUIDs
      lib: uuid: supporting building as part of host tools
      tools: add genguid tool
      test: lib/uuid: add unit tests for dynamic UUIDs

 arch/Kconfig                                       |   1 +
 board/sandbox/sandbox.c                            |  16 ---
 configs/sandbox_defconfig                          |   1 +
 configs/sandbox_flattree_defconfig                 |   1 +
 doc/develop/uefi/uefi.rst                          |  31 +++++
 doc/genguid.1                                      |  52 +++++++
 include/sandbox_efi_capsule.h                      |   6 +-
 include/uuid.h                                     |  21 ++-
 lib/Kconfig                                        |   8 ++
 lib/efi_loader/Kconfig                             |  23 +++
 lib/efi_loader/efi_capsule.c                       |   1 +
 lib/efi_loader/efi_firmware.c                      |  66 +++++++++
 lib/uuid.c                                         |  81 +++++++++--
 test/lib/uuid.c                                    |  88 ++++++++++++
 .../test_efi_capsule/test_capsule_firmware_fit.py  |   2 +-
 .../test_efi_capsule/test_capsule_firmware_raw.py  |   8 +-
 .../test_capsule_firmware_signed_fit.py            |   2 +-
 .../test_capsule_firmware_signed_raw.py            |   4 +-
 test/py/tests/test_efi_capsule/version.dts         |   6 +-
 tools/Kconfig                                      |   7 +
 tools/Makefile                                     |   3 +
 tools/binman/etype/efi_capsule.py                  |   2 +-
 tools/binman/ftest.py                              |   2 +-
 tools/genguid.c                                    | 154 +++++++++++++++++++++
 24 files changed, 538 insertions(+), 48 deletions(-)
---
change-id: 20240422-b4-dynamic-uuid-1a5ab1486c27
base-commit: 2e682a4a406fc81ef32e05c28542cc8067f1e15f

// Caleb (they/them)

