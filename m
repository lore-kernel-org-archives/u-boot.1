Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DEF7C25B74
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 07:14:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05B2988702;
	Tue, 21 May 2024 09:13:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CDT/rWuj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20CE58803E; Tue, 21 May 2024 09:13:51 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 238F488719
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 09:13:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 108666201E;
 Tue, 21 May 2024 07:13:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30BC2C32782;
 Tue, 21 May 2024 07:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1716275627;
 bh=wr43Ls3kS9v++eJj9oia9bi6eJXVJ3tY49h9p8I1eSY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CDT/rWujlypDUz+sCDrNZ8wzNCfWFBEEHmu3F/ISYtLNZ2AuK5u6PbLbukUn8QFAi
 UP1c7I1eqo+WHy4iMF3bcMtWMSo5T3yKBIuzbZBkH45ZjUv5OdVGTcNRT1bmiTMj9C
 unkly/aWltnNty/DyOGBaLzOZX8Yxc/4mMcVd93HKd/xfRRkJtkzjJV5c5av7P5UkB
 4q2DW0NTUxhjYmnTKmVs502UUui3y/9j8yoiufwNAeC3D3poT1mwN5WZQkqViYvdbl
 2nOAM++9VHzQzgBEK6z9dIxEtx4BaWZlnH9y575p++w93rk+k94oUpet+LHsJhFHOJ
 5GwZN6ew9uKgA==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Stefan Roese <sr@denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nikita Kiryanov <nikita@compulab.co.il>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 04/11] common: eeprom_field: Drop unnecessary comparison
Date: Tue, 21 May 2024 09:13:28 +0200
Message-ID: <20240521071335.4193-5-kabel@kernel.org>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20240521071335.4193-1-kabel@kernel.org>
References: <20240521071335.4193-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The byte variable is of type unsigned char, it is never less than zero.
The error case is handled by *endptr, so drop the comparison altogether.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 common/eeprom/eeprom_field.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/eeprom/eeprom_field.c b/common/eeprom/eeprom_field.c
index 9b831414a4..26f6041e54 100644
--- a/common/eeprom/eeprom_field.c
+++ b/common/eeprom/eeprom_field.c
@@ -56,7 +56,7 @@ static int __eeprom_field_update_bin(struct eeprom_field *field,
 		}
 
 		byte = simple_strtoul(tmp, &endptr, 16);
-		if (*endptr != '\0' || byte < 0)
+		if (*endptr != '\0')
 			return -1;
 
 		field->buf[j] = byte;
-- 
2.44.1

