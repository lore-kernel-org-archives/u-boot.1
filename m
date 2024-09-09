Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4150CD4F4C
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 07:16:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F92D88D40;
	Mon,  9 Sep 2024 09:16:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="P/ScMQRz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6ED0188D38; Mon,  9 Sep 2024 09:16:30 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 219A688C8E
 for <u-boot@lists.denx.de>; Mon,  9 Sep 2024 09:16:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42cb2191107so7739845e9.1
 for <u-boot@lists.denx.de>; Mon, 09 Sep 2024 00:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725866187; x=1726470987;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Vk1AN82Xd42347gEK1rcQfsavZplcyTHPaR2w3VENIg=;
 b=P/ScMQRzJwqbOJv6ChIYCH9jPZQmStZu8KJGEZzqfHbuNJ0lAlk8kfHu7YxHg25Deg
 i/AZrEqjiL0OPxxdua7H1UuYfkOVgy/UOnaKzMiu4EdnD6RA0wbunDuHmXlh4Pnccruf
 CEbiCKB3IE+PRpgpvOy6S2K6LIViVnyMx5pYunf5FHfcW3xA2qo9j5+5rvC/7Ld8WFYK
 uFvtE+ABpgmty5eMGIra8GRlchASuWG46yrUYF4eh3zQQ9fDwjpnUr1KE4zeSrIxVvB4
 uBMNYJq2avNtF6aGPvzthD2RI8kob9hYxuA1p++GLNAdRv82DPB7pWU9u2qaCTatGGUi
 PF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725866187; x=1726470987;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Vk1AN82Xd42347gEK1rcQfsavZplcyTHPaR2w3VENIg=;
 b=Dqyu7/SNScmuo1Odc5FQXpirLZm6kqXLa4ttjG5Vu2RzKGU9XybGtYceprJK/d3sPc
 6lDtW4KphDGoR0+JVdDL0ZHgVwJ/fJ/B9gS5LWmEBFLxwMqWcUH8clVnt8aaZnkWWjIY
 p1oQQtudBTsdD1vLkiesibIvXnQZwO2J4Zijjy7ElXS1pX3nl/UoxeIxY1x+cNkFecyz
 90svfWFSj8AylffTIDNWWDbcjPSBxt/aFCDrg+Xj4BSmjioKbpbJ/EzL+0wbYoRk2Qzh
 rxkP1Yt0lbwUU4TCx6fONDwT5ZoiycI3YicigHYfpRdtIiJ7P1U1aY/S8YOYHyvKbB7o
 9qUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVr5PkN6/7eIIiZOiWfWxo+0PO8cgbu3BXa6TT6dhRxeTfCrc2lhCGg8j2TuucOuz78pD4sM7g=@lists.denx.de
X-Gm-Message-State: AOJu0Yz+D8z0Z/Ep7M/TFQclZC51PhOkr5mSvsvG7L4ANIHnjMDnhZK2
 NIQgzbq/oSa/sbN838nH2LIyju439o4RK1qI4QsINTA/5awMkGmvc7H/i5kPNRo=
X-Google-Smtp-Source: AGHT+IGjxpzE0oLa7Z+RPE8VLgYaMNIp1O9LeFao+FkAq/HVLf6SmiD9odG9FPpBv9bBrzkXj+kh4Q==
X-Received: by 2002:a05:600c:4446:b0:426:593c:9361 with SMTP id
 5b1f17b1804b1-42cad87efbbmr50251435e9.26.1725866186773; 
 Mon, 09 Sep 2024 00:16:26 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42caeb21cdfsm67675335e9.10.2024.09.09.00.16.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 00:16:26 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marek Vasut <marek.vasut@mailbox.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de, Tom Rini
 <trini@konsulko.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, Fabio Estevam
 <festevam@gmail.com>, Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Jonas
 Karlman <jonas@kwiboo.se>, Mathieu Othacehe <othacehe@gnu.org>, Neil
 Armstrong <neil.armstrong@linaro.org>, Nishanth Menon <nm@ti.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Sean Anderson
 <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, Sumit Garg
 <sumit.garg@linaro.org>, Tim Harvey <tharvey@gateworks.com>, Xavier Drudis
 Ferran <xdrudis@tinet.cat>, u-boot-qcom@groups.io
Subject: Re: [PATCH v2 1/3] phy: Extend generic_setup_phy() with PHY mode
 and submode
In-Reply-To: <58805d01-511a-4ec6-88d8-b5821574cb29@mailbox.org>
References: <20240617173740.80822-1-marek.vasut+renesas@mailbox.org>
 <58805d01-511a-4ec6-88d8-b5821574cb29@mailbox.org>
Date: Mon, 09 Sep 2024 09:16:25 +0200
Message-ID: <87seu9s3ee.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On dim., sept. 08, 2024 at 20:11, Marek Vasut <marek.vasut@mailbox.org> wrote:

> On 6/17/24 7:36 PM, Marek Vasut wrote:
>> Extend generic_setup_phy() parameter list with PHY mode and submode and
>> call generic_phy_set_mode() in generic_setup_phy(), so the generic PHY
>> setup function can configure the PHY into correct mode before powering
>> the PHY up.
>> 
>> Update all call sites of generic_setup_phy() as well, all of which are
>> USB host related, except for DM test which now behaves as a USB host
>> test.
>> 
>> Note that if the PHY driver does not implement the .set_mode callback,
>> generic_phy_set_mode() call returns 0 and does not error out, so this
>> should not break any existing systems.
> Any news here ?

According to patchwork, this is assigned to you:
https://patchwork.ozlabs.org/project/uboot/patch/20240617173740.80822-1-marek.vasut+renesas@mailbox.org/

