Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6259C83F17
	for <u-boot@archiver.kernel.org>; Wed, 23 Jul 2025 15:54:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF79E83531;
	Wed, 23 Jul 2025 17:54:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="u+7Oo5KZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA65183560; Wed, 23 Jul 2025 17:54:11 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E9E98317B
 for <u-boot@lists.denx.de>; Wed, 23 Jul 2025 17:54:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a54700a463so57245f8f.1
 for <u-boot@lists.denx.de>; Wed, 23 Jul 2025 08:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753286049; x=1753890849; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2r0beyIS9FdWm7TiAuVAbkzst2lH7uH0fA4BGU5by7Q=;
 b=u+7Oo5KZ4eUY8JgSEhHLdQmXfkckHWlKjP/0rfUJine3OxXi4mV3+Im/9ga5+RmA07
 R7IWFamdPM+z9PcsflDs3eRZfH8m9hpejBlk3pmPzrBnxCte/OpGDdNOALrFjsxuZeuo
 vSRwMYE06JtMA87HwBdQNyrwpBDwpZuPxZStGvSOcqyuxituMS6FW1bLmnJmghbQg1gB
 h3VeNw2kdkEMjVtD9h6llJMBduUuQaLJtdSHg5zimearnIw0lEgk9bpVz+wymkcTW3YH
 fC360gPkv8O3x75a+f2uozB3YTxrFELbf2k4+LjZz3AKNk5BlnChKcuXs3/EF6gNN2pW
 FPNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753286049; x=1753890849;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2r0beyIS9FdWm7TiAuVAbkzst2lH7uH0fA4BGU5by7Q=;
 b=dPSGQrlswmFttjWQW/BHhGSXO/VsmV/RtFkq7DvBV/dLXDBK0Ymm3Z9Ac6qcBuB3yw
 RbnYBq20vleoCXeopZ8TKE3CVkGbSGQGVSJMU9DB+VGdfGmByvKz91CDjhHdIpeiA13w
 58eZdEbBVNHUQhwmyWcTYi955lAll0EQXphsgFmBzdY69VKNXVOFCJiUL3O+J3oiap0M
 aHgKkd9NrTkPTTGjKEeLPhuWF6pGRuzi7bXXF8rs9l6rHDHgvxKadBKDvqs6/6YF7pK2
 8AzzmcNftc3KNSLs87yGARwnhc1LK53OKtbavOuBEOnxC1CMW+Z7iS3a4NMXHKbQxctb
 9x9A==
X-Gm-Message-State: AOJu0Yy0gf5+RtBVbfZAI5VXCCotOnKV1S0ZlhX7XnDOUVoPgF1KXIcM
 +4c3VY11kWjvCQQZGVjK+T5ozeCT8mM+uLBoiJ6AwHSQIk5pQFRIMqiM7eK62iDw29Q=
X-Gm-Gg: ASbGncsaSrDpVNXpzioxdP+UPVlf4FmoZ2obfPkaCn50haQC2lbCqLvnrmjNUCKcxmT
 Lwl2WOoi3dNXkaEIFby7YfWKXyKYOFmilP3/ZA4wfxvGDwbIyk0flruQsN8btlaE4wycKWCVKGZ
 Zfx+wdbtajmNEOvOtmQqZN7wKGl+JucvIdZ3QDXMek9vasEvtGFk3mkUJMucuOShTyW8OOAYX7s
 v91Z6qE5wapF6A3Se0qcx5KJgY0A5kP4wGjVlsXg3VNl67xCRpBZQleE+ZJHBgftqDZP8j/tGGZ
 GGnM74TMQbVbKFcX9d3Nds5bk/8ebT3gcP1jm4NJuv2ice+fc2pHEBCAaH6B+HMkKw92U9nPc+S
 SOrf2atyGMBwLI6i8RPCpzybWcNn+Kd/GfV/R7TDSVwO8mnM1gTE=
X-Google-Smtp-Source: AGHT+IHmwEt7VefayChHZt/vkruBEYWC0Zp9FuwZLVYbjqmsze0l4K3N0twazoaRzQSt5cwdTcEFEQ==
X-Received: by 2002:a05:6000:2901:b0:3b6:5d0d:9826 with SMTP id
 ffacd0b85a97d-3b7634edfd4mr7219854f8f.21.1753286049280; 
 Wed, 23 Jul 2025 08:54:09 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:cdd8:a59a:1949:12ce])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45868ef50d8sm28345045e9.0.2025.07.23.08.54.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 08:54:08 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH 0/2] clk: versaclock: Fix two issues found by Smatch
Date: Wed, 23 Jul 2025 16:54:06 +0100
Message-Id: <20250723-clk_versaclock-v1-0-9d70f2530871@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ4FgWgC/x2N0QqDMAwAf0XyvIJ2k+J+ZYyRplGDro5kyED89
 1Ufj+O4DYxV2OBebaC8ismSCzSXCmjEPLCTVBh87ds6+KujeXqtrIY0LzS5ELhLKaYbtg2UKKK
 xi4qZxiN7o31ZD/FR7uV3nh7Pff8D/qJbEHkAAAA=
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

Should return value calculated by ERR_PTR as calling code attempts to
check for it.
Also do not dereference a pointer that could be an error pointer before
checking it with IS_ERR.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
Andrew Goodbody (2):
      clk: versaclock: return value calculated by ERR_PTR
      clk: versaclock: Use IS_ERR check before dereference

 drivers/clk/clk_versaclock.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)
---
base-commit: bd0ade7d090a334b3986936d63a34001d99722ad
change-id: 20250723-clk_versaclock-77e9ddbd4a51

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

