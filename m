Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB02ACD5BC9
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 13:29:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C6D4846D3;
	Mon, 25 May 2026 15:29:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=e-labworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=e-labworks-com.20251104.gappssmtp.com header.i=@e-labworks-com.20251104.gappssmtp.com header.b="BX+/cull";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2D7D8460E; Mon, 25 May 2026 15:29:11 +0200 (CEST)
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com
 [IPv6:2607:f8b0:4864:20::a2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2FD8846D3
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 15:29:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=e-labworks.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=sergio.prado@e-labworks.com
Received: by mail-vk1-xa2e.google.com with SMTP id
 71dfb90a1353d-575171b1ce7so3143544e0c.1
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 06:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=e-labworks-com.20251104.gappssmtp.com; s=20251104; t=1779715748; x=1780320548;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dC3JajDCY67+AQk7t+J09ayrr4voDrAlEKwFRDCRU9M=;
 b=BX+/cullYqsWmBnYXrCA0ITClOQ1CjMvhlA94Ns7qfWRfORkzqZRumwK5viznPZWEW
 4gi4gO/d9HV4i9avEZ5XqE8JabRRr60VKNNbnntduX4I33KdewqL+shIjDROfFyDhohl
 ckbmEMDSQJwc2yHw6IhAe+evwGEdA3eTFdyE5qQnuG7GlMm0qAwXviwbwomZLQPGIzZG
 hl2l/U6TTLWeKu5dEI/5gKxv+vMxon7tfTiA4BaznqEoFQb7zDHbllwtBqKhKo6tBKh/
 b6IQpGEtQIgmfqpEgpYapOmKJ5pH+k1NdLpfE5QMeQMuFwvkPvRrE18XKCPLF3drqjnn
 wzeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779715748; x=1780320548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dC3JajDCY67+AQk7t+J09ayrr4voDrAlEKwFRDCRU9M=;
 b=ZEvRwoi6GSGL+MfCPSf7mLfg3sqSAwgHJrTMsgX3eKlXoNHQQBEMilv/0uICqqbwqL
 fKpj2u57ERpX0vhat4NMAH61n4W0eKJw5lzRWAHaxJMTU8xQdwc8CRue7Zvq4nwS0Eex
 U+X5spXlf5NLFYa+dNOMovTAHEZYYwznOe1+okDQjKxXC6cVisZ4qdK2M3edI8029iqa
 XZ6yRNewcJBoL3WgHvkVKbSs+Owwav+hpphXaQyDSn42J4nYfUl1BQp6x9cLzPihkANh
 Xg8C2eb8/4cs42odvCmU4FH5ktPh4wn4yqTEuZih3J+Ll1Cv1XGIvnIdNCrAHwg6G3HM
 5tdQ==
X-Gm-Message-State: AOJu0Yx4QCzC8CIR+Ct10ptO8NFGCV+mCnw1CFVgNt9PDcCV5T1kRqkI
 +jGwpeoTHxHGbLLFxi0LRbpAaukAorvusUyXIZ81CtmKZyUXHl1FY+n14hApCq1Isrv45vl1ATu
 Xo1Et
X-Gm-Gg: Acq92OFWzi6Yt4nYlTTa58R/lBDnSxbQyDar/njgK/t0oAp9152IPSMTSv+tIwTfUns
 a7OYNGp9/yQF+7UVKhCgiPcqudl8XQkX6g0JAp+ApEZnHuvw5omktJ5XM0Q5zV+8muUWKx0MNAn
 RhWF2hXa7LTE4qjLcCM2PZxnnqk0oBVlB1ac69paIYy5ibI3rRc77tTF2eMdOlU/gIY3QWbsL/K
 HdpubkpRht12KvELumJbuWj8neS9vZsbZ7hugsnwxC76hGWHv0bavKhgsoFZ5GgKsQ+mQAnIMk+
 TLNxi4SI0Ad1b7AnpQSGxjQRr6cQfGohih0qRKRD0BMyInc9kOnsL9V9Tfcu99tfgydBVDe8fLh
 Xaigrue/knzot39IUqlwjJV+gGyqIHIw6morwTpx0bPYQbHidEB0g10ETtlJof/s8THaCsk9vM7
 wxpBL5DlJBhd1L5R1Qg3Slc9wSusSa3bs=
X-Received: by 2002:a05:6122:6b93:10b0:576:c4b:460a with SMTP id
 71dfb90a1353d-586606bef52mr4499174e0c.8.1779715748603; 
 Mon, 25 May 2026 06:29:08 -0700 (PDT)
Received: from desktop.. ([2804:7f0:6400:4198:c5e1:5c3b:8861:210f])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-586f791f097sm11647484e0c.9.2026.05.25.06.29.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 06:29:07 -0700 (PDT)
From: Sergio Prado <sergio.prado@e-labworks.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, alpernebiyasak@gmail.com,
 ilias.apalodimas@linaro.org, marek.vasut+renesas@mailbox.org,
 sughosh.ganu@arm.com, wolfgang.wallner@at.abb.com, bb@ti.com,
 xypron.glpk@gmx.de, y.moog@phytec.de, afd@ti.com, quentin.schulz@cherry.de,
 Wojciech.Dubowik@mt.com, Sergio Prado <sergio.prado@e-labworks.com>
Subject: [PATCH v5 1/2] binman: x509_cert: document Entry_x509_cert properties
Date: Mon, 25 May 2026 10:28:27 -0300
Message-Id: <20260525132828.3348679-2-sergio.prado@e-labworks.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260525132828.3348679-1-sergio.prado@e-labworks.com>
References: <20260525132828.3348679-1-sergio.prado@e-labworks.com>
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

The Entry_x509_cert class only listed 'content' in its
'Properties / Entry arguments' section, even though 'keyfile',
'cert-ca', 'cert-revision-int' and 'sw-rev' are also read from the
entry node and passed through to openssl.

Expand the docstring so the binman documentation generated from it
matches the actual behavior of the entry.

No functional change.

Signed-off-by: Sergio Prado <sergio.prado@e-labworks.com>
---
 tools/binman/etype/x509_cert.py | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/binman/etype/x509_cert.py b/tools/binman/etype/x509_cert.py
index b6e8b0b4fb09..efa85f9553e7 100644
--- a/tools/binman/etype/x509_cert.py
+++ b/tools/binman/etype/x509_cert.py
@@ -18,7 +18,15 @@ class Entry_x509_cert(Entry_collection):
     """An entry which contains an X509 certificate
 
     Properties / Entry arguments:
-        - content: List of phandles to entries to sign
+        - content: List of phandles to entries to sign.
+        - keyfile: Filename of the PEM key file used to sign the binary.
+        - cert-ca: Common Name (CN) embedded in the certificate. Used when
+            generating a generic x509 certificate.
+        - cert-revision-int: Integer certificate revision number. Used when
+            generating a generic x509 certificate. Defaults to 0.
+        - sw-rev: Software revision number embedded in the certificate by
+            the sysfw/rom variants used by the TI K3 secure boot subclasses.
+            Defaults to 1.
 
     Output files:
         - input.<unique_name> - input file passed to openssl
-- 
2.34.1

