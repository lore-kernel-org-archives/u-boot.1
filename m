Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F85C55174
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 14:47:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0DA754058B;
	Wed,  5 Aug 2026 14:47:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3ZLvJT5mR0GC; Wed,  5 Aug 2026 14:47:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5D59240577
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785941270;
	bh=zcnb9Rw2rouoBKIrWP312Ikg745qzGKQh5wSB+PxXgQ=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=puEMbKkd8zsXRp7JvopbpdaJH2vp8xDAl9UmWiN8Mg7ZKKaD9DjpbX4doxD9N2j9G
	 oNTP/8bzfAog+aArD6m2T4GsSWPF61PtHFc0ZJRFTOPavrhDvWhB140uW2ct1tMWBe
	 B/cZpfDvBuYYW3vVxfCxNYFrdqcSXLDsEsXcns63vI0MXb8BPklo4eJbs/owhGN5M2
	 6hOghWuAluUNttvCy15G5LM0yJHebgDbr4IGPjO/3/29SFJhk3pAmTo4P8krh03agX
	 H5qP6CHtg6zgtTMCDjw4O2qC+nZqOEBetEgaNsFEms7cfgOT5VR0MWXZtZBiIDJvnB
	 Ju/NX60z5ai1w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5D59240577;
	Wed,  5 Aug 2026 14:47:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6B01F144
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 14:47:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 496CE400AE
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 14:47:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jPC4O9cwVKHY for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 14:47:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 453B640061
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 453B640061
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 453B640061
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 14:47:47 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4957eefd361so8125435e9.1
 for <u-boot@lists.u-boot-project.org>; Wed, 05 Aug 2026 07:47:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785941266; x=1786546066;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=zcnb9Rw2rouoBKIrWP312Ikg745qzGKQh5wSB+PxXgQ=;
 b=h+G7j0ellH6MMNLtVctXUYkk4/zQ4gAnCsyi+BKR0RND0XiFa2tRK1Qu3NomsQ+v4x
 oLF9iDIRJLHNMyzq7n2P+rsxzHoksuweM8b7FEOyi5KILvpbNZ/QCLRJDMoS6xeZgwis
 sTS23qejwkYumsuktei9ChcONe1FDCmxlGR3fGAcvJ9dojBf5Z1EqxdZMg/wogL136+N
 REnoaxWDNKucyItx4CnlqK9RRuOLn3p4+CwYqINdQYQ+Y3mpo4OaKm6LbPu+7PsRVx7e
 ifCgBKWWCT976EPSCwfA+cfx6XKRFDGI/wksQAjamIOl2ilvFlaoKgzZfrczuUc51jcc
 zYew==
X-Gm-Message-State: AOJu0Yz3jfqbw0DOzswG3viWvgBbljJAOf9IVwZBZAHXjwf1H1e5dBw0
 hwY+Kl4mmQJX0ARXpp5DR8kS2UiU0u1Dzd0rd7nreyhPlPGUy0/bx24aZfdp66TOa2s=
X-Gm-Gg: AR+sD10TVtzVExg9NIBAQlmthEe020KxrGQjTrz2iUSRvqwjpCC7Mifuw4dMtE/jxHT
 n4K20h30slttEiXguR/DfXMAtME4GHY6446oQYdhFEbbgQRCDtekZGcsthHadI3LJgVH2fRtbTL
 nbRQSBEBZiHfcZ7APrpS4iGElXYiegwYw/rGwo7J+OYCm+FS29bm+OMU9hkgh8wnWavmE/6ZVnN
 1khl2/Zbf+HZpUawQTmjhESfIjAqdS/sipY7JgYDJTPRoL1dyPynV5D11iNbuqE7icovURitdRV
 XMNYemaWm4el0fZfc7IoN5Ji3L1BX/AFqQafmN/Z3F4FbixEijPFS+4txBQRGIWNONJigt0ktg0
 OuBJUL9el4O4acLQj3g4SEqMN38P8gQB4Dp0jEbYSrRRcZxRGxdaZQBa81xIY6GV48LXGTr9n3k
 RAHerzwL0jLWf/pdaV19xeTJlYInc7RqULevDlxAC3brh84cZ0m2G+O68RfU1tCM57a8iXvdPmG
 Ni3CQK8tmWL190ahdTfZ4/pOj6acbhB9Y08oAgVbg==
X-Received: by 2002:a05:600c:1550:b0:495:5fdf:2075 with SMTP id
 5b1f17b1804b1-4994e6c5521mr86391245e9.0.1785941265876; 
 Wed, 05 Aug 2026 07:47:45 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-92-99-174-41.alshamil.net.ae.
 [92.99.174.41]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4994a0f7b73sm219383405e9.9.2026.08.05.07.47.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 07:47:45 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 05 Aug 2026 18:47:38 +0400
Subject: [PATCH] pylibfdt: Grow the FdtSw buffer geometrically
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-pylibfdt-geo-growth-v1-1-dabe082367e5@flipper.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQqEMAxA4atI1gaiYileRVz4E2tErLRVZxDvb
 p1Zfov3LvDshD1UyQWOD/Fi14gsTaCf2tUwyhANOeWKNJW4fRfpxiGgYYvG2TNMSEVb6EyXpJW
 CWG6OR/n8rnXzt9+7mfvwruC+H+pPgB13AAAA
X-Change-ID: 20260805-pylibfdt-geo-growth-03a381850866
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2569; i=alchark@flipper.net;
 h=from:subject:message-id; bh=1F6YpNN1sCombnNKDyL5LcYhCYI7r/EZ7jBhM0MjD8Q=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWQV+wpETD/VMv/hnhknmGVW7F0XevGvyvaCEw/cV+8t+
 /OTO12RvWMiC4MYF4OlmCLL3G9LbKca8c3a5eHxFWYOKxPIEGmRBgYgYGHgy03MKzXSMdIz1TbU
 MzTSMdYxYuDiFICp7vBlZPh8iL9mzVpvjtuuR1cul1HqT10QcE7rv/ONgP6TzoFqItKMDI1POAU
 4WvtDPmn+0Lxyq6z617tovn7n+4q/ju7S0fnIywoA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1785941266; x=1786546066;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zcnb9Rw2rouoBKIrWP312Ikg745qzGKQh5wSB+PxXgQ=;
 b=sr8xWcdeelZRS66VLpMrPxKv2cD6CGXiv0Ph7tC36vdjTe08sdMTKYIx7qzZXbm1ji
 hrxzOQ+daJY6WTGv6ZGZMwMKerflsciPihpvowa/7Zm1GNgJ1cYg5XB6jkENCU/AYibp
 HO7v0VSKSqgjE+js5yR3o0Soa7i2EnJfmB8/DxZcPSPu0+l+nNTO94yDG19tmCO4EkA9
 9y8DmiI96fIT2auv3Uqr1qRlZ3WnrEJpMnxqOpjPuMPGUqSJyM705KKL8jVST6OpH4/6
 PdEmnUy40TAY/VCABINA1OLf/mkblOIJQPJEjoWvJ8OokH6hHNHj8mze2yHQad4FTk18
 kAVQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=sr8xWcde
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Every expansion copies the whole tree into a freshly allocated buffer, so
growing by a fixed amount makes building a tree cost time quadratic in
its size. This is especially painful when assembling larger FIT images with
binman, as it assembles the image with the data inline.

Grow by at least as much as the tree already holds, which is what variable
sized arrays usually do specifically to avoid such excessive copying.

With this change, building a Rockchip TF-A+Falcon image whose FIT carries
a 31 MiB kernel takes 33.1 s rather than 44.4 s, with binman itself down
from 25.3 s to 14.0 s, as 7139 reallocations become 187. The images
produced are byte-identical and the binman and dtoc test results are
unaffected.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 scripts/dtc/pylibfdt/libfdt.i_shipped | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/scripts/dtc/pylibfdt/libfdt.i_shipped b/scripts/dtc/pylibfdt/libfdt.i_shipped
index e4659489a96a..05c1bba78001 100644
--- a/scripts/dtc/pylibfdt/libfdt.i_shipped
+++ b/scripts/dtc/pylibfdt/libfdt.i_shipped
@@ -756,7 +756,7 @@ class FdtSw(FdtRo):
     device tree. This will be increased automatically as needed as new items
     are added to the tree.
     """
-    INC_SIZE = 1024  # Expand size by this much when out of space
+    INC_SIZE = 1024  # Expand size by at least this much when out of space
 
     def __init__(self, size_hint=None):
         """Create a new FdtSw object
@@ -801,6 +801,10 @@ class FdtSw(FdtRo):
         -NOSPACE then the FDT will be expanded to have more space, and True will
         be returned, indicating that the operation needs to be tried again.
 
+        Each expansion copies the whole tree into a new buffer, so the size is
+        at least doubled rather than grown by a fixed amount, to keep the total
+        amount of copying proportional to the size of the tree.
+
         Args:
             val: Return value from the operation that was attempted
 
@@ -808,7 +812,7 @@ class FdtSw(FdtRo):
             True if the operation must be retried, else False
         """
         if check_err(val, QUIET_NOSPACE) < 0:
-            self.resize(len(self._fdt) + self.INC_SIZE)
+            self.resize(len(self._fdt) + max(len(self._fdt), self.INC_SIZE))
             return True
         return False
 

---
base-commit: baa64b2f892890f00a377eac4a3e685472bb56b5
change-id: 20260805-pylibfdt-geo-growth-03a381850866

Best regards,
--  
Alexey Charkov <alchark@flipper.net>

