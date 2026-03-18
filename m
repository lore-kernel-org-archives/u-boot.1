Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A57DA10775E7
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 16:52:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3991083FE1;
	Wed, 18 Mar 2026 17:51:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eBojZh07";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4A1783642; Wed, 18 Mar 2026 17:51:02 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C82DC83F00
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 17:51:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-439c6fc2910so20877f8f.0
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 09:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773852660; x=1774457460;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OfNSNU6jwW57ttiPtXo06yXAgK7UaTzFLSMuzmE4JeM=;
 b=eBojZh07XhEdC1tD3Q96xjsgSV/QSWndRl+egEmMWquv/M0FIPVmljgqBU1zzaazkP
 SxTOlOogvPFeVtKCZsinIzDJxLo7rOmycWnPMV4CXl/4NJfS+I6YVJnVURTRLEzs87y5
 arO/J0F2XqZGl0Opw4RbWC4856aCoshApFKye88WNbcKFMIxfRt6hC10HWKDkKSNtx+i
 8or0pTBPTvL/wEeQMe/qiQwtiNVPjzX5mjPyx60hALijEhC273+PlYX2ZB1ZniMvjc9o
 M84BjsYdw9QEmiSnKGHClI2b/RqKWBDdttJpaA/aC6tyyhQj4rJReFhaVr9KIPsVTRcz
 E6Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773852660; x=1774457460;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OfNSNU6jwW57ttiPtXo06yXAgK7UaTzFLSMuzmE4JeM=;
 b=c8xxdwkl9g2HjAJP+88W1VY1VBU38aUi+c/IsLUpllFsxYu9s31qW0hYb5Y0lDsiJI
 G812zV+8nifgGlU8mrM9xWcvyqkdrCE9y71ypdRuIC85Ohh8H+stXUc2BWN8RYrdk+bA
 AbnfIHAKLI2cmh84OmjDw6+TA6ZYOMVMX/klN3Ys2JkE3LFd1mDNn9wdNqLcF8I4IuOK
 fe6M2JkxsM9Wp5nCmokMTfHGxm6oyihkaWz9BAZgDqFATTWwGTskyqpmM+pEfKp6xu1T
 60xihUqNEfSVfTua7UFQZhCBI6qd0vgZgk4wWgtT2vyzOT+oubCBjjCpFPDD9oeqZbP4
 vKyw==
X-Gm-Message-State: AOJu0YzKNW8U80vzOaO0/UjpTPaYuAib7XnxyFWS/o5vE07DvSXX/UJn
 a+FwG25UOdvnjyxpIX249UHJ0RGFvBSluzJOAia6qTR7BqH0x6ltG72Qapl9qNm5dXM=
X-Gm-Gg: ATEYQzyPeY5CAsbQZ/hka47ZzpwxoGAOAhrAoT2/Q/SBqpIbAZ3VviQHTNAIMqsGs15
 +d+o/N/3jsXYtGSRbM/Z3NyucYAJfrZeBYAM9nKULcQLMDVfdcZh43VZiT4P4KsQlvgIMp8o8HT
 5i+/3q94kDPU3j2SKI7wv0NQDAtzxWG9xKyrFnvT1A2J4cEf7Ht1lpsv0S5w7KU3//0h6ERXukm
 XSu122nBkuR9RLldZWDKYrX8luVN8XTM3MJoOkWL2x+V6nAmyMAtxs/nN0GM3+I7nthnJdr8sej
 1skWKE4th5drHnpZpAtaSyiawk5IwANb3/+Yenbo7NlEWNQq5ojqMSLYtVx0jQOK4nfGXc0m5v5
 lTjUZAIQND524NO7NFMwRn7z6XBU7MjeYHMCA5iMa2BhFX8Qy76i5TpEwMxipWeK/gNOAGNJV/m
 0Mt8yK3TBXTxg+gp9EoQQV3JZZaZWtkNX234ymIpc4VqdMuf+WKYHp49aNln8Xrtb1J+iQlN6ZY
 ZPBYhr11tBM4BPvUcvU+j4tTvfkMK65BBCW48fDkAa72pLw17aiM3gsXX+6BvvOAawGHQicg2dg
 cfLbvKgMfyowOUpy2g==
X-Received: by 2002:a05:6000:401e:b0:43b:4d2e:a004 with SMTP id
 ffacd0b85a97d-43b527a3caamr6885095f8f.10.1773852660096; 
 Wed, 18 Mar 2026 09:51:00 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-b535-6f9c-731f-0b89.rev.sfr.net.
 [2a02:842a:d52e:6101:b535:6f9c:731f:b89])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b51892290sm8639527f8f.20.2026.03.18.09.50.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 09:50:59 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 18 Mar 2026 17:51:00 +0100
Subject: [PATCH v2 8/9] drivers: ufs: ufs-mediatek: add MT8195 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260318-mt8195-add-ufs-support-v2-8-f18eeeeb0e72@baylibre.com>
References: <20260318-mt8195-add-ufs-support-v2-0-f18eeeeb0e72@baylibre.com>
In-Reply-To: <20260318-mt8195-add-ufs-support-v2-0-f18eeeeb0e72@baylibre.com>
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Bo-Chen Chen <rex-bc.chen@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.3
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

Add MT8195 compatible string.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/ufs/ufs-mediatek.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ufs/ufs-mediatek.c b/drivers/ufs/ufs-mediatek.c
index c65be5c2df1..252c5fc4318 100644
--- a/drivers/ufs/ufs-mediatek.c
+++ b/drivers/ufs/ufs-mediatek.c
@@ -395,6 +395,8 @@ static int ufs_mtk_probe(struct udevice *dev)
 
 static const struct udevice_id ufs_mtk_ids[] = {
 	{ .compatible = "mediatek,mt6878-ufshci" },
+	{ .compatible = "mediatek,mt8195-ufshci" },
+
 	{},
 };
 

-- 
2.52.0

