Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 555DBD12D71
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 05:55:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 600B689189;
	Mon, 11 Nov 2024 06:55:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1731304508;
	bh=E+IyM2C8TmjHEgBeXfmeERRJnPtI9ncbybqmbXNDbGQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=ITaWtiSvOrYbMSUd2Wv5UfHVTqWc+LOQEPi3CsKeYI4RKWGfOaQNYDsaDepP5pW5e
	 xwHhwMSwjs8V1eipq5+NmgA14YzPIAHgFO9ohLrA+MXU/4IraCP7G01nA3GjIIcCHE
	 nKjLHa9EGVLobGKBYq/SpkpTHcN82+TSzhMPbSxI0dQohP1+iphYEi6oootWS2ezN+
	 EkeDeAcejrSMo+WrQ5qo8IET5jKZ15D7ovrXpPHnnagBdLgwEEOHLLupmXeUnv81GX
	 W0iuMkXW0/MFCmhQoICf1crQjFSQPttLtDEYebwLTX4VZt+7E8HTYPcOy13EoE3TXK
	 71/p0hu8Y2jHg==
Received: from [192.168.1.107] (87-97-106-70.pool.digikabel.hu [87.97.106.70])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 92AA68911D;
 Mon, 11 Nov 2024 06:55:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1731304506;
 bh=E+IyM2C8TmjHEgBeXfmeERRJnPtI9ncbybqmbXNDbGQ=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=ofnLJp4kNU0NfsgN+RyqfPZt56JlDefiNiF4DcK9uR6G/UrD93picywnwx2/+sQvN
 uy1SkmS5Vp8//ui/9cV3OjsRs8H6CxePdiEJBX5pai5hcoHG7PAwoDrh8wgPkyf5uk
 RhdWQPYYzy2+fVzlT0vAds3/Aj251c2vujpl+ybGb1Vm2PcPMZxFTCE5CtwACz1Usp
 zaiKQoiqqmvsJefarayNjj6T86bNvXpUQ87KuAxemY/JYECOSl5y5OHShmgMPThUc0
 eSlRQ6yEqE9xjuyCoosEA7U62CaDZrsMyIHmatrCY2AXhN4qPcR8wkfQqSpjgeIszm
 9svvWkrj4A44w==
Message-ID: <4dadf359-8113-08b7-f198-42a2111cef81@denx.de>
Date: Mon, 11 Nov 2024 06:52:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1 15/22] siemens: imx8-capricorn.dtsi: small adaptions
Content-Language: en-US
To: Fabio Estevam <festevam@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Enrico Leto <enrico.leto@siemens.com>,
 Walter Schweizer <walter.schweizer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Anatolij Gustschin <agust@denx.de>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, Stefano Babic <sbabic@denx.de>,
 Tom Rini <trini@konsulko.com>
References: <20241108052143.26874-1-hs@denx.de>
 <20241108052143.26874-16-hs@denx.de>
 <CAOMZO5D77WPgrjXXyBzk-rAApcqxfSS7nZCF8usz2jj_oF1QpA@mail.gmail.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <CAOMZO5D77WPgrjXXyBzk-rAApcqxfSS7nZCF8usz2jj_oF1QpA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Fabio,

On 09.11.24 13:03, Fabio Estevam wrote:
> Hi Heiko,
> 
> On Fri, Nov 8, 2024 at 2:22 AM Heiko Schocher <hs@denx.de> wrote:
>>
>> - remove DMA for console
> 
> Why? Does it cause problems in U-Boot?

Forward this question to Enrico.

>> - add wdt device
>>
>> Signed-off-by: Heiko Schocher <hs@denx.de>
>> ---
>>
>>   arch/arm/dts/imx8-capricorn.dtsi | 16 ++++++++++++++++
> 
> Are there any plans to upstream this dtsi and switch to OF_UPSTREAM?

Hmm... good question! Currently we work on U-Boot to get mainline ready
for use in production, so we get rid from NXP code.

I do not know, if we can reach this with mainline linux too...

May the siemens guys can answer this...

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
