Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3913CD8C8C
	for <u-boot@archiver.kernel.org>; Sun,  7 Jun 2026 19:35:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99F9F84894;
	Sun,  7 Jun 2026 21:34:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rHU024vi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01915838BB; Sun,  7 Jun 2026 17:41:43 +0200 (CEST)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5A5E801A9
 for <u-boot@lists.denx.de>; Sun,  7 Jun 2026 17:41:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=naveen.osdev@gmail.com
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-8422871b42dso2072363b3a.3
 for <u-boot@lists.denx.de>; Sun, 07 Jun 2026 08:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780846899; x=1781451699; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OvOrAqnfQrmYM9VWm9nzNUJWz4gz/ObCG65WdxwTssk=;
 b=rHU024viTc6XrO+JujvJnoxNmSfVivVXvDqtn8jSoB6HPpHe8ITPS7KBDtPRZDx8km
 zd7xZcl8fPhMxy4mgCaohdK6d0Nauksec3RCtYQ87Y7O3YfHFOQIjI1LVew++4Pqr6BJ
 gz1l70a+ZK76MYBUvwxYsnSY1mr0B5AH5fxROXV1ovIhvbSMlebrvsAZL8JTgwxdSZ8U
 rLGApfz6qfpJldLbYjXDgFYcA2i+ahXQllMe5ypbpuW/pqmIjzDSpKJIkKDI8m8H9HJW
 etdAyHaBdf8DzGTsG7MT3r4uyKPUOBfXYwnM904X82C8wR2+WgMw/ZBBq4DICmfz5XB2
 9gZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780846899; x=1781451699;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OvOrAqnfQrmYM9VWm9nzNUJWz4gz/ObCG65WdxwTssk=;
 b=RbkPzzzG3YUDoHSUSqVX785YQ4Ssnde8P7EkIkcxMLnshM5lS9BfVb5Z4bU7FT8ABJ
 rNYouOFv9KakIXpVJHOd1inL2iRnQNxhPk84rGNTU+wXECClK33sYaQPEJXgWOEsN1A8
 66fJHSE4yfi3dXtle7IEZcBQgGbOUeELZQoZTzrqbl7b1P3EA/v211ne7aV1zO06tOZx
 0YVzXAwFfn45/BBmQNzdRBIHrA9/UjS9PLa2o1ou89YYkUh5Bl1XJMKsj/ISoOthDSw/
 m5Sz1MtkiysYhIdTZ8hgjOz0Bak+JjX2Cp8oUexG8OpoZl4Kq6TKRx4lDDi3VzfD9PVJ
 nwBQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Ie59wIVvdxDSYZj/7ME4kNAke3oW2sJo83D07ZCHNad5rJFx5UcPGSjEUelUhfSCkCotrbcc=@lists.denx.de
X-Gm-Message-State: AOJu0YzRCShQYmmXumkTDwb36HsWRPNIsvbLV4u0f3zw6mnkiPhWfQVu
 YEi0lDfLJ+I9fkqTdjCcW/d0mJPfD05igjrdVpP3luqunkHpXlLh7rKPmti3ug==
X-Gm-Gg: Acq92OF3ZWTtluicPDxZ2deki4dTjBr2Q2XXPXz7h1Z8XXYDOR4euB0lDR+QwTh9PlE
 G9thGYLrZV4CKKJUvr/XMsmHhgcORc5NO91ZgaIoxwrW+7w6xoQoLW5ZrgHZl3nM+VIUS24Xt8F
 mnqdlw6dm5RUOpVrQh8KPQ3H6xn1x0lm2PBuXEz2MBBHJ+er77AHCN6hNwcVkgxqdNOn3QAT8SI
 jomZzXf/qU+zqB2/yYqsn8K1zA88852k7NgG1e/DZd0zr5ZW6ZUOKjcqbU80ZGHp+X9lcAkG1xq
 xoPPHMHLMLeJEanSYd1luUTxMjsIVhseSnQwN3nnAkpiXvvMcI4qNfKGQntm18Qm91Siy0VF8fa
 NuXZ0+c/V4XmWPkiuPyWAaR6F29L0V8qEAJ5jaStWvWUJ+ryV3Hh3T5Bb/sJmiTEsyP9n9kV5tH
 y9mwgHo4fVgHHVXGzJ3nRrsMmn0T+q/C6iGP4=
X-Received: by 2002:a05:6a00:a13:b0:82c:d7c9:5479 with SMTP id
 d2e1a72fcca58-842b0e3da19mr12675603b3a.32.1780846899315; 
 Sun, 07 Jun 2026 08:41:39 -0700 (PDT)
Received: from localhost ([2405:201:4027:a919:e2b2:8560:26ea:4d1])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8428325d9a3sm15129927b3a.34.2026.06.07.08.41.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jun 2026 08:41:38 -0700 (PDT)
Date: Sun, 7 Jun 2026 21:11:37 +0530
From: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH] serial: msm_geni: fix clock rate return type truncation
Message-ID: <6wv2gjh4bkxttxxriqx25k43qkeg2sraknwaffxahcyqxedfm5@uuxaorwsolbm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Sun, 07 Jun 2026 21:34:32 +0200
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

get_clk_cfg() and get_clk_div_rate() return 'int' but operate on
'unsigned long' clock frequencies. If a supported frequency exceeds
INT_MAX, the return value gets silently truncated or sign-extended,
causing the caller to misinterpret valid clock rates.

Change both functions to return 'unsigned long' to match the data type
they actually operate on. This matches the callers accepted data types
as well.

Signed-off-by: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
---
 drivers/serial/serial_msm_geni.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/serial_msm_geni.c b/drivers/serial/serial_msm_geni.c
index 3dca581f68f..9de193355e4 100644
--- a/drivers/serial/serial_msm_geni.c
+++ b/drivers/serial/serial_msm_geni.c
@@ -109,7 +109,7 @@ unsigned long root_freq[] = {7372800,  14745600, 19200000, 29491200,
  *
  * Return: frequency, supported by clock supplier, multiple of clk_freq.
  */
-static int get_clk_cfg(unsigned long clk_freq)
+static unsigned long get_clk_cfg(unsigned long clk_freq)
 {
 	for (int i = 0; i < ARRAY_SIZE(root_freq); i++) {
 		if (!(root_freq[i] % clk_freq))
@@ -130,7 +130,7 @@ static int get_clk_cfg(unsigned long clk_freq)
  *
  * Return: frequency, supported by clock supplier, multiple of clk_freq.
  */
-static int get_clk_div_rate(u32 baud, u64 sampling_rate, u32 *clk_div)
+static unsigned long get_clk_div_rate(u32 baud, u64 sampling_rate, u32 *clk_div)
 {
 	unsigned long ser_clk;
 	unsigned long desired_clk;
-- 
2.43.0

