Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43CE7E7E0D0
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 18:17:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC79F83C5E;
	Mon,  9 Feb 2026 19:17:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GISzeTHP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAC6383C67; Mon,  9 Feb 2026 19:17:14 +0100 (CET)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDA3D8388D
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 19:17:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-386714da2a2so25155891fa.1
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 10:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770661032; x=1771265832; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f9aJl0pEe16FtdJkRZ/++lvjcScEZbljK4Ehv0HyWLU=;
 b=GISzeTHPpNWQ0yei7VGrCYBeGJDgnZp6SlLfXa+lCs8n107zWyvBXY1HOmjtO1VVH5
 zlUPahO7hcey7vG8SuanJeK96W4+xT9LKDTQ6ZpluXd5Bj4eDNY+q0N0QzN37S6J5p2J
 vT8eMUIvTA6AdoDX+oUjvN57Dw441wKdVvt/VdiOO+fJ6gFRXpMZJ+ZFyVW2DfSyi6RM
 O5zHG8+aDQKUXuOUJUNUcF+Vk/RDgkVQyFgbUIMBWWs8qlrUpzd16v+Dk8yEHKhG8kzK
 yQl/Z393JlzkdFA2nDItAAZ4vH7FVbRU4UdwQssdq6TnWBSVsCC/Wkapspn/EBImb9ge
 thgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770661032; x=1771265832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=f9aJl0pEe16FtdJkRZ/++lvjcScEZbljK4Ehv0HyWLU=;
 b=lHSDlJjWaTPDLsgP3nwIdr1CVOQAjqtKSJcW3w/KzvSeAuMt0u33KicnC8+OWF25JX
 69yiSjmd33VQZ37B5iYKQN/dyxgp20k6oj6H6vb84N+BzCTE77ENOFYcy4gIQjKSC2mI
 VDdEvOwzX0DDWYLa6npNu8vZ3Nj0bJUo2SJpfDW2S2pGq1H0KWFgkZrW1lpL2ME6W0lD
 7PorgqhEd4uehKr/pX5qE+njGgknEhCRm2tPNkHcqPgrrUjWN0ndXpWCvOo9lyeeDIIY
 VsfV+WmTbLeG2LgiUz7Jxwb4OQjSTYfKFlqrMZnZrFqT4prpgoAcRqSFPaHWmdBKYCUY
 mzyw==
X-Gm-Message-State: AOJu0YwyJn7ujHCe7T/yDfuV/nOn6J3fMp/TgVqxoeNTvAFdXWKGBud0
 uOA7PeF+yAp6l/uhAxI/YRi1MefqTRLvtGeuTlVShQNGtKZscq8l2kITP/WPhw==
X-Gm-Gg: AZuq6aI0oviBjQ0VWxPm0tMRV5uaFZ3zBvOgvafLVJgmMjha44qlR0+IA8LcVzpRW+0
 ruI+p2BIdT8t+bnKYirscPkT+tIjsLK6pq8Faj6DF7u+MQiks9VM2GakNLrRGTYIPe8BCJcSucE
 AB4CGFn9KriGZg5WrIxDN9m7cwT6nCKjY63I7p4JwzwTMkhajfVtTZODNYHQxNicP50TqKXrIY0
 iFBSP/9MT2dP2LjKfCDUdPabeGb70PDhvKAv91B+l3b/VOx8QL+Zl17LrRh4McfcL6+zTmbewjZ
 AKG+DHOPWv5jX/ztHzpjt1RAyNAVsgQcOfPoAjscSh0x9oCVLbKGtB4R4dpsOEXQwDCI4UO9TPJ
 RfnmR4dvj+icN5wd3Z4JGfLzPKYNAK0hMvzCQUEyatYLoQaD4qHd4sMvsJ+AUe/lzRoCym9znUe
 40
X-Received: by 2002:a2e:b8c2:0:b0:37f:d484:599c with SMTP id
 38308e7fff4ca-386b50f9a9cmr46851001fa.28.1770661031889; 
 Mon, 09 Feb 2026 10:17:11 -0800 (PST)
Received: from xeon ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-386b624d4afsm27446681fa.17.2026.02.09.10.17.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 10:17:11 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini <trini@konsulko.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 1/2] video: r61307: adjust property name
Date: Mon,  9 Feb 2026 20:17:01 +0200
Message-ID: <20260209181702.33190-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209181702.33190-1-clamor95@gmail.com>
References: <20260209181702.33190-1-clamor95@gmail.com>
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

Rename renesas,inversion to renesas,column-inversion according to latest
schema.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/renesas-r61307.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/renesas-r61307.c b/drivers/video/renesas-r61307.c
index ef6fab1e953..b643fd1db89 100644
--- a/drivers/video/renesas-r61307.c
+++ b/drivers/video/renesas-r61307.c
@@ -228,7 +228,7 @@ static int renesas_r61307_of_to_plat(struct udevice *dev)
 	}
 
 	priv->dig_cont_adj = dev_read_bool(dev, "renesas,contrast");
-	priv->inversion = dev_read_bool(dev, "renesas,inversion");
+	priv->inversion = dev_read_bool(dev, "renesas,column-inversion");
 	priv->gamma = dev_read_u32_default(dev, "renesas,gamma", 0);
 
 	return 0;
-- 
2.51.0

