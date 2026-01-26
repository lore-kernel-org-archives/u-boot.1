Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE337D19503
	for <u-boot@archiver.kernel.org>; Mon, 26 Jan 2026 16:15:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FCC183F15;
	Mon, 26 Jan 2026 17:15:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kwlNNFOn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 258CC83F14; Mon, 26 Jan 2026 17:15:21 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F63D83EF5
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 17:15:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ozndrgt@gmail.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-47ee937ecf2so39986525e9.0
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 08:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769444118; x=1770048918; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s3dep1Bt3gLkBEJ/4Fmb+pPYDzc5yGbvkghoZy0BmyE=;
 b=kwlNNFOnVFlPq7XhA/Ih645NqATMRu2UyDnCrDcnx8yAOwje1Fr7aDu00q6g8YLndI
 0sM7rhohtFbBMAPKXTm8SYbCyng+BCexrWQKcxzbIkxQ4f3ojoqKAaxbLP0MJ4VWZ+m5
 LOiyuCsKFIeAJ164yREweX5oh1/aDNBwyuiuIUrS9f4Lm6TvCxcxbTOKbyWnVyhiBQWD
 CQua/Z1lmDxdMFSa3uRkZgdVwWk0/vRTuq9fGUWSJGh4zuy3L3dy4LSoz9GOa3JKmtmW
 pYK1SP6kp3xrZmI+DeQ+/gpo75rPqV1eeMJhGRS9OesZ9GTHu8kFvE4tSyWrIp5UVxZT
 cy7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769444118; x=1770048918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=s3dep1Bt3gLkBEJ/4Fmb+pPYDzc5yGbvkghoZy0BmyE=;
 b=gZh+4l+QRo2aSMusXQaFtM4ICbNFSQ1RJRhh3vbtoxIFu0wZ2n5MQGQuyIoliVY+YE
 FNjiAg/gF12cEWkANKfkBAiqVlT1ChaOH9ClbRWjkP8+LFH43xUn9xingQnTeo/GWyJ8
 QU1uxF/1pdl3Al7Y16wPF97QDEKaDiNFVHkBmjbHdA7eAr2nx9gRANQ25wfiaMiysCU2
 hOVNvytHuS0tuNfFplr3XFWuCU7hJpeMO+Qj3+yLXeUtij653Vtbw+N3N8rDELeyVu2x
 UDtGA9eW6n1eLQfFWcBWrtV4wJcNpU+Ar98YiMOsnZhvie1Wvt9Z7FRlHzVxKUzlfKOF
 YAVQ==
X-Gm-Message-State: AOJu0YziKKrVBZaG242spVf9agd1Odp5ReYjzoSPVdlI+iyZSF65T7ED
 pHM4EvelP+CxajVcjpjmzjsxXRbGwBVveTFBeJNu0vTNXsyCuzBjdqGI2rywxQ==
X-Gm-Gg: AZuq6aJd08d4zfbcsEBkwV0syuroL4ZtUx5A4r6QX5XhBpPS0I7kBjt59Q+aO7pS89l
 8hTxJKwpkeQ5zrNVErN0IZ6bFVism86huRygFy6YaXzReDjuIDW4QyyuUK71lHYBbDzP8iBDAMY
 AJ4UBR8aayezWv0Fjo0Ow4gmnlWrNylG1sgQYjU5yDDe5DjStnlv6F/5hL8T8rMRt/A+edNyGfP
 WfKoMTHtaP2LJx5CUb4qsNaf92gP2Q0X+Ls+xMVym3VMcNGH5ICK28p04GgRSSr8JB2mjnDre8C
 5RQ4ojo7GtvjQBH+E3mRw48nN2K67LqyH87uIKL6ku6z5kFGwVRh5A5Wu2RzbpT1Peo1qkr1j+N
 2gF218Q+xPwAy8Nix41qjG7nPtYUDlFv0KXJl4AsuYGAAt+BUH/JLMjDT9Er0s7DKWzYVa4Q/gi
 pmpajCdGuIyeV6PS8PJaznBYQzAE1qPVMDWg==
X-Received: by 2002:a05:600c:698d:b0:47e:e2b8:66e6 with SMTP id
 5b1f17b1804b1-4805ce4fba0mr81108035e9.14.1769444118128; 
 Mon, 26 Jan 2026 08:15:18 -0800 (PST)
Received: from odurgut-Precision-5570..
 ([2a00:20:c361:3985:cfa:b5c2:f360:f511])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4804d5ffe12sm107368615e9.3.2026.01.26.08.15.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 08:15:17 -0800 (PST)
From: ozndrgt@gmail.com
To: u-boot@lists.denx.de
Cc: linux@analog.com, malysagreg@gmail.com,
 Ozan Durgut <ozan.durgut@analog.com>
Subject: [PATCH 5/5] arm: dts: sc598: update EZLITE to latest revision
Date: Mon, 26 Jan 2026 17:15:05 +0100
Message-ID: <ab70d86d5ecad1c7c696b3ac3dcab3770fb973a0.1769439596.git.ozan.durgut@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1769439596.git.ozan.durgut@analog.com>
References: <cover.1769439596.git.ozan.durgut@analog.com>
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

From: Ozan Durgut <ozan.durgut@analog.com>

Update the SC598 SOM EZLITE device tree to use the latest revision of
the System on Module (Rev E).

Signed-off-by: Ozan Durgut <ozan.durgut@analog.com>
---
 arch/arm/dts/sc598-som-ezlite.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/sc598-som-ezlite.dts b/arch/arm/dts/sc598-som-ezlite.dts
index 179c291f34b..40cabd1db0d 100644
--- a/arch/arm/dts/sc598-som-ezlite.dts
+++ b/arch/arm/dts/sc598-som-ezlite.dts
@@ -5,7 +5,7 @@
 
 /dts-v1/;
 
-#include "sc598-som-revD.dtsi"
+#include "sc598-som-revE.dtsi"
 
 / {
 	model = "ADI SC598-SOM-EZLITE";
-- 
2.43.0

