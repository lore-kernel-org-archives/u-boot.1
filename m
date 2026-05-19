Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7DDACD4F5B
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 14:32:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 449158486A;
	Tue, 19 May 2026 16:32:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="K1Du94IE";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="KN4uYc6S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 591A684870; Tue, 19 May 2026 16:32:04 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83F0D84852
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 16:32:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gKcZB1KTRz9tqB;
 Tue, 19 May 2026 16:32:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1779201122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hdwmc906PsQV0hMnlT3rzjGujx/nSOcOVhIZdaWSdrs=;
 b=K1Du94IEeMiXy1fgfYhSaKXwGKICXG8+G2jVX899DrsTyCiXSijYApBwZqBX5wFYRiyy5p
 jj/eZdSnyRLnBbCqw+sbvgDovTB3yf48Xy8bNGcieUfif1Erud9Cv1C303WQytLNdRPhwX
 580EYkvewhpxWoEEZgwFWiAGI20Vu39oG6yAfN3ai7l6XFsyEOtubGv+amMcO9C0fp5bOp
 tblGDG+F5c7Nco+DgSz1bAXQWhSUppiPwkYWK60c+QDrSSGMKfCBkZC45sAy0MIPnKracl
 h+KR40rlWFYONqo8AhO5fxLWTo0P3sO5zPZf9FuA/QR0owuH5pLbM/DrdvS/8Q==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=KN4uYc6S;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <101a1835-657d-424b-aa7c-7aa75bdb436a@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1779201120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hdwmc906PsQV0hMnlT3rzjGujx/nSOcOVhIZdaWSdrs=;
 b=KN4uYc6SunYPZNEy6y/uDVhmDP5MtMQ2OPIdnGnemdr7flDt32aewwWwtYvQ3IjhraZVCf
 rO5i9Pguleyl2YTKK549vy/1l6OvUuK1tjyB8G4zgMW4Vm4DljSHSRidPDQBONT2jxakIs
 jEKVIPdCwNvNV7sIyb859KyUHHS8D3o350oq6QgLRcacJJxycxPB4rW4JuwxCFKNuji+g2
 J9fWftkhnjqFZ9XB7c7fAQNDIAKHPrkFKzMqUcXXOcBd+JZktFRXIeEACimnLfcV/gIycW
 vRwXDNuviPrQkVVGKK36A52agRUwBGq6mqrL2FCq1+eJWLIBhhQo4ZmBU3x9zA==
Date: Tue, 19 May 2026 16:31:52 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 2/3] configs: stm32mp13: activate watchdog
To: Yann Gautier <yann.gautier@foss.st.com>, u-boot@lists.denx.de
Cc: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>
References: <20260519080737.47928-1-yann.gautier@foss.st.com>
 <20260519080737.47928-3-yann.gautier@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260519080737.47928-3-yann.gautier@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: w8z1r44tick9fkf5tjqeoyk1zpxbft1k
X-MBO-RS-ID: e35b7e16bc2f7c73c4c
X-Rspamd-Queue-Id: 4gKcZB1KTRz9tqB
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

On 5/19/26 10:07 AM, Yann Gautier wrote:
> Activate the watchdog for STM32MP13x.
Please expand the commit messages , this blurb above tells me literally 
nothing. Which watchdog are you enabling ? Why is the current iWDG not 
sufficient ? And so on ...
