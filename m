Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB74C54798
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 10:32:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46E2A88027;
	Tue,  5 Mar 2024 11:32:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1709634734;
	bh=8/C8RzlqSLMtBOQOkyJqioZCljpN6TNkIfkpG+3D9oU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZPOdGw1R/dGtlMYFNKkbmJSgMDE8fiiaWSZpcEu8hjqGRNT6M+dh1I1PUtREQUxda
	 2hHJzAxlwOUjd2F4HWwy0XxJuTIVvhyoeQgfJHfJY4BFZnK7vbZkRoFTTPZFzr/uOj
	 ALLIH4gtBVJKohAC3CLCKh7AVxZSF4ftsRfn5HJu1LK4qqfZ3tNn5Bxxgjf33CWbm6
	 vBV7PY4bUzQDVv5yn61qwasKt/eOvzEATM0wJ7YaS3wU3Jy5IWshzzaiKn7To6uwDK
	 EUbxesj13Cqi+1/v7kZA9Pas1juLLgEDY3nWxKM/9QxGqyrpPi4kQgVLgxBewcRwku
	 pBCkNg5pSlC4w==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A70C88031; Tue,  5 Mar 2024 11:32:13 +0100 (CET)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org
 [IPv6:2001:67c:2050:101:465::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4684688023
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 11:32:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4TpsLx0dYxz9sR5;
 Tue,  5 Mar 2024 11:32:09 +0100 (CET)
Message-ID: <76ea692e-c71c-4243-bfa3-9ec34babc3b3@denx.de>
Date: Tue, 5 Mar 2024 11:32:08 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/3] arm: dts: armada-38x-solidrun-microsom: configure
 i2c0 bus
Content-Language: en-US
To: Josua Mayer <josua@solid-run.com>, Dennis Gilmore <dgilmore@redhat.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240202-helios4-spi-v2-0-df085461d894@solid-run.com>
 <20240202-helios4-spi-v2-1-df085461d894@solid-run.com>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20240202-helios4-spi-v2-1-df085461d894@solid-run.com>
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

On 2/2/24 16:13, Josua Mayer wrote:
> SolidRun Armada-388 SoM has an i2c bus supporting on-som eeprom, and
> peripherals on a carrier.
> armada-38x.dtsi disables this bus by default, it should be enabled by
> som or carrier dts.
> 
> Linux has moved i2c0 from helios-4 board dts to som dtsi, including
> status, pinctrl and clock speed.
> Copy these settings from mainline.
> 
> This fixes accessing i2c bus from u-boot commandline.
> 
> Signed-off-by: Josua Mayer <josua@solid-run.com>

Applied to u-boot-marvell/master

Thanks,
Stefan

> ---
>   arch/arm/dts/armada-38x-solidrun-microsom.dtsi | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/dts/armada-38x-solidrun-microsom.dtsi b/arch/arm/dts/armada-38x-solidrun-microsom.dtsi
> index f6ae784bed..1540162e03 100644
> --- a/arch/arm/dts/armada-38x-solidrun-microsom.dtsi
> +++ b/arch/arm/dts/armada-38x-solidrun-microsom.dtsi
> @@ -99,6 +99,11 @@
>   };
>   
>   &i2c0 {
> +	clock-frequency = <400000>;
> +	pinctrl-0 = <&i2c0_pins>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +
>   	eeprom@53 {
>   		compatible = "atmel,24c02";
>   		reg = <0x53>;
> 

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
