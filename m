Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A56ACD98DE
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 12:29:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D703684869;
	Mon, 15 Jun 2026 14:29:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EXIG9SKd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8769684877; Mon, 15 Jun 2026 14:29:35 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88256846A4
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 14:29:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0E07643C87;
 Mon, 15 Jun 2026 12:29:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 535FB1F000E9;
 Mon, 15 Jun 2026 12:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781526571;
 bh=LCPjqzjdsDo3UH7NHEGB00BqBcwQCkecR4Ekac8CuNM=;
 h=From:Date:Subject:To:Cc;
 b=EXIG9SKdD9X60Gm7xPB9akfqPQfa3PKvN2opqpK+rMme6uFr9lRtsdnvb26j7iDAt
 YVP7NyEHh+VkMvEOGJi4C4hhNXW7glAJcs8XkzWy70Dzfdqf+BeKxzmk9Ki3hACaWZ
 9Dww2FhbCmrkY4m7pc6awr6YHMTj4Vahs7PB95uu8VjV1z5woYs715W9JhXdf331w9
 +cy+5qzDGTP+47AtdKABqvyHuYhHwTLPfkmDXbffNwbT/6RlZ1tbpvdueF3Br7XT6C
 C2baIa0Gc2bQ5XrHpQRj4XIvq8xrw3G/0Wmor7WCxTWb83KY0DXXhEcfVimEpgMOLU
 oZ4matzxkTY+A==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
Date: Mon, 15 Jun 2026 14:29:28 +0200
Subject: [PATCH] doc: android: fastboot: Document halt behaviour
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-fastboot-doc-ctrl-c-v1-1-f932dea17c0a@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqEMAxA0atI1hOwijp4FZlFjalGBitNZxDEu
 1t1+Rb/76AchBXabIfAf1HxS4J5ZUCTXUZGGZKhyIs6r02FzmrsvY84eEKK4YuEpbPUlJV5k2N
 I5RrYyXZfu89j/fUzU7xWcBwnPPAwKHcAAAA=
X-Change-ID: 20260615-fastboot-doc-ctrl-c-3fac73518cfe
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Ariel D'Alessandro <ariel.dalessandro@collabora.com>, 
 Sam Day <me@samcday.com>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1067;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=8xISImot0/jM/DR4zfOL1ndIIvD6nSivhzuqO+ChUPg=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBqL/Apkx4LgL/bqXfjiCxWopKw5+IVRvVUbZSWh
 39RSz7I7/+JATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCai/wKQAKCRAZDR20Zk4Z
 NWp+CACJIk5uak9FuEri24c/t1EnbOXCl3k3pmS7vh+OOwXLiDVpgKGL19oU7ckBSy+a+YDZMAR
 SlLsmvVGWFY4/tS5iFqsFthA/yvAj2NVyBxk2/i7Hny6B72VCjWaQ3gR9tifd4S3xwv/eH8xleD
 G5WpWR93bU0CxC1+72jBELe59Udzol+d6GCZZCxisIki3VSsOrOg6QcoXthdDKPJARj7XwXnpYi
 zT/MM0jMNqnsABBvBLl3TDW7tt8nra7ZF/SIes4DmHhNbTtrX9c4Px+RehNSlhDip88vcCpStJK
 azGAQEOC+3JyTyMFfh3trSEWio8amZPfyc2Px41ETTUYLag2
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28
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

It's possible to interrupt the fastboot command from the U-Boot shell
using the Ctrl-c keybinding.

Document this.

Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 doc/android/fastboot.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/android/fastboot.rst b/doc/android/fastboot.rst
index 19e2ee9d4074..818b8815ebdc 100644
--- a/doc/android/fastboot.rst
+++ b/doc/android/fastboot.rst
@@ -212,6 +212,11 @@ or initiate a reboot::
 
 and once the client comes back, the board should reset.
 
+It's possible to interrupt the fastboot command using Ctrl-c::
+
+   => fastboot usb 0
+   Operation aborted.
+
 You can also specify a kernel image to boot. You have to either specify
 the an image in Android format *or* pass a binary kernel and let the
 fastboot client wrap the Android suite around it. On OMAP for instance you

---
base-commit: 1e80ee41441c612f05787a93bbef4e6e422e29d1
change-id: 20260615-fastboot-doc-ctrl-c-3fac73518cfe

Best regards,
--  
Mattijs Korpershoek <mkorpershoek@kernel.org>

