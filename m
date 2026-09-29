Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E37ECA5FAC
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 12:36:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A320E607C7;
	Tue, 29 Sep 2026 12:36:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tih63LAjtXCx; Tue, 29 Sep 2026 12:36:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E861E607AB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790685402;
	b=qGDuX36re0tc1SL78ZM0+UM7Dmnx0bghZQRiKwZ50rZCdyRz5Fcq80iQ7c3rmkiIxgr+
	 bP3HsVgMCpfwlqjp325d+5J5IOGJW5F0os/SXqEKsMIkZWhuxLC42OZHT50qZyBnWUMEG
	 n0gxprC5vP04xpfWtYv4luaNR/p0J2Lx85oQGQlyRD+06+TvQa2sMlk/FlZeOzc6KhNF5
	 oEYvO6uPCjkgDC6DKxTeZuWlBIZQJsmVEGUXI/mZKdFVjqL5yQ5Hm/Z7v+cpwvqbADTZV
	 Y8l/EAcp8JGte/QyLkaeGOETZxFuZth0FzrPvc3+yKpedHTNPQI9qHAbsY2u+JYZMLg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790685402;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=JXMIm8cvDyQq956rRzVoWnNloQ6iVGpJCCxp7cmtlvc=;
	b=KDI5IdjUqfWtmNEvs3ACbu0grxVGyT93W2dLrpPGr8IKDRnIY09AHqnRf9f5VTd8RfIL
	 L7UhD3aDIax2WiB9qrA4u9sgTcX4eY7k9dNQRk+nKw1ifjfT4lBvVESObs4chlg+2CV4W
	 8vZG+3L9TW4pCU7WPD/+r8mgVgWQmLKntmCtpo05//cVPOor7yLbNhcbQatgzI7O5c/Bu
	 6t7MFCQsLGP8pi2HXq2KJ/9x55rZp4zC5ghSSEtyDMQAT0jSpaiLZg3p02D88VXeiLVqb
	 WQRWH5lVdfRBDS2XueZNqGwxtVsBSaZnvcAxKnpXkQ5gMNHI9rfHN/SegCWj3pe0n6g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790685402;
	bh=JXMIm8cvDyQq956rRzVoWnNloQ6iVGpJCCxp7cmtlvc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DXopk7HVvJD4AnWT6309VwPi6kDlY98UBHJpfeIXV16pZ3N+9kBekMl+qywltzm2e
	 3wICTdAEfHKCDi5Fd+UTGScqYcEkWEzinw05i2PuuUY4RPwtJlItjDx2iPH0Lji6oy
	 M56oDk9NPo6faICMiFdoOaofdZOTrO0YYl1RG6rGQkVYXrvnQEY5zzkgEOpHlDnSR2
	 BLnapkGdRMFcTz/fPyHSkXIpsnjO4w9UwIMIyb4Px2V2GtEhBBBwMgfLGAQYLEYtuS
	 Vcxr5z3xxkLAii1vGS5ZIA4hUId9o5w/xxBC9FuGF/pV2rVeDk/dlIz99nmpgb3Nx7
	 KHXuWDJystksw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E861E607AB;
	Tue, 29 Sep 2026 12:36:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7F715335
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 12:36:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6344C80E32
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 12:36:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B2gLhl1YSEBX for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 12:36:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org F336380E25
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790685394;
 b=d2Twd+VQiGTo6wXyi0WlW/191ZqbYYf+6QWd/lwpCVHgWeQCw7Ouzp9kbDLCY9W7n199
 yVQTEyZT5w0Wp0lD4g69RpI24gWKYW5MTeBGAdWxj39o8QlUCm2bTA+W+f+FGeU1hldAr
 pX9Fv/DWn499DCGw8K42MkcBtMniAseexC63pbrErOXiHQv3743/uF1R7i0QLeQEZhPwB
 IvihaDV9+VtPh5iJTfoR3PcyE2uJZMKy1JpoqRhxL1yulXuNH1LbRWI3mGEIm2dhfrw1h
 e3wsU/5eBr9KXZ/aEGW8zXpwxSOJb63cVyAyAIfn5SAVP6t8J0lhd7NjEIzmfc103rw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790685394;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=JXMIm8cvDyQq956rRzVoWnNloQ6iVGpJCCxp7cmtlvc=;
 b=SiNrKdG7XrOBREfVLHjxJ2hK0PAhKQz7oYKcNwXJYRpIstOYqJUU4tBiWVRISitY0Epa
 fiBBfB5vBgMdBGLlwAeRyrr+yQn2tGpGi9Y3B8tOTHTHeBZ+JsD39JvLjEhLz+rW3b7qq
 PxHVC6rPegbriYD4tPPm4SRbcmARTheRxky5OuIG/73AA8047kEBFKliTQfxGuzibg8JU
 S8sIwWhygHVGFz5arwKyhSunh+kKdYuJvr2EqOuFV1DNT5SDVbnCUz1MafLEpPVMvDY92
 cJUluqSjX/aMOvi3lMqRQB1rZ+5nHEcfUZpnRwx9SdFLYaGgRqkKM6xut7d43GuSK7Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=FXLt7c8n; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=FXLt7c8n
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F336380E25
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 12:36:32 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-4a006bb267eso10478595e9.0
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 05:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790685390; x=1791290190;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JXMIm8cvDyQq956rRzVoWnNloQ6iVGpJCCxp7cmtlvc=;
 b=FXLt7c8nFbtEXeL9GfZXglncKKGX/1kDhrWPfwXde6h8Rembti9SrJZV+RlgP2S/Tt
 PvUBXnBKMfbUTu4kw2Pcrb1DrRPVOn23OescpQRRyb7kdvBDFp4170/H8WlLTUrtqZti
 Z2GFOYe9UFaPy7/Q+8G9pfai8iw7XfbbSTo5ofFmD6M61Qrw2H0etPNACkwFGh+Kdp3o
 IZb87HmGsuDD4TqbRl+xrNXd96fzp+OH+AR3d8P6O0GATM1uFaRKq1FTxOqukWq8ugeS
 DtmniDY2zda7crr9Ee3/Ds1VAPis8p84z0F6TRGJ5k27PIebqnjEuvWCkCOH0S3W3TYj
 ymLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790685390; x=1791290190;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JXMIm8cvDyQq956rRzVoWnNloQ6iVGpJCCxp7cmtlvc=;
 b=R3Fkx9tVOdFvAJnVF90fjj7E+GphPGlRcmdifAV9FmtFazkZTbWo+8uYN038axpC9f
 TWxBVX3Vo1+tA95X+oSVTXLz7AaYYjwyNCLHbHbCv6eEV7zpMHekbtxBDgiA1YXchuei
 HOmoniWhI57PUugCfZ/47SHHpEJ910u0BeCjaUYXK4O/uT91Tk6/Kcle9xKbdHBd7ww7
 bhmTTxBfDvkU1WyIiiF6IUNUBFYaZw8OAVzwnQkQ2vKITgfi8dDZqByHrgWKQSrAxB8c
 u8+xtWoknDIfVOYv0bEI+jt3ogMnA/qA5riJdXm1Sc1G+Ba7cSr+u/VUNFXthiYrqHFg
 eBmg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx5hAIIDnA/HcS5lpKVqqtQ5OiU4KSzHEHLknLxZjJjA9ukEspGlRGnTZ0k2Zg5HQOqRv7BRPE=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mJ7l4VJc/QHdb08P4SR9ok4Re9N6FHu0MNqnNXMTelI1gyS+C3
 YpzWGxltcjq56U1wda0jltG6uAngD44gdS4pssxb7oNWzQomtAluglex+HA253YgPqM=
X-Gm-Gg: AYBFou1mQdaCQjnScSLf9Yd2/Xw1Dp+VIjb3Noq+NuNqQ6B0/hHphLJ8nFZ5dbWO4lc
 Qqhn/yVzZZBy2twiopQED6fP7OWBV7DkMDGmx3oN1V+vAGamr7C+lmWevv72s8k+y/9aDZcYprV
 jCbrSQ7psGg2JVMNwn3E+RFtG7ljM+j1X1rof0YT205fxX6CXlCiQZppoFDN69Z7+zbqona8HKU
 aV5eQneE6qwI3sanUi2GR8VjE4qLUbt0VLOoz+2P32lwdu4kxvgM6V3UdMwGEl3j0WDj10ldvrz
 RMbJgO7DnWTj6IOqn+9t4OobpysmxurE5+KLMjr0N3WWGTGj6uRqq0kQozG55by6PQ8k2R4/JVS
 2DQdSCM4ypnp9rUd+Kd9lEhUiBu0EEzLebBewUDKpfixLBoSoEKQPEHxhWNq/oJQ9HNjcnZ2kwN
 YofjRDPyXSJpmrXuoqxqyOOatabpQw1v5iRJcTaJX8qcqIeihoFwWML5+pLahNTbV1V6C729Npv
 FTayOF9uSDP7MoBj/fqYHLrGzAB1ZJaBaI5nbUQDkkbEy5fmlfp+Nshk4HCzilvRQg1VL8+gBy1
 qihNo7xZgW9ALXqGl+qQ9M62BxrRGgJKzUYK+md28LOlu2BaMo38d0o=
X-Received: by 2002:a05:600c:698e:b0:49c:fc6e:a3dc with SMTP id
 5b1f17b1804b1-49fe66f1491mr284139105e9.27.1790685390361; 
 Tue, 29 Sep 2026 05:36:30 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a013cfc788sm450305e9.2.2026.09.29.05.36.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 05:36:29 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 29 Sep 2026 14:38:41 +0200
Subject: [PATCH v2 03/11] clk: mediatek: use MTK_GATE_CLK_TREE() for the
 gate-only clock trees
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-clk-mediatek-cleanups-v2-3-b296bf3a4a93@baylibre.com>
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

Replace the open-coded struct mtk_clk_tree definitions of the blocks
that only provide gates with the MTK_GATE_CLK_TREE() helper.

The helper also sets .gates_offs to the ID of the first gate of the
block. All the converted blocks start at ID 0, so this is a no-op.

No functional change.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8183.c |  7 +----
 drivers/clk/mediatek/clk-mt8188.c | 63 ++++++--------------------------------
 drivers/clk/mediatek/clk-mt8195.c |  7 +----
 drivers/clk/mediatek/clk-mt8365.c |  7 +----
 drivers/clk/mediatek/clk-mt8366.c | 64 ++++++---------------------------------
 drivers/clk/mediatek/clk-mt8512.c | 14 ++-------
 drivers/clk/mediatek/clk-mt8516.c |  7 +----
 drivers/clk/mediatek/clk-mt8518.c |  7 +----
 8 files changed, 26 insertions(+), 150 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index 5a4863049c5..f004c9748dd 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -787,12 +787,7 @@ static const struct mtk_gate infra_clks[] = {
 	GATE_INFRA3(CLK_INFRA_FBIST2FPC, CLK_TOP_MUX_MSDC50_0, 24),
 };
 
-static const struct mtk_clk_tree mt8183_infracfg_tree = {
-	.ext_clk_rates = ext_clock_rates,
-	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-	.gates = infra_clks,
-	.num_gates = ARRAY_SIZE(infra_clks),
-};
+MTK_GATE_CLK_TREE(ext_clock_rates, mt8183_infracfg_tree, infra_clks);
 
 static const struct udevice_id mt8183_apmixed_compat[] = {
 	{
diff --git a/drivers/clk/mediatek/clk-mt8188.c b/drivers/clk/mediatek/clk-mt8188.c
index 90effc29ab2..ef7a7fea79e 100644
--- a/drivers/clk/mediatek/clk-mt8188.c
+++ b/drivers/clk/mediatek/clk-mt8188.c
@@ -1619,12 +1619,7 @@ static const struct mtk_gate infracfg_ao_clks[] = {
 	GATE_INFRA_AO4(CLK_INFRA_AO_RG_AES_MSDCFDE_CK_0P, CLK_TOP_AES_MSDCFDE, 18),
 };
 
-static const struct mtk_clk_tree mt8188_infracfg_ao_clk_tree = {
-	.ext_clk_rates = ext_clock_rates,
-	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-	.gates = infracfg_ao_clks,
-	.num_gates = ARRAY_SIZE(infracfg_ao_clks),
-};
+MTK_GATE_CLK_TREE(ext_clock_rates, mt8188_infracfg_ao_clk_tree, infracfg_ao_clks);
 
 static const struct mtk_gate_regs peri_ao_cg_regs = {
 	.set_ofs = 0x10,
@@ -1664,12 +1659,7 @@ static const struct mtk_gate pericfg_ao_clks[] = {
 	GATE_PERI_AO(CLK_PERI_AO_PCIE_P0_FMEM, CLK_TOP_466M_FMEM, 24),
 };
 
-static const struct mtk_clk_tree mt8188_pericfg_ao_clk_tree = {
-	.ext_clk_rates = ext_clock_rates,
-	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-	.gates = pericfg_ao_clks,
-	.num_gates = ARRAY_SIZE(pericfg_ao_clks),
-};
+MTK_GATE_CLK_TREE(ext_clock_rates, mt8188_pericfg_ao_clk_tree, pericfg_ao_clks);
 
 static const struct mtk_gate_regs imp_iic_wrap_cg_regs = {
 	.set_ofs = 0xe08,
@@ -1701,26 +1691,11 @@ static const struct mtk_gate imp_iic_wrap_en_clks[] = {
 	GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_EN_AP_CLOCK_I2C6, CLK_TOP_I2C, 1),
 };
 
-static const struct mtk_clk_tree mt8188_imp_iic_wrap_c_clk_tree = {
-	.ext_clk_rates = ext_clock_rates,
-	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-	.gates = imp_iic_wrap_c_clks,
-	.num_gates = ARRAY_SIZE(imp_iic_wrap_c_clks),
-};
+MTK_GATE_CLK_TREE(ext_clock_rates, mt8188_imp_iic_wrap_c_clk_tree, imp_iic_wrap_c_clks);
 
-static const struct mtk_clk_tree mt8188_imp_iic_wrap_w_clk_tree = {
-	.ext_clk_rates = ext_clock_rates,
-	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-	.gates = imp_iic_wrap_w_clks,
-	.num_gates = ARRAY_SIZE(imp_iic_wrap_w_clks),
-};
+MTK_GATE_CLK_TREE(ext_clock_rates, mt8188_imp_iic_wrap_w_clk_tree, imp_iic_wrap_w_clks);
 
-static const struct mtk_clk_tree mt8188_imp_iic_wrap_en_clk_tree = {
-	.ext_clk_rates = ext_clock_rates,
-	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-	.gates = imp_iic_wrap_en_clks,
-	.num_gates = ARRAY_SIZE(imp_iic_wrap_en_clks),
-};
+MTK_GATE_CLK_TREE(ext_clock_rates, mt8188_imp_iic_wrap_en_clk_tree, imp_iic_wrap_en_clks);
 
 static const struct mtk_gate_regs vdo0_0_cg_regs = {
 	.set_ofs = 0x104,
@@ -2080,33 +2055,13 @@ static const struct mtk_gate vdo1_clks[] = {
 	GATE_VDO1_5(CLK_VDO1_DPI1_HDMI, CLK_TOP_VPP, 0),
 };
 
-static const struct mtk_clk_tree mt8188_vpp0_clk_tree = {
-	.ext_clk_rates = ext_clock_rates,
-	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-	.gates = vpp0_clks,
-	.num_gates = ARRAY_SIZE(vpp0_clks),
-};
+MTK_GATE_CLK_TREE(ext_clock_rates, mt8188_vpp0_clk_tree, vpp0_clks);
 
-static const struct mtk_clk_tree mt8188_vpp1_clk_tree = {
-	.ext_clk_rates = ext_clock_rates,
-	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-	.gates = vpp1_clks,
-	.num_gates = ARRAY_SIZE(vpp1_clks),
-};
+MTK_GATE_CLK_TREE(ext_clock_rates, mt8188_vpp1_clk_tree, vpp1_clks);
 
-static const struct mtk_clk_tree mt8188_vdo0_clk_tree = {
-	.ext_clk_rates = ext_clock_rates,
-	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-	.gates = vdo0_clks,
-	.num_gates = ARRAY_SIZE(vdo0_clks),
-};
+MTK_GATE_CLK_TREE(ext_clock_rates, mt8188_vdo0_clk_tree, vdo0_clks);
 
-static const struct mtk_clk_tree mt8188_vdo1_clk_tree = {
-	.ext_clk_rates = ext_clock_rates,
-	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-	.gates = vdo1_clks,
-	.num_gates = ARRAY_SIZE(vdo1_clks),
-};
+MTK_GATE_CLK_TREE(ext_clock_rates, mt8188_vdo1_clk_tree, vdo1_clks);
 
 static const struct udevice_id mt8188_apmixed_compat[] = {
 	{
diff --git a/drivers/clk/mediatek/clk-mt8195.c b/drivers/clk/mediatek/clk-mt8195.c
index de40821100e..c67735e314a 100644
--- a/drivers/clk/mediatek/clk-mt8195.c
+++ b/drivers/clk/mediatek/clk-mt8195.c
@@ -1596,12 +1596,7 @@ static const struct mtk_gate infra_ao_clks[] = {
 	GATE_INFRA_AO4(CLK_INFRA_AO_PERI_UFS_MEM_SUB, CLK_TOP_MEM_466M, 31),
 };
 
-static const struct mtk_clk_tree mt8195_infracfg_ao_clk_tree = {
-	.ext_clk_rates = ext_clock_rates,
-	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-	.gates = infra_ao_clks,
-	.num_gates = ARRAY_SIZE(infra_ao_clks),
-};
+MTK_GATE_CLK_TREE(ext_clock_rates, mt8195_infracfg_ao_clk_tree, infra_ao_clks);
 
 static const struct udevice_id mt8195_apmixed[] = {
 	{
diff --git a/drivers/clk/mediatek/clk-mt8365.c b/drivers/clk/mediatek/clk-mt8365.c
index 3fa030d7218..e709fc1640b 100644
--- a/drivers/clk/mediatek/clk-mt8365.c
+++ b/drivers/clk/mediatek/clk-mt8365.c
@@ -754,12 +754,7 @@ static const struct mtk_gate ifr_clks[] = {
 	GATE_IFR6(CLK_IFR_SSUSB_XHCI, CLK_TOP_SSUSB_XHCI_SEL, 11),
 };
 
-static const struct mtk_clk_tree mt8365_infracfg_tree = {
-	.ext_clk_rates = ext_clock_rates,
-	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-	.gates = ifr_clks,
-	.num_gates = ARRAY_SIZE(ifr_clks),
-};
+MTK_GATE_CLK_TREE(ext_clock_rates, mt8365_infracfg_tree, ifr_clks);
 
 static const struct udevice_id mt8365_apmixed_compat[] = {
 	{
diff --git a/drivers/clk/mediatek/clk-mt8366.c b/drivers/clk/mediatek/clk-mt8366.c
index 533b769324c..18e121ea65e 100644
--- a/drivers/clk/mediatek/clk-mt8366.c
+++ b/drivers/clk/mediatek/clk-mt8366.c
@@ -1191,12 +1191,7 @@ static const struct mtk_gate infracfg_ao_reg_clks[] = {
 	GATE_INFRACFG_AO_REG6(CLK_INFRACFG_AO_REGP_NFIECC_B, CLK_TOP_NFI_BCLK_SEL, 24),
 };
 
-static const struct mtk_clk_tree infracfg_ao_reg_clks_tree = {
-	.ext_clk_rates = ext_clock_rates,
-	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-	.gates = infracfg_ao_reg_clks,
-	.num_gates = ARRAY_SIZE(infracfg_ao_reg_clks),
-};
+MTK_GATE_CLK_TREE(ext_clock_rates, infracfg_ao_reg_clks_tree, infracfg_ao_reg_clks);
 
 static const struct mtk_gate_regs impc_cg_regs = {
 	.set_ofs = 0xe08,
@@ -1219,12 +1214,7 @@ static const struct mtk_gate impc_clks[] = {
 	GATE_IMPC(CLK_IMPC_I2C9, CLK_TOP_I2CP_SEL, 7),
 };
 
-static const struct mtk_clk_tree impc_clks_tree = {
-	.ext_clk_rates = ext_clock_rates,
-	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-	.gates = impc_clks,
-	.num_gates = ARRAY_SIZE(impc_clks),
-};
+MTK_GATE_CLK_TREE(ext_clock_rates, impc_clks_tree, impc_clks);
 
 static const struct mtk_gate_regs impe_cg_regs = {
 	.set_ofs = 0xe08,
@@ -1241,12 +1231,7 @@ static const struct mtk_gate impe_clks[] = {
 	GATE_IMPE(CLK_IMPE_I2C4, CLK_TOP_I2C_SEL, 1),
 };
 
-static const struct mtk_clk_tree impe_clks_tree = {
-	.ext_clk_rates = ext_clock_rates,
-	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-	.gates = impe_clks,
-	.num_gates = ARRAY_SIZE(impe_clks),
-};
+MTK_GATE_CLK_TREE(ext_clock_rates, impe_clks_tree, impe_clks);
 
 static const struct mtk_gate_regs mm0_cg_regs = {
 	.set_ofs = 0x100,
@@ -1321,12 +1306,7 @@ static const struct mtk_gate mm_clks[] = {
 	GATE_MM1E(CLK_MM_32K, CLK_PAD_CLK32K, 19),
 };
 
-static const struct mtk_clk_tree mm_clks_tree = {
-	.ext_clk_rates = ext_clock_rates,
-	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-	.gates = mm_clks,
-	.num_gates = ARRAY_SIZE(mm_clks),
-};
+MTK_GATE_CLK_TREE(ext_clock_rates, mm_clks_tree, mm_clks);
 
 static const struct mtk_gate_regs dptx_phyd_sifslv_dig_glb_cg_regs = {
 	.set_ofs = 0x8,
@@ -1343,12 +1323,8 @@ static const struct mtk_gate dptx_phyd_sifslv_dig_glb_clks[] = {
 				      CLK_PAD_CLK26M, 0),
 };
 
-static const struct mtk_clk_tree dptx_phyd_sifslv_dig_glb_clks_tree = {
-	.ext_clk_rates = ext_clock_rates,
-	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-	.gates = dptx_phyd_sifslv_dig_glb_clks,
-	.num_gates = ARRAY_SIZE(dptx_phyd_sifslv_dig_glb_clks),
-};
+MTK_GATE_CLK_TREE(ext_clock_rates, dptx_phyd_sifslv_dig_glb_clks_tree,
+		  dptx_phyd_sifslv_dig_glb_clks);
 
 static const struct mtk_gate_regs epdsys_config0_cg_regs = {
 	.set_ofs = 0x100,
@@ -1396,12 +1372,7 @@ static const struct mtk_gate epdsys_config_clks[] = {
 	GATE_EPDSYS_CONFIG1(CLK_EPDSYS_DPI0_MM, CLK_TOP_EPD_SEL, 1),
 };
 
-static const struct mtk_clk_tree epdsys_config_clks_tree = {
-	.ext_clk_rates = ext_clock_rates,
-	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-	.gates = epdsys_config_clks,
-	.num_gates = ARRAY_SIZE(epdsys_config_clks),
-};
+MTK_GATE_CLK_TREE(ext_clock_rates, epdsys_config_clks_tree, epdsys_config_clks);
 
 static const struct mtk_gate_regs vde23_cg_regs = {
 	.set_ofs = 0x8,
@@ -1417,12 +1388,7 @@ static const struct mtk_gate vdec_gcon_clks[] = {
 	GATE_VDE23(CLK_VDE2_LARB1_CKEN, CLK_TOP_VDEC_SEL, 0),
 };
 
-static const struct mtk_clk_tree vdec_gcon_clks_tree = {
-	.ext_clk_rates = ext_clock_rates,
-	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-	.gates = vdec_gcon_clks,
-	.num_gates = ARRAY_SIZE(vdec_gcon_clks),
-};
+MTK_GATE_CLK_TREE(ext_clock_rates, vdec_gcon_clks_tree, vdec_gcon_clks);
 
 static const struct mtk_gate_regs ipe_cg_regs = {
 	.set_ofs = 0x4,
@@ -1444,12 +1410,7 @@ static const struct mtk_gate ipesys_clks[] = {
 	GATE_IPE(CLK_IPE_GALS, CLK_TOP_IPE_SEL, 8),
 };
 
-static const struct mtk_clk_tree ipesys_clks_tree = {
-	.ext_clk_rates = ext_clock_rates,
-	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-	.gates = ipesys_clks,
-	.num_gates = ARRAY_SIZE(ipesys_clks),
-};
+MTK_GATE_CLK_TREE(ext_clock_rates, ipesys_clks_tree, ipesys_clks);
 
 static const struct mtk_gate_regs cam_m_cg_regs = {
 	.set_ofs = 0x4,
@@ -1481,12 +1442,7 @@ static const struct mtk_gate camsys_main_clks[] = {
 	GATE_CAM_M(CLK_CAM_M_PDA, CLK_TOP_CAM_SEL, 21),
 };
 
-static const struct mtk_clk_tree camsys_main_clks_tree = {
-	.ext_clk_rates = ext_clock_rates,
-	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-	.gates = camsys_main_clks,
-	.num_gates = ARRAY_SIZE(camsys_main_clks),
-};
+MTK_GATE_CLK_TREE(ext_clock_rates, camsys_main_clks_tree, camsys_main_clks);
 
 static const struct udevice_id mt8366_apmixed_compat[] = {
 	{
diff --git a/drivers/clk/mediatek/clk-mt8512.c b/drivers/clk/mediatek/clk-mt8512.c
index a0beae8fa5f..6c0bb0944d4 100644
--- a/drivers/clk/mediatek/clk-mt8512.c
+++ b/drivers/clk/mediatek/clk-mt8512.c
@@ -815,19 +815,9 @@ static const struct mtk_clk_tree mt8512_topckgen_clk_tree = {
 	.type = MTK_CLK_TREE_TOPCKGEN,
 };
 
-static const struct mtk_clk_tree mt8512_topckgen_cg_tree = {
-	.ext_clk_rates = ext_clock_rates,
-	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-	.gates = top_clks,
-	.num_gates = ARRAY_SIZE(top_clks),
-};
+MTK_GATE_CLK_TREE(ext_clock_rates, mt8512_topckgen_cg_tree, top_clks);
 
-static const struct mtk_clk_tree mt8512_infracfg_tree = {
-	.ext_clk_rates = ext_clock_rates,
-	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-	.gates = infra_clks,
-	.num_gates = ARRAY_SIZE(infra_clks),
-};
+MTK_GATE_CLK_TREE(ext_clock_rates, mt8512_infracfg_tree, infra_clks);
 
 static const struct udevice_id mt8512_apmixed_compat[] = {
 	{
diff --git a/drivers/clk/mediatek/clk-mt8516.c b/drivers/clk/mediatek/clk-mt8516.c
index ea00b8dbca1..f4d4dc3cc56 100644
--- a/drivers/clk/mediatek/clk-mt8516.c
+++ b/drivers/clk/mediatek/clk-mt8516.c
@@ -767,12 +767,7 @@ static const struct mtk_clk_tree mt8516_topckgen_clk_tree = {
 	.type = MTK_CLK_TREE_TOPCKGEN,
 };
 
-static const struct mtk_clk_tree mt8516_clk_tree = {
-	.ext_clk_rates = ext_clock_rates,
-	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-	.gates = top_clks,
-	.num_gates = ARRAY_SIZE(top_clks),
-};
+MTK_GATE_CLK_TREE(ext_clock_rates, mt8516_clk_tree, top_clks);
 
 static const struct udevice_id mt8516_apmixed_compat[] = {
 	{
diff --git a/drivers/clk/mediatek/clk-mt8518.c b/drivers/clk/mediatek/clk-mt8518.c
index 4fef36f458a..dac5b0a6f62 100644
--- a/drivers/clk/mediatek/clk-mt8518.c
+++ b/drivers/clk/mediatek/clk-mt8518.c
@@ -1523,12 +1523,7 @@ static const struct mtk_clk_tree mt8518_topckgen_clk_tree = {
 	.type = MTK_CLK_TREE_TOPCKGEN,
 };
 
-static const struct mtk_clk_tree mt8518_clk_tree = {
-	.ext_clk_rates = ext_clock_rates,
-	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-	.gates = top_clks,
-	.num_gates = ARRAY_SIZE(top_clks),
-};
+MTK_GATE_CLK_TREE(ext_clock_rates, mt8518_clk_tree, top_clks);
 
 static const struct udevice_id mt8518_apmixed_compat[] = {
 	{

-- 
2.55.0

