Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 944FFCA5FAC
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 12:36:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 656D7607E5;
	Tue, 29 Sep 2026 12:36:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nOcDetfXZ29Z; Tue, 29 Sep 2026 12:36:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 94B73607D1
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790685412;
	b=IpWFSaIlSgzkz/bu+uinCFm16BJHXnuwClc5X5MkEA9ozO++lkHguCWqCMZGChgMfGwc
	 HOxStyuaLBT+CmG3SfmyCl7yC336ZdzRa9H32xbS9KEpzMuwCLsnbm0tmQ/ZyQ23N7lpz
	 Sh+Q9LwUsylKqX/1rnGKf0mUxAZSo/naC/NQaxxI9QMbzw1hIEpJmLSkl9122ubztPsdG
	 1PG4yNiCtj2FHoK9WkzIDuaB6DrYuLfTeC5yI7Aw0bEhTpGB9rHocJ8fT0EohpRQrFvNh
	 vosUQB96sNVl3j0oVWLsK6osed11FPkCqqeXk+m80DsiiQy6j8gRbwWoFFwG2mtCfkg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790685412;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ZyV2CjPpV93Yy+635dUF/X4renHvVEdluXoCfDlvRDE=;
	b=juoLhCCMzLQHyBhzYyaVfek2DTo5P/A3uQ7bOQyLpe11yPAc2gLwlFv0VHD/YgmgaZLn
	 7qD8QxeviXugU63BAWZmas9dyVyMyQTq5Lsthr9RiD8NZqxs/aWnMp7yRs7ZXTusrTS/x
	 5lFaFf3NbnwH1+3p+QOJ4iJ/OGZWmKjByWLZA7LZCPpj7g3iSDzkGDG3wYFTkXIpVSrLH
	 RK4ROKk4AkBeQD6gt0u+4mUFTcbuF/SGHWF2wAJQEeWBmpbaLFtzcj3rWdTRPR4WRSJkM
	 XOdGdrB0KwqXrkQHUw7T38o6UDf/TXwX0+6viySmGSEsqHEI9jvrvaX/sDQSWpC92kQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790685412;
	bh=ZyV2CjPpV93Yy+635dUF/X4renHvVEdluXoCfDlvRDE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lnWDvhHaphnYsekxU7dGZskg/Ewocy2dIA3mGo8cGBV+PB4u5zg5YlZglRBl22xBh
	 3ZzuUVFhe316Zu4FlUnsypBtI+aaxte9hKXOSk2zHK4b+BeqzZ2Q70x8lGqxwTcKUx
	 meucecvz8zIOWaRMo8tqAjoFFFWcHBrBQnHAC7cwu5X37UAR2RUe3bxY2DaKsL0rNi
	 3GwWXqvgpOnApN8KPlR+TDVOouQor7As4dyRlF/56iH6wCo8O4b46fVYNY1UlU1bBc
	 Pr23khyG5DVFRik0At3H7C+9sY8Ny/Ed4RHhAESeb2LOAHY6a6WGBHFJBQz3B8+LtK
	 qUAgaqHzOwiIw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 94B73607D1;
	Tue, 29 Sep 2026 12:36:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 43B95B6E
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 12:36:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 355DE406F2
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 12:36:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aL1fvuXN_3kS for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 12:36:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4465B406E4
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790685398;
 b=MwbtvdAdBJxh2WCLDeG51TD9QIMmRAd14BNrl3gWXyolBIe5Qgias1K796hIbyfz8MaQ
 ff7DON2Lwh6SpadU4FvXu3H4300OCSgDr+INTNZ8+4MjIYw4QHvkhLOzysfDCKmCeI0sr
 Asy3RSc/mpq62YrDkfFjHwKm+oXKo9ORazn4SMY7rVRqk5iIgxmNWTN0zeGBuWR7hkn91
 7NN9SKnTlf6iBoEwAHKq8HLjJtek7xmS/lQKwFpzAgBShx8teQrfvPuP3kiG27wEk4hPB
 wxWWksSPbosBkPhw6n7tEZCRaWpTJio2PnvmqJ33BQxqRLzUF1a9mLMlgrU800W2xKw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790685398;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=ZyV2CjPpV93Yy+635dUF/X4renHvVEdluXoCfDlvRDE=;
 b=nPHq9nR5uD1OSdapkPJEPoUVd7EnrV12fi4Lh3dd5P1yqZhcbVJSeLLAWT3GxzAhBo9+
 Zfk3QhVVQYuWVrMROQ4++r7s3AkYRakas6VDjJyiRrM3DVqP8K7+kJ7LfnYNgwYtitLDO
 dXGmESaGzKEa0v5Sley34ovsbdfkgEwywBGd5+NUIZAgYNsDgYeYAfy8gjitYDr9rdERr
 9t05MaX7jVZXZk7Xs4QQdsZrjGl9gTFBcwRO4lhYxavxrjTdigZZg7s0y5SFpwAMkof1p
 25ijMd+lENoL1aAXXYX/YdQiX79mUZVQq6eMea6sNM01diOfzGg6F0+kiy2bECMp7Xw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Z5VQHuST; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Z5VQHuST
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4465B406E4
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 12:36:36 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49ff9642c57so4297535e9.0
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 05:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790685395; x=1791290195;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZyV2CjPpV93Yy+635dUF/X4renHvVEdluXoCfDlvRDE=;
 b=Z5VQHuSTqe0ZYmKmLOPZ/bHQ+mb5HkDZ4wPxwrb23vgPzZeo4tLCIeDg0fitmvPe6+
 /z+CgaSSJpy+ZomMYhGVfbXHTkmzQODX+1Pw3Z4t80RjxvytT3pqhJOHAstmxbAudg8y
 Plz9ibUG7XQk858Cp356B4dGUTMNqyooJHH4PO3L1tDPNYF/nkFOgo/19ZOpDZjFl4FD
 AcSmyRnG14x+67oXQGDDuuYwX92LXwjkttGST6/FPEJJ0y+W57PUHj8CnFinzXN5JYd/
 sjOamt9HAt41/Wbu7Snsn6xIyIdxy+m524IY3134pfngUsH2L/i7VwzXynOidq3VO2eS
 fI4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790685395; x=1791290195;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZyV2CjPpV93Yy+635dUF/X4renHvVEdluXoCfDlvRDE=;
 b=vttiluT4sXDJkHDDic9LlrKsO8PDpp5FUtI2KozgBsU74B4HmJ4WowQ2OcWoZqkydS
 HFaPTOypkxAf9ETe+j/nL14fuWbc4uxxS86YHifek9J7O7+Nt+9eSvagVn77aN5crlLQ
 cyXUWeTnisAnUCTdwwDb4npDx+eAWRZmu/nt6nvWNVMPlEQ5Jfhdblgi2LLWlo7LbdLo
 8lYTerME1erb/dp0m8sPKXy6AGjMRELKYZGkTqiZ+xWrn7EC74wXNpjBKPwHbpIDOutK
 zwBwz/NysDvsaDI9N4EHssAyjd7n/Y7L4dAM5rManc/bKCVJIL74hNrQETblzIf6uonD
 B/fQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy/oJTr0MoJRAVGk83gE7sHjc8P8UYF1yYx35dcOZI9d9J7rqP5SxfZ1tT80OZJtXSGXfqRQG0=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++npiqYI4pASLZasn+TLXZMNS0CcVzPnBanAEZnOVw93m175si6m
 te7PrjHJlKvBf3lrFlSIks9gWXkPvjKLOuOlMrCcXEJ3ZiQhEoXJPmLwfv6OeRF22KM=
X-Gm-Gg: AYBFou1X35yBIOHimkin525//hMVneKTuVSY4xRhpmwieRMLmpY9hmvlIbS6IqNPvT/
 +IQsg9gx0VqkN9eXVA2t5uoOCyVJIZRgaFGBhg08NP1KiGQq2IblFdSpWJ3+Zr6OApf41106rxA
 3+tks0jNkf11MxVzVsio8ek7iao3+j4fO6YPH5hFVZZifBzI209aSHZ5jZF89gJoHWWAY9fH+ta
 qdkrQ1WgT2c+fqWUZz7E7V22eNlXmupVpYsfblpmuRsjHsTrU3DMYfd602D8xDG6e8l9k3VoqOM
 +AVon6ST7XeZ8O0zVCPW+lfU7zGXhu0oVxTB8A9ISz+G9bXf6tth4VExfwuwkV7hytZcR0rUgjw
 6SApPUAjtp9zNJ4rkmfeqfrLxyTsI4XmFZ8taQAAp0I3tvz6Dbh7E1z2V856sC8G8KYeJBm1q1L
 1S+5luSKoin9uy/E1fDW7UEKZ0XQk62sBr29L/WCKgVNchN+XSfUzwYch1g1TVaCl1F1RH4juo+
 Km8cJmwkevca4kc0uGnmbrbO93OZC9ioMSu4XeLHx00YR+L8Q11ckAR57wvmY8PbipYm+6vG77s
 SpSIXcVUJa+xNLSwMjMeT+my4oB6cKyjTpczcFeM3HDLkt7CVJVrkkEh
X-Received: by 2002:a05:600c:c16a:b0:49f:d69a:1a04 with SMTP id
 5b1f17b1804b1-4a00d779048mr33353305e9.16.1790685394602; 
 Tue, 29 Sep 2026 05:36:34 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a013cfc788sm450305e9.2.2026.09.29.05.36.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 05:36:34 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 29 Sep 2026 14:38:46 +0200
Subject: [PATCH v2 08/11] clk: mediatek: mt8365: merge the clock drivers
 into a single driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-clk-mediatek-cleanups-v2-8-b296bf3a4a93@baylibre.com>
References: <20260929-clk-mediatek-cleanups-v2-0-b296bf3a4a93@baylibre.com>
In-Reply-To: <20260929-clk-mediatek-cleanups-v2-0-b296bf3a4a93@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Chris Chen <chris-qj.chen@mediatek.com>, 
 "irving.ch.lin" <irving-ch.lin@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>
X-Mailer: b4 0.15.2
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

The topckgen and infracfg U_BOOT_DRIVER entries only differ by
their of_match table: they share the same probe, ops, private data
and flags. Merge them into a single mt8365-clk driver, the way
clk-mt8366.c already does, so that a new clock block only needs a
new of_match entry.

No functional change.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8365.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8365.c b/drivers/clk/mediatek/clk-mt8365.c
index e709fc1640b..8b19623c3ef 100644
--- a/drivers/clk/mediatek/clk-mt8365.c
+++ b/drivers/clk/mediatek/clk-mt8365.c
@@ -764,15 +764,11 @@ static const struct udevice_id mt8365_apmixed_compat[] = {
 	{ }
 };
 
-static const struct udevice_id mt8365_topckgen_compat[] = {
+static const struct udevice_id mt8365_clk_compat[] = {
 	{
 		.compatible = "mediatek,mt8365-topckgen",
 		.data = (ulong)&mt8365_topckgen_tree,
 	},
-	{ }
-};
-
-static const struct udevice_id mt8365_infracfg_compat[] = {
 	{
 		.compatible = "mediatek,mt8365-infracfg",
 		.data = (ulong)&mt8365_infracfg_tree,
@@ -790,20 +786,10 @@ U_BOOT_DRIVER(mt8365_clk_apmixedsys) = {
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-U_BOOT_DRIVER(mt8365_clk_topckgen) = {
-	.name = "mt8365-topckgen",
-	.id = UCLASS_CLK,
-	.of_match = mt8365_topckgen_compat,
-	.probe = mtk_clk_probe,
-	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_topckgen_ops,
-	.flags = DM_FLAG_PRE_RELOC,
-};
-
-U_BOOT_DRIVER(mt8365_clk_infracfg) = {
-	.name = "mt8365-infracfg",
+U_BOOT_DRIVER(mt8365_clk) = {
+	.name = "mt8365-clk",
 	.id = UCLASS_CLK,
-	.of_match = mt8365_infracfg_compat,
+	.of_match = mt8365_clk_compat,
 	.probe = mtk_clk_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,

-- 
2.55.0

