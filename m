Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78BA6E7AD4C
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 13:43:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB818874AF;
	Tue,  3 Oct 2023 15:41:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="jy1F4W/G";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="RWq4vFDN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CAFF874AD; Tue,  3 Oct 2023 15:41:08 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96929874A2
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 15:41:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4S0Jr22lTKz9spZ;
 Tue,  3 Oct 2023 15:41:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696340466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lhwEa4wYEhDTbIG8S6sylocaakZYOywSyAg67Dy2KWk=;
 b=jy1F4W/G9NIOTmCthKdTU1qltjxVv73SHDApIZuaM95fKGmMLtt9N7g04s2CXDfRTKkAoa
 9KMV6tARNTx+3K3ly4orCiOGOP7/y3AyFkqY7FMN8TWBEKT20y6hMBpsloi93I2id3s6VT
 vEKTqLiC6rHtLGrtqlkfxvdcaObQYY7ZPwvWA5yOBvYFD28NP4+/eTaR4JTMopA3GOocrF
 d2qaP0qoWlNoM+srSPF3yDdqG1G03Xi9RHSAw+5efewAL58Zlt3pgwgLALzuG+5WoVV6pU
 4FmrsjR0c1xbCADvEFA0Ldvt+5Aub3594HkMGX68SbYh7fcF9u8iSFRFjoNjlg==
Message-ID: <031c7c7f-3ece-ddef-792b-036af71fb424@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696340464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lhwEa4wYEhDTbIG8S6sylocaakZYOywSyAg67Dy2KWk=;
 b=RWq4vFDNIAwe868C0x+NprEiamjsV9RSFxj3eHq/SQqZdotHF42V+nr1y+ybDG/ag0NrJv
 oO/abZ6FCCEHSM6ETr+N7P66elKQIkoDzgIDP63B9z0YRl1tWd0+58b48r89IThV9wW7n5
 jD+aXMC2Kf/TcClLbRKSc/kQq1ltmJmh1UbuAifNNoR9zLfGwiDfJBrkywHoJmu+92MHwj
 q66ZSctBRpOtOPQoH53Ta00YbzCunq6wqiooFnSJByj/G6fJ3MKhXcWs8LllThdsvYgrbi
 unMrQgvHNG+OW8P/OBFJ7ihPrNzBK4G/VUIc+RX0BGVDtgdpXa3VXreDficEpg==
Date: Tue, 3 Oct 2023 15:33:40 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 15/16] arm: dts: Import RZ/G2L SMARC EVK device tree
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>, u-boot@lists.denx.de,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Hai Pham <hai.pham.ud@renesas.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230920124212.63535-1-paul.barker.ct@bp.renesas.com>
 <20230920124212.63535-16-paul.barker.ct@bp.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20230920124212.63535-16-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: tqwmn6esjh1bwcxbdocuuzzr4o3nssmf
X-MBO-RS-ID: 83a3abf969c1e362619
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

On 9/20/23 14:42, Paul Barker wrote:
> The Renesas RZ/G2L SMARC Evaluation Board Kit consists of the RZ/G2L
> System-on-Module (SOM) based on the R9A07G044L2 SoC, and a common SMARC
> carrier board.
> 
> This patch is based on the corresponding Linux v6.5 device tree.
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
