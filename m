Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF60FE64019
	for <u-boot@archiver.kernel.org>; Sun,  5 Apr 2026 11:12:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76FBC83CD3;
	Sun,  5 Apr 2026 13:12:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="i3qpUhxI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFC77840BE; Sun,  5 Apr 2026 13:12:32 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E53784020
 for <u-boot@lists.denx.de>; Sun,  5 Apr 2026 13:12:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-463a0e14abfso1773205b6e.2
 for <u-boot@lists.denx.de>; Sun, 05 Apr 2026 04:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775387548; x=1775992348; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mKKMwJEXNccMVRbjf/M/Cyhj42/TW3hLuqRloykcaGc=;
 b=i3qpUhxIXku7bi8gMw5/PW2LnxlI2ospwO1VjdBQ8U6ZLUet+qVHbgpkmB1cLJpSWo
 hrfNWbfpYO3j+Pdynou8a4mJFTInZzygpLSzJuoRPHPVW+k2XBR84P5Wpn7e+QXxwnmj
 Mz3HapISJwbSwZLjAmH5DMWMR6jkyMyZapXLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775387548; x=1775992348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mKKMwJEXNccMVRbjf/M/Cyhj42/TW3hLuqRloykcaGc=;
 b=KEBW6vX3/ngxfnnXHShKspa2D9CFdIWwxrjXstJZbGYF7LkLZGcrBNwCWig9JgHhUR
 eKbyf3UFyeap8Be/mhuOZdPOn7dXtp8ljGauVYHaYPZB1j8joeF2XX70DBgV7tjUvCQB
 i8KZNQ9aGxQeJ3LEETOMUwxY8rRctUT4fh7hqSeB+/gpUBrBOn0/MOxWsSbOak5we8yX
 8Wc4MdGJuxz4fsnD31nyZANhphbWqPWRKaUadu+cmo5hhAAF8dggrpx7FcLorTPGk8DG
 J7xKoWPUmx7gF4VEFziK6vkj6luXsEDJwD7DGKoYQn6nPanJ1ursX6IHS2sF7cgz62Xo
 9R1A==
X-Gm-Message-State: AOJu0Yx8R+UCplsQr1zRlp/e/qUmv/xAeiD7q4//IQDh5kkQcsf72Dz0
 uRTIMTX3EMr28DQ6DwovBatRq/63jbIqY0OCFzJM1+psr3sWXIUBBPnUl1y++hYeRo50EtgMOSN
 aYDnAmw==
X-Gm-Gg: AeBDieutfFDzrMCOQ9j/23YsN9RPHt4SwA2Rzm02Y1eiVnhRAwMS6Jro9W6kRlHSEji
 52L1nUyckqJHO6EM70flLnanqzA3wg8JSsvLK00R8egDKUCtIDcSIDR9S6A5L3YNFS47lxwrTYA
 9H3Ihj08kIlX9hNaDjrsy6LvJdmlZTlMnyi6EA6ieZ3+8D5cNoGZFYLCvrLDwpz8rjdw/HVRuSl
 Z67g8HhGgRhu4OHkyIjoV2c6b+y79/wArYkJGN6En7c2lvVp2wKkjfqjTV6+t4uEx0tRmtdOicu
 8j4h8G7zIJmrrGsUBmWNE08ryB89D8PGBNWLDdq1IbhtC0OTWw0UwDk4L3Ql06Gb3+25b2EOpvJ
 QA4kETjnzGbewcQfRLRsSLkd6lFxXOQWud5Jsbx2F44l12DWkd9sU5mrSJxsUPYFulzyGj73GZP
 0GCqt+qbPYNDrhN8Za2IH9ujh4cLxR
X-Received: by 2002:a05:6808:5386:b0:467:58e:5d6e with SMTP id
 5614622812f47-46ef7a0faeamr4247646b6e.30.1775387547843; 
 Sun, 05 Apr 2026 04:12:27 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46d8d109b69sm6414382b6e.0.2026.04.05.04.12.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Apr 2026 04:12:26 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 3/8] test: Rename test_fit() to test_fit_base()
Date: Sun,  5 Apr 2026 05:11:48 -0600
Message-ID: <20260405111206.945185-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260405111206.945185-1-sjg@chromium.org>
References: <20260405111206.945185-1-sjg@chromium.org>
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

The current name is uses as a root name by a few other tests, such as
test_fit_ecdsa() which makes it hard to run just this test.

Rename it to test_fit_base()

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/py/tests/test_fit.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/py/tests/test_fit.py b/test/py/tests/test_fit.py
index 4a19bd5cb49..4c7d400bc6a 100755
--- a/test/py/tests/test_fit.py
+++ b/test/py/tests/test_fit.py
@@ -119,7 +119,7 @@ host save hostfs 0 %(loadables2_addr)x %(loadables2_out)s %(loadables2_size)x
 @pytest.mark.boardspec('sandbox')
 @pytest.mark.buildconfigspec('fit')
 @pytest.mark.requiredtool('dtc')
-def test_fit(ubman):
+def test_fit_base(ubman):
     def make_fname(leaf):
         """Make a temporary filename
 
-- 
2.43.0

