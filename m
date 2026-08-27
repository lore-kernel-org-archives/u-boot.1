Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D48C61DC2
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 12:36:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8E650607A2;
	Thu, 27 Aug 2026 12:36:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U-nTle0PA271; Thu, 27 Aug 2026 12:36:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787834211;
	bh=NKQyEFmR9L1R32ieREg7ncXSriagGEaJsKR1pf+01aw=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ikEdTF4GDsMsH0aGiC+E/E3FV3yGuWmUWn2fElkX5UYilWNJ77bRx62yaSU5SbA4y
	 bI6taYokuidbYo2tgSVr7WeiR3oeESDAApnxfVrHlf/v2E1qXBUdbfonrzBGFu89rt
	 YPR3n0xZOndPKv3BJwW8CuCX82ufswC58l8bgyxFN2geUiKuJTMRTfHMnR7YNSSJqc
	 iBvUW0UYRRN6Rtac+R68cpsy38LlDkXNjLdT9Q8WYuKJaA/IYnIYZxoA0pwZ2Bypyv
	 1EMOiojPDP+VouLPmjqofNSRUPmhx3rLaTogElWRya3U7xg9VKqhoj1xcNrAaoXHoB
	 QalZYIpVG6ltw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 717BD6070B;
	Thu, 27 Aug 2026 12:36:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4F3AD1DB1
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 12:36:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 352EC80D66
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 12:36:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id prOOLVQUm_k6 for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 12:36:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=aQ+WcNK+
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2DC6980D05
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 12:36:48 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4953e04ef16so20326315e9.2
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 05:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787834207; x=1788439007;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NKQyEFmR9L1R32ieREg7ncXSriagGEaJsKR1pf+01aw=;
 b=aQ+WcNK+nbWOcPqlBCV2RL33P19rHP0syL92R6+wkhdQTdqg9pCRvPFKSm+mx00sMX
 yIrFnyz1d6d3rezlf/YlPT0jNushXHHjAaOwetSQzJlaG+9Mt4ze0Z4t48QvT7mCERaM
 uBTfMxurVYUxK4phKKS9J/zmjTMK+wM+8oeXeLkeOPWjgcHX+VTe1SfqXPsKkz3l45up
 Z9rzU8KdVwn6fQqVmEEVbpqWCgGWvxS85BT/1x10cgXESstoKT80j2Jj7jtXx5QBANbV
 +21qXN3TQcg5vIO54nO3TzMoPx6SP39yx82I3YB8OSDPHXroQ7Dw2mmO72yQK7sMoXCF
 p06A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787834207; x=1788439007;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=NKQyEFmR9L1R32ieREg7ncXSriagGEaJsKR1pf+01aw=;
 b=GcNcRtb9Da8MrfQBBH9+bm9MLQf1oqKS8WDFA60Av1zl2OGb/e9uOU5R3fsYuqGQKo
 M9ktKe7PIPu/2annuB1bdZFt+dPOnl/HJU2uviKlHtyKZEKsgp7jfIG8aieDFC2YQ5wO
 GIOU8OWg/OcvbPRJynbqgbXUg+ndkpSf3nayzD5Y4PEEVZFUuxFXbE3jkcwCW3UzmjxJ
 KrSdkU2p/yKJnRSxuV4LdQqdRyHVi8mbrodey7oE7jxHgCFsqSMGBwSsgEwg1/gTfVN1
 0anutt6ycvVRXwfnNNn+DQbZDqee673su6gyubolm/zvbyx92FTv0Y04DG85kZbntsat
 65Vg==
X-Gm-Message-State: AFuF++n1aXpWOf+DQ7Pc8YUr6r02yFG5TweLB2f1qOLA+DS4Ef1uIh1O
 u+ol7GSxJGD9T7VNQwhp4bIBx9gVJRmbOGxNDjQZWIkkTmHDllIKQ+Bn77R7CYXF+Y+T+np1kcB
 NRBEc
X-Gm-Gg: AR+sD13ISAsfd5C4YHA8dy5XRWDhrEO2EWxtF7FwCkg46fuk3QyXmSjF28sMKwaBAIZ
 GMY31ZF/erG6vsmRBhqzFivOGqKf1JZn6nY2tV2K9xGWJfhB7BazhkAzVsUXK5L8ggnuKoS3dgj
 89ei19rdsVzA5pIZ7IkcLDScFuAPZSaYYZWIcQOWncvITy4Y1+Zl5uMyuIGE3azFpyJ32Bmw27+
 Ec4yAH1s8tKj9cSjCRf3gYgJ9b3amb2yk3bSY5bA4OW8smypKmYzDEHjHOFznfv2u5mao2BkDej
 5ZIaeYf8ndVhv7/lv/5TfF1CiC9zZRNNnYSaDmJ7VAD1dccPyHtnvP5z5t3dsclV5fr2b6nqree
 pmQuEdwk4fZA0dLBmm5M7c0rkfrgtJhHKwswD966ELUluQ9dLRoOA3o5qTvzbQrS4g166eIvP31
 EYqO4T8ZMiK+PZmIXU3aC8RnfZsbx8i+Gurjn1EOe7jWlYZ5vjiQjZ7bAnog==
X-Received: by 2002:a05:600c:6096:b0:499:84fe:ca8c with SMTP id
 5b1f17b1804b1-499dc6fcd31mr205534635e9.5.1787834207104; 
 Thu, 27 Aug 2026 05:36:47 -0700 (PDT)
Received: from localhost ([2001:4090:a244:80d4:4373:6c2f:4372:b8ac])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b4c321184sm62417595e9.11.2026.08.27.05.36.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 05:36:46 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Thu, 27 Aug 2026 14:36:29 +0200
Subject: [PATCH] clk: clk-uclass: Ignore -ENOSYS in clk_set_default_rates()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-v2026-10-next-topic-am45-ofupstream-clk-default-rates-enosys-v1-1-ce3b87667c09@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAEwvkGoC/yXNQQ6CMBBA0auQWTtJQVHwKsZFaQetQks6U4Ih3
 N2iu/9WfwWm6IjhWqwQaXbsgs8oDwWYp/YPQmezoVLVWTXVBee9sFToaRGUMDmDejzVGPo0sUT
 SI5rhjZZ6nQbBqIUYyQf+MJbHurXUtbZRHeTFFKl3y29/u//NqXuRkf0J2/YF6eSgW6AAAAA=
X-Change-ID: 20260827-v2026-10-next-topic-am45-ofupstream-clk-default-rates-enosys-1359deb9d80b
To: u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1354; i=msp@baylibre.com;
 h=from:subject:message-id; bh=86T4eTEVJBpKmB4du5hNty69PaA5Dc/IMeLtnSzk7Fo=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqwJ+sGrHm6YGnI3sutz7+MNwetUlZ6ohx598ODT8k2vT
 ebw6GRv6ihlYRDjYpAVU2TpTAxN+y+/81jyomWbYeawMoEMYeDiFICJ9J9nZFhWzbRy0XTD+5Lz
 xQx7Hz6eEFogG2Y473yGa8/aswxXJFwZGY5XP315639Y9wptE8PvfWEfZr48YZVm36t5ZL5lYml
 0HAsA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
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

clk_set_default_parents() already ignores -ENOSYS from clk_set_parent().
Do the same for clk_set_default_rates() and rely on the earlier setup
clock rates.

On am437x the cpsw switch has assigned-clock-rates for the RGMII clock.
The divider delegates to a multiplier of the DPLL that has no set_rate
and no delegation, so it returns -ENOSYS.

Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 drivers/clk/clk-uclass.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
index c33f415917e9..0069ce9a8875 100644
--- a/drivers/clk/clk-uclass.c
+++ b/drivers/clk/clk-uclass.c
@@ -359,6 +359,15 @@ static int clk_set_default_rates(struct udevice *dev,
 
 		ret = clk_set_rate(c, rates[index]);
 
+		/*
+		 * Not all drivers/clocks support setting the rate (as of now).
+		 * Ignore that and keep the rate set by an earlier boot stage.
+		 */
+		if (ret == -ENOSYS) {
+			ret = 0;
+			continue;
+		}
+
 		if (IS_ERR_VALUE(ret)) {
 			dev_warn(dev,
 				 "failed to set rate on clock index %d (%ld) (error = %d)\n",

---
base-commit: d3e8597e46b635ec556a057bc42f0b0859654bdf
change-id: 20260827-v2026-10-next-topic-am45-ofupstream-clk-default-rates-enosys-1359deb9d80b

Best regards,
--  
Markus Schneider-Pargmann (TI) <msp@baylibre.com>

