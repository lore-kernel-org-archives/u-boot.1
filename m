Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E187C54798
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 06:56:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3369C87FCD;
	Tue, 27 Feb 2024 07:56:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=lexina.in
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=lexina.in header.i=@lexina.in header.b="MFsAK/ED";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE70A87FCB; Tue, 27 Feb 2024 07:56:07 +0100 (CET)
Received: from mx.msync.work (mx.msync.work [62.182.159.68])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D10CC87EFE
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 07:56:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=lexina.in
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=adeep@lexina.in
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0DC2512F35A; Tue, 27 Feb 2024 06:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
 t=1709016965; h=from:subject:date:message-id:to:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=MXZ6wHnBKbqx1Q5YHLG9K3YBob6TS5YdsHhBdhVs2oo=;
 b=MFsAK/EDAJOb6msnTQAfeXDYqLP2/UClFWLfspHy9QLu2YT8hGzZGAsIcrLqpQqvKtlapB
 KT1z/M2TRsifmfvlvHvsnZJN/VRKv2O43nbHHzU1VFc18AWuJyZZUW0oFG6us0dOfVZ+Mh
 Gy9DygHFuY3ADpdLYBGsS99BnGu+Z3nV2tgd1zXjgtN8oYuSrDvDMe8+Mrv9n96Zli17O7
 +8YJjM/PoZirv4hikpNo85OIZLZOqSdP+i3DFSgP6IIWBP5fAM+SA+NZWJJyrEl5sooZdL
 UmxC2gGIv1daR00DsyMJLriVvWUqsG/lLIIlY14NOWeqA5dpyR5Jb4mg79HfdA==
From: Viacheslav Bocharov <adeep@lexina.in>
To: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot-amlogic@groups.io, u-boot@lists.denx.de
Subject: [PATCH v1 3/3] board: amlogic: jethubj100: update docs
Date: Tue, 27 Feb 2024 09:54:06 +0300
Message-ID: <20240227065551.580199-4-adeep@lexina.in>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240227065551.580199-1-adeep@lexina.in>
References: <20240227065551.580199-1-adeep@lexina.in>
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

Improove documentation, add new revision.

Signed-off-by: Viacheslav Bocharov <adeep@lexina.in>
---
 doc/board/amlogic/jethub-j100.rst | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/doc/board/amlogic/jethub-j100.rst b/doc/board/amlogic/jethub-j100.rst
index 86acdafa06f..80bed6e919e 100644
--- a/doc/board/amlogic/jethub-j100.rst
+++ b/doc/board/amlogic/jethub-j100.rst
@@ -1,9 +1,9 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
-U-Boot for JetHub J100 (A113X)
+U-Boot for JetHub J100/J110 (A113X)
 ==============================
 
-JetHome Jethub D1 (http://jethome.ru/jethub-d1) is a home automation controller device
+JetHome Jethub D1/D1+ (http://jethome.ru/jethub-d1p) is a home automation controller device
 manufactured by JetHome with the following specifications:
 
  - Amlogic A113X (ARM Cortex-A53) quad-core up to 1.5GHz
@@ -23,7 +23,10 @@ manufactured by JetHome with the following specifications:
 
 The basic version also has:
 
- - TI CC2538 + CC2592 Zigbee Wireless with upto 20dBm output power and Zigbee 3.0
+ - Zigbee module one from:
+   - TI CC2538 + CC2592 Zigbee 3.0 Wireless
+   - TI CC2652P1 Zigbee 3.0 Wireless
+   - Silicon Labs EFT32MG21 Zigbee 3.0/Thread Wireless
  - 1 x 1-Wire
  - 2 x RS-485
  - 4 x dry contact digital GPIO inputs
-- 
2.43.2

