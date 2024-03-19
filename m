Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4156CC54E60
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 14:18:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93F1B88081;
	Tue, 19 Mar 2024 15:18:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1710857909;
	bh=At7zim04snSJuqV7sm7PDeLO1AwS1F1k0E8hhN6Zx7A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MNJWUo4meQtTTChRbNYJqeybRtYJodibZSWOKW4gyZhnATMZJ0I3Kjw1f234JLfyC
	 46G3dyE/54e7F4Ov7Wczus8FUhUz0nYSJxCcHjK9A8MhP4eG7imAzOLaiRtoWiHusz
	 G09osEgQbcJEQvuIfj2n0hxvx/5hgaAFKwTf6UmkkaiHbMdu4Ws4hdqzOux19sRmZX
	 2y0l06+rCMV9SoFMCKJRRQsQV0DBmDJ5E8NZn9kpaXUNWOmf7FFAKheHkL66ANe2sh
	 CUgYwXF6ShQKmkZ1MvsoW18TetuwUE3H32ZVsdSErcsFe3Vs4Uz/2+Ek0kn0QMuPFQ
	 AOorS4cLljSiQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 4606C87F78;
 Tue, 19 Mar 2024 15:18:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1710857908;
 bh=At7zim04snSJuqV7sm7PDeLO1AwS1F1k0E8hhN6Zx7A=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=dcG4r5D7zRv3YwaIe0/6Rqxt8BbpG5n/D/EeGhztfFvL1nC4m4epnfldbpp1tlReW
 9hqn/o/lt8i1SQRcN5hytwpW00TsPnqznDU1TZpShO8/qp/mU/cvlw3sdScCBj7O+q
 9cZMk/n0xiO2W2OU2u3T1Ize6i1WdEZMGYl4yhr3Y53Zjzf2w8mZZb68hU4JFM5RBH
 ptpF1+5fIZbVEskZ3FblxpjMY9JdKjQlf813cyqKLyIUGMIDk7+nbQaOlHX+3wiCwC
 z7OAW9+/6dU/n24856oVsrfQTktn+7FsIkI6Ev2bdUo/AiWQy38ZqDL06SbP3E0src
 pWkZ02V8b1qFw==
Message-ID: <8b232ac3-f6b0-45da-aeaf-1ce12f006f80@denx.de>
Date: Tue, 19 Mar 2024 14:57:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] arm: dts: imx93-phyboard-segin: Add USB support.
Content-Language: en-US
To: Primoz Fiser <primoz.fiser@norik.com>, Mathieu Othacehe
 <othacehe@gnu.org>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Shiji Yang <yangshiji66@outlook.com>,
 Ye Li <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Stefano Babic <sbabic@denx.de>,
 =?UTF-8?Q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>,
 Fabio Estevam <festevam@gmail.com>, Simon Glass <sjg@chromium.org>,
 Mathieu Othacehe <m.othacehe@gmail.com>, Yannic Moog <y.moog@phytec.de>,
 Christoph Stoidner <c.stoidner@phytec.de>, Wadim Egorov <w.egorov@phytec.de>
Cc: u-boot@lists.denx.de
References: <20240318171637.12664-1-othacehe@gnu.org>
 <20240318171637.12664-2-othacehe@gnu.org>
 <c9f92bd5-96c8-46b6-a672-9473d7be7aac@denx.de>
 <7b49c2e8-20b4-4307-9391-089128505da7@norik.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <7b49c2e8-20b4-4307-9391-089128505da7@norik.com>
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 3/19/24 9:26 AM, Primoz Fiser wrote:
> Hi Marek,
> 
> On 18. 03. 24 22:48, Marek Vasut wrote:
>> On 3/18/24 6:16 PM, Mathieu Othacehe wrote:
>>> Enable both usbotg1 and usbotg2 ports.
>>
>> Drop fullstop from $subject end.
>>
>>> Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
>>> ---
>>>    arch/arm/dts/imx93-phyboard-segin.dts | 13 +++++++++++++
>>>    1 file changed, 13 insertions(+)
>>>
>>> diff --git a/arch/arm/dts/imx93-phyboard-segin.dts
>>> b/arch/arm/dts/imx93-phyboard-segin.dts
>>> index 85fb188b057..acf307a3192 100644
>>> --- a/arch/arm/dts/imx93-phyboard-segin.dts
>>> +++ b/arch/arm/dts/imx93-phyboard-segin.dts
>>> @@ -40,6 +40,19 @@
>>>        status = "okay";
>>>    };
>>>    +/* USB  */
>>> +&usbotg1 {
>>> +    disable-over-current;
>>
>> Why is this needed ?
> 
> OC pins are not connected to the SoC thus disable OC to avoid warnings
> (c/p from kernel dts).

Please add it to the commit message for posterity, thanks.
