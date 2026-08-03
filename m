Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2ED0C55182
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 20:57:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 673EA80C09;
	Mon,  3 Aug 2026 20:57:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QiSlDKD1Zkcg; Mon,  3 Aug 2026 20:57:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3ABBB80C04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785790668;
	bh=pD2dU7SU8h7jG9PuqfNWCuB14LXbaYTOevebPIYnqWs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DkB2/GF4WpzjrR8RtG8dxWS5IYc6oiNsXrzog57Po/FKJ3EY5KhT251VSKzN8PrrE
	 xqiYZ8dSnxgWqRJsnyTk5S2VnwdEgp/1eI6IP1+CCxRghX5AUFTFYggv9EY/9LONcv
	 YAq1k2OFK8QxtDKEjfLmO8f4DnsWdZZxIL4jWgEOah/3vMcckF8Uri4VNqAJ4sUVZ/
	 A9Ke1Eq2gzhMj93wJKWDaz4UBzjsocIjfN51xQh43vFsXvY+lnzlfhXkoVhJDMQBxV
	 lI7x/e0loEuoD3ZF+BadFL212QqdGbYAsb1ndDSy36MEHOTiUoDfjDpq5oXHQRcnFx
	 +Dc88QJCDCgmA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3ABBB80C04;
	Mon,  3 Aug 2026 20:57:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4AACA2DE
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 20:57:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 30E0240649
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 20:57:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VRf4UAUoTM97 for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 20:57:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::332; helo=mail-ot1-x332.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 44E3E40648
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 44E3E40648
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 44E3E40648
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 20:57:45 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7ee37dc91f5so2398995a34.3
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 13:57:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785790664; x=1786395464;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pD2dU7SU8h7jG9PuqfNWCuB14LXbaYTOevebPIYnqWs=;
 b=qUwL7CWqWYWNU7UBQb3FjN9uxt0L952AE33/vNwWrB9yi+uqfUl3IcLaTu0Dx+9FlU
 KfMH3oBE/kpRsyFY3gNY4ss1XiIA5X5yxyqRAFK0mwb7U7CQwJjtn6czw4PHU8fu/7jR
 Fy+ZXvjLy2PlLQJ/S8z7Tg4o1wprdGrm0Ui8Zo6OxJ6Czm4SU3KkEr2rOz0SAx4HCgSq
 u3unTKLbkNhYyHv17SeIv+lt5S7bn7Yxzsa379unM0NLbQuuo2q36zggY5OkqoknrurT
 p61xZsBg5jVirIb6j6cV9mQPLMkgXmZNs3DkY1BSU6UInqJMHTEzKHOYMQS/Wg99nhIL
 q3Hg==
X-Gm-Message-State: AOJu0YyvWivdeurEsxMhiU/P4M8JfbQDfaVg1JUjoKN+S6dv64nd5F1A
 7udklOd5SgHLLntapNuTJdce8fVr9AQn4ov5NmxrG7XcO7BBnJo2PfkFQUk8ymFm8+myidUYQTw
 5RnP9LPg=
X-Gm-Gg: AR+sD11xY7wuC/eKuDHML11Jtux/UQFJUKNKtYsLeysHSR0J+gSa0YJHvdRdPgsYIhw
 kMdxCzf8dddDsGPKYPXdJ/82Bz6yFbOgNMq5vo4y37TFrUU+u/GnuaxXqt9cbkTe3RyriFfuhft
 vLiCakn90KYRqvFdQSzi0o2tsd92CMr2gR6d1swoUfJDaN38/5eVPwdYrE0svOp3oHO30m+6Px6
 OzJlFv8QqI7O5jPH9JcH/G2/OiegoeCps4mQ7eq9sBCZwMn3T8BZ4J4hxmX1TsIx5huNOVSzwQi
 pI6dkq5oxyCGSD8LT0q/c8JCdxz3KmG4XnszdegKFFgysWg9KuWsi4vpp2mongCF9kg43wxqwyT
 6Ad1CL0RPGq45b6mR603wYj168+T92wS3S8qql3usykrzB90ODsfiXJ6NjoF9S7y5ZM/NvMeXzm
 BfBjb4GXjR+/aVhJDLB2lpJYXclP7SAR8GOOkuXCiOZIa+JFrtnTj+s04Nx/WKjpjPXwbKUy0GU
 w==
X-Received: by 2002:a05:6830:7108:b0:7e7:45f:ce3c with SMTP id
 46e09a7af769-7f196e89bf1mr19733544a34.14.1785790664123; 
 Mon, 03 Aug 2026 13:57:44 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:b8f7:1f5e:7c:a7d1])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f18f0d6a68sm8421452a34.19.2026.08.03.13.57.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 13:57:43 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 03 Aug 2026 15:57:04 -0500
Subject: [PATCH 1/4] pinctrl: mediatek: select PINCONF
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-mtk-pinctrl-kconfig-cleanup-v1-1-fef1ff69d1cc@baylibre.com>
References: <20260803-mtk-pinctrl-kconfig-cleanup-v1-0-fef1ff69d1cc@baylibre.com>
In-Reply-To: <20260803-mtk-pinctrl-kconfig-cleanup-v1-0-fef1ff69d1cc@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Sam Shih <sam.shih@mediatek.com>, 
 David Woodhouse <dwmw2@infradead.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Mingming lee <mingming.lee@mediatek.com>, 
 Fabien Parent <fparent@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=648; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=OiUgks1djEYYyrmZ7kFijg68U0ScRedxzVKZAJV6qlA=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqcQCrQS8sqNWhKV26mrk+bsAThjZ+KlztPJnw8
 Xuha9CUmcSJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCanEAqxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A1SIIAIFW6Jksr3fKg2v7RyDptAZHNelzTKriOdoWbJK
 YYL++HcDIwWHGiVXe8a5P09+vBDppDZfpMeRoXCqQQ5kYU6d6DmjuaD3k510ZIugQff1BJwhcSG
 Vf0CdjO3RLPL4a2IScFnbtnEPV3Jc84qkAJ42/72Ta4cBqaw42S7DzCJ8sgq0FilImiSrshDaHU
 ktzXTev+xhJ0auw9CS1uHIVQJaNe6+dHWFjCwxW8SQUTmsnwolOLfPbbLQzxP/OUdA1gpVfvri4
 AGaChpuKswwll2nbhOA24gbFM6+CSyTtU8a2ETHc4daKGCKMCN/3jPyLkm6/23VZflCD0zwbebG
 NZ1k=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785790664; x=1786395464;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pD2dU7SU8h7jG9PuqfNWCuB14LXbaYTOevebPIYnqWs=;
 b=IY9UuA07m51Fi7wnv31eSHb4PbK9/YLK24UgQLcNjW1+T00un7RYqRjSc6e9cjJc9D
 RhWrGhQTeqAwBypwr/YN17KIOuqkv9LBbEjVHaSDAkB8lcatdtWhGYL3KZ+Be6LQbmTW
 OGRRtBanpR3tVzVfPqZERgDVgfOHYOG6gfgUC0/HmufakBCSykgopCMhPYOpGMuM/Fgu
 vEbn/T+AsHc0yuH2VY1BlFjVVY5c4APrdapXk9oV0JAsukSp6OcYVVft6HQAVuOUpX1t
 OAla8SNxDci0XKIYXd/tVBsXOWYTBcxqkSlkIAHi1ZUSDGo/5OsQAKBYfjqd5zfyyRM/
 z2pg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=IY9UuA07
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

All MediaTek targets include pinconf registers so we should just always
select PINCONF instead of requiring each config to explicitly enable it.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/pinctrl/mediatek/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
index 5a90d74a9e1..42c7c8b8c80 100644
--- a/drivers/pinctrl/mediatek/Kconfig
+++ b/drivers/pinctrl/mediatek/Kconfig
@@ -2,6 +2,7 @@ if ARCH_MEDIATEK
 
 config PINCTRL_MTK
 	depends on PINCTRL_GENERIC
+	select PINCONF
 	select REGMAP
 	select SYSCON
 	bool

-- 
2.43.0

