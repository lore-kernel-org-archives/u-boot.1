Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E468AC54F4C
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 13:00:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B6D1760A38;
	Tue, 28 Jul 2026 13:00:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N0TWIxHUoxiy; Tue, 28 Jul 2026 13:00:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E78CF608DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785243628;
	bh=P4y0ui07aAXfeezQBeiXkFMmtoLYC16Z/7aAKk6+8QA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hATmdVd4x7uups5yZUIGlkNktDtafHm5n4GjxdhyRnZcQfhW8mQ31K9RkbXiqGZ5w
	 mpDs+SWBebaVx58D+5jSSKqRVZ/L3ICMctcpXE6Tev6x3KI9AOBA1ntMGF2Hl5qLaj
	 Po6JYPw7kEM1/FXOznNpjzQtEkDydWRKoY6Ew6zWQ6oOy7EWG6e7I0DW6IRSYbZgUr
	 oILipuQHE+JE2gYqSg9JFsQDElRu7Z+21Kzqvbq70T/Trt7DFqfTGA1xAo5GxUUVRt
	 ThuQdSSHsVzD5NBvWg9+9brP1tDrrZatz6sNDD5StMTwA0eXK9KFVhWtZMMigeafCO
	 gqxmFrnaI8tag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E78CF608DE;
	Tue, 28 Jul 2026 13:00:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9027B45B
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:23:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 81CDE4099A
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:23:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zpEdG4Zp856O for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 11:23:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 4F6DE4097B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4F6DE4097B
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4F6DE4097B
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:23:49 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-69fe3cd5ee6so3996124a12.2
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 04:23:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785237827; cv=none;
 d=google.com; s=arc-20260327;
 b=Bek/hWv9UjBGm7QKiqVWNTEvqXRlexp4yQd08ud6rAP2lr+7moXdNAkT3tFe+Ral0U
 hKE51dO5YIoLprdLsgx4jLJC6QN6NnsWGETfQ7jBl7va5PrFupoOCgBMFEWk/R4dhUX3
 LhfaJgm+e+T8I8odsG89SRZomKC5xuFENzZVW+x3gKt3tD3PMsSBdDdMQ24MjxFEl1oW
 gQ4NzVVJDAw5LJjGsd5Fb20SiKrzm4haS8DQ4QJ6vSLEEg7t+WQDiGqV/cOpZRfoQz88
 2FXJhh4J7wfaWRZOXvv15BrrUSSsgOKu2zQOOKgYi/YWem4/RleKSGiQ6x7ndrvJTqa6
 2LdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=P4y0ui07aAXfeezQBeiXkFMmtoLYC16Z/7aAKk6+8QA=;
 fh=fKLNsKKNouJCXbiPm4Wqr7QFLhe/H4+/v7KZUfF7G20=;
 b=V/uKY8qFpJpzLU+wTWcgxRxfvL2um5jBqy1XZMGnfQ+2eLj9NE461ijKQu+vEpq2ql
 +TgbzXPAOe/J5B0EccAE+fXx8cOFMUSlG5L3hbUMyyUGWk7SZBtxbzTt6x6523yH48/S
 /hgGnPdcv8uevubMBkmj66Sd0l//3RLi2WEUvmH6EFW2Bngz13ue9l2PBUCeKMQK4Qip
 PXrA8VPfbXm9a31FreQj27hMnDkOyk8Ly3ZcVXZcDE8Yv0Rf7rjoFNA2j8rnXpDhrVKf
 7j2ZPseq1HEP0qnKDQk/7TtvJi30csuzAQrTcaEVSxOl9PGGziNZtP3lPusv70XelrjD
 uzxQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785237827; x=1785842627;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=P4y0ui07aAXfeezQBeiXkFMmtoLYC16Z/7aAKk6+8QA=;
 b=QCcQZ8McSZ5eaia9A5S8WuenHijyJ8JO3F5QPdNnRYE8PSe0+znOz7R4tPJ5Uh3K0E
 4nyWP2hGhaR1CLaLApEOourTIeX2TGaJ2lbOUOn0UXulkWhTwLQ9WMX5kV5IXBTcv1Dk
 f39pBLf8gSWUa0lHsNVjKFlaP4iCQXwiEYf/Pcqxw0l/uG5HRSDzckByNV8LDm4denWd
 BNHdcwCtuk//ptRNXUAUel251OSrYT9iVOQiKUL/mLqebzyQhrHo7HN5ycyzRXsveoiZ
 5NSgwtmm/EW84xjaqaDXA37LkP2LBIkB+D8RS3Q45LXyTpwEEbWTP8dGTuaop/KszU4O
 sWIw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoeBku4vd5ciOgnsa60r4WNrKMhhMHaEDfpZlN6CZVrvi0EoS5wXtahGhiRtqmyIfZ/6FnpmQ0=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwjQsfztaj2xQujJBN+n5j3WXfH2xtr5eq0XtoLWVeQW22KgEAy
 juOgjydQcm6zSXLM2IWsHwCN1CKcbh4znx6K5GSiwc26mBD2hBc/tMBRPUfzJ0d6w9ndBvDXO3i
 DsL7Vhpk+lsNsZPVUDSLLLT5+RA79vjvoAcFLVyBS
X-Gm-Gg: AR+sD10oxEYqKyGT6mVpbpiheCiqqOWx/7YaLjkiP053NIarcimJ6s1s2OfIDc0zJf4
 pZEc8Xxp44UwA3/Xa8iyjbXpD97lGYe28pMGhvZOYXIy1oiBlT3lKkFj9A5TNTnXjkiSPuxEdro
 xljm//WbQMsuL5CEDdJVNZeqQL5ndhHcMkfMHFSTFgRMmweJYlq14wki38kZQQxRzMioSod0sll
 nA8NId+GoP5G28b/IH0Ln8zwdYToKlTMpWCWlVWQlu/YDXjIiuLRlSdxm/a
X-Received: by 2002:a17:907:d041:b0:c1c:26fd:4f31 with SMTP id
 a640c23a62f3a-c1f72115624mr96136966b.26.1785237827182; Tue, 28 Jul 2026
 04:23:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260719-submit-ce-series-v2-v5-0-3c41f66d4522@gmail.com>
 <20260719-submit-ce-series-v2-v5-7-3c41f66d4522@gmail.com>
In-Reply-To: <20260719-submit-ce-series-v2-v5-7-3c41f66d4522@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Jul 2026 05:23:35 -0600
X-Gm-Features: AUfX_mz4zcgN3R5yqFxV5lyueulMF_X37ltcpxpAYYvNrbtHFSoEOVRrgxz4s1w
Message-ID: <CAFLszTjt1kmQOArWZ13Poa_hqw8DsQHfmuDyYjp0b4gmUodFNQ@mail.gmail.com>
Subject: Re: [PATCH v5 07/14] crypto: aes: add software-key provider dispatch
To: james.hilliard1@gmail.com
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>,
 u-boot@lists.denx.de, 
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Chen-Yu Tsai <wens@kernel.org>, 
 Samuel Holland <samuel@sholland.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, 
 Thierry Reding <treding@nvidia.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Quentin Schulz <u-boot@0leil.net>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marek Vasut <marek.vasut@mailbox.org>, Rasmus Villemoes <ravi@prevas.dk>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>,
 Aristo Chen <aristo.chen@canonical.com>, 
 Anton Ivanov <anton@binarly.io>, Daniel Golle <daniel@makrotopia.org>, 
 Francois Berder <fberder@outlook.fr>, Peng Fan <peng.fan@nxp.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Randolph Sapp <rs@ti.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Alexey Charkov <alchark@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Anshul Dalal <anshuld@ti.com>, 
 Johan Jonker <jbx6244@gmail.com>, Francesco Valla <francesco@valla.it>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Michael Walle <mwalle@kernel.org>, 
 Andre Przywara <andre.przywara@arm.com>, Lukasz Majewski <lukma@denx.de>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, E Shattow <e@freeshell.de>, 
 Enric Balletbo i Serra <eballetbo@kernel.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Lucas Dietrich <ld.adecy@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Raymond Mao <raymond.mao@riscstar.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Mateusz Furdyna <mateusz.furdyna@nokia.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, Heiko Stuebner <heiko@sntech.de>, 
 Vincent Jardin <vjardin@free.fr>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 28 Jul 2026 12:59:47 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785237827; x=1785842627;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=P4y0ui07aAXfeezQBeiXkFMmtoLYC16Z/7aAKk6+8QA=;
 b=kIcUeCfYKiu2gjWqARD1H6svfV9TSDxA1qpsSEDGnTNlBgUpfzb30vPqA33uEsbZaG
 nr0pvGNFC2ZV3nxtK9Dk8sSd2dF0yaNYic9AMNE1s/NAkgV0TENxIGEeilXbkhlUe/x3
 DHczSb0+xUUS412TqMIodZPHhancnXIZAStw4=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=kIcUeCfY
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

On 2026-07-20T04:13:44, James Hilliard <james.hilliard1@gmail.com> wrote:
> crypto: aes: add software-key provider dispatch
>
> Generic callers which supply an AES key need a provider-owned slot policy,
> since hardware may reserve or preload particular key slots. Selecting only
> UCLASS_AES device zero also prevents a later provider from handling an
> operation unsupported by the first device.
>
> Add a callback through which each provider exposes a slot for
> software-provided keys. Add a CBC decrypt helper which probes providers in
> order, continuing only when a provider explicitly reports an unsupported
> operation and preserving hard probe, setup and decrypt failures.
>
> Use slot zero for the software provider and avoid Tegra's preloaded SBK
> slot. Add sandbox coverage for provider fallback and hard-error
> propagation.
>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
>
> drivers/crypto/aes/aes-sw.c      |   6 ++
>  drivers/crypto/aes/aes-uclass.c  |  73 +++++++++++++++++++
>  drivers/crypto/tegra/tegra_aes.c |   7 ++
>  include/uboot_aes.h              |  66 +++++++++++++++--
>  test/dm/aes.c                    | 149 +++++++++++++++++++++++++++++++++++++++
>  5 files changed, 297 insertions(+), 4 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
