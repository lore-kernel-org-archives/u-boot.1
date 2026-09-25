Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9241BC98325
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 16:06:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 54F5C60D8E;
	Fri, 25 Sep 2026 16:06:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J17gFGN6o2MC; Fri, 25 Sep 2026 16:06:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9DBF160C13
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790352369;
	b=eckMScgUtU78K2xN5A0IWx76Sm5tXfJSVDKHHTytrmyAzHjqU8QFycz8yIPxGZCo3Ejv
	 W8nX/dJmvycgTyUi/AQ6kNEh94N95cDCG6kFxwq+eEoYDz3aFO9ppnCkVEfy46MG8nbAk
	 XlZKnfMsfshjdJMqyBeP/GZeWzsZuPjhlTBV+F87evO+2qJT9A4a473lYFONDsLXERG00
	 ydnOboNnfDc+joQ3nKndcwtIWrmDWyY9+ldePpItKzfPPxsMcrznWnQJN2gNF9zgu4VNh
	 wdvKXKwK403chxVMAKN0DeCHagbbViOVgxi8S5pxBFFYu1nvMwmuHhCycspWgSYmWZA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790352369;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=NnhmyHJfKbnfcx3MFg7YWzCHPevgVLZGdsX7NmD8nL0=;
	b=rYPnZr3/MR0FVyfxGAHv+LYYekcQqU5zTaHzlsHK8jJHFzbgTkxYeycbv0VID2Ol2n+Y
	 nJQVV5JpESo1qLboqtzJ9azuwhAGELkax+8EAq/OZTGcKxwZYjamT2RlQi0NzkAvVlufQ
	 xgLPVs5ZgwtU2BTzrcndmFmLTzNnnsOwQh9JqzlMx85/YccDI2N0TJIG0tl+fYbGYL1Ox
	 wr+pnf8lw3k7s6OVtE8eDIxgPq6Uh1Y1+sUSgvYLB03hLICpVJyeEtA0giFqELItqJ/jh
	 fTR15dsGD9glOwn/cVrD1ZxykRHVDDRFfDz1WGQjwqCaYZmToRfiQOkjJZx6NLcmslQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790352369;
	bh=NnhmyHJfKbnfcx3MFg7YWzCHPevgVLZGdsX7NmD8nL0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OMUulgi7PH53D/OErRxmo3zBl68PAOaUvcjnZETjTYIXvLUxNtMiYfv/5l4x1C4AQ
	 zLAtlNYMF8ne0JTshtWtJAOEp2jLgQz13Fctst/H3K2/084QMKwBXc1MFA2igdpkBS
	 NPUUG5Bjq4RmLhpmURvfDhwJVkVx81X1t+sFR7SSzuThZrTN8ivMqzqMPgyLmd83DR
	 kFUUAFVkUbVgW5vbICHCrdKS+bOLafRJ7u9AQdG7ipKkS6lTR+6EBy0/i+GxH9MXBP
	 EMc9wEQ9sQAMkDwN52S/jCgSwtkUhNOEvA03bq5nWAFR9sOtsNZRkqmOOTMineufDB
	 uDvLji5EEs/sw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9DBF160C13;
	Fri, 25 Sep 2026 16:06:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7766C35A
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 16:06:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 74E788130A
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 16:06:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m2pL83xYmLPX for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 16:06:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 914C481309
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a01:4f8:201:9162::2"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790352365;
 b=DD76MLSqdhdXO3inRBQDDSZZ/QDOewwHCMHvHkOxgwZZ2iXzz/kx7WwPyEQy7qEHoG7h
 ioveBeAWc7nmMw45s2j0T1uJM0ZTArPziEiWRtz7KNTGEND1vus9OxOu7YNnARxR03f+R
 PXdArSkpbdotZwVqLfIHxoFqmluzUej/KWQajLzh4yUnTEtLgr3l7ZCKHqNF+/uR6uOj2
 LLXuAATxKOcCzwZeWz98fndtiBWLRlx7KAZ+tjCi6ejXUlUHJCRaToqo2uetiYyNtVoV7
 DoEwr5mtDvqFb4aFkSLOX62Pha07O7oDA/V9HmmHLUWQYONtvKkntqxUdWKDMOwhuvQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790352365;
 h=Received-SPF:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
 bh=NnhmyHJfKbnfcx3MFg7YWzCHPevgVLZGdsX7NmD8nL0=;
 b=Ly65X1mp7OHBOaHwUR1qrnljxAV2KPkl3TvEk54OWeZIxFoGyeBDlON4CHGr/RdoLeo6
 L94lv1+2E3Di1o6nixwdse/qVAOyNW3tr0Et+L8eZrD4ivRvpZxnMEVo+VODzWs5J+RHp
 b1SDpDxzpofYDNBJ0/upS1mtjxJnrHeSdk1PCDeLId/+fekq2lWzuYd4ugfsmgvyBKf4q
 cD15w8oNTdWl1TMN6e2xU+qITYNio9Xpy7GbkQU+zNxxRplMhfBFgxzuLJBV6cNnD33Gl
 /dTkzyHU4A81PhjV5yPP2uovil5CnacCh1rAZFqSfqcAAT7pqPrNQ0LhJAfEucfts5g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=collabora.com; 
 dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256
 header.s=mail header.b=LzK0tsBc; 
 arc=none smtp.remote-ip="2a01:4f8:201:9162::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:201:9162::2;
 helo=bali.collaboradmins.com; envelope-from=arnaud.ferraris@collabora.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=collabora.com header.i=@collabora.com
 header.a=rsa-sha256 header.s=mail header.b=LzK0tsBc
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [IPv6:2a01:4f8:201:9162::2])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 914C481309
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 16:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1790352362;
 bh=aVy+Q6jwltrMTNZt+aEcnLntumprvsQFnCa+PE4tAus=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=LzK0tsBcsgXBjUGTNG3bcXI4lTC8epP8qeg4xwRMT/QgIxar8c3yMmB6dznpN4rQA
 GpvSN6af1sXlOwHowjKKInlUnV7/4uVCRBwka3rzKjS+MU6UQM/hDEvreDujnC3Q+V
 1i0VAPcfgXultlf0cmmPHz8wVhpG3nyJwhwgyD/XuFOAIH5jAw7L8r8fk+5V86ZoK4
 KUDME/mzcDaj4HgG4q53HPE7TT4e6HVwsmUpiS1HytjAUUZNXQp46vu0xTMPkHtykh
 T4FIgvaYML12D23Wo/g0EKddsRdIF2AAOvG0VNh+iDqoDLRYX+oP3q2kSQcCygcB7G
 RQS+93HKG9jbQ==
Received: from johnny.home (unknown [100.64.1.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: aferraris)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id CDC7F17E018B;
 Fri, 25 Sep 2026 18:06:01 +0200 (CEST)
From: Arnaud Ferraris <arnaud.ferraris@collabora.com>
Date: Fri, 25 Sep 2026 18:05:52 +0200
Subject: [PATCH v2 1/2] pinctrl: mediatek: further increase max number of
 base addresses
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-mt8196-pinctrl-v2-1-edf1aac8868f@collabora.com>
References: <20260925-mt8196-pinctrl-v2-0-edf1aac8868f@collabora.com>
In-Reply-To: <20260925-mt8196-pinctrl-v2-0-edf1aac8868f@collabora.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Deep Pani <deep.pani@mediatek.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=737;
 i=arnaud.ferraris@collabora.com; h=from:subject:message-id;
 bh=aVy+Q6jwltrMTNZt+aEcnLntumprvsQFnCa+PE4tAus=;
 b=kA0DAAgB0+u1lmu5kZYByyZiAGq2m+iiF2lovoA+iwQhQjMx+ry/ZBYG/8888NRmdved9Qxe0
 okCMwQAAQgAHRYhBHlts5PcP/QCIrbqItPrtZZruZGWBQJqtpvoAAoJENPrtZZruZGW7ncQAKUs
 X2hnTKh17TWc8kvNG1d8S1jOImlwQ/zLbHn9R+JXND7jWMPXtz4ZW3x1rOd8aQKWmaUKEZ4v65e
 FJRl81XBRNllJAUBSaJwBhEDyoedy4/F5xHxohRdTngSua9f05nlC6JyowkXv4HXiaTd6pvclyP
 +0qm+Vaof/rfw26kujJHPlznYXxkRnHy2L7MT6KV2KrUzJV6G9pIzxwuz/JgBnjRd/Rr5+YSUoE
 dCQIHbyP2hfuDHNNvO5xLxcwS1ye8QZetRUfNlRnSx6MzjTTF+4QbNl4/L5LgDv95Lp/rx/SKuC
 JVMoNRM7kXrvxqjeqmGl0FmTy2qKM0zvFlb2bfEK0lEhe9JUSxxOvMIcwQG3B8rWjoqv7zcV24G
 Wie6tOmWwiDvVkr7ZtQx1GbYNATNLg2eOjccQ2N1x6DYxNqiyT2+kyJktu9MUqVkrvGvtdjlV8Y
 sylNyx3Axt5s4G5ubpsytH4pQD3Kuc+FJdM2shSpNArcYO7Rn98ptzxdl6NjGJNilx2BAoc+/ye
 SnulzMJLZjz1v0Tjf73PUl7me2JBu0gIy+VdbTSFWIpJtETnzbSOcKVeYlZCNmaAO17xh5TPQ15
 FjDVzvLL1BAtxlYixLOxtYwg3LItM2JF3xrUfVObs1glcNlrXbkrsKgywVyjZbE5wsv6p+kN3CH
 Mwc2w
X-Developer-Key: i=arnaud.ferraris@collabora.com; a=openpgp;
 fpr=796DB393DC3FF40222B6EA22D3EBB5966BB99196
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

MT8196 has 16 base addresses, ensure those can be handled.

Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
---
 drivers/pinctrl/mediatek/pinctrl-mtk-common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.h b/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
index 1f97f3cd7b0..82577b0c43c 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
@@ -9,7 +9,7 @@
 #define MTK_PINCTRL_V0 0x0
 #define MTK_PINCTRL_V1 0x1
 #define BASE_CALC_NONE 0
-#define MAX_BASE_CALC 15
+#define MAX_BASE_CALC 16
 
 #define MTK_RANGE(_a)		{ .range = (_a), .nranges = ARRAY_SIZE(_a), }
 

-- 
2.53.0

