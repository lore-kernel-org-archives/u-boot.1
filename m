Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FB55E9D800
	for <u-boot@archiver.kernel.org>; Sun,  5 Apr 2026 14:20:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F0568352B;
	Sun,  5 Apr 2026 16:20:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O50i2WMi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86B208394E; Sun,  5 Apr 2026 15:54:52 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E9E88341A
 for <u-boot@lists.denx.de>; Sun,  5 Apr 2026 15:54:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cryosay@gmail.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-43d02a71526so1861628f8f.3
 for <u-boot@lists.denx.de>; Sun, 05 Apr 2026 06:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775397289; x=1776002089; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1wYWLX5/1KPXWZYVn+AWyQw2nGGMSWtIQtlZ7m+uHyM=;
 b=O50i2WMic0xNSfq5sMPGbHuizw3FvMJLarbCZRme72h1wXSB8XV6tH66WKZnCeh5y1
 GyInUBoP9CloWq/lfxMSuVp1qYO5knZCK34o4H1QQXNkkcX0W/NyO0VPtbcMBrrhFYU9
 UQpprjFZhTvEu1rUcy8qv6CJ+dTydcznf2oOXBLTVgXn86koDBip1M1xFDypA9NiTaQo
 s5CqoEfWEnexIakgQBYwJrmsoXwgtnVRUUqR7gRlACd+L1kdSYD+tOb1Z3UHFlWASsmS
 ku+O7JIlCLCjCW4/qei+j5BKOxIaRy8PzWOwFH1uCTxs2BlMh5luRxSpSOHuAaX77D67
 XpKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775397289; x=1776002089;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1wYWLX5/1KPXWZYVn+AWyQw2nGGMSWtIQtlZ7m+uHyM=;
 b=rNSh0uUWT6s8C2rO7IPur0KPekC6WsA5S1z8AAw3mQDZmAMnQ0/Fiyk8UWwQ0YfEzH
 VpOtV1mD7c6IHU20TpcpoSa0oM+m2REupm8PU0fESCiO/MxaWY+sxgvvJF6UflJWuhPf
 ZjiJv40Z/Beit/mVUIEC1ne9ewIfmrsgKIYMywpyOYHdLy9a+ghZndXmSek9bZ0dJJJv
 007sXp3AeY6tgxuSfJwrpcWP/GuUJ8nnbQX5Wyd/Nn8L+kOo/Sn0BT8WbWBzzE364Jsq
 bPRpUtpLKzVeHus0s3/cAAlp1kFlcYKhQ4xJDbOc/NWFs7IZtwsHHx3Dyj9wXIZZ2V4I
 UEVw==
X-Gm-Message-State: AOJu0YwDt+aALl0lGCGS94hYyC6Cn2gJM29KTsD+tdmsYE0ZZwZvCUs8
 E3sgAtT3QqCAaT3j6hnyD7KTQ+5PlNmtREgNPJCitAPiaQHFfFjV0Qdbtb4uSQ==
X-Gm-Gg: AeBDiev9jZbWC+IsY/PGI7u/dujPvtzw60Hy+gPxaYiwKouffLYYw/rlGE/iVpTMfb9
 iRHaq7u6TOZKDkQzHvMeki3tB8ENTdeNRNzvc9u5M+jC1Rq6UxObK7oi9qNPe5GnAYOhhXJWAJl
 FAJNBSbuJt5fXcaL1b5Cvwd/6INZPMGrQG+P0es9DbriDDD9OQpQop0mv2CrxzQFZ+3Fhu9dIHD
 OHeualGKiDrwYECMlzfkB+eD8x8jcQxsS7yRCzB4F9KYjhPEs8fc11Uv9g1qqyiaGzHdNwXhiKk
 R86WtPdgrtroAh8+tPvZEYDzqUrj/Lsk5h+PaC7VzlLBLttH/BgaRIOhz9GjCx+mRXhk8fE8KV+
 2BLNEvdR1708wmhr5hI4fJPIu23CJirWuMtjdy+c7b+cePCIGYoKp6ixRrlhiMqxaCJiEYbN+W5
 C9HM7i9h9yVHRd+olGpFZxlHNEa6WCjKYfwg==
X-Received: by 2002:a05:6000:1a8d:b0:43c:f793:f1b0 with SMTP id
 ffacd0b85a97d-43d292ff470mr13477526f8f.40.1775397289322; 
 Sun, 05 Apr 2026 06:54:49 -0700 (PDT)
Received: from CryoVivoBook.. ([91.244.24.228])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e4f5016sm34481118f8f.33.2026.04.05.06.54.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Apr 2026 06:54:48 -0700 (PDT)
From: Oleksandr Suvorov <cryosay@gmail.com>
To: u-boot@lists.denx.de
Cc: Oleksandr Suvorov <cryosay@gmail.com>, Gaurav Jain <gaurav.jain@nxp.com>,
 Ruchika Gupta <ruchika.gupta@nxp.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] DM: crypto/fsl: fix unaligned exponent handling in fsl_rsa
Date: Sun,  5 Apr 2026 16:54:43 +0300
Message-ID: <20260405135446.415680-1-cryosay@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 05 Apr 2026 16:20:27 +0200
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

The RSA verification path loads the public exponent from the FIT key
node with fdt_getprop(). That property buffer is not guaranteed to be
naturally aligned. On ARM64 this can lead to a synchronous abort when
fsl_rsa uses the exponent value directly during verified boot.

Fix the driver by copying the exponent into an aligned local buffer
before building the CAAM RSA job descriptor. Read the value with the
pointer-safe fdt64_to_cpu() helper and pass the aligned copy to the
engine instead of the original FDT property buffer.

Also flush the cache for the aligned exponent buffer actually consumed
by CAAM so the cache maintenance matches the data path used by the
hardware.

This keeps RSA verification functional while avoiding crashes caused by
unaligned FDT property access.

[1]
---

Trying to boot from MMC2
    sha256,rsa2048:dev"Synchronous Abort" handler, esr 0x96000021
    elr: 00000000007e737c lr : 00000000007e6e78
    x 0: 00000000007fd1e4 x 1: 0000000000000100
    x 2: 0000000000000800 x 3: 000000000091d420
    x 4: 000000000091d420 x 5: 000000000091d588
    x 6: 00000000401ff9b8 x 7: 0000000000000003
    x 8: 000000000091d49c x 9: 0000000000000002
...
    Code: f94008a0 2a0103f4 aa0303f5 b40005c0 (f9400003)
    Resetting CPU ...
---

Fixes: 34276478f7b7 ("DM: crypto/fsl - Add Freescale rsa DM driver")
Signed-off-by: Oleksandr Suvorov <cryosay@gmail.com>
---
 drivers/crypto/fsl/fsl_rsa.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/fsl/fsl_rsa.c b/drivers/crypto/fsl/fsl_rsa.c
index 125a72ae6d3..053e1862bc4 100644
--- a/drivers/crypto/fsl/fsl_rsa.c
+++ b/drivers/crypto/fsl/fsl_rsa.c
@@ -23,6 +23,7 @@ int fsl_mod_exp(struct udevice *dev, const uint8_t *sig, uint32_t sig_len,
 	struct pk_in_params pkin;
 	uint32_t desc[MAX_CAAM_DESCSIZE];
 	int ret;
+	fdt64_t exp = fdt64_to_cpu(prop->public_exponent);
 
 	/* Length in bytes */
 	keylen = prop->num_bits / 8;
@@ -31,15 +32,14 @@ int fsl_mod_exp(struct udevice *dev, const uint8_t *sig, uint32_t sig_len,
 	pkin.a_siz = sig_len;
 	pkin.n = prop->modulus;
 	pkin.n_siz = keylen;
-	pkin.e = prop->public_exponent;
+	pkin.e = (void *)&exp;
 	pkin.e_siz = prop->exp_len;
 
 	inline_cnstr_jobdesc_pkha_rsaexp(desc, &pkin, out, sig_len);
 
 	flush_dcache_range((ulong)sig, (ulong)sig + sig_len);
 	flush_dcache_range((ulong)prop->modulus, (ulong)(prop->modulus) + keylen);
-	flush_dcache_range((ulong)prop->public_exponent,
-			   (ulong)(prop->public_exponent) + prop->exp_len);
+	flush_dcache_range((ulong)&exp, (ulong)&exp + prop->exp_len);
 	flush_dcache_range((ulong)desc, (ulong)desc + (sizeof(uint32_t) * MAX_CAAM_DESCSIZE));
 	flush_dcache_range((ulong)out, (ulong)out + sig_len);
 
-- 
2.43.0

base-commit: 214aababe07de0598bd26ecb0c8fb2e2843ff7d5
branch: master-20260404-rsa-verify
