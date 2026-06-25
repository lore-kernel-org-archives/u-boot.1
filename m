Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD482CDE00C
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 22:17:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09EFB84981;
	Fri, 26 Jun 2026 00:17:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="kKwPohmK";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="CSaJmWGj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A4AD847C3; Fri, 26 Jun 2026 00:16:57 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C424847C3
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 00:16:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gmY7V5md6z9sSR;
 Fri, 26 Jun 2026 00:16:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1782425814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FxIJTb0oJ3CajpRUxWdtTRfcpYVL6y0SRubJ/4wqWuo=;
 b=kKwPohmKJKV5uQGU+iMnfLzQkbPeAEB27SJio2AUVAanN1Jk2KBguE0vglS4emY3RHis3D
 VfaLlvM6Ga78opLnbn3YkehWAywsv/TDdyaElv+LMzVc1vdd8xcCYwQm4gVMWlNkHVy/Nk
 8q0AebzByBQfxBO8369ZIVogBUGFtr1khjHOLG1aLMAGQ5x87d1HTboF9UFpj2lhuXIb8C
 TsZ08aWe8lg5t0vGhYI+am48j23Hz2JGN04WZG7hWjV23UpFSuOYhQCzXp3ewYjIBXT2la
 pJKZaQko1FNib2dNe0z8qFcpPotgMeOqhubzI1yu2p0OZJmIyUmj3rt9FpUjOQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=CSaJmWGj;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <267c7ac5-01f2-4cf1-b0e6-7aa5f5ee224e@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1782425813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FxIJTb0oJ3CajpRUxWdtTRfcpYVL6y0SRubJ/4wqWuo=;
 b=CSaJmWGjwQ38LtQc6fFDzSBhYg0l7DJs6UwJ5EyGEMgwtSEtUbjTVaSPP5sD4mtDukdQO1
 OcTpeZ606VxQz+MhHS0rIOycBM0KP2tFefWuEaRhm8Y8hiG/p7JXSprOlVseYwNrd3OUFn
 lz2gcskflACeu6slCADeT7/ti+V5XHgx/hiz3GTIZOb5r++x40FwIyA3w4z7OC3pn4rfzE
 f7US1uqRutChflxrmoXg6rSpZ00sIIWyc41F0FySAJrOVzGPNOrdzLjZMjxkWluefH8ac0
 SdFyqc5p2thpZ+r/G/KEnPLW5AbHf2RuAkMQsB178UxlxyPhRDBafqJnQYUVSg==
Date: Thu, 25 Jun 2026 14:35:29 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] usb: gadget: Add Renesas RZ/N1 USBF controller support
To: Romain Gantois <romain.gantois@bootlin.com>, u-boot@lists.denx.de
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Kever Yang <kever.yang@rock-chips.com>, Peter Robinson
 <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 George Chan <gchan9527@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Herve Codina <herve.codina@bootlin.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, Kory Maincent <kory.maincent@bootlin.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Raymond Mao
 <raymond.mao@riscstar.com>, Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 David Lechner <dlechner@baylibre.com>, Julien Stephan <jstephan@baylibre.com>
References: <20260625-rzn1-usbf-v1-0-0e1a38f7b82c@bootlin.com>
 <20260625-rzn1-usbf-v1-2-0e1a38f7b82c@bootlin.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260625-rzn1-usbf-v1-2-0e1a38f7b82c@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: n9c6tqzxgej9n5mu8f1kes4ufarrimtd
X-MBO-RS-ID: 56703dafff9e86332b9
X-Rspamd-Queue-Id: 4gmY7V5md6z9sSR
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

On 6/25/26 11:05 AM, Romain Gantois wrote:
> From: Herve Codina <herve.codina@bootlin.com>
> 
> Add support for the Renesas USBF controller. This is an USB2.0 UDC
> controller available in the RZ/N1 SoC.
> 
> This driver was originally written by Hervé Codina for the Linux kernel.
> Suspend/resume features have been removed in this U-Boot port.
If this was ported from Linux, please include in the commit message from 
which commit SHA in the Linux kernel this was ported from.
