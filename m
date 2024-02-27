Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05416C5478C
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 06:56:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A4B787FA7;
	Tue, 27 Feb 2024 07:56:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=lexina.in
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=lexina.in header.i=@lexina.in header.b="M3SHo7Cn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E3B687FC3; Tue, 27 Feb 2024 07:56:06 +0100 (CET)
Received: from mx.msync.work (mx.msync.work [62.182.159.68])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56FE387FA4
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 07:56:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=lexina.in
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=adeep@lexina.in
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4446E12F40C; Tue, 27 Feb 2024 06:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
 t=1709016962; h=from:subject:date:message-id:to:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=Ta3AyTsxEaqnTGHWH/W2ZM+lr0IMFhDKPlBFe92WqCM=;
 b=M3SHo7CngWLRCg0GftNBQWD2LFpEwTque2VSe5akIvv/gainYLFwkWQbqJF2tuY6EDIipB
 pBz7PmTdeD25YmHTnFZe2zWYbFEwvBFUZgVVGWHSZUPebf0UnzFnW/YFuaUrOnV3k1eN7X
 aCqawul9sGzIMhkn87jRBtlMdij02Xd9flmR09a14chQoKbidOLwWayWN9TnXEVzUSz6fV
 sJDKV2tSPMCdA54OR6PsSUAVWFr85HmMa6lDSSQabV+jiT8qlNZBFC49oQbgLS8dWHVHDk
 J4MwK5Hyw797r16NdbDosY0ZgxdsG/uIxVTL9woQLjXKS25ZZ3Oa4txyOvYFRQ==
From: Viacheslav Bocharov <adeep@lexina.in>
To: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot-amlogic@groups.io, u-boot@lists.denx.de
Subject: [PATCH v1 1/3] board: amlogic: jethubj100: fix common config header
Date: Tue, 27 Feb 2024 09:54:04 +0300
Message-ID: <20240227065551.580199-2-adeep@lexina.in>
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

Fix JetHub board sequence to read correct gpio for rescue button

Signed-off-by: Viacheslav Bocharov <adeep@lexina.in>
---
 include/configs/jethub.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/configs/jethub.h b/include/configs/jethub.h
index e22db4991de..2c44bfc853e 100644
--- a/include/configs/jethub.h
+++ b/include/configs/jethub.h
@@ -11,7 +11,7 @@
 #if defined(CONFIG_MESON_AXG)
 #define BOOTENV_DEV_RESCUE(devtypeu, devtypel, instance) \
 	"bootcmd_rescue=" \
-		"if gpio input 10; then " \
+		"if gpio input periphs-banks10; then " \
 		"run bootcmd_mmc0; " \
 		"run bootcmd_usb0;" \
 		"fi;\0"
-- 
2.43.2

