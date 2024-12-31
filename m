Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6EA5E77188
	for <u-boot@archiver.kernel.org>; Tue, 31 Dec 2024 23:54:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E262E80379;
	Wed,  1 Jan 2025 00:54:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VdlLdm6G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 298828037B; Wed,  1 Jan 2025 00:54:19 +0100 (CET)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC5A58021A
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 00:54:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6dcc42b5e30so26494686d6.1
 for <u-boot@lists.denx.de>; Tue, 31 Dec 2024 15:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1735689256; x=1736294056; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Poznu1QRW/sd/OHsulznWS58qNLLkTwhNOjt+UXuUII=;
 b=VdlLdm6GkNNGSvj5I0zB5mFZpJgft5K2wb/18FohQY0tZ58drsfh/dZDvy0oXpnA65
 pdpJJ6CYvfH3cGrasu8th8NeskReJnhLqshj7WUI4fsZbibhRJoPVA2oH8wOsd1irHh5
 GSBKQc0STjHKVl0Rm1QL3kkkFZu8xQdINtsLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735689256; x=1736294056;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Poznu1QRW/sd/OHsulznWS58qNLLkTwhNOjt+UXuUII=;
 b=B33sAv2Yj01Q5ystVXXA0L5E9B3UF1VgLZbJagq1xQS2djgQfU1fUObfQtvhZyQiAw
 SM+/eokRLBI74lURxLGVCNFFhSFIE+Xw4XfY1sas5Si/yYupUfg+zFFm6AXo4sFXOwcI
 lQb2c4ueoHVQ3S1co+NNTxu52ISlmrltst3ZmU4pnXIevc0Ehy9CXp+IxyEVePo1QEsW
 c9SignyqZwY91TH3ld4QLLM6rUALtbWqY+i9L+0Kr2sxgom2YgypAKXQoiDXW0k5ZRYR
 7aiVtem7pOGyINicyffdEkBECMYItnxmlI2JfS67Ii73oRenjVyJUQzBijancEbmaUFd
 ZSCA==
X-Gm-Message-State: AOJu0YxNFo4WF8jPAXErfY1vlAsj7JhcE13mEz25UnzDikJNuK0oGfE2
 thTRmziYmk6HhWAPYkhgH8rGR6jap855xDcEnpb/WcisH4BJNquicVAXDaDe1C4ufKPxvD/Z+MO
 1Se8=
X-Gm-Gg: ASbGncs6whxZp37hgVziPN9gPe7+fvdS0hTQF8YWPAzzqEHLIp21CQFS/euILk2mfnQ
 4CW1ypen+OZttSA/kdfI07OFRkAUvkZ12rpWfrh4QD/l/XiG9mDoTq0sEjsDQg2ZcJVpdmeqNTQ
 gTTlrgMzLeN10wOkFmCcQB7+fXSBxyoXGT1R7rw5HZo+9w835hBEgXlTcPAmuDAzsA6steHsPNm
 d4ettxBAv0P1AdRUijcKEOYK4/KVq1YM14jKdd6lPyMkCNdZKqogWqYJAKresydCU5oPJ9uL3vF
 BQ1P
X-Google-Smtp-Source: AGHT+IGyGxRJTl359cyvGfYAJTtZPihm+ZpVwVU28QVTkhHWSykX8FUfR7ms+IRrgZiXy719sByKzw==
X-Received: by 2002:ad4:5fc9:0:b0:6d8:a148:9ac1 with SMTP id
 6a1803df08f44-6dd233aa32fmr664505426d6.47.1735689255648; 
 Tue, 31 Dec 2024 15:54:15 -0800 (PST)
Received: from bill-the-cat.tail58a08.ts.net ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd181bfe54sm115792866d6.88.2024.12.31.15.54.14
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Dec 2024 15:54:15 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] qconfig.py: Update resync message
Date: Tue, 31 Dec 2024 17:54:12 -0600
Message-ID: <20241231235412.1605761-1-trini@konsulko.com>
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

When using qconfig.py to resync defconfig files and commit the result,
update it to say:
Resync all defconfig files using qconfig.py

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 tools/qconfig.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/qconfig.py b/tools/qconfig.py
index 058d72cf4bcc..259adbe1bc9e 100755
--- a/tools/qconfig.py
+++ b/tools/qconfig.py
@@ -1617,7 +1617,7 @@ def add_commit(configs):
                 '\n   '.join(configs))
     else:
         msg = 'configs: Resync with savedefconfig'
-        msg += '\n\nRsync all defconfig files using moveconfig.py'
+        msg += '\n\nResync all defconfig files using qconfig.py'
     subprocess.call(['git', 'commit', '-s', '-m', msg])
 
 
-- 
2.43.0

