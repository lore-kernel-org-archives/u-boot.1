Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E61C8E77188
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 23:30:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD9A0806D6;
	Wed, 15 Jan 2025 00:30:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1736897415;
	bh=WyZBAdAcOc4IsPhccMi17z79tZkHkPFUZw/TLR3V3iw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Lj1x5VZP/VyNjoPb5VUcgMDSkW4wRUYM7gIYr9nXSx0k459TnZKOGJK9tsExCEzSO
	 2FH8ZluQ7/O7sHqeYYu0qphksY6TRoSWRm3n9EO7Iea3ZjnqAGsCd/Lur4Zf38ogbm
	 hlC7zxysfAzynGTG09GHgb39mlyKZyEFIz7DcQ1wSaE5a4jNbqkZO8P3d3xZ9eqnek
	 0yRxMgj/daoooVvUtvU6cCwEMVgFnEKX9mO2s2ux6fv0VZgsxmvh4j3M8+/My/5cUM
	 MTjRxJZM9xmFpFtDmOrb2u7FHKidQmUJekG6Oeo6r6TgXRTv3PaQURAoDuN+d7toBu
	 bX+DUTo1yLmTw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0622806D8; Wed, 15 Jan 2025 00:30:14 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADFE88069A
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 00:30:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="QT0Cf/WQ"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3B0E110488481; Wed, 15 Jan 2025 00:30:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1736897411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WyZBAdAcOc4IsPhccMi17z79tZkHkPFUZw/TLR3V3iw=;
 b=QT0Cf/WQZmBGJl8Mdo1x9B3N+m3MlwN+bAieUxPjqngtnIDJySaQOufnd3UENtnAkLMsp8
 PLhqaipQC/uDdFMEi+bSUee6dzHdEZztWCWNLJJeuQCq+Wk4lAfxTOKZYbBoIPJljf6fOh
 YX9kNZFBTukY6W11veKP+xV53ftToTxBtYOT8ez88dYGPfLSqduQ5FdgjLyvMpEwcAfxnf
 J4ywXTG2svmkqSLYg8xPPQR2ysu5/4i5anvRqsGbeEHcxuPXK028d8bnHEA9pbfhMEMZEC
 J4DIl4WzZfX5tEpz9Zxc/ULIxYrNmVQudRG/1mPL2zKK3w/75uCPQD8bUlu1Lg==
Message-ID: <84b18e4b-cdd8-4767-98d2-ef31167ed6be@denx.de>
Date: Wed, 15 Jan 2025 00:28:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/17] imx95_evk: add i.MX95 19x19 EVK board basic
 support
To: Tim Harvey <tharvey@gateworks.com>, Alice Guo <alice.guo@oss.nxp.com>
Cc: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>,
 u-boot@lists.denx.de, Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
References: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
 <20250103-imx95-v1-17-6744df5dc020@oss.nxp.com>
 <CAJ+vNU1xAhYdnoTRLuM6fWa1mQgkLrVj03BsSObtd7NDq9oogw@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAJ+vNU1xAhYdnoTRLuM6fWa1mQgkLrVj03BsSObtd7NDq9oogw@mail.gmail.com>
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

On 1/14/25 11:34 PM, Tim Harvey wrote:
> On Thu, Jan 2, 2025 at 10:47 PM Alice Guo <alice.guo@oss.nxp.com> wrote:
>>
>> From: Ye Li <ye.li@nxp.com>
>>
>> This patch adds i.MX95 19x19 EVK board basic support.
>>
> 
> Hi Alice,
> 
> Could you add in the commit log what is and/or what is not supported?
> 
>  From what I see:
> 
> the following is supported:
> - gpio
> - pci

I don't think either the ECAM (internal ethernet PCIe) or PCIe host are 
supported, but the former is coming (I'm working on networking support) 
and the later is easy to add based on the current MX8MP DW PCIe driver 
and PHY drivers.

> - i2c
> - mmc
> 
> the following are not yet supported by this series:
> - ethernet
> - usb
USB 2.0 should be usable with u-boot/master now, although you will need 
to pull more recent DTs to obtain the controller node in imx95.dtsi .

USB 3.0 is possible without this TypeC switcher in PHY driver, I got it 
working as gadget I think.
