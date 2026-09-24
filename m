Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF0BC98324
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 19:44:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 988D881200;
	Thu, 24 Sep 2026 19:44:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WfN_BHWnQk3f; Thu, 24 Sep 2026 19:44:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D94E7811ED
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790279041;
	b=OZks0bMnb2HCxNT6R78KaCc7IlA2opn1YTiBbpHN8f88xg0Ivr9vOyqysgriCo2U0deV
	 tDD11+kto0METO5PlF//a8XpxzCeIn0G96pQ0Hc94eoHASHtuQ3LCk0iSdSQIKOBNvaVC
	 g/H5ibxMBLnRjGv+bWuDqjOPLPuICKU04ZZ3O1hnCTeDOAj7vA1z37PGy8IA2mYIVIn/a
	 GWD+5egymqpuc9E8TEX2ArjzvvqJkV8PduLW9Cbcv8AnpiDTArNgqJEh5xSz1TxAs9HtK
	 v8ApXN1Uo/jZ5L0ZSP8y5i2hQ5ul/1L9J5Hjr7YxYV5Dzlpqu+d05/VN26oAmdjG9tQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790279041;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=IaoGDS8LMCQrsoz4EaqFnr59umdIzmo511EpshzzFCI=;
	b=A0JxrVLyWAiXOcfYMr883MwKYXfeXt+Uo8miShATmHb2FVVYVhBkvR5qF7acs//7V1TA
	 r7+UT7J1KPjyfHqCMNVnCmnX1SRiepTwFfxQBe2NmhQXEAcbl+nizagU8s4UPF2I4Dlsk
	 MD/AieQiHlqTMCoWSqCflDUai50N2/+D5QG1kcQwT8M6fDerCuZrsfPhTpFSBSjrzHwwE
	 yf1+7KK7pCTbq1U1H4NUmQhdslCeqnPcHSpDHN5Yzdtblk/CQoc63nF80b+3cTbIi+SR9
	 XsbdkUwKWK3tYiYWUsIHDuUdfyyUY88zmXTfqy1/ZweMW7ijkXHwhcDcBHK1jfw88Qg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790279041;
	bh=IaoGDS8LMCQrsoz4EaqFnr59umdIzmo511EpshzzFCI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LANii3wbe0ic0j0smRMjP33oNg1AfSbb0vYzUUwW40IqXjadsesF+VL/0uWPXbfGA
	 PRphgVRTbL7eQGapfZFqnMqs35kYpTq2IDWVYb2qn5eEfuvA3MfBwfqiGykC/umTUt
	 vET7VhPYrUykQBm0XxcmLS2J29BL2GcQ7Igtncui0LBQb+yBQjh2fOCVHD21P32k1+
	 1u7q7BqQxzbUWUWgPlr+C2uBs9xtccGkkwMdS0Z8BZ3ukjl/D0tqG+8+XPlnwDOU6i
	 wWffYW00lGIUISG1JMD3N+KhELdGM2jK3j8Eh2XxvB12B7u6PrrOs+oCMtpupmDRPq
	 stzrUt3xSDuPg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D94E7811ED;
	Thu, 24 Sep 2026 19:44:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 441582F5
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 19:43:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 36A57404C6
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 19:43:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dxtJwA_3rc1T for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 19:43:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 7F16C4017A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::29"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790279034;
 b=Um/0hzsMMHtikCRdZ8su09ZuYlZVsLhUHeTa/Nb9f2h6kjSJ9GNM4rAMP5ujs+SV+yjm
 fi6iWIQ4CW9Qa6EhyBLoui1SgNkDvpkKQCLqj1v0D+oP4xajVWZFqGLMv/yU+OuX6zlj0
 JSqvJzB8P3QgqHGLbygGw/MRpcxh/qWFZL+Kt+7nUW1PtoGKmLuak3p7kNmNvyVlWws5n
 HbycGDZrGajVbSZlFOgQzTXP2DreDRgo/xIp/2zyGhmdG6vT1qcztXBbETs8oycWuWNt2
 fYGABpVLGh39DJ5LITjVGjyAEN0ViJOQsmNZuYO1QfSVXPK0XHyjVa4W0n5PvvzrGdw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790279034;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=IaoGDS8LMCQrsoz4EaqFnr59umdIzmo511EpshzzFCI=;
 b=GtFtxpRduNAsRdPcPQyT8TyLCbdl7Gw35/zRpEK3wVrpemITp7CwOjMN6gAVi5bosWJ/
 IKJ/6SZhLjcnkShnuobfuD2twKE2kMoMgiSafepMnSRUnk/ljux0fEZOvKKRx5hO0C4m4
 VPb8EWIo8lmTxaddfLGPGnmD69LOA1eRO12tJKqqkBCZyWAH0XQ6FE1DXkjz97qzV/hzj
 eume/zd2BHGH/IPVoY8NtXWw8s66B6rwFmB1TyRq707+WFauBINPacHrAMygMK5CC0YBY
 Y3o98b6xrvrxNlYkl7OUqp8XlghuojTAvmAFqPzsRxz6wPFBGDlxjBGT0QS/Q62+xcQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Pw31Fx7R; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::29"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:31::29; helo=mail-oo2-x29.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Pw31Fx7R
Received: from mail-oo2-x29.google.com (mail-oo2-x29.google.com
 [IPv6:2607:f8b0:4864:31::29])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7F16C4017A
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 19:43:54 +0000 (UTC)
Received: by mail-oo2-x29.google.com with SMTP id
 46e09a7af769-8137b129131so95940a34.2
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790279033; x=1790883833;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IaoGDS8LMCQrsoz4EaqFnr59umdIzmo511EpshzzFCI=;
 b=Pw31Fx7RbLz7c28HzEAb4zUBoPxyORAlxxNDh/+FGZCOiLsXEyI4hySOgxVEfe+tYW
 RWdH3DD479u/bhxWX2UFFxwCFRaKrZ/qNgoIqbA8imSi+N3R6ZMhnutADpc66LDuMFlt
 +WVi7A1X78GmVqiH87wZ1BVs3XFPoNLsc6Hirg7UlZNVB6B27DAi/4giNX5eLOGOHtaG
 z93i/fdoPi5jmInIcKLmMjvH20k/ZWcw/iIQWHzbBdbU2++1y8BljV/kCC/VnuW7B+jG
 KGToVPTf33YONd+miW4K0XfNg7nLB9bCj69XErwok2wtG8MwFjgayZbDsIZsbcOomRyJ
 RSng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790279033; x=1790883833;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IaoGDS8LMCQrsoz4EaqFnr59umdIzmo511EpshzzFCI=;
 b=jOni4gX6TvNmChy12F5GfTF1ioBF15mwuEgtV06ZJzZyy73GhbFYA/xYNsg5mkkRsP
 n4U4S1/RhSPxxRZ1RXUANJKShCmulZ6FGegjC13ricR8RjVX3Nu9LdqAg9lQ/+MrC8n+
 agagloXGUAOneqZS7paUhoT056mVlARtoq1FOoaL1Ew0vUW6JyT3ezm5Fwv0nQua3Qk8
 7ppObDhQ680luqa/siF0AFzLVUSf036fXHLwqhxN9TGLvyeUUH65w2T9CwB7kFPFNsTH
 Wf5FAIrUgj5yyqlvzvWxFlxgPNsRqjJXpareaPH4uo8CJDgDHchT6VFCrBpH2TtZdkSd
 F8Eg==
X-Gm-Message-State: AFuF++lq4yf5l+xoQ246kaUceLUfGHrPHQT0fsHvVBDeWUYNwhacjF0d
 GQuKq5aYm3yZ6pwc8n92rkoRMypJO/A2HMqj6oKDfyjPCZO5eC22VWnZkNljUwJMdcI=
X-Gm-Gg: AYBFou0FFUV4Plxbbz6hTbyezcaIpqb7HPY4lQYfWiDaIfedX88idK2krAAV9BfJsyl
 IWNNPPEdyB8SoVkOy1I+sZsnv6nYU4jAGQVtjKepWHILBwv0dosJZfoJFM550knbxu3EqzNyZmZ
 W2J5FvDvfW/Zb97Gy3Iodb5TLrHAY/WwM0r4hjjrVMQ65jIFtEz4XMbcHrpon9fHUo9ltMndDR3
 aT7QOfdFgToad3wfGRfdMcd5tp4y8sKO+cTZfIWMch5ADHjmkZ859CpQGClCmymxiaD837iP2iz
 gpXW4/PoAAhWSlIFZfjkMi3jEpLBrrFWwGoooixWOily5J8Q86jy8VusqDVcF60lptvh94gbxj0
 85W+fLT8/RWkEV8bGz56Y4azoSUaIuyU/CrLujgT5YgTI3oOdeQgkAsN0AhNlJT46NJOged44TU
 2GMH9eJbFI/jdOiqTb55DVomcYiCIUa/IU8/Rabxw40zuieQT4baYAMj8Imife7vSo9ZxGX2AnH
 5M=
X-Received: by 2002:a05:6820:1ca6:b0:6aa:da04:b56f with SMTP id
 006d021491bc7-6d43f2c7551mr3280435eaf.3.1790279033295; 
 Thu, 24 Sep 2026 12:43:53 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7ded:edd5:63dd:4102])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-818e8054dbdsm230810a34.8.2026.09.24.12.43.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 12:43:52 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 24 Sep 2026 14:41:45 -0500
Subject: [PATCH 07/15] clk: mediatek: mt8183: merge the apmixedsys driver
 into mt8183-clk
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-clk-mtk-single-ops-v1-7-1c3b5d8744ba@baylibre.com>
References: <20260924-clk-mtk-single-ops-v1-0-1c3b5d8744ba@baylibre.com>
In-Reply-To: <20260924-clk-mtk-single-ops-v1-0-1c3b5d8744ba@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1690; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=XmCj1VqvBIT2Aw34VYhQePKagnkSyv9QiBFI9WudWng=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqtX0r78eBcl2xK7yk2Zn5wi2mXd9o/pyVs/uw+
 LOlgjUt8WGJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCarV9KxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A4UkIAIu8/KnWbISTavu7ena8pBcUL+gJOvO9XvVnsVp
 7Uo8j88wOhperFLUn2wpHIWO8TITbBTatJUx8TkzF55isWCXyyUHGXSnLVinr7/M9LR09h3QIHi
 ib043rdDST10ZIQsZd1EIKeUTLvS9j/BPD8Fq3UJhUd8i+tuCd0TYhHjqVbihOLEn7CuAhGCMSM
 eiVEIcoWstzbH4K399SwhftXvnmJCdr7VSBmpZ/v75CuMknVvK53RBPwuql4/AKCky6ZHzt1sIG
 XXXSC4Ckz9XOvOGmilsQ4En9ZKJAWhBt0SaM3afKy6GP2E2LoEqhoSllgUw1C891VTpwoml6NR5
 tNNw=
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

Move the apmixedsys compatible into the mt8183-clk of_match table and drop
its separate U_BOOT_DRIVER entry.

It was only kept apart because it used different clk_ops. Now that all
MediaTek clock drivers share mtk_clk_ops, its entry is identical to
mt8183-clk apart from the of_match table.

No functional change.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8183.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index c5e607aee80..7629504ebb2 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -803,15 +803,11 @@ static const struct mtk_gate infra_clks[] = {
 
 MTK_GATE_CLK_TREE(mt8183_infracfg_tree, infra_clks, ext_clock_rates);
 
-static const struct udevice_id mt8183_apmixed_compat[] = {
+static const struct udevice_id mt8183_clk_compat[] = {
 	{
 		.compatible = "mediatek,mt8183-apmixedsys",
 		.data = (ulong)&mt8183_apmixed_clk_tree,
 	},
-	{ }
-};
-
-static const struct udevice_id mt8183_clk_compat[] = {
 	{
 		.compatible = "mediatek,mt8183-topckgen",
 		.data = (ulong)&mt8183_topckgen_clk_tree,
@@ -823,16 +819,6 @@ static const struct udevice_id mt8183_clk_compat[] = {
 	{ }
 };
 
-U_BOOT_DRIVER(mt8183_clk_apmixedsys) = {
-	.name = "mt8183-apmixedsys",
-	.id = UCLASS_CLK,
-	.of_match = mt8183_apmixed_compat,
-	.probe = mtk_clk_probe,
-	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_ops,
-	.flags = DM_FLAG_PRE_RELOC,
-};
-
 U_BOOT_DRIVER(mt8183_clk) = {
 	.name = "mt8183-clk",
 	.id = UCLASS_CLK,

-- 
2.43.0

