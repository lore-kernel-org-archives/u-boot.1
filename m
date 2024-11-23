Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DF42E66889
	for <u-boot@archiver.kernel.org>; Sat, 23 Nov 2024 21:44:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35C798929F;
	Sat, 23 Nov 2024 22:44:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iEsyJC+g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68FEB88E96; Sat, 23 Nov 2024 22:44:11 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EA1E89160
 for <u-boot@lists.denx.de>; Sat, 23 Nov 2024 22:44:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=devnull+j.jannau.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id CF1D95C5038;
 Sat, 23 Nov 2024 21:43:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E035EC4CED0;
 Sat, 23 Nov 2024 21:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1732398246;
 bh=D+WGhlriBWzfyNO5tBInnnqQfl7xFbmDlnMv7CQ+izw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=iEsyJC+gnXqNXsnD8eRZFSt5pdfQkcUWc3b3DS7u2QX5dD4a9VeceDJ7lW2w15GXX
 u1av+w8rKtSnrNbD7ETyYWAK0rzL5bP9bKNmO9ii2xH0K6bPGdpDy8gpnaAETv2tPj
 McMbXQExjyWb3o9pesXqtxUolRMw6t9P20fvepvokcA/2pKbcFYfXw65NUdxcZ5Cag
 gIXrDb2Vl7zBA5y69cXvyZmjm8dqqIrDeli0d99+mSywWtLL/nVv1yql0Jyav/yYu7
 HybMLz6Ba7xkWBo1DK/+km+5/5G49kKEey9W9wLV3SZUloCZp/pTNHo1/OeldnRwu7
 hGAty2JBAHXIw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id CC7FAE66889;
 Sat, 23 Nov 2024 21:44:06 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Date: Sat, 23 Nov 2024 22:44:04 +0100
Subject: [PATCH v2 1/2] iommu: apple: Mark device with DM_FLAG_VITAL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241123-iommu_apple_dart_ordering-v2-1-cc2ade6dde97@jannau.net>
References: <20241123-iommu_apple_dart_ordering-v2-0-cc2ade6dde97@jannau.net>
In-Reply-To: <20241123-iommu_apple_dart_ordering-v2-0-cc2ade6dde97@jannau.net>
To: Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Bin Meng <bmeng.cn@gmail.com>
Cc: u-boot@lists.denx.de, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=881; i=j@jannau.net;
 s=yk2024; h=from:subject:message-id;
 bh=VcMS4Mwn1t2CU29JtOi4fio13jUTlPQHyjkPb8z53DY=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhnQnn6UiT6saz5yck3H6qOtdlrD3omGO0wrWBjF9/jRlv
 o/1rI3SHaUsDGJcDLJiiixJ2i87GFbXKMbUPgiDmcPKBDKEgYtTACYS8puR4cGL/5f8f934bzjd
 OP3tiXvfp6wsN1bjvb9lmmz7kSeXuooZ/of/SJoqckqldnGOe4zY/9dHWb9eeOWx6MreE8dvBhz
 +k8cAAA==
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Endpoint-Received: by B4 Relay for j@jannau.net/yk2024 with auth_id=264
X-Original-From: Janne Grunau <j@jannau.net>
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
Reply-To: j@jannau.net
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Janne Grunau <j@jannau.net>

Avoids NULL pointer dereferences in apple_dart_unmap when the iommu
device is removed before its user. U-boot's device model does not track
dependencies between devices.
Observed on a M1 Ultra Mac Studio with v2024.10.

Acked-by: Mark Kettenis <kettenis@openbsd.org>
Signed-off-by: Janne Grunau <j@jannau.net>
---
 drivers/iommu/apple_dart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/apple_dart.c b/drivers/iommu/apple_dart.c
index 3e9e7819e517b8fe62b9e429b7a8ca3eca29741d..bfd4ad2010547de34d67f48e9b58295429ca8d3c 100644
--- a/drivers/iommu/apple_dart.c
+++ b/drivers/iommu/apple_dart.c
@@ -322,5 +322,5 @@ U_BOOT_DRIVER(apple_dart) = {
 	.ops = &apple_dart_ops,
 	.probe = apple_dart_probe,
 	.remove = apple_dart_remove,
-	.flags	= DM_FLAG_OS_PREPARE
+	.flags	= DM_FLAG_OS_PREPARE | DM_FLAG_VITAL
 };

-- 
2.47.0


