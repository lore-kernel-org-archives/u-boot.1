Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B94C5DF66
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 13:10:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A486B60AE7;
	Thu, 13 Aug 2026 13:10:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id splsMxaRA-_b; Thu, 13 Aug 2026 13:10:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0C8346090A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786626638;
	bh=Yi7m8JiToLA6gKHo5Wffyg6qwXpOlXkEk6qkgrSY3xk=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=W8K9QVvWo0r9MdYJMQDK1iw3brNWSdxgpRc220o5z5zCzvAo2izNAbdchr8Ce4yc8
	 q6VPfc3ivMwcoqTUBtMpHf5hULiPdV17bEWjkUuYJxC6urSJ5mQONMa7+KhgZSc92D
	 M5TzMQRTriEDHXQnIPWGUusWJjwbYE4pmF/6T+u+AmtNqZejOIHssXB50nYV2LYEyR
	 qbRcfaAIp7EV85oSuy6j/5Mb9Q9rFMU87vXV2yagmm6HQ5RtSpSLwkRQsm7LEIMdFX
	 RuxcvHs46wfKxfjxLOiRqHKvxht3vIcMsaS1aOBzZ5gYocEYpFjZo/z1gdRVTslILV
	 LHoqCEO23YEcQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0C8346090A;
	Thu, 13 Aug 2026 13:10:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6B2F7198
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 13:10:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 51FF5403D2
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 13:10:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UwhEx6-p8440 for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 13:10:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2a; helo=mail-oo1-xc2a.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 9A9BC400AC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9A9BC400AC
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9A9BC400AC
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 13:10:34 +0000 (UTC)
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-6ac83a09781so656485eaf.1
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 06:10:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786626633; x=1787231433;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Yi7m8JiToLA6gKHo5Wffyg6qwXpOlXkEk6qkgrSY3xk=;
 b=TKaaVJ4VncxbHw2Adl9hbDcwLs5sDNYdtDhOWF9/yrXeOtNTCVTZ9Uzmeio8hd68yY
 fhRm3whrYvY6kgKEd6jWua9NTozsbo6ENVch1NNBEfsIS76nnKfpFx+3Wz6qnCALuSS8
 lV8V2ZoypC97cktWZYb+C3CjvU3tL4Tlye87GzIsOGwolqSu37BX30DCMttJEHHtpVZS
 NpKEeppZypcsORZEy9AB6+FA0P4cThWk38JDmXYN8w/N+7cHssyr8YMq8ICVHkHI47aP
 OWhdq/dQZ+UTeINzKb4vLUtbddUJSYs9t7BCJHEe1ufQYmu+0FPW+c3sKWUVVROzx6Vj
 mocA==
X-Gm-Message-State: AOJu0Yx/c0iVDKZ2hI5GFb3pEAMpINHSK9WDxAqd5y6FUtnD5UtzpM2g
 IYCKoYNewcr9eEyQ1quwqGl5FO9KimiNW7l6aT05cRQegN/L64gK6X0cKWGbxNgj0To=
X-Gm-Gg: AR+sD12R+Cbf2eQ5c1zyvdCRcG4yiM+ZM05tOJfUxq0QImipcjw42HHwwqgK01uusv3
 +i870uPbshu+sW7w4VOnhFzVKWQQ1atZcfeGYd4xR48NQoOUCJOgyRwUz55qXjc8MjYKV34af6R
 lkdFU5k8eapkRi9UyP6YDoiHP1XB9wr/Woy+VKt9MTtsQMsJel5TltQmP31EnTnL4Jv9dT3vAcU
 DYNrqHW7DUb5XUOCU750qo9kQiAcyvRqJFd5zzIqj20ArIK4HppQ3RExh9jJyjr/L0qbR44QQX4
 a3XjV/44/ULrC/1qbillINQghkWnrPqzLh4BWcJfiROh+RuGlHJeHcN8d2JKB5EArwVlAmj/FlD
 5YrVDn9898tYa5/lDtOJ+5cm3KFS2W617mWd4RqeV1tF/BiE0w629GQu70LvY9q8hw1Ne92YiaR
 l+ttUBn8klNWpxfaIBUbXouNVTqKiP6ypU9tqqLi6mPY0uYqUgqab+ezmjfPScyqfu
X-Received: by 2002:a4a:ee04:0:b0:6b0:b3df:5eb8 with SMTP id
 006d021491bc7-6b0c5c88371mr4053874eaf.18.1786626633289; 
 Thu, 13 Aug 2026 06:10:33 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:3678:ac91:e955:c25])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-45e64f8f077sm1538470fac.6.2026.08.13.06.10.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 06:10:32 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 13 Aug 2026 08:10:24 -0500
Subject: [PATCH] clk: mediatek: fix reprobe regression
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-mtk-clk-fix-reprobe-regression-v1-1-ed259968c2b8@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWN0QqCYAyFX0V23WAqmPQq0YX/WroslU0lEN+9W
 VeHD875zgYupuJwyTYwWdV1HALyUwbcNUMrqPdgKKioqM5LfM898qvHh37QZLIxSWRr4scUq4a
 J6RxlShCSySSav4Pr7c++pKfwfFhh379yEYJrggAAAA==
X-Change-ID: 20260813-mtk-clk-fix-reprobe-regression-6ac0c072600b
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Sam Shih <Sam.Shih@mediatek.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1818; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=q0V3z+F2D5Fbl3w9j+kC5Zyp/rj/X+Sb3criNtuZtV0=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqfcJBdHehrvWFgFZwruio58H2ENZ1UPZUlx0R+
 1otMKO9DmmJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCan3CQRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AlTUH/i+ie86gipjXq8zPIOA+8BBR01G3QRN6mMnkMGD
 emr4mnmle09KVBDE9V065v42hC0JxVAI3cCLRVNJN7aEhHbUqjmOWdrGGsbgL3zRrEC5j0h6LX+
 ctdPCUAaRe06TvhU5isaj+b4KcXudx55pNWMvs970tlf1VhLqXVcv8WqKqvupim2UW+zZi9q5SD
 UfCtWgok6Nw+ARxAlriksNJ3BzDDWlW4voehlVjbSbjddYtgD470sVAU8ZwXQOUZsJPMGEC6B5S
 bWsHdzNssGFE8kH682DIqupq+ywOvWFFx8z7odOTMjORvGepd7ECp/WL6HjQTBfjl8z22AmWRcj
 KAmY=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786626633; x=1787231433;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Yi7m8JiToLA6gKHo5Wffyg6qwXpOlXkEk6qkgrSY3xk=;
 b=OVMpEIsXsHUnyXvGGtfjpIHpLd4YaAx7yB2mz98NOiosymZlyruVnPMODlVJ8iiluc
 wlpkZSzHT7dAK7vCFogjdzhKX3S3NHksb7xn12OU950ixN0sdQs8Zm6SWcesr/F6liDw
 rA/RJzznaINQNosALH5HpY7uwzrCPZ4ge0vdj2PJLGuCoVsB0qX5KCPaoMPAoNE5ZJqk
 +ZCilv5EegQ2DW8OP1T0k3wPj5hI22NJsFCDa2T0DwhtBmh+owAzDeiQWic2wsAX/Ii1
 QL5dE3GTzXEa/fjYD4jRAz/0voeBFZeiDsd4DC5G6lVJGv8mFmQsb5zNCfW1F6oPj5W9
 fahg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=OVMpEIsX
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Clear the MediaTek clock provider registry after relocation. This is
necessary for a couple of reasons. If any clock probed before the
relocation, the registry will contain a pointer to pre-relocation
memory. Also, all drivers reprobe after relocation, so even if we
had a valid pointer, it would be to a clock provider that had not been
reprobed yet. Clearing the registry ensures that all clock providers
are re-registered when they are reprobed after relocation.

Reported-by: Sam Shih <Sam.Shih@mediatek.com>
Fixes: 8ef0ad4c7a6d ("clk: mediatek: use registered provider for parent lookup")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mtk.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 13c248c93a6..849e8a196e5 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -1130,3 +1130,21 @@ int mtk_clk_probe(struct udevice *dev)
 
 	return mtk_clk_tree_register_provider(dev, tree);
 }
+
+static int mtk_clock_reset_registry(void)
+{
+	/*
+	 * When U-Boot is relocated, the static clock provider registry is no
+	 * longer valid since it contains pointers to the old U-Boot memory.
+	 * Furthermore, all devices are re-probed after relocation. Therefore,
+	 * we need to reset the registry before any devices can probe after
+	 * relocation.
+	 */
+
+	for (int i = 0; i < ARRAY_SIZE(mtk_clk_providers); i++)
+		mtk_clk_providers[i] = NULL;
+
+	return 0;
+}
+
+EVENT_SPY_SIMPLE(EVT_DM_POST_INIT_R, mtk_clock_reset_registry);

---
base-commit: 0b581a9612e46310ee52bf8359165950d38b2a2b
change-id: 20260813-mtk-clk-fix-reprobe-regression-6ac0c072600b

Best regards,
--  
David Lechner <dlechner@baylibre.com>

