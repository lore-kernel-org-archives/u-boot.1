Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64AD9E7719F
	for <u-boot@archiver.kernel.org>; Mon, 13 Jan 2025 12:39:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C25C0805DA;
	Mon, 13 Jan 2025 13:39:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="xUheZ5MO";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="piOztBcW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1213D80602; Mon, 13 Jan 2025 13:39:48 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E389F801CF
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 13:39:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4YWsKF45HKz9sTJ;
 Mon, 13 Jan 2025 13:39:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1736771985;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=90or0q163QFLKXr3SIeoGSdBgSOd6Hsg09Lxi/t1Ywc=;
 b=xUheZ5MOG1E4S213rWl2LcP+1gQOgSFZOJzuV9AweOqdAoM4Xs32yR5scG/AAnoor1JKrt
 yj3nlrg38SknOiRj4WGSGX0pfbBCQ2u0sIuWINfyp02I4boYSMj4ruieozspW7UAr5Zl5h
 oQI1afaNyJmkUWxKe4nnJyZ+sBdJKNxAnCd2w4KECVJiUcCXY0BQCHiW8oeBQ1jZpPa6wN
 kBBO4xlOX+IEWTnMISDg2N2IxpRGmoWaJ9+IwQclSXyqa0HPNHFfCEa8/ao+6PwoV1X3qQ
 rO8sPLNG/EgIZuA8pwjYV1mjszFk8HtltOXEW0XvAwh3qByVvpxk1l8Oj4017g==
Message-ID: <4dddca99-dcc2-411e-af9a-b27115e60efa@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1736771983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=90or0q163QFLKXr3SIeoGSdBgSOd6Hsg09Lxi/t1Ywc=;
 b=piOztBcWHKhUV+eG2L39F7cOKKtYjPSOQ7cD+iVA/NcBF0bmuZiYFeAJcakpr2LhjiGFf1
 MoswLkY9OIRmQONq84FKgUsfSheUafMYZxvQKWv0rebvpQU0g9Jpj43n3jYCpyn15IbGZ2
 51jNR2/8ytilDRGE/9iHd8iWCCMW126aInnJ0tkBhYs1R3YfjpoQ1Es03wxpmW14GHKg+t
 RoDroEE32vv6RpDlXTtxizRcnaTQYQAj26hdVGtC2vprKAXE0M6nmNGxnh+iPJqPY2XEHC
 kHh0SBqtNgVasj47hjMyaO/bgrQp578g8iULDwxXZU4AnuyTUiTWdo7uzkfaxQ==
Date: Mon, 13 Jan 2025 13:39:38 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 2/3] image: Add support for starting TFA BL31 as fitImage
 loadables
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Andre Przywara <andre.przywara@arm.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, Michael Walle <mwalle@kernel.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Paul-Erwan Rio <paulerwan.rio@gmail.com>, Peter Hoyes <Peter.Hoyes@arm.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20250112223755.179959-1-marek.vasut+renesas@mailbox.org>
 <20250112223755.179959-2-marek.vasut+renesas@mailbox.org>
 <TY3PR01MB113468B93D55B10C9D38ABFAE861F2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <TY3PR01MB113468B93D55B10C9D38ABFAE861F2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 7189da365a1dc774dfc
X-MBO-RS-META: d8nfgnd79cabjx8wfjzkd5ug7fqbszfk
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

On 1/13/25 1:15 PM, Biju Das wrote:
> Hi Marex,
> 
> Thanks for the patch
> 
>> -----Original Message-----
>> From: U-Boot <u-boot-bounces@lists.denx.de> On Behalf Of Marek Vasut
>> Sent: 12 January 2025 22:37
>> Subject: [PATCH 2/3] image: Add support for starting TFA BL31 as fitImage loadables
>>
>> Add support for starting TFA from U-Boot running in EL3 as part of fitImage boot, so the user can
>> start U-Boot in the highest privilege level on the platform, bundle TFA, Linux, DT into a single
>> fitImage and boot such a bundle as a whole.
>>
>> There are two main benefits of this approach. First is the ability to run U-Boot in EL3, where it has
>> unrestricted access to the entire system and can act as a useful debug tool, as it was always intended
>> to be used. Second is the ability to easily and safely update of any component in the fitImage, be it
>> TFA, Linux or DT.
> 
> In this case, who will do switching from secure world to normal world, u-boot?
> Do you have any link to the u-boot patch from secure to normal world switching
> with kernel entry point passed to BL31?
> 
> Otherwise, kernel, also will be executing in secure world mode.
See 3/3 , U-Boot runs in EL3 , before starting kernel it jumps into TFA 
BL31 , TFA BL31 does its setup and switches from EL3 to EL2 , TFA BL31 
returns to U-Boot armv8_switch_to_el2 which checks if this code is 
running in EL2 (it is) and does the last few steps before starting 
kernel, and then finally jumps to the kernel .
