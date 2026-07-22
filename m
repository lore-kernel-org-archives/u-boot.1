Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71AA4C44532
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 16:57:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2CA3360855;
	Wed, 22 Jul 2026 16:57:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XXcK1M_j8DX3; Wed, 22 Jul 2026 16:57:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C8332607F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784739454;
	bh=O7VxFIjc/73yRAnif9y+MTQR6VdMWBzJQ93+GEY+Yvc=;
	h=To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=xBcH8kFDDl/qZZ7uFllAYAExopBKwrm8UZzzr6XuOwk02N9LT1qwwe4OyYRvLrKjw
	 6S/sauuxXuGbbiHbGgfiGWFne++cX638yuiTUA2KkTtm1TIxIz0UK1H2A7s8agul8k
	 usUnV/zc8nmFI6r1oNSl8YhyLdWmicvMd3IwN5mHQV/X6la5t9EUk1KgVcQjoIDgH2
	 lwvQEE34YanEbfpsZg7XuIVvtDe+o/93eJu0mGKxUmFdzLojIXPCD8oUtYTNiFkaj3
	 CNaV73XPA6AQaZ3OXZAKdistX4jiDfmzuE7VSc0xyIjPazj3oKbCsb/+jDtA/z4gxK
	 rtMCz9i8J7b0g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C8332607F6;
	Wed, 22 Jul 2026 16:57:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E0AD9313
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 16:57:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DE8A4607FA
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 16:57:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jDZVIRZB6DPg for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 16:57:33 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org CE495605E5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CE495605E5
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CE495605E5
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 16:57:32 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A003846A4; Wed, 22 Jul 2026 18:57:30 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81C9783E76
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 18:57:28 +0200 (CEST)
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-448cf99c133so4319036fac.1
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 09:57:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784739447; x=1785344247;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=O7VxFIjc/73yRAnif9y+MTQR6VdMWBzJQ93+GEY+Yvc=;
 b=XyqBbP9ok0bNkcLVt7Iu5ebnkIZO2Fn9lCmS8udjtL+miY9CVN1ROn1BGrT5wPNzcs
 GM4L+i4EmbBcxtrnAbTgLRjPQ071Wc1cQgEBi/QXBnBin0+Iv3Sv5kgn+bkPUV7L83xm
 qZfQrFSmFGVfhseG3QDjaruVRNXMII1ir9YdKtzzreaiyLYikms7vabxWHZCTzNvrog1
 zVBhAp1LHGj+eBHrHRpJ/Nmoq+nPDg+V49UPdxDSRYr9vN0Vr2CHyAO+8y87Ix8pL98j
 FZHS33y2IKtEjB1vqGs7423hL/2F8sS+be8O3fryK+qFbbzuyKFbSl8eH+WzpFJmLPz3
 Y6Pw==
X-Gm-Message-State: AOJu0Yyk/UyFCG0rEdUFslZOumXmlRNpAvVcSxNqJF2/sE8DW5vCKTeZ
 +zFFucDtJHqzrA5iLudvt3uO8DfHazy/gyVqqz19FH/dYnphuLkyO/otcguyOaWlAWA=
X-Gm-Gg: AR+sD11NrMv+EFGBwm0AaVcXrunrVs/UUwrAYaCHgiV8pe5IrX1bxguOQvcP4hcEM3B
 BZRMfxRPiriG3FM1pCet29WahNonu7E4HQ+DnmCYUtHwiHBaVT5hsKRj88GTqUn/dpgnqBzLMhU
 G5RyL17ZQuJ3GSw6SQ+iRPX4Jn/lWuI81xPbBkemZKIghFSoA6xxwOAojlzZ0g56l8ztCNrrDZc
 mrRFPFB3MCw6AtR9OrTJBfFaLFgcTIHE/URsq/bOCmwOP5VNoU7QePT57X3m1PNggvbk4Z0oZvO
 vozK/O0J782ZFP2dDOj6wwtzQ6l0F7Rlse178BZ9xFVjP/WE5PVaXKG12AQN2oxldACKpd0mkoP
 MLUg2aPf8TjWW+9KWqtQGb2t+MdOfHaGR6ZvMbOfdy02zoyBqx49EHgN0rheCDb4ldoHiBDgimZ
 d9+CiS6Q==
X-Received: by 2002:a05:6820:16a4:b0:6a1:5097:667 with SMTP id
 006d021491bc7-6aa4c5bfb4fmr2204648eaf.34.1784739446977; 
 Wed, 22 Jul 2026 09:57:26 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:d067:7d1:556a:2be5])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-457673d267dsm2505585fac.11.2026.07.22.09.57.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 09:57:26 -0700 (PDT)
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20260706-mtk-clk-mt8189-fix-vlp-parent-v1-1-aedc2f8cc69d@baylibre.com>
References: <20260706-mtk-clk-mt8189-fix-vlp-parent-v1-1-aedc2f8cc69d@baylibre.com>
Subject: Re: [PATCH] clk: mediatek: mt8189: fix VLP_CK wrong parents
Message-Id: <178473943526.3352940.13414738978219386765.b4-ty@b4>
Date: Wed, 22 Jul 2026 11:57:15 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=324; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=J8fMdaEwYYcuNLpj50Kbg8M8AEfff8BPSBsIjySiIqc=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqYPZubc8MnNwW2wmYfbh3J1tva2jPFkLOlrR46
 e4GmhW2J7eJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCamD2bhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AkFgIAIOXBBW8uSRG7mHAh/qB4oKSAXStTdnbvsQ+hYf
 rdsFleoh5gZhTQELkyLt3IILzXzGr3DgkqdjeDQs0NexT9370WtOJsXV2epgj4UyCMjzyTD0WMm
 z8rR5u7hbxikFaxTkuPs84334NGn2ltqb6TXbcU2Qu1hKGKpmIuaPqsJIht+eYhLrVoqN0OSdnZ
 HAnUYDpxxUqzDP1GK3judOh61FQM2xqeEEklY7WhlS1UqUY9j90YvF037bsUeGAUsrERUuDSd8q
 GMDiM8QGG6lS1XLplX6biEwZEfuJWVIUxMCrNWM/L/ctISpJpr5pXBgHxZ4xNzSX6jFS8fauVeH
 nnrM=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784739447; x=1785344247; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=O7VxFIjc/73yRAnif9y+MTQR6VdMWBzJQ93+GEY+Yvc=;
 b=m8cM4SsV4Y66X2WftCFQnF/DQUI7959lYnGsWqSO6P2fZaL9dnkqypB34IzeE9dQw7
 NO/b6uP8e8YBXjuTo9a1nEe5nFlfwl/HR3EOJDR/Y7vvcVErcw5gs2h4VrW9zMg/WUN3
 fEp9gKLagLvqk6OVJ2m7qXLnsyBdGpoeExaRdyocNvmNp0DhbL31is72QFeGl7ay9dpt
 OF+V5YBxTtX6v1/AsucH4Iw5dhdQX+Yeuvbfv+osA6xws4i5f5vHLZtKqe6c3etfyfQn
 gVfyHzIiGqHlb9jGTim5OSCc7EhW2cSR12OL5SW/6eVVebQTzD9yx9/TGPuh4wifHiWF
 JWpg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=m8cM4SsV
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dlechner@baylibre.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=baylibre.com header.i=@baylibre.com header.b="m8cM4SsV"; 
 dkim-atps=neutral
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
From: David Lechner via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: David Lechner <dlechner@baylibre.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Mon, 06 Jul 2026 18:52:44 -0500, David Lechner wrote:
> clk: mediatek: mt8189: fix VLP_CK wrong parents

Applied to mediatek-for-main, thanks!

[1/1] clk: mediatek: mt8189: fix VLP_CK wrong parents
      commit: dfde529a780621810b0259956fc09c152e666b86

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

