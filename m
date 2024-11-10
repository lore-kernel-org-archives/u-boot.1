Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FF88D5E37B
	for <u-boot@archiver.kernel.org>; Sun, 10 Nov 2024 08:31:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48CAC88FCB;
	Sun, 10 Nov 2024 09:31:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OW2/3Oav";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5016890C1; Sun, 10 Nov 2024 09:31:03 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8073988FBF
 for <u-boot@lists.denx.de>; Sun, 10 Nov 2024 09:31:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a9aa8895facso666650066b.2
 for <u-boot@lists.denx.de>; Sun, 10 Nov 2024 00:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731227461; x=1731832261; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=A8tAVw7EnJqqzMSD2jVNR4sHw0BAq4oPrI6QOEmDJwU=;
 b=OW2/3Oavmtkbm5njIIkqd6H7ed0zfYjMdYkNIda4ZBsqU4mzdRK6ju8putFIT0MMMx
 tXkN7BS/aTAFGXqm6pV5J4zSd5/Tbo/B6YFlEFQiSSyPjN24v8FSKXMxbDXeAIcUB3Zf
 tTI2UxLsIJd2w8ivJoHSNEWjTShc2TRa04ESz8frjiyLwmY0GTFuPiDkTJTUQxLKsRUz
 qmUAFRHflUgc5fBOeTWGetzBkRDrya9C4LlzG6iFo/KFmb+QOJo8QYilNKaVyJUgQzC2
 f5iX6jfwhJ9RLpREgEI4JRLxbdhvnSPFigHbIZgQ+vFYe/mENmj7OWyKaJND/qGBkRPV
 6Q1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731227461; x=1731832261;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A8tAVw7EnJqqzMSD2jVNR4sHw0BAq4oPrI6QOEmDJwU=;
 b=Qf2A5kTNJ2pjeS+wjUiL1fRpzs6YbUq0EwiUPTQIFaMMLU5X9JP+Vt0AH1lndB3Cw/
 IahYT5nfz/yJK/XcmIVquK3Rv514DWLBvoPDrKnsu0gPeoParRESCIBvk8pmcMLKnd/7
 8txV/mHN1IQdqRpZwQ4JVGaeHdmq3ggv9BkjbJfIZQLaZdaFiwZHb5HP7Ep5wjjsR16v
 VBBR2TgVfSn/QvxE3lrPjvGCNiFRExx80fHzll0O/mGhkJMQvPXfd1Xfkmb0P+b3zsNM
 b3ncUm4nkhYvXb28SmqbLB0KwM6xJJH9FXFMsQykNZGRfjz9f+yR1p9xKDcNSM1djLho
 CYEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCU6GsAPnb7nRQNcmwupymD8ZUev4aNaaucZUWTJ7c2yiESIQQ1uXfNpJXrPGE8/0XTOEhjuo=@lists.denx.de
X-Gm-Message-State: AOJu0Yzp2fVkrScpO2tCrMbsb0N10obiKAKC8VkLs9+w4oH+nfAZ5463
 ACdwlzDHyOl/KTYhSJY6swBBLv+cOI0zeBDTaFRZezSMANeirptsFXaer3aoz28=
X-Google-Smtp-Source: AGHT+IHfd0Prhgp1zmlPlfygfTvGnGyA0G3c5tlce7N5+f29flOBI+2zVnY9E5SX6CRkhSm/sizyNg==
X-Received: by 2002:a17:906:c10f:b0:a9a:8028:45d8 with SMTP id
 a640c23a62f3a-a9eefe9bb73mr866175366b.7.1731227460761; 
 Sun, 10 Nov 2024 00:31:00 -0800 (PST)
Received: from hades.. (ppp176092143132.access.hol.gr. [176.92.143.132])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9ee0a17b3csm451909166b.19.2024.11.10.00.30.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Nov 2024 00:30:58 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: jerome.forissier@linaro.org
Cc: Anton.Antonov@arm.com, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Wei Ming Chen <jj251510319013@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 u-boot@lists.denx.de
Subject: [PATCH v3 0/6]
Date: Sun, 10 Nov 2024 10:28:36 +0200
Message-ID: <20241110083017.367565-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi all,

This is a respin of [1] adding https support to wget. In short

patch#1 enables the crypto algorithms we need in mbedTLS
patches#2, #3 enable anf fix the lwIP part we need
patch#4 is adding https:// parsing support in our wget
patch#5 is making https:// the default for QEMU lwip defconfig so
people can easily test
and finaly patch#6 updates our documentation

[1] https://lore.kernel.org/u-boot/20241024112449.1362319-1-ilias.apalodimas@linaro.org/


Changes since v2:
- Use a bool variable for https:// support instead of relying on the port number
- changed a memcpy to strlcpy to avoid reading extra bytes from the source buffer
- Removed unrelated whitespace fixes
- CONFIG_IS_ENABLED -> IS_ENABLED on mbedTLS header file
- Add r-b tags by Jerome

Changes since v1:
- re-arranged the Makefile objects so they only get compiled when TLS ie enabled
- Fix all the applicable remarks Simon had on the wget patches
- Fixed the title of a patch pointer out by Peter
- Rebased on -master
- Collected r-b tags

Ilias Apalodimas (4):
  mbedtls: Enable TLS 1.2 support
  net: lwip: Enable https:// support for wget
  configs: Enable https for wget on qemu arm64
  doc: uefi: Describe UEFI HTTPs boot

Javier Tia (2):
  net: lwip: Update lwIP for mbedTLS > 3.0 support and enable https
  net: lwip: Add Support Server Name Indication support

 cmd/Kconfig                                   | 19 ++++
 configs/qemu_arm64_lwip_defconfig             |  1 +
 doc/develop/uefi/uefi.rst                     | 45 +++++++++-
 lib/lwip/Makefile                             |  3 +
 .../src/apps/altcp_tls/altcp_tls_mbedtls.c    | 49 +++++++----
 lib/lwip/lwip/src/core/tcp_out.c              |  8 --
 lib/lwip/lwip/src/include/lwip/altcp_tls.h    |  2 +-
 lib/lwip/u-boot/lwipopts.h                    |  6 ++
 lib/mbedtls/Kconfig                           | 12 +++
 lib/mbedtls/Makefile                          | 31 +++++++
 lib/mbedtls/mbedtls_def_config.h              | 52 +++++++++++
 net/lwip/Kconfig                              |  2 +-
 net/lwip/wget.c                               | 86 +++++++++++++++++--
 13 files changed, 277 insertions(+), 39 deletions(-)

--
2.43.0

