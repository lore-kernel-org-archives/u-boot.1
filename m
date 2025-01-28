Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C99C0218D
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 13:53:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0C4F81E5A;
	Tue, 28 Jan 2025 14:52:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1738072379;
	bh=Dc7NgyiFjmviNFxfV27WVDCHAl6sLCFhaY6pNxvjfJQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=QJL5IR0nA/Cnq+kiKcuhQsZfrZPhWd2RohNnLcqoDfZMBVa4oSO2UGWoBhH6s1+mZ
	 o6V9a3cqKW13ksS1BNz6kkyiOEn2cJ2iN872sVPqV0DN7iJLfJMPArgNAuLNTkV23z
	 5JPn53pPfNlyoHMfmdI269038kHJ0oXfvRqObXf4x4rS0Dnmzg/h3MiuBiVgBI4k4W
	 eGaBTP8bYYA4XhqTdhc8I1Tvo8z3GTRw11gDjyd0xpWh5R+03ctYLINIWf8obdm3pa
	 F9S1VJs/ZQkib4jbJ+Ma2fhRBbPUaXo6eZ1ZW9q1vLpUBTdO9emh/TEp5WSAfm6Rjh
	 ICqMGH3dd8tNw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CE2081DCD; Tue, 28 Jan 2025 14:52:58 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FEC881DB4
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 14:52:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="XuqrO4LT"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1048710382D08; Tue, 28 Jan 2025 14:52:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1738072374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Dc7NgyiFjmviNFxfV27WVDCHAl6sLCFhaY6pNxvjfJQ=;
 b=XuqrO4LTc2WmYBWLQpfkd7XfciI77dGVdlHkZQmi719wlQXTAslOjaZ6e5/BYSo13AMqWd
 MJGu+kNzWu/KUF6drLCnYlaCi4gtNy0R3R2spMrt4XwqvRZrgtxRly+lCIb/xI9wcs5YJy
 45sI6AdAbw8O9JkZr+rfZqipk4rpFu5KBqxlsibkz7FE6tn/qTN+Z71tWdaV+WWXzAEiq7
 BXhCmLEVnpe6h4oHKf0hV4c+za7pmFyzWUEaGoiez6oRBNv2DFiGtWid7MEDvqTydwhsww
 WhSpsbg//GmOQNLk7AxPQKckR17Oc+imgwcTVGXYQsSnnG7gFuiCXWjhIY3Q8w==
From: Heiko Schocher <hs@denx.de>
To: u-boot@lists.denx.de
Cc: Heiko Schocher <hs@denx.de>, Christian Marangi <ansuelsmth@gmail.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 0/2] led: add function naming option from linux
Date: Tue, 28 Jan 2025 14:52:44 +0100
Message-Id: <20250128135246.74838-1-hs@denx.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

in linux we have the option to create the name of a led
optionally through the following properties:

- function
- color
- function-enumerator

This series adds support for parsing this properties if there
is no label property.

patch 1 is new in this series since v4, which deletes
the file doc/device-tree-bindings/leds/common.txt
as Tom suggested.

Azure build:
https://dev.azure.com/hs0298/hs/_build/results?buildId=168&view=results

shows an error:
https://dev.azure.com/hs0298/hs/_build/results?buildId=168&view=logs&j=c680f105-64bc-5146-6f22-9781d9f94790&t=9b6dc287-5896-5328-71bc-12fc1ca8ea8d

for sandbox64_clang ... sandbox64 target works!
The error has nothing ToDo with this patchseries,
as it is in dm_test_cmd_hash_md5, which tests content
from source files, this series do not touch.

Changes in v4:
- new in version 4
- remove ./doc/device-tree-bindings/leds/common.txt in
  seperate patch as this is now already in
  ./dts/upstream/Bindings/leds/common.txt
  as Tom commented.
  measured size impact of patch "led: add function naming option from linux":
        $ ./u-boot-size-test.sh capricorn_cxg3 --branch led-mainline
        [...]
           aarch64: (for 1/1 boards) all +886.0 rodata +230.0 text +656.0
                    capricorn_cxg3 : all +886 rodata +230 text +656
                       u-boot: add: 1/0, grow: 1/0 bytes: 416/0 (416)
                         function                                   old     new   delta
                         led_post_bind                              220     516    +296
                         led_colors                                   -     120    +120
        $ ./u-boot-size-test.sh aristainetos2c --branch led-mainline
        [...]
        01: Merge patch series "add the support of sha256_hmac and sha256_hkdf"
        40: led: add function naming option from linux
               arm: (for 2/2 boards) all +557.0 bss +20.0 rodata +161.0 text +376.0
                    aristainetos2c : all +557 bss +20 rodata +161 text +376
                       u-boot: add: 1/0, grow: 1/0 bytes: 264/0 (264)
                         function                                   old     new   delta
                         led_post_bind                              128     332    +204
                         led_colors                                   -      60     +60
                    aristainetos2ccslb: all +557 bss +20 rodata +161 text +376
                       u-boot: add: 1/0, grow: 1/0 bytes: 264/0 (264)
                         function                                   old     new   delta
                         led_post_bind                              128     332    +204
                         led_colors                                   -      60     +60
- rebase to current HEAD
  d8a7100d658. ("Subtree merge tag 'v6.13-dts' of dts repo [1] into dts/upstream")

Changes in v3:
- work in comment from Tom:
  remove new file include/dt-bindings/leds/common.h in this patch
  as it is already in dts/upstream/include/dt-bindings/leds/common.h
  and so the checkpatch warnings from this file are gone!
  Thanks! Good catch!
  remove file include/linux/uapi/linux/uleds.h and
  as we only need one define from it, add this define
  in include/led.h

Changes in v2:
- remove unused name variable in function led_get_label()
- rebased patch to current HEAD
  82d262ae162 ("Merge patch series "MediaTek MT7629 OF_UPSTREAM migration (v2)"")

Heiko Schocher (2):
  doc: remove redundant leds bindings
  led: add function naming option from linux

 arch/sandbox/dts/test.dts                | 37 ++++++++++++-
 doc/device-tree-bindings/leds/common.txt | 23 --------
 drivers/led/led-uclass.c                 | 70 ++++++++++++++++++++++--
 include/led.h                            |  6 ++
 test/dm/led.c                            | 22 +++++++-
 test/dm/ofnode.c                         |  2 +-
 6 files changed, 130 insertions(+), 30 deletions(-)
 delete mode 100644 doc/device-tree-bindings/leds/common.txt

-- 
2.20.1

