Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42B25C282DE
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 20:06:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0F1F80FF7;
	Thu, 13 Mar 2025 21:06:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1741896399;
	bh=P+ZoWg79W1OL7DfuV7167CpIxBIEMNNatgNx8SBSl+E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jwmOUCaRqQ1j4joNso5bAaIaYLhMzypKpn0CvDEnWMmO1gewUiciDYGR9UtOHeOnK
	 dwAnBla4IZs463w4ltgeOPgqPjyTm/BYfB7NI4A8csuekRiwPP/Nr75FrD5RLSLHIR
	 7pgWuvfId9exzPSYkSfisotpQvINXqSevGWrYB56bpYjcsm3DA5q98Orf5TvU+2wzj
	 yIewrfwaHHplCYxxrmV9lR5nGSUPDvg78SsBgg0uy7km07m0hlStWztluO2xbDJzJ9
	 DqT/1NFqDWwlnyEf8MHjEUkKfMj5vs2Uo8e2YbzXTwK7ovHZ9x71xIARVJSbD3hEl4
	 EzrakwykTDQ6g==
Received: by phobos.denx.de (Postfix, from userid 109)
 id F27DE8168B; Thu, 13 Mar 2025 21:06:38 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06D3480756
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 21:06:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="fhIap+B1"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7DB9C103D43BD; Thu, 13 Mar 2025 21:06:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1741896395; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=P+ZoWg79W1OL7DfuV7167CpIxBIEMNNatgNx8SBSl+E=;
 b=fhIap+B1l1yhyN4feWS8YaHuyBKqPKOi4aHfyuOuSoRUuNFogIP30J69t/PPnT/QqyS/Mo
 +nXDKy+z52LxpQfn14DrSbPtocTWePVX+DRr0vbFVg2KMIyIctftcsuJBiUV9VB4AUc5/I
 Cte5h2UWrt2pqcDMoZXFqjhAX0v4faDj8Y5aSfYaKIGvQmLfiL2fUaxd7LrJhP6lUVmHza
 RCPq+gTNA2Y7wb5AhFTp5LIRYr/HC8DiZxl8H5ljuxhczasUSybET/DO9HvghVgT9zn/ab
 I9lXdIy+3GmmmlngqkZrTV0B+r4/nJHOJQ1Xj7Ib3+EHFfQD+LMwiCNAJ49Hnw==
Message-ID: <da9bee03-b143-4d94-90c3-4e7a08a26e62@denx.de>
Date: Thu, 13 Mar 2025 21:06:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: imx: Drop bogus regulator extras on DH i.MX6
 DHCOM DRC02
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Andreas Geisreiter <ageisreiter@dh-electronics.de>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com
References: <20250311013430.510151-1-marex@denx.de>
 <CAOMZO5BuSS7Q2h_GOOkhcDyH4UNibe9FJHvHBmB8z+Qy9ZJP3A@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAOMZO5BuSS7Q2h_GOOkhcDyH4UNibe9FJHvHBmB8z+Qy9ZJP3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 3/13/25 8:57 PM, Fabio Estevam wrote:
> On Mon, Mar 10, 2025 at 10:34 PM Marek Vasut <marex@denx.de> wrote:
>>
>> The regulator extras should be placed in the USB H1 regulator node,
>> the /regulator-usb-h1-vbus. They are already present there in the
>> upstream DT, so delete this bogus node entirely.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
> 
> Applied to u-boot-imx/next, thanks.

This is a bugfix, so should be master.
