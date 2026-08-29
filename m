Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16793C61DD3
	for <u-boot@archiver.kernel.org>; Sat, 29 Aug 2026 01:50:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F187D80F87;
	Sat, 29 Aug 2026 01:50:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uVWxvaZgA-aF; Sat, 29 Aug 2026 01:50:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787968237;
	bh=PNUAE79CgL0bg0JitWWspForQHO7+2IYjl1M4AqBRyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Lejv1aRpDEmk/+vbsZNe46TAricPqbo1T0VkXYcLNTZaK/dlxqVhtwzwUGkNt0QuG
	 J8VuNYXSFkYgpvLm5t/UYSHBYHbEmYD3CszZSrg+DVZDHK2SwkZMpEvfsAPGb20qib
	 7ILRRhpFGCyFQlSoL4HL5A3eN5qgFj1+JS+/zzBydx2TFTKXuDXWCPO38lk4mOSKXv
	 jrTexjOiqml+TSxbMn0uGTNeWeMtp5oU2mHKT2ErmYdZ6bPVDTNwKrn0RppmC3DzqI
	 PSC+MgotnwRts4Us7SGO4vEuFKl4P/yeAcKnd1GNlHi+x6u60H8u10SAGr/RenAWc3
	 2HcrWvaKythxw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 58E4880F6E;
	Sat, 29 Aug 2026 01:50:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 62740118
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 01:50:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 48CC340845
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 01:50:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0kNKOG43apGY for <u-boot@lists.u-boot-project.org>;
 Sat, 29 Aug 2026 01:50:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32d; helo=mail-ot1-x32d.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=eW4I/QXj
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 92A4D40830
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 01:50:32 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7ee4f241f42so2576238a34.1
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 18:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787968231; x=1788573031;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PNUAE79CgL0bg0JitWWspForQHO7+2IYjl1M4AqBRyI=;
 b=eW4I/QXjToXlGRvhPqwa+TSceUzF1FfUE/ku0j+SvzzImtNGkYO/xu1xFQiE/EmvKJ
 U6ce7/VWeUeauY9FaX12EgxTtTjBGK+pp7XcGtMeiILese7d6l1cA5TQ6eX6YdHRs+v9
 ZSsGUa3QadHKnublSC0Jg5OlGCmnteSPzgtO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787968231; x=1788573031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PNUAE79CgL0bg0JitWWspForQHO7+2IYjl1M4AqBRyI=;
 b=A+ROwfBsd3LRZoL95Y3HCuCb7FbOSW3BUil9T1FwQb/kcfhjqbEK31VnWKnPlCI10d
 T2e99kLZ9rBxTOOHuMujSBNNYKSPwsa8BT1ozHbpillvUvV/MeVLQZnz6uZpa59ZWoxX
 EOmI6LurO80yaGmRTK7zgAlRf96Y8rwrX4IsSnIcZ4m/J28TlVnwV6p2cQm/3/adwR49
 tZuKCMfTs2N9Ww78+JR7Y0YFMa/4zhKgxwDzDPIZbN9ShwpESWrsqmw7FUBZaHcP20VK
 ZTEloMP6sNkoV6jJBtkuiRngss7LMJP4KvQkVlwdc3Y99mXuusUXBJTEuQGdkbcsAZ02
 l/iA==
X-Gm-Message-State: AFuF++mZI/lAWD/3epIPMsR6e6Mvg34GaiBx1IyIjbvwwSbgHkphPD+8
 n4OHB/Q7xaI35ukBMahaSd3Sn6lYYuFjon7IWkrR+0+3q7nsazEURx/V1WtOfX94zUu19v62MbR
 F9e5iE5HKl3l+
X-Gm-Gg: AR+sD11OgRn3fLq/Fi772WoHMFIx0J7EOQPh0/VUcNVRUPS6acfB8thYPG0PLTXtVem
 WGqEFtBWHSQnR3FWvWf3VBbK4nKQx03HlWYfefhSLgicdMmYxsW9qkcEY6HZzacYcyT9AO4Ox8I
 ENvXGoQ4nAUxmHZXjPATv/neJhfLIHyOLes+PNI3t7uRp4RT3DBatHAAfW6Sn0+2M79YDhXleqr
 pLWG4U3aJfRp+J3FbH6MUvK2GEyxAPx+1KgRz15X9i4x6wjVgvRAbWIP4BB8yhy/ze6KnwHIvS7
 BIR9iKR7QwDGyB3ovkqu8dkMMnGzFBvAeRMqR33T6JN0SFYCK4mnrxGo3kYMGge+nO+DSdpFcHB
 +pOvEKiltrZaX02bUoWKv6PL1I0KhRhxdcyFFEkJC8L0zW2HgFJNCD9eMMvhc2wlqTnYOBtpyZu
 v3sBa3d/ULOd3s91Ra2AAIK+w/qLiazHoXzyEJwnNNQWV0WAACs2NuVqYUic/+qnWXc29G3Y9ND
 9Ifnd+t4tEQuXhe7ulNfqSpeSwsYmFpGaw1mcJ/OIa+guIygsCLhnyWXQhmGJ86zIRv5h9/rNUm
 GjLbgiJG/CKzoA5azqSj97bVVmQnn3dZBg==
X-Received: by 2002:a05:6820:4dcc:b0:6b1:7e2b:dc01 with SMTP id
 006d021491bc7-6b1b00bdbd0mr15025411eaf.11.1787968231103; 
 Fri, 28 Aug 2026 18:50:31 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-468a353d45asm3070190fac.7.2026.08.28.18.50.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 18:50:30 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Cc: Michal Simek <michal.simek@amd.com>,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 3/7] MAINTAINERS: rockchip: Use N for rk3576-nanopi-r76s
Date: Fri, 28 Aug 2026 19:50:21 -0600
Message-ID: <20260829015026.473134-4-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260829015026.473134-1-trini@konsulko.com>
References: <20260829015026.473134-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

As part of the initial discussion about ensuring MAINTAINERS files don't
reference files that don't exist, one issue is ensuring that newly
introduced files get the right maintainer. In this case, add an 'N'
entry for rk3576-nanopi-r76s so the maintainer would see any new files.

Signed-off-by: Tom Rini <trini@konsulko.com>
--
Cc: Michal Simek <michal.simek@amd.com>
Cc: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/mach-rockchip/rk3576/MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-rockchip/rk3576/MAINTAINERS b/arch/arm/mach-rockchip/rk3576/MAINTAINERS
index 79cf9e97f70b..baae63fc7b08 100644
--- a/arch/arm/mach-rockchip/rk3576/MAINTAINERS
+++ b/arch/arm/mach-rockchip/rk3576/MAINTAINERS
@@ -13,7 +13,7 @@ F:	configs/nanopi-m5-rk3576_defconfig
 NANOPI-R76S-RK3576
 M:	Jonas Karlman <jonas@kwiboo.se>
 S:	Maintained
-F:	arch/arm/dts/rk3576-nanopi-r76s*
+N:	rk3576-nanopi-r76s
 F:	configs/nanopi-r76s-rk3576_defconfig
 
 OMNI3576-RK3576
-- 
2.43.0

