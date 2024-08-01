Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F8FBC3DA64
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 21:47:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CD8287C7E;
	Thu,  1 Aug 2024 23:47:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="ThGZfmjx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1276885A8; Thu,  1 Aug 2024 23:47:48 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D0D387919
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 23:47:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=d829=PB=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1722548857;
 bh=1tHN6OLkTWk3gua1AMi779rdbcM37fwy1kSMqmewW+w=;
 b=ThGZfmjxdkXpi9tI42fs6mh2hObm6FsX8nHRDirBtME6yNZoDw2JZoS+42/0yuvmjPJUmrqYv
 KgQ2VpduPFCcgaYgWvQ66f6RTRDvK5gGzADse5bxUgdmgGLOuhUX49T+k/1FsmJ6lmfbCBfC5tX
 JW/FkUHf/ZFiWXCtmumxOekHgIZ7B6oNyuOJT1+7xUkS29IkqmuylXjTGK8dumCChxy7DlWxkjM
 4NnNhBQOvPuGRq5J4YnNyOA+BmdgWaZ4qSy5W55ykbH1CVKWuHjrSrK82H+FHY6b06LNBEKUZdy
 jx4B2ZuRtg3t0INv/bV+GUrq11wNORU6DTAALUVi7EkA==
Message-ID: <944a6125-3a61-4e1f-902a-145516b315df@kwiboo.se>
Date: Thu, 1 Aug 2024 23:47:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] dm: adc: Add SPL_ADC Kconfig symbol for use of ADC in
 SPL
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
References: <20240731065048.1199792-1-jonas@kwiboo.se>
 <20240731065048.1199792-5-jonas@kwiboo.se>
 <7208a42b-4309-4216-ab64-16a5a82eced8.a73bd9c8-8cbe-42e2-876b-4c548d837fba.e39c66b9-19b8-456c-a1aa-5fb8d021db0b@emailsignatures365.codetwo.com>
 <a3f9a9ad-424e-4b51-8b02-56b992c33259@cherry.de>
 <ea1bca18-51bd-4ca8-849d-70229c5e24ec@kwiboo.se>
 <e6e50791-3308-4634-afb4-9210f92695d5@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <e6e50791-3308-4634-afb4-9210f92695d5@cherry.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66ac027606984f15ed09f0b1
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

On 2024-08-01 11:26, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 7/31/24 4:10 PM, Jonas Karlman wrote:
>  > Hi Quentin,
>  >
>  > On 2024-07-31 14:42, Quentin Schulz wrote:
>  >> Hi Jonas,
>  >>
>  >> On 7/31/24 8:50 AM, Jonas Karlman wrote:
>  >>   > What model of Radxa ZERO 3W/3E boards can be identified using ADC at
>  >>   > runtime, add a Kconfig symbol to allow use of ADC in SPL.
>  >>   >
>  >>   > This will be used to identify board model in SPL to allow loading
>  >>   > correct FIT configuration and FDT for U-Boot proper at SPL phase.
>  >>   >
>  >>   > Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>  >>   > ---
>  >>   >   drivers/Makefile    | 2 +-
>  >>   >   drivers/adc/Kconfig | 4 ++++
>  >>   >   2 files changed, 5 insertions(+), 1 deletion(-)
>  >>   >
>  >>   > diff --git a/drivers/Makefile b/drivers/Makefile
>  >>   > index 9195dafd37e0..1acd94f3c17e 100644
>  >>   > --- a/drivers/Makefile
>  >>   > +++ b/drivers/Makefile
>  >>   > @@ -1,5 +1,6 @@
>  >>   >   # SPDX-License-Identifier: GPL-2.0+
>  >>   >
>  >>   > +obj-$(CONFIG_$(SPL_TPL_)ADC) += adc/
>  >>   >   obj-$(CONFIG_$(SPL_TPL_)BIOSEMU) += bios_emulator/
>  >>   >   obj-$(CONFIG_$(SPL_TPL_)BLK) += block/
>  >>   >   obj-$(CONFIG_$(SPL_TPL_)BOOTCOUNT_LIMIT) += bootcount/
>  >>   > @@ -81,7 +82,6 @@ endif
>  >>   >
>  >>   >   ifeq ($(CONFIG_SPL_BUILD)$(CONFIG_TPL_BUILD),)
>  >>   >
>  >>   > -obj-y += adc/
>  >>   >   obj-y += ata/
>  >>   >   obj-$(CONFIG_DM_DEMO) += demo/
>  >>   >   obj-y += block/
>  >>   > diff --git a/drivers/adc/Kconfig b/drivers/adc/Kconfig
>  >>   > index c9cdbe6942de..eb705f9e0fb8 100644
>  >>   > --- a/drivers/adc/Kconfig
>  >>   > +++ b/drivers/adc/Kconfig
>  >>   > @@ -11,6 +11,10 @@ config ADC
>  >>   >          - support supply's phandle with auto-enable
>  >>   >          - supply polarity setting in fdt
>  >>   >
>  >>   > +config SPL_ADC
>  >>   > +     bool "Enable ADC drivers using Driver Model in SPL"
>  >>   > +     depends on ADC
>  >>   > +
>  >>
>  >> This is just because you didn't modify the drivers/adc/Makefile to have
>  >> obj-$(CONFIG_$(SPL_TPL_)ADC) += adc-uclass.o
>  >> I assume? It's a bit odd to require a "proper" symbol for an SPL symbol.
>  >>
>  >> Additionally, since you use $(SPL_TPL_) maybe add that TPL symbol too in
>  >> the Kconfig?
>  >
>  > Agree, this could have been done differently, I added the depends on ADC
>  > a few minutes before I send the series to ensure next user of ADC in SPL
>  > does not miss it.
>  >
> 
> I would rather not depend on a hack if we can avoid it. I believe:
> obj-$(CONFIG_$(SPL_TPL_)ADC) += adc-uclass.o
> should be enough of a change here?

I thinks so to, will change to that in a v2.

> 
> I'm actually wondering if we can't simply have
> obj-y += adc-uclass.o
> ? considering that this Makefile is only included if
> $(CONFIG_$(SPL_TPL_)ADC)?

Should be possible, but it is probably better to be explicit in case the
condition in drivers/Makefile ever changes in the future.

Regards,
Jonas

> 
> Cheers,
> Quentin

