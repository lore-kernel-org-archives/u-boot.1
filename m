Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 350E3CCF2D4
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 01:42:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D7E2980F92;
	Mon, 19 Oct 2026 01:42:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SPpHgXcvpgKQ; Mon, 19 Oct 2026 01:42:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3C42180F91
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792374143;
	b=Rq23/Ji186Pzkogxa0ohBpIUux08QELaygArpDYbCCHV5lC8XnxSENcVYN8+UZuzRJCq
	 9DAwpanuRMYpAqwF0oJH/TrmCzk8YrCKZOxNAwS958XLno18wEY8JMvXXvZ8DxgN8LLl6
	 twyjoCYLITXOivuMT7qw4yaoVzNG3854v6YjQUYhzAs9BnGKYDhOLMBOUqWw6gKcv+jKk
	 o+dgP6E3OOWQwyMYVn7BfJY5Lg+eoWAwYN/qbABrPTjta8ufVDiGaEDWYpu51viZ99gAn
	 V7mOUA2KNiu/SZiKgQFOLMizrfCWq2KIiiYw7f/mdOagcuBrMOkCDCBM8yIA1eagrKw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792374143;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Iudlm15DiFvg+Bg9K7eLzpMSkxxDt0UORGygAQ4oxsI=;
	b=oM+0BZdWBD+67obZMvzvjasVmqOXC39X3GA3YO2ey3Wksxs/y1C8qOs4VQO2pHRUmQXm
	 K2U//MsusFICXE2HUYC3PEWDbmQ4y6hCOm93uMwddur3KTCS9ZsMII+2SWjRuxJbvqGWZ
	 /c+5IUJhNvE9LD/N0njzeX65IEOPZ3f/ZS+r8E4g+3Z2Urcu6GzxpmwZXe3xyKcGRZad1
	 mMpICuCt1rH8nOn6TF7+Qp+4hotszTnBfdKFgNPMYNcoyz4BZEUDPrJgcFyEXvahEuTXk
	 ghd5GoszY0kkdh2/MXDM5tefwZxH/jXjdonlwcEMJGIiml7y9PCllye4tOqsYL2sSVg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792374143;
	bh=Iudlm15DiFvg+Bg9K7eLzpMSkxxDt0UORGygAQ4oxsI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h8o0HlZ6CgE1zCJ0186zn7hKf0x1okeA6JYDopJ4ojjBiYmfy9cXed9y0EfM6aB9e
	 UCbjM/4EgSotUXjWSM/QRUu4Gs8u1TQGOL1mtp8wzw0+dQchGEOebcBl6LD2LPuOv9
	 IFNhQy77n/RaTrxzMxMyCOApznk0ZNvbood6k0XonUnirrVEENWPH7QAlT9mg2QI8r
	 WVRzNTkXeww4q5T1iAch64KRz6NA/6L0WxzFB8ZYjpOdjERJ/nPKlw4OfgzTVxjRYD
	 C2smfD81NEh/XW7tZbtJWNpvHxccSV8t9/9S4srAjSmBBtg/pwWIGcgsCjIw9K2kVx
	 jGYGAavy2hnLw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3C42180F91;
	Mon, 19 Oct 2026 01:42:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 91EA2769
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 01:42:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 77F854007B
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 01:42:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zDJywBPnaDYn for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 01:42:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 18FAD40064
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=116.202.128.144
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792374140;
 b=H4ug+yldnHGRNPH3h1crNjnettYiuSL/cpbQhqV7g7ksO7hmhu0kgseRy+cgk0v26/GI
 brdffC4BLMfKo0ERp/lk3OpbGQA6c7TQVZ5COI5ut7cBr5TGZCq/I/lehykT/6L+HcYtd
 qvIgIVIr42SkaTswwm271MfViTc3josm0KE28jEPymCpnYzOjjhFpFZBS9XymuL0mHVnP
 pQp6DQ3OG4IAfs0yHiYZbgNKMlxguwCf2famXOr1qjr1RNOuVqDHmDeeQV61AUrdGhear
 epvl986gglXDHfomGKUwR62MZrD01LtWYvf3MyGbLdrSItjI6QeZtRbJtpOgDF3/p9A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792374140;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=Iudlm15DiFvg+Bg9K7eLzpMSkxxDt0UORGygAQ4oxsI=;
 b=mzzdZWdVsNWRNOI6tL0NvFPNpfwQfDX99ittI8LZufkVEiTMdAQmU7y+wxos70p7EwJs
 HwtzzBty68K7feBbKtGPMDecNxXolgmo2YLDe2AOSw6FNh1U7lywirFqSILWixKPQtH0a
 UtiO/zQPcG2P9mJAfyUetb3W347/bDsBOCiYqnBsMmdoDWynKRE0/PTstalEJKtNmEL2/
 9nCiw3so1ttha6W60x9HbfOCqIj/a5pV6N0VIwAKDh1To1O2uJ5DuyJkSIb63MujUyBNB
 vNcepuNAys+SnoBzm8dK2WXXiVSK4BS2uQbsX97GdiHAudjqcrzTFLt/jXYteLW/1kQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=freeshell.de;
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=Xdp0c7g+; 
 arc=none smtp.remote-ip=116.202.128.144
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.202.128.144;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=Xdp0c7g+
Received: from freeshell.de (freeshell.de [116.202.128.144])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 18FAD40064
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 01:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1792374087;
 bh=Iudlm15DiFvg+Bg9K7eLzpMSkxxDt0UORGygAQ4oxsI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Xdp0c7g+0M7EtHctOJgZrdl9Ddyjq83cx37sO4oStj7i+BupX6pEF73xACTcqEZsC
 Zhz8B+ZzAdWLD6YBIp0UEOI1trshT/ViNbaJNVimMcqOJNcEsizpmsDekWrRFiCPkx
 rEhxNcUMdVRpiC+UA5zulEcC+vYwqaYrv0l2RoG/tK7n/EQ9o5WYdLh2NkhToVi2Fw
 bGubCuqd0FJzuuTCp5GBwTDlAILt8LaF5zRBsx3DY/vmMHCmwxOCoTfAnwRignNLGC
 wU+b+bMzf4XrwGSXyPMh9X+YMu/mAgvxSgWnDMUD54IL+OqgAZZc1pBwbdQM+loJI6
 jcpmLN6JqCHdg==
Received: from hay.lan (unknown [IPv6:2605:59ca:364f:d400:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 88617B2201AF;
 Mon, 19 Oct 2026 03:41:26 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: u-boot@lists.u-boot-project.org, Yixun Lan <dlan@kernel.org>,
 Tom Rini <trini@konsulko.com>
Cc: E Shattow <e@freeshell.de>
Subject: [PATCH 4/4] configs: spacemit: k3: enable eeprom tlv command in main
 app
Date: Sun, 18 Oct 2026 18:40:21 -0700
Message-ID: <20261019014044.698294-5-e@freeshell.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019014044.698294-1-e@freeshell.de>
References: <20261019014044.698294-1-e@freeshell.de>
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

Enable "tlv" command. SPL is not yet upstream so this is only in the main
app.

Signed-off-by: E Shattow <e@freeshell.de>
---
 configs/spacemit_k3_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/spacemit_k3_defconfig b/configs/spacemit_k3_defconfig
index 586305c62322..66d1a36c79c3 100644
--- a/configs/spacemit_k3_defconfig
+++ b/configs/spacemit_k3_defconfig
@@ -22,6 +22,7 @@ CONFIG_SYS_CBSIZE=256
 CONFIG_SYS_PBSIZE=276
 # CONFIG_BOARD_INIT is not set
 CONFIG_HUSH_PARSER=y
+CONFIG_CMD_TLV_EEPROM=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_DHCP=y
@@ -44,6 +45,7 @@ CONFIG_SPACEMIT_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_SPACEMIT_K1=y
 CONFIG_MISC=y
+CONFIG_I2C_EEPROM=y
 CONFIG_PHY_GIGE=y
 CONFIG_DWC_ETH_QOS=y
 CONFIG_DWC_ETH_QOS_SPACEMIT=y
-- 
2.53.0

