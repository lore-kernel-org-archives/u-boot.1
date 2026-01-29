Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F3E8D73E87
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 20:37:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72CB68341A;
	Thu, 29 Jan 2026 21:37:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ExDozcvn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 315C7840CC; Thu, 29 Jan 2026 21:03:56 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3B9F83FED
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 21:03:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-45efde72438so909490b6e.3
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 12:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769717031; x=1770321831;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=p4X9ZgEgfxu23lxnuwfP53qg4eavXjjyBz6fqC3n9iY=;
 b=ExDozcvnzqy6jUqUbe2MnzAdQPpMe+SyVLI0CytHScgjPwiCCaduE0DDF+6xJf3+3U
 rlckam2mdPo18DpwdTDbpPw5QtK0yyi4jPC3uB4aEeD/gE38caDRqIK784p4siNKUVAH
 QeiJ1ZK26ohovAt5c39xFkRWsBr/UP2pBUJggOmyJ2X7AxAmA5eG6KZs9elJkZqX5V9y
 4Cxzwordwxx7R4TWROKwjAx+B7bNYcRjF80uc27X6qnUkOQryqSmsUgYR4pllMd5uA9+
 ECK6a2oaVz2Cl3agejY6ehWyHw7opqBdLDAwgZLWTU2Z747x9RaKuB4ePZMn3b5rllfS
 dZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769717031; x=1770321831;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p4X9ZgEgfxu23lxnuwfP53qg4eavXjjyBz6fqC3n9iY=;
 b=j3Muuh8FQ5jZD7vcMGym5rM8QPSf3pHb9+JclvnPpFl6mxYu03aP70hptKGl3Fu+XG
 DwbToPT+MOmenYdGLDZ6dOham1ZgQXM6yaoEyggX7J0IW6nK9lxP1RWegeDf9jiAP+S0
 qAiuT66DYNvXmBi50Fxk8TZF+q22jAZCS4NWbzUP9CgjB/AddftHQNjFN4aMV6WHzx11
 z4EClknGoNX0VzBpnXt00LUPG70oI0m3WiaHVD/1NhrsrL/1k2OGJHHF4BK+gJyOBfTn
 jDE4vTP1GEE7L1Ez3H7QHM32Lkq+DuBxlckr8m3vHVefRo1+74WbkWc02BWeJ1gGileb
 0LfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMS0lYNOa4srwa/xJunyZtWvw6uCoB8/0P5+3q5c5GiHhued0wM13pqVIEbXc3CXpOmwFZo0c=@lists.denx.de
X-Gm-Message-State: AOJu0Yxt3XSiTRekveK2A0tT7TzVKQ6u65Iit+4pHhJXh4Vkc883d1EL
 4TSrEhQiOO/0NbEkZph3ag6i9Rarg5fuWcT3jcm92EZcabHoFJUuQW/wFUUTFKp0pCz7ZgxNZVd
 ZEoNr
X-Gm-Gg: AZuq6aIV/cbk15cEkkuihIdkZrFxWuIRV5T1F4rr/If83H9GWBJv/ibxMRjgWBskXBr
 M1Ql8cLwjPeaKTfbsbbi7b9cMGEFHnsT3Tar1Xtos5kbG94Wou/442YWf8DonTQ1rKh4TObPfmg
 ayaY+UUyxLX6uMtSGSeEDhyqM9PCfuWMzx9CnN5wtnfWJFRwQw4xGjINjiUbS1W8TrCNCTqUXLZ
 mZwUMrc3/ivNqKfpEg08c3/6IAZkhnGE510bEqUZ44G9t/qT2Exs6aiqogW5PuKCsj3Yf4Nnzzc
 19wauBHY9kbfnnGVNvLmoAiLKmBAsn5J5SFS3lCAVA9TXradN5bT89sN9o5PomI6ckyidlkmKqH
 UPVihAUA8qtKtzMBOeVFisi7bvD/oqx0jiqSSN7XYUlp+7NNCSHCryOanrrXzIwsVUgvao0NDMC
 k+zBd23ID07laNYG8=
X-Received: by 2002:a05:6820:480d:b0:660:ffcf:42e7 with SMTP id
 006d021491bc7-6630f035ca5mr276939eaf.30.1769717031428; 
 Thu, 29 Jan 2026 12:03:51 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:eca6:912e:45a4:4837])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-409570f1273sm4472003fac.5.2026.01.29.12.03.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 12:03:50 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 29 Jan 2026 14:03:41 -0600
Subject: [PATCH] boot/fit: print error name in boot_get_fdt_fit()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260129-boot-image-fit-print-error-code-v1-1-20d8edfed856@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2NQQqEMAwAvyI5G2iLFPUryx5qjZqDjaRFBPHvF
 o/DwMwNmZQpw9jcoHRyZkkVbNtA3EJaCXmuDM44b6wbcBIpyHuoZuGCh3IqSKqiGGUm9HEywYb
 eD12EWjmUFr6+w+//PC9mQIykcQAAAA==
X-Change-ID: 20260129-boot-image-fit-print-error-code-6cb0a1a8694c
To: Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1676; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=gpQmRSgaKSGdW32zFzRqsBcbK917h1xi37HK3hCWPwc=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpe70ePd4q+WdeOGDLbB5TtIt+5xPal1NTyKVTi
 HyGfXFZPJeJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaXu9HhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AZNgH/1ODMWA5Qq2unyB2AkIm9pqnpTNLrApTwtmtAhi
 ElVXAIQE3oVH2QUZmhiXweDMZOdxzApiCMEFXtxEt9AcxLx/cIF8Xh4D+1rSOdrV9k30FAOQvBf
 GHCyls8eeBnHnqoArttxMLn2NJjgycXbRjLM7eEs5RzNSFP4S805n0MJwILR9x6r9qGif9dTaLI
 KRrm8AsiH4gxssbYkvtINwt8oP47h6ZZkNgWCmXPRQsnuvzXXNGk5x30ru0R9Y83gOXNkmolwA8
 5gVzeHEOEZPHtkW61Gj7h87trcXX0I67DoYSOEuFKcP3ABSbjda8hd30W5SBw2HBHrMz79qv75U
 9Jwc=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Thu, 29 Jan 2026 21:37:16 +0100
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

Print the actual error code in a couple of places in boot_get_fdt_fit().

These are FDT error codes, not errno, so printing the string is more
helpful than printing the numeric value.

The only caller of boot_get_fdt_fit() unconditionally replaces the
returned error code (fdt_noffset) with ENOENT so the actual error would
otherwise be lost.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
This change helped me find that we are affected by the recent change to
strict dtb 8-byte alignment checking, so I expect it will help others
as well.
---
 boot/image-fit.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index 85026c2d1d0..3ed69b5f7bc 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -2501,7 +2501,8 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
 
 		err = fdt_open_into(ov, ovcopy, ovcopylen);
 		if (err < 0) {
-			printf("failed on fdt_open_into for DTO\n");
+			printf("failed on fdt_open_into for DTO: %s\n",
+			       fdt_strerror(err));
 			fdt_noffset = err;
 			goto out;
 		}
@@ -2509,7 +2510,8 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
 		base = map_sysmem(load, len + ovlen);
 		err = fdt_open_into(base, base, len + ovlen);
 		if (err < 0) {
-			printf("failed on fdt_open_into\n");
+			printf("failed on fdt_open_into: %s\n",
+			       fdt_strerror(err));
 			fdt_noffset = err;
 			goto out;
 		}

---
base-commit: eed514b11d04a2f8a949521ad3bffba3ec98bd2f
change-id: 20260129-boot-image-fit-print-error-code-6cb0a1a8694c

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

