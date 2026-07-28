Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B092C53200
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 04:56:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1CAF460A51;
	Wed, 29 Jul 2026 04:56:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j-gaL59qtH6r; Wed, 29 Jul 2026 04:56:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6DDA060AB0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785300964;
	bh=2Ak5avdC7tP3NhekieBM21v+GzTYGGkZjvBcZG9I0CA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kAhwhQrQoSYOQKjY6TKWeRiFVFidDVPhD2LbZ3h4yLL6qswHeMv6ZsSzlUWEp5sRB
	 dyiUxsw2HMZJovkhllOlhuLglReUJ2gHs3UESP7OezmAkCoLrxsWOf3ZCHfiukbdbF
	 P2Ez6Vjk3qSZ6VnpkLsRhTNHC1dd1FrmnNRuwIJpAzpAVDaIgs9zis79GMqJV3OggX
	 FLpJjAfxyeejsKwEyaviXYeA4qAqS7ZD+p+Q5ZGSAY5+vNq+F1BTyiZkBuOCS1Gq1b
	 CZOUkMzzp3cvH4IRgMjTtNQk4Jj/Ux/+q8DxORRZwKoDytIrXZO7bhFpap/sijQfj6
	 fGRhwzyJI1rTw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6DDA060AB0;
	Wed, 29 Jul 2026 04:56:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5FF832E5
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 23:55:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 51B6140707
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 23:55:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jyqsBDVnHQ_P for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 23:55:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 395AE406ED
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 395AE406ED
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 395AE406ED
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 23:55:09 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAFAE8493F; Wed, 29 Jul 2026 01:55:06 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D6758404D
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 01:55:04 +0200 (CEST)
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-4ab47c40e7eso153747b6e.3
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 16:55:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785282903; x=1785887703;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2Ak5avdC7tP3NhekieBM21v+GzTYGGkZjvBcZG9I0CA=;
 b=p6MAPXC36Eec6+f3t6LrgL5Ez5A2sVfJgsU4VcNDbsTmqQbJ9/jRiHkwhY5Y4IlErb
 Rn/I23EwNdKrQqCHs+OTwRhjlUILbRz0OCuZVcEJ6PDmuXGplTYvNI3LbxDL1XmUML+G
 IClCaPoKTGz5Uk2oiwzcvbVxYm5fYWijz4DUrs3h9xaxIJSQ0fCmeTrwQbCLTy7LavEV
 SgP75kWoKokNHVGAvU/wahPknTPEP4VNPQnZLgVsmltSwaZr1WJEKJviVeT//kVxmWV+
 zsjCKQXkEs8Q4j5X79nmVZAvNnohYIW1ALAsrBqdCKszLxxUQZ+wBbLwukzcNpWhGWV0
 RKtQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro+ywcLHeuSYLOtiAzr8EFE4uIlA2jdOd3BXtB/RcSV6O2DipDg5AB7Duo3Lnu0LZhTJzoReXg=@lists.denx.de
X-Gm-Message-State: AOJu0YwEw90aBjkhuRa5WVxM0fF66MDPhnA7mrDSsVpLzM7CZekl5znU
 YOujxXFugGn3mDskixHhmdHyONJKAtvGrmmbCWYt6EAwlM2FX8MFK56WfMslXbf9tWA=
X-Gm-Gg: AR+sD13c+6Z1U+o5d/6eWojUgewKrhjSuuF33hNxQCzOv2OfIt+cHaOeyeZD66sk2xu
 arD9JduB3wgUWOs2vHTblKkCZ7VIzHMTHZjoZh0X/VFdSQqJOcm6Ifpd2bllsV7crNznjHYqpEF
 qruPyxV1f8WAw9oK4KzmHwrHU8ff7yUczJb951Qpc5/9s1rC8ZYTS1B+Lm6o43fVjmYeDQeDprh
 J7zctqNLfJYRru2NYKwQCvwTpFcmaMQWmLBmoIGPnUc/DQscoxW1vkr61b6SAm48xNFqbf8uWr8
 +Ku7Hci8idqHSz28osCW7oThR3Uw4bs5i/6m0cG4iyrPBR2cvNuPm5mLJFJUpLcEUlBUwMMpkv0
 fLYUhL1mB9EM6g18mWYafBLMoVmNfdlezkfPlH0OQ+kGSiDWw3DTw9iscC4iw2T2Kh9Kpw8l0Z6
 jE0KYoaRJJjVMzBYDTdhCLYlI6d/SFvOZelcOO+VIjfEv+N5rcc1RLb2g9bc0VfK6PT1pf1xGQi
 Vknqp3JFK32aEPkNI7VQScDyVy761k0azs2O/CYyefBDXe5LvVbi+EIwB9B6aEkLYImIvF4xIJd
 lbBzRqRHXA==
X-Received: by 2002:a05:6808:170a:b0:4a3:fb6c:9adf with SMTP id
 5614622812f47-4ad5b877ca7mr2491909b6e.12.1785282903013; 
 Tue, 28 Jul 2026 16:55:03 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4ad6f03403fsm455036b6e.18.2026.07.28.16.54.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 16:55:02 -0700 (PDT)
Date: Tue, 28 Jul 2026 17:54:57 -0600
From: Tom Rini <trini@konsulko.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>,
 u-boot@lists.denx.de, Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
 Joel Stanley <joel@jms.id.au>, Chen-Yu Tsai <wens@kernel.org>,
 Samuel Holland <samuel@sholland.org>,
 Simon Glass <sjg@chromium.org>, Thierry Reding <treding@nvidia.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Quentin Schulz <u-boot@0leil.net>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Marek Vasut <marek.vasut@mailbox.org>, Rasmus Villemoes <ravi@prevas.dk>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>,
 Aristo Chen <aristo.chen@canonical.com>, Anton Ivanov <anton@binarly.io>,
 Daniel Golle <daniel@makrotopia.org>,
 Francois Berder <fberder@outlook.fr>, Peng Fan <peng.fan@nxp.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Randolph Sapp <rs@ti.com>, Jonas Karlman <jonas@kwiboo.se>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Alexey Charkov <alchark@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Anshul Dalal <anshuld@ti.com>, Johan Jonker <jbx6244@gmail.com>,
 Francesco Valla <francesco@valla.it>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michael Walle <mwalle@kernel.org>, Andre Przywara <andre.przywara@arm.com>,
 Lukasz Majewski <lukma@denx.de>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 E Shattow <e@freeshell.de>, Enric Balletbo i Serra <eballetbo@kernel.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Lucas Dietrich <ld.adecy@gmail.com>, David Lechner <dlechner@baylibre.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Mateusz Furdyna <mateusz.furdyna@nokia.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Heiko Stuebner <heiko@sntech.de>, Vincent Jardin <vjardin@free.fr>
Subject: Re: [PATCH v5 02/14] crypto: hash: use DM providers from hash command
Message-ID: <20260728235457.GI1188@bill-the-cat>
References: <20260719-submit-ce-series-v2-v5-0-3c41f66d4522@gmail.com>
 <20260719-submit-ce-series-v2-v5-2-3c41f66d4522@gmail.com>
 <20260720232409.GN749385@bill-the-cat>
 <CADvTj4o6kmshf4OEMUpon_BxbssViL6xzHDo_cin6QM17q76yQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADvTj4o6kmshf4OEMUpon_BxbssViL6xzHDo_cin6QM17q76yQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 29 Jul 2026 04:55:22 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1785282903; x=1785887703; darn=lists.denx.de;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2Ak5avdC7tP3NhekieBM21v+GzTYGGkZjvBcZG9I0CA=;
 b=bVaBokWfeZFORMoheZtr6EvWj5mTuz6+SkvlU3nJ1c6KDrLaG3Atft2enOAXALzftn
 XC69aIpN45kkkpkIs6q4SwP26QdIipa77oODMvysyCbv2l3R+ce6Tt75SzIKcWc1Gt2N
 F9CK/9wvqahOp4C30P2SGWa/Fr61SGcAkiIj4=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 spf=fail smtp.mailfrom=konsulko.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=bVaBokWf
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=trini@konsulko.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bVaBokWf";
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
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Tue, Jul 28, 2026 at 03:41:50PM -0400, James Hilliard wrote:
> On Mon, Jul 20, 2026 at 7:24 PM Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sun, Jul 19, 2026 at 10:13:46PM -0600, James Hilliard wrote:
> > > The hash command currently always uses the software implementation for
> > > the selected algorithm, even when driver-model hash providers are
> > > available.
> > >
> > > Add a hash_digest_wd_lookup() helper which probes UCLASS_HASH devices in
> > > order and uses the first provider supporting the requested algorithm.
> > > Continue past unavailable providers and unsupported operations, but
> > > propagate a hard digest failure once a provider accepts the operation.
> > > Remember probe failures so they are not silently hidden by software
> > > fallback when no later provider succeeds.
> > >
> > > Use the helper from the hash command and retain its software fallback
> > > when no usable provider is present. Add sandbox tests covering provider
> > > fallback and hard-error propagation.
> > >
> > > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > > ---
> > > Changes v3 -> v4:
> > >   - New patch
> > >   - Try all registered hash providers instead of only device zero
> > >   - Add provider-selection and error-propagation tests
> > >   - Reserve -EINVAL for hard errors
> > >   - Use -EOPNOTSUPP for unsupported algorithms
> >
> > Putting new features in an unrelated patch series makes things harder to
> > merge. I don't know that Andre will be comfortable taking some generic
> > changes + sunxi support, but he might be. But it's even easier when
> > something like this is standalone and can be reviewed and picked up on
> > its own (I'm going to have some size questions about this, once I review
> > it globally..).
> 
> Maybe it makes sense to merge all my patches prior to the sunxi specific
> ones first? That way I can rebase my series and shrink the patchset
> substantially for the remaining sunxi ce driver patches for Andre.

Yes. And it's fine to note in the cover letter than series B depends on
series A, so that it can be reviewed, and then picked up in time more
easily.

-- 
Tom
