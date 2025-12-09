Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00207D3B996
	for <u-boot@archiver.kernel.org>; Tue,  9 Dec 2025 21:23:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A14983C72;
	Tue,  9 Dec 2025 22:23:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dQQLDdQJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A54283C7B; Tue,  9 Dec 2025 22:23:06 +0100 (CET)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40AFB83C6C
 for <u-boot@lists.denx.de>; Tue,  9 Dec 2025 22:23:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-4511fa1e3efso1942338b6e.0
 for <u-boot@lists.denx.de>; Tue, 09 Dec 2025 13:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765315383; x=1765920183; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=QarUppd9e041ts+7Ipne1RRuuzGVSHhWtbGvMfm+owE=;
 b=dQQLDdQJpKvJE0NEAWZJmaM8MY3p/6kPFQHOflC/PcDItxFr+Ls5qPvfouoKyfdwNv
 eQbjdQj9D8aev7eEb1BOPLRuL8smg3/koG34gxE5G+gKEQCQQDQz7BCzlm288Y0LuDS+
 ZG40rdWJ1M6Om4YSMxD66vWKz8rVMFlofKY7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765315383; x=1765920183;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QarUppd9e041ts+7Ipne1RRuuzGVSHhWtbGvMfm+owE=;
 b=l28pipajZY6z6HrJsZyxznIn0IqsYtbZlmsj3bc5r9tEwSXeP7y3OCNCcR5Jhl7Rrz
 N0F6vf17NCPxn9vkREx74Rms2ihQeRSjTfkHV92/pmOsRL0oW0TIbGGq/ECp+MSYStRN
 Ii9vOmKM8XKqvyLr2+9/LNgPm+9Uz3ccKOewcLzyqcZzxDt3sF6bZRvIr44lsCt4ed0O
 DiRUxwycYKLCXEPh3vl3rQFWGvyJ6e17AeRUGEaSZn6TCisMLudejZZNy5x5l8h4iqSx
 gYJrquCnoT4zvRjbcC6FqOwWDFHFyRtxaXXdJUtnaxyu115frBUoPQsuTUIANK39Ef3D
 U9Ng==
X-Gm-Message-State: AOJu0YxJOVmnyehz3K5uxRogR/1Zm3libIwFFmLLfIxb7rEnf1ChWhVQ
 UpQ2ZP2aY95xAdk4EKZvtXrPkqjigxCtfwHhrIk6QnWhWpYTMd7LxAKr4yeR8JJdy0uh6hTOF0a
 6JYLeTM0=
X-Gm-Gg: ASbGnctMR49/eG31bFXPg7TgdqvzKDNHPwoNq912kF3XrBvLZMBKxbHAOcT0zDIwuCk
 M2YUi+RpEDfjTazUPphaCzS5vX5McNdOx/QLtNrOtNFmidN+5qXUP2MfQaUpa2o9a5XF8tIqbv6
 nJRLH4U6CptMq692uO7apbJrpovJtFabTLMVwEdw04FNaadJsyEtqVmXSDxp3MJGoMzuZ4YX/MS
 W9D0Yf3BqLj+eu0CZPF5WXQV/SrDifWKLaPo1z1fXvBz/YSS/HX+2ashGdreh+9gLuBp+U8AuTw
 i5euD8c+E5X0PWOYh4yh74Ndd62Te5s/Fx0nvbfLMd/JizseNes/olzp+DlstVdM7ZOZkjwlHKK
 q7asOuMvf5GLYDvB29NudQZybvb3RcKGN+OhU6EJYgfPVFHRI9XTD0zoeGz+cyVZT3Zj8XZAdL6
 kXNJ3j2dpMT9yKFNPmzbhQX0Qcn706SsY1szFhO2s0ZDbkjafuAE6IEgvqhj1KtlI=
X-Google-Smtp-Source: AGHT+IG6XNK3shy6alS4da6Xj2Zurl2dVy7I6vW9DpIsCm/PfWESKVJs2frjgoifMSXwkq6bnqFewQ==
X-Received: by 2002:a05:6808:1448:b0:43f:5c61:448c with SMTP id
 5614622812f47-455864da11dmr205191b6e.39.1765315382890; 
 Tue, 09 Dec 2025 13:23:02 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4538f742e5asm6545827b6e.4.2025.12.09.13.23.02
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Dec 2025 13:23:02 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] fs: fat: Perform sanity checks on getsize in get_fatent()
Date: Tue,  9 Dec 2025 15:23:01 -0600
Message-ID: <20251209212301.2924760-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
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

We do not perform a check on the value of getsize in get_fatent to
ensure that it will fit within the allocated buffer. For safety sake,
add a check now and if the value exceeds FATBUFBLOCKS use that value
instead. While not currently actively exploitable, it was in the past so
adding this check is worthwhile.

This addresses CVE-2025-24857 and was originally reported by Harvey
Phillips of Amazon Element55

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 fs/fat/fat.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/fat/fat.c b/fs/fat/fat.c
index 89f2acbba1ef..9ce5df59f9ba 100644
--- a/fs/fat/fat.c
+++ b/fs/fat/fat.c
@@ -216,6 +216,11 @@ static __u32 get_fatent(fsdata *mydata, __u32 entry)
 		if (flush_dirty_fat_buffer(mydata) < 0)
 			return -1;
 
+		if (getsize > FATBUFBLOCKS) {
+			debug("getsize is too large for bufptr\n");
+			getsize = FATBUFBLOCKS;
+		}
+
 		if (disk_read(startblock, getsize, bufptr) < 0) {
 			debug("Error reading FAT blocks\n");
 			return ret;
-- 
2.43.0

