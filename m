Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F42CE95A8E
	for <u-boot@archiver.kernel.org>; Mon,  9 Oct 2023 14:42:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DED8E86DAF;
	Mon,  9 Oct 2023 16:42:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=conclusive.pl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=conclusive.pl header.i=@conclusive.pl header.b="esrF18Qn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7904186D9D; Mon,  9 Oct 2023 16:42:11 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 615508667A
 for <u-boot@lists.denx.de>; Mon,  9 Oct 2023 16:42:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=conclusive.pl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=artur@conclusive.pl
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5042bfb4fe9so5530322e87.1
 for <u-boot@lists.denx.de>; Mon, 09 Oct 2023 07:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=conclusive.pl; s=google; t=1696862528; x=1697467328; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kVDp+JaJVMu+LB5GxRvkt8LezZqE8eubSblZzYR7++k=;
 b=esrF18QnU5rP7C7JDW3QnVjE4dUl5+XjAhn3fe43RnuAOIjkHgjIiSzrvvvbwuyodk
 f4zARYPFZZy0eXMUSEOb6WgcbO8ezfYEXtf4Zsbd7/cMbpOc7ydYgOnbX0zuZoje/sqZ
 qDF0TZ4buTEGfIwHr4XWcu8zFu90mn/jPP+Q3rdzsSnpZedaowSdaQhma0EbGN2GLZKp
 wCS2Bi+/pTDz0SiEjl23ZfkyRXHK+MVEIIyIvaGzYIBbCpZR2TF/SEYowC44XtmHz+Mt
 WwDb0AvfkedbE8jIzMKlHcyx8oQAbTwlUX/ik9D7Zgq6doPweHEY+8wmEuaxB3Zo7y2j
 HLYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696862528; x=1697467328;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kVDp+JaJVMu+LB5GxRvkt8LezZqE8eubSblZzYR7++k=;
 b=m7PJBqC0gjSWf5sBM09aZVNpHJpXxUQdjKi2mrWfasC0Wxk+2QslQ7iUnHcSVdE/Wq
 OKKlPSMzrbA6zcZb/2Kk/GoFjB77/784LTcD7KsZrFktuKsw+UW7B0NtVqVyCTeyAYyx
 q9lVcEC9GTv0N4bdGSIY9n5Rh6DlAXsHP4XAaBaiJAS2KoTwZXL0HtymqxvQjizPKZjp
 J5JCw8irU9msqNhdlpTrxA5FkYdR4IbSGkIb8WmMWwWuvmoWs7DRrks954vRdKJEqsU2
 fXgdTNzlk8P4+FbQPRR/YyBsfPAEQOSQHM44NWHNrXZ8Jnieso4YncpTgGaKnrzuk4Nu
 KVPw==
X-Gm-Message-State: AOJu0Yx0tLZjqSmtRWw1L1JOrTWl53Bb/5OB8i3IBt/1Bav3rThvzx7v
 FauL5TzLKY+pqKzzhxkZKdeEqA==
X-Google-Smtp-Source: AGHT+IFk8eY8O9YVddHxZ8HZQn48+wuRmZbquoz3fLu1NUtbZye/X3RR31Mp6XB98Bz/Ds9vp08Rgw==
X-Received: by 2002:a19:5f59:0:b0:502:f469:d4d5 with SMTP id
 a25-20020a195f59000000b00502f469d4d5mr12816430lfj.19.1696862528168; 
 Mon, 09 Oct 2023 07:42:08 -0700 (PDT)
Received: from localhost.localdomain (host-89.25.128.123.static.3s.pl.
 [89.25.128.123]) by smtp.gmail.com with ESMTPSA id
 f19-20020ac25333000000b005045bb669d7sm1464733lfh.62.2023.10.09.07.42.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Oct 2023 07:42:07 -0700 (PDT)
From: Artur Rojek <artur@conclusive.pl>
To: Simon Glass <sjg@chromium.org>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Jakub Klama <jakub@conclusive.pl>, Marcin Jabrzyk <marcin@conclusive.pl>
Cc: Wojciech Kloska <wojciech@conclusive.pl>,
 =?UTF-8?q?Rados=C5=82aw=20Adamczyk?= <radoslaw.adamczyk@conclusive.pl>,
 u-boot@lists.denx.de, Artur Rojek <artur@conclusive.pl>
Subject: [PATCH v4 0/4] Conclusive KSTR-SAMA5D27 support
Date: Mon,  9 Oct 2023 16:41:47 +0200
Message-ID: <20231009144151.773721-1-artur@conclusive.pl>
X-Mailer: git-send-email 2.42.0
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

this is v4 of the Conclusive KSTR-SAMA5D27 support series.

Patch [1/4] now reverts to the approach found in v2. 

Simon, while the behavior is now identical to the one from v2, I
retained the serial_read_from_eeprom() function name from v3 (it makes
it more consistent with the existing mac_read_from_eeprom()). Because of
that, I refrained from copying your v2 Reviewed-by tag.

Patch [2/4] is new. It introduces a new event, intended to be called
post-relocation and before console init.

As a result, [v3 2/4] patch gets dropped in favor of this much simpler
solution (see [4/4] below for use case).

Patch [3/4] remains unchanged.

Patch [4/4] makes use of the newly introduced EVT_SETTINGS_R, utilizing
it for EEPROM readout of MAC and board serial number settings.

Artur Rojek (4):
  common: add prototype & rename populate_serial_number()
  event: add new EVT_SETTINGS_R event
  arm: dts: at91: sama5: Add flexcom4 node
  board: Add support for Conclusive KSTR-SAMA5D27

 arch/arm/dts/Makefile                         |   3 +
 arch/arm/dts/at91-kstr-sama5d27.dts           | 131 ++++++++++
 arch/arm/dts/sama5d2.dtsi                     |  20 ++
 arch/arm/mach-at91/Kconfig                    |  12 +
 board/conclusive/kstr-sama5d27/Kconfig        |  15 ++
 board/conclusive/kstr-sama5d27/MAINTAINERS    |   8 +
 board/conclusive/kstr-sama5d27/Makefile       |   5 +
 .../conclusive/kstr-sama5d27/kstr-sama5d27.c  | 239 ++++++++++++++++++
 cmd/tlv_eeprom.c                              |  14 +-
 common/board_r.c                              |   1 +
 common/event.c                                |   1 +
 configs/kstr_sama5d27_defconfig               |  73 ++++++
 include/configs/kstr-sama5d27.h               |  15 ++
 include/event.h                               |   9 +
 include/init.h                                |  14 +
 15 files changed, 547 insertions(+), 13 deletions(-)
 create mode 100644 arch/arm/dts/at91-kstr-sama5d27.dts
 create mode 100644 board/conclusive/kstr-sama5d27/Kconfig
 create mode 100644 board/conclusive/kstr-sama5d27/MAINTAINERS
 create mode 100644 board/conclusive/kstr-sama5d27/Makefile
 create mode 100644 board/conclusive/kstr-sama5d27/kstr-sama5d27.c
 create mode 100644 configs/kstr_sama5d27_defconfig
 create mode 100644 include/configs/kstr-sama5d27.h

-- 
2.42.0

