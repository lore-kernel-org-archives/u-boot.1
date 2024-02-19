Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D32EC48BF8
	for <u-boot@archiver.kernel.org>; Mon, 19 Feb 2024 23:08:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8007387DA4;
	Tue, 20 Feb 2024 00:08:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gnu.org header.i=@gnu.org header.b="BXMgZNl6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46C9087DA2; Mon, 19 Feb 2024 18:31:22 +0100 (CET)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A1B987F64
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 18:30:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=othacehe@gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <othacehe@gnu.org>)
 id 1rc7TV-0003nt-Gd; Mon, 19 Feb 2024 12:30:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=MIME-Version:Date:References:In-Reply-To:Subject:To:
 From; bh=uRCcqmEwcOwNu4e+RESUs0tggu0ehteORqBHuaHGpXk=; b=BXMgZNl6HP9+hDLxrzMs
 Hl54u3mg67JIHgHGJyZtr/pMSl+xSis2I7X20IBI+5SuXR7OYIhblaXGLiCFCrGyNC4LoEANU1BdB
 Ecg18jvPly6qWOxmWPYyWttjd9iFgVZJFT+ixj5GycEssxA71ptMUt/ctns4z8IJmP9Utg76P4rbp
 fkYw2CdSR4vrLFj+GXkqOZIDxBHfpa50AxiOYEgr4s/w/ji4/6WlAAtBF/1eb0R0xiJduQ4+jv4Mq
 f/Ree/e5XA7zY3LXYkWJb6s6yV+ZOXKKo1fOXvE/CXViA8boYms+VobEOvf6dSS/LC58TWi8WnHu7
 Mh2QUUci8m+FPA==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: Tom Rini <trini@konsulko.com>,  Marek Vasut <marex@denx.de>,  Peng Fan
 <peng.fan@nxp.com>,  Shiji Yang <yangshiji66@outlook.com>,  Ye Li
 <ye.li@nxp.com>,  =?utf-8?Q?S=C3=A9bastien?= Szymanski
 <sebastien.szymanski@armadeus.com>,
 Simon Glass <sjg@chromium.org>,  u-boot@lists.denx.de
Subject: Re: [PATCH v2] usb: ehci-mx6: Add i.MX93 support
In-Reply-To: <CAOMZO5COoMMY6gVc1Bpw2iGLeFtmrhE_G=rTzD7Zsj5i6PBipw@mail.gmail.com>
 (Fabio Estevam's message of "Mon, 19 Feb 2024 14:26:55 -0300")
References: <20240219170531.14959-1-othacehe@gnu.org>
 <CAOMZO5COoMMY6gVc1Bpw2iGLeFtmrhE_G=rTzD7Zsj5i6PBipw@mail.gmail.com>
Date: Mon, 19 Feb 2024 18:30:36 +0100
Message-ID: <878r3g9xab.fsf@gnu.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Tue, 20 Feb 2024 00:07:58 +0100
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


Hello Fabio,

Thanks for having a look.

> I assume you will add USB support to some i.MX93 boards later.

Yes that's the plan for the boards that I own: imx93_var_som and
imx93-phyboard-segin :)

Mathieu
