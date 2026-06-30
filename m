Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81F78C43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 08:01:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C998C84A60;
	Tue, 30 Jun 2026 10:01:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="W5IMO7bB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A90D84A7C; Tue, 30 Jun 2026 10:01:50 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47CA084A35
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 10:01:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id ADC4611867C; Tue, 30 Jun 2026 10:01:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1782806502;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=RnwqiqAaYi/Ktf8j4pQj7tOxR3psOB6kysx5NirTV+I=;
 b=W5IMO7bBi6OZ/7WOkqlrBbkGSFkgP9wMh7h77LrdGbhLHGQx78cabW+BbX2AOvWlEXj5Ei
 uoRAmvesY5SmePNpeuwJFTIcv0qsUeJe3ot/AY9jadsT94OHTyzNbD6EXXO2kGjKLU/Ts5
 1+3ZRd6H+oVhu5qHYDNtpGcoq8fU67II0UIgPbeBtX0cmzMxZJ0YjsnwYGVoN/+LVC2Uxi
 uOu1N2xrhhUMQk5QPR3megnG9GknP4rhtUBSdcVqigQzTvbpcd4uHVHoRI2Xj1Sj++0GTq
 e8MtiIh7OSJVPFo7ODbSVrlslSeWbhaeSFnfBd454Mgh6dmj76ALBigrpVzTvg==
Message-ID: <a6dec76b-ed70-49a0-b7bf-affe1aa2f6e7@nabladev.com>
Date: Tue, 30 Jun 2026 08:58:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Marek Vasut <marex@nabladev.com>
Subject: Re: [PATCH v2 00/10] usb: Add TCPCI driver and DWC3 OTG dual-role
 support
To: Peng Fan <peng.fan@oss.nxp.com>, u-boot@lists.denx.de,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Jonas Karlman <jonas@kwiboo.se>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Fabio Estevam <festevam@gmail.com>, Wang Jie <dave.wang@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Kever Yang <kever.yang@rock-chips.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Casey Connolly <casey.connolly@linaro.org>, Ye Li <ye.li@nxp.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Stefano Babic <sbabic@nabladev.com>, Alice Guo <alice.guo@nxp.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Peng Fan <peng.fan@nxp.com>
References: <20260621-tcpci-dwc3-v2-0-990ecacc111c@nxp.com>
 <akMgh8AbN6BX9UlS@shlinux89>
Content-Language: en-US
In-Reply-To: <akMgh8AbN6BX9UlS@shlinux89>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 6/30/26 3:48 AM, Peng Fan wrote:

Hello Peng,

> Do you have time to give a look at this series?

No, sorry, I am recently entirely overwhelmed by emails and my backlog 
only grows. Did Sebastian/Jonas provide any feedback on the TCPM part?
