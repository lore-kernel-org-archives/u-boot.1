Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22B6EC28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 16:32:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19DC081DCD;
	Fri, 28 Mar 2025 17:32:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hUAGYtI2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BC3381E13; Fri, 28 Mar 2025 17:29:41 +0100 (CET)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A80C08144A
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 17:29:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id E12F7A408EE;
 Fri, 28 Mar 2025 16:24:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C8BC4CEE4;
 Fri, 28 Mar 2025 16:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1743179376;
 bh=NBRPIyh3PZYiuoz8caI/jv21mxMf5rIMys4WzdDFGKs=;
 h=From:Date:Subject:To:Cc:From;
 b=hUAGYtI2psdgJCJcU3sYnJ+aqRg7B7DLn7UYUDnXrmP3uNXcxh0ZO0OgezA2WJqDn
 Jsv1qoe1unjQslLqjwHr0n5eJJNCw/0fqiSJTM8AMHuu7O8q5MN9KF80pXU+A/K+2s
 vqK5jnypKXwBI5iP/013+RXOmABtd7HPWw1c/MYQ49AynPuUbFOruqJzy9/JrTg9rf
 8w+kCGuQzHznvfja4KEhI8ccog+u/peOKeAvRJarOZ63BrLlWNeO6DREwG1H8JXWJW
 c1DPQM1KJir7MjtsseVzBdwj9imoUHvIEBNv7bHHr9qFfBAgul7qh2dhK3FSRK6XJ6
 A63DiY4oyL5gA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
Date: Fri, 28 Mar 2025 17:29:27 +0100
Subject: [PATCH] MAINTAINERS: Update email of Mattijs Korpershoek
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250328-mattijs-korg-v1-1-e3f61c80d767@kernel.org>
X-B4-Tracking: v=1; b=H4sIAGbO5mcC/x3MQQ5AMBBA0avIrDVBIylXEQtqMITKTCNEendl+
 Rb/PyDIhAJ18gDjSUJuj8jTBOzc7RMqGqKhyIoy03mlts57WkStjifVG9SmKq1GayAmB+NI179
 r2uiZxDu+v3sI4QXhQaoNbQAAAA==
X-Change-ID: 20250319-mattijs-korg-b8e3895c3ec8
To: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.14.3-dev-7b9b9
X-Developer-Signature: v=1; a=openpgp-sha256; l=2711;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=NBRPIyh3PZYiuoz8caI/jv21mxMf5rIMys4WzdDFGKs=;
 b=owEBbQGS/pANAwAIARkNHbRmThk1AcsmYgBn5s5uz70Pk1oNHeeIWcJUdulNeQ7V4+COpDEQB
 Uv2OvIa4LOJATMEAAEIAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCZ+bObgAKCRAZDR20Zk4Z
 NdGgB/kBtx8j+4adsIfZy5HFz6BB57GM7CG+cxmta717rY8NuSYG08evAGReE+LWHCER+vcDtia
 Ss6S1CDsREFUuh65Xl1aYS183uvOEQGncFol3xGwQz0S9L9550bkjWEbFun81/DesXFAPJUvceY
 sVZS25Gz9hnR2NQ6+dQ9kaukHM+pDAt8ZiF/dYg0I3vAPHcG719JC1GW86enVIQAv23eDohxgFf
 zfXDHNZsDTnrJ1vxr6KhHiHBtxSDkjfiSpsK3rTMMBIaxk0jMUd1u42c4DQx6LHeiJJgnZho+1U
 70sYSwBtx/k71z0M71zIINkmWBWbafXvvpZFWSilYSazj767
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28
X-Mailman-Approved-At: Fri, 28 Mar 2025 17:32:08 +0100
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

My preferred email address is mkorpershoek@kernel.org now.

This updates the MAINTAINERS files and adds an entry in the
.mailmap file.

Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 .mailmap    |  1 +
 MAINTAINERS | 10 +++++-----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/.mailmap b/.mailmap
index ff85151702f8..85086602cd50 100644
--- a/.mailmap
+++ b/.mailmap
@@ -76,6 +76,7 @@ Marek Vasut <marex@denx.de> <marex at denx.de>
 Markus Klotzbuecher <mk@denx.de>
 Masahiro Yamada <masahiroy@kernel.org> <yamada.masahiro@socionext.com>
 Masahiro Yamada <masahiroy@kernel.org> <yamada.m@jp.panasonic.com>
+Mattijs Korpershoek <mkorpershoek@kernel.org> <mkorpershoek@baylibre.com>
 Michal Simek <michal.simek@amd.com> <Monstr@seznam.cz>
 Michal Simek <michal.simek@amd.com> <michal.simek@xilinx.com>
 Michal Simek <michal.simek@amd.com> <monstr@monstr.eu>
diff --git a/MAINTAINERS b/MAINTAINERS
index 0315c606744c..042d3f6160ae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -66,7 +66,7 @@ F:	lib/alist.c
 F:	test/lib/alist.c
 
 ANDROID AB
-M:	Mattijs Korpershoek <mkorpershoek@baylibre.com>
+M:	Mattijs Korpershoek <mkorpershoek@kernel.org>
 R:	Igor Opaniuk <igor.opaniuk@gmail.com>
 R:	Sam Protsenko <semen.protsenko@linaro.org>
 S:	Maintained
@@ -77,7 +77,7 @@ F:	include/android_ab.h
 F:	test/py/tests/test_android/test_ab.py
 
 ANDROID AVB
-M:	Mattijs Korpershoek <mkorpershoek@baylibre.com>
+M:	Mattijs Korpershoek <mkorpershoek@kernel.org>
 R:	Igor Opaniuk <igor.opaniuk@gmail.com>
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-dfu.git
@@ -971,7 +971,7 @@ F:	net/eth_bootdevice.c
 F:	test/boot/
 
 BOOTMETH_ANDROID
-M:	Mattijs Korpershoek <mkorpershoek@baylibre.com>
+M:	Mattijs Korpershoek <mkorpershoek@kernel.org>
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-dfu.git
 F:	boot/bootmeth_android.c
@@ -1050,7 +1050,7 @@ N:	OF_UPSTREAM
 
 DFU
 M:	Lukasz Majewski <lukma@denx.de>
-M:	Mattijs Korpershoek <mkorpershoek@baylibre.com>
+M:	Mattijs Korpershoek <mkorpershoek@kernel.org>
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-dfu.git
 F:	cmd/dfu.c
@@ -1162,7 +1162,7 @@ F:	test/common/event.c
 F:	test/py/tests/test_event_dump.py
 
 FASTBOOT
-M:	Mattijs Korpershoek <mkorpershoek@baylibre.com>
+M:	Mattijs Korpershoek <mkorpershoek@kernel.org>
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-dfu.git
 F:	cmd/fastboot.c

---
base-commit: 3f9e0349c3e8afe45d5bdb2328a16512cfbc2ef1
change-id: 20250319-mattijs-korg-b8e3895c3ec8

Best regards,
-- 
Mattijs Korpershoek <mkorpershoek@kernel.org>

