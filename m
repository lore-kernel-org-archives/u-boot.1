Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8C34C3DA59
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 23:33:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30D0488719;
	Tue, 23 Jul 2024 01:30:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="crgoTtNa";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Jl1vBRLd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9403886F0; Tue, 23 Jul 2024 01:30:13 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95B5C885CE
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 01:30:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4WSc2G2yvfz9sjp;
 Tue, 23 Jul 2024 01:29:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721690998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XZWHWAk75ZuNXa8MRhIphLk7Cr4l3g9RiOyJD1Rv5ug=;
 b=crgoTtNaVOB9UDnconsfZIZ24wy/Z7I5I0g5suHao49Kpah8L3YCwpDvC/REC56MLnQf4o
 ifLwFZyBJ6vGBPB3DNe2ZZc43yhaPONoOnBwSEgvvCppTXnNHemGm9JT2PhQ8YtLCfvmZW
 7OWrBpKUAaXPREvSTM1Ie5zoe5uhlPAHX9Gp2Z9rn85URAFhvXVKSUbsBdOPogWibzr0BJ
 AJm0pmtPR2BORGtkbpopNTv4ovhCJ7S7YFO/hWV8EgWmoqu+b4Y5dBUJuXY7IMwPQXVoby
 6/CoWEF3KuZNBv6GhujqaoMqAGS89YNOKl6Mi5Zvk/lfobQ4snH5Mx+hVMyj8Q==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721690996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XZWHWAk75ZuNXa8MRhIphLk7Cr4l3g9RiOyJD1Rv5ug=;
 b=Jl1vBRLdL+xlIGUfUOI7R7KNNoxe9lDTNLZwSQRb9aIXigkX9PoQOravFG9NYYupFstAZC
 PEHaAjeeuSO0eYEIt5dGfG1lP/qHBNvM+yR6WMmBZmjKdddL+PmYU+2Ml0YmsnigewAABH
 BNQtiXD1nGSn5AFsXsT2gS4E/g+/BsUpVOfQYwa5z0BbLV18iDhv491M6/qectT/8PTo3x
 nKYPY9hHbHDdyWXG+CvZlZiPu8S5Vn5quRkd7YBbvw4TH965QpfVNPvLbcdcAYCBrKwl8/
 augk+42ozU22xITkBxGWdVkmhLhd8A2rAdUCv60w9IFwRgL88Gk+x5+p0Wgpxg==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 11/15] include: u-boot: Remove duplicate newlines
Date: Tue, 23 Jul 2024 01:28:30 +0200
Message-ID: <20240722232910.91249-11-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240722232910.91249-1-marek.vasut+renesas@mailbox.org>
References: <20240722232910.91249-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: f887a5d1d8bed83d39f
X-MBO-RS-META: zus5eywf9xj6btfcjhzbs4q78ziczwdf
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 include/u-boot/sha512.h | 1 -
 include/u-boot/zlib.h   | 2 --
 2 files changed, 3 deletions(-)

diff --git a/include/u-boot/sha512.h b/include/u-boot/sha512.h
index 90bd96a3f8c..83c2119cd26 100644
--- a/include/u-boot/sha512.h
+++ b/include/u-boot/sha512.h
@@ -36,5 +36,4 @@ void sha384_finish(sha512_context * ctx, uint8_t digest[SHA384_SUM_LEN]);
 void sha384_csum_wd(const unsigned char *input, unsigned int ilen,
 		unsigned char *output, unsigned int chunk_sz);
 
-
 #endif /* _SHA512_H */
diff --git a/include/u-boot/zlib.h b/include/u-boot/zlib.h
index ee19f460958..dac565497cf 100644
--- a/include/u-boot/zlib.h
+++ b/include/u-boot/zlib.h
@@ -36,7 +36,6 @@
   Jean-loup Gailly        Mark Adler
   jloup@gzip.org          madler@alumni.caltech.edu
 
-
   The data format used by the zlib library is described by RFCs (Request for
   Comments) 1950 to 1952 in the files http://www.ietf.org/rfc/rfc1950.txt
   (zlib format), rfc1951.txt (deflate format) and rfc1952.txt (gzip format).
@@ -547,7 +546,6 @@ ZEXTERN uLong ZEXPORT deflateBound OF((z_streamp strm,
 ZEXTERN int ZEXPORT deflateCopy OF((z_streamp dest,
 			z_streamp source));
 
-
 ZEXTERN int ZEXPORT inflateInit_ OF((z_streamp strm,
 			int stream_size));
 ZEXTERN int ZEXPORT inflate OF((z_streamp strm, int flush));
-- 
2.43.0

