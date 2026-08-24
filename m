Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9603EC5DF9C
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 23:12:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CA38F606A8;
	Mon, 24 Aug 2026 23:12:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O68tt8wTCo8m; Mon, 24 Aug 2026 23:12:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787613120;
	bh=rAIr0Ae+c+/3DrO4YxOk1oAOi5GCGweqI/mtfNKbUnA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Jj2KW5aJT2LKZYPBlse1TkbDCk/MJCtjuSZUDVgDaD95N4jmGNjxWEmvPc6/uaAGj
	 x4hm8iafQ7Xb+1VOW6kxK0tx4dzDoTYIDli2k1T/a99GE7QJMJMd4TvvJPTxpWF4y6
	 MtU2ipsnzY7BsWQx8jPaA/kH+VQUmAiRtw6W++v/xXcFsNdPXZqJ7fwl5drZhHjqya
	 zb6lDfKU/uVe93RsW1h3pnyQA+IJpz0UO/0j2rAh0iwIQWkf2/sG1+8UlskeRvt6+O
	 g29YLQiGRmgTbKGkAgrSPsSjP4kFk6jnIXkl5vu9yO4VdHsQqq/L+sDBhvmoWm3yPB
	 yMuyL+0z9/rmQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1157160670;
	Mon, 24 Aug 2026 23:12:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E7622118
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 23:11:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D396F80D10
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 23:11:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L7uvB1PROyqN for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 23:11:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2a; helo=mail-oa1-x2a.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=eDtpgxPI
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5316480D09
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 23:11:55 +0000 (UTC)
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-451d8064238so3892043fac.3
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 16:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787613115; x=1788217915;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rAIr0Ae+c+/3DrO4YxOk1oAOi5GCGweqI/mtfNKbUnA=;
 b=eDtpgxPIi7VLIxlOgech8ef+UWGB8NXvLSCYib+lUSbPOkwlfyF3PyaIKugzvKZamo
 u3fJfkaEGb7eBnHonE6NevTYSa39qK59c4hEL5WpwkecxZN368MRZbzJ3Df0DraYBIQ1
 PmAr0+dZyK3x1CnSbWqknBdA/RCDxNgSS+Qs18I+50mT7kgdE0T1ZFi0a71tJTI6HPu5
 FnnesHetdJQhZ3VR5cqht3qzQYfgH5f6Zif2S7pOwodCyMnDfSvt68UC81wyQcE98DCq
 46L4t6cENKeWAaenKjXZ1088o/frankYeK+RI9kfznzpp6ZF2mTPnzbS8A2BT+gZTGK4
 BMDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787613115; x=1788217915;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rAIr0Ae+c+/3DrO4YxOk1oAOi5GCGweqI/mtfNKbUnA=;
 b=kAMiAYV3V3i4ebCgvBUTZ0KnbOsMje8a4rD+ejM8+qiECKT8rR1QT54hyHT0hn2ew3
 RmflhhJQVDGZrNROOn5RyAc2JhnqGPiL7ILqBjOBuLGi9MIfibCnX9v3k0eng7jCIHBm
 0gL0x9Rnraf/DGtMA30iAC8RSuHYmqEg+YU5QZqX1iVNwpBA/OxdZ8+yEzwgWJpSzF2q
 ZbqDNQgoVokJSq5sZuw0vaEG6Vhkzjnn2f4WgAtUJupvUtkXHjcH7IkkshPnwfe94a6R
 tYy8Nptzr4pFafC9dqI8dUneByB7C40I4lN328DMNgbO+7eRjyk1zNa/+BVcxuqdN+aD
 a02g==
X-Gm-Message-State: AFuF++kFvZ+lVRSVtavJFycaUyzdnSHPDVmq/I3dVYZr/Lt8EhITx9Ep
 /ayGvXCW+LblEdrHbh3TEQmY8w7yShAuKU5jo6ARAgS7agCYIIVbA1o2XFe0R50EKqE=
X-Gm-Gg: AR+sD11df0EAAyzoc+0COVDUQ6Izme5707digmu/xlB4iOAw9SXnGdvNcPeMUmPWZh5
 xMqrfZ0Kjkebf3a1WntFjxgk/psXgk1+g+W9M0JKmyeiYo7i3YBZHiR/aY2D0Ogkzsd9tXUA9TK
 ohATv1lEkRm5OqgDYx4+pq+aasUoeWT2H8R53rt1ZWYc+GU8hU7Ao6pCDhKzgikz8DqeH0QQBuV
 ZEEpOWpxcMVqOJNGg/bcgh/Bcr0fhOOfeACM3KbvUD6r6RuKISF052u0PQAW3wnU68rg+cA3S5I
 +APsVym6qSpsh9nn3K2XzVidySybmlK2PslI4A5XaX9EvhMfBicW2tu1wrfJ7/kejur030h1AiH
 Co+el8Z+9gbPLvNv9zjxuACJeBnhpchqSpAY9tx/qai74iLWyvKuEtXPAMOu4vp+EewBP8LdziA
 Lb+d7aEjyY8ZsBu4eZjiwHks5cGGqPMZ/9zzwwlTByUiTWBVlmivp1OLX15CjTR5Ozbw==
X-Received: by 2002:a05:6871:c8d5:b0:44c:5d96:337 with SMTP id
 586e51a60fabf-463516883c1mr27424984fac.13.1787613114930; 
 Mon, 24 Aug 2026 16:11:54 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:29ca:5dba:5fc1:6f13])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-46383539b74sm5929420fac.14.2026.08.24.16.11.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 16:11:54 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>
Cc: u-boot@lists.u-boot-project.org
In-Reply-To: <20260806-mtk-snor-fallback-compatible-v1-1-74559b491b4a@baylibre.com>
References: <20260806-mtk-snor-fallback-compatible-v1-1-74559b491b4a@baylibre.com>
Subject: Re: [PATCH] spi: mtk_snor: combine mt8188 and mt8189 into
 mediatek,mt8186-nor
Message-Id: <178761310484.2485046.11623536606267913288.b4-ty@b4>
Date: Mon, 24 Aug 2026 18:11:44 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=360; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=eLNVQCIOv20wir0FH7PzAeSo+eenQ0iptwUUQ38Lmds=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqjM+yQrxNFEZ+I1OxHWUWyv4x9EZZifG7c6PSx
 qU8JBOrX8mJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaozPshYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A8SUH/1WJ8nZicIlcRcIo0dDtKAM0haNfWXfgzo0aGwG
 xWtbSe6ltZixx9sJP2jM98T7xd8uXHUfGRM7p3cychEiaE7WiuvUuGKZ8iCCgaCKQsVUf1qhvgS
 6yTzN5S85KdR4M6f5XJY5TgHwZWYRQjAQ/FCYCewgmvM5bap1LbnHVYuH0ztrYzYvFT/liZYtmr
 o9092SEAeyeWVmfCPUe33cFJHyT1/yFsYumY7nIO199ANrmLmJWVy8x3FUzhzAcja0GtFFVA33O
 lTLXhH0KTi4h7ad1Hphaq3iumbY3JgpI4/IhF9NHu6HKrdPClBh2rrf4I5+gzIZK/NtGwzSbWpM
 r0tE=
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

On Thu, 06 Aug 2026 18:40:19 -0500, David Lechner wrote:
> spi: mtk_snor: combine mt8188 and mt8189 into mediatek,mt8186-nor

Applied to mediatek-for-next, thanks!

[1/1] spi: mtk_snor: combine mt8188 and mt8189 into mediatek,mt8186-nor
      commit: ca1cf823fa1e59039494d4eabb4d117abd4844a3

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

