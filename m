Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE0EC4829A
	for <u-boot@archiver.kernel.org>; Sat, 10 Feb 2024 11:06:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0460F87E96;
	Sat, 10 Feb 2024 12:06:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="c9BVaO8P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96F2C87EA0; Sat, 10 Feb 2024 12:06:56 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A98F87E96
 for <u-boot@lists.denx.de>; Sat, 10 Feb 2024 12:06:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 37F7640590
 for <u-boot@lists.denx.de>; Sat, 10 Feb 2024 11:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1707563213;
 bh=dHQaQo1nliwciaep/HGSTBekPPEPDMDe8XIgh3pFlPc=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=c9BVaO8PNj2h5CVXGGJ0zHXqm36TW7WmhVVvsU7ON1pDC7ZSOo8xjax2Jvv0MA+hi
 zmDBjDNFoCel4Km8H9XIwPCPvkpur4A3/XOfsOlH7AGOz40j5sCH9ibMDg16FbOfLc
 HU0E4ck1qUxV1ZRuRg21cewbEehqWagfqLGvICY3BsuqlNkEHeB+5JyqC+F/w5pgXg
 0QnOzn3c+pWNdd7oC7D7I2ZiV9atKofSu+ImZgq1mgf7fR/4xz8WoJiHeXHG2qxyaO
 vFD5D+TXxDvKZLOeL8MVY2fZEdpnLNEgqK3MNvc7+eg9Z6qjC9aa0g3F17i/iVw2ZH
 A25T5InzRwAew==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4102b934ba0so9541195e9.2
 for <u-boot@lists.denx.de>; Sat, 10 Feb 2024 03:06:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707563212; x=1708168012;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dHQaQo1nliwciaep/HGSTBekPPEPDMDe8XIgh3pFlPc=;
 b=eYCxlZmHt779d64w8E0I4Sk2mn1S05AHqhXU9Z+SYr9n/NG1p/wuTXfRAXDalHi49k
 XNWvasmsH7HViGKFkVZxS5A78i89FHQMlDtUAUchPgfCwUDT8e5GlIcXCKvYVedKw2CE
 kPoEcxKJCTzpxRy6SEvB3mujI1uFvqH56ON3MYj12RUGkvHy093irvm9jxXdUjYHl804
 EngMurJ8Zw79MzEBJFVdMoVvmX370LImigOKD1ZBLQWSmhQzzsGd/qN1eIlxlLWyxCHa
 LZscUl/MApAr300DUH5ZKjlcrZgHbu42VlG8Jz54lWgoMNJWXW724ZJkoAA/E9TZWHGq
 bnvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW93Ir7e+LIlva3jC4gh1B+zRch2npmF5uLUqjhGTeWB5z5M+V3qBS64gXW1o1OHltlPy2VJszepe1SSlUOQlQFgFU3dg==
X-Gm-Message-State: AOJu0YxHPzii18KHa5Z7HhWQ3abGicnbDA43Z/YSdKtfGaniqONk+DIr
 ZDvDAUKtORvpG7v3olAy2COOFMPr+RCMG/S9D7UAQ39eTMKWjboh7VEn25i3e6RqWAizLVf2htR
 ZfPFgQP5bLMcFrjvmxM4AcET2HdEb7Sv+iQhajkKIUR7dhaKv3ifP2Aaqt/j+6L8d1FY=
X-Received: by 2002:a05:600c:45c7:b0:40f:d738:c213 with SMTP id
 s7-20020a05600c45c700b0040fd738c213mr1782713wmo.29.1707563212415; 
 Sat, 10 Feb 2024 03:06:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHx8p7cY0o3rpTDfxS4acgDO2T66xCl+BF4WSBNID+1EiStoi3yQTa0HHWT8A5fr0r58MG0tg==
X-Received: by 2002:a05:600c:45c7:b0:40f:d738:c213 with SMTP id
 s7-20020a05600c45c700b0040fd738c213mr1782693wmo.29.1707563211916; 
 Sat, 10 Feb 2024 03:06:51 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWxf/rsKgYjLmlAVOjl0c1YKin6TOoUX9ohfN+SPf+9Z3WwKVAAClJanV0krgs3bkASibrD5snW5cj9rWmETPrs5PC3aEdMCsPeLYPQ9sMlmlLoUFr69iouvIoOTnO06/d7GfPSTH8Qy2oj3odsQIJBg3dvf7IcHiBt
Received: from x13s.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 i5-20020a05600c290500b0040ef95e1c78sm3069231wmd.3.2024.02.10.03.06.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Feb 2024 03:06:51 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 0/2] smbios: fill wake-up type
Date: Sat, 10 Feb 2024 12:06:46 +0100
Message-ID: <20240210110648.21977-1-heinrich.schuchardt@canonical.com>
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

We should not use the reserved value 0x00 for the wake up type but
use 0x06 (Power Switch).

Correctly display wake-up type in smbios command.

Display SMBIOS type 1 field family in smbios command.

v3:
	provide an enum for the wake-up type constants
v2:
	use wake-up type 0x02 as our default

*** BLURB HERE ***

Heinrich Schuchardt (2):
  cmd: smbios: type 1 wake-up time, family
  smbios: fill wake-up type

 cmd/smbios.c     | 25 +++++++++++++++++++++++--
 include/smbios.h | 27 +++++++++++++++++++++++++++
 lib/smbios.c     |  1 +
 3 files changed, 51 insertions(+), 2 deletions(-)

-- 
2.43.0

