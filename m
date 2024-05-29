Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64B95C27C43
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 14:49:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E209488626;
	Wed, 29 May 2024 16:49:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BRyxEJbz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E89B488625; Wed, 29 May 2024 16:49:02 +0200 (CEST)
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com
 [IPv6:2a00:1450:4864:20::541])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9439C88602
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 16:49:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x541.google.com with SMTP id
 4fb4d7f45d1cf-5755fafa5a7so2732865a12.1
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 07:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716994140; x=1717598940; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BvxvIW9HNiiSBguv6cdag8h2BsTq1tw7FSLbM2L6wg8=;
 b=BRyxEJbzw/eluAtBcTec7BawKjyWk2RXN0BfRvNGbcm3VgJaNrNDBsyKB+29hrxmEV
 YpNQz+A1+uz3qs7/+NNFWLz6hZ/9MzvOW1FFvlJAnXTXhDF1m26xuwUhyF1XGMyv0vtP
 b6kZHUAUfCZ04g8vVXVQfe5SsoMachPLKQJdvigejxaKzoL5fdtFb3rX4ZlnZvj6qRC1
 5Yp6NGw360WRMaAulP/p2aORQrpIfwFWH2lz0l+oF3afHluqW+9l9CmB1Xuglrfj3BtL
 HDSpIVLuO/fEewmR05wKZn8r+mR9G6u0cFxuJcpa1BT6u0IKGUcvBL3uuh5EpCbGUbSQ
 PIfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716994140; x=1717598940;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BvxvIW9HNiiSBguv6cdag8h2BsTq1tw7FSLbM2L6wg8=;
 b=ICjRke8s/X7dqiRwAI7xMjD7Hu1hgVuLHIcmL0y23aMrR3QNoMI6z94Wo6DtJXtXdd
 E39FFYt2RwusIY7jROq4SINRruJUq1tsp7XgFB2SnCJliUd7LTb8E3v7YvZfzLvhuO8J
 EwIHpXxlgoji2wdnGnSe0Zr7uWyugb0wElYlgemPK/eP+7AAvD2wuKMcxisClZm8bG9B
 4uSdWCNBv1dBKRW0q5IbYIjvepeJ9uo7qW8Za1GvJ+LkpghGQJLREmH4a9ai7d90a5fk
 MWWwDo8/ietjWUiLWFF8twyFGM8HOhi7LjvI5kIn4opk2eigszl21RkpXVbhbAcvtSio
 G0cw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsgBFVy8HQrYPriNCu2lIUFqlRuy/q0qT13QFzv6E7t5TXbjGyG+GMPP6BxhHHJ0XlEwW4FYVgBQy9BrGluYeWUdNHKQ==
X-Gm-Message-State: AOJu0YyDS4Lnx03nnCb3OBgtJWuwDtfnmlKdsGmseEZIJJTfRQ4b8lKJ
 JYTdGSrsvHpnO1gbgf2JoI4JIox0K6GDKj1xb+JFAnx6HyROR/0FvxgwWzPW/Lw=
X-Google-Smtp-Source: AGHT+IF250p0UtAT/CxarJ9LfirQE0H7fbvHCN2tjxDxkMmRGSa1IeVIpPYPbTOgCQTHVp4aXcF82w==
X-Received: by 2002:a50:d6c9:0:b0:572:2f0d:f4cb with SMTP id
 4fb4d7f45d1cf-5785191601dmr9590453a12.1.1716994139956; 
 Wed, 29 May 2024 07:48:59 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::8bb3])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-578638009b1sm6922029a12.17.2024.05.29.07.48.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 07:48:59 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v2 0/7] efi: CapsuleUpdate: support for dynamic UUIDs
Date: Wed, 29 May 2024 16:48:49 +0200
Message-Id: <20240529-b4-dynamic-uuid-v2-0-c26f31057bbe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFFAV2YC/2WNQQrCMBBFr1Jm7UgSprW48h7SRZqO7YAmkthgK
 b27seDK5Xvw318hcRROcK5WiJwlSfAFzKECN1k/MspQGIwypMgY7AmHxduHOJxnGVDb2vaa2sa
 ZE5TVM/JN3nvx2hWeJL1CXPaDrL/212r+WlmjQm51TawUO6LLXbyN4RjiCN22bR+MOa3DrwAAA
 A==
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4647;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=dsQUyi2Uv3SXMkbXG4unRGV5H89KUoB4fD4wC9Pw4/g=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmV0BZhbbqZaVURB+HA/fRdTM7Z9WrP+yNYttDT
 LQyb/GmPGGJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZldAWQAKCRAFgzErGV9k
 thePEACBWqkm2wSUAUA9zURVGbEqUvOb2ZV53r8ML2E1108arnW86OyRCCV1Bq8zzlcGxrolnvB
 LJ4XwRxC0/spn40L7ifQGy0MIUioE3tIc4zz+fwCnhnouYzxRpCTS081MpmALAkH4WUnGkb7WvX
 ot0LeM8J6s65amnU5n5GetzyW1WVCcpN7IcJ5vSLV8n2533YZkMTZb+IgJipZSHeTMvIAaa3y3y
 Fo+iVVWrDZ23/BjynKumlF8Qt06lB/rnlplodO2B2fM47OqHDYIFXerron8LpU7Q/hiiZxyVUuX
 Myag1WczTQxhZOUGun3T5Ty/1FLRSVYOs4JmbJRNrvvaZkrTH1gTKCc7XRvQjBwkxU4qeEuFZri
 oog6CixM/wv/0aNwTdr6iquBkJiGp2Wvzctkew9gNS5O0DnvgjnzcP/U4en9MjHei+7ML02riCp
 vhfyJ7rr99h6YQUmzJmV8nk86E/d2LWZ06BJpGwJNdu4PU0uKuGiMt5eor7XtS52XoROGZh+kBT
 ap2Tijmfh1H7H0/JGs9mmzYyqYGtW/F1bnF2rPIOyJyiBraTv0Zl1Olkf4OVMBnL/6WaXLD2z+x
 ZcUwEO+63KTLEHyaeAOkw8O1WTFC8AY+BBloDyNIL83iIZlrgbzXrY7HhedeKDAeEs9AdMwwnXi
 sTDXp2IAtTcjV1A==
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

To: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Simon Glass <sjg@chromium.org>
To: Mario Six <mario.six@gdsys.cc>
To: Alper Nebi Yasak <alpernebiyasak@gmail.com>
To: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Richard Hughes <hughsient@gmail.com>
Cc: u-boot@lists.denx.de

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
 include/sandbox_efi_capsule.h                      |   6 +-
 include/uuid.h                                     |  21 ++-
 lib/Kconfig                                        |   8 ++
 lib/efi_loader/Kconfig                             |  23 +++
 lib/efi_loader/efi_capsule.c                       |   1 +
 lib/efi_loader/efi_firmware.c                      |  66 +++++++++
 lib/uuid.c                                         |  81 +++++++++--
 test/lib/uuid.c                                    |  90 ++++++++++++
 .../test_efi_capsule/test_capsule_firmware_fit.py  |   2 +-
 .../test_efi_capsule/test_capsule_firmware_raw.py  |   8 +-
 .../test_capsule_firmware_signed_fit.py            |   2 +-
 .../test_capsule_firmware_signed_raw.py            |   4 +-
 test/py/tests/test_efi_capsule/version.dts         |   6 +-
 tools/Makefile                                     |   3 +
 tools/binman/etype/efi_capsule.py                  |   2 +-
 tools/binman/ftest.py                              |   2 +-
 tools/genguid.c                                    | 154 +++++++++++++++++++++
 22 files changed, 481 insertions(+), 48 deletions(-)
---
change-id: 20240422-b4-dynamic-uuid-1a5ab1486c27
base-commit: 2e682a4a406fc81ef32e05c28542cc8067f1e15f

// Caleb (they/them)

