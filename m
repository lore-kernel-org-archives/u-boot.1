Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2206DC27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 11:30:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E74E8658A;
	Thu, 24 Aug 2023 13:30:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1692876616;
	bh=piCQgMwuV2hfK7yxd5NUO6Ef1l18rOOkqyi0A/gmgmY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PkHaKdJINbdKkn+GGJxUApPv+qkXmmDZ8a+4bjj5TUBftsvk/i661fo2Rom7B8ApV
	 Vt25UBuhde50iF7qKtLQgxRRNO7sk4Hc8D8Oh4y+r9ccxPJsrBKWeqiq2tHYA2IysP
	 Tpriz0Q5w9e4HJlcC1BWsulu5o/PsG1HjbUSd/SYFetTRJ7H3eX7LoyNVi1FbYlNbs
	 97QGoG7b1EizrqEqLwJXqrxD+M/o4fDWwg/t1NgcvLC7b7zZWU7D6OoVtv5iOGyZOV
	 SodeLd2Dm1ezitp2PQxkrXXRaCHVUQoGW/F3XiIfFiXb2WCgqBDM9sC2/FlUgbyFUT
	 62KrLFShWv5vg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE11A8657A; Thu, 24 Aug 2023 13:30:14 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org
 [IPv6:2001:67c:2050:101:465::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58A758658C
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 13:30:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4RWgqP5tQVz9sTM;
 Thu, 24 Aug 2023 13:30:09 +0200 (CEST)
Message-ID: <86f392b4-b549-9891-f272-73706543c5c0@denx.de>
Date: Thu, 24 Aug 2023 13:30:09 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] ARM64: dts: marvell: cn9310-crb: Remove duplicate
 pinctrl
Content-Language: en-US
To: Chris Packham <judge.packham@gmail.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20230820233113.575818-1-judge.packham@gmail.com>
 <20230820233113.575818-2-judge.packham@gmail.com>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20230820233113.575818-2-judge.packham@gmail.com>
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

On 8/21/23 01:31, Chris Packham wrote:
> The cn9130.dtsi defines a pinctrl node for SPI1 (until recently it was
> mislabeled as spi0). Use this instead of having a duplicate definition
> with a different label.
> 
> Signed-off-by: Chris Packham <judge.packham@gmail.com>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
> 
>   arch/arm/dts/cn9130-crb.dtsi | 7 +------
>   1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/arch/arm/dts/cn9130-crb.dtsi b/arch/arm/dts/cn9130-crb.dtsi
> index b229725184a9..7dd36cae282b 100644
> --- a/arch/arm/dts/cn9130-crb.dtsi
> +++ b/arch/arm/dts/cn9130-crb.dtsi
> @@ -125,11 +125,6 @@
>   		marvell,function = <0>;
>   	};
>   
> -	cp0_spi1_pins_crb: cp0-spi-pins-crb {
> -		marvell,pins = < 13 14 15 16 >;
> -		marvell,function = <3>;
> -	};
> -
>   	cp0_smi_pins_crb: cp0-smi-pins-crb {
>   		marvell,pins = < 40 41 >;
>   		marvell,function = <8>;
> @@ -170,7 +165,7 @@
>   
>   &cp0_spi1 {
>   	pinctrl-names = "default";
> -	pinctrl-0 = <&cp0_spi1_pins_crb>;
> +	pinctrl-0 = <&cp0_spi1_pins>;
>   	reg = <0x700680 0x50>,		/* control */
>   	      <0x2000000 0x1000000>,	/* CS0 */
>   	      <0 0xffffffff>,		/* CS1 */

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
