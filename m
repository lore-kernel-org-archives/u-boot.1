Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9802ECA101E
	for <u-boot@archiver.kernel.org>; Sun,  1 Sep 2024 22:30:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D57488C8A;
	Mon,  2 Sep 2024 00:27:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ivm9G+cE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7E6488C61; Mon,  2 Sep 2024 00:27:14 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9948588C6F
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 00:27:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-82a24deca03so111729739f.0
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 15:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725229631; x=1725834431; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mpM6D4iVoUaEr5VP2FSxVUylRw0M0VmVl2Pwd1cTeHc=;
 b=ivm9G+cEZhx2JNeA43OGoU91olX87yLZg8BjxBJS8ZjydUYY1e53ycVb5CmatdMCWI
 T0xoVSXSpGgR6K1IMbt1cLZGcG9fq3nAZsblf2ckb/3uYIYpn2kk2gjij3SAI5Kcp3Vt
 lju6S2tn79v79zGYhgRv9Fvkz9FF618856wt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725229631; x=1725834431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mpM6D4iVoUaEr5VP2FSxVUylRw0M0VmVl2Pwd1cTeHc=;
 b=rYPSHCLXteXD9NS4/fF1b/EWhbAG6b54SU/Ltf/z2kKDDtOaYokRwMw8U5WKsNYcyo
 YpWjq0+Uyxy+9F+cqxRgnIj9kjC2bY8nT4V/djoztM6hTsxHzNK1tLimCXDUfZrg5bv+
 lwHszceKDJ5V7zv5/1KiCRvGkqIaaHXhooi2rC+OHz0bgL5iCHcNi4pF9PbPveXy4lCT
 Af4L5glvpgA9ImciyKoql6yAIgpqUA1mJmy3hF5QbMWyBBBWwouAGc/hfRBRUuxoL4Bk
 u+qmb6mTFvx/v/X4uyqv24RZuapYcqqUDMxMv2ZuLbrIs9O/rExLYNJGOjjiscUxRegV
 pp4Q==
X-Gm-Message-State: AOJu0YwomXLl2lf+o4XlB7hHuk8hTBwfluWIF/uj/w9uQgsJgw6dsBwI
 X8ji3Ak3hdh2uKOumqv+/SUrpjIpIUGA+eCJrKWgHH0YYAeW+ow0vNPgdd/ucy6wSZRzTrjAMBM
 =
X-Google-Smtp-Source: AGHT+IGplySHj8Ohmaci4MmqasNA1hJwhu8InTdLhp9gHDpvtS1bOi5QT08bmmPWEoTiedycfUsaCA==
X-Received: by 2002:a05:6602:2dcb:b0:829:ebd7:4a1 with SMTP id
 ca18e2360f4ac-82a375531cbmr713214839f.12.1725229631129; 
 Sun, 01 Sep 2024 15:27:11 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-82a1a4c099asm215751839f.48.2024.09.01.15.27.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Sep 2024 15:27:10 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 20/23] test: mbr: Unmap the buffers after use
Date: Sun,  1 Sep 2024 16:26:31 -0600
Message-Id: <20240901222634.460873-21-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240901222634.460873-1-sjg@chromium.org>
References: <20240901222634.460873-1-sjg@chromium.org>
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

This tests maps some local variables into sandbox's address space. Make
sure to unmap them afterwards.

Note that the normal approach with sandbox is to use a fixed memory
address in the RAM, to avoid needing to create a map for transient local
variables.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: 04291ee0aba ("cmd: mbr: Allow 4 MBR partitions without need...")
---

(no changes since v3)

Changes in v3:
- Add a Fixes tag

 test/cmd/mbr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/test/cmd/mbr.c b/test/cmd/mbr.c
index c38199740a3..e750875ea43 100644
--- a/test/cmd/mbr.c
+++ b/test/cmd/mbr.c
@@ -456,6 +456,9 @@ static int mbr_test_run(struct unit_test_state *uts)
 			"5P EBR+0x%04X: expected %#02X, actual: %#02X\n",
 			ebr_cmp_start + i, ebr_parts_ref_p5[i], rbuf[ebr_cmp_start + i]);
 	}
+	unmap_sysmem(mbr_wbuf);
+	unmap_sysmem(ebr_wbuf);
+	unmap_sysmem(rbuf);
 
 	return 0;
 }
-- 
2.34.1

