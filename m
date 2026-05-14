Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D70A7CD4851
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 14:50:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CEC8846AD;
	Thu, 14 May 2026 16:49:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="u4FhkO6Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89D2E83FB0; Thu, 14 May 2026 14:50:06 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id CED5C8467B
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 14:50:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=harsimransingh.tungal@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8226244C;
 Thu, 14 May 2026 05:49:54 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.69.131])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 398283F7B4;
 Thu, 14 May 2026 05:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1778763000; bh=lI93Fx9xDWH1S7NLKwcf6Sa+NjE6SGYbBMFprWUyqPY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=u4FhkO6Q7C9dKSBByJh5d+QqSfnGwhcDeTHDbVoCRzaU+gd+cnRqKxbzlvXsXhF/g
 jnCfEz+ANA0x6FzL0ww5Sq8EKZYICWJQOQnQzd1gDx8odJkIKexI78T9kP/qdhsBaq
 DFQq41nr5PYx4SZKd6NTwX9vj2QvzBbedGxdjYPU=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.denx.de
Cc: abdellatif.elkhlifi@arm.com, trini@konsulko.com,
 ilias.apalodimas@linaro.org, xypron.glpk@gmx.de,
 hugues.kambampiana@arm.com, sjg@chromium.org,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v2 05/11] charset: mark u16_strsize() as __efi_runtime
Date: Thu, 14 May 2026 13:49:18 +0100
Message-Id: <20260514124924.1804332-6-harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260514124924.1804332-1-harsimransingh.tungal@arm.com>
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
 <20260514124924.1804332-1-harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 14 May 2026 16:49:29 +0200
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

Mark u16_strsize() as __efi_runtime so it can be called from the EFI
runtime variable paths added for FF-A/MM communication after
ExitBootServices().

Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
---
 lib/charset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/charset.c b/lib/charset.c
index 182c92a50c4..738ad1352de 100644
--- a/lib/charset.c
+++ b/lib/charset.c
@@ -407,7 +407,7 @@ size_t __efi_runtime u16_strnlen(const u16 *in, size_t count)
 	return i;
 }
 
-size_t u16_strsize(const void *in)
+size_t __efi_runtime u16_strsize(const void *in)
 {
 	return (u16_strlen(in) + 1) * sizeof(u16);
 }
-- 
2.34.1

