Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96464C7EE30
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 01:07:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12E0A82E27;
	Wed,  2 Jul 2025 03:06:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RM8PEsOB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94F0F82CFA; Wed,  2 Jul 2025 03:06:02 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45D9B82E27
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 03:06:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-735b2699d5dso1960269a34.0
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 18:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751418359; x=1752023159; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=959q7XjivxqOUBqznitxi8LXDeN5r91EWHnsxfAL2y0=;
 b=RM8PEsOBYhTeih4aUWLkm8ZIozdKfzTBO9QM/gT6viSo4K8klOvC3H3//iLGiH0aW6
 7nFN23QkCzqAGh/mKMwgINCDacr4IsCqc4JaE9srn8fqoC6cf96Kj6YyRy4Nu7Puy5eV
 GMLsL/+mbGGaAIcBUYrL6qi2/sm7uPwXfY/4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751418359; x=1752023159;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=959q7XjivxqOUBqznitxi8LXDeN5r91EWHnsxfAL2y0=;
 b=XPYKEh7tY6wRvoUv+lD1m65Bmktbx2370Hrl6RMJLcgT8P5LmaDN7h2RZ/0NUWQLI3
 XvzFntFPD2Ex3nYeeAGK3GWsRRXcvCF6VnOM1atqUwgDBxeLWgElyS3b+5quWN4QrPp/
 oTm5eg33/EGiHc4pR4+QQFRbBDUxHoSM0CwzMiBEjY6Eb9greV0FTsYfTOqTGtDX/aws
 EdxA9ahJNHYkg2pwMscMHupZma8Bh/ETsKLkV1gBthzIYqTnrCOVVZRPIcFtG6+l9BP7
 CKVFHhCgfRlm/igLKLFs6qDJrrbvJvCLnWw/puoUYYe5paP2odQIPyJxhYppTHtQP9vB
 T9Tw==
X-Gm-Message-State: AOJu0YxL4/pPlBP4ULhPo45BQ4ivyMS2rB8cQvc/otOMdyWvp4t5ySFA
 UF6HfADzLPZcQrPhUIMYLyIhkwy6KApkcpRrvI6j3Cjgmbm9vWXPfa7WUPuPCTQ21/HsJByLXBm
 cAZ6a/qc=
X-Gm-Gg: ASbGncv3Pw6mNrfPD1CZwXIhdEfi+oKve7AvcqdP5Y6aCtyC6r9zEW+QIXQOjkxDSji
 rfcCQQQHqzuzgGYTCmUWyMP2qzVqI+zLtqQ/h+b4eKYYuRgeXtoS5oqVvJjmbHtqniIeutiWr70
 rlv9dRaZVcrvynXiUF+sR8iX+Hja//3WlShSzXUYLvG+/dylQRF1SOBFkfzWf1/mlnpqJCT4fx+
 PQbMDhWJuHUdOxv2j8Su6TqIl/B0ezDy32X002phWop87Q7MGa5RzY9t0BsFGnONrZADiaZiLhf
 6UwgZGbg+r1I9vLZ0KNS6uaxFPOBpXrOn4oe5Nz98CEl21uvo/iZadQ8RNON3Haa9tlK2lOexyG
 dOQKtSu2gbWzmVdjfj6fqeCo=
X-Google-Smtp-Source: AGHT+IFQBBm+Jc3OUTAb0Ur7fbu9z915uSAKGQQxocE37oBGmhiDjMAH641ujZQ9bmia0EwEkk6h6w==
X-Received: by 2002:a05:6808:1b28:b0:40b:15ac:df1b with SMTP id
 5614622812f47-40b88746cf6mr839396b6e.7.1751418358906; 
 Tue, 01 Jul 2025 18:05:58 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40b322892d7sm2333070b6e.7.2025.07.01.18.05.58
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 18:05:58 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] disk/part_dos.c: Make use of LBAF for printing lbaint_t
Date: Tue,  1 Jul 2025 19:05:57 -0600
Message-ID: <20250702010557.19333-1-trini@konsulko.com>
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

When printing the contents of an lbaint_t variable we need to use LBAF
to print it in order to get the correct format type depending on 32 or
64bit-ness.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 disk/part_dos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/disk/part_dos.c b/disk/part_dos.c
index 5c77225cef93..18dd35c9b98e 100644
--- a/disk/part_dos.c
+++ b/disk/part_dos.c
@@ -421,7 +421,7 @@ int write_mbr_partitions(struct blk_desc *dev,
 
 		/* write EBR */
 		if (blk_dwrite(dev, ext_part_sect, 1, buffer) != 1) {
-			printf("%s: failed writing 'EBR' (1 blks at 0x%lx)\n",
+			printf("%s: failed writing 'EBR' (1 blks at 0x" LBAF ")\n",
 			       __func__, ext_part_sect);
 			return -1;
 		}
-- 
2.43.0

