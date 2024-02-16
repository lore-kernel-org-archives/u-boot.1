Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1134AC48260
	for <u-boot@archiver.kernel.org>; Fri, 16 Feb 2024 17:06:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2ABA987E1D;
	Fri, 16 Feb 2024 18:06:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="d/Ur/0OS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 935B087E1A; Fri, 16 Feb 2024 18:06:16 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1FE8876E4
 for <u-boot@lists.denx.de>; Fri, 16 Feb 2024 18:06:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EAAEB40FB7
 for <u-boot@lists.denx.de>; Fri, 16 Feb 2024 17:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1708103169;
 bh=jf3xe5TPBXo4xXZJGXW+6JoEHDnMvmFrzz6ZJu68MUc=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=d/Ur/0OSIhN25LMbhmXLYEDToIjP10NH8MZ02rfa3wxuqhfsdw/jKaZLDYegitlrL
 wKu3/gpePcm7ST6Udscsnl0K2r0XqSpg8w2QJ6o8+IytdOm6KX9niHD6ctrzQ5OPUo
 xLNRBDBHai/SZCuh+4V2vtJgtnbol5iOh287HeFRMK5OaqPY10e75UGJx0Nz+3DvJE
 Q7k1lWTi5JasV7Yhsm64v0YK57c+gvYh2K1OAdwzrwLfIIPHP9/HkxzxDwOwEYbC9f
 83VaonhlJEKfi+IxsEzJ2+PA5g9awYhmsJkmyOwYdb/AFp1I5WugjbdrZBFXlBMcjz
 cS4W10xsl4/aA==
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-33cf6266c2eso1072541f8f.0
 for <u-boot@lists.denx.de>; Fri, 16 Feb 2024 09:06:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708103169; x=1708707969;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jf3xe5TPBXo4xXZJGXW+6JoEHDnMvmFrzz6ZJu68MUc=;
 b=nyv6H2zipWEEDH5uKwUEO15PsBtrTlLOUA40Z0omQ7AGJzAr8wPEQ69u8D22vEkWGA
 29luzv7zXpku3E/4h+U64ju+pcEvLFhRXhWOQ5RjXyBYSY4S69O5uijpjXmWfIUm6F37
 gxcR7IeGMa1jBiNQczJV3KSfRSmv021ko6aabK/remT116us/O+HDF8ppcZgkRg45SE5
 inwssB0iwm2XnfB9CUraBu4Bv0YMYdxq4ibjKa8JPMepO7p1M4QxqL5wGZFxhl1XA33F
 OiKWAEeQWDeNNRaAInSSz2/VsgEyjC8xw8bR2sjv76mm32unYGr/f+ydODUSOH/2VkpX
 4+3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUI1+8Bxtyg8EpC21jwYkwO6twjgut7kdQde5JWQgwP7wx4kwH1d59STxOpRpqhWJbAPye40fVycdpbypee5QHtpxCjEQ==
X-Gm-Message-State: AOJu0Yx86sPuKMwy1tway6BD+zzu/tTuttJIXFmgyUA6nlD84wpc7+ly
 cKQuikpgfRftyPyr0jzAANIeVHA6TT+/2bn5MD5Gu10pQo8Te0Llfx/DojaQ+ke1ED7qlObvocw
 pdorZ6mtfVjXnmRRPohdwMdy4suHgtSxKEbQ0isM4vez0kctA2d+q8vcARg+YJOFh5cA=
X-Received: by 2002:a5d:46d2:0:b0:33b:10de:59a2 with SMTP id
 g18-20020a5d46d2000000b0033b10de59a2mr3779817wrs.15.1708103169573; 
 Fri, 16 Feb 2024 09:06:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGtbV6fTkEUSGrQskHRZbzqbrNy6iEhImjtvsm5lBmUAZa4zdluqjQ3bWS6vC+E65HUzEa89w==
X-Received: by 2002:a5d:46d2:0:b0:33b:10de:59a2 with SMTP id
 g18-20020a5d46d2000000b0033b10de59a2mr3779803wrs.15.1708103169181; 
 Fri, 16 Feb 2024 09:06:09 -0800 (PST)
Received: from workstation5.fritz.box
 (ip-178-202-040-247.um47.pools.vodafone-ip.de. [178.202.40.247])
 by smtp.gmail.com with ESMTPSA id
 c5-20020adfe745000000b0033b46b1b6adsm2699506wrn.21.2024.02.16.09.06.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 09:06:08 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Lukasz Majewski <lukma@denx.de>,
	Sean Anderson <seanga2@gmail.com>
Cc: Green Wan <green.wan@sifive.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH] clk: sifive: check wrpll_configure_for_rate() return value
Date: Fri, 16 Feb 2024 18:06:01 +0100
Message-ID: <20240216170601.277015-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
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

wrpll_configure_for_rate() might fail. We should check the return value.

Fixes: d56d79ed27c6 ("drivers: clk: add fu740 support")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 drivers/clk/sifive/sifive-prci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/sifive/sifive-prci.c b/drivers/clk/sifive/sifive-prci.c
index c8fb6002907..a950736f11b 100644
--- a/drivers/clk/sifive/sifive-prci.c
+++ b/drivers/clk/sifive/sifive-prci.c
@@ -209,7 +209,9 @@ unsigned long sifive_prci_wrpll_round_rate(struct __prci_clock *pc,
 
 	memcpy(&c, &pwd->c, sizeof(c));
 
-	wrpll_configure_for_rate(&c, rate, *parent_rate);
+	r = wrpll_configure_for_rate(&c, rate, *parent_rate);
+	if (r)
+		return r;
 
 	return wrpll_calc_output_rate(&c, *parent_rate);
 }
-- 
2.43.0

