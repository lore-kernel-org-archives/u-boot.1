Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E92F9C44536
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 18:34:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2E62080D99;
	Wed, 22 Jul 2026 18:34:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kc4Xxl-umF0r; Wed, 22 Jul 2026 18:34:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 98AAB80B52
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784745262;
	bh=KAIoqrsoCOhMqvHM4Xyp3PvTAnHY2i9agdQwTySg67A=;
	h=To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=twmp66dO0yG5mpTTWkdd2crFCWoZF5TTBw2BVOXk7oxRg8WNVnSdRmx/NA5OoDcwj
	 Xrn6hMu7cnZsnH1mPDHy1F8qTtiEuhZq/1L0EKCsGgP9JsODdAS8PMgqkP+1HgCgDM
	 up7jG5awVIvFKyzWJnzHrnlMYl0nU9LJz7XJnZk8wRl6bngojosHJzPm56pgcAvgB8
	 bC0NzGBXLB37TspIKp1DxwmsS/CqS8CMaPFH3rgSj9uz+H+ETOsRBaoXpGf+HnJNBM
	 b2aursAckuBNGL5N+L10yn5AEbaddP1eSk6F3m/Y9nuS9GbXDHY17lgcu+Y5qoqc5Q
	 SLcyrvpiMs+xA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 98AAB80B52;
	Wed, 22 Jul 2026 18:34:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 29FE91B8
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 18:34:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 12F3380A48
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 18:34:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rarY_yNQCBt0 for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 18:34:20 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 79D4D80845
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 79D4D80845
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 79D4D80845
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 18:34:19 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A4C9848BA; Wed, 22 Jul 2026 20:34:17 +0200 (CEST)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7006083E76
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 20:34:15 +0200 (CEST)
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-6a38e51ae95so4048659eaf.1
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 11:34:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784745254; x=1785350054;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KAIoqrsoCOhMqvHM4Xyp3PvTAnHY2i9agdQwTySg67A=;
 b=VnKbG8CV1k8Yrsc5zsx/32gEtzJc6SbbshuqJ4crivaM19b02ykVDRvVQpCBUTovTE
 7xEZDPBxRheWw0h9wfiLMWZuHSvVZuny1WUmjGkjOrUBBReildvbMrxRJ4DHNYdM5I3p
 mSn6qQIxPZJOWxf68f4+wzA/tADhRKppx02LsZb4qOdJWG0JRRe3nhSXrMCnbgz0EbTb
 Bj0aqbo98X+ftOqluQE7zchRK0jrYTWM+GZYgqKojZTDIAQX4pzw7/SR5Lxc2Wo8K5AJ
 szcTa84H2IHh/IEsL7yUEE7Tr+6UXj11/3K2PmwxiAzm8u3PjHEq/UEkj2rxapE09W1B
 U87w==
X-Gm-Message-State: AOJu0YxfHoAiW2ZwbMbas21xc83uqRF1fCxeJ6oNPakkOt4n7Ef8rAex
 uzAlo/6V+EifthVVLbnBRMY6E9JcY5YFBnAv2QLpQ8XcKxG33YHcSqX3Q05QWXiXk4I=
X-Gm-Gg: AR+sD1345iVVZFeWWNvk/cT3P+ghY9+YH9BxRSyIpQ9/giBQZWy03ZuHBTwAePQ79IH
 npzXxZE/jqR3N6qA5YJNNIBfU97SFB9La41p5UwMVWU0jrYnt075yfL+Tu5lrIlk8eMS6Y/IlZC
 dDj8J+KoWbLJufTiRor51sCxN8CVGmYEBk1WzuSQIyROm7X08mVUPJ9r7+lF1zFDyXn5PMDSlvG
 5Pyr0wwUNFpE9Nz26JfAVe1/spvT7TtoqnoAMS9l15Z/FhekHwuOl+shVTkr4axbwUAlFf/5eSa
 /Mto3m0QGLU1OB+dz+5diBIaHJjlSpWSPs7B7Vi9R493yi3FTyGhl4SQg/H1HK5bC4kgFQrbNGs
 vShdt7/TWCyvgDN7PnGmnKENAg3p8IiOnzKDyJSS501dAh3fX/KRHGddlQMg7Hy6XuozU1ScXAV
 PD5spwlA==
X-Received: by 2002:a05:6820:4dc7:b0:6a1:7fef:e88a with SMTP id
 006d021491bc7-6a53680284amr11912965eaf.28.1784745253941; 
 Wed, 22 Jul 2026 11:34:13 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:d067:7d1:556a:2be5])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-45766f16541sm2436326fac.6.2026.07.22.11.34.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 11:34:13 -0700 (PDT)
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20260707-mtk-clk-unique-driver-names-v1-0-283d9a55361e@baylibre.com>
References: <20260707-mtk-clk-unique-driver-names-v1-0-283d9a55361e@baylibre.com>
Subject: Re: [PATCH 00/15] clk: mediatek: unique driver names
Message-Id: <178474524281.3352940.10355814282483444150.b4-ty@b4>
Date: Wed, 22 Jul 2026 13:34:02 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2248; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=MY+L/aNTXV8XLT2UDOBYkQt/TwokUw0KsjcGFueDLVk=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqYQ0dek0zoR5NP08PyvxRjgd6Ttj/chzLOAnIp
 6g6+nMCvjeJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCamENHRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A9QcH/if4S5CfoR5xIhOEKdok1E3DwPEbCQgonpQJPKQ
 6VPfASWCnK2Wi6nz1Q3xP0V/9v7hBH74TysMFoAVkhi8JOpL7sjtizt0winqNOLawHqSL5R3LEj
 0n5zcZKMWcL0Xc3wyVCG4xKR4jV+Yfo++8kbg3522AToDoK9PwsLYP6yNv+yd55U7YrZSuK5fdj
 5GwXYDjv49TJH1+1/rXYJdb8brs93ZuNhpPHYwz1NRp9ARKf12vgtNHsx/ceO8uNBh8EW81CQNG
 4h4B2oQALSxEo3RyaXzfYpgesZD4ARcQhTy1QWZm7MDDghR1B2lam9QC22UCSBWZFE+H3iHc9H4
 2xlM=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784745254; x=1785350054; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KAIoqrsoCOhMqvHM4Xyp3PvTAnHY2i9agdQwTySg67A=;
 b=eYWlzP3Yn/P26GJj5i/FH9B40w6C61zmuYjOSA0YNoaETTS+5D4VSbdACbiwRE7UUY
 ER8cLPn3hZtyhBVpe/vXZbOt5/4cA01muZrwkRMFl0xDQ8oSW1ITMHHAktp3FL4EXC+0
 jgYrXj1dJQyUbXH26itEhw67F9V3+Wh6JM5aPAUS5tBWHo9QdOYIqjzhLdqoWwIsz8m2
 iWHiIuKkd1dN1iA5EdUoB/GNf2xSXwG3zf/BUUhkS0JTOHZLtxRC3pCOIQI2ogj7Z4yk
 v1rsnbyBZAQiC8E3RLpJ8Lk04EzZm2ArMYZzK+H4xC1n+TI0xpR6oLACbK78dy/fESs/
 ReXw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=eYWlzP3Y
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dlechner@baylibre.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=baylibre.com header.i=@baylibre.com header.b="eYWlzP3Y"; 
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

On Tue, 07 Jul 2026 14:10:02 -0500, David Lechner wrote:
> clk: mediatek: unique driver names
> 
> It came up a while ago that we want all drivers to have globally unique
> names in order to build as many drivers as possible, e.g. in an allyes
> config for build testing [1].
> 
> This was blocked by the fact the core driver used these names for
> looking up parent clocks. This code is slated to be removed [2] so we
> can proceed with renaming the driver symbols now.
> 
> [...]

Applied to mediatek-for-main, thanks!

[01/15] clk: mediatek: mt7622: unique driver names
        commit: 9b52211d15d4f673d1daaa407b33ea7dcf1df8ef
[02/15] clk: mediatek: mt7623: unique driver names
        commit: e17d2af3c61b7749f5b3ef173dae65fafcc156ef
[03/15] clk: mediatek: mt7629: unique driver names
        commit: 552431a59fb8d65ce00ba5531b57c8fecb159a9b
[04/15] clk: mediatek: mt7981: unique driver names
        commit: 9b9ecfdba4c24acec2ab9de5a0191bf7f129aa64
[05/15] clk: mediatek: mt7986: unique driver names
        commit: ebe95d6a2782a1c64a3ceeb0078e29eaa26ddf5d
[06/15] clk: mediatek: mt7987: unique driver names
        commit: bd9bf2ad5eb23b060924ddc391efb7716aa0c00e
[07/15] clk: mediatek: mt7988: unique driver names
        commit: 9d111995f0e9e5d42dd4f6a1662495bc26fdd52c
[08/15] clk: mediatek: mt8183: unique driver names
        commit: aae6e3b156c6a8838cfaebf8a633e2084c229fb4
[09/15] clk: mediatek: mt8188: unique driver names
        commit: 9a441347791d40e4c5593b25b913adf3285b1883
[10/15] clk: mediatek: mt8189: unique driver names
        commit: c99eaea4e9afdc798e6ec75264ae4e48221c1975
[11/15] clk: mediatek: mt8195: unique driver names
        commit: 82946f1797d67507b670a21fbd28de8a8607f782
[12/15] clk: mediatek: mt8365: unique driver names
        commit: 98c458cd32201a748ef6852851411fda1a47d32a
[13/15] clk: mediatek: mt8512: unique driver names
        commit: cc8cb613f4d0592ab3fc0ab4b92981ab74a890b3
[14/15] clk: mediatek: mt8516: unique driver names
        commit: 3e69cd14e17a0d6f9bc9c46501c92308539fbb86
[15/15] clk: mediatek: mt8518: unique driver names
        commit: f4f1287bd89d7c118792da21898780db8e3b22d5

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

