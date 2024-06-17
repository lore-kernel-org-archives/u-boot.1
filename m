Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D0AC27C79
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 17:12:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03DAA88323;
	Mon, 17 Jun 2024 19:12:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="jtbamMWA";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="oagk6ocv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0883883A4; Mon, 17 Jun 2024 19:12:52 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C655988254
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 19:12:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4W2xKF3ZqBz9st9;
 Mon, 17 Jun 2024 19:12:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1718644369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tzbHfav1BTe/2bzagIBn7IKRe7TufP2eux1CU5KT0ec=;
 b=jtbamMWAzBT7UO00vsb7jQkbeA8Xs0g99AcIHH06yMcUF7Y82KbF6J2cEtaOgKTtY7Vhwz
 LspdFfVLXVVLYCEWDx1yOTA5HgOw3pHy0C1axSH8pzWEpRo6S2VfyBw7BuwRbAHL/4dCYi
 tbDidpBPzf5pn8mokQoHLuj5yj1Ky4GgeDEX4FY47VLkOxfVDEwJPxrJDnqlUwINOGEloV
 by+okMNKcJy7VBxRfgBF8doZ4LkPzRF3qREbiD/e0l5IbwfQEon1yjC+ZrCf3oSHi7nQyH
 /QB6Yx68it9F+X2W+00atByxY6njSGwyll6kAvXa3SUyTFz4OudkqBOy1ek8aQ==
Message-ID: <773b9a21-a977-4e07-99bd-a6c1e581cc51@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1718644367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tzbHfav1BTe/2bzagIBn7IKRe7TufP2eux1CU5KT0ec=;
 b=oagk6ocvg2vkOe2+E1y+kUIVWjHr2q+CB+BJFUckngprGDLPpRqOXSW2SP6LgFgb/iuHe9
 RONM6RqS0pJ6BtD/LhfP+3Plxp1QTZJcVXL8vlqvyxwoJe2OZvLGwrYe7X1j59geEmMYOA
 TWPYlbSP2/3Nsgb/388qkZprToTZ5S4GGfrn17f3gssq6HtDgS09uNwNZkvEB6nH/49zwL
 ozBHal75Aq4MR32hyZvBhu6l+4Xq1HbD8n/6FEDMM5rJZ+/BgQyalg1H7DVImtLMioEABg
 RKnkMFJPwFHnG5BN03aYzouO0J6HUVu1v6Ntzr/U4+gsh4aGglVQc9RKELev6w==
Date: Mon, 17 Jun 2024 19:12:43 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] phy: Extend generic_setup_phy() with PHY mode and
 submode
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@gmail.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Jonas Karlman <jonas@kwiboo.se>, Mathieu Othacehe <othacehe@gnu.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Nishanth Menon <nm@ti.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>,
 Xavier Drudis Ferran <xdrudis@tinet.cat>, u-boot-qcom@groups.io
References: <20240616150426.36338-1-marek.vasut+renesas@mailbox.org>
 <1c0aa5da-468b-4d3f-9d90-6dba511afb69@linaro.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <1c0aa5da-468b-4d3f-9d90-6dba511afb69@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 1cc36902164057d8ebf
X-MBO-RS-META: h3inxxzgen4119ur7tgisrmspyece31f
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

On 6/17/24 9:07 AM, Caleb Connolly wrote:
> 
> 
> On 16/06/2024 17:04, Marek Vasut wrote:
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
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> 
> Acked-by: Caleb Connolly <caleb.connolly@linaro.org> # ehci-msm

Thanks. There will be a V2 tomorrow-ish with fix for Jonas.
