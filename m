Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA6CCCC6B1A
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 16:16:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8593480BD6;
	Wed, 14 Oct 2026 16:16:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r_HeWUp1F19T; Wed, 14 Oct 2026 16:16:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C8FF28097B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791994596;
	b=YNpf7h8Q5Z6/6Lx6f60W4HNeQTszQPe7/i+qhFgQ+y4z3uMPeTvf1M5VpNRGXL088hn9
	 j74/OGsqmbW8fzXZbqhJdz/N3kDFVK/PNl/YP+etpTkIHKlG5oAvNjclBNJ3VmFUvAhjN
	 0ti+ynCSdLcP8AHcA8Kga4CthQ3cpmlhBdXgJW0oE710YZTdNXaj55utTA1QcKFxSIgPJ
	 tdfhCpiXA6TniRG94qL3CRl2MYVpGYMCbMzJavJ7+gevaFtdpBgtQxwTqg4nTCNwnbKm4
	 /6ti2YqbXUhAZhRh6jhglyzZZLRpBT+KKiPgrZIFBOO0U9P1J81CQ/2JW8WMs46dldg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791994596;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=unJaJM71hO2aXQBOTYwH3laakFr2QwTTrSXjkwnE1Mk=;
	b=n/Ov5HdkGtxL0V1YBxpg7NUwyjnk3Mviqg+VxqeDTENVbl+X5ejN6v7BfUlwXkv3rgFZ
	 OXVKuErJC6mw3Kjm6lQtqyDb2OFMq/JVhbOIcj44pSylOEMCZo/Q6jDjBIjxHWSLfM9Tn
	 xMGfO3zNSeAMHIfqDjuO5wcWQfVoUnmJdMSL+SS6QgV6xQk/oWM4YEay5aD0h3VR/VNcy
	 byq4sgO1IIsqP3rMRDUC5Pfcwl11KoNaWOgvJgNSwq8o91O/fL/u40fcR16NjafN5chJ3
	 NyuxQhiIRpyhSnHLB39iGsYCKvpEDudDqZ9cZ2JNp1p+7Yb1lW12oVK4g36H33Jy2zQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791994595;
	bh=unJaJM71hO2aXQBOTYwH3laakFr2QwTTrSXjkwnE1Mk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XLWW+SmQXNfk8jLrDQrk0muErat8p8NwXQTdd6ipqNxU0Bf7FdfPPS5OkMDgy845C
	 qbv0wxu/K0UlnIPVKXLMNvV3cUvmnzX8wllih4be1PWgQKDIeh6fbNF+LcQW4Islgu
	 yGhhkoO7dzXvyO0xdGZXYTA99Ku61OndXAKUPGSy+zRMSKOVNmDihXMqe9cx6Ibhbs
	 kPMuNRI243UdG8VvHA7P44ry0hSQmPrOdgo55fRgp79pQZKw3F1G2HmI7nXW0GQk5T
	 ia2bhAhp8ZXqfz8tf2aADYXyxy1vOPORdcNtidx+3qOJld/3IQNcPhwnvMRGxd6YdG
	 JdxYo+RivL5ag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C8FF28097B;
	Wed, 14 Oct 2026 16:16:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 79AB4769
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:16:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6AE39406C3
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:16:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VgV7VvRyjNkX for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 16:16:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 849C6406AE
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791994592;
 b=rBuHDi7CJ7cheWAC9reXcacBQ0cP8vLa7aATUcEvSQJwQCe6BuphRvx1JiOc4QIrHbK9
 DYiQ76yHZdE7jK1cSeuIgY4wQKNc7QVrywkxbfz2Xt7Bv2nszU8eOUPsjCSIGzGgmgpAd
 iaNiM9Yyu3q0UCakyntQCA90An1y60okBq8SgRTt5leHd3Zl4E6RzX+irpO0y5xDdZ/mg
 qaAQAFGmqXp7rradH54lZbImqwzBOBc5blPel7l+e8UlUWrQJXSXJgLXf66DI79f8xLoU
 8xANe9OvPvb4iIZ2nERrPiqYREAfyGl575+9wVq8UYguCNUsgop3bbil9544EwE9ukA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791994592;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=unJaJM71hO2aXQBOTYwH3laakFr2QwTTrSXjkwnE1Mk=;
 b=gkFHv+scMRIrQ1tyUXZLkirUtLhbo01uEUkRxugoa/2lIS9dQmfCN5lsn8AZwcktd/Z6
 xGQRU5biwPAo0zlnV6OyAEVCb2uu4mU0ZQCo3ZwZE8g6My1MDFkFAugL/5YgWTR415Nx7
 Xc8MbEGz5u/X16TM3h5lvxzOIncigfWzdaP25vkpRdo5u4UXhjv2+9W9abVPWJZ6AKQqy
 56O97jEcnbdyNg+pZ5mcTH2n7zVc2Y3utNy93c+sR6m8PhKG9oI92kAbe7F9+A8YyhMXo
 L2LLKV4EJs+6HzIoxJBkEBx7bSSQ2KiUMPcOwRCAP0j+megiHcCpx+s97gPVFBYD/bQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=ouVLG4Ii; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42a; helo=mail-wr1-x42a.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=ouVLG4Ii
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 849C6406AE
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:16:31 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-48b060ec084so2854466f8f.0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 09:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791994590; x=1792599390;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=unJaJM71hO2aXQBOTYwH3laakFr2QwTTrSXjkwnE1Mk=;
 b=ouVLG4IiShaXl9GxLIWgPUC+SO2oYZOr4fbKYr/5xJ7IMJhAwKaF6y3Br57CnrOn5a
 GNLn6wqdVvnEQsGoWcHW+fNVjAfWz3hTVz8OGiian7ZDORqF1Aabf/C9P+WoY67GU5kj
 jeLu8BpAYrBeKrXx31+YrCz7vIEs6RCpv37yG1ZS1vYWF+fl7n4KII88cgGPLYmh2Jcm
 2aF6EEJlgepYgkGzA+/yrQGE9efCrz3uMoXhaP/Vaqtd9AFCM3OrxWQBOoJJLaCSPxIT
 LSvmHFTCTbHrae9pK5uFS7QHe5HgqATf2rhu+/RCRSg/96pmRoCX3kicB/60VTMQ7SFi
 af+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791994590; x=1792599390;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=unJaJM71hO2aXQBOTYwH3laakFr2QwTTrSXjkwnE1Mk=;
 b=UwfM1MZdfoLgZXdlgDYV45NxUbUFTFyVSHml5x+p2NogES0RtCPuucw1cRC2j+u4r/
 gy1MP1CkAr2xWDqFV2ZIFOnrYdh4qam2pSErta0gtdC2bzS8Dp1PknrnGl3sQ9s6Ow91
 KsZ8cDo290FLgNgWe3o3bt2ZzA6EObfNvOu2d9piSoX0fyUzxv3CbSYsJ8BG8tXoUQ0V
 zzV+65AJwrtHOcv5+RN/qPbWxGVNA908NZnzmcXrIug8bNPv9XPXKL31NOJr4WFzRTnY
 fptWfhzEfosHOXnnArDgTxP9ErZ91yLjD1DP1LLHcokmHD8s8CCCIRLJN4gMYiYZCApz
 PPdA==
X-Forwarded-Encrypted: i=1;
 AKwUvBws+IQhEuVohx7PTrw0TGVL5dNzOSk1NNHE2XVwbgCythn6dLY/rsSUm3GWl0VTr2DusbckvAo=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIj5H3jzl5yJlsX6JSm6VB7Fn7aU2oLd958A6nhIiaJI+NY0Apo
 qv5Wzo3SMAE6P+1bmoAQB4FK9JLkUL8W1K+p9wQIoqSkvR2VnZKTzX3+2PC1YbHR2hs=
X-Gm-Gg: AYBFou0Hi5WtnDuI2HB+emjRmqEChPe2ZOpzFnnSU3lB7p1RCg1SJKFurGDjX8vAjfX
 vXYk11uWi0q2rTHvUuDFneILijzq7A+dkVPSvoK8A5ezbnjh7AjmMkJMZOIj2viFCJOEFGtfoSV
 WuB3YM0PT127tsa6keycd8zYXPJ0MEQNVam9sF3A+RlIHoIF6pjwJktazCrZ19qL6ONq9+R3u3V
 1L3Sp9weSE9LWPo8yyKD8M/5LkX0UakZi0QwA/RqLAPZFp4LazoPsQuC0NtDcagaCx5oPMKb1dm
 S2hfgFD+p7YCur+NAUEorcapi55AFwUsw4wZ5Q/GgeAmRxzdMs6BAXNoG/+Dvs8AT6FdmiqJ2sx
 /wqKDil0plLJp0kqy44a0m0WpBg0Rwkn5AYS1om1cymtO0F9P129MOkCi4YnTAh+6b4/f23cMIJ
 TAob4pMe1n73M9mAM3iGx8V5tZB4ZBLQohKpN8z3nCbmui3q4JQFcM9oit9G8nwQRerFAfMvx3A
 bdfsWcuWGnWStmRVZAA/ED9RYjRso4G4qWoXASwuH4E/uNKKfor6YPibpKCrFaG/6pCDnZ6FDOj
 sncYnpeEVVIYT7udCh5JZcBshkjNjv0/rwB6kqzPHGZx9D4v344ycnI=
X-Received: by 2002:a05:600c:4fcb:b0:4a0:1fe2:d4f1 with SMTP id
 5b1f17b1804b1-4a18e4d1686mr312743955e9.28.1791994589893; 
 Wed, 14 Oct 2026 09:16:29 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-8434-7c41-c701-8278-849f-666b-c282.rev.sfr.net.
 [2a02:8434:7c41:c701:8278:849f:666b:c282])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd9934eesm2204315e9.10.2026.10.14.09.16.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 09:16:29 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 14 Oct 2026 18:16:46 +0200
Subject: [PATCH v2 3/3] configs: mt8365: enable the power domain driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-mt8365-add-power-domain-v2-3-dfc3e6eadfd5@baylibre.com>
References: <20261014-mt8365-add-power-domain-v2-0-dfc3e6eadfd5@baylibre.com>
In-Reply-To: <20261014-mt8365-add-power-domain-v2-0-dfc3e6eadfd5@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Irving-ch Lin <irving-ch.lin@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, Carlo Caione <ccaione@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Enable CONFIG_POWER_DOMAIN on the MT8365 EVK so the scpsys power domain
driver is built in for the SoC.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 configs/mt8365_evk_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/mt8365_evk_defconfig b/configs/mt8365_evk_defconfig
index b3dcc5cc5b4..cc01dcf434c 100644
--- a/configs/mt8365_evk_defconfig
+++ b/configs/mt8365_evk_defconfig
@@ -22,6 +22,7 @@ CONFIG_OF_UPSTREAM=y
 CONFIG_CLK=y
 CONFIG_MMC_MTK=y
 CONFIG_PINCTRL=y
+CONFIG_POWER_DOMAIN=y
 CONFIG_DM_PMIC=y
 CONFIG_DM_PMIC_MTK_PWRAP=y
 CONFIG_DM_REGULATOR=y

-- 
2.56.0

