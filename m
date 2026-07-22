Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB026C4453A
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 17:39:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3C14280D96;
	Wed, 22 Jul 2026 17:39:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EdFjlnpLQbk7; Wed, 22 Jul 2026 17:39:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7587180BD1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784741993;
	bh=+oUeAO7Y1GwYVeIUVwYBIWHa+6ypu2pAJs5FPK9UB5U=;
	h=To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=JbXXN7qm26ov/L8gH6Lb2kxv6Jbi/gcgw3CfaBArRP+zIlSY+lOw+1njqs9xjdRU4
	 yQfQdacmNQauYTDLpY8AnH6EnJ6CNYOEVTWwTkR5vhwJsn/+ys+Ef61ssYXA1HHsX1
	 +FmHk2ow49oNXqTmJanIVR4wetbN98XCieRVLvYO9U7kra6IZyCCrlkAhTYHbMVkG0
	 j2PbEITw5Z/5ic9IbEOxnkdZ2l/DDWo5aP/qJv3h4dpFh9dKUwFdSq0cXUbCwrmOjI
	 YQgDFptQhN0BeY/7wpfkc+Esro9L7kSIzUPwVSmSqJ0nWzwHoFOLJYu7Qe/X/vFPVA
	 RjDUQIBDUyqBQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7587180BD1;
	Wed, 22 Jul 2026 17:39:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 146AD224
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 17:39:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 05C7580BD1
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 17:39:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X6lcjwwj1pCJ for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 17:39:51 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org C9D7E80BCC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C9D7E80BCC
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C9D7E80BCC
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 17:39:48 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4C2D846A4; Wed, 22 Jul 2026 19:39:46 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57B4483E76
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 19:39:44 +0200 (CEST)
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-4a4836dc117so1589355b6e.1
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 10:39:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784741983; x=1785346783;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+oUeAO7Y1GwYVeIUVwYBIWHa+6ypu2pAJs5FPK9UB5U=;
 b=pGGtblG6T5dZURTXjA1MJQj7iYlVO3m1YZHrsYSwjENiLDOaWl1P6soKFwDk/NSj+m
 2gkc7ylqlfgU153p3V9PXMBkq3yUsvpUqRAmwvpe6pf3XCsP3XUK03jAii/nzG6ZruHU
 qkjEp66s2MnbqJUgdP0HPOlsamkT09X/oNgNdY7zM0R7qGpQS5N+WrUO5fXrSXZkLDrG
 Yz/7FxNaa2VlLSNABBEscpcLeyrpVEcjep0S6ej2a3DQhN+JoeGL62i5FQ4JFlXajp8w
 73WnVlg2qACKhISQl6d8CREYX9u80lr5cNuzD5tHIzPmHaOmC7hS8AioX46jaG2YGqsx
 bySg==
X-Gm-Message-State: AOJu0YwlVMCXo6+NXYttdWhydURGJfsxGTI15KXblxbYCsUekSKU5BMy
 A0VoY/VvtuERXWaZ0GdsYlJOoCg5HlJgCDbcXG6RYJsK/Z0zKv7+c/ysw1EuMesL+ho=
X-Gm-Gg: AR+sD132xNsgRf6iq9WNkUPxhinGqTfzSVM8k7c7QLEO0wHvKW01wMmGiXpBBEllMI5
 qR7NmYmrhdVvDdYKe64H4eTrwsbeI1k9tetC+QMDnEehLOGyc73XSG0aT9C/5GyU7HdsJhGctyi
 VzT/z18mpcxCtDvik3ghbBrMRO+sr9Q/Cok74nLU9REV7uw8mM2+3zh3PGGDAqtdNLbKGVNMS6M
 gzdIb6l1p5oWYjE8i3c3SHIRsz31TVQarfgk5ssTBXI7HbVaQnRZE2sD3t1ll0aI6OVDbdiZ8dr
 ofDzGtDeK7Z4cPYihneD7ELxLWsZGY1Zxq0IIHARKQIVCFDzDZnCJoD6znrOgHg4vvAeWnGD9un
 Euh9enRy74h/5dGD5DtiTWIIdq5xBaJbGpvaXPN/SnKXW3UR4VrUANkXiDDj18Xpky3gBeMicik
 hTBSJ4+w==
X-Received: by 2002:a05:6808:319b:b0:4a3:ff0a:e407 with SMTP id
 5614622812f47-4a4d038a47bmr12003458b6e.15.1784741982828; 
 Wed, 22 Jul 2026 10:39:42 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:d067:7d1:556a:2be5])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4ab0e9aef0bsm1661359b6e.11.2026.07.22.10.39.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 10:39:42 -0700 (PDT)
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20260710-mtk-clk-parent-lookup-improvements-v2-0-f3f3a4a28dca@baylibre.com>
References: <20260710-mtk-clk-parent-lookup-improvements-v2-0-f3f3a4a28dca@baylibre.com>
Subject: Re: [PATCH v2 00/24] clk: mediatek: more clock parent improvements
Message-Id: <178474196881.3352940.430627219269623538.b4-ty@b4>
Date: Wed, 22 Jul 2026 12:39:28 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3345; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=+pMfRY77lwJevw6ulQHHozZpyHa7AaUZwkBMfJUxWu8=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqYQBVylPERzf9lBeoC+sk5cVreRmHke6LPOGWG
 H2IVCgWmduJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCamEAVRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AfZEH/jDhYgWrGCXgPo5eTenAeNAc2tVe6cvcIy8+EIy
 2oTSSszroi8HkfZERxm+GifNSoZMfaAEv+ZAhxyNXIYFzcEELlSMDa66hZLnLaE77vTVjBaWCgG
 MH/P2Kxudxsi3WxE4BC6+Tz6r7oMTmDewsxqkhwleWrYDil8O7/Nb09CP1WF0RO3qAxHIkv+qSP
 hyx+7SgnsdspJkUc9046xambZrdLeNyz1oSVz+mLfLkXAJ0Tvl0tgbEPXbybtpjAjlFAzJPQ44h
 CtBUpxR18VKXdwnEv8ubR+QMxbJAgWA28l8Z4U0rdk6nUM/RZKGWjbMi9wCwox611nAfHlhB9ZK
 Mjb0=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784741983; x=1785346783; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+oUeAO7Y1GwYVeIUVwYBIWHa+6ypu2pAJs5FPK9UB5U=;
 b=aj0wEgj70/7NtP0+x35/ZijOyLXsbIMSm1QCnkA4FQJ7idmVTPxs/cPD/BhVV9/dbh
 tBsjwL0ZoirekksS7sVJLIcMUvbY5fk/VsMTxKmUGUSAEbycxdyrSmfnjDGR3mOOfYd9
 YZmbDrLQ72TxqrLvGT3SlIC3Dmsw1efv2vkBp65rbGDOjWFUJTEPnkDyzPkMpsUmiJ+f
 +Z+/8KU4vLrjM6pDoo10AaU3KprKl0HWMReFDBDZWAIRat4KpabGf1pZyny8lpkFAIzN
 p4Q2J5igneVxcjSbe1xDZpyL7zRuHtVa6O1hWhjtKOoEEf3LQxGZtqSCNb7rcrYbaM9f
 bAkQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=aj0wEgj7
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dlechner@baylibre.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=baylibre.com header.i=@baylibre.com header.b="aj0wEgj7"; 
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

On Fri, 10 Jul 2026 13:56:16 -0500, David Lechner wrote:
> clk: mediatek: more clock parent improvements
> 
> This is the start of another wave of Mediatek clock driver improvements
> with the aim to simplify things.
> 
> This series replaces complex rules about clock tree ancestor relations
> used to look up parent clocks with a simple table to register clock
> trees that provide a certain parent type.
> 
> [...]

Applied to mediatek-for-main, thanks!

[01/24] clk: mediatek: mt7622: set parent flag for GATE_APMIXED()
        commit: 2c8577318ab8e6db7fd5e88b6ef3c94c9a58a6a5
[02/24] clk: mediatek: add registration function for clock tree types
        commit: 5d631beb2c21fc2bf23e1fc2f9b436de44ac8fae
[03/24] clk: mediaTek: mt7622: add clock tree type flags
        commit: 269ba058816027df59b49d5c244511275ddb6205
[04/24] clk: mediaTek: mt7623: add clock tree type flags
        commit: f28ea3a26a3970ea79eb4dde00908e65261a8a56
[05/24] clk: mediaTek: mt7629: add clock tree type flags
        commit: 72983e25535fe8fd3f1bc0933a2965838feff13c
[06/24] clk: mediaTek: mt7981: add clock tree type flags
        commit: b1c0fb40d6215c651bd9c63029ed51943aa1d7eb
[07/24] clk: mediaTek: mt7986: add clock tree type flags
        commit: de2cffba44c066c4b38d9e8c412060258b50afa8
[08/24] clk: mediaTek: mt7987: add clock tree type flags
        commit: 3bb8ad2397cd4f84472fafdbb3d557320a5ac8a0
[09/24] clk: mediaTek: mt7988: add clock tree type flags
        commit: eaeeab40b1ef8457717b309c4c3d62fc2dce0d2c
[10/24] clk: mediaTek: mt8183: add clock tree type flags
        commit: 7fb926c3cf9c6fe0d25188bdce7beb9daac3b5ce
[11/24] clk: mediaTek: mt8188: add clock tree type flags
        commit: 8ae02df8a3d119521a8ca760c2bafacb0b7b17ec
[12/24] clk: mediaTek: mt8189: add clock tree type flags
        commit: 9ad117b8fce43ab8cf30920e66f2d85def024dce
[13/24] clk: mediaTek: mt8195: add clock tree type flags
        commit: 5c15fdc8e0b94fa4e01129e2e54e95764baf5480
[14/24] clk: mediaTek: mt8365: add clock tree type flags
        commit: 6795ecfb0a5d5bf1c6dc71bfc75cbaa8d0cd8f63
[15/24] clk: mediaTek: mt8512: add clock tree type flags
        commit: ad5b38f0362fe3e500466fa4ea3c85cf420e75bd
[16/24] clk: mediaTek: mt8516: add clock tree type flags
        commit: 8a95973130ae95c17b34acbda4beb7bec7a4e6ee
[17/24] clk: mediaTek: mt8518: add clock tree type flags
        commit: eac5696bb83cee4ae63e96da1f547f7e1a48752a
[18/24] clk: mediatek: use registered provider for parent lookup
        commit: 8ef0ad4c7a6d2ff48318c24784644b1ca3f72a49
[19/24] clk: mediatek: drop parent udevice field
        commit: baf76de5958eec2ecb8ff388725df4ccb98f2510
[20/24] clk: mediatek: remove mtk_common_clk_infrasys_init()
        commit: d50a79e8fc23a30a973b8b149da60089ed100b92
[21/24] arm: dts: mt7981: remove clock-parent properties
        commit: c897d9f06e49c34865707e04e3bd2b20c134e46c
[22/24] arm: dts: mt7986: remove clock-parent properties
        commit: 9a919ebebb0f11810ae70f6e7c2400b4e2294ed6
[23/24] arm: dts: mt7988: remove clock-parent properties
        commit: e3f5fd01d4301f75396723b85c7ee7bd89e2c10d
[24/24] clk: mediatek: mt7629: remove mt7629_peri_clk_tree
        commit: f518796ffd8682c3c73d02cde9c9f14f96e03260

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

