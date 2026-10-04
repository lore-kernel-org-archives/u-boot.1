Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0635ACA5FFC
	for <u-boot@archiver.kernel.org>; Sun,  4 Oct 2026 21:53:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 870DD405E8;
	Sun,  4 Oct 2026 21:53:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kX10pwI6HmT5; Sun,  4 Oct 2026 21:53:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org CE6D5405DA
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791150809;
	b=nLv+ewlNKibjb6jrCHVI/8bC2xrqoujBB+g8Fiwti5nOSssKQ+J9rwXmfroO56td1zTs
	 S8Gf1XFVmHQ3eWZF+xcsTO5ZFnuSFImojgmznawzxtZnJZN14DXfhWqp1wK2crXW7I6/6
	 RgccVftH0Tv082mXP/OvhQ7vz4A3QDGHr5lpeRVKYhyw5HBaWY4QIhCJUn6qq0gFZ+73t
	 yqbp3Cmmx7oOaM2ZkveAWlRb/E0LoPGym4kmfdVeXgYVdacrEz6InYKddE2utbDcMj5I9
	 TpPBP8ofrMkiII/+ODLTLYKNdSDmXn9SmHsZEpcHz/7yat3kHTUydg1Q/x3yPzFzfbg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791150809;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Forward-Email-ID:X-Forward-Email-Sender:
	 X-Forward-Email-Version:X-Forward-Email-Website:X-Complaints-To:
	 X-Report-Abuse:X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=NR4l/h3eoQ6diIahBKlaHSeFViOX5GBVBrkabLZ7zyc=;
	b=Vl6cFFRQ/BRFgh/FEQKohflp0SIegzcNUp6MGUb0b4z3+tspNn172/KTmhd5qfacmkjf
	 maaanHVJAZAN5ekgTW/aIvTI7JkiRL+PlwwPLzTDjPiNtxPn9Y93EDDvJ/BplieXEBuW7
	 c6fOKmgxOvv0CTo3Q4XPbTqE49yO2kblRQfNcC/IM7OIqiO6Yc0gjo/GOFrhc/Co4CRK4
	 6XEIU5L0gmLiTViUuB+L3mouZVF9aBnFj3bH3V+yUu+J3p5kI8z9e6j0Be8b86jI3SsLG
	 ceUkUwMcKKaogfmj0EZiJkrjYzs1Ss2IYJ7/LPgWbnYnkvMtzjQevEIs8O9KU6KCX2Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791150808;
	bh=NR4l/h3eoQ6diIahBKlaHSeFViOX5GBVBrkabLZ7zyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kmIWKm40puEyr1klJnInPcCyo6ZYWtS5tSn0/VS0FkdVVXyKrqolI7eGv7AL74ISN
	 QTiNz5IJPte27qQ3jRODjnjmEwlZ16fkhplLJNLpV+5Ka+HnfIkJqruBJ7nx5QX9JJ
	 lAq995Z5Zvx3g2CosYMffHwlanfzjIYUnuHb0V0WUqSQX98la11gaj8YujmMm1PqME
	 dbYSlzdgE9/TTC1ykpPnmN/qC1mIklK+Dn1gW0klpgeessOLSoprkT5gRWn1Cm3vX1
	 hFaTVDECIsCTd+9vTohXxAfcmj/OXhodOtfn7SqHrqyqbfwohpLgv03lsS3QRk+BUE
	 o4umhml7dDhsQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CE6D5405DA;
	Sun,  4 Oct 2026 21:53:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6390332F
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 21:53:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 49FCB40049
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 21:53:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pz7vB67KW1Iu for <u-boot@lists.u-boot-project.org>;
 Sun,  4 Oct 2026 21:53:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 7F5A940004
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=121.127.44.66
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791150806;
 b=cWRB49u34h1+e6B03wKdS6S1nN4Bh4i9cWHrfNjYOjFLqVVhWEczuQKc30i2tQn9zBm2
 M0nU8DWXpuA+grUa9mrfcHZm8vG3dCx7eKPsNmGxy3IgUPPt3QpykBqAQqIGQ/KScerSo
 KqMJoYWIjKimd+kLSt+ZKqcuWgfHsYdhRJCV+HYEjvR/cDaryY2sDrVCBiYZ1tFCZrFf0
 YCrOmj8NNblLbPAOWdpM3sbZ8wmsaKPM9hic6eN/Y4OP4kCAD68RtBmbDmuP3gaT+TOlC
 XTv8ozA6e9klvdlgB8Sdqmk/8bstcJfvboRjFSyVTHG+SbU7nFY8FpUaEpDHseWK/hA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791150806;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=NR4l/h3eoQ6diIahBKlaHSeFViOX5GBVBrkabLZ7zyc=;
 b=IlTmlnONXSCjS3JDRKETwumVVW2d5RfRDOIKIbShKCyXeklG8V3R8UcyFWFPIY9GXXG8
 UYs3fVEMG6PHKd925XdcyQMfcZZvfeyiNbeSKuP17D+OdwOYRuXMWv+aPjfV2FX1LL/YI
 pABRguW+iAR2c4vwWYSiEznnt8gsdEufAf2fisJvBZPcA8ASfYO96Q9sm3nT3hwmIg8ow
 4UwiQOD0i5GGWNsX7syhsOr70S1ew+GARi5w/7hEf21UkfXgopVnAqfzce/M2+HCPYFTS
 GQO5FJKgXtYkS9ntXwGxqBvIX5co2mwZHJ605L58rFqDM2tUhnzmsnTdMof5zYmqsVA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kwiboo.se; 
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=JNL+joiA; 
 arc=none smtp.remote-ip=121.127.44.66
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=8573=h3=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=JNL+joiA
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7F5A940004
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 21:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1791150804; bh=NR4l/h3eoQ6diIahBKlaHSeFViOX5GBVBrkabLZ7zyc=;
 b=JNL+joiAwrOjxjoKJFyqQcaY1P4fEoXOh4SQ+diPJorNj3NX3N4MJTqPbCAlU3KqbNeyC2ZlO
 PtAvXV2JR69WY2b9Oao3itOkZ0NIWf8hYKJJj75hYpyRKf4Yis0wyaklce4wXZm+raghLsHBCHv
 j6uLCU4lLK7pTqtj+BrCGluB6hGiCwylc7IxYg354Ch5vsV8JqIf3YYPkusKwFxS3Ckmbe7xp5c
 uG4lZb0eO0NVAFReM/kpucCY414oUi5ekkK/K31pA0CkP0YQYHSj+9IL+fYPwu56/xs5tHre/Ao
 e7QfUziIwEUFv7md9aBktLjTgybbv2KX3QWehpfpMCrA==
X-Forward-Email-ID: 6ac2cad35dbe246f1b817a4b
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.18.1
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 1/2] net: eth-phy: Refactor DM_GPIO guard
Date: Sun,  4 Oct 2026 21:53:16 +0000
Message-ID: <20261004215318.65492-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261004215318.65492-1-jonas@kwiboo.se>
References: <20261004215318.65492-1-jonas@kwiboo.se>
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

Refactor the DM_GPIO guard for the generic eth phy driver in preparation
for adding support for use of eth phy reset controls.

This has no intended functional change beside delay DT properties now
being parsed even when DM_GPIO is disabled.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/net/eth-phy-uclass.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/net/eth-phy-uclass.c b/drivers/net/eth-phy-uclass.c
index 1dae26878e61..7c60b3e57975 100644
--- a/drivers/net/eth-phy-uclass.c
+++ b/drivers/net/eth-phy-uclass.c
@@ -130,15 +130,14 @@ static int eth_phy_of_to_plat(struct udevice *dev)
 	struct eth_phy_device_priv *uc_priv = dev_get_uclass_priv(dev);
 	int ret;
 
-	if (!CONFIG_IS_ENABLED(DM_GPIO))
-		return 0;
-
 	/* search "reset-gpios" in phy node */
-	ret = gpio_request_by_name(dev, "reset-gpios", 0,
-				   &uc_priv->reset_gpio,
-				   GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
-	if (ret && ret != -ENOENT)
-		return ret;
+	if (CONFIG_IS_ENABLED(DM_GPIO)) {
+		ret = gpio_request_by_name(dev, "reset-gpios", 0,
+					   &uc_priv->reset_gpio,
+					   GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
+		if (ret && ret != -ENOENT)
+			return ret;
+	}
 
 	uc_priv->reset_assert_delay = dev_read_u32_default(dev, "reset-assert-us", 0);
 	uc_priv->reset_deassert_delay = dev_read_u32_default(dev, "reset-deassert-us", 0);
@@ -159,13 +158,8 @@ static void eth_phy_reset(struct udevice *dev, int value)
 	struct eth_phy_device_priv *uc_priv = dev_get_uclass_priv(dev);
 	u32 delay;
 
-	if (!CONFIG_IS_ENABLED(DM_GPIO))
-		return;
-
-	if (!dm_gpio_is_valid(&uc_priv->reset_gpio))
-		return;
-
-	dm_gpio_set_value(&uc_priv->reset_gpio, value);
+	if (CONFIG_IS_ENABLED(DM_GPIO) && dm_gpio_is_valid(&uc_priv->reset_gpio))
+		dm_gpio_set_value(&uc_priv->reset_gpio, value);
 
 	delay = value ? uc_priv->reset_assert_delay : uc_priv->reset_deassert_delay;
 	if (delay)
-- 
2.55.0

