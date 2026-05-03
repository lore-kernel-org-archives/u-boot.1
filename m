Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31A24FF886F
	for <u-boot@archiver.kernel.org>; Sun,  3 May 2026 20:50:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A166584662;
	Sun,  3 May 2026 22:50:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aGZnQ3xf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AB088464D; Sun,  3 May 2026 22:50:29 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D29F84660
 for <u-boot@lists.denx.de>; Sun,  3 May 2026 22:50:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-6948ff6b006so1745153eaf.2
 for <u-boot@lists.denx.de>; Sun, 03 May 2026 13:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777841426; x=1778446226; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tJj2F6JGMvoSjYyhBNZSUOjZo+JCbk3ECrqciJaznA0=;
 b=aGZnQ3xf62EWWQ+nP/iLIz84jGvi1hpr2vmtbgEyw1enAFBOuolL9GntByiH7d2CdS
 INRfEwXYqa4W1yZzjhdqlizYgp1fbuZamdAppNHvCoN+KPtHD/9gmDYB9tQQJm8R8wo9
 XQWlMWpV2qlgeZdnLhZZXNIeKw8MwSy6w8KDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777841426; x=1778446226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tJj2F6JGMvoSjYyhBNZSUOjZo+JCbk3ECrqciJaznA0=;
 b=NgPav//gvGHb9neqFvuojDpV75K+ppg1Tmp40lRrkuMEqL4yO3cAbms1YWJ6l7Sx+5
 eUr5kQ4DoSqm3Q4s1m2dG6VAprXC26JhAPkR9YUWZvlzOufXDmUiw3Sr+0hDiX7NlLzu
 YHvWr49EiafeS0DrB/opGzFcSvnpeNnnZy1Q8kQgZo3dy7WN8fnKcJei12yMGypzonqE
 wL5HKZf/l/M8VDnbDIUt25XAbvT7v7WpwqJCf3VM0MVe0bhaarukbvQJef+g/0NjlEmr
 5pfqnboQLzjHhM30PJTvzZTU/BWVoA45PmDTe5yUSfXSxCM9Ikly99vwPEl+qWgGW5xr
 AZbQ==
X-Gm-Message-State: AOJu0YyB8teclYF7yaUXvHq+/nXFvhHq1z8hDEtSwExTmvPDFOiF8gw9
 RMIcKQXVvdBWCXXOvPd5gElOvhtwiyFUA1ePKBV8H3Lo3fxtESG7DF2G4WFPQGWzK/c8ntED/2a
 p3bx3Og==
X-Gm-Gg: AeBDievF/kjX8SXodyjcI0yAdpFv5B37ixEEmdP7yU5BSX5M9V89Uww2Y+ZqUxPeOi9
 2IGFNe9fa/2qTbjgqNTumbqAx6kG3KehqL62GbLeFHmhCf5+8q1WchJYEh88Ip3c2dqMHGivTXO
 3pFxCdvV41yqyo2qHckOM/UVa0iRDSNksRfdKFVoSSYYmiGJrpsq8vTKHuoEyqruqaREFsrEyUb
 8fb/Wf9zs/aeuGdJ/8cltBe8HaRZ7qceT0TxoruyMQMpkVq05ObDAHP2OtzrkBNjpphwZzW3BMy
 nYrgh0DCMAURk5hF1YpMwVm8/wAXVn7RedFWe79Tzgdh5tcK1NUAtAopoJ7bOnr/htveeR5R63b
 Exrc99ULhvH8a5Ru3EZ8n0pvZXlA9yCXEKJVYw4zpAXcxPgQAIpJQ/W7vQVVh5rrP0DmaSIeA90
 1jLsTNAXZWOog6w8/WQcWQwtK6nkDSG9N5P6kcFlM=
X-Received: by 2002:a05:6820:1887:b0:696:926d:ce3a with SMTP id
 006d021491bc7-696979f4744mr3762977eaf.26.1777841425724; 
 Sun, 03 May 2026 13:50:25 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-696aacbb5bbsm1142940eaf.15.2026.05.03.13.50.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 May 2026 13:50:24 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heiko Schocher <hs@nabladev.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 6/6] aristainetos2: Quote rescue_reason in rescueboot test
Date: Sun,  3 May 2026 14:49:24 -0600
Message-ID: <20260503204936.3151124-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260503204936.3151124-1-sjg@chromium.org>
References: <20260503204936.3151124-1-sjg@chromium.org>
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

The rescueboot script optionally runs a per-board rescue_reason hook
with:

    if test -n ${rescue_reason}; then run rescue_reason; fi;

The default state is "no rescue reason script", i.e. rescue_reason
unset.  The expression then expands to 'test -n' with no operand and
relies on a U-Boot 'test' quirk that treats a missing operand as
false to skip the run.

Quote the variable so an unset rescue_reason expands to 'test -n ""'
and the emptiness check is explicit.

Fixes: 8b0619579b22 ("cmd: test: fix handling of single-argument form of test")
Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/configs/aristainetos2.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/configs/aristainetos2.h b/include/configs/aristainetos2.h
index 8a66b1275df..2078ebc5282 100644
--- a/include/configs/aristainetos2.h
+++ b/include/configs/aristainetos2.h
@@ -211,7 +211,7 @@
 		"${pubkey}\0" \
 	"rescueboot=echo Booting rescue system ...; " \
 		"run addmtd addmisc;" \
-		"if test -n ${rescue_reason}; then run rescue_reason;fi;" \
+		"if test -n \"${rescue_reason}\"; then run rescue_reason;fi;" \
 		"run boot_board_type;" \
 		"if bootm ${fit_addr_r}; then ; " \
 		"else " \
-- 
2.43.0

