Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65630E6FE49
	for <u-boot@archiver.kernel.org>; Sun,  8 Sep 2024 18:11:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F28288846;
	Sun,  8 Sep 2024 20:11:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="AhZVFLN+";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="bDJIxR0j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F3ED831A1; Sun,  8 Sep 2024 20:11:47 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A727D8878A
 for <u-boot@lists.denx.de>; Sun,  8 Sep 2024 20:11:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4X1yhw15CKz9sZL;
 Sun,  8 Sep 2024 20:11:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1725819104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p5+p4pygLghAMpVDFYqNekemN7tfR4ZnTpd+oIJ/jq0=;
 b=AhZVFLN+3L54BJM1ps9gNsU7/n3wnyn6BFBvVSZvl8R8uDrw/9iEakH92/4zIIweqHlo6F
 OIwn7J02aNQlASf53LhPoLKJUsYoWxD/C8nogcvgjZfVsYkUvlR7xqI5DMGy0Yc7Sxd9wq
 kVOLbleri7EEMOOiucQQ6PPyduaeKlxQOYLkRqX40WmEOf4Q1VxSQcpC14EV55cCxXKDfC
 uQhvzFLh8Qgg+XczjykEp6Bgf0c5TzCuWuMuUB02feQk6pnSAgpT5IZqxf7gb8qV1nYtzu
 IGK6oAGuE0PqdTvO6TxSTAqCJxOVuXBhxkW+jO9GJBcRayu8YnzfZjARhzNKPA==
Message-ID: <58805d01-511a-4ec6-88d8-b5821574cb29@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1725819102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p5+p4pygLghAMpVDFYqNekemN7tfR4ZnTpd+oIJ/jq0=;
 b=bDJIxR0jJhPYVw3rdCHg4Dkrj035OGsxasJLY4bx0S9gU0V4GAAVnUW5rTwuA+6TgDU6re
 C9sPU0eDgL9LQMpExcAVqJqCluOMqpyvXSG+xeEY20Tle5dPuhOfNFYSRlHUSeTZcCoLdl
 Nux7qd5PCxKfe1CnBNz4Ry6d5QWzr9BBjzZ3pAX5O1wpXi9mfpj4BmGb8SHuw7/wMdhdRn
 Nffmt0j+KGBQCm+D3UNQgyMiRxgGbZs5eM/zOa4i6/WSCeu+qiVYufS98Z+DQEUQ8z6u/2
 v3Df0gQia9srXNKRp7n0e+mH56NgyypCESSvWNCkVN0+YVBxurxtiXN7T5D1mg==
Date: Sun, 8 Sep 2024 20:11:36 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/3] phy: Extend generic_setup_phy() with PHY mode and
 submode
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Fabio Estevam <festevam@gmail.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Jonas Karlman <jonas@kwiboo.se>, Mathieu Othacehe <othacehe@gnu.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Nishanth Menon <nm@ti.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tim Harvey <tharvey@gateworks.com>, Xavier Drudis Ferran
 <xdrudis@tinet.cat>, u-boot-qcom@groups.io
References: <20240617173740.80822-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20240617173740.80822-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: kgusodj7d6p9r3mbqebojkrpnkrsw1f8
X-MBO-RS-ID: 181ed14b7444d6c2532
X-Rspamd-Queue-Id: 4X1yhw15CKz9sZL
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

On 6/17/24 7:36 PM, Marek Vasut wrote:
> Extend generic_setup_phy() parameter list with PHY mode and submode and
> call generic_phy_set_mode() in generic_setup_phy(), so the generic PHY
> setup function can configure the PHY into correct mode before powering
> the PHY up.
> 
> Update all call sites of generic_setup_phy() as well, all of which are
> USB host related, except for DM test which now behaves as a USB host
> test.
> 
> Note that if the PHY driver does not implement the .set_mode callback,
> generic_phy_set_mode() call returns 0 and does not error out, so this
> should not break any existing systems.
Any news here ?
