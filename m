Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D3FAC43458
	for <u-boot@archiver.kernel.org>; Sun, 12 Jul 2026 14:07:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 717E084A0B;
	Sun, 12 Jul 2026 16:07:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A9tuQ0V1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B21FC84940; Sun, 12 Jul 2026 16:07:31 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7100484852
 for <u-boot@lists.denx.de>; Sun, 12 Jul 2026 16:07:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c15b509c323so319312566b.0
 for <u-boot@lists.denx.de>; Sun, 12 Jul 2026 07:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783865249; x=1784470049; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zidCjt/4tbXmQP0806CnrArJnyHgB/h2FZ3aMoDeGFk=;
 b=A9tuQ0V1y3UbdMx4viyIIOeW0lbt9lMc3+Yawk/ZE2ihv/O7oVzwewTz2ftMcIm04a
 8tXGlXT94Mn7vOQ97nlckPtwPx0MM5NsM1bczkFyjPxpEPe6669yRJjmMihUwrYAlXkA
 0vWae/s/fgI/hGwMJ2Bj3kwvpfp7qKVcS+g9W4nU5JRCB5+vx4dzsDRvnOL7IfNQ48/y
 oQ4GNINHh0IU/Np/vSJtTjIl1Jc6DGAOPdqMFmacBp64ITaXRJi5K2q8Y676h2V31iJo
 27MBs5VGSd4F6dNjqQQyDfgVrOsGYd4+I0yp2k24kJqsXCaDbQCdfEDzmY7nhvUgERMw
 F9iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783865249; x=1784470049;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zidCjt/4tbXmQP0806CnrArJnyHgB/h2FZ3aMoDeGFk=;
 b=F5tHMG8TU6o1Vv5tHUi5804UiNjUbgWw0q8Tp9Uf/18SO5LTd93rPdFtx3x4JCQIrt
 Wl62EWOnEm2IV5QMKRpL2Li/udxSpM6DdyFaza1CztOVA3xR8rNFkSbq9eYlgf/Nehq4
 xKxFAxMBHWJLPWXfbOEsAMGBnRMxhtimfPDB1SNzY+SANWKS0pImi/c/3fpVF6pTATcl
 olzUcLohlziPOat8MXC+yWSLgAUjIwY7gWtrPCB09qY562x2vayQIZ7eNAucuWIedisM
 wWSmwVhfZzB8rqK3mhhfdzaF327cc8X4MhrUYhybxKJ+tfKubxUcYIxGlv9NEls2zH42
 /Rvw==
X-Gm-Message-State: AOJu0Yzu51JXk6vHGN22sAWRt387wy3q+Pcj32IvqTp1heiad57CDk1w
 5F/ft+oE8vEnwHatWxluP4kO7Msdk36sptCaOUJmRV3E6juH5yCAIBc/RB2KDA==
X-Gm-Gg: AfdE7cmfBWm1Z6IkGoGW+7TApwb9lCL4zCPE5U6IwjK2sM8sw7Y8X3uNAU1fYTHb3Ra
 b1RQEYIuroiMXhfzk+V8lJiG17Km9OBAQRpW9voUjZwVm34apGB1VVJqkC7SXnwlrGuU/frstTB
 fI9CZjcfdehQEmyOFv4WmUc46u6aqVbX1K3KN1S4a+2lVev4bEZcTxcL5DaCOXXj1jJx8bXZ84p
 JCSfKLjvS4LQ85MXTyplECDTBVv/CzoGskslvGfvjxvbXbuNwZb0tfIfbOl3aWUpRav1+DB/7fH
 0bAjhUH+YYAtVE1R2ixrXa/t9estFpYSOBFK/78hx7xVXziY//ZeXSHWhdvBalo1CyugsmYt7qq
 i0/a9va6Oij1xvG49WsqrSjUiWBrTjdQXaUqDylhdCJDMqG5tbShXYrUW1bC5xjSMwGPJVHYcE4
 P2AzjwiP0eB4OaQTc9T/SHSK2NrxvIWRRLDw486IkLf+/KYU7VBaIMNYcERPOPSFfrm/FFC3unG
 olTYE7DoPCEx2ZKE8Y=
X-Received: by 2002:a17:907:7255:b0:c16:1a3:9022 with SMTP id
 a640c23a62f3a-c161ea7951dmr232913666b.38.1783865248721; 
 Sun, 12 Jul 2026 07:07:28 -0700 (PDT)
Received: from [127.0.1.1] (185-164-141-21.cgnat.inetia.pl. [185.164.141.21])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15e41121d2sm492856166b.47.2026.07.12.07.07.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 07:07:28 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@gmail.com>
Subject: [PATCH 0/2] libavb: update to AOSP 1.3.0
Date: Sun, 12 Jul 2026 16:07:09 +0200
Message-Id: <20260712-avb-libavb-1-3-v1-0-44a50dfe2f23@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDc0Mj3cSyJN2czCQQZahrrJtmZG5sZmJqbGaWkqgE1FRQlJqWWQE2MDq
 2thYASOLF8WAAAAA=
X-Change-ID: 20260712-avb-libavb-1-3-f273645366da
To: u-boot@lists.denx.de
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Igor Opaniuk <igor.opaniuk@gmail.com>
X-Mailer: b4 0.14.3
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

The vendored libavb under lib/libavb/ has been frozen at a ~2019 AOSP
snapshot (AVB version 1.1.0) for about six years. A v1.1.0 library
rejects any vbmeta whose required libavb minor version is greater than 1
with UNSUPPORTED_VERSION, so an image signed by a newer avbtool that uses
a 1.2/1.3 feature fails to verify. This series re-syncs the library to
version 1.3.0 and picks up the accumulated upstream fixes.

The vendored files are taken verbatim from AOSP external/avb commit
a1fe228b8654 ("libavb: support chain partition no ab"), the commit that
introduced version 1.3.0 [1].

Functionality the library now parses:
  - AvbVBMetaImageHeader.rollback_index_location (v1.2)
  - AvbChainPartitionDescriptor flags / DO_NOT_USE_AB (v1.3)
  - AvbHashtreeDescriptor FLAGS_CHECK_AT_MOST_ONCE
  - AVB_HASHTREE_ERROR_MODE_PANIC

Scope / integration impact:
  - The AvbOps callback set is unchanged between 1.1.0 and 1.3.0, so the
    U-Boot integration in common/avb_verify.c needs no changes.
  - The U-Boot port is preserved rather than pulling upstream's
    BoringSSL-oriented crypto restructure (sha/, boringssl/):
    avb_sysdeps.h / avb_sysdeps_posix.c and the flat avb_sha.h /
    avb_sha256.c / avb_sha512.c are kept as-is. The SHA API signatures
    are unchanged, so the retained implementation stays compatible.
  - Per-file licenses are preserved (avb_rsa.c stays MIT OR
    BSD-3-Clause). The Apache-2.0-licensed avb_crc32.c is not imported,
    as it is unused by U-Boot.

Note: patch 1 is a verbatim upstream import and therefore triggers a
number of checkpatch style warnings. The files are intentionally left in
upstream (AOSP) coding style to keep them diffable against external/avb;
they are deliberately not reformatted to U-Boot style.

[1] https://android.googlesource.com/platform/external/avb/+/a1fe228b86543a21739c51352f5ce72f134fccfa

Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
---
Igor Opaniuk (2):
      libavb: update to AOSP 1.3.0
      doc: android: refresh AVB provenance and pin libavb reference

 doc/android/avb2.rst                        |   7 +-
 lib/libavb/avb_chain_partition_descriptor.c |   1 +
 lib/libavb/avb_chain_partition_descriptor.h |  16 +-
 lib/libavb/avb_cmdline.c                    |  44 +---
 lib/libavb/avb_descriptor.c                 |  62 ++++--
 lib/libavb/avb_hashtree_descriptor.h        |   3 +
 lib/libavb/avb_property_descriptor.h        |   8 +-
 lib/libavb/avb_rsa.c                        |   6 +-
 lib/libavb/avb_slot_verify.c                | 313 +++++++++++++++-------------
 lib/libavb/avb_slot_verify.h                |   6 +-
 lib/libavb/avb_util.c                       |  46 +++-
 lib/libavb/avb_util.h                       | 140 +++++++------
 lib/libavb/avb_vbmeta_image.c               |   1 +
 lib/libavb/avb_vbmeta_image.h               |   8 +-
 lib/libavb/avb_version.h                    |   2 +-
 15 files changed, 384 insertions(+), 279 deletions(-)
---
base-commit: 6741b0dfb41dc82a284ab1cff4c58af6ef2f3f9c
change-id: 20260712-avb-libavb-1-3-f273645366da

Best regards,
-- 
Igor Opaniuk <igor.opaniuk@gmail.com>

