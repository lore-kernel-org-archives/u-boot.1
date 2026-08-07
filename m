Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8BF1C2A09B
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 19:00:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1693660A9E;
	Fri,  7 Aug 2026 19:00:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b42eUXC8vMbG; Fri,  7 Aug 2026 19:00:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 664B460901
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786129225;
	bh=vOPPeQzLO5uaNC4d9RPciJwFwY3XVauGfxDP6NayZv0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JaW9s1jjDh8LoReWJ8wstx4TWu+D8aVNxIAJ1PiVpQVTiZ4a+hk85tqgwTPPp/gvc
	 yA7wMHIC8PyhEAErSHOEefM9ge0syi5ErF3YfOCVJqcz+4wKbU7BDdOWXP71a4Uk/q
	 IjmUJdAxNUKpYHYBpdBomK0kV40lQ4ZDgTy9wQekCgyl3oTU2ZOzwBOTrvD49CEabP
	 1vkm17ZIaQxnh0Z4LW0PoPX9z4yRHirS1yqjiz+juZ888hcjPCPMfCmk7GAVuVR7Zb
	 0RkjKhCg8fKCXHcqp2YZ7CXb9p8p9OeOsD2zpQepomJRnEuuhQW8lkCo+ev9+2SYA0
	 VuWYAiz6n5v5Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 664B460901;
	Fri,  7 Aug 2026 19:00:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9796F1AF
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 19:00:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7D74F40159
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 19:00:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0S33nQbUcYjg for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 19:00:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c29; helo=mail-oo1-xc29.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org BA9E4400C7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BA9E4400C7
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BA9E4400C7
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 19:00:22 +0000 (UTC)
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-6aca0f482e5so2430094eaf.2
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 12:00:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786129221; x=1786734021;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vOPPeQzLO5uaNC4d9RPciJwFwY3XVauGfxDP6NayZv0=;
 b=mEUF5I1ZBkJNaqPfNjkLH5pgKnEMsZtmb2WYLVPn5AZRdl1PW3IPNp/q6cdRrMb2Kq
 boqoopkJm7cHcfqnb3gzsQEHfsKH4LwehWfKOgUR9rHulIM6W2tR1n8A4wUTgF9W+S5q
 sLS32v36iT4KpZE6p9dKqbnB/tuU9DCD6cO+GIExxzfUrFhYnnpZoegUtRs5NcHdW6Q8
 WkLvOW3YGtc//lK52F2hZfOMMTON7z/vc3NMqrIbAAg9RY2+4vh/Yb8O3tJoPe8FCOv3
 AK9zhNFMdYXY+uKDrPnfF0al2jDD0fGVoHWKMU6ktuh8yllwtoKxoShf61rr6H6DdoL0
 unaQ==
X-Gm-Message-State: AOJu0YzZ5Y04okFU2m/RZI/KzZarFgZrZnCeZHYCHqTsXsfpBbuBtTtO
 P2KhpYzZUTX9cOSUMWoyMg5OBTnbXAy8knlgp7yYqO1I2tTSHaFTmsU6Jq5BtC++R3A=
X-Gm-Gg: AR+sD12uOAwiVsA1MPXKS2CUOP0n1//JqnNKsi7ImM1R63U0Ke4niARa7JkeF8z7Wef
 eEfZ7IZXqERQFa5LMMBFKYmgHeIZZIm4/etPK2hkEPp+pO/l8QoY61vaJCjAQCcKAWBTP6btx/g
 ENi43ObtYqf2E8tq0wjA02eofoPbdt9VWQTsoYSProHR/pf79aRV8fqn/aEPSNDucEH3c4m12Q5
 hbSJeZl9ZVbC2VxM/+pFnMbLgr3sk/h0mMjLHRxjzyF2ot0Uv1NZZYz3jnIe8z1nbeR/Wnd4mHw
 nTQyrlaa7+CYbPCLohcFu5wKJD1YkGFnAqwi7OtnIgYyS+DycqUv8aAcev4Gqhjpfd08xvq7v/Q
 Jq4rL+olRG9kpb2F0OZaYdBVm5l/IjUR0Ktqu9nX+2MbiNfhQd+zi4EsOzqU+PeB/SbORl8azxz
 KnvS5hSUUJUyWK8VE0+IztyKiGXmHCXCY+3eEL4XwTRscmKTFp+9iAQ4lRn/OJVwMK
X-Received: by 2002:a05:6820:1621:b0:6a1:40ad:cfac with SMTP id
 006d021491bc7-6b02125fce1mr6552749eaf.13.1786129221379; 
 Fri, 07 Aug 2026 12:00:21 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:b714:88c:313d:dee2])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b02be47604sm2679283eaf.10.2026.08.07.12.00.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 12:00:20 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 07 Aug 2026 13:59:40 -0500
Subject: [PATCH v3 2/4] serial: mtk: guard clk ops on clk.dev
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-serial-mtk-clock-fixes-v3-2-8cc94d313b57@baylibre.com>
References: <20260807-serial-mtk-clock-fixes-v3-0-8cc94d313b57@baylibre.com>
In-Reply-To: <20260807-serial-mtk-clock-fixes-v3-0-8cc94d313b57@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>, 
 Suhrid Subramaniam <suhrid.subramaniam@mediatek.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1246; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=eVLP7sNbUg4VPpZFSbeRbEuWybqBP8a88l0CbIX3TEo=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqdiss+Uo9gqpIC+Cl4hPmH+EE7Be7RpLDH1LUh
 pxzWUmDm2OJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCanYrLBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Aj4cH/R5rZmbqfwuzCWFyH3lbEUILidhILjWrbrO9KS4
 /wLzPiglxyQg66DJRna9ywo1WjRWGW4fkeGdh/1M0ckkxdKYdvVLxxbEHzbh9bwZpSjAcUU8rrW
 6SqQID3XxkWw+OaGZAtefuS8nOmMLsKsab5K0AUp6H3UzCMsUtX6LJC8dsiZkTSiVqLn4e1umRK
 YWhx5s0YNVpSsIIW/fGbNr8OXJ8YFJESf7o3HGs6d/Ex7w93pd48tyMqn3pwPQZpYAWk+8x00VE
 Wz4AB5bQNUZJEUlKF2JYjtFn3oJNUTqo7+5wqTGAqxCDSmnYH99ZyqXV8lCZ6LsmPgQNqz9FBz4
 XPHw=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786129221; x=1786734021;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vOPPeQzLO5uaNC4d9RPciJwFwY3XVauGfxDP6NayZv0=;
 b=f7SszobMTnJEZanYNW+g/PkMc7Ogjey8t9ndwFO/rae7gs9QTKwA58CfejenBU4p/S
 rGULdKL0IUQLhmfpqWQyP3j8XQRCyaBCKzcvq1GJDHULQLZhVGEWmt/qAxi66j7KUz0v
 xWzR9X0/q8kI+yJXybzdfpvRcv7eb7oI3OnMN3Bj4h3b92GW9YAcCRdqVThM6/0pmd70
 n+ehOoLUoojB8jUxMqndHXsTG1lPwfR3lczczGP7dV//2tPHUqj7jZlZ5b7xx3HcFQyD
 0xbQqthjgetcKyjn01Atyq3Ula4c0zf9CQG0Kw1bTVFRNEXq/O+4dyFXpUiycMC4T083
 b09Q==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=f7SszobM
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

From: Suhrid Subramaniam <suhrid.subramaniam@mediatek.com>

Check that priv->clk has been populated before trying to use it in the
MediaTek serial driver.

The clock is optional and may not be populated in all cases (in which
case it is expected that there was a fixed clock rate provided.)

Fixes: 3b17f2e2c2a9 ("serial: mtk: add support for using dynamic baud clock souce")
Signed-off-by: Suhrid Subramaniam <suhrid.subramaniam@mediatek.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/serial/serial_mtk.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/serial_mtk.c b/drivers/serial/serial_mtk.c
index 28e87f485a2..0f1d3b63f23 100644
--- a/drivers/serial/serial_mtk.c
+++ b/drivers/serial/serial_mtk.c
@@ -215,9 +215,13 @@ static int mtk_serial_setbrg(struct udevice *dev, int baudrate)
 	struct mtk_serial_priv *priv = dev_get_priv(dev);
 	ulong clk_rate;
 
-	clk_rate = clk_get_rate(&priv->clk);
-	if (IS_ERR_VALUE(clk_rate) || clk_rate == 0)
+	if (clk_is_valid(&priv->clk)) {
+		clk_rate = clk_get_rate(&priv->clk);
+		if (IS_ERR_VALUE(clk_rate) || clk_rate == 0)
+			return -EINVAL;
+	} else {
 		clk_rate = priv->fixed_clk_rate;
+	}
 
 	_mtk_serial_setbrg(priv, baudrate, clk_rate);
 

-- 
2.43.0

