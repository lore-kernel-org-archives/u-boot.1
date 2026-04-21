Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3BB5F94CA9
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 19:39:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C799839D5;
	Tue, 21 Apr 2026 21:39:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="YT8R0f9y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1D8683A91; Tue, 21 Apr 2026 21:39:40 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 631C583936
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 21:39:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 29717114817; Tue, 21 Apr 2026 21:39:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1776800377;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=8VFHljY4wb/MseQsKc6g/Q+9aWqR9Jl56AGwTB90Z2o=;
 b=YT8R0f9yo7MuM1/g6qwNUhvQpAvk4KNKnDJTdIf7N6Oi6hYxuPMmkFEWU6VywqLqI98hFc
 hm62khvb81ww4EHsru9ljLB5uYcVT4Uaoiza+Eynvai9eVaU8jyJZ7pBN9qgo0s7i53MPl
 ik5Focxbtwb9sFwM44nvsoDbmTfYNAuECmEWp7zflFmC34Z/OdoQpijd/PU8RCrVty/Yn0
 cr/KC8omz0KgcaTzWbvDXMrbgH2xkPBquVrPXqYLxIpG+5J/I21mqwDU81yIcuMvoIFqT1
 mf5BEDcwudwsGOxmA/uNUos3UWyGfjskS1TqNr5S1tGnO8fbCTtdQLL3otBnsg==
Message-ID: <8d8a649a-4cc3-4d88-9028-a8c4976beb12@nabladev.com>
Date: Tue, 21 Apr 2026 21:39:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] board: dhelectronics: imx: Use second Ethernet MAC
 also from fuse
To: Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 u-boot@lists.denx.de, Fabio Estevam <festevam@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com
References: <20260415101257.23154-1-cniedermaier@dh-electronics.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260415101257.23154-1-cniedermaier@dh-electronics.com>
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

On 4/15/26 12:12 PM, Christoph Niedermaier wrote:
> Currently, the board specific code evaluates only the first Ethernet
> MAC address fuse, regardless of whether the first or second MAC
> address is requested. When the function for determine the second

"the function _to_ determine" ... can this be fixed when applying ?

... and uh, odd, why is Fabio not on CC ? I don't think this patch will 
be picked up with him not on Cc.
