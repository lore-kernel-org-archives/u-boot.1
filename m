Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89A21C83F1D
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 10:49:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B821F82F8F;
	Tue, 15 Jul 2025 12:49:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="zRcpTEte";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C37482F6F; Tue, 15 Jul 2025 12:49:24 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80F4482FAB
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 12:49:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=a257=Z4=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1752576560;
 bh=nkoOh1efG9S450sWAZtolPk3RUB01B0XI6BGg5t7Bwo=;
 b=zRcpTEte+688q+e+fprHTEcTy7DNp5ErrgLG9M6aDMD/HbOJTqNNGurfYpVVuTDL6qQnxM/IS
 +Dlne4qSikyCvTnIA9U5mb2PsYk2fNTT5bp7X3NAXp47oZlaeo7N5yhN0qKguJBmuwvOmGWO0fb
 kVAxR33TIuFnMrfWrYpbsVUK88D1dxMjB9rkVTIeMkaptf+/kvCE1WUO3KDVqM1n9VIUZ37Cl9f
 U/kFGalA3r14fHd+kYrzR18hL1z5zcWeohwLrGEXWc8ymZZNnFJkY1bydBDFhr/end9W7Yrwzzo
 /TGOd3lsUeBqlhSW3O5u2IccOBL6/K+cxzli7LkdHoGQ==
X-Forward-Email-ID: 6876322b02da433925ac9bcd
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.1.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <092a18f7-91fc-49f1-8110-90105262c40f@kwiboo.se>
Date: Tue, 15 Jul 2025 12:49:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: Ensure env in SPI Flash can work correctly
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20250712212710.684525-1-jonas@kwiboo.se>
 <aa1c247f-c22e-4f4c-9abf-dd1bc23b4f90@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <aa1c247f-c22e-4f4c-9abf-dd1bc23b4f90@cherry.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Quentin,

On 7/15/2025 11:11 AM, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 7/12/25 11:27 PM, Jonas Karlman wrote:
>> Ensure that the spi/sfc node for SPI flash is aviliable during pre-reloc
>> phase so that env can successfully be loaded from SPI Flash.
>>
> 
> Shouldn't the pinmux nodes be added as well? Or are you planning on 
> having those part of the individual board's DTS rather than in the SoC DTSI?

The boards that come with SPI flash should already have those added in
the SoC or individual board's DTs, to my knowledge.

However, when I was testing env in SPI flash on odroid-go2 I noticed
that env would not load unless we explicitly include the sfc/spi node in
pre-reloc phase. And the recent added propagation of bootph- props in
binman did not seem to really affect use of multiple FDTs in FIT.

With this patch I try to add this explicit bootph-some-ram prop so that
if anyone enable the ENV_IN_SPI_FLASH option it actually works as
intended on boards that already support booting from SPI flash.

Basically this fixes something I missed in old patches/series ;-)

Regards,
Jonas

> 
> Cheers,
> Quentin

