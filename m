Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AD2DCA5FAE
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 12:36:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7B50D607C9;
	Tue, 29 Sep 2026 12:36:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mp4rXaFJd-Lp; Tue, 29 Sep 2026 12:36:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B96CF607C6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790685399;
	b=F2yphoEXnyKu1jWYBi4uCp80e4yZCKIt9tJrwh9/FBnyiwiXZARPpSN8yAP7+NaEVKYI
	 zaDQxkw5EMRZSk0FnLBmTvApqF1KjuWwzhUt4tm7cDuB+E1TlknP1pC9hP/GCbBOKqOfD
	 QGqvV1zQiWIFrFEFG0qwFrAcw34QAZSIfc5EIHqgRMQaYfo5mB0b7q99+mwr/rWuvOLqp
	 rqiHQkBB90E27Qd8/hyBEE1XDwkwvLT733FblVyEQMWtw97vP7kO0NjyPRgkeXuzFb4Fu
	 R6dnKfMdqmthtLpi+dE1qjxhhreAkydQEFe1QH0f+y3CZ2mHVMyz0TCkTy+MX/JMxyA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790685399;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=zRCIQ3v29sV9vTXFZHv/hqgqm0Fxp70RF5zrWyrrKlU=;
	b=g1h2IwGA6phPwdkYyrkPAyOzk+Vw4q1dUAko1gdewK5ATIUHlyTuUPQoW3vF6dv6kPP1
	 xcMsAbYxxwVXVK9IqOpCWvU5Th4yaWagsENeU08S3XzJh6l0kgk9zjYfQRLSVzQ9C+Bel
	 2Gd45m6lextOEhxSLRK6dGDFF4DHUboEeIlbeu16iprw/uDENujoLrjft7awNfk85ZjQK
	 v9Hu6rDZh7iMYX+6CIhuWF99Voj1+GPe736XGThu/lZp/t4oIzjXMv8sW0fFRQZoeEsqi
	 Wc73wBoRoTojOkMzo+ax3Epf6cofY7ISj3udsUYRvV394bP8vXdEWNyb/5WUqlnY1SA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790685399;
	bh=zRCIQ3v29sV9vTXFZHv/hqgqm0Fxp70RF5zrWyrrKlU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YscZ2kUcgvxCZXhXym/6xeg7D+5vCTOZzNyLL16KcwzKqcOg6KuRRRBe93QQE7pEw
	 B03CeHOVkqMJhvV61zX66UUo8HOieaazqq7jaaConkiauktc7+CSSNuynNuBB5TH49
	 EWqQp+/5HEIo0mG5O2Xx257p4qBe/PTQ6Wz0yuPJL93dh1ArxLaBbjFIzmrSk/4NFH
	 Cz2gBCu/XpS4Le4uyemjkJFsGMHaLxX8fmnq2HpoGsO1ZEeqlhjfNfgjEjnkG/k4PY
	 Ro7vr1s53IxOdgabjTQgU45rfLZJLPv9VAP9chAB9Ek9eiYLnMx3EgbHOU056nn2/L
	 unz+HvBczzSOQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B96CF607C6;
	Tue, 29 Sep 2026 12:36:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 278E4D1
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 12:36:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1953B406F2
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 12:36:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UTkRJKrx0TZb for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 12:36:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 10A75406E4
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790685394;
 b=fx4tXB30EbrUk/XHr3UU0BcxmMPKCGWXun2DFtdlAWqNY0GSvMDf39587G/xTI6R5Nvl
 L1iz2KRf1vJXIOrnusdRiijtv+QAXm9qkPIg7jA7fR18WZNsgetSHgiIfWgDy0zHBxisZ
 JESMFDPlDreTUm38VSCq03BFBlUXCQDF9UBE3LjEMOaBXgnq8k0GizdfHr+SeemQjW8eE
 uVxVGT9NaiS2ebCDjUeGUlNl5+wC71T6htvcFbtLNJpIsJwjJKCf/djpHqBhj1ZJDsV83
 xZZ6FSDDTk5mcFK1lBG+zoaMOsXe6MfH1NNR7rjwac/L/Nufr0XqOxUBF0WK3qTQrEg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790685394;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=zRCIQ3v29sV9vTXFZHv/hqgqm0Fxp70RF5zrWyrrKlU=;
 b=pqWniRH6KUdBDo9J5/Qcy15KndNj9zvmcDx6miVo6zb8G61b6AsUaVR8nAebiNIMvO58
 GPNCGjvXx7V29TpaP9DgcWx/ieQj+tAG7VdhMre7Ne3xKatDLwgojlNUcOn+Def3tmuUT
 q4VfiRUoxRZYm+nJRxsl9kgkymm+/bv3p9GXVGe4zzRkPc9RDkwO+CnrN84BFNg9XLWYO
 QmjNVuv5zNL2j9TwSKjHVw29jugPyRWBybWXhS9EToeqV5/Fz/+ut9Q0+Afq37skOTpA8
 6XRH0IUmkriRcyY9mvk2INgzfLT/nZig+X9ff6VMv1xAkst9tog5vchFvV3McrCvYDQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=OdFbb3KE; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=OdFbb3KE
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 10A75406E4
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 12:36:33 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e79a408deso25894445e9.2
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 05:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790685391; x=1791290191;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zRCIQ3v29sV9vTXFZHv/hqgqm0Fxp70RF5zrWyrrKlU=;
 b=OdFbb3KE5dVS7Lsg0kEbfrJWRUgAJBki09oXJv33kKMrkBXMeRb+CsVfxXMVFd1LOO
 TMc+uEs4Tt8abPCJydKMYPiFy8xfncavzNMRbfFgvvLCefRNGaQ9ekWQDdFJi9dcEoKH
 qFgWiYIxYKCbNnA2dYLzidw8SGJ4P9GBOSUNc0IE1+H4YCIwd+M6h7PTVY7KErDBy+X/
 XuYfR6I1EQLI6sM+miPBHOy2PKq114xs9n1uRAMvCrI6ZpC/lnmbY4lD98ZFXhLvKVgt
 SuFwSIaN/k/Qg6Bdulz3KVRVzoIfpt+H6Z7zpv0qKyZlEpoc137NgOkKC5HZ31FdaOLF
 bDbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790685391; x=1791290191;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zRCIQ3v29sV9vTXFZHv/hqgqm0Fxp70RF5zrWyrrKlU=;
 b=qK+Hp0YM2q7y/AOxNDZXmAawzQXKLWKlBSENn9tZxBdCzvKUKhIQ060+UQfKUPoBQ/
 Ng5H7TjJpPOIzc9tmv+4WsiSp7w4hnmQTMSHLdPlez6DIyXvMeZRR7YiKAV2X2WAW5/W
 COnLoF2nPiSKM7g008lBYVfDXwo+KVu9CxpkzXj3mduIf7zoOv4Si5a3ZkWtNYHXKANp
 iHhNgJHldorZjl1V46GjVH0/LvqUTDe7iKaLTCSbUFLA3dN+bdl+ta8gwIpc9QTBZfbY
 GbjlJhlDh7hQUF2KwEwms3X8oZTlSd7H8n9obJAt4rq056wSUpwgaABHc4FG+TDFT4BI
 yRjA==
X-Forwarded-Encrypted: i=1;
 AKwUvByyNcW4HndybbDXdqfcFlYaagEuSJuVW+d1T+CUQRSC8TnR6puAVQXaosphJP1XZZeUWx8z4vE=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++n5+rt1XdghbpHbDbnSCBFFjPF4PZ+xnUCBSDVmE1MNSaJuHExs
 eSFa3Q6GvGRzeXiiqpUgYC7H/581V9R6ENWAuf3OYNfnZzGbI0uGj2GrmMjwivxo+jc=
X-Gm-Gg: AYBFou1v1bTvP9gPMGDINz30JC4p8BROUzWt8Ub2IOf9QWbdumDZfTwnYw7SciIrr2V
 J64L+SRCwYb4zn9EBDB4Pn9Llox8EA1K7TgDgUjCdQd0pyC1n/9Kyp3iIuuvsiMIDH0cp8UEIGp
 TczBxqCgpl4W26PZDij8NVJw+pbNQDsaH85y9g/z7XTPz55n6c+x/ssEVo5hgibdECJG6/SC6Na
 KmSjlEaQbLP0sDfIpYre1p8az6IsDz83Vy5FqIGFqsVAq12YKQTiNIFeyOhyJx8hGeACxxyM8eL
 RN7/B+TWSm0s3aPtQPf9jrWs17NakKEvh91cybtnBKDMUHleXC8mcM1A5Z+USuSNk0Bp9hWnq+r
 EPxxHUuIMnKNq4XhI3rgqm0RykNTtRfW3bSjFX7guSI2pKNjkcl0hIz++3nS9qAl1AFBKsbCvLC
 U/YYyI2NAHT8x1+FH0i3lY+Z8TT14bOZM8Kw8Erd5hJi+Ga/mxCOjM56X0BzKju95M6Yi0k3kbi
 bKpXoemhA0dl34LZSdUDmdx4dZ5WsXNU4nmwzxodEbBTSpTuoB270kqtt5kgFPxyKrMei7GtslQ
 G5KQxaM0MX7v5Q7t1PfGbgw8dxkSHSXwiK82tTRTlBlOtf+K76KcYwk=
X-Received: by 2002:a05:600c:a418:b0:49f:e4ca:e1d with SMTP id
 5b1f17b1804b1-49fe66fa070mr228660655e9.27.1790685391110; 
 Tue, 29 Sep 2026 05:36:31 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a013cfc788sm450305e9.2.2026.09.29.05.36.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 05:36:30 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 29 Sep 2026 14:38:42 +0200
Subject: [PATCH v2 04/11] clk: mediatek: mt8183: merge the clock drivers
 into a single driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-clk-mediatek-cleanups-v2-4-b296bf3a4a93@baylibre.com>
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
and flags. Merge them into a single mt8183-clk driver, the way
clk-mt8366.c already does, so that a new clock block only needs a
new of_match entry.

No functional change.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8183.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index f004c9748dd..117294cec04 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -797,15 +797,11 @@ static const struct udevice_id mt8183_apmixed_compat[] = {
 	{ }
 };
 
-static const struct udevice_id mt8183_topckgen_compat[] = {
+static const struct udevice_id mt8183_clk_compat[] = {
 	{
 		.compatible = "mediatek,mt8183-topckgen",
 		.data = (ulong)&mt8183_topckgen_clk_tree,
 	},
-	{ }
-};
-
-static const struct udevice_id mt8183_infracfg_compat[] = {
 	{
 		.compatible = "mediatek,mt8183-infracfg",
 		.data = (ulong)&mt8183_infracfg_tree,
@@ -823,20 +819,10 @@ U_BOOT_DRIVER(mt8183_clk_apmixedsys) = {
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-U_BOOT_DRIVER(mt8183_clk_topckgen) = {
-	.name = "mt8183-topckgen",
-	.id = UCLASS_CLK,
-	.of_match = mt8183_topckgen_compat,
-	.probe = mtk_clk_probe,
-	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_topckgen_ops,
-	.flags = DM_FLAG_PRE_RELOC,
-};
-
-U_BOOT_DRIVER(mt8183_clk_infracfg) = {
-	.name = "mt8183-infracfg",
+U_BOOT_DRIVER(mt8183_clk) = {
+	.name = "mt8183-clk",
 	.id = UCLASS_CLK,
-	.of_match = mt8183_infracfg_compat,
+	.of_match = mt8183_clk_compat,
 	.probe = mtk_clk_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,

-- 
2.55.0

