Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DDEFC53200
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 16:18:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2CF7A60667;
	Wed, 29 Jul 2026 16:18:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ga1yfketgb-F; Wed, 29 Jul 2026 16:18:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 82798605E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785341883;
	bh=m6i3qURXc7jN8FH9yiK2RdV2TI7wihyaV97DPEE8ZDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sGl1vPSATXcERHXMalaIVuOuxW9l7jDhAlR83Qf2AgpXdKV8LcSOWaOv0ei8HADlW
	 uBrXFhIcLzNnEwC0q7ccTh0hiJrdxUbESrlhPCu+Nf6LvxTyDlSzyzCIKa12Q5U/KV
	 ZCafO9f/WYK2CWfbOmmt4yZSQ515wZvD9qdK1GLarQplWfUswbTdjU+X2MxbNtMcxt
	 QssCCmH1pmdmbuaeG014BF5VkrrvHCIPDEWPMFuM6uSOdRRIoo6lgRM0r2kKGhaLOf
	 037UZ0A5KgR0GM3NaY0ZU6yaeRsLX37HfN2Gjp5u9hNdxFoAIntac/DE9nB8Ie42WX
	 IXqXWktjXHdlA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 82798605E5;
	Wed, 29 Jul 2026 16:18:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 09810788
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 16:18:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EF857605E5
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 16:18:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t5gYeY28KoLa for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 16:18:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2b; helo=mail-oo1-xc2b.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org BEDB8605B1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BEDB8605B1
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BEDB8605B1
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 16:18:00 +0000 (UTC)
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-6ab021f1daeso460026eaf.2
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 09:18:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785341879; x=1785946679;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=m6i3qURXc7jN8FH9yiK2RdV2TI7wihyaV97DPEE8ZDk=;
 b=fuXlsU1eaRISbfON6kQWGJm8ReUmwDzsc/H6APmxuByI4yitC+lbFV1boSeNYX94Ef
 F5XjJlPNby4WTEF09VGV8h0UP+GANyRzgebtMd2fdkTfuNCiYJU73UqC7LAQLWRW2Oo9
 K46LLUFUYtQ/08GrEKs0QnbdpX5iAdiR6zqEoYB/sUG3OX6QGF0VIrty62fH87u5JbMm
 A/e9VVOZviOHKByRjp/ODq+yFJ1JJktOg+XckmJpWX1C7V2nh3FhY1Rxcsgrk8K0yAnY
 OUWm4GLR3w/7AuVk6I375ubYel1c4i5wC51OygWcplYHpv48eJgVSHJyVKqocmVazOuB
 SB0A==
X-Forwarded-Encrypted: i=1;
 AHgh+RqYCWf9Y4yBFHxhAzoNuIs7Rf7BWLlYODOv8g++BoaLcjkCshXbxmHl8f7qEQqEjhLVWsfuFoQ=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzkAd3CTCg5pRDTmuzdFUM3MMJ2sM1C1xfELUv/Dd4/EhyD98/M
 H7KbeTL/KerpMzAL+1dB5it+IFZ78UM5ikX3elPteDQNFQJvBcuHlLA9hw7MYioPSZ8=
X-Gm-Gg: AR+sD123a1XWj9JzXSIUx6ZclXeKCpN6wqWXh22JkzELOuba1sax4oOeE4NaIzICc91
 Gc3p6O9XQBDkp/Mc9CtM5oThHStcnnYHTlp0std0LMPsxyvePJX/Bmikt9glImydcp/hB8irc7v
 UiVDTzwQ/nbw7YwaMVXUDhkLAry9/1jsG3qTGLBCBogSMYk0+TJY+GvCjKRB7U7+rtgfreb5M24
 Of0eiVpL4MDt6x4nAHNW52M0DulAPiwLO/lP3rmLoEnYsR+Pr6tZQ9EwpiU2wKsbJRECO4lA2eH
 u1kQI5+HdDOhqaOAdseDu7Hn63Dvc1uXnHx5qLLDc8Fc0fT1zyxzG68xv1puiki9E0ajQcI0vmB
 t7gBleqAeTVp40nb1eWfidN1zMSrMvnEssKe1HJVAgkUtXJU7eIaVmNT8mCFGNuak3iMQ27lJ9N
 IVQ02ipHY2/JL/vClDKW3vpgJtvUfFtJuBOU3VjIE5RrMrs8HrHAEeYKFV/fubtvQ=
X-Received: by 2002:a05:6820:4df3:b0:6aa:de29:647 with SMTP id
 006d021491bc7-6acb61ecb78mr183673eaf.29.1785341879328; 
 Wed, 29 Jul 2026 09:17:59 -0700 (PDT)
Received: from freyr.lan ([2600:8803:e7e4:500:3096:ee5f:6f57:afe1])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-45886469a49sm2675401fac.6.2026.07.29.09.17.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 09:17:58 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org, Carlo Caione <ccaione@baylibre.com>
Cc: David Lechner <dlechner@baylibre.com>, Lukasz Majewski <lukma@denx.de>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>, Tom Rini <trini@konsulko.com>,
 Sam Shih <sam.shih@mediatek.com>
Subject: Re: [PATCH v2 1/2] clk: mediatek: probe parent providers on demand
Date: Wed, 29 Jul 2026 11:17:42 -0500
Message-ID: <178534172705.998601.16883937333293973375.b4-ty@b4>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724-ccaione-upstream-fix-clk-probe-v2-1-ebcef2e94e9d@baylibre.com>
References: <20260724-ccaione-upstream-fix-clk-probe-v2-1-ebcef2e94e9d@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785341879; x=1785946679;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=m6i3qURXc7jN8FH9yiK2RdV2TI7wihyaV97DPEE8ZDk=;
 b=QlwA9EorDp1Z0+Dqrexx+ft+PnXY1AEP/xWJYlBrHUbqmMw17lzN169bRp1D9TvtIK
 KsnIHPRzcz2sFtrHARf4bwRxYQNVCX0pTT2KfnfXvY6l4wrrmZJBCUeirkqSzpr81LpV
 YhwskUkkBQuZGO1dB8YlEGRdMHoefuG7EN7m9VF94XGc0Ihg18ckskM9UTJmC7hhCfAm
 lO0La9cNzCI5Ru+KwYpnP1AvkIcZa6p6KYu0Yasd7AFRYFc6QCqu9wvl+KPQiqarn4q0
 WtaLefQ3Tk8jVwy51iDTwOdioxaNAyYgEXRUUj1SED9hGcaXeO4FxWmB6ArEYmDbAOr3
 PZdQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=QlwA9Eor
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Fri, 24 Jul 2026 10:36:05 +0200, Carlo Caione wrote:
> MediaTek clock trees can reference parents provided by a different clock
> controller. The provider registry is populated when each controller
> probes, so an early consumer can request a parent before its provider has
> been registered.
> 
> When lookup misses, find the MediaTek clock device whose operations and
> clock-tree type match the requested provider, then probe that device.
> This removes the probe-order dependency without probing unrelated clock
> controllers or treating a driver's bind callback as a type marker.
> 
> [...]

Fixed some merge conflicts while applying.

Applied to mediatek-for-main, thanks!

[1/2] clk: mediatek: probe parent providers on demand
      commit: 976b12414c18cb7d601f073dcb2282bac1924197
[2/2] clk: mediatek: drop probe-after-bind provider setup
      commit: bf75f80082a194a95eb2aef039a746c5765ba8d1

Best regards,
-- 
David Lechner <dlechner@baylibre.com>
