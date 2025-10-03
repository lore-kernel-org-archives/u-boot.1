Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67A1CCAC5B0
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 10:43:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52939836D1;
	Fri,  3 Oct 2025 12:42:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="r5kTNRTN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84CED83693; Fri,  3 Oct 2025 12:42:55 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 992F6836B4
 for <u-boot@lists.denx.de>; Fri,  3 Oct 2025 12:42:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-46e4473d7f6so12735845e9.1
 for <u-boot@lists.denx.de>; Fri, 03 Oct 2025 03:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759488173; x=1760092973; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sziUr5s5Y1GAAZ4Ae4FZvUWdzpnvNCBjvQd23D4w9Hg=;
 b=r5kTNRTNgPQGoEmXGiocntRYnFO1ZshOFpm/Ld8rMjvwuuOwUtLAQY2HJBifqblqZy
 ZdGc9o5MBnmokffN+3Pe+MNnjUa7Hhza4NjVSHtSNogBFRqPxFNB4jLniA5IW7pTQiS4
 WyZ0BdfHRQOMB7M2Mjm8nvB8tz4vMlpXxPIHhvLhCSHbnbMsu1cxAwzw2qwS65DaWiZs
 6eEtEpX9WJKYhG0BJhJ66AXQx8K0/20WQqNe7oBu0gluxBBQhXwrDsoPc+eJ/n+Sbjok
 nWuZQITkhi/8iAGaMteGN+c/8y/UZVScISKeBajzgL+RJrCwUPZDux7xzXBZYNNEBVlo
 ZsnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759488173; x=1760092973;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sziUr5s5Y1GAAZ4Ae4FZvUWdzpnvNCBjvQd23D4w9Hg=;
 b=fsURlm2ReT9TUvKfzLurktRrJTYEbbX7Uee1Sksu3zyPdR7doD1lnkCego1iZ7k0sL
 w47sM/xmReHRQz8H9Ib5icooAS79OiJdpppArv0N+26QFqfNUvIflhmF38wg4uhxSBUF
 Z73afdfDR2nTmuOruWEVZqWOB2UuOWCxMVeC1PESxSrbC42l9exF269i0jaCWIOgGjbc
 1OxqDIvBRrbRGxJkR+KYoaKtPCWCYb0hujKDHt7tLy98AG4ffn3qKpMovl9uNNf6HFMb
 8qg1qvn85TO/Gellqx4QunKz4gk5cOHnVyvhTU1w5Ap8wbf0Uqg8INVoVQZf1oWnnD9h
 xoXw==
X-Gm-Message-State: AOJu0YwtCgBMDu2JLAaAhfGysTpnictUe28LwhUB6yKjW9uAE6a9J5uT
 Uh5P6XUgRRfaevFLOn67EEVrDn5lsYhHwzBltBx8LMi/DIgup6K9XtSslMAqqlwnaeAu3pmYYnN
 APhyH
X-Gm-Gg: ASbGncskjiK83d6vX/1ZQB6D+5viZpBlrPmJuoCpcC92KTIZ8fSv0lGzw57vhluT+61
 XJnbGfWhjyjqgHfnCe2TNTe1qFoO2A0RQOSbSucfZFO5ssWNawSIH/2xkrCVmyd9LC7npyl+EuT
 hL++K8ENOwwpnWwIWmALOZWRpt05J4a9nJ139XleOObJ90t93AIYuh2370vnxLdx2KnkxZwBiGl
 9lXZ4H/Lt6zPU59VK970EkjmQs3cYcVKu+knfvgasIZ8SEUyTcvXidAkHavyhsdTg82HUUmnaRT
 qvasyxLQrCWmyTBmoMYVHsdh+Nrjgg1j3r0XPYW1eXblvu2JtkC4wV14dI1h3AaMfqzGxF79vk7
 lfObvEgK98gOFYIWiBxL685klG6PZNCesW1rwN4HllnuXPDsV7pOmwZ3fbP/0xziOSVXAIbF0CI
 SoFZc=
X-Google-Smtp-Source: AGHT+IF8OEnIITyx7jxEikD3em9L774NXtDI1i4go8qvlo1qrMFk17OUtOeUKMh87kC8FTZxZcsnVA==
X-Received: by 2002:a05:600c:4f08:b0:46e:4b79:551 with SMTP id
 5b1f17b1804b1-46e7608b5camr4302335e9.31.1759488172930; 
 Fri, 03 Oct 2025 03:42:52 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:ebd:e301:a6dd:d590:166e:6c62])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f0846sm7470005f8f.45.2025.10.03.03.42.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 03:42:52 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Fri, 03 Oct 2025 11:42:50 +0100
Subject: [PATCH 1/3] fs: ubifs: Ensure buf is freed before return
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251003-fs_ubifs-v1-1-a48d4861670a@linaro.org>
References: <20251003-fs_ubifs-v1-0-a48d4861670a@linaro.org>
In-Reply-To: <20251003-fs_ubifs-v1-0-a48d4861670a@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Alexander Dahl <ada@thorsis.com>, Michal Simek <michal.simek@amd.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.14.2
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

Returning directly after buf has been allocated will result in a memory
leak. Instead set the error code and goto the common unwind code to
ensure that buf will be freed before returning.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 fs/ubifs/lprops.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ubifs/lprops.c b/fs/ubifs/lprops.c
index a9e22abe6b401ecc4afb15c632dadbe23199c39f..74beb853b6e1da5076cbc8aad77ae26a76fa3580 100644
--- a/fs/ubifs/lprops.c
+++ b/fs/ubifs/lprops.c
@@ -1096,14 +1096,16 @@ static int scan_check_cb(struct ubifs_info *c,
 		lst->empty_lebs += 1;
 		lst->total_free += c->leb_size;
 		lst->total_dark += ubifs_calc_dark(c, c->leb_size);
-		return LPT_SCAN_CONTINUE;
+		ret = LPT_SCAN_CONTINUE;
+		goto out;
 	}
 	if (lp->free + lp->dirty == c->leb_size &&
 	    !(lp->flags & LPROPS_INDEX)) {
 		lst->total_free  += lp->free;
 		lst->total_dirty += lp->dirty;
 		lst->total_dark  +=  ubifs_calc_dark(c, c->leb_size);
-		return LPT_SCAN_CONTINUE;
+		ret = LPT_SCAN_CONTINUE;
+		goto out;
 	}
 
 	sleb = ubifs_scan(c, lnum, 0, buf, 0);

-- 
2.47.3

