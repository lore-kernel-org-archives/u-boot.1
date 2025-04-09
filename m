Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B18F8C36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 11:45:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C145183692;
	Wed,  9 Apr 2025 13:45:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="CxFMHNGx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF8C183698; Wed,  9 Apr 2025 13:45:40 +0200 (CEST)
Received: from mx2.securetransport.de (mx2.securetransport.de [188.68.39.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 718A4835FE
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 13:45:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1744199099;
 bh=IPH/KbaQ0ohRpJ0YM3QxlB9z7jC2NQLBbwY6C557oYY=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:From;
 b=CxFMHNGxai0YUa1mi4BRc2JtTAPeZEFIkbUMPoL7HPuo250K/G45BvSU+TDlbQkBI
 1lpodO0WEJJ2B1/w7zmrzQVTU1OWj+/wmTEv9hSUKghtDy5WVgCnn1OXY6X+oTG+Jv
 S/PW8nMoMSRPf9zKQfxGSwaxDZ58k0e5dSNx0uR34bFfrvb30mkihCNMVQ8h8muvd3
 f8krUHSgPWPrSA6wo4PSRamH3IFsS2aq5r9caqWvA1CSeGrD41TQMGEkROdDSnhsMM
 SSzoTBt1KvNUFv3xRZaUJQwH9lQY1M8RF6S1DwSzgTiydalATGSFTqSBFfgd5Abmqa
 m8shWshomRTHQ==
X-secureTransport-forwarded: yes
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To: Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Simon Glass
 <sjg@chromium.org>, Michael Walle <mwalle@kernel.org>, Quentin Schulz
 <quentin.schulz@cherry.de>, Marek Vasut <marex@denx.de>, Benedikt Spranger
 <b.spranger@linutronix.de>, Jerome Forissier <jerome.forissier@linaro.org>,
 John Ogness <john.ogness@linutronix.de>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>
Subject: RE: [PATCH] tiny-printf: Handle formatting of %p with an extra Kconfig
Thread-Topic: [PATCH] tiny-printf: Handle formatting of %p with an extra
 Kconfig
Thread-Index: AQHbp5sW1d25vB71o0K258WD0P1O67OaITQAgAEBz/A=
Date: Wed, 9 Apr 2025 11:44:27 +0000
Message-ID: <063948ec5d3845daae97d4b9bc97c901@dh-electronics.com>
References: <20250407085614.126626-1-cniedermaier@dh-electronics.com>
 <20250408205826.GZ5495@bill-the-cat>
In-Reply-To: <20250408205826.GZ5495@bill-the-cat>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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

From: Tom Rini <trini@konsulko.com>
Sent: Tuesday, April 8, 2025 10:58 PM
> To: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> Cc: u-boot@lists.denx.de; Simon Glass <sjg@chromium.org>; Michael Walle
> <mwalle@kernel.org>; Quentin Schulz <quentin.schulz@cherry.de>; Marek Vas=
ut
> <marex@denx.de>; Benedikt Spranger <b.spranger@linutronix.de>; Jerome For=
issier
> <jerome.forissier@linaro.org>; John Ogness <john.ogness@linutronix.de>; I=
lias Apalodimas
> <ilias.apalodimas@linaro.org>
> Subject: Re: [PATCH] tiny-printf: Handle formatting of %p with an extra K=
config
>=20
> On Mon, Apr 07, 2025 at 10:56:14AM +0200, Christoph Niedermaier wrote:
>=20
>> The formatting with %pa / %pap behaves like %x, which results in an
>> incorrect value being output. To improve this, a new fine-tuning
>> Kconfig XPL_USE_TINY_PRINTF_POINTER_SUPPORT for pointer formatting
>> has been added. If it is enabled, the output of %pa / %pap should
>> be correct, and if it is disabled, the pointer formatting is
>> completely unsupported. In addition to indicate unsupported formatting,
>> '?' will be output. This allows enabling pointer formatting only
>> when needed. For SPL_NET and NET_LWIP it is selected by default.
>> Then it also supports the formatting with %pm, %pM and %pI4.
>>
>> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
>> ---
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: Simon Glass <sjg@chromium.org>
>> Cc: Michael Walle <mwalle@kernel.org>
>> Cc: Quentin Schulz <quentin.schulz@cherry.de>
>> Cc: Marek Vasut <marex@denx.de>
>> Cc: Benedikt Spranger <b.spranger@linutronix.de>
>> Cc: Jerome Forissier <jerome.forissier@linaro.org>
>> Cc: John Ogness <john.ogness@linutronix.de>
>> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> ---
>>  Kconfig            |  1 +
>>  common/spl/Kconfig |  1 +
>>  lib/Kconfig        |  8 ++++++++
>>  lib/tiny-printf.c  | 45 +++++++++++++++++++--------------------------
>>  4 files changed, 29 insertions(+), 26 deletions(-)
>>
>> diff --git a/Kconfig b/Kconfig
>> index 6379a454166..4d13717294c 100644
>> --- a/Kconfig
>> +++ b/Kconfig
>> @@ -757,6 +757,7 @@ config NET
>>
>>  config NET_LWIP
>>  	bool "Use lwIP for networking stack"
>> +	select XPL_USE_TINY_PRINTF_POINTER_SUPPORT if SPL_USE_TINY_PRINTF || T=
PL_USE_TINY_PRINTF || VPL_USE_TINY_PRINTF
>>  	imply NETDEVICES
>>  	help
>>  	  Include networking support based on the lwIP (lightweight IP)
>> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
>> index 94e118f8465..72736dbecf5 100644
>> --- a/common/spl/Kconfig
>> +++ b/common/spl/Kconfig
>> @@ -1096,6 +1096,7 @@ config SPL_DM_SPI_FLASH
>>  config SPL_NET
>>  	bool "Support networking"
>>  	depends on !NET_LWIP
>> +	select XPL_USE_TINY_PRINTF_POINTER_SUPPORT if SPL_USE_TINY_PRINTF || T=
PL_USE_TINY_PRINTF || VPL_USE_TINY_PRINTF
>>  	help
>>  	  Enable support for network devices (such as Ethernet) in SPL.
>>  	  This permits SPL to load U-Boot over a network link rather than
>> diff --git a/lib/Kconfig b/lib/Kconfig
>> index 1a683dea670..62e28d4a1f3 100644
>> --- a/lib/Kconfig
>> +++ b/lib/Kconfig
>> @@ -253,6 +253,14 @@ config VPL_USE_TINY_PRINTF
>>
>>  	  The supported format specifiers are %c, %s, %u/%d and %x.
>>
>> +config XPL_USE_TINY_PRINTF_POINTER_SUPPORT
>> +	bool "Extend tiny printf with the pointer formatting %p"
>> +	depends on SPL_USE_TINY_PRINTF || TPL_USE_TINY_PRINTF || VPL_USE_TINY_=
PRINTF
>> +	help
>> +	  This option enables the formatting of pointers %p. It supports
>> +	  %p and %pa / %pap. If this option is selected by SPL_NET or NET_LWIP
>> +	  it also supports the formatting with %pm, %pM and %pI4.
>=20
> This isn't quite what I'd like to see. I don't want to start using the
> literal XPL namespace as that will lead to confusion down the line.

OK, in V2 I will only support SPL.

> Since we only have SPL_NET, I think we should name this symbol
> SPL_USE_TINY_PRINTF_POINTER_SUPPORT, not ask about it (so bool without
> "prompt text" following), and select from SPL_NET if
> SPL_USE_TINY_PRINTF.

Now you will get the output '?' when using formatting with %p or %pa.
If someone wants to use the pointer support e.g. %pa in pinctrl-single.c
and is restricted to use tiny printf, then it would be good to have
the option to enable it manually and not be forced to enable SPL_NET or
NET_LWIP to have the pointer support enabled. In this case, it makes
sense to allow switching it on in menuconfig.

Regards
Christoph
