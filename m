Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 868DBC982EA
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 09:35:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 36C3680BB9;
	Wed, 23 Sep 2026 09:35:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id emj2WRiyn5XQ; Wed, 23 Sep 2026 09:35:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6641180C80
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790156110;
	b=P3WdVXpInBdpafrN+OnF/oaKpFR+Tp+TO8E9JsVFYmdGfRAMhVd5g+E4AHQ5YGsAzP2e
	 PjBIyVm71c764BHNuSagN6VBimADLn8i8fTfkEbXcef5p89q8ax/itPtqV1b9/QqMwNnV
	 rEgGFlXUNNTFv+zUGTpU5CV2Pl0TIW/FCuQKku/nnWVlbjZtWJE38KW6P+ZC2H/M2SIqF
	 ygD4ROx4mn1GsPQk5l4pDFwUcB4FKkKAhB2ZEi5JrsVPeu2BRQGHOSXA5V4DPThC6gl5P
	 6F1ep6Ek1YXNnjvVvu+iOc/V1NFqUtR3f6als2D09/PMVJgn2EdqS502Gw2HZWxI7sA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790156110;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=xVDLYm7Vc4eS7g7lUhStZtpiZZEIXN58iH76x5D+dEk=;
	b=gymzPW9s5nrfUC/shA+aUOVuHCBERQC1EWWNa9gtY/wcrssuF5t9oqq5RXgYAmPI9MSy
	 MG+y5x/0VgbY9iWL0iFBhXi/0Tr4qezcNuc4LPUQYeYlp9VK1tyzvwWssbgS6E4aMydVG
	 SzFrjVektoLnKYYsIpz3XQvHroFkqUMeovzK8DkbpMYZU8dazl4Bks83Zgsaw+usJ5Si7
	 CeTnuYaduC80bbIavoM+nSApcuu850MhfBXGDPibgDqioivOtk5MQlaeHIK5Zu4/cqP80
	 tYZ1TJ8jmGn1Hi8AI4KM2TEdPbHlNU/0ormZkhaoErqMFjUnhDz3RrmteZSZRkHE2dA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790156110;
	bh=xVDLYm7Vc4eS7g7lUhStZtpiZZEIXN58iH76x5D+dEk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HuJjRVpI9Z4tCkO4xLV+yFe6QQjqkZTKAmiIH/Qv+czazrwaGvqwWgq+fWZtJCzq8
	 /SPkFPLBiult/4TeACnO9YjxWNTrQZYqT5LJKAzseSbt0V4r4OYRIyt1ZmSWTm8An9
	 tu7uLg/NjpS2YJm+6MxNB7/uGs8IwwWNAaUC1DAjSsreKO3CulHzhuTKsB3pnkwtBo
	 jPb2/PvmJR6oAyvgh1N42tQZTDFYqSNJMk2kepLZ5MZg4CIocMDAWtlWN4mVMwTytc
	 Wf0WD1AwrCMfzsE9HHhgfqWlQJci9NESenFLNx89HZAj3Yk6ogdfXLYhv7bh0IudqR
	 Im1CJri8NarpA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6641180C80;
	Wed, 23 Sep 2026 09:35:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 70889194
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 09:35:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 56E38405E7
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 09:35:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xIkVQ9JK9XR9 for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 09:35:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9F00E404C9
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790156106;
 b=SEiGc1vWDOzD3TYtVcv/IVBxClh8ftn1sd80U9qhAvNC/T1PMDgThRmkfirYVo+CPuHY
 xIegQsuv3vNtkXmbM0T7A+6kUTJiIY48+ioyq2rwyO5EO5mr48lBo/MuWJwDTy8frfMeA
 FlLuwXCc9mO8jGKEleB1qpb+kiOv7KTI2cK7QJ7qZqUxm4hRsZBFeRd8sB6lPbMnDxw/M
 RndMV2h37B4Eyosk0Pc9TSA/MMl7jY+QPjcuRDiCG4xEROZwUFdPFafQxi8JL9tQlO3O8
 befAC8VyiQWvaJQykzaJxrs0FWSlOsdLfQ2WDslceMTaYFXol4Ki6PmObWP3RkrSB6g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790156106;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=xVDLYm7Vc4eS7g7lUhStZtpiZZEIXN58iH76x5D+dEk=;
 b=pHdEe4FXrt1raycz0LDZBgbZbJo8KwFF5cQj00eITX7IayMqAFDxin1uHsnZKeZPqUIl
 w9kqatlab862jcMap2D52Jk8YCkRkWWhap4L3cWrUoA7VZq/E08a1DyEiHZvC/obssKcg
 qEx9glU6UMEWxeaeyPxw1MBGcbbipPzYiKbvHsIFf2P24att6bheaDDs4yK1do2oVqq/h
 qy4Y5DUznhGmaYi/FOYNbmJYT7tlMm0as2DvxJoJ1gginsY/WiABjPobOG++mAAr7Yb76
 4H8d1wnVw7SZA1UTICQPrqLGtrWByPkiYTGUp5vOQp58t52HKP5CRyPnPWO8yq1CGlA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=YFXzSLWM; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=YFXzSLWM
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9F00E404C9
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 09:35:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 66E9C40B70;
 Wed, 23 Sep 2026 09:35:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C711F000FF;
 Wed, 23 Sep 2026 09:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790156105;
 bh=xVDLYm7Vc4eS7g7lUhStZtpiZZEIXN58iH76x5D+dEk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=YFXzSLWMiAgjrPzz+WXvfa6dOMTPMk6g526ZW54x4DQ3ohUq8rZlWNZb8cJJvzIa3
 jBQLVbY8iu3gBRIc1i6btYi4i7O40vnP0eVEjHZSHRAwvKjz/4A0Qof994hrkDI9i8
 CU0ANQtfwC1PHMIlFwp5lJa+LliXF780R5vuuUKROa8KQpwVkIq5hnoP2v4xvVMhbU
 tcFTx9Qldwp4vFeq2iXzMaA+lZIlfxYkHWt2Nv2p2ghXR++lo9z/GgGln8cjbpnXpq
 XVdlmdG48aMGVtKFNcddLBISkJd1D0Z02kqQM3MlXCrs9sDOphQH4PfYWWBKlrD+o3
 b5F4eSGPrcXmg==
From: Yixun Lan <dlan@kernel.org>
Date: Wed, 23 Sep 2026 09:34:25 +0000
Subject: [PATCH v2 2/8] clk: spacemit: ccu_mix: add inverted enable gate clock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-01-k3-clock-reset-support-v2-2-6ec0abb1c7b5@kernel.org>
References: <20260923-01-k3-clock-reset-support-v2-0-6ec0abb1c7b5@kernel.org>
In-Reply-To: <20260923-01-k3-clock-reset-support-v2-0-6ec0abb1c7b5@kernel.org>
To: u-boot@lists.u-boot-project.org
Cc: spacemit@lists.linux.dev, u-boot-spacemit@groups.io, 
 Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Guodong Xu <guodong.xu@oss.qualcomm.com>, Peng Fan <peng.fan@nxp.com>, 
 Torsten Duwe <duwe@suse.de>, Ryan Chen <ryan_chen@aspeedtech.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Alexey Charkov <alchark@flipper.net>, 
 Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3297; i=dlan@kernel.org;
 h=from:subject:message-id; bh=NRLwp8NB1IxmSa8mEQExvHg9nJZQbtlW+HLuENSffDg=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBqs50p/OEdcNrXnpI/Fjgp2feQ6M7VGpD4aPRrq
 KSwtnzWItiJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCarOdKRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+0aGg//RpiWlqlQI9k2UbhWQRQVypkvbR5HcTRGdcvHfRWAF2cu2exHKNCSn
 4ONHndqBqy75rJbL0afT0ikstLTsjGDnPlMI03pGUsZAgdsK9w/pdSw8++T3JETEAGFnrr1BRl3
 6ahojMf5whxaFTG7kE83BauuV5SZSIBHecUYjzMi6PXOX0p82znr9Jl4ajzbv7mNHpwwp/ApjKe
 uDrawJG/CFpFgDpQjAvq158ZfZhgyk/rEzQwG/WAYpILSRem5G1Zw/gQFFhPOLObVLOh0Wtsd+1
 6Ai3S3Nf4HZGMtDcXMOvkefZNALgwHzk9d+tC+ZL0lwW217zglTzTCzUvFByEO/jTtgwKe5rsoj
 s4rfCBufyj210CMLp6hCAD/UDhjJQxdKQ5icNvx7oINMseEpoOk4pybbjgeT/IdgtjR7UP+QAEy
 vr7hu3ScEYTKV55WgRP3nfzayV63vUdLAVTwvikBSnfqnP9aFKILmTLE80puBDLN7I1joJyz74+
 ee1Net4PqhqdAKwe8Z00AVaz1qqH6Ksj2Xl1I0/mpW0P5F+N+FHDgOZCu8kOZ44/CHTbJx2/3xf
 M8J7xnMJ3/ObZloeCfpDB0s2bwfIecEZi3LRuPwyOnfGk1VD3bQZevy6dsXy0T79cu92g1pxzXO
 JYtDDfaPhYF9zpz4bHWyh3+jM3Bl90=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55
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

Based on upstream linux:
  ace73b7e2763 ("clk: spacemit: ccu_mix: add inverted enable gate clock")

K3 SoC has the clock IP which support to write value 0 for enabling the
clock, while write 1 for disabling it, thus the enable BIT is inverted.
So, introduce a flag to support the inverted gate clock.

Signed-off-by: Yixun Lan <dlan@kernel.org>
---
 drivers/clk/spacemit/clk_mix.c |  7 +++++--
 drivers/clk/spacemit/clk_mix.h | 17 +++++++++++++----
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/spacemit/clk_mix.c b/drivers/clk/spacemit/clk_mix.c
index 45bf2c72375..b0d1a506851 100644
--- a/drivers/clk/spacemit/clk_mix.c
+++ b/drivers/clk/spacemit/clk_mix.c
@@ -33,8 +33,10 @@
 int ccu_gate_disable(struct clk *clk)
 {
 	struct ccu_mix *mix = clk_to_ccu_mix(clk);
+	struct ccu_gate_config *gate = &mix->gate;
+	u32 val = gate->inverted ? gate->mask : 0;
 
-	ccu_update(&mix->common, ctrl, mix->gate.mask, 0);
+	ccu_update(&mix->common, ctrl, gate->mask, val);
 
 	return 0;
 }
@@ -43,8 +45,9 @@ int ccu_gate_enable(struct clk *clk)
 {
 	struct ccu_mix *mix = clk_to_ccu_mix(clk);
 	struct ccu_gate_config *gate = &mix->gate;
+	u32 val = gate->inverted ? 0 : gate->mask;
 
-	ccu_update(&mix->common, ctrl, gate->mask, gate->mask);
+	ccu_update(&mix->common, ctrl, gate->mask, val);
 
 	return 0;
 }
diff --git a/drivers/clk/spacemit/clk_mix.h b/drivers/clk/spacemit/clk_mix.h
index 26a12cedd0d..4ac61b55546 100644
--- a/drivers/clk/spacemit/clk_mix.h
+++ b/drivers/clk/spacemit/clk_mix.h
@@ -20,9 +20,11 @@
  *
  * @mask:	Mask to enable the gate. Some clocks may have more than one bit
  *		set in this field.
+ * @inverted:	Enable bit is inverted, 1 - disable clock, 0 - enable clock
  */
 struct ccu_gate_config {
 	u32 mask;
+	bool inverted;
 };
 
 struct ccu_factor_config {
@@ -48,15 +50,17 @@ struct ccu_mix {
 	struct ccu_common common;
 };
 
-#define CCU_GATE_INIT(_mask)		{ .mask = _mask }
+#define CCU_GATE_INIT(_mask)		{ .mask = _mask, .inverted = false }
+#define CCU_GATE_FLAGS_INIT(_mask, _inverted)	\
+	{ .mask = _mask, .inverted = _inverted }
 #define CCU_FACTOR_INIT(_div, _mul)	{ .div = _div, .mul = _mul }
 #define CCU_MUX_INIT(_shift, _width)	{ .shift = _shift, .width = _width }
 #define CCU_DIV_INIT(_shift, _width)	{ .shift = _shift, .width = _width }
 
-#define CCU_GATE_DEFINE(_id, _var, _name, _parent, _reg_ctrl,		\
-			_mask_gate, _flags)				\
+#define CCU_GATE_FLAGS_DEFINE(_id, _var, _name, _parent, _reg_ctrl,	\
+			      _mask_gate, _inverted, _flags)		\
 static struct ccu_mix _var = {						\
-	.gate	= CCU_GATE_INIT(_mask_gate),				\
+	.gate	= CCU_GATE_FLAGS_INIT(_mask_gate, _inverted),		\
 	.common	= {							\
 		.reg_ctrl	= _reg_ctrl,				\
 		CCU_COMMON(_id, _name, _parent, spacemit_gate_init,	\
@@ -64,6 +68,11 @@ static struct ccu_mix _var = {						\
 	}								\
 }
 
+#define CCU_GATE_DEFINE(_id, _var, _name, _parent, _reg_ctrl,		\
+			_mask_gate, _flags)				\
+	CCU_GATE_FLAGS_DEFINE(_id, _var, _name, _parent, _reg_ctrl,	\
+			      _mask_gate, false, _flags)
+
 #define CCU_FACTOR_DEFINE(_id, _var, _name, _parent, _div, _mul)	\
 static struct ccu_mix _var = {						\
 	.factor	= CCU_FACTOR_INIT(_div, _mul),				\

-- 
2.55.0

