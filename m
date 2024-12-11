Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F20E7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 16:32:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD68280383;
	Wed, 11 Dec 2024 17:32:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="koNSD+nh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BDE1801E7; Wed, 11 Dec 2024 17:32:06 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A3298036F
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 17:32:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8164B3FE57
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 16:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1733934723;
 bh=SVeYZFdgtiEzoxRxcUw/Q6m9kKGXsgX6HWKtIf+8IMM=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=koNSD+nhekhr+N90F6iG8CJThDrLkCpJgJOKGHNqXewqZ4WrXN4y6xNEXFN/KoWQS
 r1dK5iCQLw6foIeLZ0XnURZ9Gad6WlG5S3XxuGXSWSDtHHEvgrJbYQH+3nTdeQTZyU
 CKBWzldZYMZS/0BHuH9YuD1gi7swg2Sj65fbfGsuSKBhAOAXPiXpECk+ir/gX1nUUj
 4sNUDBdgzVWj1frseRvPaR0Jb52FP7Pe+uj/eQM+sVVLpAawRGLlJ7lE3gRKJpIFhx
 wKjJCJsQ13Ja/vuUrX9LxWZNN1FCZ2fJ2cXc58qgR+2Sopg7akJWAGo8/7FjwSRFeW
 Qo5yzSfJlIFxA==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4361fc2b2d6so4542895e9.3
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 08:32:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934722; x=1734539522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SVeYZFdgtiEzoxRxcUw/Q6m9kKGXsgX6HWKtIf+8IMM=;
 b=PcpQvZRNe/ZHZQ03et98c6r+2eDTC4APs0hj75usTUqBjqJBUMK1Mv6+G2ZVnBRezU
 DqWTfKv6P/SOn3ldUjzZ35UcCfSSJxTMdoho97ouqQAs307QBQ6Z4qjkuAzmcJF930Zz
 R1VJrAWGLCpowfEZOg53rIUdxzWP72i15JujAVexY8oDOffXJ7f5glYJjfpc6ehk6RHO
 7xNuA9tT0D2pzrJOT/SH0J2lY5Yu0T9JPPNJb9bpO59Jlq+PblmzzlK+aikLMwju/+sg
 +NnEpg94WcZJJ96soOAs0DAF2cFSsJiOxz4gM2ZFVsONomM2sisod6HuOglyHg+OtH06
 62JA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVApabdLLm3tk+KAbVA1E1hfTKsCdGhpZXtl1ZBLIjGfBIToUUtL6GfsjYQESGgQtnya4/tqfs=@lists.denx.de
X-Gm-Message-State: AOJu0YwT39X+DZXf2ZwP2qGM72UkjlcvmcsYgDEX2EcaHwf2sNhBmjuu
 6kIqxMXQTmijm5JESZWRteItmA7KeIbunUdXCGoYQtv9gUje9zvI4WxfuMRJRskn2lqUafLH2iF
 8UOFh7YmWPV9dtUo0JWBevmAmGq3lgg2WxXzHUlaAvFetJYE0PDStBvG/VfMxN0+6sIE=
X-Gm-Gg: ASbGncsa5ybrq6swN31tK+g8+cQ1YszVYFA3ZdMMUV3mNkdNHtHiGIZdQtkiDVinJYT
 CzLnEpywghfe+Qr3P/v4IKfvmdaJNpfQNceQwj3T7vGlyxum7/ZGkUHUoB3e+11S01tLGofcAMe
 lvQm1AWOBaxxyIaS+AvmrAePrcOCxS/yN1QgLB4uIwrd7oWQQx4nvUXqPBJHQ9MDJ34f7HrweNS
 ldJJxugrnCmTlWQ6Pj1aUo0tPXv0NAkLFyZM3AU1p0f+4GGtdsxdL7Cyp3xAtmFmfpWbErCtPPt
 mM+YpsOTjmhRa2oLFuNUWkEs8Snmi0Vw6RWNllGs/bUeEZ5n7Q8I1GO6ZYQ=
X-Received: by 2002:a05:600c:3b94:b0:434:fdaf:af2d with SMTP id
 5b1f17b1804b1-4361c441f23mr30341905e9.30.1733934722734; 
 Wed, 11 Dec 2024 08:32:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtWP4Mgdll6cHvOQaC6/vZuHz5QDMaV9cOsy3X/e81CD4Xv3zzIcCL0E7M5qRxoRb/ACkcmw==
X-Received: by 2002:a05:600c:3b94:b0:434:fdaf:af2d with SMTP id
 5b1f17b1804b1-4361c441f23mr30341605e9.30.1733934722362; 
 Wed, 11 Dec 2024 08:32:02 -0800 (PST)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3878248f521sm1627311f8f.16.2024.12.11.08.32.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:32:01 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Ashish Kumar <Ashish.Kumar@nxp.com>, Gaurav Jain <gaurav.jain@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Jason Liu <jason.hui.liu@nxp.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 3/3] crypto: typo volatge
Date: Wed, 11 Dec 2024 17:31:54 +0100
Message-ID: <20241211163154.56272-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241211163154.56272-1-heinrich.schuchardt@canonical.com>
References: <20241211163154.56272-1-heinrich.schuchardt@canonical.com>
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

%s/volatge/voltage/g

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 drivers/crypto/fsl/jr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/fsl/jr.c b/drivers/crypto/fsl/jr.c
index c45481bef0b..8f7a821ebf3 100644
--- a/drivers/crypto/fsl/jr.c
+++ b/drivers/crypto/fsl/jr.c
@@ -654,7 +654,7 @@ static int rng_init(uint8_t sec_idx, ccsr_sec_t *sec)
 		ret = instantiate_rng(sec_idx, sec, gen_sk);
 		/*
 		 * entropy delay is calculated via self-test method.
-		 * self-test are run across different volatge, temp.
+		 * self-test are run across different voltage, temp.
 		 * if worst case value for ent_dly is identified,
 		 * loop can be skipped for that platform.
 		 */
-- 
2.45.2

