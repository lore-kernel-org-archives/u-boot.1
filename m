Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ECEBE7717D
	for <u-boot@archiver.kernel.org>; Sat,  7 Dec 2024 17:27:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 748DC89486;
	Sat,  7 Dec 2024 18:26:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HJmY4rrD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56BB788DC6; Sat,  7 Dec 2024 18:26:24 +0100 (CET)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D475893D1
 for <u-boot@lists.denx.de>; Sat,  7 Dec 2024 18:26:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-84183532291so218951539f.2
 for <u-boot@lists.denx.de>; Sat, 07 Dec 2024 09:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733592380; x=1734197180; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ke6QYg+xtnB5Mu9yRGp039weqmWxFSs/11iZzqpG0X8=;
 b=HJmY4rrDWmmxQ8j03C/wCVjpPG+VRthRXvTlR738uhUA+iajgVXWFrMHSSRtsIIiLf
 rP4acLZmGHEHpDD/FY9Tq+dSxHU1d1X8W1VzHN1qfyR1xUthSmnPv/s+AgstGpFmEMhg
 okxvlxPQ4/VLgM8OfzGAgs2jWTbL+WchZhTB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733592380; x=1734197180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ke6QYg+xtnB5Mu9yRGp039weqmWxFSs/11iZzqpG0X8=;
 b=o9sXDzeL+mmg1iM5nRO3Xq0vOg4sCo6ze1WDKHztf/cTQZef2oOlqpcxgCAhYch03o
 1LrstnfF6VcSxxqZRkAsmfdmSb1j2+OHF8wsl5INJiadF8XTnEA9vWHiVFqy/WBy5QSQ
 7yrSU+P+XAsbGzGAWjlgN8hzH2m2rE7iU3BOTxhE8UD03aGOhlIzlnCCq+9CETb/V2nF
 x9wwz60PQ1xhLQKAFFKm/RkGUa8tUsE61SOBq9KUAMYH6FiKAU29rrI+BldgJDH3qcG3
 ek4vm36IHrIJpb1EoVx4inm2YSdNa7vWnu4TBdFIOLaqTMb7wpAUGnrcszbTGnzcnzYh
 oa+Q==
X-Gm-Message-State: AOJu0Yy0hLkwQiHiJtdQmMZ3DlGOvx+L7mBm4X8zLDQ2f+592j32Au3x
 HjdvZXxA4woovpKfEGS/LOBXAkVKxogk3uQbHQfrApm1qzr7uRuzNgxk0IcFysWAN+HPDkYw9oQ
 =
X-Gm-Gg: ASbGncvAXkHNdAuRIKYKSQTfiWOpny9qXtbac9gC+CaNdzbFDHOmyhO7evwOyo0uJx8
 2/PEqAwApEII8ZwUpfIJbBdBa+7cIxbvKIyFqcDWgU2D1PD3RwVxJHTsiK4P4B0KlKR5DMj+HoA
 tWhTYGYOFxmPbpTW8NGtVlue7gpyK1M2cdhYdpDN77Z6WoSIzk/lpQQcTrxWmgIkiObQfW9i2GU
 Do3e9Qnua/fgsYjaHFG+5ktIh6DYC+suODglGtXT2a6S2D8AGd6a32aPgtN/RYeARIK6dX8zkXx
 1C+kX+iWRbc=
X-Google-Smtp-Source: AGHT+IEeJWrZzCHuT5wr+3DP3JjUekiTSQxsPLKzLDB+1qWiWAGeSV5ch2n2TnbLhfvNEy2Cnez1FA==
X-Received: by 2002:a05:6602:6b19:b0:844:7896:a152 with SMTP id
 ca18e2360f4ac-8447e296ac9mr933726539f.12.1733592380425; 
 Sat, 07 Dec 2024 09:26:20 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84473a7080csm171745739f.45.2024.12.07.09.26.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Dec 2024 09:26:19 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Gary Bisson <bisson.gary@gmail.com>,
 Mathieu Othacehe <m.othacehe@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 08/19] Support setting a maximum size for the VPL image
Date: Sat,  7 Dec 2024 10:24:01 -0700
Message-Id: <20241207172412.1124558-9-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241207172412.1124558-1-sjg@chromium.org>
References: <20241207172412.1124558-1-sjg@chromium.org>
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

Add a size limit for VPL, to match those for SPL and TPL

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/spl/Kconfig.vpl | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/common/spl/Kconfig.vpl b/common/spl/Kconfig.vpl
index 3dc0e95e09f..eb57dfabea5 100644
--- a/common/spl/Kconfig.vpl
+++ b/common/spl/Kconfig.vpl
@@ -237,6 +237,14 @@ config VPL_TEXT_BASE
 	help
 	  The address in memory that VPL will be running from.
 
+config VPL_MAX_SIZE
+	hex "Maximum size (in bytes) for the VPL stage"
+	default 0x2e000 if ROCKCHIP_RK3399
+	default 0x0
+	help
+	  The maximum size (in bytes) of the TPL stage. This size is determined
+	  by the amount of internal SRAM memory.
+
 config VPL_BINMAN_SYMBOLS
 	bool "Declare binman symbols in VPL"
 	depends on VPL_FRAMEWORK && BINMAN
-- 
2.34.1

