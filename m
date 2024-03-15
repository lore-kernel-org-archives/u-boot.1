Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEFF2C54E58
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 15:10:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EAC78801A;
	Fri, 15 Mar 2024 16:10:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YCwMPg1I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DAEA8801A; Fri, 15 Mar 2024 16:10:35 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FE3A87FF1
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 16:10:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-513d23be0b6so2081479e87.0
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 08:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710515430; x=1711120230; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FqBLktASesX4FD9xMZHc+cynW/CmSAI3p7Tkt8KuoKQ=;
 b=YCwMPg1IpOLO+n6OX4hwsfv4QxUy2eZvH144YHnQHH4bBVIAL/e4KNa3onPiyjJO3B
 YdLjJYCsaAGsyaU5qZXOWrIbCWVuPXOV+uFT/JeijhCGjAiuC/uoKetGf94ua/XOQleu
 WvtgKKZNtYsVyTyPzP0R7+Y49BwBtc+whlDw0yZFvfrfSkiKrr+j/bj7ZqWF7cJmdasm
 fX4/cCi5lPBossfrSTHpgYY5JtfYWAMx4BeizNfikjv9ANjclwZ3WTUynQ6wPICFCIig
 TCMmJ+P1YQludvUwHvS4qhVEKWnGp8Y4OqOSKinCudZXAOhRKekCHVs6Rs7+Z9SxRHJa
 EKtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710515430; x=1711120230;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FqBLktASesX4FD9xMZHc+cynW/CmSAI3p7Tkt8KuoKQ=;
 b=O3naHIdCtjXXLMWj5XIE+FOj205o/cYe1xmj7WWy3po7bMlZx1bBy+4peNIuUQH/0W
 EqON0B5X4Kky4huTvs8yLAuJ4SNR9LjEdannNL0xtAVD+Gkx0mtzUpwMuKN+EfJQECL+
 B8MoamyhBQctZECI6YSWtRNfLfK7ZlbCniow6pjmQEINO4wVP4V2nztUCRt1s5PVkNyQ
 l9QHI3PXGFexiUbhI0gFUBCvMkGMBQkmPnJ2BzxuTRVvzRrKgfyey6VWko/zlT5LvzPx
 zis6c62yrIqzcckdzHhrFZNZ/f2iXn9X7QpGeuCM7jS/Kx1Lmxjs1mhADekwjTczs8V4
 n1Nw==
X-Gm-Message-State: AOJu0Yz9i26Hh9uZijSEhga5OO8Znc0pRG2bFZXBE4MateA0Ukgvw1mz
 wdevuQM3KTdF6f23Si5VgDi0ERDf0VizqWOLIY2gbmKyBy49/id3S+KMq1BMV2nUhAswO1tQU6O
 U
X-Google-Smtp-Source: AGHT+IEJ7/YbM/6mIQrgP/FF35nhJ41KGYOqKy+3sWtbzRE/uUiWY+xzMycRbGoUcq/MGJB5WCQ5aQ==
X-Received: by 2002:a05:6512:54e:b0:513:c17b:1426 with SMTP id
 h14-20020a056512054e00b00513c17b1426mr3437849lfl.11.1710515430023; 
 Fri, 15 Mar 2024 08:10:30 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 n6-20020a5d4006000000b0033e699fc6b4sm3398141wrp.69.2024.03.15.08.10.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 08:10:29 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 15 Mar 2024 15:10:10 +0000
Subject: [PATCH v2 01/14] mailmap: update Bhupesh's email address
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240315-b4-qcom-livetree-v2-1-ab635774b2dc@linaro.org>
References: <20240315-b4-qcom-livetree-v2-0-ab635774b2dc@linaro.org>
In-Reply-To: <20240315-b4-qcom-livetree-v2-0-ab635774b2dc@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Bhupesh Sharma <bhupesh.linux@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1108;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=Gph7f+aNqWx3oubVdCe0jYXNtcC+/SvMrfdaVbbbDAE=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtQvKY8cH5TuLpR8fCVexpOxR3DC44vn3rWaX5/794msy
 a8ifzXWjlIWBkEOBlkxRRbxE8ssm9ZettfYvuACzBxWJpAhDFycAjCRmUYM/5Tnh3c6uc28pcwm
 vGtTi7UN0wGPdQ5crfb3Vh72mD9RyIjhf+IZ5x/tatYnthaf8WIu3iEpJ3SCRzRIh/3GurURT4X
 3ewEA
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Update Bhupesh's email to his new one.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---

Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index d1f08f3eca8a..f6e0847b2168 100644
--- a/.mailmap
+++ b/.mailmap
@@ -29,8 +29,9 @@ Ashok Reddy Soma <ashok.reddy.soma@amd.com> <ashok.reddy.soma@xilinx.com>
 Atish Patra <atishp@atishpatra.org> <atish.patra@wdc.com>
 Bharat Kumar Gogada <bharat.kumar.gogada@amd.com> <bharat.kumar.gogada@xilinx.com>
 Bharat Kumar Gogada <bharat.kumar.gogada@amd.com> <bharatku@xilinx.com>
 Bhargava Sreekantappa Gayathri <bhargava.sreekantappa-gayathri@amd.com> <bhargava.sreekantappa-gayathri@xilinx.com>
+Bhupesh Sharma <bhupesh.linux@gmail.com> <bhupesh.sharma@linaro.org>
 Bin Meng <bmeng.cn@gmail.com> <bin.meng@windriver.com>
 Boris Brezillon <bbrezillon@kernel.org> <boris.brezillon@bootlin.com>
 Boris Brezillon <bbrezillon@kernel.org> <boris.brezillon@free-electrons.com>
 Christian Kohn <chris.kohn@amd.com> <christian.kohn@xilinx.com>

-- 
2.44.0

