Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB176C98318
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 16:13:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2A83A60793;
	Thu, 24 Sep 2026 16:13:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V4RA9EgUg4MN; Thu, 24 Sep 2026 16:13:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E603460B88
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790266385;
	b=EZaJxVopaRQWUbwPrwk47kZKNqwTb0ckI+XLScnx0GKebURrH98cZmNvgcV0ZU4coGTA
	 or8ZyangCyC2TVJr4e58uOFzjDHqBlZI13KedznDSw/8p7DiHVe0qni0BpXI9L7xYPdoQ
	 6bY9ozGxjc7UilX/ep3V0ffHkhhJLP4JSSCKw1eQdNAhagVb5EvUlNhExWzw2iBVcTGpn
	 9ISaG+ai2aWudhUinnqNysCnzBoIGc35MWRRYwsEBOj5KFXSebC/ubZ+Uq2ln/snLd3Dw
	 K5BhyCpSy3STW4NWNMUmD3xLPUEh5qkuJtvJfsFHxGcucXj/splsnzGQU30OspW6qrw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790266385;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=NnhmyHJfKbnfcx3MFg7YWzCHPevgVLZGdsX7NmD8nL0=;
	b=P9Uy+4e0N/xh0VZpwPt/y5pQFHwoexwfdhBu866/9NlCLYhEMTvsHTuCNUi4MTMk65Mg
	 TV9a0ZyU/6tZFnrl9YJB7/YBHkWPbmvB/ypx219Lc0qoiY/QK/dFj2B9X5yyUWfFkMB1C
	 0CsLeVjjASfjXKGWE6+9L4yIoone1dOwTIOD+PJi6b2o/1vv1ARcqfGFsLgZTi0ws8NLd
	 D8lULK4wq0STO8qSh02QMCkAWrUbMJUmiiiFFoVPE69SfiT3sgSEntl9iwN7ywGtsLNk9
	 fuMGLaDV2cLSdsD3TqfIalCU2x/wuPW47m7BOwCWaD5uR4/TIdLFWUvfyNKXa1xrV6g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790266385;
	bh=NnhmyHJfKbnfcx3MFg7YWzCHPevgVLZGdsX7NmD8nL0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yE0Y3Rz+Gg/K8gsak7qhucs4W3EOhHgXOcHnziBhC8ZWaoDSACStLV5+eVfGV2tV8
	 R2rGOqtg4XZNcWCHYXcw6tMERIVG4/Xa8Xfn23FO1LlFjq8928Fyio735WnMnWrHbS
	 bYGflwkHuNX5b0dwww6YPrKneGQeY6Wz9U0yRHDTARSd7mRX+aNlE7r7LjVd1LeFOT
	 1Fi6RbDUtbRo4NXqVzSje0peP+NgZPXir5zCqMpYwy6Ch8u1AFqxMCSdfcLpiWwCCb
	 AwHnKBmEvjcsle9IaMSrlVE1JcnEqid+VgCD+UITCRxVeo29RUzSmno+VTWFYih42E
	 4bGkDzbqe4q9w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E603460B88;
	Thu, 24 Sep 2026 16:13:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id BD2AF392
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 16:13:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AED2881E09
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 16:13:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U0sVpYcH9rpK for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 16:13:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B0E0181AF5
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a01:4f8:201:9162::2"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790266380;
 b=DleXjylcMNWsgnBsQWXp6pJDs3lfcbifyNCyWVN7+y14YUAHNtYnWeJQWDpkbpeIe+9W
 eBhjjT2hVvB6zpjTTMKXkHKqIypZmBqei/XgADvjxa8eRD/TarLj0VxPBQjZpe6EWcgPU
 DBNt5TA3hc0PHTIYQGjHOs/UdO+wXq2/gbE/YV/0BMA7EUW9Eo6mITIP0pRagcWtEL4wa
 sqxdxq2+QmZqPAfvE0DKj35WYnYGOcxJo5n2vgIee9wD5tOSr1oBLaRdbuEboFp5DoOh2
 cWP4pDBL3wMIXnJku5qmy1npIcUnVXGzzi10S8rX6/XUOfsl1hFWDIA8+QZAsDzthOA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790266380;
 h=Received-SPF:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
 bh=NnhmyHJfKbnfcx3MFg7YWzCHPevgVLZGdsX7NmD8nL0=;
 b=O9w2IXphVhgZl6ex6xTercajsGLJwfZPbxhQBHrC0JfvDj0F6mLtvxTFffnopWlqYPNo
 UdGo7GmraAH5Gs9ca2jIwQoOzJFqnHp1ym5PFT2M0oJVGIQI3pdlVv7Di8AOxdXESTCJC
 R13GmUAS0kr5KkcC0vs5iDYr0XkRAugU1DojEOomNEYhLvVF2aKsrInkuGHce/62PM/EH
 FbfuSfkn6nTTSd/zF/gkBmh0YQzOFp/x1byz27OszLj8e9Bygbq8eTZUs1RKUsX2ktTmT
 lvt74/C3LLk8Y5S7CjbHOH+n59H6+E8zWYHIYEfMw+7Vpu3wknumvGpScW316cFMgLw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=collabora.com; 
 dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256
 header.s=mail header.b="JMkzc/3Y"; 
 arc=none smtp.remote-ip="2a01:4f8:201:9162::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:201:9162::2;
 helo=bali.collaboradmins.com; envelope-from=arnaud.ferraris@collabora.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=collabora.com header.i=@collabora.com
 header.a=rsa-sha256 header.s=mail header.b=JMkzc/3Y
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [IPv6:2a01:4f8:201:9162::2])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B0E0181AF5
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 16:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1790265830;
 bh=aVy+Q6jwltrMTNZt+aEcnLntumprvsQFnCa+PE4tAus=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=JMkzc/3YYS7cg2lcAFwGn80cZGZM7sXUdHReMZdKqvmi7WpNHTFb2j8InvGfkpnTY
 u1oIs2MiPqVlP8U4h39HemFZsX8ehYh9Q5LI5m0sUw3ZoWQP/Wle0pV87Nd7tDipF8
 4tWx9nOxQWgdtrbVBy9gOwXw8ILkbHdlucTPNhFtvC1VT+XaOGFjduR+sK1IF1KBko
 Tp9OnhnLc3bSUqDsCaAdzWFo4C8CvT1VgCnLAMJbLeS16h/7Rit6Z9cRrJJZuvxBNj
 TkJU5g9RjAC/R2bDH06UxYLtNWuTXEfMfL+q9E2WozxcPbJ4hgBTSR5sa0nkroagvu
 L3GOdGmDHbUWg==
Received: from johnny.home (unknown [100.64.1.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: aferraris)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 05B0C17E0D5D;
 Thu, 24 Sep 2026 18:03:49 +0200 (CEST)
From: Arnaud Ferraris <arnaud.ferraris@collabora.com>
Date: Thu, 24 Sep 2026 18:03:48 +0200
Subject: [PATCH 2/2] pinctrl: mediatek: further increase max number of base
 addresses
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-mt8196-pinctrl-v1-2-4df08627ad64@collabora.com>
References: <20260924-mt8196-pinctrl-v1-0-4df08627ad64@collabora.com>
In-Reply-To: <20260924-mt8196-pinctrl-v1-0-4df08627ad64@collabora.com>
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
 b=owEBbQKS/ZANAwAIAdPrtZZruZGWAcsmYgBqtUnkNA9aFhpnVIhQj2TlO1LYhwmdMLc0XfTLU
 oasouJo+8GJAjMEAAEIAB0WIQR5bbOT3D/0AiK26iLT67WWa7mRlgUCarVJ5AAKCRDT67WWa7mR
 lhQ4D/90JGId1DJbC19nnQ8AnZYUu3quaphv/D2iDfZFvuFWOR9ZETJBkdlYqDmsM1+7PZL86AD
 k8ML0JOhKHXj13cWetgwigdDubqWQf0SoOfLZGpQc0i+EVUWJmGjhNSk3X8bgLslZcNm3JPNiD5
 iQfaI2vECfDOH8nOZ3qXbeBnCoEpzgHlzT6X33RajlXCOotKfxPYxnrp0hrXXumnjzl14klXwbO
 Y6GUQ/1IUQVU7e0wKCuspwgx5YISpGwQwa5UZlzih0YVHsuS7BJ+qKubdrYB6U0mk0NyvA/YqgH
 bnm0GGJbh5r+4fSeqMrN3OeAJ4u6zhEnCQ0QETicD71XU83lIDcsR/6RukJxZ7rdQdvUKebcP6q
 Y0zAWoBZv7NPZ9T0adh86lrFoedhfmAA9SWv1Dp4IuA/aTzvNrw6eFkemPPYi+M1Zt2sw8HHSpj
 x2O7HPlZNCNWLwpweGlB4PPkFuJkjHBytWkZy4dKV2VxF5lRZ/d34ussh8il9RY/l+1i7fBSpx3
 OlLobm1Hnvw66jdjUdrpn++hfEjrIHX+xtXRZEgii4daaTWjwPj/J+5rsKC+PPFzS0Yys8YUVgV
 zypx9dHTZrFr8rBgcFlv7WGhPNiLTL5Ae3giw4sxRU3uEvTdBbRCrL8LYWha/V/Ku5QI9o0Zo3r
 IIPawG2IlJBWunA==
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

