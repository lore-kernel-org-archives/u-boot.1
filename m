Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1AA7C282D1
	for <u-boot@archiver.kernel.org>; Sun,  9 Mar 2025 06:31:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E98E1801DE;
	Sun,  9 Mar 2025 07:31:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZL3nnsEz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A2658043C; Sun,  9 Mar 2025 07:31:55 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48E3F80107
 for <u-boot@lists.denx.de>; Sun,  9 Mar 2025 07:31:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-abbd96bef64so515759766b.3
 for <u-boot@lists.denx.de>; Sat, 08 Mar 2025 22:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741501913; x=1742106713; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RccTg7UJlyDlzTuf/rPeRlSiEb/UmdPN47ma/gUixNk=;
 b=ZL3nnsEz1/KEyVvwlPlFn0Bt48oIsncwI/djKQ+HZJ8QQjyqpNXU5cb8nAIGBcSNq8
 40jn/lVGBiTtS16jhCiVvIHSvAZqZH8kPxXFMQGQhVuoWKDNFQTMsaCKaosNYgKZHOYA
 1LgtZMYGtK23omb4fm+h3IFysJp47cGDouQncIZcwt20swrQ3cGpr9DPIiGM93yFoCyO
 0ROKU+2wI1+CJI9dsByoZ8S0MSbOvqgtDIRkMYBxbJPo8+YvtD938v1Kxon8NTeUj6FP
 wOXmv1ui0XF59NlS/dym0qzA6AENqL0+1Zc+CqdNbOms59eNsoxAC4OwpGDJyGBWA/n1
 KA2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741501913; x=1742106713;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RccTg7UJlyDlzTuf/rPeRlSiEb/UmdPN47ma/gUixNk=;
 b=JhY292h7c6HbetpqowarT8+WSXhCtPTBRXI7m0EU6x2WxE459G7W0NKiXpOv1uAavV
 GoW6l3CP2MaTXg01HgtO2kHBNjvjBpH5L1dvoMfS6ytP1hDfMg1fwn6g3M5e3M8Tv06L
 DnWrbq1LTpquf9i1QXuiVp9bbSjQ8okw463i10erR4k7LCv5JgWQ4HXlipR5mX0jpEcG
 kq+rba+ansYRQPtqcw3TpnVaRhT+rKkxsGqsCzmf5f76iSg4Wn0BTJQ2rPM9nL4bC4JO
 Z8NFVQLU9cn8Haj3TN1LKF2tVdhOC80MbHCtdA7lbNApN4FQIMsAq2/jSbktStpnHMdl
 +aQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8tuO6oInH5srf/+gvVEVIUfDx4UGVdI4Kbw6I6HrtDXzYjDf7eA3E8d9A59Dv+p7v4hQokz4=@lists.denx.de
X-Gm-Message-State: AOJu0Yyt7shlJzXyZ7W4JZ8kCuPJsaap1WKP8A1b8sZVFTateWR//6fs
 2gkk/1cmbF+zF6JngcOS99gotS6gu5zUQFYlsdE/6SCi3UumeBL8EjY2jg==
X-Gm-Gg: ASbGncsuoLMPwUB1W3lpQYiii3oQN9dZsw1hC5wGo3p0FcQz4GstsSB8XtDx88hdkfz
 L+03FGyEaMu6ByrOogt4K8USnw5+F3DZJ5ZUhe/W30mt1ekpoaH25ewvtpPn2RbnV+1fdTNAUZz
 ZIGGH2sdfK2qreJSWHTSq2o1+cCGZwRS0cBGGHsiiVJFcI2aRcndKZB9AClFr2PD4oCy0aUE8nv
 FQK201gDUVOTb3EXjhJvuIx864v3Qv0WvTqjQauHoHI7ybTgRLxJTqecn4v8ino07k21NMZOwEu
 AYnkWxjjJYDOmUUURyFH9XJ5Zlo3H2dYKEOq971caL/mrwWV7gK0IVhPYUX50wh7
X-Google-Smtp-Source: AGHT+IFJP+ioWICcQWleXjUCazZRl9S43DXcHVf0azvKLfKrDxoAZUO/9RqcSrXzrIMCa2sJZuCRjw==
X-Received: by 2002:a17:906:cecb:b0:ac2:8118:27e7 with SMTP id
 a640c23a62f3a-ac2811831a3mr354340466b.50.1741501912282; 
 Sat, 08 Mar 2025 22:31:52 -0800 (PST)
Received: from localhost.localdomain ([188.159.248.16])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac239438fd1sm552978766b.18.2025.03.08.22.31.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Mar 2025 22:31:51 -0800 (PST)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: jagan@amarulasolutions.com,
	andre.przywara@arm.com,
	trini@konsulko.com
Cc: macromorgan@hotmail.com, u-boot@lists.denx.de, linux-sunxi@lists.linux.dev,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 0/2] sunxi: h616: fix DRAM size detection
Date: Sun,  9 Mar 2025 07:31:41 +0100
Message-ID: <20250309063143.62859-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.48.1
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

I got multiple reports that DRAM size is occasionally misdetected on H616.
Some analysis revealed that issues are the same as on currently WIP A523
DRAM driver. Namely:
- size check might test outside H616 DRAM memory region
- only one dword pattern is not enough for memory aliasing testing

Following patches solve these two issues.

Best regards,
Jernej

Jernej Skrabec (2):
  sunxi: h616: dram: Rework size detection
  sunxi: H616: dram: Improve address wrapping detection

 arch/arm/mach-sunxi/dram_sun50i_h616.c | 74 +++++++++++++++++++++++---
 1 file changed, 66 insertions(+), 8 deletions(-)

-- 
2.48.1

