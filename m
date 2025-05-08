Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4FB8C3ABC0
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 11:57:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B1F0822D7;
	Thu,  8 May 2025 13:57:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="xQX1t6R9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA276828BC; Thu,  8 May 2025 13:56:58 +0200 (CEST)
Received: from mx3.securetransport.de (mx3.securetransport.de [116.203.31.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE39282153
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 13:56:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1746705371;
 bh=KsksNRE3+olPddrnJQseDQKwej2IcMXwsU2ALhcXQ1Q=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:From;
 b=xQX1t6R9/kfoxIVuVu/qgYiGlM1ik58BB4XdkkvJdyc04/MIdCDI2w4FF9QN4/LxK
 hK7nCCDt44vzDFig/9ABW8k+bwyVRVUZYTaQf0WkdB57JwAVy83sH4SvZ0Bb1FvFdn
 PW3R1LUmS7XkLsKcIYiM5eJV0hyygLFQ5bKpzOBUM1juowlfXlEaxtrJXpyq3gKSEL
 HFF3nI0/V20WzpQxqdlOK4Gk2ZD/NXgSQ3w8mqFQgVAWO5Y8VdmKVEBKIjX2a5DP55
 /CARhYPNUzdkiqQzvJX3kFmUyor++WXzrN1em3YbRGGCzhjTGhzGw2IRt5SWQ6iqNq
 jSIFlAqxxRFcg==
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
Subject: RE: [PATCH V3] tiny-printf: Handle formatting of %p with an extra
 Kconfig
Thread-Topic: [PATCH V3] tiny-printf: Handle formatting of %p with an extra
 Kconfig
Thread-Index: AQHbubvPPdYtyPGafUWLdogTob1ZxLPHWdSAgAFRVjA=
Date: Thu, 8 May 2025 11:56:08 +0000
Message-ID: <5a3217a732794dfc8e07e53436cbee2a@dh-electronics.com>
References: <20250430103548.4162289-1-cniedermaier@dh-electronics.com>
 <20250507174233.GA491506@bill-the-cat>
In-Reply-To: <20250507174233.GA491506@bill-the-cat>
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
Sent: Wednesday, May 7, 2025 7:43 PM
> On Wed, Apr 30, 2025 at 12:35:48PM +0200, Christoph Niedermaier wrote:
>=20
>> The formatting with %pa / %pap behaves like %x, which results in an
>> incorrect value being output. To improve this, a new fine-tuning
>> Kconfig SPL_USE_TINY_PRINTF_POINTER_SUPPORT for pointer formatting
>> has been added. If it is enabled, the output of %pa / %pap should
>> be correct, and if it is disabled, the pointer formatting is
>> completely unsupported. In addition to indicate unsupported formatting,
>> '?' will be output. This allows enabling pointer formatting only
>> when needed. For SPL_NET and NET_LWIP it is selected by default.
>> Then it also supports the formatting with %pm, %pM and %pI4.
>>
>> In summery this level of %p support for tiny printf is possible now:
>>
>> 1) The standard tiny printf won't have support for pointer formatting.
>>    So it doesn't print misleading values for %pa, instead '?' will be
>>    output:
>>    %p   =3D> ?
>>    %pa  =3D> ?a
>>    %pap =3D> ?ap
>>
>> 2) If SPL_USE_TINY_PRINTF_POINTER_SUPPORT is enabled or DEBUG is defined
>>    tiny printf supports formatting %p and %pa / %pap.
>>
>> 3) If SPL_NET or NET_LWIP is enabled the support of pointers is extended
>>    for %pm, %pM and %pI4.
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
>> V2: - Rebase on current master
>>     - Extend commit message
>>     - Restrict use to SPL
>>     - Rename Kconfig to SPL_USE_TINY_PRINTF_POINTER_SUPPORT
>>     - Replace _DEBUG with defined(DEBUG)
>>     - Output '?' if %pm, %pM and %pI4 isn't available
>>     - Add break on case '%'
>> V3: - Add missing output '?' for the default case
>> ---
>>  Kconfig            |  1 +
>>  common/spl/Kconfig |  1 +
>>  lib/Kconfig        |  8 +++++++
>>  lib/tiny-printf.c  | 52 +++++++++++++++++++++++-----------------------
>>  4 files changed, 36 insertions(+), 26 deletions(-)
>>
>> diff --git a/Kconfig b/Kconfig
>> index 51358633762..b8eec3fc931 100644
>> --- a/Kconfig
>> +++ b/Kconfig
>> @@ -774,6 +774,7 @@ config NET
>>
>>  config NET_LWIP
>>  	bool "Use lwIP for networking stack"
>> +	select SPL_USE_TINY_PRINTF_POINTER_SUPPORT if SPL_USE_TINY_PRINTF
>>  	imply NETDEVICES
>>  	help
>>  	  Include networking support based on the lwIP (lightweight IP)
>=20
> Sorry I missed this bug until now. This (and the subsequent parts of the
> patch referencing lwIP) aren't right. There's no SPL_NET_LWIP support
> (and not planned at this point), so what this does is grow platforms
> like xilinx_zynq_virt which use lwIP in U-Boot and tiny printf in SPL,
> but shouldn't since there's no SPL_NET_LWIP.

I didn't know that, I took it from the tiny printf pointer handling code.
I will remove all lwIP references in version 4.

Thanks and regards
Christoph
