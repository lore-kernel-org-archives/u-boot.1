Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D368CCD4851
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 14:44:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAC9483CD3;
	Tue, 12 May 2026 16:44:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kIwn0K3J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B16C803C6; Tue, 12 May 2026 16:44:56 +0200 (CEST)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF00E83CD3
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 16:44:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nathbappai@gmail.com
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-836ed29d1e5so2457049b3a.2
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 07:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778597092; x=1779201892; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fSJARmp9VAchLf7cc6H+v6yXtgViTbgd29HVZ84bkOI=;
 b=kIwn0K3JGoqyHsXu1+o6T+uhscHsKYdZp8IHHhyDBKRTzNccMTVFfwMtgF3hB6xaHx
 ZaBFGxXqo6SQ8Ve6TsKzqWPjINBROgc1tJa0lnrVO+eq2OzHB7ib9Kg6CF2jRB++l3L+
 9PI+c4uetEZOkxz7mi31926O4x9HxCvaGEMIgEwkAobLJXmCU8zw6PxvROJaLXOHdg08
 wa09U6jLRrF2hW59rO9SSo1tBT4k1QxT82vZ/ksCo4vkH3GGbnXvSYtbIH1dSMm3Fa8t
 730vkbOm8TRAYEJZ8I8CwcJlijcEft0VZT9ZPL3S6J7Vr1YJUkV3MgB4897wyZpk269v
 fYSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778597092; x=1779201892;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fSJARmp9VAchLf7cc6H+v6yXtgViTbgd29HVZ84bkOI=;
 b=YAjncqEkgm8FkKrDdSci7z6zdRxh54ZFoVWEvhrx1hEEJnbVHzT2xxP+h4rB+5yon8
 KrOtAZGM24bVmmHihWkWGx0gSUwXWQ4mM94A1Mszgh0PKWfbEYxoREkpwpPjemGJxUzh
 iw1uliDOldm22iTUqh2AXHtsEWr4VRD4341/TT0WFoIKIDcGhejJNuE+MMcz3PneNmGs
 z6WyJu1H6ijLLlBwyGtK4Jd8i6bjdjKcuCaxcyibbyEvGuRf2mcYMsCRpcLU7+wjwu2m
 LGbLvmNJVlS00CCU+ryvg1rze2kpcgHTr+OGpeH/UkWJzvqdt/MZAJa/IbitrryFz6SC
 71Yw==
X-Forwarded-Encrypted: i=1;
 AFNElJ97SI0S4MQGCIE+2s/FVL+n+FGgM+955nKkw05RMYpgRwjyI/x8eeI6D0kXfRHKwM5o+FvvCZU=@lists.denx.de
X-Gm-Message-State: AOJu0YyCH8SvyNgNHWQcACj0Z83ayVKwbOohSwIBK7EIYDr1490bWHh2
 inUU9g0MOvmX+InbIYbwKTIGEIiv9GMZJqxRdL2piOu20QBuDHl7oCF2
X-Gm-Gg: Acq92OFCJko8hSme/AespnB7Sk9cPtDNX6qmiydAdh4/KF1XZKbypd1o9cKOf1ZxYXn
 hQFo8xbtbqRv/1gEypxeE6ZVatAOXb7iGlPamwHp6OaG6tbstGWRqUsU7gf+0T6b+E6ZOYY0trQ
 0Rt4Jh3Ee6oSU/s7d/fq8BnpZyF5p6lewRmpXdcNoznB86Hi4NJiFVuxSzI3078cbt+1QPwpD8G
 /3JeCh9p3FUYZoq192U0UqCtO2alwY5pMuZ93+FXyGHLcFNGov/6jBix+kB4rK2llN4qvmAQ6rY
 r8wDC90XhM2NJI7w/XgI7jwaS/5gD3T3QVNOEfFoYUHH7/v4GbM1WQQh31NIrDzR+A8gXWcGvMu
 ECH5mARYDRHyDGyU+UV0iD1gKQDGJJy2EeeZ0WCUUxnehrRD6hhrHWgu9JT4FJ2xa0RQecIBu5g
 egc4cFX95pLS6iUhWM2v1SKSd3gEbb
X-Received: by 2002:a05:6a00:ad8a:b0:82a:17b8:1474 with SMTP id
 d2e1a72fcca58-83eeb9f0e34mr3814849b3a.1.1778597092395; 
 Tue, 12 May 2026 07:44:52 -0700 (PDT)
Received: from [192.168.0.102] ([43.251.89.154])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-8396594645csm24703145b3a.14.2026.05.12.07.44.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 07:44:52 -0700 (PDT)
From: Biswapriyo Nath <nathbappai@gmail.com>
Date: Tue, 12 May 2026 14:44:39 +0000
Subject: [PATCH 1/3] phy: qcom: Add SM6115 and SM6125 to QMP UFS PHY driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-ufs-sm61x5-v1-1-c022cf988e89@gmail.com>
References: <20260512-ufs-sm61x5-v1-0-c022cf988e89@gmail.com>
In-Reply-To: <20260512-ufs-sm61x5-v1-0-c022cf988e89@gmail.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de, Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Danila Tikhonov <danila@jiaxyga.com>, Lukasz Majewski <lukma@denx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Biswapriyo Nath <nathbappai@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778597082; l=1181;
 i=nathbappai@gmail.com; s=20260118; h=from:subject:message-id;
 bh=VsAl51+8L+9uOub83dF4ViQvej2763KWvuPznnYuR58=;
 b=jHNErAbNUzIOnIqM2q3sBy88+AAEyu+ojh17m0WAewrT+jf91nEIG7F3g4VnNmn1+lNCeHjzu
 LVk6pxDClCdB/BkE0IViiMTjBuWqi0F4yZrsCyVn3z9fhEoNe3vcbxX
X-Developer-Key: i=nathbappai@gmail.com; a=ed25519;
 pk=slmb/9yXbet+KTiT3EYLCp0p0MEOYa3EdjUXP+HXfjg=
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

The UFS on SM6125 can reuse SM6115 configuration, just like Linux.

Signed-off-by: Biswapriyo Nath <nathbappai@gmail.com>
---
 drivers/phy/qcom/phy-qcom-qmp-ufs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/phy/qcom/phy-qcom-qmp-ufs.c b/drivers/phy/qcom/phy-qcom-qmp-ufs.c
index 80eba734a633..3df88189a907 100644
--- a/drivers/phy/qcom/phy-qcom-qmp-ufs.c
+++ b/drivers/phy/qcom/phy-qcom-qmp-ufs.c
@@ -1741,6 +1741,8 @@ static const struct udevice_id qmp_ufs_ids[] = {
 	{ .compatible = "qcom,milos-qmp-ufs-phy", .data = (ulong)&milos_ufsphy_cfg, },
 	{ .compatible = "qcom,sa8775p-qmp-ufs-phy", .data = (ulong)&sa8775p_ufsphy_cfg, },
 	{ .compatible = "qcom,sdm845-qmp-ufs-phy", .data = (ulong)&sdm845_ufsphy_cfg },
+	{ .compatible = "qcom,sm6115-qmp-ufs-phy", .data = (ulong)&sm6115_ufsphy_cfg, },
+	{ .compatible = "qcom,sm6125-qmp-ufs-phy", .data = (ulong)&sm6115_ufsphy_cfg, },
 	{ .compatible = "qcom,sm6350-qmp-ufs-phy", .data = (ulong)&sdm845_ufsphy_cfg },
 	{ .compatible = "qcom,sm7150-qmp-ufs-phy", .data = (ulong)&sm7150_ufsphy_cfg },
 	{ .compatible = "qcom,sm8150-qmp-ufs-phy", .data = (ulong)&sm8150_ufsphy_cfg },

-- 
2.54.0

