Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD3F0CD4933
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 22:59:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9196686C64;
	Thu, 21 Sep 2023 00:58:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="OdMpbIKJ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Le2p5jpu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A9A786C42; Thu, 21 Sep 2023 00:58:42 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D51D86C24
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 00:58:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4RrYqN06jKz9sqL;
 Thu, 21 Sep 2023 00:58:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1695250720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WZSwCKl/13hAshU9+6y0sOr3xesW0K6q/gHShhR/OWY=;
 b=OdMpbIKJRQACrpDNbnO2OpuyjjmqIoGC4aiD6JKIyYW26kVc12XwJP8zA3U1JyPO89M23E
 2N470EBTiOF7ORHDbOcPsfqdgCl39pjcBQoOQSV6WI5ZAl6JGZc94vS4Ue5eU09J2NJpKW
 JKH819uiyka+gHKsdNM29AQPWk97H3j9ILo7iP7jW8XAidVe9WO43aIAKJEc6+I2PvWNGK
 ZECtUdTbl31ZUdfkS1oFg40g7dgQFJdrj3beZKGGOEmi0YhQ7h/NgvWbCfBnbLUxdPu9Tp
 yG2eqfmfEospSwwu7OGTdt+wzFlcKZ0eLZUIQG0ukRTwQI4/jeVm12Od8rvPig==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1695250718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WZSwCKl/13hAshU9+6y0sOr3xesW0K6q/gHShhR/OWY=;
 b=Le2p5jpuFMKgKKJ+jGn3xiZtRAZlTvAKVi+zJSxDj2koxzsqrC7HTyHh/kEUtKIL11R2hx
 lVoVVPPohImh9c7iDK49UjXttW2xgy8s1YJfKIo8sTRJG/Ry4kvJzXEySHv9nVaK/59/+v
 AsnxpF3fwbeD7qr6l2tcohV9+eokcPXtrCD0h46t+Kckb1bsjWInz98qco1jYpj9gZl39j
 EtEpF1cCaBplFOBlFDvbcJe1Jqc3E7kXUwY5BTeANsyVyY/L/LmZeHpTr7ooVMhrl1NFiv
 HotRzKvfIwD+tiyM3Cz4UWhxT8894ac/6iugyZSOv/ie4YFVZta5YJBXJoIE3Q==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bin Meng <bmeng.cn@gmail.com>, Mario Six <mario.six@gdsys.cc>,
 Nikhil M Jain <n-jain1@ti.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 4/9] configs: sandbox: Enable GETOPT for sandbox and sandbox64
 target
Date: Thu, 21 Sep 2023 00:58:06 +0200
Message-Id: <20230920225811.153474-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230920225811.153474-1-marek.vasut+renesas@mailbox.org>
References: <20230920225811.153474-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 96ed29714ec70b2b824
X-MBO-RS-META: spjg49d6a3yu9kadu3p91sdds85pf7ud
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

Enable GETOPT so that 'bdinfo' command with getopt() support can be
tested in CI.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Bin Meng <bmeng.cn@gmail.com>
Cc: Mario Six <mario.six@gdsys.cc>
Cc: Nikhil M Jain <n-jain1@ti.com>
Cc: Simon Glass <sjg@chromium.org>
---
 configs/sandbox64_defconfig | 1 +
 configs/sandbox_defconfig   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/sandbox64_defconfig b/configs/sandbox64_defconfig
index fd110d99a3a..8aef76a5c00 100644
--- a/configs/sandbox64_defconfig
+++ b/configs/sandbox64_defconfig
@@ -262,6 +262,7 @@ CONFIG_CMD_DHRYSTONE=y
 CONFIG_TPM=y
 CONFIG_LZ4=y
 CONFIG_ERRNO_STR=y
+CONFIG_GETOPT=y
 CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
 CONFIG_EFI_CAPSULE_ON_DISK=y
 CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index d667cb9ae47..ca54e445426 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -338,6 +338,7 @@ CONFIG_ECDSA_VERIFY=y
 CONFIG_TPM=y
 CONFIG_SHA384=y
 CONFIG_ERRNO_STR=y
+CONFIG_GETOPT=y
 CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
 CONFIG_EFI_CAPSULE_ON_DISK=y
 CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
-- 
2.40.1

