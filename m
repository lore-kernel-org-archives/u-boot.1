Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F782C61DC7
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 19:53:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E403B6081F;
	Thu, 27 Aug 2026 19:53:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nxOGCyHD68zV; Thu, 27 Aug 2026 19:53:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787860436;
	bh=YN//ntP1oquyTXGFIDEyGARDundDE1Ft2rX1nQDpu9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XuT2YqSOqUMrIB4lsKV0hxipYlpZCObACXjMxjWXB44mHXqqqxs2gLKM/Hak996/U
	 9Ff8xMItvyoQKIlAqahODVgb3t0eMx+ZAsno/SMB4JdtbzKCngx2ByOxll+qqAXFGk
	 mLw7yTFQNNh9umZ7kDNKDcDIRnk2TM4vfBXodB0SYfu2ieq4Lq7Z9L8aTKv3bVyDIs
	 +wJXIk0cGXPKSZtwc2rhHy5Mib2VIDjRDBGGa4JfSTgNIuIEZ2yWb+e9Bj3eJt3d+f
	 WlNi6yFXVMW08Lj1jzXPU9cCq1B2iljCQ7Ggi8T30ZI8699DXbvbCHuBwynj8Ox8Oy
	 ufyRKbZOcsKCQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8C6AC60816;
	Thu, 27 Aug 2026 19:53:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D9E7E75
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 19:53:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CC90F400D7
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 19:53:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QVR53R5A8VZo for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 19:53:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=83.166.143.170;
 helo=smtp-8faa.mail.infomaniak.ch; envelope-from=foss+uboot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=QMKhVS/u
Received: from smtp-8faa.mail.infomaniak.ch (smtp-8faa.mail.infomaniak.ch
 [83.166.143.170])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 63F63400D5
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 19:53:50 +0000 (UTC)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246c])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hWBzJ3jh1z118x;
 Thu, 27 Aug 2026 21:53:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1787860428;
 bh=YN//ntP1oquyTXGFIDEyGARDundDE1Ft2rX1nQDpu9E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=QMKhVS/uaR4I6mpJ0giCsDY/PjuYMcgXnuFDwSm7f8oi+9O7gj1Y7jeu2GFzYUU39
 dOBKBCwARyihYPTJ70IKki1OQQVkz2PbKC29cHl9kUK5aMiELn+u1ZWXYyxeNeT/AG
 evMmytnwBlPIbHB5eGVp3+zFOwcNHOHTME9QrIdDGDE0WUY49CJUinS9K2amcOR0ig
 lebZ+Fp+q/XugoS0RkVGifDtDXAEHGo7UoDJkv0tFEwlCH6E9hVLA5zYa64JbsGrDX
 dWkaJ9vHimd4d5Na340Ewu982x7VJtujmdbw5HlMipkJgV1bn3cMH9xUlB8e+idz9/
 xFNV+G+iyZksw==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hWBzG4Q3jzQYS; Thu, 27 Aug 2026 21:53:46 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
To: u-boot@lists.u-boot-project.org,
	u-boot-amlogic@groups.io
Cc: uboot-imx@nxp.com, trini@konsulko.com, sjg@chromium.org,
 neil.armstrong@linaro.org, marek.vasut+renesas@mailbox.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, adeep@lexina.in,
 sbabic@nabladev.com, festevam@gmail.com, smoch@web.de,
 alpernebiyasak@gmail.com, le.jin@siemens.com, jan.kiszka@siemens.com,
 iwamatsu@nigauri.org, pbrobinson@gmail.com, seanga2@gmail.com,
 bmeng.cn@gmail.com, lukma@denx.de, mkorpershoek@kernel.org,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH 26/45] doc: chromium: update Firmware porting guide link
Date: Thu, 27 Aug 2026 21:52:54 +0200
Message-ID: <20260827195313.129994-5-foss+uboot@0leil.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de>
References: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Quentin Schulz <quentin.schulz@cherry.de>

It currently serves a 404. Looking at the Wayback Machine[1], I found a
similar page currently being served. It's probably very outdated by now
but at least it's not a 404 anymore.

[1] https://web.archive.org/web/20230520044331/https://www.chromium.org/chromium-os/firmware-porting-guide/
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/chromium/overview.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/chromium/overview.rst b/doc/chromium/overview.rst
index 23f224b30594..acd9ab8bfcba 100644
--- a/doc/chromium/overview.rst
+++ b/doc/chromium/overview.rst
@@ -71,4 +71,4 @@ Here is some material relevant to Chromium OS verified boot with U-Boot:
 
    - `Chromium OS U-Boot <https://www.chromium.org/developers/u-boot>`_
 
-   - `Firmware porting Guide <https://www.chromium.org/chromium-os/firmware-porting-guide>`_
+   - `Firmware porting Guide <https://www.chromium.org/chromium-os/developer-library/guides/firmware/firmware-porting-guide/>`_
