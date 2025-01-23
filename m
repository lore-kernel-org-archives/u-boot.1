Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FDF2C02181
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 02:47:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E4A2801B0;
	Thu, 23 Jan 2025 03:47:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="reIac+4G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34C4B80214; Thu, 23 Jan 2025 03:47:02 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01B2380137
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 03:46:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 216EB3F291
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 02:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1737600419;
 bh=rD0DrG0urD8NUuCtnjwiBYrNmurV1gVPG7mM5b68IVg=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=reIac+4GLLXr3AXesj/XLmQM9LDhlg0/tgSaCswuZDJ8SGLAdV/As5dS2Qi34gm8G
 o+tehKpVycHq6I1yWewumaCkk1Z4lFPq8MBSrYWodFPbcV96tSTwVixx9ZUrAmH2uc
 rVXBaIQMrKxFUa6hV5ulQvSi2wU2P5LunR8XxWxPZK9REEEg76+OuFIMUX0yqURTo6
 d+dXY+98xVGO0FadpIWaPjpo0h6O29aO5SrgPQBZZ2tZ642Bizc3aKI22Rz4p0c9Xn
 dI1pKqnEnlSWj2NuzTFbc3GE9Fmwm1oOCLv9lVRr7PKGIt4jCTCxlXVSs/HFPFBuLg
 KGwJhKjQX2qng==
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43651b1ba8aso2307015e9.1
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 18:46:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737600418; x=1738205218;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rD0DrG0urD8NUuCtnjwiBYrNmurV1gVPG7mM5b68IVg=;
 b=fBTSrsp2YXx0Kz2wjDNFQuY2iJVOwwFjki2F7Dr4pFQKPqTWHcgbQrHTmhKLDiqF8k
 QIsmVdZ+x9NhUm3+4cWIA3AsUMF+2p9Z9GMjr5OgcEJR13yaQOf1nMFZH958xmygXmhJ
 eiy5+wLkiKvJtEkpbtDtccbJbGfzKkJzR6PBl6HolEH12FNM+l7Tc1Jj+c7e/8TVqC4s
 qqpCp+/dD3zSBpqPi4WYMweEwLAtyuhMa1f35IOLQLlT8mqUvvf28FOsxPwSVmnXIj+S
 LNVgQcnzoJWO8fnS9FwQHWhE4X6y8raDt0XvnUFF5G5sCJ0JoN1ARsgERM2HPWMma87Q
 M6jg==
X-Gm-Message-State: AOJu0YyxcAMLW8Qgv3kXaGvosuP9o/E3SDMP0deycJFuyWOOKkF3f0MB
 T8/BTa+ukMR2S42mVIlDq5GxVDDDrZbteSrYqMXNcOd9+3mK7+ngjKK29NcxbIRsofHCNoIX7rX
 ha1zuX24kbU8v2CcVBKLmI289UxScgKpCqzF6LrnA0914VKkLvYi07iEQjSosb1UCffk=
X-Gm-Gg: ASbGnctThvS28yuKvDnyjsfCsN3MqQMd+zp/IoE2LOzifww9Ivx4ZVqXQNCBhaZzxWJ
 wHqAO3Y2Z4UZ/RB5NbQKsJSSHg9ezdOtko2vrH0MnPEJe1fs/XCDK/tsy0qzwXWxO0hJJK8zz+h
 aozgwZLIze95f6DgMlgSEmojv/KcYUFXUoZYNqv92bCtepCsSqo1uFx9fZ0jRI5haufj4iOOQHj
 MI5nI7csPdIxB7s46ULuJ41sc2AQYxoLc1c1fIDaHYMEPlQh4Iy0gtB5nZWQg9O7Hg0UxG8Lm8t
 jbUhYNp4EEFTI1IPKL+vp/C5cjw=
X-Received: by 2002:a05:600c:4c86:b0:436:6ddf:7a27 with SMTP id
 5b1f17b1804b1-4389141c412mr208978605e9.23.1737600418547; 
 Wed, 22 Jan 2025 18:46:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLu4XKjX580cq5UVdYMIifX/Xem2vZsEWK2AqXslFWlZcfvzL3P/1sLDkcZK0yV3VMV4Ro/w==
X-Received: by 2002:a05:600c:4c86:b0:436:6ddf:7a27 with SMTP id
 5b1f17b1804b1-4389141c412mr208978525e9.23.1737600418238; 
 Wed, 22 Jan 2025 18:46:58 -0800 (PST)
Received: from localhost.localdomain ([2a02:3035:6e0:4a90:399:6f76:8248:d5ea])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438b31ae155sm44919675e9.20.2025.01.22.18.46.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 18:46:57 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>,
	Leo <ycliang@andestech.com>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] doc: describe creating a pflash file for
 qemu-system-riscv64
Date: Thu, 23 Jan 2025 03:46:51 +0100
Message-ID: <20250123024651.74987-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
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

U-Boot can be executed in place from a flash device.
Describe how this can be emulated on RISC-V QEMU.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 doc/board/emulation/qemu-riscv.rst | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/doc/board/emulation/qemu-riscv.rst b/doc/board/emulation/qemu-riscv.rst
index 8388e13d96d..cf2f893b723 100644
--- a/doc/board/emulation/qemu-riscv.rst
+++ b/doc/board/emulation/qemu-riscv.rst
@@ -42,6 +42,23 @@ use the configurations qemu-riscv32_smode_defconfig and
 qemu-riscv64_smode_defconfig instead. Note that U-Boot running in supervisor
 mode requires a supervisor binary interface (SBI), such as RISC-V OpenSBI.
 
+To create a U-Boot binary that can be utilized with a pflash device in QEMU
+apply these addtional settings to qemu-riscv64_smode_defconfig:
+
+::
+
+    CONFIG_TEXT_BASE=0x20000000
+    CONFIG_XIP=y
+    # CONFIG_AVAILABLE_HARTS is not set
+    CONFIG_SYS_MONITOR_BASE=0x80200000
+
+Truncate the resulting u-boot.bin to 32 MiB. Add the following to your
+qemu-system-riscv64 command:
+
+.. code-block:: bash
+
+    -drive if=pflash,format=raw,unit=0,file=u-boot.bin
+
 Running U-Boot
 --------------
 The minimal QEMU command line to get U-Boot up and running is:
-- 
2.47.1

