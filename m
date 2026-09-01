Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 162D7C61DD6
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 22:31:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 606BF40802;
	Tue,  1 Sep 2026 22:31:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4blp8NU3zpNz; Tue,  1 Sep 2026 22:31:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788301884;
	bh=g/MCQwsf6DZ7K+tXTnLmy37s6xiZ6VBMq6nrmIu6m9c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zef7lr0SBoGPGi0k7cEzyGe5Uubbba8ut6Nb/QnvgRb9BIHMz6+rE1BWp3HM28IGH
	 l6MXkgOgJpfH96IxLxQtwTTqJvwNUKPQct5/rkLWkp9TdX9G2ROCSsPnQFOMUdGZEJ
	 0/BRGhk3XZrjPw/apOYF4hh73PVX17ILoEpjqp5BpB7H/EZAhu86WXADU2tfLbYHkx
	 6pHNjmbmEENC+wSKjTkv9sBFglvlt89VxaVaHYxqkGpaLSWIUjsIuZGqVm4Tt2mQTc
	 rORPD6XRIi5HUNuv6nC5+uFnPGjklsx4ZimgVvhliCFEAOa26QO4GF67TdX4DGKc5b
	 9S69wJ3mKt8ZA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EBB0A407C1;
	Tue,  1 Sep 2026 22:31:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id CF2CA279
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 22:31:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B49B180DCC
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 22:31:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4n249IUBSjv0 for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 22:31:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::231; helo=mail-oi1-x231.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=K2pH/neu
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D6210807AE
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 22:31:19 +0000 (UTC)
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-4b1fcd3b1a9so203966b6e.0
 for <u-boot@lists.u-boot-project.org>; Tue, 01 Sep 2026 15:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788301879; x=1788906679;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g/MCQwsf6DZ7K+tXTnLmy37s6xiZ6VBMq6nrmIu6m9c=;
 b=K2pH/neuq170iWMzXAh8hTdGlwgk+UODuHle373nYcxxq+0HHYCYn9EOOAMo7GdjqV
 wOqgeqKCEJR39B6diBlcyR9eqtRIrowthR0DRfx5NWFwVb6UieCbNBwJ2ulcBUKz5AId
 yjt45Zzaf0EVkGm8GGIMchFEvY1fsweyza8QgXIkz2Zxd5BpqexqDQD7x264qpGWuZuU
 t0xvBlRZWWd+TE5D81JEhTUvDF/HEwR/g4pzD1KHUu6C33UaqzIPNwV9VVzo3orQv6gr
 LGJ+qWM4/w39L5Fw9pW9+6pqleavj3s0TuPcSifkYA2nvmTZ5YMLX7z/ALDLYIYYE9PQ
 KMdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788301879; x=1788906679;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=g/MCQwsf6DZ7K+tXTnLmy37s6xiZ6VBMq6nrmIu6m9c=;
 b=L9DnNxpUsLVFJ274A04ej90xyjbx59cZQ0HHi55YpWjg2/ZjRfidYxmxDzZzEebsYc
 O6kjfQK2g2+UsI+mYQiIKQLi/skhOCNl2Ca985X9sr8xG/8JUK9ewAD7KkaF9uh+xNM6
 iXB7BQxTIRlv6SADzJuCVo3vBqxQ2PXKx4NY2sx7v218w3hOBonBu0hd0QTKwzLyoHca
 ifVil4Td1z74mw19WddtPWE1qw2V4PeqFl4jRrxn2ycGZjl/j3zGkldPNnmEi/EoMnND
 slTbc8cfUKwo1awpHu/GDoXmtdGkCZTnLt5QEkM77IJvGnSCsJRV1l6Us6BWHssGlOKl
 siJA==
X-Gm-Message-State: AFuF++m7bSZr49S/br0dq0aBmaeOM4BJG7Tluki/DcWHxwZ3UONBtWxH
 HnE0j3wysJ+KIxKazV8/idkF1KSG8QgmbjJP8uaIjY6QUUI7AxyH6JLZ2XK4lVqiR0k=
X-Gm-Gg: AR+sD12daHQ/Wo6nM68BIgYaPqzt4UYdM6ED5EMUAoh41bWz2mhadgddgH2sc1cORl8
 x2+H1M8GeRw+42Riamf8VgwSBEeNE3hG+5DXKQM7/kVfQg2YOXXrh6KP7Ln5PJMAgW8cEagv4TI
 U3dcG46tukTxAmU0yT2+V1pCVWMyQrHMkoK8p9enjGsmIv11994Tz15iXGUetHjjhuGAvU1udJT
 azR/13AYt48ZAJ/FgYBxgpEM/KTwRaotjO98tq+gcIcESBCgMnGPIngREIQn6erQNB8O9jGUbTu
 aFeIl95EYL6YBsyW0nV2pamQ74GbLv3jOOQqja6zibn7wjOupNw8Lq/jE3PXxb8xLaEtLpVkMe8
 4x0gPL7R7UtT9gXq9Gl0MC9tiGGQ5mSVRL9mKDosvIIrC0xADpPe+Dq+NbUW7RIsmRqiywhWGGb
 z4uf0RpnmHNSJMuBbkPawpbSpLn5myfiJa1ksNqISTX8Rgsj6aSCvAEuycvgziSWEujw==
X-Received: by 2002:a05:6808:1692:b0:4b3:7b31:8df0 with SMTP id
 5614622812f47-4b6beb4ab04mr478023b6e.10.1788301878723; 
 Tue, 01 Sep 2026 15:31:18 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:523f:532b:33f7:89e5])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-46f30baafacsm1604345fac.5.2026.09.01.15.31.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 15:31:18 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 David Lechner <dlechner@baylibre.com>
Cc: u-boot@lists.u-boot-project.org
In-Reply-To: <20260817-mtk-dts-drop-mt6357-dtsi-v1-1-fe6ce3fdf1c0@baylibre.com>
References: <20260817-mtk-dts-drop-mt6357-dtsi-v1-1-fe6ce3fdf1c0@baylibre.com>
Subject: Re: [PATCH] arm: dts: mediatek: remove mt6357.dtsi
Message-Id: <178830186848.2485046.1222079683324172624.b4-ty@b4>
Date: Tue, 01 Sep 2026 17:31:08 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=306; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=p3+KexRk+ztxEcDTXN925+SIejKmFSDV3Ncy64wn9WM=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBql1IuCs/ZBMHQiw5w/gugjTYdBUUQ+pB1XMcJg
 XUa+jpjRxyJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCapdSLhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A2UAH/2USsZA0C/wtsg5gj3kEV+7ffvrOPY+A7nWrZv6
 1tpqBsNxcUGXwRt7VF5cIguDH0UUQaek0hxMtLyDHuTTHEcB83VcnSTIVgI8JT1dK3GE6Ju2hf+
 hyda402Wq9rrlN3U92Kff1rF4FZiGtt8zSKRgSdOuZbh1sCSgM7fGEy1iLjoHVaPDR/fkj+83GM
 cHNUOE1JuPzMiYOrndqxYSFYl9dUQcO0ILe8ROtFa/6b13fbFiODaHBpJPJoeZ/l5BWoLHsGMei
 TdAbcCp4t5JZqaJ8rGwE4Cqp5xJlcSk2Pnw0kDa2Xb4ielDYLjIIQi8JNvICoJH8jvFIaz2FvW5
 Xl+M=
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

On Mon, 17 Aug 2026 19:20:30 -0500, David Lechner wrote:
> arm: dts: mediatek: remove mt6357.dtsi

Applied to mediatek-for-next, thanks!

[1/1] arm: dts: mediatek: remove mt6357.dtsi
      commit: 5549ddbc52c75ec190545c83c62e5b7f4589349d

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

