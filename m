Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71E52CAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 20:33:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D94D83775;
	Wed,  1 Oct 2025 22:31:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bv22l8R3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4989E836EE; Wed,  1 Oct 2025 22:31:06 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 127C283753
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 22:31:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-74526ca79beso199044a34.0
 for <u-boot@lists.denx.de>; Wed, 01 Oct 2025 13:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759350663; x=1759955463; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=/d4D3vfyDUjRzZQhdSVSyf8y4Gaih7Gzg+kN3pqo9g4=;
 b=bv22l8R3AjzzkagVXBd+28un8xAjTP1gedlaTTwsKs1SWdhdE7JXqa+dryYfKqRiF4
 3X59Y6oVP5ewIrA4Kf9xxNoDfB4ti7lu/r1l6q2OWfnTfmq6JHlf4NXD46f8oZtopQVH
 AOSZpu/Y24dFMOZUfOxKu7UNkpfNKxdpmju/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759350663; x=1759955463;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/d4D3vfyDUjRzZQhdSVSyf8y4Gaih7Gzg+kN3pqo9g4=;
 b=bdDS2swMngNL0x88qoB9SsjziSy0Iik68XN/udZD7Ht0VZyWYR93Y1OHbqytSUxuRH
 0n9BrCGmcuIW15GMapHfTnKfjZzNPNhxSF25X49iXa76alwov3ObffSuT47itSKD3mXE
 pCy5jUdU0BEcQFt1iO6SAfmmziOLeXwrkCV7BQnbiFn8h/9IKbPYFddeKxYyym6vFsri
 dnwAZWipdYeAv0rw8IzojNYBS1CgN4OcwlKMMBOak/6nNMel3/srEqEXIBJ+nzZYTMxH
 s96iociHWpwYzFuMymjE0D+vQQAwDsfKByaNNP0AwmADkJ5ihilXdYBQ4SZ+S0F67anf
 hpzA==
X-Gm-Message-State: AOJu0YyIYENLCjjKU7ka6RR3f1m0Eayk+2vbvu6oJzZ5nk8+SWEoizwc
 5GeLYv27o2PMV6uknRQQLT1WlCt6J7q4kfYZCkzyq0XOFntnX3SeP9Jix+vYlwA79HN0xWHrd2E
 H+iAfaA4=
X-Gm-Gg: ASbGnculUzXHKFO2iVxbKypfg+RV05ZU0G98mOUU8Axhpd5noj6tgHtPaHgbv2m1QtQ
 +HjlMj4rvego8Se4JKO/sdtUF9vlC0k9OJYmBn8De9KIFJwkmTaGXcotj1Uzed0Xeaem+pSigaj
 SjxPFryELp0dlncF+hfLQMVrn9afwYkukz7GOxrE/yunNfqb/Km68wWz5itAaP4kB2h9PVQ0n6e
 uev1+dEqrUBA3rCon1Ysbva+JnD7l9X3G4mwp++EKAHtb9pZFLZvGpbA9HbsI6I2PjIDUWQyKjK
 QrDn8VPjg7iHoMGB3n9O1LT3c+QaqBkF+FljJTXey7jClJbvq/1WPJ751sDlwydiqvITCVRZcNL
 2FJsVuOqPhWrBErBgOuMI1xqNRqt+fIib8jVTxOUQu0av46p6IAz5MpF0i8Nv564Q0ByicCgeo3
 xwGDBC3P4=
X-Google-Smtp-Source: AGHT+IEcyDfA6VjdpbkXwzohgc2wmA8gJftSukX7O8XBFpxxqHML3BFAxnAfUlpSeJH9bs9r+XY/kg==
X-Received: by 2002:a05:6830:3591:b0:757:aee6:4a59 with SMTP id
 46e09a7af769-7bdf86a93a0mr3378908a34.18.1759350662783; 
 Wed, 01 Oct 2025 13:31:02 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7bf3f6102f2sm124370a34.6.2025.10.01.13.31.01
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 13:31:02 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] lz4: Do not disable LZ4_decompress_safe* for xPL
Date: Wed,  1 Oct 2025 14:31:01 -0600
Message-ID: <20251001203101.2828577-1-trini@konsulko.com>
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

We should compile the LZ4_decompress_safe and
LZ4_decompress_safe_partial functions in SPL and they will be discarded
if unused.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 lib/lz4.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/lz4.c b/lib/lz4.c
index c718659c590a..11b4a4d334be 100644
--- a/lib/lz4.c
+++ b/lib/lz4.c
@@ -526,7 +526,6 @@ _output_error:
 	return (int) (-(((const char *)ip) - src)) - 1;
 }
 
-#ifndef CONFIG_SPL_BUILD
 __rcode int LZ4_decompress_safe(const char *source, char *dest,
 				int compressedSize, int maxDecompressedSize)
 {
@@ -545,4 +544,3 @@ __rcode int LZ4_decompress_safe_partial(const char *src, char *dst,
 				      endOnInputSize, partial_decode,
 				      noDict, (BYTE *)dst, NULL, 0);
 }
-#endif
-- 
2.43.0

