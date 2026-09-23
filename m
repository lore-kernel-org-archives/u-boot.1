Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C4B7C98304
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 20:22:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5ABB28435B;
	Wed, 23 Sep 2026 20:22:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gwy-f-0X97UG; Wed, 23 Sep 2026 20:22:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 14D26841DB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790194970;
	b=EYjEWoRoCBGrxUDFJ6XXVH9hac5aWNhVW6wQIjnlORrd8gkNqUkikcXq9UHY1Rtngnsq
	 FovGdAXnQ/AmqAw/hjupaawOYRKlLmUgelYx79JXFMOyxbCoXTqU5FAY0GaUtrGxMKe5L
	 JbljHFZCmUj8TO/2NODk3o40ef+ZHx4BNHyI4JpGgGq3ZI1rltBpCLqMxKJwqFeOMIsG5
	 Z3WHHd2NIyNSHzNQuqgnewjjp61aIzd9uJl8z5eelg5hwlIuP5crHyaSLpJyr3XXGznRJ
	 KV4Z+Lr6tv5C+oztvrb3188dj/Pt38JziMY6HwisNAzNOxJPx3Bb4ImTFvvu4Bbsn4w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790194970;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=1SXRQV5uz3AJAXe7wfXRdn1g8Zeh03UptZ4iOXg+T4g=;
	b=PKqxgPIbu6RCELfIhljOgYd8X/+YVMGh04Mc0jxMPSxWQkHk51AVmMhLB4aXDVEaejSh
	 wykFk3uTYbEa0fTibRSMV1UoBsQ3gBVpx4OETByn4XyI7nMvOUjAxARH0tDYL78s8R7tQ
	 8XwCKIU8F9Rk/40ctrjpJ4aZ5FhhV/kEcsh0KxiqmulM6Tp8ySZGlessZgmC2qy7wGmsZ
	 p+OzfcqEmToX6mrvscOHY7Z1U6vJm4yvKEg5XtrWZlp1TjAWjApNjFyPtyYluXRHddGMt
	 G3t1/8bq2ss+0sSUqxiYq/IbZyxtxFZIOWuwcT5ygbNtvmgkmcDTSit0QatFA8ylvbw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790194970;
	bh=1SXRQV5uz3AJAXe7wfXRdn1g8Zeh03UptZ4iOXg+T4g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sl0B7l+VMZ3V5DfS6Uk6UEbUfRDKibrzFG1vCSThWrVLJKqtVRvV+6zOEre5uRfND
	 MZACUNZP0V2CvaVu7z1QWY0fXvZJz60fIK1Ar/ngqeo48EwrXZCIkcIerkTp2LIyz9
	 O7XnNFQVmEkq/8u0B83vU2QDvvu2ke/BzfRYi6n+vrdHnRXDDCRh2JwNpIhdYjmHBq
	 BKj2+hjc0jUVAZkL3iRPkp6+z1PWvKBd9ighZG2LeU5of4IxDGlpRbu0EQeUnab/lm
	 Bky+rKb3FdGVvBULwtLNWk3Mwae46sqPPan8kNZDWK7dOrOG4KOuqMfTWrQYAAQYx+
	 QL0T+cqASVUDQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 14D26841DB;
	Wed, 23 Sep 2026 20:22:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3F59232F
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 20:22:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2D22F60B7D
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 20:22:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9SVgqoRA9vKB for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 20:22:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 63E1A60B05
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:30::f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790194965;
 b=JRiT37t/4Sa/aXouzO7RY5tumDHSwTnJ1iqv6QjLxLxQ0KpHkjDGE/l0+Y3yeAYifxFe
 Wd4E++GeD0uDfvIXauggN02HhEq2EsHt3DkKTKdgJgyshcPx8ytzh5kSg3/c0BTEQNI63
 trt+5LbU9AA1HWXyDTqIxvX3rm8cnuUzfJRGI3ZDDt+ZkrAXT4uw9+y3FBZV6dI5mQJtz
 BN9tDhRHnXaGFaWYBA6cn8vMng7TIYeBNkYHyofLqbQYHFtx8K0qSpv5VsJvX6OjBSl8H
 3O82b40osS3kEf4TbJOFWd5mmoMJ/V9fYrxn9lY1JbUE6gYSoUwncTP1QoGp+OVuvDw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790194965;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=1SXRQV5uz3AJAXe7wfXRdn1g8Zeh03UptZ4iOXg+T4g=;
 b=oOFbbAzHWburUAt74eBQiKLw+4zN8olySvr1Lx3qvIQG1r4u9BLK7Dhl7DzIaFS7zSMB
 hP+krqTNlMrOVwunz3LkGguAnd625zYqwGhdods7sjub4mnEHMc2gkk3dwXSFLsPY0vgJ
 ZPnFqyANcmJCwkRxY6IJVwG+AhxpZzGeErsNhbrLj82UFUSBnHM0Rl3E+a5PshyD2l+KQ
 RQPR+9fAX5c1ekYGPGxyufxmg4nIV4BTlPq6ZkXykr53SxvyLknG2BfTg0i+sF9dY81Ke
 eRpID8TiGOPzO15Ly2vlUenzijPvMK9YVLDTnNbquK79VGMwl72YwFxAVLm8pFra4FQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=aiTQe2yu; 
 arc=none smtp.remote-ip="2607:f8b0:4864:30::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:30::f;
 helo=mail-oa2-x0f.google.com; envelope-from=dlechner@baylibre.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=aiTQe2yu
Received: from mail-oa2-x0f.google.com (mail-oa2-x0f.google.com
 [IPv6:2607:f8b0:4864:30::f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 63E1A60B05
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 20:22:44 +0000 (UTC)
Received: by mail-oa2-x0f.google.com with SMTP id
 586e51a60fabf-49172f18b40so354071fac.3
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 13:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790194964; x=1790799764;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1SXRQV5uz3AJAXe7wfXRdn1g8Zeh03UptZ4iOXg+T4g=;
 b=aiTQe2yu0qQ8IPH+9Ls3GP2FQj9zgDnwccZCfIy2EgWufgRFAqhWhv77gPM100Panr
 K3HxSGW9iUrrehw3z+GJ0XyUnni0SjRdkf6NnQPXMGw+hykUYVqkwvm2L82shjwj0geP
 eP/22SdBMzKVzO4WTJxLiAbZrwTadK2XNY/IJFjp6lWmf4Li19WLn1qI2ThzNJhMTenA
 EOGCI23mCQMrLBTyv6+HwdhZpnhrXhquyxUUoilskphLAMfyaYTX+oW3nmpnTLtQa0io
 9lWHl3WpzCKWc0QeYuNjYMr65WpkotY4r7Ns2CoJ90Nzc52bR91VLQqVUHs85nmAoIko
 PlwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790194964; x=1790799764;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1SXRQV5uz3AJAXe7wfXRdn1g8Zeh03UptZ4iOXg+T4g=;
 b=usncCkqJohm9m9fhQM+Mm7a/QsXMMrxh8QMkL2ceLY5qtwXtWaDWL0PCb+AolQB7Vg
 rKpCByh5Si4URzzwMVOXJHxLphjcQvbmc1riAXeYnWIgiMNL4kWH0Jsfn9q0ICLIAaDV
 IqvCinS3uAYqys+38OMkRDs0FRVezou6niVS6rV+Wv4M2mNEMB2v3D00HFjFXYtwaLrU
 EEpSmnlltMjg/hLXPYhEGbLWeb/l9ueeMDQ46rjlndYw1Y4ArU6ipYFtIHTdQ/W9AN7a
 nFiu2QjRu8B7dgG5U3D92ThJwZGekLIOYkl/JnnD6K6an/41oK0Iw+QLkkCmpk6jbonO
 udiw==
X-Gm-Message-State: AFuF++lqmvaCVe7IX1bwCdJmmOB6wSxsR/SZz8q+zuR6MNBwzazEoppM
 jGVCwUYNh1re08r90rK7Gp5fJ7cVLK/qN9XTvYn4Jo77d9mjRSWuf3enjfNgjJjn2Go=
X-Gm-Gg: AYBFou2eMKfczl7GevmeTDO1oQtDLrJCGIGa239viWOTdW2nPdmozhGgxK1ds2AdRaE
 AqSMNjYmZ0+z12ls9Yip05TPPm074AlbN+Jl0mYycZ5KlKlYXjt1kCkzEWReh10mJfIAuWH5mkz
 w6sF9PU7ByvVsIZR2mHENOuYs4XRGtqp4rq8FntjBhQuc52WXsSDLSOkD6DvyTajgeR1YRryi05
 uDwli2aoJgVud+d0CFcTQ/95BZFC8qphkuEd88ZjZQCQo1g01dv8nKcXnVnlbnR48zrdgkDFjyL
 Txir1b4FIjlUb1OUnKd00QBkVidw0Q8ivD4lvaHqyAAcsk2Il90Ht22RoX04niyJPuIoHByjGu/
 s8Nf6ybJSFRi8SleMA/c2l78WdvZE1dEtZtj0FEFWt9AO4E2+3A3fahWmrJksnl66JFjr2LkL+9
 Rm8aZSm/i/v1xQ5/Wg1WMtxLvOFqijOGQFidRk8ZmxsKfFgft/UU39hOji5MeLWnkoXxkp9+dP2
 aTjOe3VXcwacA==
X-Received: by 2002:a05:6870:e18f:b0:47d:8128:8178 with SMTP id
 586e51a60fabf-491e539d672mr418575fac.16.1790194963991; 
 Wed, 23 Sep 2026 13:22:43 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:15b8:389e:2bba:8894])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-491ed71e8easm233729fac.7.2026.09.23.13.22.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 13:22:43 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 23 Sep 2026 15:22:14 -0500
Subject: [PATCH 2/2] clk: mediatek: mt8518: fix top gate lookup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-clk-mediatek-gate-order-v1-2-085391165c36@baylibre.com>
References: <20260923-clk-mediatek-gate-order-v1-0-085391165c36@baylibre.com>
In-Reply-To: <20260923-clk-mediatek-gate-order-v1-0-085391165c36@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Fabien Parent <fparent@baylibre.com>, 
 mingming lee <mingming.lee@mediatek.com>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2006; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=W/7Gd/Fv468YWEzR8oQGXqKjYjz+sI4puB9S3EgF7c0=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqtDUFAhe0NeqbLvvuItSeefLRMEVsvN8H0Qz3g
 jUXRbp6V2WJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCarQ1BRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Az1sH/29lbjZkSQp4amBvMnZFKeXxyXWC1zbcJpVuw2O
 1M5gN8N7FCW8tvb36NOOXTrB4Gvk98pP+q0Jp9Iz7HRKc8iMCvZ2zIGdg7jcEw9myQWKb+OKpKV
 lWffOJoJ4BVR8Ezdm+dhqNwvB2T57jaG2wKwZ6Lg3kaJGVor2Vn4Tl/9eHVNvhvdxGXPXpH8nnf
 2QwYCatrjwa0v1BGaAv6VZvqLXw67dom97gbS62ubA1BV6U9w0BN1lG23y+Kn1F9DlIVDiU0Wyf
 bH6+8CXcRkOn2XCe87vg0qjW17lHqCQyYfE6B4G2PP2xOTOjllsB7F7870Uqb4AE/UObhnJZjo1
 Al6Y=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Move the TOP3 gates after the TOP4 gates in top_clks[].

The common MediaTek clock code looks a gate up by using the clock ID as
an index into the gate array, so the array must be sorted by ID. The
TOP3 gates (IDs 67 to 70) came before the TOP4 gates (IDs 57 to 66), so
all of these IDs selected the wrong gate.

Fixes: 907240077516 ("clk: mediatek: add driver for MT8518")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8518.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8518.c b/drivers/clk/mediatek/clk-mt8518.c
index 70dc659419c..f875d4fcdd5 100644
--- a/drivers/clk/mediatek/clk-mt8518.c
+++ b/drivers/clk/mediatek/clk-mt8518.c
@@ -1452,11 +1452,6 @@ static const struct mtk_gate top_clks[] = {
 	GATE_TOP2_I(CLK_TOP_MSDC1_B, CLK_TOP_MSDC1, 29),
 	GATE_TOP2_I(CLK_TOP_MSDC2_B, CLK_TOP_MSDC2, 30),
 	GATE_TOP2(CLK_TOP_USB_B, CLK_TOP_USB_SEL, 31),
-	/* TOP3 */
-	GATE_TOP3(CLK_TOP_APLL12_DIV0, CLK_TOP_APLL12_CK_DIV0, 0),
-	GATE_TOP3(CLK_TOP_APLL12_DIV3, CLK_TOP_APLL12_CK_DIV3, 3),
-	GATE_TOP3(CLK_TOP_APLL12_DIV4, CLK_TOP_APLL12_CK_DIV4, 4),
-	GATE_TOP3(CLK_TOP_APLL12_DIV6, CLK_TOP_APLL12_CK_DIV6, 8),
 	/* TOP4 */
 	GATE_TOP4(CLK_TOP_SPINOR, CLK_TOP_SPINOR_SEL, 0),
 	GATE_TOP4(CLK_TOP_MSDC2, CLK_TOP_MSDC2_SEL, 1),
@@ -1468,6 +1463,11 @@ static const struct mtk_gate top_clks[] = {
 	GATE_TOP4(CLK_TOP_AUD_SPDIF_IN, CLK_TOP_AUD_SPDIFIN_SEL, 14),
 	GATE_TOP4(CLK_TOP_RG_UART2, CLK_TOP_UART2_SEL, 15),
 	GATE_TOP4(CLK_TOP_DBG_AT, CLK_TOP_DBG_ATCLK_SEL, 17),
+	/* TOP3 */
+	GATE_TOP3(CLK_TOP_APLL12_DIV0, CLK_TOP_APLL12_CK_DIV0, 0),
+	GATE_TOP3(CLK_TOP_APLL12_DIV3, CLK_TOP_APLL12_CK_DIV3, 3),
+	GATE_TOP3(CLK_TOP_APLL12_DIV4, CLK_TOP_APLL12_CK_DIV4, 4),
+	GATE_TOP3(CLK_TOP_APLL12_DIV6, CLK_TOP_APLL12_CK_DIV6, 8),
 	/* TOP5 */
 	GATE_TOP5_I(CLK_TOP_IMGRZ_SYS, CLK_TOP_IMGRZ_SYS_SEL, 0),
 	GATE_TOP5_I(CLK_TOP_PNG_SYS, CLK_TOP_PNG_SYS_SEL, 1),

-- 
2.43.0

