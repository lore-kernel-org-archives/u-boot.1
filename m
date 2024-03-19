Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 543D3C54E5D
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 08:26:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DA2687B77;
	Tue, 19 Mar 2024 09:26:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=norik.com header.i=@norik.com header.b="ZwMH/QGX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C57E087B77; Tue, 19 Mar 2024 09:26:37 +0100 (CET)
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D395E87D45
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 09:26:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=primoz.fiser@norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com; 
 s=default;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tUh+7kbGNdT+kASsPu/TNarkc1Z090GBCiWXrkE8KXM=; b=ZwMH/QGX8JAbevKXS1z+K+YJJ9
 iJq5Yp7hTHhQI4fLIONLNWpz5gy7C7pW0N8e0gPd1YqaLJ009s7PoIvbXjcB3fkzykiImcNZH3waZ
 vkeE50YMSlg/l0l1Zn5GlkE2yJczTpD37zcaTHtT3lDkx6nffdZmdRJ3mHjZU1D7ghvfBPYLxuBaS
 CfzWfNoMXRjZCHs21TyOKBdR3QZuK7I0/TaFdgppFVMwEAOr9pZG8uL6QFs7GMggFPf1wUtrfSDd7
 /e/o+e77FOB+o30GdQY/apyayJ228zjom6Og2vo/6Py0xWXpoIhDmwhfVd1Fcpd7GIPJBO3JZ/tW1
 Q6ebDg+Q==;
Received: from [89.212.21.243] (port=53458 helo=[192.168.69.116])
 by cpanel.siel.si with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.96.2)
 (envelope-from <primoz.fiser@norik.com>) id 1rmUnl-0010vE-0U;
 Tue, 19 Mar 2024 09:26:28 +0100
Message-ID: <7b49c2e8-20b4-4307-9391-089128505da7@norik.com>
Date: Tue, 19 Mar 2024 09:26:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] arm: dts: imx93-phyboard-segin: Add USB support.
Content-Language: en-US
To: Marek Vasut <marex@denx.de>, Mathieu Othacehe <othacehe@gnu.org>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Shiji Yang <yangshiji66@outlook.com>, Ye Li <ye.li@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, Stefano Babic <sbabic@denx.de>,
 =?UTF-8?Q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>,
 Fabio Estevam <festevam@gmail.com>, Simon Glass <sjg@chromium.org>,
 Mathieu Othacehe <m.othacehe@gmail.com>, Yannic Moog <y.moog@phytec.de>,
 Christoph Stoidner <c.stoidner@phytec.de>, Wadim Egorov <w.egorov@phytec.de>
Cc: u-boot@lists.denx.de
References: <20240318171637.12664-1-othacehe@gnu.org>
 <20240318171637.12664-2-othacehe@gnu.org>
 <c9f92bd5-96c8-46b6-a672-9473d7be7aac@denx.de>
From: Primoz Fiser <primoz.fiser@norik.com>
Organization: Norik systems d.o.o.
In-Reply-To: <c9f92bd5-96c8-46b6-a672-9473d7be7aac@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id:
 primoz.fiser@norik.com
X-Authenticated-Sender: cpanel.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
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

Hi Marek,

On 18. 03. 24 22:48, Marek Vasut wrote:
> On 3/18/24 6:16 PM, Mathieu Othacehe wrote:
>> Enable both usbotg1 and usbotg2 ports.
> 
> Drop fullstop from $subject end.
> 
>> Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
>> ---
>>   arch/arm/dts/imx93-phyboard-segin.dts | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/arch/arm/dts/imx93-phyboard-segin.dts
>> b/arch/arm/dts/imx93-phyboard-segin.dts
>> index 85fb188b057..acf307a3192 100644
>> --- a/arch/arm/dts/imx93-phyboard-segin.dts
>> +++ b/arch/arm/dts/imx93-phyboard-segin.dts
>> @@ -40,6 +40,19 @@
>>       status = "okay";
>>   };
>>   +/* USB  */
>> +&usbotg1 {
>> +    disable-over-current;
> 
> Why is this needed ?

OC pins are not connected to the SoC thus disable OC to avoid warnings
(c/p from kernel dts).

BR,
Primoz


