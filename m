Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB451F34C51
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 13:01:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 277E3839DF;
	Mon, 13 Apr 2026 15:01:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WnWeLCDY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D12568419E; Mon, 13 Apr 2026 15:01:29 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75E5C839D5
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 15:01:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7dbd2a0211bso3198664a34.0
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 06:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776085285; x=1776690085; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8zWHXxI6Zwno0IDaWAd4itCTOKFu/oIP2UFfoAnQSB4=;
 b=WnWeLCDYe7m1L3GDX+r/g93wevHDqRBRZmv7GodQQP8o2clHUZr0TINj3BEGrGOkDX
 rlE8YRlZ1uZgkmBImN3gZIisr1T5B39+JViAc3lj6nfTYqfda3xmhPg5uYyIXoRCujyI
 9Jb0V3Jqk5Lrgmm65VOAYm0O/bn8VgiVavsqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776085285; x=1776690085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8zWHXxI6Zwno0IDaWAd4itCTOKFu/oIP2UFfoAnQSB4=;
 b=HJjWmu5GEBVEp9IFvH64Tb6HZczzYFnBUbOKQVI2uk+dMGIFR/QoEIXTSvqUcenhJO
 Ti4i7OYgW2bun8Yhvaw72rk1B6t+v7xqkfN56kYHUI2j6IJXiYAdRTqDiPw0eLmQyHV+
 01V4PpNKnAqik8FkzXgbVxxQq84C01JWahfTy31KKB3miqgUD7NT5LNJNlA6ZNfBLMWD
 q/ouqauhVteovo27V6i0IHwl0pSR0wPcTxtC7/uvM0ZU3rMra3xpVpAI/do/TtAWofdF
 Q4jFreXesEgnEfZcFyH9Ob9tpK0i+Pnsh9zxhEGEo6xznVgT4heiNMG8U6Laxq8zUZT0
 IEQg==
X-Gm-Message-State: AOJu0YwCPai4lWUvM1pRS2c0r+mX99StONou7NqKskoOevFh3c6A/Mug
 Jq4Edbesk9hc90CjKMlmNlgHqljwEilrgxBLjyuXAN/prnN61vXi38a5OFAaLFz9My/RdiAUFCx
 a/g1tdQ==
X-Gm-Gg: AeBDieuTT9nbMI0aVY40KRZ7U+sA3KzDSkD7J4pdyxLOeAsyACdAxQvhxge2DaT0geK
 UzPei9spweThKo+euJX1jiaP0P13ehF91okS+kHlWmYyPATmqLbmmxgQ+CtP+R30d+X648R1y2T
 7AOlFcHVtZO/QrOobYsm1qAWSrQSUKa4PHZ+HZY5NSB52kJEzvEG8l7DVTteA1DSwHY2puT72kq
 0FeaLafu2CM1sGXWPwwhvdZTTnDlbATwNPUFttIqVBz+DFC1cjzXJgRY0VS2uJHI0nd61DUBI0V
 oyG4LsW/RTbDFovPbJt5pdIzgzllvoRSZcDbVLybXlmLRJC97R4QsCG+LKPo/LWpWtjABG3A74R
 P3Bwg8VhDRdq1wKX27iFiV6dTit1qH4jH3JV7fgO+SX59lJ5dtmDtHmE78YdKcWrO3jR7hgQtTX
 4t/blBMyAIeCRf5M1KdQ==
X-Received: by 2002:a05:6830:34a3:b0:7d7:f13a:762c with SMTP id
 46e09a7af769-7dc27f60e59mr7812167a34.27.1776085285060; 
 Mon, 13 Apr 2026 06:01:25 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc2696532bsm8369144a34.21.2026.04.13.06.01.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 06:01:24 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 1/8] test: fit: Drop the fit_signature buildconfigspec
Date: Mon, 13 Apr 2026 06:59:52 -0600
Message-ID: <20260413130007.1987326-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260413130007.1987326-1-sjg@chromium.org>
References: <20260413130007.1987326-1-sjg@chromium.org>
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

The test_fit test requires buildconfigspec('fit_signature') but does
not exercise signature verification. The ITS template includes a
signature-1 node, but mkimage only needs TOOLS_FIT_SIGNATURE (a host
tool option) to handle it, not CONFIG_FIT_SIGNATURE in the U-Boot
binary.

Since sandbox does not enable CONFIG_FIT_SIGNATURE, the test is silently
skipped on every run. Change the marker to buildconfigspec('fit') which
is all the test actually needs.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Add new patch to fix the buildconfigspec marker

 test/py/tests/test_fit.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/py/tests/test_fit.py b/test/py/tests/test_fit.py
index 619f73153a0..71c98be27cf 100755
--- a/test/py/tests/test_fit.py
+++ b/test/py/tests/test_fit.py
@@ -116,7 +116,7 @@ host save hostfs 0 %(loadables2_addr)x %(loadables2_out)s %(loadables2_size)x
 '''
 
 @pytest.mark.boardspec('sandbox')
-@pytest.mark.buildconfigspec('fit_signature')
+@pytest.mark.buildconfigspec('fit')
 @pytest.mark.requiredtool('dtc')
 def test_fit(ubman):
     def make_fname(leaf):
-- 
2.43.0

