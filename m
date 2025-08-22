Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 893EACA0EED
	for <u-boot@archiver.kernel.org>; Fri, 22 Aug 2025 19:06:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CEF180422;
	Fri, 22 Aug 2025 21:06:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="IXkhdv+y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6075A80548; Fri, 22 Aug 2025 21:06:49 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50A4C8006D
 for <u-boot@lists.denx.de>; Fri, 22 Aug 2025 21:06:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4c7qRn2hSkz9tS7;
 Fri, 22 Aug 2025 21:06:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1755889605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JkktD82t/vACJI1a9RQHtp7OwVwoXYuKqbvnB68DR2U=;
 b=IXkhdv+yhE3cQtuvwq2FEf6/nGP4ZINq+Q3bZj9oGg9iCiFC5Kid0GR2mhPah/jD9sGQfp
 p/0n48ZZDnLfqv7O+8yCJr76uwOptj29kh7p0luKrtaIA1mmDm4VXy8rgac8jF5WLWWlRQ
 CmM1+Xur9M0OVbOiU4dlWYxk4zPNrMWCrEaUDww5NkrS+G3q9fYH5BYtimNQiDILqMB+ey
 RIsb+lWnsyPVdbLRCXD1bQorgsiKth2X+UVfq/tJoYLCKS95qruDxzgbbenx/o0AcE8hac
 e80BauIsbgwK33ds2Iz8x+KN+ActZx6JwwNfNjstceFG1scNGwsYz255pRo3Uw==
Message-ID: <2e7151dd-c793-4ad7-ae95-5173927ad40e@mailbox.org>
Date: Fri, 22 Aug 2025 21:06:42 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 01/10] usb: host: dwc3-of-simple: Add exynos850 compatible
To: Sam Protsenko <semen.protsenko@linaro.org>,
 Minkyu Kang <mk7.kang@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: Minkyu Kang <promsoft@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
References: <20250806222710.23773-1-semen.protsenko@linaro.org>
 <20250806222710.23773-2-semen.protsenko@linaro.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250806222710.23773-2-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 93ce73e3afb6581a0b3
X-MBO-RS-META: hnh5qai4ifzdacfqdwp8t31ynoxook8c
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

On 8/7/25 12:27 AM, Sam Protsenko wrote:
> Enable support for Exynos850 SoC in DWC3 host glue layer driver.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>

Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>

Thanks
