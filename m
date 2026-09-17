Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7099CC982D3
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 12:51:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3366E407F6;
	Thu, 17 Sep 2026 12:51:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fry0YQXhdXkk; Thu, 17 Sep 2026 12:51:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7A575407FA
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789649460;
	b=TrGSGHsBRav7L6GjY5AYNGrNNOxEY8p40Hw/8QHWKSb93uPKtKeuGP7bsumj2fWVCDXX
	 wIP3qUD6vxO9Wc9steLk+zA2GEVn9KpFqhy410k2a5MhltnmNOSqOpf0fNuGW7M6MCHxu
	 6hvqOazqQ2aNTYepDoeqgEIudA/zf17DC8/D2RuiJmgrRxNM8hRBXjI4GwSCCindqGylJ
	 FlOoAcjM2JPgLxSkN827Hib+BgObWLbLcAr6IPiOpgl3zAMXs70NekL09cxQChoDHWg8J
	 ioRsJUFTKTHrPN/0AFbHUyhkjtdbzXErXPIRsWeYy/+wyuDRefRDgxBxslz7LEQaUuQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789649460;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=HEPdTForVW+GC0/IskU5EEb84awp8w59Zvbmo9Fp0CI=;
	b=hlB2yYZHg5MTdFmEMdlUeNqaoBevtLMM2fO/bzbA4Ddp2y/rx+fUK/TcW/mQRQSYmGee
	 PWeVwlftVv5n88vut0swH706ceY18HRh5ur3vOyG2Cb5KZ+H+P+Jj9caNgVCdvN1RQQHW
	 OU1L78hBetrS5Jp+N3WvciyI9jWtnZ40WVSnNFdjQk0HC3aUXN+1sH9IKyQMUPuH9rp9H
	 4P08URDE6Rv8Nz5oT0bCR9QPgGeNy3IIqfuNa9Y4PYh7e9TLhLJjtZv6Mw7hL0iozP3PW
	 gUnbjEaHEKQ972YYVa8D12F0cTDbdCBsD3F2X8T7qwBCnvVf5OZDUqvrCm3iMYrfNRg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789649460;
	bh=HEPdTForVW+GC0/IskU5EEb84awp8w59Zvbmo9Fp0CI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0KGPVFx+0cPMMxUROm98FTkocbu1LlOwU/S7bTnFFTa0X99kHrRG++rKjgJ8zR0FN
	 Rvu1PNlH9ik7pFO72dJRQ2PTN9f6VGk8zMwecRd+yma0h0qTviAezFYMC49QvbV17B
	 lB/MJopDQn9HtaGTz6jkp58/Q+r6O2w3LYjwBYBRfTM89xNpE37qISqiI0xcLf+R9Y
	 gKnozQ3oX6+gsos8ZFHqOXbFLczasKgLP67kYLGKsGBo8abhMFjxttzINzKLVT0gkm
	 zXroQiJpte2iEFZl1W7TpkkYajOf1XIBxZnnlCKI5jV4FWEnkdWJJiJrQHao3I4rCh
	 8mpgHKWIeLhoA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7A575407FA;
	Thu, 17 Sep 2026 12:51:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6BE0F37A
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 12:50:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5D178608A8
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 12:50:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vq0xsEueYEZT for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 12:50:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5AF58608B5
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789649455;
 b=LqLGpe+kVBDmatYaHzmXIliyrhxHM8M3pu6fOoBeVb/kiYjBW2oJpuhFos6rXR7n/BKY
 ou7sE1L9HJiX2CjZb3H5W2Mvao/J46ilSB7cK1vG+OjVHSpagH6l0nuovoJG0nYzj201k
 LSOhojHB3XKDlen+AXpX+u+YFsYJo/fh4yncUy9LlmQ2o8noepv0aet4kDFKfpFsIL1GL
 jMRENOSu1XB9gUCPfLyvtgBKFSbkpOmXFW4NeAOZfNKk+wqhTYYliMt4+nloNRHj8hUC2
 TnYYmoLanvPuPn2WmHWjBu/DogXFBJpZVy0bwBXGdhKA78DKg65DQKkS6wcbKdqn9sQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789649455;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=HEPdTForVW+GC0/IskU5EEb84awp8w59Zvbmo9Fp0CI=;
 b=Ju03q7X3PZ8OOnzZjTyOIcqWOLu2LKaL5CxFLQQnb0PQftCKqmpQHnzR6Cp6rdEGQq1+
 9WZ/q85c/YTuZ0vqxs2q0eGeOQ5PlnY5x9vk+f8f5Ayqsavd4Vfk5OGXQ9JhEXtjBV/Cz
 4ockibbBfRNX9flNm+VXK8PlpcilCDlscJfZ5hBLsangHD9Ywb9RPCt/HQbJaxT1G9fYQ
 eLRrOtjlgOlxz+AbpFj5N6nyaHYoBAlhi46sJj4+mDylZr/JizKmh7s6yM++DHoF8dRIJ
 o+PGDcS5oadKVVXbpFow+zLZ98NlCCEYUEyY+i1AA/UQnhkzoZHf2VSnfBAmxoxnyXQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b="QRtpFdw/"; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=QRtpFdw/
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5AF58608B5
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 12:50:54 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49ccf3ca626so4142805e9.0
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 05:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1789649453; x=1790254253;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HEPdTForVW+GC0/IskU5EEb84awp8w59Zvbmo9Fp0CI=;
 b=QRtpFdw/Pv1vQOGn9wq38nbitx7w1JM3u3k8Fj2lfQAIdN2GtBrY/LXx7IuaSTpSdv
 g5dsJF1ATBXIdPMVFkJO4HMCmNnG+vK3QJB2GJkzMvuNa41o6tQgijUYux8TmyphUlDF
 EfBBDr4qwfMkPD7dKP/TO7Fs+MGSz37Bj6uEr4VlpfBETwNR1EOA2PSLfkKYVPdQ9TnS
 e15nURvvH4R2w4MFIw5dioZchy8QRm+dk+IbWNAEBIzXeaXgTC8APaWmGmx7WHgQ3L9s
 bL/reb0BEKu7F0q7mfqDsCqvyC/XdPBOXNLScOq//Wrpc9vuEPQTiwGgnrAK/gbvqJwc
 O52Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789649453; x=1790254253;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HEPdTForVW+GC0/IskU5EEb84awp8w59Zvbmo9Fp0CI=;
 b=bHXmAqm2i/M+OT1E2SlM8KT+3UXzdM1slsyG0/E64OHJ4mq4TeFLpZf8A5DD9w/+no
 5oXcdcYOmPtqMFmGkhjfTNv/mQWxClA57QC6mXFzoMWiqI9ePPlcYNP0CJ6OFUGbnA7t
 taTUrtqZSgnuw8fjbskPDChdVcRt6IKTBfeOdQNGsSbRNuj66e2ntWGfqwwXByftibRj
 iMk5eQnbQOYqm6mr+vli9jvmfQ7tXxVv/Ik7PEmb3Q1y9yEooVkOLYgdtiRE5KN+F+AV
 aZQb42n9z6r/QTMiTk9z3VBJBM2dtpOyBW0d1ZC0+wcEsuvlCoP/mmeSC+353rnJmosF
 rtvA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxcjZd/wRmJm1VSxI4Y9N8S/wF+hDRIrCUySsAcV+MbqGXgNgFWKnZxFpaeNG2BbbXnU4zeg0I=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nb4N+i5WVTp/aPhL/o7L5kGcSUKZ9BM2AWSESTfo7rJJYQOtZb
 0bKISP02mgZxHYAKjAoY0A0GiMMhKpCzPWuXt0cY8wFFa4DNQx0L1JNqgCNZR35Azgk=
X-Gm-Gg: AYBFou1N2GnHd58QaBRrL2z+gxE42FY320Kj+5+R/19IFTNIO4LQgZHiLc9s6TflPmV
 7QFcKfvXHtrxq8h2ROaRMbp36IC6wohv/SLEPvkQZ+FiPtpNbjkFwgDKKeUsRBWc9qSSFHlsXJx
 qL3IKNq7nUNOMe/v7cu5dF9IQzo9cYoNgdCsBcoaqVexjwhuydT50nKjWQlDeS8LHHU5D74CqzV
 6nMCeZYTxwB+7CRkvU/4sw4S4JU9Vs2eXrRumjrk/x7NaMuLsqaCqfnW9jnx+9oSRN8KaJMij2F
 w+3/fsevap5r/HujJD+kx3T+ALYG7ObmyzgOFxCZbgT0M76L07NKoqu4YbUwjTKSasvuT6syEMD
 PBbz5IaOW37cMHb0Nm0w26es71drFD1pF0MSvzIrWrtkoHxO1/wMrxI/mRfB3WXiLPVCdD4awRa
 /AWevGDY1B193Oz+5jFWuKwr8Mw62zEsI1lwokAqMn1U/F/gOtoOR9STpxt7+RIhW/tlUYOPWQ4
 5ODF8W714CSRJx0b4BA0Gkg0uQClhyv0zH7qOthC8qcn+lekWV62sQAS2sd9pJPzaeAhCIn6Tph
 oYDJkutCFKfMv2u2V+uvtTLWYbn2T7v+A4JNEcMHpffHhmTyyLGDb1g=
X-Received: by 2002:a05:600c:c104:b0:49f:bc28:e8c5 with SMTP id
 5b1f17b1804b1-49fbc28ea2dmr44324685e9.12.1789649452831; 
 Thu, 17 Sep 2026 05:50:52 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd23f4e6sm88614255e9.8.2026.09.17.05.50.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 05:50:51 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 17 Sep 2026 14:52:00 +0200
Subject: [PATCH 05/11] clk: mediatek: mt8188: merge the clock drivers into
 a single driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-clk-mediatek-cleanups-v1-5-4dccf8ed98fc@baylibre.com>
References: <20260917-clk-mediatek-cleanups-v1-0-4dccf8ed98fc@baylibre.com>
In-Reply-To: <20260917-clk-mediatek-cleanups-v1-0-4dccf8ed98fc@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Chris Chen <chris-qj.chen@mediatek.com>, 
 "irving.ch.lin" <irving-ch.lin@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>
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

The topckgen and generic clock U_BOOT_DRIVER entries only differ by
their of_match table: they share the same probe, ops, private data
and flags. Merge them into a single mt8188-clk driver, the way
clk-mt8366.c already does, so that a new clock block only needs a
new of_match entry.

No functional change.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8188.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8188.c b/drivers/clk/mediatek/clk-mt8188.c
index 3ede5e792d6..0f50757c97e 100644
--- a/drivers/clk/mediatek/clk-mt8188.c
+++ b/drivers/clk/mediatek/clk-mt8188.c
@@ -2071,15 +2071,11 @@ static const struct udevice_id mt8188_apmixed_compat[] = {
 	{ }
 };
 
-static const struct udevice_id mt8188_topckgen_compat[] = {
+static const struct udevice_id mt8188_clk_compat[] = {
 	{
 		.compatible = "mediatek,mt8188-topckgen",
 		.data = (ulong)&mt8188_topckgen_clk_tree,
 	},
-	{ }
-};
-
-static const struct udevice_id of_match_mt8188_clk[] = {
 	{
 		.compatible = "mediatek,mt8188-infracfg-ao",
 		.data = (ulong)&mt8188_infracfg_ao_clk_tree,
@@ -2129,20 +2125,10 @@ U_BOOT_DRIVER(mt8188_clk_apmixedsys) = {
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-U_BOOT_DRIVER(mt8188_clk_topckgen) = {
-	.name = "mt8188-topckgen",
-	.id = UCLASS_CLK,
-	.of_match = mt8188_topckgen_compat,
-	.probe = mtk_clk_probe,
-	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_topckgen_ops,
-	.flags = DM_FLAG_PRE_RELOC,
-};
-
 U_BOOT_DRIVER(mt8188_clk) = {
 	.name = "mt8188-clk",
 	.id = UCLASS_CLK,
-	.of_match = of_match_mt8188_clk,
+	.of_match = mt8188_clk_compat,
 	.probe = mtk_clk_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,

-- 
2.55.0

